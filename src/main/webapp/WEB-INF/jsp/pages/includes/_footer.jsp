<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


</div>
<!-- Footer -->
<footer class="sticky-footer bg-white">
	<div class="container my-auto">
		<div class="copyright text-center my-auto">
			<!-- <button id="clickbutton">chrome</button> -->
			<span>Copyright &copy; Lands Commission <span id="footer_copyright_year"> <script type="text/javascript">document.write( new Date().getFullYear() );</script></span></span>
		</div>
	</div>
</footer>
<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary"
					href="${pageContext.request.contextPath}/Logout"
					onclick="doLogoutClearing()">Logout</a>
			</div>
			<input id="val_fullname" value="${fullname}" type="hidden">
		</div>
	</div>
</div>


<div class="modal fade" id="queriedNotificationModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header bg-danger">
				<h5 class="modal-title" id="exampleModalLabel">Notification</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<ul id="queried_list"></ul>
				</div>
			</div>
			<!-- <div class="modal-footer">
			</div> -->
		</div>
	</div>
</div>


<!-- Bootstrap core JavaScript-->
<script>
document.getElementById("footer_copyright_year").innerText=(new Date().getFullYear());

window.doLogoutClearing = function doLogoutClearing(){
	 localStorage.clear();
}
window.convertStringToNumber = function convertStringToNumber(currency){ 
	    var k, temp; 
	    // Loop to make substring
	    for(var i = 0; i < currency.length; i++){ 
	          
	        // Getting Unicode value
	        k = currency.charCodeAt(i); 
	          
	        // Checking whether the character
	        // is of numeric type or not
	        if(k > 47 && k < 58){ 
	              
	            // Making substring
	            temp = currency.substring(i); 
	            break; 
	        } 
	    } 
	    temp = temp.replace(/, /, ''); 
	    return parseFloat(temp);    
	} 

window.addFileToList = function addFileToList(job_number,ar_name,business_process_sub_name,locality){
	 var obj = {
			'Job Number': job_number,
			'Applicant Name ': ar_name,
			'Application Type' : business_process_sub_name,
			'Locality' : locality
		};
	var existing = localStorage.getItem('fileBatchingListData');
		existing = existing ? JSON.parse(existing) : {};
		existing[job_number] = obj;
		localStorage.setItem('fileBatchingListData', JSON.stringify(existing));
        prepareFileBatchingModal();
}

window.addRequestToList = function addRequestToList(job_number,ar_name,business_process_sub_name,locality,job_purpose,remarks){
	 var obj = {
			'Job Number': job_number,
			'Applicant Name ': ar_name,
			'Application Type' : business_process_sub_name,
			'Locality' : locality,
			'Purpose' : job_purpose,
			'Remarks' : remarks
		};

		console.log(obj)

	var existing = localStorage.getItem('requestBatchingListData');
		existing = existing ? JSON.parse(existing) : {};
		existing[job_number] = obj;
		localStorage.setItem('requestBatchingListData', JSON.stringify(existing));
		//console.log(existing)
        prepareRequestBatchingModal();
}


window.addArchiveToList = function addArchiveToList(job_number, ar_name, business_process_sub_name, locality, job_purpose, remarks) {
    var obj = {
        'Job Number': job_number,
        'Applicant Name': ar_name,
        'Application Type': business_process_sub_name,
        'Locality': locality,
        'Purpose': job_purpose,
        'Remarks': remarks
    };

    var existing = localStorage.getItem('requestArchiveListData');
    existing = existing ? JSON.parse(existing) : [];

    existing.push(obj); // Add new entry without overwriting duplicates
    localStorage.setItem('requestArchiveListData', JSON.stringify(existing));

    prepareRequestArchiveModal(); // Refresh table
};

window.removeJobFileBatchingList = function removeJobFileBatchingList(job_number){
		 // alert(job_number)
		var existing = localStorage.getItem('fileBatchingListData');
		existing = existing ? JSON.parse(existing) : []
		delete existing[job_number];
		localStorage.setItem('fileBatchingListData', JSON.stringify(existing));
		prepareFileBatchingModal();
}

window.removeRequestBatchingList = function removeRequestBatchingList(job_number){
		// alert(job_number)
	var existing = localStorage.getItem('requestBatchingListData');
	existing = existing ? JSON.parse(existing) : []
	delete existing[job_number];
	localStorage.setItem('requestBatchingListData', JSON.stringify(existing));
	prepareRequestBatchingModal();
}


window.removeRequestArchiveList = function removeRequestArchiveList(job_number){
		// alert(job_number)
	var existing = localStorage.getItem('requestArchiveListData');
	existing = existing ? JSON.parse(existing) : []
	delete existing[job_number];
	localStorage.setItem('requestArchiveListData', JSON.stringify(existing));
	prepareRequestArchiveModal();
}

window.prepareFileBatchingModal = function prepareFileBatchingModal(){
	 
	 var existing = localStorage.getItem('fileBatchingListData');
		
          if(existing !== (existing.length < 3) ){	 
       	   existing = existing ? JSON.parse(existing) : "No Application in list";
          		var wholeArray = null;
       		var wholeArray = Object.keys(existing).map(key => existing[key]);
            function constructTable(selector,list) { 
	    			// Getting the all column names
    			var cols = Headers(list, selector); 
    			// Traversing the JSON data
    			for (var i = 0; i < list.length; i++) { 
    				var row = $('<tr/>'); 
    				for (var colIndex = 0; colIndex < cols.length; colIndex++) 
    				{ 
    					var val = list[i][cols[colIndex]]; 
    					// If there is any key, which is matching
    					// with the column name
    					if (val == null) val = ""; 
   						row.append($('<td/>').html(val)); 
   						if(colIndex == cols.length - 1){
   							row.append('<td><button type="button" onclick="removeJobFileBatchingList(\'' + list[i][cols[colIndex -3]] +'\')" class="btn btn-danger" >Remove</button></td>');
   						}
    				} 
    				// Adding each row to the table
    				$(selector).append(row); 
    			} 
    		} 
   		
    		function Headers(list, selector) { 
    			$(selector).empty();
    			var columns = []; 
    			var header = $('<tr/>'); 
    			for (var i = 0; i < list.length; i++) { 
    				var row = list[i]; 
    				for (var k in row) { 
    					if ($.inArray(k, columns) == -1) { 
    						columns.push(k); 
    						// Creating the header
    						header.append($('<th/>').html(k)); 
    					} 
    				} 
    			} 
    			// Appending the header to the table
    			$(selector).append(header); 
    			return columns; 
    		}	
            
    		constructTable('#FileListdataTable',wholeArray);
    		$('#viewFileListModal').modal('show');
    		$('#viewFileListModal').modal('handleUpdate')
    		
       	
          }else{
       	   
       	  $('#viewFileListModal').modal('toggle');
       	 alert("No batchlist created");
          }
}

window.prepareRequestBatchingModal = function prepareRequestBatchingModal(){
	 
	 var existing = localStorage.getItem('requestBatchingListData');

	//console.log('jkegdnejgjkerknjnekrwjkjer')
		
          if(existing !== (existing.length < 3) ){	 
       	   existing = existing ? JSON.parse(existing) : "No Application in list";
          		var wholeArray = null;
       		var wholeArray = Object.keys(existing).map(key => existing[key]);
            function constructTable(selector,list) { 
	    			// Getting the all column names
    			var cols = Headers(list, selector); 
    			// Traversing the JSON data
    			for (var i = 0; i < list.length; i++) { 
    				var row = $('<tr/>'); 
    				for (var colIndex = 0; colIndex < cols.length; colIndex++) 
    				{ 
    					var val = list[i][cols[colIndex]]; 
    					// If there is any key, which is matching
    					// with the column name
    					if (val == null) val = ""; 
   						row.append($('<td/>').html(val)); 
   						if(colIndex == cols.length - 1){
   							row.append('<td><button type="button" onclick="removeRequestBatchingList(\'' + list[i][cols[colIndex -5]] +'\')" class="btn btn-danger" >Remove</button></td>');
   						}
    				} 
    				// Adding each row to the table
    				$(selector).append(row); 
    			} 
    		} 
   		
    		function Headers(list, selector) { 
    			$(selector).empty();
    			var columns = []; 
    			var header = $('<tr/>'); 
    			for (var i = 0; i < list.length; i++) { 
    				var row = list[i]; 
    				for (var k in row) { 
    					if ($.inArray(k, columns) == -1) { 
    						columns.push(k); 
    						// Creating the header
    						header.append($('<th/>').html(k)); 
    					} 
    				} 
    			} 
    			// Appending the header to the table
    			$(selector).append(header); 
    			return columns; 
    		}	
            
    		constructTable('#FileListdataTable',wholeArray);
    		$('#viewFileListModal').modal('show');
    		$('#viewFileListModal').modal('handleUpdate')
    		
       	
          }else{
       	   
       	  $('#viewFileListModal').modal('toggle');
       	 alert("No batchlist created");
          }
}


window.prepareRequestArchiveModal = function prepareRequestArchiveModal(){
	 
	 var existing = localStorage.getItem('requestArchiveListData');

	//console.log('jkegdnejgjkerknjnekrwjkjer')
		
          if(existing !== (existing.length < 3) ){	 
       	   existing = existing ? JSON.parse(existing) : "No Application in list";
          		var wholeArray = null;
       		var wholeArray = Object.keys(existing).map(key => existing[key]);
            function constructTable(selector,list) { 
	    			// Getting the all column names
    			var cols = Headers(list, selector); 
    			// Traversing the JSON data
    			for (var i = 0; i < list.length; i++) { 
    				var row = $('<tr/>'); 
    				for (var colIndex = 0; colIndex < cols.length; colIndex++) 
    				{ 
    					var val = list[i][cols[colIndex]]; 
    					// If there is any key, which is matching
    					// with the column name
    					if (val == null) val = ""; 
   						row.append($('<td/>').html(val)); 
   						if(colIndex == cols.length - 1){
   							row.append('<td><button type="button" onclick="removeRequestArchiveList(\'' + list[i][cols[colIndex -5]] +'\')" class="btn btn-danger" >Remove</button></td>');
   						}
    				} 
    				// Adding each row to the table
    				$(selector).append(row); 
    			} 
    		} 
   		
    		function Headers(list, selector) { 
    			$(selector).empty();
    			var columns = []; 
    			var header = $('<tr/>'); 
    			for (var i = 0; i < list.length; i++) { 
    				var row = list[i]; 
    				for (var k in row) { 
    					if ($.inArray(k, columns) == -1) { 
    						columns.push(k); 
    						// Creating the header
    						header.append($('<th/>').html(k)); 
    					} 
    				} 
    			} 
    			// Appending the header to the table
    			$(selector).append(header); 
    			return columns; 
    		}	
            
    		constructTable('#ArchiveListdataTable',wholeArray);
    		$('#viewArchiveListModal').modal('show');
    		$('#viewArchiveListModal').modal('handleUpdate')
    		
       	
          }else{
       	   
       	  $('#viewArchiveListModal').modal('toggle');
       	 alert("No batchlist created");
          }
}


window.addJobToCompletedQueriedList = function addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose){
	 var obj = {
		'Job Number': job_number,
		'Applicant Name ': ar_name,
		'Application Type' : business_process_sub_name,
		'Status' : job_purpose
	};
	
	var existing = localStorage.getItem('completedQueriedListData');
	existing = existing ? JSON.parse(existing) : {};
	existing[job_number] = obj;
	localStorage.setItem('completedQueriedListData', JSON.stringify(existing));
	prepareCompletedQueriedModal();
}

window.removeJobFromCompletedQueriedList = function removeJobFromCompletedQueriedList(job_number){
		// alert(job_number)
	var existing = localStorage.getItem('completedQueriedListData');
	existing = existing ? JSON.parse(existing) : []
	delete existing[job_number];
	localStorage.setItem('completedQueriedListData', JSON.stringify(existing));
	prepareCompletedQueriedModal();
}

window.prepareCompletedQueriedModal = function prepareCompletedQueriedModal(){
	 
	 var existing = localStorage.getItem('completedQueriedListData');
		
          if(existing !== (existing.length < 3) ){	 
       	   existing = existing ? JSON.parse(existing) : "No Application in list";
          		var wholeArray = null;
       		var wholeArray = Object.keys(existing).map(key => existing[key]);
            function constructTable(selector,list) { 
	    			// Getting the all column names
    			var cols = Headers(list, selector); 
    			// Traversing the JSON data
    			for (var i = 0; i < list.length; i++) { 
    				var row = $('<tr/>'); 
    				for (var colIndex = 0; colIndex < cols.length; colIndex++) 
    				{ 
    					var val = list[i][cols[colIndex]]; 
    					// If there is any key, which is matching
    					// with the column name
    					if (val == null) val = ""; 
   						row.append($('<td/>').html(val)); 
   						if(colIndex == cols.length - 1){
   							row.append('<td><button type="button" onclick="removeJobFromCompletedQueriedList(\'' + list[i][cols[colIndex -3]] +'\')" class="btn btn-danger" >Remove</button></td>');
   						}
    				} 
    				// Adding each row to the table
    				$(selector).append(row); 
    			} 
    		} 
   		
    		function Headers(list, selector) { 
    			$(selector).empty();
    			var columns = []; 
    			var header = $('<tr/>'); 
    			for (var i = 0; i < list.length; i++) { 
    				var row = list[i]; 
    				for (var k in row) { 
    					if ($.inArray(k, columns) == -1) { 
    						columns.push(k); 
    						// Creating the header
    						header.append($('<th/>').html(k)); 
    					} 
    				} 
    			} 
    			// Appending the header to the table
    			$(selector).append(header); 
    			return columns; 
    		}	
            
    		constructTable('#completedQueriedListdataTable',wholeArray);
    		$('#viewCompletedQueriedModal').modal('show');
    		$('#viewCompletedQueriedModal').modal('handleUpdate')
    		
       	
          }else{
       	   
       	  $('#viewCompletedQueriedModal').modal('toggle');
       	 alert("No batchlist created");
          }
			 
		// console.log(JSON.stringify(existing));
}



window.addJobToBatchlist = function addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,remarks_notes){
	 var obj = {
			'Job Number': job_number,
			'Applicant Name ': ar_name,
			'Application Type' : business_process_sub_name,
			'Batching Purpose' : job_purpose,
			'Remarks/Notes' : remarks_notes
		};

	var existing = localStorage.getItem('batchlistdata');
		existing = existing ? JSON.parse(existing) : {};
		existing[job_number] = obj;
		localStorage.setItem('batchlistdata', JSON.stringify(existing));
			    prepareBatchlistModal();
}

	window.removeJobFromBatchlist = function removeJobFromBatchlist(job_number){
		 // alert(job_number)
		var existing = localStorage.getItem('batchlistdata');
		//console.log(existing)
		existing = existing ? JSON.parse(existing) : []
		delete existing[job_number];
		localStorage.setItem('batchlistdata', JSON.stringify(existing));
		prepareBatchlistModal();
	}
  
	
	window.prepareBatchlistModal = function prepareBatchlistModal(){
   	 
   	 var existing = localStorage.getItem('batchlistdata');
           if(existing !== (existing.length < 3) ){	 
        	   existing = existing ? JSON.parse(existing) : "No Application in batch list";
           		var wholeArray = null;
        		var wholeArray = Object.keys(existing).map(key => existing[key]);
	            function constructTable(selector,list) { 
 	    			// Getting the all column names
	    			var cols = Headers(list, selector); 
	    			// Traversing the JSON data
	    			for (var i = 0; i < list.length; i++) { 
	    				var row = $('<tr/>'); 
	    				for (var colIndex = 0; colIndex < cols.length; colIndex++) 
	    				{ 
	    					var val = list[i][cols[colIndex]]; 
	    					// If there is any key, which is matching
	    					// with the column name
	    					if (val == null) val = ""; 
    						row.append($('<td/>').html(val)); 
    						if(colIndex == cols.length - 1){
    							row.append('<td><button type="button" onclick="removeJobFromBatchlist(\'' + list[i][cols[colIndex -4]] +'\')" class="btn btn-danger" >Remove</button></td>');
    						}
	    				} 
	    				// Adding each row to the table
	    				$(selector).append(row); 
	    			} 
	    		} 
    		
	    		function Headers(list, selector) { 
	    			$(selector).empty();
	    			var columns = []; 
	    			var header = $('<tr/>'); 
	    			for (var i = 0; i < list.length; i++) { 
	    				var row = list[i]; 
	    				for (var k in row) { 
	    					if ($.inArray(k, columns) == -1) { 
	    						columns.push(k); 
	    						// Creating the header
	    						header.append($('<th/>').html(k)); 
	    					} 
	    				} 
	    			} 
	    			// Appending the header to the table
	    			$(selector).append(header); 
	    			return columns; 
	    		}	
                
	    		constructTable('#batchlistdataTable',wholeArray);
	    		$('#viewBatchlistModal').modal('show');
	    		$('#viewBatchlistModal').modal('handleUpdate')

	    		
           	
           }else{
        	   
        	  $('#viewBatchlistModal').modal('toggle');
        	 alert("No batchlist created");
           }
    }


    $(document).ready(function(){
    	
    	$("#clickbutton").on("click", function(){
			console.log("ajaxStop");
		}); 
    	
    	$('.modal-dialog').draggable({
    	      handle: ".modal-header"
    	    });
    	
    	$('#my-summernote, #lc_search_report_summary_details_dcs, #lc_search_report_summary_details, #lc_search_report_summary_details_2, #lc_search_report_summary_details_3, #lc_search_report_summary_details_4,  #lc_search_report_summary_details_final, #lc_letter_template_description, #lc_search_report_summary_details_cs').summernote({
    		  minHeight: 400,
    		  placeholder: 'Write here ...',
    		  focus: false,
    		  airMode: false,
    		  fontName: 'Times New Roman',
    		  fontNames: ['Times New Roman'],
    		  dialogsInBody: true,
    		  dialogsFade: true,
    		  disableDragAndDrop: false,
    		  toolbar: [
    		    //[groupName, [list of button]],
    		    ['style', ['bold', 'italic', 'underline', 'clear']],
				['fontname', ['fontname']],
    		    ['color', ['color']],
    		    ['para', ['style', 'ul', 'ol', 'paragraph']],
    		    ['fontsize', ['fontsize']],
    		    ['font', ['strikethrough', 'superscript', 'subscript']],
    		    ['height', ['height']],
    		    ['misc', ['undo', 'redo', 'print', 'help', 'fullscreen']]
    		  ],
    		  popover: {
    		    air: [
    		      ['color', ['color']],
    		      ['font', ['bold', 'underline', 'clear']]
    		    ]
    		  },
    		  print: {
    		    //'stylesheetUrl': 'url_of_stylesheet_for_printing'
    		  }
    		}); 
    	
    		 $(document).ajaxSend(function(e, xhr) {
         		var url = 'Case_Management_Serv_session';
     	    	var data = {"request_type": "check_session_expired"};

     	    	fetch(url, {
     	    	  method: 'GET', // or 'PUT'
     	    	  headers:{
     	    	    'Content-Type': 'application/json'
     	    	  }
     	    	}).then(res => res.text() )
     	    	.then(response => {
     	    		//console.log(JSON.stringify(response));
     	    		if( JSON.stringify(response).includes("true")){
     	    			//doo nothing
     	    			//console.log("true" + xhr);
     	    			//xhr.abort();
     	    		}else{
     	    			//redirect to login page
     	    			xhr.abort();
     	    			$("#general_message_dialog").modal();
     					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
     					$('#general_message_dialog #general_message_dialog_msg_new').val("Sorry pls! Your session expired");
     					doLogoutClearing();
     					window.location.replace("Logout");
     	    		}
     	    	
     	    	})
     	    	.catch(error => console.error('Error:', error)); 
    			 
    			});
    		$( document ).ajaxStart(function() {
    			// Statement
    			spinHandle = loadingOverlay().activate();
        		//console.log("ajaxStarted");
        		
    		});
    	
    		$( document ).ajaxStop(function(){
    			//console.log("ajaxStop");
    			loadingOverlay().cancel(spinHandle);
    		
    		});
    		
    		$( document ).ajaxComplete(function(){
    			loadingOverlay().cancel(spinHandle);
    			//console.log("ajaxComplete");
    		
    		});
    		$( document ).ajaxSuccess(function(){
    			//console.log("ajaxComplete");
    			loadingOverlay().cancel(spinHandle);
    			
    		});
    		
    		
    		$( document ).ajaxError(function(){
    			//console.log("ajaxError");
    			loadingOverlay().cancel(spinHandle);
    			
    		});
    	
         
        	$("#btnnewmilestonesearch").click(function(event){
        		 var job_number = $("#job_number").val();
        		
				  var table = $('#milestonedataTable');
				    table.find("tbody tr").remove();
				    $.ajax({
						 type: "POST",
						 url: "Case_Management_Serv",
						 data: {
			                	request_type: 'select_load_details_for_batching',
			                	job_number:job_number},
						 cache: false,
						 success: function(jobdetails) {
							
							 var json_p = JSON.parse(jobdetails);
				              $(json_p.milestones).each(function () {
     
								    table.append("<tr><td>" + this.milestone_description + "</td><td>" +this.ms_id + "</td>"
								    			 
								    		  +  '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#modalrecordinformation" data-target-id="' + this.ms_id + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
								    		   
								    		    + "</tr>");
							        
				              });
							    
						 }
						 });
				    
			});
        	
         $("#edit").on("show.bs.modal", function(e) {
             var job_number = $(e.relatedTarget).data('target-id');
             console.log(job_number)
             showSuggestions(job_number);
              $('#edit #job_numnber').val(job_number);
              
              });
         
         
         $("#addlrdtransaction").on("show.bs.modal", function(e) {
	            var gid = $(e.relatedTarget).data('target-id');
	         
	              $('#addlrdtransaction #lrd_td_fid_id_fk').val([]);
			    	$('#addlrdtransaction #lrd_td_gid').val([]);
			    	 $('#addlrdtransaction #lrd_td_plotted_by_reg').val([]);
			    	 $('#addlrdtransaction #lrd_td_checked_by').val([]);
			    	 $('#addlrdtransaction #lrd_td_plott_date_reg').val([]);
			    	 $('#addlrdtransaction #lrd_td_certicate_number').val([]);
			    	  $('#addlrdtransaction #nature_of_instument').val([]);
				    	 $('#addlrdtransaction #applicant_name').val([]);
				    	 $('#addlrdtransaction #plan_number').val([]);
				    	 $('#addlrdtransaction #lrd_td_type_instrument').val([]);
				    	 $('#addlrdtransaction #lrd_td_date_of_instument').val([]);
				    	 $('#addlrdtransaction #lrd_td_consideration').val([]);
				    	 $('#addlrdtransaction #lrd_td_purpose').val([]);
				    	 $('#addlrdtransaction #lrd_td_date_commencement').val([]);
				    	 $('#addlrdtransaction #lrd_td_term').val([]);
				    	 $('#addlrdtransaction #lrd_td_remarks').val([]);
				    	 $('#addlrdtransaction #lrd_td_type_of_registration').val([]);
				    	 $('#addlrdtransaction #lrd_td_encumbrance').val([]);
				    	 $('#addlrdtransaction #lrd_td_checked_by').val([]);
			    	 $('#addlrdtransaction #lrd_td_date_of_registration').val([]);
			    	 $('#addlrdtransaction #lrd_td_volume').val([]);
			    	 $('#addlrdtransaction #lrd_td_folio').val([]);
			    	 $('#addlrdtransaction #lrd_td_date_of_issued_cert_no').val([]);
			    	 $('#addlrdtransaction #lrd_td_type_of_certificate').val([]);
			    	 $('#addlrdtransaction #lrd_td_registered_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_cc_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_certicate_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_registered_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_cc_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_grantor_name').val([]);
			    	 $('#addlrdtransaction #lrd_td_job_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_reference_number').val([]);
			    	 $('#addlrdtransaction #lrd_td_land_size').val([]);
			    	 $('#addlrdtransaction #lrd_td_modified_by').val([]);
			    	 $('#addlrdtransaction #lrd_td_modified_by').val([]);

		    	 var today = new Date();
		    	 var dd = String(today.getDate()).padStart(2, '0');
		    	 var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		    	 var yyyy = today.getFullYear();

		    	 today = mm + '/' + dd + '/' + yyyy;
	              
	              if (gid){
	            	  $('#addlrdtransaction #lrd_td_fid_id_fk').val($('#lrd_ps_fid').val());
		 		    	 $('#addlrdtransaction #lrd_td_gid').val(gid);
		 		    	 $('#addlrdtransaction #lrd_td_plotted_by_reg').val(localStorage.getItem('fullname'));
		 		    	 $('#addlrdtransaction #lrd_td_checked_by').val(localStorage.getItem('fullname'));
		 		    	 $('#addlrdtransaction #lrd_td_plott_date_reg').val(today);
		 		    	// $('#addlrdtransaction #lrd_td_job_numnber').val(job_number);
		 		    	 $('#addlrdtransaction #lrd_td_reference_number').val($('#lrd_ps_reference_number').val());
		 		    	 
		 		   	 $.ajax({
						 type: "POST",
						 url: 'Maps',
						 data: {
			                	request_type: 'load_lrd_transaction_details_by_gid',
			                	gid : gid
			                	},
						 cache: false,
						 beforeSend: function () {
							// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
						 },
						 success: function(serviceresponse) {
							
							 var json_p = JSON.parse(serviceresponse);
						console.log(json_p)
											
						
						 $(json_p.data).each(function () {
						        
					    	  $('#addlrdtransaction #lrd_td_nature_of_instument').val( this.nature_of_instument);
						    	 $('#addlrdtransaction #lrd_td_applicant_name').val( this.applicant_name);
						    	 $('#addlrdtransaction #lrd_td_plan_number').val( this.plan_number);
					          
					          
					     	 
						    	 $('#addlrdtransaction #lrd_td_type_instrument').val( this.type_instrument);
						    	 $('#addlrdtransaction #lrd_td_date_of_instument').val( this.date_of_instument);
						    	 $('#addlrdtransaction #lrd_td_consideration').val( this.consideration);
						    	 $('#addlrdtransaction #lrd_td_purpose').val( this.purpose);
						    	 $('#addlrdtransaction #lrd_td_date_commencement').val( this.date_commencement);
						    	 $('#addlrdtransaction #lrd_td_term').val( this.term);
				              
						    	 
						    	 $('#addlrdtransaction #lrd_td_remarks').val( this.remarks);
						    	 $('#addlrdtransaction #lrd_td_type_of_registration').val( this.type_of_registration);
						    	 $('#addlrdtransaction #lrd_td_encumbrance').val( this.encumbrance);
						    	 $('#addlrdtransaction #lrd_td_checked_by').val( this.checked_by);

					    	 $('#addlrdtransaction #lrd_td_date_of_registration').val( this.date_of_registration);
					    	 $('#addlrdtransaction #lrd_td_volume').val( this.volume);
					    	 $('#addlrdtransaction #lrd_td_folio').val( this.folio);
					    	 $('#addlrdtransaction #lrd_td_date_of_issued_cert_no').val( this.date_of_issued_cert_no);
					    	 $('#addlrdtransaction #lrd_td_type_of_certificate').val( this.type_of_certificate);
					    	 $('#addlrdtransaction #lrd_td_registered_number').val( this.registered_number);
			              
					    	 
					    	 
					    	 $('#addlrdtransaction #lrd_td_cc_number').val( this.cc_number);
					    	 $('#addlrdtransaction #lrd_td_certicate_number').val( this.certicate_number);
					    	 $('#addlrdtransaction #lrd_td_registered_number').val( this.registered_number);
					    	 $('#addlrdtransaction #lrd_td_cc_number').val( this.cc_number);
					    	 $('#addlrdtransaction #lrd_td_grantor_name').val( this.grantor_name);
					    	 $('#addlrdtransaction #lrd_td_job_number').val( this.job_number);
					    	 $('#addlrdtransaction #lrd_td_reference_number').val( this.reference_number);
					    	 
					    	 $('#addlrdtransaction #lrd_td_land_size').val(this.land_size);
					    	 
					    	 
					    	 $('#addlrdtransaction #lrd_td_modified_by').val(this.modified_by);
					    	 $('#addlrdtransaction #lrd_td_modified_date').val(this.modified_date);
					    	
					    
							 
							 
						         });

						 }
						 });
   					 
	 	
	              }else{
	            	  //console.log('addlrdtransaction loading ' + 'not valid ')
	            		 $('#addlrdtransaction #lrd_td_fid_id_fk').val($('#lrd_ps_fid').val());
		 		    	 $('#addlrdtransaction #lrd_td_gid').val('0');
		 		    	 $('#addlrdtransaction #lrd_td_plotted_by_reg').val(localStorage.getItem('fullname'));
		 		    	 $('#addlrdtransaction #lrd_td_checked_by').val(localStorage.getItem('fullname'));
		 		    	 $('#addlrdtransaction #lrd_td_plott_date_reg').val(today);
		 		    	// $('#addlrdtransaction #lrd_td_job_numnber').val(job_number);
		 		    	 $('#addlrdtransaction #lrd_td_reference_number').val($('#lrd_ps_reference_number').val());
		 		    	 
	              }
	              
		    	 
	              });
         
         
 		$('#btn_save_lrd_transaction')
		.on(
				'click',
				function(e) {

					//console.log('Assiamah');

					var fid_id_fk = document.getElementById("lrd_td_fid_id_fk").value;
					var gid = document.getElementById("lrd_td_gid").value;

					var plotted_by_reg = document.getElementById("lrd_td_plotted_by_reg").value;
					
					var checked_by = document.getElementById("lrd_td_checked_by").value;
					
					var plott_date_reg = document.getElementById("lrd_td_plott_date_reg").value;
					
					
					
					var nature_of_instument = document
							.getElementById("lrd_td_nature_of_instument").value;
					var date_of_registration = document
							.getElementById("lrd_td_date_of_registration").value;
					var volume = document
							.getElementById("lrd_td_volume").value;
					var folio = document
							.getElementById("lrd_td_folio").value;
					var date_of_issued_cert_no = document
							.getElementById("lrd_td_date_of_issued_cert_no").value;

					var type_of_certificate = document
							.getElementById("lrd_td_type_of_certificate").value;
					var registered_number = document
							.getElementById("lrd_td_registered_number").value;

					var cc_number = document
							.getElementById("lrd_td_cc_number").value;
					
					var certicate_number = document
							.getElementById("lrd_td_certicate_number").value;
					var applicant_name = document
							.getElementById("lrd_td_applicant_name").value;

					var grantor_name = document
							.getElementById("lrd_td_grantor_name").value;

					var job_number = document
							.getElementById("lrd_td_job_number").value;

					var type_instrument = document
							.getElementById("lrd_td_type_instrument").value;

					var date_of_instument = document
							.getElementById("lrd_td_date_of_instument").value;

					var consideration = document
					.getElementById("lrd_td_consideration").value;
			
					
			var purpose = document
					.getElementById("lrd_td_purpose").value;

			var date_commencement = document
					.getElementById("lrd_td_date_commencement").value;
			var term = document
					.getElementById("lrd_td_term").value;
			var remarks = document
					.getElementById("lrd_td_remarks").value;
			var type_of_registration = document
					.getElementById("lrd_td_type_of_registration").value;
			
			var reference_number = document.getElementById("lrd_td_reference_number").value;
			var land_size = document.getElementById("lrd_td_land_size").value;

					$
							.ajax({
								type : "POST",
								url : "Maps",
								// target : '_blank',
								data : {
								request_type : 'lrd_add_update_transaction',
								fid_id_fk : fid_id_fk,
								gid : gid,
								nature_of_instument : nature_of_instument,
								date_of_registration : date_of_registration,
								volume : volume,
								folio : folio,
								date_of_issued_cert_no : date_of_issued_cert_no,
								type_of_certificate : type_of_certificate,
								registered_number : registered_number,
								cc_number : cc_number,
								certicate_number : certicate_number,
								applicant_name : applicant_name,
								grantor_name : grantor_name,
								job_number : job_number,
								type_instrument : type_instrument,
								date_of_instument : date_of_instument,
								consideration : consideration,
								purpose : purpose,
								date_commencement : date_commencement,
								term : term,
								remarks : remarks,
								plotted_by_reg : plotted_by_reg,
								checked_by : checked_by,
								plott_date_reg : plott_date_reg,
								type_of_registration : type_of_registration,
								reference_number : reference_number,
								land_size : land_size
								},
								cache : false,
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');

								},
								success : function(
										jobdetails) {
									console.log(jobdetails)
									alert(jobdetails);

								}
							});

				});
         
           
			$("#btnclearlist").click(function(event){
				
				  var table = $('#batchlistdataTable');
				    table.find("tbody tr").remove();
			});

         
         $("#btnprocessbatchlis").click(function(event){
        	 var table = $('#batchlistdataTable').tableToJSON();
        	 //s  console.log(table);
        	  // alert(JSON.stringify(table)); 
var list_of_application_new = JSON.stringify(table)
        	 
        	 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'process_batch_list_new',
	                	division: localStorage.getItem('division'),
	                  	list_of_application:list_of_application_new
	                  	},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(response) {
					    console.log(response)
					    
					  var json_p = JSON.parse(response);
					 
					    
					    $('#request_type').val('request_to_generate_batch_list');
					    $('#list_of_application').val(list_of_application_new);
					    $('#batch_number').val(json_p.batch_number);
					   
					    $('#modified_by').val(  $( "#user_to_send_to" ).val());
					    //var userid_1 = $( "#user_to_send_to" ).val(); 
					    
					   //  $('#modified_by').val(localStorage.getItem('fullname'));
					    $('#modified_by_id').val( localStorage.getItem('userid'));
					     $('#downloadForm').submit();
				      
				 }
				 }); 
     		
     	});
         $('#btnaddjobtolist').on('click', function(e) {
        	  
              var jn_id = $('#bl_jn_id').val();
              var mss_id = $("input[name='bl_milestone']:checked").val();
             // var job_status = $("input[name='bl_milestone']:checked").text();
              var job_status = $("input[name=bl_milestone]:checked").attr("data-value"); 
              var job_number = $('#bl_job_number').val();
              var ar_name = $('#bl_ar_name').val();
              var business_process_sub_name = $('#bl_business_process_sub_name').val();
              var job_purpose = $('#bl_job_purpose').val();
             // var job_status = 'Pending';
             // var job_status = 'Pending';
              var send_by_id = localStorage.getItem('userid');
              var send_by_name = localStorage.getItem('fullname');
           var userid_1 = $( "#user_to_send_to" ).val();  // $( "#user_to_send_to option:selected" ).text(); 
           var xyz = $('#listofusers option').filter(function() {return this.value == userid_1; }).data('xyz');
               
          //listofusers
           var userid = xyz ?  xyz : 'No Match';
           //var userid = xyz ? 'xyz=' + xyz : 'No Match';
          // alert(msg)
        		  var table = $('#batchlistdataTable');
			    //table.find("tbody tr").remove();
			    
			    table.append("<tr><td>" + jn_id + "</td><td>" + mss_id + "</td><td>" + job_number + "</td><td>" + ar_name + "</td><td>" + business_process_sub_name + "</td><td>" + job_purpose + "</td><td>" + job_status + "</td><td>" + send_by_id + "</td><td>" + send_by_name + "</td><td>" + userid + "</td>"
			    		
			    		   
			    		  +  '<td><p data-placement="top" data-toggle="tooltip" title="Add To List"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" data-toggle="modal" data-target="#delete" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'
			    		    + "</tr>");
		        
			 
        	    $('#edit').modal('hide')
         })
        
    	$("#btnjob_numbersearch").click(function(event){
    		console.log('how are yiou');
    		
    		var job_number = $("#job_number").val();
    		 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'load_application_details_by_job_number',
	                	job_number:job_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					  var table = $('#job_detailsdataTable');
							    table.find("tbody tr").remove();
					 
					    var result = JSON.parse(jobdetails);
					    console.log('how come')
				        console.log(result)
				        
					    table.append("<tr><td>" + result.job_number + "</td><td>" + result.ar_name + "</td><td>" + result.current_application_status + "</td>"
					    							    		 
					    		  +  '<td><p data-placement="top" data-toggle="tooltip" title="Add To List"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="' + result.job_number + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
					    		   
					    		    + "</tr>");
				        
				 }
				 }); 
        });
     	function formatMoney(amount, decimalCount = 2, decimal = ".", thousands = ",") {
     		  try {
     		    decimalCount = Math.abs(decimalCount);
     		    decimalCount = isNaN(decimalCount) ? 2 : decimalCount;

     		    const negativeSign = amount < 0 ? "-" : "";

     		    let i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString();
     		    let j = (i.length > 3) ? i.length % 3 : 0;

     		    return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "");
     		  } catch (e) {
     		    console.log(e)
     		  }
     		};
     
         
 ////------------------------------------------------------------------------------------------------
	$('#assessed_value').keyup(function(e){
		
		//var nf = new Intl.NumberFormat();
		var assessed_value = convertStringToNumber($('#assessed_value').val());
		
		if(assessed_value <=10000){
			 $('#stamp_duty').val(formatMoney(assessed_value * (0.25/100)));
		}else if(assessed_value > 10000 && assessed_value <= 50000 ){
			 $('#stamp_duty').val(formatMoney(assessed_value * (0.5/100)));
		}else if(assessed_value > 50000 ){
			 $('#stamp_duty').val(formatMoney(assessed_value * (1/100)));
		}
	});
	
	$('#radioBtn a').on('click', function(){
	    var sel = $(this).data('title');
	    var tog = $(this).data('toggle');
	    $('#'+tog).prop('value', sel);
	    
	    $('a[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').addClass('notActive');
	    $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').addClass('active');
	    
	    if($('#land_state').val()=='No'){
	    	$('#comparable_section_display').show();
	    	$('#adopted_value').prop("readonly", true);
	    	$('#assessed_value').prop("readonly", true);
	    	//$('#stamp_duty').prop("readonly", true);
	    }else{
	    	$('#comparable_section_display').hide();
	    
	    	//$('#adopted_value').prop("readonly", false);
	    	$('#assessed_value').prop("readonly", false);
	    	//$('#stamp_duty').prop("readonly", false);
	    	
	    	$('#adopted_value').val("");
	    	$('#assessed_value').val("");
	    	$('#stamp_duty').val("");
	    	
	    }
	});
	
  	$('#btn_load_comparable_values').on('click', function(e) {
      	var locality_new = $("#new_comparable_locality").val();
      	
       // var locality_new = $(this).val();
	       
	      new_comparable_locality
	      
			 $.ajax({
			 type: "POST",
			 url: "Maps",
			 data: {
                	request_type: 'select_lc_locality_comparable_values_by_location',
                	locality:locality_new},
			 cache: false,
			 beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			 },
			 success: function(jobdetails) {
				    //console.log(jobdetails);
				    var json_p = JSON.parse(jobdetails);
				
					 
				  $('#txt_comp_max_value').val(json_p.min_value);
					$('#txt_comp_min_value').val(json_p.min_max);
						 
					  $( function() {
					  	    var handle = $( "#label" );
					  	    handle.show();
					  	  	var formatter = new Intl.NumberFormat('en-US', {
						    	    style: 'currency',
						    	    currency: 'GHS',
						    	   });
					  	  	
					  	  	var min =json_p.min_value; var max =json_p.min_max;
					  	    $( "#assesedvalueRange" ).slider({
					  	       
					  	    	value:(min + max)/2,
						     	    min: min,
						            max: max,
						            step: 1,
					  	        slide: function( event, ui ) {
					  	    	  
					  	    	  handle.css("margin-left", (ui.value-min)/(max-min)*100+"%");
					  	    	  handle.css("left", "-50px");
					  	          handle.text(formatter.format(ui.value) );
					  	          
					  	          
					  	          //do assessment
					  	        //  console.log(ui.value);
						  	        var adopted_value = ui.value;
									//var nf = f('en-IN', { maximumSignificantDigits: 3 });
									//var new_value= nf.format(adopted_value); // "1,234,567,890"
									var land_size = $("#new_comparable_size_of_land").val();
									var assessed_value = land_size * adopted_value;
									
									//console.log("adopted =" + adopted_value)
									
						//console.log("asseessed =" + assessed_value)
									
									$('#adopted_value').val(formatMoney(adopted_value));
						  			
						  		  	$('#assessed_value').val(formatMoney(assessed_value));
						  		  	//$('#stamp_duty').val(assessed_value * (0.25/100));
						
						//console.log("asseessed =" + assessed_value)
						
									if(assessed_value <=10000){
										 $('#stamp_duty').val(formatMoney(assessed_value * (0.25/100)));
									}else if(assessed_value > 10000 && assessed_value <= 50000 ){
										 $('#stamp_duty').val(formatMoney(assessed_value * (0.5/100)));
									}else if(assessed_value > 50000 ){
										console.log("asseessed =" + assessed_value)
										$('#stamp_duty').val(formatMoney(assessed_value * (0.1/100)));
									}
					  	          
					  	      }
					  	    });
					  	  });
			 }
			 });
      	
    });
     	
     		$('#sub_service_on_case').change(function(){
     	    //alert($(this).val());
     			var select_id = document.getElementById("main_service_on_case");
     		var main_service=select_id.options[select_id.selectedIndex].value;
     		var sub_service = $(this).val();
     			const main_service_name_id = main_service.split('-');
     			const sub_service_name_id = sub_service.split('-');
     			var main_service_id = main_service_name_id[0];
         		var main_service_name = main_service_name_id[1];
     			var sub_service_id = sub_service_name_id[0];
     			var sub_service_name = sub_service_name_id[1];

     			if(main_service_name==='APPLICATION FOR PLAN APPROVAL'){
		   			$('#oncasereg-no-div').show();
		   			$('#oncasereglandsize-no-div').show();
		   			$('#oncasestp-no-div').hide();
		   			$('#oncasefreg-no-div').hide();
		   			$('#oncasefpublication-no-div').hide();
		   			
		   		}
		   		
		   		if(main_service_name==='APPLICATION FOR STAMPING'){
		   			$('#oncasereg-no-div').hide();
		   			$('#oncasereglandsize-no-div').hide();
		   			$('#oncasestp-no-div').show();
		   			$('#oncasefreg-no-div').hide();
		   			$('#oncasefpublication-no-div').hide();
		   		}
		   		
		   		if(sub_service_name==='APPLICATION FOR FIRST REGISTRATION (STOOL)'){
		   			$('#oncasereg-no-div').hide();
		   			$('#oncasereglandsize-no-div').hide();
		   			$('#oncasestp-no-div').hide();
		   			$('#oncasefreg-no-div').show();
		   			$('#oncasefpublication-no-div').show();
		   			
		   		}
     			
		   		if(sub_service_name==='APPLICATION FOR MORTGAGES'){
		   			$("#on_application_client_name").val('');
		   			document.getElementById("on_application_client_name").readOnly = false;
		 		   
		   		}
		   		
		   		if(sub_service_name==='APPLICATION FOR OBJECTION'){
		   			$("#on_application_client_name").val('');
		   		  	document.getElementById("on_application_client_name").readOnly = false;
		 		   
		   		}
		   		
     			 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				 data: {
    	                	request_type: 'get_lc_checklist',
    	                	main_service_id:main_service_id,
    	                	sub_service_id:sub_service_id},
    				 cache: false,
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					
    					  var table = $('#on_case_checlist_table_billdataTable');
    					    table.find("tbody tr").remove();
    					
    					    //console.log(jobdetails);
    					    var json_p = JSON.parse(jobdetails);
    					    
    					    $(json_p).each(function () {
    								    table.append("<tr><td>" + this.business_process_checklist_name + "</td><td>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" /></div>' + "</td>"
    								    //	  +  '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#modalrecordinformation" data-target-id="' + this.ms_id + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
    								    + "</tr>");
    				              });
    				 }
    				 }); 
     			 
     			 
     			 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				 data: {
    	                	request_type: 'get_type_of_forms_list',
    	                	main_service_id:main_service_id,
    	                	sub_service_id:sub_service_id},
    				 cache: false,
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					
    					 
    					    console.log(jobdetails);
    					    var json_p = JSON.parse(jobdetails);
    					    var options = $("#new_bill_registration_forms_on_case");

    				       // var options = $("#selector");
    				        options.empty();
    				        options.append(new Option("-- Select --", 0));
    				     
    					    $(json_p).each(function () {
    				        	  $('#new_bill_registration_forms_on_case').append('<option value="' + this.form_number + '-'+ this.form_name +'">' + this.form_name + '</option>');
    	        				
    				           });
    				//business_process_id	  
    				 }
    				 });
     			 
	     		 $.ajax({
	   				 type: "POST",
	   				 url: "Case_Management_Serv",
	   				 data: {
	   	                	request_type: 'get_list_of_revenue_item_list',
	   	                	},
	   				 cache: false,
	   				 beforeSend: function () {
	   					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	   				 },
	   				 success: function(jobdetails) {
	   					    var json_p = JSON.parse(jobdetails);
	   					    var options = $("#new_type_of_revenue_item_on_case");

	   				       // var options = $("#selector");
	   				        options.empty();
	   				        options.append(new Option("-- Select --", 0));
	   				     
	   					    $(json_p).each(function () {
	   				          
	   					 
	   				       if (sub_service_id ==this.is_inspection_required){
	   				        	  $('#new_type_of_revenue_item_on_case').append('<option value="' + this.id + '_'+ this.revenue_items_name +'">' + this.revenue_items_name + '</option>');
	   	        					 
	   				     }
	   				          
	   				        
	   				           });
	   				//business_process_id	  
	   				 }
	   				 });
     			
     	})
         
     		$("#btn_save_lrd_parcel_details_fts_with_info").click(function(event){
     	
					var wktplygonsearch = document
							.getElementById("lrd_parcel_wkt_to_plot_fts").value;

					var lrd_glpin = document
							.getElementById("lrd_glpin").value;

					var locality = document.getElementById("lrd_locality_fts").value;

					var remarks = document.getElementById("lrd_remarks_fts").value;

					$
							.ajax({
								type : "POST",
								url : "Maps",
								// target : '_blank',
								data : {
									request_type : 'lrd_polygon_for_save_with_info',
									wkt_polgon : wktplygonsearch,
									certificate_number : '',

									locality : locality,
									remarks : remarks
								},
								cache : false,

								success : function(jobdetails) {
									//console.log(jobdetails)

									var json_p = JSON.parse(jobdetails);
									$(
											'#lrdparcelinformationfirsttimesavewithinfo #lrd_gid_fts')
											.val(json_p.gid);
									$(
											'#lrdparcelinformationfirsttimesavewithinfo #lrd_glpin')
											.val(json_p.reference_number);
								
									//$("#btn_save_lrd_parcel_details_fts_with_info")
									document.getElementById("btn_save_lrd_parcel_details_fts_with_info").disabled = true;
									alert(json_p.msg)

								
								}
							});

				});
     		
     		 $('#btn_process_after_payment_on_case').on('click', function(e) {
            
            	var job_number = $("#txt_on_case_ap_job_number").val();
            	
            	console.log(job_number);
       		 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				 data: {
    	                	request_type: 'select_load_details_for_payment',
    	                	job_number:job_number},
    				 cache: false,
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					
    					  var table_bp = $('#tbl_on_case_ap_bills_payments_dataTable');
    					  table_bp.find("tbody tr").remove();
    					    

      					  var table_cl = $('#tbl_on_case_ap_checklist_dataTable');
      					table_cl.find("tbody tr").remove();
      					    var json_p = JSON.parse(jobdetails);
							
							 $('#txt_on_case_ap_main_service_id').val(json_p.jobdetails.business_process_id);
							 $('#txt_on_case_ap_main_service_sub_id').val(json_p.jobdetails.business_process_sub_id);
							 $('#txt_on_case_ap_jn_id').val(json_p.jobdetails.jn_id);
							 $('#txt_on_case_ap_main_service_desc').val(json_p.jobdetails.business_process_name);
							 $('#txt_on_case_ap_main_service_sub_desc').val(json_p.jobdetails.business_process_sub_name);
							 $('#txt_on_case_ap_client_name').val(json_p.jobdetails.lessees_name);
							 $('#txt_on_case_ap_ar_name').val(json_p.jobdetails.lessees_name);
							 
							 
							 $('#txt_on_case_ap_land_size').val(json_p.jobdetails.extent);
							$('#new_ap_application_surveyors_name_oncase').val(json_p.jobdetails.licensed_surveyor_name);
							 
							 
							 $('#txt_on_case_ap_type_of_instrument').val(json_p.jobdetails.type_of_interest);
								$('#txt_on_case_ap_type_of_use').val(json_p.jobdetails.type_of_use);
								 
							 
							 if(json_p.jobdetails.business_process_name==='APPLICATION FOR PLAN APPROVAL'){
						   			$('#oncasepaap-no-div').show();
						   			$('#oncasestpap-no-div').hide();
						   			$('#oncaseregap-no-div').hide();
						   			$('#oncaseparty-no-div').hide();
						   			
						   		}
						   		
						   		if(json_p.jobdetails.business_process_name==='APPLICATION FOR STAMPING'){
						   			$('#oncasepaap-no-div').hide();
						   			$('#oncasestpap-no-div').show();
						   			$('#oncaseregap-no-div').hide();
						   			$('#oncaseparty-no-div').hide();
						   		}
						   		
						   		if(json_p.jobdetails.business_process_name==='APPLICATION FOR REGISTRATION'){
						   			$('#oncasepaap-no-div').hide();
						   			$('#oncasestpap-no-div').show();
						   			$('#oncaseregap-no-div').hide();
						   			$('#oncaseparty-no-div').hide();
						   		}
						   		
						   		
						   		if(json_p.jobdetails.business_process_sub_name==='APPLICATION FOR OBJECTION'){
						   			$('#oncasepaap-no-div').hide();
						   			$('#oncasestpap-no-div').show();
						   			$('#oncaseregap-no-div').hide();
						   			$('#oncaseparty-no-div').show();
						   		}
						   		
						   		if(json_p.jobdetails.business_process_sub_name==='APPLICATION FOR MORTGAGES'){
						   			$('#oncasepaap-no-div').hide();
						   			$('#oncasestpap-no-div').show();
						   			$('#oncaseregap-no-div').hide();
						   			$('#oncaseparty-no-div').show();
						   		}
						   		
						   		
						   		if(json_p.jobdetails.business_process_sub_name==='APPLICATION FOR WHOLE TRANFER'){
						   			$('#oncasepaap-no-div').hide();
						   			$('#oncasestpap-no-div').show();
						   			$('#oncaseregap-no-div').hide();
						   			$('#oncaseparty-no-div').show();
						   		}
						   		
    					    $(json_p.payments).each(function () {
    					    	table_bp.append("<tr><td>" + this.bill_number + "</td><td>" +this.customer_id + "</td><td>" +this.bill_amount + "</td><td>" +this.payment_amount + "</td><td> </td><td>" +this.division + "</td>"
    							+ "</tr>");        
    				          });
    					    
    						 $.ajax({
    		    				 type: "POST",
    		    				 url: "Case_Management_Serv",
    		    				 data: {
    		    	                	request_type: 'get_lc_checklist',
    		    	                	main_service_id:json_p.jobdetails.business_process_id,
    		    	                	sub_service_id:json_p.jobdetails.business_process_sub_id},
    		    				 cache: false,
    		    				 beforeSend: function () { },
    		    				 success: function(jobdetails) {
    		    					
    		    					  var table = $('#tbl_on_case_ap_checklist_dataTable');
    		    					    table.find("tbody tr").remove();
    		    					
    		    					    //console.log(jobdetails);
    		    					    var json_p = JSON.parse(jobdetails);
    		    					    
    		    					    $(json_p).each(function () {
    		    								    table.append("<tr><td>" + this.business_process_checklist_name + "</td><td>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" /></div>' + "</td>"
    		    								    	
    		    								    		    + "</tr>");
    		    							        
    		    				              });
    		    					  
    		    				 }
    		    				 }); 
    					  
    				 }
    				 }); 
            });
     		 
     		 
   		 $('#btn_print_new_title_plan').on('click', function(e) {
            var job_number = $("#cs_main_job_number").val();
            var case_number = $("#cs_main_case_number").val();
			var transaction_number = $("#cs_main_transaction_number").val();
         	var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
			 
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_title_plan',
      	                	wkt_polygon:wkt_polygon,
  		                 	job_number:job_number,
							   transaction_number:transaction_number,
  		                 	case_number:case_number
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () {
      					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      				 },
      				 success: function(jobdetails) {
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });
   		 
 		 $('#btn_generate_transitional_certificate').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
          	var transaction_number = $("#cs_main_transaction_number").val();
          	
        	var notes = $("#my-summernote").val();
       	//var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
          	console.log(notes)
       		 $.ajax({
    						                 	
 		                 	 type: "POST",
 	        				 url: "GenerateCaseReports",
 	        				// target:'_blank',
 	        				 data: {
 	        	                	request_type: 'request_to_generate_transitional_certificate',
 	     		                 	job_number:job_number,
 	     		                 	case_number:transaction_number,
 	     		                 	transaction_number:transaction_number,
 	     		                 	notes:notes },
    				 cache: false,
    				xhrFields:{
    	                responseType: 'blob'
    	            },
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					var blob = new Blob([jobdetails], {type: "application/pdf"});
    			        var objectUrl = URL.createObjectURL(blob);
    			      window.open(objectUrl);
    					  
    				 }
    				 }); 
    		 });
 		 

 		 $('#lc_btn_generate_memo_for_certificate, #lc_btn_generate_memo_for_certificate_2').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
          	var transaction_number = $("#cs_main_transaction_number").val();
          	
        	
       		 $.ajax({
    						                 	
 		                 	 type: "POST",
 	        				 url: "GenerateCaseReports",
 	        				// target:'_blank',
 	        				 data: {
 	        	                	request_type: 'request_to_generate_memo',
 	     		                 	job_number:job_number,
 	     		                 	case_number:transaction_number,
 	     		                 	transaction_number:transaction_number
 	     		                 	 },
    				 cache: false,
    				xhrFields:{
    	                responseType: 'blob'
    	            },
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					var blob = new Blob([jobdetails], {type: "application/pdf"});
    			        var objectUrl = URL.createObjectURL(blob);
    			      window.open(objectUrl);
    					  
    				 }
    				 }); 
    		 });


			 $('#lc_btn_generate_discharge_memo_for_certificate, #lc_btn_generate_discharge_memo_for_certificate_2').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
          	var transaction_number = $("#cs_main_transaction_number").val();
          	
        	
       		 $.ajax({
    						                 	
 		                 	 type: "POST",
 	        				 url: "GenerateCaseReports",
 	        				// target:'_blank',
 	        				 data: {
 	        	                	request_type: 'request_to_generate_discharge_memo',
 	     		                 	job_number:job_number,
 	     		                 	case_number:transaction_number,
 	     		                 	transaction_number:transaction_number	 },
    				 cache: false,
    				xhrFields:{
    	                responseType: 'blob'
    	            },
    				 beforeSend: function () { },
    				 success: function(jobdetails) {
						var blob = new Blob([jobdetails], {type: "application/pdf"});
    			        var objectUrl = URL.createObjectURL(blob);
    			      window.open(objectUrl);
    					  
    				 }
    				 }); 
    		 });
 		 
   		 $('#lc_btn_preview_concurrence_certificate').on('click', function(e) {
         	var job_number = $("#cs_main_job_number").val();
         	var case_number = $("#cs_main_case_number").val();
         	var transaction_number = $("#cs_main_transaction_number").val();
      	//var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
         	
      		 $.ajax({ type: "POST",
	        				 url: "GenerateCaseReports",
	        				// target:'_blank',
	        				 data: {
	        	                	request_type: 'request_to_generate_concurrence_certificate',
	     		                 	job_number:job_number,
	     		                 	case_number:transaction_number,
	     		                 	transaction_number:transaction_number },
   				 cache: false,
   				xhrFields:{
   	                responseType: 'blob'
   	            },
   				 beforeSend: function () {
   					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   				 },
   				 success: function(jobdetails) {
   					var blob = new Blob([jobdetails], {type: "application/pdf"});
   			        var objectUrl = URL.createObjectURL(blob);
   			      window.open(objectUrl);
   					  
   				 }
   				 }); 
   		 });
    		 
 		
 		 $('#lc_btn_preview_consent_certificate').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
        	var ir_business_process_sub_name = $("#cs_main_business_process_sub_name").val();
          	var transaction_number = $("#cs_main_transaction_number").val();
        	var notes = $("#lc_search_report_summary_details").val();
          	
       		 $.ajax({
    						                 	
 		                 	 type: "POST",
 	        				 url: "GenerateCaseReports",
 	        				// target:'_blank',
 	        				 data: {
 	        	                	request_type: 'request_to_generate_consent_certificate_typed',
 	     		                 	job_number:job_number,
 	     		                 	case_number:case_number,
 	     		                 	transaction_number:transaction_number,
 	     		                 	notes:notes,
 	     		                 	ir_business_process_sub_name:ir_business_process_sub_name      	
    				 },
    				 cache: false,
    				xhrFields:{
    	                responseType: 'blob'
    	            },
    				 beforeSend: function () {},
    				 success: function(jobdetails) {
    					var blob = new Blob([jobdetails], {type: "application/pdf"});
    			        var objectUrl = URL.createObjectURL(blob);
    			      window.open(objectUrl);
    					  
    				 }
    				 }); 
    		 });
     		 
     		$('#open_attached_document').on('click', function(e) {
    			 
             		 $.ajax({
          				 type: "POST",
          				 url: "open_pdffile",
          				// target:'_blank',
          				 data: {
          	                	request_type: 'print_rent_demand_notice'	
          				 },
          				 cache: false,
          				xhrFields:{
          	                responseType: 'blob'
          	            },
          				 beforeSend: function () { },
          				 success: function(jobdetails) {
          					$('#elisDocumentPreview').modal({backdrop: 'static',});
          					var blob = new Blob([jobdetails], {type: "application/pdf"});
          			        var objectUrl = URL.createObjectURL(blob);
							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
          				 }
          				 });  
          			 
          		 });
       	  	

     		  $("#btn_upload_case_file").click(function (event) {
                      event.preventDefault();
                     var case_number = $("#file_upload_case_number").val();
                     var sampleFile = document.getElementById("fileUploadForm").files[0];
                     var filename = document.getElementById("fileUploadForm").files[0].name;
                     console.log(filename);
                     
                     var formdata = new FormData();

                     formdata.append("case_number", case_number);
                     formdata.append("file_name", filename);
					   $('.fileUpload input[name="sampleFile"]').each(function(index, element) {
							if (element.files && element.files.length > 0) {
								// Append each file with a unique index
								formdata.append('sampleFile', element.files[0]);
								formdata.append('file_name', element.files[0].name);
							}
						});
                     
                    $("#btn_upload_case_file").prop("disabled", true);
                   // console.log(formdata);
                     $.ajax({
                         type: "POST",
                         enctype: 'multipart/form-data',
                         //url: "document_upload_new",
						 url: "document_upload_mutiple_new",
                         data: formdata,
                         processData: false,
                         contentType: false,
                         cache: false,
                         timeout: 600000,
                         success: function (data) {
                          alert(data);
                          $('#fileUploadModal').modal('hide');
                             console.log("SUCCESS : ", data);
                             $("#btn_upload_case_file").prop("disabled", false);

                         },
                         error: function (e) {

                            // $("#result").text(e.responseText);
                             console.log("ERROR : ", e);
                             $("#btn_upload_case_file").prop("disabled", false);

                         }
                     });
                     
                 });
     		 
   		 $('#btn_update_parcel_as_approved_draft').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
          	
       		 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				// target:'_blank',
    				 data: {
    	                	request_type: 'select_lc_plan_approval_plottings_update_final_status',
		                 	job_number:job_number,
		                 	case_number:case_number
    				 },
    				 cache: false,
    				/* xhrFields:{
    	                responseType: 'blob'
    	            }, */
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					 console.log(jobdetails);
    					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
    				
    					 $("#general_message_dialog").modal();
    						//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
    						$('#general_message_dialog #general_message_dialog_msg_new').val('Parcel Approved Successfully');
    					  
    				 }
    				 }); 
    		 });
   		 
   		 $('#btn_generate_smd_barcode').on('click', function(e) {
           	var job_number = $("#cs_main_job_number").val();
           	var case_number = $("#cs_main_transaction_number").val();
        	//var case_number = $("#cs_main_case_number").val();
        	var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
           	
        		 $.ajax({
     				 type: "POST",
     				 url: "GenerateCaseReports",
     				// target:'_blank',
     				 data: {
     	                	request_type: 'request_to_generate_smd_barcode',
     	                	wkt_polygon:wkt_polygon,
 		                 	job_number:job_number,
 		                 	case_number:case_number
     				 },
     				 cache: false,
     				xhrFields:{
     	                responseType: 'blob'
     	            },
     				 beforeSend: function () {
     					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     				 },
     				 success: function(jobdetails) {
     					 console.log(jobdetails);
     					var blob = new Blob([jobdetails], {type: "application/pdf"});
     			        var objectUrl = URL.createObjectURL(blob);
     			      window.open(objectUrl);
     					  
     				 }
     				 }); 
     		 });
   		
   		 $('#lc_btn_activate_final_register, #lc_btn_activate_final_register_').on('click', function(e) {
            	var job_number = $("#cs_main_job_number").val();
            	//var case_number = $("#cs_main_case_number").val();
            	var case_number = $("#cs_main_transaction_number").val();
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_register',
  		                 	job_number:job_number,
  		                 	case_number:case_number
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () {
      					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      				 },
      				 success: function(jobdetails) {
      					 console.log(jobdetails);
      					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
      				
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });

			   $('#lc_btn_activate_final_register_').on('click', function(e) {
            	var job_number = $("#fe_job_number").val();
            	//var case_number = $("#cs_main_case_number").val();
            	var case_number = $("#fe_transaction_number").val();
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_register',
  		                 	job_number:job_number,
  		                 	case_number:case_number
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () {
      					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      				 },
      				 success: function(jobdetails) {
      					 console.log(jobdetails);
      					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
      				
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });

			   $('#lc_btn_generate_mother_final_register').on('click', function(e) {
            	var job_number = $("#ts_main_job_number_sm").val();
            	//var case_number = $("#cs_main_case_number").val();
            	var case_number = $("#ts_main_transaction_number_sm").val();
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_register',
  		                 	job_number:job_number,
  		                 	case_number:case_number
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () {
      					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      				 },
      				 success: function(jobdetails) {
      					 console.log(jobdetails);
      					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
      				
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });

			   $('#lc_btn_generate_updated_mother_final_register').on('click', function(e) {
            	var job_number = $("#cs_main_job_number").val();
            	//var case_number = $("#cs_main_case_number").val();
            	var case_number = $("#cs_main_transaction_number").val();
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_register',
  		                 	job_number:job_number,
  		                 	case_number:case_number
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () {},
      				 success: function(jobdetails) {
      					 console.log(jobdetails);
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });

			   $('#btnUpdateAsMotherFinalRegister').on('click', function(e) {

					var job_number = $("#cs_main_job_number").val();
					var case_number = $("#cs_main_case_number").val();
         		 
         		 	 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				// target:'_blank',
    				 data: {
    	                	request_type: 'select_lc_mother_file_update_final_register',
		                 	job_number:job_number,
		                 	case_number:case_number
    				 },
    				 cache: false,
    				 beforeSend: function () { },
    				 success: function(jobdetails) {
    					 $("#general_message_dialog").modal();
    						//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
    						$('#general_message_dialog #general_message_dialog_msg_new').val('Mother file updated successfully');
    					  
    				 }
    				 }); 
         		});
   		 
   		 $('#lc_btn_activate_provisional_certificate').on('click', function(e) {
         	var job_number = $("#cs_main_job_number").val();
           	var case_number = $("#cs_main_transaction_number").val();
         	var registration_district_number = $("#txt_lc_registration_district_number").val();
         	var registration_section_number = $("#txt_lc_registration_section_number").val();
         	
      		 $.ajax({
   				 type: "POST",
   				 url: "GenerateCaseReports",
   				// target:'_blank',
   				 data: {
   	                	request_type: 'request_to_generate_provisional_certificate',
		                 	job_number:job_number,
		                 	case_number:case_number,
		                 	cert_type:'LEASEHOLD',
		                 	registration_district_number:registration_district_number,
		                 	registration_section_number:registration_section_number  		                 	
   				 },
   				 cache: false,
   				xhrFields:{
   	                responseType: 'blob'
   	            },
   				 beforeSend: function () {
   					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   				 },
   				 success: function(jobdetails) {
   					 console.log(jobdetails);
   					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
   				
   					var blob = new Blob([jobdetails], {type: "application/pdf"});
   			        var objectUrl = URL.createObjectURL(blob);
   			      window.open(objectUrl);
   					  
   				 }
   				 }); 
   		 });
		 
   		 
   		 $('#lc_btn_activate_final_certificate, #lc_btn_activate_final_certificate_').on('click', function(e) {
            	var job_number = $("#cs_main_job_number").val();
            	var case_number = $("#cs_main_case_number").val();
              	var transaction_number = $("#cs_main_transaction_number").val();
            	var registration_district_number = $("#txt_lc_registration_district_number").val();
            	var registration_section_number = $("#txt_lc_registration_section_number").val();
				var type_of_certificate = $('#lc_txt_type_of_certificate').find(":selected").text() == "Land Certificate" ? "LAND CERTIFICATE" : $('#lc_txt_type_of_certificate').find(":selected").text();

				console.log(type_of_certificate);
            	
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_certificate',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
							transaction_number:transaction_number,
  		                 	cert_type:'LEASEHOLD',
  		                 	registration_district_number:registration_district_number,
  		                 	registration_section_number:registration_section_number,
							type_of_certificate: type_of_certificate.trim()  		                 	
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () { },
      				 success: function(jobdetails) {
      					 console.log(jobdetails);
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });

			   $('#lc_btn_activate_final_concurrence_certificate, #lc_btn_activate_final_concurrence_certificate_').on('click', function(e) {
            	var job_number = $("#cs_main_job_number").val();
            	var case_number = $("#cs_main_case_number").val();
              	var transaction_number = $("#cs_main_transaction_number").val();
            	var registration_district_number = $("#txt_lc_registration_district_number").val();
            	var registration_section_number = $("#txt_lc_registration_section_number").val();
				var type_of_certificate = $('#lc_txt_type_of_certificate').find(":selected").text() == "Land Certificate" ? "LAND CERTIFICATE" : $('#lc_txt_type_of_certificate').find(":selected").text();

				console.log(type_of_certificate);
            	
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_certificate',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
							transaction_number:transaction_number,
  		                 	cert_type:'CONCURRENCE',
  		                 	registration_district_number:registration_district_number,
  		                 	registration_section_number:registration_section_number,
							type_of_certificate: type_of_certificate.trim()  		                 	
      				 },
      				 cache: false,
      				xhrFields:{
      	                responseType: 'blob'
      	            },
      				 beforeSend: function () { },
      				 success: function(jobdetails) {
      					 console.log(jobdetails);
      					var blob = new Blob([jobdetails], {type: "application/pdf"});
      			        var objectUrl = URL.createObjectURL(blob);
      			      window.open(objectUrl);
      					  
      				 }
      				 }); 
      		 });
  		 
     		 $('#btn_generate_pvlmd_search_report').on('click', function(e) {
      			var case_number = $("#cs_main_case_number").val();
      		 	var job_number = $("#cs_main_job_number").val();
      		  	var transaction_number = $("#cs_main_transaction_number").val();
      
      		  	 var send_by_id = localStorage.getItem('userid');
      	         var send_by_name = localStorage.getItem('fullname');

				   var verification_code = makeid(5);

				   var message_to_send = 'Activation code for registration with Case Number ' +   case_number + ' Code:'+ verification_code;
 	       			var recipient = '+233242012137,+2332034790,+233242740508,+233242012137,+233206068883,+233501322686,+233244215813,+233202023810' ;
      	         
      	    
      				 $.ajax({
      					 type: "POST",
      					 url: "Case_Management_Serv",
      					 data: {
      		               	request_type: 'online_select_verification_code_create',
      		             	case_number:case_number,
      		             	job_number:job_number,
      		             	transaction_number:transaction_number,
							type_of_transaction:'approval_of_consolidated_search_signature'
      		              },
      					 cache: false,
      					 beforeSend: function () {
      						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      					 },
      					 success: function(jobdetails) {
      						
      						console.log(jobdetails);
						 var json_p = JSON.parse(jobdetails);
						//  alert(json_p.msg);
						 alert(json_p.msg);
      					 }
      					 }); 
     			 
     		
       		 });
     		 
     		 
     		 $('#btn_compose_certificate_template, #btn_compose_certificate_template_2').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
              	var case_number = $("#cs_main_transaction_number").val();
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();

				  var confirmText = "Are you sure you want to compose?";
				  if (confirm(confirmText)) {
              	
           		 $.ajax({
        				 type: "POST",
        				 url: "GenerateCaseReports",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'request_to_compose_certificate_template',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
  		                 	business_process_sub_name:business_process_sub_name,
  		                 	cert_type:'consent_certificate'
        				 },
        				 cache: false,
        				/* xhrFields:{
        	                responseType: 'blob'
        	            }, */
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					
        					// $('#my-summernote, #lc_search_report_summary_details, #lc_search_report_summary_details_final').summernote('code', '<ol><li>'+ jobdetails +'</li></ol>');
							console.log(job_number, case_number, business_process_sub_name, jobdetails)
        					
        					 $('#lc_search_report_summary_details').summernote('code', '<ol><li>'+ jobdetails +'</li></ol>');
         					 
        					console.log(jobdetails);
        					 alert('Report Composed Successfully')
        					  
        				 }
        				 }); 

						}
        		 });


				 $('#btn_compose_certificate_template_2').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
              	var case_number = $("#cs_main_transaction_number").val();
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();

				  var confirmText = "Are you sure you want to compose?";
				  if (confirm(confirmText)) {
              	
           		 $.ajax({
        				 type: "POST",
        				 url: "GenerateCaseReports",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'request_to_compose_certificate_template',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
  		                 	business_process_sub_name:business_process_sub_name,
  		                 	cert_type:'consent_certificate'
        				 },
        				 cache: false,
        				/* xhrFields:{
        	                responseType: 'blob'
        	            }, */
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					 $('#lc_search_report_summary_details_2').summernote('code', '<ol><li>'+ jobdetails +'</li></ol>');
         					
        					 
        					console.log(jobdetails);
        					 alert('Report Composed Successfully')
        					
        					  
        				 }
        				 }); 

						}
        		 });
     		 
     		 
     		 
     		 $('#btn_preview_final_search_report').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
              	var case_number = $("#cs_main_transaction_number").val();
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
              	
           		 $.ajax({
        				 type: "POST",
        				 url: "GenerateCaseReports",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'request_to_generate_search_template',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
  		                 	business_process_sub_name:business_process_sub_name,
  	   		                 signature:'Yes'
        				 },
        				 cache: false,
        				xhrFields:{
        	                responseType: 'blob'
        	            },
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					 console.log(jobdetails);
        					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
        				
        					var blob = new Blob([jobdetails], {type: "application/pdf"});
        			        var objectUrl = URL.createObjectURL(blob);
        			      window.open(objectUrl);
        					  
        				 }
        				 }); 
        		 });
     		 
     		 
     		 $('#btn_preview_search_report, #btn_preview_search_report_2').on('click', function(e) {
               	var job_number = $("#cs_main_job_number").val();
               	var case_number = $("#cs_main_transaction_number").val();
             	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
               	
               	
            		 $.ajax({
         				 type: "POST",
         				 url: "GenerateCaseReports",
         				// target:'_blank',
         				 data: {
         	                	request_type: 'request_to_generate_search_template',
   		                 	job_number:job_number,
   		                 	case_number:case_number,
   		                 	business_process_sub_name:business_process_sub_name,
   		                 signature:'No'
         				 },
         				 cache: false,
         				xhrFields:{
         	                responseType: 'blob'
         	            },
         				 beforeSend: function () {
         					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
         				 },
         				 success: function(jobdetails) {
         					 console.log(jobdetails);
         					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
         				
         					var blob = new Blob([jobdetails], {type: "application/pdf"});
         			        var objectUrl = URL.createObjectURL(blob);
         			      window.open(objectUrl);
         					  
         				 }
         				 }); 
         		 });
       		
     		 
     		$('#submit_print_stamp_bill').on('click', function(e) {
     			 
     			
     			var job_number = $("#cs_main_job_number").val();
             	var case_number = $("#cs_main_case_number").val();
            	var business_process_id = $("#cs_main_business_process_id").val();
            	var business_process_name = $("#cs_main_business_process_name").val();
            	
            	var business_process_sub_id = $("#cs_main_business_process_sub_id").val();
            	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
            	var client_number = $("#cs_main_client_number").val();
            	
            	var ar_name = $("#cs_main_ar_name").val();
            	var stamp_duty_amount = $("#stamp_duty").val();
            	var assessed_value_amount = $("#assessed_value").val();
            	var assessed_comment = $("#assessed_comment").val();
            	/* var case_number = $("#cs_main_case_number").val();
            	var case_number = $("#cs_main_case_number").val(); */
             	
          		 $.ajax({
       				 type: "POST",
       				 url: "Case_Management_Serv",
       				// target:'_blank',
       				 data: {
       	                	request_type: 'process_print_stamp_duty_bill',
 		                 	job_number:				job_number,
 		                 	case_number:			case_number,
 		                 	ar_name:				ar_name,
 		                 	business_process_id:	business_process_id,
 		                 	business_process_name:	business_process_name,
 		                 	business_process_sub_id:business_process_sub_id,
 		                 	business_process_sub_name:business_process_sub_name,
 		                 	stamp_duty_amount:		stamp_duty_amount,
 		                 	assessed_value_amount:	assessed_value_amount,
 		                 	assessed_comment: 		assessed_comment
 		                 	
       				 },
       				 cache: false,
       				xhrFields:{
       	                responseType: 'blob'
       	            },
       				 beforeSend: function () {
       					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
       				 },
       				 success: function(jobdetails) {
       					 console.log(jobdetails);
       					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
       				
       					var blob = new Blob([jobdetails], {type: "application/pdf"});
       			        var objectUrl = URL.createObjectURL(blob);
       			      window.open(objectUrl);
       					  
       				 }
       				 }); 
       		 });
     		 
     		
     		 
     		 $('#btn_save_to_generate_on_application').on('click', function(e) {
     			var select_id = document.getElementById("main_service_on_case");
         		var main_service=select_id.options[select_id.selectedIndex].value;
         		var sub_select_id = document.getElementById("sub_service_on_case");
         		var sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
         			const main_service_name_id = main_service.split('-');
         			const sub_service_name_id = sub_service.split('-');
         			
         			var main_service_id = main_service_name_id[0];
             		var main_service_name = main_service_name_id[1];
             				
         			var sub_service_id = sub_service_name_id[0];
         			var sub_service_name = sub_service_name_id[1];
			   		main_service_id = main_service_id.replace('.0', '');
			   		var new_land_size = '0';
             	var on_application_client_name = $("#on_application_client_name").val();
             	
             	var new_bill_application_ls_number = $("#new_bill_application_ls_number_oncase").val();
             	var new_bill_application_case_number = $("#new_bill_case_number_on_case").val();
             	new_bill_locality_on_case ='';
             	new_land_size = $("#new_bill_land_size_on_case").val();
             	var new_bill_type_of_use = $("#new_bill_type_of_use_on_case").val();
             	var new_type_of_revenue_item = $("#new_type_of_revenue_item_on_case").val();
             	
            	var new_bill_registration_forms = $("#new_bill_registration_forms_on_case").val();
            	var new_bill_publication_type = $("#new_bill_publication_type_on_case").val();
            	var new_bill_application_surveyors_name_oncase = '';
            	
            	var new_number_of_copies = $("#new_number_of_copies_on_case").val();
            	
            	if(main_service_name==='APPLICATION FOR PLAN APPROVAL'){
            		new_land_size =$("#new_bill_land_size_on_case").val();
            		new_bill_application_surveyors_name_oncase = $("#new_bill_application_surveyors_name_oncase").val();
            		new_bill_locality_on_case=$("#new_bill_locality_on_case_1").val();
		   		}
            	var on_application_client_name = $("#on_application_client_name").val();
            	var created_for =$("#on_application_client_name").val();;
		   		var created_for_id=$("#new_bill_client_id_on_case").val();
		   		//var created_for_id='0242012137';
		   		var application_required_additional_bill='No';
		   		var office_region = $("#new_bill_application_office_region_on_case").val();
            	
		   		
            	if(office_region.length < 2){
					alert("Please select office region.!!");
					$(
					"#new_bill_application_office_region").focus()
					//console.log("length selected1")
					return false;
				}
             	
             //	console.log(on_application_client_name);
        		 $.ajax({
     				 type: "POST",
     				 url: "Case_Management_Serv",
     				// target:'_blank',
     				
     					 data: {
     	                	request_type: 'process_online_select_bill_for_registration',
     	                	main_service_id:main_service_id,
     	                	main_service_sub_id:sub_service_id,
     	                	main_service_desc:main_service_name,
     	                	main_service_sub_desc:sub_service_name,
     	                	client_name:on_application_client_name,
     	                	case_number:new_bill_application_case_number,
     	                	land_size:new_land_size,
     	                	registration_forms:new_bill_registration_forms,
     	                	publication_type:new_bill_publication_type,
     	                	type_of_use:new_bill_type_of_use,
     	                	licensed_surveyor_number:new_bill_application_ls_number,
     	                	licensed_surveyor_name:new_bill_application_surveyors_name_oncase,
     	                	revenue_item:new_type_of_revenue_item,
     	                	locality:new_bill_locality_on_case,
     	                	ar_gender:'',
     	                	ar_district:'',
     	                	ar_region:'',
     	                	paper_size:0,
     	                	no_of_copy:new_number_of_copies,
     	                	office_region:office_region,
     	                	submission_type:'Office',
     	                	surveyors_client:'-',
     	                	created_for:created_for,
     	                	created_for_id:created_for_id,
     	                	application_required_additional_bill:application_required_additional_bill},
     				 cache: false,
     				// responseType: 'arraybuffer',
             		//dataType:'blob',
             			xhrFields:{
      	                responseType: 'blob'
      	            },
     				 beforeSend: function () {
     					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     				 },
     				 success: function(jobdetails) {
     					 console.log(jobdetails);
       					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
       				
       					
       					var blob = new Blob([jobdetails], {type: "application/pdf"});
       			        var objectUrl = URL.createObjectURL(blob);
       			      window.open(objectUrl);
       			      
       			      
       					 console.log(jobdetails);
       				       					  
     					 $('#addNewserviceBillModalonCase').modal('hide');
     					  
     				 }
     				 });  
     		 });
     		 
     		function base64ToArrayBuffer(base64) {
     		    var binaryString = window.atob(base64);
     		    var binaryLen = binaryString.length;
     		    var bytes = new Uint8Array(binaryLen);
     		    for (var i = 0; i < binaryLen; i++) {
     		       var ascii = binaryString.charCodeAt(i);
     		       bytes[i] = ascii;
     		    }
     		    return bytes;
     		 }
     		
     		function saveByteArray(reportName, byte) {
     		    var blob = new Blob([byte], {type: "application/pdf"});
     		    var link = document.createElement('a');
     		    link.href = window.URL.createObjectURL(blob);
     		    var fileName = reportName;
     		    link.download = fileName;
     		    link.click();
     		};
     		 
     		  
            $('#main_service_cp').change(function(){
        	   // alert($(this).val());
           		var select_id = document.getElementById("main_service_cp");
            		var main_service=select_id.options[select_id.selectedIndex].value;
            		
            		const main_service_name_id = main_service.split('-');
  
         			var main_service_id = main_service_name_id[0];
             		var main_service_name = main_service_name_id[1];
            		
            		 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'get_lc_sub_service',
        	                	},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					
        					 
        					    //console.log(jobdetails);
        					    var json_p = JSON.parse(jobdetails);
        					    var options = $("#sub_service_cp");

        				       // var options = $("#selector");
        				        options.empty();
        				        options.append(new Option("-- Select --", 0));
        				     
        					    $(json_p).each(function () {
        				          
        					    	//console.log(select_id);
        					    	//console.log(this.business_process_id);
        				          
        				         if (main_service_id ==this.business_process_id){
        				        	 if (this.business_process_on_case =='No' ){
           				        	  $('#sub_service_cp').append('<option value="' + this.business_process_sub_id + '-'+ this.business_process_sub_name +'">' + this.business_process_sub_name + '</option>');
           	        					 
           				        } 
        				        }
        				           });
        				//business_process_id	  
        				 }
        				 }); 
            		
        	})
        	
        	
        	  
         $('#sub_service_cp').change(function(){
     	    //alert($(this).val());
			        var select_id = document.getElementById("main_service_cp");
			  		var main_service=select_id.options[select_id.selectedIndex].value;
			  		const main_service_name_id = main_service.split('-');
					var main_service_id = main_service_name_id[0];
			   		var main_service_name = main_service_name_id[1];
         			
			   		var sub_select_id = document.getElementById("sub_service_cp");
         			var sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
         		
         			const sub_service_name_id = sub_service.split('-');
					var sub_service_id = sub_service_name_id[0];
			   		var sub_service_name = sub_service_name_id[1];
			   		if(main_service_name==='APPLICATION FOR REGIONAL NUMBER'){
			   			$('#reg-no-div').show();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').hide();
			   			
			   			$('#checksigs-no-div').show();
			   			$('#selectlocality-no-div').show();
			   			
			   			$('#new_bill_application_client_name').val([]);
						$('#new_bill_application_client_name').prop("readonly", false);

			   			
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR STAMPING'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').show();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').hide();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').hide();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR REGISTRATION'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').show();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').hide();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR PVLMD PLOTTING'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		

			   		if(main_service_name==='APPLICATION FOR PERMIT SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		
			   		if(sub_service_name==='APPLICATION FOR PERMIT SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		if(sub_service_name==='APPLICATION FOR ADMINISTRATIVE SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		if(sub_service_name==='APPLICATION FOR SMD SITE PLAN SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		if(sub_service_name==='APPLICATION FOR LRD SITE PLAN SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   	   $('#addNewserviceBillModal #main_service_id').val(main_service_id);
 				   $('#addNewserviceBillModal #main_service_sub_id').val(sub_service_id);
 				   $('#addNewserviceBillModal #main_service_desc').val(main_service_name);
 				   $('#addNewserviceBillModal #main_service_sub_desc').val(sub_service_name);
 				 
			   		
 					 $.ajax({
	    				 type: "POST",
	    				 url: "Case_Management_Serv",
	    				 data: {
	    	                	request_type: 'get_lc_checklist',
	    	                	main_service_id:main_service_id,
	    	                	sub_service_id:sub_service_id},
	    				 cache: false,
	    				 beforeSend: function () {
	    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	    				 },
	    				 success: function(jobdetails) {
	    					
	    						//loadingOverlay().cancel(spinHandle);
	    					 
	    					  var table = $('#new_checlist_table_billdataTable');
	    					    table.find("tbody tr").remove();
	    					
	    					    //console.log(jobdetails);
	    					    var json_p = JSON.parse(jobdetails);
	    					    
	    					    $(json_p).each(function () {
	    				               
	    								    table.append("<tr><td>" + this.business_process_checklist_name + "</td><td>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item"  id="checklistitem" value="1002" /></div>' + "</td>"
	    								    		
	    								    		    + "</tr>");
	    							        
	    				              });
	    					  
	    				 }
	    				 }); 


				if(main_service_name==='APPLICATION FOR STAMPING'){
			   		
							$.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							data: {
									request_type: 'get_list_of_revenue_item_list',
									},
							cache: false,
							success: function(jobdetails) {
								console.log(jobdetails);
									var json_p = JSON.parse(jobdetails);
									var options = $("#new_type_of_revenue_item");
									options.empty();
									options.append(new Option("-- Select --", 0));
								
									$(json_p).each(function () {
									
										//if (sub_service_id ==this.is_inspection_required){
										$('#new_type_of_revenue_item').append('<option value="' + this.id + '_'+ this.revenue_items_name +'">' + this.revenue_items_name + '</option>');
											
										//}
									});
							//business_process_id	  
							}
							});
			   	}
 					 
 					 
 					 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'get_type_of_forms_list',
        	                	main_service_id:main_service_id,
	    	                	sub_service_id:sub_service_id},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        						
        					 //loadingOverlay().cancel(spinHandle);
        					 
        					    console.log( 'get_type_of_forms_list: ' + jobdetails);
        					    
        					    if(jobdetails.includes('Error')){
									console.log('error : ' + jobdetails);
									//return false;
									loadingOverlay().cancel(spinHandle);
								}else{
									var json_p = JSON.parse(jobdetails);
	        					    var options = $("#new_bill_registration_forms");
	        					    
	        					    options.empty();
	        				        options.append(new Option("-- Select --", 0));
	        				        
	        				        $(json_p).each(function () {
	        				        	  $('#new_bill_registration_forms').append('<option value="' + this.form_number + '-'+ this.form_name +'">' + this.form_name + '</option>');
	        	        			});
	        				        
								}

        				 }
        				 });
 				   
         		
     	})
     	
     	     		  
            $('#main_service_on_case').change(function(){
        	 //  alert($(this).val());
           		var select_id = document.getElementById("main_service_on_case");
            		var main_service=select_id.options[select_id.selectedIndex].value;
            		
            		const main_service_name_id = main_service.split('-');
  
         			var main_service_id = main_service_name_id[0];
             		var main_service_name = main_service_name_id[1];
             		
             		
             		console.log(main_service_name);
             		if(main_service_name==='APPLICATION FOR PLAN APPROVAL'){
			   			$('#oncasereg-no-div').show();
			   			$('#oncasereglandsize-no-div').show();
			   			
			   			$('#oncasestp-no-div').hide();
			   			$('#oncasefreg-no-div').hide();
			   			$('#oncasefpublication-no-div').hide();
			   			
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR STAMPING'){
			   			$('#oncasereg-no-div').hide();
			   			$('#oncasereglandsize-no-div').hide();
			   			$('#oncasestp-no-div').show();
			   			$('#oncasefreg-no-div').hide();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR REGISTRATION'){
			   			$('#oncasereg-no-div').hide();
			   			$('#oncasereglandsize-no-div').hide();
			   			$('#oncasestp-no-div').hide();
			   			$('#oncasefreg-no-div').show();
			   		}
			   		
            		 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'get_lc_sub_service',
        	                	},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					
        					 
        					    console.log(jobdetails);
        					    var json_p = JSON.parse(jobdetails);
        					    var options = $("#sub_service_on_case");

        				       // var options = $("#selector");
        				        options.empty();
        				        options.append(new Option("-- Select --", 0));
        				     
        					    $(json_p).each(function () {
        				          
        					    	console.log(select_id);
        					    	console.log(this.business_process_id);
        				          
        				         if (main_service_id ==this.business_process_id){
        				        	  $('#sub_service_on_case').append('<option value="' + this.business_process_sub_id + '-'+ this.business_process_sub_name +'">' + this.business_process_sub_name + '</option>');
        	        					 
        				        }
        				          
        				        
        				           });
        				//business_process_id	  
        				 }
        				 }); 
            		
        	})
        	
     		
     	  	$('#NotoncaseafterPaymentModalonCaseNew').on('show.bs.modal', function (event) {

	    		 $.ajax({
   				 type: "POST",
   				 url: "Case_Management_Serv",
   				 data: {
   	                	request_type: 'get_list_of_natureofinstrument',
   	                	},
   				 cache: false,
   				 beforeSend: function () {
   					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   				 },
   				 success: function(jobdetails) {
   					
   					 
   					    console.log(jobdetails);
   					    var json_p = JSON.parse(jobdetails);
   					    var options = $("#txt_not_on_case_ap_type_of_instrument");

   				       // var options = $("#selector");
   				        options.empty();
   				        options.append(new Option("-- Select --", 0));
   				     
   					    $(json_p).each(function () {
   				          
   					    //	console.log(select_id);
   					   //	console.log(this.business_process_id);
   				          
   				       //  if (main_service_id ==this.business_process_id){
   				        	  $('#txt_not_on_case_ap_type_of_instrument').append('<option value="' + this.natureofinstrument_id + '-'+ this.natureofinstrument_id +'">' + this.natureofinstrument_name + '</option>');
   	        					 
   				       //}
   				          
   				        
   				           });
   				//business_process_id	  
   				 }
   				 });
	    		 
		  
			});
     		 
     	  	
      		 $('#lc_btn_print_rent_demand_notice').on('click', function(e) {
     	
              	var job_number = $("#cs_main_job_number").val();
            	var case_number = $("#cs_main_case_number").val();
            	var transaction_number = $("#cs_main_transaction_number").val();
              	var rent_passing_per_acres = $("#txt_lc_rent_passing_per_acre").val();
             	var rent_period_for_demand_note = $("#txt_lc_rent_period_for_demand_note").val();
              	var interest_rate = $("#txt_lc_interest_rate").val();
              	var size_of_land = $("#txt_lc_size_of_land").val();
              	txt_lc_rent_passing_per_acre
			//	var rent_passing_per_app = 0.1 *  (rent_passing_per_acres * size_of_land);
               
       
           		 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'print_rent_demand_notice',
     		                 	job_number:job_number,
     		                 	case_number:case_number,
     		                 	transaction_number:transaction_number,
     		                 	rent_passing_per_acres:rent_passing_per_acres,
     		                 	interest_rate:interest_rate,
     		                 	size_of_land:size_of_land,
     		                 	rent_passing_per_app:rent_passing_per_acres,
     		                 	rent_period_for_demand_note:rent_period_for_demand_note
     		                 	
        				 },
        				 cache: false,
        				xhrFields:{
        	                responseType: 'blob'
        	            },
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					 console.log(jobdetails);
        					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
        				
        					var blob = new Blob([jobdetails], {type: "application/pdf"});
        			        var objectUrl = URL.createObjectURL(blob);
        			      window.open(objectUrl);
        			      
        					 console.log(jobdetails);
        					  
        				 }
        				 });  
        			 
        			 
        			 
        		 });
      		 
      		 
      	  	
      		 $('#lc_btn_preview_consent_certificate_old').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
            	var case_number = $("#cs_main_case_number").val();
            	var transaction_number = $("#cs_main_transaction_number").val();
            	
              	var size_of_land = $("#txt_lc_size_of_land").val();
       
           		 $.ajax({
        				 type: "POST",
        				 url: "GenerateCaseReports",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'request_to_generate_consent_certificate',
     		                 	job_number:job_number,
     		                 	case_number:transaction_number,
     		                 	transaction_number:transaction_number
     		              
     		                 	
     		                 	
        				 },
        				 cache: false,
        				xhrFields:{
        	                responseType: 'blob'
        	            },
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					 console.log(jobdetails);
        					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
        				
        					var blob = new Blob([jobdetails], {type: "application/pdf"});
        			        var objectUrl = URL.createObjectURL(blob);
        			      window.open(objectUrl);
        					 console.log(jobdetails);
        
        					  
        				 }
        				 });  
        			 
        			 
        			 
        		 });
     	  	
     	  	
     	  	
     	   $('#lc_btn_load_lc_estate').on('click', function(e) {
     	  	
     		  var txt_lc_land_value_annual_equivalent = $("#txt_lc_land_value_annual_equivalent").val();
     		  var txt_lc_interest_rate = $("#txt_lc_interest_rate").val();

     		  var txt_lc_size_of_land = $("#txt_lc_size_of_land").val();
 				$("#txt_lc_rent_passing_per_acre").val(txt_lc_land_value_annual_equivalent * txt_lc_size_of_land);
     			
     	  });
     	   
           $('#txt_on_case_ap_list_of_lc_estates').change(function(){
        	   // alert($(this).val());
           		var select_id = document.getElementById("txt_on_case_ap_list_of_lc_estates");
            		var main_service=select_id.options[select_id.selectedIndex].value;
            		
            		const estate_name_code = main_service.split('-');
  
         			var estate_code = estate_name_code[0];
             		var estate_name = estate_name_code[1];
            		
            		 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'select_rt_rates_table_current_per_estate',
        	                	estate_code: estate_code,
        	                	},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					    console.log(jobdetails);
        					    var json_p = JSON.parse(jobdetails);
        					  

    							$('#txt_lc_rent_passing_per_acre').val(json_p.data.r_rent_passing_per_acre);
    							//$('#txt_lc_interest_rate').val(json_p.jobdetails.business_process_sub_id);
        				 }
        				 }); 
            		
            	
        	})
            
            $('#btn_load_job_details_after_payment').on('click', function(e) {
                
         		console.log('enter data');
         	//	$("#NotoncaseafterPaymentModalonCase").modal();
         		
                	var job_number = $("#txt_job_number_after_payment").val();
                	
                	
              	//	$("#NotoncaseafterPaymentModalonCase").modal();
              		
              		$("#NotoncaseafterPaymentModalonCase").modal({backdrop: 'static', keyboard: false});
                	console.log(job_number);
           		 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'select_load_details_for_payment',
        	                	job_number:job_number},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					
        					 console.log(jobdetails);
        					 
        					  var table_bp = $('#tbl_not_on_case_ap_bills_payments_dataTable');
        					  table_bp.find("tbody tr").remove();
        					    

          					  var table_cl = $('#tbl_not_on_case_after_payment_ap_checklist_dataTable');
          					table_cl.find("tbody tr").remove();
          					    
        					
        					    console.log(jobdetails);

    							var json_p = JSON.parse(jobdetails);
    							
    							$('#txt_not_on_case_ap_main_service_id').val(json_p.jobdetails.business_process_id);
    							 $('#txt_not_on_case_ap_main_service_sub_id').val(json_p.jobdetails.business_process_sub_id);
    							 $('#txt_not_on_case_ap_jn_id').val(json_p.jobdetails.jn_id);
    							 $('#txt_not_on_case_ap_main_service_desc').val(json_p.jobdetails.business_process_name);
    							 $('#txt_not_on_case_ap_main_service_sub_desc').val(json_p.jobdetails.business_process_sub_name);
    							 $('#txt_not_on_case_ap_client_name').val(json_p.jobdetails.lessees_name);
    							 $('#txt_not_on_case_ap_ar_name').val(json_p.jobdetails.lessees_name);
    							 $('#txt_not_on_case_ap_land_size').val(json_p.jobdetails.extent);
    							 $('#txt_not_on_case_ap_job_number').val(job_number);
    							 $('#txt_not_on_case_bl_txt_ar_name').val(json_p.jobdetails.lessees_name);
    							 
    							 
    							 
    							 $('#txt_not_on_case_bl_txt_ar_gender').val(json_p.jobdetails.gender);
    							 $('#txt_not_on_case_ap_district').val(json_p.jobdetails.district);
    							 $('#txt_not_on_case_ap_region').val(json_p.jobdetails.region);
    							 $('#txt_not_on_case_ap_licensed_surveyor_number').val(json_p.jobdetails.licensed_surveyor_number);
    							 $('#new_bill_application_ls_number_afp').val(json_p.jobdetails.licensed_surveyor_number);
    							 
    							 
    							 $('#txt_not_on_case_ap_licensed_surveyor_name').val(json_p.jobdetails.licensed_surveyor_name);
    							 $('#txt_not_on_case_ap_locality_of_parcel').val(json_p.jobdetails.locality);
    							 $('#txt_not_on_case_ap_type_of_use').val(json_p.jobdetails.type_of_use);
    							 
    							 
    						//	 var new_bill_land_size = $("#new_bill_land_size").val();
    							 
    							 
    							 console.log(json_p.jobdetails.business_process_name);
    								
    							 if(json_p.jobdetails.business_process_name==='APPLICATION FOR REGIONAL NUMBER'){
    						   			$('#ap-reg-no-div').show();
    						   			$('#ap-stp-no-div').hide();
    						   			
    						   			$('#ap-partysearch-no-div').hide();
    						   			
    						   			
    						   			$('#ap-typeofuse-no-div').hide();
    						   			$('#ap-selectlocality-no-div').show();
    						   			
    						   			$('#checksigs-no-div_afp').show();
    						   			
    						   			
    						   		}
    						   		
    						   		if(json_p.jobdetails.business_process_name==='APPLICATION FOR STAMPING'){
    						   			$('#ap-reg-no-div').hide();
    						   			$('#ap-stp-no-div').show();
    						   			
    						   			$('#ap-typeofuse-no-div').show();
    						   			$('#ap-selectlocality-no-div').hide();
    						   			$('#ap-partysearch-no-div').show();
    						   			$('#checksigs-no-div_afp').hide();
    						   		}
    						   		
    						   		if(json_p.jobdetails.business_process_name==='APPLICATION FOR SEARCH'){
						   			$('#ap-reg-no-div').hide();
						   			$('#ap-stp-no-div').hide();
						   			
						   			$('#ap-typeofuse-no-div').show();
						   			$('#ap-selectlocality-no-div').show();
						   			$('#ap-partysearch-no-div').show();
						   			$('#checksigs-no-div_afp').hide();
						   			} 
    						   		
    						   		/* if(json_p.jobdetails.business_process_name==='APPLICATION FOR REGISTRATION'){
    						   			$('#ap-reg-no-div').hide();
    						   			$('#ap-stp-no-div').show();
    						   			$('#ap-freg-no-div').hide();
    						   		} */
    						   		
    							
        					    $(json_p.payments).each(function () {
        					    	table_bp.append("<tr><td>" + this.bill_number + "</td><td>" +this.customer_id + "</td><td>" +this.bill_amount + "</td><td>" +this.payment_amount + "</td><td> </td><td>" +this.division + "</td>"
        							+ "</tr>");        
        				          });
        					    
        					 /*    
        					    $(json_p.payments).each(function () {
        					    	table_bp.append("<tr><td>" + this.bill_number + "</td><td>" +this.customer_id + "</td><td>" +this.bill_amount + "</td><td>" +this.payment_amount + "</td><td>" +this.division + "</td>"
        							+ "</tr>");        
        				          });
        					     */
        					    
        						 $.ajax({
        		    				 type: "POST",
        		    				 url: "Case_Management_Serv",
        		    				 data: {
        		    	                	request_type: 'get_lc_checklist',
        		    	                	main_service_id:json_p.jobdetails.business_process_id,
        		    	                	sub_service_id:json_p.jobdetails.business_process_sub_id},
        		    				 cache: false,
        		    				 beforeSend: function () {
        		    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        		    				 },
        		    				 success: function(jobdetails) {
        		    					
        		    					  var table = $('#tbl_not_on_case_after_payment_ap_checklist_dataTable');
        		    					    table.find("tbody tr").remove();
        		    					
        		    					    console.log(jobdetails);
        		    					    var json_p = JSON.parse(jobdetails);
        		    					    
        		    					    $(json_p).each(function () {
        		    				               
        		    				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');

        		    				                  
        		    								    table.append("<tr><td>" + this.business_process_checklist_name + "</td><td>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" /></div>' + "</td>"
        		    								    		
        		    								    			 
        		    								    	//	  +  '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#modalrecordinformation" data-target-id="' + this.ms_id + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
        		    								    	   
        		    								    		    + "</tr>");
        		    							        
        		    				              });
        		    					  
        		    				 }
        		    				 }); 
        					     
        				 }
        				 }); 
 			 
 			 
 		 });
 		 
            
            
    		 $('#btn_not_on_case_add_new_party').on('click', function(e) {
    	            
    	     		console.log('enter data');
    	     		
    	     		
    	           	var job_number = $("#txt_not_on_case_ap_job_number").val();
    	            //	$('#txt_not_on_case_ap_job_number').val(job_number);
    	            	
    	            	var type_of_party = $('#txt_not_on_case_bl_cbo_type_of_party').val();
    	            	var ar_name =  $('#txt_not_on_case_bl_txt_ar_name').val();
    	            	var ar_gender = $('#txt_not_on_case_bl_cbo_ar_gender').val();
    	            	var ar_cell_phone = $('#txt_not_on_case_bl_txt_ar_cell_phone').val();
    	            	var ar_id_type =  $('#txt_not_on_case_bl_cbo_ar_id_type').val();
    	            	var ar_id_number =  $('#txt_not_on_case_bl_txt_ar_id_number').val();
    	    			 
    	            	console.log(job_number);
    	            	//select_address_register_by_id_number
    	       		 $.ajax({
    	    				 type: "POST",
    	    				 url: "Case_Management_Serv",
    	    				 data: {
    	    	                	request_type: 'select_address_register_add_new',
    	    	                	case_number:job_number,
    	    	                	type_of_party:type_of_party,
    	    	                	ar_name:ar_name,
    	    	                	ar_gender:ar_gender,
    	    	                	ar_cell_phone:ar_cell_phone,
    	    	                	ar_id_type:ar_id_type,
    	    	                	ar_id_number:ar_id_number},
    	    				 cache: false,
    	    				 beforeSend: function () {
    	    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    	    				 },
    	    				 success: function(jobdetails) {
    	    					
    	    					  var table = $('#tbl_not_on_case_client_details_datatable');
    	    					    table.find("tbody tr").remove();
    	    					
    	    					    console.log(jobdetails);
    	    					    var json_p = JSON.parse(jobdetails);
    	    					    
    	    					    $(json_p).each(function () {
    	    				               
    	    				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');

    	    				                  
    	    								    table.append("<tr><td>" + this.ar_client_id + "</td><td>" +this.ar_name + "</td><td>" +this.ar_gender + "</td><td>" +this.ar_cell_phone + "</td><td>" +this.type_of_party + "</td>"
    	    								    		
    	    								    		
    	    								    			 
    	    								    	//	  +  '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#modalrecordinformation" data-target-id="' + this.ms_id + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
    	    								    	   
    	    								    		    + "</tr>");
    	    							        
    	    				              });
    	    					  
    	    				 }
    	    				 }); 
    	            	//$("#addeditparty").modal();
    	            	 // $('#addeditparty').modal('hide')
    	            	 
    	       		$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val('Party Added Successfully');
    	         
    		 }); 
    	         
 		
            
     		
     		 $('#btnsavenewparty').on('click', function(e) {
            
     		console.log('enter data');
     		
     		
            	var job_number = $("#job_number").val();
            	
            	var type_of_party = $('#bl_cbo_type_of_party').val();
            	var ar_name =  $('#bl_txt_ar_name').val();
            	var ar_gender = $('#bl_cbo_ar_gender').val();
            	var ar_cell_phone = $('#bl_txt_ar_cell_phone').val();
            	var ar_id_type =  $('#bl_cbo_ar_id_type').val();
            	var ar_id_number =  $('#bl_txt_ar_id_number').val();
    			 
            	console.log(job_number);
       		 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				 data: {
    	                	request_type: 'select_address_register_add_new',
    	                	case_number:job_number,
    	                	type_of_party:type_of_party,
    	                	ar_name:ar_name,
    	                	ar_gender:ar_gender,
    	                	ar_cell_phone:ar_cell_phone,
    	                	ar_id_type:ar_id_type,
    	                	ar_id_number:ar_id_number},
    				 cache: false,
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					
    					  var table = $('#client_details_datatable');
    					    table.find("tbody tr").remove();
    					
    					    console.log(jobdetails);
    					    var json_p = JSON.parse(jobdetails);
    					    
    					    $(json_p).each(function () {
    				               
    				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');

    				                  
    								    table.append("<tr><td>" + this.ar_client_id + "</td><td>" +this.ar_name + "</td><td>" +this.ar_gender + "</td><td>" +this.ar_cell_phone + "</td><td>" +this.type_of_party + "</td>"
    								    		
    								    		
    								    			 
    								    	//	  +  '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#modalrecordinformation" data-target-id="' + this.ms_id + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
    								    	   
    								    		    + "</tr>");
    							        
    				          });
    					  
    				 }
    				 }); 
            	//$("#addeditparty").modal();
            	  $('#addeditparty').modal('hide')
            	  // $('#form_inspection').modal('hide');
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val('Party Added Successfully');
            }); 
         
     		 
    		 $('#party_ar_type_of_party_gen').change(function(){
    			 console.log('Changed');
    		 
    			 var ar_person_type = $("#party_ar_type_of_party_gen").children("option:selected").val();
    			 if(ar_person_type=='Grantor'){
    				 $('#grantor-family-div').show();
    			 }else{
    				 $('#grantor-family-div').hide();
    			 }
    		 });
    		 
    		 $('#addeditpartyGeneral').on('show.bs.modal', function(e) {
    			 	var party_id ='';
    			    //get data-id attribute of the clicked element
    			    var party_id = $(e.relatedTarget).data('target-id');
					//console.log("party_id=" + party_id); 
    			    //populate the textbox
    			    $('#party_id_gen').val(party_id);
    			    
    			    $("#party_ar_name_gen").val($(e.relatedTarget).data('ar_name')); 
               		$("#party_ar_gender_gen").val($(e.relatedTarget).data('ar_gender')); 
               		$("#party_ar_cell_phone_gen").val($(e.relatedTarget).data('ar_cell_phone'));
               		$("#party_ar_cell_phone2_gen").val($(e.relatedTarget).data('ar_cell_phone2'));
               		$("#party_ar_nationality_gen").val($(e.relatedTarget).data('ar_nationality'));
               		$("#party_ar_address_gen").val($(e.relatedTarget).data('ar_address'));
               		$("#party_ar_tin_no_gen").val($(e.relatedTarget).data('ar_tin_no')); 
               		$("#party_ar_id_type_gen").val($(e.relatedTarget).data('ar_id_type')); 
               		$("#party_ar_id_number_gen").val($(e.relatedTarget).data('ar_id_number'));
               		$("#party_ar_type_of_party_gen").val($(e.relatedTarget).data('type_of_party'));  
               		$("#party_ar_location_gen").val($(e.relatedTarget).data('ar_location')); 
               		$("#party_ar_district_gen").val($(e.relatedTarget).data('ar_district'));
               		$("#party_ar_region_gen_gen").val($(e.relatedTarget).data('ar_region')); 
               		$("#party_ar_person_type_gen").val($(e.relatedTarget).data('ar_person_type')); 
    			    
    		 });
			 

			 $('#deletepartyGeneral').on('show.bs.modal', function(e) {
    			 	var party_id ='';
    			    //get data-id attribute of the clicked element
    			    var party_id = $(e.relatedTarget).data('target-id');
					//console.log("party_id=" + party_id); 
    			    //populate the textbox
    			    $('#party_id_gen_d').val(party_id);
    			    
    			    $("#party_ar_name_gen_d").val($(e.relatedTarget).data('ar_name')); 
               		$("#party_ar_gender_gen").val($(e.relatedTarget).data('ar_gender')); 
               		$("#party_ar_cell_phone_gen").val($(e.relatedTarget).data('ar_cell_phone'));
               		$("#party_ar_cell_phone2_gen").val($(e.relatedTarget).data('ar_cell_phone2'));
               		$("#party_ar_nationality_gen").val($(e.relatedTarget).data('ar_nationality'));
               		$("#party_ar_address_gen").val($(e.relatedTarget).data('ar_address'));
               		$("#party_ar_tin_no_gen").val($(e.relatedTarget).data('ar_tin_no')); 
               		$("#party_ar_id_type_gen").val($(e.relatedTarget).data('ar_id_type')); 
               		$("#party_ar_id_number_gen").val($(e.relatedTarget).data('ar_id_number'));
               		$("#party_ar_type_of_party_gen").val($(e.relatedTarget).data('type_of_party'));  
               		$("#party_ar_location_gen").val($(e.relatedTarget).data('ar_location')); 
               		$("#party_ar_district_gen").val($(e.relatedTarget).data('ar_district'));
               		$("#party_ar_region_gen_gen").val($(e.relatedTarget).data('ar_region')); 
               		$("#party_ar_person_type_gen").val($(e.relatedTarget).data('ar_person_type')); 
					$("#party_p_uid").val($(e.relatedTarget).data('p_uid'));
					$("#party_ar_id").val($(e.relatedTarget).data('ar_id'));
    			    
    		 });

			 $('#confirmDeletePartyGeneral').on('click', function(e) {
				e.preventDefault();

				var ar_client_id =  $('#party_id_gen_d').val();
				var case_number = $("#fe_transaction_number").val() == undefined ? $("#cs_main_transaction_number").val() : $("#fe_transaction_number").val();
				var job_number = $("#fe_job_number").val();
				var ar_id = $("#party_ar_id").val();
				var p_uid = $("#party_p_uid").val();

 $.ajax({
          				 type: "POST",
          				 url: "Case_Management_Serv",
          				 data: {
          	                	request_type: 'select_delete_party',
          	                	ar_client_id: ar_client_id,
          	                	case_number:case_number,
								  job_number: job_number,
								  ar_id: parseInt(ar_id),
								  p_uid: parseInt(p_uid)
                    				
          				 },
          				 cache: false,
          				 beforeSend: function () {
          					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
          				 },
          				 success: function(jobdetails) {

							 //$("#addeditparty").modal();
							 $('#deletepartyGeneral').modal('toggle')
                  	  // $('#form_inspection').modal('hide');
	 				  $("#general_message_dialog").modal();

							$('#general_message_dialog #general_message_dialog_msg_new').val('Party Deleted Successfully');
          				  
          				 }
          				 }); 

			 })
     		
     		 $('#btnsavenewpartyGeneral').on('click', function(e) {
                 
           		console.log('enter data for parties');
           		var ar_client_id = $("#party_id_gen").val(); 
           		var ar_name = $("#party_ar_name_gen").val(); 
           		var ar_gender = $("#party_ar_gender_gen").children("option:selected").val(); 
           		var ar_cell_phone = $("#party_ar_cell_phone_gen").val();
           		var ar_cell_phone2 = $("#party_ar_cell_phone2_gen").val();
           		var ar_nationality = $("#party_ar_nationality_gen").children("option:selected").val();
           		var ar_address = $("#party_ar_address_gen").val();
           		var ar_tin_no = $("#party_ar_tin_no_gen").val(); 
           		var ar_id_type = $("#party_ar_id_type_gen").children("option:selected").val(); 
           		var ar_id_number = $("#party_ar_id_number_gen").val();
           		var ar_type_of_party = $("#party_ar_type_of_party_gen").children("option:selected").val();  
           		var ar_location = $("#party_ar_location_gen").val(); 
           		var ar_district = $("#party_ar_district_gen").children("option:selected").val();
           		var ar_region = $("#party_ar_region_gen_gen").children("option:selected").val(); 
           		var ar_person_type = $("#party_ar_person_type_gen").children("option:selected").val(); 
           		console.log("selected party :"  +ar_type_of_party);
           		//set the grantor family and stool anmes
           		$('#fe_family_name').val($('#family_name_gen').val());
           		$('#fe_grantor_family').val( $('#grantor_family_gen').val());
           		 
           		var created_by = localStorage.getItem('fullname'); 
           		var created_by_id = localStorage.getItem('userid'); 


           		var case_number = $("#fe_transaction_number").val() == undefined ? $("#cs_main_transaction_number").val() : $("#fe_transaction_number").val();
				   console.log("name is " + case_number)
           		
           		if(ar_client_id ==""){
           			var request_type = 'select_address_register_add_new_general';
           		}else {var request_type = 'select_address_register_edit_general'}
           		//console.log("name is " + ar_name)
          			 
             		 $.ajax({
          				 type: "POST",
          				 url: "Case_Management_Serv",
          				 data: {
          	                	request_type: request_type,
          	                	ar_client_id: ar_client_id,
          	                	case_number:case_number,
          	                	type_of_party:ar_type_of_party,
          	                	ar_name:ar_name,
          	                	ar_gender:ar_gender,
          	                	ar_cell_phone:ar_cell_phone,
          	                	ar_cell_phone2:ar_cell_phone2,
          	                	ar_nationality: ar_nationality,
 		                   		ar_address :ar_address,
 		                   		ar_tin_no :ar_tin_no, 
 		                   		ar_id_type :ar_id_type,
 		                   		ar_id_number :ar_id_number,
 		                   		ar_location :ar_location, 
 		                   		ar_district :ar_district, 
 		                   		ar_region :ar_region,
 		                   		ar_person_type :ar_person_type,
 								created_by :created_by, 
                    				created_by_id:created_by_id
                    				
          				 },
          				 cache: false,
          				 beforeSend: function () {
          					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
          				 },
          				 success: function(jobdetails) {
          					
          					var table = $('#party_details_datatable');
      					   table.find("tbody tr").remove();
          					
          					    console.log(jobdetails);
          					    var json_p = JSON.parse(jobdetails);
          					    
          					  if(this.data =='Success'){
									
								}
								else{
									
								
          					    
          					    $(json_p).each(function () {
          				               
          								    table.append("<tr><td>" + this.ar_name + "</td><td>" + this.ar_gender + "</td><td>" + this.ar_cell_phone  + "</td><td>" + this.type_of_party + "</td>"
          								    		
          								    			 
          								   +  '<td>' 
    								    	  +'<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
    								    	  +'data-target="#addeditpartyGeneral"'
    								    	  + '  	data-target-id="' + this.ar_client_id 
      								    	  +'"  data-ar_name="' + this.ar_name 
      								    	  +'"  data-ar_gender="' + this.ar_gender 
      								    	  +'"  data-ar_address="' + this.ar_address 
      								    	  +'"  data-ar_cell_phone="' + this.ar_cell_phone 
      								    	  +'" data-ar_cell_phone2="' + this.ar_cell_phone2
      								    	  +'" data-ar_tin_no="' + this.ar_tin_no 
      								    	  +'" data-ar_id_type="' + this.ar_id_type 
      								    	  +'" data-ar_id_number="' + this.ar_id_number
      								    	  +'" data-ar_location="' + this.ar_location 
      								    	  +'" data-ar_district="' + this.ar_district 
	      								      +'" data-ar_region="' + this.ar_region
	      								      +'" data-type_of_party="' + this.type_of_party
      								    	  +'" data-ar_person_type="' + this.ar_person_type
      								    	  + '"> ' 
    								    	  +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>'
											  
    								    	  +'<button class="btn btn-danger btn-icon-split ml-1" data-title="Delete"  data-toggle="modal"'
    								    	  +'data-target="#deletepartyGeneral"'
    								    	  + '  	data-target-id="' + this.ar_client_id 
      								    	  +'"  data-ar_name="' + this.ar_name 
      								    	  +'"  data-ar_gender="' + this.ar_gender 
      								    	  +'"  data-ar_address="' + this.ar_address 
      								    	  +'"  data-ar_cell_phone="' + this.ar_cell_phone 
      								    	  +'" data-ar_cell_phone2="' + this.ar_cell_phone2
      								    	  +'" data-ar_tin_no="' + this.ar_tin_no 
      								    	  +'" data-ar_id_type="' + this.ar_id_type 
      								    	  +'" data-ar_id_number="' + this.ar_id_number
      								    	  +'" data-ar_location="' + this.ar_location 
      								    	  +'" data-ar_district="' + this.ar_district 
	      								      +'" data-ar_region="' + this.ar_region
	      								      +'" data-type_of_party="' + this.type_of_party
      								    	  +'" data-ar_person_type="' + this.ar_person_type
												+'" data-p_uid="' + this.p_uid
      								    	  +'" data-ar_id="' + this.ar_id
      								    	  + '"> ' 
    								    	  +'<span class="icon text-white-50"> <i class="fas fa-trash"></i></span> <span class="text">Delete</span>  </button></td>'
    								    	   
    					                      + "</tr>");
          									
										
          				              });
								}
          					  
          				 }
          				 }); 
                  	  //$("#addeditparty").modal();
                  	  $('#addeditpartyGeneral').modal('toggle')
                  	  // $('#form_inspection').modal('hide');
	 				  $("#general_message_dialog").modal();
	 				  //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
	 				  $('#general_message_dialog #general_message_dialog_msg_new').val('Party Added/Edited Successfully');

        });  
     		 
     		 /*  */
     		 
    /* ===============================================END NEW UPDATE JUDE ========================================================================  */	 
     		 
     		     
     $('#addcoordinatetoplot').on('show.bs.modal', function (event) {
				
				  /* $('#addcoordinatetoplot #bl_coordiante_name').val([]);
				  $('#addcoordinatetoplot #bl_X_coordinate').val([]);
				  $('#addcoordinatetoplot #bl_y_coordinate').val([]); */
	    	});
     		     
     	$("#btnaddcoordinatelist").click(function(event){
     		console.log('Add coor');
			  var  x_coordinate_name =  $('#ac_coordinate_name').val();
			  var  x_coordinate_mak =  $('#ac_x_coordinate').val();
			 var  y_coordinate_mak =  $('#ac_y_coordinate').val();
  		
			  var table = $('#coordinatelis_Table');
			
	    table.append("<tr><td>" + x_coordinate_name + "</td><td>" + x_coordinate_mak + "</td><td>" + y_coordinate_mak + "</td>"
	    		
	    		
	    	//	+  '<td><p data-placement="top" data-toggle="tooltip" title="Milestone"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" ' + result.job_number + ' id="btnmilestoneslist"><span class="fas fa-check"></span></button></p> </td>'
	    		 
	    		  +  '<td><span class="table-remove"><button type="button" class="btn btn-danger btn-rounded btn-sm my-0">Remove</button></span></td>'
	    		   
	    		    + "</tr>");
	    
	    
	   
	    
	    $('#addcoordinatetoplot').modal('hide');
	 
	    
        });
     	 const $tableID = $('#coordinatelis_Table'); const $BTN = $('#export-btn'); const $EXPORT = $('#export');
        
        $('#btn_card_number_search').on('click', function(e) { 
        	
        	var id_number = $("#id_card_number_search").val();
        	console.log(id_number);
   		 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'select_address_register_by_id_number',
	                	id_number:id_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					 var json_p = JSON.parse(jobdetails);
					
					  
					 if (json_p.data === null){
						// $("#addeditparty").modal();
						 $('#addeditparty').modal({
							  closeExisting: false
						});
					 }else{

						 $(json_p.data).each(function () {
							 
							 $('#client_name_search').val(this.ar_name);
							 $('#client_id_search').val(this.ar_client_id);
						 }) 
					
					 }
				 }
				 }); 
        //	
        });
        
   $('#btn_load_scanned_documents').on('click', function(e) { 
	   
			 var table_docs = $('#lc_scanned_documents_dataTable');
			table_docs.find("tbody tr").remove(); 	
			
			
			
			 var table_docs_mains = $('#lc_main_scanned_documents_dataTable');
			 table_docs_mains.find("tbody tr").remove(); 
	   
        	var case_number = $("#cs_main_case_number").val();
        	//console.log(case_number);
   		 $.ajax({
				 type: "POST",
				 url: "LoadLRDJackets",
				 data: {
	                	request_type: 'load_case_scanned_document_new',
	                	case_number:case_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(serviceresponse) {
					// if(!serviceresponse){
					// 	return;
					// }
					try{
						var json_p = JSON.parse(serviceresponse);
						//console.log(json_p)
											
						
						 $(json_p).each(function () {
						        
							 table_docs.append("<tr><td>" + this.doc_description + "</td><td>" +this.document_extention + "</td>"
									 +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td>'

							    		    + "</tr>");

							 table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

					    		    + "</tr>");

						 });

					}catch(e){
													console.log(e)
												}
					
					  
				 }
				 }); 
        //	
        });

		

		$('#view_existing_records_info').on('click', function(e) { 

			$("#exreinfo_table").removeClass('d-none');
	  
	   var table_docs_mains = $('#lc_main_scanned_documents_dataTable__');
	   table_docs_mains.find("tbody tr").remove(); 
 
	  var case_number = $("#cs_main_case_number").val();
	  //console.log(case_number);
	  $.ajax({
		   type: "POST",
		   url: "LoadLRDJackets",
		   data: {
				  request_type: 'load_case_scanned_document_new',
				  case_number:case_number},
		   cache: false,
		   beforeSend: function () {
			  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		   },
		   success: function(serviceresponse) {
			  // if(!serviceresponse){
			  // 	return;
			  // }
			  try{
				  var json_p = JSON.parse(serviceresponse);
				  //console.log(json_p)
									  
				  
				   $(json_p).each(function () {
					   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

							  + "</tr>");

				   });

			  }catch(e){
											  console.log(e)
										  }
			  
				
		   }
		   }); 
  //	
  });

  $('#view_existing_records_info_').on('click', function(e) { 

$("#exreinfo_table_").removeClass('d-none');

var table_docs_mains = $('#lc_main_scanned_documents_dataTable___');
table_docs_mains.find("tbody tr").remove(); 

var case_number = $("#cs_main_case_number").val();
//console.log(case_number);
$.ajax({
type: "POST",
url: "LoadLRDJackets",
data: {
	  request_type: 'load_case_scanned_document_new',
	  case_number:case_number},
cache: false,
beforeSend: function () {
  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
},
success: function(serviceresponse) {
  // if(!serviceresponse){
  // 	return;
  // }
  try{
	  var json_p = JSON.parse(serviceresponse);
	  //console.log(json_p)
						  
	  
	   $(json_p).each(function () {
		   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

				  + "</tr>");

	   });

  }catch(e){
								  console.log(e)
							  }
  
	
}
}); 
//	
});

		$('#btn_load_scanned_documents_').on('click', function(e) { 
	   
	   var table_docs = $('#lc_scanned_documents_dataTable_');
	  table_docs.find("tbody tr").remove(); 	
	  
	  
	  
	   var table_docs_mains = $('#lc_main_scanned_documents_dataTable_');
	   table_docs_mains.find("tbody tr").remove(); 
 
	  var case_number = $("#cs_main_case_number").val();
	  //console.log(case_number);
	  $.ajax({
		   type: "POST",
		   url: "LoadLRDJackets",
		   data: {
				  request_type: 'load_case_scanned_document_new',
				  case_number:case_number},
		   cache: false,
		   beforeSend: function () {
			  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		   },
		   success: function(serviceresponse) {
			  // if(!serviceresponse){
			  // 	return;
			  // }
			  try{
				  var json_p = JSON.parse(serviceresponse);
				  //console.log(json_p)
									  
				  
				   $(json_p).each(function () {
						  
					   table_docs.append("<tr><td>" + this.doc_description + "</td><td>" +this.document_extention + "</td>"
							   +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td>'

									  + "</tr>");

					   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

							  + "</tr>");

				   });

			  }catch(e){
											  console.log(e)
										  }
			  
				
		   }
		   }); 
  //	
  });


  
		$('#btn_load_scanned_documents_ts').on('click', function(e) { 

	   var table_docs_mains = $('#lc_main_scanned_documents_dataTable_ts');
	   table_docs_mains.find("tbody tr").remove(); 
 
	  var case_number = $("#ts_main_case_number_sm").val();
	  //console.log(case_number);
	  $.ajax({
		   type: "POST",
		   url: "LoadLRDJackets",
		   data: {
				  request_type: 'load_case_scanned_document_new',
				  case_number:case_number},
		   cache: false,
		   beforeSend: function () {
			  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		   },
		   success: function(serviceresponse) {
			  
			   var json_p = JSON.parse(serviceresponse);
				  //console.log(json_p)
									  
				  try{
				   $(json_p).each(function () {
					   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.document_name + '</a></td><td>' +this.document_extention + '</td>' 

							  + "</tr>");

				   });

				}catch(e){
													console.log(e)
												}
				
		   }
		   }); 
  //	
  });
        
   
  var lc_main_scanned_documents_dataTable = $('#lc_main_scanned_documents_dataTable').DataTable();
  var lc_scanned_documents_dataTable = $('#lc_scanned_documents_dataTable').DataTable();

  
  
  
  
  $('#lc_main_scanned_documents_dataTable, #lc_main_scanned_documents_dataTable_ts, #lc_main_scanned_documents_dataTable_, #lc_main_scanned_documents_dataTable__, #lc_main_scanned_documents_dataTable___').on('click', '.link-post', function(e){
	//  console.log(e)

	  e.preventDefault();
var file_to_open = e.target.href;
  console.log(file_to_open);
var file_path = file_to_open.replace("file:///", "");
	 console.log(file_path);
var URL_map = file_to_open;
var newURL = URL_map.replace(/^[a-z]{4,5}\:\/{2}[a-z]{1,}\:[0-9]{1,4}.(.*)/, '$1');
console.log('newURL');
console.log(newURL);
	 
var urlObj = new URL(file_to_open);
var newURL1 = urlObj.href.replace(urlObj.origin, '');
console.log(newURL1);
	 
	  var fileName, fileExtension;
//fileName = file_path;
fileName = file_path;
fileExtension = fileName.replace(/^.*\./, '');
console.log (fileExtension);
	  

		 $.ajax({
				 type: "POST",
				 url: "open_pdffile_new",
				// target:'_blank',
				 data: {
					 //request_type: 'request_to_generate_batch_list',
					 request_type: 'request_to_generate_batch_list',
					 file_to_open:newURL,
						 file_path: newURL1,
						 file_extension: fileExtension,
						 file_to_open: newURL
	           },
				 cache: false,
				xhrFields:{
	                responseType: 'blob'
	            },
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					console.log(jobdetails);
						if(fileExtension==="zip"){
 						
							var blob = new Blob([jobdetails], {type: "application/zip"});
	          			        var objectUrl = URL.createObjectURL(blob);
	          			   		 window.open(objectUrl);
 						}else{
 							
 							$('#elisDocumentPreview').modal({
 		     	    	 			 backdrop: 'static',
 		     	    				});
 		          				
 		          					
 							//const file = new File([blob], 'untitled', { type: blob.type })
 							
 							var blob = new Blob([jobdetails], {type: "application/pdf"});
 		          			        var objectUrl = URL.createObjectURL(blob);
 		          			   // window.open(objectUrl);

 									$(
 											'#elisdovumentpreviewblobfile')
 											.attr('src',
 													objectUrl);
 									
 									$(
 									'#fedocumentPreviewblobfile')
 									.attr('src',
 											objectUrl);
 						}
					
					  
				 }
				 });  
	  
	});
   
  $('#lc_scanned_documents_dataTable').on('click', '.link-post', function(e){
		//  console.log(e)
		  e.preventDefault();

		  var file_to_open = event.target.href;
		  var file_path = file_to_open.replace("file:///", "");
		  
			 $.ajax({
					 type: "POST",
					 url: "open_pdffile",
					// target:'_blank',
					 data: {
						 request_type: 'request_to_generate_batch_list',
						 file_path: file_path
		           },
					 cache: false,
					xhrFields:{
		                responseType: 'blob'
		            },
					 beforeSend: function () {
						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
					 },
					 success: function(jobdetails) {
						 console.log(jobdetails);
						// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
					
						
						
						$('#elisDocumentPreview').modal({
     	    	 			 backdrop: 'static',
     	    				});
          				
          					var blob = new Blob([jobdetails], {type: "application/pdf"});
          			        var objectUrl = URL.createObjectURL(blob);
          			   // window.open(objectUrl);

							$(
									'#elisdovumentpreviewblobfile')
									.attr('src',
											objectUrl);
				        
					 }
					 });  
		  
		});
	   
  $('#lrd_scanned_documents_dataTable').on('click', '.link-post', function(e){
		//  console.log(e)
		  e.preventDefault();
		  var file_to_open = event.target.href;
		 //C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
		 
		 console.log(file_to_open);
		 
		 lrd_scanned_documents_dataTable
		 
		 //var str = "Visit Microsoft!";
		  var file_path = file_to_open.replace("file:", "");
		//  var file_path = file_to_open.replace("file:///", "");
		  
			 $.ajax({
					 type: "POST",
					 url: "open_pdffile",
					// target:'_blank',
					 data: {
						 request_type: 'request_to_generate_batch_list',
						 file_path: file_path
		           },
					 cache: false,
					xhrFields:{
		                responseType: 'blob'
		            },
					 beforeSend: function () {},
					 success: function(jobdetails) {
						 console.log(jobdetails);
						// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
						$('#elisDocumentPreview').modal({
     	    	 			 backdrop: 'static',
     	    				});
          				
          					var blob = new Blob([jobdetails], {type: "application/pdf"});
          			        var objectUrl = URL.createObjectURL(blob);
							$(
									'#elisdovumentpreviewblobfile')
									.attr('src',
											objectUrl);
					 }
					 });  
		});
   
   $('#btn_generate_case_file_number').on('click', function(e) { 
   	var case_number = $("#cs_main_case_number").val();
   	//console.log(id_number);
		 $.ajax({
			 type: "POST",
			 url: "Case_Management_Serv",
			 data: {
               	request_type: 'auto_generate_file_number',
               	vr_type_of_number:'LRDFileNumber',
               	case_number:case_number},
			 cache: false,
			 beforeSend: function () { },
			 success: function(jobdetails) {
				
				console.log(jobdetails);
				 $('#case_file_number').val(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val('File Number has been generated Successfully');
			 }
			 }); 
   });
   
   $('#lc_btn_save_search_report').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details").val();
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary',
	               	search_report:search_report,
	               	case_number:case_number,
	               	job_number:job_number},
				 cache: false,
				 beforeSend: function () {},
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
				 }
				 }); 
	   });

	   $('#lc_btn_save_search_report_2').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details_2").val();
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary',
	               	search_report:search_report,
	               	case_number:case_number,
	               	job_number:job_number},
				 cache: false,
				 beforeSend: function () {},
				 success: function(jobdetails) {
					console.log(jobdetails);
					$("#general_message_dialog").modal();
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
				 }
				 }); 
	   });

	   $('#lc_btn_save_search_report_3').on('click', function(e) { 
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details_3").val();
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary',
	               	search_report:search_report,
	               	case_number:case_number,
	               	job_number:job_number},
				 cache: false,
				 beforeSend: function () {},
				 success: function(jobdetails) {
					console.log(jobdetails);
					$("#general_message_dialog").modal();
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
				 }
				 }); 
	   //	
	   });
   
   $('#lc_btn_save_search_report_final').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details_final").val();
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary',
	               	search_report:search_report,
	               	case_number:case_number,
	               	job_number:job_number},
				 cache: false,
				 beforeSend: function () {},
				 success: function(jobdetails) {
					console.log(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
				 }
				 }); 
	   });
   $('#btn_lc_save_parcel_for_search').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var wkt_polygon = $("#lc_bl_wkt_polygon").val() == undefined ? $("#lc_fr_bl_wkt_polygon").val() : $("#lc_bl_wkt_polygon").val();
	  	
	  	 var send_by_id = localStorage.getItem('userid');
        var send_by_name = localStorage.getItem('fullname');
	  	
	   	console.log(job_number,case_number, wkt_polygon, send_by_id, send_by_name );
			 $.ajax({
				 type: "POST",
				 url: "Maps",
				 data: {
	               	request_type: 'select_save_spatial_objects_undergoing_registration',
	               	wkt_polygon:wkt_polygon,
	               	case_number:case_number,
	               	job_number:job_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					 //var json_p = JSON.parse(jobdetails);
					
					// $('#case_file_number').val(jobdetails);
				//	alert(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
				 }
				 }); 
	   //	
	   });
  
   
   $('#btn_lc_save_parcel_undergoing_registration').on('click', function(e) { 
	   	 
	   var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
	  	
	  	 var send_by_id = localStorage.getItem('userid');
         var send_by_name = localStorage.getItem('fullname');
	  	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Maps",
				 data: {
	               	request_type: 'select_save_spatial_objects_undergoing_registration',
	               	wkt_polygon:wkt_polygon,
	               	case_number:case_number,
	               	job_number:job_number,
	               	fullname:send_by_name,
	               	userid:send_by_id},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					
					 $('#txt_glpin').val(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val('Parcel has been  saved successful');
				 }
				 }); 
	   //	
	   });
   
   
   
   $('#lc_btn_save_details_at_title_plan').on('click', function(e) { 
		var case_number = $("#cs_main_case_number").val();
		var job_number = $("#cs_main_job_number").val();
		
	   	var txt_lc_size_of_land = $("#txt_lc_size_of_land").val();
		var txt_lc_plan_no = $("#txt_lc_plan_no").val();
		var txt_lc_registration_district_number = $("#txt_lc_registration_district_number").val();
		var txt_lc_registration_section_number = $("#txt_lc_registration_section_number").val();
	  	var txt_lc_registration_block_number = $("#txt_lc_registration_block_number").val();
	  	var txt_lc_ltr_plan_no = $("#txt_lc_ltr_plan_no").val();
		var txt_lc_registry_mapref = $("#txt_lc_registry_mapref").val();
		var txt_lc_cc_no = $("#txt_lc_cc_no").val();
	  	 var send_by_id = localStorage.getItem('userid');
         var send_by_name = localStorage.getItem('fullname');
      
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'select_lrd_registration_processing_update_parcel_plan',
	             	case_number:case_number,
	               	job_number:job_number,
	               	size_of_land:txt_lc_size_of_land,
	               	plan_no:txt_lc_plan_no,
	               	registration_district_number:txt_lc_registration_district_number,
	               	registration_section_number:txt_lc_registration_section_number,
	               	registration_block_number:txt_lc_registration_block_number,
	               	ltr_plan_no:txt_lc_ltr_plan_no,
	               	registry_mapref:txt_lc_registry_mapref,
	               	cc_no:txt_lc_cc_no,
	               	fullname:send_by_name,
	               	userid:send_by_id},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					 //var json_p = JSON.parse(jobdetails);
					
					// $('#case_file_number').val(jobdetails);
					//alert(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
				 }
				 }); 
	   //	
	   });
    

   $('#lc_btn_add_to_publication_list').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	
	  	 var send_by_id = localStorage.getItem('userid');
       var send_by_name = localStorage.getItem('fullname');
	  	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'select_add_to_publication',
	               	case_number:case_number,
	               	job_number:job_number,
	               	fullname:send_by_name,
	               	userid:send_by_id},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					 //var json_p = JSON.parse(jobdetails);
					
					// $('#case_file_number').val(jobdetails);
					//alert(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
				 }
				 }); 
	   //	
	   });
  
  
  $('#lc_btn_update_publication_date').on('click', function(e) { 
	   	
	   	var lc_txt_publicity_date = $("#lc_txt_publicity_date").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var lc_txt_publicity_date = $("#lc_txt_publicity_date").val();
	  	
	  	 var send_by_id = localStorage.getItem('userid');
      var send_by_name = localStorage.getItem('fullname');
	  	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'select_update_publication_date',
	               	case_number:case_number,
	               	publication_date:lc_txt_publicity_date,
	               	fullname:send_by_name,
	               	userid:send_by_id},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					 //var json_p = JSON.parse(jobdetails);
					
					// $('#case_file_number').val(jobdetails);
					//alert(jobdetails);
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
				 }
				 }); 
	   //	
	   });
 	//$('#btnsavenewparty').on('click', function(e) { 
 		
 		 		$('#lc_btn_check_status_of_lincense_surveyor_oncase').on('click', function(e) { 
 			var ls_number = $("#new_bill_application_ls_number_oncase").val();
 	
 		   //	console.log(id_number);
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_Management_Serv",
 					 data: {
 		               	request_type: 'select_load_details_of_licenced_surveyor',
 		             	ls_number:ls_number},
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
 						console.log(jobdetails);
 						
 						if(jobdetails==="Error in loading Data "){
 							alert('Surveyor number does not exist, or Surveyor is not in good standing')
 							return false;
 						}else{
 							var json_p = JSON.parse(jobdetails);
 	 						console.log(json_p);
 	 						// $('#case_file_number').val(jobdetails);
 	 						 $('#addNewserviceBillModalonCase #new_bill_application_surveyors_name_oncase').val(json_p.licensed_surveyor_name);
 	 						 $('#addNewserviceBillModalonCase #new_bill_application_surveyors_status_oncase').val(json_p.licensed_surveyor_status);
 	 						$('#addNewserviceBillModalonCase #new_bill_application_client_id_oncase').val(json_p.licensed_surveyor_number);
 						}
 						
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		$('#lc_btn_check_status_of_lincense_surveyor').on('click', function(e) { 
 			var ls_number = $("#new_bill_application_ls_number").val();
 	
 			
 			 $('#addNewserviceBillModal #new_bill_application_surveyors_name').val([]);
				 $('#addNewserviceBillModal #new_bill_application_surveyors_status').val([]);
 			
 		   //	console.log(id_number);
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_Management_Serv",
 					 data: {
 		               	request_type: 'select_load_details_of_licenced_surveyor',
 		             	ls_number:ls_number},
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
 						console.log(jobdetails);
 						
 						var error_msg = jobdetails;
 						error_msg = error_msg.trim();
 						//alert('Surveyor number does not exist, or Surveyor is not in good standing')
 						if(error_msg==="Error in loading Data"){
 							alert('Surveyor number does not exist, or Surveyor is not in good standing')
 							//return false;
 						}else{
 							var json_p = JSON.parse(jobdetails);
 	 						//console.log(json_p);
 	 						// $('#case_file_number').val(jobdetails);
 	 						 $('#addNewserviceBillModal #new_bill_application_surveyors_name').val(json_p.licensed_surveyor_name);
 	 						 $('#addNewserviceBillModal #new_bill_application_surveyors_status').val(json_p.licensed_surveyor_status);
 	 						 
 	 						$('#addNewserviceBillModal #new_bill_application_client_id').val(json_p.licensed_surveyor_number);
	 						//$('#addNewserviceBillModal #new_bill_application_surveyors_status').val(json_p.licensed_surveyor_email);
 	 					
 						}
 						
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		
 		
 		
 		$('#lc_btn_check_status_of_lincense_surveyor_afp').on('click', function(e) { 
 			var ls_number = $("#new_bill_application_ls_number_afp").val();
 	
 			
 			 $('#addNewserviceBillModal #new_bill_application_surveyors_name').val([]);
				 $('#NotoncaseafterPaymentModalonCase #new_bill_application_surveyors_status_afp').val([]);
 			
 		   //	console.log(id_number);
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_Management_Serv",
 					 data: {
 		               	request_type: 'select_load_details_of_licenced_surveyor',
 		             	ls_number:ls_number},
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
 						//console.log(jobdetails);
 						
 						var error_msg = jobdetails;
 						error_msg = error_msg.trim();
 						//alert('Surveyor number does not exist, or Surveyor is not in good standing')
 						if(error_msg==="Error in loading Data"){
 							alert('Surveyor number does not exist, or Surveyor is not in good standing')
 							//return false;
 						}else{
 							var json_p = JSON.parse(jobdetails);
 	 						//console.log(json_p);
 	 						// $('#case_file_number').val(jobdetails);
 	 						 $('#NotoncaseafterPaymentModalonCase #new_bill_application_surveyors_name_afp').val(json_p.licensed_surveyor_name);
 	 						 $('#NotoncaseafterPaymentModalonCase #txt_not_on_case_ap_licensed_surveyor_name').val(json_p.licensed_surveyor_name);
 	 						 $('#NotoncaseafterPaymentModalonCase #new_bill_application_surveyors_status_afp').val(json_p.licensed_surveyor_status);
 	 						$('#NotoncaseafterPaymentModalonCase #new_bill_application_client_id_afp').val(json_p.licensed_surveyor_number);
 	 					
 						}
 						
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		
 		$('#lc_btn_generate_certificate_volume_folio').on('click', function(e) { 
		var case_number = $("#cs_main_case_number").val();
		var transaction_number = $("#cs_main_transaction_number").val();
		var job_number = $("#cs_main_job_number").val();
		
		
		var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
		var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
		var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
	  	 var send_by_id = localStorage.getItem('userid');
         var send_by_name = localStorage.getItem('fullname');

		//  if(!lc_txt_type_of_certificate) {
		// 	alert("Please select a certificate type");
		// 	 return;
		//  }
         
         if (confirm("Are you sure to generate certificate as "+lc_txt_type_of_certificate+"?") == true) {
	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'select_create_volume_folio_number',
	             	case_number:case_number,
					job_number:job_number,
					transaction_number:transaction_number,
	               	registration_district_number:txt_lc_registration_district_number,
	               	registration_section_number:txt_lc_registration_section_number,
					type_of_certificate:lc_txt_type_of_certificate,
	               	fullname:send_by_name,
	               	userid:send_by_id},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					var json_p = JSON.parse(jobdetails);

					if(jobdetails != ""){
						$('#lc_btn_generate_certificate_volume_folio').prop("disabled", true);
					}
					
					// $('#case_file_number').val(jobdetails);
					 $('#lc_txt_certificate_number').val(json_p.certificate_number);
					 $('#lc_txt_volume_number').val(json_p.volume);
					 $('#lc_txt_folio_number').val(json_p.folio);
					  
				            
						// $('#form_inspection').modal('hide');
	 					$("#general_message_dialog").modal();
	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
	 					$('#general_message_dialog #general_message_dialog_msg_new').val('Certifificate, Folio and Volume Numbers has been generated sucsessfully');

				 }
				 }); 
				}
	   //	
	   });
 		

	   $('#lc_btn_generate_certificate_volume_folio_mg').on('click', function(e) { 
		var case_number = $("#cs_main_case_number").val();
		var transaction_number = $("#cs_main_transaction_number").val();
		var job_number = $("#cs_main_job_number").val();
		
		
		var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
		var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
		var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
	  	 var send_by_id = localStorage.getItem('userid');
         var send_by_name = localStorage.getItem('fullname');

         if (confirm("Are you sure you want to proceed?") == true) {
	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'select_create_volume_folio_number',
	             	case_number:case_number,
					job_number:job_number,
					transaction_number:transaction_number,
	               	registration_district_number:txt_lc_registration_district_number,
	               	registration_section_number:txt_lc_registration_section_number,
					type_of_certificate:lc_txt_type_of_certificate,
	               	fullname:send_by_name,
	               	userid:send_by_id},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					console.log(jobdetails);
					var json_p = JSON.parse(jobdetails);
					
					// $('#case_file_number').val(jobdetails);
					 $('#lc_txt_certificate_number').val(json_p.certificate_number);
					 $('#lc_txt_volume_number').val(json_p.volume);
					 $('#lc_txt_folio_number').val(json_p.folio);
					  
				            
						// $('#form_inspection').modal('hide');
	 					$("#general_message_dialog").modal();
	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
	 					$('#general_message_dialog #general_message_dialog_msg_new').val('Final transaction has been confirmed successfully.');

					//alert(jobdetails);
		  
				 }
				 }); 
				}
	   //	
	   });
 		
 		$('#lc_btn_activate_final_registration').on('click', function(e) { 
 			var case_number = $("#cs_main_case_number").val();
 			
 
 		  	 var send_by_id = localStorage.getItem('userid');
 	         var send_by_name = localStorage.getItem('fullname');
 	         
 	        var verification_code = makeid(5);
 	         
 	        var message_to_send = 'Activation code for registration with Case Number ' +   case_number + ' Code:'+ verification_code;
 	       var recipient = '+233242012137,+2332034790,+233242740508,+233242012137,+233206068883,+233501322686,+233244215813,+233202023810' ;
		  	
 		   //	console.log(id_number);
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_SMS_Serv",
 					 data: {
						request_type: 'online_select_verification_code_create',
      		             	case_number:case_number,
      		             	job_number:job_number,
      		             	transaction_number:transaction_number,
							type_of_transaction:'approval_of_consolidated_search_signature'
 		              },
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
 						console.log(jobdetails);
 						$("#final_registration_approval_dialog").modal({backdrop: 'static', keyboard: false});
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		
 		$('#lc_btn_generate_activation_code').on('click', function(e) { 
 			var case_number = $("#cs_main_case_number").val();
 		 	var job_number = $("#cs_main_job_number").val();
 		  	var transaction_number = $("#cs_main_transaction_number").val();
 
 		  	 var send_by_id = localStorage.getItem('userid');
 	         var send_by_name = localStorage.getItem('fullname');
 	         
 	    
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_Management_Serv",
 					 data: {
						request_type: 'online_select_verification_code_create',
      		             	case_number:case_number,
      		             	job_number:job_number,
      		             	transaction_number:transaction_number,
							type_of_transaction:'approval_of_registration_activation_signature'
 		              },
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
						var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							$('#final_registration_approval_dialog').modal('show');

							$("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
							$("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
							$("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
							$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
							$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							$("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);

						}else {
							alert(json_p.msg);
						}
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		
 		
			$('#lc_btn_generate_activation_code_').on('click', function(e) { 
 			var case_number = $("#cs_main_case_number").val();
 		 	var job_number = $("#cs_main_job_number").val();
 		  	var transaction_number = $("#cs_main_transaction_number").val();
 
 		  	 var send_by_id = localStorage.getItem('userid');
 	         var send_by_name = localStorage.getItem('fullname');
 	         
 	    
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_Management_Serv",
 					 data: {
						request_type: 'online_select_verification_code_create',
      		             	case_number:case_number,
      		             	job_number:job_number,
      		             	transaction_number:transaction_number,
							type_of_transaction:'approval_of_registration_activation_signature'
 		              },
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
						var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							// $('#final_registration_approval_dialog').modal('show');

							// $("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
							// $("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
							// $("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
							// $("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
							// $("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							// $("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);

							alert("OTP For Approval Transaction Sent");

						}else {
							alert(json_p.msg);
						}
 			  
 					 }
 					 }); 
 		   //	
 		   });

			

			$('#lc_btn_generate_activation_code__').on('click', function(e) { 
 			var case_number = $("#cs_main_case_number").val();
 		 	var job_number = $("#cs_main_job_number").val();
 		  	var transaction_number = $("#cs_main_transaction_number").val();
 
 		  	 var send_by_id = localStorage.getItem('userid');
 	         var send_by_name = localStorage.getItem('fullname');
 	         
 	    
 				 $.ajax({
 					 type: "POST",
 					 url: "Case_Management_Serv",
 					 data: {
						request_type: 'online_select_verification_code_create',
      		             	case_number:case_number,
      		             	job_number:job_number,
      		             	transaction_number:transaction_number,
							type_of_transaction:'approval_of_registration_activation_signature'
 		              },
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
						var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							$('#final_registration_approval_dialog').modal('show');

							$("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
							$("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
							$("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
							$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
							$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							$("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);

							//alert("OTP For Approval Transaction Sent");

						}else {
							alert(json_p.msg);
						}
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		
 		
 		function makeid(length) {
 		   var result           = '';
 		   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
 		   var charactersLength = characters.length;
 		   for ( var i = 0; i < length; i++ ) {
 		      result += characters.charAt(Math.floor(Math.random() * charactersLength));
 		   }
 		   return result;
 		}

 	//============================================= Add to Process BatchList ===============================================  	
		 
 	     $('#btnProcessFirstTimeBatchlist').on('click', function(e) {
           
    		console.log('Add to batchlist');
    		
    		var batch_list_front;
    		batch_list_front = storeTblValues()
    		batch_list_front = JSON.stringify(batch_list_front)
    		console.log(batch_list_front);

    		function storeTblValues()
    		{
    		    var TableData = new Array();

    		    $('#batchlistdataTable tr').each(function(row, tr){
    		        TableData[row]={
    		            "job_number" : $(tr).find('td:eq(0)').text().trim() ,
    		            "ar_name" : $(tr).find('td:eq(4)').text().trim(),
    		            "business_process_sub_name" : $(tr).find('td:eq(3)').text().trim()
    		        }    
    		    }); 
    		    TableData.shift();  // first row will be empty - so remove
    		    return TableData;
    		}
    		
    		
    		
    		var userid_1 = $( "#user_to_send_to" ).val();  // $( "#user_to_send_to option:selected" ).text();
       	 	var  send_to_id  = $('#listofusers option').filter(function() {return this.value == userid_1; }).data('id');
       		var  send_to_name= $('#listofusers option').filter(function() {return this.value == userid_1; }).data('name');


       		console.log("sender" + send_to_name);
       		console.log("sender" + send_to_id);
       		
       		
       		
       		var userid= localStorage.getItem('userid');
	        var fullname= localStorage.getItem('fullname');
	        var division =localStorage.getItem('division');
	        
       		console.log("sent_by_id" + userid);
       		console.log("fullname" + fullname);
       		console.log("division" + division)
       		
       		
    		$.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'select_process_batchlist',
	                	division: division,
	                	userid: userid,
	                	fullname: fullname,
	                	send_to_name: send_to_name,
	                	send_to_id: send_to_id,
	                	batch_list: batch_list_front
	                  	},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(response) {
					    console.log(response)
					    
					  var json_p = JSON.parse(response);
					 
							 
							 $.ajax({
			       				 type: "POST",
			       				 url: "GenerateCaseReports",
			       				// target:'_blank',
			       				 data: {
										 request_type: 'request_to_generate_batch_list',
			           					  list_of_application: batch_list_front,
			           					  batch_number: json_p.batch_number,
			           					  modified_by : localStorage.getItem('fullname'),
			           					  modified_by_id : localStorage.getItem('userid'),
			           					send_to_name: send_to_name,
			    	                	send_to_id: send_to_id
						           },
			       				 cache: false,
			       				xhrFields:{
			       	                responseType: 'blob'
			       	            },
			       				 beforeSend: function () {
			       					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			       				 },
			       				 success: function(jobdetails) {
			       					 console.log(jobdetails);
			       					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
			       				
			       					
			       					var blob = new Blob([jobdetails], {type: "application/pdf"});
			       			        var objectUrl = URL.createObjectURL(blob);
			       			      	window.open(objectUrl);
			       			      
			       					 console.log(jobdetails);
			       					
			       					$('#NotoncaseafterPaymentModalonCase').modal('hide');
			       					  
			       				 }
			       				 });  
			
				 }
				 }); 
      		
           }); 
 	
 			//============================================= Add to Batchlist =============================================== 
			 
			 $('#askForPurposeOfSendingRequest').on('show.bs.modal', function(e) {
    			$('#req_job_number').val($(e.relatedTarget).data('job_number'));
    			$('#req_ar_name').val($(e.relatedTarget).data('ar_name'));
    			$('#req_business_process_sub_name').val($(e.relatedTarget).data('business_process_sub_name'));
				$('#req_locality').val($(e.relatedTarget).data('locality'));
			 })

			 $('#askForPurposeOfSendingRequesttoOfficer').on('show.bs.modal', function(e) {
    			$('#reqn_job_number').val($(e.relatedTarget).data('job_number'));
    			$('#reqn_ar_name').val($(e.relatedTarget).data('ar_name'));
    			$('#reqn_business_process_sub_name').val($(e.relatedTarget).data('business_process_sub_name'));
				$('#reqn_job_purpose').val($(e.relatedTarget).data('job_purpose'));
			 })

			 $('#askArchiveRequest').on('show.bs.modal', function(e) {
    			$('#arc_job_number').val($(e.relatedTarget).data('job_number'));
    			$('#arc_ar_name').val($(e.relatedTarget).data('ar_name'));
				$('#arc_rq_id').val($(e.relatedTarget).data('req_id'));
			 })
			 
 	    $('#askForPurposeOfBatching').on('show.bs.modal', function(e) {
    			$('#bl_job_number_new').val($(e.relatedTarget).data('job_number'));
    			$('#bl_ar_name_new').val($(e.relatedTarget).data('ar_name'));
    			$('#bl_business_process_sub_name_new').val($(e.relatedTarget).data('business_process_sub_name'));
				$('#bl_application_stage').val($(e.relatedTarget).data('application_stage'));
    			$('#bl_application_stage_name').val($(e.relatedTarget).data('application_stage_name'));
    			$('#bl_application_stage_baby_step').val($(e.relatedTarget).data('application_stage_baby_step'));
				$('#bl_application_stage_name_baby_step').val($(e.relatedTarget).data('application_stage_name_baby_step'));



				console.log($(e.relatedTarget).data('application_stage_name'));
    			console.log($(e.relatedTarget).data('application_stage_baby_step'));
				console.log($(e.relatedTarget).data('application_stage_name_baby_step'));

				 
				$.ajax({
    				 type: "POST",
    				 url: "app_modal_fills_serv",
    				 data: {
    	                	request_type: 'tags_for_batching_jobs_list'},
    				 cache: false,
    				 beforeSend: function () {
    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					
    					 
    					    console.log(jobdetails);
    					    var json_p = JSON.parse(jobdetails);
    					    var options = $("#bl_job_purpose_new");
							var adv_options = $("#adv_job_purpose");

    				       // var options = $("#selector");
    				        options.empty();
    				        options.append(new Option("-- Select --", 0));

							adv_options.empty();
    				        adv_options.append(new Option("-- Select --", 0));
    				     
    					    $(json_p).each(function () {
    				          
    					    //	console.log(select_id);
    					   //	console.log(this.business_process_id);
    				          
    				      //   if (main_service_id ==this.business_process_id){
    				        	  $('#bl_job_purpose_new').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');

								  $('#adv_job_purpose').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');
    	        					 
    				      //  }
    				          
    				        
    				           });  
    				 }
    				 });
     			 
           });
		   
		   $('#clientAttentionRequiredModal').on('show.bs.modal', function(e) {
    			$('#cat_job_number').val($(e.relatedTarget).data('job_number'));
    			$('#cat_ar_name').val($(e.relatedTarget).data('ar_name'));
    			$('#cat_business_process_sub_name').val($(e.relatedTarget).data('business_process_sub_name'));    		   			 
           });

 	     $('#btnaddjobtolistFinal').on('click', function(e) {
    			//console.log('Add to batchlist');
    			$('#askForPurposeOfBatching').modal('hide');
	           	var job_number = $("#bl_job_number_new").val();
	           	//var send_by_id = $("#modified_by_id").val();
	           	//var send_by =$("#modified_by").val();
	           	var ar_name = $("#bl_ar_name_new").val();
           		var business_process_sub_name =$("#bl_business_process_sub_name_new").val();
           		var job_purpose =$("#bl_job_purpose_new").val();
				var remarks_notes =$("#bl_remarks_notes").val(); 

           		console.log("job_num: " + job_number);
           		console.log("ar_name: " + ar_name);
           		console.log("business_process_sub_name: " + business_process_sub_name);
           		console.log("job_purpose: " + job_purpose);
				console.log("remarks_notes: " + remarks_notes);
           		
				if(job_purpose == 'KEEP –IN-VIEW' || !remarks_notes) {
					alert('Add remarks or notes to continue!!')
					return;
				}

           		if(job_purpose){
	           		addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,remarks_notes);
	           		
	                prepareBatchlistModal();
           		}else{
           			$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Purpose of Bacthing Required </span>',
	                }, {
	                    type: 'danger'
	                });
           		}
      		
           }); 

		   

		   $('#btnaddreqtolistFinal').on('click', function(e) {
    			//console.log('Add to batchlist');
    			$('#askForPurposeOfSendingRequest').modal('hide');
	           	var job_number = $("#req_job_number").val();
	           	//var send_by_id = $("#modified_by_id").val();
	           	//var send_by =$("#modified_by").val();
	           	var ar_name = $("#req_ar_name").val();
           		var business_process_sub_name =$("#req_business_process_sub_name").val();
           		var job_purpose =$("#req_job_purpose").val();
				var remarks =$("#req_remarks").val();
				var locality =$("#req_locality").val(); 

				console.log(job_purpose, remarks);

           		if(job_purpose && remarks){
					addRequestToList(job_number,ar_name,business_process_sub_name,locality,job_purpose,remarks);
					console.log('Add to batchlist');
	                //prepareRequestBatchingModal();
           		}else{
           			$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Purpose of Bacthing and Remarks Required </span>',
	                }, {
	                    type: 'danger'
	                });
           		}
      		
           }); 


		   $('#btnaddreqtosendlistFinal').on('click', function(e) {
    			//console.log('Add to batchlist');
    			$('#askForPurposeOfSendingRequesttoOfficer').modal('hide');
	           	var job_number = $("#reqn_job_number").val();
	           	//var send_by_id = $("#modified_by_id").val();
	           	//var send_by =$("#modified_by").val();
	           	var ar_name = $("#reqn_ar_name").val();
           		var business_process_sub_name =$("#reqn_business_process_sub_name").val();
           		var job_purpose =$("#reqn_job_purpose").val();
				var remarks = $("#reqn_remarks").val();
				var locality = ''; 

           		if(job_purpose && remarks){
					addRequestToList(job_number,ar_name,business_process_sub_name,locality,job_purpose,remarks);
	           		
	                //prepareRequestBatchingModal();
           		}else{
           			$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Remarks Required </span>',
	                }, {
	                    type: 'danger'
	                });
           		}
      		
           }); 

		   
		   $('#btnarchiverequest').on('click', function(e) {

			$("#askArchiveRequest").modal('hide');

			var rq_id = $("#arc_rq_id").val();
			var job_number = $("#arc_job_number").val();
			var note = $("#arch_note").val();
			rq_id = rq_id.replace('.0', '');



							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									   request_type: 'select_archive_application_request',
									   rq_id: rq_id,
									   job_number:job_number,
									   note : note,
										 },
								cache: false,
								success: function(response) {

									json_p = JSON.parse(response)

									if(json_p.success == true) {
										$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Request has been archived successfully. </span>',
	                }, {
	                    type: 'success'
	                });
window.location.href = "/application_review";
									}
								}

							})


		   }
		)
 	     
 	     
 	    $('#btnAddAlltoBatchlist').on('click', function(e) {
          var job_purpose =$("#txt_general_job_purpose").val();

		  var remarks_notes = $(
													"#txt_general_remarks_notes")
													.val();

													if(!job_purpose || !remarks_notes) {
													
														$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose and remarks field are required!! </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
														return;
													}
          		if(job_purpose){
		            var confirmText = "Are you sure you want to add these application to the list?";
				    if(confirm(confirmText)) {
			            $("#job_casemgtdetailsdataTableCSAU input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked , #job_casemgtdetailsdataTable_frrv input[type=checkbox]:checked , #job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked, #job_casemgtdetailsdataTable_cst input[type=checkbox]:checked, #job_casemgtdetailsdataTable_frrv_cst input[type=checkbox]:checked").each(function () {
			                var row = $(this).closest("tr")[0];
			                var job_number = row.cells[1].innerHTML;
				           	var ar_name =  row.cells[2].innerHTML;
				       		var business_process_sub_name =row.cells[3].innerHTML;
				    	 	  addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,remarks_notes);
				    	 	  
				    	 	 //console.log("testing click " + business_process_sub_name);
			            });
			            
			            $("#job_casemgtdetailsdataTable input[type=checkbox]:checked").each(function () {
			                var row = $(this).closest("tr")[0];
			                var job_number = row.cells[2].innerHTML;
				           	var ar_name =  row.cells[3].innerHTML;
				       		var business_process_sub_name =row.cells[4].innerHTML;
				    	 	  addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,remarks_notes);
			            });
			            
			            
			            prepareBatchlistModal();
			  		}
          		}else{
          			
          			$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
	                }, {
	                    type: 'danger'
	                });
          		}
          		
       	}); 
 	     
 	     
		   $('#btn_set_application_as_required_client_attention').on('click', function(e) {
         
			$('#clientAttentionRequiredModal').modal({backdrop: 'static',});
       		}); 
 	     
 	     

		   $('#btn_set_application_as_required_client_attention_1').on('click', function(e) {
          var job_purpose =$("#txt_general_job_purpose").val();
          		if(job_purpose){
		            var confirmText = "Are you sure you want to add these application to the list?";
				    if(confirm(confirmText)) {
			            $("#job_casemgtdetailsdataTableCSAU input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked , #job_casemgtdetailsdataTable_frrv input[type=checkbox]:checked , #job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked, #job_casemgtdetailsdataTable_cst input[type=checkbox]:checked, #job_casemgtdetailsdataTable_frrv_cst input[type=checkbox]:checked").each(function () {
			                var row = $(this).closest("tr")[0];
			                var job_number = row.cells[1].innerHTML;
				           	var ar_name =  row.cells[2].innerHTML;
				       		var business_process_sub_name =row.cells[3].innerHTML;
				    	 	  addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,"");
			            });
			            
			            $("#job_casemgtdetailsdataTable input[type=checkbox]:checked").each(function () {
			                var row = $(this).closest("tr")[0];
			                var job_number = row.cells[2].innerHTML;
				           	var ar_name =  row.cells[3].innerHTML;
				       		var business_process_sub_name =row.cells[4].innerHTML;
				    	 	  addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,"");
			            });
			            
			            
			            prepareBatchlistModal();
			  		}
          		}else{
          			
          			$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
	                }, {
	                    type: 'danger'
	                });
          		}
          		
       	}); 
 	    
 	  	
 	  $('#btnViewBatchlist').on('click', function(e) {
        
  		prepareBatchlistModal();
    		
     });
 	    
 	   $('#btnViewCompetedQueriedList').on('click', function(e) {
 	        
 	  		prepareCompletedQueriedModal();
 	    		
 	     });
 	   
 	  $('#btn_print_completed_queried_list').on('click', function(e) {
	        
	  		prepareCompletedQueriedModal();
	    		
	     });
 	 $('#btn_print_completed_queried_list').on('click', function () {
         var pageTitle = 'Page Title',
             stylesheet = '//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css',
             win = window.open('', 'Print', 'width=500,height=300');
         win.document.write('<html><head><title>' + pageTitle + '</title>' +
             '<link rel="stylesheet" href="' + stylesheet + '">' +
             '</head><body>' + $('#completedQueriedListdataTable')[0].outerHTML + '</body></html>');
         win.document.close();
         win.print();
         //win.close();
         return false;
     });
 	 

    });    

	var trans_unit_name = $("#trans_unit_name").val();
 		//console.log(trans_unit_name.trim())
	if(trans_unit_name !== undefined) {
	}

	$('#btnViewTransitionalCaseList').click(function() {

			var coor_tbl = $("#job_coor_tbl").DataTable({
							// responsive: true,
	
							stateSave : true,
							"createdRow" : function(row, data, dataIndex) {
								if (data[0] == "1") {
									$(row).addClass('tr-completed-work');
								}
							},
	
						});
	
						$("#transitionalcaseModal").modal('show');
						$('#job_coor_tbl').DataTable().clear().destroy();
	
						$.ajax({
	
							type : "POST",
								url : "Case_Management_Serv",
								data : {
									request_type : 'load_transitional_plotting_application_batched_to_user',
								},
								cache : false,
								success : function(jobdetails) {
	
									var json_p = JSON.parse(jobdetails);
	
									coor_tbl.search("")
											.draw();
									coor_tbl.state.clear();
									coor_tbl.clear();
									
									$(json_p.data)
										.each(
												function() {
	
													coor_tbl.row
															.add([
	
																
																this.job_number,
																this.business_process_sub_name,
																this.ar_name,
																this.plot_location,
																this.job_datesend,
																//this.smd_type_of_plotting,
	
																		'<form action="map_plotting_application_progress_details" method="post">'
																		+ '<input type="hidden" name="case_number" id="case_number" value="'
																		+ this.transaction_number
																		+ '">'
																		+ '<input type="hidden" name="transaction_number" id="transaction_number" value="'
																		+ this.transaction_number
																		+ '">'
																		+ '<input type="hidden" name="job_number" id="job_number" value="'
																		+ this.job_number
																		+ '">'
																		+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
																		+ this.business_process_sub_name
																		+ '">'
	
																		+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'
	
																		+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
																		+ '	</button></form>'
	
																	])
															.draw(
																	false);
													coor_tbl
															.column(
																	2)
															.data()
															.sort();
	
												});
								}
							})
				  
		   });

	
</script>


<script type="text/javascript">
        $(document).ready(function(){

			// // Disable right-click
			// document.addEventListener('contextmenu', function(e) {
			// e.preventDefault();
			// }, false);

			// // Disable F12 (DevTools)
			// document.onkeydown = function(e) {
			// if (e.key === 'F12') {
			// 	return false;
			// }
			// };

        	
        	var date=new Date('2018-01-30T12:00:00Z');    
            $("#smartwizardfirstregistration").on("leaveStep", function(e, anchorObject, stepNumber, stepDirection) {
            	   //return confirm("Do you want to leave the step "+stepNumber+"?");
            	
           });

            $("#smartwizardfirstregistration").on("showStep", function(e, anchorObject, stepNumber, stepDirection, stepPosition) {
             // alert("You are on step "+stepDirection+" now");
               if(stepPosition === 'first'){
                   $("#prev-btn").addClass('disabled');
               }else if(stepPosition === 'final'){
                   $("#Approve").addClass('disabled');
                  /// $("#next-btn").addClass('disabled');
               }else{
                   $("#prev-btn").removeClass('disabled');
                   $("#next-btn").removeClass('disabled');
               }
            });

            $("#smartwizardfirstregistration").on("endReset", function() {
              $("#next-btn").removeClass('disabled');
            //  $("#next-btn").removeClass('disabled');
            });

            // Toolbar extra buttons
            // var btnFinish = $('<button></button>').text('Finish Step').addClass('btn btn-info').attr('disabled', '${active_case_queries}' > 0).attr('disabled', '${active_case_queries}' > 0).on('click', function(){   

			// 	var map_plotting = $('#map_plotting').val();

			// 	//console.log(map_plotting);
          
            // 	 $('#smartwizardfirstregistration').smartWizard('showMessage','Finish Clicked');
            	
            // 	if(localStorage.getItem('user_level') < 2){
            		
            // 		//$("#stepconfirmationDialognoRight").modal();
            // 		$("#stepconfirmationDialognoRight").modal({backdrop: 'static', keyboard: false});
       			  
            // 	}else{
            // 		//$("#stepconfirmationDialog").modal();

			// 		if(map_plotting == 1) {
			// 			$("#stepPlottingconfirmation").modal({backdrop: 'static', keyboard: false});

			// 		} else {
			// 			$("#stepconfirmationDialog").modal({backdrop: 'static', keyboard: false});

			// 		}
            //     }
            	
            // 	});
            // var btnCancel = $('<button></button>').text('Reverse to Prev').addClass('btn btn-info').attr('disabled', "${active_case_queries}" > 0).attr('disabled', "${active_case_objection}" > 0).on('click', function(){   
            	
            // 	console.log($("#smartwizardfirstregistration").smartWizard("getCurrentStep"));
            	
            	
            // 	if(localStorage.getItem('user_level') < 2){
            // 		//$("#stepconfirmationDialognoRight").modal();
            // 		$("#stepconfirmationDialognoRight").modal({backdrop: 'static', keyboard: false});
            // 	}else{
            // 	//	$("#stepreverseconfirmationDialog").modal();
            // 		$("#stepreverseconfirmationDialog").modal({backdrop: 'static', keyboard: false});
            //     }
            	
            // return true; 
            // });
            // var btnQuery = $('<button></button>').text('Query').addClass('btn btn-danger').attr("data-action","").attr('disabled', "${active_case_queries}" > 0).attr('disabled', "${active_case_objection}" > 0).on('click', function(){ 	$("#newQueryModal").modal({backdrop: 'static', keyboard: false});});

			var btnFinish = $('<button></button>').text('Finish Step').addClass('btn btn-info').on('click', function(){   
				
				var map_plotting = $('#map_plotting').val();

				//console.log(map_plotting);
          
            	 $('#smartwizardfirstregistration').smartWizard('showMessage','Finish Clicked');
            	
            	if(localStorage.getItem('user_level') < 2){
            		
            		//$("#stepconfirmationDialognoRight").modal();
            		$("#stepconfirmationDialognoRight").modal({backdrop: 'static', keyboard: false});
       			  
            	}else{
            		//$("#stepconfirmationDialog").modal();

					if(map_plotting == 1) {
						$("#stepPlottingconfirmation").modal({backdrop: 'static', keyboard: false});

					} else {
						$("#stepconfirmationDialog").modal({backdrop: 'static', keyboard: false});

					}
                }
			});
			var btnCancel = $('<button></button>').text('Reverse to Prev').addClass('btn btn-info').on('click', function(){   
			
			console.log($("#smartwizardfirstregistration").smartWizard("getCurrentStep"));
			
			
			if(localStorage.getItem('user_level') < 2){
				//$("#stepconfirmationDialognoRight").modal();
				$("#stepconfirmationDialognoRight").modal({backdrop: 'static', keyboard: false});
			}else{
			//	$("#stepreverseconfirmationDialog").modal();
				$("#stepreverseconfirmationDialog").modal({backdrop: 'static', keyboard: false});
				}
			
			return true; 
			});
			var btnQuery = $('<button></button>').text('Query').addClass('btn btn-danger').on('click', function(){ 	$("#newQueryModal").modal({backdrop: 'static', keyboard: false});});
			
            var new_external_tool_bar =  [];
            
          	if(localStorage.getItem('user_level') < 2){
          	    new_external_tool_bar = [btnQuery];
        	}else{
        	    new_external_tool_bar = [btnFinish,btnQuery, btnCancel];
            }
            
            $('#smartwizardfirstregistration').smartWizard({
                    selected: '${application_stage}',
                    theme: 'arrows',
                    transitionEffect:'fade',
                    showStepURLhash: false,
                    
                    toolbarSettings: {toolbarPosition: 'bottom',
                                      toolbarButtonPosition: 'end',
                                      showNextButton: false, // show/hide a Next button
                                      showPreviousButton: false, // show/hide a Previous button
                                    //  toolbarExtraButtons: [btnFinish,btnQuery, btnCancel]
                    toolbarExtraButtons:new_external_tool_bar
                                    },
                     anchorSettings: {
                                        anchorClickable: false, // Enable/Disable anchor navigation
                                        enableAllAnchors: false, // Activates all anchors clickable all times
                                        markDoneStep: false, // add done css
                                        enableAnchorOnDoneStep: false // Enable/Disable the done steps navigation
                                    },
            });


			$("#btn_approve_plotting_process")
							.on('click',
									function(event) {

										$("#stepPlottingconfirmation").modal('hide');
     			 
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
										 var transaction_number = $("#cs_main_transaction_number").val();
						   
										  var send_by_id = localStorage.getItem('userid');
										var send_by_name = localStorage.getItem('fullname');
										
								   
											$.ajax({
												type: "POST",
												url: "Case_Management_Serv",
												data: {
													  request_type: 'online_select_verification_code_create',
													case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
												 type_of_transaction:'approval_of_map_plotting'
												 },
												cache: false,
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												},
												success: function(jobdetails) {
												   
											var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							//$('#final_registration_approval_dialog').modal('hide');
							$('#map_plotting_approval_dialog').modal('show');

							$("#map_plotting_approval_dialog #ma_txt_ta_id").val(json_p.ta_id);
							$("#map_plotting_approval_dialog #ma_txt_job_number").val(json_p.job_number);
							$("#map_plotting_approval_dialog #ma_txt_case_number").val(json_p.case_number);
							$("#map_plotting_approval_dialog #ma_txt_type_of_transaction").val(json_p.type_of_transaction);
							$("#map_plotting_approval_dialog #ma_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							$("#map_plotting_approval_dialog #ma_txt_transaction_details").val(json_p.transaction_details);

							
						}else {
							alert(json_p.msg);
						}
												}
												}); 
									});


            // External Button Events
            $("#reset-btn").on("click", function() {
                // Reset wizard
                $('#smartwizardfirstregistration').smartWizard("reset");
                $("#next-btn").removeClass('disabled');
                return true;
            });

            $("#prev-btn").on("click", function() {
                // Navigate previous
              
                $('#smartwizardfirstregistration').smartWizard("prev");
                return true;
            });

            $("#next-btn").on("click", function() {
                // Navigate next
                $('#smartwizardfirstregistration').smartWizard("next");
                return true;
            });

            	
			$('#final_registration_approval_dialog').on(
							'show.bs.modal',
							function(event) {
								
								var ta_id = parseInt($(event.relatedTarget).data('ta_id') ? $(event.relatedTarget).data('ta_id') : 0);
								var job_number = $(event.relatedTarget).data('job_number');
								var case_number = $(event.relatedTarget).data('case_number');
								var type_of_transaction = $(event.relatedTarget).data('type_of_transaction');
								var transaction_details = $(event.relatedTarget).data('transaction_details');
								var approval_status = $(event.relatedTarget).data('approval_status');
								var business_process_name = $(event.relatedTarget).data('business_process_name');
								var business_process_sub_name = $(event.relatedTarget).data('business_process_sub_name');
						
								if (cs_id == "" || cs_id == undefined
										|| cs_id == 0) {
									cs_id = '0';
									$(".btn_reg_root_delete_action").hide();
								} else {
									$(".btn_reg_root_delete_action").show();
								}

								$("#final_registration_approval_dialog #ta_txt_ta_id").val(ta_id);
								$("#final_registration_approval_dialog #ta_txt_job_number").val(job_number);
								$("#final_registration_approval_dialog #ta_txt_case_number").val(case_number);
								$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(type_of_transaction);
								$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(business_process_sub_name);
								$("#final_registration_approval_dialog #ta_txt_transaction_details").val(transaction_details);
								

							});

            $("#btn_final_registration_approval_dialog").click(function(event){
            	
		    		var job_number = $("#ta_txt_job_number").val();
		    		var case_number = $("#ta_txt_case_number").val();
		    	 	var business_process_sub_name = $("#ta_txt_business_process_sub_name").val();
					var ta_id = $("#ta_txt_ta_id").val();
					var type_of_transaction = $("#ta_txt_type_of_transaction").val();
		    		
					var veri_code1 = $("#veri_code1").val();
		    		var veri_code2 = $("#veri_code2").val();
		    		var veri_code3 = $("#veri_code3").val();
		    		var veri_code4 = $("#veri_code4").val();
					var veri_code5 = $("#veri_code5").val();
		    		var veri_code6 = $("#veri_code6").val();
		    		
		    		var full_code = veri_code1 + ''+ veri_code2 + ''+ veri_code3 + ''+ veri_code4 + ''+ veri_code5 + ''+ veri_code6;
		    	 	
		    	 	console

		    		 $.ajax({
						 type: "POST",
						 url: "Case_Management_Serv",
						 data: {
			                	request_type: 'online_select_verification_code_final_approval',
			                	ta_id: ta_id,
			                	type_of_transaction : type_of_transaction,
			                	job_number:job_number,
			                	case_number:case_number,
			                	business_process_sub_name: business_process_sub_name,
			                	full_code:full_code
						 	   },
						 cache: false,
						 beforeSend: function () {
							 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
						 },
						 success: function(jobdetails) {
							 	console.log(jobdetails);
								$("#general_message_dialog").modal();
								//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
								$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
								
								
								
								  $('#final_registration_approval_dialog').modal('hide');
							 
						 }
						
				});
            	
            	
                  return true;
            });
            
			$("#btn_final_registration_approval_dialog_").click(function(event){
            	
				var job_number = $("#ta_txt_job_number_").val();
				var case_number = $("#ta_txt_case_number_").val();
				 var business_process_sub_name = $("#ta_txt_business_process_sub_name_").val();
				var ta_id = $("#ta_txt_ta_id_").val();
				var type_of_transaction = $("#ta_txt_type_of_transaction_").val();
				
				var veri_code1 = $("#veri_code1_").val();
				var veri_code2 = $("#veri_code2_").val();
				var veri_code3 = $("#veri_code3_").val();
				var veri_code4 = $("#veri_code4_").val();
				var veri_code5 = $("#veri_code5_").val();
				var veri_code6 = $("#veri_code6_").val();
				
				var full_code = veri_code1 + ''+ veri_code2 + ''+ veri_code3 + ''+ veri_code4 + ''+ veri_code5 + ''+ veri_code6;
				 
				 console

				 $.ajax({
					 type: "POST",
					 url: "Case_Management_Serv",
					 data: {
							request_type: 'online_select_verification_code_final_approval',
							ta_id: ta_id,
							type_of_transaction : type_of_transaction,
							job_number:job_number,
							case_number:case_number,
							business_process_sub_name: business_process_sub_name,
							full_code:full_code
							},
					 cache: false,
					 beforeSend: function () {
						 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
					 },
					 success: function(jobdetails) {
							 console.log(jobdetails);
							$("#general_message_dialog").modal();
							//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
							$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
							
							
							
							  $('#final_registration_approval_dialog').modal('hide');
						 
					 }
					
			});
			
			
			  return true;
		});

		$("#btn_final_registration_approval_dialog__").click(function(event){
            	
				var job_number = $("#ta_txt_job_number__").val();
				var case_number = $("#ta_txt_case_number__").val();
				 var business_process_sub_name = $("#ta_txt_business_process_sub_name__").val();
				var ta_id = $("#ta_txt_ta_id__").val();
				var type_of_transaction = $("#ta_txt_type_of_transaction__").val();
				
				var veri_code1 = $("#veri_code1__").val();
				var veri_code2 = $("#veri_code2__").val();
				var veri_code3 = $("#veri_code3__").val();
				var veri_code4 = $("#veri_code4__").val();
				var veri_code5 = $("#veri_code5__").val();
				var veri_code6 = $("#veri_code6__").val();
				
				var full_code = veri_code1 + ''+ veri_code2 + ''+ veri_code3 + ''+ veri_code4 + ''+ veri_code5 + ''+ veri_code6;
				 
				 console

				 $.ajax({
					 type: "POST",
					 url: "Case_Management_Serv",
					 data: {
							request_type: 'online_select_verification_code_final_approval',
							ta_id: ta_id,
							type_of_transaction : type_of_transaction,
							job_number:job_number,
							case_number:case_number,
							business_process_sub_name: business_process_sub_name,
							full_code:full_code
							},
					 cache: false,
					 beforeSend: function () {
						 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
					 },
					 success: function(jobdetails) {
							 console.log(jobdetails);
							$("#general_message_dialog").modal();
							//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
							$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
							
							
							
							  $('#final_registration_approval_dialog').modal('hide');
						 
					 }
					
			});
			
			
			  return true;
		});

		$("#btn_final_registration_approval_dialog___").click(function(event){
            	
				var job_number = $("#ta_txt_job_number___").val();
				var case_number = $("#ta_txt_case_number___").val();
				 var business_process_sub_name = $("#ta_txt_business_process_sub_name___").val();
				var ta_id = $("#ta_txt_ta_id___").val();
				var type_of_transaction = $("#ta_txt_type_of_transaction___").val();
				
				var veri_code1 = $("#veri_code1___").val();
				var veri_code2 = $("#veri_code2___").val();
				var veri_code3 = $("#veri_code3___").val();
				var veri_code4 = $("#veri_code4___").val();
				var veri_code5 = $("#veri_code5___").val();
				var veri_code6 = $("#veri_code6___").val();
				
				var full_code = veri_code1 + ''+ veri_code2 + ''+ veri_code3 + ''+ veri_code4 + ''+ veri_code5 + ''+ veri_code6;
				 
				 console

				 $.ajax({
					 type: "POST",
					 url: "Case_Management_Serv",
					 data: {
							request_type: 'online_select_verification_code_final_approval',
							ta_id: ta_id,
							type_of_transaction : type_of_transaction,
							job_number:job_number,
							case_number:case_number,
							business_process_sub_name: business_process_sub_name,
							full_code:full_code
							},
					 cache: false,
					 beforeSend: function () {
						 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
					 },
					 success: function(jobdetails) {
							 console.log(jobdetails);
							$("#general_message_dialog").modal();
							//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
							$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
							
							
							
							  $('#final_registration_approval_dialog').modal('hide');
						 
					 }
					
			});
			
			
			  return true;
		});
            
			$("#btn_map_plotting_approval_dialog").click(function(event){
    
		    		var job_number = $("#ma_txt_job_number").val();
		    		var case_number = $("#ma_txt_case_number").val();
		    	 	var business_process_sub_name = $("#ma_txt_business_process_sub_name").val();
					var ta_id = $("#ma_txt_ta_id").val();
					var type_of_transaction = $("#ma_txt_type_of_transaction").val();
		    		
					var veri_code1 = $("#m_veri_code1").val();
		    		var veri_code2 = $("#m_veri_code2").val();
		    		var veri_code3 = $("#m_veri_code3").val();
		    		var veri_code4 = $("#m_veri_code4").val();
					var veri_code5 = $("#m_veri_code5").val();
		    		var veri_code6 = $("#m_veri_code6").val();
		    		
		    		var full_code = veri_code1 + ''+ veri_code2 + ''+ veri_code3 + ''+ veri_code4 + ''+ veri_code5 + ''+ veri_code6;
		    	 	
		    	 	console
		    	            	    
		    		 $.ajax({
						 type: "POST",
						 url: "Case_Management_Serv",
						 data: {
			                	request_type: 'online_select_verification_code_final_approval',
			                	ta_id: ta_id,
			                	type_of_transaction : type_of_transaction,
			                	job_number:job_number,
			                	case_number:case_number,
			                	business_process_sub_name: business_process_sub_name,
			                	full_code:full_code
						 	   },
						 cache: false,
						 beforeSend: function () {
							 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
						 },
						 success: function(jobdetails) {
							 	console.log(jobdetails);
								
								if(jobdetails == 'Application Successfully completed') {

									$("#btn_approve_map_plotting_process").trigger( "click" );

								} else {
									alert('Approval failed! Enetered wrong code. Try again.')
								}
						 }
						
				});
            	
                  return true;
            });
          
			$('#frmFurtherEntries_only')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										var case_number = $("#fe_case_number")
												.val();
										var transaction_number = $(
												"#fe_transaction_number").val();
										// var annual_rent =
										// $("#fe_annual_rent").val();
										var commencement_date = $(
												"#fe_commencement_date").val();
										var stool_family_name = $(
												"#fe_family_name").val();
										var family_of_grantor = $(
												"#fe_grantor_family").val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var term = $("#fe_term").val();
										var date_of_document = $(
												"#fe_date_of_document").val();
										var consideration_fee = $(
												"#fe_consideration_fee").val();
										var consideration_currency = $(
												"#fe_consideration_currency")
												.val()
										var type_of_use = $("#fe_type_of_use")
												.val();
										// var extent = $("#fe_extent").val();
										var size_of_land = $("#fe_land_size")
												.val();
										var type_of_interest = $(
												"#fe_type_of_interest").val();
										var nature_of_instrument = $(
												"#fe_nature_of_instrument")
												.val();
										var client_name = $("#fe_client_name")
												.val();
										var business_process_sub_name = $(
												"#febusiness_process_sub_name")
												.val();
										var job_number = $("#fe_job_number")
												.val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var annual_rent = $("#fe_annual_rent")
												.val();
										var surveyor_number = $(
												"#fe_surveyor_number").val();
										var regional_number = $(
												"#fe_regional_number").val();
										var land_size = $("#fe_land_size")
												.val();

										var district = $("#fe_district").val();

										var locality = $("#fe_locality").val();
										var region = $("#fe_region").val();
										var extent = $("#fe_extent").val();
										var file_number = $("#fe_file_number")
												.val();
										var registry_mapref = $(
												"#fe_registry_mapref").val();

										var modified_by = localStorage
												.getItem("fullname");
										var modified_by_id = localStorage
												.getItem("userid");
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'further_entries_update_case',
														case_number : case_number,
														annual_rent : annual_rent,
														commencement_date : commencement_date,
														stool_family_name : stool_family_name,
														family_of_grantor : family_of_grantor,
														renewal_term : renewal_term,
														term : term,
														date_of_document : date_of_document,
														consideration_fee : consideration_fee,
														consideration_currency : consideration_currency,
														extent : extent,
														size_of_land : size_of_land,
														type_of_interest : type_of_interest,
														nature_of_instrument : nature_of_instrument,
														type_of_use : type_of_use,
														transaction_number : transaction_number,
														client_name : client_name,
														business_process_sub_name : business_process_sub_name,
														job_number : job_number,
														surveyor_number : surveyor_number,
														regional_number : regional_number,
														land_size : land_size,
														locality : locality,
														district : district,
														region : region,
														file_number : file_number,
														modified_by : modified_by,
														modified_by_id : modified_by_id
													},
													cache : false,
													beforeSend : function() {
													},
													success : function(
															jobdetails) {
														console.log(jobdetails)

														var result = JSON
																.parse(jobdetails);

														if (result.data == 'Success') {
															var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Success!</strong> Case details saved successfully</div>';

															$(
																	"#alert-display-space")
																	.append(
																			alert_mess);

															var job_number = $(
																	"#fe_job_number")
																	.val();
															var ar_name = $(
																	"#fe_client_name")
																	.val();
															var business_process_sub_name = $(
																	"#febusiness_process_sub_name")
																	.val();

															addJobToBatchlist(
																	job_number,
																	ar_name,
																	business_process_sub_name,
																	" ","");

															prepareBatchlistModal();

														} else {
															var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Failure!</strong> Something went wrong, Please try again</div>';

														}
													}

												});
									});
            
            
									$('#frmFurtherEntries_only_')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										var case_number = $("#fe_case_number")
												.val();
										var transaction_number = $(
												"#fe_transaction_number").val();
										// var annual_rent =
										// $("#fe_annual_rent").val();
										var commencement_date = $(
												"#fe_commencement_date").val();
											var date_of_registration = $(
												"#fe_date_of_registration").val();
										var stool_family_name = $(
												"#fe_family_name").val();
										var family_of_grantor = $(
												"#fe_grantor_family").val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var term = $("#fe_term").val();
										var date_of_document = $(
												"#fe_date_of_document").val();
										var consideration_fee = $(
												"#fe_consideration_fee").val();
										var consideration_currency = $(
												"#fe_consideration_currency")
												.val()
										// console.log("cnsider:" +
										// consideration_currency)
										var type_of_use = $("#fe_type_of_use")
												.val();
										// var extent = $("#fe_extent").val();
										var size_of_land = $("#fe_land_size")
												.val();
										var type_of_interest = $(
												"#fe_type_of_interest").val();
										var nature_of_instrument = $(
												"#fe_nature_of_instrument")
												.val();
										var client_name = $("#fe_client_name")
												.val();
										var business_process_sub_name = $(
												"#febusiness_process_sub_name")
												.val();
										var job_number = $("#fe_job_number")
												.val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var annual_rent = $("#fe_annual_rent")
												.val();
										var surveyor_number = $(
												"#fe_surveyor_number").val();
										var regional_number = $(
												"#fe_regional_number").val();
										var land_size = $("#fe_land_size")
												.val();

										// var case_number =
										// $("#fe_case_number").val();

										var district = $("#fe_district").val();

										var locality = $("#fe_locality").val();
										var region = $("#fe_region").val();
										var extent = $("#fe_extent").val();
										var file_number = $("#fe_file_number")
												.val();
										var registry_mapref = $(
												"#fe_registry_mapref").val();
				

										var date_of_issue = $("#fe_date_of_issue").val();
										
										var registered_number = $("#fe_registered_number").val();
										
										var certificate_type = $("#fe_certificate_type").val();
										

										var modified_by = localStorage
												.getItem("fullname");
										var modified_by_id = localStorage
												.getItem("userid");

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'further_entries_update_case',
														case_number : case_number,
														annual_rent : annual_rent,
														commencement_date : commencement_date,
														date_of_registration:date_of_registration,
														stool_family_name : stool_family_name,
														family_of_grantor : family_of_grantor,
														renewal_term : renewal_term,
														term : term,
														date_of_document : date_of_document,
														consideration_fee : consideration_fee,
														consideration_currency : consideration_currency,
														extent : extent,
														size_of_land : size_of_land,
														type_of_interest : type_of_interest,
														nature_of_instrument : nature_of_instrument,
														type_of_use : type_of_use,
														transaction_number : transaction_number,
														client_name : client_name,
														business_process_sub_name : business_process_sub_name,
														job_number : job_number,
														surveyor_number : surveyor_number,
														regional_number : regional_number,
														land_size : land_size,
														locality : locality,
														district : district,
														region : region,
														file_number : file_number,
														date_of_issue : date_of_issue,
														registered_number : registered_number,
														registry_mapref : registry_mapref,
														certificate_type:certificate_type,
														modified_by : modified_by,
														modified_by_id : modified_by_id
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails)

														var result = JSON
																.parse(jobdetails);

														if (result.data == 'Success') {
															var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Success!</strong> Case details saved successfully</div>';

															$(
																	"#alert-display-space")
																	.append(
																			alert_mess);

															var job_number = $(
																	"#fe_job_number")
																	.val();
															var ar_name = $(
																	"#fe_client_name")
																	.val();
															var business_process_sub_name = $(
																	"#febusiness_process_sub_name")
																	.val();

															// addJobToBatchlist(
															// 		job_number,
															// 		ar_name,
															// 		business_process_sub_name,
															// 		" ","");

															// prepareBatchlistModal();

														} else {
															var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Failure!</strong> Something went wrong, Please try again</div>';

														}
													}

												});
									});
        });
    </script>

<script type="text/javascript">
    
    $(document).ready(function() {
    	
    
    	 $('#form_embossment').on('submit', function(e){
       	    // validation code here
       	    e.preventDefault();
       	    //console.log('form submited Clicked');
       		
       		var job_number =  $("#cs_main_job_number").val();
       	    
       	  	var modified_by =localStorage.getItem("fullname");
      	    var modified_by_id =localStorage.getItem("userid");
       	   
   	   
      	    
       		 $.ajax({
   				 type: "POST",
   				 url: "Case_Management_Serv",
   				 data: {
   	                	request_type: 'update_stamp_duty_records_embossment',
   	                	job_number: job_number,
   		    	    	modified_by : modified_by,
   		    	    	modified_by_id : modified_by_id
   				 	   },
   				 cache: false,
   				 beforeSend: function () {
   					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   				 },
   				 success: function(jobdetails) {
      	 					$("#general_message_dialog").modal();
      	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
      	 					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);

   				 }
   				
   		});});
    	 
    	 
    	 
    	  $("#btn_submit_embossment").click(function(event){
				 
           		var job_number =  $("#cs_main_job_number").val();
           	    
           	  	var modified_by =localStorage.getItem("fullname");
          	    var modified_by_id =localStorage.getItem("userid");
           	   
       	   
          	    
           		 $.ajax({
       				 type: "POST",
       				 url: "Case_Management_Serv",
       				 data: {
       	                	request_type: 'update_stamp_duty_records_embossment',
       	                	job_number: job_number,
       		    	    	modified_by : modified_by,
       		    	    	modified_by_id : modified_by_id
       				 	   },
       				 cache: false,
       				 beforeSend: function () {
       					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
       				 },
       				 success: function(jobdetails) {
          	 					$("#general_message_dialog").modal();
          	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
          	 					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);


       				        //}     
       				 }
       				
       		});
    				    
    			});
    	 
 	  
 	  $('#form_assessment').on('submit', function(e){
   	    // validation code here
   	    e.preventDefault();
   	    //console.log('form submited Clicked');
   		//var case_number =  $("#cs_main_case_number").val();
   		var case_number =  $("#cs_main_transaction_number").val();
   		var job_number =  $("#cs_main_job_number").val();
   	    var assessed_value = $("#assessed_value").val();
   	 	var stamp_duty = $("#stamp_duty").val();
   	 	var assessed_comment = $("#assessed_comment").val();
   	  	var considertion_fee_adopted_rate = $("#considertion_fee_adopted_rate").val();
   	     
  	    
   		 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'update_stamp_duty_records',
	                	case_number:case_number,
	                	job_number:job_number,
	                	assessed_value : assessed_value,
	                	stamp_duty : stamp_duty,
	                	assessed_comment:assessed_comment,
	                	considertion_fee_adopted_rate :considertion_fee_adopted_rate
				 	   },
				 cache: false,
				 beforeSend: function () {
					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					//console.log(jobdetails)
					if(jobdetails.includes('Success')){
						var ar_name = $("#cs_main_ar_name").val();
  	 	 	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
  	 	 	    		var job_purpose = "Assessement Done";
  	 	              	
  	 	              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
  	 	              	
  	 	              	addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
					}else{
						$("#general_message_dialog").modal();
  	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Sorry! Somthing went wrong");
  	 					//$('#general_message_dialog #').val('Stamp Duty has been saved Successfully');
					}
			      	 				
				 }
				
		});});
 	  
 	//=================================================================
	    
     	
	   $('#frmVerification input').on('keyup', function() {
			//alert("some");
			if ($(this).val()) {
				var index = parseFloat($(this).attr(
						'data-index'));
				$(
						'[data-index="'
								+ (index + 1)
										.toString()
								+ '"]').focus();
			}

		});
	    
	    
 	  $('#frmFurtherEntries').on('submit', function(e){
 	    // validation code here
 	    e.preventDefault(); 
		var registry_mapref = $("#fe_registry_mapref").val();
		var job_number = $("#fe_job_number").val();
	 	var surveyor_number = $("#fe_surveyor_number").val();
	 	var regional_number =  $("#fe_regional_number").val();
	 	var land_size =  $("#fe_land_size").val();
	 	var district = $("#fe_district").val();
	 	var region =  $("#fe_region").val();
	 	var locality =  $("#fe_locality").val();
			
 		var case_number 		= $("#fe_case_number").val();
 		var transaction_number 	= $("#fe_transaction_number").val();
 		var annual_rent			= $("#fe_annual_rent").val(); 
 		var commencement_date	= $("#fe_commencement_date").val();
 		var stool_family_name	= $("#fe_family_name").val();
 		var family_of_grantor	= $("#fe_grantor_family").val(); 
 		var renewal_term		= $("#fe_renewal_term").val();
 		var term				= $("#fe_term").val();
 		var date_of_document	= $("#fe_date_of_document").val();
 		var consideration_fee	= $("#fe_consideration_fee").val();
 		var type_of_use			= $("#fe_type_of_use").val();
 		var extent				= $("#fe_extent").val();
 		var size_of_land		= $("#fe_land_size").val();
 		var type_of_interest	= $("#fe_type_of_interest").val();
 		var nature_of_instrument= $("#fe_nature_of_instrument").val();
 		var file_number			= $("#fe_file_number").val();
 		var modified_by 		= localStorage.getItem("fullname");
 		var modified_by_id		= localStorage.getItem("userid");
 		
 		//console.log('form submited Clicked New: ' + registry_mapref);
 		
 		
 		 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type			: 'further_entries_update_case',
	                	job_number:job_number,
	                surveyor_number : surveyor_number,
	       			regional_number :  regional_number,
	       			land_size :  land_size,
	       			district : district,
	       			 region : region,
	       			 locality :  locality,
						registry_mapref:registry_mapref,

	                	case_number   			: case_number,
	                	transaction_number		: transaction_number,
	                	annual_rent 			: annual_rent,
	                	commencement_date 		: commencement_date,
	                	stool_family_name		: stool_family_name,
	                	family_of_grantor		: family_of_grantor,
	                	renewal_term   			: renewal_term,
	                	term 					: term,
	                	date_of_document 		: date_of_document,
	                	consideration_fee		: consideration_fee,
	                	extent   				: extent,
	                	size_of_land 			: size_of_land,
	                	type_of_interest 		: type_of_interest,
	                	nature_of_instrument	: nature_of_instrument,
	                		file_number			: file_number,
	                	type_of_use 			: type_of_use,
			    	    modified_by 			: modified_by,
		    	    	modified_by_id 			: modified_by_id
				 	   },
				 cache: false,
				 beforeSend: function () {
					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					 	var result = JSON.parse(jobdetails);
					 	//console.log(jobdetails)
				        if(result.data.includes('Success')){
				        	var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Success!</strong> Case details saved successfully</div>';

				       
				        	$( "#alert-display-space" ).append( alert_mess );
				           	var job_number = $("#fe_job_number").val();
				           	//var send_by_id = $("#modified_by_id").val();
				           	//var send_by =$("#modified_by").val();
				           	var ar_name = $("#fe_client_name").val();
				           	var business_process_sub_name = $("#fe_business_process_sub_name").val();
				           	
				           	addJobToBatchlist(job_number,ar_name,business_process_sub_name,"");
				             
				            prepareBatchlistModal();
				        	
				        } else{
				        	var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Failure!</strong> Something went wrong, Please try again</div>';
     					   
				        }
				 }
				
		}); });

		$('#frmFurtherEntries_R').on('submit', function(e){
 	    // validation code here
 	    e.preventDefault();
 	    
 	    var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Success!</strong> Case details saved successfully</div>';

				        	$( "#alert-display-space" ).append( alert_mess );
				        	//Do Add to Batclist
				    
				           	var job_number = $("#fe_job_number").val();
				           	//var send_by_id = $("#modified_by_id").val();
				           	//var send_by =$("#modified_by").val();
				           	var ar_name = $("#fe_client_name").val();
				           	var business_process_sub_name = $("#fe_business_process_sub_name").val();
				           	
				           	addJobToBatchlist(job_number,ar_name,business_process_sub_name,"");
				            prepareBatchlistModal();
 	   
 		 });
		
		
		
		$('#frmFurtherEntriesWithValuation').on('submit', function(e){
 	    // validation code here
 	    e.preventDefault();
 	    
		var registry_mapref = $("#fe_registry_mapref").val();
		var job_number = $("#fe_job_number").val();
	 	var surveyor_number = $("#fe_surveyor_number").val();
	 	var regional_number =  $("#fe_regional_number").val();
	 	var land_size =  $("#fe_land_size").val();
	 	var district = $("#fe_district").val();
	 	var region =  $("#fe_region").val();
	 	var locality =  $("#fe_locality").val();
			
 		var case_number 		= $("#fe_case_number").val();
 		var transaction_number 	= $("#fe_transaction_number").val();
 		var annual_rent			= $("#fe_annual_rent").val(); 
 		var commencement_date	= $("#fe_commencement_date").val();
 		var stool_family_name	= $("#fe_family_name").val();
 		var family_of_grantor	= $("#fe_grantor_family").val(); 
 		var renewal_term		= $("#fe_renewal_term").val();
 		var term				= $("#fe_term").val();
 		var date_of_document	= $("#fe_date_of_document").val();
 		var consideration_fee	= $("#fe_consideration_fee").val();
 		var type_of_use			= $("#fe_type_of_use").val();
 		var extent				= $("#fe_extent").val();
 		var size_of_land		= $("#fe_land_size").val();
 		var type_of_interest	= $("#fe_type_of_interest").val();
 		var nature_of_instrument= $("#fe_nature_of_instrument").val();
 		var file_number			= $("#fe_file_number").val();
 		var modified_by 		= localStorage.getItem("fullname");
 		var modified_by_id		= localStorage.getItem("userid");
		var date_of_valuation 	= $("#fe_date_of_valuation").val();
		var amount 				= $("#fe_amount").val();
		var remarks 			= $("#fe_remarks").val();
		var certificate_number	= $('#fe_certificate_number').val()
 		 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type			: 'further_entries_update_case_with_valuation',
	                	job_number:job_number,
	                surveyor_number : surveyor_number,
	       			regional_number :  regional_number,
	       			land_size :  land_size,
	       			district : district,
	       			 region : region,
	       			 locality :  locality,
						registry_mapref:registry_mapref,

	                	case_number   			: case_number,
	                	transaction_number		: transaction_number,
	                	annual_rent 			: annual_rent,
	                	commencement_date 		: commencement_date,
	                	stool_family_name		: stool_family_name,
	                	family_of_grantor		: family_of_grantor,
	                	renewal_term   			: renewal_term,
	                	term 					: term,
	                	date_of_document 		: date_of_document,
	                	consideration_fee		: consideration_fee,
	                	extent   				: extent,
	                	size_of_land 			: size_of_land,
	                	type_of_interest 		: type_of_interest,
	                	nature_of_instrument	: nature_of_instrument,
	                	file_number				: file_number,
	                	type_of_use 			: type_of_use,
			    	    modified_by 			: modified_by,
		    	    	modified_by_id 			: modified_by_id,
						date_of_valuation		: date_of_valuation,
						amount					: amount,
						remarks					: remarks,
						certificate_number		: certificate_number
				 	   },
				 cache: false,
				 beforeSend: function () {
					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					 	var result = JSON.parse(jobdetails);
					 	//console.log(jobdetails)
				        if(result.data.includes('Success')){
				        	var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Success!</strong> Case details saved successfully</div>';


				        	//console.log(jobdetails)
				       
				        	$( "#alert-display-space" ).append( alert_mess );
				        	
				        } else{
				        	var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Failure!</strong> Something went wrong, Please try again</div>';
     					   
				        }
				 }
				
		}); });
		
 	 
 	 $('btn_view_comparable_on_map').click(function() {
	console.log('yes');
	var data = $(this).attr('property_owner');
	alert(data.option1)
});

 		$('#newObjectionModal').on('show.bs.modal', function (event) {
    		  var button = $(event.relatedTarget) // Button that triggered the modal
    		  var recipient = button.data('action') // Extract info from data-* attributes
    		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    		  
    		  console.log(recipient);
    		  var modal = $(this)
    		  if(recipient=='edit'){
    			modal.find('.modal-body #action_on_form').val(recipient)
    			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
      								    	 					
    				$("#obj_id").val($(event.relatedTarget).data('target-id'));
               		$("#obj_objector_name").val($(event.relatedTarget).data('objector_name'));
               		$("#obj_objector_address").val($(event.relatedTarget).data('objector_address'));
               		$("#obj_objector_contact").val($(event.relatedTarget).data('objector_contact'));
               		$("#obj_reasons").val($(event.relatedTarget).data('reasons')); 
               		$("#obj_remarks").val($(event.relatedTarget).data('remarks')); 
               		$("#obj_status").val($(event.relatedTarget).data('status')); 
    			
    				
    		}
 		});
    	
    	  $('#form_add_objection').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    console.log('form submited Clicked');
        	    var action_on_form = $("#action_on_form").val();
        		var obj_case_number = $("#obj_case_number").val();
        		var obj_job_number = $("#obj_job_number").val();
        	    var obj_objector_name = $("#obj_objector_name").val();
        	 	var obj_objector_address = $("#obj_objector_address").val();
        	 	var obj_object_contact = $("#obj_object_contact").val();
        	 	
        	 	var obj_reasons = $("#obj_reasons").val();
        	 	var obj_remarks = $("#obj_remarks").val();
        	 	var obj_status = $("#obj_status").val();
        	 	
        	/* 	var modified_by =$("#modified_by").val();
       	    	var modified_by_id =$("#modified_by_id").val(); */
       	    	
        	    var request_type="";
        	    
       	    	if(action_on_form =="edit"){ request_type = "request type for edit"; }
       	    	else{ request_type ="request type for action"; }
       	    	
       	    	
        		 $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				 data: {
    	                	request_type		 : request_type,
    	                	obj_case_number      : obj_case_number,
    	                	obj_job_number       : obj_job_number,
    	                	obj_objector_name    : obj_objector_name,
    	                	obj_objector_address : obj_objector_address,
    	                	obj_object_contact   : obj_object_contact,
    	                	obj_reasons			 : obj_reasons,
    	                	obj_remarks 		 : obj_remarks,
    	                	obj_status 			 : obj_status,
    		    	    	/* modified_by           : modified_by,
    		    	    	modified_by_id        : modified_by_id */
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
    					
    					$('#newObjectionModal').modal('hide');
   	 					$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Objections Details");
   	 					
   	 					
   	 					
  					
    				 } 
    				
    		});
        		 
    	  });
    	  
//============================================= End Actions for Objection ===============================================

/*===========================================   Actions for Query ==================  */    	  
    	$('#newQueryModal').on('show.bs.modal', function (event) {
    		  var button = $(event.relatedTarget); // Button that triggered the modal
    		  var qid = button.data('id'); // Extract info from data-* attributes
    		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    		  let action = button.data('action');
    		  //console.log("ctt:"+ action)
    		  let modal = $(this);
    		  if(qid > 0){
    			
					$("#qid").val(qid);
					//console.log("test am" + qid);
					$("#query_created_by").val(button.data('created_by'));
	        	 	$("#query_created_date").val($(event.relatedTarget).data('created_date')); 
	        	 	$("#query_modified_by").val(button.data('created_by'));
	        	 	$("#query_modified_date").val($(event.relatedTarget).data('created_date')); 
	        	 	$("#query_status").val($(event.relatedTarget).data('status'));
	        	 	$("#query_reasons").val($(event.relatedTarget).data('reasons'));
	        	 	$("#query_remarks").val($(event.relatedTarget).data('remarks'));
	        	 	$("#query_response").val($(event.relatedTarget).data('query_response'));
	        	 	$("#query_general_reason").val($(event.relatedTarget).data('general_reason'));
	        	 	$("#query_response").prop('disabled', true);
	        	 	if($(event.relatedTarget).data('attachment_required') == 1){
	        	 		$("#query_attachement_requried1").prop('checked', true);
	        	 	}else{
	        	 		$("#query_attachement_requried2").prop('checked', true);
	        	 	}
	        	 	//console.log("testing " + $(event.relatedTarget).data('status'));
	        	 	if($(event.relatedTarget).data('status') == 1){
	        	 		$("#query_status option:eq(0)").prop('selected', true);
	        	 		//console.log("test 1 " );
	        	 	}else{
	        	 		$("#query_status option:eq(1)").prop('selected', true);
	        	 		//console.log("test 0" );
	        	 	}
    		  	} 
    		  if(typeof action ==="undefined" || action.includes("new")){
    			  $("#qid").val();
					//console.log("test am" + qid);
					$("#query_created_by").val("");
	        	 	$("#query_created_date").val(""); 
	        	 	$("#query_modified_by").val("");
	        	 	$("#query_modified_date").val(""); 
	        	 	$("#query_status").val("");
	        	 	$("#query_reasons").val("");
	        	 	$("#query_remarks").val("");
	        	 	$("#query_general_reason").val("");
	        	 	$("#query_response").val("");
	        	 	$("#query_response").prop('disabled', true);
  			
  			
    		  }
    		  if(localStorage.getItem("user_level") <2){
	       	 		$("#query_remarks").prop('required',false);
	       	 		$("input[name='query_attachement_requried']").prop('required',false);
	       	 		$("#query_reasons").prop('required',false);
		 	  }
    		  
    		});
    			
    		
    	
    	  $('#form_add_query').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    console.log('form submited Clicked');
        	    var action_on_form = $("#action_on_form_query").val();
        		var qid = parseInt($("#qid").val());
        		var case_number = $("#query_case_number").val();
        		var job_number = $("#query_job_number").val();
        	    var query_reasons = $("#query_reasons").val();
        	 	var query_remarks = $("#query_remarks").val();
        	 	var query_status = $("#query_status").val();
        	 	var query_attachment = $("input[name='query_attachement_requried']:checked").val();
        	 	var query_general_reason =$("#query_general_reason").val();
				//console.log("loged : " + query_attachment);
       	    	
        	    var request_type="";
        	    
       	    	if(action_on_form =="edit"){ request_type = "select_lc_case_query_add_and_update"; }
       	    	else{ request_type ="select_lc_case_query_add_and_update"; }
       	   
            
        		 $.ajax({
    				 type: "POST",
    				 url: "lc_case_query_serv",
    				 data: {
    	                	request_type		 : request_type,
    	                	qid      	 		 : qid,
    	                	case_number      	 : case_number,
    	                	job_number       	 : job_number,
    	                	reasons	     		 : query_reasons,
    	                	remarks		 		 : query_remarks,
    	                	status   		     : query_status,
    	                	query_attachment     : query_attachment,
    	                	query_general_reason : query_general_reason
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					//console.log(jobdetails)
              	var job_number = $("#cs_main_job_number").val();
              	var transaction_number = $("#cs_main_transaction_number").val();
              	var case_number = $("#cs_main_case_number").val();
              	
              	var ar_name = $("#cs_main_ar_name").val();
 	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
 	    		var job_purpose = "Application Queried";
              	
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
              	
              	addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
   	 				
    				 } 
    				
    			 });
        	});
    	  
	
			$('#addMinutesModal').on('show.bs.modal', function (event) {
				//e.preventDefault();
				var am_id = $(event.relatedTarget).data('target-id') // Extract
				var am_edit = $(event.relatedTarget).data('am_edit')
				console.log(am_edit);

				if(am_id > 0){
					$("#am_id").val(am_id);
					//console.log("test am" + am_id);
					$("#am_description").val($(event.relatedTarget).data('am_description'));
	        	 	$("#am_from_officer").val($(event.relatedTarget).data('am_from_officer'));
	        	 	$("#am_to_officer").val($(event.relatedTarget).data('am_to_officer'));		
	        	 	//console.log("test am" + am_id);
	        	 	
	        	 	//check if user created the minute then allow edit
	        	 	if($(event.relatedTarget).data('am_from_officer') !== "${fullname}"){
						$("#btn_add_minutes").hide();
	        	 		
	        	 	}

					 switch (am_edit) {
							case 1:
								$("#btn_add_minutes").hide();
								$("#division_div").hide();
							break;
							default:
								$("#btn_add_minutes").show();
								$("#division_div").show();
								$("#am_description").val("")
								$("#am_to_officer").val("")
						}
				}else{
					//$("#btn_add_minutes").show();
					switch (am_edit) {
							case 1:
								$("#btn_add_minutes").hide();
								$("#division_div").hide();
							break;
							default:
								$("#btn_add_minutes").show();
								$("#division_div").show();
								$("#am_description").val("")
								$("#am_to_officer").val("")
						}
				}
				
        	 
			});
			
	
	 	  $('#form_add_minutes').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    //console.log('form submited Clicked');
        	    var action_on_form = $("#action_on_form_query").val();
        	    var am_id = $("#am_id").val();
        		var am_case_number = $("#am_case_number").val();
        		var am_job_number = $("#am_job_number").val();
        	    var am_description = $("#am_description").val();
        	 	var am_from_officer = $("#am_from_officer").val();
        	 	var am_to_officer = $("#am_to_officer").val();
        	
        	    var request_type="";
        	    
       	    	if(action_on_form =="edit"){ request_type = "select_lc_application_minutes_add_and_update"; }
       	    	else{ request_type ="select_lc_application_minutes_add_and_update"; }
       	    	
       	     console.log('form submited Clicked');
        		 $.ajax({
    				 type: "POST",
    				 url: "lc_application_minutes_serv",
    				
    				 data: {
    	                	request_type:request_type,
    	                	am_id:am_id,
    	                	 am_case_number:am_case_number,
    	                	am_job_number:am_job_number,
    	                	am_description:am_description,
    	                	am_from_officer:am_from_officer,
    	                	am_from_position:'',
    	                	am_to_officer:am_to_officer,
    	                	am_to_position:'',
    	                	am_status:false,
    		    	    /* 	modified_by:modified_by,
    		    	    	modified_by_id:modified_by_id   */
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
    					
    				   $('#addMinutesModal').modal('hide');
   	 				   $("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 				 $('#general_message_dialog #general_message_dialog_msg_new').val('Minutes has been added Successfully ');
    					
    				 }
    				
    				});
        		 return false;
        		 });

				 $('#form_add_sms').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        		var sms_case_number = $("#sms_case_number").val();
        		var sms_job_number = $("#sms_job_number").val();
        	    var sms_description = $("#sms_description").val();
        	 	var sms_from_officer = $("#sms_from_officer").val();
        	
        		 $.ajax({
    				 type: "POST",
    				 url: "lc_application_minutes_serv",
    				
    				 data: {
    	                	request_type:"select_send_message_on_application",
    	                	//sms_id:sms_id,
							sms_case_number:sms_case_number,
    	                	sms_job_number:sms_job_number,
    	                	sms_description:sms_description,
    	                	sms_from_officer:sms_from_officer
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
    					
    				   $('#addSMSModal').modal('hide');
   	 				   $("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 				 $('#general_message_dialog #general_message_dialog_msg_new').val('Message has been sent Successfully ');
    					
    				 }
    				
    				});
        		 return false;
        		 });
    	  
	 	 $('#btnCompleteJob').on('click', function(e){
     	   
     	   bootbox.confirm({
     		    title: "Action confrimation!",
     		    message: "Are you sure you want to set this job as work completed and push to Unit Head?",
     		    buttons: {
     		        cancel: {
     		            label: '<i class="fa fa-times"></i> Cancel'
     		        },
     		        confirm: {
     		            label: '<i class="fa fa-check"></i> Confirm'
     		        }
     		    },
     		    callback: function (result) {
     		    	if(result){
         	    		
         	    		var job_number = $("#cs_main_job_number").val();
         	    		var ar_name = $("#cs_main_ar_name").val();
         	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
         	    		var job_purpose = $("#ars_job_purpose").val();
         	       	 
         	     	    
         	     		 $.ajax({
         	 				 type: "POST",
         	 				 url: "Case_Management_Serv",
         	 				 data: {
         	 	                	request_type: 'select_update_application_as_work_done',
         	 	                	job_number: job_number ,
									  job_purpose: job_purpose
         	 				 	   },
         	 				 cache: false,
         	 				 
         	 				 success: function(jobdetails) {
         	 					 
         	 					var json_p = JSON.parse(jobdetails);
         	 					if( json_p.data=="Success"){
         	 	 				   $("#general_message_dialog").modal();
         	 	 				   $('#general_message_dialog #general_message_dialog_msg_new').val('Application Successfully Updated and Moved to Unit Dashboard ');
         	 					}else{
         	 					   $("#general_message_dialog").modal();
         	  	 				   $('#general_message_dialog #general_message_dialog_msg_new').val('Error Loading data!! ' );
         	 					}
         	 					
         	 					//push to storage
         	 					addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
         	 					
         	 					setTimeout(function(){window.history.go(-1)}, 3000);
         	 
         	 				 }
         	 				
         	 				});
         	     		 //return false;
         	    	
         	    	}
     		    }
     		});
     	 	
     	});	  


		 $('#btnApproveJob').on('click', function(e){
     	   
     	   bootbox.confirm({
     		    title: "Action confrimation!",
     		    message: "Are you sure you want to set this request as work approved?",
     		    buttons: {
     		        cancel: {
     		            label: '<i class="fa fa-times"></i> Cancel'
     		        },
     		        confirm: {
     		            label: '<i class="fa fa-check"></i> Confirm'
     		        }
     		    },
     		    callback: function (result) {
     		    	if(result){
         	    		
         	    		var job_number = $("#cs_main_job_number").val();
         	    		var ar_name = $("#cs_main_ar_name").val();
         	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
         	    		var job_purpose = $("#ars_job_purpose").val();
         	     	    
         	     		 $.ajax({
         	 				 type: "POST",
         	 				 url: "Case_Management_Serv",
         	 				 data: {
         	 	                	request_type: 'select_update_application_as_approve_work_done',
         	 	                	job_number: job_number ,
									  job_purpose: job_purpose
         	 				 	   },
         	 				 cache: false,
         	 				 
         	 				 success: function(jobdetails) {
         	 					 
         	 					var json_p = JSON.parse(jobdetails);
         	 					if( json_p.data=="Success"){
         	 	 				   $("#general_message_dialog").modal();
         	 	 				   $('#general_message_dialog #general_message_dialog_msg_new').val('Request successfully approved as work done.');
         	 					}else{
         	 					   $("#general_message_dialog").modal();
         	  	 				   $('#general_message_dialog #general_message_dialog_msg_new').val('Error Loading data!! ' );
         	 					}
         	 					
         	 					//push to storage
         	 					//addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
         	 					
         	 					setTimeout(function(){window.history.go(-1)}, 3000);
         	 
         	 				 }
         	 				
         	 				});
         	     		 //return false;
         	    	
         	    	}
     		    }
     		});
     	 	
     	});	 


		 $('#btnQueryJob').on('click', function(e){
     	   
     	   bootbox.confirm({
     		    title: "Action confrimation!",
     		    message: "Are you sure you want to set this request as query?",
     		    buttons: {
     		        cancel: {
     		            label: '<i class="fa fa-times"></i> Cancel'
     		        },
     		        confirm: {
     		            label: '<i class="fa fa-check"></i> Confirm'
     		        }
     		    },
     		    callback: function (result) {
     		    	if(result){
         	    		
         	    		var job_number = $("#cs_main_job_number").val();
         	    		var ar_name = $("#cs_main_ar_name").val();
         	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
         	    		var job_purpose = $("#ars_job_purpose").val();
         	     	    
         	     		 $.ajax({
         	 				 type: "POST",
         	 				 url: "Case_Management_Serv",
         	 				 data: {
         	 	                	request_type: 'select_update_application_as_request_queried',
         	 	                	job_number: job_number ,
									  job_purpose: job_purpose
         	 				 	   },
         	 				 cache: false,
         	 				 
         	 				 success: function(jobdetails) {
         	 					 
         	 					var json_p = JSON.parse(jobdetails);
         	 					if( json_p.data=="Success"){
         	 	 				   $("#general_message_dialog").modal();
         	 	 				   $('#general_message_dialog #general_message_dialog_msg_new').val('Request has been queried.');
         	 					}else{
         	 					   $("#general_message_dialog").modal();
         	  	 				   $('#general_message_dialog #general_message_dialog_msg_new').val('Error Loading data!! ' );
         	 					}
         	 					
         	 					//push to storage
         	 					//addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
         	 					
         	 					setTimeout(function(){window.history.go(-1)}, 3000);
         	 
         	 				 }
         	 				
         	 				});
         	     		 //return false;
         	    	
         	    	}
     		    }
     		});
     	 	
     	});	


     	      	$('#form_inspection').on('show.bs.modal', function (event) {
     	      		  var button = $(event.relatedTarget) // Button that triggered the modal
     	      		  var recipient = button.data('action') // Extract info from data-* attributes
     	      		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
     	      		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
     	      		  var modal = $(this)
     	      		  if(recipient=='edit'){
     	      			modal.find('.modal-body #action_on_form_valuation').val(recipient)
     	      			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
     	      			
     	      		  	
     	      		  	} 
     	      		  
     	      		  
     	      		});
     	      			
     	        
     	     	$('#form_inspection').on('submit', function(e){
     	      	  
     	     	// validation code here
     	    	    e.preventDefault();
     	    	    //console.log('form submited Clicked');

     	    	    var case_number = $("#in_case_number").val();
     	    	 	console.log(case_number);
     	    		var job_number = $("#in_job_number").val();
     	    		console.log(job_number);
     	    	   
     	    	 	var inspection_date = $("#in_inspection_date").val();
     	    	 console.log(inspection_date);
     	    	 	var inspection_purpose = $("#in_inspection_purpose").val();
     	    	 console.log(inspection_purpose);
     	    		var development_level = $("#in_development_level").val();
     	    		console.log(development_level);
     	    	    var possession_person = $("#in_possession_person").val();
     	    	 console.log(possession_person);
     	    	 	var neighborhood_description = $("#in_neighborhood_description").val();
     	    	 console.log(neighborhood_description);
     	    	 	var neighbor_names =$("#in_neighbor_names").val();
     	    	 console.log(neighbor_names);
     	       	    var ground_opinion =$("#in_ground_opinion").val();
     	       	console.log(ground_opinion);
     	    	 	var created_by =$("#in_modified_by").val();
     	    	 console.log(created_by);
     	       	    var created_by_id =$("#in_modified_by_id").val();
     	       	console.log(created_by_id);
     	       	    
     	       	    
     	       		var userid_1 = $( "#requested_by" ).val();  // $( "#user_to_send_to option:selected" ).text();
     	       	 	var requested_by_id = $('#listofusers option').filter(function() {return this.value == userid_1; }).data('id');
     	       		var requested_by = $('#listofusers option').filter(function() {return this.value == userid_1; }).data('name');
     	       	
     	       		console.log(requested_by);     
     	       		console.log(requested_by_id);
     	       		 
     	    		  $.ajax({
     					 type: "POST",
     					 url: "Case_Management_Serv",
     					 data: {
     		                	request_type : 'insert_update_on_lc_inspection_reports',
     		                	job_number : job_number,
     		                	case_number	: case_number,
     		                	requested_by_id : requested_by_id,
     		                	requested_by : requested_by,
     		                	inspection_date : inspection_date,
     		                	inspection_purpose : inspection_purpose,
     		                	development_level : development_level,
     		                	possession_person : possession_person,
     		                	neighbor_names : neighbor_names,
     		                	ground_opinion : ground_opinion,
     		                /* 	created_by :created_by,
     			    	    	created_by_id : created_by_id, */
     		                	neighborhood_description: neighborhood_description
     			    	    	
     					 	   },
     					 cache: false,
     					 beforeSend: function () {
     						 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     					 },
     					 success: function(jobdetails) {
     						 
     						 
     						$('#form_inspection').modal('hide');
       	 					$("#general_message_dialog").modal();
       	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
       	 					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
     						 
     						 
     					 },
     					 error: function(err){
     						 console.log(err);
     					 }
     	      				
     	      		}); });

	  			$('#btnJobNumberSearch').on('click', function(e){
         	      	  
         	     	// validation code here
         	    	    e.preventDefault();
     	    		//console.log('how are your search new');
     	    		
     	    		var job_number = $("#search_job_number").val().toUpperCase();
     	    		 $.ajax({
     					 type: "POST",
     					 url: "Case_Management_Serv",
     					 data: {
     		                	request_type: 'load_application_details_by_job_number',
     		                	job_number:job_number},
     					 cache: false,
     					 beforeSend: function () {
     						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     					 },
     					 success: function(jobdetails) {
     						
     						// console.log(jobdetails);
     						
     						 var result = JSON.parse(jobdetails);
     						 
     					        //console.log(result)
     					        
     						if(result.job_detail !==null){
    				        	//console.log("not null")
    				        	
     							$("job_number_placeholder").append(result.job_detail.job_number);  
        					     
        					     
        					     $("#fe_client_name").val( result.transaction_details.ar_name);
        					    $("#febusiness_process_sub_name").val(result.job_detail.business_process_sub_name); 
        					        
        					        
        					    
        					   $("#fe_job_number").val(result.job_detail.job_number);
        					   
        					   
        					  $("#fe_nature_of_instrument").val(result.transaction_details.nature_of_instrument);
   	     					 $("#fe_type_of_interest").val(result.transaction_details.type_of_interest);
   	     					 $("#fe_type_of_use").val(result.transaction_details.type_of_use);
   	     					 $("#fe_consideration_fee").val(result.transaction_details.consideration_fee);
   	     					 //console.log('date: '+result.transaction_details.date_of_document);
   	     					 $("#fe_date_of_document").val(result.transaction_details.date_of_document);
   	     					 $("#fe_commencement_date").val(result.transaction_details.commencement_date);
   	     					   $("#fe_transaction_number").val(result.transaction_details.transaction_number);
   	     				
   	     					 $("#fe_term").val(result.transaction_details.term);
   	     					 $("#fe_renewal_term").val(result.transaction_details.renewal_term);
   	     					 $("#fe_family_name").val(result.transaction_details.stool_family_name);
   	     					 $("#fe_grantor_family").val(result.transaction_details.family_of_grantor);
   	     					 $("#fe_annual_rent").val(result.transaction_details.annual_rent);
   	     				 	 $("#fe_file_number").val(result.transaction_details.case_file_number);
   	     					
     		
   	     					 
        					   
   	     					 $("#fe_surveyor_number").val(result.parcel_details.licensed_no);
   	     					 $("#fe_regional_number").val(result.parcel_details.regional_number);
   	     					 $("#fe_land_size").val(result.parcel_details.land_size);
   	     					 $("#fe_case_number").val(result.transaction_details.case_number);
   	     					 $("#fe_locality").val(result.parcel_details.locality);
   	     					 $("#fe_district").val(result.parcel_details.district);
   	     					 $("#fe_region").val(result.parcel_details.region);
   	     					 $("#fe_extent").val(result.parcel_details.extent);
							 $("#fe_registry_mapref").val(result.parcel_details.registry_mapref);

   	     					 
   	     					   $("#main_service_id_fe").val(result.job_detail.business_process_id); 
   	     					   $("#main_service_sub_id_fe").val(result.job_detail.business_process_sub_id); 
   	     					   
   	     	
   	     					
   	     					 var fe_case_number_new= result.transaction_details.transaction_number;
   	     					 
   	     					 //console.log("case is " + fe_case_number_new);
    				        	
   	     					$.ajax({
	        					 type: "POST",
	        					 url: "Case_Management_Serv",
	        					 data: {
	        		                	request_type: 'select_get_parties_by_case',
	        		                	case_number: fe_case_number_new},
	        					 cache: false,
	        					 beforeSend: function () {
	        						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	        					 },
	        					 success: function(jobdetails) {
	        						
	        						 //console.log("details: " + jobdetails);
	        						if(jobdetails.includes("Data Not Received")){
	        							//console.log("not ");
	        						}else{
	        							
	        						
	        						 var result = JSON.parse(jobdetails);
	        						 
	        						 var table = $('#party_details_datatable');
	          					    table.find("tbody tr").remove();
	          					
	          					    //console.log(jobdetails);
	          					    var json_p = JSON.parse(jobdetails);
	          					    
	          					    $(json_p).each(function () {
	          				               
	          				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');
											//<td>" + this.ar_client_id + "</td>
	          				                  
	          								    table.append("<tr><td>" +this.ar_name + "</td><td>" +this.ar_gender + "</td><td>" +this.ar_cell_phone + "</td><td>" +this.type_of_party + "</td>"
	          								    		
	          								    		
	          								    			 
	          								    	  +  '<td><p data-placement="top"  title="Edit Party"> ' 
	          								    	  +'<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"'
	          								    	  +'data-target="#addeditpartyGeneral"' 
	          								    	  +' data-target-id="' + this.ar_client_id 
	          								    	  +'"  data-ar_name="' + this.ar_name 
	          								    	  +'"  data-ar_gender="' + this.ar_gender 
	          								    	 +'"  data-ar_address="' + this.ar_address
	          								    	  +'"  data-ar_cell_phone="' + this.ar_cell_phone 
	          								    	  +'" data-ar_cell_phone2="' + this.ar_cell_phone2
	          								    	  +'" data-ar_tin_no="' + this.ar_tin_no 
	          								    	  +'" data-ar_id_type="' + this.ar_id_type 
	          								    	  +'" data-ar_id_number="' + this.ar_id_number
	          								    	  +'" data-ar_location="' + this.ar_location 
	          								    	  +'" data-ar_district="' + this.ar_district 
	          								    	  +'" data-type_of_party="' + this.type_of_party
	          								    	  +'" data-ar_region="' + this.ar_region
	          								    	  +'" data-ar_person_type="' + this.ar_person_type
	          								    	  + '"> ' 
	          								    	  +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
	          								    	   
	          					         + "</tr>");
	          							        
	          				              });
	        						    
	        					 }}
	        					 });
    				        }else{
    				        	
    				        	$.notify({
    			                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
    			                }, {
    			                    type: 'danger'
    			                });
    				        	
    				        }
     					 }
     					 }); 
     	        });
	  			

				 $("#btn_reply_message_alert").on('click', function(e){

e.preventDefault();

var am_to_officer = $("#sender_name_text").val();
var userid  = $("#userid_text").val();
var message = $("#txt_reply_message_alert").val();

console.log(am_to_officer)

if (!message || !userid){
	alert("Please enter a message");
}else{
	$.ajax({
		type : "POST",
		url : "Case_Management_Serv",
		data : {
			request_type : 'select_send_message_to_officer',
			am_to_officer : am_to_officer,
			userid : userid,
			message : message
		},
		cache : false,
		beforeSend : function() {
		},
		success : function(jobdetails) {

			console.log(jobdetails);

			if(jobdetails = 'success'){
				$.notify({
					message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Message sent successfully.</span>',
				}, { type : 'success', z_index : 9999 });

				setTimeout(function(){
					window.location.reload();
				 }, 2000);

			}else {
				$.notify({
					message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error. Contact IT for support.</span>',
				}, { type : 'danger' , z_index: 9999  });
			}			
		}
	})
}
})

document.getElementById('addFile').addEventListener('click', function() {
					const fileContainer = document.getElementById('fileContainer');
					const clonedCard = fileContainer.cloneNode(true);

					const fileInput = clonedCard.querySelector('input[type="file"]');
					fileInput.id = ''; // Clear the ID or assign a unique one if needed

					const previewBtn = clonedCard.querySelector('.previewBtn');
					previewBtn.addEventListener('click', function() {
						previewFile(fileInput);
					});

					const removeBtn = document.createElement('button');
					removeBtn.type = 'button';
					removeBtn.className = 'btn btn-danger btn-sm removeBtn text-sm small';
					removeBtn.textContent = 'Remove';
					clonedCard.querySelector('form').appendChild(removeBtn);

					fileContainer.parentNode.insertBefore(clonedCard, fileContainer.nextSibling);

					removeBtn.addEventListener('click', function() {
						clonedCard.remove();
					});

				});

				document.getElementById('addOCFile').addEventListener('click', function() {
					const fileContainer = document.getElementById('ocfileContainer');
					const clonedCard = fileContainer.cloneNode(true);

					const fileInput = clonedCard.querySelector('input[type="file"]');
					fileInput.id = ''; // Clear the ID or assign a unique one if needed

					const previewBtn = clonedCard.querySelector('.ocPreviewBtn');
					previewBtn.addEventListener('click', function() {
						previewFile(fileInput);
					});

					const removeBtn = document.createElement('button');
					removeBtn.type = 'button';
					removeBtn.className = 'btn btn-danger btn-sm removeBtn text-sm small';
					removeBtn.textContent = 'Remove';
					clonedCard.querySelector('form').appendChild(removeBtn);
					fileContainer.parentNode.insertBefore(clonedCard, fileContainer.nextSibling);
					removeBtn.addEventListener('click', function() {
						clonedCard.remove();
					});
				});

				const originalPreviewBtn = document.querySelector('.previewBtn');
				originalPreviewBtn.addEventListener('click', function() {
					previewFile(document.getElementById('publicFileUploadForm'));
				});

				const originalOCPreviewBtn = document.querySelector('.ocPreviewBtn');
				originalOCPreviewBtn.addEventListener('click', function() {
					previewFile(document.getElementById('fileUploadForm'));
				});

				function previewFile(fileInput) {
					const file = fileInput.files[0];

					if (file && file.type === 'application/pdf') {
						const objectURL = URL.createObjectURL(file); // Create an object URL for the file
						document.getElementById('elisdovumentpreviewblobfile').src = objectURL;
						$('#elisDocumentPreview').modal('show');

						// Clean up the object URL after the preview modal is closed
						$('#elisDocumentPreview').on('hidden.bs.modal', function () {
							URL.revokeObjectURL(objectURL); // Free up memory by revoking the object URL
						});

			} else {
				alert('Please select a valid PDF file.');
			
			}
		}	
    });
	</script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="js/sb-admin-2.min.js"></script>
<script src="js/loadingOverlay.js"></script>
 ${(page_name == "case_processing") || (page_name == "further_entries") ? "<script src='jsmap/lcmaps.js'></script>" : ""}
  
 ${page_name == "case_processing" ? "<script src='jsmap/lrdmaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='jsmap/lrdfpmaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='jsmap/lcfrsmaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='jsmap/smdfrtpmaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='jsmap/pvlmd_spatial.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='jsmap/lcfrfamaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='pvlmd_maps_templates/dlrevmaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='smd_maps_templates/smdmaps.js'></script>" : ""}
 ${page_name == "case_processing" ? "<script src='jsmap/lvdcomparablemaps.js'></script>" : ""}
 ${page_name == "lvd_compensation_maps" ? "<script src='lvd_compensation_maps/lvd_compensation_maps.js'></script>" : ""}
 ${page_name == "rent_management_maps" ? "<script src='rent_management/rent_management_maps.js'></script>" : ""}
  ${page_name == "rent_management_maps" ? "<script src='rent_management/rent_management.js'></script>" : ""}
 ${page_name == "strata_management_maps" ? "<script src='strata_plan_management/strata_management_maps.js'></script>" : ""}
 ${page_name == "lvd_category_rate" ? "<script src='lvd_category_rates/lvd_category_rate.js'></script>" : ""}
 ${page_name == "lvd_crop_rates" ? "<script src='lvd_crop_rates/lvd_crop_rates.js'></script>" : ""}
 ${page_name == "lrd_map_blocking_module" ? "<script src='jsmap/lrd_map_blocking_module.js'></script>" : ""}
<script src="js_includes/professional_tem.js"></script>
<script src="js_includes/transitional_tem.js"></script>
<script src="js_includes/case_movement.js"></script>
<script src="js_includes/all_functions.js"></script>
${page_name == "user_management" ? "<script src='js_includes/user_mgt.js'></script>" : ""}
${(page_name == "page_enquiry_backoffice") || (page_name == "csau_backoffice") ? "<script src='js_includes/enquiry_backoffice.js'></script>" : ""}
${(page_name == "page_bulk_csau_collection") ? "<script src='js_includes/bulk_csau_collection.js'></script>" : ""}
${page_name == "page_appdata_transfer_template" ? "<script src='js_includes/_apps_update.js'></script>" : ""}
${(page_name == "page_bulk_csau_receiving") ? "<script src='js_includes/bulk_csau_receiving.js'></script>" : ""}
${(page_name == "page_bulk_collection_for_payment") ? "<script src='js_includes/bulk_collection_for_payment.js'></script>" : ""}
${(page_name == "page_cabinet_completed_searches") ? "<script src='js_includes/cabinet_completed_searches.js'></script>" : ""}
${(page_name == "page_reverse_transaction_approval") ? "<script src='js_includes/reverse_transaction_approval.js'></script>" : ""}
${page_name == "page_enquiry_desk" ? "<script src='js_includes/enquiry_collections.js'></script>" : ""}
${page_name == "upload_scanned_site_plan" ? "<script src='js_includes/upload_scanned_site_plan.js'></script>" : ""}
${page_name == "page_enquiry_teller" ? "<script src='js_includes/enquiry_teller.js'></script>" : ""}
${page_name == "page_enquiry_desk_stamping" ? "<script src='js_includes/enquiry_collections_stamping.js'></script>" : ""}
${(page_name == "further_entries_new") || (page_name == "further_entries") ? "<script src='js_includes/_further_entries.js'></script>" : ""}
${page_name == "smd_temp_barcode" ? "<script src='js_includes/smd_temp_barcode.js'></script>" : ""}
${page_name == "settings_milestones" ? "<script src='setup/_manage_milestone.js'></script>" : ""}
${page_name == "settings_checklist" ? "<script src='setup/_manage_checklist.js'></script>" : ""}
${page_name == "settings_all" ? "<script src='setup/_manage_settings.js'></script>" : ""}
${(page_name == "page_file_management") || (page_name == "further_entries_new") || (page_name_ == "review_application_progress_details") ? "<script src='js_includes/file_management.js'></script>" : ""}
${page_name == "page_file_management_receive_hard_copy" ? "<script src='js_includes/page_file_management_receive_hard_copy.js'></script>" : ""}
${page_name == "unit_case_management" ? "<script src='js_includes/unit_case_management.js'></script>" : ""}
${page_name == "unit_case_management_revised" ? "<script src='js_includes/unit_case_management_revised.js'></script>" : ""}
${page_name == "certificate_signing_module" ? "<script src='js_includes/certificate_signing.js'></script>" : ""}
${page_name == "publication_management" ? "<script src='js_includes/publication.js'></script>" : ""}
${page_name == "settings_basic" ? "<script src='js_includes/settings_basic.js'></script>" : ""}
${page_name == "settings_units" ? "<script src='js_includes/settings_units.js'></script>" : ""}
${page_name == "csau_backoffice" ? "<script src='js_includes/csau_backoffice.js'></script>" : ""}
${page_name == "help_desk" ? "<script src='js_includes/help_desk.js'></script>" : ""}
${(page_name == "first_registration_record_verification")||( page_name == "case_processing") ? "<script src='js_includes/unit_case_management_frrv.js'></script>" : ""}
${(page_name == "consolidated_search_template")||( page_name == "case_processing") ? "<script src='js_includes/unit_case_management_cst.js'></script>" : (page_name == "corporate_frrv_cst_module")||( page_name == "case_processing") ? "<script src='js_includes/unit_case_management_frrv_cst.js'></script>" : ""}
${page_name == "title_plan_preparation" ? "<script src='js_includes/unit_case_management_tpp.js'></script>" : ""}
${page_name == "app_update" ? "<script src='js_includes/app_update.js'></script>" : ""}
${page_name == "message_center" ? "<script src='js_includes/message_center.js'></script>" : ""}
${(page_name == "transitional_plotting_module") || (page_name == "coordinate_entry_and_record_verification") || (page_name == "plot_vetting_and_approval") || (page_name == "plot_final_approval") ? "<script src='js_includes/map_plotting.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js_includes/load_application_details.js'></script>" : ""}
${page_name == "rent_management_dashboard" ? "<script src='rent_management/rent_management.js'></script>" : ""}
${page_name == "strata_management_dashboard" ? "<script src='strata_plan_management/strata_management.js'></script>" : ""}
${page_name == "payment_receipt_dashboard" ? "<script src='payment_receipt_management/payment_receipt_management.js'></script>" : ""}
<script src="csau_template/csau_online.js"></script>
<!-- <script src="js_includes/app_modal_fills.js"></script> -->
<script src="js_includes/users_to_batch.js"></script>
<script src="js_includes/_user_profile.js"></script>
<script src="transitional_templates/transitional_tem.js"></script>
<script src="pvlmd_maps_templates/pvlmd_transaction_search.js"></script>
<script src="js_includes/letters_template.js"></script>
<script src="lrd_maps_templates/lrd_transaction_search.js"></script>
<script src="smd_maps_templates/smd_transaction_search.js"></script>
<script src="js_includes/public_document_upload.js"></script>
<script src="js_includes/notifications.js"></script>
<script src="legal/includes/bootstrap/js/toastr.min.js"></script>
<script type="text/javascript" src="js/tabulator.js"></script>
<script type="text/javascript" src="pdf/jspdf.min.js"></script>
<script type="text/javascript" src="pdf/jspdf.plugin.autotable.js"></script>
${page_name == "reports_by_application_type" ? "<script src='js_includes/reports_by_app_type.js'></script>" : ""}
${page_name == "reports" ? "<script src='js_includes/reports.js'></script>" : ""}
${page_name == "audit_reports" ? "<script src='js_includes/audit_reports.js'></script>" : ""}
${page_name == "reports_stamping" ? "<script src='js_includes/reports_stamping.js'></script>" : ""}
${page_name == "login" ? "<script src='js_includes/dashboard.js'></script>" : ""}
${page_name == "help_desk" ? "<script src='js_includes/help_desk.js'></script>" : ""}
${(page_name == "compliance_cst") || (page_name == "compliance") || (page_name=="unit_case_management") || (page_name=="certificate_signing_module") ? "<script src='js_includes/compliance.js'></script> " : ""}
${(page_name == "compliance_cst") || (page_name == "compliance") || (page_name=="unit_case_management") || (page_name == "account-reports") || (page_name=="compliance_no_login") ? "<script src='js/echarts/echarts.min.js'></script> " : ""}
${(page_name == "compliance_cst") ? "<script src='js_includes/compliance_cst.js'></script> " : ""}
${(page_name == "compliance_no_login") ? "<script src='js_includes/compliance_no_login.js'></script> " : ""}
${(page_name == "compliance_cst") ? "<script src='js_includes/corporate_application.js'></script> " : ""}
${(page_name == "account-reports")  ? "<script src='js_includes/account_reports.js'></script> " : ""}
${(page_name == "account-reports-grand-rent")  ? "<script src='js_includes/account_reports_rent.js'></script> " : ""}
${(page_name == "compliance_query_and_response") || (page_name == "regional_compliance_query_and_response") || (page_name == "compliance_notice_report") ? "<script src='js_includes/compliance_query_and_response.js'></script> " : ""}
${(page_name == "director_compliance") ? "<script src='js_includes/director_compliance.js'></script> " : ""}
${(page_name == "director_compliance") ? "<script src='js/echarts/echarts.min.js'></script> " : ""}
${(page_name == "focal_compliance_person") ? "<script src='js_includes/focal_person.js'></script> " : ""}
${(page_name == "focal_compliance_person") ? "<script src='js/echarts/echarts.min.js'></script> " : ""}
${(page_name == "milestone_update")  ? "<script src='js_includes/_apps_update.js'></script> " : ""}
${(page_name == "application_review_details_advanced")  ? "<script src='js_includes/application_review_details_advanced.js'></script> " : ""}

<script src="js/js/jquery.steps.js"></script>
<script src="js/js/main.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap-notify.js"></script>
<script src='js/lodash.min.js'></script>
<script src="js/bootbox.min.js"></script>
<script src="js/jsw/jquery.smartWizard.js" type="text/javascript"></script>
<script src="js/summernote.min.js" type="text/javascript"></script>
<script src="js/datatables-js/dataTables.responsive.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
	var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	function convertDate(date_str) {
		temp_date = date_str.split("-");
		return temp_date[2] + " " + months[Number(temp_date[1]) - 1] + " " + temp_date[0];
	}
</script>
<jsp:include page="../includes/_modals.jsp"></jsp:include>
<jsp:include page="../lrd_maps_templates/lrd_maps_modals.jsp"></jsp:include>
<jsp:include page="../user_management/user_mgt_modals.jsp"></jsp:include>
<jsp:include page="../professional_templates/_professionals_modals.jsp"></jsp:include> 
<jsp:include page='${(page_name == "page_enquiry_desk") || (page_name == "page_enquiry_backoffice") ||(page_name == "page_enquiry_desk_stamping") || (page_name == "csau_backoffice") || (page_name == "page_enquiry_teller") ? "../includes/_enquiry_modals.jsp" : ""}'></jsp:include>
<jsp:include page="../pvlmd_maps_templates/pvlmd_maps_modals.jsp"></jsp:include>
<jsp:include page="../csau_template/_csau_online_modals.jsp"></jsp:include>
<jsp:include page="../includes/_profile_modal.jsp"></jsp:include>
<jsp:include page="../transitional_templates/_transitional_modals.jsp"></jsp:include>
<jsp:include page="../smd_maps_templates/smd_maps_modals.jsp"></jsp:include>
<jsp:include page='${(page_name == "compliance_cst") ||(page_name == "compliance")|| (page_name=="unit_case_management") || (page_name=="compliance_no_login") || (page_name=="compliance_query_and_response") || (page_name=="regional_compliance_query_and_response") || (page_name=="compliance_notice_report") ? "../includes/_compliance_modals.jsp" : ""}'></jsp:include>	
<jsp:include page='${(page_name == "compliance_cst") ||(page_name == "compliance")|| (page_name=="unit_case_management")|| (page_name=="certificate_signing_module") ? "../includes/_compliance_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "director_compliance") ? "../includes/_director_compliance_modals.jsp" : ""}'></jsp:include>	
<jsp:include page='${(page_name == "director_compliance")  ? "../includes/_director_compliance_modals.jsp" : ""}'></jsp:include>	
<jsp:include page='${(page_name == "executive_dashboard")  ? "../includes/_executive_dashboard_modals.jsp" : ""}'></jsp:include>	
<jsp:include page='${(page_name == "focal_compliance_person") ? "../includes/_focal_compliance_modals.jsp" : ""}'></jsp:include>	
<jsp:include page='${(page_name == "focal_compliance_person")  ? "../includes/_focal_compliance_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "rent_management_dashboard")  ? "../rent_management/rent_management_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "rent_management_maps")  ? "../rent_management/rent_management_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "strata_management_dashboard")  ? "../strata_plan_management/strata_management_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "lvd_category_rate") ? "../lvd_category_rates/lvd_category_rate_modals.jsp" : ""}'></jsp:include>	
<jsp:include page='${(page_name == "lvd_compensation_maps")  ? "../lvd_compensation_maps/lvd_compensation_maps_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "lvd_crop_rates")  ? "../lvd_crop_rates/lvd_crop_rate_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "payment_receipt_dashboard")  ? "../payment_receipt_management/payment_receipt_modals.jsp" : ""}'></jsp:include>
<script>
const stepButtons = document.querySelectorAll('.step-button');
const progress = document.querySelector('#progress');
Array.from(stepButtons).forEach((button,index) => {
    button.addEventListener('click', () => {
        progress.setAttribute('value', index * 100 /(stepButtons.length - 1) );//there are 3 buttons. 2 spaces.

        stepButtons.forEach((item, secindex)=>{
            if(index > secindex){
                item.classList.add('done');
            }
            if(index < secindex){
                item.classList.remove('done');
            }
        })
    })
})

$(document).on('show.bs.modal', '.modal', function () {
    const zIndex = 1040 + (10 * $('.modal:visible').length);
    $(this).css('z-index', zIndex);
    setTimeout(() => {
        $('.modal-backdrop').not('.stacked').css('z-index', zIndex - 1).addClass('stacked');
    }, 0);
});

</script>
</body>
</html>