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
 <jsp:useBean id="now" class="java.util.Date"/>    


<!-- Division Modal-->
<!-- <div class="modal fade" data-position="0" id="divisionModal" tabindex="-1" role="dialog"
	aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"></div>
			</div>
		</div>
	</div>
</div> -->


<div class="modal fade" id="user_divisionModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Received  Today(
					<fmt:formatDate value="${now}" type="date" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4" id="user_division_today" >
                                    <div class="card border-left-primary shadow ">
                                            <div class="card-body">
                                              <div class="row no-gutters align-items-center">
                                               <div class="col mr-2">
                                                  <div id="user_division" class="text-xs font-weight-bold text-primary text-uppercase mb-1"></div>
                                                  <div id="div_count" class="h5 mb-0 font-weight-bold text-gray-800"></div>
                                                </div>
                                                <div class="col-auto">
                                                  <i class="fas fa-2x text-gray-300 ${iconClass}"></i>
                                                </div>
                                                <!-- <a href="#" data-method="${method}" data-period="${period}" data-by="service_type" data-url="${url}" data-type="${current.division}" data-title="${title}" data-date="${date}" class="showServiceTypeModal text-decoration-none stretched-link"> -->
                                      </a>
                                           </div>
                                            </div>
                                          </div>
                                        </div>
                    
                </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" id="user_divisionModal_this_month" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Received  This Month(
					<fmt:formatDate value="${now}" pattern="MMMM" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4" id="user_division_this_month">
                                    <div class="card border-left-primary shadow ">
                                            <div class="card-body">
                                              <div class="row no-gutters align-items-center">
                                               <div class="col mr-2">
                                                  <div id="user_division_month" class="text-xs font-weight-bold text-primary text-uppercase mb-1"></div>
                                                  <div id="div_count_month" class="h5 mb-0 font-weight-bold text-gray-800"></div>
                                                </div>
                                                <div class="col-auto">
                                                  <i class="fas fa-2x text-gray-300 ${iconClass}"></i>
                                                </div>
                                                <!-- <a href="#" data-method="${method}" data-period="${period}" data-by="service_type" data-url="${url}" data-type="${current.division}" data-title="${title}" data-date="${date}" class="showServiceTypeModal text-decoration-none stretched-link"> -->
                                      </a>
                                           </div>
                                            </div>
                                          </div>
                                        </div>
                    
                </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" id="user_completed_divison_today" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Completed  Today(
					<fmt:formatDate value="${now}" type="date" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4" id="completed_today_service" >
                                    <div class="card border-left-primary shadow ">
                                            <div class="card-body">
                                              <div class="row no-gutters align-items-center">
                                               <div class="col mr-2">
                                                  <div id="user_division_completed_today" class="text-xs font-weight-bold text-primary text-uppercase mb-1"></div>
                                                  <div id="div_count_completed_toda" class="h5 mb-0 font-weight-bold text-gray-800"></div>
                                                </div>
                                                <div class="col-auto">
                                                  <i class="fas fa-2x text-gray-300 ${iconClass}"></i>
                                                </div>
                                                <!-- <a href="#" data-method="${method}" data-period="${period}" data-by="service_type" data-url="${url}" data-type="${current.division}" data-title="${title}" data-date="${date}" class="showServiceTypeModal text-decoration-none stretched-link"> -->
                                      </a>
                                           </div>
                                            </div>
                                          </div>
                                        </div>
                    
                </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>







<div class="modal fade" id="user_completed_divison_month" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Completed  This Month(
					<fmt:formatDate value="${now}" pattern="MMMM" />) </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4" id="completed_month_service" >
                                    <div class="card border-left-primary shadow ">
                                            <div class="card-body">
                                              <div class="row no-gutters align-items-center">
                                               <div class="col mr-2">
                                                  <div id="user_division_completed_month" class="text-xs font-weight-bold text-primary text-uppercase mb-1"></div>
                                                  <div id="div_count_completed_momth" class="h5 mb-0 font-weight-bold text-gray-800"></div>
                                                </div>
                                                <div class="col-auto">
                                                  <i class="fas fa-2x text-gray-300 ${iconClass}"></i>
                                                </div>
                                                <!-- <a href="#" data-method="${method}" data-period="${period}" data-by="service_type" data-url="${url}" data-type="${current.division}" data-title="${title}" data-date="${date}" class="showServiceTypeModal text-decoration-none stretched-link"> -->
                                      </a>
                                           </div>
                                            </div>
                                          </div>
                                        </div>
                    
                </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</div>
	</div>
</div>



<!-- Application Type Modal-->
<div class="modal fade" data-position="0" id="serviceTypeModal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
                <h5 class="modal-title" id="serviceTypeModalLabel"></h5> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="created_by_services_today" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>











<div class="modal fade" data-position="0" id="completedTodayserviceTypeModal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
                <h5 class="modal-title" id="completedTodayserviceTypeModalLabel"></h5> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="completed_serviceType_Table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>





<div class="modal fade" data-position="0" id="completedMonthserviceTypeModal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
                <h5 class="modal-title" id="completedMonthserviceTypeModalLabel"></h5> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="completed_MonthserviceType_Table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" data-position="0" id="serviceTypeModalMonth" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
                <h5 class="modal-title" id="serviceTypeModalLabelMonth"></h5> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="created_by_services_month" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- Units Modal-->
<div class="modal fade" data-position="0" id="unitModal" tabindex="-1" role="dialog"
	aria-labelledby="unitModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelCompletedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="apps_past_due_unit" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                   }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Unit</th>
										<th>Count</th>
										<th >Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Officers Modal-->
<div class="modal fade" data-position="0" id="officerModal" tabindex="-1" role="dialog"
	aria-labelledby="officerModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="officerModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">

                    <a class="dropdown-item sendMessage" href="#">Send Message</a>

					<div class="row">
						<div class="col-12 table-responsive">
							<table id="past_due_officers_table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th >Officer</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" data-position="0" id="apps_recieved_year_modal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelRecievedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="apps_recieved_year_table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" data-position="0" id="apps_recieved_completed_year_modal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelRecievedCompletedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="apps_recieved_completed_year_table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" data-position="0" id="apps_completed_year_modal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelCompletedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="apps_completed_year_table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>



<!-- Applications Modal-->

<div class="modal fade" data-position="0" id="applicationsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Date Received by Officer</th>
										<th>Pending Days</th>
										<th>Days With Officer</th>
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<!-- <th>Action</th> -->
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>








<div class="modal fade" data-position="0" id="applicationsModalRecievedMonth" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelRecievedMonth"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_month_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Date Received by Officer</th>
										<th>Pending Days</th>
										<th>Days With Officer</th>
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<!-- <th>Action</th> -->
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>







<div class="modal fade" data-position="0" id="applicationsModalRecievedYear" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelRecievedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_year_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Date Received by Officer</th>
										<th>Pending Days</th>
										<th>Days With Officer</th>
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<!-- <th>Action</th> -->
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>










<div class="modal fade" data-position="0" id="applicationsModalCompletedToday" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelCompletedToday"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_completed_today_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<!-- <th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th> -->

										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Completed Date </th>
										<th>TAT</th>
					
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" data-position="0" id="applicationsModalCompletedMonth" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelCompletedMonth"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_completed_month_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<!-- <th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th> -->

										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Completed Date </th>
										<th>TAT</th>
					
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" data-position="0" id="applicationsModalRecievedCompletedYear" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelRecievedCompletedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_created_completed_year_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<!-- <th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th> -->

										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Completed Date </th>
										<th>TAT</th>
					
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" data-position="0" id="applicationsModalCompletedYear" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelCompletedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="view_applications_completed_year_by_service_type" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<!-- <th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th> -->

										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Completed Date </th>
										<th>TAT</th>
					
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" data-position="0" id="new_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="due_date" data-data="due_date">Date Received by Officer</th>
										<th data-name="days_due" data-data="days_due">Pending Days</th>
										<th data-name="days_since_batched" data-data="days_since_batched">Days With Officer</th>
										<th data-name="job_purpose" data-data="job_purpose">Purpose</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>











<div class="modal fade" data-position="0" id="completedapplicationsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>




<!-- Send Message Modal-->
<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="message-form" action="SendComplianceMessage">
					<input id="officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="query">Query</option>
				    	<option value="Warning">Warning</option>
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" data-position="0" id="sendMessageModal_FocalCompliance" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel_FocalCompliance"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="message-form_focal_complaince" action="SendComplianceMessage">
					<input id="focal_officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_focal_person_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="message">Message</option>
				    	<!-- <option value="Warning">Warning</option> -->
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>













<div class="modal fade" data-position="0" id="past_due_apps_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="past_due_apps_Label"></h5>
                <!-- <button class="btn btn-primary ml-auto" id="send_message" type="button">Send Message</button> -->
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="past_due_apps_with_staff" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Date Received by Officer</th>
										<th>Pending Days</th>
										<th>Days With Officer</th>
										<th>Purpose</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>








<div class="modal fade" data-position="0" id="apps_with_division_officers_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="apps_with_division_officers_Label"></h5>
                <!-- <button class="btn btn-primary ml-auto" id="send_message" type="button">Send Message</button> -->
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table id="apps_with_division_officers_table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Date Received by Officer</th>
										<th>Pending Days</th>
										<th>Days With Officer</th>
										<th>Purpose</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>
