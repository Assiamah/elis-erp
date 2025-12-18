
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>


<!-- Begin Page Content -->
<div class="container-fluid">




    <div id="acct_graph_data_values" style="display:none">${data}</div>
			
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
												
												<div class="form-group">
													<label>Main Service</label> 
													
													<select name="main_service_rpt" id="main_service_rpt"   class="form-control input-sm" data-style="btn-info"  required>
									                  <option value="-1">Select Main Service</option>
									                 
									                   <c:forEach items="${main_services}" var="main_service">
									                         <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  
									                   </c:forEach> 
									                 
									                </select>
												</div>
												<div class="form-group">
													<label>Sub Service</label> 
									                <select name="sub_service_rpt" id="sub_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true">
									                    <option value="-1">Select Sub Service</option>
									                </select>
													
												</div>
												
							                	<br>
												<div class="form-group">
													<button type = "submit" class="btn btn-dark btn-block">Apply Filter</button>
												</div>
												
					
											
										
										</form>
									</div>
								</div>
							</div>
					
							<div class="col-lg-9">
					
					
								<div class="row">
									<div class="col col-6">
										<!-- Card -->
										<div class="card bg-primary text-white">
											<div class="card-body">
					
												<h3 id="md_total_amt"> <fmt:formatNumber type = "number"   maxFractionDigits = "2"  value = "${total_count}" /></h3>
												<p>Applications at Division Registry</p>
					
											</div>
										</div>
									</div>
					
									<div class="col col-6">
										<!-- Card -->
										<div class="card bg-success">
											<div class="card-body">
					
												<h3 id="md_total_amt"><fmt:formatNumber type = "number"   maxFractionDigits = "2"  value = "${total_count}" /></h3>
												<p>Applications Completed</p>
					
											</div>
										</div>
									</div>
								</div>
								<!-- /.row -->
								<br>
								<div class="card">
									<div class="card-header bg-white">Applications at Milestones
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
			  
	

</div>
<!-- Container -->

<!-- /.container-fluid -->


<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript">


</script>



