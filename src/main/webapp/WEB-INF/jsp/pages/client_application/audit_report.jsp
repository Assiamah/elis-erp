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
    .blur-background {
    filter: blur(8px);
    transition: filter 0.3s ease; /* Smooth transition */
}
</style>


<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h4 class="mb-4 text-lg text-gray-800">Financial Report Dashboard <span id="region_type"></span></h4>

	<div class="row">

		<div class="col-sm-4">
			<div class="card">
			  <div class="card-body">
				  <label for="">Date Range</label> 
				  <div id="reportrange" style="background: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 80%">
					<i class="fa fa-calendar"></i>&nbsp;
					<span></span> <i class="fa fa-caret-down"></i>
				</div>
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
                            <!-- <th>Count</th> -->
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
                <div class="table-responsive">
                    <input type="hidden" id="subprocessid">
                    <input type="hidden" id="completed_subprocessid">
                    <input type="hidden" id="service_to_bank_name">
                    <table class="table table-bordered table-hover" id="banks_table" width="100%" cellspacing="0">
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
<!-- /.container-fluid -->
<!-- End of Main Content -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript" src="client_application/audit_report.js"></script>
