<div class="modal fade" id="add_new_file" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title" id="exampleModalLabel">ADD APPLICATION</h6>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="file_track_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Reference Number: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="reference_no">
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Application Type (Main): <span class="text-danger">*</span></label>
           <select class="form-control mb-2" id="application_type">
           		<option selected disabled>-- select --</option>
           		<option value="Letter">Letter</option>
           		<option value="File">File</option>
		   </select>
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Application Type (Sub-main): <span class="text-danger">*</span></label>
           <select class="form-control mb-2" id="specific_type">
           		<option selected disabled>-- select --</option>
           		<option value="Lease">Lease</option>
		   </select>
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Application Name: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="application_name">
         </div>
         <div id="letter_form">
	         <div class="form-group mb-3">
	           <label class="col-form-label">Subject: <span class="text-danger">*</span></label>
	           <input class="form-control" type="text" id="subject">
	         </div>
	         <div class="form-group mb-3">
	           <label class="col-form-label">Date of Letter: <span class="text-danger">*</span></label>
	           <input class="form-control" type="date" id="date_of_letter">
	         </div>
	         <div class="form-group mb-3">
	           <label class="col-form-label">Addressed To:</label>
	           <input class="form-control" type="text" id="addressed_to">
	         </div>
	         <div class="form-group mb-3">
	           <label class="col-form-label">Received From:</label>
	           <input class="form-control" type="text" id="received_from">
	         </div>
         </div>
         <div id="file_form">
	         <div class="form-group mb-3">
	           <label class="col-form-label">Location: <span class="text-danger">*</span></label>
	           <input class="form-control" type="text" id="location">
	         </div>
	         <div class="form-group mb-3">
	           <label class="col-form-label">Received From:</label>
	           <input class="form-control" type="text" id="received_from">
	         </div>
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Purpose: <span class="text-danger">*</span></label>
           <textarea class="form-control" id="purpose"></textarea>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-close">Close</button>
        <button type="submit" class="btn btn-success" id="btn-save">Save</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="viewBatchlistModal" tabindex="-1"
   role="dialog" aria-labelledby="viewBatchlistModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="viewBatchlistModalLabel">Batch List Processing</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body modal-body_lg">
         
          <input id="lbl_batch_type" name="lbl_batch_type" type="hidden" value="normal">
           
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                     
                     	<div class="form-group row">
							
							<div class='${unit_name == "CSAU" ? "col-sm-5" : "col-sm-4"}'>
							<label class="col-form-label" style="text-align: left"><h5>Batch To :</h5></label>
								<div class="input-group">
									<div id="radioBtnBatching" class="btn-group ">
										<a class="btn btn-secondary btn-sm notActive" data-toggle="batch_type" data-title="Unit"><h6>Unit</h6></a> 
										<a class="btn btn-secondary btn-sm notActive" data-toggle="batch_type" data-title="Individual"><h6>Individual</h6></a>
										${unit_name == "CSAU" ? "<a class='btn btn-primary btn-sm notActive' data-toggle='batch_type' data-title='Cabinet'><h2>Cabinet</h2></a>" : unit_name == "CORPORATE CSAU UNIT" ? "<a class='btn btn-primary btn-sm notActive' data-toggle='batch_type' data-title='Cabinet'><h2>Cabinet</h2></a>" : ""}
										
										
									</div>
									<input type="hidden" name="batch_type" id="batch_type">
								</div>
							</div>
							<div class="col">
								<div class="form-row" id="unit-batching" style="background-color:#123456; padding:15px; display:none">
									<div class="col-12"><h5 style="" class="text-white">Batching to a Unit</h5></div>
								    <div class="col">
								      <label for="" class="col-form-label text-white">Division :</label>
		                              <select id="unit_division_to_send_to" class="form-control" >
		                                 <option value="none">---Select Division---</option>
		                                 <option value="LVD">LVD</option>
		                                 <option value="LRD">LRD</option>
		                                 <option value="PVLMD">PVLMD</option>
		                                 <option value="SMD">SMD</option>
		                                  <option value="RLO">RLO</option>
		                              </select>
								      
								    </div>
								    <div class="col">
								    <label for="" class="col-form-label text-white">Unit :</label>
								      <input autocomplete="off" class="form-control" id="unit_to_send_to"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
		                              <datalist id="listofunitsbatching"></datalist>
								    </div>
								</div>
								
								<div class="form-row"  style="background-color:#654321; padding:15px; display:none" id="individual-batching" >
		                           <div class="col-12"><h5 style="" class="text-white">Batching to an Individual</h5></div>
		                           <div class="col-sm-3">
		                              <label for="" class="col-form-label text-light">Division/Unit :</label>
		                              <!-- <select id="division_to_send_to" class="form-control" >
		                                 <option value="none">---Select Division---</option>
		                                 <option value="CSAU">CSAU</option>
		                                 <option value="LVD">LVD</option>
		                                 <option value="LRD">LRD</option>
		                                 <option value="PVLMD">PVLMD</option>
		                                 <option value="SMD">SMD</option>
		                                   <option value="RLO">RLO</option>
		                              </select> -->
		                              <input class="form-control" type="text" value="${unit_name}" id="division_to_send_to" readonly>
		                           </div>
		                           <div class="col-sm-9">
		                              <label for="" class="col-form-label text-light">User :</label>
		                              <!-- <select id="user_to_send_to" class="form-control" >
		                                 </select> -->
		                              <input class="form-control" id="user_to_send_to"  name="user_to_send_to" type="text" autocomplete="off" 
		                                 list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
		                              <datalist id="listofusersbatching"></datalist>
		                           </div>
		                        </div>
		                        <form id="frmBatchToCabinet">
		                        <div class="form-row"  style="background-color:#32a852; padding:15px; display:none " id="cabinet-batching" >
		                           <div class="col-12"><h5 style="" class="text-white">Batching to Cabinet</h5></div>
		                           
			                           <div class="col-auto">
			                              <label for="" class="col-form-label text-white">Cabinet Name :</label>
			                              
			                              <input class="form-control" type="text"  id="cabinet_to_send_to" required>
			                           </div>
			                           <div class="col-sm-4">
			                              <label for="" class="col-form-label text-light">&nbsp;</label>
			                              <!-- <select id="user_to_send_to" class="form-control" >
			                                 </select> -->
			                              <button class="form-control btn btn-primary" type="Submit" >Batch to Cabinet</button>
			                             
			                           </div>
		                           
		                        </div>
								</form>
								
							  &nbsp;
							</div>
						</div>
                     	
                        
                        
                     </div>
                  </div>
               </div>
               <br/>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="batchlistdataTable" class="table table-bordered table-hover">
                        	<tr>
		                        <th>Reference No.</th>
		                        <th>Application Name</th>
		                        <th>Subject/Location</th>
		                        <th>Purpose</th>
		                        <th class="text-center">Action</th>
		                    </tr>
                        </table>
                     </div>
                  </div>
               </div>
               <br/> <br/> <br/>
               <div class="modal-footer">
               		<button type="button" class="btn btn-danger float-left  mr-auto" id="remove_all_from_list" onclick="remove_all_from_list();">Remove all from list</button>
               		<!-- <button type="button" class="btn btn-dark float-left  mr-auto" id="btn_sent_for_frrv_batchlist">Sent For FRRV</button> -->
                  <button type="button" class="btn btn-secondary" id="btn_close_process"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_batchlist_ft"  class="btn btn-primary" style="display:none">Process Batch List</button>
               </div>
            
         </div>
      </div>
   </div>
</div>



<div class="modal fade" id="batch_purpose" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title" id="exampleModalLabel">ADD PURPOSE</h6>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="batch_purpose_form" method="post">
      <div class="modal-body">
         <div class="form-group mb-3">
           <label class="col-form-label">Purpose: <span class="text-danger">*</span></label>
           <textarea class="form-control" rows="7" id="purpose"></textarea>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-close">Close</button>
        <button type="submit" class="btn btn-success" onclick="batch_selected_files();" id="btn-save">Confirm</button>
      </div>
      </form>
    </div>
  </div>
</div>


<div class="modal fade" id="batched_file_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 1000px">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Application Logs</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="row">
      	<div class="col-8">
	        <input class="form-control" type="text" id="ll_reference_no" readonly="readonly">
	         
      	</div>
      	<div class="col-4">
      		<button type="button" class="btn btn-warning" id="btn-load-logs"><i class="fas fa-refresh me-2"></i>Load</button>
      	</div>
      </div>
      <div class="card card-body mt-3">
      	<div class="tab-content mt-1">
	      <div class="table-responsive">
              <table class="table table-fixed" id="file_logs_tbl">
        		<thead>
			    <tr>
			    	<th>#</th>
			    	<th>From.</th>
			        <th>To</th>
			        <th>Officer</th>
			        <th>Purpose</th>
			        <th>Date</th>
			    </tr>
			  </thead>
			  <tbody style="max-width: 100%">
			  </tbody>
             </table>
	        </div>
	    </div>
	    </div>
      
      </div>
    </div>
  </div>
</div>


<!-- <script>
	
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

	function remove_all_from_list_CS() {
		var tableHeaderRowCount = 1;
		var table = document.getElementById('batchlistdataCSTable');
		var rowCount = table.rows.length;
		for (var i = tableHeaderRowCount; i < rowCount; i++) {
			table.deleteRow(tableHeaderRowCount);
		}
		
		var btn_process_batchlist_ft = document.getElementById('btn_process_batchlist_cs');
		btn_process_batchlist_ft.style.display = "none";
	}
	
	  </script> -->