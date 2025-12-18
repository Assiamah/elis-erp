
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>


<!-- Begin Page Content -->
<div class="container-fluid">




    <div id="acct_graph_data_values" style="display:none">${data}</div>

	<div class="row">
		<div class="col-lg-3">
			<div class="card">
				<div class="card-header bg-white">
					<h1 class="h3 mb-0 text-gray-800">STAMP DUTY PAYMENTS</h1>

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
					<%-- <div class="form-group">
						<label>Filter by</label> 
						<select class="form-control filter" name="type" id="type">
							<option value="values" ${(type =="values") ? "selected='selected'":""}>Value</option>
							<option value="count"  ${(type =="count") ? "selected='selected'":""}>Count</option>
						</select>
					</div>
           			<div class="form-group">
                  			<label>Cut-Off Point on Graph</label>
                  			<input type="number" step = "1" class="form-control" name = "limit" value="${limit}" min="3" id="limit">
                	</div> --%>

						<!-- <div class="form-group">
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
						</div> -->
					<br><br>
					<div class="form-group">
						<button type = "submit"class="btn btn-dark btn-block">Apply Filter</button>
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

							<h3>GHS <fmt:formatNumber type = "number"  maxFractionDigits = "3" minFractionDigits = "2" value = "${total_amount}" /> </h3>
							<p>Total Amount</p>

						</div>
					</div>
				</div>

				<div class="col col-6">
					<!-- Card -->
					<div class="card ">
						<div class="card-body">

							<h3><fmt:formatNumber type = "number"   maxFractionDigits = "2"  value = "${total_count}" /></h3>
							<p>Total Payment Count</p>

						</div>
					</div>
				</div>
			</div>
			<!-- /.row -->
			<br>
			<div class="card">
				<div class="card-header bg-white">Revenue transactions list
					<ul class="float-right card-actions">
                        <li><a href="#" class="card-btn" role="button" title="Toggle fullscreen">
                        <i class="fas fa-expand-arrows-alt"></i></a></li>
                    </ul>
                </div>
				<div class="card-body">
					<!-- <div id="main-echart" style="width: 100%; height:500px;"></div> -->
					<div class="table-responsive">
						<table class="table table-bordered table-hover table-sm data-table_" id="tbl_transactions_stp_result">
							<thead>
								<tr>
									<th>Bill Number</th>
									<th>Payment Ref</th>
									<th> Payment Date</th>
									<th>Applicant</th>
									<th>Amount</th>
									<th>Nature of Instrument</th>
									<th>Payment Mode </th>
									<th>Related Job</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items='${data}' var="rec">
								      <tr>
								      	<td>${rec.ref_number}</td>
								      	<td>${rec.payment_slip_number}</td>
								      	<td>${rec.payment_date}</td>
								      	<td>${rec.lessees_name} || ${rec.business_process_sub_name}</td>
								      	<td>${rec.payment_amount}</td>
										<td>${rec.nature_of_instrument}</td>
								      	<td>${rec.payment_mode}</td>
								      	<td>${rec.job_number}</td>
								      </tr>
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
<!-- Container -->

<!-- /.container-fluid -->


<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript">


</script>



