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
/* Scoped ELIS emerald design — does not override the global application theme. */
.lrd-green { --lrd-dark:#064b39;--lrd-deep:#053f31;--lrd-primary:#087f5b;--lrd-bright:#0ba26f;--lrd-soft:#e8f7ee;--lrd-border:#d3e9dc;--lrd-ink:#193d31; color:var(--lrd-ink); }
.lrd-green .lrd-hero{background:linear-gradient(120deg,#064b39 0%,#087f5b 65%,#0ba26f 100%);color:#fff;border-radius:18px;padding:23px 27px;box-shadow:0 14px 30px rgba(6,75,57,.18);margin-bottom:22px;position:relative;overflow:hidden}
.lrd-green .lrd-hero:after{content:"";position:absolute;width:260px;height:260px;border-radius:50%;background:rgba(255,255,255,.06);right:-90px;top:-150px;pointer-events:none}
.lrd-green .lrd-hero h1,.lrd-green .lrd-hero p{color:#fff!important}
.lrd-green .lrd-hero p{opacity:.86}
.lrd-green .lrd-hero .breadcrumb-item,.lrd-green .lrd-hero .breadcrumb-item a{color:rgba(255,255,255,.85)!important}
.lrd-green .lrd-hero .breadcrumb-item.active{color:#fff!important}
.lrd-green .lrd-kpi{display:inline-flex;align-items:center;gap:8px;border:1px solid rgba(255,255,255,.23);background:rgba(255,255,255,.14);padding:8px 13px;border-radius:12px;color:#fff;font-size:.88rem}
.lrd-green .lrd-card{background:#fff;border:1px solid var(--lrd-border)!important;border-radius:16px;overflow:hidden;box-shadow:0 8px 24px rgba(6,75,57,.07)!important}
.lrd-green .lrd-card>.card-header{background:linear-gradient(120deg,var(--lrd-dark),var(--lrd-primary))!important;color:#fff!important;border:0!important;padding:16px 19px}
.lrd-green .lrd-card>.card-header h5{color:#fff!important}
.lrd-green .lrd-section-title{font-weight:750;color:var(--lrd-dark)!important;display:flex;align-items:center;gap:8px;margin-bottom:12px}
.lrd-green .lrd-section-title i{color:var(--lrd-bright)}
.lrd-green .lrd-subcard{border:1px solid var(--lrd-border)!important;border-radius:13px;overflow:hidden;background:#fcfffd}
.lrd-green .lrd-subcard>.card-header{background:var(--lrd-soft)!important;border-bottom:1px solid var(--lrd-border)!important;color:var(--lrd-dark)!important;padding:11px 14px}
.lrd-green .lrd-subcard>.card-header h6{color:var(--lrd-dark)!important}
.lrd-green .form-control,.lrd-green .form-select,.lrd-green .input-group-text{border-color:#cfe2d6;border-radius:8px}
.lrd-green .form-control:focus,.lrd-green .form-select:focus{border-color:var(--lrd-bright);box-shadow:0 0 0 .2rem rgba(11,162,111,.13)}
.lrd-green .form-check-input:checked{background-color:var(--lrd-primary);border-color:var(--lrd-primary)}
.lrd-green .btn{border-radius:9px;font-weight:600;transition:transform .15s,box-shadow .15s}
.lrd-green .btn:hover{transform:translateY(-1px)}
.lrd-green .btn-primary,.lrd-green .btn-success{background:var(--lrd-primary)!important;border-color:var(--lrd-primary)!important;color:#fff!important}
.lrd-green .btn-primary:hover,.lrd-green .btn-success:hover{background:var(--lrd-dark)!important;border-color:var(--lrd-dark)!important}
.lrd-green .btn-info{background:#15876d!important;border-color:#15876d!important;color:#fff!important}
.lrd-green .btn-warning{background:#d5a13c!important;border-color:#d5a13c!important;color:#253528!important}
.lrd-green .btn-outline-primary,.lrd-green .btn-outline-success,.lrd-green .btn-outline-info{border-color:var(--lrd-primary)!important;color:var(--lrd-primary)!important;background:#fff}
.lrd-green .btn-outline-primary:hover,.lrd-green .btn-outline-success:hover,.lrd-green .btn-outline-info:hover{background:var(--lrd-primary)!important;color:#fff!important}
.lrd-green .lrd-toolbar{background:#f5fbf7;border:1px solid var(--lrd-border);border-radius:13px;padding:12px;margin-bottom:16px}
.lrd-green .lrd-map-frame{height:600px;border:2px solid #b9dfc9;border-radius:13px;overflow:hidden;background:#eef7f0;position:relative}
.lrd-green #lrd-map{height:100%;width:100%}
.lrd-green .table{font-size:.83rem;margin-bottom:0}
.lrd-green .table thead th{background:#e9f6ee!important;color:var(--lrd-dark)!important;font-weight:700;border-bottom:1px solid var(--lrd-border);white-space:nowrap}
.lrd-green .table tbody tr:hover{background:#f0faf4}
.lrd-green .lrd-divider{border-top:1px solid #e2eee6;margin:18px 0}
.lrd-green .lrd-map-footer{background:#f8fcf9;color:#527365;padding:11px 18px;border-top:1px solid var(--lrd-border)}
@media(max-width:991.98px){.lrd-green .lrd-map-frame{height:480px}}
@media(max-width:575.98px){.lrd-green .lrd-hero{padding:19px}.lrd-green .lrd-map-frame{height:380px}.lrd-green .lrd-toolbar .btn{margin-bottom:3px}}
</style>

<div class="main-content app-content lrd-green">
 <div class="container-fluid page-container">
  <div class="lrd-hero">
   <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
    <div><div class="small mb-2" style="opacity:.8"><i class="fas fa-layer-group me-1"></i> ELIS / LAND REGISTRATION DIVISION</div><h1 class="fw-bold fs-22 mb-2">LRD Map Plottings</h1><p class="mb-0"><i class="ri-information-line me-1"></i>Manage and plot LRD parcels and transactions</p></div>
    <div class="text-lg-end"><ol class="breadcrumb justify-content-lg-end mb-2"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item"><a href="javascript:void(0);">LRD Map Plotting</a></li><li class="breadcrumb-item active">Maps</li></ol><div class="d-flex flex-wrap gap-2 justify-content-lg-end"><span class="lrd-kpi"><i class="ri-map-pin-line"></i>Parcels: <strong><c:out value="${parcel_count}" default="0"/></strong></span><span class="lrd-kpi"><i class="ri-ruler-2-line"></i>Acreage: <strong><c:out value="${total_acreage}" default="0"/></strong></span></div></div>
   </div>
  </div>
  <div class="row g-3">
   <div class="col-lg-4 col-xl-3">
    <div class="card lrd-card mb-4"><div class="card-header"><h5 class="mb-0 fw-semibold"><i class="fas fa-sliders-h me-2"></i>Control Panel</h5></div>
     <div class="card-body p-3">
      <div class="d-flex flex-wrap gap-2 mb-4">
       <button type="button" class="btn btn-primary btn-sm flex-fill" id="lc_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot" data-bs-tooltip="tooltip" title="Add Coordinate"><i class="fas fa-plus-circle me-1"></i>Add</button>
       <button type="button" class="btn btn-info btn-sm flex-fill" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv" data-bs-tooltip="tooltip" title="Upload CSV"><i class="fas fa-upload me-1"></i>CSV</button>
       <button type="button" class="btn btn-warning btn-sm flex-fill" id="lrd_btn_visualise_coordinate" data-bs-tooltip="tooltip" title="Visualise Polygon"><i class="fas fa-eye me-1"></i>Visualise</button>
       <button type="button" class="btn btn-success btn-sm flex-fill" id="lrd_btn_save_wkt" data-bs-tooltip="tooltip" title="Plot Parcel"><i class="fas fa-save me-1"></i>Save</button>
      </div>
      <h6 class="lrd-section-title"><i class="fas fa-list-ol"></i>Coordinate List</h6>
      <div class="table-responsive"><table class="table table-hover table-sm" id="coordinatelis_Table"><thead><tr><th>Name</th><th>X</th><th>Y</th><th class="text-center">Action</th></tr></thead><tbody></tbody></table></div>
      <div class="lrd-divider"></div>
      <h6 class="lrd-section-title"><i class="fas fa-draw-polygon"></i>WKT Polygon</h6>
      <textarea class="form-control form-control-sm" rows="3" id="lrd_txt_wkt_polygon" placeholder="POLYGON((...))"></textarea>
      <button type="button" class="btn btn-outline-primary btn-sm w-100 mt-2" id="lrd_btn_visualise_wkt" data-bs-tooltip="tooltip" data-bs-original-title="Visualise Polygon"><i class="fas fa-map me-1"></i>Visualise Polygon</button>
      <button type="button" class="btn btn-outline-danger btn-sm w-100 mt-2" id="lrd_btn_refresh_btn_wkt" data-bs-tooltip="tooltip" title="Refresh"><i class="fas fa-redo me-1"></i>Refresh</button>
      <div class="card lrd-subcard mt-4 mb-3"><div class="card-header"><h6 class="mb-0 fw-semibold"><i class="fas fa-search-location me-2"></i>Quick Coordinate Search</h6></div><div class="card-body p-3">
       <div class="row g-2 mb-2"><div class="col-5"><input type="text" class="form-control form-control-sm" id="lrd_x_coordinate" placeholder="Y Coordinate"></div><div class="col-5"><input type="text" class="form-control form-control-sm" id="lrd_y_coordinate" placeholder="X Coordinate"></div><div class="col-2"><button type="button" class="btn btn-primary btn-sm w-100" id="lrd_btn_show_location" title="Show Location"><i class="fas fa-map-marker-alt"></i></button></div></div>
       <div class="row g-2"><div class="col-10"><input type="text" class="form-control form-control-sm" id="lrd_search_by_text" placeholder="Search by Certificate/Ref Number"></div><div class="col-2"><button type="button" class="btn btn-info btn-sm w-100" id="lrd_btn_search_by_certificate_number" title="Search"><i class="fas fa-search"></i></button></div></div>
       <div class="row g-2 mt-2"><div class="col-8"><input type="text" class="form-control form-control-sm" id="lrd_search_smd_by_text" placeholder="Search SMD Records by Ref"></div><div class="col-4"><button type="button" class="btn btn-warning btn-sm w-100" id="lrd_btn_search_smd_dat_by_ref" title="Search SMD"><i class="fas fa-database"></i> SMD</button></div></div>
       <div class="row g-2 mt-2"><div class="col-8"><input type="text" class="form-control form-control-sm" id="lrd_search_by_reference" placeholder="Search by Reference Number"></div><div class="col-4"><button type="button" class="btn btn-primary btn-sm w-100" id="lrd_btn_search_by_reference_number" title="Search by Reference"><i class="fas fa-search"></i> Ref</button></div></div>
      </div></div>
      <div class="card lrd-subcard mb-3"><div class="card-header"><h6 class="mb-0 fw-semibold"><i class="fas fa-layer-group me-2"></i>Scanned Maps</h6></div><div class="card-body p-3"><div class="mb-3"><select class="form-select form-select-sm" id="geoserverscannedimages_list"><option value="-1">Select Scanned Image</option></select></div><div class="d-flex gap-2"><button type="button" class="btn btn-warning btn-sm flex-fill" id="lrd_btn_search_for_scanned_maps"><i class="fas fa-search me-1"></i>Search</button><button type="button" class="btn btn-success btn-sm flex-fill" id="lrd_btn_load_for_scanned_maps"><i class="fas fa-check-circle me-1"></i>Load</button></div><div class="d-flex gap-2 mt-2"><button type="button" class="btn btn-info btn-sm flex-fill" id="lrd_btn_load_for_scanned_maps_by_point"><i class="fas fa-map-pin me-1"></i>Load by Point</button></div></div></div>
      <div class="card lrd-subcard"><div class="card-header"><h6 class="mb-0 fw-semibold"><i class="fas fa-search-plus me-2"></i>Advanced Search</h6></div><div class="card-body p-3"><div class="mb-3"><input class="form-control form-control-sm" type="text" id="scannned_map_to_search_for" placeholder="Enter Map name" list="listofscannnedmaptosearchfor"><datalist id="listofscannnedmaptosearchfor"></datalist></div><div class="d-flex gap-2"><button type="button" class="btn btn-info btn-sm flex-fill" id="lrd_btn_search_for_scanned_maps_all"><i class="fas fa-search me-1"></i>Find</button><button type="button" class="btn btn-primary btn-sm flex-fill" id="lrd_btn_load_for_scanned_maps_all"><i class="fas fa-layer-group me-1"></i>Load All</button></div></div></div>
      <div class="mt-4"><h6 class="lrd-section-title"><i class="fas fa-copy"></i>Multiple Parcel Overlays</h6><div class="table-responsive"><table class="table table-hover table-sm" id="lrd_more_than_one_parcel_Table"><thead><tr><th>Reference Number</th><th>Locality</th><th>Remarks</th><th class="text-center">Details</th></tr></thead><tbody></tbody></table></div></div>
     </div>
    </div>
   </div>
   <div class="col-lg-8 col-xl-9"><div class="card lrd-card mb-4"><div class="card-header"><h5 class="mb-0 fw-semibold"><i class="fas fa-map me-2"></i>Interactive Map Viewer</h5></div><div class="card-body p-3 p-xl-4">
    <div class="lrd-toolbar d-flex flex-wrap align-items-center gap-3">
     <div class="btn-group flex-wrap" role="group"><button type="button" class="btn btn-outline-primary btn-sm" id="lrd_btn_draw_polygon" title="Draw Polygon"><i class="fas fa-draw-polygon me-1"></i>Draw</button><button type="button" class="btn btn-outline-warning btn-sm" id="lrd_btn_modify_polygon" title="Modify Shape"><i class="fas fa-edit me-1"></i>Modify</button><button type="button" class="btn btn-outline-danger btn-sm" id="lrd_btn_delete_polygon" title="Delete Selected"><i class="fas fa-trash me-1"></i>Delete</button><button type="button" class="btn btn-outline-success btn-sm" id="lrd_btn_measure_distance" title="Measure Distance"><i class="fas fa-ruler me-1"></i>Measure</button><button type="button" class="btn btn-outline-info btn-sm" id="lrd_btn_measure_area" title="Measure Area"><i class="fas fa-ruler-combined me-1"></i>Area</button></div>
     <div class="d-flex align-items-center gap-2 flex-wrap"><label class="fw-semibold" for="lrd_scale_value">Scale:</label><select class="form-select form-select-sm" style="width:120px" id="lrd_scale_value"><option value="500">1:500</option><option value="1107">1:1,107</option><option value="1250">1:1,250</option><option value="2500">1:2,500</option><option value="5000">1:5,000</option><option value="10000">1:10,000</option><option value="15000">1:15,000</option><option value="20000">1:20,000</option></select><div class="form-check mb-0"><input class="form-check-input" type="checkbox" id="lrd_lockmapscale" checked><label class="form-check-label small" for="lrd_lockmapscale">Lock</label></div><button type="button" class="btn btn-primary btn-sm" id="lrd_btn_scale_zoom" title="Zoom to Scale"><i class="fas fa-search"></i></button></div>
     <div class="d-flex gap-2 flex-wrap ms-xl-auto"><!-- Keep the original refresh selector unique: two buttons with this ID would cause unpredictable event binding. --><button type="button" class="btn btn-outline-danger btn-sm" id="lrd_btn_refresh_map" title="Refresh Map"><i class="fas fa-redo me-1"></i>Refresh</button><button type="button" class="btn btn-outline-primary btn-sm" id="lrd_btn_print_map" title="Print Map"><i class="fas fa-print me-1"></i>Print</button><button type="button" class="btn btn-outline-secondary btn-sm" id="lrd_btn_clear_measurements" title="Clear Measurements"><i class="fas fa-eraser me-1"></i>Clear</button></div>
    </div>
    <div class="lrd-map-frame"><div id="lrd-map"></div></div>
   </div><div class="lrd-map-footer d-flex justify-content-between align-items-center flex-wrap gap-2"><span class="small"><i class="fas fa-info-circle me-1"></i>Total Parcels: <strong><c:out value="${parcel_count}" default="0"/></strong></span><span class="small"><i class="fas fa-map-marked-alt me-1"></i>LRD Parcel Plotting Workspace</span></div></div></div>
  </div>
 </div>
</div>

<jsp:include page="lrd_maps_modals.jsp" />
<script>
(function(){
 function setupLrdTooltips(){if(typeof bootstrap==='undefined'||!bootstrap.Tooltip)return;document.querySelectorAll('.lrd-green [data-bs-tooltip="tooltip"]').forEach(function(el){if(!bootstrap.Tooltip.getInstance(el))new bootstrap.Tooltip(el);});}
 if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',setupLrdTooltips);else setupLrdTooltips();
 // Map refresh delegates to the existing WKT refresh handler where it is bound.
 document.addEventListener('click',function(event){var button=event.target.closest('#lrd_btn_refresh_map');if(!button)return;var existing=document.getElementById('lrd_btn_refresh_btn_wkt');if(existing)existing.click();});
})();
</script>
<script src="${pageContext.request.contextPath}/js-pages/gated_workflow.js"></script>
<script src="${pageContext.request.contextPath}/js-pages/lrdmaps.js"></script>
