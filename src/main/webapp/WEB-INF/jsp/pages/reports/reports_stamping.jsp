<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>

<style>
/* ELIS Stamping Reports — scoped emerald-green theme */
.elis-stamping-reports {--elis-dark:#064b39;--elis-primary:#087f5b;--elis-bright:#0ba26f;--elis-pale:#e8f7ee;--elis-border:#cce9d9;color:#203b31;padding-bottom:2rem}
.elis-stamping-reports .elis-page-hero{background:linear-gradient(120deg,#064b39 0%,#087f5b 62%,#0ba26f 100%);color:#fff;padding:1.5rem 1.75rem;border-radius:16px;margin:1rem 0 1.5rem;box-shadow:0 12px 30px rgba(6,75,57,.18)}
.elis-stamping-reports .elis-page-hero h2{color:#fff;font-size:1.45rem;font-weight:700;margin:0 0 .35rem}
.elis-stamping-reports .elis-page-hero p{color:rgba(255,255,255,.85);margin:0}
.elis-stamping-reports .breadcrumb{background:transparent;margin:0 0 .8rem;padding:0}
.elis-stamping-reports .breadcrumb-item a{color:#087f5b;text-decoration:none;font-weight:600}
.elis-stamping-reports .breadcrumb-item.active{color:#496b5d}
.elis-stamping-reports .card{border:1px solid var(--elis-border);border-radius:14px;box-shadow:0 6px 22px rgba(6,75,57,.065);overflow:hidden}
.elis-stamping-reports .card-header{background:linear-gradient(110deg,#064b39,#087f5b);color:white;border:0;padding:1rem 1.25rem}
.elis-stamping-reports .card-header h4{font-size:1.06rem;font-weight:700;color:#fff;margin:0;float:none!important}
.elis-stamping-reports .card-header h4 i{margin-right:.5rem;color:#c7f7de}
.elis-stamping-reports .card-header a{color:#fff;text-decoration:none;font-weight:700}
.elis-stamping-reports .card-header a:hover{color:#d7ffeb}
.elis-stamping-reports .card-body{padding:1.3rem}
.elis-stamping-reports .accordion .card{box-shadow:none;border:1px solid #e0f0e7;margin-bottom:0}
.elis-stamping-reports .accordion .card-body{padding:1rem}
.elis-stamping-reports .form-group{margin-bottom:1.1rem}
.elis-stamping-reports label{display:block;font-weight:600;color:#175a42;margin-bottom:.4rem}
.elis-stamping-reports .form-control,.elis-stamping-reports .form-select{border:1px solid #c5decf;border-radius:9px;min-height:41px;background-color:#fff;transition:border-color .2s,box-shadow .2s}
.elis-stamping-reports .form-control:focus,.elis-stamping-reports .form-select:focus{border-color:#0ba26f;box-shadow:0 0 0 .2rem rgba(11,162,111,.13);outline:0}
.elis-stamping-reports .btn-info,.elis-stamping-reports .btn-primary,.elis-stamping-reports .btn-success{background:linear-gradient(115deg,#087f5b,#0ba26f);border:1px solid #087f5b;color:white;border-radius:9px;padding:.55rem 1rem;font-weight:600;box-shadow:0 4px 10px rgba(8,127,91,.13)}
.elis-stamping-reports .btn-info:hover,.elis-stamping-reports .btn-primary:hover,.elis-stamping-reports .btn-success:hover{background:#064b39;border-color:#064b39;color:#fff;transform:translateY(-1px)}
.elis-stamping-reports .elis-filters-note{background:#e8f7ee;border:1px solid #cce9d9;border-radius:9px;color:#316b52;padding:.65rem .85rem;font-size:.86rem;margin-bottom:1.15rem}
.elis-stamping-reports .elis-actions{display:flex;flex-wrap:wrap;gap:.7rem;margin-top:1.1rem}
.elis-stamping-reports .table-responsive{border-radius:10px;border:1px solid #d6ecdf}
.elis-stamping-reports table{margin:0;width:100%}
.elis-stamping-reports table thead th{background:#e8f7ee;color:#064b39;border-bottom:2px solid #0ba26f!important;font-weight:700;white-space:nowrap;padding:.85rem .7rem}
.elis-stamping-reports table tbody td{vertical-align:middle;padding:.7rem;border-color:#e5f2ea}
.elis-stamping-reports table tbody tr:hover{background:#f2fbf6}
.elis-stamping-reports .elis-review .card-header{background:linear-gradient(110deg,#064b39,#087f5b)}
.elis-stamping-reports .elis-review .card-header .fa-chevron-down{float:right;margin-top:.25rem}
.elis-stamping-reports .dataTables_wrapper .dataTables_filter input,.elis-stamping-reports .dataTables_wrapper .dataTables_length select{border:1px solid #bcdcc9;border-radius:7px;padding:.35rem .55rem}
.elis-stamping-reports .dataTables_wrapper .dataTables_filter input:focus{border-color:#087f5b;outline:none;box-shadow:0 0 0 .2rem rgba(8,127,91,.12)}
.elis-stamping-reports .dataTables_wrapper .dataTables_paginate .paginate_button.current,.elis-stamping-reports .dataTables_wrapper .dataTables_paginate .paginate_button:hover{background:#087f5b!important;color:white!important;border-color:#087f5b!important}
@media(max-width:767px){.elis-stamping-reports .elis-page-hero{padding:1.1rem}.elis-stamping-reports .card-body{padding:1rem}.elis-stamping-reports .elis-actions .btn{width:100%}}
</style>

<div class="container-fluid elis-stamping-reports">
    <div class="elis-page-hero">
        <h2><i class="fas fa-file-invoice-dollar mr-2 me-2"></i>Stamping Reports Dashboard</h2>
        <p>Generate and review stamp duty assessment, payment and application reports.</p>
    </div>
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.jsp">ELIS Report</a></li>
        <li class="breadcrumb-item active">Stamping Report User - ${fullname}</li>
    </ol>

    <div class="row">
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header"><h4><i class="fas fa-database"></i>Type of Report Selection</h4></div>
                <div class="card-body">
                    <div class="accordion" id="stpcReportTypeAccordion">
                        <div class="card">
                            <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#stpcReportTypeAccordion">
                                <div class="card-body">
                                    <div class="elis-filters-note"><i class="fas fa-filter mr-1 me-1"></i>Select the report type and service to refine the results.</div>
                                    <div class="form-group">
                                        <label for="type_of_report_name_stpc">Application Status</label>
                                        <select name="type_of_report_name_stpc" id="type_of_report_name_stpc" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                                            <option value="-1">Select Report Type</option>
                                            <option value="All">All Job Recieved</option>
                                            <option value="Completed">Completed Jobs</option>
                                            <option value="Pending">Pending Jobs</option>
                                            <option value="by_invoice_number">Invoice Number</option>
                                            <option value="assessed_but_not_paid">Assessed But Not Paid</option>
                                            <option value="assessed_and_paid">Assessed and Paid</option>
                                            <option value="assessed_but_not_paid_by_applicant_name">Assessed But Not Paid By Applicant</option>
                                            <option value="assessed_and_paid_by_applicant_name">Assessed and Paid By Applicant</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="main_service_rpt_stpc">Main Service</label>
                                        <select name="main_service_rpt_stpc" id="main_service_rpt_stpc" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                                            <option value="-1">Select Main Service</option>
                                            <c:forEach items="${main_services}" var="main_service">
                                                <c:if test="${main_service.business_process_id == '4'}">
                                                    <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="sub_service_rpt_stpc">Sub Service</label>
                                        <select name="sub_service_rpt_stpc" id="sub_service_rpt_stpc" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                                            <option value="-1">Select Sub Service</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header"><h4><i class="fas fa-calendar-alt"></i>Report Date Range</h4></div>
                <div class="card-body">
                    <div class="accordion" id="stpcDateRangeAccordion">
                        <div class="card">
                            <div class="collapse show" data-parent="#stpcDateRangeAccordion">
                                <div class="card-body">
                                    <div class="elis-filters-note"><i class="fas fa-calendar-check mr-1 me-1"></i>Choose the period and optional search value.</div>
                                    <div class="form-group">
                                        <label for="date_from_stpc">Date From</label>
                                        <input type="date" name="date_from_stpc" id="date_from_stpc" min="1000-01-01" max="3000-12-31" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="date_to_stpc">Date To</label>
                                        <input type="date" name="date_to_stpc" id="date_to_stpc" min="1000-01-01" max="3000-12-31" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="ar_name_search_stpc">Search Value</label>
                                        <input type="text" name="ar_name_search_stpc" id="ar_name_search_stpc" class="form-control" placeholder="Enter applicant name, invoice or reference">
                                    </div>
                                    <div class="elis-actions">
                                        <button type="button" class="btn btn-sm btn-info shadow-sm" id="btn_generate_details_reports_new_stpc" data-placement="top" data-toggle="tooltip" title="Search">
                                            <i class="fas fa-search mr-1 me-1"></i>View Report Result
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div id="accordion" class="elis-review" role="tablist" aria-multiselectable="true">
                <div class="card mb-4">
                    <h5 class="card-header" role="tab" id="headingThree">
                        <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="true" aria-controls="collapseparties">
                            <i class="fa fa-chevron-down pull-right"></i><i class="fa fa-cube mr-2 me-2"></i>Review Stamping Report Results
                        </a>
                    </h5>
                    <div id="collapseparties" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover datatable" id="job_casemgtdetailsdataTable_elis_reports_stpc" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Date Received</th>
                                            <th>Job Status</th>
                                            <th>Assessed Value</th>
                                            <th>Stamp Duty Payable</th>
                                            <th>Ref Number</th>
                                            <th>Bill Amount</th>
                                            <th>Payment Date</th>
                                            <th>Invoice Number</th>
                                            <th>Payment Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../includes/_footer.jsp"></jsp:include>
