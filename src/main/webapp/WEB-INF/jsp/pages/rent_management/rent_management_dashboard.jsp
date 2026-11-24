<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
/* ELIS Ground Rent Dashboard — scoped green design */
.rent-dashboard{--rd-green:#087f5b;--rd-deep:#07543f;--rd-border:#dcece2;--rd-muted:#668477;color:#193c30}
.rent-dashboard .rd-hero{background:linear-gradient(110deg,#07543f,#0b8a61 65%,#38a77d);border-radius:17px;padding:24px 28px;box-shadow:0 10px 28px rgba(7,84,63,.17);color:#fff}
.rent-dashboard .rd-hero h1{font-size:24px;font-weight:800;color:white;margin:5px 0}
.rent-dashboard .rd-hero p{color:#d6f6e7;margin:0;font-size:13px}
.rent-dashboard .rd-eyebrow{color:#b8f5d6;font-size:11px;font-weight:800;letter-spacing:1.4px;text-transform:uppercase}
.rent-dashboard .rd-hero .breadcrumb-item,.rent-dashboard .rd-hero .breadcrumb-item a{color:#e2fff0!important}
.rent-dashboard .rd-hero .breadcrumb-item+.breadcrumb-item::before{color:#b8f5d6}
.rent-dashboard .rd-card{background:white;border:1px solid var(--rd-border);border-radius:16px;box-shadow:0 5px 20px rgba(8,84,57,.065);overflow:hidden}
.rent-dashboard .rd-metric{height:100%;padding:20px;display:flex;align-items:center;gap:14px;border-left:4px solid #087f5b}
.rent-dashboard .rd-metric-icon{height:47px;width:47px;border-radius:13px;background:#e2f7ea;display:flex;align-items:center;justify-content:center;flex-shrink:0;color:#087f5b;font-size:24px}
.rent-dashboard .rd-metric-label{color:#597a69;font-size:12px;font-weight:700;line-height:1.45}
.rent-dashboard .rd-metric-value{color:#07543f;font-size:24px;font-weight:800;margin-top:6px;overflow-wrap:anywhere}
.rent-dashboard .rd-metric-value small{font-size:12px;font-weight:700;color:#537c68}
.rent-dashboard .rd-metric-outstanding{border-left-color:#d58a27}.rent-dashboard .rd-metric-outstanding .rd-metric-icon{background:#fff3dc;color:#b77718}
.rent-dashboard .rd-metric-paid{border-left-color:#20a474}.rent-dashboard .rd-metric-paid .rd-metric-icon{background:#e0f8eb;color:#15945d}
.rent-dashboard .rd-metric-linked{border-left-color:#7c9d35}.rent-dashboard .rd-metric-linked .rd-metric-icon{background:#f1f8e0;color:#6a8c23}
.rent-dashboard .rd-section-head{padding:17px 20px;border-bottom:1px solid var(--rd-border);display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px}
.rent-dashboard .rd-section-title{color:#07543f;font-size:15px;font-weight:800;margin:0}
.rent-dashboard .rd-section-desc{font-size:12px;color:#799184;margin-top:4px}
.rent-dashboard .rd-section-body{padding:20px}
.rent-dashboard .rd-search-panel{border:1px solid #d5eade;border-radius:13px;background:#f4fbf6;padding:18px;margin-bottom:19px}
.rent-dashboard .rd-search-label{font-size:11px;text-transform:uppercase;letter-spacing:1px;color:#087f5b;font-weight:800;margin-bottom:12px}
.rent-dashboard .form-select,.rent-dashboard .form-control{border:1px solid #cfe5d8;border-radius:9px;min-height:41px;font-size:13px}
.rent-dashboard .form-select:focus,.rent-dashboard .form-control:focus{border-color:#0b9569;box-shadow:0 0 0 .2rem rgba(11,149,105,.13)}
.rent-dashboard .rd-btn{border-radius:9px;font-size:12px;font-weight:750;padding:9px 13px;display:inline-flex;align-items:center;justify-content:center;gap:5px;white-space:nowrap}
.rent-dashboard .rd-btn-primary{background:#087f5b;color:#fff;border:1px solid #087f5b}.rent-dashboard .rd-btn-primary:hover{background:#07543f;color:white}
.rent-dashboard .rd-btn-soft{background:#e4f7ec;color:#07543f;border:1px solid #b5dec8}.rent-dashboard .rd-btn-soft:hover{background:#c9efd9;color:#07543f}
.rent-dashboard .rd-btn-amber{background:#f7edda;color:#805716;border:1px solid #e8d4ac}.rent-dashboard .rd-btn-amber:hover{background:#efdfbd;color:#805716}
.rent-dashboard .rd-btn-alert{background:#fff0e9;color:#b3542b;border:1px solid #f1cfbc}.rent-dashboard .rd-btn-alert:hover{background:#ffe3d4;color:#a44620}
.rent-dashboard .rd-table-scroll{overflow-x:auto}
.rent-dashboard #tbl_rent_records{font-size:12px;border-collapse:separate;border-spacing:0;width:100%!important}
.rent-dashboard #tbl_rent_records thead th{background:linear-gradient(110deg,#07543f,#0c9365)!important;color:#fff!important;font-size:11px;font-weight:750;padding:13px 12px;border:0;white-space:nowrap}
.rent-dashboard #tbl_rent_records tbody td{padding:12px;border-bottom:1px solid #e5f0e8;vertical-align:middle}
.rent-dashboard #tbl_rent_records tbody tr:nth-child(even){background:#f7fcf9}
.rent-dashboard #tbl_rent_records tbody tr:hover{background:#e8f8ee}
.rent-dashboard .rd-side-body{padding:14px 17px}
.rent-dashboard .rd-empty{min-height:165px;display:flex;flex-direction:column;align-items:center;justify-content:center;color:#789184;text-align:center}
.rent-dashboard .rd-empty i{font-size:35px;color:#8cbca2;margin-bottom:8px}
.rent-dashboard .rd-chart{min-height:355px}
.rent-dashboard .rd-note{font-size:11px;color:#789184}
/* The included JSPs render their modals outside the dashboard wrapper. Match their modal headers explicitly. */
#incomingLesseeUpdatesModal .modal-content,#addlegder .modal-content{border:0;border-radius:16px;overflow:hidden;box-shadow:0 20px 55px rgba(7,84,63,.2)}
#incomingLesseeUpdatesModal .modal-header,#addlegder .modal-header{background:linear-gradient(110deg,#07543f,#0c9365)!important;color:#fff!important;padding:18px 22px}
#incomingLesseeUpdatesModal .modal-header .modal-title,#addlegder .modal-header .modal-title{color:#fff!important;font-weight:800}
#incomingLesseeUpdatesModal .modal-header .btn-close,#addlegder .modal-header .btn-close{filter:invert(1) grayscale(1)}
@media(max-width:767px){.rent-dashboard .rd-hero{padding:19px}.rent-dashboard .rd-hero h1{font-size:21px}.rent-dashboard .rd-section-body{padding:13px}.rent-dashboard .rd-section-head{padding:15px}.rent-dashboard .rd-metric{padding:16px}}
</style>

<div class="main-content app-content rent-dashboard">
 <div class="container-fluid page-container">
  <div class="rd-hero mb-4">
   <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
    <div><div class="rd-eyebrow"><i class="ri-government-line me-1"></i> ELIS / GROUND RENT</div>
     <h1><i class="ri-dashboard-3-line me-2"></i>Rent Management Dashboard</h1>
     <p>Monitor rent accounts, outstanding balances, lessee records and payments.</p>
    </div>
    <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item active" aria-current="page">Rent Dashboard</li></ol>
   </div>
  </div>

  <div class="row g-3 mb-4">
   <div class="col-xl-3 col-sm-6"><div class="rd-card h-100"><div class="rd-metric"><span class="rd-metric-icon"><i class="ri-group-line"></i></span><div><div class="rd-metric-label">Total Lessees / Assignees</div><div class="rd-metric-value" id="total_leasee"><c:out value="${total_leasee}" default="0"/></div></div></div></div></div>
   <div class="col-xl-3 col-sm-6"><div class="rd-card h-100"><div class="rd-metric rd-metric-outstanding"><span class="rd-metric-icon"><i class="ri-error-warning-line"></i></span><div><div class="rd-metric-label">Total Rent Outstanding</div><div class="rd-metric-value" id="rentOutstanding"><small>GHS</small> <c:out value="${total_rent_outstanding}" default="0.00"/></div></div></div></div></div>
   <div class="col-xl-3 col-sm-6"><div class="rd-card h-100"><div class="rd-metric rd-metric-paid"><span class="rd-metric-icon"><i class="ri-money-dollar-circle-line"></i></span><div><div class="rd-metric-label">Total Rents Paid (This Year)</div><div class="rd-metric-value"><small>GHS</small> 0.00</div></div></div></div></div>
   <div class="col-xl-3 col-sm-6"><div class="rd-card h-100"><div class="rd-metric rd-metric-linked"><span class="rd-metric-icon"><i class="ri-user-follow-line"></i></span><div><div class="rd-metric-label">Accounts Linked</div><div class="rd-metric-value" id="total_account_linked">0</div></div></div></div></div>
  </div>

  <div class="row g-3">
   <div class="col-12">
    <div class="rd-card mb-3">
     <div class="rd-section-head">
      <div><h2 class="rd-section-title"><i class="ri-file-list-3-line me-2"></i>Lessee &amp; Rent Records</h2><div class="rd-section-desc">Search and manage registered lessee accounts</div></div>
      <div class="d-flex flex-wrap gap-2">
       <c:if test="${sessionScope.view_all_offices == 'true' or sessionScope.view_all_offices == 'yes' or fn:containsIgnoreCase(sessionScope.user_level, 'admin') or fn:containsIgnoreCase(sessionScope.designation, 'admin')}">
        <a class="rd-btn rd-btn-soft" href="${pageContext.request.contextPath}/admin/incoming_lessee_updates"><i class="ri-dashboard-3-line"></i> Regional Review Centre</a>
       </c:if>
       <button type="button" class="rd-btn rd-btn-alert" data-bs-toggle="modal" data-bs-target="#incomingLesseeUpdatesModal"><i class="ri-inbox-archive-line"></i> Incoming Updates <span class="badge bg-white text-dark"><c:out value="${total_incoming_lessee_update}" default="0"/></span></button>
       <button type="button" class="rd-btn rd-btn-amber" data-bs-toggle="modal" data-bs-target="#addlegder"><i class="ri-user-add-line"></i> Add Lessee</button>
      </div>
     </div>
     <div class="rd-section-body">
      <div class="rd-search-panel">
       <div class="rd-search-label"><i class="ri-search-eye-line me-1"></i> Find a lessee or rent account</div>
       <div class="row g-3 align-items-end">
        <div class="col-lg-4 col-md-5"><label class="form-label small fw-semibold" for="rts_select_type">Search By</label>
         <select class="form-select" id="rts_select_type" data-trigger><option disabled selected>-- Select Type --</option><option value="Plot Number">Plot Number</option><option value="Estate">Estate</option><option value="Name of Leasee/Assignee">Name of Lessee</option></select>
        </div>
        <div class="col-lg-5 col-md-5">
         <div class="d-none" id="div_rent_estate"><label class="form-label small fw-semibold" for="rts_estate">Estate</label><select class="form-select" id="rts_estate" data-trigger><c:forEach items="${estate_list}" var="estateList"><option value="<c:out value='${estateList.ge_id}'/>"><c:out value="${estateList.ge_location_name}"/></option></c:forEach></select></div>
         <div class="d-none" id="div_rent_keyword"><label class="form-label small fw-semibold" for="rts_keyword">Keyword</label><input type="text" class="form-control" id="rts_keyword" placeholder="Enter plot number or lessee name..."></div>
        </div>
        <div class="col-lg-3 col-md-2"><button type="button" class="rd-btn rd-btn-primary w-100" id="btn_rt_search"><i class="ri-search-line"></i> Search</button></div>
       </div>
      </div>
      <div class="rd-table-scroll table-responsive"><table class="table table-hover align-middle mb-0" id="tbl_rent_records">
       <thead><tr><th>Action</th><th>Account Number</th><th>Plot Number</th><th>Name of Lessee</th><th>File Number</th><th>Commencement Date</th><th>Term</th><th>Plot Size</th><th>Last Review Date</th><th>Last Payment Period</th><th>Rent Outstanding</th><th>Unexpired Term</th></tr></thead>
       <tbody></tbody>
      </table></div>
     </div>
    </div>
   </div>
  </div>
 </div>
</div>

<jsp:include page="../../components/_incoming_lessee_updates_modal.jsp" />
<jsp:include page="../../components/_rent_management_modals.jsp" />
