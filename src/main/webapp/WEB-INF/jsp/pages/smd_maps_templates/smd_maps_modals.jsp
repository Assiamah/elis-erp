<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>

<style>
/* ELIS SMD modals: scoped emerald-green theme */
#smdparcelinformationfirst, #smdparcelinformation, #addsmdtransaction { --smd-dark:#064b39;--smd-primary:#087f5b;--smd-bright:#0ba26f;--smd-pale:#e8f7ee;--smd-border:#cce8d9; }
#smdparcelinformationfirst .modal-content,#smdparcelinformation .modal-content,#addsmdtransaction .modal-content{border:0;border-radius:16px;overflow:hidden;box-shadow:0 24px 65px rgba(6,75,57,.23)}
#smdparcelinformationfirst .modal-header,#smdparcelinformation .modal-header,#addsmdtransaction .modal-header{background:linear-gradient(115deg,#064b39,#087f5b 65%,#0ba26f);color:#fff;border:0;padding:19px 24px;display:flex;align-items:center;justify-content:space-between}
#smdparcelinformationfirst .modal-title,#smdparcelinformation .modal-title,#addsmdtransaction .modal-title{color:#fff!important;font-size:1.13rem;font-weight:700;margin:0}
#smdparcelinformationfirst .modal-header .close,#smdparcelinformation .modal-header .close,#addsmdtransaction .modal-header .close{order:2;color:#fff!important;opacity:1;text-shadow:none;font-size:1.5rem;margin:0;padding:0 4px;border:0;background:transparent}
#smdparcelinformationfirst .modal-body,#smdparcelinformation .modal-body,#addsmdtransaction .modal-body{padding:24px;background:#fbfefc}
#smdparcelinformationfirst .modal-body>.container,#smdparcelinformation .modal-body>.container,#addsmdtransaction .modal-body>.container{width:100%;max-width:100%;padding:0}
#smdparcelinformationfirst label,#smdparcelinformation label,#addsmdtransaction label{font-size:.82rem;font-weight:700;color:#175a43;margin-bottom:7px}
#smdparcelinformationfirst .form-control,#smdparcelinformation .form-control,#addsmdtransaction .form-control{min-height:39px;border:1px solid var(--smd-border);border-radius:8px;background:#fff;color:#263b33;box-shadow:none;transition:border-color .2s,box-shadow .2s}
#smdparcelinformationfirst .form-control:focus,#smdparcelinformation .form-control:focus,#addsmdtransaction .form-control:focus{border-color:var(--smd-bright);box-shadow:0 0 0 3px rgba(11,162,111,.13)}
#smdparcelinformationfirst .form-control[readonly],#smdparcelinformation .form-control[readonly],#addsmdtransaction .form-control[readonly]{background:#f0f7f2;color:#50665b}
#smdparcelinformationfirst .form-group,#smdparcelinformation .form-group,#addsmdtransaction .form-group{margin-bottom:18px}
#smdparcelinformationfirst .form-row,#smdparcelinformation .form-row,#addsmdtransaction .form-row{display:flex;flex-wrap:wrap;gap:12px;margin:0}
#smdparcelinformationfirst .form-row>.col,#smdparcelinformation .form-row>.col,#addsmdtransaction .form-row>.col{flex:1 1 170px;min-width:0;padding:0}
#smdparcelinformationfirst .modal-footer,#smdparcelinformation .modal-footer,#addsmdtransaction .modal-footer{background:#f0f8f3;border-top:1px solid var(--smd-border);padding:14px 24px}
#smdparcelinformationfirst .btn-primary,#smdparcelinformation .btn-primary,#addsmdtransaction .btn-primary,#addsmdtransaction .btn-success{background:var(--smd-primary)!important;border-color:var(--smd-primary)!important;color:#fff!important}
#smdparcelinformationfirst .btn-primary:hover,#smdparcelinformation .btn-primary:hover,#addsmdtransaction .btn-primary:hover,#addsmdtransaction .btn-success:hover{background:var(--smd-dark)!important;border-color:var(--smd-dark)!important}
#smdparcelinformationfirst .btn-default,#smdparcelinformation .btn-default,#addsmdtransaction .btn-default{background:#fff;border:1px solid #c4d8cb;color:var(--smd-dark)}
#smdparcelinformationfirst .btn-default:hover,#smdparcelinformation .btn-default:hover,#addsmdtransaction .btn-default:hover{background:var(--smd-pale)}
#smdparcelinformationfirst .btn,#smdparcelinformation .btn,#addsmdtransaction .btn{border-radius:8px;font-weight:600;padding:8px 15px}
#smdparcelinformation .table-responsive{border:1px solid var(--smd-border);border-radius:10px;overflow:auto;margin-bottom:17px}
#smdparcelinformation table{margin-bottom:0;background:#fff}
#smdparcelinformation table thead th{background:#e2f3e5;color:#07543b;border-color:#cce8d9;font-size:.78rem;white-space:nowrap;padding:11px}
#smdparcelinformation table tbody td{border-color:#e4eee7;padding:10px;vertical-align:middle}
#smdparcelinformation table tbody tr:hover{background:#f2fbf5}
@media(max-width:767px){#smdparcelinformationfirst .modal-body,#smdparcelinformation .modal-body,#addsmdtransaction .modal-body{padding:16px}#smdparcelinformationfirst .form-row,#smdparcelinformation .form-row,#addsmdtransaction .form-row{gap:10px}#smdparcelinformationfirst .form-row>.col,#smdparcelinformation .form-row>.col,#addsmdtransaction .form-row>.col{flex-basis:100%}}
</style>

<!-- SMD Parcel (first) -->
<div class="modal fade bd-example-modal-xl" tabindex="-1" id="smdparcelinformationfirst" role="dialog" aria-labelledby="smdFirstModalTitle" aria-hidden="true">
  <div class="modal-dialog"><div class="modal-content">
    <div class="modal-header"><h4 class="modal-title custom_align" id="smdFirstModalTitle"><i class="fas fa-draw-polygon mr-2"></i> SMD Parcel</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
    <div class="modal-body"><input id="smd_gid_f" name="smd_gid_f" type="hidden" value="0"><div class="container"><div class="row"><div class="col">
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_ref_no_f">Reference Number</label><input class="form-control" type="text" id="smd_ref_no_f" readonly></div><div class="col"><label for="smd_locality_f">Locality</label><input class="form-control" type="text" id="smd_locality_f"></div></div></div>
      <div class="form-group"><label for="smd_wkt_polygon_f">WKT polygon</label><input class="form-control" type="text" id="smd_wkt_polygon_f"></div>
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_land_size_f">Land Size</label><input class="form-control" type="text" id="smd_land_size_f"></div><div class="col"><label class="d-block">&nbsp;</label><button class="btn btn-primary btn-block" id="btn_save_smd_parcel_details_f"><i class="fas fa-save mr-1"></i> Save</button></div></div></div>
    </div></div></div></div>
    <div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times mr-1"></i> Close</button></div>
  </div></div>
</div>

<!-- SMD Parcel Information -->
<div class="modal fade bd-example-modal-xl" tabindex="-1" id="smdparcelinformation" role="dialog" aria-labelledby="smdParcelModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-xl"><div class="modal-content">
    <div class="modal-header"><h4 class="modal-title custom_align" id="smdParcelModalTitle"><i class="fas fa-map-marked-alt mr-2"></i> SMD Transaction Informations</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
    <div class="modal-body"><input id="smd_gid_p" name="smd_gid_p" type="hidden" value="0"><div class="container"><div class="row">
      <div class="col-md-6">
        <div class="form-group"><div class="form-row"><div class="col"><label for="smd_ref_no">Reference Number</label><input class="form-control" type="text" id="smd_ref_no" readonly></div><div class="col"><label for="smd_locality">Locality</label><input class="form-control" type="text" id="smd_locality"></div></div></div>
        <div class="form-group"><div class="form-row"><div class="col"><label for="smd_plotted_by">Plotted By</label><input class="form-control" type="text" id="smd_plotted_by" readonly></div><div class="col"><label for="smd_date_plott">Date Plotted</label><input class="form-control" type="text" id="smd_date_plott" readonly></div><div class="col"><label for="smd_mul_claim">Multiple Claim</label><input class="form-control" type="text" id="smd_mul_claim" readonly></div></div></div>
        <div class="form-group"><div class="form-row"><div class="col"><label for="smd_modified_by">Last Update By</label><input class="form-control" type="text" id="smd_modified_by" readonly></div><div class="col"><label for="smd_modified_date">Date Last Updated</label><input class="form-control" type="text" id="smd_modified_date" readonly></div></div></div>
        <div class="form-group"><button class="btn btn-primary btn-block" id="btn_save_smd_parcel_details"><i class="fas fa-save mr-1"></i> Save</button></div>
      </div>
      <div class="col-md-6">
        <button type="button" class="btn btn-primary btn-sm mb-3" data-toggle="modal" data-target="#addsmdtransaction"><i class="fas fa-plus-circle mr-1"></i> Add New Transaction</button>
        <div class="table-responsive"><table class="table table-bordered" id="smd_transaction_dataTable" width="100%" cellspacing="0"><thead><tr><th>Name</th><th>Grantor</th><th>Multiple Claim</th><th>Remarks</th><th>Details</th></tr></thead><tbody></tbody></table></div>
        <div class="table-responsive"><table class="table table-bordered" id="smd_scanned_documents_dataTable" width="100%" cellspacing="0"><thead><tr><th>Document Name</th><th>Document Type</th></tr></thead><tbody></tbody></table></div>
      </div>
    </div></div></div>
    <div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times mr-1"></i> Close</button></div>
  </div></div>
</div>

<!-- Add SMD Transaction -->
<div class="modal fade bd-example-modal-xl" tabindex="-1" id="addsmdtransaction" role="dialog" aria-labelledby="smdAddTransactionTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg"><div class="modal-content">
    <div class="modal-header"><h4 class="modal-title custom_align" id="smdAddTransactionTitle"><i class="fas fa-file-signature mr-2"></i> SMD Transaction Informations</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
    <div class="modal-body"><input id="smd_tr_gid" name="smd_tr_gid" type="hidden" value=""><input id="smd_tr_t_id" name="smd_tr_t_id" type="hidden" value="0"><div class="container">
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_tr_reference_number">Reference Number</label><input class="form-control" type="text" id="smd_tr_reference_number" readonly></div><div class="col"><label for="smd_tr_cc_number">CC Number</label><input class="form-control" type="text" id="smd_tr_cc_number"></div></div></div>
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_tr_regional_number">Regional Number</label><input class="form-control" type="text" id="smd_tr_regional_number"></div><div class="col"><label for="smd_tr_job_number">Job Number</label><input class="form-control" type="text" id="smd_tr_job_number"></div></div></div>
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_tr_applicant_name">Applicant Name</label><input class="form-control" type="text" id="smd_tr_applicant_name"></div><div class="col"><label for="smd_tr_grantor_name">Grantor Name</label><input class="form-control" type="text" id="smd_tr_grantor_name"></div></div></div>
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_tr_purpose">Purpose</label><input class="form-control" type="text" id="smd_tr_purpose"></div><div class="col"><label for="smd_tr_plan_number">Plan Number</label><input class="form-control" type="text" id="smd_tr_plan_number"></div></div></div>
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_tr_old_ref_number">Old Ref Number</label><input class="form-control" type="text" id="smd_tr_old_ref_number"></div><div class="col"><label for="smd_tr_mul_claim">Multiple Claim Status</label><input class="form-control" type="text" id="smd_tr_mul_claim"></div></div></div>
      <div class="form-group"><label for="smd_tr_remarks">Remarks</label><input class="form-control" type="text" id="smd_tr_remarks"></div>
      <div class="form-group"><div class="form-row"><div class="col"><label for="smd_tr_modified_by">Last Update By</label><input class="form-control" type="text" id="smd_tr_modified_by" readonly></div><div class="col"><label for="smd_tr_modified_date">Date Last Updated</label><input class="form-control" type="text" id="smd_tr_modified_date" readonly></div></div></div>
    </div></div>
    <div class="modal-footer"><button type="button" class="btn btn-success" data-dismiss="modal" id="btn_save_smd_transaction"><i class="fas fa-save mr-1"></i> Save</button><button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times mr-1"></i> Close</button></div>
  </div></div>
</div>
