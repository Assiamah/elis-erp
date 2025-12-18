
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>


<!-- Begin Page Content -->
<div class="container-fluid">
    <div id="acct_graph_data_values" style="display:none">${data}</div>
			
			<div class="row">
						<div class="col-lg-3">
							<div class="card">
								<div class="card-header bg-white">
									<h1 class="h3 mb-0 text-gray-800">FILTER GROUND RENT</h1>
				
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
										<%-- <div class="form-group">
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
										</div> --%>
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
									<div class="card-header bg-white">Ground Rent Payments list
										<ul class="float-right card-actions">
					                        <li><a href="#" class="card-btn" role="button" title="Toggle fullscreen">
					                        <i class="fas fa-expand-arrows-alt"></i></a></li>
					                    </ul>
									</div>
									<div class="card-body">
										<div id="seconday-echart" class="table-responsive">
										
											<table class="table table-bordered table-hover table-sm data-table_" id="tbl_transactions_result">
												<thead>
													<tr>
														<th>Bill Number</th>
														<th>Bill Date</th>
														<th>Payment Date</th>
														<th>Bill Amount</th>
														<th>Payment Amount</th>
														<th>Payment Slip number</th>
														<th>Invoice Number</th>
														<th>Payment Mode</th>
														<th>Plot Details</th>
														<th>Updated Status</th>
														<th>Action</th>
														<!-- <th>Division</th> -->
													</tr>
												</thead>
												<tbody>
													<c:forEach items='${t_applicationlist}' var="row">
													<tr <c:if test = "${fn:contains(row.is_sync, '1')}"> class="tr-completed-work" </c:if> >
														<td>${row.ref_number}</td>
														<td>${row.created_date}</td>
														<td>${row.payment_date}</td>
														<td>${row.bill_amount}</td>
														<td>${row.payment_amount}</td>
														<td>${row.payment_slip_number}</td>
														<td>${row.gog_invoice_number}</td>
														<td>${row.payment_mode}</td>
														<td>${row.business_process_sub_name}</td>
														<td>
															<c:if test = "${fn:contains(row.is_sync, '1')}">
														        <span class="badge badge-success">Recorded</span>
														     </c:if>
														     <c:if test = "${fn:contains(row.is_sync, '0')}">
														        <span class="badge badge-danger">Not Updated</span>
														     </c:if>
														</td>
														<td>
															<c:if test = "${fn:contains(row.is_sync, '0')}">
														        <button class="btn btn-primary set_as_recorded" 
														        data-ref_number="${row.ref_number}">Set as Updated</button>
														     </c:if> &nbsp;
														</td>
														
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
	

</div>
<!-- Container -->

<!-- /.container-fluid -->


<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript">


</script>



