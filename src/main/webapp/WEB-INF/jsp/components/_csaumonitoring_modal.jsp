<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<jsp:useBean id="now" class="java.util.Date" />


<div class="modal fade effect-scale modal-blur" id="officerModal" tabindex="-1" aria-labelledby="officerModalLabel" aria-hidden="true" data-bs-backdrop="false">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="officerModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-striped table-hover w-100" 
                                       data-responsive="true"
                                       data-order='[[1, "desc"]]'
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>">
								<thead class="table-light">
                                    <tr>
                                        <th>Officer</th>
                                        <th>Count</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
								<tbody class="text-small">
                                    <!-- Data will be loaded here -->
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
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Applications Modal (General) -->
<div class="modal fade" id="csau_applicationsModal" tabindex="-1" aria-labelledby="applicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="csau_applicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="csau_applicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
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
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>






<div class="modal fade" id="csau_billsModal" tabindex="-1" aria-labelledby="applicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="csau_billsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="csau_billsModalTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Created Date</th>
                                         <th>Bill Number</th>
                                        <th>Bill Amount</th>
                                         <th>Payment Status</th>
                                        <!-- <th class="text-end">Action</th> -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
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
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

