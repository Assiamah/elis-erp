<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
/* ELIS Bulk Demand Notices: scoped styling */
.bulk-demand{--bd-dark:#064b39;--bd-green:#087f5b;--bd-light:#e8f7ee;--bd-border:#d8e9df;--bd-text:#173b2e;color:var(--bd-text)}
.bulk-demand .bd-hero{background:linear-gradient(115deg,#064b39,#0a8b61 72%,#31a477);color:white;border-radius:17px;padding:24px 28px;box-shadow:0 10px 30px #064b3926}
.bulk-demand .bd-hero h1{color:white;font-size:24px;font-weight:800;margin:5px 0}.bulk-demand .bd-hero p{color:#d8f8e7;margin:0;font-size:13px}
.bulk-demand .bd-eyebrow{font-size:11px;font-weight:800;letter-spacing:1.3px;color:#bdf2d4}.bulk-demand .breadcrumb-item,.bulk-demand .breadcrumb-item a{color:#e6fff0!important}.bulk-demand .breadcrumb-item+.breadcrumb-item::before{color:#bdf2d4}
.bulk-demand .bd-card{background:#fff;border:1px solid var(--bd-border);border-radius:15px;box-shadow:0 5px 20px #064b3910;overflow:hidden}
.bulk-demand .bd-card-head{padding:17px 20px;border-bottom:1px solid var(--bd-border);display:flex;justify-content:space-between;align-items:center;gap:10px;flex-wrap:wrap}.bulk-demand .bd-card-title{font-size:15px;font-weight:800;color:var(--bd-dark);margin:0}.bulk-demand .bd-desc{font-size:12px;color:#71877a;margin:4px 0 0}.bulk-demand .bd-card-body{padding:20px}
.bulk-demand .bd-metric{display:flex;align-items:center;gap:13px;padding:18px;border-left:4px solid var(--bd-green)}.bulk-demand .bd-icon{width:44px;height:44px;display:grid;place-items:center;background:var(--bd-light);border-radius:12px;color:var(--bd-green);font-size:22px;flex:none}.bulk-demand .bd-metric label{display:block;font-size:12px;color:#6b8475;font-weight:700}.bulk-demand .bd-metric strong{display:block;color:var(--bd-dark);font-size:23px;font-weight:800;line-height:1.3;margin-top:3px}.bulk-demand .bd-metric.amber{border-left-color:#d7a03d}.bulk-demand .bd-metric.amber .bd-icon{background:#fff5e0;color:#b77d16}
.bulk-demand .form-label{font-size:12px;font-weight:750;color:#365d49}.bulk-demand .form-control,.bulk-demand .form-select{min-height:42px;border:1px solid #cfe4d7;border-radius:9px;font-size:13px}.bulk-demand .form-control:focus,.bulk-demand .form-select:focus{border-color:#0b9469;box-shadow:0 0 0 .2rem #0b94691c}.bulk-demand .bd-filter{background:#f3fbf6;border:1px solid #d8ebde;border-radius:12px;padding:17px}
.bulk-demand .bd-btn{border-radius:9px;padding:10px 14px;font-size:12px;font-weight:750;border:1px solid transparent;display:inline-flex;gap:7px;align-items:center;justify-content:center;white-space:nowrap}.bulk-demand .bd-btn-primary{background:linear-gradient(110deg,#087f5b,#0ba26f);color:white}.bulk-demand .bd-btn-primary:hover{background:#065c44;color:white}.bulk-demand .bd-btn-soft{background:#e5f7ed;color:#07543f;border-color:#bce2ca}.bulk-demand .bd-btn-soft:hover{background:#d3efde;color:#07543f}.bulk-demand .bd-btn-outline{background:white;border-color:#bcd9c8;color:#07543f}.bulk-demand .bd-btn-outline:hover{background:#f2faf5}.bulk-demand .bd-btn:disabled{opacity:.55;cursor:not-allowed}
.bulk-demand .bd-table-wrap{overflow:auto;max-height:430px}.bulk-demand #tbl_bulk_demand{width:100%;font-size:12px;white-space:nowrap}.bulk-demand #tbl_bulk_demand thead th{position:sticky;top:0;z-index:1;background:linear-gradient(110deg,#07543f,#0b9064);color:white;border:0;padding:13px 11px;font-weight:750}.bulk-demand #tbl_bulk_demand tbody td{padding:11px;border-bottom:1px solid #e5efe8;vertical-align:middle}.bulk-demand #tbl_bulk_demand tbody tr:nth-child(even){background:#f7fcf9}.bulk-demand #tbl_bulk_demand tbody tr:hover{background:#eaf7ef}.bulk-demand #tbl_bulk_demand .form-check-input{cursor:pointer;border-color:#84b69a}.bulk-demand #tbl_bulk_demand .form-check-input:checked{background-color:#087f5b;border-color:#087f5b}
.bulk-demand .bd-tag{display:inline-flex;align-items:center;gap:5px;padding:5px 9px;background:#e8f7ed;color:#087f5b;border-radius:50px;font-size:11px;font-weight:750}.bulk-demand .bd-tag.overdue{background:#fff2e3;color:#a86d13}.bulk-demand .bd-footnote{font-size:12px;color:#738a7c}.bulk-demand .bd-action-bar{background:#f4fbf6;border-top:1px solid #d8e9df;padding:16px 20px;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}.bulk-demand .bd-check{accent-color:#087f5b}.bulk-demand .bd-status{font-size:12px;min-height:20px}.bulk-demand .bd-empty{padding:45px 15px;text-align:center;color:#779083}.bulk-demand .bd-empty i{font-size:38px;display:block;margin-bottom:8px;color:#91b9a2}
#bulkDemandPreviewModal .modal-content{border:0;border-radius:15px;overflow:hidden}#bulkDemandPreviewModal .modal-header{background:linear-gradient(110deg,#064b39,#0b9469);color:white}#bulkDemandPreviewModal .modal-title{color:white;font-weight:800}#bulkDemandPreviewModal .btn-close{filter:invert(1) grayscale(1)}
@media(max-width:767px){.bulk-demand .bd-hero{padding:18px}.bulk-demand .bd-hero h1{font-size:20px}.bulk-demand .bd-card-body{padding:13px}.bulk-demand .bd-metric{padding:13px}}
</style>

<div class="main-content app-content bulk-demand">
 <div class="container-fluid page-container">
  <div class="bd-hero mb-4">
   <div class="d-flex align-items-center justify-content-between gap-3 flex-wrap">
    <div><div class="bd-eyebrow"><i class="ri-government-line me-1"></i> ELIS / GROUND RENT</div>
     <h1><i class="ri-file-paper-2-line me-2"></i>Bulk Demand Notice Generation</h1>
     <p>Find rent accounts, select eligible lessees and prepare demand notices in one batch.</p>
    </div>
    <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="javascript:void(0)">ELIS</a></li><li class="breadcrumb-item active">Bulk Demand Notices</li></ol>
   </div>
  </div>

  <div class="row g-3 mb-4">
   <div class="col-xl-3 col-sm-6"><div class="bd-card h-100"><div class="bd-metric"><div class="bd-icon"><i class="ri-file-list-3-line"></i></div><div><label>Accounts Loaded</label><strong id="bdTotalRecords">0</strong></div></div></div></div>
   <div class="col-xl-3 col-sm-6"><div class="bd-card h-100"><div class="bd-metric"><div class="bd-icon"><i class="ri-checkbox-circle-line"></i></div><div><label>Accounts Selected</label><strong id="bdSelectedRecords">0</strong></div></div></div></div>
   <div class="col-xl-3 col-sm-6"><div class="bd-card h-100"><div class="bd-metric amber"><div class="bd-icon"><i class="ri-money-dollar-circle-line"></i></div><div><label>Selected Outstanding</label><strong id="bdSelectedAmount">GHS 0.00</strong></div></div></div></div>
   <div class="col-xl-3 col-sm-6"><div class="bd-card h-100"><div class="bd-metric"><div class="bd-icon"><i class="ri-printer-line"></i></div><div><label>Batch Status</label><strong id="bdBatchStatus" style="font-size:17px">Not started</strong></div></div></div></div>
  </div>

  <div class="bd-card mb-3">
   <div class="bd-card-head"><div><h2 class="bd-card-title"><i class="ri-filter-3-line me-2"></i>Step 1 — Identify Rent Accounts</h2><p class="bd-desc">Filter the accounts to be considered for demand notices.</p></div><span class="bd-tag"><i class="ri-search-line"></i> Account selection</span></div>
   <div class="bd-card-body"><div class="bd-filter"><div class="row g-3 align-items-end">
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdEstate">Estate</label><select id="bdEstate" class="form-select"><option value="">All Estates</option><c:forEach items="${estate_list}" var="estate"><option value="<c:out value='${estate.ge_id}'/>"><c:out value="${estate.ge_location_name}"/></option></c:forEach></select></div>
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdSearchType">Search By</label><select id="bdSearchType" class="form-select"><option value="">All Accounts</option><option value="account_number">Account Number</option><option value="plot_number">Plot Number</option><option value="lessee_name">Name of Lessee</option><option value="file_number">File Number</option></select></div>
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdKeyword">Search Keyword</label><input id="bdKeyword" type="text" class="form-control" placeholder="Account, plot, lessee or file..."></div>
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdMinOutstanding">Minimum Outstanding (GHS)</label><input id="bdMinOutstanding" type="number" min="0" step="0.01" class="form-control" placeholder="0.00"></div>
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdRentYear">Demand Year</label><input id="bdRentYear" type="number" min="2000" max="2100" class="form-control" value="<c:out value='${demand_year}'/>" placeholder="e.g. 2026"></div>
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdNoticeDate">Notice Date</label><input id="bdNoticeDate" type="date" class="form-control"></div>
    <div class="col-xl-3 col-md-6"><label class="form-label" for="bdDueDate">Payment Due Date</label><input id="bdDueDate" type="date" class="form-control"></div>
    <div class="col-xl-3 col-md-6 d-flex gap-2"><button type="button" class="bd-btn bd-btn-primary flex-fill" id="bdSearchButton"><i class="ri-search-line"></i> Load Accounts</button><button type="button" class="bd-btn bd-btn-outline" id="bdResetButton" title="Reset filters"><i class="ri-refresh-line"></i></button></div>
   </div></div></div>
  </div>

  <div class="bd-card mb-3">
   <div class="bd-card-head"><div><h2 class="bd-card-title"><i class="ri-list-check-2 me-2"></i>Step 2 — Select Accounts for Demand Notices</h2><p class="bd-desc">Only checked accounts will be included in the batch.</p></div><div class="d-flex gap-2 flex-wrap"><button type="button" class="bd-btn bd-btn-soft" id="bdSelectAll"><i class="ri-checkbox-multiple-line"></i> Select All Loaded</button><button type="button" class="bd-btn bd-btn-outline" id="bdClearSelection"><i class="ri-checkbox-blank-line"></i> Clear Selection</button></div></div>
   <div class="bd-table-wrap"><table class="table table-hover mb-0" id="tbl_bulk_demand"><thead><tr><th><input type="checkbox" class="form-check-input" id="bdHeaderCheck" aria-label="Select all loaded accounts"></th><th>Account Number</th><th>Plot Number</th><th>Lessee / Assignee</th><th>Estate</th><th>File Number</th><th>Last Payment Period</th><th>Rent Outstanding (GHS)</th><th>Status</th></tr></thead><tbody id="bdTableBody"><tr><td colspan="9"><div class="bd-empty"><i class="ri-file-search-line"></i>Use the filters above and click <strong>Load Accounts</strong> to retrieve rent records.</div></td></tr></tbody></table></div>
   <div class="bd-action-bar"><div><strong id="bdSelectionSummary">0 accounts selected</strong><div class="bd-footnote">Review records and outstanding balances before generating notices.</div></div><div class="d-flex gap-2 flex-wrap"><button type="button" class="bd-btn bd-btn-outline" id="bdPreviewButton" disabled><i class="ri-eye-line"></i> Preview Batch</button><button type="button" class="bd-btn bd-btn-primary" id="bdGenerateButton" disabled><i class="ri-file-pdf-2-line"></i> Generate Demand Notices</button></div></div>
  </div>
  <div class="bd-card mb-4"><div class="bd-card-head"><div><h2 class="bd-card-title"><i class="ri-information-line me-2"></i>Generation Guidance</h2></div></div><div class="bd-card-body"><div class="row g-3"><div class="col-md-4"><span class="bd-tag">01 · Filter</span><p class="bd-footnote mt-2 mb-0">Load eligible accounts from the rent ledger using estate, keyword and outstanding balance.</p></div><div class="col-md-4"><span class="bd-tag">02 · Review</span><p class="bd-footnote mt-2 mb-0">Select the required lessees and confirm the notice date, year and payment due date.</p></div><div class="col-md-4"><span class="bd-tag">03 · Generate</span><p class="bd-footnote mt-2 mb-0">Submit the selected account IDs to the demand notice service for PDF generation.</p></div></div><div class="bd-status mt-3" id="bdMessage" role="status" aria-live="polite"></div></div></div>
 </div>
</div>

<div class="modal fade" id="bulkDemandPreviewModal" tabindex="-1" aria-labelledby="bdPreviewTitle" aria-hidden="true"><div class="modal-dialog modal-lg modal-dialog-centered"><div class="modal-content"><div class="modal-header"><h5 class="modal-title" id="bdPreviewTitle"><i class="ri-file-list-3-line me-2"></i>Demand Notice Batch Preview</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div><div class="modal-body" id="bdPreviewContent"></div><div class="modal-footer"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button><button type="button" class="btn btn-success" id="bdPreviewGenerate"><i class="ri-file-pdf-2-line me-1"></i> Generate Batch</button></div></div></div></div>

<script>
(function () {
 'use strict';
 /* Replace these two URLs with your implemented ELIS controller endpoints.
    Search response: JSON array or {data:[...]}, each record containing a stable account ID.
    Generate request: POST JSON {account_ids:[...],demand_year,notice_date,due_date}.
    Generate response: JSON {success:true,download_url:"..."} or PDF blob. */
 const SEARCH_URL = '${pageContext.request.contextPath}/rent/bulk-demand/accounts';
 const GENERATE_URL = '${pageContext.request.contextPath}/rent/bulk-demand/generate';
 const $id = id => document.getElementById(id);
 let rows = [], selected = new Set(), busy = false;
 const currency = n => 'GHS ' + Number(n || 0).toLocaleString('en-GH', {minimumFractionDigits:2,maximumFractionDigits:2});
 const html = value => String(value == null ? '' : value).replace(/[&<>"']/g, ch => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[ch]));
 const valueOf = (row, keys) => { for (const key of keys) if (row[key] !== undefined && row[key] !== null) return row[key]; return ''; };
 const getId = r => String(valueOf(r,['account_id','rent_account_id','id','rt_r_id','account_number']));
 const getAmount = r => Number(String(valueOf(r,['rent_outstanding','outstanding_amount','outstanding_balance','balance']) || 0).replace(/,/g,'')) || 0;
 const message = (txt, bad) => { const el=$id('bdMessage');el.textContent=txt;el.style.color=bad?'#b42318':'#087f5b'; };
 const payload = () => ({account_ids:Array.from(selected),demand_year:Number($id('bdRentYear').value),notice_date:$id('bdNoticeDate').value,due_date:$id('bdDueDate').value});
 function updateTotals() {
  const picked = rows.filter(r => selected.has(getId(r)));
  $id('bdTotalRecords').textContent=rows.length.toLocaleString();$id('bdSelectedRecords').textContent=picked.length.toLocaleString();
  $id('bdSelectedAmount').textContent=currency(picked.reduce((s,r)=>s+getAmount(r),0));
  $id('bdSelectionSummary').textContent=picked.length+' account'+(picked.length===1?'':'s')+' selected';
  $id('bdPreviewButton').disabled=!picked.length;$id('bdGenerateButton').disabled=!picked.length||busy;
  const all=rows.length>0 && rows.every(r=>selected.has(getId(r)));
  $id('bdHeaderCheck').checked=all;$id('bdHeaderCheck').indeterminate=!all&&rows.some(r=>selected.has(getId(r)));
 }
 function render() {
  const body=$id('bdTableBody');body.innerHTML='';
  if(!rows.length){body.innerHTML='<tr><td colspan="9"><div class="bd-empty"><i class="ri-inbox-line"></i>No matching rent accounts found.</div></td></tr>';updateTotals();return;}
  rows.forEach(r=>{
   const id=getId(r); const tr=document.createElement('tr');
   const cols=[valueOf(r,['account_number','account_no']),valueOf(r,['plot_number','plot_no']),valueOf(r,['lessee_name','leasee_name','name_of_lessee','name']),valueOf(r,['estate_name','estate']),valueOf(r,['file_number','file_no']),valueOf(r,['last_payment_period','last_paid_period'])];
   const td=document.createElement('td');const check=document.createElement('input');check.type='checkbox';check.className='form-check-input bd-row-check';check.checked=selected.has(id);check.setAttribute('aria-label','Select account '+id);check.addEventListener('change',()=>{check.checked?selected.add(id):selected.delete(id);updateTotals();});td.appendChild(check);tr.appendChild(td);
   cols.forEach(c=>{const cell=document.createElement('td');cell.textContent=String(c);tr.appendChild(cell);});
   const amount=document.createElement('td');amount.className='fw-semibold';amount.textContent=currency(getAmount(r));tr.appendChild(amount);
   const status=document.createElement('td');const badge=document.createElement('span');badge.className='bd-tag overdue';badge.textContent=String(valueOf(r,['status','rent_status'])||'Outstanding');status.appendChild(badge);tr.appendChild(status);body.appendChild(tr);
  });updateTotals();
 }
 async function loadAccounts(){
  if(busy)return;busy=true;$id('bdSearchButton').disabled=true;message('Loading rent accounts...');
  const q=new URLSearchParams({estate_id:$id('bdEstate').value,search_type:$id('bdSearchType').value,keyword:$id('bdKeyword').value,min_outstanding:$id('bdMinOutstanding').value,demand_year:$id('bdRentYear').value});
  try {const response=await fetch(SEARCH_URL+'?'+q.toString(),{credentials:'same-origin',headers:{'Accept':'application/json'}});if(!response.ok)throw new Error('Account lookup failed (HTTP '+response.status+'). Check the search endpoint.');
   const json=await response.json();const data=Array.isArray(json)?json:(Array.isArray(json.data)?json.data:Array.isArray(json.records)?json.records:null);if(!data)throw new Error('The search endpoint did not return an account array.');
   rows=data.filter(r=>getId(r));selected.clear();render();message(rows.length+' account(s) loaded. Select the accounts to include.');$id('bdBatchStatus').textContent='Ready';
  } catch(err){rows=[];selected.clear();render();message(err.message,true);$id('bdBatchStatus').textContent='Lookup failed';}
  finally{busy=false;$id('bdSearchButton').disabled=false;updateTotals();}
 }
 function validate(){if(!selected.size){message('Select at least one account.',true);return false;}if(!$id('bdRentYear').value||!$id('bdNoticeDate').value||!$id('bdDueDate').value){message('Demand year, notice date and payment due date are required.',true);return false;}if($id('bdDueDate').value<$id('bdNoticeDate').value){message('Payment due date cannot be before the notice date.',true);return false;}return true;}
 function preview(){if(!validate())return;const p=payload(),picked=rows.filter(r=>selected.has(getId(r)));$id('bdPreviewContent').innerHTML='<div class="row g-3 mb-3"><div class="col-sm-6"><strong>Demand Year:</strong> '+html(p.demand_year)+'</div><div class="col-sm-6"><strong>Selected Accounts:</strong> '+p.account_ids.length+'</div><div class="col-sm-6"><strong>Notice Date:</strong> '+html(p.notice_date)+'</div><div class="col-sm-6"><strong>Payment Due:</strong> '+html(p.due_date)+'</div></div><div class="alert alert-success"><strong>Total Outstanding:</strong> '+html(currency(picked.reduce((s,r)=>s+getAmount(r),0)))+'</div><p class="small text-muted mb-0">Generate will submit the selected account IDs to the configured server endpoint. Confirm balances against the authoritative rent ledger.</p>';
  if(window.bootstrap&&bootstrap.Modal)bootstrap.Modal.getOrCreateInstance($id('bulkDemandPreviewModal')).show();else message('Preview is ready, but Bootstrap modal JavaScript is not loaded.',true);
 }
 async function generate(){if(busy||!validate())return;if(!window.confirm('Generate demand notices for '+selected.size+' selected account(s)?'))return;
  busy=true;$id('bdGenerateButton').disabled=true;$id('bdPreviewGenerate').disabled=true;$id('bdBatchStatus').textContent='Generating...';message('Submitting demand notice batch...');
  try {const headers={'Content-Type':'application/json','Accept':'application/json, application/pdf'};
   const csrf=document.querySelector('meta[name="_csrf"]');const csrfHeader=document.querySelector('meta[name="_csrf_header"]');if(csrf&&csrfHeader)headers[csrfHeader.content]=csrf.content;
   const response=await fetch(GENERATE_URL,{method:'POST',credentials:'same-origin',headers,body:JSON.stringify(payload())});if(!response.ok)throw new Error('Generation failed (HTTP '+response.status+').');
   const type=response.headers.get('content-type')||'';
   if(type.includes('application/pdf')){const blob=await response.blob();const url=URL.createObjectURL(blob);const a=document.createElement('a');a.href=url;a.download='ELIS_Bulk_Demand_Notices.pdf';document.body.appendChild(a);a.click();a.remove();setTimeout(()=>URL.revokeObjectURL(url),60000);}
   else {const json=await response.json();if(json.success===false)throw new Error(json.msg||json.message||'Generation was not successful.');if(json.download_url){const a=document.createElement('a');a.href=json.download_url;a.target='_blank';a.rel='noopener';document.body.appendChild(a);a.click();a.remove();}else if(!json.success)throw new Error('No download link or success status returned by the server.');}
   $id('bdBatchStatus').textContent='Generated';message('Demand notice batch generated successfully.');
   if(window.bootstrap&&bootstrap.Modal){const modal=bootstrap.Modal.getInstance($id('bulkDemandPreviewModal'));if(modal)modal.hide();}
  }catch(err){$id('bdBatchStatus').textContent='Failed';message(err.message,true);}finally{busy=false;$id('bdPreviewGenerate').disabled=false;updateTotals();}
 }
 $id('bdSearchButton').addEventListener('click',loadAccounts);$id('bdResetButton').addEventListener('click',()=>{$id('bdEstate').value='';$id('bdSearchType').value='';$id('bdKeyword').value='';$id('bdMinOutstanding').value='';rows=[];selected.clear();render();message('Filters cleared.');});
 $id('bdSelectAll').addEventListener('click',()=>{rows.forEach(r=>selected.add(getId(r)));render();});$id('bdClearSelection').addEventListener('click',()=>{selected.clear();render();});$id('bdHeaderCheck').addEventListener('change',e=>{selected.clear();if(e.target.checked)rows.forEach(r=>selected.add(getId(r)));render();});
 $id('bdPreviewButton').addEventListener('click',preview);$id('bdGenerateButton').addEventListener('click',generate);$id('bdPreviewGenerate').addEventListener('click',generate);
 if(!$id('bdRentYear').value)$id('bdRentYear').value=new Date().getFullYear();if(!$id('bdNoticeDate').value)$id('bdNoticeDate').value=new Date().toLocaleDateString('en-CA');updateTotals();
})();
</script>
