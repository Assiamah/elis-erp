<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<jsp:useBean id="now" class="java.util.Date" />



<!-- Regions Modal -->
<div class="modal fade effect-scale modal-blur" id="regionsModal" tabindex="-1" aria-labelledby="regionsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="regionsModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="region_table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Region</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade effect-scale modal-blur" id="user_divisionModal" tabindex="-1" aria-labelledby="user_divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="user_divisionModalLabel">
					Applications Received Today (<fmt:formatDate value="${now}" type="date" />)
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xl-3 col-md-6 mb-4" id="user_division_today">
						<div class="card border-start-primary shadow">
							<div class="card-body">
								<div class="row g-0 align-items-center">
									<div class="col me-2">
										<div id="user_division" class="text-xs fw-bold text-primary text-uppercase mb-1"></div>
										<div id="div_count" class="h5 mb-0 fw-bold text-gray-800"></div>
									</div>
									<div class="col-auto">
										<i class="fas fa-2x text-gray-300 ${iconClass}"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">
					Close <i class="fa fa-times"></i>
				</button>
			</div>
		</div>
	</div>
</div>

<!-- User Division Modal (This Month) -->
<div class="modal fade effect-scale modal-blur" id="user_divisionModal_this_month" tabindex="-1" aria-labelledby="user_divisionModal_this_monthLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="user_divisionModal_this_monthLabel">
					Applications Received This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xl-3 col-md-6 mb-4" id="user_division_this_month">
						<div class="card border-start-primary shadow">
							<div class="card-body">
								<div class="row g-0 align-items-center">
									<div class="col me-2">
										<div id="user_division_month" class="text-xs fw-bold text-primary text-uppercase mb-1"></div>
										<div id="div_count_month" class="h5 mb-0 fw-bold text-gray-800"></div>
									</div>
									<div class="col-auto">
										<i class="fas fa-2x text-gray-300 ${iconClass}"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">
					Close <i class="fa fa-times"></i>
				</button>
			</div>
		</div>
	</div>
</div>

<!-- User Completed Division (Today) -->
<div class="modal fade effect-scale modal-blur" id="user_completed_divison_today" tabindex="-1" aria-labelledby="user_completed_divison_todayLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="user_completed_divison_todayLabel">
					Applications Completed Today (<fmt:formatDate value="${now}" type="date" />)
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xl-3 col-md-6 mb-4" id="completed_today_service">
						<div class="card border-start-primary shadow">
							<div class="card-body">
								<div class="row g-0 align-items-center">
									<div class="col me-2">
										<div id="user_division_completed_today" class="text-xs fw-bold text-primary text-uppercase mb-1"></div>
										<div id="div_count_completed_toda" class="h5 mb-0 fw-bold text-gray-800"></div>
									</div>
									<div class="col-auto">
										<i class="fas fa-2x text-gray-300 ${iconClass}"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">
					Close <i class="fa fa-times"></i>
				</button>
			</div>
		</div>
	</div>
</div>

<!-- User Completed Division (Month) -->
<div class="modal fade effect-scale modal-blur" id="user_completed_divison_month" tabindex="-1" aria-labelledby="user_completed_divison_monthLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="user_completed_divison_monthLabel">
					Applications Completed This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xl-3 col-md-6 mb-4" id="completed_month_service">
						<div class="card border-start-primary shadow">
							<div class="card-body">
								<div class="row g-0 align-items-center">
									<div class="col me-2">
										<div id="user_division_completed_month" class="text-xs fw-bold text-primary text-uppercase mb-1"></div>
										<div id="div_count_completed_momth" class="h5 mb-0 fw-bold text-gray-800"></div>
									</div>
									<div class="col-auto">
										<i class="fas fa-2x text-gray-300 ${iconClass}"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">
					Close <i class="fa fa-times"></i>
				</button>
			</div>
		</div>
	</div>
</div>

<!-- Service Type Modal -->
<div class="modal fade effect-scale modal-blur" id="serviceTypeModal" tabindex="-1" aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="serviceTypeModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<input type="hidden" id="today_region_id">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="created_by_services_today" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Completed Today Service Type Modal -->
<div class="modal fade effect-scale modal-blur" id="completedTodayserviceTypeModal" tabindex="-1" aria-labelledby="completedTodayserviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="completedTodayserviceTypeModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="completed_serviceType_Table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Completed Month Service Type Modal -->
<div class="modal fade effect-scale modal-blur" id="completedMonthserviceTypeModal" tabindex="-1" aria-labelledby="completedMonthserviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="completedMonthserviceTypeModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="completed_MonthserviceType_Table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Service Type Modal (Month) -->
<div class="modal fade effect-scale modal-blur" id="serviceTypeModalMonth" tabindex="-1" aria-labelledby="serviceTypeModalMonthLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="serviceTypeModalMonthLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="created_by_services_month" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Units Modal -->
<div class="modal fade effect-scale modal-blur" id="unitModal" tabindex="-1" aria-labelledby="unitModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelCompletedYear"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="apps_past_due_unit" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Unit</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Officers Modal -->
<div class="modal fade effect-scale modal-blur" id="officerModal" tabindex="-1" aria-labelledby="officerModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="officerModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="mb-3">
						<a class="btn btn-outline-primary btn-sm sendMessage" href="#">
							<i class="fas fa-envelope me-1"></i> Send Message
						</a>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="past_due_officers_table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Officer</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Received Year Modal -->
<div class="modal fade effect-scale modal-blur" id="apps_recieved_year_modal" tabindex="-1" aria-labelledby="apps_recieved_year_modalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelRecievedYear"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="apps_recieved_year_table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Received & Completed Year Modal -->
<div class="modal fade effect-scale modal-blur" id="apps_recieved_completed_year_modal" tabindex="-1" aria-labelledby="apps_recieved_completed_year_modalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelRecievedCompletedYear"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="apps_recieved_completed_year_table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Completed Year Modal -->
<div class="modal fade effect-scale modal-blur" id="apps_completed_year_modal" tabindex="-1" aria-labelledby="apps_completed_year_modalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelCompletedYear1"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="apps_completed_year_table" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Service Name</th>
											<th>Count</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal -->
<div class="modal fade effect-scale modal-blur" id="applicationsModal" tabindex="-1" aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Pending Days</th>
											<th>Date Received by Officer</th>
											<th>Days With Officer</th>
											<th>Current Stage</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal (Received Month) -->
<div class="modal fade effect-scale modal-blur" id="applicationsModalRecievedMonth" tabindex="-1" aria-labelledby="applicationsModalRecievedMonthLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelRecievedMonth"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_month_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Pending Days</th>
											<th>Date Received by Officer</th>
											<th>Days With Officer</th>
											<th>Current Stage</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal (Received Year) -->
<div class="modal fade effect-scale modal-blur" id="applicationsModalRecievedYear" tabindex="-1" aria-labelledby="applicationsModalRecievedYearLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header d-flex justify-content-between align-items-start">
				<div>
					<h5 class="modal-title" id="applicationsModalLabelRecievedYear"></h5>
				</div>
				<div class="d-flex align-items-center gap-2">
					<div class="form-group mb-0">
						<label for="status_filter" class="form-label small mb-0 me-2">Filter by Status:</label>
						<select id="status_filter" class="form-select form-select-sm" style="width: auto;">
							<option value="all">All</option>
							<option value="Pending">Pending</option>
							<option value="Completed">Completed</option>
							<option value="Queried">Queried</option>
						</select>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<input type="hidden" id="serviceSelect">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_year_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Pending Days</th>
											<th>Date Received by Officer</th>
											<th>Days With Officer</th>
											<th>Current Stage</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal (Completed Today) -->
<div class="modal fade effect-scale modal-blur" id="applicationsModalCompletedToday" tabindex="-1" aria-labelledby="applicationsModalCompletedTodayLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelCompletedToday"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_completed_today_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Completed Date</th>
											<th>TAT</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal (Completed Month) -->
<div class="modal fade effect-scale modal-blur" id="applicationsModalCompletedMonth" tabindex="-1" aria-labelledby="applicationsModalCompletedMonthLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelCompletedMonth"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_completed_month_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Completed Date</th>
											<th>TAT</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal (Received & Completed Year) -->
<div class="modal fade effect-scale modal-blur" id="applicationsModalRecievedCompletedYear" tabindex="-1" aria-labelledby="applicationsModalRecievedCompletedYearLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelRecievedCompletedYear"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_created_completed_year_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Completed Date</th>
											<th>TAT</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal (Completed Year) -->
<div class="modal fade effect-scale modal-blur" id="applicationsModalCompletedYear" tabindex="-1" aria-labelledby="applicationsModalCompletedYearLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelCompletedYear"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="view_applications_completed_year_by_service_type" class="table table-striped w-100">
									<thead>
										<tr>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Application Type</th>
											<th>Submission Date</th>
											<th>Completed Date</th>
											<th>TAT</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Past Due Applications Modal -->
<div class="modal fade effect-scale modal-blur" id="past_due_apps_modal" tabindex="-1" aria-labelledby="past_due_apps_modalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header d-flex justify-content-between align-items-start">
				<h5 class="modal-title" id="past_due_apps_Label"></h5>
				<div class="d-flex align-items-center gap-2">
					<div id="sendmsg"></div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="past_due_apps_with_staff" class="table table-striped w-100">
									<thead>
										<tr>
											<th>
												<div class="form-check">
													<input class="form-check-input" type="checkbox" id="select-all">
													<label class="form-check-label small" for="select-all">Select All</label>
												</div>
											</th>
											<th>Job Number</th>
											<th>Applicant Name</th>
											<th>Submission Date</th>
											<th>Pending Days</th>
											<th>Date Received by Officer</th>
											<th>Days With Officer</th>
											<th>Current Stage</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="col-12 mt-3">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart d-flex flex-wrap align-items-center gap-2">
					<label for="chart_type" class="form-label mb-0">Generate Chart</label>
					<select class="form-select form-select-sm" name="chart_type" style="width: auto;">
						<option value="">Select One</option>
						<option value="pie">Pie Chart</option>
						<option value="doughnut">Doughnut Chart</option>
						<option value="bar">Bar Chart</option>
					</select>
					<button type="submit" class="btn btn-primary btn-sm">Generate</button>
					<button type="button" class="btn btn-danger btn-sm clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>



<!-- Send Message Modal -->
<div class="modal fade effect-scale modal-blur" id="sendMessageModal" tabindex="-1" aria-labelledby="sendMessageModalLabel" style="z-index: 1029;" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="sendMessageModalLabel">
                        <i class="ri-message-2-line me-2 text-primary"></i>
                        <span id="modalTitleText">Send Message</span>
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Recipient Info Card -->
                <div class="card border mb-4">
                    <div class="card-body py-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-primary bg-opacity-10 rounded-circle me-3">
                                <i class="ri-user-line text-primary fs-4"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-0 fw-semibold" id="recipientNameDisplay">Select a recipient</h6>
                                <small class="text-muted" id="recipientInfo">No recipient selected</small>
                            </div>
                            <div class="badge bg-light text-dark" id="jobCountBadge">0 jobs</div>
                        </div>
                    </div>
                </div>
                
                <div class="rec-table">

                </div>
                <hr>

                <!-- Message Form -->
                <form method="post" id="message-form" action="SendComplianceMessage" class="needs-validation" novalidate>
                    <input id="officer_id" name="officer_id" type="hidden"/>
                    <input id="request_type" name="request_type" value="send_compliance_message" type="hidden">
                    <input id="officer_name" name="officer_name" type="hidden"/>
                    <input id="job_numbers" name="job_numbers[]" type="hidden"/>

                    <!-- Message Type -->
                    <div class="mb-4">
                        <label for="message_type" class="form-label fw-medium">
                            <i class="ri-chat-1-line me-1 text-muted"></i>
                            Message Type
                            <span class="text-danger">*</span>
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="Message type selection">
                            <input type="radio" class="btn-check" name="message_type" id="message_type_query" value="query" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="message_type_query">
                                <i class="ri-question-line me-1"></i>Query
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_message" value="message" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_message">
                                <i class="ri-message-2-line me-1"></i>Message
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_reminder" value="reminder" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_reminder">
                                <i class="ri-alarm-warning-line me-1"></i>Reminder
                            </label>
                        </div>
                        <div class="form-text">
                            <i class="ri-information-line me-1"></i>
                            Select the type of message you want to send
                        </div>
                    </div>

                    <!-- Message Content -->
                    <div class="mb-4">
                        <label for="message" class="form-label fw-medium">
                            <i class="ri-chat-quote-line me-1 text-muted"></i>
                            Message Content
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <textarea class="form-control" name="message" id="message" 
                                      rows="5" placeholder="Type your message here..." 
                                      required style="resize: none;"></textarea>
                            <span class="input-group-text bg-light align-items-start">
                                <i class="ri-pencil-line text-muted"></i>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-2">
                            <div class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Write your message to the recipient
                            </div>
                            <small class="text-muted" id="charCount">0/1000 characters</small>
                        </div>
                    </div>

                    <!-- Template Suggestions (Optional) -->
                    <div class="mb-4">
                        <label class="form-label fw-medium">
                            <i class="ri-stack-line me-1 text-muted"></i>
                            Quick Templates
                        </label>
                        <div class="d-flex flex-wrap gap-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="query">
                                <i class="ri-question-line me-1"></i>Urgent Query
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="followup">
                                <i class="ri-time-line me-1"></i>Follow-up Required
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="reminder">
                                <i class="ri-alarm-warning-line me-1"></i>TAT Reminder
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="update">
                                <i class="ri-refresh-line me-1"></i>Status Update
                            </button>
                        </div>
                    </div>

                    <!-- Preview Section -->
                    <div class="card border mb-4" id="previewCard" style="display: none;">
                        <div class="card-header bg-light">
                            <h6 class="mb-0 fw-semibold">
                                <i class="ri-eye-line me-2"></i>Message Preview
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-light border" id="messagePreview">
                                <small class="text-muted">Preview will appear here</small>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i>Cancel
                        </button>
                        <button type="reset" class="btn btn-outline-warning" id="btnResetForm">
                            <i class="ri-refresh-line me-1"></i>Reset
                        </button>
                        <button type="submit" class="btn btn-primary flex-grow-1" id="btnSubmitMessage">
                            <i class="ri-send-plane-line me-1"></i>
                            <span id="submitButtonText">Send Message</span>
                            <span class="spinner-border spinner-border-sm ms-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Cabinet Modal -->
<div class="modal fade effect-scale modal-blur" id="cabinetModal" tabindex="-1" aria-labelledby="cabinetModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="cabinetModalLabel">
                            <i class="fas fa-history me-2"></i>Application Tracking History
                        </h5>
                        <small class="opacity-75">View complete application tracking and cabinet details</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <div class="row g-4">
                    <!-- Left Column: Tracking History -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow">
                            <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-stream me-2 text-primary"></i>Tracking History
                                </h6>
                                <span class="badge bg-primary" id="historyCount">0 entries</span>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-comment me-2"></i>Comments
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-building me-2"></i>Division/Unit
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-user-tie me-2"></i>Officer
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-calendar me-2"></i>Date
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="cabinet-tracking">
                                            <!-- Tracking data will be populated here -->
                                            <tr id="noTrackingData" class="d-none">
                                                <td colspan="4" class="text-center py-5">
                                                    <div class="d-flex flex-column align-items-center">
                                                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                        <h6 class="fw-semibold mb-2">No tracking history found</h6>
                                                        <p class="text-muted small">No tracking entries available for this application</p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-light py-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="text-muted small">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Shows all tracking activities for this application
                                    </div>
                                    <button type="button" class="btn btn-sm btn-outline-primary" id="btnExportHistory">
                                        <i class="fas fa-download me-2"></i>Export
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Application Details -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow">
                            <div class="card-header bg-light py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-info-circle me-2 text-success"></i>Application Details
                                </h6>
                            </div>
                            <div class="card-body">
                                <form id="cabinetDetailsForm">
                                    <!-- Applicant Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-primary">
                                            <i class="fas fa-user-circle me-2"></i>Applicant Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_applicant_name" class="form-label fw-medium">
                                                    Applicant Name
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-user"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_applicant_name" rows="2"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_applicant_type" class="form-label fw-medium">
                                                    Application Type
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-file-alt"></i>
                                                    </span>
                                                    <input type="text" readonly class="form-control bg-light" 
                                                           id="enq_applicant_type">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Cabinet Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-success">
                                            <i class="fas fa-archive me-2"></i>Cabinet Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_cabinet_name" class="form-label fw-medium">
                                                    Cabinet/File Reference
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-hashtag"></i>
                                                    </span>
                                                    <input type="text" readonly class="form-control bg-light" 
                                                           id="enq_cabinet_name">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-warning">
                                            <i class="fas fa-tasks me-2"></i>Status Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_job_purpose" class="form-label fw-medium">
                                                    Job Purpose
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-bullseye"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_job_purpose" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_job_status" class="form-label fw-medium">
                                                    Job Status
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-spinner"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_job_status" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_current_application_status" class="form-label fw-medium">
                                                    Current Application Status
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-flag"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_current_application_status" rows="3"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quick Stats -->
                                    <div class="card border-dashed border-2 mt-4">
                                        <div class="card-body p-3">
                                            <h6 class="fw-semibold mb-3">
                                                <i class="fas fa-chart-bar me-2"></i>Quick Stats
                                            </h6>
                                            <div class="row g-2">
                                                <div class="col-6">
                                                    <div class="d-flex flex-column align-items-center p-2 bg-light rounded">
                                                        <span class="text-muted small">Tracking Entries</span>
                                                        <small class="fw-bold" id="trackingEntriesCount">0</small>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex flex-column align-items-center p-2 bg-light rounded">
                                                        <span class="text-muted small">Last Update</span>
                                                        <small class="fw-bold" id="lastUpdateDate">-</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer bg-light py-3">
                                <div class="text-muted small">
                                    <i class="fas fa-clock me-1"></i>
                                    Last refreshed: <span id="lastRefreshTime">-</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light rounded-bottom p-3">
                <!-- <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-primary me-2" id="btnRefreshCabinet">
                            <i class="fas fa-sync-alt me-2"></i>Refresh
                        </button>
                        <button type="button" class="btn btn-primary" id="btnPrintHistory">
                            <i class="fas fa-print me-2"></i>Print History
                        </button>
                    </div>
                </div> -->
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Stages Modal -->
<div class="modal fade effect-scale modal-blur" id="stagesModal" tabindex="-1" aria-labelledby="stagesModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-dark text-white">
				<h5 class="modal-title" id="stagesModallLabel">Application Tracking Thread</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div id="stagesTrackingContainer" class="w-100"></div>
			</div>
		</div>
	</div>
</div>

<!-- Replies Modal -->
<div class="modal fade effect-scale modal-blur" id="repliesModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h6 class="modal-title">Notice Replies</h6>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body" id="repliesModalBody"></div>
		</div>
	</div>
</div>






<div class="modal fade effect-scale modal-blur" id="previousNoticesModal" tabindex="-1" aria-labelledby="previousNoticesModalLabel" style="z-index: 1029;" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="previousNoticesModalLabel">
                        <i class="ri-message-2-line me-2 text-primary"></i>
                        <!-- <span id="modalTitleText">Send Message</span> -->
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
				<!-- 🕓 PREVIOUS MESSAGES SECTION -->
                <div id="previousMessages" class="mb-3">
					<h6 class="text-dark font-weight-bold mb-2">Previous Notices</h6>
					<div id="messagesContainer" class="border rounded p-2 bg-light" style="max-height: 200px; overflow-y: auto;">
						<p class="text-muted mb-0">Loading previous messages...</p>
					</div>
				</div>

                <!-- Message Form -->
                
            </div>
        </div>
    </div>
</div>
