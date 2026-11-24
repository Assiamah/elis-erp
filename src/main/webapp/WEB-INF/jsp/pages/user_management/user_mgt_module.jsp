<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
/* Scoped ELIS emerald theme: does not change included modals or other pages. */
.elis-user-green { --elis-forest:#07543f; --elis-green:#087b58; --elis-bright:#10a778; --elis-mint:#eaf8f1; --elis-border:#d8ece2; }
.elis-user-green .page-header-breadcrumb { background:linear-gradient(115deg,#064b39 0%,#087957 60%,#12a77a 100%); border-radius:15px; padding:21px 25px; box-shadow:0 12px 25px rgba(4,90,65,.17); }
.elis-user-green .page-header-breadcrumb .page-title,.elis-user-green .page-header-breadcrumb small,.elis-user-green .page-header-breadcrumb .breadcrumb-item,.elis-user-green .page-header-breadcrumb .breadcrumb-item.active,.elis-user-green .page-header-breadcrumb .breadcrumb-item a { color:#fff !important; }
.elis-user-green .page-header-breadcrumb .breadcrumb-item + .breadcrumb-item::before { color:rgba(255,255,255,.7) !important; }
.elis-user-green .custom-card { border:1px solid var(--elis-border); border-radius:15px; box-shadow:0 7px 20px rgba(5,75,54,.07); overflow:hidden; }
.elis-user-green .custom-card > .card-header { background:linear-gradient(110deg,#07543f,#0b9168) !important; border-color:#087451 !important; padding:17px 20px; }
.elis-user-green .custom-card > .card-header .card-title,.elis-user-green .custom-card > .card-header h5,.elis-user-green .custom-card > .card-header i { color:#fff !important; }
.elis-user-green .dashboard-main-card { background:linear-gradient(145deg,#fff,#f2fbf6) !important; border-radius:0 !important; transition:background .2s ease; }
.elis-user-green .dashboard-main-card:hover { background:linear-gradient(145deg,#eaf8f1,#fff) !important; }
.elis-user-green .dashboard-main-card .text-muted { color:#527569 !important; font-weight:600; }
.elis-user-green .dashboard-main-card h5 { color:var(--elis-forest) !important; font-size:1.65rem; }
.elis-user-green .dashboard-main-card .avatar { color:#087b58 !important; background:#d8f4e6 !important; border:1px solid #bce8d2; }
.elis-user-green .dashboard-main-card.secondary .avatar { color:#946100 !important; background:#fff2d4 !important; border-color:#ffe1a3; }
.elis-user-green .dashboard-main-card.warning .avatar { color:#b54b2b !important; background:#ffede5 !important; border-color:#ffd6c7; }
.elis-user-green .btn-primary,.elis-user-green .btn-outline-primary:hover { background:var(--elis-green) !important; border-color:var(--elis-green) !important; color:#fff !important; }
.elis-user-green .btn-primary:hover { background:var(--elis-forest) !important; border-color:var(--elis-forest) !important; }
.elis-user-green .btn-outline-primary { border-color:var(--elis-green) !important; color:var(--elis-green) !important; }
.elis-user-green .text-primary { color:var(--elis-green) !important; }
.elis-user-green .table thead th { background:#e7f5ed !important; color:#07543f !important; border-bottom:2px solid #b9dfca !important; font-size:.78rem; font-weight:700; white-space:nowrap; }
.elis-user-green .table tbody tr:not(.table-danger):not(.table-warning):hover td { background:#f1faf5 !important; }
.elis-user-green .table td { vertical-align:middle; }
.elis-user-green .table .badge.bg-light { background:#e9f6ef !important; color:#155b42 !important; }
.elis-user-green .table .avatar { background:#e6f4ec !important; }
.elis-user-green .btn-group .btn { border-radius:6px; margin-right:3px; }
.elis-user-green .dataTables_wrapper .dataTables_filter input,.elis-user-green .dataTables_wrapper .dataTables_length select { border:1px solid #b8dcca; border-radius:7px; }
.elis-user-green .dataTables_wrapper .page-item.active .page-link { background:var(--elis-green) !important; border-color:var(--elis-green) !important; color:#fff !important; }
.elis-user-green .dataTables_wrapper .page-link { color:var(--elis-green); }
.elis-user-green #user-region-statistics { min-height:351px; }
@media(max-width:767px){.elis-user-green .page-header-breadcrumb{padding:16px}.elis-user-green .custom-card > .card-header{gap:12px;flex-wrap:wrap}}
</style>
<div class="main-content app-content elis-user-green">
  <div class="container-fluid page-container">
    <div class="page-header-breadcrumb mb-3">
      <div class="d-flex align-center justify-content-between flex-wrap">
        <h1 class="page-title fw-medium fs-18 mb-0">User Management</h1>
        <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item active" aria-current="page">User Management</li></ol>
      </div>
      <small><i class="ri-information-line me-2"></i>Manage system users, roles, and access permissions.</small>
    </div>
    <div class="row">
      <div class="col-xxl-4 col-xl-6"><div class="row"><div class="col-xl-12">
        <div class="card custom-card overflow-hidden custom-hrm-list"><div class="card-body p-0"><div class="row g-0">
          <div class="col-xl-6"><div class="card custom-card dashboard-main-card primary school-card border-0 shadow-none border-lg-end border-bottom mb-0 rounded-0"><div class="card-body">
            <div class="mb-3"><span class="avatar avatar-lg avatar-rounded bg-primary-transparent svg-primary"><i class="bi bi-people fa-2x"></i></span></div>
            <div class="text-muted mb-2">Total Users</div><div class="d-flex align-items-end gap-2 flex-wrap"><h5 class="fw-semibold mb-0 lh-1">${fn:length(users_list)}</h5></div>
          </div></div></div>
          <div class="col-xl-6"><div class="card custom-card dashboard-main-card success school-card border-0 shadow-none border-bottom mb-0 rounded-0"><div class="card-body">
            <div class="mb-3"><span class="avatar avatar-lg avatar-rounded bg-success-transparent svg-success"><i class="bi bi-person-check fa-2x"></i></span></div>
            <div class="text-muted mb-2">Active Users</div><div class="d-flex align-items-end gap-2 flex-wrap"><h5 class="fw-semibold mb-0 lh-1">
              <c:set var="activeCount" value="0"/><c:forEach items="${users_list}" var="user"><c:if test="${not user.isdisabled}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if></c:forEach>${activeCount}
            </h5></div>
          </div></div></div>
          <div class="col-xl-6"><div class="card custom-card dashboard-main-card secondary school-card dashboard-main-border border-0 shadow-none border-lg-end mb-0 rounded-0"><div class="card-body">
            <div class="mb-3"><span class="avatar avatar-lg avatar-rounded bg-secondary-transparent svg-secondary"><i class="bi bi-person-lock fa-2x"></i></span></div>
            <div class="text-muted mb-2">Pending Password Reset</div><div class="d-flex align-items-end gap-2 flex-wrap"><h5 class="fw-semibold mb-0 lh-1">
              <c:set var="passwordResetCount" value="0"/><c:forEach items="${users_list}" var="user"><fmt:parseNumber var="passwordvaliditydays" integerOnly="true" type="number" value="${user.passwordvaliditydays}"/><c:if test="${passwordvaliditydays <= 7 and passwordvaliditydays > 0}"><c:set var="passwordResetCount" value="${passwordResetCount + 1}"/></c:if></c:forEach>${passwordResetCount}
            </h5></div>
          </div></div></div>
          <div class="col-xl-6"><div class="card custom-card dashboard-main-card warning school-card border-0 shadow-none mb-0 rounded-0"><div class="card-body">
            <div class="mb-3"><span class="avatar avatar-lg avatar-rounded bg-warning-transparent svg-warning"><i class="bi bi-person-slash fa-2x"></i></span></div>
            <div class="text-muted mb-2">Disabled Accounts</div><div class="d-flex align-items-end gap-2 flex-wrap"><h5 class="fw-semibold mb-0 lh-1">
              <c:set var="disabledCount" value="0"/><c:forEach items="${users_list}" var="user"><c:if test="${user.isdisabled}"><c:set var="disabledCount" value="${disabledCount + 1}"/></c:if></c:forEach>${disabledCount}
            </h5></div>
          </div></div></div>
        </div></div></div>
        <div class="card custom-card overflow-hidden"><div class="card-header"><div class="card-title">User Distribution by Region</div></div><div class="card-body py-0"><div id="user-region-statistics"></div></div></div>
      </div></div></div>
      <div class="col-xxl-8 col-xl-6"><div class="card custom-card">
        <div class="card-header justify-content-between"><div><h5 class="card-title mb-0">User List</h5></div><div class="d-flex flex-wrap gap-2">
          <button class="btn btn-danger label-btn" data-bs-toggle="modal" data-bs-target="#checkstepassignment"><i class="ri-list-check-2 label-btn-icon fs-13"></i>Check Step Assignment</button>
          <button class="btn btn-primary label-btn" data-bs-toggle="modal" data-bs-target="#addupdateuserdatails"><i class="ri-add-line label-btn-icon fs-13"></i>Add New Account</button>
        </div></div>
        <div class="card-body p-3 position-relative" id="todo-content"><div class="table-responsive"><table class="table table-hover align-middle mb-0" id="userTable">
          <thead class="table-light"><tr><th>User Details</th><th>Region</th><th>Division</th><th>Unit/Department</th><th>Status</th><th class="text-center">Actions</th></tr></thead>
          <tbody><c:forEach items="${users_list}" var="user" varStatus="loop">
            <fmt:parseNumber var="passwordvaliditydays" integerOnly="true" type="number" value="${user.passwordvaliditydays}"/>
            <fmt:parseNumber var="user_level_single" integerOnly="true" type="number" value="${user.user_level}"/>
            <tr class="${user.isdisabled ? 'table-danger' : ''} ${passwordvaliditydays <= 7 and passwordvaliditydays > 0 ? 'table-warning' : ''}" data-status="${user.isdisabled ? 'disabled' : 'active'}" data-region="${user.region}">
              <td><div class="d-flex align-items-center"><div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2"><i class="ri-user-line text-muted"></i></div><div><div class="fw-medium text-primary small">${user.fullname}</div><small class="text-muted small">${user.emailaddress}</small></div></div></td>
              <td><span class="small text-dark">${user.region}</span></td>
              <td><span class="badge bg-light text-dark">${user.division}</span></td>
              <td><span class="small text-dark">${fn:length(user.unit_name) > 20 ? fn:substring(user.unit_name, 0, 20) : user.unit_name}</span></td>
              <td><span class="badge ${user.isdisabled ? 'bg-danger' : 'bg-success'}">${user.isdisabled ? 'Disabled' : 'Active'}</span><br/><c:if test="${passwordvaliditydays <= 7 and passwordvaliditydays > 0}"><small class="text-warning"><i class="fas fa-exclamation-triangle me-1"></i>Password expires in ${passwordvaliditydays} days</small></c:if></td>
              <td><div class="d-flex justify-content-center gap-2"><div class="btn-group">
                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addupdateuserdatails"
                  data-userid="${user.userid}" data-username="${user.username}" data-fullname="${user.fullname}" data-userprofile="${user.userprofile}" data-isdisabled="${user.isdisabled}"
                  data-staffnumber="${user.staffnumber}" data-title="${user.title}" data-designation="${user.designation}" data-division="${user.division}" data-address="${user.address}"
                  data-phone="${user.phone}" data-mobile="${user.mobile}" data-emailaddress="${user.emailaddress}" data-department="${user.department}"
                  data-department_id="${user.department_code}" data-department_name="${user.department}" data-district="${user.district}"
                  data-district_code="${user.regional_code}" data-district_name="${user.regional_name}" data-region="${user.region}" data-region_id="${user.region_id}"
                  data-id="${user.id}" data-passwordchanged="${user.passwordchanged}" data-canpasswordexpire="${user.canpasswordexpire}"
                  data-passwordvaliditydays="${passwordvaliditydays}" data-passwordexpirydate="${user.passwordexpirydate}" data-user_level="${user.user_level}"
                  data-usr_access_level="${user.usr_access_level}" data-view_all_offices="${user.view_all_offices}"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#assignReassignUserProfile" data-userid="${user.userid}" data-username="${user.username}" data-fullname="${user.fullname}" data-usertype="NationalUser" data-division="${user.division}"><i class="fas fa-user-shield"></i></button>
                <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#assignMilestoneUserProfile" data-userid="${user.userid}" data-username="${user.username}" data-fullname="${user.fullname}" data-division="${user.division}"><i class="fas fa-list"></i></button>
              </div></div></td>
            </tr>
          </c:forEach></tbody>
        </table></div></div>
      </div></div>
    </div>
  </div>
</div>
<jsp:include page="user_mgt_modals.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
<script>
$(document).ready(function() {
    const table = $('#userTable').DataTable({stateSave:true,pageLength:10});
    const regionMap = {};
    table.rows().every(function () {
        const row = this.node();
        const region = row.dataset.region?.trim();
        if (!region) return;
        regionMap[region] = (regionMap[region] || 0) + 1;
    });
    let categories = Object.keys(regionMap);
    let seriesData = Object.values(regionMap);
    const combined = categories.map((r,i) => ({region:r,count:seriesData[i]})).sort((a,b) => b.count - a.count);
    categories = combined.map(x => x.region);
    seriesData = combined.map(x => x.count);
    const MIN_ROWS = 10;
    while(categories.length < MIN_ROWS){categories.push('—');seriesData.push(0);}
    renderRegionChart(categories,seriesData);
    function renderRegionChart(categories,seriesData){
        const options = {
            series:[{name:'Users',data:seriesData}],
            chart:{type:'bar',height:351,fontFamily:'Poppins, Arial, sans-serif',toolbar:{show:false}},
            grid:{borderColor:'#e0f1e8'},
            plotOptions:{bar:{horizontal:true,barHeight:'30%',borderRadius:4}},
            colors:['#0b9168'],
            dataLabels:{enabled:false},
            xaxis:{categories:categories,labels:{formatter:function(val){if(val>=1000)return (val/1000).toFixed(1).replace(/\.0$/,'')+'K';return val;}}},
            tooltip:{y:{formatter:val=>val+' users'}}
        };
        const chart = new ApexCharts(document.querySelector('#user-region-statistics'),options);
        chart.render();
    }
});
</script>
