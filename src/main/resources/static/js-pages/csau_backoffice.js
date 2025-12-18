$(document).ready(function() {

	
	var datatable = $("#job_casemgtdetailsdataTableCSAU").DataTable( {
		stateSave: true,  "createdRow": function( row, data, dataIndex ) {
			    if ( data[1] == "1" ) {
			      $(row).addClass( 'tr-completed-work' );
			    }
			  },
	} );
	
	// $(".btnLoadUnitApplications").click(function(event){

	function LoadUnitApplications(inbox_type){
  
    	 // var inbox_type = $(this).data('id');
    	  $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'load_applications_at_unit_by_inbox_type',
	                	inbox_type: inbox_type + '_true',
				 	   },
				 
				 success: function(jobdetails) {
					 	//console.log(jobdetails);
					 	
					 	if(!jobdetails){
							return;
						}

					/*var table = $('#job_casemgtdetailsdataTable');
					table.find("tbody tr").remove();*/
				
				 
				
					// console.log(jobdetails);
					var json_p = JSON.parse(jobdetails);
					
					/*$('th:nth-child(7)').show();
					$('th:nth-child(8)').show();*/
					//datatable.column(0).data().sort();
					datatable.column(0).visible(false);	
					datatable.column(1).visible(false);	
					datatable.search("").draw();
					datatable.state.clear();
					datatable.clear();
					
					$("#body-dg-1").removeClass('bg-dark');
					  $("#number-text-1").removeClass('text-white');
					  $("#number-text-1").addClass('text-gray-800');
					  $("#body-dg-2").removeClass('bg-dark');
					  $("#number-text-2").removeClass('text-white');
					  $("#number-text-2").addClass('text-gray-800');
					  $("#body-dg-3").removeClass('bg-dark');
					  $("#number-text-3").removeClass('text-white');						 
					  $("#number-text-3").addClass('text-gray-800');
					  $("#body-dg-4").removeClass('bg-dark');
					  $("#number-text-4").removeClass('text-white');
					  $("#number-text-4").addClass('text-gray-800');
					
					
					$(json_p.data).each(function() { 
					
						datatable.row.add( [
							this.created_date,
							this.job_worked_on_status,
							
							'<input type="checkbox"/>',
							this.job_number,
							this.ar_name,
							this.business_process_sub_name,
							this.job_status,
							
							'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-' + this.job_number
							+ '" data-job_number="' + this.job_number
	                		+ '" data-ar_name="' + this.ar_name  
	                		+ '" data-business_process_sub_name="' + this.business_process_sub_name   
	                		+ '" data-target=" #askForPurposeOfBatching" data-toggle="modal" >'
	                		+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
	                		+ ' </button>',
		            		
	                		
					        '<form action="front_office_view_application" method="post">'
							+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
							+ '<input type="hidden" name="search_text" id="search_text" value="' + this.case_number + '">'
							+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
							+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'
							
							+ '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'
							
							+ '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
							+ '	</button></form>',
							
							'<button  class="btn btn-primary" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
							+ '" data-target-id=' + this.job_number
	                		
	                		+ ' <span class="icon text-white-50"> <i class="fas fa-hdd"></i></span><span class="text">Track</span>'
	                		+ ' </button>',
					        
					        ] ).draw( false );
						
							
					}); 
					
					
					
					switch(inbox_type) {
					  case 1:
						  
						  $(".btn-to-be-disabled").prop('disabled', true); 
						  
						  $("#body-dg-1").addClass('bg-dark');
						  $("#number-text-1").removeClass('text-gray-800');
						  $("#number-text-1").addClass('text-white');
						  
						  
					    break;
					  case 2:
						  
						  $(".btn-to-be-disabled").prop('disabled', false);
							
						  $("#body-dg-2").addClass('bg-dark');
						  $("#number-text-2").removeClass('text-gray-800');
						  $("#number-text-2").addClass('text-white');
						  
						 
					    break;
					  case 3:
						  $(".btn-to-be-disabled").prop('disabled', false);
							
						  $("#body-dg-3").addClass('bg-dark');
						  $("#number-text-3").removeClass('text-gray-800');
						  $("#number-text-3").addClass('text-white');
						  break;
					  case 4: 
						  $(".btn-to-be-disabled").prop('disabled', true); 
						  
						  $("#body-dg-4").addClass('bg-dark');
						  $("#number-text-4").removeClass('text-gray-800');
						  $("#number-text-4").addClass('text-white');
						  break;
					  default:
					    // code block
					}
					
					
					if(localStorage.getItem('user_level') < 2){
						//$('th:nth-child(8), th:nth-child(8)').hide();
	        			//$('.to_hide_on_level_1').hide();
						datatable.column(7).visible(false);
	        			
	     	     	}
					
					
				 }
					
			});
    	
    
          
    }; 
					/*
					 * ======================================== Actions for User
					 * Management ==================
					 */

					$('#incoming_advanced_search').on('hidden.bs.modal', function(e){
						$('#adv_inbox_type').val('')
					})
	
					$('#incoming_advanced_search').on('shown.bs.modal', function(e){

						function CallA(){

							var inbox_type = $('#adv_inbox_type').val() == '' ? '5' : $('#adv_inbox_type').val();
							//console.log(inbox_type)
							if(inbox_type == '5'){
								$('#adv_status').val('All');
								$('.exclude_all').addClass('d-none')
								//$("#adv_filter_type_1").prop("checked", true);
								document.getElementById('adv_filter_type_1').click();
							}

							$.ajax({
								type : "POST",
								url : "Case_Management_Serv",
								data : {
									request_type : 'load_sub_process_application_type_for_adv_filter',
									inbox_type : inbox_type + '_true',
								},
	
								success : function(jobdetails) {
									//console.log(jobdetails)
									if(!jobdetails){
										return;
									}
									var json_p = JSON.parse(jobdetails);
	
									var select = $("#adv_application_type");
									select.empty();
									select
											.append(new Option(
													"-- Select --",
													0));
	
									$(json_p).each(function() {
														
										select.append('<option value="'
												+ this.business_process_sub_id
												+ '">'
												+ this.business_process_sub_name
												+ '</option>');
									});
								}
	
							})

							CallB()
						}

						function CallB(){
							
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
								   
									
									   //console.log(jobdetails);
									   var json_p = JSON.parse(jobdetails);
									   var options = $("#adv_job_purpose");
		   
									   options.empty();
									   options.append(new Option("-- Select --", 0));
		
									
									   $(json_p).each(function () {
		   
											 $('#adv_job_purpose').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');
											
										  });  
									}
								});
						}

						CallA()

					})

					// $(".btnLoadUnitApplications").click(function(event) {
						
					// 	var inbox_type = $(this).data('id');
					// 	$('#adv_inbox_type').val(inbox_type);

					// 	if(inbox_type == 1){
					// 		$('#adv_status').val('Incoming Files');
					// 	} else if(inbox_type == 2) {
					// 		$('#adv_status').val('Queried');
					// 	} else if(inbox_type == 3) {
					// 		$('#adv_status').val('Completed Within Unit');
					// 	} else if(inbox_type == 4) {
					// 		$('#adv_status').val('Awaiting Payment');
					// 	}else {
					// 		$('#adv_status').val('All');
					// 	}

					// 	$("#incoming_advanced_search").modal('show');

					// 	datatable.search("")
					// 		.draw();
					// datatable.state.clear();
					// datatable.clear();
									
					// })

					$(".btnLoadUnitApplications").click(function(event) {
						
						var inbox_type = $(this).data('id');

						var inc_1 = $('#inc_1').val();
						var com_3 = $('#com_3').val();
						var que_2 = $('#que_2').val();
						var awa_4 = $('#awa_4').val();

						datatable.search("").draw();
						datatable.state.clear();
						datatable.clear();

						//console.log(inc_1, com_3, que_2, awa_4)

						switch (inbox_type) {
							case 1:
								if(inc_1 > 500) {

									$('#adv_inbox_type').val(inbox_type);

									if(inbox_type == 1){
										$('#adv_status').val('Incoming Files');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 2) {
										$('#adv_status').val('Queried');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 3) {
										$('#adv_status').val('Completed Within Unit');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 4) {
										$('#adv_status').val('Awaiting Payment');
										$('.exclude_all').removeClass('d-none');
									} else {
										$('#adv_status').val('All');
									}

									$("#incoming_advanced_search").modal('show');

									datatable.search("").draw();
									datatable.state.clear();
									datatable.clear();

									return;

								} else {

									LoadUnitApplications(inbox_type)
								}

							case 3:
								if(com_3 > 500) {

									$('#adv_inbox_type').val(inbox_type);

									if(inbox_type == 1){
										$('#adv_status').val('Incoming Files');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 2) {
										$('#adv_status').val('Queried');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 3) {
										$('#adv_status').val('Completed Within Unit');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 4) {
										$('#adv_status').val('Awaiting Payment');
										$('.exclude_all').removeClass('d-none');
									} else {
										$('#adv_status').val('All');
									}

									$("#incoming_advanced_search").modal('show');

									return;

								} else {

									LoadUnitApplications(inbox_type)
								}

							case 2:
								if(que_2 > 500) {

									$('#adv_inbox_type').val(inbox_type);

									if(inbox_type == 1){
										$('#adv_status').val('Incoming Files');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 2) {
										$('#adv_status').val('Queried');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 3) {
										$('#adv_status').val('Completed Within Unit');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 4) {
										$('#adv_status').val('Awaiting Payment');
										$('.exclude_all').removeClass('d-none');
									} else {
										$('#adv_status').val('All');
									}

									$("#incoming_advanced_search").modal('show');

									return;

								} else {

									LoadUnitApplications(inbox_type)
								}

							case 4:
								if(awa_4 > 500) {

									$('#adv_inbox_type').val(inbox_type);

									if(inbox_type == 1){
										$('#adv_status').val('Incoming Files');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 2) {
										$('#adv_status').val('Queried');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 3) {
										$('#adv_status').val('Completed Within Unit');
										$('.exclude_all').removeClass('d-none');
									} else if(inbox_type == 4) {
										$('#adv_status').val('Awaiting Payment');
										$('.exclude_all').removeClass('d-none');
									} else {
										$('#adv_status').val('All');
									}

									$("#incoming_advanced_search").modal('show');

									return;

								} else {

									LoadUnitApplications(inbox_type)
								}
						}
		
					})

					$('.exclude_job_search').addClass('d-none');
					//$('.include_job_search').removeClass('d-none');

					$('input[name="adv_search_type"]').on('click', function() {
						

						var adv_search_type = $('input[name="adv_search_type"]:checked').val();
						//console.log(adv_search_type)

						if(adv_search_type == 'f_job_number') {
							$('.exclude_job_search').addClass('d-none');
							$('.include_job_search').removeClass('d-none');
						} else if(adv_search_type == 'f_app_type') {
							$('.exclude_app_type').addClass('d-none');
							$('.include_app_type').removeClass('d-none');
						} else if(adv_search_type == 'f_job_purpose') {
							$('.exclude_job_purpose').addClass('d-none');
							$('.include_job_purpose').removeClass('d-none');
						} else if(adv_search_type == 'f_date_range') {
							$('.exclude_date_range').addClass('d-none');
							$('.include_date_range').removeClass('d-none');
						} else if(adv_search_type == 'f_limit') {
							$('.exclude_limit').addClass('d-none');
							$('.include_limit').removeClass('d-none');
						}
					});
				

					$('#btn_load_adv_filter').on('click', function(e) {

						var adv_search_type = $('input[name="adv_search_type"]:checked').val();
						var inbox_type = $('#adv_inbox_type').val();
						//var adv_filter;
						//console.log(inbox_type)

						var adv_job_number = $('#adv_job_number').val()
						var adv_application_type = $('#adv_application_type').val()
						var adv_limit = $('#adv_limit').val()
						var adv_from_date = $('#adv_from_date').val()
						var adv_to_date = $('#adv_to_date').val()
						var enq_search_type = "job_number";
						var adv_job_purpose = $('#adv_job_purpose').val()
						var adv_sorting = $('#adv_sorting').val()

						if(adv_search_type == 'f_job_number') {

							inbox_type = '0';

							if(!adv_job_number) {
								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter a job number</span>',
								}, { type : 'danger' , z_index: 9999  });

								alert('Please enter a job number');

								return;
							}
						} else if(adv_search_type == 'f_app_type') {
							console.log(adv_application_type,adv_limit,adv_sorting )
							if(adv_application_type == 0 || !adv_limit || !adv_sorting) {
								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required with the exception of job purpose</span>',
								}, { type : 'danger' , z_index: 9999  });

								alert('Please all the field are required with the exception of job purpose');

								return;
							}
							
						} else if(adv_search_type == 'f_job_purpose') {

							if(adv_job_purpose == '0' || !adv_limit) {
								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
								}, { type : 'danger' , z_index: 9999  });

								alert('Please all the field are required');

								return;
							}
							
						} else if(adv_search_type == 'f_date_range') {
							if(!adv_from_date || !adv_limit || !adv_to_date) {
								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
								}, { type : 'danger' , z_index: 9999  });

								alert('Please all the field are required');

								return;
							}
						} else if(adv_search_type == 'f_limit') {
							if(!adv_limit || !adv_sorting) {
								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
								}, { type : 'danger' , z_index: 9999  });

								alert('Please all the field are required');

								return;
							}
						}

						$.ajax({
							type : "POST",
							url : "Case_Management_Serv",
							data : {
								request_type : 'load_incoming_app_for_unit_using_adv_filter',
								//adv_filter : adv_filter,
								adv_job_number: adv_job_number,
								adv_application_type: adv_application_type,
								adv_from_date: adv_from_date == '' ? '12-12-2000' : adv_from_date,
								adv_to_date: adv_to_date == '' ? '12-12-2000' : adv_to_date,
								adv_limit: adv_limit == '' ? 0 : adv_limit,
								enq_search_type: enq_search_type,
								inbox_type: inbox_type + '_true',
								adv_job_purpose : adv_job_purpose,
								adv_sorting : adv_sorting,
								adv_search_type : adv_search_type
							},

							success: function(jobdetails) {
								//console.log(jobdetails);
								
								if(!jobdetails){
									return;
								}
	   
						   /*var table = $('#job_casemgtdetailsdataTable');
						   table.find("tbody tr").remove();*/
					   
						
					   
						   // console.log(jobdetails);
						   var json_p = JSON.parse(jobdetails);
						   
						   /*$('th:nth-child(7)').show();
						   $('th:nth-child(8)').show();*/
						   //datatable.column(0).data().sort();
						   datatable.column(0).visible(false);	
						   datatable.column(1).visible(false);	
						   datatable.search("").draw();
						   datatable.state.clear();
						   datatable.clear();
						   
						   $("#body-dg-1").removeClass('bg-dark');
							 $("#number-text-1").removeClass('text-white');
							 $("#number-text-1").addClass('text-gray-800');
							 $("#body-dg-2").removeClass('bg-dark');
							 $("#number-text-2").removeClass('text-white');
							 $("#number-text-2").addClass('text-gray-800');
							 $("#body-dg-3").removeClass('bg-dark');
							 $("#number-text-3").removeClass('text-white');						 
							 $("#number-text-3").addClass('text-gray-800');
							 $("#body-dg-4").removeClass('bg-dark');
							 $("#number-text-4").removeClass('text-white');
							 $("#number-text-4").addClass('text-gray-800');
						   
						   
						   $(json_p.data).each(function() { 
						   
							   datatable.row.add( [
								   this.created_date,
								   this.job_worked_on_status,
								   
								   '<input type="checkbox"/>',
								   this.job_number,
								   this.ar_name,
								   this.business_process_sub_name,
								   this.job_status,
								   
								   '<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-' + this.job_number
								   + '" data-job_number="' + this.job_number
								   + '" data-ar_name="' + this.ar_name  
								   + '" data-business_process_sub_name="' + this.business_process_sub_name   
								   + '" data-target=" #askForPurposeOfBatching" data-toggle="modal" >'
								   + ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
								   + ' </button>',
								   
								   
								   '<form action="front_office_view_application" method="post">'
								   + '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
								   + '<input type="hidden" name="search_text" id="search_text" value="' + this.case_number + '">'
								   + '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
								   + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'
								   
								   + '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'
								   
								   + '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
								   + '	</button></form>',
								   
								   '<button  class="btn btn-primary" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
								   + '" data-target-id=' + this.job_number
								   
								   + ' <span class="icon text-white-50"> <i class="fas fa-hdd"></i></span><span class="text">Track</span>'
								   + ' </button>',
								   
								   ] ).draw( false );
							   
								   
						   }); 
						   
						   
						   
						   switch(inbox_type) {
							 case 1:
								 
								 $(".btn-to-be-disabled").prop('disabled', true); 
								 
								 $("#body-dg-1").addClass('bg-dark');
								 $("#number-text-1").removeClass('text-gray-800');
								 $("#number-text-1").addClass('text-white');
								 
								 
							   break;
							 case 2:
								 
								 $(".btn-to-be-disabled").prop('disabled', false);
								   
								 $("#body-dg-2").addClass('bg-dark');
								 $("#number-text-2").removeClass('text-gray-800');
								 $("#number-text-2").addClass('text-white');
								 
								
							   break;
							 case 3:
								 $(".btn-to-be-disabled").prop('disabled', false);
								   
								 $("#body-dg-3").addClass('bg-dark');
								 $("#number-text-3").removeClass('text-gray-800');
								 $("#number-text-3").addClass('text-white');
								 break;
							 case 4: 
								 $(".btn-to-be-disabled").prop('disabled', true); 
								 
								 $("#body-dg-4").addClass('bg-dark');
								 $("#number-text-4").removeClass('text-gray-800');
								 $("#number-text-4").addClass('text-white');
								 break;
							 default:
							   // code block
						   }
						   
						   
						   if(localStorage.getItem('user_level') < 2){
							   //$('th:nth-child(8), th:nth-child(8)').hide();
							   //$('.to_hide_on_level_1').hide();
							   datatable.column(7).visible(false);
							   
							 }
						   
						   
						}

						})
					})

					// $('#btn_load_adv_filter').on('click', function(e) {

					// 	var adv_filter;

					// 	var adv_job_number = $('#adv_job_number').val()
					// 	var adv_application_type = $('#adv_application_type').val()
					// 	var adv_limit = $('#adv_limit').val()
					// 	var adv_from_date = $('#adv_from_date').val()
					// 	var adv_to_date = $('#adv_to_date').val()
					// 	var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					// 	var enq_search_type = "";

					// 	var inbox_type = $(this).data('id');

					// 	if(adv_job_number != ""){
					// 		//$('#adv_job_number').css('border-color', 'green');
					// 		if (selected_rbtn.length > 0) {
					// 			enq_search_type = selected_rbtn.val();
					// 			//console.log("selected " + enq_search_type);
					// 		}

					// 		if (enq_search_type.length <= 0){
					// 			$.notify({
					// 				message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
					// 			}, { type : 'danger' , z_index: 9999  });

					// 			alert('Please select the type of field for your search');

					// 			return;
								
					// 		}

					// 		adv_limit = 1000;
					// 	}

					// 	if(!adv_limit){
					// 		$.notify({
					// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter the limit.</span>',
					// 		}, { type : 'danger' , z_index: 9999  });

					// 		alert('Please enter the limit.');

					// 		return;
							
					// 	}

					// 	// if(adv_job_number || adv_application_type == "0" || !adv_from_date || !adv_to_date) {
					// 	// 	adv_filter = "adv_filter_1"
						
					// 	// } else if(!adv_job_number || adv_application_type == "0" || !adv_from_date || !adv_to_date){
					// 	// 	adv_filter = "adv_filter_2"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}

					// 	// } else if(!adv_job_number || adv_application_type != "0" || adv_from_date || adv_to_date){
					// 	// 	adv_filter = "adv_filter_5"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}

					// 	// } else if(!adv_job_number || adv_application_type != "0" || !adv_from_date || !adv_to_date){
					// 	// 	adv_filter = "adv_filter_6"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}
					// 	// } else if(!adv_job_number || adv_application_type != "0" || adv_from_date || adv_to_date){
					// 	// 	adv_filter = "adv_filter_7"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}
					// 	// }

					// 	if(adv_application_type != "0" || !adv_from_date || !adv_to_date){
					// 		adv_filter = "adv_filter_6"

					// 		if(adv_limit > 1000){
					// 			$.notify({
					// 				message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 			}, { type : 'danger' , z_index: 9999  });

					// 			alert('Limit should not be more than 1000.');
	
					// 			return;
					// 		}
					// 	} else if(adv_application_type == "0" || !adv_from_date || !adv_to_date){
					// 		adv_filter = "adv_filter_6"

					// 		if(adv_limit > 1000){
					// 			$.notify({
					// 				message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 			}, { type : 'danger' , z_index: 9999  });

					// 			alert('Limit should not be more than 1000.');
	
					// 			return;
					// 		}
					// 	}

					// 	//console.log(adv_filter, adv_job_number, adv_application_type, adv_from_date, adv_to_date,adv_limit );

					// 	$.ajax({
					// 		type : "POST",
					// 		url : "Case_Management_Serv",
					// 		data : {
					// 			request_type : 'load_incoming_app_for_unit_using_adv_filter',
					// 			adv_filter : adv_filter,
					// 			adv_job_number: adv_job_number,
					// 			adv_application_type: adv_application_type,
					// 			adv_from_date: adv_from_date == '' ? '12-12-2000' : adv_from_date,
					// 			adv_to_date: adv_to_date == '' ? '12-12-2000' : adv_to_date,
					// 			adv_limit: adv_limit,
					// 			enq_search_type: enq_search_type,
					// 			inbox_type: inbox_type + '_false',
					// 		},

					// 		success : function(
					// 			jobdetails) {
							
					// 		// console.log(jobdetails);
					// 		var json_p = JSON
					// 				.parse(jobdetails);


					// 		/*
					// 		 * $('th:nth-child(7)').show();
					// 		 * $('th:nth-child(8)').show();
					// 		 */

					// 		datatable.column(0)
					// 				.visible(false);
					// 		// datatable.column(1).visible(false);

							
					// 		datatable.column(0).visible(false);
					// 		//datatable.column(1).visible(false);

					// 		datatable.search("")
					// 				.draw();
					// 		datatable.state.clear();
					// 		datatable.clear();

					// 		$("#body-dg-1")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-1")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-1")
					// 				.addClass(
					// 						'text-gray-800');
					// 		$("#body-dg-2")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-2")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-2")
					// 				.addClass(
					// 						'text-gray-800');
					// 		$("#body-dg-3")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-3")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-3")
					// 				.addClass(
					// 						'text-gray-800');
					// 		$("#body-dg-4")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-4")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-4")
					// 				.addClass(
					// 						'text-gray-800');

					// 		$(json_p.data)
					// 				.each(
					// 						function() {

					// 							datatable.row
					// 									.add([

					// 										this.job_worked_on_status,

					// 										'<input type="checkbox"/>',
					// 										this.created_date,
					// 										this.job_number,
					// 										this.ar_name,
					// 										this.business_process_sub_name,
					// 										this.job_status,
					// 										this.job_forwarded_by,
					// 										this.locality,
					// 										this.smd_type_of_plotting,

					// 										'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
					// 												+ this.job_number
					// 												+ '" data-job_number="'
					// 												+ this.job_number
					// 												+ '" data-ar_name="'
					// 												+ this.ar_name
					// 												+ '" data-business_process_sub_name="'
					// 												+ this.business_process_sub_name
					// 												+ '" data-application_stage="'
					// 												+ this.application_stage
					// 												+ '" data-application_stage_name="'
					// 												+ this.application_stage_name
					// 												+ '" data-application_stage_baby_step="'
					// 												+ this.application_stage_baby_step
					// 												+ '" data-application_stage_name_baby_step="'
					// 												+ this.application_stage_name_baby_step
					// 												+ '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
					// 												+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
					// 												+ ' </button>',

					// 										'<form action="front_office_view_application" method="post">'
					// 												+ '<input type="hidden" name="case_number" id="case_number" value="'
					// 												+ this.transaction_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="search_text" id="search_text" value="'
					// 												+ this.case_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="job_number" id="job_number" value="'
					// 												+ this.job_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
					// 												+ this.business_process_sub_name
					// 												+ '">'

					// 												+ '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'

					// 												+ '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
					// 												+ '	</button></form>',

					// 												'<form action="registration_application_progress_details" method="post">'
					// 												+ '<input type="hidden" name="case_number" id="case_number" value="'
					// 												+ this.transaction_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="transaction_number" id="transaction_number" value="'
					// 												+ this.transaction_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="job_number" id="job_number" value="'
					// 												+ this.job_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
					// 												+ this.business_process_sub_name
					// 												+ '">'

					// 												+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

					// 												+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
					// 												+ '	</button></form>'

					// 											])
					// 									.draw(
					// 											false);
					// 							datatable
					// 									.column(
					// 											2)
					// 									.data()
					// 									.sort();

					// 						});

					// 		switch (inbox_type) {
					// 		case 1:

					// 			$(".btn-to-be-disabled").prop('disabled',true);
					// 			//datatable.column(11).visible(true);

					// 			$("#body-dg-1")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-1")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-1")
					// 					.addClass(
					// 							'text-white');

					// 			break;
					// 		case 2:

					// 			$(
					// 					".btn-to-be-disabled")
					// 					.prop(
					// 							'disabled',
					// 							false);

					// 			$("#body-dg-2")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-2")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-2")
					// 					.addClass(
					// 							'text-white');
					// 			//datatable.column(11).visible(true);

					// 			break;
					// 		case 3:
					// 			$(
					// 					".btn-to-be-disabled")
					// 					.prop(
					// 							'disabled',
					// 							false);

					// 			$("#body-dg-3")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-3")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-3")
					// 					.addClass(
					// 							'text-white');
					// 			//datatable.column(11).visible(true);
					// 			break;
					// 		case 4:
					// 			$(
					// 					".btn-to-be-disabled")
					// 					.prop(
					// 							'disabled',
					// 							true);
					// 			// datatable
					// 			// 		.column(11)
					// 			// 		.visible(
					// 			// 				false);

					// 			$("#body-dg-4")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-4")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-4")
					// 					.addClass(
					// 							'text-white');
					// 			break;
					// 		default:
					// 			// code block
					// 		}

					// 		if (localStorage
					// 				.getItem('user_level') < 2) {
					// 			// $('th:nth-child(8),
					// 			// th:nth-child(8)').hide();
					// 			// $('.to_hide_on_level_1').hide();
					// 			// datatable
					// 			// 		.column(11)
					// 			// 		.visible(
					// 			// 				false);

					// 		}

					// 	}

					// 	})
					// })
	 

				});