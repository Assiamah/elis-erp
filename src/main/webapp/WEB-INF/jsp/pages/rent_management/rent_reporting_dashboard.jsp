<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<style>
    .bullet {
        display: inline-block;
        width: 10px;
        height: 10px;
        border-radius: 50%;
    }
    
    /* Custom styling for ECharts tooltips */
    .echarts-tooltip {
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        border-radius: 8px;
    }
    
    /* Ensure charts are responsive */
    #rent-collection-trend,
    #rent-distribution-chart,
    #performance-analysis-chart {
        width: 100%;
    }

    /* Add to your existing CSS */
.loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
    display: none;
}

.loading-spinner {
    width: 50px;
    height: 50px;
    border: 5px solid #f3f3f3;
    border-top: 5px solid #0d6efd;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Chart loading state */
.echarts-loading {
    opacity: 0.5;
    transition: opacity 0.3s ease;
}

.bullet {
    display: inline-block;
    width: 8px;
    height: 8px;
    border-radius: 50%;
}

.bg-primary { background-color: #0d6efd; }
.bg-success { background-color: #198754; }
.bg-warning { background-color: #ffc107; }
.bg-info { background-color: #0dcaf0; }
.bg-danger { background-color: #dc3545; }
.bg-purple { background-color: #6f42c1; }
.bg-orange { background-color: #fd7e14; }
.bg-teal { background-color: #20c997; }
.bg-indigo { background-color: #6610f2; }
.bg-pink { background-color: #d63384; }
.bg-dark { background-color: #212529; }


/* Estate Details Modal Styles */
#estateLeasesTable th {
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    color: #6c757d;
    white-space: nowrap;
}

#estateLeasesTable td {
    font-size: 13px;
    vertical-align: middle;
}

#estateLeasesTable .dropdown-toggle {
    padding: 2px 8px;
    font-size: 12px;
}

/* Status badges */
.status-badge {
    font-size: 11px;
    padding: 3px 8px;
    border-radius: 4px;
}

.status-paid {
    background-color: rgba(25, 135, 84, 0.1);
    color: #198754;
    border: 1px solid rgba(25, 135, 84, 0.2);
}

.status-outstanding {
    background-color: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.2);
}

/* Hover effects */
#estateLeasesTable tbody tr {
    transition: background-color 0.2s;
}

#estateLeasesTable tbody tr:hover {
    background-color: rgba(13, 110, 253, 0.02);
}

/* Tooltip styling */
.tooltip-primary .tooltip-inner {
    background-color: #0d6efd;
    font-size: 12px;
}

.tooltip-primary .tooltip-arrow::before {
    border-top-color: #0d6efd;
}

/* Modal loading overlay */
.modal-loading {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1050;
}

</style>

<div class="main-content app-content">
    <div class="container-fluid page-container">
        <!-- Start::page-header -->
<div class="page-header-breadcrumb mb-4">
  <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">

    <!-- LEFT: Title -->
    <div>
      <h1 class="page-title fw-semibold fs-22 mb-1">
        Rent Analytics & Reporting
      </h1>
      <p class="text-muted mb-0">
        Comprehensive overview of rent collection, outstanding balances, and lease performance
      </p>
    </div>

    <!-- RIGHT: Controls -->
    <div class="d-flex align-items-center gap-2 flex-wrap">

      <!-- Region Card -->
      <div
        class="card border shadow-sm d-flex align-items-center"
        style="height: 44px; min-width: 220px; max-width: 260px;"
      >
        <div class="card-body py-0 px-3 w-100 d-flex align-items-center">
          <div class="d-flex align-items-center gap-3 w-100">
            <i class="ri-map-pin-2-fill text-primary fs-5"></i>

            <div class="flex-grow-1">
              <label class="form-label small text-muted mb-0">
                Region
              </label>
              <select
                id="sel_change_region_compliance"
                class="form-select form-select-sm border-0 p-0 bg-transparent fw-semibold text-dark"
              >
                <option value="${regional_code}">
                  ${regional_name}
                </option>

                <c:forEach items="${officeregionlist}" var="officeregion">
                  <option value="${officeregion.ord_region_code}">
                    ${officeregion.ord_region_name}
                  </option>
                </c:forEach>

              </select>
            </div>
          </div>
        </div>
      </div>


      <!-- Date Range Dropdown -->
      <div class="dropdown">
        <button
          class="btn btn-primary dropdown-toggle d-flex align-items-center justify-content-center"
          type="button"
          data-bs-toggle="dropdown"
          style="height: 44px;"
        >
          <i class="ri-calendar-line me-2"></i>
          <span id="selectedRangeLabel">This Month</span>
        </button>

        <ul class="dropdown-menu dropdown-menu-end shadow-sm">
          <li><a class="dropdown-item" href="javascript:void(0);" onclick="setTimeRange('today')">Today</a></li>
          <li><a class="dropdown-item" href="javascript:void(0);" onclick="setTimeRange('week')">This Week</a></li>
          <li><a class="dropdown-item" href="javascript:void(0);" onclick="setTimeRange('month')">This Month</a></li>
          <li><a class="dropdown-item" href="javascript:void(0);" onclick="setTimeRange('quarter')">This Quarter</a></li>
          <li><a class="dropdown-item" href="javascript:void(0);" onclick="setTimeRange('year')">This Year</a></li>
          <li><a class="dropdown-item" href="javascript:void(0);" onclick="showCustomRange()">Custom Range</a></li>
        </ul>
      </div>



      <input type="text" id="start_date" class="form-control d-none">
      <input type="text" id="end_date" class="form-control d-none">
      <input type="text" id="estate_id" value="Estate" class="form-control d-none">


       <!-- Export Button -->
      <button
        class="btn btn-outline-primary d-flex align-items-center justify-content-center"
        style="height: 44px;"
        id="exportReport"
      >
        <i class="ri-download-line me-2"></i>
        Export Report
      </button>


    </div>
  </div>
</div>
        <!-- End::page-header -->

        <!-- Start:: Key Metrics Row -->
        <div class="row mb-4">
            <div class="col-xl-3 col-lg-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-muted fs-12 d-block mb-1">Total Rent Collected</span>
                                <h3 class="fw-bold mb-2"><small class="fw-light fs-16">GHS</small> 
                                     <span id="total_rent_collected">0.00</span>
                                </h3>
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-success-transparent rounded-pill fs-11 fw-medium d-flex align-items-center">
                                        <!-- <i class="ri-arrow-up-line me-1"></i>12.5% -->
                                    </span>
                                    <!-- <span class="text-muted ms-2 fs-12">vs last month</span> -->
                                </div>
                            </div>
                            <div class="avatar avatar-md bg-primary-transparent text-primary rounded-3 p-3">
                                <i class="ri-money-dollar-circle-line fs-24"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <div class="progress progress-sm" style="height: 5px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 78%"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                                <span class="text-muted fs-11">Target: GHS 1,000,000</span>
                                <span class="text-primary fs-11 fw-medium">78%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-3 col-lg-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-muted fs-12 d-block mb-1">Total Rent Outstanding</span>
                                <h3 class="fw-bold mb-2 text-danger"><small class="fw-light fs-16">GHS</small> 
                                     <span id="total_rent_outstanding">0.00</span>
                                </h3>
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-danger-transparent rounded-pill fs-11 fw-medium d-flex align-items-center">
                                        <!-- <i class="ri-arrow-up-line me-1"></i>8.2% -->
                                    </span>
                                    <!-- <span class="text-muted ms-2 fs-12">vs last month</span> -->
                                </div>
                            </div>
                            <div class="avatar avatar-md bg-danger-transparent text-danger rounded-3 p-3">
                                <i class="ri-alert-line fs-24"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <div class="progress progress-sm" style="height: 5px;">
                                <div class="progress-bar bg-danger" role="progressbar" style="width: 42%"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                                <span class="text-muted fs-11">Overdue: GHS 120,450</span>
                                <span class="text-danger fs-11 fw-medium">42%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-3 col-lg-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-muted fs-12 d-block mb-1">Total Leasees</span>
                                <h3 class="fw-bold mb-2">
                                      <span id="total_leasee">0</span>
                                </h3>
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-success-transparent rounded-pill fs-11 fw-medium d-flex align-items-center">
                                        <!-- <i class="ri-arrow-up-line me-1"></i>5.3% -->
                                    </span>
                                    <!-- <span class="text-muted ms-2 fs-12">new leases this month</span> -->
                                </div>
                            </div>
                            <div class="avatar avatar-md bg-success-transparent text-success rounded-3 p-3">
                                <i class="ri-contract-line fs-24"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <span class="d-block fs-12 text-muted">Paid</span>
                                    <span class="d-block fs-14 fw-medium">12</span>
                                </div>
                                <div>
                                    <span class="d-block fs-12 text-muted">Outstanding</span>
                                    <span class="d-block fs-14 fw-medium">144</span>
                                </div>
                                <div>
                                    <span class="d-block fs-12 text-muted">Expired Leases</span>
                                    <span class="d-block fs-14 fw-medium">8</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-3 col-lg-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-muted fs-12 d-block mb-1">Collection Rate</span>
                                <h3 class="fw-bold mb-2">92.5%</h3>
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-warning-transparent rounded-pill fs-11 fw-medium d-flex align-items-center">
                                        <!-- <i class="ri-arrow-down-line me-1"></i>2.1% -->
                                    </span>
                                    <!-- <span class="text-muted ms-2 fs-12">vs last month</span> -->
                                </div>
                            </div>
                            <div class="avatar avatar-md bg-warning-transparent text-warning rounded-3 p-3">
                                <i class="ri-percent-line fs-24"></i>
                            </div>
                        </div>
                        <div class="mt-3">
                            <div class="d-flex justify-content-between">
                                <div class="text-center">
                                    <div class="fs-16 fw-medium">78%</div>
                                    <div class="fs-11 text-muted">On Time</div>
                                </div>
                                <div class="text-center">
                                    <div class="fs-16 fw-medium">14.5%</div>
                                    <div class="fs-11 text-muted">Late</div>
                                </div>
                                <div class="text-center">
                                    <div class="fs-16 fw-medium">7.5%</div>
                                    <div class="fs-11 text-muted">Overdue</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End:: Key Metrics Row -->

        <!-- Start:: Charts Row -->
        <div class="row mb-4">
            <div class="col-xl-8">
                <div class="card custom-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="card-title mb-0">
                            Rent Collection Trend
                            <!-- <span class="text-muted fs-12 ms-2 fw-normal">(Last 12 months)</span> -->
                        </div>
                        <!-- <div class="dropdown">
                            <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" id="trendChartPeriod">
                                Monthly
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="javascript:void(0);" onclick="changeTrendChartPeriod('daily')">Daily</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" onclick="changeTrendChartPeriod('weekly')">Weekly</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" onclick="changeTrendChartPeriod('monthly')">Monthly</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" onclick="changeTrendChartPeriod('quarterly')">Quarterly</a></li>
                            </ul>
                        </div> -->
                    </div>
                    <div class="card-body">
                        <div id="rent-collection-trend" style="height: 320px;"></div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-4">
                <div class="card custom-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="card-title mb-0">
                            Outstanding Rent Distribution by Estate
                        </div>
                        <button class="btn btn-light btn-sm" onclick="refreshDistributionChart()">
                            <i class="ri-refresh-line"></i>
                        </button>
                    </div>
                    <div class="card-body">
                        <div id="rent-distribution-chart" style="height: 320px;"></div>
                        <div class="mt-3" id="estate-list-container">
    <!-- Existing static content will be replaced -->
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="d-flex align-items-center">
                                <span class="bullet bg-primary me-2"></span>
                                <span class="fs-12">East Legon Estates</span>
                            </div>
                            <span class="fs-12 fw-medium">GHS 245,000</span>
                        </div>
                        <!-- ... other static items ... -->
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End:: Charts Row -->

        <!-- Start:: Analysis Row -->
        <div class="row mb-4">
            <div class="col-xl-6">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="card-title mb-0">
                            Top Estates by Outstanding Rent
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                      <table class="table table-hover align-middle mb-0" id="estates-table">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">Estate</th>
                                    <th class="text-end">Total Outstanding</th>
                                    <th class="text-end">Maximum Outstanding</th>
                                    <th class="text-end pe-4">Actions</th>

                                </tr>
                            </thead>
                            <tbody>
                                <!-- Existing rows will be removed and replaced dynamically -->
                                <!-- ... existing static rows ... -->
                            </tbody>
                        </table>
                    </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-6">
                <div class="card custom-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="card-title mb-0">
                            Recent Rent Payments
                            <span class="text-muted fs-12 ms-2 fw-normal">(Last 30 days)</span>
                        </div>
                        <a href="javascript:void(0);" class="text-primary fs-12">View All</a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="recent-payments-table">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Lessee</th>
                                        <th>Property</th>
                                        <th>Date</th>
                                        <th class="text-end">Amount</th>
                                        <th class="text-end pe-4">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Existing rows will be removed and replaced dynamically -->
                                    <!-- ... existing static rows ... -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End:: Analysis Row -->

        <!-- Start:: Detailed Analysis Card -->
<div class="card border-0 shadow-sm mb-4">
    <div class="card-header bg-transparent border-bottom">
        <div class="d-flex justify-content-between align-items-center">
            <h6 class="card-title mb-0">
                <i class="ri-filter-3-line me-2"></i>Advanced Filters & Analytics
            </h6>
            <button class="btn btn-sm btn-link text-decoration-none" type="button" data-bs-toggle="collapse" data-bs-target="#filterCollapse">
                <i class="ri-settings-3-line"></i>
            </button>
        </div>
    </div>
    
    <div class="collapse show" id="filterCollapse">
        <div class="card-body">
            <div class="row g-3">
                <!-- Estate Filter -->
                <div class="col-xl-3 col-lg-4 col-md-6">
                    <label class="form-label fw-semibold">
                        <i class="ri-building-2-line me-1"></i>Estate / Property
                    </label>
                    <div class="dropdown">
                        <button class="form-select text-start dropdown-toggle d-flex justify-content-between align-items-center" 
                                type="button" id="estateFilterDropdown" data-bs-toggle="dropdown" 
                                aria-expanded="false" data-bs-auto-close="outside">
                            <span id="selectedEstateText">All Estates</span>
                        </button>
                        <div class="dropdown-menu p-3" style="min-width: 300px;">
                            <div class="mb-3">
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-light">
                                        <i class="ri-search-line"></i>
                                    </span>
                                    <input type="text" class="form-control" id="estateSearchInput" 
                                           placeholder="Search estates..." onkeyup="filterEstateOptions()">
                                </div>
                            </div>
                            <div class="estate-options-container" style="max-height: 200px; overflow-y: auto;">
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="estateFilter" 
                                           id="estateAll" value="all" checked onchange="updateEstateFilter()">
                                    <label class="form-check-label w-100 d-flex justify-content-between" for="estateAll">
                                        <span>All Estates</span>
                                        <span class="badge bg-light text-dark" id="estateAllCount">0</span>
                                    </label>
                                </div>
                                <!-- Estate options will be populated dynamically -->
                                <div id="estateOptionsList"></div>
                            </div>
                            <div class="mt-3 pt-3 border-top">
                                <button class="btn btn-sm btn-outline-primary w-100" onclick="clearEstateFilter()">
                                    <i class="ri-close-circle-line me-1"></i>Clear Selection
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Status Filter -->
                <div class="col-xl-2 col-lg-3 col-md-6">
                    <label class="form-label fw-semibold">
                        <i class="ri-checkbox-circle-line me-1"></i>Payment Status
                    </label>
                    <select class="form-select" id="paymentStatusFilter" onchange="applyAnalysisFilter()">
                        <option value="all">All Status</option>
                        <option value="paid">Paid</option>
                        <option value="partial">Partially Paid</option>
                        <option value="overdue">Overdue</option>
                        <option value="pending">Pending</option>
                        <option value="disputed">Disputed</option>
                    </select>
                </div>

                <!-- Lease Type Filter -->
                <div class="col-xl-2 col-lg-3 col-md-6">
                    <label class="form-label fw-semibold">
                        <i class="ri-contract-line me-1"></i>Lease Type
                    </label>
                    <select class="form-select" id="leaseTypeFilter" onchange="applyAnalysisFilter()">
                        <option value="all">All Types</option>
                        <option value="residential">Residential</option>
                        <option value="commercial">Commercial</option>
                        <option value="industrial">Industrial</option>
                        <option value="agricultural">Agricultural</option>
                        <option value="mixed">Mixed Use</option>
                    </select>
                </div>

                <!-- Date Range Filter -->
                <div class="col-xl-3 col-lg-6 col-md-6">
                    <label class="form-label fw-semibold">
                        <i class="ri-calendar-line me-1"></i>Payment Date Range
                    </label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="analysis_start_date" 
                               placeholder="Start Date" value="2025-01-01">
                        <span class="input-group-text bg-light">
                            <i class="ri-arrow-right-line"></i>
                        </span>
                        <input type="text" class="form-control" id="analysis_end_date" 
                               placeholder="End Date" value="2025-02-28">
                        <button class="btn btn-outline-secondary" type="button" onclick="showAdvancedDatePicker()">
                            <i class="ri-calendar-2-line"></i>
                        </button>
                    </div>
                </div>

                <!-- Amount Range Filter -->
                <div class="col-xl-2 col-lg-3 col-md-6">
                    <label class="form-label fw-semibold">
                        <i class="ri-money-dollar-circle-line me-1"></i>Amount Range
                    </label>
                    <select class="form-select" id="amountRangeFilter" onchange="applyAnalysisFilter()">
                        <option value="all">All Amounts</option>
                        <option value="0-1000">GHS 0 - 1,000</option>
                        <option value="1000-5000">GHS 1,000 - 5,000</option>
                        <option value="5000-10000">GHS 5,000 - 10,000</option>
                        <option value="10000-50000">GHS 10,000 - 50,000</option>
                        <option value="50000+">Above GHS 50,000</option>
                    </select>
                </div>

                <!-- Action Buttons -->
                <div class="col-xl-12">
                    <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                        <div class="d-flex gap-2">
                            <div class="dropdown">
                                <button class="btn btn-outline-primary btn-sm dropdown-toggle" type="button" 
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="ri-download-line me-1"></i>Export
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#" onclick="exportFilteredData('csv')">
                                        <i class="ri-file-excel-line me-2"></i>Export as CSV
                                    </a></li>
                                    <li><a class="dropdown-item" href="#" onclick="exportFilteredData('excel')">
                                        <i class="ri-file-excel-2-line me-2"></i>Export as Excel
                                    </a></li>
                                    <li><a class="dropdown-item" href="#" onclick="exportFilteredData('pdf')">
                                        <i class="ri-file-pdf-line me-2"></i>Export as PDF
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="#" onclick="saveFilterPreset()">
                                        <i class="ri-save-line me-2"></i>Save Filter Preset
                                    </a></li>
                                </ul>
                            </div>
                            
                            <button class="btn btn-outline-secondary btn-sm" onclick="clearAllFilters()">
                                <i class="ri-filter-off-line me-1"></i>Clear All Filters
                            </button>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <div class="input-group input-group-sm" style="width: 250px;">
                                <span class="input-group-text bg-light">
                                    <i class="ri-search-line"></i>
                                </span>
                                <input type="text" class="form-control" id="globalSearchInput" 
                                       placeholder="Search across all fields..." 
                                       onkeyup="debouncedGlobalSearch()">
                                <button class="btn btn-primary" type="button" onclick="applyAdvancedSearch()">
                                    <i class="ri-search-line"></i>
                                </button>
                            </div>
                            
                            <button class="btn btn-primary" onclick="applyAnalysisFilter()">
                                <i class="ri-filter-line me-1"></i>Apply Filters
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Stats Bar -->
            <div class="row mt-4 g-2" id="filterStatsBar">
                <div class="col-auto">
                    <span class="badge bg-light text-dark d-flex align-items-center">
                        <i class="ri-building-2-line me-1"></i>
                        <span id="filteredEstateCount">All Estates</span>
                    </span>
                </div>
                <div class="col-auto">
                    <span class="badge bg-light text-dark d-flex align-items-center">
                        <i class="ri-calendar-line me-1"></i>
                        <span id="filteredDateRange">Jan 1 - Feb 28, 2025</span>
                    </span>
                </div>
                <div class="col-auto">
                    <span class="badge bg-light text-dark d-flex align-items-center">
                        <i class="ri-money-dollar-circle-line me-1"></i>
                        <span id="filteredAmountRange">All Amounts</span>
                    </span>
                </div>
                <div class="col-auto">
                    <span class="badge bg-primary-transparent text-primary d-flex align-items-center">
                        <i class="ri-file-list-line me-1"></i>
                        <span id="totalFilteredRecords">0 records</span>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="table-responsive">
                                    <table class="table table-hover align-middle" id="tbl_rent_records">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Action</th>
                                                <th>Account Number</th>
                                                <th>Plot Number</th>
                                                <th>Name of Lessee</th>
                                                <th>File Number</th>
                                                <th>Commencement Date</th>
                                                <th>Term</th>
                                                <th>Plot Size</th>
                                                <th>Last Review Date</th>
                                                <th>Last Payment Period</th>
                                                <th>Rent Outstanding</th>
                                                <th>Unexpired Term</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Populated by DataTables -->
                                        </tbody>
                                    </table>
                                </div>
</div>
        <!-- End:: Detailed Analysis Card -->

        
    </div>
</div>



<!-- Estate Details Modal -->
<div class="modal fade" id="estateDetailsModal" tabindex="-1" aria-labelledby="estateDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="estateDetailsModalLabel">
                    <i class="ri-building-line me-2"></i>
                    <span id="modalEstateName">Estate Details</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Estate Summary Cards -->
                <div class="row mb-4" id="estateSummaryCards">
                    <!-- Summary cards will be populated dynamically -->
                </div>
                
                <!-- Estate Leases Table -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-transparent border-bottom">
                        <h6 class="card-title mb-0">
                            <i class="ri-file-list-line me-2"></i>Lease Details
                        </h6>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="estateLeasesTable">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Action</th>
                                        <th>Account Number</th>
                                        <th>Plot Details</th>
                                        <th>Owner/Lessee</th>
                                        <th>File Number</th>
                                        <th>Commencement Date</th>
                                        <th>Term</th>
                                        <th>Plot Size</th>
                                        <th>Last Review Date</th>
                                        <th>Last Payment Period</th>
                                        <th class="text-end">Amount Status</th>
                                        <th class="text-end pe-4">Reminder</th>
                                    </tr>
                                </thead>
                                <tbody id="estateLeasesTableBody">
                                    <!-- Table rows will be populated dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="exportEstateReportBtn">
                    <i class="ri-download-line me-1"></i>Export Report
                </button>
            </div>
        </div>
    </div>
</div>








<jsp:include page="../../components/_rent_management_modals.jsp"></jsp:include>
<!-- Include ECharts -->
<!-- <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script> -->
<!-- <script src="${pageContext.request.contextPath}/assets/libs/flatpickr/dist/flatpickr.min.js"></script> -->



