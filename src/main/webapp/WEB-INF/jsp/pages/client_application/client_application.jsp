
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>


<%
	
%>




<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		

		<div class="row">
			<div class="col-lg-6">
				<!-- Example Bar Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Service Selection
					</div>
					<div class="card-body">
						<form action="${pageContext.request.contextPath}/bill_switcher"
							method="post">


							<div class="form-group">
								<!-- <label for="main_service">Main Service</label> -->
								<select name="main_service_cp" id="main_service_cp"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									
									
									<option value="-1">Select Main Service</option>
									
                <c:forEach items="${main_services}" var="main_service">
                  
               
                   <c:if test="${main_service.business_process_on_case == 'No'}"> 
                          <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option> 
                    <%-- <p>Welcome, <c:out value="${nm }"/></p> --%>
                    </c:if>  
                   
                   
                  
                  
                     
                  </c:forEach>
									
								</select>
							</div>
							<div class="form-group">
								<!--  <label for="sub_service">Sub Service</label> -->
								<select name="sub_service_cp" id="sub_service_cp"
									class="form-control input-sm">
									<option value="-1">Select Sub Service</option>
									
								</select>
							</div>

							<!-- 	<input type="submit" name="save" class="next btn btn-info" value="Proceed" /> -->

							<%-- <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addNewserviceBillModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                  		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Add New Service</span>
                  	</button> --%>

						</form>

					</div>
					<!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
				</div>



			</div>



			<!--   Here is the right Table -->
			<div class="col-lg-3">
				<!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i> Processing After Payment
					</div>
					<div class="card-body">
						<!--  The Form starts here -->
						<%--  <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
 --%>
						<div class="form-group">
									<!--   <label for="job_number">Job Number</label> -->
									<input class="form-control" id="txt_job_number_after_payment"
										name="job_number" type="text" aria-describedby="nameHelp"
										placeholder="Enter Reference Number" required>
										</div>
								<div class="form-group">
									<button class="btn btn-primary btn-block"
										id="btn_load_job_details_after_payment">
										<span
											class="text" >Search</span>
									</button>
									
									<!-- 
									 <button type="button" name="btn_generate_cagd_receipt" id="btn_generate_cagd_receipt" class="btn  btn-primary btn-icon-split "  >
										    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">CAGD</span>
										    		</button> -->

								</div>
					</div>
				</div>
				<!--   Here is the end of right table -->

			</div>
			<div class="col-lg-3">

						<form action="${pageContext.request.contextPath}/front_office_case_add_on" method="post">
						<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i> Processing Job on Existing Case
					</div>
					<div class="card-body">
						<div class="form-group">
						
									<input class="form-control" id="search_text"
										name="search_text" type="text" aria-describedby="nameHelp"
										placeholder="Enter Case Number" required>
								</div>						
								<div class="form-group">
								
									<button type="submit" class="btn btn-info  btn-block"
										id="btn_load_job_details_after_payment">
										<span
											class="text">Search</span>
									</button>
								</div>
					</div>
				</div>
			
						</form>
						<!--   </form> -->

						<!-- The form Ends Hers -->

					</div>

				

			</div>





		</div>







		<div class="row">
			<div class="col-lg-12">
				<!-- Example Bar Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fas fa-list-ul"></i>Received Application for First time
						Batch <span class="col-md-6 float-right ">


							<div class="form-group">
								<table style="width: 100%">
									<tr>
										<td><label for="main_service">Officers</label></td>
										<td><input class="form-control" id="user_to_send_to"
											name="user_to_send_to" type="text"
											aria-describedby="nameHelp" list="listofusers"
											class="autocomplat" placeholder="Enter Username" required>
											<datalist id="listofusers">

												<c:forEach items="${userlist}" var="user">
													<option data-value="${user.userid}" value="${user.fullname}"></option>
										  </c:forEach>
										  
											</datalist></td>
										<td>
											<button class="btn btn-success btn-icon-split float-right "
												id="btnProcessFirstTimeBatchlist">
												<span class="icon text-white-50"> <i
													class="fas fa-eye"></i></span><span class="text">Process
													Batch</span>
											</button>
										</td>
									</tr>
								</table>
							</div>



						</span>

					</div>

					<div class="card-body">



						<!--  Here is where the fee list comes -->

						<div class="table-responsive">
							<table class="table table-bordered" id="batchlistdataTable"
								width="100%" cellspacing="0">

								<thead>
									<tr>



										<th>Job Number</th>
										<th>Applicant Name</th>
										<!--   <th>Milestones</th> -->
										<th>Case Number</th>
										<th>Application Type</th>


									</tr>
								</thead>

								<tbody>


									<c:forEach items="${applicationlist}" var="appfiles">
										<tr>
											<td>${appfiles.job_number}</td>

											<td title="${appfiles.ar_name}">
												${fn:substring(appfiles.ar_name, 0, 20)}
												${fn:length(appfiles.ar_name) >20 ? "..." : ""}</td>

											<td>${appfiles.case_number}</td>
											<td>${appfiles.business_process_sub_name}</td>
											<td style="display: none">${appfiles.ar_name}</td>

										</tr>
									</c:forEach>


								</tbody>


							</table>
						</div>

						<!--  End Of Table -->
					</div>

				</div>








			</div>
		</div>






	</div>



	<jsp:include page="../includes/_footer.jsp"></jsp:include>