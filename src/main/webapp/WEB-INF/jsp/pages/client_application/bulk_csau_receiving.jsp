<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


<div class="main-content app-content">
    <div class="container-fluid page-container">

      <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Bulk Receiving</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Bulk Receiving</li>
                </ol>
            </div>
        </div>
      <!-- Breadcrumbs-->
           
         <div class="row g-4">
			<!-- Search Section -->
			<div class="col-lg-6">
				<div class="card border-0 shadow-sm h-100">
				<div class="card-header bg-primary bg-gradient text-white">
					<h5 class="mb-0"><i class="fas fa-search text-warning me-2"></i>Search Section</h5>
				</div>
				<div class="card-body">
					<form id="frmEnquiryJobSearch" method="post">
					<!-- Search Type -->
					<div class="mb-4">
						<label class="form-label fw-bold mb-3">Search By:</label>
						<div class="d-flex flex-wrap gap-4">
						<div class="form-check">
							<input class="form-check-input" type="radio" name="rbtn_search_type" id="rbtn_search_type1" value="job_number" required checked>
							<label class="form-check-label fw-medium" for="rbtn_search_type1">
							<i class="fas fa-hashtag me-1"></i>Job Number
							</label>
						</div>
						<!-- Add more radio options here if needed -->
						</div>
					</div>

					<!-- Search Input -->
					<div class="mb-4">
						<label for="enq_search_value" class="form-label fw-bold mb-2">Search Term</label>
						<div class="input-group input-group-lg">
						<input type="text" class="form-control form-control-lg" 
								id="enq_search_value" name="enq_search_value" 
								placeholder="Enter job number to search" required>
						<button type="submit" class="btn btn-primary btn-lg" id="btnEnquiryJobSearch">
							<i class="fas fa-search me-2"></i>Search
						</button>
						</div>
						<div class="form-text">Enter at least 8 characters for better results</div>
					</div>
					</form>

					<!-- Alert - Can be removed since we're using SweetAlert -->
					<div class="alert alert-danger d-none mt-3" id="enquiry_alert" role="alert">
					<i class="fas fa-exclamation-circle me-2"></i>No Results Found
					</div>
				</div>
				</div>
			</div>

			<!-- Depositor's Details Section -->
			<div class="col-lg-6">
				<div class="card border-0 shadow-sm h-100">
				<div class="card-header bg-info bg-gradient text-white">
					<h5 class="mb-0"><i class="fas fa-user-circle text-warning me-2"></i>Depositor's Details</h5>
				</div>
				<div class="card-body">
					<form id="frmEnquiryBatchlist" method="post">
					<!-- Depositor's Name -->
					<div class="mb-3">
						<label for="bcd_depositor_by" class="form-label fw-bold">Full Name</label>
						<div class="input-group">
						<span class="input-group-text bg-light"><i class="fas fa-user"></i></span>
						<input type="text" class="form-control" id="bcd_depositor_by" 
								placeholder="Enter depositor's full name" required>
						</div>
					</div>

					<!-- ID Type and Number -->
					<div class="row g-3 mb-3">
						<div class="col-md-6">
						<label for="bcd_depositor_id_type" class="form-label fw-bold">ID Type</label>
						<select class="form-select" id="bcd_depositor_id_type" required data-trigger>
							<option value="" selected disabled>Select ID Type</option>
							<option value="NATIONAL ID">National ID</option>
							<option value="PASSPORT">Passport</option>
							<option value="DRIVERS LICENSE">Driver's License</option>
							<option value="NHIS CARD">NHIS Card</option>
							<option value="VOTERS ID">Voter's ID</option>
							<option value="SSNIT ID CARD">SSNIT ID Card</option>
						</select>
						</div>
						<div class="col-md-6">
						<label for="bcd_depositor_id_number" class="form-label fw-bold">ID Number</label>
						<div class="input-group">
							<span class="input-group-text bg-light"><i class="fas fa-id-card"></i></span>
							<input type="text" class="form-control" id="bcd_depositor_id_number" 
								placeholder="Enter ID number" required>
						</div>
						</div>
					</div>

					<!-- Contact Information -->
					<div class="row g-3 mb-3">
						<div class="col-md-6">
						<label for="bcd_depositor_phone_number" class="form-label fw-bold">Phone Number</label>
						<div class="input-group">
							<span class="input-group-text bg-light"><i class="fas fa-phone"></i></span>
							<input type="text" class="form-control" id="bcd_depositor_phone_number" 
								placeholder="Enter phone number" required>
						</div>
						</div>
						<div class="col-md-6">
						<label for="bcd_depositor_email" class="form-label fw-bold">Email Address</label>
						<div class="input-group">
							<span class="input-group-text bg-light"><i class="fas fa-envelope"></i></span>
							<input type="email" class="form-control" id="bcd_depositor_email" 
								placeholder="Enter email address" required>
						</div>
						</div>
					</div>

					<!-- Submission Type -->
					<div class="mb-4">
						<label for="bcd_submission_type" class="form-label fw-bold">Submission Type</label>
						<select class="form-select" id="bcd_submission_type" required data-trigger>
						<option value="" selected disabled>Select Re-Submission Type</option>
						<option value="First Time Hard Copy Submission">First Time Hard Copy Submission</option>
						<option value="Resolved Query">Resolved Query</option>
						<option value="Payment">Payment</option>
						<option value="Correction">Correction</option>
						<option value="No Payment Details">No Payment Details</option>
						<option value="Re-assessment">Re-assessment</option>
						<option value="Other">Other</option>
						</select>
					</div>

					<!-- Process Button -->
					<div class="d-grid">
						<button type="button" class="btn btn-success btn-lg" id="btnBatchBulkReceiving">
						<i class="fas fa-play-circle me-2"></i>Process List
						</button>
					</div>
					</form>
				</div>
				</div>
			</div>
			</div>

			<!-- Search Results Section -->
			<div class="row mt-4">
			<div class="col-12">
				<div class="card border-0 shadow-sm" id="enq-search-results-section" style="display: none">
				<div class="card-header bg-secondary bg-gradient text-white d-flex justify-content-between align-items-center">
					<div>
					<h5 class="mb-0"><i class="fas fa-list-check me-2"></i>Search Results</h5>
					</div>
					<div>
					<span class="badge bg-light text-dark fs-6 me-2">
						<i class="fas fa-file-alt me-1"></i>Showing 10 records
					</span>
					<button type="button" class="btn btn-light btn-sm" id="btnClearResults">
						<i class="fas fa-trash-alt me-1"></i>Clear Results
					</button>
					</div>
				</div>
				<div class="card-body p-0">
					<div class="table-responsive">
					<table class="table table-hover table-striped mb-0" id="tbl-bulk-receiving-table">
						<thead class="table-dark">
						<tr>
							<th><i class="fas fa-user me-1"></i>Applicant Name</th>
							<th><i class="fas fa-file-alt me-1"></i>Case Number</th>
							<th><i class="fas fa-hashtag me-1"></i>Job Number</th>
							<th><i class="fas fa-tag me-1"></i>Application Type</th>
							<th><i class="fas fa-key me-1"></i>GLPIN</th>
							<th><i class="fas fa-map-marker-alt me-1"></i>Locality</th>
							<th><i class="fas fa-flag me-1"></i>Regional Number</th>
							<th class="text-center"><i class="fas fa-cogs me-1"></i>Actions</th>
						</tr>
						</thead>
						<tbody>
						<!-- Results will be populated here -->
						</tbody>
					</table>
					</div>
				</div>
				<div class="card-footer bg-light border-top py-3">
					<div class="d-flex justify-content-between align-items-center">
					<small class="text-muted">
						<i class="fas fa-info-circle me-1"></i>Select records for batch processing
					</small>
					<div class="badge bg-info text-dark">
						<span id="selectedCount">0</span> selected
					</div>
					</div>
				</div>
				</div>
			</div>
			</div>
    </div>
     
 </div>

 <div class="modal fade effect-scale modal-blur" id="publicViewFileModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="publicViewFileModal_label" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-folder2-open fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white mb-1" id="publicViewFileModal_label">
                            Review Documents
                        </h5>
                        <p class="mb-0 small opacity-75">
                            <i class="bi bi-info-circle me-1"></i>
                            Manage and review case documents
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Loading Indicator -->
                <div id="documentsLoading" class="d-none mb-4">
                    <div class="d-flex align-items-center">
                        <div class="spinner-border spinner-border-sm text-primary me-2" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <small class="text-muted">Loading documents...</small>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex flex-wrap gap-2 mb-4">
                    <button type="button" class="btn btn-primary btn-sm" id="btn_load_scanned_documents_public_gated_workflow">
                        <i class="bi bi-eye me-1"></i> Load Documents
                    </button>
                    
                    <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" 
                            data-bs-target="#publicFileUploadModal">
                        <i class="bi bi-plus-circle me-1"></i> Add Documents
                    </button>
                    
                    <button type="button" class="btn btn-info btn-sm" id="btn_refresh_documents">
                        <i class="bi bi-arrow-clockwise me-1"></i> Refresh
                    </button>
                    
                    <button type="button" class="btn btn-outline-secondary btn-sm" id="btn_export_documents">
                        <i class="bi bi-download me-1"></i> Export
                    </button>
                </div>

                <!-- Case Information -->
                <div class="card border mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0 fw-semibold">
                            <i class="bi bi-info-circle me-2"></i>Case Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-file-text me-1"></i>Case Number
                                </label>
                                <div class="input-group">
                                    <input type="text" 
                                           class="form-control bg-light" 
                                           id="cs_main_case_number" 
                                           value="${case_number}" 
                                           readonly>
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="copyToClipboard('cs_main_case_number')">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-person me-1"></i>Applicant Name
                                </label>
                                <input type="text" 
                                       class="form-control bg-light" 
                                       id="cs_main_applicant_name"
                                       readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documents Table -->
                <div class="table-responsive border rounded mb-4">
                    <table class="table table-hover table-sm mb-0" id="lc_public_documents_dataTable_gated_workflow">
                        <thead class="table-light">
                            <tr>
                                <th width="40%">
                                    <i class="bi bi-file-earmark-text me-1"></i>Document Name
                                </th>
                                <th width="25%">
                                    <i class="bi bi-tag me-1"></i>Document Type
                                </th>
                                <th width="15%" class="text-center">
                                    <i class="bi bi-filetype-pdf me-1"></i>Format
                                </th>
                                <th width="20%" class="text-center">
                                    <i class="bi bi-gear me-1"></i>Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody id="documentsTableBody_gated_workflow">
                            
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                        <!-- <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="showApprovalButton">
                            <label class="form-check-label small" for="showApprovalButton">
                                Show Final Approval
                            </label>
                        </div> -->
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i> Close
                        </button>
                        <!-- <button type="button" id="btn_update_app_status_ffrv" style="display:none"
                                class="btn btn-success">
                            <i class="bi bi-check-circle me-1"></i> Confirm Final Approval
                        </button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

  <script>

// function batch_selected_files() {



//     $("#batchlistdataTable").find("tr:gt(0)").remove();
        
//     var table1 = document.getElementById("tbl-bulk-receiving-table"),
//     table2 = document.getElementById("batchlistdataTable")
        
//     var purpose = $("#batch_purpose_form #txt_general_job_purpose").val();
//     var tr = $('#tbl-bulk-receiving-table tbody tr')

//     console.log(tr.length)
        
//     for(var i = 0; i < tr.length; i++) {
    
         
            
//             // create new row and cells
//             var newRow = table2.insertRow(table2.length),
//                 cell1 = newRow.insertCell(0),
//                 cell2 = newRow.insertCell(1),
//                 cell3 = newRow.insertCell(2),
//                 cell4 = newRow.insertCell(3),
//                 cell5 = newRow.insertCell(4);
                
//             // add values to the cells
//             cell1.innerHTML = table1.rows[i+1].cells[2].innerHTML;
//             cell2.innerHTML = table1.rows[i+1].cells[0].innerHTML;
//             cell3.innerHTML = table1.rows[i+1].cells[4].innerHTML; 
//             cell4.innerHTML = purpose;
//             cell5.innerHTML = `<div class='text-center'><button type='button' class='btn btn-outline-danger text-center' onclick='document.getElementById("batchlistdataTable").deleteRow(${i+1})'><i class='fas fa-trash ml-2'></i></button></div>`;
           
       
//     }
//     /*let batchlistdataTable = document.querySelector('#batchlistdataTable');
    
//     let headers = [...batchlistdataTable.rows[0].cells].map(th => th.innerText);
//     for(let row of [...batchlistdataTable.rows].slice(1, batchlistdataTable.rows.length)) {
//         batchList = Object.fromEntries(new Map([...row.cells].map((cell, i) => [headers.at(i), cell.innerText])));
//         //console.log(JSON.stringify(batchList));
//     }*/
    
//     var _table = document.getElementById("batchlistdataTable");
//     var _trLength = _table.getElementsByTagName("tr").length;
//     var _jsonData = [];
//     var _obj = {};
    
//     var _htmlToJSON = function(index){
//         var _tr = _table.getElementsByTagName("tr")[index];
//         var _td = _tr.getElementsByTagName("td");
//         var _arr = [].map.call( _td, function( td ) {
//             return td.innerHTML;
//         }).join( ',' );
//         var _data = _arr.split(",");
        
//         _obj = {
//              reference_no     : _data[0]
//             ,application_name     : _data[1]
//             ,subject_location     : _data[2]
//             ,purpose     : _data[3]
//         };
        
//         _jsonData.push(_obj);
        
//     };
    
//     for(var j = 1; j < _trLength; j++){
//         _htmlToJSON(j);
//     }
//     //console.log("html to JSON",_jsonData);​
    
    
//     $(document).ready(function (){
        
//         $('#remove_all_from_list').click(function(){
//             _jsonData = [];
//         })
        
//         $("#viewBatchlistModal").on("hidden.bs.modal", function() {
//             _jsonData = [];
//             //console.log(_jsonData)
//         });
        
//         $('#btn_process_batchlist_ft').click(function(){
//             var json_data = JSON.stringify(_jsonData);
//             var unit_to_send_to = $('#viewBatchlistModal #unit_to_send_to').val();
//             var user_to_send_to = $('#viewBatchlistModal #user_to_send_to').val();
//             var unit_division_to_send_to = $('#viewBatchlistModal #unit_division_to_send_to').val();
            
//             if(json_data == [] || !json_data) {
//                 $.toast({
//                       heading: 'Warning',
//                       text: 'Please select application to continue',
//                       showHideTransition: 'slide',
//                       icon: 'error',
//                       loaderBg: '#f2a654',
//                       position: 'bottom-right',
//                       hideAfter: 10000 
//                 })
//             }else {
//                 var $this = $('#btn_process_batchlist_ft');
//                 var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
//                 if ($('#btn_process_batchlist_ft').html() !== loadingText) {
//                   $this.data('original-text', $('#btn_process_batchlist_ft').html());
//                   $this.html(loadingText);
//                   $('#btn_process_batchlist_ft').prop('disabled', true);
//                   $('#btn_close_process').hide();
//                 }
            
//                 $.ajax({
//                     type: "POST",
//                     url: "files_track",
//                     data: {
//                         request_type: "batch_list_to_unit",
//                         unit_to_send_to: unit_to_send_to,
//                         user_to_send_to: user_to_send_to,
//                         unit_division_to_send_to: unit_division_to_send_to,
//                         json_data: json_data
//                     },
//                     cache: false,
//                     success: function(results){
//                         console.log(results);
//                         json_data = JSON.parse(results)
//                         if(json_data.success == true) {
//                             $('#btn_process_batchlist_ft').prop('disabled', false);
//                             $('#btn_close_process').show();
//                             $this.html($this.data('original-text'));
//                             $.toast({
//                                   heading: 'Success',
//                                 text: 'The application has been batched successfully.',
//                                 showHideTransition: 'slide',
//                                 icon: 'success',
//                                 loaderBg: '#f96868',
//                                 position: 'bottom-right',
//                                 hideAfter: 10000 
//                             })
//                             $('#viewBatchlistModal').modal('hide');
                            
//                         } else {
//                             $('#btn_process_batchlist_ft').prop('disabled', false);
//                             $('#btn_close_process').show();
//                             $this.html($this.data('original-text'));
//                             $.toast({
//                                   heading: 'System Failed',
//                                   text: 'Sorry! something went wrong, try again.',
//                                   showHideTransition: 'slide',
//                                   icon: 'error',
//                                   loaderBg: '#f2a654',
//                                   position: 'bottom-right',
//                                   hideAfter: 10000 
//                             })
//                         }
//                     }
//                 })
//             }  
            
//         })
//     })
// }//


function remove_all_from_list() {
	var tableHeaderRowCount = 1;
	var table = document.getElementById('batchlistdataTable');
	var rowCount = table.rows.length;
	for (var i = tableHeaderRowCount; i < rowCount; i++) {
	    table.deleteRow(tableHeaderRowCount);
	}
	
	var btn_process_batchlist_ft = document.getElementById('btn_process_batchlist_ft');
	btn_process_batchlist_ft.style.display = "none";
}

  </script>