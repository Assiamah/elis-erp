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
	<h1 class="h3 mb-4 text-gray-800">Compliance Notice Report</h1>

	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-4 mb-4">
			<div class="card shadow h-100 py-2">
				<div class="card-body">
					<div class="form-group">
                        <label>Date <span class="text-danger">*</span>:</label>
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
                        <label>Region <span class="text-danger">*</span>:</label> 
                        <select id="cr_region_code" class="form-control">
                            <option selected disabled value="">-- select --</option>
                                                        
                            <c:forEach items="${officeregionlist}" var="officeregion">
                                <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                              </c:forEach>
                    
                        </select>
                    </div>


						<div class="form-group">
							<label for="" class="col-form-label">Division <span class="text-danger">*</span>:</label>
							  <select id="cr_division_name" class="form-control" >
								 <option value="none">-- select --</option>
								 <option value="LVD">LVD</option>
								 <option value="LRD">LRD</option>
								 <option value="PVLMD">PVLMD</option>
								 <option value="SMD">SMD</option>
								  <option value="RLO">RLO</option>
							  </select>
							  </div>
	
							  <div class="form-group">
								<label for="" class="col-form-label">Unit <span class="text-danger">*</span>:</label>
                                <!-- <input autocomplete="off" class="form-control" id="unit_to_send_to_2"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
                                <datalist id="listofunitsbatching"></datalist> -->
                                <select id="cr_unit_name" class="form-control" >
                                </select>
							  </div>
					
						<div class="form-group">
							<label for="" class="col-form-label">Officer:</label>
							<!-- <input class="form-control" id="am_to_officer"  name="am_to_officer" type="text" autocomplete="off" 
							list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
						 	<datalist id="listofusersbatching">
								<c:forEach items="${userlist}" var="user">
										<option data-value="${user.userid}" value="${user.fullname}"></option>
							</c:forEach>
							</datalist> -->
                            <select id="cr_user" class="form-control" >
                            </select>
						</div>
                        <br>
                        <div class="form-group">
                            <button type="button" class="btn btn-dark btn-block" id="btn_compliance_notice_report" >Apply Filter</button>
                        </div>
				</div>
			</div>
		</div>
	<!-- </div>

    <div class="row mb-4"> -->
        <div class="col-xl-9 col-md-8 mb-4">
          <div class="card shadow h-100 py-2">
              <div class="card-header bg-dark text-white">
                <i class="fa fa-bar-chart"></i><span class="h5">Report Details</span> <span
                class="col-md-3 float-right ">
                 <!-- <button class="btn btn-success btn-icon-split float-right "
                    id="btnViewBatchlist" style="margin-right: -15px">
                    <span class="icon text-white-50"> <i class="fas fa-angle-double-right"></i></span><span
                        class="text">Forward</span>
                </button> -->
            </span>
            </div>
            <div class="card-body">
                  <h5 class="card-title"><span id="card_title"> </span></h5>
				  <!-- <div class="row mt-2">
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-info"></i>Reminder Applications</span>
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-warning"></i>Warning Applications</span>
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-danger"></i>Queried Applications</span>
					<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-success"></i>Response</span>
				</div> -->
              <div class="tab-content mt-4">
                        <div id="" class="table-responsive">
                            <table class="table " id="table_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
                                  <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Job No.</th>
                                        <th>Type of Notice</th>
                                        <th>Details</th>
                                        <th>Receiver</th>
                                        <th>Division</th>							        
                                        <th>Region</th>
                                        <th>Prev. Reminder Date</th>							        
                                        <th>Prev. Warning Date</th>
                                        <th>Date of Notice</th>
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