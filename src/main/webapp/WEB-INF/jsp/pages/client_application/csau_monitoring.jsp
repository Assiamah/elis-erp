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
	<h1 class="h3 mb-4 text-gray-800">CSAU Monitoring Dashboard</h1>


    <ol class="breadcrumb">
		<li class="breadcrumb-item text-uppercase text-gray-800">Tellers</li>
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>

	<input type="hidden" id="csau_manager_regional_code" value="${regional_code}" />

	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="csau_applications_received_today">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
								Received</div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${recieved_today}
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>

		</div>

		
		<!-- Application Completed (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="csau_applications_received_week">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Received
							</div>
							<div class="text-xs  text-dark text-uppercase">this WEEK</div>

							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${recieved_today}</div>
								</div>

							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
						</a>
					</div>
				</div>
			</div>
		</div>


        <!-- Application Received (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="csau_applications_received_this_month">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
								Received</div>
							<div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
							<div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">${recieved_month}</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
			
						</a>
					</div>
				</div>

			</div>
		</div>


		<!-- Application Completed (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4"   id="csau_applications_received_this_year">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Applications
								Received</div>
                                <div class="text-xs  text-dark text-uppercase">this Year (
                                    <fmt:formatDate value="${now}" pattern="YYYY" />)</div>
							<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${recieved_year}</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>

						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
   

    <div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-4 col-md-6 mb-4" id="6months_bills_created">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1"> Bills Created</div>
							<div class="text-xs  text-dark text-uppercase">Last 6 Months </div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${bills_6months}
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Application Received (Monthly) -->
		<div class="col-xl-4 col-md-6 mb-4" id="biils_created_and_paid">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1"> Bills Created And Paid</div>
							<div class="text-xs  text-dark text-uppercase">Last 6 Months </div>
							<div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">${createdandpaid}</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>

			</div>
		</div>

		<!-- Application Completed (Today) -->
		<div class="col-xl-4 col-md-6 mb-4" id="bills_created_and_acknowledged">
			<div class="card border-left-danger shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-danger text-uppercase mb-1"> Bills Created and acknowledged
							</div>
							<div class="text-xs  text-dark text-uppercase">Last 6 Months </div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${bills_acknowledged}</div>
								</div>

							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Application Completed (Monthly) -->
		
	</div>

    <hr>

    <ol class="breadcrumb">
          <li class="breadcrumb-item text-uppercase text-gray-800">Collection</li>
          <!-- <li class="breadcrumb-item active">${unit_name}</li> -->
      </ol>
    <!-- Signout Monitoring -->

    <div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="apps_signedout_today">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
								Signed Out</div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

	
		<!-- Application Completed (Today) -->
	<div class="col-xl-3 col-md-6 mb-4" id="apps_signedout_week">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications
								Signed Out
							</div>
							<div class="text-xs  text-dark text-uppercase">this WEEK</div>

							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${signedout_week}</div>
								</div>

							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>


        	<!-- Application Received (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="apps_signedout_month">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
								Signed Out</div>
							<div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
							<div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_month}</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>

			</div>
		</div>


		<!-- Application Completed (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="apps_signedout_year">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Applications
								Signed Out</div>
                                <div class="text-xs  text-dark text-uppercase">this Year (
                                    <fmt:formatDate value="${now}" pattern="YYYY" />)</div>
							<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_year}</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>








	<ol class="breadcrumb">
		<li class="breadcrumb-item text-uppercase text-gray-800">Reporting</li>
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>
  <!-- Signout Monitoring -->

  <div class="row">
	  <!-- Application Received (Today) -->
	  <div class="col-xl-4 col-md-6 mb-2" id="apps_recieved_within_dates">
		  <div class="card border-left-primary shadow h-100 py-2">
			  <div class="card-body">
				  <div class="row no-gutters align-items-center">
					  <div class="col mr-2">
						  <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
							   Received</div>
						  <div class="text-xs  text-dark text-uppercase"> By Dates</div>
						  <!-- <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
						  </div> -->
					  </div>
					  <div class="col-auto">
						  <i class="fas fa-file fa-2x text-gray-300"></i>
					  </div>
				  </div>
			  </div>
		  </div>
	  </div>


	  <div class="col-xl-4 col-md-6 mb-2" id="apps_signed_out_within_dates">
		<div class="card border-left-warning shadow h-100 py-2">
			<div class="card-body">
				<div class="row no-gutters align-items-center">
					<div class="col mr-2">
						<div class="text-xs font-weight-bold text-warning text-uppercase mb-1"> Applications
							 Signed Out</div>
						<div class="text-xs  text-dark text-uppercase"> By Dates</div>
						<!-- <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
						</div> -->
					</div>
					<div class="col-auto">
						<i class="fas fa-file fa-2x text-gray-300"></i>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="col-xl-4 col-md-6 mb-2" id="bills_created_by_dates">
		<div class="card border-left-info shadow h-100 py-2">
			<div class="card-body">
				<div class="row no-gutters align-items-center">
					<div class="col mr-2">
						<div class="text-xs font-weight-bold text-info text-uppercase mb-1"> Bills
							 Created</div>
						<div class="text-xs  text-dark text-uppercase"> By Dates</div>
						<!-- <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
						</div> -->
					</div>
					<div class="col-auto">
						<i class="fas fa-file fa-2x text-gray-300"></i>
					</div>
				</div>
			</div>
		</div>
	</div>

  
	  <!-- Application Completed (Today) -->
  </div>


	
		
		
		
		</div>
		

		
		</div>

		
	</div>

	</div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->




<!-- applications received today -->

<div class="modal fade" id="recievedtodayModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved Today</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    <div id="bills_created_and_paid_today" class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black"><span class="count text-primary">${createdandpaid_today}</span> Bills Created And Paid
                                </h6>
                            </div>
                            <!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
                        </div>
                    </div>
                    
                    
                    <!-- Application Received and Completed -->
                    <div id="bills_created_and_acknowledged_today" class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black"><span class="count text-primary">${createdandack_today}</span> Bills Acknowledged
                                </h6>
                                <!-- <span class="small text-primary"><span class="count">0</span> Applications for
                                    <fmt:formatDate value="${now}" pattern="Y" /></span> -->
                            </div>
                            <!-- <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
                        </div>
                    </div>
                    
                        
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="recievedtoday" width="100%" cellspacing="0">
                    <!-- <table id="recievedtoday" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<!-- bills created and paid today -->
<div class="modal fade" id="billcreatedandpaidModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Bills Created And Paid (
					<fmt:formatDate value="${now}" type="date" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="billcreatedandpaidTable" width="100%" cellspacing="0">
                    <!-- <table id="billcreatedandpaidTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>





<!-- bills created and acknowledged today -->
<div class="modal fade" id="billcreatedandacknowledgedModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Bills Created And Acknowledged (
					<fmt:formatDate value="${now}" type="date" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="billcreatedandAckTable" width="100%" cellspacing="0">
                    <!-- <table id="billcreatedandAckTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>





<!--Today bills created by officer -->
<div class="modal fade" id="today_bills_created_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">BILLS CREATED BY <span class="text-success" id="staff_name53"></span> TODAY </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="today_bills_created_table" width="100%" cellspacing="0">
                    <!-- <table id="today_bills_created_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Reference Number</th>
							<th>Payment Status</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>







<!--Today bills Acknowledged  by officer -->
<div class="modal fade" id="today_bills_acknowledged_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">BILLS ACKNOWLEDGED BY <span class="text-success" id="staff_name54"></span> TODAY </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="today_bills_acknowledged_table" width="100%" cellspacing="0">
                    <!-- <table id="today_bills_acknowledged_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Job Number</th>
							<th>Reference Number</th>
							<th>Payment Status</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<!-- applications received month -->
<div class="modal fade" id="recievedMonthModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved This Month (
					<fmt:formatDate value="${now}" pattern="MMMM" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="recievedMonth" width="100%" cellspacing="0">
                    <!-- <table id="recievedMonth" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<!-- applications received this year -->

<div class="modal fade" id="recievedYearModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved This Year (
					<fmt:formatDate value="${now}" pattern="YYYY" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="recievedYear" width="100%" cellspacing="0">

                    <!-- <table id="recievedYear" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<!-- applications received this week -->

<div class="modal fade" id="recievedWeekModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved This Year Week </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="recievedWeek" width="100%" cellspacing="0">
                    <!-- <table id="recievedWeek" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" id="csau_staff_yearly_apps_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY  <span id="staffname"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_yearly_apps_view" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_yearly_apps_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>


<!-- Staff Weekly appications modal -->
<div class="modal fade" id="csau_staff_daily_apps_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name51"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_daily_apps_table" width="100%" cellspacing="0">

                    <!-- <table id="csau_staff_daily_apps_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<!-- Staff Weekly appications modal -->
<div class="modal fade" id="csau_staff_weekly_apps_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name5"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_weekly_apps_table" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_weekly_apps_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>


<!-- Staff monthly appications modal -->

<div class="modal fade" id="csau_staff_monthly_apps_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name7"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_monthly_apps_view" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_monthly_apps_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




<!-- bills generated modal -->

<div class="modal fade" id="bill_createdModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Bills Created</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="bills_CreatedTable" width="100%" cellspacing="0">
                    <!-- <table id="bills_CreatedTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




 <!-- bill created and paid modal -->
 <div class="modal fade" id="bill_createdand_paidModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Bills Created And Paid</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="bills_Createdand_paidTable" width="100%" cellspacing="0">
                    <!-- <table id="bills_Createdand_paidTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




<!-- bill paid and acknowleged modal -->
<div class="modal fade" id="bills_paid_and_acknowleged_Modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Bills Paid And Acknowledged</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="bills_paid_and_acknlowledged_Table" width="100%" cellspacing="0">
				<!-- <table id="bills_paid_and_acknlowledged_Table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Officer</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>


<!-- 6months bills created -->
<div class="modal fade" id="csau_6months_biils_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS CREATED BY <span id="staff_name1"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_6months_bills_view" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_6months_bills_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Reference Number</th>
							<th>Payment Status</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<!-- 6months bills created and paid -->

<div class="modal fade" id="csau_6months_biils_paid_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS CREATED BY <span id="staff_name2"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_6months_bills_paid_view" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_6months_bills_paid_view" class="table table-striped table-bordered dt-responsive" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Reference Number</th>
							<th>Payment Status</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>





<!-- 6months bills created and acknowledged -->
<div class="modal fade" id="csau_6months_biils_acknow_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS CREATED BY <span id="staff_name3"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_6months_bills_acknow_view" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_6months_bills_acknow_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Reference Number</th>
							<th>Payment Status</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>


<!-- Applications signed out today -->

<div class="modal fade" id="signedouttodayModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out Today</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="signedouttodayTable" width="100%" cellspacing="0">
                    <!-- <table id="signedouttodayTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>





<!-- Applications signed out Week -->

<div class="modal fade" id="signedoutWeekModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out This Week</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>

			<div class="modal-body">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="signedoutWeekTable" width="100%" cellspacing="0">
                    <!-- <table id="signedoutWeekTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<!-- Applications signed out thid year -->
<div class="modal fade" id="signedoutyearModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out this Year (<fmt:formatDate value="${now}" pattern="YYYY" />)</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="signedoutyearTable" width="100%" cellspacing="0">
					<!-- <table id="signedoutyearTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
						<thead>
							 <th>Officer</th>
							 <th>Count</th>
							 <th>Action</th>
					   </thead>
						   <tbody>        
						   </tbody>
					 </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




<!-- Applications signed out this week -->
<!-- <div class="modal fade" id="signedoutMonthlModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out this month (<fmt:formatDate value="${now}" pattern="MMMM" />)</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="table-responsive">
                    <table id="signedoutMonthTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                       <thead>
						    <th>Applicant Name</th>  
                            <th>Job Number</th>
							<th>Application Type</th>
                            <th>Status</th>
                            <th>Collected by</th>
							<th>Collected on</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div> -->



<!-- Applications signed out thid year -->
<div class="modal fade" id="signedoutMonthlModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out this month (<fmt:formatDate value="${now}" pattern="MMMM" />)</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="signedoutMonthTable" width="100%" cellspacing="0">
					<!-- <table id="signedoutMonthTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
						<thead>
							 <th>Officer</th>
							 <th>Count</th>
							 <th>Action</th>
					   </thead>
						   <tbody>        
						   </tbody>
					 </table>
                    <!-- <table id="signedoutMonthTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                       <thead>
						   <th>Applicant Name</th>
                            <th>Job Number</th>
							<th>Application Type</th>
                            <th>Status</th>
                            <th>Collected by</th>
							<th>Collected on</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table> -->
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>





<!-- Staff monthly appications modal -->

<div class="modal fade" id="csau_staff_yearly_signedout_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name9"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->  
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_yearly_signedout_table" width="100%" cellspacing="0"></table>
                    <!-- <table id="csau_staff_yearly_signedout_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Job Status</th>
							<th>Date Signed Out</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




<!-- Staff Today appications modal -->

<div class="modal fade" id="csau_staff_today_signedout_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name10"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->  
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_today_signedout_table" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_today_signedout_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Job Status</th>
							<th>Date Signed Out</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<!-- Staff Week appications modal -->
<div class="modal fade" id="csau_staff_week_signedout_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name11"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->  
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_week_signedout_table" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_week_signedout_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Job Status</th>
							<th>Date Signed Out</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<!-- Staff Month appications modal -->
<div class="modal fade" id="csau_staff_month_signedout_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name12"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->  
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="csau_staff_month_signedout_table" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_month_signedout_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Job Status</th>
							<th>Date Signed Out</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" id="apps_recieved_within_dates_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved Within Dates</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
              
				<form class="" method="POST">
						<div class="row">

							<div class="col-md-6">
							<div class="mb-4">
							 <label class="form-label" for="val-username">Start Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="startDate" name="startDate" >
						   </div>
						 </div>
	   
						   <div class="col-md-6">
						   <div class="mb-4">
							 <label class="form-label" for="val-username">End Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="endDate"  name="endDate" >
						   </div>
						 </div>
					 
						 </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-success" id="submit_Btn" type="button" >Submit <i class="fa fa-save"></i></button>
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</form>
		</div>
	</div>
</div>






<div class="modal fade" id="apps_recieved_within_dates_officers_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved Between <span class="text-success" id="startDate1"></span> and <span class="text-success" id="startDate2"></span></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="officer_startDate">
				<input type="hidden" id="officer_endDate">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="apps_recieved_within_dates_officers_table" width="100%" cellspacing="0">
                    <!-- <table id="recievedtoday" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" id="load_apps_created_by_officers_by_date_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="staff_name71"></span> Between <span id="staff_date"></span> and <span id="staff_end_date"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="load_apps_created_by_officers_by_date_table" width="100%" cellspacing="0">

                    <!-- <table id="csau_staff_daily_apps_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" id="apps_signed_out_within_dates_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out Within Dates</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
				<form class="" method="POST">
						<div class="row">

							<div class="col-md-6">
							<div class="mb-4">
							 <label class="form-label" for="val-username">Start Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="signed_out_startDate" name="signed_out_startDate" >
						   </div>
						 </div>
	   
						   <div class="col-md-6">
						   <div class="mb-4">
							 <label class="form-label" for="val-username">End Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="signed_out_endDate"  name="signed_out_endDate" >
						   </div>
						 </div>
					 
						 </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-success" id="submit_signedout_Btn" type="button" >Submit <i class="fa fa-save"></i></button>
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</form>
		</div>
	</div>
</div>






<div class="modal fade" id="apps_signedout_within_dates_officers_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Signed Out Between <span class="text-success" id="startDate3"></span> and <span class="text-success" id="startDate4"></span></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="signedout_officer_startDate">
				<input type="hidden" id="signedout_officer_endDate">
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="apps_signedout_within_dates_officers_table" width="100%" cellspacing="0">
                    <!-- <table id="recievedtoday" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>








<div class="modal fade" id="load_apps_signedout_by_officers_by_date_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS SIGNED OUT BY <span id="staff_name72"></span> Between <span id="staff_date6"></span> and <span id="staff_end_date1"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="load_apps_signedout_by_officers_by_date_table" width="100%" cellspacing="0">

                    <!-- <table id="csau_staff_daily_apps_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Collected</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" id="bills_created_within_dates_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Bills Created Within Dates</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
				<form class="" method="POST">
						<div class="row">

							<div class="col-md-6">
							<div class="mb-4">
							 <label class="form-label" for="val-username">Start Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="bills_created_startDate" name="signed_out_startDate" >
						   </div>
						 </div>
	   
						   <div class="col-md-6">
						   <div class="mb-4">
							 <label class="form-label" for="val-username">End Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="bills_created_endDate"  name="signed_out_endDate" >
						   </div>
						 </div>
					 
						 </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-success" id="submit_bills_created_Btn" type="button" >Submit <i class="fa fa-save"></i></button>
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</form>
		</div>
	</div>
</div>




<div class="modal fade" id="apps_created_within_dates_officers_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Bills Created Between <span class="text-success" id="startDate5"></span> and <span class="text-success" id="startDate6"></span></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="signedout_officer_startDate">
				<input type="hidden" id="signedout_officer_endDate">
				<input type="hidden" id="created_mode">

				
				<label class="form-label" for="val-username">Please Select</label>
				<select class="form-control" id="select_bill_created">
					<option value='ALL BILLS'>All Bills</option>
			        <option value="PAID">Paid Bills</option>
					<option value="PAID AND ACK">Paid and Acknowledged Bills</option>
					<option value="NOT PAID">Not Paid Bills</option>
				</select><br><br>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="apps_created_within_dates_officers_table" width="100%" cellspacing="0">
                    <!-- <table id="recievedtoday" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Officer</th>
                            <th>Count</th>
                            <th>Action</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>







<div class="modal fade" id="today_bills_created_by_date_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">BILLS CREATED BY <span class="" id="staff_name60"></span></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="today_bills_created_by_date_table" width="100%" cellspacing="0">
                    <!-- <table id="today_bills_created_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Reference Number</th>
							<th>Payment Status</th>
							<th>Date Created</th>
                      </thead>
                          <tbody>        
                          </tbody>
                    </table>
                </div> 
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript" src="client_application/_function.js"></script>