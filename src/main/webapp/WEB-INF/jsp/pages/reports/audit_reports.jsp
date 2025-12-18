<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />

<!-- Include Chart.js and Moment.js -->
<script src="../assets/libs/chart.js/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>

<style>
    .blur-background {
        filter: blur(8px);
        transition: filter 0.3s ease;
    }
    .stat-card {
        transition: transform 0.2s;
        cursor: pointer;
        border-left: 4px solid;
    }
    .stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }
    .activity-log {
        max-height: 400px;
        overflow-y: auto;
    }
    .chart-container {
        position: relative;
        height: 300px;
        width: 100%;
    }
    .filter-section {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .drilldown-modal .modal-lg {
        max-width: 95%;
    }
    .log-details {
        background: #f8f9fa;
        border-radius: 5px;
        padding: 15px;
        margin-top: 10px;
    }
    /* Ensure chart canvas is visible */
    canvas {
        max-width: 100% !important;
        background: #fff; /* Ensure background is solid for visibility */
    }
    
    /* Enhanced color scheme */
    .card-header {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
    }
    
    .card-header h6 {
        color: white;
    }
    
  
    /* Stats card colors */
    .stat-card-1 {
        border-left-color: #4e73df;
        background: linear-gradient(135deg, #f0f5ff 0%, #e6eeff 100%);
    }
    
    .stat-card-2 {
        border-left-color: #1cc88a;
        background: linear-gradient(135deg, #f0f9f5 0%, #e6f7ef 100%);
    }
    
    .stat-card-3 {
        border-left-color: #36b9cc;
        background: linear-gradient(135deg, #f0f9fb 0%, #e6f5f9 100%);
    }
    
    .stat-card-4 {
        border-left-color: #f6c23e;
        background: linear-gradient(135deg, #fffbf0 0%, #fff9e6 100%);
    }
    
    /* Table styling */
    .table thead {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
    }
    
    .table tbody tr:hover {
        background-color: rgba(78, 115, 223, 0.05);
    }
    
    /* Button styling */
    .btn-primary {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        border: none;
    }
    
    .btn-primary:hover {
        background: linear-gradient(135deg, #3a5fc8 0%, #1a3bb5 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    /* Date filter region styling */
    .date-region {
        background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        border-left: 4px solid #2196f3;
    }
    
    .date-region h5 {
        color: #1565c0;
        margin-bottom: 15px;
    }
    
    /* Enhanced loading spinner */
    #loadingSpinner {
        background: rgba(255,255,255,0.9);
    }
</style>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Audit Trail Dashboard</h1>
        <div class="d-flex">
            <button id="refreshBtn" class="btn btn-primary mr-2">
                <i class="fas fa-sync-alt"></i> Refresh
            </button>
            <button id="btn_load_statitics_based_on_users_audit" class="btn btn-success">
                <i class="fas fa-download"></i> Export Report
            </button>
        </div>
    </div>

    <!-- Date Region with Enhanced Filters -->
    <div class="row">
        <div class="col-12">
             <input type="hidden" id="txt_unit_id_ar" name="txt_unit_id_ar" />
            <input type="hidden" id="txt_user_id_ar" name="txt_user_id_ar" />
            <div class="date-region">
                <h5><i class="fas fa-calendar-alt mr-2"></i>Date Filter Region</h5>
                <div class="row">
                    <div class="col-md-3">
                        <label for="region_id">Region</label>
                          <select id="get_change_region_compliance_ar" class="form-control" required>
                        <option selected disabled>Please Select</option>
                        <c:forEach items="${officeregionlist}" var="officeregion">
                            <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                        </c:forEach>
                    </select>
                    </div>
                     <div class="col-md-3">
                          <label>Report Type</label>
                    <select id="type_of_report_name_rpt" class="form-control">
                        <option value="individual_audit_trails">Individual Audit Trails</option>
                        <option value="Division">Division</option>
                        <option value="Unit" selected>Unit</option>
                        <option value="Staff">Staff</option>
                    </select>
                    </div>
                     <div class="col-md-3">
                         <label>Division</label>
                    <select id="unit_division_to_send_to_rpt_ar" class="form-control">
                        <option value="none">---Select Division---</option>
                        <option value="LVD">LVD</option>
                        <option value="LRD">LRD</option>
                        <option value="PVLMD">PVLMD</option>
                        <option value="SMD">SMD</option>
                        <option value="RLO">RLO</option>
                    </select>
                    </div>
                     <div class="col-md-3">
                           <label>Unit</label>
                    <input class="form-control" id="unit_to_send_to_rpt_ar" list="listofunitsbatching_rpt" placeholder="Enter Unit">
                    <datalist id="listofunitsbatching_rpt"></datalist>
                    </div>
                         <div class="col-md-3">
                            <label>User</label>
                    <input class="form-control" id="user_to_send_to_rpt_ar" list="listofusersbatching_rpt" placeholder="Enter Username">
                    <datalist id="listofusersbatching_rpt"></datalist>
                    </div>
                    <div class="col-md-6" id="customDateRange">
                          <!-- <div class="col-md-6" id="customDateRange" style="display: none;"></div> -->
                        <div class="row">
                            <div class="col-md-6">
                                <label for="startDate">Start Date</label>
                                <input type="date" class="form-control" id="start_date_ar">
                            </div>
                            <div class="col-md-6">
                                <label for="endDate">End Date</label>
                                <input type="date" class="form-control" id="end_date_ar">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="timeUnit">Group By</label>
                        <select class="form-control" id="timeUnit">
                            <option value="hour">Hour</option>
                            <option value="day" selected>Day</option>
                            <option value="week">Week</option>
                            <option value="month">Month</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Filters Section -->
    <div class="row">
        <div class="col-12">
            <div class="date-region">
                <h5><i class="fas fa-filter mr-2"></i>Additional Filters</h5>
                <div class="row">
                    <div class="col-md-4">
                        <label for="userFilter">User</label>
                        <select class="form-control" id="userFilter">
                            <option value="">All Users</option>
                            <!-- Users will be populated dynamically -->
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="activityType">Activity Type</label>
                        <select class="form-control" id="activityType">
                            <option value="">All Activities</option>
                            <option value="ACCESS">Access Logs</option>
                            <option value="ACTIVITY">Activity Logs</option>
                            <option value="ADVANCED_ACTIVITY">Advanced Activities</option>
                            <option value="TABLE_CHANGE">Table Changes</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="statusFilter">Status</label>
                        <select class="form-control" id="statusFilter">
                            <option value="">All Statuses</option>
                            <option value="SUCCESS">Success</option>
                            <option value="FAILED">Failed</option>
                            <option value="WARNING">Warning</option>
                        </select>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12 text-right">
                        <button id="applyFilters" class="btn btn-primary">
                            <i class="fas fa-filter"></i> Apply Filters
                        </button>
                        <button id="clearFilters" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Clear
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

       <div class="row">
        <!-- Example Card 1 -->
        <div class="col-xl-4 col-md-4 col-sm-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2 stat-card" data-type="leases">
                <div class="card-body">
                    <div class="row g-0 align-items-center">
                        <div class="col">
                            <div class="text-xs fw-bold text-primary text-uppercase mb-1">Total Leases</div>
                            <div id="totalActivities" class="h5 mb-0 fw-bold text-gray-800">1,245</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-file-contract fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Example Card 2 -->
        <div class="col-xl-4 col-md-4 col-sm-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2 stat-card" data-type="payments">
                <div class="card-body">
                    <div class="row g-0 align-items-center">
                        <div class="col">
                            <div class="text-xs fw-bold text-success text-uppercase mb-1">Rent Collected</div>
                            <div id="totalAccessLogs" class="h5 mb-0 fw-bold text-gray-800">GHS 820K</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-money-bill-wave fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Example Card 3 -->
        <div class="col-xl-4 col-md-4 col-sm-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2 stat-card" data-type="pending">
                <div class="card-body">
                    <div class="row g-0 align-items-center">
                        <div class="col">
                            <div class="text-xs fw-bold text-info text-uppercase mb-1">Pending Applications</div>
                            <div id="totalAdvancedActivities" class="h5 mb-0 fw-bold text-gray-800">142</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-hourglass-half fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

          

    </div>

    <!-- Statistics Cards -->
    <div class="row" id="statsCards">
        <!-- Cards will be populated by JavaScript -->
    </div>

    <!-- Charts Row -->
    <div class="row">
        <!-- Activity Trends Chart -->
        <div class="col-xl-8 col-lg-7">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold">Activity Trends</h6>
                    <div class="dropdown no-arrow">
                        <a class="dropdown-toggle" href="#" role="button" id="trendsDropdown"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-ellipsis-v fa-sm fa-fw"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                             aria-labelledby="trendsDropdown">
                            <div class="dropdown-header">Group By:</div>
                            <a class="dropdown-item" href="#" data-group="hour">Hour</a>
                            <a class="dropdown-item" href="#" data-group="day">Day</a>
                            <a class="dropdown-item" href="#" data-group="month">Month</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="activityTrendsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity Distribution Chart -->
        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold">Activity Distribution</h6>
                </div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="activityDistributionChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activities and User Summary Row -->
    <div class="row">
        <!-- Recent Activities -->
        <div class="col-xl-8 col-lg-7">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold">Recent Activities</h6>
                    <a href="#" id="viewAllActivities" class="btn btn-sm btn-primary">View All</a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="recentActivitiesTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>Timestamp</th>
                                    <th>User</th>
                                    <th>Activity Type</th>
                                    <th>Description</th>
                                    <th>IP Address</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="recentActivitiesBody">
                                <!-- Activities will be populated by JavaScript -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Top Users -->
        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold">Top Active Users</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Activities</th>
                                    <th>Last Activity</th>
                                </tr>
                            </thead>
                            <tbody id="topUsersBody">
                                <!-- Top users will be populated by JavaScript -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->

<!-- Drill-down Modal -->
<div class="modal fade" id="drilldownModal" tabindex="-1" role="dialog" aria-labelledby="drilldownModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg drilldown-modal" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="drilldownModalLabel">Activity Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="drilldownContent">
                <!-- Details will be populated by JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Loading Spinner -->
<div id="loadingSpinner" class="d-none" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(255,255,255,0.9); z-index: 9999;">
    <div class="d-flex justify-content-center align-items-center" style="height: 100%;">
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
            <span class="sr-only">Loading...</span>
        </div>
        <span class="ml-2 h4">Loading audit data...</span>
    </div>
</div>

<!-- End of Main Content -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script>


	$('#unit_division_to_send_to_rpt_ar')
							.change(
									function() {
										// alert("d");
										var selected_division = $(this).val();

										$("#unit_to_send_to_rpt_ar").val("");
										$("#get_change_region_compliance").val("");
										// $("#btn_process_batchlist").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_units',
													},
													cache : false,
													success : function(
															jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var datalist = $("#listofunitsbatching_rpt");
														datalist.empty();

														$(json_p.data)
																.each(
																		function() {
																			// console.log("Outer
																			// " +
																			// this.unit_division
																			// + "
																			// - "
																			// +
																			// this.unit_name);
																			if (this.unit_division
																					.includes(selected_division)) {
																				// console.log("Inner
																				// " +
																				// this.unit_division
																				// + "
																				// - "
																				// +
																				// this.unit_name);
																				datalist
																						.append('<option data-name="'
																								+ this.unit_name
																								+ '" data-id="'
																								+ this.unit_id
																								+ '" value="'
																								+ this.unit_name
																								+ '" ></option>');
																			}
																		});
													}
												});

									});

    $('#unit_to_send_to_rpt_ar')
							.change(
									function() {
										
										var unit_id = $(this).val();
										var region_code = $("#get_change_region_compliance_ar").val();
                                        var division_name = $("#unit_division_to_send_to_rpt_ar").val();
								    //let region_code = Math.trunc(region_code);
                                        let dataId = $('#unit_to_send_to_rpt_ar option:selected').data('id');
                                        console.log(dataId); // 46

                                        let dataname = $('#unit_to_send_to_rpt_ar option:selected').data('name');
                                        console.log(dataname); // 46

                    unit_id = unit_id.replace(".0", "");
                    region_code = region_code.replace(".0", "");



								  console.log("division_name");
                                    console.log(division_name);

                                        console.log("unit_id");
                                    console.log(unit_id);

                                        console.log("unit_id");
                                    console.log(unit_id);

                                        console.log("region_code");
                                        console.log(region_code);

										$("#user_to_send_to_rpt_ar").val("");
										
										// $("#btn_process_batchlist").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_users_rpt',
														region_code : region_code,
                                                        division_name : division_name,
                            unit_id : unit_id
													},
													cache : false,
													success : function(
															jobdetails) {

														
														var json_p = JSON
																.parse(jobdetails);
																console.log(json_p.data);
														var datalist = $("#listofusersbatching_rpt");
														datalist.empty();

														$(json_p.data)
																.each(
																		function() {
																			// if (selected_division == this.unit_name) {
																				//if (unit_id == this.unit_name) {

																				// console.log(this.division
																				// + "
																				// - "
																				// +
																				// this.userid);
																				datalist
																						.append('<option data-name="'
																								+ this.fullname
																								+ '" data-id="'
																								+ this.userid
																								+ '" value="'
																								+ this.fullname
																								+ '" ></option>');
																			//}
																		});
													}
												});

									});



            $('#unit_to_send_to_rpt_ar').on('change', function() {
            let inputVal = $(this).val(); // the text entered or selected
            let selectedOption = $('#listofunitsbatching_rpt option[value="' + inputVal + '"]');

            // Get data-id and data-name
            let unit_id = selectedOption.data('id');
            let userName = selectedOption.data('name');
            $('#txt_unit_id_ar').val(unit_id);
            if (unit_id) {
                console.log("Selected user ID:", unit_id);
                console.log("Selected user name:", userName);
            } else {
                console.log("No matching user found for:", inputVal);
            }
            });


            $('#user_to_send_to_rpt_ar').on('change', function() {
            let inputVal = $(this).val(); // the text entered or selected
            let selectedOption = $('#listofusersbatching_rpt option[value="' + inputVal + '"]');

            // Get data-id and data-name
            let user_id = selectedOption.data('id');
            let userName = selectedOption.data('name');
            $('#txt_user_id_ar').val(user_id);

            if (user_id) {
                console.log("Selected user ID:", user_id);
                console.log("Selected user name:", userName);
            } else {
                console.log("No matching user found for:", inputVal);
            }
            });



        $('#btn_load_statitics_based_on_users_audit').on('click', function(){
            
            var get_change_region_compliance_ar = $('#get_change_region_compliance_ar').val();
            var type_of_report_name_rpt = $('#type_of_report_name_rpt').val();
            var unit_division_to_send_to_rpt_ar = $('#unit_division_to_send_to_rpt_ar').val();
            // var unit_to_send_to_rpt_ar = $('#unit_to_send_to_rpt_ar').val();
            // var user_to_send_to_rpt_ar = $('#user_to_send_to_rpt_ar').val();


            var unit_to_send_to_rpt_ar = $('#txt_unit_id_ar').val();
            var user_to_send_to_rpt_ar = $('#txt_user_id_ar').val();
            

            
            var start_date_ar = $('#start_date_ar').val();
            var end_date_ar = $('#end_date_ar').val();

            get_change_region_compliance_ar =  get_change_region_compliance_ar.replace(".0", "");
            
            
            $.ajax({
            url: 'audit_reporting',
            type: 'POST',
            data: { 
                request_type: 'get_audit_dashboard_stats', 
                get_change_region_compliance_ar:get_change_region_compliance_ar,
                type_of_report_name_rpt:type_of_report_name_rpt,
                unit_division_to_send_to_rpt_ar:unit_division_to_send_to_rpt_ar,
                unit_to_send_to_rpt_ar:unit_to_send_to_rpt_ar,
                user_to_send_to_rpt_ar:user_to_send_to_rpt_ar,
                start_date_ar:start_date_ar,
                end_date_ar:end_date_ar
            },
            beforeSend: function () {
                $(this).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Processing...');
            },
            success: function (response) {
            // Parse response if it's a string (in case the server returns JSON as text)
          
          console.log(response)
            let responseObj;
            try {
                responseObj = typeof response === 'string' ? JSON.parse(response) : response;
            } catch (e) {
                alert('Invalid server response format.', 'danger');
                return;
            }

            // Handle success or failure based on response
            if (responseObj.success) {
                // Example: Updating the value of the card
               $('#totalActivities').text(responseObj.data.totalActivities);
               $('#totalAccessLogs').text(responseObj.data.totalAccessLogs);
               $('#totalAdvancedActivities').text(responseObj.data.totalAdvancedActivities);

               // alert(responseObj.msg || 'Rent data processed and exported successfully!', 'success');
               // loadRentData(); // Reload DataTable on success
            } else {
                alert(responseObj.msg || 'Failed to process rent data.', 'danger');
            }
        },
            error: function (xhr) {
                alert('Processing failed: ' + (xhr.responseText || 'Server error'), 'danger');
            },
            complete: function () {
                $(this).prop('disabled', false).html('<i class="fas fa-cogs"></i> Process Rent Data');
            }
        });
        });


    let modalMap, modalMarker;

    // Initialize Modal Map
    function initModalMap() {
        modalMap = L.map('modalMap').setView([7.9465, -1.0232], 7);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(modalMap);
    }

    // Clear Modal Map
    function clearModalMap() {
        if (modalMarker) modalMap.removeLayer(modalMarker);
        modalMap.eachLayer(l => {
            if (l instanceof L.Polygon || l instanceof L.Marker) modalMap.removeLayer(l);
        });
    }



    // Plot on Modal Map
    function plotOnModalMap(original, changes) {
        clearModalMap();
        try {
            const o = JSON.parse(original);
            const c = JSON.parse(changes);
            const geom = c.geometry || o.geometry;
            if (geom && geom.coordinates) {
                const coords = geom.coordinates;
                if (geom.type === 'Point') {
                    modalMarker = L.marker([coords[1], coords[0]]).addTo(modalMap)
                        .bindPopup('Parcel Location').openPopup();
                    modalMap.setView([coords[1], coords[0]], 16);
                } else if (geom.type === 'Polygon') {
                    const poly = L.polygon(coords[0].map(c => [c[1], c[0]])).addTo(modalMap);
                    modalMap.fitBounds(poly.getBounds());
                }
            }
        } catch (e) {
            console.log("No geometry to plot");
        }
    }

    // Update Modal JSON
    function updateModalJson(original, changes) {
        try {
            const o = typeof original === 'string' ? JSON.parse(original) : original;
            const c = typeof changes === 'string' ? JSON.parse(changes) : changes;
            $('#originalJsonModal').text(JSON.stringify(o, null, 2));
            $('#changesJsonModal').text(JSON.stringify(c, null, 2));
        } catch (e) {
            $('#originalJsonModal').text(original);
            $('#changesJsonModal').text(changes);
        }
    }

    // Open Modal on View Click
    $(document).on('click', '.view-json', function() {
        const original = $(this).data('original') || '{}';
        const changes = $(this).data('changes') || '{}';

        updateModalJson(original, changes);
        plotOnModalMap(original, changes);

        // Show modal and activate JSON tab by default
        $('#detailModal').modal('show');
        $('#json-tab-modal').tab('show');
    });

    // Update Stats
    function updateStats(data) {
        const counts = { add:0, update:0, delete:0, insert:0 };
        data.forEach(r => {
            const op = (r.operation_type || '').toLowerCase();
            if (op.includes('add') || op.includes('insert')) counts.add++;
            else if (op.includes('update')) counts.update++;
            else if (op.includes('delete')) counts.delete++;
            else if (op.includes('insert')) counts.insert++;
        });
        $('#stat-add').text(counts.add);
        $('#stat-update').text(counts.update);
        $('#stat-delete').text(counts.delete);
        $('#stat-insert').text(counts.insert);
    }

    // Load Report
    function loadAuditReport() {
        const filters = {
            region: $('#get_change_region_compliance').val(),
            reportType: $('#type_of_report_name_rpt').val(),
            division: $('#unit_division_to_send_to_rpt_ar').val(),
            unit: $('#unit_to_send_to_rpt_ar').val(),
            user: $('#user_to_send_to_rpt_ar').val()
        };

        $.post('${pageContext.request.contextPath}/audit-report-servlet', filters, function(resp) {
            const data = resp.data || [];
            const tbl = $('#auditTable').DataTable();
            tbl.clear();

            data.forEach(row => {
                tbl.row.add([
                    row.log_date || '',
                    row.dog_type || '',
                    row.operation_type || '',
                    row.description || '',
                    row.ip_address || '',
                    row.table_name || '',
                   
                ]);
            });
            tbl.draw();
            updateStats(data);
        }).fail(() => alert('Failed to load report'));
    }

    // Escape HTML to prevent JS injection
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

   
        $('#btn_generate_details_based_on_users_audit').on('click', function(){
            alert('CSV download – implement server-side export');
        });

    // Initialize
    $(function() {
        $('#auditTable').DataTable({ pageLength:10, responsive:true });
        initModalMap();

    
        $('#btn_generate_details_based_on_users_csv_audit').on('click', function(){
            alert('CSV download – implement server-side export');
        });

        // Re-init map when modal is shown
        $('#detailModal').on('shown.bs.modal', function () {
            setTimeout(() => modalMap.invalidateSize(), 100);
        });
    });
</script>
<script>
    // Global variables
    let activityTrendsChart = null;
    let activityDistributionChart = null;
    let currentFilters = {
        dateRange: '7',
        startDate: null,
        endDate: null,
        userId: '',
        activityType: ''
    };

    // Document ready function
    $(document).ready(function() {
        //initializeDashboard();
       // setupEventListeners();
        loadInitialData();
    });

    function initializeDashboard() {
        // Initialize date fields
        const today = new Date().toISOString().split('T')[0];
        $('#endDate').val(today);
        $('#startDate').val(new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]);
    }

    function setupEventListeners() {
        // Date range change
        $('#dateRange').change(function() {
            if ($(this).val() === 'custom') {
                $('#customDateRange').show();
            } else {
                $('#customDateRange').hide();
            }
        });

        // Apply filters
        $('#applyFilters').click(applyFilters);

        // Clear filters
        $('#clearFilters').click(clearFilters);

        // Refresh button
        $('#refreshBtn').click(loadInitialData);

        // Export button
        $('#exportBtn').click(exportReport);

        // Trends chart grouping
        $('.dropdown-item[data-group]').click(function(e) {
            e.preventDefault();
            const groupBy = $(this).data('group');
            loadActivityTrends(groupBy);
        });

        // View all activities
        $('#viewAllActivities').click(function(e) {
            e.preventDefault();
            loadAllActivities();
        });

        // Stats card click for drill-down
        $(document).on('click', '.stat-card', function() {
            const cardType = $(this).data('type');
            drillDownByType(cardType);
        });
    }

    function applyFilters() {
        currentFilters = {
            dateRange: $('#dateRange').val(),
            startDate: $('#startDate').val(),
            endDate: $('#endDate').val(),
            userId: $('#userFilter').val(),
            activityType: $('#activityType').val()
        };
        loadDashboardData();
    }

    function clearFilters() {
        $('#dateRange').val('7');
        $('#userFilter').val('');
        $('#activityType').val('');
        $('#customDateRange').hide();
        applyFilters();
    }

    function loadInitialData() {
        showLoading();
         loadDashboardStats(),
            loadActivityTrends('day'),
            loadRecentActivities(),
            loadTopUsers(),
            loadUserFilterOptions()
       hideLoading();
        // Promise.all([
          
        // ]).finally(hideLoading);
    }

    function loadDashboardData() {
        showLoading();
        Promise.all([
            loadDashboardStats(),
            loadActivityTrends('day'),
            loadRecentActivities(),
            loadTopUsers()
        ]).finally(hideLoading);
    }

    function loadDashboardStats() {
        return new Promise((resolve, reject) => {
            const params = buildFilterParams();
            
            // This would be your actual AJAX call to backend
            // For now, using mock data
            const mockStats = {
                total_activities: 1247,
                total_access_logs: 543,
                total_advanced_activities: 289,
                total_table_changes: 415,
                unique_users: 23,
                most_active_user: 'john.doe',
                most_active_table: 'usr_users',
                recent_activity: new Date().toISOString()
            };
            
            renderStatsCards(mockStats);
            resolve();
            
         // Actual implementation would be:
            $.ajax({
                url: 'audit_reporting',
            type: 'POST',
            data: { 
                request_type: 'get_audit_dashboard_stats', 
                region:11,
                jsonData: JSON.stringify(jsonData) // Optionally send JSON to server
            },
                success: function(response) {
                    //renderStatsCards(response);
                   // resolve();
                },
                error: function(xhr, status, error) {
                    console.error('Error loading dashboard stats:', error);
                    showError('Failed to load dashboard statistics');
                    reject(error);
                }
            });
            
        });
    }

    function buildFilterParams() {
        const params = {};
        
        if (currentFilters.dateRange === 'custom') {
            if (currentFilters.startDate) params.startDate = currentFilters.startDate;
            if (currentFilters.endDate) params.endDate = currentFilters.endDate;
        } else {
            const days = parseInt(currentFilters.dateRange);
            params.startDate = new Date(Date.now() - days * 24 * 60 * 60 * 1000).toISOString();
        }
        
        if (currentFilters.userId) params.userId = currentFilters.userId;
        if (currentFilters.activityType) params.activityType = currentFilters.activityType;
        
        return params;
    }

    function renderStatsCards(stats) {
        const cards = [
            {
                title: 'Total Activities',
                value: stats.total_activities.toLocaleString(),
                icon: 'fa-chart-line',
                color: 'primary',
                type: 'all'
            },
            {
                title: 'Access Logs',
                value: stats.total_access_logs.toLocaleString(),
                icon: 'fa-sign-in-alt',
                color: 'success',
                type: 'access'
            },
            {
                title: 'Advanced Activities',
                value: stats.total_advanced_activities.toLocaleString(),
                icon: 'fa-tasks',
                color: 'info',
                type: 'advanced'
            },
            {
                title: 'Table Changes',
                value: stats.total_table_changes.toLocaleString(),
                icon: 'fa-database',
                color: 'warning',
                type: 'table_changes'
            },
            {
                title: 'Unique Users',
                value: stats.unique_users.toLocaleString(),
                icon: 'fa-users',
                color: 'secondary',
                type: 'users'
            },
            {
                title: 'Most Active User',
                value: stats.most_active_user,
                icon: 'fa-user',
                color: 'dark',
                type: 'active_user'
            }
        ];

        const cardsHtml = cards.map(card => `
            <div class="col-xl-2 col-md-4 col-sm-6 mb-4">
                <div class="card border-left-${card.color} shadow h-100 py-2 stat-card" data-type="${card.type}">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-${card.color} text-uppercase mb-1">
                                    ${card.title}
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${card.value}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas ${card.icon} fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `).join('');

        $('#statsCards').html(cardsHtml);
    }

    function loadActivityTrends(groupBy) {
        // Implementation for loading activity trends chart
        console.log('Loading activity trends with group by:', groupBy);
        // Similar AJAX call structure as loadDashboardStats
    }

    function loadRecentActivities() {
        // Implementation for loading recent activities table
        console.log('Loading recent activities');
        // Similar AJAX call structure
    }

    function loadTopUsers() {
        // Implementation for loading top users
        console.log('Loading top users');
        // Similar AJAX call structure
    }

    function loadUserFilterOptions() {
        // Implementation for loading user filter dropdown
        console.log('Loading user filter options');
        // Similar AJAX call structure
    }

    function loadAllActivities() {
        // Implementation for loading all activities in a new page/modal
        console.log('Loading all activities');
    }

    function drillDownByType(type) {
        // Implementation for drill-down functionality
        console.log('Drill down by type:', type);
        // This would open the drilldown modal with filtered data
    }

    function exportReport() {
        // Implementation for exporting report
        console.log('Exporting report');
        // This would generate and download a report
    }

    function showLoading() {
        $('#loadingSpinner').removeClass('d-none');
        $('.container-fluid').addClass('blur-background');
    }

    function hideLoading() {
        $('#loadingSpinner').addClass('d-none');
        $('.container-fluid').removeClass('blur-background');
    }

    function showError(message) {
        // Implementation for showing error messages
        console.error('Error:', message);
        // You could use toastr or similar library here
    }

    // audit_report.js - Additional functionality for audit dashboard

// Chart initialization and management
const ChartManager = {
    initActivityTrendsChart: function(canvasId, data) {
        const ctx = document.getElementById(canvasId).getContext('2d');
        return new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels,
                datasets: [{
                    label: 'Access Logs',
                    data: data.accessLogs,
                    borderColor: '#1cc88a',
                    backgroundColor: 'rgba(28, 200, 138, 0.1)',
                    fill: true
                }, {
                    label: 'Activity Logs',
                    data: data.activityLogs,
                    borderColor: '#36b9cc',
                    backgroundColor: 'rgba(54, 185, 204, 0.1)',
                    fill: true
                }, {
                    label: 'Advanced Activities',
                    data: data.advancedActivities,
                    borderColor: '#f6c23e',
                    backgroundColor: 'rgba(246, 194, 62, 0.1)',
                    fill: true
                }, {
                    label: 'Table Changes',
                    data: data.tableChanges,
                    borderColor: '#e74a3b',
                    backgroundColor: 'rgba(231, 74, 59, 0.1)',
                    fill: true
                }]
            },
            options: {
                maintainAspectRatio: false,
                scales: {
                    x: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Time Period'
                        }
                    },
                    y: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Number of Activities'
                        },
                        beginAtZero: true
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
    },

    initActivityDistributionChart: function(canvasId, data) {
        const ctx = document.getElementById(canvasId).getContext('2d');
        return new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: data.labels,
                datasets: [{
                    data: data.values,
                    backgroundColor: [
                        '#1cc88a',
                        '#36b9cc',
                        '#f6c23e',
                        '#e74a3b'
                    ],
                    hoverBackgroundColor: [
                        '#17a673',
                        '#2c9faf',
                        '#dda20a',
                        '#be2617'
                    ]
                }]
            },
            options: {
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom'
                    }
                }
            }
        });
    },

    destroyChart: function(chart) {
        if (chart) {
            chart.destroy();
        }
    }
};

// Data formatter utilities
const Formatter = {
    formatDate: function(dateString) {
        const date = new Date(dateString);
        return date.toLocaleString();
    },

    formatActivityType: function(type) {
        const types = {
            'ACCESS': 'Access Log',
            'ACTIVITY': 'Activity',
            'ADVANCED_ACTIVITY': 'Advanced Activity',
            'TABLE_CHANGE': 'Table Change'
        };
        return types[type] || type;
    },

    truncateText: function(text, maxLength = 50) {
        if (text && text.length > maxLength) {
            return text.substring(0, maxLength) + '...';
        }
        return text;
    }
};

// Export functionality
const ExportManager = {
    exportToCSV: function(data, filename) {
        // Implementation for CSV export
        console.log('Exporting to CSV:', filename);
    },

    exportToPDF: function(data, filename) {
        // Implementation for PDF export
        console.log('Exporting to PDF:', filename);
    },

    exportToExcel: function(data, filename) {
        // Implementation for Excel export
        console.log('Exporting to Excel:', filename);
    }
};

// Drill-down functionality
const DrillDownManager = {
    showActivityDetails: function(activityId, sourceTable) {
        // Implementation for showing activity details in modal
        console.log('Showing details for activity:', activityId, 'from table:', sourceTable);
        
        // This would make an AJAX call to get detailed information
        // and populate the drilldown modal
    },

    loadFilteredActivities: function(filters) {
        // Implementation for loading filtered activities based on drill-down
        console.log('Loading filtered activities:', filters);
    }
};

// Error handling
const ErrorHandler = {
    showToast: function(message, type = 'error') {
        // Implementation for showing toast notifications
        console[type === 'error' ? 'error' : 'log']('Toast:', message);
    },

    handleAjaxError: function(xhr, context) {
        let message = 'An error occurred';
        if (xhr.responseJSON && xhr.responseJSON.message) {
            message = xhr.responseJSON.message;
        }
        this.showToast(`${context}: ${message}`, 'error');
    }
};
</script>
