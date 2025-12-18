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

<jsp:include page="../CICA/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
			<div class="row">
						<div class="col-lg-3">
							<div class="card">
								<div class="card-header bg-white">
									<h1 class="h3 mb-0 text-gray-800">FILTER</h1>
				
									</div>
									<div class="card-body">
										<form method="post" id="cica_reports_form" >
										
					
										<div class="form-group">
											<label>Date</label>
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="fa fa-calendar-alt"></i></span>
												</div>
												<%-- <input type="date" class="form-control"
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="date_from" id="start_date" value="${date_from}" required> --%>
												<input type="date" class="form-control" id="start_date" name="start_date" required>
											</div>
										</div>
										<div class="form-group ">
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="far fa-calendar-alt"></i></span>
												</div>
												<%-- <input type="date" class="form-control"
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="date_to" id="end_date" value="${date_to}" required> --%>
												<input type="date" class="form-control" id="end_date" name="end_date" required>
											</div>
										</div>
										<!-- <div class="form-group">
											<label>Transaction Type</label>
											<div class="input-group">
												<div class="input-group-prepend">
													<button type="button" class="btn btn-danger">Volume</button>
												</div>
												<button type="button" class="btn btn-danger">Count</button>
											</div>
										</div> -->
										<div class="form-group">
											<label>Purpose</label> 
											<select class="form-control filter" name="purpose" id="purpose" required>
												<option disabled selected>-- select --</option>
									            <option value="1">Service Enquiry</option>
												<option value="2">Other Enquiry</option>
												<option value="3">Service Complaint</option>
												<option value="4">Non Service Complaint</option>	
											</select>
										</div>
										<div id="purpose_div">
										<div class="form-group">
											<label>Status</label> 
											<select class="form-control filter" name="status" id="status" required>
												<option disabled selected value="0">-- select --</option>
												<option value="4">All</option>
									            <option value="0">Open</option>
												<option value="2">Pending</option>
												<option value="1">On Hold</option>
												<option value="3">Resolved</option>	
											</select>
										</div>
										<div class="form-group">
											<label>Division</label> <br>
											<select class="form-control filter" name="division" id="division" required>
												<option value="ALL">ALL</option>
												<option value="PVLMD" 
												  <c:if test = "${fn:contains(division, 'PVLMD')}">
											        selected
											      </c:if>>PVLMD</option>
												<option value="SMD" 
												  <c:if test = "${fn:contains(division, 'SMD')}">
											        selected
											      </c:if>>SMD</option>
												<option value="LVD" 
												  <c:if test = "${fn:contains(division, 'LVD')}">
											        selected
											      </c:if>
												>LVD</option>
												<option value="LRD"  
												  <c:if test = "${fn:contains(division, 'LRD')}">
											        selected
											      </c:if>>LRD</option>
											    <!-- <option disabled selected>-- select --</option>
											    <option value="ALL">ALL</option>
											    <option value="PVLMD">PVLMD</option>
												<option value="SMD">SMD</option>
												<option value="LVD">LVD</option>	
												<option value="LRD">LRD</option>
												<option value="CORPORATE">CORPORATE</option> -->
											</select>
										</div>
										<div class="form-group">
											<label>Region</label> 
											<!-- <select id="region_id" name="region_id" data-live-search="true" class="form-control selectpicker" required> 
								
								<option disabled selected value="0">-- select --</option>
								 <option value="0">All Regions</option>
				                 <option value="11">Greater Accra</option>
								<option value="14">Western</option>
								<option value="19">Volta</option>	
								<option value="12">Eastern</option>	
								<option value="13">Ashanti</option>	
								<option value="15">Central</option>	
								<option value="6">Northern</option>	
								<option value="7">Upper East</option>	
								<option value="8">Upper West</option>	
								<option value="11">Tema</option>
								<option value="22">Oti</option>	
								<option value="23">Bono East</option>	
								<option value="24">Ahafo</option>	
								<option value="2">Bono</option>	
								<option value="5">North East </option>	
								<option value="26">Savannah</option>
								<option value="21">Western North</option>

							</select> -->

							<select
									name="region_id"
									id="region_id"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Office Region</option>
									<option value="0">All Regions</option>
									<c:forEach items="${officeregionlist}" var="officeregion">
										<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
							  </c:forEach>
			 
								</select>
										</div>
										</div>
					           		
										<div class="form-group mt-5">
											<button type ="submit" class="btn btn-dark btn-block" id="apply_filter">Apply Filter</button>
										</div>
										<br><br>
					
											
										<!-- 	<div class="form-group">
												<button class="btn btn-outline-dark btn-block " id="btn_export_data">Export Data</button>
											</div>  -->
										
										</form>
									</div>
								</div>
							</div>
					
							<div class="col-lg-9">
					
					
								<div class="row mb-4" id="div_status">
									<div class="col col-4">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">Total</h3>
												<span class="text-danger h5" id="total"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">Open</h3>
												<span class="text-danger h5" id="open"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">Pending</h3>
												<span class="text-danger h5" id="pending"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">On-hold </h3>
												<span class="text-danger h5" id="hold"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">Resolved </h3>
												<span class="text-danger h5" id="resolved"></span>
											</div>
										</div>
									</div>
									
								</div>
								
								<div class="row d-none mb-4" id="div_division">
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">TOTAL</h3>
												<span class="text-danger h5" id="total_d"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">PVLMD</h3>
												<span class="text-danger h5" id="pvlmd"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">LRD</h3>
												<span class="text-danger h5" id="lrd"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">SMD </h3>
												<span class="text-danger h5" id="smd"></span>
											</div>
										</div>
									</div>
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">LVD </h3>
												<span class="text-danger h5" id="lvd"></span>
											</div>
										</div>
									</div>
									
									<div class="col col-2">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">CORP. </h3>
												<span class="text-danger h5" id="corporate"></span>
											</div>
										</div>
									</div>
									
								</div>
								<div class="card" id="cica_chart">
									<div class="card-header bg-white">Service Related Complaints
										<ul class="float-right card-actions">
					                        <li><a href="#" class="card-btn" role="button" title="Toggle fullscreen">
					                        <i class="fas fa-expand-arrows-alt"></i></a></li>
					                    </ul>
									</div>
									<div class="card-body">
										<div class="chart">
						                   <div id="barChart"></div>
						                </div>
									</div>
								</div>
								
					
					
							</div>
							<!-- col -->
						<%-- </div>
						<!-- row -->
						<div class="row"> --%>
						<div class="col-lg-12 mt-4">
						<div class="card">
							<div class="card-body">
			                	  <h5 class="card-title">CAC Reports<span id="card_title"> </span></h5>
								  <div class="mt-2 mb-2 d-none" id="_show_column">
									<button onclick="togglePhoneColumn(3)" class="btn btn-danger">Phone :<span id="_phone_option_status">On</span></button>
									  <button onclick="toggleEmailColumn(4)" class="btn btn-danger">Email :<span id="_email_option_status">On</span></button>
									  <!-- <button onclick="toggleSexColumn(5)" class="btn btn-danger">Sex</button> -->
								  </div>
			                  <%-- <div class="tab-content mt-4">
							            <div id="" class="table-responsive">
							                <table class="table " id="table_list" width="100%" cellspacing="0" >
			              						<thead>
												    <tr>
												        <th>Ticket ID</th>
												        <th>Purpose</th>
												        <th>Client Name</th>										        
												        <th>Subject</th>
												        <th>Description</th>
												        <th>Phone Number</th>
												        <th>Email</th>
												        <th>Region</th>
												        <th>Unit</th>										        
												        <th>Created By</th>
												        <th>Date Created</th>
												    </tr>
												  </thead>
												  <tbody id="table_body">
												    
												  </tbody>
				                   	        </table>
							            </div>
							    </div> --%>
							    <div class="tab-content mt-4" id="service_tbl">
					            	<div class="table-responsive">
					                <table class="table " id="table_list"  width="100%" cellspacing="0">
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Ticket No.</th>
										        <th>Name</th>

												<th>Phone</th>
										        <th>Email</th>

										        <th>Purpose</th>
										        <th>Subject</th>
										        <th class="text-center">Status</th>											        
										        <th class="text-center">Priority</th>
										        <th>Division</th>									        
										        <th>Region</th>
										        <th>Created By</th>
										        <th>Date Created</th>
												<th>Date Completed</th>
										    </tr>
										  </thead>
										  <tbody id="table_body">
										    
										  </tbody>
		                   	        </table>
					            </div>
					            </div>
					            <div class="tab-content mt-4" id="other_service_tbl">
					            	<div class="table-responsive">
					                <table class="table " id="other_table_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Ticket No.</th>
										        <th>Name</th>

										        <th>Phone</th>
										        <th>Email</th>

										        <th>Reference Source</th>											        
										        <th>Milestone Status</th>	
										        <th>Nature of Enquiry</th>						        
										        <th>Region</th>
										        <th>Created By</th>
										        <th>Date Created</th>
												<th>Date Completed</th>
										    </tr>
										  </thead>
										  <tbody id="table_body">
										    
										  </tbody>
		                   	        </table>
					            </div>
					    	</div>
			                </div>
						</div>
						</div>

	</div>
	
	</div>
<!-- End Page Content -->

<jsp:include page="../CICA/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="CICA/includes/pages_script/cica_dashboard.js"></script>
<script type="text/javascript" src="CICA/includes/js/bar_chart.js"></script>
<script src="legal/includes/apexcharts/apexcharts.min.js"></script>
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