<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800">Executive Financial Monitoring Dashboard</h1>


	
	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-4 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> 
								Total Revenue </div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">
								<p>GHS <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${daily_revenue == null ? 0 : daily_revenue }" /></p>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		
		<!-- Application Completed (Today)
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Received
							</div>
							<div class="text-xs  text-dark text-uppercase">this WEEK</div>

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
		</div> -->


        <!-- Application Received (Monthly) -->
		<div class="col-xl-4 col-md-6 mb-4">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">
								Total Revenue </div>
							<div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
							<div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">
								<p>GHS <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${monthly_revenue == null ? 0 : monthly_revenue }" /></p>
							</div>
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


		<!-- Application Completed (Monthly) -->
		<div class="col-xl-4 col-md-6 mb-4">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
								Total Revenue </div>
                                <div class="text-xs  text-dark text-uppercase">this Year (
                                    <fmt:formatDate value="${now}" pattern="YYYY" />)</div>
							<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">
								<p>GHS <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${yearly_revenue == null ? 0 : yearly_revenue }" /></p>

								<!-- <p>GHS <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${yearly_revenue}" /></p> -->
								</div>
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
   
	<ol class="breadcrumb">
		<li class="breadcrumb-item text-uppercase text-gray-800">Revenue Count |  Services</li>
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>

	<div id="carouselExampleControls1" class="carousel slide" data-ride="carousel" data-interval="15000">
  <div class="carousel-inner">
    <div class="carousel-item active">
    <div class="row">
		<!-- Application Received -->
		<div id="app-received-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Registration</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <!-- <canvas id="myChart" class="h-275"></canvas> -->
                        <canvas id="myChart" style="width:100%;max-width:600px"></canvas>
                    </div>
                </div>
				<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				
			</div>
		</div>
		
		
		<!-- Application Received and Completed -->
		<div id="app-received-completed-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Consolidated Search
					</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="searchChart" style="width:100%;max-width:600px"></canvas>
                        
                    </div>
                </div>
				<!-- <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				<!-- <canvas id="searchChart" style="width:100%;max-width:600px"></canvas> -->
			</div>
		</div>
		

		<!-- Application Completed -->
		
	</div>
</div>



<div class="carousel-item">
    <div class="row">
		<!-- Application Received -->
		<div id="app-received-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Consent</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <!-- <canvas id="myChart" class="h-275"></canvas> -->
                        <canvas id="consentChart" style="width:100%;max-width:600px"></canvas>
                    </div>
                </div>
				<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				
			</div>
		</div>
		
		
		<!-- Application Received and Completed -->
		<div id="app-received-completed-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Objection
					</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="objectionChart" style="width:100%;max-width:600px"></canvas>
                        
                    </div>
                </div>
				<!-- <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				<!-- <canvas id="searchChart" style="width:100%;max-width:600px"></canvas> -->
			</div>
		</div>
		

		<!-- Application Completed -->
		
	</div>
</div>


</div>

<a class="carousel-control-prev" href="#carouselExampleControls1" role="button" data-slide="prev">
	<span class="carousel-control-prev-icon"  style="background-color: black;" aria-hidden="true"></span>
	<span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleControls1" role="button" data-slide="next">
	<span class="carousel-control-next-icon"  style="background-color: black;" aria-hidden="true"></span>
	<span class="sr-only">Next</span>
  </a>

</div>


<div id="carouselExampleControls" class="carousel slide" data-ride="carousel" data-interval="15000">
  <div class="carousel-inner">
    <div class="carousel-item active">
    <div class="row">
		<!-- Application Received -->
		<div id="app-received-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Stamping</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <!-- <canvas id="myChart" class="h-275"></canvas> -->
                        <canvas id="stampingChart" style="width:100%;max-width:600px"></canvas>
                    </div>
                </div>
				<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				
			</div>
		</div>
		
		
		<!-- Application Received and Completed -->
		<div id="app-received-completed-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Plan Approval
					</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="planChart" style="width:100%;max-width:600px"></canvas>
                        
                    </div>
                </div>
				<!-- <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				<!-- <canvas id="searchChart" style="width:100%;max-width:600px"></canvas> -->
			</div>
		</div>
		

		<!-- Application Completed -->
		
	</div>
	</div>


	<div class="carousel-item">
		<div class="row">
			<!-- Application Received -->
			<div id="app-received-year" class="col-lg-6 mb-4">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Regional Number</h6>
						<!-- <span class="small text-primary"><span class="count">0</span> Applications for
							<fmt:formatDate value="${now}" pattern="Y" /></span> -->
					</div>
					<div class="card-body">
						<div class="chart-container">
							<!-- <canvas id="myChart" class="h-275"></canvas> -->
							<canvas id="regnumbChart" style="width:100%;max-width:600px"></canvas>
						</div>
					</div>
					<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
					
				</div>
			</div>
			
			
			<!-- Application Received and Completed -->
			<div id="app-received-completed-year" class="col-lg-6 mb-4">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Application For Pvlmd Plotting
						</h6>
						<!-- <span class="small text-primary"><span class="count">0</span> Applications for
							<fmt:formatDate value="${now}" pattern="Y" /></span> -->
					</div>
					<div class="card-body">
						<div class="chart-container">
							<canvas id="plottingChart" style="width:100%;max-width:600px"></canvas>
							
						</div>
					</div>
					<!-- <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
					<!-- <canvas id="searchChart" style="width:100%;max-width:600px"></canvas> -->
				</div>
			</div>
			
	
			<!-- Application Completed -->
			
		</div>
		</div>


	</div>

	<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
		<span class="carousel-control-prev-icon"  style="background-color: black;" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	  </a>
	  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
		<span class="carousel-control-next-icon"  style="background-color: black;" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	  </a>

	</div>





	<ol class="breadcrumb">
		<li class="breadcrumb-item text-uppercase text-gray-800">Revenue Count | Regional</li>
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>

	<div class="row">
		<!-- Application Received -->

		<div id="app-received-completed-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Regional Revenue This month (<fmt:formatDate value="${now}" pattern="MMMM" />)
					</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <!-- <canvas id="planChart" style="width:100%;max-width:600px"></canvas> -->
						<div id="monthContainer" style="height: 300px; width: 100%;"></div>
                        
                    </div>
                </div>
				<!-- <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				<!-- <canvas id="searchChart" style="width:100%;max-width:600px"></canvas> -->
			</div>
		</div>



		<div id="app-received-year" class="col-lg-6 mb-4">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="font-weight-bold text-black text-uppercase mb-1 text-xs">Regional Revenue this year (<fmt:formatDate value="${now}" pattern="YYYY" />)</h6>
					<!-- <span class="small text-primary"><span class="count">0</span> Applications for
						<fmt:formatDate value="${now}" pattern="Y" /></span> -->
				</div>
                <div class="card-body">
                    <div class="chart-container">
                        <!-- <canvas id="myChart" class="h-275"></canvas> -->
                        <!-- <canvas id="stampingChart" style="width:100%;max-width:600px"></canvas> -->
						<div id="yearContainer" style="height: 300px; width: 100%;"></div>
                    </div>
                </div>
				<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
				
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





<jsp:include page="../includes/_footer.jsp"></jsp:include>
<script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>

<script>

let reg_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_jan == null ? 0 : total_reg_jan }"/>'
let reg_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_feb == null ? 0 : total_reg_feb }"/>'
let reg_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_mar == null ? 0 : total_reg_mar }"/>'
let reg_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_apr == null ? 0 : total_reg_apr }"/>'
let reg_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_may == null ? 0 : total_reg_may }"/>'
let reg_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_june == null ? 0 : total_reg_june }"/>'
let reg_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_july == null ? 0 : total_reg_july }"/>'
let reg_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_aug == null ? 0 : total_reg_aug }"/>'
let reg_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_sep == null ? 0 : total_reg_sep }"/>'
let reg_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_oct == null ? 0 : total_reg_oct }"/>'
let reg_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_nov == null ? 0 : total_reg_nov }"/>'
let reg_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_dec == null ? 0 : total_reg_dec }"/>'




let search_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_jan == null ? 0 : total_search_jan }"/>'
let search_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_feb == null ? 0 : total_search_feb }"/>'
let search_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_mar == null ? 0 : total_search_mar }"/>'
let search_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_apr == null ? 0 : total_search_apr }"/>'
let search_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_may == null ? 0 : total_search_may }"/>'
let search_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_june == null ? 0 : total_search_june }"/>'
let search_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_july == null ? 0 : total_search_july }"/>'
let search_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_aug == null ? 0 : total_search_aug }"/>'
let search_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_sep == null ? 0 : total_search_sep }"/>'
let search_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_oct == null ? 0 : total_search_oct }"/>'
let search_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_nov == null ? 0 : total_search_nov }"/>'
let search_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_search_dec == null ? 0 : total_search_dec }"/>'



let stamp_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_jan == null ? 0 : total_stamp_jan }"/>'
let stamp_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_feb == null ? 0 : total_stamp_feb }"/>'
let stamp_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_mar == null ? 0 : total_stamp_mar }"/>'
let stamp_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_apr == null ? 0 : total_stamp_apr }"/>'
let stamp_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_may == null ? 0 : total_stamp_may }"/>'
let stamp_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_june == null ? 0 : total_stamp_june }"/>'
let stamp_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_july == null ? 0 : total_stamp_july }"/>'
let stamp_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_aug == null ? 0 : total_stamp_aug }"/>'
let stamp_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_sep == null ? 0 : total_stamp_sep }"/>'
let stamp_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_oct == null ? 0 : total_stamp_oct }"/>'
let stamp_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_nov == null ? 0 : total_stamp_nov }"/>'
let stamp_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_stamp_dec == null ? 0 : total_stamp_dec }"/>'




let plan_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_jan == null ? 0 : total_plan_jan }"/>'
let plan_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_feb == null ? 0 : total_plan_feb }"/>'
let plan_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_mar == null ? 0 : total_plan_mar }"/>'
let plan_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_apr == null ? 0 : total_plan_apr }"/>'
let plan_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_may == null ? 0 : total_plan_may }"/>'
let plan_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_june == null ? 0 : total_plan_june }"/>'
let plan_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_july == null ? 0 : total_plan_july }"/>'
let plan_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_aug == null ? 0 : total_plan_aug }"/>'
let plan_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_sep == null ? 0 : total_plan_sep }"/>'
let plan_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_oct == null ? 0 : total_plan_oct }"/>'
let plan_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_nov == null ? 0 : total_plan_nov }"/>'
let plan_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plan_dec == null ? 0 : total_plan_dec }"/>'




	var xValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
	var yValues = [parseFloat(reg_jan), parseFloat(reg_feb), parseFloat(reg_mar),parseFloat(reg_apr),parseFloat(reg_may),parseFloat(reg_june),parseFloat(reg_july),
	parseFloat(reg_aug),parseFloat(reg_sep),parseFloat(reg_oct),parseFloat(reg_nov),parseFloat(reg_dec)];
	var barColors = ["#6597c9", "#236bb2", "#003366","#6597c9", "#236bb2", "#003366","#6597c9", "#236bb2", "#003366","#6597c9", "#236bb2", "#003366"];
	
	new Chart("myChart", {
	  type: "bar",
	  data: {
		labels: xValues,
		datasets: [{
		  backgroundColor: barColors,
		  data: yValues,
          fill: true
		}]
	  },
      options: {
			maintainAspectRatio: false,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
        //     title: {
		//   display: true,
		//   //text: "World Wine Production 2018"
		// },
			scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
			
		}
	});


	var searchxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
	var searchyValues = [parseInt(search_jan), parseInt(search_feb), parseInt(search_mar),parseInt(search_apr),parseInt(search_may),parseInt(search_june),
	parseInt(search_july),parseInt(search_aug),parseInt(search_sep),parseInt(search_oct),parseInt(search_nov),parseInt(search_dec)];
	var searchbarColors = ["#d4a983", "#c77b3e", "#c45d08","#d4a983", "#c77b3e", "#c45d08","#d4a983", "#c77b3e", "#c45d08","#d4a983", "#c77b3e", "#c45d08"];
	
	new Chart("searchChart", {
	  type: "bar",
	  data: {
		labels: searchxValues,
		datasets: [{
		  backgroundColor: searchbarColors,
		  data: searchyValues,
          borderWidth: 0,
		}]
	  },
      options: {
			maintainAspectRatio: false,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
        //     title: {
		//   display: true,
		//   //text: "World Wine Production 2018"
		// },
			scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
		}
	});



	var stampingxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
	var stampingyValues = [parseInt(stamp_jan), parseInt(stamp_feb), parseInt(stamp_mar),parseInt(stamp_apr),parseInt(stamp_may),parseInt(stamp_june),
	parseInt(stamp_july),parseInt(stamp_aug),parseInt(stamp_sep),parseInt(stamp_oct),parseInt(stamp_nov),parseInt(stamp_dec)];
	var stampingbarColors = ["#977ca3", "#8746a3", "#59057d","#977ca3", "#8746a3", "#59057d","#977ca3", "#8746a3", "#59057d","#977ca3", "#8746a3", "#59057d"];
	
	new Chart("stampingChart", {
	  type: "bar",
	  data: {
		labels: stampingxValues,
		datasets: [{
		  backgroundColor: stampingbarColors,
		  data: stampingyValues
		}]
	  },
      options: {
			maintainAspectRatio: false,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
        //     title: {
		//   display: true,
		//   //text: "World Wine Production 2018"
		// },
			scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
		}
	});



	var planxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
	var planyValues = [parseInt(plan_jan), parseInt(plan_feb), parseInt(plan_mar),parseInt(plan_apr),parseInt(plan_may),parseInt(plan_june),
	parseInt(plan_july),parseInt(plan_aug),parseInt(plan_sep),parseInt(plan_oct),parseInt(plan_nov),parseInt(plan_dec)];
	var planbarColors = ["#82a89a", "#066b46", "#022e1e","#82a89a", "#066b46", "#022e1e","#82a89a", "#066b46", "#022e1e","#82a89a", "#066b46", "#022e1e"];
	
	new Chart("planChart", {
	  type: "bar",
	  data: {
		labels:  planxValues,
		datasets: [{
		  backgroundColor:  planbarColors,
		  data:  planyValues
		}]
	  },
      options: {
			maintainAspectRatio: false,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
        //     title: {
		//   display: true,
		//   //text: "World Wine Production 2018"
		// },
			scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
		}
	});


let total_reg_number_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_jan == null ? 0 : total_reg_number_jan }"/>'
let total_reg_number_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_feb == null ? 0 : total_reg_number_feb }"/>'
let total_reg_number_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_mar == null ? 0 : total_reg_number_mar }"/>'
let total_reg_number_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_apr == null ? 0 : total_reg_number_apr }"/>'
let total_reg_number_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_may == null ? 0 : total_reg_number_may }"/>'
let total_reg_number_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_june == null ? 0 : total_reg_number_june }"/>'
let total_reg_number_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_july == null ? 0 : total_reg_number_july }"/>'
let total_reg_number_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_aug == null ? 0 : total_reg_number_aug }"/>'
let total_reg_number_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_sep == null ? 0 : total_reg_number_sep }"/>'
let total_reg_number_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_oct == null ? 0 : total_reg_number_oct }"/>'
let total_reg_number_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_nov == null ? 0 : total_reg_number_nov }"/>'
let total_reg_number_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_reg_number_dec == null ? 0 : total_reg_number_dec }"/>'



var rxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
var ryValues = [parseInt(total_reg_number_jan), parseInt(total_reg_number_feb), parseInt(total_reg_number_mar), parseInt(total_reg_number_apr), parseInt(total_reg_number_may), 
parseInt(total_reg_number_june), parseInt(total_reg_number_july), parseInt(total_reg_number_aug), 
parseInt(total_reg_number_sep), parseInt(total_reg_number_oct), parseInt(total_reg_number_nov), parseInt(total_reg_number_dec)];
var rbarColors = ["#662200", "#803300","#994400","#b35c00","#cc6600","#e67300", "#ff8000","#ff9933","#ffa64d","#ffb366","#ffc080","#ffcc99"];

new Chart("regnumbChart", {
  type: "bar",
  data: {
    labels: rxValues,
    datasets: [{
      backgroundColor: rbarColors,
      data: ryValues
    }]
  },
  options: {
    legend: {display: false},
	scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
   
  }
});



let total_plotting_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_jan == null ? 0 : total_plotting_jan }"/>'
let total_plotting_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_feb == null ? 0 : total_plotting_feb }"/>'
let total_plotting_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_mar == null ? 0 : total_plotting_mar }"/>'
let total_plotting_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_apr == null ? 0 : total_plotting_apr }"/>'
let total_plotting_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_may == null ? 0 : total_plotting_may }"/>'
let total_plotting_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_june == null ? 0 : total_plotting_june }"/>'
let total_plotting_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_july == null ? 0 : total_plotting_july }"/>'
let total_plotting_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_aug == null ? 0 : total_plotting_aug }"/>'
let total_plotting_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_sep == null ? 0 : total_plotting_sep }"/>'
let total_plotting_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_oct == null ? 0 : total_plotting_oct }"/>'
let total_plotting_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_nov == null ? 0 : total_plotting_nov }"/>'
let total_plotting_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_dec == null ? 0 : total_plotting_dec }"/>'





var pvxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
var pvyValues = [parseInt(total_plotting_jan), parseInt(total_plotting_feb), parseInt(total_plotting_mar), parseInt(total_plotting_apr), parseInt(total_plotting_may), 
parseInt(total_plotting_june),parseInt(total_plotting_july), parseInt(total_plotting_aug), parseInt(total_plotting_sep), parseInt(total_plotting_oct), 
parseInt(total_plotting_nov), parseInt(total_plotting_dec)];
var pvbarColors = ["#003333", "#004d4d","#006666","#008080","#009999","#00b3b3", "#00cccc","#00e6e6","#00ffff","#33ffff","#66ffff","#99ffff"];

new Chart("plottingChart", {
  type: "bar",
  data: {
    labels: pvxValues,
    datasets: [{
      backgroundColor: pvbarColors,
      data: pvyValues
    }]
  },
  options: {
    legend: {display: false},
	scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
   
  }
});





let total_consent_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_jan == null ? 0 : total_consent_jan }"/>'
let total_consent_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_feb == null ? 0 : total_consent_feb }"/>'
let total_consent_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_mar == null ? 0 : total_consent_mar }"/>'
let total_consent_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_plotting_apr == null ? 0 : total_consent_apr }"/>'
let total_consent_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_may == null ? 0 : total_consent_may }"/>'
let total_consent_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_june == null ? 0 : total_consent_june }"/>'
let total_consent_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_july == null ? 0 : total_consent_july }"/>'
let total_consent_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_aug == null ? 0 : total_consent_aug }"/>'
let total_consent_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_sep == null ? 0 : total_consent_sep }"/>'
let total_consent_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_oct == null ? 0 : total_consent_oct }"/>'
let total_consent_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_nov == null ? 0 : total_consent_nov }"/>'
let total_consent_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_consent_dec == null ? 0 : total_consent_dec }"/>'



var consentxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
var consentyValues = [parseInt(total_consent_jan), parseInt(total_consent_feb), parseInt(total_consent_mar), parseInt(total_consent_apr), parseInt(total_consent_may), 
parseInt(total_consent_june), parseInt(total_consent_july), parseInt(total_consent_aug), parseInt(total_consent_sep), parseInt(total_consent_oct), 
parseInt(total_consent_nov), parseInt(total_consent_dec)];
var consentbarColors = ["#330066", "#4d007f","#660099","#8000b3","#9900cc","#b300e6", "#cc00ff","#e600ff","#ff00ff","#ff33ff","#ff66ff","#ff99ff"];

new Chart("consentChart", {
  type: "bar",
  data: {
    labels: consentxValues,
    datasets: [{
      backgroundColor: consentbarColors,
      data: consentyValues
    }]
  },
  options: {
    legend: {display: false},
	scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
   
  }
});




let total_objection_jan = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_jan == null ? 0 : total_objection_jan }"/>'
let total_objection_feb = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_feb == null ? 0 : total_objection_feb }"/>'
let total_objection_mar = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_mar == null ? 0 : total_objection_mar }"/>'
let total_objection_apr = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_apr == null ? 0 : total_objection_apr }"/>'
let total_objection_may = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_may == null ? 0 : total_objection_may }"/>'
let total_objection_june = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_june == null ? 0 : total_objection_june }"/>'
let total_objection_july = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_july == null ? 0 : total_objection_july }"/>'
let total_objection_aug = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_aug == null ? 0 : total_objection_aug }"/>'
let total_objection_sep = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_sep == null ? 0 : total_objection_sep }"/>'
let total_completed_oct = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_completed_oct == null ? 0 : total_completed_oct }"/>'
let total_objection_nov = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_nov == null ? 0 : total_objection_nov }"/>'
let total_objection_dec = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${total_objection_dec == null ? 0 : total_objection_dec }"/>'




var objectionxValues = ["Jan", "Feb", "Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"];
var objectionyValues = [parseInt(total_objection_jan), parseInt(total_objection_feb), parseInt(total_objection_mar), parseInt(total_objection_apr), parseInt(total_objection_may),
parseInt(total_objection_june), parseInt(total_objection_july), parseInt(total_objection_aug), parseInt(total_objection_sep), parseInt(total_completed_oct),
parseInt(total_objection_nov), parseInt(total_objection_dec)];
var objectiobarColors = ["#003366", "#004080","#005599","#0066b3","#0077cc","#0088e6", "#3399ff","#66aaff","#99bbff","#cce5ff","#66aaff","#005599"];

new Chart("objectionChart", {
  type: "bar",
  data: {
    labels: objectionxValues,
    datasets: [{
      backgroundColor: objectiobarColors,
      data: objectionyValues
    }]
  },
  options: {
    legend: {display: false},
	scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]	
			}
   
  }
});




	

	</script>
	<script>

let yearly_accra_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_accra_revenue == null ? 0 : yearly_accra_revenue }"/>'
let yearly_kumasi_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_kumasi_revenue == null ? 0 : yearly_kumasi_revenue}" />'
let yearly_secondi_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_secondi_revenue == null ? 0 : yearly_secondi_revenue}" />'

let yearly_bolga_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_bolga_revenue == null ? 0 : yearly_bolga_revenue}" />'
let yearly_tema_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_tema_revenue == null ? 0 : yearly_tema_revenue}" />'


let yearly_techiman_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_techiman_revenue == null ? 0 : yearly_techiman_revenue}" />'
let yearly_goaso_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_goaso_revenue == null ? 0 : yearly_goaso_revenue}" />'
let yearly_damango_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_damango_revenue == null ? 0 : yearly_damango_revenue}" />'
let yearly_dambai_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_dambai_revenue == null ? 0 : yearly_dambai_revenue}" />'
let yearly_wa_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_wa_revenue == null ? 0 : yearly_wa_revenue}" />'
let yearly_kof_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_kof_revenue == null ? 0 : yearly_kof_revenue}" />'
let yearly_suny_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_suny_revenue == null ? 0 : yearly_suny_revenue}" />'

let yearly_cape_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_cape_revenue == null ? 0 : yearly_cape_revenue}" />'
let yearly_tama_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_tama_revenue == null ? 0 : yearly_tama_revenue}" />'


// let yearly_suny_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_suny_revenue == null ? 0 : yearly_suny_revenue}" />'
let yearly_western_north_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_western_north_revenue == null ? 0 : yearly_western_north_revenue}" />'
let yearly_volta_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_volta_revenue == null ? 0 : yearly_volta_revenue}" />'
let yearly_north_east_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${yearly_north_east_revenue == null ? 0 : yearly_north_east_revenue}" />'










let monthly_accra_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_accra_revenue == null ? 0 : monthly_accra_revenue}" />'
let monthly_kumasi_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_kumasi_revenue == null ? 0 : monthly_kumasi_revenue}" />'
let monthly_secondi_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_secondi_revenue == null ? 0 : monthly_secondi_revenue}" />'

let monthly_bolga_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_bolga_revenue == null ? 0 : monthly_bolga_revenue}" />'
let monthly_tema_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_tema_revenue == null ? 0 : monthly_tema_revenue}" />'


let monthly_techiman_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_techiman_revenue == null ? 0 : monthly_techiman_revenue}" />'
let monthly_goaso_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_goaso_revenue == null ? 0 : monthly_goaso_revenue}" />'
let monthly_damango_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_damango_revenue == null ? 0 : monthly_damango_revenue}" />'
let monthly_dambai_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_dambai_revenue == null ? 0 : monthly_dambai_revenue}" />'
let monthly_wa_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_wa_revenue == null ? 0 : monthly_wa_revenue}" />'
let monthly_kof_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_kof_revenue == null ? 0 : monthly_kof_revenue}" />'
let monthly_suny_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_suny_revenue == null ? 0 : monthly_suny_revenue}" />'
let monthly_cape_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_cape_revenue == null ? 0 : monthly_cape_revenue}" />'
let monthly_tama_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_tama_revenue == null ? 0 : monthly_tama_revenue}" />'


let monthly_western_north_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_western_north_revenue == null ? 0 : monthly_western_north_revenue}" />'
let monthly_volta_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_volta_revenue == null ? 0 : monthly_volta_revenue}" />'
let monthly_north_east_revenue = '<fmt:formatNumber type = "number" groupingUsed = "false" value = "${monthly_north_east_revenue == null ? 0 : monthly_north_east_revenue}" />'






console.log(monthly_kumasi_revenue);		

 var chart = new CanvasJS.Chart("monthContainer", {
	animationEnabled: true,
	title: {
		text: ""
	},
	data: [{
		type: "pie",
		startAngle: 360,
		//yValueFormatString: "##0.00\"%\"",
		indexLabel: "{label} {y}",
		dataPoints: [
		    {y: parseInt(monthly_accra_revenue), label: "Accra"},
		    {y: parseInt(monthly_kumasi_revenue), label: "Kumasi"},
			{y: parseInt(monthly_secondi_revenue), label: "Secondi"},
			{y: parseInt(monthly_bolga_revenue), label: "Bolga"},
			{y: parseInt(monthly_tema_revenue), label: "Tema"},
			{y: parseInt(monthly_techiman_revenue), label: "Techiman"},
			{y: parseInt(monthly_goaso_revenue), label: "Goaso"},
			{y: parseInt(monthly_damango_revenue), label: "Damango"},
			{y: parseInt(monthly_dambai_revenue), label: "Dambai"},
			{y: parseInt(monthly_tama_revenue), label: "Tamale"},
			{y: parseInt(monthly_cape_revenue), label: "Cape"},
			{y: parseInt(monthly_suny_revenue), label: "Sunyani"},
			{y: parseInt(monthly_wa_revenue), label: "Wa"},
			{y: parseInt(monthly_kof_revenue), label: "Koforidua"},
			{y: parseInt(monthly_western_north_revenue), label: "Sefwi Wiaso"},
			{y: parseInt(monthly_volta_revenue), label: "Ho"},
			{y: parseInt(monthly_north_east_revenue), label: "Nalerigu"}
			
		]
	}]
});
chart.render();


var chart1 = new CanvasJS.Chart("yearContainer", {
	animationEnabled: true,
	title: {
		text: ""
	},
	data: [{
		type: "pie",
		startAngle: 360,
		//yValueFormatString: "##0.00\"%\"",
		indexLabel: "{label} {y}",
		dataPoints: [
			{y: parseInt(yearly_accra_revenue), label: "Accra"},
			{y: parseInt(yearly_kumasi_revenue), label: "Kumasi"},
			{y: parseInt(yearly_secondi_revenue), label: "Secondi"},
			{y: parseInt(yearly_bolga_revenue), label: "Bolga"},
			{y: parseInt(yearly_tema_revenue), label: "Tema"},
			{y: parseInt(yearly_techiman_revenue), label: "Techiman"},
			{y: parseInt(yearly_goaso_revenue), label: "Goaso"},
			{y: parseInt(yearly_damango_revenue), label: "Damongo"},
			{y: parseInt(yearly_dambai_revenue), label: "Dambai"},
			{y: parseInt(yearly_cape_revenue), label: "Cape Coast"},
			{y: parseInt(yearly_tama_revenue), label: "Tamale"},
			{y: parseInt(yearly_wa_revenue), label: "Wa"},
			{y: parseInt(yearly_kof_revenue), label: "Koforidua"},
			{y: parseInt(yearly_western_north_revenue), label: "Sefwi-Wiaso"},
			{y: parseInt(yearly_north_east_revenue), label: "Nalerigu"},
			{y: parseInt(yearly_suny_revenue), label: "Sunyani"},
			{y: parseInt(yearly_volta_revenue), label: "Ho"}
		]
	}]
});
chart1.render();
	




		// var xValues = ["Ashanti", "Greater Accra", "Bono", "Bono-East", "Central","Ahafo","Eastern","Northen","Savannah","North-East","Upper-East","uppper-West","Volta","Oti","Western","Western-Noth"];
		// var yValues = [55, 49, 44, 24, 15,12,11,11,112,32,65,33,36,66,98,43];
		// var barColors = [
		//   "#e36700",
		//   "#3a683a",
		//   "#e97451",
		//   "#f6546a",
		//   "#141669","#d0e4b7",
		//   "#706f6f",
		//   "#b7e1cd",
		//   "#d0ebf9","#8ff2e6",
		//   "#c2c330",
		//   "#1c0126",
		//   "#006acc",
		//   "#ff1493",
		//   "#d5eb00",
		//   "#470000"
		// ];
		
		// new Chart("pieChart", {
		//   type: "pie",
		//   data: {
		// 	labels: xValues,
		// 	datasets: [{
		// 	  backgroundColor: barColors,
		// 	  data: yValues
		// 	}]
		//   },
		//   options: {
		// 	title: {
		// 	  display: true,
		// 	}
		//   }
		// });


		// var completedxValues = ["Ashanti", "Greater Accra", "Bono", "Bono-East", "Central","Ahafo","Eastern","Northen","Savannah","North-East","Upper-East","uppper-West","Volta","Oti","Western","Western-Noth"];
		// var completedyValues = [55, 49, 44, 24, 15,12,11,11,112,32,65,33,36,66,98,43];
		// var completedbarColors = [
		// "#e36700",
		//   "#3a683a",
		//   "#f6546a",
		//   "#470000",
		//   "#141669","#d0e4b7",
		//   "#706f6f",
		//   "#d0ebf9",
		//   "#c2c330",
		//   "#b7e1cd",
		//   "#1c0126",
		//   "#8ff2e6",
		//   "#006acc",
		//   "#ff1493",
		//   "#d5eb00",
		//   "#e97451"
		// ];
		
		// new Chart("completedChart", {
		//   type: "pie",
		//   data: {
		// 	labels: completedxValues,
		// 	datasets: [{
		// 	  backgroundColor: completedbarColors,
		// 	  data: completedyValues
		// 	}]
		//   },
		//   options: {
		// 	title: {
		// 	  display: true,
		// 	}
		//   }
		// });	
		</script>

