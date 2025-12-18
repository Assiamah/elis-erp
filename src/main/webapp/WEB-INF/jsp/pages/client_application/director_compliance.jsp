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

<style>


body {
    margin-top: 20px;
    background: #FAFAFA;
}

.order-card {
    color: #fff;
}

.card {

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


.card .card-block {
    padding: 25px;
}

/* Softer Gradients */

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
    background: linear-gradient(135deg, #4CAF50, #2E8B57); /* Lighter to deeper green */
    color: white;
}

/* Card Styling */
.order-card {
    border-radius: 10px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

.card-block {
    padding: 20px;
}

/* Float helpers */
.f-left {
    float: left;
}

.f-right {
    float: right;
}
.card:hover {
    transform: translateY(-10px); /* Moves the card slightly up */
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Stronger shadow on hover */
}
/* New CSS for enhanced components */
.alert-list .alert {
    padding: 0.75rem 1rem;
    margin-bottom: 0.5rem;
    font-size: 0.85rem;
}

.metric-trend {
    font-size: 0.75rem;
    font-weight: bold;
}

.trend-up {
    color: #28a745;
}

.trend-down {
    color: #dc3545;
}

.trend-neutral {
    color: #6c757d;
}

.chart-container {
    position: relative;
    height: 100%;
    min-height: 200px;
}

.small-chart {
    height: 40px;
    width: 100%;
    margin: 10px 0;
}

.performance-metric {
    text-align: center;
    padding: 10px;
}

.metric-value {
    font-size: 2rem;
    font-weight: bold;
    margin: 10px 0;
}

.metric-label {
    font-size: 0.85rem;
    color: #6c757d;
}

.region-bar {
    display: flex;
    align-items: center;
    margin: 8px 0;
    padding: 5px;
}

.region-name {
    width: 120px;
    font-size: 0.85rem;
}

.region-value {
    width: 50px;
    text-align: right;
    font-size: 0.85rem;
    font-weight: bold;
}

.region-chart-bar {
    flex: 1;
    height: 20px;
    background: #e9ecef;
    margin: 0 10px;
    border-radius: 10px;
    overflow: hidden;
}

.bar-fill {
    height: 100%;
    border-radius: 10px;
}

.trend-item {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    border-bottom: 1px solid #f1f1f1;
}

.trend-item:last-child {
    border-bottom: none;
}

.complexity-item {
    display: flex;
    align-items: center;
    margin: 10px 0;
}

.complexity-label {
    width: 150px;
    font-size: 0.85rem;
}

.complexity-bar {
    flex: 1;
    height: 15px;
    background: #e9ecef;
    margin: 0 10px;
    border-radius: 5px;
    overflow: hidden;
}
#performance-alerts {
  max-height: 350px;
  overflow-y: auto;
}

#service-type-breakdown {
  max-height: 350px; /* adjust height as needed */
  overflow-y: auto;
  padding-right: 5px;
  scrollbar-width: thin;
  scrollbar-color: #999 #f1f1f1;
}

/* For WebKit browsers (Chrome, Safari, Edge) */
#service-type-breakdown::-webkit-scrollbar {
  width: 6px;
}
#service-type-breakdown::-webkit-scrollbar-thumb {
  background-color: #999;
  border-radius: 3px;
}
#service-type-breakdown::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}


#repliesModalBody .list-group-item {
  transition: background 0.2s ease-in-out;
  border-radius: 0.5rem;
}

#repliesModalBody .list-group-item:hover {
  background-color: #f8f9fa;
}
  .timeline {
  position: relative;
  margin: 20px 0;
  padding-left: 40px;
  border-left: 2px solid #dee2e6;
}

.timeline-item {
  position: relative;
  margin-bottom: 30px;
}

.timeline-item:last-child {
  margin-bottom: 0;
}

.timeline-icon {
  position: absolute;
  left: -24px;
  top: 0;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  box-shadow: 0 0 0 3px #fff;
}

.timeline-content {
  background: #f8f9fa;
  padding: 12px 16px;
  border-radius: 6px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.timeline-item.completed .timeline-icon {
  background-color: #284ca7 !important;
}

.timeline-item.active .timeline-icon {
  background-color: #28a745 !important;
}

.timeline-item.pending .timeline-icon {
  background-color: #6c757d !important;
}

.timeline h6 {
  margin-bottom: 4px;
  font-weight: 600;
}

.timeline p {
  margin-bottom: 4px;
  font-size: 14px;
  color: #555;
}
.timeline i {
    margin-right: 1px;
}
/* #sendMessageModal .alert-info ul {
  max-height: 200px;
  overflow-y: auto;
  margin-top: 10px;
} */

</style>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">${division} Dashboard 
    
    <!-- <select id="sel_change_region_compliance" class="">
        <option value=${regional_code}>${regional_name}</option>
                                    
        <c:forEach items="${officeregionlist}" var="officeregion">
            <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
  </c:forEach>

                                </select> -->
    
    
    
    </h1>

    <input type="hidden" id="director_regional_code" value="${regional_code}" />
	<input type="hidden" id="director_division" value="${division}" />


     <input type="hidden" id = "startdate">
			  <input type="hidden" id = "start_date">
			  <input type="hidden" id = "enddate">
			  <input type="hidden" id = "end_date">




               <div class="row">

            <div class="col-xl-4 col-md-6 mb-4" id="apps_received_today" data-toggle="tooltip" 
     title="This Card Displays Applications Received Today. Click To View More Details">
                <div class="card bg-c-blue order-card">
                    <div class="card-block">
                        <h6 class="m-b-20 text-uppercase">Applications
                            Received </h6>

                                <div class="text-xs text-uppercase">Today (
                                    <fmt:formatDate value="${now}" type="date" />)</div>

                                <h2  class="text-left"><i class="fa fa-calendar-day f-right"></i><span id="app-received-today">0</span></h2>
                                <!-- <p class="m-b-0">Completed Orders<span class="f-right">351</span></p> -->
                    </div>
                </div>
            </div>

            
            <div class="col-xl-4 col-md-6 mb-4" id="apps_received_this_month"  data-toggle="tooltip" 
     title="This Card Displays Applications Pending As At Today. Click To View More Details">
                <div class="card bg-c-yellow order-card">
                    <div class="card-block">
                        <h6 class="m-b-20 text-uppercase">Applications Pending As At</h6>

                            <div class="text-xs text-uppercase">Today (
                                    <fmt:formatDate value="${now}" type="date" />)</div>


                            <h2 class="text-left"><i class="fas fa-hourglass-half f-right"></i><span id="app-received-month">0</span></h2>
                        </div>
                </div>
            </div>
            
            <div class="col-xl-4 col-md-6 mb-4" id="apps_completed_today_division"  data-toggle="tooltip" 
     title="This Card Displays Applications Completed Today. Click To View More Details">
                <div class="card bg-c-pink order-card">
                    <div class="card-block">
                        <h6 class="m-b-20 text-uppercase">Applications
                            Completed </h6>
                            <div class="text-xs text-uppercase">Today (
                                <fmt:formatDate value="${now}" type="date" />)</div>

                                <h2 class="text-left"><i class="fa fa-check-circle f-right"></i><span id="app-completed-today">0</span></h2>
                            </div>
                </div>
            </div>
            
        </div>




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





         <!-- Trends & Forecasting -->
    <div class="row">


<div class="col-lg-7 mb-4" data-toggle="tooltip" 
     title="Provides a breakdown of application Service types Received">
  <div class="card shadow mb-4">
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-black">APPLICATION TYPES BREAKDOWN</h6>
    </div>
    <div class="card-body">
      <div class="service-type-breakdown" id="service-type-breakdown"></div>
    </div>
  </div>
</div>
    

      
        
        <div class="col-lg-5 mb-4" data-toggle="tooltip" 
     title="Displays a summary of regional offices with high to low completion rates, highlighting areas that require attention or performance improvement.">
  <div class="card shadow mb-4">
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-black">Performance Alerts</h6>
    </div>
    <div class="card-body">
      <div id="performance-alerts" class="alert-list"></div>
    </div>
  </div>
</div>



    </div>

    



        



   

    <div class="row">
        <!-- Application Received -->
        <div id="app-received-year" class="col-lg-4 mb-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-black">Applications Received</h6>
                    <span class="small text-primary"><span class="count">0</span> Applications from
                        <span id="displayDateRange"></span></span>
                        <!-- <div class="metric-trend trend-up">
                        <i class="fas fa-arrow-up"></i> 12% increase from last year
                    </div> -->
                </div>
                

                <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal_apps_recieved" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
            </div>
        </div>
        
        
        <!-- Application Received and Completed -->
        <div id="app-received-completed-year" class="col-lg-4 mb-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-black">Applications Received and Completed in
                        <!-- <fmt:formatDate value="${now}" pattern="Y" /> -->
                    </h6>
                    <span class="small text-primary"><span class="count">0</span> Applications from
                    <span id="displayDateRange1"></span></span>
                    </span>
                    <span class="small text-primary float-right" id="pec_id">0%</span>
                </div>
                <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal_apps_recieved_and_completed" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
            </div>
            
        </div>
        

        <!-- Application Completed -->
        <div id="app-completed-year" class="col-lg-4 mb-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-black">Applications Completed</h6>
                    <span class="small text-primary"><span class="count">0</span> Applications from
                        <span id="displayDateRange2"></span></span>
                </div>
                <div data-method="apps_completed" data-period="year" data-url="DashboardAppsCompleted" data-next-level-modal="showServiceTypeModal_apps_completed" data-title="Applications Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
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
                    <span class="small text-primary"><span class="count">0</span> Applications from
                         <span id="displayDateRange4"></span></span>
                </div>
                <div data-method="apps_past_due" data-period="year" data-url="DashboardAppsPastDueDate" data-next-level-modal="showServiceTypeModal_apps_pastdue" data-title="Applications Past Due Date" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
            </div>
        </div>
        <div id="app-with-divisions" class="col-lg-6 mb-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-black">Applications With Regions </h6>
                    <span class="small text-primary"><span class="count">0</span> Applications From
                     <span id="displayDateRange5"></span></span>
                </span>
                </div>
                <div data-method="apps_with_division" data-url="DashboardAppsWithDivision" data-next-level-modal="showServiceTypeModal_apps_with_divisions" data-title="Applications With Divisions" class="content-body card-body"></div>
            </div>
        </div>

        
    </div>


    

        <!-- Original Metrics Row -->
    


    <!-- Regional Performance Comparison -->
<div class="row">
  <div class="col-lg-12 mb-4">
    <div class="card shadow mb-4">
      <div class="card-header py-3 d-flex justify-content-between align-items-center">
        <h6 class="m-0 font-weight-bold text-black text-uppercase">Regional Performance Comparison</h6>
        <select id="region-comparison-metric" class="form-control form-control-sm w-auto">
          <option value="completion_rate">Completion Rate</option>
          <option value="avg_processing_days">Processing Time</option>
          <option value="total_received">Application Volume</option>
        </select>
      </div>
      <div class="card-body">
        <div id="regionComparisonChart" style="height: 450px;"></div>
      </div>
    </div>
  </div>
</div>


   

    <!-- Service Type Analysis -->
    

    <!-- Quick Actions & Export Features -->
    <!-- <div class="row">
        <div class="col-lg-12 mb-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-black">Quick Actions & Reports</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 text-center">
                            <button class="btn btn-outline-primary btn-sm mb-2" onclick="exportDashboardData()">
                                <i class="fas fa-download"></i> Export Data
                            </button>
                        </div>
                        <div class="col-md-3 text-center">
                            <button class="btn btn-outline-info btn-sm mb-2" onclick="generatePerformanceReport()">
                                <i class="fas fa-chart-line"></i> Performance Report
                            </button>
                        </div>
                        <div class="col-md-3 text-center">
                            <button class="btn btn-outline-warning btn-sm mb-2" onclick="viewBottleneckAnalysis()">
                                <i class="fas fa-tachometer-alt"></i> Bottleneck Analysis
                            </button>
                        </div>
                        <div class="col-md-3 text-center">
                            <button class="btn btn-outline-success btn-sm mb-2" onclick="scheduleExecutiveBriefing()">
                                <i class="fas fa-briefcase"></i> Executive Summary
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> -->

</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->
<jsp:include page="../includes/_footer.jsp"></jsp:include>

