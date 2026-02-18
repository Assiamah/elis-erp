<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:useBean id="now" class="java.util.Date" />



<style>
    /* ====== STAT CARD STYLES (from focal_compliance) ====== */
    .stat-card {
        transition: all 0.3s ease;
        border: none;
        position: relative;
        overflow: hidden;
        cursor: pointer;
    }
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
    }
    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: rgba(255, 255, 255, 0.4);
    }
    .avatar {
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
    }
    /* officer table row hover */
    .officer-row {
        transition: background 0.2s;
        cursor: pointer;
    }
    .officer-row:hover {
        background-color: rgba(102, 126, 234, 0.05);
    }
    /* progress bar customization (if needed) */
    .progress-bar.bg-primary { background-color: #667eea !important; }
    .progress-bar.bg-success { background-color: #28a745 !important; }
    .progress-bar.bg-warning { background-color: #ffc107 !important; }
    .progress-bar.bg-danger { background-color: #dc3545 !important; }

    /* modal header gradient (optional reuse) */
    .modal-header.bg-gradient-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
</style>

<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">


	<input type="hidden" id="sel_change_region_compliance" value="${regional_code}" />
    <!-- <input type="hidden" id="director_regional_code" value="${regional_code}" /> -->

    <!-- <input type="hidden" id="director_division" value="${division}" /> -->
	<input type="hidden" id="startdate">
    <input type="hidden" id="start_date">
    <input type="hidden" id="enddate">
    <input type="hidden" id="end_date">
    



        <!-- Page Header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1"><i class="ri-dashboard-line me-2 text-primary"></i>CSAU Front Office Dashboard</h1>
                        <p class="text-muted mb-0">Real‑time monitoring of teller activities, collections, and signouts</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">CSAU Dashboard</li>
                </ol>
            </div>
        </div>

        <!-- Hidden fields (preserved) -->
        <input type="hidden" id="csau_manager_regional_code" value="${regional_code}" />
        <input type="hidden" id="startdate">
        <input type="hidden" id="start_date">
        <input type="hidden" id="enddate">
        <input type="hidden" id="end_date">

        <!-- ===== DATE RANGE FILTER ===== (same as focal_compliance) -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                    <div>
                        <h4 class="mb-2 text-gray-800">Performance Overview</h4>
                        <p class="text-muted mb-0">Select a date range to update all metrics below</p>
                    </div>
                    <div class="d-flex align-items-center flex-wrap gap-3">
                        <div class="d-flex align-items-center flex-wrap gap-3 flex-grow-1 flex-md-grow-0">
                            <!-- Date From -->
                            <div class="card border shadow-sm flex-grow-1" style="min-width: 180px; max-width: 220px;">
                                <div class="card-body py-2 px-3">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="ri-calendar-event-line text-primary"></i>
                                        <div class="flex-grow-1">
                                            <label class="form-label small text-muted mb-1">Date From</label>
                                            <input type="text" id="datefrom" class="form-control form-control-sm border-0 p-0 fw-semibold w-100" placeholder="Select start date" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Date Separator -->
                            <div class="text-muted d-none d-md-block">
                                <i class="ri-arrow-right-line"></i>
                            </div>
                            <!-- Date To -->
                            <div class="card border shadow-sm flex-grow-1" style="min-width: 180px; max-width: 220px;">
                                <div class="card-body py-2 px-3">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="ri-calendar-event-fill text-primary"></i>
                                        <div class="flex-grow-1">
                                            <label class="form-label small text-muted mb-1">Date To</label>
                                            <input type="text" id="dateto" class="form-control form-control-sm border-0 p-0 fw-semibold w-100" placeholder="Select end date" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== KEY METRICS ROW (one card per metric, date‑range aware) ===== -->
        <div class="row">
            <!-- Applications Received -->
            <div class="col-xl col-md-6 mb-4" id="card_apps_received">
                <div class="card stat-card custom-card dashboard-main-card primary" data-bs-toggle="modal" data-bs-target="#appsReceivedModal">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-primary svg-white">
                                    <i class="ri-file-copy-line fs-4 text-white"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">Applications Received</span>
                                <h5 class="fw-semibold mb-1" id="receivedCount">0</h5>
                                <div class="text-muted fs-12">
                                    <!-- <span class="text-success" id="receivedRangeLabel">selected period</span> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bills Created -->
            <div class="col-xl col-md-6 mb-4" id="card_bills_created">
                <div class="card stat-card custom-card dashboard-main-card info" data-bs-toggle="modal" data-bs-target="#billsCreatedModal">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-info svg-white">
                                    <i class="ri-file-paper-line fs-4 text-white"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">Bills Created</span>
                                <h5 class="fw-semibold mb-1" id="billsCreatedCount">0</h5>
                                <div class="text-muted fs-12">
                                    <!-- <span class="text-success" id="billsCreatedRangeLabel">selected period</span> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bills Paid -->
            <div class="col-xl col-md-6 mb-4" id="card_bills_paid">
                <div class="card stat-card custom-card dashboard-main-card success" data-bs-toggle="modal" data-bs-target="#billsPaidModal">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-success svg-white">
                                    <i class="ri-check-double-line fs-4 text-white"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">Bills Paid</span>
                                <h5 class="fw-semibold mb-1" id="billsPaidCount">0</h5>
                                <div class="text-muted fs-12">
                                    <!-- <span class="text-success" id="billsPaidRangeLabel">selected period</span> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Applications Signed Out -->
            <div class="col-xl col-md-6 mb-4" id="card_apps_signedout">
                <div class="card stat-card custom-card dashboard-main-card warning" data-bs-toggle="modal" data-bs-target="#appsSignedOutModal">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-warning svg-white">
                                    <i class="ri-logout-circle-line fs-4 text-white"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">Applications Signed Out</span>
                                <h5 class="fw-semibold mb-1" id="signedOutCount">0</h5>
                                <div class="text-muted fs-12">
                                    <!-- <span class="text-success" id="signedOutRangeLabel">selected period</span> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

			<!-- Pending Acknowledgement -->
			<div class="col-xl col-md-6 mb-4" id="card_pending_ack">
				<div class="card stat-card custom-card dashboard-main-card secondary" 
					data-bs-toggle="modal" 
					data-bs-target="#pendingAckModal">
					<div class="card-body">
						<div class="d-flex align-items-start gap-3">
							<div>
								<span class="avatar avatar-md bg-secondary svg-white">
									<i class="ri-time-line fs-4 text-white"></i>
								</span>
							</div>
							<div>
								<span class="d-block text-muted">Pending Acknowledment</span>
								<h5 class="fw-semibold mb-1" id="pendingAckCount">0</h5>
								<div class="text-muted fs-12">
									<!-- optional range label -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

        </div>

        <!-- ===== OFFICER PERFORMANCE SECTION ===== -->
        <div class="d-flex align-items-center mt-4 mb-3">
            <i class="ri-user-star-line fs-4 me-2 text-primary"></i>
            <h5 class="fw-semibold mb-0">Officer Performance</h5>
        </div>
        <div class="row">
            <!-- Top Officers by Applications Received -->
            <div class="col-lg-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-transparent border-0 d-flex justify-content-between align-items-center">
                        <h6 class="fw-semibold mb-0"><i class="ri-bar-chart-grouped-line me-2 text-primary"></i>Top Officers by Applications Received</h6>
                        <!-- <a href="javascript:void(0);" class="small text-primary" data-bs-toggle="modal" data-bs-target="#appsReceivedModal">View All</a> -->
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm table-hover align-middle" id="topOfficersReceivedTable">
                                <thead>
                                    <tr>
                                        <th>Officer</th>
                                        <th class="text-end">Count</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- dynamically populated -->
                                    <tr><td colspan="2" class="text-muted text-center">Select date range</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top Officers by Bills Created -->
            <div class="col-lg-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-transparent border-0 d-flex justify-content-between align-items-center">
                        <h6 class="fw-semibold mb-0"><i class="ri-bar-chart-grouped-line me-2 text-info"></i>Top Officers by Bills Created</h6>
                        <!-- <a href="javascript:void(0);" class="small text-primary" data-bs-toggle="modal" data-bs-target="#billsCreatedModal">View All</a> -->
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm table-hover align-middle" id="topOfficersBillsTable">
                                <thead>
                                    <tr>
                                        <th>Officer</th>
                                        <th class="text-end">Count</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- dynamically populated -->
                                    <tr><td colspan="2" class="text-muted text-center">Select date range</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== TRENDS & CHARTS ===== -->
        <div class="d-flex align-items-center mt-4 mb-3">
            <i class="ri-bar-chart-2-line fs-4 me-2 text-danger"></i>
            <h5 class="fw-semibold mb-0">Monthly Trends (Recieved VS Signed Out)</h5>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <canvas id="dailyTrendsChart" style="height: 300px; width: 100%;"></canvas>
                    </div>
                </div>
            </div>
        </div>
        

    </div> <!-- container-fluid -->
</div> <!-- main-content -->






<div class="modal fade" id="applicationsModal" tabindex="-1" aria-labelledby="applicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="applicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="applicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                      <th><input type="checkbox" id="select-all"></th>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Date Received by Officer</th>
                                        <th>Pending Days</th>
                                        <th>Days With Officer</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

 <jsp:include page="../../components/_csaumonitoring_modal.jsp"></jsp:include>
