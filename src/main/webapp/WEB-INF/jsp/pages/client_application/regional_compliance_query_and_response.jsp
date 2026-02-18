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
	.dropdown-menu .dropdown-item {
    text-transform: none !important;
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
						<h1 class="page-title fw-medium fs-18 mb-1"><i class="ri-chat-quote-line me-2 text-primary"></i>Regional Head: Compliance Query and Response</h1>
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
    <input id='userid' type='hidden' value='${sessionScope.userid}'/>

	<div class="row">
		<div class="col-xl-2">
			<div class="row">
				<div class="col-xl-12 col-md-6">
					<a href="#" class="showDivisionModal" id="compliance_query_apps_card" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date='This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)'>
						<div class="card stat-card custom-card dashboard-main-card danger"> 
							<div class="card-body">
								<div class="d-flex align-items-start gap-3">
									<div>
										<span class="avatar avatar-md bg-danger svg-white">
											<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
										</span>
									</div>
									<div>
										<span class="d-block text-muted">Compliance Query Applications</span>
										<h5 class="fw-semibold mb-1" id="app-received-month">${compliance_queries_count}</h5>
										<!-- <div class="text-muted fs-12">
											<span class="text-success">month</span>
											( <fmt:formatDate value="${now}" pattern="MMMM" /> )
										</div> -->
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-xl-12 col-md-6">
					<a href="#" class="showDivisionModal" id="warning_apps_card" data-method="summary_completed" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date='Today (<fmt:formatDate value="${now}" type="date" />)'>
						<div class="card stat-card custom-card dashboard-main-card warning"> 
							<div class="card-body">
								<div class="d-flex align-items-start gap-3">
									<div>
										<span class="avatar avatar-md bg-warning svg-white">
											<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
										</span>
									</div>
									<div>
										<span class="d-block text-muted">Warning Applications</span>
										<h5 class="fw-semibold mb-1" id="app-completed-today">${warnings_count}</h5>
										<!-- <div class="text-muted fs-12">
											<span class="text-success">today</span>
											( <fmt:formatDate value="${now}" type="date" /> )
										</div> -->
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-xl-12 col-md-6">
					<a href="#" class="showDivisionModal" id="reminder_apps_card" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date='This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)'>
						<div class="card stat-card custom-card dashboard-main-card info"> 
							<div class="card-body">
								<div class="d-flex align-items-start gap-3">
									<div>
										<span class="avatar avatar-md bg-info svg-white">
											<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#5f6368"><path d="M0 0h24v24H0z" fill="none"></path><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path></svg>
										</span>
									</div>
									<div>
										<span class="d-block text-muted">Reminder Applications</span>
										<h5 class="fw-semibold mb-1" id="app-completed-month">${reminders_count}</h5>
										<!-- <div class="text-muted fs-12">
											<span class="text-success">this month</span>
											( <fmt:formatDate value="${now}" pattern="MMMM" /> )
										</div> -->
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
		<div class="col-xl-10">
			<div class="card custom-card shadow-sm">
              <!-- <div class="card-header bg-dark text-white">
                <i class="fa fa-bar-chart"></i><span class="h5">Queried Details</span> <span
                class="col-md-3 float-right ">
            </span>
            </div> -->
			<div class="card-header d-flex justify-content-between align-items-center">
				<div>
					<h5 class="card-title mb-0">Queried Applications [ <span id="card_title"></span> ]</h5>
					<p class="text-muted small mb-0 filter-status"></p>
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
              <div class="tab-content mt-4">
                        <div id="" class="table-responsive">
                            <table class="table " id="table_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
                                  <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Job No.</th>
                                        <th>Details</th>
                                        <th>Receiver</th>
                                        <th>Unit</th>							        
                                        <th>Created By</th>
                                        <th>Date Created</th>
                                        <th>TAT</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                  </thead>
                                  <tbody id="table_body">
                                    
                                  </tbody>
                               </table>
                        </div>
                </div>
            </div>
          </div>
		</div>
	</div>

    

	</div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->