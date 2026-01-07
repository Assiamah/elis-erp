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
    .dashboard-header {
        padding: 1rem 0;
        border-bottom: 1px solid #f0f2f5;
    }

    .btn-add-request {
        padding: 0.5rem 1.25rem;
        font-weight: 500;
        border-radius: 6px;
        box-shadow: 0 2px 8px rgba(0, 123, 255, 0.2);
        transition: all 0.3s ease;
    }

    .btn-add-request:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 1.5rem;
    }

    .stat-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.03);
        transition: all 0.3s ease;
        border: 1px solid #f0f2f5;
        cursor: pointer;
        overflow: hidden;
        position: relative;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
    }

    /* Active card styles */
    .stat-card.active {
        color: white;
    }

    .stat-card-info.active {
        background-color: #0dcaf0;
        border-color: #0dcaf0;
    }

    .stat-card-success.active {
        background-color: #198754;
        border-color: #198754;
    }

    .stat-card-warning.active {
        background-color: #ffc107;
        border-color: #ffc107;
    }

    .stat-card-danger.active {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .stat-card.active .stat-title,
    .stat-card.active .stat-value,
    .stat-card.active .stat-trend {
        color: white !important;
    }

    .stat-card-link {
        text-decoration: none !important;
        display: block;
        color: inherit;
    }

    /* Updated CSS for stat-icon */
    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        float: left;
        margin-right: 1rem;
        transition: all 0.3s ease;
    }

    /* Active state - white background */
    .stat-card.active .stat-icon {
        background-color: white !important;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .stat-card:not(.active) .stat-icon {
        background-color: rgba(0, 0, 0, 0.05);
    }

    .stat-card-info:not(.active) .stat-icon {
        background-color: rgba(13, 202, 240, 0.1);
    }

    .stat-card-success:not(.active) .stat-icon {
        background-color: rgba(25, 135, 84, 0.1);
    }

    .stat-card-warning:not(.active) .stat-icon {
        background-color: rgba(255, 193, 7, 0.1);
    }

    .stat-card-danger:not(.active) .stat-icon {
        background-color: rgba(220, 53, 69, 0.1);
    }

    .stat-content {
        overflow: hidden;
    }

    .stat-title {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #6c757d;
        margin-bottom: 0.25rem;
        font-weight: 600;
    }

    .stat-value {
        font-size: 1.75rem;
        font-weight: 600;
        margin-bottom: 0.25rem;
        color: #3c4d62;
    }

    .stat-trend {
        font-size: 0.75rem;
        font-weight: 500;
        color: #6c757d;
    }

    .main-card {
        border: none;
        background: white;
        overflow: hidden;
    }

    .modern-table {
        width: 100%;
        margin-bottom: 0;
    }

    .modern-table thead th {
        padding: 1rem 1.5rem;
        background-color: #f9fafc;
        color: #6c757d;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.5px;
        border-bottom: 1px solid #f0f2f5;
        white-space: nowrap;
    }

    .modern-table tbody td {
        padding: 1rem 1.5rem;
        vertical-align: middle;
        border-bottom: 1px solid #f0f2f5;
    }

    .no-data {
        background: #f9fafc;
    }

    /* Custom Modal Styling */
    #addRequestModal .modal-content {
        border-radius: 0.5rem;
        overflow: hidden;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 576px) {
        .stats-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

      <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
					<div>
						<h1 class="page-title fw-medium fs-18 mb-1"><i class="ri-chat-quote-line me-2 text-primary"></i>Compliance Query and Response</h1>
                    	<p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Track, manage, and respond to compliance queries</p>
					</div>
					

					<!-- Region Selector -->
					

				
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item" aria-current="page">Compliance</li>
					<li class="breadcrumb-item active" aria-current="page">Query and Response</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

		<div class="row">
            <div class="col-xl-2">
                <div class="row">
                    <div class="col-xl-12 col-md-6">
                        <a href="#" class="stat-card-link btnLoadData btnLoadDataIncoming" id="lvd_card">
                            <div class="card custom-card dashboard-main-card primary" id="card-lvd">
								<div class="card-body" id="body-bg-1">
									<div class="d-flex align-items-start gap-3">
										<div class="lh-1">
											<span class="avatar avatar-md bg-primary-transparent svg-primary">
												<i class="ri-question-line fa-2x"></i>
											</span>
										</div>
										<div>
											<span class="d-block text-muted mb-1">LVD (Queried Apps)</span>
											<h5 class="fw-semibold mb-0" id="lvd_total">0</h5>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                    <div class="col-xl-12 col-md-6">
                        <a href="#" class="stat-card-link btnLoadData btnLoadDataIncoming" id="lrd_card">
                            <div class="card custom-card dashboard-main-card danger" id="card-lrd">
								<div class="card-body" id="body-bg-2">
									<div class="d-flex align-items-start gap-3">
										<div class="lh-1">
											<span class="avatar avatar-md bg-danger-transparent svg-danger">
												<i class="ri-question-line fa-2x"></i>
											</span>
										</div>
										<div>
											<span class="d-block text-muted mb-1">LRD (Queried Apps)</span>
											<h5 class="fw-semibold mb-0" id="lrd_total">0</h5>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                    <div class="col-xl-12 col-md-6">
                        <a href="#" class="stat-card-link btnLoadData btnLoadDataIncoming" id="smd_card">
                            <div class="card custom-card dashboard-main-card info" id="card-smd">
								<div class="card-body" id="body-bg-3">
									<div class="d-flex align-items-start gap-3">
										<div class="lh-1">
											<span class="avatar avatar-md bg-info-transparent svg-info">
												<i class="ri-question-line fa-2x"></i>
											</span>
										</div>
										<div>
											<span class="d-block text-muted mb-1">SMD (Queried Apps)</span>
											<h5 class="fw-semibold mb-0" id="smd_total">0</h5>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                    <div class="col-xl-12 col-md-6">
                        <a href="#" class="stat-card-link btnLoadData btnLoadDataIncoming" id="pvlmd_card">
                            <div class="card custom-card dashboard-main-card warning" id="card-pvlmd">
								<div class="card-body" id="body-bg-4">
									<div class="d-flex align-items-start gap-3">
										<div class="lh-1">
											<span class="avatar avatar-md bg-warning-transparent svg-warning">
												<i class="ri-question-line fa-2x"></i>
											</span>
										</div>
										<div>
											<span class="d-block text-muted mb-1">PVLMD (Queried Apps)</span>
											<h5 class="fw-semibold mb-0" id="pvlmd_total">0</h5>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-xl-10">
                <!-- <button class="btn btn-primary btn-add-request" data-bs-toggle="modal" data-bs-target="#addRequestModal">
                    <i class="ri-add-circle-line me-2"></i>New Request
                </button> -->
				<div class="region-selector-card" style="width: 500px;">
					<div class="card border shadow-sm">
						<div class="card-body py-2 px-3">
							<div class="d-flex align-items-center gap-2">
								<div class="flex-shrink-0">
									<i class="ri-map-pin-2-fill text-primary"></i>
								</div>
								<div class="flex-grow-1">
									<label class="form-label small text-muted mb-1">Current Region</label>
									<select id="sel_change_region_compliance" class="form-select form-select-sm border-0 p-0 bg-transparent fw-medium" data-trigger>
										<option value="${regional_code}">${regional_name}</option>
										<c:forEach items="${officeregionlist}" var="officeregion">
											<option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
                <div class="card custom-card shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title mb-0">Queried Applications [ <span id="card_title"></span> ]</h5>
                            <p class="text-muted small mb-0 filter-status"></p>
                        </div>
                        <div class="d-flex gap-2">
                            <!-- <button class="btn btn-sm btn-outline-secondary d-none" id="btn_add_request_all">
                                <i class="ri-checkbox-circle-line me-1"></i> Add All To Request List
                            </button>
                            <button class="btn btn-sm btn-outline-secondary d-none" id="btn_add_archive_all">
                                <i class="ri-delete-bin-line me-1"></i> Add All To Archive List
                            </button> -->
							<input hidden="" id="pending_queries_input" value="" />
                            <button class="btn btn-sm btn-danger btnLoadData" id="btnPendingQueries">
                                <i class="ri-time-line me-1"></i> Pending Queries
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
						<div class="card-body p-0 mb-3">
							<div class="d-flex flex-wrap justify-content-start gap-3">
								<div class="d-flex align-items-center">
									<span class="badge bg-info-subtle text-info me-2"><i class="fas fa-circle fa-xs"></i></span>
									<small class="text-muted">Reminder Applications</small>
								</div>
								<div class="d-flex align-items-center">
									<span class="badge bg-warning-subtle text-warning me-2"><i class="fas fa-circle fa-xs"></i></span>
									<small class="text-muted">Warning Applications</small>
								</div>
								<div class="d-flex align-items-center">
									<span class="badge bg-danger-subtle text-danger me-2"><i class="fas fa-circle fa-xs"></i></span>
									<small class="text-muted">Queried Applications</small>
								</div>
								<div class="d-flex align-items-center">
									<span class="badge bg-success-subtle text-success me-2"><i class="fas fa-circle fa-xs"></i></span>
									<small class="text-muted">Response Applications</small>
								</div>
							</div>
						</div>
                        <div class="table-responsive">
                            <table id="table_list" class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Job No.</th>
                                        <th>Details</th>
                                        <th>Receiver</th>
										<th>Unit</th>
                                        <th>Created By</th>							        
                                        <!-- <th>Region</th> -->
                                        <th>Date Created</th>
										<th>TAT</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="small">
                                    <!-- Data will be loaded here dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

	</div>
</div>

<!-- <script>
	
</script> -->