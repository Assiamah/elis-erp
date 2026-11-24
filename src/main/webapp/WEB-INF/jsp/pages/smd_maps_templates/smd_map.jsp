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

<style>
/* ELIS SMD map page — self-contained emerald theme */
.smd-green {--smd-dark:#064b39;--smd-primary:#087f5b;--smd-bright:#0ba26f;--smd-pale:#e8f7ee;--smd-line:#cce9d9;color:#173d30}
.smd-green .smd-page-hero{background:linear-gradient(115deg,#064b39 0%,#087f5b 58%,#0ba26f 100%);padding:1.35rem 1.65rem;border-radius:1rem;box-shadow:0 12px 30px rgba(6,75,57,.16)}
.smd-green .smd-page-hero h1,.smd-green .smd-page-hero p,.smd-green .smd-page-hero .breadcrumb-item,.smd-green .smd-page-hero .breadcrumb-item.active,.smd-green .smd-page-hero .breadcrumb-item a{color:#fff!important}
.smd-green .smd-page-hero .breadcrumb-item+.breadcrumb-item::before{color:#c6eddd}
.smd-green .smd-page-hero p{opacity:.86}
.smd-green .card{border-radius:.9rem;box-shadow:0 5px 20px rgba(7,83,56,.07)!important}
.smd-green .smd-main-card{border:1px solid #dcefe5!important;overflow:hidden}
.smd-green .smd-main-header{background:linear-gradient(110deg,#064b39,#087f5b 70%,#0ba26f)!important;color:#fff!important;border:0;padding:1rem 1.25rem}
.smd-green .smd-main-header h5{color:#fff!important}
.smd-green .smd-subcard{border:1px solid var(--smd-line)!important;overflow:hidden}
.smd-green .smd-subheader{background:linear-gradient(90deg,#e8f7ee,#f4fbf7)!important;border-bottom:1px solid var(--smd-line)!important;color:#07583f!important}
.smd-green .smd-subheader h6{color:#07583f!important}
.smd-green .smd-section-title{color:#087f5b!important;font-weight:700}
.smd-green .form-control,.smd-green .form-select{border-color:#c8dfd1;border-radius:.5rem}
.smd-green .form-control:focus,.smd-green .form-select:focus{border-color:#0ba26f;box-shadow:0 0 0 .2rem rgba(11,162,111,.13)}
.smd-green .btn{border-radius:.48rem;font-weight:600;transition:background .2s,transform .2s,box-shadow .2s}
.smd-green .btn:hover{transform:translateY(-1px)}
.smd-green .btn-primary,.smd-green .btn-success,.smd-green .btn-info,.smd-green .btn-warning{background:linear-gradient(125deg,#087f5b,#0ba26f)!important;border-color:#087f5b!important;color:#fff!important}
.smd-green .btn-primary:hover,.smd-green .btn-success:hover,.smd-green .btn-info:hover,.smd-green .btn-warning:hover{background:linear-gradient(125deg,#064b39,#087f5b)!important;box-shadow:0 5px 13px rgba(8,127,91,.2)}
.smd-green .btn-outline-primary,.smd-green .btn-outline-info,.smd-green .btn-outline-warning,.smd-green .btn-outline-success{color:#087f5b!important;border-color:#83c9a7!important}
.smd-green .btn-outline-primary:hover,.smd-green .btn-outline-info:hover,.smd-green .btn-outline-warning:hover,.smd-green .btn-outline-success:hover{color:#fff!important;background:#087f5b!important;border-color:#087f5b!important}
.smd-green .btn-check:checked+.btn-outline-primary,.smd-green .btn-check:checked+.btn-outline-warning{background:#087f5b!important;color:#fff!important;border-color:#087f5b!important}
.smd-green .table thead th{background:#e8f7ee!important;color:#07583f!important;border-bottom:2px solid #b4ddc7;white-space:nowrap;font-weight:700}
.smd-green .table tbody tr:hover td{background:#f0faf4}
.smd-green .table td{vertical-align:middle}
.smd-green .smd-map-frame{border:2px solid #b7dec8!important;border-radius:.8rem!important;overflow:hidden;background:#f5faf7;height:600px;min-height:450px}
.smd-green .smd-toolbar{background:#f4faf6;border:1px solid #d5eadd;border-radius:.75rem;padding:.85rem}
.smd-green .smd-map-footer{background:#f5fbf7!important;border-top:1px solid #e1f0e6!important}
.smd-green .form-check-input:checked{background-color:#087f5b;border-color:#087f5b}
@media(max-width:767.98px){.smd-green .smd-page-hero{padding:1rem}.smd-green .smd-map-frame{height:480px;min-height:350px}.smd-green .smd-toolbar{gap:.75rem!important}}
</style>

<div class="main-content app-content smd-green">
 <div class="container-fluid page-container">
  <div class="page-header-breadcrumb smd-page-hero mb-4">
   <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
    <div><h1 class="page-title fw-semibold fs-18 mb-1"><i class="fas fa-map-marked-alt me-2"></i>SMD Map Plottings</h1><p class="small mb-0"><i class="ri-information-line me-1"></i>Manage and plot SMD parcels and scanned map overlays</p></div>
    <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item"><a href="javascript:void(0);">SMD Map Plotting</a></li><li class="breadcrumb-item active" aria-current="page">Maps</li></ol>
   </div>
  </div>
  <div class="row">
   <div class="col-lg-4 col-xl-3">
    <div class="card smd-main-card mb-4">
     <div class="card-header smd-main-header"><h5 class="mb-0 fw-semibold"><i class="fas fa-sliders-h me-2"></i>Control Panel</h5></div>
     <div class="card-body">
      <div class="btn-group w-100 mb-4">
       <button type="button" class="btn btn-primary btn-sm" id="lc_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot" data-bs-tooltip="tooltip" title="Add Coordinate"><i class="fas fa-plus-circle me-1"></i>Add</button>
       <button type="button" class="btn btn-info btn-sm" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv" data-bs-tooltip="tooltip" title="Upload CSV"><i class="fas fa-upload me-1"></i>CSV</button>
       <button type="button" class="btn btn-warning btn-sm" id="smd_btn_visualise_coordinate" data-bs-tooltip="tooltip" title="Visualise Coordinate"><i class="fas fa-eye me-1"></i>Visualise</button>
       <!-- Optional original Save button: id="smd_btn_save_wkt" -->
      </div>
      <div class="mb-4"><h6 class="smd-section-title mb-3"><i class="fas fa-list-ol me-2"></i>Coordinate List</h6>
       <div class="table-responsive"><table class="table table-hover table-sm" id="coordinatelis_Table"><thead><tr><th>Name</th><th>X</th><th>Y</th><th class="text-center">Action</th></tr></thead><tbody><!-- Dynamic rows --></tbody></table></div>
      </div>
      <div class="mb-4"><h6 class="smd-section-title mb-2"><i class="fas fa-draw-polygon me-2"></i>WKT Polygon</h6>
       <textarea class="form-control form-control-sm mb-2" rows="3" id="smd_bl_wkt_polygon" placeholder="POLYGON((...))"></textarea>
       <button type="button" class="btn btn-outline-primary btn-sm w-100" id="smd_btn_visualise_wkt" data-bs-tooltip="tooltip" title="Visualise Polygon"><i class="fas fa-map me-1"></i>Visualise Polygon</button>
       <button type="button" class="btn btn-warning btn-sm w-100 mt-2 d-none" id="smd_btn_request_add_existing_parcel" data-bs-toggle="tooltip" title="Request For Add Existing Parcel"><i class="fas fa-paper-plane me-1"></i>Request For Add Existing Parcel</button>
      </div>
      <div class="card smd-subcard mb-4"><div class="card-header smd-subheader py-2"><h6 class="mb-0 fw-semibold"><i class="fas fa-search-location me-2"></i>Quick Coordinate Search</h6></div>
       <div class="card-body p-3"><div class="row g-2 mb-2">
        <div class="col-5"><input type="text" class="form-control form-control-sm" id="smd_x_coordinate_mak" placeholder="Y Coordinate"></div>
        <div class="col-5"><input type="text" class="form-control form-control-sm" id="smd_y_coordinate_mak" placeholder="X Coordinate"></div>
        <div class="col-2"><button type="button" class="btn btn-primary btn-sm w-100" id="smd_btn_show_location" data-bs-tooltip="tooltip" title="Show Location"><i class="fas fa-map-marker-alt"></i></button></div>
       </div><div class="row g-2"><div class="col-8"><input type="text" class="form-control form-control-sm" id="smd_search_by_text" name="smd_search_by_text" placeholder="Search by Ref Number" required></div>
        <div class="col-2"><button type="button" class="btn btn-info btn-sm w-100" id="smd_btn_search_by_reference_number" data-bs-tooltip="tooltip" title="Search Reference Number"><i class="fas fa-search"></i></button></div>
        <div class="col-2"><button type="button" class="btn btn-success btn-sm w-100" id="smd_btn_load_for_scanned_maps_by_point" data-bs-tooltip="tooltip" title="Search Scanned Map"><i class="fas fa-check-circle"></i></button></div>
       </div></div>
      </div>
      <div class="card smd-subcard mb-4"><div class="card-header smd-subheader py-2"><h6 class="mb-0 fw-semibold"><i class="fas fa-layer-group me-2"></i>Scanned Maps</h6></div>
       <div class="card-body p-3"><div class="mb-3"><select class="form-select form-select-sm" id="geoserverscannedimages_list"><option value="-1">No Scanned Image</option></select></div>
        <div class="d-flex gap-2"><button type="button" class="btn btn-warning btn-sm flex-fill" id="smd_btn_search_for_scanned_maps" data-bs-tooltip="tooltip" title="Search for related sheets"><i class="fas fa-search me-1"></i>Search</button>
         <button type="button" class="btn btn-success btn-sm flex-fill" id="smd_btn_load_for_scanned_maps" data-bs-tooltip="tooltip" title="Show Selected Sheet"><i class="fas fa-check-circle me-1"></i>Load</button></div>
       </div>
      </div>
      <div class="mt-4"><h6 class="smd-section-title mb-3"><i class="fas fa-copy me-2"></i>Multiple Parcel Overlays</h6>
       <div class="table-responsive"><table class="table table-hover table-sm" id="smd_more_than_one_parcel_Table"><thead><tr><th>Ref Number</th><th>Locality</th><th>Plotted By</th><th class="text-center">Details</th></tr></thead><tbody><!-- Dynamic rows --></tbody></table></div>
      </div>
     </div>
    </div>
   </div>
   <div class="col-lg-8 col-xl-9"><div class="card smd-main-card mb-4"><div class="card-header smd-main-header"><h5 class="mb-0 fw-semibold"><i class="fas fa-map me-2"></i>Interactive Map Viewer</h5></div>
    <div class="card-body"><div class="smd-toolbar d-flex flex-wrap align-items-center gap-3 mb-4">
     <div class="btn-group" role="group"><input type="radio" class="btn-check" name="interaction_type" id="draw" value="draw" checked><label class="btn btn-outline-primary btn-sm" for="draw"><i class="fas fa-pencil-alt me-1"></i>Draw</label>
      <input type="radio" class="btn-check" name="interaction_type" id="modify" value="modify"><label class="btn btn-outline-warning btn-sm" for="modify"><i class="fas fa-edit me-1"></i>Modify</label></div>
     <div class="d-flex flex-wrap align-items-center gap-2"><span class="fw-semibold small">Scale:</span>
      <input type="text" class="form-control form-control-sm" id="smd_scale_value_e" name="smd_scale_value_e" placeholder="Custom" style="width:90px;">
      <select class="form-select form-select-sm" style="width:120px;" id="smd_scale_value"><option value="500">1:500</option><option value="1107">1:1,107</option><option value="1250">1:1,250</option><option value="2500">1:2,500</option><option value="2140">1:2,140</option><option value="2670">1:2,670</option><option value="2215">1:2,215</option><option value="2825">1:2,825</option><option value="5000">1:5,000</option><option value="10000">1:10,000</option><option value="15000">1:15,000</option><option value="20000">1:20,000</option></select>
      <div class="form-check mb-0"><input class="form-check-input" type="checkbox" id="smd_lockmapscale" checked><label class="form-check-label small" for="smd_lockmapscale">Lock</label></div>
      <button type="button" class="btn btn-primary btn-sm" id="smd_btn_scale_zoom" data-bs-tooltip="tooltip" title="Zoom to Scale"><i class="fas fa-search"></i></button>
     </div>
     <div class="d-flex flex-wrap gap-2 ms-auto"><button type="button" class="btn btn-outline-primary btn-sm" id="smd_btnprintmap" data-bs-tooltip="tooltip" title="Print Map"><i class="fas fa-print me-1"></i>Print</button>
      <button type="button" class="btn btn-outline-info btn-sm" id="smd_btn_visualise_search" data-bs-tooltip="tooltip" title="Visualise Search"><i class="fas fa-search me-1"></i>Search</button>
      <button type="button" class="btn btn-outline-secondary btn-sm" id="smd_btngeneratesearchreport" data-bs-tooltip="tooltip" title="Print Search Report"><i class="fas fa-file-alt me-1"></i>Report</button></div>
    </div>
    <div class="smd-map-frame"><div id="smd-map" class="h-100 w-100"></div></div>
    </div>
    <div class="card-footer smd-map-footer pt-3"><div class="d-flex justify-content-between align-items-center flex-wrap gap-2"><div class="text-muted small"><i class="fas fa-info-circle me-1"></i>SMD plotting interface</div><div class="text-muted small"><i class="fas fa-sync-alt me-1"></i>Last updated: Just now</div></div></div>
   </div></div>
  </div>
 </div>
</div>

<!-- Uses the application's existing Bootstrap 5 bundle; avoid loading it twice. -->
<script>
(function () {
 function initialiseSmdTooltips() {
  if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) { return; }
  document.querySelectorAll('[data-bs-tooltip="tooltip"], [data-bs-toggle="tooltip"]').forEach(function (el) {
   if (!bootstrap.Tooltip.getInstance(el)) { new bootstrap.Tooltip(el); }
  });
 }
 if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', initialiseSmdTooltips); }
 else { initialiseSmdTooltips(); }
})();
</script>
<script src="${pageContext.request.contextPath}/js-pages/js-map/smdmaps.js?v=20260809-1"></script>
<script src="${pageContext.request.contextPath}/js-pages/gated_workflow.js"></script>
