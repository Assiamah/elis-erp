
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>





<style>

.blur-background {
    filter: blur(8px);
    transition: filter 0.3s ease; /* Smooth transition */
}


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
	
	</style>







<!-- Begin Page Content -->
<div class="container-fluid">




    <div id="acct_graph_data_values" style="display:none">${data}</div>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
			  <li class="nav-item">
			    <a class='text-uppercase nav-link  ${(active == "graph") ? " active bg-dark text-white" : "" }' id="summarize-tab" data-toggle="tab" href="#tab_summarized_revenue" role="tab"
			     aria-controls="tab_gra_payments" aria-selected="true">SUMMARIZED REVENUES PER SERVICE</a>
			  </li>
			  <li class="nav-item">
			    <a class='text-uppercase nav-link  ${(active == "trans") ? " active  bg-dark text-white" : "" }' id="profile-tab" data-toggle="tab" href="#tab_revenue" 
			    role="tab" aria-controls="profile" aria-selected="false">TRANSACTIONS REPORT</a>
			  </li>




			  <li class="nav-item">
			    <a class='text-uppercase nav-link bg-info text-white' id="new_summarize-tab" data-toggle="tab" href="#new_tab_revenue" 
			    role="tab" aria-controls="profile" aria-selected="false">REPORT PER BILL ITEM</a>
			  </li>



			  
			 
			</ul>
			<div class="tab-content" id="myTabContent">
			  <div class='tab-pane fade  ${(active == "graph")  ? "show active" : "" } ' id="tab_summarized_revenue" role="tabpanel" aria-labelledby="summarize-tab">
			  		<br>
			  		<div class="row">
						<div class="col-lg-3">
							<div class="card">
								<div class="card-header bg-white">
									<h1 class="h3 mb-0 text-gray-800">FILTER</h1>
				
									</div>
									<div class="card-body">
										<form method="post" >
										
					
										<div class="form-group">
											<label>Date</label>
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="fa fa-calendar-alt"></i></span>
												</div>
												<input type="date" class="form-control"
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="date_from" id="date_from" value="${date_from}">
											</div>
										</div>
										<div class="form-group ">
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="far fa-calendar-alt"></i></span>
												</div>
												<input type="date" class="form-control"
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="date_to" id="date_to" value="${date_to}">
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
											<label>Summarize by</label> 
											<select class="form-control filter" name="type" id="type" required>
												<option value="values" ${(type =="values") ? "selected='selected'":""}>Value</option>
												<option value="count"  ${(type =="count") ? "selected='selected'":""}>Count</option>
											</select>
										</div>
										<div class="form-group">
											<label>Division</label> <br>
											<select class="form-control filter" name="division" id="division" multiple required>
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
											</select>
										</div>
					           			<div class="form-group">
					                  			<label>Cut-Off Point on Graph</label>
					                  			<input type="number" step = "1" class="form-control" name = "limit" value="${limit}" min="3" id="limit" required>
					                	</div>
					                	<br>
										<div class="form-group">
											<button type = "submit"class="btn btn-dark btn-block">Apply Filter</button>
										</div>
										<br><br>
					
											<div class="form-group">
												<label>Export Type</label>
												
															<div class="input-group">
																<div id="rdb_export_type" class="btn-group">
																	<button class="btn btn-outline-dark  " 
																		data-toggle="export_type" data-title="PDF" 
																	> &nbsp; &nbsp; &nbsp; &nbsp; PDF &nbsp; &nbsp; &nbsp; &nbsp; </button> 
																	<button class="btn btn-outline-dark  "
																		data-toggle="export_type" data-title="CSV"
																	> &nbsp; &nbsp; &nbsp; &nbsp; CSV &nbsp; &nbsp; &nbsp; &nbsp; </button>
																</div>
																<input type="hidden" name="export_type" id="export_type">
															</div>
															
														
											</div>
											<div class="form-group">
												<button class="btn btn-outline-dark btn-block " id="btn_export_data">Export Data</button>
											</div>
										
										</form>
									</div>
								</div>
							</div>
					
							<div class="col-lg-9">
					
					
								<div class="row">
									<div class="col col-6">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt">GHS <fmt:formatNumber type = "number"  maxFractionDigits = "3" minFractionDigits = "2" value = "${total_amount}" /> </h3>
												<p>Total Amount</p>
					
											</div>
										</div>
									</div>
					
									<div class="col col-6">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="md_total_amt"><fmt:formatNumber type = "number"   maxFractionDigits = "2"  value = "${total_count}" /></h3>
												<p>Total Payment Count</p>
					
											</div>
										</div>
									</div>
								</div>
								<!-- /.row -->
								<br>
								<div class="card">
									<div class="card-header bg-white">Revenue per Service
										<ul class="float-right card-actions">
					                        <li><a href="#" class="card-btn" role="button" title="Toggle fullscreen">
					                        <i class="fas fa-expand-arrows-alt"></i></a></li>
					                    </ul>
									</div>
									<div class="card-body">
										<div id="main-echart" style="width: 100%; height:500px;"></div>
									</div>
								</div>
								
					
					
							</div>
							<!-- col -->
						</div>
						<!-- row -->
			  </div>








			  <div class='tab-pane fade  ${(active == "new_graph")  ? "show active" : "" } ' id="new_tab_revenue" role="tabpanel" aria-labelledby="new_summarize-tab">
				<br>
				


				<div class="container-fluid">				
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

				
				
						<div class="col-sm-4">
						  <div class="card">
							<div class="card-body">
								<label for="">Office Region</label> 
								<select id="sel_change_region_compliance" class="form-control selectpicker"  required>
										<option selected value="-1">-- select --</option>		
										<option  value="0">Nationwide</option>						
										<c:forEach items="${officeregionlist}" var="officeregion">
											<option  value="${officeregion.ord_region_code}" data-name="${officeregion.ord_region_name}">${officeregion.ord_region_name}</option>
				
										
								  </c:forEach>
											</select>
							</div>
						  </div>
						</div>
				
				
					
				
					
				
					  </div>
					  <br>
				
				
					  <input type="hidden" id="start_date">
					  <input type="hidden" id="end_date">
				
					  <input type="hidden" id="region_select">
				
				
					  
				
				
				
				
				<!--
					<ol class="breadcrumb">
						<li class="breadcrumb-item text-uppercase text-gray-800">Applications Count | year</li>
						 <li class="breadcrumb-item active">${unit_name}</li> 
					</ol>
				
					-->
				
					<div class="row">
						<!-- Application Received (Today) -->
						<div class="col-xl-6 col-md-6 mb-4" id="totalrevenue">
							<div class="card border-left-warning shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">  <span class="text-dark"></span>
												Total Revenue </div>
											<!-- <div class="text-xs  text-dark text-uppercase">today (
												<fmt:formatDate value="${now}" type="date" />)</div> -->
											<!-- <div id="total_revenue" class="h5 mb-0 font-weight-bold text-gray-800">GHS <fmt:formatNumber type = "number"  maxFractionDigits = "3" minFractionDigits = "2" value = "${total_amount}"></fmt:formatNumber>
											</div> -->
											<h3 id="total_revenue">GHS 0.00 </h3>
				
										</div>
										<div class="col-auto">
											<i class="fas fa-file fa-2x text-gray-300"></i>
										</div>
										<a href="#" data-method="summary_created" data-period="day" 
										data-url="DashboardDivisionSummary" data-icon="fa-file" 
										data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
										class="showDivisionModal text-decoration-none stretched-link">
										</a>
									</div>
									<hr>					  
								</div>
							</div>
							
						</div>
				
				
				
						<div class="col-xl-6 col-md-6 mb-4" id="totalTransactions">
							<div class="card border-left-info shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">  <span class="text-dark"></span>
												Total Transactions </div>
											<!-- <div class="text-xs  text-dark text-uppercase">today (
												<fmt:formatDate value="${now}" type="date" />)</div> -->
											
				
											<h3 id="total_transactions">0 </h3>
				
				
				
										</div>
										<div class="col-auto">
											<i class="fas fa-file fa-2x text-gray-300"></i>
										</div>
										<a href="#" data-method="summary_created" data-period="day" 
										data-url="DashboardDivisionSummary" data-icon="fa-file" 
										data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
										class="showDivisionModal text-decoration-none stretched-link">
										</a>
									</div>
									<hr>					  
								</div>
							</div>
						</div>
				
				
				
					
				
				
				
					
				
					</div>
				
				
				
				
				<div class="modal fade" id="sub_service_modal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="sub_service_modalLabel"></h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true"> <i class="fa fa-times"></i></span>
								</button>
							</div>
							<div class="modal-body">
								<div class="table-responsive">
									<table class="table table-bordered table-hover" id="sub_service_table" width="100%" cellspacing="0">
									<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
									   <thead>
											<th>Sub Service Name</th>
											<th>Amount</th>
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
				
				
				
				
				<div class="modal fade" id="bill_items" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="banks_modalLabel">Applications Recieved </h5>
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
												<h6 class="m-0 font-weight-bold text-black">Total :<span class="count text-primary" id="total_span1"></span>
												</h6>
											</div>
											<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
										</div>
									</div>
											
								</div>


								<div class="table-responsive">
									<input type="hidden" id="subprocessid">
									<input type="hidden" id="completed_subprocessid">
									<input type="hidden" id="service_to_bank_name">
									<table class="table table-bordered table-hover" id="banks_table" width="100%" cellspacing="0">
									<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
									   <thead>
											<th>Bill Item Name</th>
											<th>Amount</th>
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




			<div class="modal fade" id="bill_items_new" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="banks_modalLabel_1">Applications Recieved </h5>
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
												<h6 class="m-0 font-weight-bold text-black">Total :<span class="count text-primary" id="total_span2"></span>
												</h6>
											</div>
											<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
										</div>
									</div>
											
								</div>

								<div class="table-responsive">
									<input type="hidden" id="subprocessid">
									<input type="hidden" id="completed_subprocessid">
									<input type="hidden" id="service_to_bank_name">
									<table class="table table-bordered table-hover" id="banks_table_1" width="100%" cellspacing="0">
									<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
									   <thead>
											<th>Bill Item Name</th>
											<th>Amount</th>
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



		
					<div class="modal fade" id="bill_items_regional_modal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="bill_items_regional_Label"></h5>
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
												<h6 class="m-0 font-weight-bold text-black">Total :<span class="count text-primary" id="total_span"></span>
												</h6>
											</div>
											<!-- <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div> -->
										</div>
									</div>
											
								</div>


								<div class="table-responsive">
									<input type="hidden" id="subprocessid">
									<input type="hidden" id="completed_subprocessid">
									<input type="hidden" id="service_to_bank_name">
									<table class="table table-bordered table-hover" id="bill_items_regional_table" width="100%" cellspacing="0">
									<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
									   <thead>
											<th>Bill Item Name</th>
											<th>Amount</th>
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

					  
					
				
				
				
					<div class="modal fade" id="transactions_modal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-fullscreen" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="transactions_Label"></h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true"> <i class="fa fa-times"></i></span>
								</button>
							</div>
							<div class="modal-body">
								<div class="table-responsive">
									<table class="table table-bordered table-hover" id="transactions_table" width="100%" cellspacing="0">
									<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
									   <thead>
											<th>Applicant Name</th>
											<th>Job Number</th>
											<th>Application Type</th>
											<th>Bill Number</th>
											<th>Bill Amount</th>
											<th>Amount Paid</th>
											<th>GHANA.GOV Ref Number</th>
											<th>EGRC Number</th>
											<th>Payment Mode</th>
											<th>Payment Date</th>
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
				
				
				
				
				
				
				
				
				<div class="modal fade" id="job_numberbill_items" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="job_numberbillLabel"></h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true"> <i class="fa fa-times"></i></span>
								</button>
							</div>
							<div class="modal-body">
								<div class="table-responsive">
									<!-- <input type="text" id="ref_number" readonly>
									<input type="hidden" id="completed_subprocessid">
									<input type="hidden" id="service_to_bank_name"> -->
									<hr>
									
									<div class="form-group row">
									<div class="col-sm-6">
										  <label  class="form-label">Bill Number</label>
										<input type="text" id="bill_number" disabled class="form-control"  value="">
									  </div>
									  
									  <div class="col-sm-6">
										<label  class="form-label">Bill Amount</label>
										<input type="text" id="bill_amount" disabled class="form-control"  value="">
									  </div>
									</div>
									<div class="form-group row">
									  <label class="col form-label">Applicant Name</label>
									  <div class="col-sm-12">
										<input type="text" id="applicant_name" disabled class="form-control"  value="">
									  </div>
									</div>
				
				
									<table class="table table-bordered table-hover" id="job_numberbill_table" width="100%" cellspacing="0">
									<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
									   <thead>
											<th>Bill Item Name</th>
											<th>Amount</th>
											<!-- <th>Action</th> -->
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
				
				
				
					
				
				</div>


		</div>









			  
			  
			  
			  
			  <div class='tab-pane fade  ${(active == "trans") ? "show active" : "" } ' id="tab_revenue" role="tabpanel" aria-labelledby="payments-tab">
			  		<br>
			  		<div class="row">
						<div class="col-lg-3">
							<div class="card">
								<div class="card-header bg-white">
									<h1 class="h3 mb-0 text-gray-800">FILTER</h1>
				
									</div>
									<div class="card-body">
									 <form method="post" >
										
					
										<div class="form-group">
											<label>Date</label>
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="fa fa-calendar-alt"></i></span>
												</div>
												<input type="date" class="form-control"
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="t_date_from" id="t_date_from" value="${t_date_from}">
											</div>
										</div>
										<div class="form-group ">
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="far fa-calendar-alt"></i></span>
												</div>
												<input type="date" class="form-control"
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="t_date_to" id="t_date_to" value="${t_date_to}">
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
										<%-- <div class="form-group">
											<label>Summarize by</label> 
											<select class="form-control filter" name="type" id="type" required>
												<option value="values" ${(type =="values") ? "selected='selected'":""}>Value</option>
												<option value="count"  ${(type =="count") ? "selected='selected'":""}>Count</option>
											</select>
										</div> --%>
										<div class="form-group">
											<label>Division</label> <br>
											<select class="form-control filter" name="t_division" id="t_division" multiple required>
												<option value="PVLMD" 
												  <c:if test = "${fn:contains(t_division, 'PVLMD')}">
											        selected
											      </c:if>>PVLMD</option>
												<option value="SMD" 
												  <c:if test = "${fn:contains(t_division, 'SMD')}">
											        selected
											      </c:if>>SMD</option>
												<option value="LVD" 
												  <c:if test = "${fn:contains(t_division, 'LVD')}">
											        selected
											      </c:if>
												>LVD</option>
												<option value="LRD"  
												  <c:if test = "${fn:contains(t_division, 'LRD')}">
											        selected
											      </c:if>>LRD</option>
											</select>
										</div>
					           			<%-- <div class="form-group">
					                  			<label>Cut-Off Point on Graph</label>
					                  			<input type="number" step = "1" class="form-control" name = "limit" value="${limit}" min="3" id="limit" required>
					                	</div> --%>
					
											<!-- <div class="form-group">
												<label>Export Type</label>
												
															<div class="input-group">
																<div id="rdb_export_type_t" class="btn-group">
																	<button class="btn btn-outline-dark  " 
																		data-toggle="export_type" data-title="PDF" 
																	> &nbsp; &nbsp; &nbsp; &nbsp; PDF &nbsp; &nbsp; &nbsp; &nbsp; </button> 
																	<button class="btn btn-outline-dark  "
																		data-toggle="export_type" data-title="CSV"
																	> &nbsp; &nbsp; &nbsp; &nbsp; CSV &nbsp; &nbsp; &nbsp; &nbsp; </button>
																</div>
																<input type="hidden" name="t_export_type" id="t_export_type">
															</div>
															
														
											</div>
											<div class="form-group">
												<button class="btn btn-outline-dark btn-block " id="btn_export_data_t">Export Data</button>
											</div> -->
										<br>
										<div class="form-group">
											<button type = "submit" name = "transactions_form" value="1" class="btn btn-dark btn-block">Apply Filter</button>
										</div>
										</form>
									</div>
								</div>
							</div>

							

					
							<div class="col-lg-9">
					
					
								<div class="row">
									<div class="col col-6">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="mt_total_amt">GHS <fmt:formatNumber type = "number"  maxFractionDigits = "3" minFractionDigits = "2" value = "${t_total_amount}" /> </h3>
												<p>Total Amount</p>
					
											</div>
										</div>
									</div>
					
									<div class="col col-6">
										<!-- Card -->
										<div class="card ">
											<div class="card-body">
					
												<h3 id="mt_total_amt"><fmt:formatNumber type = "number"   maxFractionDigits = "2"  value = "${t_total_count}" /></h3>
												<p>Total Payment Count</p>
												
											</div>
										</div>
									</div>
								</div>
								<!-- /.row -->
								<br>
								<div class="card">
									<div class="card-header bg-white">Revenue Transactions list
										<ul class="float-right card-actions">
					                        <li><a href="#" class="card-btn" role="button" title="Toggle fullscreen">
					                        <i class="fas fa-expand-arrows-alt"></i></a></li>
					                    </ul>
									</div>
									<div class="card-body">
										<div id="seconday-echart" class="table-responsive">
										
											<table class="table table-bordered table-hover table-sm tbl_transactions_result" id="tbl_transactions_result">
												<thead>
													<tr>
														<th>Bill Number</th>
														<th>GOG Invoice No.</th>
														<th>Created Date</th>
														<th>Payment Date</th>
														<th>Bill Amount</th>
														<th>Payment Amount</th>
														<th>Payment Slip number</th>
														<th>Payment Mode</th>
														<th>Related Job number</th>
														<th>Application Type</th>
														<!-- <th>Division</th> -->
													</tr>
												</thead>
												<tbody>
													<c:forEach items='${t_applicationlist}' var="row">
													<tr>
														<td>${row.ref_number}</td>
														<td>${row.gog_invoice_number}</td>
														<td>${row.created_date}</td>
														<td>${row.payment_date}</td>
														<td>${row.bill_amount}</td>
														<td>${row.payment_amount}</td>
														<td>${row.payment_slip_number}</td>
														<td>${row.payment_mode}</td>
														<td>${row.job_number}</td>
														<td>${row.business_process_sub_name}</td>
													</tr>
													  <a:dropdownOption value="${category.key}">${category.key} </a:dropdownOption>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
					
					
							</div>



							<!-- col -->
						</div>
						<!-- row -->
			  </div>
			</div>
			  
	

</div>
<!-- Container -->

<!-- /.container-fluid -->


<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript" src="client_application/audit_report.js"></script>
<!-- <script>

</script> -->



<script type="text/javascript">


</script>



