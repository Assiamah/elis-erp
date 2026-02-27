<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>

<!-- ApexCharts CSS (optional, for some themes) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/apexcharts@3.45.2/dist/apexcharts.css">


<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">CAC Reports</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Generate and view CAC reports</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">CAC</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Reports</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

		<!-- Begin Page Content -->
		<div class="row g-4">
			<!-- Filter Panel - 3 columns -->
			<div class="col-lg-3">
				<!-- Filter Card -->
				<div class="card shadow-sm border-0">
					<div class="card-header bg-white py-3 border-0">
						<div class="d-flex align-items-center justify-content-between">
							<h5 class="mb-0 fw-semibold">
								<i class="bi bi-funnel-fill text-primary me-2"></i>
								Filter Reports
							</h5>
							<span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2">
								<i class="bi bi-sliders me-1"></i>
								Advanced
							</span>
						</div>
					</div>
					
					<div class="card-body pt-0">
						<form method="post" id="cica_reports_form">
							<!-- Date Range Section -->
							<div class="mb-4">
								<label class="form-label fw-semibold text-muted small text-uppercase mb-2">
									<i class="bi bi-calendar-range me-1"></i>
									Date Range
								</label>
								
								<!-- Start Date -->
								<div class="mb-2">
									<div class="input-group input-group-sm">
										<span class="input-group-text bg-light border-0">
											<i class="bi bi-calendar-check text-primary"></i>
										</span>
										<input type="date" class="form-control bg-light" 
											id="start_date" name="start_date" required>
									</div>
									<small class="text-muted ms-1">Start date</small>
								</div>
								
								<!-- End Date -->
								<div>
									<div class="input-group input-group-sm">
										<span class="input-group-text bg-light border-0">
											<i class="bi bi-calendar-x text-primary"></i>
										</span>
										<input type="date" class="form-control bg-light" 
											id="end_date" name="end_date" required>
									</div>
									<small class="text-muted ms-1">End date</small>
								</div>
							</div>

							<!-- Purpose Dropdown -->
							<div class="mb-4">
								<label class="form-label fw-semibold text-muted small text-uppercase mb-2">
									<i class="bi bi-tag me-1"></i>
									Purpose
								</label>
								<select class="form-select bg-light" 
										name="purpose" id="purpose" required data-trigger>
									<option disabled selected>-- Select Purpose --</option>
									<option value="1">Service Enquiry</option>
									<option value="2">Other Enquiry</option>
									<option value="3">Service Complaint</option>
									<option value="4">Non Service Complaint</option>	
								</select>
							</div>

							<!-- Advanced Filters (Collapsible) -->
							<div id="purpose_div">
								<div class="mb-4">
									<label class="form-label fw-semibold text-muted small text-uppercase mb-2">
										<i class="bi bi-flag me-1"></i>
										Status
									</label>
									<select class="form-select bg-light" 
											name="status" id="status" required data-trigger>
										<option disabled selected value="0">-- Select Status --</option>
										<option value="4">All</option>
										<option value="0">Open</option>
										<option value="2">Pending</option>
										<option value="1">On Hold</option>
										<option value="3">Resolved</option>	
									</select>
								</div>

								<div class="mb-4">
									<label class="form-label fw-semibold text-muted small text-uppercase mb-2">
										<i class="bi bi-diagram-3 me-1"></i>
										Division
									</label>
									<select class="form-select bg-light" 
											name="division" id="division" required  data-trigger>
										<option value="ALL">All Divisions</option>
										<option value="PVLMD" ${fn:contains(division, 'PVLMD') ? 'selected' : ''}>PVLMD</option>
										<option value="SMD" ${fn:contains(division, 'SMD') ? 'selected' : ''}>SMD</option>
										<option value="LVD" ${fn:contains(division, 'LVD') ? 'selected' : ''}>LVD</option>
										<option value="LRD" ${fn:contains(division, 'LRD') ? 'selected' : ''}>LRD</option>
									</select>
								</div>

								<div class="mb-4">
									<label class="form-label fw-semibold text-muted small text-uppercase mb-2">
										<i class="bi bi-geo-alt me-1"></i>
										Region
									</label>
									<select name="region_id" id="region_id" 
											class="form-select bg-light" data-trigger>
										<option value="-1">Select Office Region</option>
										<option value="0">All Regions</option>
										<c:forEach items="${officeregionlist}" var="officeregion">
											<option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<!-- Action Buttons -->
							<div class="d-grid gap-2 mt-5">
								<button type="submit" class="btn btn-primary" id="apply_filter">
									<i class="bi bi-funnel me-2"></i>
									Apply Filters
								</button>
								<button type="button" class="btn btn-outline-secondary" id="reset_filters">
									<i class="bi bi-arrow-counterclockwise me-2"></i>
									Reset
								</button>
							</div>
						</form>
					</div>
					
					<!-- Filter Summary Footer -->
					<div class="card-footer bg-white border-0 py-3">
						<div class="small text-muted">
							<i class="bi bi-info-circle me-1"></i>
							Filters affect all charts and tables
						</div>
					</div>
				</div>
			</div>

			<!-- Main Content - 9 columns -->
			<div class="col-lg-9">
				<!-- KPI Cards Section -->
				<div class="row g-3 mb-4" id="div_status">
					<!-- Total Card -->
					<div class="col-4">
						<div class="card border-0 shadow-sm h-100">
							<div class="card-body">
								<div class="d-flex align-items-start justify-content-between">
									<div>
										<p class="text-muted small text-uppercase mb-1">Total Tickets</p>
										<h3 class="mb-0 fw-bold" id="total">0</h3>
										<small class="text-muted">All purposes</small>
									</div>
									<div class="bg-primary bg-opacity-10 p-3 rounded-circle">
										<i class="bi bi-ticket-perforated text-primary fs-4"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Open Card -->
					<div class="col-2">
						<div class="card border-0 shadow-sm h-100 border-start border-warning border-4">
							<div class="card-body p-3">
								<div class="text-center">
									<p class="text-muted small text-uppercase mb-1">Open</p>
									<h4 class="mb-0 fw-bold text-warning" id="open">0</h4>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Pending Card -->
					<div class="col-2">
						<div class="card border-0 shadow-sm h-100 border-start border-info border-4">
							<div class="card-body p-3">
								<div class="text-center">
									<p class="text-muted small text-uppercase mb-1">Pending</p>
									<h4 class="mb-0 fw-bold text-info" id="pending">0</h4>
								</div>
							</div>
						</div>
					</div>
					
					<!-- On Hold Card -->
					<div class="col-2">
						<div class="card border-0 shadow-sm h-100 border-start border-secondary border-4">
							<div class="card-body p-3">
								<div class="text-center">
									<p class="text-muted small text-uppercase mb-1">On Hold</p>
									<h4 class="mb-0 fw-bold text-secondary" id="hold">0</h4>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Resolved Card -->
					<div class="col-2">
						<div class="card border-0 shadow-sm h-100 border-start border-success border-4">
							<div class="card-body p-3">
								<div class="text-center">
									<p class="text-muted small text-uppercase mb-1">Resolved</p>
									<h4 class="mb-0 fw-bold text-success" id="resolved">0</h4>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Division Stats Cards -->
				<div class="row g-3 mb-4 d-none" id="div_division">
					<div class="col-12">
						<div class="card border-0 shadow-sm">
							<div class="card-header bg-white py-3">
								<h6 class="mb-0 fw-semibold">
									<i class="bi bi-pie-chart me-2 text-primary"></i>
									Division Distribution
								</h6>
							</div>
							<div class="card-body">
								<div class="row g-3">
									<div class="col-2">
										<div class="text-center p-3 bg-light rounded-3">
											<span class="small text-muted d-block">TOTAL</span>
											<span class="h5 mb-0 fw-bold text-primary" id="total_d">0</span>
										</div>
									</div>
									<div class="col-2">
										<div class="text-center p-3 bg-light rounded-3">
											<span class="small text-muted d-block">PVLMD</span>
											<span class="h5 mb-0 fw-bold" id="pvlmd">0</span>
										</div>
									</div>
									<div class="col-2">
										<div class="text-center p-3 bg-light rounded-3">
											<span class="small text-muted d-block">LRD</span>
											<span class="h5 mb-0 fw-bold" id="lrd">0</span>
										</div>
									</div>
									<div class="col-2">
										<div class="text-center p-3 bg-light rounded-3">
											<span class="small text-muted d-block">SMD</span>
											<span class="h5 mb-0 fw-bold" id="smd">0</span>
										</div>
									</div>
									<div class="col-2">
										<div class="text-center p-3 bg-light rounded-3">
											<span class="small text-muted d-block">LVD</span>
											<span class="h5 mb-0 fw-bold" id="lvd">0</span>
										</div>
									</div>
									<div class="col-2">
										<div class="text-center p-3 bg-light rounded-3">
											<span class="small text-muted d-block">CORP.</span>
											<span class="h5 mb-0 fw-bold" id="corporate">0</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Chart Card -->
				<div class="card border-0 shadow-sm mb-4" id="cica_chart">
					<div class="card-header bg-white py-3 d-flex align-items-center justify-content-between">
						<div>
							<h5 class="mb-1 fw-semibold">
								<i class="bi bi-bar-chart-line text-primary me-2"></i>
								Service Related Complaints
							</h5>
							<p class="text-muted small mb-0">Monthly trend analysis</p>
						</div>
						<div class="btn-group" role="group">
							<button type="button" class="btn btn-outline-secondary btn-sm">
								<i class="bi bi-calendar-week"></i>
							</button>
							<button type="button" class="btn btn-outline-secondary btn-sm">
								<i class="bi bi-calendar-month"></i>
							</button>
							<button type="button" class="btn btn-outline-secondary btn-sm" id="fullscreenChart">
								<i class="bi bi-arrows-fullscreen"></i>
							</button>
						</div>
					</div>
					<div class="card-body">
						<div class="chart" style="height: 350px;">
							<div id="barChart" style="width: 100%; height: 100%;"></div>
						</div>
					</div>
				</div>

				<!-- Data Tables Section -->
				<div class="col-lg-12 mt-2">
					<!-- Table Tabs -->
					<div class="card border-0 shadow-sm">
						<div class="card-header bg-white py-3">
							<ul class="nav nav-tabs card-header-tabs" role="tablist">
								<li class="nav-item">
									<a class="nav-link active" data-bs-toggle="tab" href="#service_tickets" role="tab">
										<i class="bi bi-ticket-detailed me-2"></i>
										Service Tickets
										<span class="badge bg-primary ms-2" id="serviceCount">0</span>
									</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" data-bs-toggle="tab" href="#other_tickets" role="tab">
										<i class="bi bi-chat-text me-2"></i>
										Other Enquiries
										<span class="badge bg-secondary ms-2" id="otherCount">0</span>
									</a>
								</li>
							</ul>
							
							<!-- Column Toggle Buttons -->
							<div class="mt-3 d-flex align-items-center gap-2">
								<span class="small text-muted me-2">Show/Hide Columns:</span>
								<button onclick="togglePhoneColumn(3)" class="btn btn-sm btn-outline-danger">
									<i class="bi bi-telephone me-1"></i>
									Phone <span id="_phone_option_status" class="badge bg-danger ms-1">On</span>
								</button>
								<button onclick="toggleEmailColumn(4)" class="btn btn-sm btn-outline-danger">
									<i class="bi bi-envelope me-1"></i>
									Email <span id="_email_option_status" class="badge bg-danger ms-1">On</span>
								</button>
							</div>
						</div>

						<div class="card-body">
							<!-- Tab Panes -->
							<div class="tab-content">
								<!-- Service Tickets Tab -->
								<div class="tab-pane active" id="service_tickets" role="tabpanel">
									<div class="table-responsive">
										<table class="table table-hover align-middle" id="table_list" width="100%">
											<thead class="bg-light">
												<tr>
													<th width="5%">#</th>
													<th width="10%">Ticket No.</th>
													<th width="15%">Name</th>
													<th width="10%">Phone</th>
													<th width="15%">Email</th>
													<th width="10%">Purpose</th>
													<th width="15%">Subject</th>
													<th width="8%" class="text-center">Status</th>
													<th width="8%" class="text-center">Priority</th>
													<th width="8%">Division</th>
													<th width="10%">Region</th>
													<th width="10%">Created By</th>
													<th width="12%">Date Created</th>
													<th width="12%">Date Completed</th>
												</tr>
											</thead>
											<tbody id="table_body"></tbody>
										</table>
									</div>
								</div>

								<!-- Other Enquiries Tab -->
								<div class="tab-pane" id="other_tickets" role="tabpanel">
									<div class="table-responsive">
										<table class="table table-hover align-middle" id="other_table_list" width="100%" style="text-transform: uppercase;">
											<thead class="bg-light">
												<tr>
													<th width="5%">#</th>
													<th width="10%">Ticket No.</th>
													<th width="15%">Name</th>
													<th width="10%">Phone</th>
													<th width="15%">Email</th>
													<th width="12%">Reference Source</th>
													<th width="12%">Milestone Status</th>
													<th width="15%">Nature of Enquiry</th>
													<th width="10%">Region</th>
													<th width="10%">Created By</th>
													<th width="12%">Date Created</th>
													<th width="12%">Date Completed</th>
												</tr>
											</thead>
											<tbody></tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<!-- Table Footer with Export Options -->
						<div class="card-footer bg-white border-0 py-3">
							<div class="d-flex justify-content-between align-items-center">
								<div class="small text-muted">
									<i class="bi bi-info-circle me-1"></i>
									Showing <span id="recordStart">1</span> to <span id="recordEnd">10</span> of <span id="totalRecords">0</span> entries
								</div>
								<div class="btn-group" role="group">
									<button type="button" class="btn btn-outline-primary btn-sm" id="btn_export_excel">
										<i class="bi bi-file-excel me-1"></i>
										Excel
									</button>
									<button type="button" class="btn btn-outline-primary btn-sm" id="btn_export_pdf">
										<i class="bi bi-file-pdf me-1"></i>
										PDF
									</button>
									<button type="button" class="btn btn-outline-primary btn-sm" id="btn_print">
										<i class="bi bi-printer me-1"></i>
										Print
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	
<!-- End Page Content -->
 	</div>
 </div>

<!-- Correct CDN links -->
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<!-- OR -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.45.2/apexcharts.min.js"></script>

<!-- Plotly.js library -->
<script src="https://cdn.plot.ly/plotly-2.27.0.min.js"></script>
<script type="text/javascript">

	
	function togglePhoneColumn(columnIndex) {
		// Get all table elements on the page
		let tables = document.getElementsByTagName("table");

		// Loop through each table
		for (let t = 0; t < tables.length; t++) {
			let table = tables[t];         

			document.getElementById('_phone_option_status').innerHTML = 'On'
			
			// Get the column header (th) of the specific column in this table
			let th = table.getElementsByTagName("th")[columnIndex];
			
			// Check if the column header exists
			if (th) {
				// Toggle visibility of the column header
				th.style.display = (th.style.display === "none") ? "" : "none";
				//$('#_phone_option_status')
				th.style.display = (th.style.display === "none") ? 
				document.getElementById('_phone_option_status').innerHTML = 'Off' : 
				document.getElementById('_phone_option_status').innerHTML = 'On';
			} 

			// Get all the data cells (td) in this table
			let rows = table.getElementsByTagName("tr");
			
			// Loop through each row of the table
			for (let i = 0; i < rows.length; i++) {
				let cells = rows[i].getElementsByTagName("td");

				// Make sure this row has a cell in the specified column
				if (cells.length > columnIndex) {
					let cell = cells[columnIndex];
					
					// Toggle visibility of the column data cells
					cell.style.display = (cell.style.display === "none") ? "" : "none";
				}
			}
		}
	}


	function toggleEmailColumn(columnIndex) {
		// Get all table elements on the page
		let tables = document.getElementsByTagName("table");

		// Loop through each table
		for (let t = 0; t < tables.length; t++) {
			let table = tables[t];
			
			// Get the column header (th) of the specific column in this table
			let th = table.getElementsByTagName("th")[columnIndex];
			
			// Check if the column header exists
			if (th) {
				// Toggle visibility of the column header
				th.style.display = (th.style.display === "none") ? "" : "none";

				th.style.display = (th.style.display === "none") ? 
				document.getElementById('_email_option_status').innerHTML = 'Off' : 
				document.getElementById('_email_option_status').innerHTML = 'On';
			}

			// Get all the data cells (td) in this table
			let rows = table.getElementsByTagName("tr");
			
			// Loop through each row of the table
			for (let i = 0; i < rows.length; i++) {
				let cells = rows[i].getElementsByTagName("td");

				// Make sure this row has a cell in the specified column
				if (cells.length > columnIndex) {
					let cell = cells[columnIndex];
					
					// Toggle visibility of the column data cells
					cell.style.display = (cell.style.display === "none") ? "" : "none";
				}
			}
		}
	}
       

</script>