<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<!-- Footer -->
<footer class="sticky-footer bg-white">
	<div class="container my-auto">
		<div class="copyright text-center my-auto">
			<!-- <button id="clickbutton">chrome</button> -->
			<span>Copyright &copy; Lands Commission 2021</span>
		</div>
	</div>
</footer>
<!-- End of Footer -->


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
					<span aria-hidden="true"></span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
		 	<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="" onclick="">Logout</a>
					<input type="text" id="val_fullname" value="${fullname}" type="hidden">
			</div>

		</div>
	</div>
</div>

<!-- Bootstrap core JavaScript-->
<script>
    $(document).ready(function(){
    	
    	
    	
    	/* $("#clickbutton").on("click", function(){
			//console.log("ajaxStop");
			

	    	/* const headers = new Headers();
	    	headers.append('Content-Type', 'application/json');

	    	const body = '{"job_number":"LCGAOS21565362020"}';

	    	const init = {
	    	  method: 'POST',
	    	  headers,
	    	  body
	    	};

	    	fetch('http://localhost:8080/gelis_online_service_live/rest/case_management_service/load_application_milestone_for_tracking_by_job', init)
	    	.then((response) => {
	    	  console.log(response.json()); // or .text() or .blob() ...
	    	})
	    	.then((text) => {
	    	  // text is the response body
	    	})
	    	.catch((e) => {
	    	  // error in e.message
	    	}); *
	    	
	    	
	    	var url = 'Case_Management_Serv';
	    	var data = {"request_type": "check_session_expired"};

	    	fetch(url, {
	    	  method: 'POST', // or 'PUT'
	    	  body: JSON.stringify(data), // data can be `string` or {object}!
	    	  headers:{
	    	    'Content-Type': 'application/json'
	    	  }
	    	}).then(res => res.text())
	    	.then(response => console.log( JSON.stringify(response)))
	    	.catch(error => console.error('Error:', error));
		
		}); */
    	
    	
    	
    	
    	
    	$('.modal-dialog').draggable({
    	      handle: ".modal-header"
    	    });

    	/* $('#body-dg-4').draggable({
    	      handle: "#number-text-4"
    	    }); */
    	
    	$('#my-summernote, #lc_search_report_summary_details, #lc_search_report_summary_details_final, #lc_letter_template_description').summernote({
    		  minHeight: 400,
    		  placeholder: 'Write here ...',
    		  focus: false,
    		  airMode: false,
    		  fontNames: ['Roboto', 'Calibri', 'Times New Roman', 'Arial'],
    		  fontNamesIgnoreCheck: ['Roboto', 'Calibri'],
    		  dialogsInBody: true,
    		  dialogsFade: true,
    		  disableDragAndDrop: false,
    		  toolbar: [
    		    // [groupName, [list of button]]
    		    ['style', ['bold', 'italic', 'underline', 'clear']],
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
    	
    	    /* $('#my-summernote, #lc_search_report_summary_details, #lc_search_report_summary_details_final').summernote();
    		$('#my-summernote, #lc_search_report_summary_details, #lc_search_report_summary_details_final').summernote('code', '<ol><li>sdfgsdfgsd</li></ol>');
    		 */

    		$( document ).ajaxStart(function() {
    			// Statement
    			
        		spinHandle = loadingOverlay().activate();
        		console.log("ajaxStart");
        		
        		//check for login session expired
        		 /* $.ajax({
					 type: "POST",
					 url: "Case_Management_Serv",
					 data: {
		                	request_type: 'check_session_expired',
					 	   },
					 cache: false,
					 success: function(jobdetails) {
						 	console.log("Session: " + jobdetails);
						 	var json_p = JSON.parse(jobdetails);
						 	var fullname = null;
						 	fullname = $("#val_fullname").val();
						 	if(json_p.success==="false" || !fullname){
						 		$("#general_message_dialog").modal();
								//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
								$('#general_message_dialog #general_message_dialog_msg_new').val("Sorry pls! Your session expired");
								doLogoutClearing();
								window.location.replace("Logout");
						 	}
					  }}); */
        		
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
    		      
    		    // If currency is in format like 
    		    // 458, 656.75 then we used replace 
    		    // method to replace every ', ' with '' 
    		    temp = temp.replace(/, /, ''); 
    		      
    		    // Converting string to float 
    		    // or double and return 
    		    return parseFloat(temp); 
    		      
    		          
    		} 
         
         window.addFileToList = function addFileToList(job_number,ar_name,business_process_sub_name,locality){
    		 var obj = {
    	 			'Job Number': job_number,
    	 			'Applicant Name ': ar_name,
    	 			'Application Type' : business_process_sub_name,
    	 			'Locality' : locality
    	 		};
    	 	

    	 	//var json= JSON.stringify( obj);
    	 	
    	 	
    	 	var existing = localStorage.getItem('fileBatchingListData');

    	 		// If no existing data, create an array
    	 		// Otherwise, convert the localStorage string to an array
    	 		//existing = existing ? existing.split(',') : [];
    	 		existing = existing ? JSON.parse(existing) : {};

    	 		// Add new data to localStorage Array
    	 		//existing.push(json);
    	 		existing[job_number] = obj;

    	 		// Save back to localStorage
    	 		localStorage.setItem('fileBatchingListData', JSON.stringify(existing));
    				
    	 		//alert(localStorage.getItem('batchlistdata'));
    	 		
    				    //alert("Added to Batch List");
    				    prepareFileBatchingModal();
    	}
         window.removeJobFileBatchingList = function removeJobFileBatchingList(job_number){
       		 //alert(job_number)
       		var existing = localStorage.getItem('fileBatchingListData');
       		existing = existing ? JSON.parse(existing) : []
       		delete existing[job_number];
       		localStorage.setItem('fileBatchingListData', JSON.stringify(existing));
       		prepareFileBatchingModal();
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
 				 
 			//console.log(JSON.stringify(existing));
         }
         
         //////////////////////////////////////////
    	 
         window.addJobToCompletedQueriedList = function addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose){
    		 var obj = {
    	 			'Job Number': job_number,
    	 			'Applicant Name ': ar_name,
    	 			'Application Type' : business_process_sub_name,
    	 			'Status' : job_purpose
    	 		};
    	 	

    	 	//var json= JSON.stringify( obj);
    	 	
    	 	
    	 	var existing = localStorage.getItem('completedQueriedListData');

    	 		// If no existing data, create an array
    	 		// Otherwise, convert the localStorage string to an array
    	 		//existing = existing ? existing.split(',') : [];
    	 		existing = existing ? JSON.parse(existing) : {};

    	 		// Add new data to localStorage Array
    	 		//existing.push(json);
    	 		existing[job_number] = obj;

    	 		// Save back to localStorage
    	 		localStorage.setItem('completedQueriedListData', JSON.stringify(existing));
    				
    	 		//alert(localStorage.getItem('batchlistdata'));
    	 		
    				    //alert("Added to Batch List");
    				    prepareCompletedQueriedModal();
    	}
         window.removeJobFromCompletedQueriedList = function removeJobFromCompletedQueriedList(job_number){
       		 //alert(job_number)
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
 				 
 			//console.log(JSON.stringify(existing));
         }
         
         $('#btn_clear_all_batchlist').on('click', function(e){
        	 
        	 
        	 var confirmText = "Are you sure you want to remove all applications from list? Note that this cannot be undone";
			    if(confirm(confirmText)) {
				
	        		localStorage.removeItem('batchlistdata');
	        		prepareBatchlistModal();
         		}
		  	
         });
         
         
    	 window.addJobToBatchlist = function addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose){
    		 var obj = {
    	 			'Job Number': job_number,
    	 			'Applicant Name ': ar_name,
    	 			'Application Type' : business_process_sub_name,
    	 			'Batching Purpose' : job_purpose
    	 		};
    	 	

    	 	//var json= JSON.stringify( obj);
    	 	
    	 	
    	 	var existing = localStorage.getItem('batchlistdata');

    	 		// If no existing data, create an array
    	 		// Otherwise, convert the localStorage string to an array
    	 		//existing = existing ? existing.split(',') : [];
    	 		existing = existing ? JSON.parse(existing) : {};

    	 		// Add new data to localStorage Array
    	 		//existing.push(json);
    	 		existing[job_number] = obj;

    	 		// Save back to localStorage
    	 		localStorage.setItem('batchlistdata', JSON.stringify(existing));
    				
    	 		//alert(localStorage.getItem('batchlistdata'));
    	 		
    				    //alert("Added to Batch List");
    				    prepareBatchlistModal();
    	}
    	 
    		window.removeJobFromBatchlist = function removeJobFromBatchlist(job_number){
       		 //alert(job_number)
       		var existing = localStorage.getItem('batchlistdata');
       		existing = existing ? JSON.parse(existing) : []
       		delete existing[job_number];
       		localStorage.setItem('batchlistdata', JSON.stringify(existing));
       		prepareBatchlistModal();
       	}
           
    		
    		window.prepareBatchlistModal = function prepareBatchlistModal(){
	        	 
	        	 var existing = localStorage.getItem('batchlistdata');
					//console.log(existing);
	 	            /* 
	 	           	 for (var key1 in existing) {
	 	           	  var e1 = existing[key1];
	 	           	  for (var key2 in e1) {
	 	           	    //var e2 = e1[key2];
	 	           	 	console.log(e1[key2]);
	 	           	 	
	 	           	  }
	 	           	} 
	 				 */
	 				 
	 				//!==
	 				 // if(existing AND !(existing.length < 3) ){
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
	 	    							row.append('<td><button type="button" onclick="removeJobFromBatchlist(\'' + list[i][cols[colIndex -3]] +'\')" class="btn btn-danger" >Remove</button></td>');
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
	 				 
	 			//console.log(JSON.stringify(existing));
	         }
    	
    	
    	/* $(document).on('click', 'input[name="interaction_type"]', function() {
    		alert($(this).val());
    	}); */
    	
    	
    	
    	
         function showSuggestions(job_number) {
        	 
        	 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'select_load_details_for_batching',
	                	job_number:job_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					
					 var json_p = JSON.parse(jobdetails);
					 
					 //var json_p_details = JSON.parse(json_p.jobdetails);
		        	//console.log(json_p_details)
					 $('#edit #bl_job_number').val(json_p.jobdetails.job_number);
					 $('#edit #bl_jn_id').val(json_p.jobdetails.jn_id);
					 $('#edit #bl_ar_name').val(json_p.jobdetails.ar_name);
					 
					 $('#edit #bl_business_process_sub_name').val(json_p.jobdetails.business_process_sub_name);
					 
					
					 
		        	  var result = $('#result');
		        	  result.html('');

		        	/*   for (var i = 0; i < usernames.length; i++) {
		        	    result.append('<label><input type="radio" name="usernames" value="' + usernames[i] + '" /> ' + usernames[i] + '</label>');
		        	  }  */
		        	  
		        	  // var ddlCustomers = $("#ddlCustomers");
		              $(json_p.milestones).each(function () {
		                 /*  var option = $("<option />");

		                  //Set Customer Name in Text part.
		                  option.html(this.Name);

		                  //Set Customer CustomerId in Value part.
		                  option.val(this.CustomerId);

		                  //Add the Option element to DropDownList.
		                  ddlCustomers.append(option);
		                   */
		                  
		                  result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" data-value="' + this.milestone_description + '" /> ' + this.milestone_description + '</label>  </div>');
		              });
					    

				 }
				 });
        	  
        	  
        	
        	}
         
         
      //  $("#email_dst").val($("#email_orig").val())
       
         
         //$('input:radio[name=sex]:checked').val();
         
        /*  $('#result').on('change', 'input', function() {
        	  var elem = $(this);
        	  if (elem.is(':checked')) {
        	    $('#search').val(elem.val());
        	    
        	    alert($('#search').val(elem.val()));
        	  }
        	}); */
         
        	$("#btnnewmilestonesearch").click(function(event){
				
        		
        		
        		//alert('oioi');
        		 
        		 var job_number = $("#job_number").val();
        		
				  var table = $('#milestonedataTable');
				    table.find("tbody tr").remove();
				    
				   //var job_number = $(event.relatedTarget).data('target-id');
				  //  alert(job_number);
				    $.ajax({
						 type: "POST",
						 url: "Case_Management_Serv",
						 data: {
			                	request_type: 'select_load_details_for_batching',
			                	job_number:job_number},
						 cache: false,
						 beforeSend: function () {
							// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
						 },
						 success: function(jobdetails) {
							
							 var json_p = JSON.parse(jobdetails);
							 
							 //var json_p_details = JSON.parse(json_p.jobdetails);
				        	//console.log(json_p_details)
							// $('#edit #bl_job_number').val(json_p.jobdetails.job_number);
							// $('#edit #bl_jn_id').val(json_p.jobdetails.jn_id);
							 //$('#edit #bl_ar_name').val(json_p.jobdetails.ar_name);
							 
							//$('#edit #bl_business_process_sub_name').val(json_p.jobdetails.business_process_sub_name);

				              $(json_p.milestones).each(function () {
				               
				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');
				                  
				                  
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
             
             /*   $.get( "/controller/" + id, function( data ) {
                 $(".modal-body").html(data.html);
            });
              */
              $('#edit #job_numnber').val(job_number);
              
              
              });
         
         
         $("#addlrdtransaction").on("show.bs.modal", function(e) {
	            var gid = $(e.relatedTarget).data('target-id');
	         
	            
	       // console.log('gid'); 
	        //  console.log(gid);
	           
	            // showSuggestions(job_number);
	             
	             /*   $.get( "/controller/" + id, function( data ) {
	                 $(".modal-body").html(data.html);
	            });
	              */
	            //  $('#edit #job_numnber').val(job_number);
	              
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
	              
			    	 
			    
	             
	              
		    	 var today = new Date();
		    	 var dd = String(today.getDate()).padStart(2, '0');
		    	 var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		    	 var yyyy = today.getFullYear();

		    	 today = mm + '/' + dd + '/' + yyyy;
	              
	              if (gid){
	            console.log('addlrdtransaction loading ' + 'valid ')
	            console.log('addlrdtransaction loading ' + gid)
	            	  
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
	              
		    	 
	            
		    	// document.write(today);
		    	 
		    	 
		    	
	              
	              
	              });
         
         
         
         
         
 		$('#btn_save_lrd_transaction')
		.on(
				'click',
				function(e) {

					//console.log('Assiamah');

					var fid_id_fk = document
							.getElementById("lrd_td_fid_id_fk").value;
					
					
					var gid = document
					.getElementById("lrd_td_gid").value;

					var plotted_by_reg = document
							.getElementById("lrd_td_plotted_by_reg").value;
					
					var checked_by = document
							.getElementById("lrd_td_checked_by").value;
					
					var plott_date_reg = document
					.getElementById("lrd_td_plott_date_reg").value;
					
					
					
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
								reference_number : reference_number
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
					    
							 /*    $.ajax({
									 type: "POST",
									 url: "GenerateCaseReports",
									 target : '_blank',
									 data: {
										 request_type: 'request_to_generate_batch_list',
			           					  list_of_application: list_of_application_new,
			           					  batch_number: json_p.batch_number,
			           					  modified_by : localStorage.getItem('fullname'),
			           					  modified_by_id : localStorage.getItem('userid'),
						                  	},
									 cache: false,
									 beforeSend: function () {
										// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
									 },
									 success: function(jobdetails) {
										  //  console.log(jobdetails)
						
									      
									 }
									 });  */
			
				      
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
		        
			    // Hide the checked columns
			   //  table.column(0).visible(false);
			     //table.column(1).visible(false);
        	   // $('td:nth-child(0)').hide();
        	    
        	  //  $('td:nth-child(1)').hide();
        	 //   $('td:nth-child(4)').hide();
        	    
        	   // var dt = $('#batchlistdataTable').DataTable();
        	  //hide the first column
        	//  dt.column(0).visible(false);
        	  
        	  
        	  
        	   //table.DataTable.columns(0).visible(false);
        	  
        	  
        	  //  var $table = $('#batchlistdataTable');

   /*  table.('hideColumn', 'jn_id');
    table.('hideColumn', 'mss_id');
    table.('hideColumn', 'job_purpose');
     table.('hideColumn', 'send_by_id');
    table.('hideColumn', 'send_by_name');
    table.('hideColumn', 'userid');
                 */
        	  
        	  
              //   var table1 = $('#batchlistdataTable').DataTable();
               //  table.column(0).visible(true);    // To show
             //    table.column(1).visible(false);   // To hide
        	  
        	  
        	  
        	  
        	  
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
					
					 //console.log(jobdetails)
					
					 
					  var table = $('#job_detailsdataTable');
							    table.find("tbody tr").remove();
					 
					    var result = JSON.parse(jobdetails);
					    console.log('how come')
				        console.log(result)
				        
				        
				        
							
					    //var trHTML = '';
					   /*  $.each(result, function (i, item) {
				            
				            //trHTML += '<tr><td>' + result[i] + '</td><td>' + result[i] + '</td></tr>';
				           
				        });  */
				        
				        
					    table.append("<tr><td>" + result.job_number + "</td><td>" + result.ar_name + "</td><td>" + result.current_application_status + "</td>"
					    		
					    		
					    	//	+  '<td><p data-placement="top" data-toggle="tooltip" title="Milestone"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" ' + result.job_number + ' id="btnmilestoneslist"><span class="fas fa-check"></span></button></p> </td>'
					    		 
					    		  +  '<td><p data-placement="top" data-toggle="tooltip" title="Add To List"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="' + result.job_number + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
					    		   
					    		    + "</tr>");
				        
				      
				      
				        /* for(i =0;i<result.length;i++){
		                   table_body+='<tr>';
		                    table_body +='<td>';
		                    table_body +=result[i]["job_number"];
		                    table_body +='</td>';
		                   
		                    table_body +='<td>';
		                    table_body +=json_obj.cars[k].models[i];
		                    table_body +='</td>';
		                
		                    table_body+='</tr>'; 
		                    console.log(result[i])
		                    table.append("<tr><td>" + result[i]["job_number"] + "</td><td>" + result[i]["ar_name"] + "</td><td>" + result[i]["job_number"] + "</td></tr>");
		                    
		              } */

					 
					

					    
					 //   document.querySelector('#dataTable tbody').innerHTML = tbodyHtml;
					  
					    
					  /*   var reloadTable = function(jobdetails) {
					    	 
							 var table = $('#job_detailsdataTable');
							    table.find("tbody tr").remove();
							    jobdetails.forEach(function (jobdetail) {
							        table.append("<tr><td>" + jobdetail.job_number + "</td><td>" + jobdetails.ar_name + "</td><td>" + jobdetails.case_number + "</td></tr>");
							    });
					    };
					     */
					    

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
				
				 
				    console.log(jobdetails);
				    var json_p = JSON.parse(jobdetails);
				
				
				//  $('#txt_comp_max_value').val(formatMoney(json_p.min_value));
				//$('#txt_comp_min_value').val(formatMoney(json_p.min_max));
					 
				  $('#txt_comp_max_value').val(json_p.min_value);
					$('#txt_comp_min_value').val(json_p.min_max);
						 
					 
					
					  
					  
					  console.log(json_p.min_max);
					  
					
			  		  
			  		  
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
									
									console.log("adopted =" + adopted_value)
									
						console.log("asseessed =" + assessed_value)
									
									$('#adopted_value').val(formatMoney(adopted_value));
						  			
						  		  	$('#assessed_value').val(formatMoney(assessed_value));
						  		  	//$('#stamp_duty').val(assessed_value * (0.25/100));
						
						console.log("asseessed =" + assessed_value)
						
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
  		/* 	$('#new_comparable_locality').change(function(){
     	     //  alert($(this).val());
     	       
     	       var locality_new = $(this).val();
     	       
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
  					
  					 
  					    console.log(jobdetails);
  					    var json_p = JSON.parse(jobdetails);
  					
  					
  					  $('#txt_comp_max_value').val(json_p.min_value);
						 $('#txt_comp_min_value').val(json_p.min_max);
						 
					
						  var x = document.getElementById("assesedvalueRange").min = json_p.min_value;
						  var y = document.getElementById("assesedvalueRange").max = json_p.min_max;
						 
				
  			  
  				 }
  				 });
     	       
    		}) */
    		
    		
    		
  
 /////--------------------------------------------------------------------------------------------------------------------------
     	
     		$('#sub_service_on_case').change(function(){
     	    //alert($(this).val());
     			var select_id = document.getElementById("main_service_on_case");
     		var main_service=select_id.options[select_id.selectedIndex].value;
     		
     		
     		var sub_service = $(this).val();
     			
     			console.log(main_service);
     			

     			const main_service_name_id = main_service.split('-');
     			const sub_service_name_id = sub_service.split('-');
     			
     			
     			var main_service_id = main_service_name_id[0];
         		var main_service_name = main_service_name_id[1];
         				
     			var sub_service_id = sub_service_name_id[0];
     			var sub_service_name = sub_service_name_id[1];
     			
     			console.log(main_service_id);
     			console.log(sub_service_name_id);
     			console.log(sub_service_id);
     			console.log(sub_service_name);
     			
     			
     			
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
     			
     			
     		/* 	if(sub_service_name==='APPLICATION FOR WHOLE TRANFER'){
     				$("#on_application_client_name").val('');
     				document.getElementById("on_application_client_name").readOnly = false;
		   		}
		   		 */
		   		if(sub_service_name==='APPLICATION FOR MORTGAGES'){
		   			$("#on_application_client_name").val('');
		   			document.getElementById("on_application_client_name").readOnly = false;
		 		   
		   		}
		   		
		   		if(sub_service_name==='APPLICATION FOR OBJECTION'){
		   			$("#on_application_client_name").val('');
		   		  	document.getElementById("on_application_client_name").readOnly = false;
		 		   
		   		}
		   		
		   		
		   		
		   		
		   		/* if(sub_service_name==='APPLICATION FOR OBJECTION'){
		   			$("#on_application_client_name").val('');
		   		  	document.getElementById("on_application_client_name").readOnly = false;
		 		   
		   		} */
		   		
		   		
		   		

     			
     			
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
    				          
    					    //	console.log(select_id);
    					   //	console.log(this.business_process_id);
    				          
    				      //   if (main_service_id ==this.business_process_id){
    				        	  $('#new_bill_registration_forms_on_case').append('<option value="' + this.form_number + '-'+ this.form_name +'">' + this.form_name + '</option>');
    	        					 
    				      //  }
    				          
    				        
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
	   					
	   					 
	   					    console.log(jobdetails);
	   					    var json_p = JSON.parse(jobdetails);
	   					    var options = $("#new_type_of_revenue_item_on_case");

	   				       // var options = $("#selector");
	   				        options.empty();
	   				        options.append(new Option("-- Select --", 0));
	   				     
	   					    $(json_p).each(function () {
	   				          
	   					    //	console.log(select_id);
	   					   //	console.log(this.business_process_id);
	   				          
	   					  // revenue_items_name = (String) jsonObject.getString("revenue_items_name");
                         // revenue_items_amount = (String) jsonObject.getString("revenue_items_amount");
                         // String is_inspection_required = (String) jsonObject.getString("revenue_items_amount");
                          
	   					   
	   				       if (sub_service_id ==this.is_inspection_required){
	   				        	  $('#new_type_of_revenue_item_on_case').append('<option value="' + this.id + '_'+ this.revenue_items_name +'">' + this.revenue_items_name + '</option>');
	   	        					 
	   				     }
	   				          
	   				        
	   				           });
	   				//business_process_id	  
	   				 }
	   				 });
     			
     	})
         
         
     	//$("#btnsavenewparty").click(function(event){
     		
     		$("#btn_save_lrd_parcel_details_fts_with_info").click(function(event){
     		/* document
		.getElementById('btnsavelrdparcelmain')
		.addEventListener(
				'click',
				function() { */
					// wktplygonsearch
					// v
					// console.log(wktplygonsearch)

					// var wktplygonsearch =
					// $('#lc_bl_wkt_polygon').val();
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
									console.log(jobdetails)

									var json_p = JSON.parse(jobdetails);

									/*
									 * $( "#pvlmdparcelinformation") .modal();
									 */

									$(
											'#lrdparcelinformationfirsttimesavewithinfo #lrd_gid_fts')
											.val(json_p.gid);
									$(
											'#lrdparcelinformationfirsttimesavewithinfo #lrd_glpin')
											.val(json_p.reference_number);
								
									//$("#btn_save_lrd_parcel_details_fts_with_info")
									document.getElementById("btn_save_lrd_parcel_details_fts_with_info").disabled = true;
									alert('Parcel Successfully Saved')
								}
							});

				});
     		
     		
				$("#lrd_btn_search_for_mother_transction_to_child").click(function(event){
		     		
							    var mc_job_number =$('#lrd_search_for_mother_transction_to_child').val();
								var job_number = $("#cs_main_job_number").val();
					          	var case_number = $("#cs_main_case_number").val();
					          	var transaction_number = $("#cs_main_transaction_number").val();

							$
									.ajax({
										type : "POST",
										url : "Case_Management_Serv",
										// target : '_blank',
										data : {
											request_type : 'select_copy_mother_file_transaction_to_child',
											mc_job_number : mc_job_number,
											job_number : job_number,
											case_number : case_number,
											transaction_number : transaction_number
										},
										cache : false,

										success : function(jobdetails) {
											console.log(jobdetails);
											alert(jobdetails);

										}
									});

						});
     		
     		 $('#btn_process_after_payment_on_case').on('click', function(e) {
            
     		console.log('enter data');
     		
     		
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
    					
    					 console.log(jobdetails);
    					 
    					  var table_bp = $('#tbl_on_case_ap_bills_payments_dataTable');
    					  table_bp.find("tbody tr").remove();
    					    

      					  var table_cl = $('#tbl_on_case_ap_checklist_dataTable');
      					table_cl.find("tbody tr").remove();
      					    
    					
    					    console.log(jobdetails);

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
    					    
    					    /* 
    					    $(json_p.payments).each(function () {
    					    	table_bp.append("<tr><td>" + this.bill_number + "</td><td>" +this.customer_id + "</td><td>" +this.bill_amount + "</td><td>" +this.payment_amount + "</td><td>" +this.division + "</td>"
    							+ "</tr>");        
    				          }); */
    					    
    					    
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
    		    					
    		    					  var table = $('#tbl_on_case_ap_checklist_dataTable');
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
            	//$("#addeditparty").modal();
            	//  $('#addeditparty').modal('hide')
            });
     		 
     		 
     		 
     		
     		 
     		
     		
     		
   		 $('#btn_print_new_title_plan').on('click', function(e) {
            	//var job_number = $("#cs_main_job_number").val();
            	//var case_number = $("#cs_main_case_number").val();
         	//var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
            	
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_title_plan',
      	                	wkt_polygon:'LCGARGAPCN717192620190',
  		                 	job_number:'LCGARGAPCN717192620190',
  		                 	case_number:'LCGARGAPCN717192620190'
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
   		 
   		 
   		 $('#btn_convert_lrd_jacktet_to_pdf').on('click', function(e) {
      
         	
      		 $.ajax({
   				 type: "POST",
   				 url: "GeneratePDFLRDFiles",
   				 target:'_blank',
   				 data: {
   	                	request_type: 'convert_lrd_jacktet_to_pdf'
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
   				
   		
   					  
   				 }
   				 }); 
   		 });
   		 
 		 $('#btn_convert_geoserver_geotiff_files_to_vector_layer').on('click', function(e) {
 		      
          	
      		 $.ajax({
   				 type: "POST",
   				 url: "ProcessGeotiffToVectorLayer",
   				 target:'_blank',
   				 data: {
   	                	request_type: 'convert_lrd_jacktet_to_pdf'
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
 	     		                 	notes:notes
 	     		              
 	     		                 	
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
 		 

 		 $('#lc_btn_generate_memo_for_certificate').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
          	var transaction_number = $("#cs_main_transaction_number").val();
          	
        	//var notes = $("#my-summernote").val();
       	//var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
          //	console.log(notes)
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
    					 console.log(jobdetails);
    					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
    				
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
         	
      		 $.ajax({
   						                 	
		                 	 type: "POST",
	        				 url: "GenerateCaseReports",
	        				// target:'_blank',
	        				 data: {
	        	                	request_type: 'request_to_generate_concurrence_certificate',
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
     		 
   		
     	
     		 
     		 
     		 
     		$('#open_attached_document').on('click', function(e) {
    			 
       			
                //	var job_number = $("#cs_main_job_number").val();
              	//var case_number = $("#cs_main_case_number").val();
              	
           
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
       	  	

     		  $("#btn_upload_case_file").click(function (event) {
              	 //  $('form').submit(function(event) {
                     //stop submit the form, we will post it manually.
                      event.preventDefault();

                     // Get form
                   //var form = $('#fileUploadForm')[0];
                     
                    //var form = $('#fileUploadForm')[0].files[0];
                     var case_number = $("#file_upload_case_number").val();

                     
                     
                     
                     var sampleFile = document.getElementById("fileUploadForm").files[0];
                     
                     //var fileInput = document.getElementById('upload');   
                     var filename = document.getElementById("fileUploadForm").files[0].name;

                     
                     console.log(filename);
                     
                     var formdata = new FormData();

                     formdata.append("case_number", case_number);
                     formdata.append("file_name", filename);

                     formdata.append("sampleFile", sampleFile);
                     
             		// Create an FormData object
                     //var data = new FormData(form);
                    // console.log(data);
             		// If you want to add an extra field for the FormData
                    // data.append("case_number", case_number);
                     //console.log(data);
             		//// disabled the submit button
                    $("#btn_upload_case_file").prop("disabled", true);
                    console.log(formdata);
                     $.ajax({
                         type: "POST",
                         enctype: 'multipart/form-data',
                         url: "document_upload",
                         data: formdata,
                         processData: false,
                         contentType: false,
                         cache: false,
                         timeout: 600000,
                         success: function (data) {

                          //   $("#result").text(data);
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
                     
                     
                     
                     
     /*                 
                  // Get form
                     var form = $('#id_form')[0];
                     var data = new FormData(form);
                     $.ajax({
                         type: "POST",
                         enctype: 'multipart/form-data',
                         url: "document_upload",
                         data: data,
                         processData: false, //prevent jQuery from automatically transforming the data into a query string
                         contentType: false,
                         cache: false,
                         dataType:'json',
                         success: function (e) {
                             $("#result").text(data);
                             alert("Success");
                         },
                         error: function (e) {
                             $("#result").text(e.responseText);
                             alert("Error");
                         },
                         complete: function () {
                             // Handle the complete event
                             alert("Complete");
                           }
                     });
                      */
                     
                     
                     
                     
      /*                var sampleText = document.getElementById("file_upload_case_number").value;

                     var sampleFile = document.getElementById("sampleFile").files[0];

                     var formdata = new FormData();

                     formdata.append("case_number", sampleText);

                     formdata.append("sampleFile", sampleFile);

                     var xhr = new XMLHttpRequest();       

                     xhr.open("POST","document_upload", true);

                     xhr.send(formdata);

                     xhr.onload = function(e) {

                         if (this.status == 200) {

                            alert(this.responseText);

                         }

                     };    
                      */
                     
                     
                     //}

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
     					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
     				
     					var blob = new Blob([jobdetails], {type: "application/pdf"});
     			        var objectUrl = URL.createObjectURL(blob);
     			      window.open(objectUrl);
     					  
     				 }
     				 }); 
     		 });
   		 
   		 
   		
   		 $('#lc_btn_activate_final_register').on('click', function(e) {
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
   		 
   		 
   		 
   		 $('#lc_btn_activate_final_certificate').on('click', function(e) {
            	var job_number = $("#cs_main_job_number").val();
            	//var case_number = $("#cs_main_case_number").val();
              	var case_number = $("#cs_main_transaction_number").val();
            	
           
            	
            	var registration_district_number = $("#txt_lc_registration_district_number").val();
            	var registration_section_number = $("#txt_lc_registration_section_number").val();
            	
         		 $.ajax({
      				 type: "POST",
      				 url: "GenerateCaseReports",
      				// target:'_blank',
      				 data: {
      	                	request_type: 'request_to_generate_certificate',
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
  		 
     		
     		 $('#btn_generate_pvlmd_search_report').on('click', function(e) {
             	
     			 
     			 
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
      		             	transaction_number:transaction_number
      		              },
      					 cache: false,
      					 beforeSend: function () {
      						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      					 },
      					 success: function(jobdetails) {
      						
      						console.log(jobdetails);
      					/* 	var json_p = JSON.parse(jobdetails);
      						
      						// $('#case_file_number').val(jobdetails);
      						 $('#lc_txt_certificate_number').val(json_p.certificate_number);
      						 $('#lc_txt_volume_number').val(json_p.volume);
      						 $('#lc_txt_folio_number').val(json_p.folio);
      						  
      					             */
      					           
      						alert('Code !' + jobdetails);
      					          
      						
      					//	$("#final_registration_approval_dialog").modal();
      						$("#final_registration_approval_dialog").modal({backdrop: 'static', keyboard: false});
      			 			  
      			  
      					 }
      					 }); 
     			 
     		/* 	 
     			 var job_number = $("#cs_main_job_number").val();
             	var case_number = $("#cs_main_case_number").val();
             	
          		 $.ajax({
       				 type: "POST",
       				 url: "GenerateCaseReports",
       				// target:'_blank',
       				 data: {
       	                	request_type: 'request_to_generate_search_template',
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
       				 }); */ 
       		 });
     		 
     		 
     		 
     		 
     		 $('#btn_compose_certificate_template').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
              	var case_number = $("#cs_main_transaction_number").val();
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
              	
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
        					
        					 $('#lc_search_report_summary_details').summernote('code', '<ol><li>'+ jobdetails +'</li></ol>');
         					 
        					 
        					 //$("#lc_search_report_summary_details").val(jobdetails);
        					// $("#lc_search_report_summary_details").text(jobdetails)
        					// $("#lc_search_report_summary_details").html(jobdetails)
        					
        					//$('#lc_search_report_summary_details').html( '' ); 
        					 
        					console.log(jobdetails);
        					 alert('Report Composed Successfully')
        					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
        				/* 
        					var blob = new Blob([jobdetails], {type: "application/pdf"});
        			        var objectUrl = URL.createObjectURL(blob);
        			      window.open(objectUrl); */
        					  
        				 }
        				 }); 
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
     		 
     		 
     		 $('#btn_preview_search_report').on('click', function(e) {
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
       		 
      		 
     		 
     	/* 	 $('#btn_test_web_service').on('click', function(e) {
              	//var job_number = $("#cs_main_job_number").val();
              	//var case_number = $("#cs_main_case_number").val();
              	console.log('Ni');
              	
           		 $.ajax({
        				 type: "POST",
        				 url: "https://uat-cagdmdaapi.paqtechnologies.com",
        				// target:'_blank',
        				 data: {
        					 "agencyUniqueReference": "LC0001",
        					 "receiptDescription": "Stamp duty",
        					 "recipientName": "Kofi Ghana",
        					 "recipientEmail": "kofi.ghana@gmail.com",
        					 "recipientPhone": "02334567789",
        					 "amount": "100.50",
        					 "receiptType": "LC-GEN",
        					 "receivedBy": "Joe Bloggs"
        					},
        				 headers: {
        				        "APIKey":"K0rDNV5zn7UdQsYjMJpRziRBsc3R80KM7MT8Q/O2Ddg=",
        				        "My-Second-Header":"second value"
        				    },
        				 cache: false,
        			    beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					 console.log(jobdetails);
        					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
        				
        					//var blob = new Blob([jobdetails], {type: "application/pdf"});
        			       // var objectUrl = URL.createObjectURL(blob);
        			     //window.open(objectUrl);
        					  
        				 }
        				 }); 
        		 });
     		  */
     		 
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
     		 
     		  
     		  
     			/* $('#btn_generate_cagd_receipt').on('click', function(e) {
        			 
     				var request = new XMLHttpRequest();
     			    var params = '{"agencyUniqueReference": "LC0003","receiptDescription": "Stamp duty","recipientName": "Kofi Ghana","recipientEmail": "kofi.ghana@gmail.com","recipientPhone": "0242012137", "amount": "165.5","receiptType": "LC-GEN","receivedBy": "Joe Bloggs"}';
     			   //request.responseType = 'blob';
     			    request.onreadystatechange = function() {
     			        if (this.readyState == 4 && this.status == 200) {
     			           // console.log(this.responseText);
     			         
     			            
     			           var blob = new Blob([this.response], {type: "application/pdf"});
          			        var objectUrl = URL.createObjectURL(blob);
          			      window.open(objectUrl);
     			            
     			        }
     			    };

     			    request.open('POST', 'https://uat-cagdmdaapi.paqtechnologies.com/v1/receipts/createreceiptandfile', true);
     			   request.responseType = 'blob';
     			    request.setRequestHeader('X-Api-Key', 'K0rDNV5zn7UdQsYjMJpRziRBsc3R80KM7MT8Q/O2Ddg=');
     			    request.setRequestHeader("Content-type", "application/json");
     			   
     			    request.send(params);
     			    
                
           		 }); */
     		 
     		 
     		 
     		 $('#btn_save_to_generate_on_application').on('click', function(e) {
     			 
     			 
     			 
     			// var table = $('#on_case_checlist_table_billdataTable');
     			
  /*    		if ($.fn.DataTable.isDataTable('#on_case_checlist_table_billdataTable')) {
    		  $('#on_case_checlist_table_billdataTable').DataTable().destroy();
			}
					             	
     			 var table = $('#on_case_checlist_table_billdataTable').DataTable({
	    	    'paging': true
	    	});

	    	var row_count_in_a_table = table.page.info().recordsTotal;
	    	  console.log(length);
	    	  
	    	 var check = $('#on_case_checlist_table_billdataTable').find('input[type=checkbox]:checked').length;
	    	 if (check === row_count_in_a_table) {
	    	    // alert("All columns are checked successfully");
	    	  //  ze.preventDefault();
	    	  //return;
	    	 }
	    	 else{
	    		alert("Please make sure all check list are checked");                 
	    	    // ze.preventDefault();
	    		return;
	    	 }
	    	 
     			  */
     			 
     			 
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
         			
         			console.log(main_service_id);
         			console.log(main_service_name);
         			console.log(sub_service_id);
         			console.log(sub_service_name);
     			 
     			 

			   		main_service_id = main_service_id.replace('.0', '');
     			
			   		
			   		var new_land_size = '0';
			   		

             	var on_application_client_name = $("#on_application_client_name").val();
             	
             	var new_bill_application_ls_number = $("#new_bill_application_ls_number_oncase").val();
             	var new_bill_application_case_number = $("#new_bill_case_number_on_case").val();
             	new_bill_locality_on_case ='';
             	//size_of_land
             	
             	
             	//new_land_size = $("#new_bill_land_size").val();
             //	console.log(new_land_size);
             	new_land_size = $("#new_bill_land_size_on_case").val();
             	//console.log(new_land_size);
             	
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
            	console.log("office Region: " + office_region);
            	/* if(main_service_name==='APPLICATION FOR REGISTRATION'){
            		new_land_size =$("#size_of_land_case").val();
            		
		   		}
            	 */
             	
       /*       
             	var request = new XMLHttpRequest();
             	request.responseType = "blob";
                var params = {
 	                	request_type: 'process_online_select_bill_for_registration',
 	                	main_service_id:main_service_id,
 	                	main_service_sub_id:sub_service_id,
 	                	main_service_desc:main_service_name,
 	                	main_service_sub_desc:sub_service_name,
 	                	client_name:on_application_client_name,
 	                	land_size:'0',
 	                	registration_forms:'0-0',
 	                	publication_type:'-',
 	                	type_of_use:'0-0'};

                request.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                      console.log(request.response);
                       // var json =this.responseText;
                     //   insert_parceldata(request.responseText);
                     
                     
                   //   var file = window.URL.createObjectURL(this.response);
                    //  window.open(file);
                      
                     //var blob = new Blob([this.response], {type: "application/pdf"});
     			     // var objectUrl = URL.createObjectURL(request.response);
     			      //  window.open(objectUrl);
           
     			        
     			       // console.log('Loaded');
     			       
                      var bb = new window.WebKitBlobBuilder();
                      bb.append(this.response); // Note: not xhr.responseText

                      var blob = bb.getBlob('application/pdf');
                      var blobURL = window.webkitURL.createObjectURL(blob);

                      window.open(blobURL);
           
                    }
                };

                request.open('POST', 'Case_Management_Serv', true);
                //request.setRequestHeader('api-key', 'your-api-key');
                request.setRequestHeader("Content-type", "application/json");
                request.send(params); */
                
              //  var created_for ='0242012137';
		   		//var created_for_id='Assiamah John';
		   		//var application_required_additional_bill='Yes';
				//var case_number = 'Not Case';
		   		
		   	
             	
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
       					 //  const arrayBuffer = base64ToArrayBuffer(jobdetails);
       				     //  createAndDownloadBlobFile(arrayBuffer, 'testName');
       				     
       				     //var sampleArr = base64ToArrayBuffer(jobdetails);
  						//saveByteArray("Sample Report", sampleArr);
  						
  						
  						 // const blob1 = new Blob([jobdetails])
    						//	const url = window.URL.createObjectURL(blob1)
    						//this.setState({fileUrl: url, loading: false})
  					//	let pdfWindow = window.open("");
  					//		pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64," + jobdetails +"'></iframe>");
       					    
       				       					  
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
        				        	 if (this.business_process_on_case =='No'){
           				        	  $('#sub_service_cp').append('<option value="' + this.business_process_sub_id + '-'+ this.business_process_sub_name +'">' + this.business_process_sub_name + '</option>');
           	        					 
           				        }
        				        	 
        				        		 
        				        }
        				         
        				         
        				          
        				        
        				           });
        				//business_process_id	  
        				 }
        				 }); 
            		
            		/* $.each(data, function() {
            		   
            		});
            		 */
            		
            		//var sub_select_id = document.getElementById("sub_service_on_case");
            		//var sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
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
			   		
			   		//$("#addNewserviceBillModal").modal({backdrop: 'static', keyboard: false});
			   		
			   	
			   		
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
			   		
			   		/* if(main_service_name==='APPLICATION FOR STATE LAND'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		} */
			   		
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
	    					
	    						loadingOverlay().cancel(spinHandle);
	    					 
	    					  var table = $('#new_checlist_table_billdataTable');
	    					    table.find("tbody tr").remove();
	    					
	    					    console.log(jobdetails);
	    					    var json_p = JSON.parse(jobdetails);
	    					    
	    					    $(json_p).each(function () {
	    				               
	    				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');

	    				                  
	    								    table.append("<tr><td>" + this.business_process_checklist_name + "</td><td>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item"  id="checklistitem" value="1002" /></div>' + "</td>"
	    								    		
	    								    		
	    		           	               
	    								       
	    							                  
	    							                  
	    							              
	    		           	              			 
	    								    			 
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
        						loadingOverlay().cancel(spinHandle);
        					 
        					    console.log(jobdetails);
        					    var json_p = JSON.parse(jobdetails);
        					    var options = $("#new_bill_registration_forms");

        				       // var options = $("#selector");
        				        options.empty();
        				        options.append(new Option("-- Select --", 0));
        				     
        					    $(json_p).each(function () {
        				          
        					    //	console.log(select_id);
        					   //	console.log(this.business_process_id);
        				          
        				      //   if (main_service_id ==this.business_process_id){
        				        	  $('#new_bill_registration_forms').append('<option value="' + this.form_number + '-'+ this.form_name +'">' + this.form_name + '</option>');
        	        					 
        				      //  }
        				          
        				        
        				           });
        				//business_process_id	  
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
            		
            		/* $.each(data, function() {
            		   
            		});
            		 */
            		
            		//var sub_select_id = document.getElementById("sub_service_on_case");
            		//var sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
        	})
        	
     		
        
       
            
            
            
     	
     	
     
     	  /*   $('#NotoncaseafterPaymentModalonCase').modal({
     	    	  backdrop: 'static',
     	    	});
     		 */
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
     			 
      		//	var select_id = document.getElementById("txt_on_case_ap_list_of_lc_estates");
        		//var main_service=select_id.options[select_id.selectedIndex].value;
        		
        		//const estate_name_code = main_service.split('-');

     			//var estate_code = estate_name_code[0];
         	//	var estate_name = estate_name_code[1];
         		
      			 
      	  		
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
        					 //  const arrayBuffer = base64ToArrayBuffer(jobdetails);
        				     //  createAndDownloadBlobFile(arrayBuffer, 'testName');
        				     
        				     //var sampleArr = base64ToArrayBuffer(jobdetails);
     						//saveByteArray("Sample Report", sampleArr);
     						
     						
     						 // const blob1 = new Blob([jobdetails])
     						//	const url = window.URL.createObjectURL(blob1)
     						//this.setState({fileUrl: url, loading: false})
     					//	let pdfWindow = window.open("");
     					//		pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64," + jobdetails +"'></iframe>");
        					    
        					// $('#afterPaymentModalonCase').modal('hide');
        					  
        				 }
        				 });  
        			 
        			 
        			 
        		 });
      		 
      		 
      	  	
      		 $('#lc_btn_preview_consent_certificate_old').on('click', function(e) {
     			 
      		     
      	  		
              	var job_number = $("#cs_main_job_number").val();
            	var case_number = $("#cs_main_case_number").val();
            	var transaction_number = $("#cs_main_transaction_number").val();
            	
            	
              	
              	var size_of_land = $("#txt_lc_size_of_land").val();
              	
				//var rent_passing_per_app = 0.1 *  (rent_passing_per_acres * size_of_land);
               
       
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
     		 
     		 
 			//	$("#txt_lc_rent_passing_per_acre").val((txt_lc_land_value_annual_equivalent * txt_lc_size_of_land)/txt_lc_interest_rate);
 				
 				$("#txt_lc_rent_passing_per_acre").val(txt_lc_land_value_annual_equivalent * txt_lc_size_of_land);
     			
     		  
     		   
     		   /*  $.ajax({
      				 type: "POST",
      				 url: "Case_Management_Serv",
      				 data: {
      	                	request_type: 'get_list_of_ls_estates',
      	                	},
      				 cache: false,
      				 beforeSend: function () {
      					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      				 },
      				 success: function(jobdetails) {
      					
      					 
      					    console.log(jobdetails);
      					    var json_p = JSON.parse(jobdetails);
      					    var options = $("#txt_on_case_ap_list_of_lc_estates");

      				       // var options = $("#selector");
      				        options.empty();
      				        options.append(new Option("-- Select --", 0));
      				     
      					    $(json_p.data).each(function () {
      				          
      					    //	console.log(select_id);
      					   //	console.log(this.business_process_id);
      				          
      				       //  if (main_service_id ==this.business_process_id){
      				        	  $('#txt_on_case_ap_list_of_lc_estates').append('<option value="' + this.gt_estate_code + '-'+ this.gt_location_name +'">' + this.gt_location_name + '</option>');
      	        					 
      				       //}
      				          
      				        
      				           });
      				//business_process_id	  
      				 }
      				 }); */
     			 
     			 
     			
     			 
     		   
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
        					     
        					     
        						 	//select_address_register_by_id_number
        	    	       		/*  $.ajax({
        	    	    				 type: "POST",
        	    	    				 url: "Case_Management_Serv",
        	    	    				 data: {
        	    	    	                	request_type: 'select_address_register_by_id_number',
        	    	    	                	id_number:job_number,
        	    	    	             },
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
        	    	    				 });  */
        					  
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
         
     		 
/* <!--===============================================NEW UPDATE JUDE ========================================================================  --> */
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

    			    //populate the textbox
    			    $(e.currentTarget).find('#party_id_gen').val(party_id);
    			    
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
           		
           		//set the grantor family and stool anmes
           		$('#fe_family_name').val($('#family_name_gen').val());
           		$('#fe_grantor_family').val( $('#grantor_family_gen').val());
           		 
           		var created_by = localStorage.getItem('fullname'); 
           		var created_by_id = localStorage.getItem('userid'); 


           		var case_number = $("#fe_case_number").val();
                  
           		
           		if(ar_client_id ==""){
           			var request_type = 'select_address_register_add_new_general';
           		}else {var request_type = 'select_address_register_edit_general'}
           		console.log("name is " + ar_name)
          			 
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
          				               
          				               //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');
										
										
          				                  
          								    table.append("<tr><td>" + this.ar_name + "</td><td>" + this.ar_gender + "</td><td>" + this.ar_cell_phone  + "</td><td>" + this.type_of_party + "</td>"
          								    		
          								    		
 			          								    		
 			          								    		
          								    		
          								    			 
          								   +  '<td><p data-placement="top" data-toggle="tooltip"  title="Edit Party"> ' 
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
    								    	  +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
    								    	   
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
			  var  x_coordinate_name =  $('#bl_coordiante_name').val();
			  var  x_coordinate_mak =  $('#bl_X_coordinate').val();
			 var  y_coordinate_mak =  $('#bl_y_coordinate').val();
  		
			  var table = $('#coordinatelis_Table');
			    //table.find("tbody tr").remove();
			    
			    
			    //console.log(x_coordinate_name);
			   // console.log(x_coordinate_mak);
			  //  console.log(y_coordinate_mak);
	 
	   
      
	    table.append("<tr><td>" + x_coordinate_name + "</td><td>" + x_coordinate_mak + "</td><td>" + y_coordinate_mak + "</td>"
	    		
	    		
	    	//	+  '<td><p data-placement="top" data-toggle="tooltip" title="Milestone"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" ' + result.job_number + ' id="btnmilestoneslist"><span class="fas fa-check"></span></button></p> </td>'
	    		 
	    		  +  '<td><p data-placement="top" data-toggle="tooltip" title="Remove"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="' + x_coordinate_name + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span></button></p></td>'
	    		   
	    		    + "</tr>");
	    
	    $('#addcoordinatetoplot').modal('hide');
	 
	    
        });
         
         

         
         
     	
         
        
        // Find and remove selected table rows
       /*  $(".delete-row").click(function(){
            $("table tbody").find('input[name="record"]').each(function(){
                if($(this).is(":checked")){
                    $(this).parents("tr").remove();
                }
            });
        }); */
        
        
        //Adding Parties to a Case
        
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
        	console.log(case_number);
   		 $.ajax({
				 type: "POST",
				 url: "LoadLRDJackets",
				 data: {
	                	request_type: 'load_case_scanned_document',
	                	case_number:case_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(serviceresponse) {
					
					 var json_p = JSON.parse(serviceresponse);
						console.log(json_p)
											
						
						 $(json_p).each(function () {
						        
							 table_docs.append("<tr><td>" + this.document_name + "</td><td>" +this.document_extention + "</td>"
									 +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.document_name + '</a></td>'

							    		    + "</tr>");

							 table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.document_name + '</a></td><td>' +this.document_extention + '</td>' 

					    		    + "</tr>");

						 });
					  
				 }
				 }); 
        //	
        });
        
   
   
   
   $('#btn_load_scanned_documents_public').on('click', function(e) { 
	   
	
		 var table_docs_mains = $('#lc_public_documents_dataTable');
		 table_docs_mains.find("tbody tr").remove(); 
 
  	var case_number = $("#cs_main_case_number").val();
  	console.log(case_number);
		 $.ajax({
			 type: "POST",
			 url: "LoadLRDJackets",
			 data: {
              	request_type: 'load_case_scanned_document_public',
              	case_number:case_number},
			 cache: false,
			 beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			 },
			 success: function(serviceresponse) {
				
				 var json_p = JSON.parse(serviceresponse);
					console.log(json_p)
										
					
					 $(json_p).each(function () {
					  table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.document_name + '</a></td><td>' +this.document_extention + '</td>' 
					    + "</tr>");
			         
		    
					 });
				  
			 }
			 }); 
  //	
  });
   
   
   $('#lc_public_documents_dataTable').on('click', '.link-post', function(e){
		//  console.log(e)
		  e.preventDefault();

		   // Get row data
		   
	var file_to_open = event.target.href;

	  var file_path = file_to_open.replace("file:///", "");
	  
	  var fileName, fileExtension;
	  fileName = file_path;
	  fileExtension = fileName.replace(/^.*\./, '');
	  
		  
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
  
   
   
   
  var lc_main_scanned_documents_dataTable = $('#lc_main_scanned_documents_dataTable').DataTable();
  var lc_scanned_documents_dataTable = $('#lc_scanned_documents_dataTable').DataTable();

  
  
  
  
  $('#lc_main_scanned_documents_dataTable').on('click', '.link-post', function(e){
	//  console.log(e)
	  e.preventDefault();

	   // Get row data
	   
	// console.log(e.currentTarget.href);
	 // console.log(e.target);
//  console.log(event.target.href);
	  
	  var file_to_open = event.target.href;
	 //C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
	 
	 
	 //var str = "Visit Microsoft!";
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
							
							$(
							'#fedocumentPreviewblobfile')
							.attr('src',
									objectUrl);

				//	$('#NotoncaseafterPaymentModalonCase').modal('hide');
					  
				 }
				 });  
	  
	});
   
  $('#lc_scanned_documents_dataTable').on('click', '.link-post', function(e){
		//  console.log(e)
		  e.preventDefault();

		   // Get row data
		   
		// console.log(e.currentTarget.href);
		 // console.log(e.target);
	//  console.log(event.target.href);
		  
		  var file_to_open = event.target.href;
		 //C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
		 
		 
		 //var str = "Visit Microsoft!";
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
				        
				        //window.open(objectUrl);
				      

					//	$('#NotoncaseafterPaymentModalonCase').modal('hide');
						  
					 }
					 });  
		  
		});
	   
  $('#lrd_scanned_documents_dataTable').on('click', '.link-post', function(e){
		//  console.log(e)
		  e.preventDefault();

		   // Get row data
		   
		// console.log(e.currentTarget.href);
		 // console.log(e.target);
	//  console.log(event.target.href);
		  
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
					//	$('#NotoncaseafterPaymentModalonCase').modal('hide');
						  
					 }
					 });  
		  
		});
   
   
   $('#btn_generate_case_file_number').on('click', function(e) { 
   	
   	//var id_number = $("#case_file_number").val();
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
			 beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			 },
			 success: function(jobdetails) {
				
				console.log(jobdetails);
				 //var json_p = JSON.parse(jobdetails);
				
				 $('#case_file_number').val(jobdetails);
				 
				 
				   // $('#form_inspection').modal('hide');
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val('File Number has been generated Successfully');

	  
			 }
			 }); 
   //	
   });
   
   $('#lc_btn_save_search_report').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details").val();
	  	
	  	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary',
	               	search_report:search_report,
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
				
					//$('#addcoordinatetoplot').modal('hide');
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
					
				 }
				 }); 
	   //	
	   });
   
   $('#lc_btn_save_search_report_final').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details_final").val();
	  	
	  	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary',
	               	search_report:search_report,
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
				
					//$('#addcoordinatetoplot').modal('hide');
					$("#general_message_dialog").modal();
					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
					
				 }
				 }); 
	   //	
	   });
  
  
   
   
   $('#btn_lc_save_parcel_for_search').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var wkt_polygon = $("#lc_bl_wkt_polygon").val();
	  	
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
					
					console.log(jobdetails);
					 //var json_p = JSON.parse(jobdetails);
					
					// $('#case_file_number').val(jobdetails);
					//alert(jobdetails);
					
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
 						
 						
 						//$('#addNewserviceBillModal #bl_y_coordinate').val([]);
 						// $('#lc_txt_folio_number').val(json_p.folio);
 						  
 					            // $('#form_inspection').modal('hide');
	 					//$("#general_message_dialog").modal();
	 					//$('#general_message_dialog #general_message_dialog_msg_new').val(licensed_surveyor_status);

 					           
 						//alert(jobdetails);
 			  
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
 						
 						 
 						//$('#addNewserviceBillModal #bl_y_coordinate').val([]);
 						// $('#lc_txt_folio_number').val(json_p.folio);
 						  
 					            // $('#form_inspection').modal('hide');
	 					//$("#general_message_dialog").modal();
	 					//$('#general_message_dialog #general_message_dialog_msg_new').val(licensed_surveyor_status);

 					           
 						//alert(jobdetails);
 			  
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
 						
 						 
 						//$('#addNewserviceBillModal #bl_y_coordinate').val([]);
 						// $('#lc_txt_folio_number').val(json_p.folio);
 						  
 					            // $('#form_inspection').modal('hide');
	 					//$("#general_message_dialog").modal();
	 					//$('#general_message_dialog #general_message_dialog_msg_new').val(licensed_surveyor_status);

 					           
 						//alert(jobdetails);
 			  
 					 }
 					 }); 
 		   //	
 		   });
 		
 		$('#lc_btn_generate_certificate_volume_folio').on('click', function(e) { 
		var case_number = $("#cs_main_case_number").val();
		var transaction_number = $("#cs_main_transaction_number").val();
		
		
	   
		var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
		var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
	  	 var send_by_id = localStorage.getItem('userid');
         var send_by_name = localStorage.getItem('fullname');
         
         
	  	
	   //	console.log(id_number);
			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'select_create_volume_folio_number',
	             	case_number:transaction_number,
	               	registration_district_number:txt_lc_registration_district_number,
	               	registration_section_number:txt_lc_registration_section_number,
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
	 					$('#general_message_dialog #general_message_dialog_msg_new').val('Certifificate, Folio and Volume Numbers has been generated sucsessfully');

					//alert(jobdetails);
		  
				 }
				 }); 
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
 		               	msg:message_to_send,
 		               recipient:recipient,
 		              verification_code:verification_code
 		              },
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
 						console.log(jobdetails);
 					/* 	var json_p = JSON.parse(jobdetails);
 						
 						// $('#case_file_number').val(jobdetails);
 						 $('#lc_txt_certificate_number').val(json_p.certificate_number);
 						 $('#lc_txt_volume_number').val(json_p.volume);
 						 $('#lc_txt_folio_number').val(json_p.folio);
 						  
 					             */
 					           
 						//alert('Messege Sent!');
 					          
 						
 					//	$("#final_registration_approval_dialog").modal();
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
 		             	transaction_number:transaction_number
 		              },
 					 cache: false,
 					 beforeSend: function () {
 						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 					 },
 					 success: function(jobdetails) {
 						
 						console.log(jobdetails);
 					/* 	var json_p = JSON.parse(jobdetails);
 						
 						// $('#case_file_number').val(jobdetails);
 						 $('#lc_txt_certificate_number').val(json_p.certificate_number);
 						 $('#lc_txt_volume_number').val(json_p.volume);
 						 $('#lc_txt_folio_number').val(json_p.folio);
 						  
 					             */
 					           
 						alert('Code !' + jobdetails);
 					          
 						
 					//	$("#final_registration_approval_dialog").modal();
 						$("#final_registration_approval_dialog").modal({backdrop: 'static', keyboard: false});
 			 			  
 			  
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

 	//console.log(makeid(5));
 	
 	
 	
 	
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
					 
					    
					   /*  $('#request_type').val('request_to_generate_batch_list');
					    $('#list_of_application').val(list_of_application_new);
					    $('#batch_number').val(json_p.batch_number);
					   
					    $('#modified_by').val(  $( "#user_to_send_to" ).val());
					    //var userid_1 = $( "#user_to_send_to" ).val(); 
					    
					  //  $('#modified_by').val(localStorage.getItem('fullname'));
					    $('#modified_by_id').val( localStorage.getItem('userid'));
					     $('#downloadForm').submit(); */
					    
							  
							 
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
			       					//  const arrayBuffer = base64ToArrayBuffer(jobdetails);
			       				    //  createAndDownloadBlobFile(arrayBuffer, 'testName');
			       				     
			       				    //var sampleArr = base64ToArrayBuffer(jobdetails);
			  						//saveByteArray("Sample Report", sampleArr);
			  						
			  						
			  						// const blob1 = new Blob([jobdetails])
			    					//	const url = window.URL.createObjectURL(blob1)
			    					//this.setState({fileUrl: url, loading: false})
				  					//	let pdfWindow = window.open("");
				  					//		pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64," + jobdetails +"'></iframe>");
			       					    
			       					$('#NotoncaseafterPaymentModalonCase').modal('hide');
			       					  
			       				 }
			       				 });  
			
				      
				 }
				 }); 
      		
           }); 
 	
 			//============================================= Add to Batchlist =============================================== 
 		
		 
 	    $('#askForPurposeOfBatching').on('show.bs.modal', function(e) {
 	    	
			       			
    			$('#bl_job_number_new').val($(e.relatedTarget).data('job_number'));
    			$('#bl_ar_name_new').val($(e.relatedTarget).data('ar_name'));
    			$('#bl_business_process_sub_name_new').val($(e.relatedTarget).data('business_process_sub_name'));
    		
    			
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
           		if(job_purpose){
	           		addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose);
	                prepareBatchlistModal();
           		}else{
           			$.notify({
	                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Purpose of Bacthing Required </span>',
	                }, {
	                    type: 'danger'
	                });
           		}
      		
           }); 
 	     
 	     
 	    $('#btnAddAlltoBatchlist').on('click', function(e) {
          var job_purpose =$("#txt_general_job_purpose").val();
          		if(job_purpose){
		            var confirmText = "Are you sure you want to add these application to the list?";
				    if(confirm(confirmText)) {
			            $("#job_casemgtdetailsdataTable input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked").each(function () {
			                var row = $(this).closest("tr")[0];
			                var job_number = row.cells[1].innerHTML;
				           	var ar_name =  row.cells[2].innerHTML;
				       		var business_process_sub_name =row.cells[3].innerHTML;
				    	 	  addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose);
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
 	     
 	     
 	    
 		
 		
 	    
		
		
 	   
 	   
		
//=============================================END Add to Batchlist ===============================================  	

//============================================= View Batchlist ===============================================  	
 	  	
 	/*   $('#btnViewBatchlist').on('click', function(e) {
        
  		console.log('View batchlist');
  		
  		prepareBatchlistModal();
    		
         });
	
	
      
    });    
 	    */
 	 
		
		
//=============================================END Add to Batchlist ===============================================  	

//============================================= View Batchlist ===============================================  	
 	  	
 	  $('#btnViewBatchlist').on('click', function(e) {
        
  		//console.log('View batchlist');
  		
  		prepareBatchlistModal();
    		
     });
 	    
 	   $('#btnViewCompetedQueriedList').on('click', function(e) {
 	        
 	  		//console.log('View batchlist');
 	  		
 	  		prepareCompletedQueriedModal();
 	    		
 	     });
 	   
 	  $('#btn_print_completed_queried_list').on('click', function(e) {
	        
	  		//console.log('View batchlist');
	  		
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
</script>


<script type="text/javascript">
        $(document).ready(function(){

        	
        	var date=new Date('2018-01-30T12:00:00Z');    
        	//$('#lc_txt_publicity_date').attr("data-date", '${publicity_date}');
        	//$('#lc_txt_publicity_date').datepicker("update");

            $("#smartwizardfirstregistration").on("leaveStep", function(e, anchorObject, stepNumber, stepDirection) {
            	   //return confirm("Do you want to leave the step "+stepNumber+"?");
            	
           });

            
        	
            // Step show event
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
            var btnFinish = $('<button></button>').text('Finish Step').addClass('btn btn-info').on('click', function(){   
          
            	 $('#smartwizardfirstregistration').smartWizard('showMessage','Finish Clicked');
            	
            	if(localStorage.getItem('user_level') < 2){
            		
            		//$("#stepconfirmationDialognoRight").modal();
            		$("#stepconfirmationDialognoRight").modal({backdrop: 'static', keyboard: false});
       			  
            	}else{
            		//$("#stepconfirmationDialog").modal();
            		$("#stepconfirmationDialog").modal({backdrop: 'static', keyboard: false});
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
                                             
                                             


            // Smart Wizard
            
            //arrows
            //circles
            //dots
            //default
 
            var new_external_tool_bar =  [];
            
        
            
            
          	if(localStorage.getItem('user_level') < 2){
          	    new_external_tool_bar = [btnQuery];
        	}else{
        	    new_external_tool_bar = [btnFinish,btnQuery, btnCancel];
            }
          	
          	// console.log('application_stage');
        	// console.log('${application_stage}');
            
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

        
           
          
            
            
        });
    </script>

<script type="text/javascript">
    //=================================================================================================================
    //=================================================================================================================
    
    	
   
    
    
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
   					 	//var result = JSON.parse(jobdetails);
   				       /*  var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'  ;
   				        	alert_mess = alert_mess + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'  ;
   				        	alert_mess = alert_mess + '<strong>Success!</strong> Assessment Values saved successfully</div>'; */
   				        //if(jobdetails=='Success'){
   				        	//$( "#alert-display-space2" ).append( 'ood' );
   				     	// $('#form_inspection').modal('hide');
      	 					$("#general_message_dialog").modal();
      	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
      	 					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);


   				        //}     
   				 }
   				
   		});});
    	 
    	 
    	 
    	  $("#btn_submit_embossment").click(function(event){
				 
    		   //m e.preventDefault();
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
       					 	//var result = JSON.parse(jobdetails);
       				       /*  var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'  ;
       				        	alert_mess = alert_mess + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'  ;
       				        	alert_mess = alert_mess + '<strong>Success!</strong> Assessment Values saved successfully</div>'; */
       				        //if(jobdetails=='Success'){
       				        	//$( "#alert-display-space2" ).append( 'ood' );
       				     	// $('#form_inspection').modal('hide');
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
   	  	var modified_by =localStorage.getItem("fullname");
  	    var modified_by_id =localStorage.getItem("userid");
   	      
  	   /* console.log("case_number "+ case_number);
  	  console.log("job_number "+ job_number);
  	 	console.log("assessed_value "+ assessed_value);
  	console.log("stamp_duty "+ stamp_duty);
  	console.log("assessed_comment "+ assessed_comment);
  	console.log("modified_by "+ modified_by); */
	   
  	    
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
		    	    	modified_by :modified_by,
		    	    	modified_by_id : modified_by_id
				 	   },
				 cache: false,
				 beforeSend: function () {
					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					console.log(jobdetails)
					 	
						// $('#form_inspection').modal('hide');
			      	 					//$("#general_message_dialog").modal();
			      	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
			      	 					//$('#general_message_dialog #general_message_dialog_msg_new').val('Stamp Duty has been saved Successfully');
		
			      	 					
			      	 					var ar_name = $("#cs_main_ar_name").val();
			      	 	 	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
			      	 	 	    		var job_purpose = "Assessement Done";
			      	 	              	
			      	 	              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
			      	 	              	
			      	 	              	addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
					
					
					//var result = JSON.parse(jobdetails);
				       /*  var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
				        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
				        					'<strong>Success!</strong> Assessment Values saved successfully</div>';
				        if(jobdetails=='Success'){
				        	$( "#alert-display-space1" ).append( alert_mess );
				        	
				        } */     
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
 	    
 	    
 	    console.log('form submited Clicked New');
 		
 	    
			 
			 
			 
			  
			 
		var registry_mapref = $("#fe_registry_mapref").val();

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
 		
 		console.log('form submited Clicked New: ' + registry_mapref);
 		
 		
 		 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type			: 'further_entries_update_case',
	                surveyor_number : surveyor_number,
	       			regional_number :  regional_number,
	       			land_size :  land_size,
	       			district : district,
	       			 region : region,
	       			 locality :  locality,
						registry_mapref:registry_mapref,

	                	case_number   			: transaction_number,
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
				        
				        if(result.data=='Success'){
				        	var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Success!</strong> Case details saved successfully</div>';


				        	console.log(jobdetails)
				       
				        	$( "#alert-display-space" ).append( alert_mess );
				        	//Do Add to Batclist
				        	//console.log('Add to batchlist');
				    		
				    		
				           	var job_number = $("#fe_job_number").val();
				           	//var send_by_id = $("#modified_by_id").val();
				           	//var send_by =$("#modified_by").val();
				           	var ar_name = $("#fe_client_name").val();
				           	var business_process_sub_name = $("#fe_business_process_sub_name").val();
				           	
				           	addJobToBatchlist(job_number,ar_name,business_process_sub_name);
				             
				            prepareBatchlistModal();
				        	
				        } else{
				        	var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">' + 
     					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					'<strong>Failure!</strong> Something went wrong, Please try again</div>';
     					   
				        }
				 }
				
		}); });
		
		
		
		
		
 	  
    	  
 	  
 	 /*========================================     	 Actions for User Management ==================  */    
 	//  $('#tbl_user_profile_list_dataTable').DataTable();
 	 
 	 $('btn_view_comparable_on_map').click(function() {
	console.log('yes');
	var data = $(this).attr('property_owner');
	alert(data.option1)
});

 	 
/*========================================     	 Actions for Objection ==================  */    	  
 
			 
			 
				
			 
			 
			 
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
    		  var button = $(event.relatedTarget) // Button that triggered the modal
    		  var qid = button.data('id') // Extract info from data-* attributes
    		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    		  var modal = $(this)
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
	        	 	
    			
    			
    		  	
    		  	} 
    		  
    		  
    		});
    			
    		
    	
    	  $('#form_add_query').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    //console.log('form submited Clicked');
        	    //var action_on_form = $("#action_on_form_query").val();
        		var qid = parseInt($("#qid").val());
        		var case_number = $("#query_case_number").val();
        		var job_number = $("#query_job_number").val();
        	    var query_reasons = $("#query_reasons").val();
        	 	var query_remarks = $("#query_remarks").val();
        	 	var query_status = $("#query_status").val();
        	 	
        	 	
        	/*  	var modified_by =$("#modified_by").val();
       	    	var modified_by_id =$("#modified_by_id").val(); */ 
       	    	
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
    		    	    	/* modified_by           : modified_by,
    		    	    	modified_by_id        : modified_by_id */
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
    					
    					
    			//$('#btn_preview_final_search_report').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
              	var transaction_number = $("#cs_main_transaction_number").val();
              	var case_number = $("#cs_main_case_number").val();
              	
              	var ar_name = $("#cs_main_ar_name").val();
 	    		var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
 	    		var job_purpose = "Application Queried";
              	
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
              	
              	addJobToCompletedQueriedList(job_number,ar_name,business_process_sub_name,job_purpose);
              	
           		 $.ajax({
        				 type: "POST",
        				 url: "GenerateCaseReports",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'request_to_generate_query_letter',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
  		                 	transaction_number:transaction_number,
  		                 	business_process_sub_name:business_process_sub_name
        				 },
        				 cache: false,
        				xhrFields:{
        	                responseType: 'blob'
        	            },
        				 //beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				// },
        				 success: function(jobdetails) {
        					 console.log(jobdetails);
        					// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
        				
        					var blob = new Blob([jobdetails], {type: "application/pdf"});
        			        var objectUrl = URL.createObjectURL(blob);
        			      window.open(objectUrl);
        					  
        				 }
        				 }); 
        		// });
    					
    					
    					
    					$('#newQueryModal').modal('hide');
   	 					//$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Query Details");
    					
   	 				
    				 }
    				
    		});});
    	  
//============================================= End Actions for Query ===============================================
			$('#addMinutesModal').on('show.bs.modal', function (event) {
				//e.preventDefault();
				var am_id = $(event.relatedTarget).data('target-id') // Extract
				if(am_id > 0){
					$("#am_id").val(am_id);
					console.log("test am" + am_id);
					$("#am_description").val($(event.relatedTarget).data('am_description'));
	        	 	$("#am_from_officer").val($(event.relatedTarget).data('am_from_officer'));
	        	 	$("#am_to_officer").val($(event.relatedTarget).data('am_to_officer'));		
	        	 	//console.log("test am" + am_id);
	        	 	
	        	 	//check if user created the minute then allow edit
	        	 	if($(event.relatedTarget).data('am_from_officer') !== "${fullname}"){
	        	 		$("#btn_add_minutes").hide();
	        	 	}
				}else{
					$("#btn_add_minutes").show();
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
        	 
        	/* 	var modified_by =$("#modified_by").val();
       	    	var modified_by_id =$("#modified_by_id").val(); */
       	    	
        	 	console.log(am_case_number);
        	 	console.log(am_job_number);
        	 	console.log(am_description);
        	 	console.log(am_from_officer);
        	 	console.log(am_to_officer);
       		 
        	 /* 	console.log(modified_by);
        	 	console.log(modified_by_id); */
        	
       	    	
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
    	  
	 	 $('#btnCompleteJob').on('click', function(e){
     	    // validation code here
     	    //e.preventDefault();
     	    //console.log('form submited Clicked');
     	    
     	    
     	    
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
         	    		var job_purpose = "Work Completed";
         	       	 
         	     	    
         	     		 $.ajax({
         	 				 type: "POST",
         	 				 url: "Case_Management_Serv",
         	 				 data: {
         	 	                	request_type: 'select_update_application_as_work_done',
         	 	                	job_number: job_number 
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
    	  
//============================================= End Actions for Query ===============================================
	
	//============================================= End Actions for Note and Reports ===============================================
			$('#addNotesModal').on('show.bs.modal', function (event) {
				//e.preventDefault();
				var an_id = $(event.relatedTarget).data('target-id') // Extract
				if(an_id > 0){
					$("#an_id").val(am_id);
					console.log("test am" + am_id);
					$("#an_description").val($(event.relatedTarget).data('an_description'));
					$("#an_created_by").val($(event.relatedTarget).data('created_by'));
					$("#an_created_date").val($(event.relatedTarget).data('created_date'));
					$("#an_modified_by").val($(event.relatedTarget).data('modified_by'));
					$("#an_modified_date").val($(event.relatedTarget).data('modified_date'));
	        	 	
	        	 	if($(event.relatedTarget).data('created_by') !== "${fullname}"){
	        	 		$("#btn_add_notes").hide();
	        	 	}
	        	 	
	        	 	//hide others
	        	 	$(".list-to-hide").show();
	        	 	
	        	 	
	        	 	
				}else{
					$("#btn_add_notes").show();
					$(".list-to-hide").hide();
				}
				
        	 
			});
			
			
			  
	
	 	  $('#form_add_notes').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    //console.log('form submited Clicked');
        	    var an_id = $("#an_id").val();
        		var an_case_number = $("#an_case_number").val();
        		var an_job_number = $("#an_job_number").val();
        	    var an_description = $("#an_description").val();
        	    var an_type = $("#an_type").val();
        	 	
        	 
        	
        	 	/* console.log(an_case_number);
        	 	console.log(an_job_number);
        	 	console.log(an_description); */
        	 	
       		 
       	    	
        	   
       	    	
       	     //console.log('form submited Clicked');
        		 $.ajax({
    				 type: "POST",
    				 url: "lc_application_minutes_serv",
    				
    				 data: {
    	                	request_type:"select_lc_application_notes_add_and_update",
    	                	an_id:an_id,
    	                	 an_case_number:an_case_number,
    	                	an_job_number:an_job_number,
    	                	an_description:an_description,
    	                	an_type:an_type,
    	                	
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					//console.log(jobdetails)
    					
    				   $('#addNotesModal').modal('hide');
   	 				   $("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 				 $('#general_message_dialog #general_message_dialog_msg_new').val('Success!! Note has been added Successfully. Refresh page to see it in the list');
    					
    				
   	 					
    				 }
    				
    				});
        		 return false;
        		 });
    	  
    	  
    	  
//============================================= End Actions for Note ===============================================
	
	
	
/*===========================================   Actions for newCertificateModal ==================  */    	  
    	$('#newCertificateModal').on('show.bs.modal', function (event) {
    		 /*  var button = $(event.relatedTarget) // Button that triggered the modal
    		  var recipient = button.data('action') // Extract info from data-* attributes
    		   var modal = $(this)
    		  if(recipient=='edit'){
    			modal.find('.modal-body #action_on_form_certificate').val(recipient)
    			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
    			
    		  	
    		  	}  */
    		  	
    	  	var cs_id = $(event.relatedTarget).data('cs_id');
			var cs_case_number = $(event.relatedTarget).data('cs_case_number');
			var cs_official_notes = $(event.relatedTarget).data('cs_official_notes');
			var cs_date_of_registration = $(event.relatedTarget).data('cs_date_of_registration');
			var cs_to_whom_issued = $(event.relatedTarget).data('cs_to_whom_issued');
			var cs_serial_number = $(event.relatedTarget).data('cs_serial_number');
	
	
			$("#cs_id").val(cs_id);
		//	$("#cs_case_number").val(cs_case_number);
			$("#cs_official_notes").val(cs_official_notes);
			$("#cs_date_of_registration").val(cs_date_of_registration);
			$("#cs_to_whom_issued").val(cs_to_whom_issued);
			$("#cs_serial_number").val(cs_serial_number);
			
			
    		  
    		  
    		});
    	
    	  $('#form_add_certificate').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    console.log('form submited Clicked');
        	    var action_on_form = $("#action_on_form_certificate").val();
        	    var cs_id = $("#cs_id").val();
        		var cs_case_number = $("#cs_case_number").val();
        		var cs_official_notes = $("#cs_official_notes").val(); 
        	    var cs_date_of_registration = $("#cs_date_of_registration").val();
        	 	var cs_to_whom_issued = $("#cs_to_whom_issued").val();
        	 	var cs_serial_number = $("#cs_serial_number").val();
        	 	
        	 	
        	/*   	var modified_by =$("#modified_by").val();
       	    	var modified_by_id =$("#modified_by_id").val();
       	    	 */
        	    var request_type="select_lrd_certificate_section_add_and_update";
        	    
       	    	if(action_on_form =="edit"){ request_type = "select_lrd_certificate_section_add_and_update"; }
       	    	else{ request_type ="select_lrd_certificate_section_add_and_update"; }
       	    	
       	    	
        		 $.ajax({
    				 type: "POST",
    				 url: "lrd_certificate_section_serv",
    				 data: {
    	                	request_type		 	: request_type,
    	                	cs_id      				: cs_id,
    	                	cs_case_number      	: cs_case_number,
    	                	cs_official_notes       : cs_official_notes,
    	                	cs_date_of_registration	: cs_date_of_registration,
    	                	cs_to_whom_issued		: cs_to_whom_issued,
    	                	cs_serial_number   		: cs_serial_number,
    	                	/* modified_by           	: modified_by,
    		    	    	modified_by_id        	: modified_by_id */
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
    					
    				   $('#newCertificateModal').modal('hide');
   	 					$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Certificate Details");
    					
   	 				var json_p = JSON.parse(jobdetails);
   	 				
   	 				 var table_bp = $('#lrd_certificate_details_dataTable');
					  table_bp.find("tbody tr").remove();
						$(json_p.payments).each(function () {
					    	table_bp.append("<tr><td>" + this.cs_date_of_registration + "</td><td>" +this.cs_to_whom_issued + "</td><td>" +this.cs_serial_number + "</td><td>" +this.cs_official_notes + "</td>"
							+ "</tr>");        
				     	});
   	 					
   	 					
   	 					/*  	var result = JSON.parse(jobdetails);
    				        var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
    				        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
    				        					'<strong>Success!</strong> Certificate Record saved successfully</div>';
    				        if(result.data=='Success'){
    				        	$( "#alert-display-space-certificate" ).append( alert_mess );   				        	
    				        }   */   
    				 }
    				
    		});});
    	  
//============================================= End Actions for Certificate ===============================================
    	
/*===========================================   Actions for Encumbrance ==================  */    	  
    	$('#newEncumberancesModal').on('show.bs.modal', function (event) {
    		  var button = $(event.relatedTarget) // Button that triggered the modal
    		  var recipient = button.data('action') // Extract info from data-* attributes
    		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    		  var modal = $(this)
    		  if(recipient=='edit'){
    			modal.find('.modal-body #action_on_form_encumbrances').val(recipient)
    			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
    			
    		  	//Get the objection data for editing
    		  	/* $.ajax({
    				 type: "POST",
    				 url: "Case_Management_Serv",
    				 data: {
    	                	request_type: 'update_stamp_duty_records',
    	                	job_number:job_number
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
   					 	var result = JSON.parse(jobdetails);
   				        if(result.data=='Success'){
   				        	//Load all Objection data into form				        	
   				        }     
    				 }
    			*/
    		  	} 
    		  
    		  
    		});
    	
    	  $('#form_add_encumbrances').on('submit', function(e){
        	    // validation code here
        	    e.preventDefault();
        	    console.log('form submited Clicked');
        	    var action_on_form = $("#action_on_form_encumbrances").val();
        	    var es_id = $("#es_id").val();
        		var es_case_number = $("#es_case_number").val();
        		var es_registered_number = $("#es_registered_number").val();
        		
        		var es_date_of_registration = $("#es_date_of_registration").val(); 
        	    var es_date_of_instrument = $("#es_date_of_instrument").val();
        	 	var es_memorials = $("#es_memorials").val();
        	 	
        	 	

        	 /*  	var modified_by =$("#modified_by").val();
       	    	var modified_by_id =$("#modified_by_id").val(); */
       	    	
        	    var request_type="select_lrd_encumbrances_section_add_and_update";
        	    
       	    	if(action_on_form =="edit"){ request_type = "select_lrd_encumbrances_section_add_and_update"; }
       	    	else{ request_type ="select_lrd_encumbrances_section_add_and_update"; }
       	    	
       	    	
        		 $.ajax({
    				 type: "POST",
    				 url: "lrd_encumbrances_section_serv",
    				 data: {
    	                	request_type		 	: request_type,
    	                	es_id      				: es_id,
    	                	es_registered_number	: es_registered_number,
    	                	es_case_number      	: es_case_number,
    	                	es_date_of_registration : es_date_of_registration,
    	                	es_date_of_instrument	: es_date_of_instrument,
    	                	es_memorials			: es_memorials,
    	                	es_back					: '',
    	                	es_forward				: '',
    		    	    	/* modified_by           	: modified_by,
    		    	    	modified_by_id        	: modified_by_id */
    				 	   },
    				 cache: false,
    				 beforeSend: function () {
    					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
    				 },
    				 success: function(jobdetails) {
    					console.log(jobdetails)
    					 	
    					$('#newEncumberancesModal').modal('hide');
   	 					$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Encumbrance Details");
    					
   	 				
   	 				var json_p = JSON.parse(jobdetails);
   	 				
   	 				 var table_bp = $('#lrd_encumberance_details_dataTable');
					  table_bp.find("tbody tr").remove();
						$(json_p.data).each(function () {
					    	table_bp.append("<tr><td>" + this.es_date_of_instrument + "</td><td>" +this.es_date_of_registration + "</td><td>" +this.es_registered_number + "</td><td>" +this.es_memorials + "</td><td>" +this.es_remarks + "</td>"
							+ "</tr>");        
				     	});
   	 					
   	 					
    					/* var result = JSON.parse(jobdetails);
    				        var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
    				        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
    				        					'<strong>Success!</strong> Encumbrance Record saved successfully</div>';
    				        if(result.data=='Success'){
    				        	$( "#alert-display-space-certificate" ).append( alert_mess );   				        	
    				        }   */   
    				 }
    				
    		});});
    	  
//============================================= End Actions for Encumbrance ===============================================

    		
 /*===========================================   Actions for newMemorialsModal ==================  */    	  
   	      	$('#newMemorialsModal').on('show.bs.modal', function (event) {
   	      		/*   var button = $(event.relatedTarget) // Button that triggered the modal
   	      		  var recipient = button.data('action') // Extract info from data-* attributes
   	      		  var modal = $(this)
   	      		  if(recipient=='edit'){
   	      			modal.find('.modal-body #action_on_form_memorials').val(recipient)
   	      			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
   	      			
   	      		   */
   	      		   
   	      	  	var mid = $(event.relatedTarget).data('mid');
   	 			var m_case_number = $(event.relatedTarget).data('m_case_number');
   	 			var m_registered = $(event.relatedTarget).data('m_registered');
   	 			var m_memorials = $(event.relatedTarget).data('m_memorials');
   	 			var m_date_of_instrument = $(event.relatedTarget).data('m_date_of_instrument');
   	 			var m_date_of_registration = $(event.relatedTarget).data('m_date_of_registration');
  	 	
   	 			
   	 			$("#mid").val(mid);
   	 			//$("#m_case_number").val(m_case_number);
   	 			$("#m_registered").val(m_registered);
   	 			$("#m_memorials").val(m_memorials);
   	 			$("#m_date_of_instrument").val(m_date_of_instrument);
   	 			$("#m_date_of_registration").val(m_date_of_registration);

   	 			
   	      		  
   	      		});
   	      	
   	      	  $('#form_add_memorials').on('submit', function(e){
   	          	    // validation code here
   	          	    e.preventDefault();
   	          	    console.log('form submited Clicked');
   	          	    //var action_on_form = $("#action_on_form_memorials").val();
   	          		var mid = $("#mid").val();
   	          		var m_case_number = $("#m_case_number").val();
   	          		var m_registered = $("#m_registered").val(); 
   	          	    var m_memorials = $("#m_memorials").val();
   	          	 	var m_date_of_instrument = $("#m_date_of_instrument").val();
   	          	 	var m_date_of_registration = $("#m_date_of_registration").val();
   	          	console.log('form submited Clicked');
   	          	 	
   	          		//var m_back = $("#m_back").val();
	          	 	//var m_forward = $("#m_forward").val();
	          	 	var m_remarks = $("#m_remarks").val();
   	          	 	

   	        	  /* 	var modified_by =$("#modified_by").val();
   	       	    	var modified_by_id =$("#modified_by_id").val(); */
   	         	    	
   	          	    var request_type="";
   	       	  request_type ="select_lrd_memorials_section_add_and_update";
  	         	    	//if(action_on_form =="edit"){ request_type = "select_lrd_memorials_section_add_and_update"; }
  	         	    	//else{ request_type ="select_lrd_memorials_section_add_and_update"; }
   	         	 /*    	
  	         	 	console.log(mid);
  	         	 console.log(case_number);
  	         	console.log(m_registered);
  	         	console.log(m_memorials);
  	         	
  	         	console.log(m_date_of_instrument);
  	         	console.log(m_date_of_registration);
  	         	console.log(request_type); */
   	          		 $.ajax({
   	      				 type: "POST",
   	      				 url: "lrd_memorials_section_serv",
   	      				 data: {
   	      	                	request_type		 	: request_type,
   	      	               		mid      	 			: mid,
   	      	               		m_case_number      	 	: m_case_number,
   	      	                	m_registered       		: m_registered,
   	      	                	m_memorials				: m_memorials,
   	      	                	m_date_of_registration	: m_date_of_registration,
   	      	                	m_date_of_instrument   	: m_date_of_instrument,
   	      	               		m_back					: '-',
   	      	          			m_forward				: '-',
   	      	     				m_remarks   			: m_remarks
   	      		    	    	/* modified_by           	: modified_by,
   	      		    	    	modified_by_id        	: modified_by_id */
   	      				 	   },
   	      				 cache: false,
   	      				 beforeSend: function () {
   	      					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   	      				 },
   	      				 success: function(jobdetails) {
   	      					console.log(jobdetails)
   	      					 	
   	      				$('#newMemorialsModal').modal('hide');
   	 					$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Mamorails Details");
   	      					
   	 				var json_p = JSON.parse(jobdetails);
   	      					
   	 				 var table_bp = $('#lrd_memorial_details_dataTable');
					  table_bp.find("tbody tr").remove();
						$(json_p.data).each(function () {
					    	table_bp.append("<tr><td>" + this.m_registered_no + "</td><td>" +this.m_memorials + "</td><td>" +this.m_date_of_instrument + "</td><td>" +this.m_date_of_registration + "</td>"
							+ "</tr>");        
				     	});
   	 					
   	 					/* var result = JSON.parse(jobdetails);
   	      				        var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
   	      				        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
   	      				        					'<strong>Success!</strong> Memorials Record saved successfully</div>';
   	      				        if(result.data=='Success'){
   	      				        	$( "#alert-display-space-memorials" ).append( alert_mess );   				        	
   	      				        }  */    
   	      				 }
   	      				
   	      		});});
    	      	  
//============================================= End Actions for newMemorialsModal ===============================================
    	      	
   	      	
/*===========================================   Actions for newProprietorshipModal ==================  */    	  
   	      	$('#newProprietorshipModal').on('show.bs.modal', function (event) {
   	      		 // var button = $(event.relatedTarget) // Button that triggered the modal
   	      		  //var recipient = button.data('action') // Extract info from data-* attributes
   	      		  //var target_id = button.data('target-id') // Extract info from data-* attributes
   	      		
   	      		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
   	      		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
   	      		/*   var modal = $(this)
   	      		  if(recipient=='edit'){
   	      			modal.find('.modal-body #action_on_form_proprietory').val(recipient)
   	      			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
   	      		
   	      		  	} 
   	      		   */
   	      		   
   	      		   
   	      	var ps_id = $(event.relatedTarget).data('ps_id');
			var ps_case_number = $(event.relatedTarget).data('ps_case_number');
			var ps_registration_number = $(event.relatedTarget).data('ps_registration_number');
			var ps_proprietor = $(event.relatedTarget).data('ps_proprietor');
			var ps_date_of_instrument = $(event.relatedTarget).data('ps_date_of_instrument');
			var ps_nature_of_instrument = $(event.relatedTarget).data('ps_nature_of_instrument');
			var ps_date_of_registration = $(event.relatedTarget).data('ps_date_of_registration');
			var ps_transferor = $(event.relatedTarget).data('ps_transferor');
			var ps_transferee = $(event.relatedTarget).data('ps_transferee');
			var ps_price_paid = $(event.relatedTarget).data('ps_price_paid');
			var ps_remarks = $(event.relatedTarget).data('ps_remarks');
			
	
	
	
			$("#ps_id").val(ps_id);
			//$("#ps_case_number").val(ps_case_number);
			$("#ps_registration_number").val(ps_registration_number);
			$("#ps_proprietor").val(ps_proprietor);
			$("#ps_date_of_instrument").val(ps_date_of_instrument);
			$("#ps_nature_of_instrument").val(ps_nature_of_instrument);
			$("#ps_date_of_registration").val(ps_date_of_registration);
			$("#ps_transferor").val(ps_transferor);
			$("#ps_transferee").val(ps_transferee);
			$("#ps_price_paid").val(ps_price_paid);
			$("#ps_remarks").val(ps_remarks);
			
   	      		  
   	      	});
   	      	
   	      	  $('#form_add_proprietory').on('submit', function(e){
   	          	    // validation code here
   	          	    e.preventDefault();
   	          	    console.log('form submited Clicked');
   	          	    var action_on_form = $("#action_on_form_proprietory").val();
   	          	    
   	          	    
   	          	
   	          		var ps_id = $("#ps_id").val();
   	         		var case_number = $("#ps_case_number").val();
   	          		var ps_registration_number = $("#ps_registration_number").val(); 
   	          	    var ps_proprietor = $("#ps_proprietor").val();
   	          	 	var ps_date_of_instrument = $("#ps_date_of_instrument").val();
   	          	 	var ps_nature_of_instrument = $("#ps_nature_of_instrument").val();
   	          		var ps_date_of_registration = $("#ps_date_of_registration").val();
	          		var ps_transferor = $("#ps_transferor").val(); 
	          	    var ps_transferee = $("#ps_transferee").val();
	          	 	var ps_price_paid = $("#ps_price_paid").val();
	          	 	var ps_remarks = $("#ps_remarks").val();
	          	 	//var ps_signature = $("#ps_signature").val();
   	          	 	
   	          	 	

	        	 /*  	var modified_by =$("#modified_by").val();
	       	    	var modified_by_id =$("#modified_by_id").val(); */
   	         	    	
   	          	    var request_type="";
   	          	    
         	    	if(action_on_form =="edit"){ request_type = "select_lrd_proprietorship_section_add_and_update"; }
         	    	else{ request_type ="select_lrd_proprietorship_section_add_and_update"; }
   	         	    	
   	         	    	
   	          		 $.ajax({
   	      				 type: "POST",
   	      				 url: "lrd_proprietorship_section_serv",
   	      				 data: {
   	      	                	request_type		 	: request_type,
   	      	               		ps_id      				: ps_id,
   	      	               		ps_case_number      	: case_number,
   	      	               		ps_registration_number  : ps_registration_number,
   	      	               		ps_proprietor			: ps_proprietor,
   	      	          			ps_date_of_instrument	: ps_date_of_instrument,
   	      	     				ps_nature_of_instrument : ps_nature_of_instrument,
   	      						ps_date_of_registration : ps_date_of_registration,
   	      						ps_transferor  			: ps_transferor,
   	      						ps_transferee			: ps_transferee,
   	      						ps_price_paid			: ps_price_paid,
   	      						ps_remarks 				: ps_remarks,
   	      						ps_signature 			: ''
   	      					/* 	modified_by 			: modified_by,
   	      		    	    	modified_by_id        	: modified_by_id */
   	      				 	   },
   	      				 cache: false,
   	      				 beforeSend: function () {
   	      					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   	      				 },
   	      				 success: function(jobdetails) {
   	      					console.log(jobdetails)
   	      					var json_p = JSON.parse(jobdetails);
   	      					
   	      				$('#newProprietorshipModal').modal('hide');
   	 					$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Proprietorship Details");
   	 					
   	 				 var table_bp = $('#lrd_proprietorship_details_dataTable');
					  table_bp.find("tbody tr").remove();
						$(json_p.data).each(function () {
					    	table_bp.append("<tr><td>" + this.ps_registration_number + "</td><td>" +this.ps_proprietor + "</td><td>" +this.ps_date_of_instrument + "</td><td>" +this.ps_nature_of_instrument + "</td>"
							+ "</tr>");        
				     	});
   	 					
   	 					
   	 					
   	 					/* var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
   	      				        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
   	      				        					'<strong>Success!</strong> Proprietorship Record saved successfully</div>';
   	      				        if(result.data=='Success'){
   	      				        	$( "#alert-display-space-proprietory" ).append( alert_mess );   				        	
   	      				        }  */    
   	      				 }
   	      				
   	      		});});
    	      	  
//============================================= End Actions for newProprietorshipModal ===============================================
	
	
/*===========================================   Actions for newValuationModal ==================  */    	  
   	      	$('#newValuationModal').on('show.bs.modal', function (event) {
   	      		/*   var button = $(event.relatedTarget) // Button that triggered the modal
   	      		  var recipient = button.data('action') // Extract info from data-* attributes
   	      		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
   	      		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
   	      		  var modal = $(this)
   	      		  if(recipient=='edit'){
   	      			modal.find('.modal-body #action_on_form_valuation').val(recipient)
   	      			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
   	      		
   	      		  	}  */
   	       	var vs_id = $(event.relatedTarget).data('vs_id');
			var vs_case_number = $(event.relatedTarget).data('vs_case_number');
			var vs_date_of_valuation = $(event.relatedTarget).data('vs_date_of_valuation');
			var vs_amount = $(event.relatedTarget).data('vs_amount');
			var vs_remarks = $(event.relatedTarget).data('vs_remarks');
				
			$("#vs_id").val(vs_id);
			//$("#vs_case_number").val(vs_case_number);
			$("#vs_date_of_valuation").val(vs_date_of_valuation);
			$("#vs_amount").val(vs_amount);
			$("#vs_remarks").val(vs_remarks);
			
			
   	      		  
   	      		});
   	      	
   	      	  $('#form_add_valuation').on('submit', function(e){
   	          	    // validation code here
   	          	    e.preventDefault();
   	          	    console.log('form submited Clicked');
   	          	    var action_on_form 			= $("#action_on_form_valuation").val();
   	          		var vs_id 					= $("#vs_id").val();
   	          		var vs_case_number 			= $("#vs_case_number").val();
   	          		var vs_date_of_valuation 	= $("#vs_date_of_valuation").val(); 
   	          	    var vs_amount 				= $("#vs_amount").val();
   	          	 	var vs_remarks 				= $("#vs_remarks").val();
   	          	 	
   	          	 	
   	          	 	

	        	  /* 	var modified_by =$("#modified_by").val();
	       	    	var modified_by_id =$("#modified_by_id").val();
   	         	     */	
   	          	    var request_type="select_lrd_valuation_section_add_and_update";
   	          	    
         	    	if(action_on_form =="edit"){ request_type = "select_lrd_valuation_section_add_and_update"; }
         	    	else{ request_type ="select_lrd_valuation_section_add_and_update"; }
   	         	    	
   	         	    	
   	          		 $.ajax({
   	      				 type: "POST",
   	      				 url: "lrd_valuation_section_serv",
   	      				 data: {
   	      	                	request_type		 	: request_type,
   	      	               		vs_id      	 			: vs_id,
   	      	               		vs_case_number  		: vs_case_number,
   	      	               		vs_date_of_valuation	: vs_date_of_valuation,
   	      	               		vs_amount				: vs_amount,
   	      	               		vs_remarks 				: vs_remarks,
   	      						/* modified_by 			: modified_by,
   	      		    	    	modified_by_id        	: modified_by_id */
   	      				 	   },
   	      				 cache: false,
   	      				 beforeSend: function () {
   	      					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
   	      				 },
   	      				 success: function(jobdetails) {
   	      					console.log(jobdetails)
   	      					 
   	      				$('#newValuationModal').modal('hide');
   	 					$("#general_message_dialog").modal();
   	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
   	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Successfully Saved Valuation Details");
   	      					
   	 				var json_p = JSON.parse(jobdetails);
   	 					
   	 				 var table_bp = $('#lrd_valuation_details_dataTable');
					  table_bp.find("tbody tr").remove();
						$(json_p.data).each(function () {
					    	table_bp.append("<tr><td>" + this.vs_date_of_valuation + "</td><td>" +this.vs_amount + "</td><td>" +this.vs_remarks +"</td>"
							+ "</tr>");        
				     	});
   	 					
   	 					
   	 					/* var result = JSON.parse(jobdetails);
   	      				        var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
   	      				        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
   	      				        					'<strong>Success!</strong> Valuation Record saved successfully</div>';
   	      				        if(result.data=='Success'){
   	      				        	$( "#alert-display-space-valuation" ).append( alert_mess );   				        	
   	      				        }     */ 
   	      				 }
   	      				
   	      		});});
    	      	  
//============================================= End Actions for newProprietorshipModal ===============================================
   	      	      	
	
   	      	      	
	
   	       /*===========================================   Actions for InspectionModal ==================  */    	  
     	      	$('#form_inspection').on('show.bs.modal', function (event) {
     	      		  var button = $(event.relatedTarget) // Button that triggered the modal
     	      		  var recipient = button.data('action') // Extract info from data-* attributes
     	      		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
     	      		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
     	      		  var modal = $(this)
     	      		  if(recipient=='edit'){
     	      			modal.find('.modal-body #action_on_form_valuation').val(recipient)
     	      			modal.find('.modal-title').text(recipient.toUpperCase() +" "+ modal.find('.modal-title').text().toUpperCase() )
     	      			
     	      		  	//Get the objection data for editing
     	      		  	/* $.ajax({
     	      				 type: "POST",
     	      				 url: "Case_Management_Serv",
     	      				 data: {
     	      	                	request_type: 'update_stamp_duty_records',
     	      	                	job_number:job_number
     	      				 	   },
     	      				 cache: false,
     	      				 beforeSend: function () {
     	      					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     	      				 },
     	      				 success: function(jobdetails) {
     	      					console.log(jobdetails)
     	     					 	var result = JSON.parse(jobdetails);
     	     				        if(result.data=='Success'){
     	     				        	//Load all Objection data into form				        	
     	     				        }     
     	      				 }
     	      			*/
     	      		  	} 
     	      		  
     	      		  
     	      		});
     	      			
     	      			
     	      			
     	      	
     	           $("#btn_upload_georeferenced_images_to_server").click(function(event){
                 	
     		    		//var job_number = $("#cs_main_job_number").val();
     		    	  

     		    		 $.ajax({
     						 type: "POST",
     						 url: "LoadGeotiffToGeoserver",
     						 data: {
     			                	request_type: 'load_lrd_geotiff_path'
     			                	
     						 	   },
     						 cache: false,
     						 beforeSend: function () {
     							 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     						 },
     						 success: function(jobdetails) {
     							 //	console.log(jobdetails);
     								$("#general_message_dialog").modal();
     								//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
     								$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
     								
     								
     							
     						 }
     						
     				});
                 	
                 	//$('#smartwizardfirstregistration').smartWizard("next");
                 	
                       return true;
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
     						 
     						 /* var result = JSON.parse(jobdetails);
     					        var alert_mess = '<div class="alert alert-success fade show" id="bsalert">' + 
     					        					'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' + 
     					        					'<strong>Success!</strong> Inspection Report saved successfully</div>';
     					        if(result.data=='Success'){
     					        	$( "#alert-display-space" ).append( alert_mess );
     					        	
     					        }  */    
     					 },
     					 error: function(err){
     						 console.log(err);
     					 }
     	      				
     	      		}); });
      	      	  
  //============================================= End Actions for iNSPECTION ===============================================  	
      	
	  
	  
	  
	  
     	     //	btn-uploadcoordiantecsv
     	     	 $('#btn-uploadcoordiantecsv').click(function(){

     	     		 
     	     		 
     	     		var table_bp = $('#coordinatelis_Table');
					  table_bp.find("tbody tr").remove();
	  
     	     		 
     	     		 
     	            var csv = $('#txtFileUploaduploadcoordiantecsv');
     	            var csvFile = csv[0].files[0];
     	            var ext = csv.val().split(".").pop().toLowerCase();

     	            if($.inArray(ext, ["csv"]) === -1){
     	                alert('upload csv');
     	                return false;
     	            }
     	            if(csvFile != undefined){
     	                reader = new FileReader();
     	                reader.onload = function(e){

     	                	console.log(e.target.result)
     	                	csvResult = e.target.result.split(/\r|\n|\r\n/);
     	                   // $('.csv').append(csvResult);
     	                    console.log(csvResult)
     	                    var list_from_csv =e.target.result;
     	                    
     	                   var coordinates = list_from_csv.split('\n');
     	                
     	                   var points = [];
     	                    console.log('coodinates list');
     	                     console.log(coordinates);

     	                     // console.log(coodinates.length);
     	                       console.log('length:'+ coordinates.length);
     	                  coordinates.forEach(function(entry) {
     	                      //console.log(entry);

     	                       points = entry.split(",");


     	                        if (points.length>1){
     	                              // polypoints.push(ol.proj.transform([parseFloat(points[0]),parseFloat(points[1])],'EPSG:4326','EPSG:3857'))
     	                               //polypoints.push([parseFloat(points[0]),parseFloat(points[1])])
     	                               console.log(points[0]);
     	                        	  var table = $('#coordinatelis_Table');
     	             			    //table.find("tbody tr").remove();
     	             	 
     	             	   
     	                   
     	             	    table.append("<tr><td>" + points[0] + "</td><td>" + points[1] + "</td><td>" + points[2] + "</td><td>"+ '' + "</td>"
     	             	    		
     	             	    		
     	             	    	//	+  '<td><p data-placement="top" data-toggle="tooltip" title="Milestone"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" ' + result.job_number + ' id="btnmilestoneslist"><span class="fas fa-check"></span></button></p> </td>'
     	             	    		 
     	             	    	/*  +  '<td><p data-placement="top" data-toggle="tooltip" title="Remove"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="' + points[0] + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span></button></p></td>'
     	             	    	 */	   
     	             	    		    + "</tr>");
     	                           }
     	                     
     	                   });
     	                }
     	                reader.readAsText(csvFile);
     	                
     	                
     	                
     	                
     	                
     	       /*     	var file = evt.target.files[0];
     	   		var reader = new FileReader();
     	   		reader.readAsText(file);
     	   		reader.onload = function(event) {
     	   			//Jquery.csv
     	   			createArray($.csv.toArrays(event.target.result));			
     	   		}; */
     	   		
     	           //	$('#form_inspection').modal('hide');
	 					//$("#general_message_dialog").modal();
	 				//	$('#general_message_dialog #general_message_dialog_msg_new').val('CSV File has been Uploaded Successfully');
     	               $('#uploadcoordiantecsv').modal('hide');
     	            }
     	        });
  
	  			$('#btnJobNumberSearch').on('click', function(e){
         	      	  
         	     	// validation code here
         	    	    e.preventDefault();
     	    		console.log('how are your search new');
     	    		
     	    		var job_number = $("#search_job_number").val();
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
     						
     						 console.log(jobdetails);
     						
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
   	     					 $("#fe_case_number").val(result.transaction_details.transaction_number);
   	     					 $("#fe_locality").val(result.parcel_details.locality);
   	     					 $("#fe_district").val(result.parcel_details.district);
   	     					 $("#fe_region").val(result.parcel_details.region);
   	     					 $("#fe_extent").val(result.parcel_details.extent);
							 $("#fe_registry_mapref").val(result.parcel_details.registry_mapref);

   	     					 
   	     					   $("#main_service_id_fe").val(result.job_detail.business_process_id); 
   	     					   $("#main_service_sub_id_fe").val(result.job_detail.business_process_sub_id); 
   	     					   
   	     	
   	     					
   	     					 var fe_case_number_new= result.transaction_details.transaction_number;
   	     					 
   	     					 console.log("case is " + fe_case_number_new);
    				        	
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
	        						
	        						 //console.log("details" + jobdetails);
	        						if(jobdetails == "Data Not Received"){
	        							console.log("not ");
	        						}else{
	        							
	        						
	        						 var result = JSON.parse(jobdetails);
	        						 
	        						 var table = $('#party_details_datatable');
	          					    table.find("tbody tr").remove();
	          					
	          					    console.log(jobdetails);
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
	        						    
	          					    
	          					// $('#form_inspection').modal('hide');
	      	 					
	          					
	          					
	          					//$("#general_message_dialog").modal();
	      	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
	      	 					//$('#general_message_dialog #general_message_dialog_msg_new').val('Party has been saved Successfully');

	        					 }}
	        					 });
    				        	
    				        	
    				        	
    				        	
    				        	
    				        }else{
    				        	
    				        	$.notify({
    			                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
    			                }, {
    			                    type: 'danger'
    			                });
    				        	
    				        }
     					        
     					        
     					        
     					      //-----------------------------  
     					      
     					     
	     					 
	     					 
	     					
	     					
			     					 
     					     
     						    
     						    

     					 }
     					 }); 
     	        });
	  			
	  			
				$('#new_bill_application_region').change(function() {
      	     		
      	     		var region_id = $(this).find(':selected').attr('data-id');
      	     	    console.log("seleted gerion: " + region_id);
      	     		$.ajax({
	   					 type: "POST",
	   					 url: "Case_Management_Serv",
	   					 data: {
	   		                	request_type: 'get_list_of_district',
	   		                	region_id: region_id },
	   					 cache: false,
	   					 beforeSend: function () {
	   						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	   					 },
	   					 success: function(jobdetails) {
	   						 
	   						var select = $("#party_ar_district_gen");
	   						var select2 = $("#new_bill_application_district");
	   						select.empty();
	   						select2.empty();
	   					   
     					    //console.log("District: " + jobdetails);
     					    var json_p = JSON.parse(jobdetails);
	     					    
				        						    
	     					$(json_p).each(function () {
	     						//console.log("new District: " + this.district_name);
	     						/* $option = $("<option></option>")
	     				        .attr("value", this.district_name)
	     				        .text(this.district_name);
	     						select.append($option);
	     						select2.append($option); */
	     						select2.append('<option value="' + this.district_name + '">' + this.district_name + '</option>');
	        					
	     						
	     						/* select.append("<tr><td>" +this.officers_general_comments + "</td><td>" +this.division + "</td><td>" +this.created_by 
									  + "</td><td>" +this.created_date 
									+'</tr>'); */
	  							        
	  				         });			    
				          					 
	   					     
	   						    
	   						    
	
	   					 }
	   				});
      	     		
      	     		
      	     		
      	     	});
  
				
  				$('#btn_assign_inspection').on('click', function(e){
      	       	    // validation code here
      	       	    e.preventDefault();
      	       	    //console.log('form submited Clicked');
      	       		
      	       		var job_number =  $("#cs_main_job_number").val();
      	       	    var case_number =  $("#cs_main_tansaction_number").val();
      	       	    var purpose_of_inspection = $("#purpose-of-inspection").val();
	      	       	var userid_1 = $( "#in_user_to_send_to" ).val();  // $( "#user_to_send_to option:selected" ).text();
	           	 	var  assigned_to_id  = $('#in_listofusers option').filter(function() {return this.value == userid_1; }).data('id');
	           		var  assigned_to= $('#in_listofusers option').filter(function() {return this.value == userid_1; }).data('name');
	        		
	           		console.log("case :" + case_number);
	                console.log("job :" + job_number);
	                console.log("purposr :" + purpose_of_inspection);
	                
	                console.log("userid_1 :" + userid_1);
	                console.log("sender :" + assigned_to);
	                console.log("sender_id :" + assigned_to_id);
      	       	    
      	       	  	var assigned_by =localStorage.getItem("fullname");
      	      	    var assigned_by_id =localStorage.getItem("userid");
      	       	   
      	   	   
      	      	    
      	      	$.ajax({
 	   				 type: "POST",
 	   				 url: "Case_Management_Serv",
 	   				 data: {
 	   	                	request_type: 'assign_inspection_case_to_officer',
 	   	                    case_number : case_number,
 	   					    job_number : job_number,
 	   					    purpose_of_inspection : purpose_of_inspection,
 	   					    assigned_to : assigned_to,
 	   					    assigned_to_id : assigned_to_id,
 	   					    assigned_by : assigned_by,
 	   					    assigned_by_id :assigned_by_id
 	   				 	   },
 	   				 cache: false,
 	   				 beforeSend: function () {
 	   					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
 	   				 },
 	   				 success: function(jobdetails) {
 	   					 	//var result = JSON.parse(jobdetails);
 	   				       /*  var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'  ;
 	   				        	alert_mess = alert_mess + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'  ;
 	   				        	alert_mess = alert_mess + '<strong>Success!</strong> Assessment Values saved successfully</div>'; */
 	   				       console.log("jobdetails :" + jobdetails);
 	   	      	       	    
	   				        	//if(jobdetails === "Success"){
	   				        	//$( "#alert-display-space2" ).append( 'ood' );
	   				     	   $('#assignInspectionModal').modal('hide');
	      	 					$("#general_message_dialog").modal();
	      	 					//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
	      	 					$('#general_message_dialog #general_message_dialog_msg_new').val("Assinging Inspection to to user! " + jobdetails);

     	   				   // }     
 	   				 },
	      	   		error: function (request) {
	      	   	        alert("Request falied");
	      	   	    }
      	   		}); });
  				
  	
  				


  				 /*===========================================   Actions for InspectionModal ==================  */    	  
     	      

     	       /*===========================================   Actions for FinancialReportModal ==================  */    	  
     	      	$('#viewFinancialReportModal').on('show.bs.modal', function (event) {
     	      		  var report_type = $(event.relatedTarget).data('report_type') // Extract info from data-* attributes
     	      		  
     	      		  
     	      		  console.log(report_type);
     	      		  $("#report-modal-title-financial").empty();
     	      		  $("#report-modal-title-financial").html(report_type);
     	      		  
     	      		
     	      		  
     	      	});
     	       
     	      	/*===========================================   Actions for ReceivedReportModal ==================  */    	  
     	      	$('#viewReceivedReportModal').on('show.bs.modal', function (event) {
     	      		  var report_type = $(event.relatedTarget).data('report_type') // Extract info from data-* attributes
     	      		  
     	      		  
     	      		  console.log(report_type);
     	      		  $("#report-modal-title-received").empty();
     	      		  $("#report-modal-title-received").html(report_type);
     	      		  
     	      		
     	      		  
     	      	});
     	      	
     	      	/*===========================================   Actions for CompletedReportModal ==================  */    	  
     	      	$('#viewCompletedReportModal').on('show.bs.modal', function (event) {
     	      		  var report_type = $(event.relatedTarget).data('report_type') // Extract info from data-* attributes
     	      		  
     	      		  
     	      		  console.log(report_type);
     	      		  $("#report-modal-title-completed").empty();
     	      		  $("#report-modal-title-completed").html(report_type);
     	      		  
     	      		
     	      		  
     	      	}); 
  				 
  				 
  				 
  
     	     	//Select row table
      	     	$('#publishedDataTable tbody, #job_detailsdataTable tbody').on('click', 'tr', function() {
      	     	  var $row = $(this),
      	     	    isSelected = $row.hasClass('selected')
      	     	  $row.toggleClass('selected')
      	     	    .find(':checkbox').prop('checked', !isSelected);
      	     	  
      	     		
 		            $('#selectAll').prop('checked',false);
 		             
      	     	});
 				//select all in table
      	     	$("#selectAll").on("click", function() {
      	     	  if($(this).prop("checked") == true){
      	     		$('#publishedDataTable tbody tr, #job_casemgtdetailsdataTable  tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_detailsdataTable tbody tr').addClass('selected');
      	     	  }else{ $('#publishedDataTable tbody tr, #job_casemgtdetailsdataTable  tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_detailsdataTable tbody tr').removeClass('selected'); }
      	     	  
      	     	  $("#publishedDataTable tbody tr,  #job_casemgtdetailsdataTable  tbody tr, #job_detailsdataTable tbody tr").find(":checkbox").prop('checked', $(this).prop('checked'));
      	     	 
      	     	});
  
 				
      	     	
     	     	 
     	     	 
     	     	 $('.data-table').DataTable( {
     	            stateSave: true
     	        } );
     	     	 $('[data-toggle="tooltip"]').tooltip();
     	     	/* var $j = jQuery.noConflict();
     	     	$j(".datepicker").datepicker(); */
     	     	/* $("#fe_commencement_date, #fe_date_of_document, .date-picker").flatpickr( 
     	     			
     	     	); */
     	     	
     	     	if(localStorage.getItem('user_level') < 2){
        			$('.btn_Update_existing_milestone').hide();
        			$('.to_hide_on_level_1').hide();
        			
     	     	}else{
        			$('.btn_Update_existing_milestone').show();
        			$('.to_hide_on_level_1').show();
        		}
     	     	
     	     	
    });
	</script>




<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts 
<script src="js/demo/chart-area-demo.js"></script>
<script src="js/demo/chart-pie-demo.js"></script> -->

<!-- JS for loading Overlay spinner -->
<script src="js/loadingOverlay.js"></script>



<!-- <script src="jsmap/maps.js"></script> -->
 <!-- <script src="pvlmd_maps_templates/pvlmdmaps.js"></script>  -->
<script src="jsmap/lcmaps.js"></script>
<script src="jsmap/lrdmaps.js"></script>
<script src="jsmap/lrdfpmaps.js"></script>
<script src="jsmap/lcfrsmaps.js"></script>

<script src="jsmap/smdfrtpmaps.js"></script>
<script src="jsmap/pvlmd_spatial.js"></script>  
<script src="jsmap/lcfrfamaps.js"></script>


<script src="pvlmd_maps_templates/dlrevmaps.js"></script>
<script src="smd_maps_templates/smdmaps.js"></script>
<script src="jsmap/lvdcomparablemaps.js"></script>
<script src="js_includes/professional_tem.js"></script>
<script src="js_includes/transitional_tem.js"></script>
<script src="js_includes/case_movement.js"></script>

${page_name == "help_desk" ? "<script src='js_includes/help_desk.js'></script>" : ""}
${(page_name == "compliance") ? "<script src='js_includes/compliance.js'></script>" : ""}
${(page_name == "ticket") ? "<script src='js_includes/ticket.js'></script>" : ""}
${(page_name == "ticket_view") ? "<script src='js_includes/ticket.js'></script>" : ""}

<script src="csau_template/csau_online.js"></script>


<script src="js_includes/users_to_batch.js"></script>
<script src="js_includes/_user_profile.js"></script>
<script src="transitional_templates/transitional_tem.js"></script>
<script src="pvlmd_maps_templates/pvlmd_transaction_search.js"></script>

<script src="js_includes/letters_template.js"></script>
<script src="lrd_maps_templates/lrd_transaction_search.js"></script>
<script src="smd_maps_templates/smd_transaction_search.js"></script>







<!-- <script src="jsmap/pvlmdmaps.js"></script> -->

<script src="js/js/jquery.steps.js"></script>
<script src="js/js/main.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap-notify.js"></script>
<script src='js/lodash.min.js'></script>
<!-- <script src="js/js/parsley_form.js"></script> -->

<!-- bootbox code -->
<script src="js/bootbox.min.js"></script>

<!-- JavaScript -->
<script src="js/jsw/jquery.smartWizard.js" type="text/javascript"></script>
<script src="js/summernote.min.js" type="text/javascript"></script>
<script src="js/echarts/echarts.min.js" type="text/javascript"></script>



<jsp:include page="../includes/_modals.jsp"></jsp:include>
<jsp:include page='${(page_name == "page_enquiry_desk") || (page_name == "page_enquiry_backoffice") || (page_name == "csau_backoffice") ? "../includes/_enquiry_modals.jsp" : ""}'></jsp:include>
<jsp:include page="../csau_template/_csau_online_modals.jsp"></jsp:include>
<jsp:include page="../includes/_profile_modal.jsp"></jsp:include>
<jsp:include page='${(page_name == "compliance") ? "../includes/_compliance_modals.jsp" : ""}'></jsp:include>
<jsp:include page='${(page_name == "ticket") || (page_name == "ticket_view") ? "../includes/_ticket_modals.jsp" : ""}'></jsp:include>












</body>

</html>