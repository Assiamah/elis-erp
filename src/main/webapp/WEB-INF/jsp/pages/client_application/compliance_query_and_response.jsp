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
	<h1 class="h3 mb-4 text-gray-800">Compliance Query & Response for 
	
	<select id="sel_change_region_compliance" class="">
		<option value=${regional_code}>${regional_name}</option>
									
		<c:forEach items="${officeregionlist}" var="officeregion">
			<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
  		</c:forEach>

	</select>
	
	
	
	
	</h1>

	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="lvd_card">
			<div class="card border-left-primary shadow h-100 py-2" id="body-bg-1">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> LVD (Applications
								Queried)</div>
							<!-- <div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div> -->
							<div id="lvd_total" class="h5 mb-0 font-weight-bold">0
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="" data-period="day" 
						data-url="" data-icon="fa-file" 
						data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
						class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Application Received (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="lrd_card">
			<div class="card border-left-success shadow h-100 py-2" id="body-bg-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">LRD (Applications
								Queried)</div>
							<!-- <div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
							<div id="lrd_total" class="h5 mb-0 font-weight-bold">0</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="" data-period="month" data-url="" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>

			</div>
		</div>

		<!-- Application Completed (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="smd_card">
			<div class="card border-left-info shadow h-100 py-2" id="body-bg-3">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">SMD (Applications
								Queried)
							</div>
							<!-- <div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div> -->

							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="smd_total" class="h5 mb-0 mr-3 font-weight-bold">0</div>
								</div>

							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="" data-period="day" data-url="" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Application Completed (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="pvlmd_card">
			<div class="card border-left-warning shadow h-100 py-2" id="body-bg-4">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">PVLMD (Applications
								Queried)</div>
							<!-- <div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
							<div id="pvlmd_total" class="h5 mb-0 font-weight-bold">0</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
						<a href="#" data-method="" data-period="month" data-url="" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

    <div class="row mb-4">
        <div class="col-md-12">
          <div class="card">
              <div class="card-header bg-dark text-white">
                <i class="fa fa-bar-chart"></i><span class="h5">Queried Details</span> <span
                class="col-md-3 float-right ">
				<input hidden="" id="pending_queries_input" value="" />
                 <button class="btn btn-danger btn-icon-split float-right "
                    id="btnPendingQueries" style="margin-right: -15px">
                    <span class="icon text-white-50"> <i class="fas fa-clock"></i></span><span
                        class="text">Pending Queries</span>
                </button>
            </span>
            </div>
            <div class="card-body">
                  <h5 class="card-title"><span id="card_title"> </span></h5>
				  <div class="row mt-2">
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-info"></i>Reminder Applications</span>
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-warning"></i>Warning Applications</span>
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-danger"></i>Queried Applications</span>
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-success"></i>Response</span>
				</div>
              <div class="tab-content mt-4">
                        <div id="" class="table-responsive">
                            <table class="table " id="table_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
                                  <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Job No.</th>
                                        <th>Details</th>
                                        <th>Receiver</th>
										<th>Unit</th>
                                        <th>Created By</th>							        
                                        <!-- <th>Region</th> -->
                                        <th>Date Created</th>
										<th>TAT</th>
                                        <th class="text-end">Actions</th>
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
<!-- /.container-fluid -->
<!-- End of Main Content -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>