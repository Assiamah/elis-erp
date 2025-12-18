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

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->

<script src="../assets/libs/chart.js/Chart.min.js"></script>


<style>
    /* Previous CSS styles remain exactly the same */
	.card:hover {
        transform: translateY(-10px); /* Moves the card slightly up */
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Stronger shadow on hover */
    }   .card {
    
        border-radius: 15px !important; /* Ensures rounded edges */
        overflow: hidden; /* Ensures child elements follow the border-radius */
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    
    
        
        /* border-radius: 15px; Increased for smoother rounded edges */
        /* border-radius: 5px; */
        -webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
        box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
        border: none;
        margin-bottom: 30px;
        -webkit-transition: all 0.3s ease-in
    }

        .bg-c-blue {
        background: linear-gradient(135deg, #3a7bd5, #3a6073);
        color: white;
    }
    
    .bg-c-green {
        background: linear-gradient(135deg, #A8E063, #56AB2F); /* Lime green to deep leaf green */
        color: white;
    }
    
    .bg-c-yellow {
        background: linear-gradient(135deg, #ffb347, #ffcc33);
        color: white;
    }
    
    .bg-c-pink {
    background: linear-gradient(135deg, #ff4d4d, #b30000); /* Lighter to deeper red */
        color: white;
    }
        .bg-c-completed {
        background: linear-gradient(135deg, #4CAF50, #2E8B57); /* Lighter to deeper green */
        color: white;
    }
     .dashboard-subtitle {
      color: #6c757d;
        font-size: 1.0rem;
    }
     .dashboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e3e6f0;
    }

     @media (max-width: 768px) {
        .dashboard-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .quick-actions {
            flex-direction: column;
        }
    }
    .text-success {
  color: #2E8B57 !important;
}
#send_message {
  transition: all 0.2s ease-in-out;
}

#send_message:hover {
  transform: translateY(-2px);
  box-shadow: 0 0.5rem 1rem rgba(0, 123, 255, 0.25);
}

</style>

<!-- Begin Page Content -->
<div class="container-fluid">

    <div class="dashboard-header">
        <div>
           <h1 class="h3 mb-1 text-gray-800 dashboard-title">Executive Management Dashboard</h1>
<p class="dashboard-subtitle">
    This Dashboard provides a strategic overview of key operational metrics and performance indicators. 
    It enables management to monitor application trends, assess divisional efficiency, and make data-driven decisions 
    that enhance performance and service delivery.
</p>
        </div>

        
        
    </div>

              <input type="hidden" id = "startdate">
			  <input type="hidden" id = "start_date">
			  <input type="hidden" id = "enddate">
			  <input type="hidden" id = "end_date">

    <!-- Page Heading -->
    

    


    <div class="row row-cols-5">
    <!-- Applications Received -->
    <div class="col mb-6">
        <div class="card bg-c-blue shadow h-100 py-2" data-toggle="tooltip" 
     title="All Applications Received">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Applications Received (All Time)</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="alltime-app-received" data-target="1842">0</div>
                        <!-- <div class="mt-2 mb-0 text-muted text-xs">
                            <span class="text-white mr-2">
  <i class="fas fa-arrow-up"></i> 
  <span id="recieved_percentage"></span>
</span>
<span class="text-white">vs last year</span>
                        </div> -->
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-file-import fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Applications Pending -->
    
    

    <!-- Applications Completed -->
    <div class="col mb-6">
        <div class="card bg-c-green shadow h-100 py-2"  data-toggle="tooltip" 
     title="All Applications Completed.">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Completed (All Time)</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="alltime-app-completed" data-target="1156">0</div>
                        <!-- <div class="mt-2 mb-0 text-muted text-xs">
                            <span class="text-white mr-2"><i class="fas fa-arrow-up" id="completed_percentage"></i> 15%</span>
                            <span class="text-white">vs last year</span>
                        </div> -->
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-check-circle fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>



 

</div>

<hr>


   


               
                <div class="row">
                    
				
                    <div class="col-sm-4">
                        <div class="card">
                          <div class="card-body">
                              <label for="">Date From</label> 
                              <input type="text" id="datefrom" class="form-control"  placeholder="Select Date Range">
                              <!-- <div id="reportrange" style="background: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 80%">
                                <i class="fa fa-calendar"></i>&nbsp;
                                <span></span> <i class="fa fa-caret-down"></i>
                            </div> -->
                          </div>
                        </div>
                      </div>


                      <div class="col-sm-4">
                        <div class="card">
                          <div class="card-body">
                              <label for="">Date To</label> 
                              <input type="text" id="dateto" class="form-control"  placeholder="Select Date Range">
                              <!-- <div id="reportrange" style="background: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 80%">
                                <i class="fa fa-calendar"></i>&nbsp;
                                <span></span> <i class="fa fa-caret-down"></i>
                            </div> -->
                          </div>
                        </div>
                      </div>

                      </div>
                


                <hr>



    <!-- Filter Row -->
    <!-- Previous filter row HTML remains exactly the same -->

    <!-- Key Metrics Summary -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card shadow mb-4 loaded">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-primary">
                    <h6 class="m-0 font-weight-bold text-white">Applications Summary - <span id="displayDateRange"><span></h6>
                    <!-- Dropdown menu remains the same -->
                </div>
                <div class="card-body position-relative">
                    <!-- <div class="loadingoverlay" id="metrics-loading">
                        <div class="spinner-border text-primary" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div> -->
<div class="row row-cols-5">
    <!-- Applications Received -->
    <div class="col mb-4" id="received_apps">
        <div class="card bg-c-blue shadow h-100 py-2" data-toggle="tooltip" 
     title="Applications Received within the selected date range.">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Received</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="app-received" data-target="1842">0</div>
                        <!-- <div class="mt-2 mb-0 text-muted text-xs">
                            <span class="text-white mr-2">
  <i class="fas fa-arrow-up"></i> 
  <span id="recieved_percentage"></span>
</span>
<span class="text-white">vs last year</span>
                        </div> -->
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-file-import fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Applications Pending -->
    <div class="col mb-4" id="pending_apps">
        <div class="card bg-c-yellow shadow h-100 py-2" data-toggle="tooltip" 
         title="Applications Pending within the selected date range.">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Pending</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="app-pending" data-target="527">0</div>
                        <!-- <div class="mt-2 mb-0 text-muted text-xs">
                            <span class="text-white mr-2"><i class="fas fa-arrow-down" id="pending_percentage"></i> 8%</span>
                            <span class="text-white">vs last year</span>
                        </div> -->
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-hourglass-half fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


        <!-- Applications Received & Completed -->
    <div class="col mb-4" id="received_completed_apps">
        <div class="card bg-c-completed shadow h-100 py-2" data-toggle="tooltip" 
     title="Applications both received and completed within the selected date range.">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Recieved & Completed</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="app-received-completed" data-target="159">0</div>
                        <!-- <div class="mt-2 mb-0 text-muted text-xs">
                            <span class="text-white mr-2"><i class="fas fa-arrow-down" id="recievedcompleted_percentage"></i> 5%</span>
                            <span class="text-white">vs last year</span>
                        </div> -->
                    </div>
                    <div class="col-auto">
                        <i class="fa fa-calendar-check f-right fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    <!-- Applications Completed -->
    <div class="col mb-4" id="completed_apps">
        <div class="card bg-c-green shadow h-100 py-2"  data-toggle="tooltip" 
     title="Applications completed within the selected date range but received earlier.">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Completed</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="app-completed" data-target="1156">0</div>
                        <!-- <div class="mt-2 mb-0 text-muted text-xs">
                            <span class="text-white mr-2"><i class="fas fa-arrow-up" id="completed_percentage"></i> 15%</span>
                            <span class="text-white">vs last year</span>
                        </div> -->
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-check-circle fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <!-- Applications Queried -->
     <div class="col mb-4" id="pastdue_apps">
        <div class="card bg-c-pink shadow h-100 py-2" data-toggle="tooltip" 
     title="Applications Pastdue within the selected date range.">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Past Due Date</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="app-pastdue" data-target="159">0</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-question-circle fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div> 


    <!-- <div class="col mb-4" id="queried_apps">
        <div class="card bg-c-pink shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Applications Queried</div>
                        <div class="h5 mb-0 font-weight-bold text-white-800 counter" id="app-queried" data-target="159">0</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-question-circle fa-2x text-white-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div> -->

</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Monthly Trends Section -->
    <div class="row mb-4">
<div class="col-lg-9" data-toggle="tooltip" 
     title="This section displays the Top 5 Service Distribution Chart and Statuses within the selected date range.">
    <div class="card shadow mb-4 loaded">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-info">
            <h6 class="m-0 font-weight-bold text-white">Top Services Trend</h6>
            <!-- Chart Options Dropdown -->
            <div class="dropdown no-arrow">
                <a class="dropdown-toggle" href="#" role="button" id="trendDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-ellipsis-v fa-sm fa-fw text-white"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="trendDropdownMenuLink">
                    <div class="dropdown-header">Chart Options:</div>
                    <!-- <a class="dropdown-item" href="#" id="toggle-line"><i class="fas fa-chart-line mr-2"></i>Line Chart</a> -->
                    <!-- <a class="dropdown-item" href="#" id="toggle-bar"><i class="fas fa-chart-bar mr-2"></i>Bar Chart</a> -->
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#" id="export-trend-chart"><i class="fas fa-download mr-2"></i>Export as PNG</a>
                </div>
            </div>
        </div>
        <div class="card-body position-relative">
            <!-- <div class="loadingoverlay" id="trend-loading">
                <div class="spinner-border text-info" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div> -->
            <div class="chart-container" id="monthlyTrendContainer" style="height: 300px;">
                <canvas id="monthlyTrendChart"></canvas>
            </div>
            <!-- <div style="position: relative; height: 60vh; width: 100%;">
    <canvas id="monthlyTrendChart"></canvas>
</div> -->

        </div>
    </div>
</div>

		<div class="col-lg-3" data-toggle="tooltip" 
     title="This chart illustrates the distribution of application statuses within the chosen date range, providing an overview of operational progress.">
			<div class="card shadow mb-4 loaded">
				<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-success">
					<h6 class="m-0 font-weight-bold text-white">Status Distribution</h6>
					<div class="dropdown no-arrow">
						<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-ellipsis-v fa-sm fa-fw text-white"></i>
						</a>
						<div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
							<div class="dropdown-header">Chart Options:</div>
							<a class="dropdown-item" href="#" id="toggle-doughnut"><i class="fas fa-chart-pie mr-2"></i>Doughnut</a>
							<a class="dropdown-item" href="#" id="toggle-pie"><i class="fas fa-circle-notch mr-2"></i>Pie</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#" id="export-pie-chart"><i class="fas fa-download mr-2"></i>Export Image</a>
						</div>
					</div>
				</div>
				<div class="card-body position-relative">
					<!-- <div class="loadingoverlay" id="pie-loading" style="display: none;">
						<div class="spinner-border text-success" role="status">
							<span class="sr-only">Loading...</span>
						</div>
					</div> -->
					<div class="chart-container" id="statusPieContainer" style="height: 300px;">
						<canvas id="statusPieChart"></canvas>
					</div>
					<!-- <div class="mt-4 text-center small">
						<span class="mr-3">
							<i class="fas fa-circle text-primary"></i> Received (42%)
						</span>
						<span class="mr-3">
							<i class="fas fa-circle text-warning"></i> Pending (23%)
						</span>
						<span class="mr-3">
							<i class="fas fa-circle text-success"></i> Completed (31%)
						</span>
						<span class="mr-3">
							<i class="fas fa-circle text-danger"></i> Queried (4%)
						</span>
					</div> -->
				</div>
			</div>
		</div>

    </div>

    <!-- Division Performance -->
    <div class="row mb-4">
        <div class="col-12"  data-toggle="tooltip" 
     title="This Section illustrates the distribution of application statuses within the chosen date range by divisions.">
            <div class="card shadow mb-4 loaded">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-primary">
                    <h6 class="m-0 font-weight-bold text-white">Division Performance</h6>
                    <!-- Dropdown menu remains the same -->
                </div>
                <div class="card-body position-relative">
                    <!-- <div class="loadingoverlay" id="division-loading">
                        <div class="spinner-border text-primary" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div> -->
                    <div class="row">
                        <!-- PVLMD Division -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 division-card">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-light">
                                    <h6 class="m-0 font-weight-bold text-primary">PVLMD</h6>
                                    <i class="fas fa-landmark text-primary"></i>
                                    
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-3">
                                        <div class="h5 mb-0 font-weight-bold text-gray-800 counter" id="pvlmdtotal_rec" data-target="642">0</div>
                                        <small class="text-muted">Total Applications</small>
                                    </div>

                                                                <div class="progress progress-thin mb-3">
                                <div id="pvlmdPendingBar" class="progress-bar" role="progressbar"
                                    style="width:0%; background-color:#ff4d4d;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                    0%
                                </div>
                                <div id="pvlmdCompletedBar" class="progress-bar" role="progressbar"
                                    style="width:0%; background-color:#2E8B57;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                    0%
                                </div>
                            </div>
                                                                
                                    <div class="row text-center">
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase">Pending</div>
                                            <div class="h6 mb-0 text-gray-800 counter" id="pvlmdtotal_pending" data-target="141">0</div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-success text-uppercase">Completed</div>
                                            <div class="h6 mb-0 text-gray-800 counter" id="pvlmdtotal_completed" data-target="501">0</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-light">
                                    <small class="text-muted">Last updated: <fmt:formatDate value="${now}" pattern="hh:mm a" /></small>
                                </div>
                            </div>
                        </div>

                        <!-- LRD Division -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 division-card">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-light">
                                    <h6 class="m-0 font-weight-bold text-success">LRD</h6>
                                    <i class="fas fa-map-marked-alt text-success"></i>
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-3">
                                        <div class="h5 mb-0 font-weight-bold text-gray-800 counter" id="lrdtotal_rec" data-target="587">0</div>
                                        <small class="text-muted">Total Applications</small>
                                    </div>

                                    <!-- <div class="progress progress-thin mb-3">
                                        <div class="progress-bar bg-danger" role="progressbar" style="width:31%" aria-valuenow="31" aria-valuemin="0" aria-valuemax="100"></div>
                                        <div class="progress-bar bg-success" role="progressbar" style="width:69%" aria-valuenow="69" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div> -->



                                    <div class="progress progress-thin mb-3">
                                        <div id="lrdPendingBar" class="progress-bar" role="progressbar"
                                            style="width:0%; background-color:#ff4d4d;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            0%
                                        </div>
                                        <div id="lrdCompletedBar" class="progress-bar" role="progressbar"
                                            style="width:0%; background-color:#2E8B57;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            0%
                                        </div>
                                    </div>

                                    <div class="row text-center">
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase">Pending</div>
                                            <div class="h6 mb-0 text-gray-800 counter"  id="lrdtotal_pending"  data-target="182">0</div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-success text-uppercase">Completed</div>
                                            <div class="h6 mb-0 text-gray-800 counter" id="lrdtotal_completed"  data-target="405">0</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-light">
                                    <small class="text-muted">Last updated: <fmt:formatDate value="${now}" pattern="hh:mm a" /></small>
                                </div>
                            </div>
                        </div>

                        <!-- LVD Division -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 division-card">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-light">
                                    <h6 class="m-0 font-weight-bold text-info">LVD</h6>
                                    <i class="fas fa-file-contract text-info"></i>
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-3">
                                        <div class="h5 mb-0 font-weight-bold text-gray-800 counter" id="lvdtotal_rec" data-target="423">0</div>
                                        <small class="text-muted">Total Applications</small>
                                    </div>


                                        <div class="progress progress-thin mb-3">
                                        <div id="lvdPendingBar" class="progress-bar" role="progressbar"
                                            style="width:0%; background-color:#ff4d4d;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            0%
                                        </div>
                                        <div id="lvdCompletedBar" class="progress-bar" role="progressbar"
                                            style="width:0%; background-color:#2E8B57;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            0%
                                        </div>
                                    </div>

                                    
                                    <div class="row text-center">
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase">Pending</div>
                                            <div class="h6 mb-0 text-gray-800 counter"  id="lvdtotal_pending" data-target="161">0</div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-success text-uppercase">Completed</div>
                                            <div class="h6 mb-0 text-gray-800 counter" id="lvdtotal_completed"  data-target="262">0</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-light">
                                    <small class="text-muted">Last updated: <fmt:formatDate value="${now}" pattern="hh:mm a" /></small>
                                </div>
                            </div>
                        </div>

                        <!-- SMD Division -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 division-card">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-light">
                                    <h6 class="m-0 font-weight-bold text-warning">SMD</h6>
                                    <i class="fas fa-search-location text-warning"></i>
                                </div>
                                <div class="card-body">
                                    <div class="text-center mb-3">
                                        <div class="h5 mb-0 font-weight-bold text-gray-800 counter" id="smdtotal_rec" data-target="290">0</div>
                                        <small class="text-muted">Total Applications</small>
                                    </div>

                                         <div class="progress progress-thin mb-3">
                                        <div id="smdPendingBar" class="progress-bar" role="progressbar"
                                            style="width:0%; background-color:#ff4d4d;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            0%
                                        </div>
                                        <div id="smdCompletedBar" class="progress-bar" role="progressbar"
                                            style="width:0%; background-color:#2E8B57;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            0%
                                        </div>
                                    </div>

                                    
                                    <div class="row text-center">
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase">Pending</div>
                                            <div class="h6 mb-0 text-gray-800 counter"  id="smdtotal_pending" data-target="43">0</div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-xs font-weight-bold text-success text-uppercase">Completed</div>
                                            <div class="h6 mb-0 text-gray-800 counter" id="smdtotal_completed"  data-target="247">0</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-light">
                                    <small class="text-muted">Last updated: <fmt:formatDate value="${now}" pattern="hh:mm a" /></small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Regional Performance -->
    <div class="row">
          <!-- <div class="col-lg-6 mb-4" id="pending_received_apps"> -->
  <div class="col-lg-12 mb-4" data-toggle="tooltip" 
     title="Displays a comparative analysis of applications received, pending, and completed across all regions within the selected date range.">
    <div class="card shadow mb-4 loaded">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-info">
            <h6 class="m-0 font-weight-bold text-white">Regional Applications Received Vrs Pending Vrs Completed</h6>
            <div class="dropdown no-arrow">
                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-ellipsis-v fa-sm fa-fw text-white"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink2">
                    <div class="dropdown-header">Chart Options:</div>
                    <a class="dropdown-item" href="#" id="export-regional-png"><i class="fas fa-download mr-2"></i>Export PNG</a>
                    <a class="dropdown-item" href="#" id="export-regional-pdf"><i class="fas fa-file-pdf mr-2"></i>Export PDF</a>
                </div>
            </div>
        </div>
        <div class="card-body position-relative">
            <!-- <div class="loadingoverlay" id="regional-received-loading">
                <div class="spinner-border text-secondary" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div> -->
            <div class="chart-container" id="regionalReceivedContainer" style="height: 300px;">
                <canvas id="regionalReceivedChart"></canvas>
            </div>
        </div>
    </div>

</div>


 <!-- <div class="col-lg-6 mb-4" id="com_received_apps"> -->
 <!-- <div class="col-lg-6 mb-4">
    <div class="card shadow mb-4 loaded">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-info">
            <h6 class="m-0 font-weight-bold text-white">Regional Applications Completed</h6>
            <div class="dropdown no-arrow">
                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-ellipsis-v fa-sm fa-fw text-white"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink3">
                    <div class="dropdown-header">Chart Options:</div>
                    <a class="dropdown-item" href="#" id="export-completed-png"><i class="fas fa-download mr-2"></i>Export PNG</a>
                    <a class="dropdown-item" href="#" id="export-completed-pdf"><i class="fas fa-file-pdf mr-2"></i>Export PDF</a>
                </div>
            </div>
        </div>
        <div class="card-body position-relative">
            
            <div class="chart-container" id="regionalCompletedContainer" style="height: 300px;">
                <canvas id="regionalCompletedChart"></canvas>
            </div>
        </div>
    </div>
</div> -->

    </div>

    <!-- Recent Activity -->
    <!-- <div class="row">
        <div class="col-12">
            <div class="card shadow mb-4 loaded">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-gradient-primary">
                    <h6 class="m-0 font-weight-bold text-white">Recent Activity</h6>
                </div>
                <div class="card-body position-relative">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover table-sm" id="recentActivityTable" width="100%" cellspacing="0">
                            <thead class="thead-light">
                                <tr>
                                    <th>Timestamp</th>
                                    <th>Activity</th>
                                    <th>Application ID</th>
                                    <th>Division</th>
                                    <th>Region</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>New Application Received</td>
                                    <td>PVLMDGAR1321212025</td>
                                    <td>PVLMD</td>
                                    <td>Greater Accra</td>
                                    <td><span class="badge badge-primary">Received</span></td>
                                </tr>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>Application Completed</td>
                                    <td>LRDAS3232122025</td>
                                    <td>LRD</td>
                                    <td>Ashanti</td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>Application Queried</td>
                                    <td>LVD482283282025</td>
                                    <td>LVD</td>
                                    <td>Eastern</td>
                                    <td><span class="badge badge-danger">Queried</span></td>
                                </tr>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>Document Completed</td>
                                    <td>SMDCR20290392932025</td>
                                    <td>SMD</td>
                                    <td>Central</td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>Application Completed</td>
                                    <td>PVLMDWRN22332222025</td>
                                    <td>PVLMD</td>
                                    <td>Western</td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>Payment Received</td>
                                    <td>LRDVR94949292025</td>
                                    <td>LRD</td>
                                    <td>Volta</td>
                                    <td><span class="badge badge-secondary">Received</span></td>
                                </tr>
                                <tr>
                                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>Application Received</td>
                                    <td>LVDNR482283282025</td>
                                    <td>LVD</td>
                                    <td>Northern</td>
                                    <td><span class="badge badge-primary">Received</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>    
    </div> -->

</div>
<!-- /.container-fluid -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script type="text/javascript" src="client_application/executive_compliance.js"></script>

<script>
    $(function () {
  $('[data-toggle="tooltip"]').tooltip()
});
</script>


