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
<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />


<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800">Delivery and Compliance Reports for 
	
	<select id="sel_change_region_compliance" class="">
		<option value=${regional_code}>${regional_name}</option>
									
		<c:forEach items="${officeregionlist}" var="officeregion">
			<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
  </c:forEach>

								</select>
	
	
	
	</h1>

	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
								Received</div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">0
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="summary_created" data-period="day" 
						data-url="DashboardDivisionSummary" data-icon="fa-file" 
						data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
						class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Application Received (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
								Received</div>
							<div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
							<div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>

			</div>
		</div>

		<!-- Application Completed (Today) -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Completed
							</div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>

							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
								</div>

							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="summary_completed" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Application Completed (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Applications
								Completed</div>
							<div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
							<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<!-- Application Received -->
		<div id="app-received-year" class="col-lg-4 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-black">Applications Received in
						<fmt:formatDate value="${now}" pattern="Y" />
					</h6>
					<span class="small text-primary"><span class="count">0</span> Applications</span>
				</div>
				<div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
			</div>
		</div>
		
		
		<!-- Application Received and Completed -->
		<div id="app-received-completed-year" class="col-lg-4 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-black">Applications Received and Completed in
						<fmt:formatDate value="${now}" pattern="Y" />
					</h6>
					<span class="small text-primary"><span class="count">0</span> Applications</span>
					<span class="small text-primary float-right" id="pec_id">0%</span>
				</div>
				<div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
			</div>
		</div>

		<!-- <div id="app-received-completed-year" class="col-lg-4 mb-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-black">Applications Received and Completed in
						<fmt:formatDate value="${now}" pattern="Y" />
					</h6>
                    <span class="small text-primary"><span class="count">0</span> Applications</span>
                    <span class="small text-primary float-right" id="pec_id">0%</span>
                </div>
                <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body">

				</div>
            </div>
		</div> -->

		<!-- Application Completed -->
		<div id="app-completed-year" class="col-lg-4 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-black">Applications Completed in
						<fmt:formatDate value="${now}" pattern="Y" />
					</h6>
					<span class="small text-primary"><span class="count">0</span> Applications</span>
				</div>
				<div data-method="apps_completed" data-period="year" data-url="DashboardAppsCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
			</div>
		</div>

		<!-- <div id="app-completed-year" class="col-lg-3 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-black">Applications Queried</h6>
					<span class="small text-primary"><span class="count">0</span> Applications
						<fmt:formatDate value="${now}" pattern="Y" />
					</span>
				</div>
				<div data-method="apps_completed" data-period="year" data-url="DashboardAppsCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
			</div>
		</div> -->

		
	</div>

	<div class="row">
		<!-- Past Due -->
		<div id="app-past-due-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-black">Applications Past Due Date </h6>
					<span class="small text-primary"><span class="count">0</span> Applications</span>
				</div>
				<div data-method="apps_past_due" data-period="year" data-url="DashboardAppsPastDueDate" data-next-level-modal="showUnitModal" data-title="Applications Past Due Date" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
			</div>
		</div>
		<div id="app-with-divisions" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-black">Applications With Divisions </h6>
					<span class="small text-primary"><span class="count">0</span> Applications</span>
				</div>
				<div data-method="apps_with_division" data-url="DashboardAppsWithDivision" data-next-level-modal="showUnitModal" data-title="Applications With Divisions" class="content-body card-body"></div>
			</div>
		</div>
	</div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>