<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<jsp:include page="../includes/_header.jsp" />
<jsp:useBean id="now" class="java.util.Date" />

<style>
.elis-reports-green{--er-dark:#064b39;--er-primary:#087f5b;--er-bright:#0ba26f;--er-soft:#e8f7ee;--er-border:#bfe6d2;color:#203b30}
.elis-reports-green .er-hero{background:linear-gradient(115deg,#064b39,#087f5b 65%,#0ba26f);border-radius:16px;padding:24px 28px;color:#fff;margin-bottom:24px;box-shadow:0 12px 30px rgba(6,75,57,.16)}
.elis-reports-green .er-hero h2,.elis-reports-green .er-hero a{color:#fff}
.elis-reports-green .er-hero .breadcrumb-item.active{color:#d8f8e7}
.elis-reports-green .er-card{border:1px solid #d8eae0;border-radius:14px;overflow:hidden;box-shadow:0 5px 22px rgba(6,75,57,.07);margin-bottom:24px;background:#fff}
.elis-reports-green .er-card>.card-header{background:linear-gradient(105deg,#064b39,#087f5b);color:#fff;padding:17px 20px;border:0}
.elis-reports-green .er-card>.card-header h4,.elis-reports-green .er-card>.card-header h5,.elis-reports-green .er-card>.card-header a{color:#fff!important;text-decoration:none;margin:0;font-size:1.06rem;font-weight:650}
.elis-reports-green .er-card>.card-body{padding:22px}
.elis-reports-green .er-inner{background:#f8fcfa;border:1px solid #e0efe6;border-radius:11px;padding:20px}
.elis-reports-green .form-group{margin-bottom:16px}
.elis-reports-green .form-group label{display:block;font-size:.89rem;font-weight:650;color:#245541;margin-bottom:6px}
.elis-reports-green .form-control,.elis-reports-green .form-select{border:1px solid #cbded3;border-radius:8px;min-height:39px;background-color:#fff}
.elis-reports-green .form-control:focus,.elis-reports-green .form-select:focus{border-color:#0ba26f;box-shadow:0 0 0 .2rem rgba(11,162,111,.13);outline:0}
.elis-reports-green .btn-primary,.elis-reports-green .btn-info{background:linear-gradient(120deg,#087f5b,#0ba26f);border-color:#087f5b;color:#fff}
.elis-reports-green .btn-primary:hover,.elis-reports-green .btn-info:hover{background:#064b39;border-color:#064b39;color:#fff}
.elis-reports-green .er-btn-secondary{background:#e8f7ee;color:#07573d;border:1px solid #a7dac0}
.elis-reports-green .er-btn-secondary:hover{background:#d0eddf;color:#064b39}
.elis-reports-green .er-actions{display:flex;flex-wrap:wrap;gap:10px;margin-top:18px}
.elis-reports-green .er-actions .btn{padding:10px 15px;border-radius:8px;font-weight:600}
.elis-reports-green .er-review-header{display:block;background:linear-gradient(105deg,#064b39,#087f5b);color:#fff;padding:17px 20px;text-decoration:none}
.elis-reports-green .er-review-header:hover{color:#fff;background:#064b39}
.elis-reports-green .er-table thead th{background:#e2f4e9;color:#064b39;border-color:#c2e4d0;font-weight:700;white-space:nowrap;font-size:.83rem}
.elis-reports-green .er-table tbody tr:hover{background:#f0faf4}
.elis-reports-green .er-table td{vertical-align:middle}
.elis-reports-green .dataTables_filter input,.elis-reports-green .dataTables_length select{border:1px solid #cbded3;border-radius:7px;padding:6px 9px}
.elis-reports-green .page-item.active .page-link,.elis-reports-green .paginate_button.current{background:#087f5b!important;border-color:#087f5b!important;color:#fff!important}
.elis-reports-green .er-count-card{border:1px solid #cfe9da;border-left:5px solid #087f5b;border-radius:10px;background:#f8fcfa;box-shadow:0 4px 12px rgba(6,75,57,.07)}
.elis-reports-green .er-count-card .er-count-label{font-size:.78rem;text-transform:uppercase;font-weight:700;color:#087f5b}
.elis-reports-green .er-count-card .er-count-value{font-size:1.7rem;font-weight:750;color:#064b39}
.elis-reports-green .er-count-card.queried{border-left-color:#c75454}
.elis-reports-green .er-count-card.queried .er-count-label{color:#aa3c3c}
#report_count_modal .modal-content{border:0;border-radius:14px;overflow:hidden}
#report_count_modal .modal-header{background:linear-gradient(110deg,#064b39,#0ba26f);color:#fff;border:0}
#report_count_modal .modal-title{color:#fff;font-weight:700}
#report_count_modal .modal-header .close{color:#fff;opacity:1}
#report_count_modal .modal-footer{background:#e8f7ee;border-top:1px solid #c9e8d6}
@media(max-width:767px){.elis-reports-green .er-hero{padding:19px}.elis-reports-green .er-card>.card-body{padding:14px}.elis-reports-green .er-inner{padding:13px}}
</style>

<div class="container-fluid elis-reports-green">
  <div class="er-hero">
    <div class="d-flex justify-content-between align-items-center flex-wrap">
      <div><h2 class="mb-1"><i class="fas fa-chart-line mr-2 me-2"></i>ELIS Reports Dashboard</h2><div style="color:#d8f8e7">Generate, review and export land administration reports</div></div>
      <ol class="breadcrumb mb-0" style="background:transparent"><li class="breadcrumb-item"><a href="index.jsp">ELIS Report</a></li><li class="breadcrumb-item active">Report User - ${fullname}</li></ol>
    </div>
  </div>

  <div class="row">
    <div class="col-lg-6">
      <div class="card er-card">
        <div class="card-header"><h4><i class="fas fa-database mr-2 me-2"></i>Report by Service Types</h4></div>
        <div class="card-body"><div class="er-inner">
          <div class="form-group"><label for="type_of_report_name">Application Status</label><select name="type_of_report_name" id="type_of_report_name" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option value="All">All</option><option value="Completed" selected>Completed</option><option value="Pending">Pending</option><option value="gra_stamp_duty_report">GRA Stamp Duty Report</option><option value="lrd_plotting_report">LRD Plotting Report</option></select></div>
          <div class="form-group"><label for="sel_change_region_compliance">Select Region</label><select id="sel_change_region_compliance" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option selected value="0">All Regions</option><c:forEach items="${officeregionlist}" var="officeregion"><option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option></c:forEach></select></div>
          <div class="form-group"><label for="main_service_rpt">Main Service</label><select name="main_service_rpt" id="main_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option value="-1">Select Main Service</option><c:forEach items="${main_services}" var="main_service"><option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option></c:forEach></select></div>
          <div class="form-group"><label for="sub_service_rpt">Sub Service</label><select name="sub_service_rpt" id="sub_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option value="-1">Select Sub Service</option></select></div>
          <div class="row"><div class="col-md-6"><div class="form-group"><label for="date_from">Date From</label><input type="date" name="date_from" id="date_from" min="1000-01-01" max="3000-12-31" class="form-control"></div></div><div class="col-md-6"><div class="form-group"><label for="date_to">Date To</label><input type="date" name="date_to" id="date_to" min="1000-01-01" max="3000-12-31" class="form-control"></div></div></div>
          <div class="er-actions"><button type="button" class="btn btn-info btn-sm shadow-sm" id="btn_generate_details_reports_new" data-placement="top" data-toggle="tooltip" title="View Report Result"><i class="fas fa-eye mr-2 me-2"></i>View Report Result</button><button type="button" class="btn er-btn-secondary btn-sm shadow-sm" id="btn_generate_details_reports_new_csv" data-placement="top" data-toggle="tooltip" title="Download Report Result"><i class="fas fa-download mr-2 me-2"></i>Download Report Result</button></div>
        </div></div>
      </div>
    </div>

    <div class="col-lg-6">
      <div class="card er-card">
        <div class="card-header"><h4><i class="fas fa-users mr-2 me-2"></i>Report by Division/Users</h4></div>
        <div class="card-body"><div class="er-inner">
          <div class="form-group"><label for="type_of_report_name_rpt">Report Type</label><select name="type_of_report_name_rpt" id="type_of_report_name_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option value="individual_audit_trails">Individual Audit Trails</option><option value="Division">Division</option><option value="Unit" selected>Unit</option><option value="Staff">Staff</option></select></div>
          <div class="form-group"><label for="get_change_region_compliance">Select Region</label><select id="get_change_region_compliance" class="form-control input-sm" data-style="btn-info" data-live-search="true" required><option selected disabled>Please Select</option><c:forEach items="${officeregionlist}" var="officeregion"><option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option></c:forEach></select></div>
          <div class="form-group"><label for="unit_division_to_send_to_rpt">Division</label><select id="unit_division_to_send_to_rpt" class="form-control"><option value="none">---Select Division---</option><option value="LVD">LVD</option><option value="LRD">LRD</option><option value="PVLMD">PVLMD</option><option value="SMD">SMD</option><option value="RLO">RLO</option></select></div>
          <div class="form-group"><label for="unit_to_send_to_rpt">Unit</label><input autocomplete="off" class="form-control" id="unit_to_send_to_rpt" type="text" list="listofunitsbatching_rpt" placeholder="Select/Enter Unit" required><datalist id="listofunitsbatching_rpt"></datalist></div>
          <div class="form-group"><label for="user_to_send_to_rpt">User</label><input class="form-control" id="user_to_send_to_rpt" name="user_to_send_to_rpt" type="text" autocomplete="off" list="listofusersbatching_rpt" placeholder="Enter Username" required onmousedown="value = '';"><datalist id="listofusersbatching_rpt"></datalist></div>
          <div class="er-actions"><button type="button" class="btn btn-primary btn-sm shadow-sm" id="btn_generate_details_based_on_users" data-placement="top" data-toggle="tooltip" title="View Report"><i class="fas fa-eye mr-2 me-2"></i>View Report</button><button type="button" class="btn er-btn-secondary btn-sm shadow-sm" id="btn_generate_details_based_on_users_csv" data-placement="top" data-toggle="tooltip" title="Download Report"><i class="fas fa-download mr-2 me-2"></i>Download Report</button></div>
        </div></div>
      </div>
    </div>
  </div>

  <div class="card er-card">
    <div class="card-header p-0" role="tab" id="headingThree"><a class="er-review-header" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="true" aria-controls="collapseparties"><i class="fa fa-cube mr-2 me-2"></i>Review <i class="fa fa-chevron-down float-right"></i></a></div>
    <div id="collapseparties" class="collapse show" role="tabpanel" aria-labelledby="headingThree"><div class="card-body"><div class="table-responsive"><table class="table table-bordered table-hover datatable er-table" id="job_casemgtdetailsdataTable_elis_reports" width="100%" cellspacing="0"><thead><tr><th>Job Number</th><th>Applicant Name</th><th>Application Type</th><th>Date Received</th><th>Job Status</th><th>Case Number</th><th>Days(Received)</th><th>Days(Batched)</th><th>Date(Completed)</th><th>Days(Completed)</th><th>Date(Collected)</th><th class="to_hide_on_level_1">View</th></tr></thead><tbody></tbody></table></div></div></div>
  </div>

  <div class="card er-card">
    <div class="card-header"><h4><i class="fas fa-chart-bar mr-2 me-2"></i>Report Count by Service Types</h4></div>
    <div class="card-body"><div class="er-inner">
      <div class="form-group"><label for="report_count_sel_change_region_compliance">Select Region</label><select id="report_count_sel_change_region_compliance" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option selected value="0">All Regions</option><c:forEach items="${officeregionlist}" var="officeregion"><option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option></c:forEach></select></div>
      <div class="row"><div class="col-md-6"><div class="form-group"><label for="report_count_main_service_rpt">Main Service</label><select name="main_service_rpt" id="report_count_main_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option value="-1">Select Main Service</option><c:forEach items="${main_services}" var="main_service"><option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option></c:forEach></select></div></div><div class="col-md-6"><div class="form-group"><label for="report_count_sub_service_rpt">Sub Service</label><select name="sub_service_rpt" id="report_count_sub_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true"><option value="-1">Select Sub Service</option></select></div></div></div>
      <div class="row"><div class="col-md-6"><div class="form-group"><label for="report_count_date_from">Date From</label><input type="date" name="date_from" id="report_count_date_from" min="1000-01-01" max="3000-12-31" class="form-control"></div></div><div class="col-md-6"><div class="form-group"><label for="report_count_date_to">Date To</label><input type="date" name="date_to" id="report_count_date_to" min="1000-01-01" max="3000-12-31" class="form-control"></div></div></div>
      <div class="er-actions"><button type="button" class="btn btn-info btn-sm shadow-sm" id="btn_generate_count_reports" data-placement="top" data-toggle="tooltip" title="View Report Count Result"><i class="fas fa-chart-pie mr-2 me-2"></i>View Report Count Result</button><button type="button" class="btn er-btn-secondary btn-sm shadow-sm" id="btn_generate_count_reports_csv" data-placement="top" data-toggle="tooltip" title="Download Report Result"><i class="fas fa-download mr-2 me-2"></i>Download Report Result</button></div>
    </div></div>
  </div>
</div>

<div class="modal fade" id="report_count_modal" tabindex="-1" role="dialog" aria-labelledby="reportCountModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg" role="document"><div class="modal-content"><div class="modal-header"><h5 class="modal-title" id="reportCountModalLabel"></h5><button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times"></i></span></button></div><div class="modal-body"><div class="row">
  <div class="col-xl-4 col-md-6 mb-4"><div class="card er-count-card h-100"><div class="card-body"><div class="d-flex justify-content-between align-items-center"><div><div class="er-count-label">Applications Pending</div><div id="app-pending" class="er-count-value">0</div></div><i class="fas fa-file fa-2x text-success"></i></div></div></div></div>
  <div class="col-xl-4 col-md-6 mb-4"><div class="card er-count-card h-100"><div class="card-body"><div class="d-flex justify-content-between align-items-center"><div><div class="er-count-label">Applications Completed</div><div id="app-completed" class="er-count-value">0</div></div><i class="fas fa-check-circle fa-2x text-success"></i></div></div></div></div>
  <div class="col-xl-4 col-md-6 mb-4"><div class="card er-count-card queried h-100"><div class="card-body"><div class="d-flex justify-content-between align-items-center"><div><div class="er-count-label">Applications Queried</div><div id="app-queried" class="er-count-value">0</div></div><i class="fas fa-clock fa-2x text-danger"></i></div></div></div></div>
</div></div><div class="modal-footer"><button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button></div></div></div></div>
<jsp:include page="../includes/_footer.jsp" />
