<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
/* ELIS Ground Rent Setup — emerald green redesign, scoped to this page */
.page-container {--rent-green:#087f5b;--rent-deep:#07543f;--rent-lime:#dff7e9;--rent-ink:#183b31;color:var(--rent-ink)}
.page-container .page-header-breadcrumb{background:linear-gradient(110deg,#07543f,#0b8a61 65%,#38a77d);border-radius:16px;padding:24px 28px;box-shadow:0 10px 28px rgba(7,84,63,.19)}
.page-container .page-header-breadcrumb .page-title,.page-container .page-header-breadcrumb .breadcrumb-item,.page-container .page-header-breadcrumb .breadcrumb-item.active{color:#fff!important}
.page-container .page-header-breadcrumb .breadcrumb-item + .breadcrumb-item::before{color:#b9f4d5}
.page-container .page-title{font-size:22px!important;font-weight:800!important}
.page-container .custom-card{border:1px solid #d9eee3;border-radius:16px;box-shadow:0 5px 18px rgba(8,84,57,.07);overflow:hidden;transition:transform .18s,box-shadow .18s}
.page-container .row.g-3.mb-3 .custom-card:hover{transform:translateY(-3px);box-shadow:0 10px 24px rgba(8,84,57,.14)}
.page-container .row.g-3.mb-3 .col-md-4:nth-child(1) .custom-card{background:linear-gradient(125deg,#e5f7ee,#fff);border-left:5px solid #087f5b}
.page-container .row.g-3.mb-3 .col-md-4:nth-child(2) .custom-card{background:linear-gradient(125deg,#d9fbe8,#fff);border-left:5px solid #16a34a}
.page-container .row.g-3.mb-3 .col-md-4:nth-child(3) .custom-card{background:linear-gradient(125deg,#effce1,#fff);border-left:5px solid #65a30d}
.page-container .row.g-3.mb-3 .custom-card .card-body{padding:22px 24px}
.page-container .row.g-3.mb-3 .custom-card .text-muted{font-size:13px;font-weight:700;color:#466b59!important}
.page-container .row.g-3.mb-3 .custom-card h4{font-size:31px;font-weight:800;margin:10px 0 0;color:#07543f}
.page-container .row.g-3.mb-3 .col-md-4:nth-child(2) h4{color:#15803d}
.page-container .row.g-3.mb-3 .col-md-4:nth-child(3) h4{color:#4d7c0f}
.page-container > .card.custom-card .card-header{background:linear-gradient(90deg,#e7f7ee,#f5fff9);padding:19px 22px;border-bottom:1px solid #cdebd9}
.page-container .card-title{font-size:17px;font-weight:800;color:#07543f;margin:0}
.page-container .form-label{font-weight:700;color:#255543}
.page-container .form-control,.page-container .form-select{border-radius:10px;border-color:#cfe5d8;min-height:42px}
.page-container .form-control:focus,.page-container .form-select:focus{border-color:#16a34a;box-shadow:0 0 0 .2rem rgba(22,163,74,.13)}
.page-container .btn{border-radius:9px;font-weight:700}
.page-container .btn-primary,.page-container .btn-success{background:#087f5b;border-color:#087f5b;color:#fff}
.page-container .btn-primary:hover,.page-container .btn-success:hover{background:#07543f;border-color:#07543f;color:#fff}
.page-container .btn-primary-light{background:#e3f7eb;color:#07543f;border:1px solid #a9ddc1}
.page-container .btn-primary-light:hover{background:#087f5b;color:#fff}
.page-container .btn-light{background:#eff7f1;border:1px solid #cfe5d8;color:#255543}
.page-container .rent-filter-panel{background:#f4fbf6;border:1px solid #d9eee3;border-radius:13px;padding:18px 20px;margin-bottom:18px}
.page-container .rent-filter-title{font-size:12px;font-weight:800;letter-spacing:.07em;text-transform:uppercase;color:#087f5b;margin-bottom:12px}
.page-container #estateSetupTable{border-collapse:separate;border-spacing:0;font-size:13px}
.page-container #estateSetupTable thead th{background:#07543f;color:#fff;padding:14px 12px;font-size:12px;white-space:nowrap;border:0}
.page-container #estateSetupTable thead th:first-child{border-top-left-radius:10px}
.page-container #estateSetupTable thead th:last-child{border-top-right-radius:10px}
.page-container #estateSetupTable tbody td{padding:13px 12px;border-bottom:1px solid #e7f1e9;color:#334b3d;vertical-align:middle}
.page-container #estateSetupTable tbody tr:nth-child(even) td{background:#f6fbf7}
.page-container #estateSetupTable tbody tr:hover td{background:#e6f7ec}
.page-container #estateSetupTable tbody td:nth-child(2){font-weight:700;color:#07543f}
.page-container #estateSetupTable .badge{border-radius:20px;padding:7px 11px;font-weight:700}
.page-container #estateSetupTable .bg-success-transparent{background:#d1fae5!important;color:#047857!important}
.page-container #estateSetupTable .bg-secondary-transparent{background:#edf2ef!important;color:#63766b!important}
.page-container #resultCount{color:#087f5b!important;font-weight:700}
#estateSetupModal .modal-content{border:0;border-radius:17px;overflow:hidden;box-shadow:0 22px 65px rgba(9,65,42,.25)}
#estateSetupModal .modal-header{background:linear-gradient(100deg,#07543f,#0c9365);color:#fff;padding:20px 24px}
#estateSetupModal .modal-header .btn-close{filter:invert(1) grayscale(1);opacity:.9}
#estateSetupModal .modal-title{font-weight:800}
#estateSetupModal .modal-body{padding:26px}
#estateSetupModal .modal-footer{background:#f4fbf6;border-top:1px solid #d9eee3;padding:16px 24px}
#estateSetupModal .form-label{font-weight:700;color:#255543}
#estateSetupModal .form-control,#estateSetupModal .form-select{border-radius:10px;border-color:#cfe5d8}
#estateSetupModal .btn-primary{background:#087f5b;border-color:#087f5b}
#estateSetupModal .btn-primary:hover{background:#07543f;border-color:#07543f}
@media(max-width:767px){.page-container .page-header-breadcrumb{padding:18px}.page-container .row.g-3.mb-3 .custom-card .card-body{padding:17px}.page-container #estateSetupTable{font-size:12px}.page-container .rent-filter-panel{padding:14px}}
</style>


<style>
/* Visual refresh matching the Ground Rent Mapping workspace; scoped to this JSP. */
.rent-setup-refined{--rent-green:#087f5b;--rent-deep:#075b42;--rent-border:#e1eae5;color:#193c30}
.rent-setup-refined .page-header-breadcrumb{background:linear-gradient(115deg,#075b42,#119c70)!important;position:relative;overflow:hidden;border-radius:18px!important;padding:24px 28px!important;box-shadow:0 12px 28px rgba(8,111,80,.17)!important;margin-bottom:20px!important}
.rent-setup-refined .page-header-breadcrumb:after{content:"";position:absolute;right:-60px;top:-100px;width:300px;height:300px;border:45px solid rgba(255,255,255,.07);border-radius:50%;pointer-events:none}
.rent-setup-refined .page-header-breadcrumb>.d-flex{position:relative;z-index:1;gap:14px}
.rent-setup-refined .rent-kicker{font-size:11px;letter-spacing:1.6px;font-weight:800;color:#b9f5d9;margin-bottom:7px}
.rent-setup-refined .rent-hero-caption{font-size:13px;color:#d6f7e6}
.rent-setup-refined .page-title{font-size:25px!important;color:white!important}
.rent-setup-refined .row.g-3.mb-3 .custom-card{border:1px solid #e1eae5!important;border-left:0!important;border-radius:16px!important;box-shadow:0 6px 22px rgba(15,74,53,.055)!important;background:#fff!important;min-height:130px}
.rent-setup-refined .row.g-3.mb-3 .col-md-4:nth-child(1) .custom-card{background:linear-gradient(125deg,#ecf9f1,#fff)!important}
.rent-setup-refined .row.g-3.mb-3 .col-md-4:nth-child(2) .custom-card{background:linear-gradient(125deg,#e6f8ed,#fff)!important}
.rent-setup-refined .row.g-3.mb-3 .col-md-4:nth-child(3) .custom-card{background:linear-gradient(125deg,#f2fae8,#fff)!important}
.rent-setup-refined .rent-stat-heading{display:flex;align-items:center;gap:12px}
.rent-setup-refined .rent-stat-icon{display:inline-flex;align-items:center;justify-content:center;flex:0 0 42px;height:42px;border-radius:12px;background:#d9f5e5;color:#087f5b;font-size:22px}
.rent-setup-refined .col-md-4:nth-child(2) .rent-stat-icon{background:#d4f7df;color:#16803d}
.rent-setup-refined .col-md-4:nth-child(3) .rent-stat-icon{background:#eaf7d6;color:#608817}
.rent-setup-refined .row.g-3.mb-3 .custom-card h4{margin-left:54px!important;font-size:30px!important}
.rent-setup-refined > .card.custom-card{border:1px solid #e1eae5!important;border-radius:16px!important;box-shadow:0 6px 22px rgba(15,74,53,.055)!important}
.rent-setup-refined > .card.custom-card .card-header{background:#fff!important;padding:18px 20px!important;border-bottom:1px solid #e1eae5!important}
.rent-setup-refined .card-title{font-size:15px!important;color:#174d39!important}
.rent-setup-refined .rent-filter-panel{background:#f7fcf9!important;border:1px solid #e1eae5!important;border-radius:12px!important}
.rent-setup-refined #estateSetupTable thead th{background:#075b42!important}
.rent-setup-refined #estateSetupTable tbody tr:hover td{background:#eaf8f0!important}
.rent-setup-refined .btn-primary,.rent-setup-refined .btn-success{background:#087f5b!important;border-color:#087f5b!important}
.rent-setup-refined .btn-primary:hover,.rent-setup-refined .btn-success:hover{background:#066a4c!important}
#estateSetupModal .modal-header{background:linear-gradient(110deg,#075b42,#0b9569)!important}
@media(max-width:767px){.rent-setup-refined .page-header-breadcrumb{padding:20px!important}.rent-setup-refined .page-title{font-size:21px!important}.rent-setup-refined .row.g-3.mb-3 .custom-card h4{margin-left:0!important}}
/* Unified header styling: the table header and edit-modal header use the same emerald gradient. */
.rent-setup-refined #estateSetupTable thead th,
.rent-setup-refined #estateSetupTable thead.table-light th {
  background:linear-gradient(110deg,#075b42,#0b9569)!important;
  background-color:#075b42!important;
  color:#fff!important;
  border-color:transparent!important;
  font-weight:800!important;
  letter-spacing:.02em;
  vertical-align:middle;
}
#estateSetupModal .modal-header {
  background:linear-gradient(110deg,#075b42,#0b9569)!important;
  color:#fff!important;
  border-bottom:0!important;
}
#estateSetupModal .modal-header .modal-title {color:#fff!important;font-size:16px;font-weight:800!important}
#estateSetupModal .modal-header .btn-close {filter:brightness(0) invert(1)!important;opacity:1}
</style>

<%-- Controller must supply estate_list, estate_list_json and total_estates before rendering. --%>
<div class="main-content app-content">
  <div class="container-fluid page-container rent-setup-refined">
    <div class="page-header-breadcrumb mb-3">
      <div class="d-flex align-items-center justify-content-between flex-wrap">
        <div><div class="rent-kicker"><i class="ri-government-line me-1"></i> ELIS / LAND ADMINISTRATION</div><h1 class="page-title fw-medium fs-18 mb-1"><i class="ri-settings-3-line me-2"></i>Rent Management Setup</h1><p class="rent-hero-caption mb-0">Configure government estate rates, interest and parcel availability.</p></div>
        <ol class="breadcrumb mb-0"><li class="breadcrumb-item">ELIS</li><li class="breadcrumb-item active">Rent Management Setup</li></ol>
      </div>
    </div>

    <div class="row g-3 mb-3">
      <div class="col-md-4"><div class="card custom-card"><div class="card-body"><div class="rent-stat-heading"><span class="rent-stat-icon"><i class="ri-community-line"></i></span><span class="text-muted">Total Government Estates</span></div><h4 id="statEstates"><c:out value="${total_estates}" default="0" /></h4></div></div></div>
      <div class="col-md-4"><div class="card custom-card"><div class="card-body"><div class="rent-stat-heading"><span class="rent-stat-icon"><i class="ri-map-pin-range-line"></i></span><span class="text-muted">Estates With Parcels</span></div><h4 id="statWithParcels">0</h4></div></div></div>
      <div class="col-md-4"><div class="card custom-card"><div class="card-body"><div class="rent-stat-heading"><span class="rent-stat-icon"><i class="ri-money-dollar-circle-line"></i></span><span class="text-muted">Estates With Rates Configured</span></div><h4 id="statConfigured">0</h4></div></div></div>
    </div>

    <div class="card custom-card">
      <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
        <div class="card-title"><i class="ri-building-2-line me-2"></i>Government Estates <span class="d-block small fw-normal mt-1" style="color:#507363">Manage estate rates and interest settings</span></div>
        <button class="btn btn-primary btn-sm" id="refreshEstates" type="button"><i class="ri-refresh-line me-1"></i>Reload Estates</button>
      </div>
      <div class="card-body">
        <div id="setupAlert" role="alert" class="alert d-none"></div>
        <div class="rent-filter-panel">
          <div class="rent-filter-title"><i class="ri-filter-3-line me-1"></i> Find and filter estates</div>
          <div class="row g-3 align-items-end">
            <div class="col-lg-5 col-md-6"><label class="form-label" for="estateSearch">Estate Name or ID</label><input class="form-control" id="estateSearch" placeholder="Enter estate name or ID" autocomplete="off"></div>
            <div class="col-lg-3 col-md-6"><label class="form-label" for="regionFilter">Region</label><select id="regionFilter" class="form-select"><option value="">All Regions</option></select></div>
            <div class="col-lg-2 col-6"><button class="btn btn-success w-100" id="searchEstates" type="button"><i class="ri-search-line me-1"></i>Search</button></div>
            <div class="col-lg-2 col-6"><button class="btn btn-light w-100" id="clearFilters" type="button"><i class="ri-close-circle-line me-1"></i>Clear</button></div>
          </div>
        </div>
        <div class="d-flex justify-content-between align-items-center mb-2"><small class="text-muted" id="resultCount"></small></div>
        <div class="table-responsive">
          <table class="table table-hover align-middle" id="estateSetupTable">
            <thead><tr>
              <th>Estate ID</th><th>Estate / Location</th><th>Region ID</th><th class="text-end">Subsidised Rate (GHS)</th>
              <th class="text-end">Economic Rate (GHS)</th><th class="text-end">Interest Rate (%)</th><th>Has Parcels</th><th>Last Updated</th><th>Action</th>
            </tr></thead>
            <tbody id="estateRows">
              <%-- Server-rendered records are visible immediately, without AJAX. --%>
              <c:forEach var="estate" items="${estate_list}">
                <tr class="estate-row" data-estate-id="${estate.ge_id}" data-region="<c:out value="${estate.ge_region_id}" />" data-name="<c:out value="${estate.ge_location_name}" />" data-subsidised="<c:out value="${estate.subsidised_rate}" />" data-economic="<c:out value="${estate.economic_rate}" />" data-interest="<c:out value="${estate.ge_interest_rate}" />" data-parcels="<c:out value="${estate.ge_has_parcels}" />">
                  <td><c:out value="${estate.ge_id}" /></td>
                  <td><c:out value="${estate.ge_location_name}" /></td>
                  <td><c:out value="${estate.ge_region_id}" default="—" /></td>
                  <td class="text-end"><c:choose><c:when test="${not empty estate.subsidised_rate}"><fmt:formatNumber value="${estate.subsidised_rate}" minFractionDigits="2" maxFractionDigits="2" /></c:when><c:otherwise>—</c:otherwise></c:choose></td>
                  <td class="text-end"><c:choose><c:when test="${not empty estate.economic_rate}"><fmt:formatNumber value="${estate.economic_rate}" minFractionDigits="2" maxFractionDigits="2" /></c:when><c:otherwise>—</c:otherwise></c:choose></td>
                  <td class="text-end"><c:choose><c:when test="${not empty estate.ge_interest_rate}"><fmt:formatNumber value="${estate.ge_interest_rate}" minFractionDigits="2" maxFractionDigits="2" /></c:when><c:otherwise>—</c:otherwise></c:choose></td>
                  <td><c:choose><c:when test="${estate.ge_has_parcels == 1}"><span class="badge bg-success-transparent">Yes</span></c:when><c:otherwise><span class="badge bg-secondary-transparent">No</span></c:otherwise></c:choose></td>
                  <td><c:out value="${estate.ge_updated_at}" default="—" /></td>
                  <td><button type="button" class="btn btn-sm btn-primary-light edit-estate" data-id="${estate.ge_id}">Edit Rates</button></td>
                </tr>
              </c:forEach>
              <c:if test="${empty estate_list}"><tr id="noEstateRow"><td colspan="9" class="text-center py-4">No government estates were returned.</td></tr></c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="estateSetupModal" tabindex="-1" aria-labelledby="estateSetupModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg"><div class="modal-content">
    <form id="estateSetupForm">
      <div class="modal-header"><h5 class="modal-title" id="estateSetupModalTitle">Configure Estate Ground Rent Rates</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body">
        <input type="hidden" id="editEstateId">
        <div class="mb-3"><label class="form-label" for="editEstateName">Government Estate</label><input id="editEstateName" class="form-control" readonly></div>
        <div class="row g-3">
          <div class="col-md-6"><label class="form-label" for="editSubsidisedRate">Subsidised Rate (GHS)</label><input type="number" min="0" step="0.01" class="form-control" id="editSubsidisedRate"></div>
          <div class="col-md-6"><label class="form-label" for="editEconomicRate">Economic Rate (GHS)</label><input type="number" min="0" step="0.01" class="form-control" id="editEconomicRate"></div>
          <div class="col-md-6"><label class="form-label" for="editInterestRate">Interest Rate (%)</label><input type="number" min="0" step="0.01" class="form-control" id="editInterestRate"></div>
          <div class="col-md-6"><label class="form-label" for="editHasParcels">Estate Has Parcels</label><select id="editHasParcels" class="form-select"><option value="1">Yes</option><option value="0">No</option></select></div>
        </div>
        <p class="small text-muted mt-3 mb-0">These settings apply to estate configuration. The servlet must derive the updating user ID from the authenticated session.</p>
      </div>
      <div class="modal-footer"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button><button type="submit" id="saveEstateBtn" class="btn btn-primary">Save Changes</button></div>
    </form>
  </div></div>
</div>

<script>
(function () {
  'use strict';
  // Supply the real existing servlet mapping as the controller attribute rentSetupServletUrl.
  // Otherwise this uses the prior example mapping; change it if your ELIS servlet differs.
  const servletUrl = '<c:url value="/RentManagementServlet" />';
  const configuredServletUrl = '<c:out value="${rentSetupServletUrl}" />';
  const SERVLET_URL = configuredServletUrl || servletUrl;
  const $id = id => document.getElementById(id);
  const alertBox = $id('setupAlert');
  const csrf = document.querySelector('meta[name="_csrf"]');
  const csrfHeader = document.querySelector('meta[name="_csrf_header"]');
  // Read server-rendered records; no browser-side API call or JSON injection.
  const estates = Array.from(document.querySelectorAll('#estateRows tr.estate-row')).map(row => ({
    ge_id: row.dataset.estateId,
    ge_region_id: row.dataset.region,
    ge_location_name: row.dataset.name,
    subsidised_rate: row.dataset.subsidised === '' ? null : row.dataset.subsidised,
    economic_rate: row.dataset.economic === '' ? null : row.dataset.economic,
    ge_interest_rate: row.dataset.interest === '' ? null : row.dataset.interest,
    ge_has_parcels: row.dataset.parcels
  }));
  const estateById = new Map(estates.map(e => [String(e.ge_id), e]));
  const format = v => v == null || v === '' ? '—' : Number(v).toLocaleString('en-GH', {minimumFractionDigits:2, maximumFractionDigits:2});
  function showAlert(message, type) {
    alertBox.textContent = message;
    alertBox.className = 'alert alert-' + type;
  }
  function initializeStats() {
    $id('statEstates').textContent = estates.length;
    $id('statWithParcels').textContent = estates.filter(e => Number(e.ge_has_parcels) === 1).length;
    $id('statConfigured').textContent = estates.filter(e => e.subsidised_rate != null || e.economic_rate != null).length;
  }
  function initializeRegions() {
    const regions = [...new Set(estates.map(e => e.ge_region_id).filter(v => v != null && v !== ''))].sort((a,b) => Number(a)-Number(b));
    regions.forEach(region => {
      const option = document.createElement('option');
      option.value = String(region);
      option.textContent = 'Region ' + region;
      $id('regionFilter').appendChild(option);
    });
  }
  function filterEstates() {
    const search = $id('estateSearch').value.trim().toLowerCase();
    const region = $id('regionFilter').value;
    let visible = 0;
    document.querySelectorAll('#estateRows tr.estate-row').forEach(row => {
      const estate = estateById.get(row.dataset.estateId);
      const matches = estate && (!region || String(estate.ge_region_id) === region)
        && (!search || String(estate.ge_location_name || '').toLowerCase().includes(search) || String(estate.ge_id).includes(search));
      row.hidden = !matches;
      if (matches) visible++;
    });
    $id('resultCount').textContent = 'Showing ' + visible + ' of ' + estates.length + ' estates';
    let empty = $id('filterEmptyRow');
    if (!visible && estates.length) {
      if (!empty) {
        empty = document.createElement('tr'); empty.id = 'filterEmptyRow';
        const td = document.createElement('td'); td.colSpan = 9; td.className = 'text-center py-4';
        td.textContent = 'No estates match your search.'; empty.appendChild(td); $id('estateRows').appendChild(empty);
      }
      empty.hidden = false;
    } else if (empty) empty.hidden = true;
  }
  function editEstate(id) {
    const estate = estateById.get(String(id));
    if (!estate) return showAlert('Estate record not found in preloaded data.', 'danger');
    $id('editEstateId').value = estate.ge_id;
    $id('editEstateName').value = estate.ge_location_name || '';
    $id('editSubsidisedRate').value = estate.subsidised_rate ?? '';
    $id('editEconomicRate').value = estate.economic_rate ?? '';
    $id('editInterestRate').value = estate.ge_interest_rate ?? '';
    $id('editHasParcels').value = Number(estate.ge_has_parcels) === 1 ? '1' : '0';
    bootstrap.Modal.getOrCreateInstance($id('estateSetupModal')).show();
  }
  async function saveEstate(event) {
    event.preventDefault();
    if (!$id('estateSetupForm').reportValidity()) return;
    const button = $id('saveEstateBtn'); button.disabled = true;
    const numberOrEmpty = id => $id(id).value.trim();
    const payload = new URLSearchParams();
    payload.set('request_type', 'saveGovernmentEstate');
    payload.set('ge_id', $id('editEstateId').value);
    payload.set('subsidised_rate', numberOrEmpty('editSubsidisedRate'));
    payload.set('economic_rate', numberOrEmpty('editEconomicRate'));
    payload.set('interest_rate', numberOrEmpty('editInterestRate'));
    payload.set('has_parcels', $id('editHasParcels').value);
    const headers = {'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8', 'Accept':'application/json'};
    if (csrf && csrfHeader) headers[csrfHeader.content] = csrf.content;
    try {
      const response = await fetch(SERVLET_URL, {method:'POST', credentials:'same-origin', headers, body:payload.toString()});
      const raw = await response.text();
      let result;
      try { result = JSON.parse(raw); if (typeof result === 'string') result = JSON.parse(result); }
      catch (error) { throw new Error('The servlet returned an invalid JSON response.'); }
      if (!response.ok || !result.success) throw new Error(result.msg || 'Unable to save estate configuration.');
      bootstrap.Modal.getOrCreateInstance($id('estateSetupModal')).hide();
      // Reload GET /rent_management_setup to fetch the updated complete estate list server-side.
      window.location.reload();
    } catch (error) { showAlert(error.message, 'danger'); }
    finally { button.disabled = false; }
  }
  $id('estateRows').addEventListener('click', event => {
    const button = event.target.closest('button.edit-estate');
    if (button) editEstate(button.dataset.id);
  });
  $id('searchEstates').addEventListener('click', filterEstates);
  $id('estateSearch').addEventListener('input', filterEstates);
  $id('regionFilter').addEventListener('change', filterEstates);
  $id('clearFilters').addEventListener('click', () => { $id('estateSearch').value = ''; $id('regionFilter').value = ''; filterEstates(); });
  $id('refreshEstates').addEventListener('click', () => window.location.reload());
  $id('estateSetupForm').addEventListener('submit', saveEstate);
  initializeStats(); initializeRegions(); filterEstates();
})();
</script>
