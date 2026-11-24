<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<style>
.elis-transaction-approval{--el-green:#097e69;--el-dark:#065747;--el-light:#e8f6f0;--el-border:#d8eae3;color:#18352e}
.elis-transaction-approval .el-hero{background:linear-gradient(115deg,#075b4c 0%,#09876f 55%,#26a88b 100%);color:#fff;border-radius:16px;padding:24px 28px;box-shadow:0 12px 28px rgba(9,126,105,.18);margin-bottom:24px}
.elis-transaction-approval .el-hero h1{color:#fff;font-size:1.45rem;font-weight:700;margin:0 0 5px}
.elis-transaction-approval .el-hero p{color:rgba(255,255,255,.85);margin:0}
.elis-transaction-approval .el-hero .breadcrumb{margin:0;background:transparent;padding:0}
.elis-transaction-approval .el-hero .breadcrumb-item,.elis-transaction-approval .el-hero .breadcrumb-item a{color:#fff;text-decoration:none}
.elis-transaction-approval .el-hero .breadcrumb-item+.breadcrumb-item::before{color:rgba(255,255,255,.75)}
.elis-transaction-approval .el-stat{border:1px solid var(--el-border);border-radius:14px;overflow:hidden;background:#fff;box-shadow:0 5px 20px rgba(7,80,62,.07);height:100%;transition:transform .2s,box-shadow .2s}
.elis-transaction-approval .el-stat:hover{transform:translateY(-3px);box-shadow:0 12px 24px rgba(7,80,62,.13)}
.elis-transaction-approval .el-stat .card-body{padding:22px}
.elis-transaction-approval .el-stat .el-icon{width:54px;height:54px;border-radius:15px;display:flex;align-items:center;justify-content:center;font-size:1.4rem}
.elis-transaction-approval .el-stat.total{border-top:4px solid #087f69}.elis-transaction-approval .el-stat.total .el-icon{background:#e2f4ec;color:#087f69}
.elis-transaction-approval .el-stat.pending{border-top:4px solid #d99a18}.elis-transaction-approval .el-stat.pending .el-icon{background:#fff5dd;color:#ad7608}
.elis-transaction-approval .el-stat.approved{border-top:4px solid #16a078}.elis-transaction-approval .el-stat.approved .el-icon{background:#e3f7ef;color:#087f69}
.elis-transaction-approval .el-stat.rejected{border-top:4px solid #d94c53}.elis-transaction-approval .el-stat.rejected .el-icon{background:#fdecee;color:#b72e3c}
.elis-transaction-approval .el-stat .el-label{font-size:.77rem;text-transform:uppercase;letter-spacing:.06em;color:#60766e;font-weight:700}
.elis-transaction-approval .el-stat .el-value{font-size:1.9rem;font-weight:750;color:#173b32;margin-top:6px}
.elis-transaction-approval .el-main-card{border:1px solid var(--el-border);border-radius:15px;overflow:hidden;box-shadow:0 8px 24px rgba(7,80,62,.08)}
.elis-transaction-approval .el-main-card>.card-header{background:linear-gradient(115deg,#07614f,#0a9177 65%,#2cac8e);color:#fff;border:0;padding:18px 22px}
.elis-transaction-approval .el-main-card>.card-header h5{color:#fff;font-weight:700}
.elis-transaction-approval .el-main-card .table-responsive{border:1px solid var(--el-border);border-radius:10px;overflow-x:auto}
.elis-transaction-approval #transactionDataTable{margin-bottom:0!important;width:100%!important}
.elis-transaction-approval #transactionDataTable thead th{background:#e4f3ec!important;color:#075d4d!important;font-weight:700;font-size:.8rem;text-transform:uppercase;letter-spacing:.03em;border-bottom:2px solid #b4daca;padding:13px}
.elis-transaction-approval #transactionDataTable tbody td{vertical-align:middle;padding:12px;font-size:.88rem;border-color:#edf3ef}
.elis-transaction-approval #transactionDataTable tbody tr:hover:not(.red-alert-row){background:#f0faf5!important}
.elis-transaction-approval .red-alert-row{background:#fce7e9!important;color:#842029!important}
.elis-transaction-approval .red-alert-row:hover{background:#f8d5d9!important}
.elis-transaction-approval .btn-success,.elis-transaction-approval .btn-primary{background:#09836d;border-color:#09836d;color:#fff}
.elis-transaction-approval .btn-success:hover,.elis-transaction-approval .btn-primary:hover{background:#06644f;border-color:#06644f}
.elis-transaction-approval .btn-outline-success{border-color:#09836d;color:#09836d}
.elis-transaction-approval .btn-outline-success:hover{background:#09836d;color:#fff}
.elis-transaction-approval .badge.bg-info{background:#dff3ec!important;color:#075c4a!important}
.elis-transaction-approval .badge.bg-secondary{background:#e8f0ed!important;color:#155a49!important}
.elis-transaction-approval .dataTables_wrapper .dataTables_filter input:focus,.elis-transaction-approval .dataTables_wrapper .dataTables_length select:focus{border-color:#09836d;box-shadow:0 0 0 .2rem rgba(9,131,109,.14);outline:none}
.elis-transaction-approval .dataTables_wrapper .dataTables_paginate .paginate_button.current,.elis-transaction-approval .page-item.active .page-link{background:#09836d!important;border-color:#09836d!important;color:#fff!important}
.elis-transaction-approval .page-link{color:#08755f}
.elis-transaction-approval .el-empty{color:#789187;font-size:.83rem}
@media(max-width:768px){.elis-transaction-approval .el-hero{padding:18px}.elis-transaction-approval .el-main-card>.card-header{padding:15px}.elis-transaction-approval #transactionDataTable thead th{white-space:nowrap}}

/* Enhanced layout and controls */
.elis-transaction-approval .el-hero{position:relative;overflow:hidden;min-height:125px}
.elis-transaction-approval .el-hero:after{content:"";position:absolute;right:-55px;bottom:-130px;width:300px;height:300px;border:45px solid rgba(255,255,255,.07);border-radius:50%;pointer-events:none}
.elis-transaction-approval .el-hero>*{position:relative;z-index:1}
.elis-transaction-approval .el-eyebrow{font-size:.73rem;text-transform:uppercase;letter-spacing:.12em;color:#c9f7e5;font-weight:700;margin-bottom:8px}
.elis-transaction-approval .el-stat .el-sub{font-size:.72rem;color:#69867b;margin-top:6px}
.elis-transaction-approval .el-toolbar{display:flex;gap:12px;align-items:end;flex-wrap:wrap;background:#f5fbf7;border:1px solid #d8eae3;border-radius:12px;padding:15px;margin-bottom:17px}
.elis-transaction-approval .el-toolbar .el-field{min-width:175px;flex:1}
.elis-transaction-approval .el-toolbar label{display:block;font-size:.75rem;font-weight:700;color:#376555;margin-bottom:5px}
.elis-transaction-approval .el-toolbar .form-control,.elis-transaction-approval .el-toolbar .form-select{border:1px solid #c9e2d5;border-radius:9px;background:#fff;min-height:40px}
.elis-transaction-approval .el-toolbar .form-control:focus,.elis-transaction-approval .el-toolbar .form-select:focus{border-color:#0a9177;box-shadow:0 0 0 .2rem rgba(9,131,109,.12)}
.elis-transaction-approval .el-toolbar .el-reset{min-height:40px;border:1px solid #b9d9ca;color:#075d4d;background:#fff;border-radius:9px}
.elis-transaction-approval .el-toolbar .el-reset:hover{background:#e4f3ec}
.elis-transaction-approval .el-note{display:flex;align-items:center;gap:9px;font-size:.82rem;color:#42665a;margin-bottom:14px}
.elis-transaction-approval .el-note i{color:#0b9276}
.elis-transaction-approval .el-flag{display:inline-flex;align-items:center;gap:5px;background:#ffe7e8;color:#a42c37;padding:4px 7px;border-radius:6px;font-size:.72rem;font-weight:700;margin-top:6px}
.elis-transaction-approval .el-job{font-weight:700;color:#075d4d}
.elis-transaction-approval .el-approve{border-radius:8px;padding:8px 12px;font-weight:700;white-space:nowrap}
.elis-transaction-approval .el-details{max-width:560px;line-height:1.5;color:#435a51;overflow-wrap:anywhere}
.elis-transaction-approval .el-footer{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-top:14px;color:#69867b;font-size:.79rem}
.elis-transaction-approval .dataTables_wrapper .dataTables_filter{display:none}
.elis-transaction-approval .dataTables_wrapper .dataTables_length{margin-bottom:12px}
.elis-transaction-approval .dataTables_wrapper .dataTables_info,.elis-transaction-approval .dataTables_wrapper .dataTables_paginate{padding-top:14px}
.elis-transaction-approval .el-objection-alert{color:#a42c37}
@media(max-width:768px){.elis-transaction-approval .el-toolbar .el-field{min-width:100%}.elis-transaction-approval .el-toolbar .el-reset{width:100%}}
</style>
<div class="main-content app-content elis-transaction-approval">
 <div class="container-fluid page-container">
  <div class="el-hero d-flex align-items-center justify-content-between flex-wrap gap-3">
   <div><div class="el-eyebrow"><i class="fas fa-shield-alt me-1"></i> ELIS · Approval Workspace</div><h1><i class="fas fa-check-double me-2"></i>Transaction Approval Management</h1><p>Review and approve transactions assigned to ${fullname}</p></div>
   <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item active" aria-current="page">Transaction Approvals</li></ol></nav>
  </div>
  <div class="row g-3 mb-4">
   <div class="col-xl-3 col-md-6"><div class="card el-stat total"><div class="card-body d-flex justify-content-between align-items-center"><div><div class="el-label">Total Transactions</div><div class="el-value">${fn:length(transactionlist)}</div><div class="el-sub">Transactions assigned to you</div></div><div class="el-icon"><i class="fas fa-exchange-alt"></i></div></div></div></div>
   <div class="col-xl-3 col-md-6"><div class="card el-stat pending"><div class="card-body d-flex justify-content-between align-items-center"><div><div class="el-label">Pending Approval</div><div class="el-value" id="el-pending-count">—</div><div class="el-sub">Awaiting decision</div></div><div class="el-icon"><i class="fas fa-clock"></i></div></div></div></div>
   <div class="col-xl-3 col-md-6"><div class="card el-stat approved"><div class="card-body d-flex justify-content-between align-items-center"><div><div class="el-label">Approved</div><div class="el-value" id="el-approved-count">—</div><div class="el-sub">Successfully reviewed</div></div><div class="el-icon"><i class="fas fa-check-circle"></i></div></div></div></div>
   <div class="col-xl-3 col-md-6"><div class="card el-stat rejected"><div class="card-body d-flex justify-content-between align-items-center"><div><div class="el-label">Rejected</div><div class="el-value" id="el-rejected-count">—</div><div class="el-sub">Declined transactions</div></div><div class="el-icon"><i class="fas fa-times-circle"></i></div></div></div></div>
  </div>
  <div class="card el-main-card mb-4"><div class="card-header d-flex align-items-center justify-content-between flex-wrap gap-2"><h5 class="mb-0"><i class="fas fa-list me-2"></i>Transaction Approval List</h5><div class="d-flex gap-2 align-items-center"><span class="badge bg-light text-dark"><i class="fas fa-file me-1"></i>Total: ${fn:length(transactionlist)}</span><button type="button" class="btn btn-light btn-sm" onclick="window.location.reload()" title="Refresh"><i class="fas fa-sync-alt"></i></button></div></div>
   <div class="card-body p-3 p-md-4">
    <div class="el-toolbar" role="search" aria-label="Filter transaction approvals">
      <div class="el-field" style="flex:2"><label for="el-transaction-search">Search transactions</label><input type="search" id="el-transaction-search" class="form-control" placeholder="Job number, application type or details..."></div>
      <div class="el-field"><label for="el-transaction-status">Approval status</label><select id="el-transaction-status" class="form-select"><option value="all">All statuses</option><option value="pending">Pending</option><option value="approved">Approved</option><option value="rejected">Rejected</option><option value="other">Other / Unspecified</option></select></div>
      <div class="el-field"><label for="el-transaction-objections">Objections</label><select id="el-transaction-objections" class="form-select"><option value="all">All transactions</option><option value="yes">With objections</option><option value="no">Without objections</option></select></div>
      <button type="button" id="el-clear-filters" class="btn el-reset"><i class="fas fa-undo me-1"></i>Reset</button>
    </div>
    <div class="el-note"><i class="fas fa-info-circle"></i><span>Review transaction details before approval. Applications with objections are highlighted in red.</span></div>
    <div class="table-responsive"><table class="table table-bordered table-hover display" id="transactionDataTable" width="100%" cellspacing="0"><thead><tr><th>Job Number</th><th>Application Type</th><th>Transaction Details</th><th>Action</th></tr></thead><tbody>
    <c:forEach items="${transactionlist}" var="appfiles"><tr class="${appfiles.objections > 0 ? 'red-alert-row' : ''}" data-approval-status="${fn:escapeXml(appfiles.approval_status)}" data-has-objections="${appfiles.objections > 0 ? 'yes' : 'no'}" ${appfiles.objections > 0 ? "data-bs-toggle='tooltip' title='Application has pending Objections'" : ""}>
     <td><span class="el-job">${appfiles.job_number}</span><c:if test="${appfiles.objections > 0}"><br><span class="el-flag"><i class="fas fa-exclamation-triangle"></i> Objection recorded</span></c:if></td><td><span class="badge bg-info">${appfiles.business_process_sub_name}</span></td>
     <td class="el-details" data-bs-toggle="tooltip" data-bs-placement="top" title="${fn:escapeXml(appfiles.transaction_details)}">${fn:escapeXml(fn:substring(appfiles.transaction_details, 0, 50))}${fn:length(appfiles.transaction_details) > 50 ? '...' : ''}</td>
     <td class="table-actions"><button type="button" class="btn btn-success btn-sm approve-btn el-approve" data-job_number="${fn:escapeXml(appfiles.job_number)}" data-case_number="${fn:escapeXml(appfiles.case_number)}" data-ta_id="${fn:escapeXml(appfiles.ta_id)}" data-type_of_transaction="${fn:escapeXml(appfiles.type_of_transaction)}" data-transaction_details="${fn:escapeXml(appfiles.transaction_details)}" data-approval_status="${fn:escapeXml(appfiles.approval_status)}" data-business_process_name="${fn:escapeXml(appfiles.business_process_name)}" data-business_process_sub_name="${fn:escapeXml(appfiles.business_process_sub_name)}" data-bs-toggle="modal" data-bs-target="#final_registration_approval_dialog" title="Approve Transaction"><i class="fas fa-check-circle me-1"></i>Approve</button></td>
    </tr></c:forEach>
   </tbody></table></div><div class="el-footer"><span><i class="fas fa-lock me-1"></i> Approval actions use your existing ELIS authorization workflow.</span><span id="el-filter-count" aria-live="polite"></span></div></div>
  </div>
 </div>
</div>
<script>
$(document).ready(function(){
  var $table=$('#transactionDataTable');
  var pending=['pending','pending approval','awaiting approval','0'];
  var approved=['approved','approve','1'];
  var rejected=['rejected','reject','2'];
  function statusGroup(value){
    var status=String(value||'').trim().toLowerCase();
    if(pending.indexOf(status)!==-1)return 'pending';
    if(approved.indexOf(status)!==-1)return 'approved';
    if(rejected.indexOf(status)!==-1)return 'rejected';
    return 'other';
  }
  var counts={pending:0,approved:0,rejected:0,other:0};
  $table.find('tbody tr[data-approval-status]').each(function(){counts[statusGroup($(this).attr('data-approval-status'))]++;});
  // Unspecified statuses are not guessed; show a dash for incomplete breakdowns.
  if(!counts.other){
    $('#el-pending-count').text(counts.pending);
    $('#el-approved-count').text(counts.approved);
    $('#el-rejected-count').text(counts.rejected);
  }
  var dt=null;
  if($.fn.DataTable){
    dt=$.fn.DataTable.isDataTable($table[0])?$table.DataTable():$table.DataTable({
      pageLength:10,lengthMenu:[[10,25,50,-1],[10,25,50,'All']],
      responsive:true,order:[[0,'desc']],columnDefs:[{orderable:false,targets:[3]}],
      language:{search:'Search:',lengthMenu:'Show _MENU_ entries',info:'Showing _START_ to _END_ of _TOTAL_ transactions',infoEmpty:'No transactions available',infoFiltered:'(filtered from _MAX_ total transactions)',zeroRecords:'No matching transactions found'}
    });
    // Register one scoped DataTables filter, with no changes to server-side approval logic.
    var filterFn=function(settings,data,dataIndex){
      if(settings.nTable!==$table[0])return true;
      var row=dt.row(dataIndex).node();
      if(!row)return true;
      var requestedStatus=$('#el-transaction-status').val();
      var requestedObjections=$('#el-transaction-objections').val();
      if(requestedStatus!=='all' && statusGroup(row.getAttribute('data-approval-status'))!==requestedStatus)return false;
      if(requestedObjections!=='all' && row.getAttribute('data-has-objections')!==requestedObjections)return false;
      return true;
    };
    $.fn.dataTable.ext.search.push(filterFn);
    $('#el-transaction-search').on('input',function(){dt.search(this.value).draw();});
    $('#el-transaction-status,#el-transaction-objections').on('change',function(){dt.draw();});
    $('#el-clear-filters').on('click',function(){
      $('#el-transaction-search').val('');
      $('#el-transaction-status,#el-transaction-objections').val('all');
      dt.search('').draw();
    });
    dt.on('draw',function(){
      $('#el-filter-count').text(dt.rows({search:'applied'}).count()+' matching transactions');
    });
    dt.draw();
  }else{
    // Search remains available if the DataTables plugin is not loaded.
    $('#el-transaction-search,#el-transaction-status,#el-transaction-objections').on('input change',function(){
      var term=$('#el-transaction-search').val().toLowerCase();
      var status=$('#el-transaction-status').val();
      var objection=$('#el-transaction-objections').val();
      var visible=0;
      $table.find('tbody tr').each(function(){
        var ok=(!term||$(this).text().toLowerCase().indexOf(term)!==-1)&&
          (status==='all'||statusGroup(this.getAttribute('data-approval-status'))===status)&&
          (objection==='all'||this.getAttribute('data-has-objections')===objection);
        $(this).toggle(ok);if(ok)visible++;
      });
      $('#el-filter-count').text(visible+' matching transactions');
    });
    $('#el-clear-filters').on('click',function(){
      $('#el-transaction-search').val('');$('#el-transaction-status,#el-transaction-objections').val('all').trigger('change');
    });
  }
  if(typeof bootstrap!=='undefined'&&bootstrap.Tooltip){
    document.querySelectorAll('.elis-transaction-approval [data-bs-toggle="tooltip"]').forEach(function(el){bootstrap.Tooltip.getOrCreateInstance(el);});
  }
  // Approval modal data attributes and existing application handlers remain unchanged.
});
</script>
