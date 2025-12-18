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
	<h1 class="h3 mb-4 text-gray-800">CSAU Backoffice Monitoring Dashboard</h1>


    <ol class="breadcrumb">
		<li class="breadcrumb-item text-uppercase text-gray-800">Further Entries</li>
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>

	<input type="hidden" id="csau_manager_regional_code" value="${regional_code}" />


	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_recieved_today">
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
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_recieved_week">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Received
							</div>
							<div class="text-xs  text-dark text-uppercase">this WEEK</div>

							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${recieved_week}</div>
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


        <!-- Application Received (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_recieved_month">
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
						<a href="#" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>

			</div>
		</div>


		<!-- Application Completed (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_recieved_year">
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
						<a href="#" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>

	</div>
   

    <div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_worked_on_today">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1"> Applications Worked On</div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${further_entries_workedon_today}
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
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_worked_on_week">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">  Applications Worked On</div>
							<!-- <div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
                                <div class="text-xs  text-dark text-uppercase">this WEEK</div>
                                <div class="row no-gutters align-items-center">
                                    <div class="col-auto">
                                        <div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${further_entries_workedon_week}</div>
                                    </div>
    
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

		<!-- Application Completed (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="further_entries_worked_on_month">
			<div class="card border-left-danger shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-danger text-uppercase mb-1">  Applications Worked On
							</div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
                                    <div class="text-xs  text-dark text-uppercase">this month (
                                        <fmt:formatDate value="${now}" pattern="MMMM" />)</div>
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${further_entries_workedon_month}</div>
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

        <div class="col-xl-3 col-md-6 mb-4" id="further_entries_worked_on_year">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications Worked On</div>
							<div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="YYYY" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${further_entries_workedon_year}
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- Application Completed (Monthly) -->
		
	</div>

    <hr>

    <ol class="breadcrumb">
          <li class="breadcrumb-item text-uppercase text-gray-800">Batching | Cabinet</li>
          <!-- <li class="breadcrumb-item active">${unit_name}</li> -->
      </ol>
    <!-- Signout Monitoring -->
   
    <div class="row">

		<div class="col-xl-3 col-md-6 mb-4" id="batching_apps_worked_on_today">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1"> Applications Worked On</div>
							<div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${further_entries_workedon_today}
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
		<div class="col-xl-3 col-md-6 mb-4" id="batching_apps_worked_on_thisweek">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">  Applications Worked On</div>
							<!-- <div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
                                <div class="text-xs  text-dark text-uppercase">this WEEK</div>
                                <div class="row no-gutters align-items-center">
                                    <div class="col-auto">
                                        <div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${further_entries_workedon_week}</div>
                                    </div>
    
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
		<div class="col-xl-3 col-md-6 mb-4" id="batching_apps_worked_on_month">
			<div class="card border-left-danger shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-danger text-uppercase mb-1">  Applications Worked On
							</div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
                                    <div class="text-xs  text-dark text-uppercase">this month (
                                        <fmt:formatDate value="${now}" pattern="MMMM" />)</div>
									<div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${further_entries_workedon_month}</div>
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

        <div class="col-xl-3 col-md-6 mb-4" id="batching_apps_worked_on_year">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications Worked On</div>
							<div class="text-xs  text-dark text-uppercase">this year (
								<fmt:formatDate value="${now}" pattern="YYYY" />)</div>
							<div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${further_entries_workedon_year}
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- Application Completed (Monthly) -->
		
	</div>



  
    <hr>		
		
		
		</div>
		

		
		</div>

		
	</div>

	</div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->


<!-- Further Entries recieved today modal -->

<div class="modal fade" id="further_entries_recieved_today_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED TODAY </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_recieved_today_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_recieved_today_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
						   <th>Division</th>
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




<!-- Further Entries recieved week modal -->

<div class="modal fade" id="further_entries_recieved_week_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED THIS WEEK </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_recieved_week_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_recieved_week_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
						<th>Division</th>
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




<!-- Further Entries recieved month modal -->


<div class="modal fade" id="further_entries_recieved_month_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED THIS MONTH </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_recieved_month_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_recieved_month_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
						<th>Division</th>
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




<!-- Further Entries recieved year modal -->

<div class="modal fade" id="further_entries_recieved_year_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED THIS YEAR </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_recieved_year_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_recieved_year_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
						<th>Division</th>
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








<div class="modal fade" id="batching_apps_worked_on_today_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On Today</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="batching_apps_worked_on_today_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_today_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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






<div class="modal fade" id="batching_apps_worked_on_thisweek_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On this Week</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="batching_apps_worked_on_thisweek_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisweek_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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







<div class="modal fade" id="batching_apps_worked_on_thismonth_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On This Month</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="batching_apps_worked_on_thismonth_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thismonth_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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






<div class="modal fade" id="batching_apps_worked_on_thisyear_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On This Year</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="batching_apps_worked_on_thisyear_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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







<!-- Back Offier Daily appications batched to cabinet  modal -->
<div class="modal fade" id="view_daily_apps_batched_tocabinet_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name1"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_daily_apps_batched_tocabinet_table" width="100%" cellspacing="0">
                    <!-- <table id="view_daily_apps_batched_tocabinet_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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





<div class="modal fade" id="view_weekly_apps_batched_tocabinet_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name2"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_weekly_apps_batched_tocabinet_table" width="100%" cellspacing="0">
                    <!-- <table id="view_weekly_apps_batched_tocabinet_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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








<div class="modal fade" id="view_monthly_apps_batched_tocabinet_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name3"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_monthly_apps_batched_tocabinet_table" width="100%" cellspacing="0">
                    <!-- <table id="view_monthly_apps_batched_tocabinet_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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





<div class="modal fade" id="view_yearly_apps_batched_tocabinet_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name4"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_yearly_apps_batched_tocabinet_table" width="100%" cellspacing="0">
                    <!-- <table id="view_yearly_apps_batched_tocabinet_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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







<!-- Futher Entries Worked on -->
<div class="modal fade" id="further_entries_worked_on_today_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On Today</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="further_entries_worked_on_today_table" width="100%" cellspacing="0">
				<!-- <table id="further_entries_worked_on_today_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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




<div class="modal fade" id="further_entries_worked_on_week_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On Today</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="further_entries_worked_on_week_table" width="100%" cellspacing="0">
				<!-- <table id="further_entries_worked_on_week_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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





<div class="modal fade" id="further_entries_worked_on_month_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On Today</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="further_entries_worked_on_month_table" width="100%" cellspacing="0">
				<!-- <table id="further_entries_worked_on_month_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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




<div class="modal fade" id="further_entries_worked_on_year_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">Applications Worked On Today</h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="further_entries_worked_on_year_table" width="100%" cellspacing="0">
				<!-- <table id="further_entries_worked_on_year_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
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







<!-- Futher Entries Applications worked on today Modal-->

<div class="modal fade" id="further_entries_workedon_today_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name5"></span> </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_workedon_today_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_workedon_today_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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






<!-- Futher Entries Applications worked on Week Modal-->

<div class="modal fade" id="further_entries_workedon_week_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name6"></span> </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_workedon_week_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_workedon_week_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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




<!-- Futher Entries Applications worked on Month Modal-->

<div class="modal fade" id="further_entries_workedon_month_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name7"></span> </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_workedon_month_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_workedon_month_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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







<!-- Futher Entries Applications worked on Year Modal-->

<div class="modal fade" id="further_entries_workedon_year_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WORKED ON BY <span id="staff_name8"></span> </h5>
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
					<table class="table table-bordered table-hover" id="further_entries_workedon_year_table" width="100%" cellspacing="0">
                    <!-- <table id="further_entries_workedon_year_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Worked on</th>
							<th>Job Status</th>
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









<div class="modal fade" id="view_divisional_today_data_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="division_name"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_divisional_today_data_table" width="100%" cellspacing="0">
                    <!-- <table id="view_divisional_today_data_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
							<th>Age of Application</th>
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




<div class="modal fade" id="view_divisional_week_data_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="division_name1"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_divisional_week_data_table" width="100%" cellspacing="0">
                    <!-- <table id="view_divisional_week_data_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
							<th>Age of Application</th>
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





<div class="modal fade" id="view_divisional_month_data_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="division_name2"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_divisional_month_data_table" width="100%" cellspacing="0">
                    <!-- <table id="view_divisional_month_data_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
							<th>Age of Application</th>
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




<div class="modal fade" id="view_divisional_year_data_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS RECIEVED BY <span id="division_name3"></span> </h5>
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
					<table class="table table-bordered table-hover" id="view_divisional_year_data_table" width="100%" cellspacing="0">
                    <!-- <table id="view_divisional_year_data_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
							<th>Date Created</th>
							<th>Age of Application</th>
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
<script type="text/javascript" src="client_application/_function_backoffice_monitoring.js"></script>

