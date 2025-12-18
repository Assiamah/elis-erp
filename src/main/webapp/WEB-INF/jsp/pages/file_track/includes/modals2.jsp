<div class="modal fade" id="add_new_file" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add File/Letter</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="file_track_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Reference Number: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="lodgement_no">
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Activity Type: <span class="text-danger">*</span></label>
           <div class="row">
	           	<div class="col-md-10">
	           		<select class="form-control mb-2" id="activity_type">
		           </select>
	           	</div>
	           	<div class="col-md-2">
	           		<button type="button" class="btn rounded btn-warning" style="border-radius: 10px" id="refresh-activity"><i class="fas fa-refresh m-1"></i></button>
	           	</div>
           </div>
           <a style="text-decoration: underline" href="#"  id="btn-new-activity">Add new</a>
           <!-- <select class="form-control" id="activity_type">
           	<option>-- select --</option>
           	<option value="File">File</option>
           	<option value="Letter">Letter</option>
           </select> -->
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Name of Enquirer: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="name">
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Subject/Location:</label>
           <input class="form-control" type="text" id="subject">
         </div>
         <div class="form-group mb-2">
           <label class="col-form-label">Received From: <span class="text-danger">*</span></label>
           <div class="row">
	           	<div class="col-md-10">
	           		<select class="form-control mb-2" id="destination">
		           </select>
	           	</div>
	           	<div class="col-md-2">
	           		<button type="button" class="btn rounded btn-warning" style="border-radius: 10px" id="refresh-destination"><i class="fas fa-refresh m-1"></i></button>
	           	</div>
           </div>
           <a style="text-decoration: underline" href="#"  id="btn-new-destination">Add new</a>
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


<div class="modal fade" id="add_new_destination" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Office</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="destination_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Office: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="destination">
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="btn-close-destination">Close</button>
        <button type="submit" class="btn btn-success" id="btn-add-destination">Save</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="add_new_activity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Activity</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="activity_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Activity Type: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="activity_type">
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="btn-close-activity">Close</button>
        <button type="submit" class="btn btn-success" id="btn-add-activity">Save</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="re_assign_file" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add File/Letter</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="re_assign_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Reference Number: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="re_lodgement_no" readonly>
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Name of Enquirer: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="re_name" readonly>
         </div>
         <div class="form-group mb-3" hidden="">
           <label class="col-form-label">Subject/Location:</label>
           <input class="form-control" type="text" id="re_subject">
         </div>
         <div class="form-group mb-2">
           <label class="col-form-label">Destination: <span class="text-danger">*</span></label>
           <div class="row">
	           	<div class="col-md-10">
	           		<select class="form-control mb-2" id="re_destination">
		           </select>
	           	</div>
	           	<div class="col-md-2">
	           		<button type="button" class="btn rounded btn-warning" style="border-radius: 10px" id="re-refresh-destination"><i class="fas fa-refresh m-1"></i></button>
	           	</div>
           </div>
           <a style="text-decoration: underline" href="#" id="btn-re-destination">Add new</a>
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Purpose: <span class="text-danger">*</span></label>
           <textarea class="form-control" id="re_purpose"></textarea>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="re-btn-close">Close</button>
        <button type="submit" class="btn btn-success" id="btn-re-assign">Forward</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="assign_to_officer" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Assign To Officer</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="assign_to_officer_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Reference Number: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="sc_lodgement_no" readonly>
         </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Scheduled Officer: <span class="text-danger">*</span></label>
         
         	<div class="row">
	           	<div class="col-md-10">
	           		<select class="form-control mb-2" id="officer">
	           		<option>-- select --</option>
		           </select>
	           	</div>
	           	<div class="col-md-2">
	           		<button type="button" class="btn rounded btn-warning" style="border-radius: 10px" id="refresh-officers"><i class="fas fa-refresh m-1"></i></button>
	           	</div>
           </div>
           <a style="text-decoration: underline" href="#" id="btn-add-officer-form">Add new</a>
          </div>
         <div class="form-group mb-3">
           <label class="col-form-label">Purpose: <span class="text-danger">*</span></label>
           <textarea class="form-control" id="sc_purpose"></textarea>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="sc-btn-close">Close</button>
        <button type="submit" class="btn btn-success" id="btn-sc-assign">Assign</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="add_new_officer" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Officer</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="add_new_officer_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Officer: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="officer">
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-close-officer">Close</button>
        <button type="submit" class="btn btn-success" id="btn-add-officer">Save</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="re_add_destination" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Office</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="re_destination_form" method="post">
      <div class="modal-body">
      	<div class="form-group mb-3">
           <label class="col-form-label">Office: <span class="text-danger">*</span></label>
           <input class="form-control" type="text" id="re_destination">
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="re-btn-close-destination">Close</button>
        <button type="submit" class="btn btn-success" id="re-btn-add-destination">Save</button>
      </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="file_logs" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 900px">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">File/Letter History</h5>
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form method="post">
      		<div class="row">
	      		<div class="col-md-4">
		        	<input class="form-control mb-3" readonly id="fl_lodgement_no" />
	      		</div>
	      		<div class="col-md-4">
		        	<button class="btn btn-warning ml-2" id="btn-file-logs"><i class="fas fa-refresh"></i>Load</button>
	      		</div>
      		</div>
      		<div class="card card-body">
      			<div class="tab-content mt-1">
			      <div class="table-responsive">
		              <table class="table table-fixed" id="file_logs_list">
		        		<thead>
					    <tr>
					        <th>Logs</th>
					    </tr>
					  </thead>
					  <tbody>
					    
					  </tbody>
		             </table>
			        </div>
			    </div>
      		</div>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="generate_report" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 1000px">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Generate Reports</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="mb-4">
            <input class="radio_animated" type="radio" name="search_radio" value="incoming" checked="checked"> Incoming
            <input class="radio_animated ms-5 ps-5" type="radio" name="search_radio" value="outgoing"> Outgoing
            <input class="radio_animated ms-5 ps-5" type="radio" name="search_radio" value="assigned_officer"> Schedule Officer
            <input class="radio_animated ms-5 ps-5" type="radio" name="search_radio" value="activity_type"> Activity Type
            <input class="radio_animated ms-5 ps-5" type="radio" name="search_radio" value="general_logs"> General Logs
        </div>
        
      <div id="incoming_form">
      <form id="incoming_generate_report_form" method="post">
      <div class="card card-body mt-1">
      	<div class="row">
         <div class="form-group col-4">
           <label class="col-form-label">From Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="from_date">
         </div>
         <div class="form-group col-4">
           <label class="col-form-label">To Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="to_date">
         </div>
          <div class="form-group col-4">
          	<div class="mt-4 pt-3">
          		<button type="submit" class="btn btn-success" id="btn-incoming-generate-report"><i class="fas fa-refresh mr-1"></i>Generate</button>
          	</div>
          </div>
      	</div>
      </div>
      
      <div class="card card-body mt-3">
      	<div class="tab-content mt-1">
	      <div class="table-responsive">
              <table class="table table-fixed" id="incoming_report_list">
        		<thead>
			    <tr>
			    	<th>#</th>
			    	<th>Reference No.</th>
			        <th>Received From</th>
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
	    </form>
      </div>
      
      <div id="activity_type_form">
      <form class="activity_type_generate_report_form" method="post">
      <div class="card card-body mt-1">
      	<div class="row">
      	<div class="form-group col-8">
           <label class="col-form-label">Activity Type: <span class="text-danger">*</span></label>
           <select class="form-control mb-2" id="activity_type">
           <option>-- select --</option>
           <option>Files</option>
           <option>Letters</option>
		   </select>
         </div>
         <div class="col-4"></div>
         <div class="form-group col-4">
           <label class="col-form-label">From Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="from_date">
         </div>
         <div class="form-group col-4">
           <label class="col-form-label">To Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="to_date">
         </div>
          <div class="form-group col-4">
          	<div class="mt-4 pt-3">
          		<button type="submit" class="btn btn-success" id="btn-activity-type-generate-report"><i class="fas fa-refresh mr-1"></i>Generate</button>
          	</div>
          </div>
      	</div>
      </div>
      
      <div class="card card-body mt-3">
      	<div class="tab-content mt-1">
	      <div class="table-responsive">
              <table class="table table-fixed" id="activity_type_report_list">
        		<thead>
			    <tr>
			    	<th>#</th>
			    	<th>Reference No.</th>
			        <th>Forwarded To</th>
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
	    </form>
      </div>
      
      <div id="assigned_officer_form">
      <form class="assigned_officer_generate_report_form" method="post">
      <div class="card card-body mt-1">
      	<div class="row">
      	<div class="form-group col-8">
           <label class="col-form-label">Schedule Officer: <span class="text-danger">*</span></label>
           <select class="form-control mb-2" id="gr_officer">
           <option>-- select --</option>
		   </select>
         </div>
         <div class="col-4"></div>
         <div class="form-group col-4">
           <label class="col-form-label">From Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="from_date">
         </div>
         <div class="form-group col-4">
           <label class="col-form-label">To Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="to_date">
         </div>
          <div class="form-group col-4">
          	<div class="mt-4 pt-3">
          		<button type="submit" class="btn btn-success" id="btn-assigned-officer-generate-report"><i class="fas fa-refresh mr-1"></i>Generate</button>
          	</div>
          </div>
      	</div>
      </div>
      
      <div class="card card-body mt-3">
      	<div class="tab-content mt-1">
	      <div class="table-responsive">
              <table class="table table-fixed" id="assigned_officer_report_list">
        		<thead>
			    <tr>
			    	<th>#</th>
			    	<th>Reference No.</th>
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
	    </form>
      </div>
      
      <div id="outgoing_form">
      <form class="outgoing_generate_report_form" method="post">
      <div class="card card-body mt-1">
      	<div class="row">
      	<div class="form-group col-8">
           <label class="col-form-label">Destination: <span class="text-danger">*</span></label>
           <select class="form-control mb-2" id="gr_destination">
		   </select>
         </div>
         <div class="col-4"></div>
         <div class="form-group col-4">
           <label class="col-form-label">From Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="from_date">
         </div>
         <div class="form-group col-4">
           <label class="col-form-label">To Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="to_date">
         </div>
          <div class="form-group col-4">
          	<div class="mt-4 pt-3">
          		<button type="submit" class="btn btn-success" id="btn-outgoing-generate-report"><i class="fas fa-refresh mr-1"></i>Generate</button>
          	</div>
          </div>
      	</div>
      </div>
      
      <div class="card card-body mt-3">
      	<div class="tab-content mt-1">
	      <div class="table-responsive">
              <table class="table table-fixed" id="outgoing_report_list">
        		<thead>
			    <tr>
			    	<th>#</th>
			    	<th>Reference No.</th>
			        <th>Forwarded To</th>
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
	    </form>
      </div>
      
      <div id="general_logs_form">
      <form class="generate_report_form" method="post">
      <div class="card card-body mt-1">
      	<div class="row">
         <div class="form-group col-4">
           <label class="col-form-label">From Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="from_date">
         </div>
         <div class="form-group col-4">
           <label class="col-form-label">To Date: <span class="text-danger">*</span></label>
           <input class="form-control" type="date" id="to_date">
         </div>
          <div class="form-group col-4">
          	<div class="mt-4 pt-3">
          		<button type="submit" class="btn btn-success" id="btn-generate-report"><i class="fas fa-refresh mr-1"></i>Generate</button>
          	</div>
          </div>
      	</div>
      </div>
      
      <div class="card card-body mt-3">
      	<div class="tab-content mt-1">
	      <div class="table-responsive">
              <table class="table table-fixed" id="report_list">
        		<thead>
			    <tr>
			    	<th>#</th>
			        <th>Logs [<span>From: <small><span id="from_date_id"></span></small></span> - <span>To: <small><span id="to_date_id"></span></small></span>]</th>
			    </tr>
			  </thead>
			  <tbody style="max-width: 100%">
			  </tbody>
             </table>
	        </div>
	    </div>
	    </div>
	    </form>
      </div>
      
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="return_file" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Confirmation</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="return_file_form" method="post">
      <div class="modal-body">
         <div class="form-group mb-3" hidden="">
           <input class="form-control" type="text" id="rs_lodgement_no">
         </div>
      		Are you sure you want to return file?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="rs-btn-close">Close</button>
        <button type="submit" class="btn btn-success" id="btn-return">Return</button>
      </div>
      </form>
    </div>
  </div>
</div>