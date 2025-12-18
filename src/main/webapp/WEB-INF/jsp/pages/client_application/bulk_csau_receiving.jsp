<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  
 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
           
          <div class="row">
	        <div class="col">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header h3">
	              Search Section</div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form id="frmEnquiryJobSearch"  method="post">
					  <div class="form-group">
					  	
					  		<label><b>Search By: </b></label>
					  	
					  </div>
					  
					    <div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
						  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
						</div>

						
					  <br><br>
			          
					 
					 
					  <div class="form-group">
			            <div class="form-row">
			            
			              <div class="col-md-8">
			                
			                <input class="form-control" id="enq_search_value"  name="enq_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
			                
			              </div>
			            </div>
			          </div>


			        </form>
	            
	            <!-- The form Ends Hers -->

				<div class="alert alert-danger d-none" id="enquiry_alert" role="alert">
					No Results Found
				  </div>
	
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
        
	      	<!--   Here is the right Table -->
	        <div class="col-sm-6">
	          <!-- Example Pie Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header h3">
	              Depositor's Details</div>
	            <div class="card-body">
	            
	            	<form id="frmEnquiryBatchlist"  method="post">
						<!-- <h5 class="border-bottom border-gray pb-2">Details Confirmation</h5> -->
						<div class="form-group row">
							<div class="col">
								<input type="text"  required class="form-control" id="bcd_depositor_by" placeholder="Enter Depositor's Name">
						
							</div>
							
						 </div>


						 <div class="form-group row">
						  
							<div class="col">
							
						
							
									<select id="bcd_depositor_id_type" required  class="form-control" >
										<option value="" selected disabled>--Select ID Type--</option>
										<option value="NATIONAL ID">NATIONAL ID</option>
										<option value="PASSPORT">PASSPORT</option>
										<option value="DRIVERS LICENSE">DRIVERS LICENSE</option>
										<option value="NHIS CARD">NHIS CARD</option>
										<option value="VOTERS ID">VOTERS ID</option>
										<option value="SSNIT ID CARD">SSNIT ID CARD</option>
									</select>
								
							</div>

							<div class="col">
								  <input type="text" required  class="form-control" id="bcd_depositor_id_number" placeholder="Enter ID Number">
								
							</div>

						 </div>
						
						 <div class="form-group row">

							<div class="col">
								
								  <input type="text" required  class="form-control" id="bcd_depositor_phone_number" placeholder="Enter Phone Number">
								
							</div>

                            <div class="col">
								<input type="text" required  class="form-control" id="bcd_depositor_email" placeholder="Enter Email">
                              
                            </div>
						  
						 </div>

                         <div class="form-group row">

                            <div class="col">
								
                                <select class="form-control selectpicker " id="bcd_submission_type" name="res_bill_type">
                                    <option value="" selected disabled>-- Select Re-Submission Type --</option>
                                   
                                    <option value="First Time Hard Copy Submission">First Time Hard Copy Submission</option>
                                    <option value="Resolved Query">Resolved Query</option>
                                    <option value="Payment">Payment</option>
                                    <option value="Correction">Correction</option>
									<option value="No Payment Details">No Payment Details</option>
									<option value="Re-assessment">Re-assessment</option>
                                    <option value="Other">Other</option>
                               
                                    
                                 </select>
                              
                            </div>
						  
						 </div>

             <!-- <div class="form-group row">

                              <div class="col">
                  
                                  <select class="form-control selectpicker " id="txt_general_job_purpose" name="txt_general_job_purpose">
                                      <option value="" selected disabled>-- Select Purpose --</option>
                                    
                                      <option value="Re-submission">Re-submission</option>
                                
                                      
                                  </select>
                                
                              </div>

                </div> -->

                         <div class="form-group row">
                            <div class="col">
								
                                <button type="button" class="btn btn-primary btn-block" value="Search" id="btnBatchBulkReceiving" > Process List </button>
                              
                            </div>
                            
                        </div>
			         
			        </form>
	            
	          </div>
	        </div>
	      <!--   Here is the end of right table -->
      
      
   
      </div>
       
      	  </div>
    
    
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3" style="display:none" id="enq-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results (The result is only 10 records)</div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="tbl-bulk-receiving-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <th>Case Number</th>
			                  <th>Job Number</th>
							  <th>Application Type</th>
			                  <th>GLPIN</th>
			                  
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  
			                <th>Actions</th>
			                  
			                  
			                
			                 </tr>
			              </thead>
			              
			              <tbody>
			               	
			                              
						     
			              </tbody> 
			            </table>
	          	</div>
             
              <!--  End Of Table -->
             </div>
            <!-- <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
          
     <!-- Example Bar Chart Card-->
          
        
    
       </div>
        
      </div>
     </div>
     
     
    
 </div>
 
 
 <!-- <div class="modal fade" id="batch_purpose" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h6 class="modal-title" id="exampleModalLabel">ADD PURPOSE</h6>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        
        <div class="modal-body">
           <div class="form-group mb-3">
             <label class="col-form-label">Purpose: <span class="text-danger">*</span></label>
             <textarea class="form-control" rows="7" id="txt_general_job_purpose"></textarea>
           </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btn-close">Close</button>
          <button type="submit" class="btn btn-success" id="btnBatchBulkReceiving">Confirm</button>
        </div>
      
      </div>
    </div>
  </div> -->


  <!-- <div class="modal fade" id="viewBatchlistModal" tabindex="-1"
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
										${unit_name == "CSAU" ? "<a class='btn btn-secondary btn-sm notActive' data-toggle='batch_type' data-title='Cabinet'><h6>Cabinet</h6></a>" : ""}
										
										
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
		                              <input class="form-control" type="text" value="${unit_name}" id="division_to_send_to" readonly>
		                           </div>
		                           <div class="col-sm-9">
		                              <label for="" class="col-form-label text-light">User :</label>
		                              
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
                        <table id="batchlistdataTable" class="table table-bordered table-hover">
                        	<tr>
		                        <th>Reference No.</th>
		                        <th>Application Name</th>
		                        <th>Location</th>
		                        <th>Purpose</th>
		                        <th class="text-center">Action</th>
		                    </tr>
                        </table>
                  </div>
               </div>
               <br/> <br/> <br/>
               <div class="modal-footer">
               		<button type="button" class="btn btn-danger float-left  mr-auto" id="remove_all_from_list" onclick="remove_all_from_list();">Remove all from list</button>
               	
                  <button type="button" class="btn btn-secondary" id="btn_close_process"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_batchlist_ft"  class="btn btn-primary" style="display:none">Process Batch List</button>
               </div>
            
         </div>
      </div>
   </div>
</div> -->

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>


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