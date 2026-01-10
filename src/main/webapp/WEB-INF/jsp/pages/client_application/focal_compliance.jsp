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
    .stat-card {
        transition: all 0.3s ease;
        border: none;
        position: relative;
        overflow: hidden;
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

	/* Division Modal Styles */
.modal-header.bg-gradient-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.division-card {
    transition: all 0.3s ease;
    border-left: 4px solid transparent;
}

.division-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.1) !important;
}

.division-card .division-icon {
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.division-card .division-icon.bg-primary {
    background-color: rgba(102, 126, 234, 0.1) !important;
    color: #667eea !important;
}

.division-card .division-icon.bg-success {
    background-color: rgba(40, 167, 69, 0.1) !important;
    color: #28a745 !important;
}

.division-card .division-icon.bg-warning {
    background-color: rgba(255, 193, 7, 0.1) !important;
    color: #ffc107 !important;
}

.division-card .division-icon.bg-danger {
    background-color: rgba(220, 53, 69, 0.1) !important;
    color: #dc3545 !important;
}

.btn.bg-primary { background-color: #667eea; border-color: #667eea; }
.btn.bg-success { background-color: #28a745; border-color: #28a745; }
.btn.bg-warning { background-color: #ffc107; border-color: #ffc107; color: #000; }
.btn.bg-danger { background-color: #dc3545; border-color: #dc3545; }

.avatar {
    width: 60px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Progress bar customization */
.progress-bar.bg-primary { background-color: #667eea !important; }
.progress-bar.bg-success { background-color: #28a745 !important; }
.progress-bar.bg-warning { background-color: #ffc107 !important; }
.progress-bar.bg-danger { background-color: #dc3545 !important; }

/* Responsive adjustments */
@media (max-width: 768px) {
    .modal-header .d-flex {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .modal-header .modal-icon-container {
        margin-bottom: 10px;
    }
    
    .modal-footer .d-flex {
        flex-direction: column;
        gap: 10px;
    }
    
    .modal-footer .text-muted {
        text-align: center;
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
						<h1 class="page-title fw-medium fs-20 mb-1"><i class="ri-question-line me-2 text-danger"></i>Compliance</h1>
					</div>
					

					<!-- Region Selector -->
					

				
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item" aria-current="page">Compliance</li>
                    <li class="breadcrumb-item active" aria-current="page">Focal Person</li>
                </ol>
            </div>
        </div>

        <input type="hidden" id="director_regional_code" value="${regional_code}" />
        <input type="hidden" id="director_division" value="${division}" />

        <div class="row">
            <div class="col-xl-2">
                <div class="row">
                    <div class="col-xl-12 col-md-6">
                        <a href="#" id="apps_received_today" class="showDivisionModal" data-method="summary_created" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date='This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)'>
                            <div class="card stat-card custom-card dashboard-main-card primary school-card"> 
								<div class="card-body">
									<div class="d-flex align-items-start gap-3">
										<div>
											<span class="avatar avatar-md bg-primary svg-white">
												<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
											</span>
										</div>
										<div>
											<span class="d-block text-muted">Applications Received</span>
											<h5 class="fw-semibold mb-1" id="app-received-today">0</h5>
											<div class="text-muted fs-12">
												<span class="text-success">today</span>
												( <fmt:formatDate value="${now}" type="date" /> )
											</div>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                    <div class="col-xl-12 col-md-6">
                        <a href="#" id="apps_received_this_month" class="showDivisionModal" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date='This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)'>
                            <div class="card stat-card custom-card dashboard-main-card secondary school-card"> 
								<div class="card-body">
									<div class="d-flex align-items-start gap-3">
										<div>
											<span class="avatar avatar-md bg-secondary svg-white">
												<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
											</span>
										</div>
										<div>
											<span class="d-block text-muted">Applications Received</span>
											<h5 class="fw-semibold mb-1" id="app-received-month">0</h5>
											<div class="text-muted fs-12">
												<span class="text-success">month</span>
												( <fmt:formatDate value="${now}" pattern="MMMM" /> )
											</div>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                   <div class="col-xl-12 col-md-6">
                        <a href="#" id="apps_completed_today_division" class="showDivisionModal" data-method="summary_completed" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date='Today (<fmt:formatDate value="${now}" type="date" />)'>
                            <div class="card stat-card custom-card dashboard-main-card success school-card"> 
								<div class="card-body">
									<div class="d-flex align-items-start gap-3">
										<div>
											<span class="avatar avatar-md bg-success svg-white">
												<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
											</span>
										</div>
										<div>
											<span class="d-block text-muted">Applications Completed</span>
											<h5 class="fw-semibold mb-1" id="app-completed-today">0</h5>
											<div class="text-muted fs-12">
												<span class="text-success">today</span>
												( <fmt:formatDate value="${now}" type="date" /> )
											</div>
										</div>
									</div>
								</div>
							</div>
                        </a>
                    </div>
                    <div class="col-xl-12 col-md-6">
                        <a href="#" id="apps_completed_month_division" class="showDivisionModal" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date='This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)'>
                            <div class="card stat-card custom-card dashboard-main-card warning school-card"> 
								<div class="card-body">
									<div class="d-flex align-items-start gap-3">
										<div>
											<span class="avatar avatar-md bg-warning svg-white">
												<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
											</span>
										</div>
										<div>
											<span class="d-block text-muted">Applications Completed</span>
											<h5 class="fw-semibold mb-1" id="app-completed-month">0</h5>
											<div class="text-muted fs-12">
												<span class="text-success">this month</span>
												( <fmt:formatDate value="${now}" pattern="MMMM" /> )
											</div>
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
				<div class="row mb-4">
					<div class="col-12">
						<div class="d-flex justify-content-between align-items-center">
							<div>
								<h4 class="mb-2 text-gray-800">Dashboard Overview</h4>
								<p class="text-muted mb-0">Real-time application tracking and analytics</p>
							</div>
							<!-- <div class="region-selector" style="width: 445px;">
								<div class="card border shadow-sm">
									<div class="card-body py-2 px-3">
										<div class="d-flex align-items-center gap-3">
											<div class="region-icon">
												<i class="ri-map-pin-2-fill text-primary fs-5"></i>
											</div>
											<div class="flex-grow-1">
												<label class="form-label small text-muted mb-1">Current Region</label>
												<select id="sel_change_region_compliance" class="form-select form-select-sm border-0 p-0 bg-transparent fw-semibold text-dark" data-trigger>
													<option value="${regional_code}">${regional_name}</option>
													<c:forEach items="${officeregionlist}" var="officeregion">
														<option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div> -->
						</div>
					</div>
				</div>
                <div class="row">
					<!-- Application Received -->
					<div id="app-received-year" class="col-lg-4 mb-4">
						<div class="card custom-card">
							<div class="card-header">
								<div class="card-title">    
									Applications Received in <fmt:formatDate value="${now}" pattern="Y" />
								</div>
							</div>
							<div class="card-body"
								data-method="apps_created" 
								data-period="year" 
								data-url="DashboardAppsReceived" 
								data-next-level-modal="showServiceTypeModal" 
								data-title="Applications Received" 
								data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
								
								<div class="d-flex align-items-center mb-3 flex-wrap">
									<h4 class="fw-bold mb-0"><span class="count">0</span></h4>
									<div class="ms-2">
										<span class="badge bg-primary-transparent">Applications</span>
									</div>
								</div>
								
								<div class="progress-stacked progress-animate progress-sm mb-4">
									<!-- Progress bars will be dynamically generated here -->
								</div>
								
								<ul class="list-unstyled mb-0 pt-2 top-referral-pages">
									<!-- List items will be dynamically generated here -->
								</ul>
							</div>
						</div>
					</div>
					
					
					
					<!-- Application Received and Completed -->
					<div id="app-received-completed-year" class="col-lg-4 mb-4">
						<div class="card custom-card">
							<div class="card-header">
								<div class="card-title">    
									Applications Received and Completed in <fmt:formatDate value="${now}" pattern="Y" />
								</div>
							</div>
							<div class="card-body"
								data-method="apps_received_completed" 
								data-period="year" 
								data-url="DashboardAppsReceivedAndCompleted" 
								data-next-level-modal="showServiceTypeModal" 
								data-title="Applications Received and Completed" 
								data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
								
								<div class="d-flex align-items-center justify-content-between mb-3">
									<div class="d-flex align-items-center">
										<h4 class="fw-bold mb-0 me-2"><span class="count">0</span></h4>
										<span class="badge bg-primary-transparent">Applications</span>
									</div>
									<div class="text-end">
										<div class="text-muted fs-11 mb-1">Completion Rate <span class="fw-bold text-success" id="pec_id">0%</span></div>
									</div>
								</div>
								
								<div class="progress-stacked progress-animate progress-sm mb-4">
									<!-- Progress bars will be dynamically generated here -->
								</div>
								
								<ul class="list-unstyled mb-0 pt-2 top-referral-pages">
									<!-- List items will be dynamically generated here -->
								</ul>
							</div>
						</div>
					</div>

					<!-- Application Completed -->

					<div id="app-completed-year" class="col-lg-4 mb-4">
						<div class="card custom-card">
							<div class="card-header">
								<div class="card-title">    
									Applications Completed in <fmt:formatDate value="${now}" pattern="Y" />
								</div>
							</div>
							<div class="card-body"
								data-method="apps_completed" 
								data-period="year" 
								data-url="DashboardAppsCompleted" 
								data-next-level-modal="showServiceTypeModal" 
								data-title="Applications Completed" 
								data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
								
								<div class="d-flex align-items-center justify-content-between mb-3">
									<div class="d-flex align-items-center">
										<h4 class="fw-bold mb-0 me-2"><span class="count">0</span></h4>
										<span class="badge bg-primary-transparent">Applications</span>
									</div>
								</div>
								
								<div class="progress-stacked progress-animate progress-sm mb-4">
									<!-- Progress bars will be dynamically generated here -->
								</div>
								
								<ul class="list-unstyled mb-0 pt-2 top-referral-pages">
									<!-- List items will be dynamically generated here -->
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<!-- Past Due -->
					<div id="app-past-due-year" class="col-lg-6 mb-4">
						<div class="card shadow-sm mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-black">Applications Past Due Date </h6>
								<span class="small text-primary"><span class="count">0</span> Applications</span>
							</div>
							<div data-method="apps_past_due" data-period="year" data-url="DashboardAppsPastDueDate" data-next-level-modal="showUnitModal" data-title="Applications Past Due Date" data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)' class="content-body card-body"></div>
						</div>
					</div>
					<div id="app-with-divisions" class="col-lg-6 mb-4">
						<div class="card shadow-sm mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-black">Applications With Divisions </h6>
								<span class="small text-primary"><span class="count">0</span> Applications</span>
							</div>
							<div data-method="apps_with_division" data-url="DashboardAppsWithDivision" data-next-level-modal="showUnitModal" data-title="Applications With Divisions" class="content-body card-body"></div>
						</div>
					</div>
				</div>
            </div>
        </div>


        
    </div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->

