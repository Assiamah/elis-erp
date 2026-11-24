<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
/* Scoped styles: do not change the surrounding ELIS application */
.rent-maps-page{--rm-green:#087f5b;--rm-dark:#07563f;--rm-light:#e9f8ef;--rm-border:#e1eae5;--rm-text:#193c30;color:var(--rm-text)}
.rent-maps-page .rm-hero{background:linear-gradient(115deg,#075b42,#119c70);color:white;border-radius:18px;padding:24px 28px;box-shadow:0 12px 28px rgba(8,111,80,.17);position:relative;overflow:hidden}
.rent-maps-page .rm-hero:after{content:"";position:absolute;right:-50px;top:-95px;width:310px;height:310px;border:45px solid rgba(255,255,255,.07);border-radius:50%;pointer-events:none}
.rent-maps-page .rm-eyebrow{font-size:11px;text-transform:uppercase;letter-spacing:1.7px;font-weight:800;color:#b9f5d9}
.rent-maps-page .rm-hero h1{font-size:25px;font-weight:800;color:#fff;margin:7px 0}
.rent-maps-page .rm-hero p{color:#d6f7e6;margin:0;font-size:13px}
.rent-maps-page .rm-status{display:inline-flex;align-items:center;gap:7px;background:rgba(255,255,255,.16);border:1px solid rgba(255,255,255,.3);border-radius:100px;padding:8px 13px;font-size:12px;font-weight:700}
.rent-maps-page .rm-dot{height:8px;width:8px;background:#a9f7b9;border-radius:50%}
.rent-maps-page .rm-panel{background:#fff;border:1px solid var(--rm-border);border-radius:16px;box-shadow:0 6px 22px rgba(15,74,53,.055);overflow:hidden}
.rent-maps-page .rm-panel-heading{padding:16px 18px;border-bottom:1px solid var(--rm-border);display:flex;align-items:center;justify-content:space-between;gap:10px}
.rent-maps-page .rm-panel-title{font-size:14px;font-weight:800;margin:0;color:#174d39}
.rent-maps-page .rm-panel-subtitle{font-size:11px;color:#789187;margin-top:3px}
.rent-maps-page .rm-icon{display:inline-flex;align-items:center;justify-content:center;width:35px;height:35px;background:var(--rm-light);color:var(--rm-green);border-radius:10px;font-size:19px}
.rent-maps-page .rm-panel-body{padding:18px}
.rent-maps-page .rm-section-label{display:flex;align-items:center;gap:7px;font-size:11px;letter-spacing:1px;text-transform:uppercase;font-weight:800;color:#789187;margin-bottom:12px}
.rent-maps-page .rm-action-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:7px}
.rent-maps-page .rm-action{min-height:69px;border:1px solid #e2eee7;background:#f8fcfa;border-radius:11px;color:#285743;display:flex;align-items:center;gap:7px;padding:9px;text-align:left;font-size:11px;font-weight:750;transition:all .18s}
.rent-maps-page .rm-action i{font-size:18px;color:#0d8a60}
.rent-maps-page .rm-action:hover{background:#eaf9f0;border-color:#82d3aa;transform:translateY(-2px)}
.rent-maps-page .rm-action-primary{grid-column:span 2;background:#087f5b;color:white;border-color:#087f5b;justify-content:center;min-height:45px}
.rent-maps-page .rm-action-primary i{color:white}
.rent-maps-page .rm-action-primary:hover{background:#076c4d;color:white}
.rent-maps-page .rm-divider{height:1px;background:#e8efeb;margin:20px 0}
.rent-maps-page .rm-field-label{font-size:12px;font-weight:750;color:#355d4a;margin-bottom:7px;display:block}
.rent-maps-page .form-control,.rent-maps-page .form-select{border:1px solid #d9e7de;border-radius:9px;min-height:40px;font-size:13px}
.rent-maps-page .form-control:focus,.rent-maps-page .form-select:focus{border-color:#0f9a6e;box-shadow:0 0 0 .2rem rgba(15,154,110,.13)}
.rent-maps-page .rm-btn-green{background:#087f5b;color:white;border:0;border-radius:9px;padding:11px 16px;font-size:13px;font-weight:750}
.rent-maps-page .rm-btn-green:hover{background:#066a4c;color:white}
.rent-maps-page #wkt-display{min-height:105px;max-height:170px;overflow:auto;white-space:pre-wrap;overflow-wrap:anywhere;background:#f6faf7;border:1px dashed #b8d9c5;border-radius:10px;padding:12px;font:12px/1.6 monospace;color:#426854}
.rent-maps-page .rm-map-wrap{position:relative}
.rent-maps-page #govrent-map{height:680px;width:100%;background:#e8f0e9}
.rent-maps-page .rm-map-footer{padding:12px 17px;border-top:1px solid var(--rm-border);font-size:12px;color:#6c8678;display:flex;justify-content:space-between;gap:12px}
.rent-maps-page .rm-count{background:#e8f8ee;border-radius:99px;padding:5px 10px;color:#087f5b;font-size:11px;font-weight:800}
.rent-maps-page .rm-modal-header{background:linear-gradient(110deg,#075b42,#0b9569);color:#fff}
.rent-maps-page .rm-modal-header .modal-title{color:white;font-weight:800}
.rent-maps-page .rm-modal-header .btn-close{filter:invert(1)}
@media(min-width:992px) and (max-width:1199px){.rent-maps-page .rm-action-grid{grid-template-columns:1fr}.rent-maps-page .rm-action-primary{grid-column:span 1}}
@media(max-width:1199px){.rent-maps-page #govrent-map{height:580px}}
@media(max-width:767px){.rent-maps-page .rm-hero{padding:20px}.rent-maps-page .rm-hero h1{font-size:21px}.rent-maps-page #govrent-map{height:440px}.rent-maps-page .rm-panel-body{padding:14px}}
</style>

<div class="main-content app-content rent-maps-page">
 <div class="container-fluid page-container">
  <div class="rm-hero mb-4">
   <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 position-relative" style="z-index:1">
    <div><div class="rm-eyebrow"><i class="ri-government-line me-1"></i> ELIS / LAND ADMINISTRATION</div>
     <h1><i class="ri-map-2-line me-2"></i>Ground Rent Mapping</h1>
     <p>Explore government estates, locate parcels and manage spatial records in one workspace.</p>
    </div>
    <div class="rm-status"><span class="rm-dot"></span> Mapping Workspace</div>
   </div>
  </div>

  <div class="row g-3">
   <div class="col-xl-3 col-lg-4">
    <div class="rm-panel mb-3">
     <div class="rm-panel-heading">
      <div class="d-flex align-items-center gap-2"><span class="rm-icon"><i class="ri-tools-line"></i></span><div><h2 class="rm-panel-title">Spatial Tools</h2><div class="rm-panel-subtitle">Coordinate and parcel operations</div></div></div>
     </div>
     <div class="rm-panel-body">
      <div class="rm-section-label"><i class="ri-cursor-line"></i> Coordinate operations</div>
      <div class="rm-action-grid">
       <button type="button" class="rm-action" id="pvlmd_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot"><i class="ri-add-circle-line"></i><span>Add Coordinate</span></button>
       <button type="button" class="rm-action" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv"><i class="ri-upload-cloud-2-line"></i><span>Upload CSV</span></button>
       <button type="button" class="rm-action" id="pvlmd_btn_visualise_coordinate"><i class="ri-focus-3-line"></i><span>Visualise Coordinates</span></button>
       <button type="button" class="rm-action" id="pvlmd_btn_visualise_wkt"><i class="ri-shape-2-line"></i><span>Visualise Polygon</span></button>
       <button type="button" class="rm-action rm-action-primary" id="pvlmd_btn_save_parcels"><i class="ri-save-3-line"></i><span>Save Parcel Data</span></button>
      </div>
     </div>
    </div>

    <div class="rm-panel mb-3">
     <div class="rm-panel-heading"><div class="d-flex align-items-center gap-2"><span class="rm-icon"><i class="ri-search-eye-line"></i></span><div><h2 class="rm-panel-title">Find a Property</h2><div class="rm-panel-subtitle">Search the estate and parcel records</div></div></div></div>
     <div class="rm-panel-body">
      <div class="mb-3"><label class="rm-field-label" for="rts_select_type">Search by</label>
       <select class="form-select" id="rts_select_type"><option selected disabled value="-1">Choose a search method</option><option value="Plot Number">Plot Number</option><option value="Estate">Estate</option><option value="Certificate Number">Certificate Number</option></select>
      </div>
      <div class="mb-3 d-none" id="div_rent_estate"><label class="rm-field-label" for="rts_estate">Government estate</label>
       <select name="rts_estate" id="rts_estate" class="form-select"><option selected disabled value="">Select estate</option>
        <c:forEach items="${estate_list}" var="estateList"><option value="<c:out value='${estateList.ge_id}'/>"><c:out value="${estateList.ge_location_name}"/></option></c:forEach>
       </select>
      </div>
      <div class="mb-3 d-none" id="div_rent_keyword"><label class="rm-field-label" for="rts_keyword">Plot number</label><input class="form-control" id="rts_keyword" placeholder="Enter plot number"></div>
      <div class="mb-3 d-none" id="div_certificate_rmap_search"><label class="rm-field-label" for="pvlmd_search_by_text">Certificate number</label>
       <div class="input-group"><input class="form-control" id="pvlmd_search_by_text" type="text" placeholder="Enter certificate number"><button type="button" class="btn btn-outline-success" id="pvlmd_btn_search_by_certificate_number" aria-label="Find certificate"><i class="ri-search-line"></i></button></div>
      </div>
      <div id="div_btn_rmap_search"><button type="button" class="rm-btn-green w-100" id="btn_rmap_search"><i class="ri-search-line me-2"></i>Search on Map</button></div>
     </div>
    </div>

    <div class="rm-panel mb-3">
     <div class="rm-panel-heading"><div class="d-flex align-items-center gap-2"><span class="rm-icon"><i class="ri-code-box-line"></i></span><div><h2 class="rm-panel-title">Geometry / WKT</h2><div class="rm-panel-subtitle">Selected geometry details</div></div></div></div>
     <div class="rm-panel-body"><div id="wkt-display" aria-live="polite"></div><div class="small text-muted mt-2"><i class="ri-information-line me-1"></i>Geometry output appears here when available.</div></div>
    </div>
   </div>

   <div class="col-xl-9 col-lg-8">
    <div class="rm-panel">
     <div class="rm-panel-heading">
      <div class="d-flex align-items-center gap-2"><span class="rm-icon"><i class="ri-map-pin-range-line"></i></span><div><h2 class="rm-panel-title">Government Land Estates Map</h2><div class="rm-panel-subtitle">Spatial overview and parcel visualisation</div></div></div>
      <span class="rm-count"><i class="ri-map-line me-1"></i>Map View</span>
     </div>
     <div class="rm-map-wrap"><div id="govrent-map" role="region" aria-label="Government land estates map"></div></div>
     <div class="rm-map-footer"><span><i class="ri-shield-check-line me-1"></i>ELIS Ground Rent Management</span><span id="map-info" aria-live="polite">Ready</span></div>
    </div>
   </div>
  </div>
 </div>
</div>

<div class="modal fade rent-maps-page" id="addcoordinatetoplot" tabindex="-1" aria-hidden="true">
 <div class="modal-dialog modal-dialog-centered"><div class="modal-content border-0 rounded-4 overflow-hidden">
  <div class="modal-header rm-modal-header"><h5 class="modal-title"><i class="ri-map-pin-add-line me-2"></i>Add Coordinate</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>
  <div class="modal-body p-4"><form id="coordinateForm">
   <div class="mb-3"><label class="rm-field-label" for="latitude">Latitude</label><input type="number" step="any" class="form-control" id="latitude" placeholder="e.g. 5.6037"></div>
   <div class="mb-3"><label class="rm-field-label" for="longitude">Longitude</label><input type="number" step="any" class="form-control" id="longitude" placeholder="e.g. -0.1870"></div>
   <div class="mb-3"><label class="rm-field-label" for="plotNumber">Plot Number</label><input type="text" class="form-control" id="plotNumber" placeholder="Enter plot number"></div>
  </form></div>
  <div class="modal-footer border-0 px-4 pb-4"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button><button type="button" class="rm-btn-green" id="btnSaveCoordinate"><i class="ri-save-line me-1"></i>Save Coordinate</button></div>
 </div></div>
</div>

<div class="modal fade rent-maps-page" id="uploadcoordiantecsv" tabindex="-1" aria-hidden="true">
 <div class="modal-dialog modal-dialog-centered"><div class="modal-content border-0 rounded-4 overflow-hidden">
  <div class="modal-header rm-modal-header"><h5 class="modal-title"><i class="ri-upload-cloud-line me-2"></i>Upload Coordinates CSV</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>
  <div class="modal-body p-4"><form id="csvUploadForm" enctype="multipart/form-data">
   <div class="mb-3"><label class="rm-field-label" for="csvFile">CSV file</label><input class="form-control" type="file" id="csvFile" name="csvFile" accept=".csv,text/csv" required><div class="form-text">Expected columns: Latitude, Longitude, PlotNumber.</div></div>
   <div class="form-check"><input class="form-check-input" type="checkbox" id="hasHeader"><label class="form-check-label" for="hasHeader">File contains a header row</label></div>
  </form></div>
  <div class="modal-footer border-0 px-4 pb-4"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button><button type="button" class="rm-btn-green" id="btnUploadCSV"><i class="ri-upload-cloud-line me-1"></i>Upload CSV</button></div>
 </div></div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const searchType = document.getElementById('rts_select_type');
    const estate = document.getElementById('div_rent_estate');
    const keyword = document.getElementById('div_rent_keyword');
    const certificate = document.getElementById('div_certificate_rmap_search');
    const searchButton = document.getElementById('div_btn_rmap_search');
    function updateSearchFields() {
        estate.classList.add('d-none');
        keyword.classList.add('d-none');
        certificate.classList.add('d-none');
        searchButton.classList.remove('d-none');
        if (searchType.value === 'Estate') {
            estate.classList.remove('d-none');
            searchButton.classList.add('d-none');
        } else if (searchType.value === 'Plot Number') {
            keyword.classList.remove('d-none');
        } else if (searchType.value === 'Certificate Number') {
            certificate.classList.remove('d-none');
            searchButton.classList.add('d-none');
        }
    }
    searchType.addEventListener('change', updateSearchFields);
    updateSearchFields();
});
</script>
