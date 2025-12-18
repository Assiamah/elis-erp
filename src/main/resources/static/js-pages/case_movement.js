$(document).ready(function() {
	var datatable = $("#job_batchedtouserlistdataTable").DataTable( {
		stateSave: true, 
		dom: 'Bfrtip',						
								buttons: [
									'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
								]
	} );
	
	$("#btnViewApplicationsList").click(function(event){
     	//console.log("btnViewApplicationsList clicked");
	    	 	
	       	    //var created_by_id =localStorage.getItem("userid");
	    	            	    
	    		 $.ajax({
					 type: "POST",
					 url: "Case_Management_Serv",
					 data: {
		                	request_type: 'load_application_batched_to_user_new'
					 	   },
					 cache: false,
					 success: function(jobdetails) {
						 	//console.log(jobdetails);
						 	/*JSON.stringify(jobdetails);*/
						 	var json_p = JSON.parse(jobdetails);
						 	datatable.clear();

						 	$(json_p.data).each(function() { 
						 		//console.log('t');
								datatable.row.add( [
									
									
									'<input type="checkbox"/>',
									this.job_number,
									this.ar_name,
									this.business_process_sub_name,
									this.current_application_status,
									this.job_datesend,
									this.job_forwarded_by,
									/*'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-' + this.job_number
									+ '" data-job_number=' + this.job_number
			                		+ ' data-ar_name=' + this.job_number  
			                		+ ' data-business_process_sub_name=' + this.business_process_sub_name   
			                		+ ' data-target=" #askForPurposeOfBatching" data-toggle="modal" >'
			                		+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
			                		+ ' </button>',*/
				            		
			                		
							        /*'<form action="front_office_view_application" method="post">'
									+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
									+ '<input type="hidden" name="search_text" id="search_text" value="' + this.case_number + '">'
									+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
									+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'
									
									+ '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'
									
									+ '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
									+ '	</button></form>',
									*/
									'<form action="registration_application_progress_details" method="post">'
									+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
									+ '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
									+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
									+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'
									
									+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'
									
									+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
									+ '	</button></form>'
							        
							        ] ).draw( false );
								
									
							}); 
					 }
			});   	
   });
   	
   
   	

   $("#btnViewCorporateApplicationsList").click(function(event){
	//console.log("btnViewApplicationsList clicked");
			
			  //var created_by_id =localStorage.getItem("userid");
						   
			$.ajax({
				type: "POST",
				url: "Case_Management_Serv",
				data: {
					   request_type: 'load_corporate_application_batched_to_user_new'
					   },
				cache: false,
				success: function(jobdetails) {
						//console.log(jobdetails);
						/*JSON.stringify(jobdetails);*/
						var json_p = JSON.parse(jobdetails);
						datatable.clear();

						$(json_p.data).each(function() { 
							//console.log('t');
						   datatable.row.add( [
							   
							   
							   '<input type="checkbox"/>',
							   this.job_number,
							   this.ar_name,
							   this.business_process_sub_name,
							   this.current_application_status,
							   this.job_datesend,
							   this.job_forwarded_by,
							   /*'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-' + this.job_number
							   + '" data-job_number=' + this.job_number
							   + ' data-ar_name=' + this.job_number  
							   + ' data-business_process_sub_name=' + this.business_process_sub_name   
							   + ' data-target=" #askForPurposeOfBatching" data-toggle="modal" >'
							   + ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
							   + ' </button>',*/
							   
							   
							   /*'<form action="front_office_view_application" method="post">'
							   + '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
							   + '<input type="hidden" name="search_text" id="search_text" value="' + this.case_number + '">'
							   + '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
							   + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'
							   
							   + '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'
							   
							   + '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
							   + '	</button></form>',
							   */
							   '<form action="registration_application_progress_details" method="post">'
							   + '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
							   + '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
							   + '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
							   + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'
							   
							   + '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'
							   
							   + '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
							   + '	</button></form>'
							   
							   ] ).draw( false );
						   
							   
					   }); 
				}
	   });   	
});
   	//------ end of $(doc).ready
});