$(document)
		.ready(
				function() {

					var datatable = $("#job_casemgtdetailsdataTable")
							.DataTable({
								// responsive: true,

								stateSave : true,
								"createdRow" : function(row, data, dataIndex) {
									// if (data[0] == "1") {
									// 	$(row).addClass('tr-completed-work');
									// }
									if(data[7] == 'Approved'){
										$(row).addClass('bg-success text-white');
									  }
									
								},

							/*
							 * columns: [ { // Responsive control column data:
							 * null, defaultContent: '', className: 'control',
							 * orderable: false },
							 *  ],
							 */
							});

					$('#frmFileJobSearch')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('how are your search');

										var enq_search_value = $(
												"#file_search_value").val();
										console.log('Search Value: '
												+ enq_search_value);

										if (!(enq_search_value.length >= 4)) {
											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 4 or more characters to search </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										} else {

											

											$.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_by_job_number',
															job_number : enq_search_value
														},
														cache : false,
														
														success : function(
																jobdetails) {

														

															var table = $('#file-search-results-table');
															table.find(
																	"tbody tr")
																	.remove();

															//console.log(jobdetails);
															var json_p = JSON
																	.parse(jobdetails);
															
															if(result.job_detail !==null){
																table.append("<tr><td>" 
																		+ json_p.transaction_details.ar_name
																		+ "</td><td>"
																		+  json_p.transaction_details.case_number
																		+ "</td><td>"
																		+ json_p.job_detail.job_number
																		+ "</td><td>"
																		+ json_p.job_detail.business_process_sub_name
																		+ "</td><td>"
																		+ json_p.parcel_details.locality
																		+ "</td>"

																		+ '<td> <button class="btn btn-info" id="btnAddFile"'
																		+ ' data-job_number="'
																		+ json_p.job_detail.job_number
																		+ '" onclick = "addFileToList(\''+ json_p.job_detail.job_number +'\',\'' + json_p.transaction_details.ar_name + '\',\'' + json_p. job_detail.business_process_sub_name + '\',\''  + json_p.parcel_details.locality+'\')">+ Add </button>  '
																		
																		+ '</td></tr>'
																
																
																
																)
															}

														

														}
													});
										}
									});

				
					
					$('#frmEnquiryBatchlist').on('submit',function(e) {

								// validation code here
								e.preventDefault();
								// console.log('how are your search');

								var enq_batchlist_val = $("#enq_batchlist").val();
								//console.log('Search Value: ' + enq_batchlist_val);

								if (!(enq_batchlist_val.length >= 4)) {
									$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 6 or more characters to search </span>',
									}, {type : 'danger' , z_index: 9999 });
								} else {

									
									

									$.ajax({
										type : "POST",
										url : "Case_Management_Serv",
										data : {
											request_type : 'load_applications_by_batchlist',
											job_number : enq_batchlist_val
										},
										cache : false,
										beforeSend : function() {
											
										},
										success : function(jobdetails) {
											try {
												var table = $('#tbl_batchlist_history');
												table.find("tbody tr").remove();

												//console.log(jobdetails);
												
												var json_p = JSON.parse(jobdetails);

												$(json_p).each(function() {

													table.append("<tr><td>" + this.ar_name
																+ "</td><td>" + this.job_number
																+ "</td><td>" + this.job_purpose
																+ "</td><td>" + this.sender_name
																+ "</td><td>" + this.receiver_name
																+ "</td><td>" + this.date_created
																+ "</td>"
																+ '</tr>');

													});
												
												$("#enq-search-results-section").hide();
												$("#batchlist_value").empty();
												$("#batchlist_value").append(enq_batchlist_val);
												$("#BachlistModal").modal("show");
												}
												catch(err) {
												 console.log(err.message);
												}
										}

									});

												
											
								}
							});
					
					
					$("#btn_process_file_list").click(function(event){
					   	 
				   	  	//alert(JSON.stringify(table)); 
						let request_type ="";
						var list_of_application_new = JSON.stringify(table)
						if($('#batch_type').val()==='Unit'){
							request_type = 'process_file_list';
							var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
					   	 	var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
					   		var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');
							
					    }else{
					    	request_type = 'process_file_list';
					    	var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
					   	 	var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
					   		var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');
							
					    }
							
						var table = storeTblValues();
						list_of_application_new = JSON.stringify(table);
						//console.log(list_of_application_new);
							
							
							
						console.log("request_type: " + request_type);
				        console.log("userid_1 " + userid_1);
				        console.log("sender " + send_to_name);
				        console.log("sender " + send_to_id);


						function storeTblValues()
						{
						    var TableData = new Array();

						    $('#FileListdataTable tr').each(function(row, tr){
						        TableData[row]={
						            "job_number" : $(tr).find('td:eq(0)').text().trim() ,
						            "ar_name" : $(tr).find('td:eq(1)').text().trim(),
						            "locality" : $(tr).find('td:eq(3)').text().trim(),
						            "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim()
						            
						        }    
						    }); 
						    TableData.shift();  // first row will be empty - so remove
						    return TableData;
						}
				    	 
				    	 $.ajax({
							 type: "POST",
							 url: "Case_Management_Serv",
							 data: {
				                	request_type: request_type,
				                	division: localStorage.getItem('division'),
				                  	list_of_application:list_of_application_new,
				                  	send_to_name : send_to_name,
						            send_to_id : send_to_id
				                  	},
							 cache: false,
							
							 success: function(response) {
								    console.log(response)
								    
								  var json_p = JSON.parse(response);
								 
								   /* $('#request_type').val('request_to_generate_batch_list');
								    $('#list_of_application').val(list_of_application_new);
								    $('#batch_number').val(json_p.batch_number);
								   
								    $('#modified_by').val(  $( "#user_to_send_to" ).val());
								    //var userid_1 = $( "#user_to_send_to" ).val(); 
								    
								  //  $('#modified_by').val(localStorage.getItem('fullname'));
								    $('#modified_by_id').val( localStorage.getItem('userid'));
								    // $('#downloadForm').submit();
*/								    
										 $.ajax({
												 type: "POST",
												 url: "GenerateCaseReports",
												 target : '_blank',
												 data: {
													 request_type: 'request_to_generate_file_list',
						           					  list_of_application: list_of_application_new,
						           					  batch_number: json_p.batch_number,
						           					  modified_by : localStorage.getItem('fullname'),
						           					  modified_by_id : localStorage.getItem('userid'),
						           					send_to_name: send_to_name,
				                                    send_to_id: send_to_id
									                  	},
												 cache: false,
												 xhrFields : {
														responseType : 'blob'
													},
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													//console.log("before ajax");
													
													
													
													
												 },
												 success: function(data) {
													 console.log(data)
													
													
														$('#elisDocumentPreview').modal({
							     	    	 			 backdrop: 'static',
							     	    				});
													 
													 
													 var blob = new Blob(
																[ data ],
																{
																	type : "application/pdf"
																});
													var objectUrl = URL
																.createObjectURL(blob);
														// window.open(objectUrl);
														console.log("success ajax");

				 	    							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
														
														
														
												      
												 },
												 complete: function(){
													 console.log("Completed ajax");
													 $('#viewBatchlistModal').modal('hide');
													 console.log("Completed 3 ajax");
				 	    							 //Clear Local storage Bactlist
				 	    				       		localStorage.setItem('batchlistdata', '');
				 	    				       		//prepareBatchlistModal();
				 	    				       		
				 	    				       	   
												   }
												 });  
						
							      
							 }
							 }); 
				 		
				 	});
					
					 $('#btnViewFilesList').on('click', function(e) {
				 	        
				 	  		//console.log('View batchlist');
				 	  		
						 prepareFileBatchingModal();
				 	    		
				 	     });


						  $("#btn_process_file_movement_list").click(function(event){
					   	 
							//alert(JSON.stringify(table)); 
					   let request_type ="";
					   var list_of_application_new = JSON.stringify(table)
					   if($('#batch_type').val()==='Unit'){
						   request_type = 'process_file_movement_list';
						   var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a unit to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#btn_process_file_movement_list").removeClass('d-none')
								}
							  })
						   
					   }else{
						   request_type = 'process_file_movement_list';
						   var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a user to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#btn_process_file_movement_list").removeClass('d-none')
								}
							  })
						   
					   }
						   
					   var table = storeTblValues();
					   list_of_application_new = JSON.stringify(table);
					   //console.log(list_of_application_new);
						   
						   
						   
					   console.log("request_type: " + request_type);
					   console.log("userid_1 " + userid_1);
					   console.log("sender " + send_to_name);
					   console.log("sender " + send_to_id);


					   function storeTblValues()
					   {
						   var TableData = new Array();

						   $('#FileListdataTable tr').each(function(row, tr){
							   TableData[row]={
								   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
								   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
								   "locality" : $(tr).find('td:eq(3)').text().trim(),
								   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim()
								   
							   }    
						   }); 
						   TableData.shift();  // first row will be empty - so remove
						   return TableData;
					   }
						
						$.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							data: {
								   request_type: request_type,
								   division: localStorage.getItem('division'),
									 list_of_application:list_of_application_new,
									 send_to_name : send_to_name,
								   send_to_id : send_to_id
									 },
							cache: false,
						   
							success: function(response) {
								   console.log(response)
								   
								 var json_p = JSON.parse(response);
								
								  /* $('#request_type').val('request_to_generate_batch_list');
								   $('#list_of_application').val(list_of_application_new);
								   $('#batch_number').val(json_p.batch_number);
								  
								   $('#modified_by').val(  $( "#user_to_send_to" ).val());
								   //var userid_1 = $( "#user_to_send_to" ).val(); 
								   
								 //  $('#modified_by').val(localStorage.getItem('fullname'));
								   $('#modified_by_id').val( localStorage.getItem('userid'));
								   // $('#downloadForm').submit();
*/								    
										$.ajax({
												type: "POST",
												url: "GenerateCaseReports",
												target : '_blank',
												data: {
													request_type: 'request_to_generate_file_list',
														list_of_application: list_of_application_new,
														batch_number: json_p.batch_number,
														modified_by : localStorage.getItem('fullname'),
														modified_by_id : localStorage.getItem('userid'),
													  send_to_name: send_to_name,
												   send_to_id: send_to_id
														 },
												cache: false,
												xhrFields : {
													   responseType : 'blob'
												   },
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												   //console.log("before ajax");
												   
												   
												   
												   
												},
												success: function(data) {
													console.log(data)
												   
												   
													   $('#elisDocumentPreview').modal({
														  backdrop: 'static',
														});
													
													
													var blob = new Blob(
															   [ data ],
															   {
																   type : "application/pdf"
															   });
												   var objectUrl = URL
															   .createObjectURL(blob);
													   // window.open(objectUrl);
													   console.log("success ajax");

													$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
													   
													   
													   
													 
												},
												complete: function(){
													console.log("Completed ajax");
													$('#viewBatchlistModal').modal('hide');
													console.log("Completed 3 ajax");
													 //Clear Local storage Bactlist
													   localStorage.setItem('batchlistdata', '');
													   //prepareBatchlistModal();
													   
													  
												  }
												});  
					   
								 
							}
							}); 
						
					});

					

					
					$('#frmRequestJobSearch')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('how are your search');

										var enq_search_value = $(
												"#file_search_value").val();
										console.log('Search Value: '
												+ enq_search_value);

										if (!(enq_search_value.length >= 4)) {
											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 4 or more characters to search </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										} else {

											

											$.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_by_job_number',
															job_number : enq_search_value
														},
														cache : false,
														
														success : function(
																jobdetails) {

														

															var table = $('#file-search-results-table');
															table.find(
																	"tbody tr")
																	.remove();

															//console.log(jobdetails);
															var json_p = JSON
																	.parse(jobdetails);
															
															if(result.job_detail !==null){
																table.append("<tr><td>" 
																		+ json_p.transaction_details.ar_name
																		+ "</td><td>"
																		+  json_p.transaction_details.case_number
																		+ "</td><td>"
																		+ json_p.job_detail.job_number
																		+ "</td><td>"
																		+ json_p.job_detail.business_process_sub_name
																		+ "</td><td>"
																		+ json_p.parcel_details.locality
																		+ "</td>"

																		+ '<td> <button class="btn btn-info" data-toggle="modal" data-target="#askForPurposeOfSendingRequest" id="btnAddRequest"'
																		+ ' data-job_number="'+ json_p.job_detail.job_number+'" data-bs-desc="openall" data-ar_name="'+json_p.transaction_details.ar_name+'" data-business_process_sub_name="'+json_p.job_detail.business_process_sub_name+'" data-locality="'+json_p.parcel_details.locality+'"> Add </button>  '
																		+ '<button class="btn btn-danger" data-toggle="modal" data-target="#checkAppdetailsforRequest"'
																		+ ' data-job_number="'+ json_p.job_detail.job_number+'" data-transaction_number="'+json_p.transaction_details.transaction_number+'"> Details </button>  '
																		+ '</td></tr>'
																
																
																
																)
															}

														

														}
													});
										}
									});

									$('#btnViewRequestsList').on('click', function(e) {
				 	        
										//console.log('View batchlist');
										
										prepareRequestBatchingModal();
										  
								   });


								   $('#btnAddRequest').on('click', function(e) {
				 	        //console.log('jksnfjvnwjsk')
									return;
									  
							   });



							   $("#btn_process_request_list").click(function(event){
					   	 
								//alert(JSON.stringify(table)); 
						   let request_type ="";
						   var list_of_application_new = JSON.stringify(table)
						   if($('#batch_type').val()==='Unit'){
							   request_type = 'process_request_list';
							   var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
								   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
								  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');
	
								  if(!userid_1 || !send_to_id || !send_to_name) {
	
									alert('Please select a unit to send to');
	
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
									}, { type : 'danger' , z_index: 9999  });
	
									return;
	
								  }
	
								  $("#unit_to_send_to").on('input', function(){
									var userid_1 = $(this).val();  // $( "#user_to_send_to option
									if(userid_1){
										$("#btn_process_request_list").removeClass('d-none')
									}
								  })
							   
						   }else{
							   request_type = 'process_request_list';
							   var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
								   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
								  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');
	
								  if(!userid_1 || !send_to_id || !send_to_name) {
	
									alert('Please select a user to send to');
	
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
									}, { type : 'danger' , z_index: 9999  });
	
									return;
	
								  }
	
								  $("#unit_to_send_to").on('input', function(){
									var userid_1 = $(this).val();  // $( "#user_to_send_to option
									if(userid_1){
										$("#btn_process_request_list").removeClass('d-none')
									}
								  })
							   
						   }
							   
						   var table = storeTblValues();
						   list_of_application_new = JSON.stringify(table);
						   //console.log(list_of_application_new);
							   
							   
							   
						   console.log("request_type: " + request_type);
						   console.log("userid_1 " + userid_1);
						   console.log("sender " + send_to_name);
						   console.log("sender " + send_to_id);
	
	
						   function storeTblValues()
						   {
							   var TableData = new Array();
	
							   $('#FileListdataTable tr').each(function(row, tr){
								   TableData[row]={
									   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
									   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
									   "locality" : $(tr).find('td:eq(3)').text().trim(),
									   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
									   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
									   "remarks" : $(tr).find('td:eq(5)').text().trim()
									   
								   }    
							   }); 
							   TableData.shift();  // first row will be empty - so remove
							   return TableData;
						   }
							
							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									   request_type: request_type,
									   division: localStorage.getItem('division'),
										 list_of_application:list_of_application_new,
										 send_to_name : send_to_name,
									   send_to_id : send_to_id,
									   batch_type: $('#batch_type').val()
										 },
								cache: false,
							   
								success: function(response) {
									 //  console.log(response)
									   
									 var json_p = JSON.parse(response);
									
											$.ajax({
													type: "POST",
													url: "GenerateCaseReports",
													target : '_blank',
													data: {
														request_type: 'request_to_generate_request_list',
															list_of_application: list_of_application_new,
															batch_number: json_p.batch_number,
															modified_by : localStorage.getItem('fullname'),
															modified_by_id : localStorage.getItem('userid'),
														  send_to_name: send_to_name,
													   send_to_id: send_to_id,
															 },
													cache: false,
													xhrFields : {
														   responseType : 'blob'
													   },
													beforeSend: function () {
													   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													   //console.log("before ajax");
													   
													   
													   
													   
													},
													success: function(data) {
														console.log(data)
													   
													   
														   $('#elisDocumentPreview').modal({
															  backdrop: 'static',
															});
														
														
														var blob = new Blob(
																   [ data ],
																   {
																	   type : "application/pdf"
																   });
													   var objectUrl = URL
																   .createObjectURL(blob);
														   // window.open(objectUrl);
														   console.log("success ajax");
	
														$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
														   
														   
														   
														 
													},
													complete: function(){
														console.log("Completed ajax");
														$('#viewFileListModal').modal('hide');
														console.log("Completed 3 ajax");
														 //Clear Local storage Bactlist
														   localStorage.setItem('requestBatchingListData', '');
														   //prepareBatchlistModal();
														   
														  
													  }
													});  
						   
									 
								}
								}); 
							
						});

						

						$("#apbtn_process_request_list").click(function(event){
					   	 
							//alert(JSON.stringify(table)); 
					   let request_type ="";
					   var list_of_application_new = JSON.stringify(table)
					   if($('#batch_type').val()==='Unit'){
						   request_type = 'process_request_list';
						   var userid_1 = $("#rs_unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a unit to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#rs_unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#apbtn_process_request_list").removeClass('d-none')
								}
							  })
						   
					   }else{
						   request_type = 'process_request_list';
						   var userid_1 = $("#rs_user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a user to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#rs_unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#apbtn_process_request_list").removeClass('d-none')
								}
							  })
						   
					   }
						   
					   var table = storeTblValues();
					   list_of_application_new = JSON.stringify(table);
					   //console.log(list_of_application_new);
						   
						   
						   
					   console.log("request_type: " + request_type);
					   console.log("userid_1 " + userid_1);
					   console.log("sender " + send_to_name);
					   console.log("sender " + send_to_id);


					   function storeTblValues()
					   {
						   var TableData = new Array();

						   $('#FileListdataTable tr').each(function(row, tr){
							   TableData[row]={
								   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
								   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
								   "locality" : $(tr).find('td:eq(3)').text().trim(),
								   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
								   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
								   "remarks" : $(tr).find('td:eq(5)').text().trim()
								   
							   }    
						   }); 
						   TableData.shift();  // first row will be empty - so remove
						   return TableData;
					   }
						
						$.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							data: {
								   request_type: request_type,
								   division: localStorage.getItem('division'),
									 list_of_application:list_of_application_new,
									 send_to_name : send_to_name,
								   send_to_id : send_to_id,
								   batch_type: $('#batch_type').val()
									 },
							cache: false,
						   
							success: function(response) {
								 //  console.log(response)
								   
								 var json_p = JSON.parse(response);
								
										$.ajax({
												type: "POST",
												url: "GenerateCaseReports",
												target : '_blank',
												data: {
													request_type: 'request_to_generate_request_list',
														list_of_application: list_of_application_new,
														batch_number: json_p.batch_number,
														modified_by : localStorage.getItem('fullname'),
														modified_by_id : localStorage.getItem('userid'),
													  send_to_name: send_to_name,
												   send_to_id: send_to_id,
														 },
												cache: false,
												xhrFields : {
													   responseType : 'blob'
												   },
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												   //console.log("before ajax");
												   
												   
												   
												   
												},
												success: function(data) {
													console.log(data)
												   
												   
													   $('#elisDocumentPreview').modal({
														  backdrop: 'static',
														});
													
													
													var blob = new Blob(
															   [ data ],
															   {
																   type : "application/pdf"
															   });
												   var objectUrl = URL
															   .createObjectURL(blob);
													   // window.open(objectUrl);
													   console.log("success ajax");

													$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
													   
													   
													   
													 
												},
												complete: function(){
													console.log("Completed ajax");
													$('#viewFileListModal').modal('hide');
													console.log("Completed 3 ajax");
													 //Clear Local storage Bactlist
													   localStorage.setItem('requestBatchingListData', '');
													   //prepareBatchlistModal();
													   
													  
												  }
												});  
					   
								 
							}
							}); 
						
					});


						$(".btnLoadUnitApplications")
						.click(
								function(event) {
									var inbox_type = $(this).data('id');
								if(inbox_type == 2){
									document.getElementById('inbox_text').innerHTML = "Officer/Unit"
								} else if(inbox_type == 4) {
									document.getElementById('inbox_text').innerHTML = "Sent To"
								}
								else if(inbox_type == 5) {
									document.getElementById('inbox_text').innerHTML = "Queried By"
								} else {
									document.getElementById('inbox_text').innerHTML = "Requested By"
								}

								if(inbox_type == 4){
									document.getElementById('send_text').innerHTML = "Archive Request"
								} else {
									document.getElementById('send_text').innerHTML = "Send Request"
								}

								if(inbox_type == 1){
									//document.getElementById('send_text').innerHTML = "Archive Request"
									$("#sendbulkrequest").removeClass('d-none');
								} else {
									//document.getElementById('send_text').innerHTML = "Send Request"
									$("#sendbulkrequest").addClass('d-none');
								}

								if(inbox_type == 4){
									//document.getElementById('send_text').innerHTML = "Archive Request"
									$("#archivebulkrequest").removeClass('d-none');
								} else {
									//document.getElementById('send_text').innerHTML = "Send Request"
									$("#archivebulkrequest").addClass('d-none');
								}
									
									$.ajax({
												type : "POST",
												url : "Case_Management_Serv",
												data : {
													request_type : 'load_app_request_at_unit_by_inbox_type',
													inbox_type : inbox_type + '_false',
												},

												success : function(
														jobdetails) {
													
													// console.log(jobdetails);
													var json_p = JSON
															.parse(jobdetails);


													/*
													 * $('th:nth-child(7)').show();
													 * $('th:nth-child(8)').show();
													 */

													// datatable.column(0)
													// 		.visible(false);
													// datatable.column(1).visible(false);

													
													//datatable.column(0).visible(false);
													//datatable.column(1).visible(false);

													datatable.search("")
															.draw();
													datatable.state.clear();
													datatable.clear();

													$("#body-dg-1")
															.removeClass(
																	'bg-dark');
													$("#number-text-1")
															.removeClass(
																	'text-white');
													$("#number-text-1")
															.addClass(
																	'text-gray-800');
													$("#body-dg-2")
															.removeClass(
																	'bg-dark');
													$("#number-text-2")
															.removeClass(
																	'text-white');
													$("#number-text-2")
															.addClass(
																	'text-gray-800');
													$("#body-dg-3")
															.removeClass(
																	'bg-dark');
													$("#number-text-3")
															.removeClass(
																	'text-white');
													$("#number-text-3")
															.addClass(
																	'text-gray-800');
													$("#body-dg-4")
															.removeClass(
																	'bg-dark');
													$("#number-text-4")
															.removeClass(
																	'text-white');
													$("#number-text-4")
															.addClass(
																	'text-gray-800');

													$("#body-dg-5")
													.removeClass(
															'bg-dark');
														$("#number-text-5")
																.removeClass(
																		'text-white');
														$("#number-text-5")
																.addClass(
																		'text-gray-800');

													$(json_p.data)
															.each(
																	function() {

																		datatable.row
																				.add([

																					'<input type="checkbox"/>',
																					this.created_on,
																					this.job_number,
																					this.ar_name,
																					this.business_process_sub_name,
																					this.job_purpose,
																					inbox_type == 2 ? this.officer_comments : this.remarks,
																					this.job_status,
																					inbox_type == 2 ? this.job_recieved_by : this.job_forwarded_by,

																					inbox_type == 4 ? 
																					
																					'<div class="text-center"><button  class="btn btn-danger"  data-title="Add to List"  id="btnAddToBatchlist-'
																							+ this.job_number
																							+ '" data-job_number="'
																							+ this.job_number
																							+ '" data-ar_name="'
																							+ this.ar_name
																							+ '" data-business_process_sub_name="'
																							+ this.business_process_sub_name
																							+ '" data-job_purpose="'
																							+ this.job_purpose
																							+ '" data-req_id="'
																							+ this.rq_id
																							+ '" data-target="#askArchiveRequest" data-toggle="modal" >'
																							+ ' <i class="fas fa-trash"></i>'
																							+ ' </button><div>' 
																					
																					: 

																					inbox_type == 3 && this.job_purpose == 'Certificate Signing' ? 
																					// inbox_type == 3 ? 
																					
																					'<div class="text-center"><button  class="btn btn-info"  data-title="Add to List"  id="btnAddToBatchlist-'
																							+ this.job_number
																							+ '" data-job_number="'
																							+ this.job_number
																							+ '" data-ar_name="'
																							+ this.ar_name
																							+ '" data-business_process_sub_name="'
																							+ this.business_process_sub_name
																							+ '" data-job_purpose="'
																							+ this.job_purpose
																							+ '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
																							+ ' <i class="fas fa-paper-plane"></i>'
																							+ ' </button><div>'
																							
																							:

																							'<div class="text-center"><button  class="btn btn-info"  data-title="Add to List"  id="btnAddToBatchlist-'
																							+ this.job_number
																							+ '" data-job_number="'
																							+ this.job_number
																							+ '" data-ar_name="'
																							+ this.ar_name
																							+ '" data-business_process_sub_name="'
																							+ this.business_process_sub_name
																							+ '" data-job_purpose="'
																							+ this.job_purpose
																							+ '" data-target="#askForPurposeOfSendingRequesttoOfficer" data-toggle="modal" >'
																							+ ' <i class="fas fa-paper-plane"></i>'
																							+ ' </button><div>'
																							,

																					'<form action="front_office_view_application" method="post">'
																							+ '<input type="hidden" name="case_number" id="case_number" value="'
																							+ this.transaction_number
																							+ '">'
																							+ '<input type="hidden" name="search_text" id="search_text" value="'
																							+ this.case_number
																							+ '">'
																							+ '<input type="hidden" name="job_number" id="job_number" value="'
																							+ this.job_number
																							+ '">'
																							+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
																							+ this.business_process_sub_name
																							+ '">'

																							+ '	<div class="text-center"><button type="submit" name="save" class="btn btn-primary" >'

																							+ '	<i class="fas fa-eye"></i>'
																							+ '	</button><div></form>',

																							'<form action="new_request_application_progress_details" method="post">'
																							+ '<input type="hidden" name="case_number" id="case_number" value="'
																							+ this.transaction_number
																							+ '">'
																							+ '<input type="hidden" name="review_instruction" id="review_instruction" value="'
																							+ this.remarks
																							+ '">'
																							+ '<input type="hidden" name="transaction_number" id="transaction_number" value="'
																							+ this.transaction_number
																							+ '">'
																							+ '<input type="hidden" name="job_number" id="job_number" value="'
																							+ this.job_number
																							+ '">'
																							+ '<input type="hidden" name="job_purpose" id="job_purpose" value="'
																							+ this.job_purpose
																							+ '">'
																							+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
																							+ this.business_process_sub_name
																							+ '">'

																							+ '		<div class="text-center"><button type="submit" name="save" class="btn btn-danger btn-to-be-disabled to_hide_on_level_1" >'

																							+ '	<i class="fas fa-folder-open"></i>'
																							+ '	</button><div></form>'
																							

																						])
																				.draw(
																						false);
																		datatable
																				.column(
																						2)
																				.data()
																				.sort();

																	});

													switch (inbox_type) {
													case 1:

														$(".btn-to-be-disabled").prop('disabled',true);
														//datatable.column(11).visible(true);

														$("#body-dg-1")
																.addClass(
																		'bg-dark');
														$("#number-text-1")
																.removeClass(
																		'text-gray-800');
														$("#number-text-1")
																.addClass(
																		'text-white');

														break;
													case 2:

														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		false);

														$("#body-dg-2")
																.addClass(
																		'bg-dark');
														$("#number-text-2")
																.removeClass(
																		'text-gray-800');
														$("#number-text-2")
																.addClass(
																		'text-white');
														//datatable.column(11).visible(true);

														break;
													case 3:
														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		false);

														$("#body-dg-3")
																.addClass(
																		'bg-dark');
														$("#number-text-3")
																.removeClass(
																		'text-gray-800');
														$("#number-text-3")
																.addClass(
																		'text-white');
														//datatable.column(11).visible(true);
														break;
													case 4:
														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		true);
														// datatable
														// 		.column(11)
														// 		.visible(
														// 				false);

														$("#body-dg-4")
																.addClass(
																		'bg-dark');
														$("#number-text-4")
																.removeClass(
																		'text-gray-800');
														$("#number-text-4")
																.addClass(
																		'text-white');
														break;
														case 5:
														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		true);
														// datatable
														// 		.column(11)
														// 		.visible(
														// 				false);

														$("#body-dg-5")
																.addClass(
																		'bg-dark');
														$("#number-text-5")
																.removeClass(
																		'text-gray-800');
														$("#number-text-5")
																.addClass(
																		'text-white');
														break;
													default:
														// code block
													}


												}

											});

								});


				$("#btn_process_request_list_to_user").click(function(event){
					   	 
									//alert(JSON.stringify(table)); 
							   let request_type ="";
							   var list_of_application_new = JSON.stringify(table)
							   if($('#batch_type').val()==='Unit'){
								   request_type = 'process_request_list_to_user';
								   var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
									   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
									  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');
		
									  if(!userid_1 || !send_to_id || !send_to_name) {
		
										alert('Please select a unit to send to');
		
										$.notify({
											message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
										}, { type : 'danger' , z_index: 9999  });
		
										return;
		
									  }
		
									  $("#unit_to_send_to").on('input', function(){
										var userid_1 = $(this).val();  // $( "#user_to_send_to option
										if(userid_1){
											$("#btn_process_request_list_to_user").removeClass('d-none')
										}
									  })
								   
							   }else{
								   request_type = 'process_request_list_to_user';
								   var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
									   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
									  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');
		
									  if(!userid_1 || !send_to_id || !send_to_name) {
		
										alert('Please select a user to send to');
		
										$.notify({
											message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
										}, { type : 'danger' , z_index: 9999  });
		
										return;
		
									  }
		
									  $("#unit_to_send_to").on('input', function(){
										var userid_1 = $(this).val();  // $( "#user_to_send_to option
										if(userid_1){
											$("#btn_process_request_list_to_user").removeClass('d-none')
										}
									  })
								   
							   }
								   
							   var table = storeTblValues();
							   list_of_application_new = JSON.stringify(table);
							   //console.log(list_of_application_new);
								   
								   
								   
							   console.log("request_type: " + request_type);
							   console.log("userid_1 " + userid_1);
							   console.log("sender " + send_to_name);
							   console.log("sender " + send_to_id);
		
		
							   function storeTblValues()
							   {
								   var TableData = new Array();
		
								   $('#FileListdataTable tr').each(function(row, tr){
									   TableData[row]={
										   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
										   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
										   "locality" : $(tr).find('td:eq(3)').text().trim(),
										   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
										   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
										   "remarks" : $(tr).find('td:eq(5)').text().trim()
										   
									   }    
								   }); 
								   TableData.shift();  // first row will be empty - so remove
								   return TableData;
							   }
								
								$.ajax({
									type: "POST",
									url: "Case_Management_Serv",
									data: {
										   request_type: request_type,
										   division: localStorage.getItem('division'),
											 list_of_application:list_of_application_new,
											 send_to_name : send_to_name,
										   send_to_id : send_to_id,
											 },
									cache: false,
								   
									success: function(response) {
										   console.log(response)
										   
										 var json_p = JSON.parse(response);
										
										  /* $('#request_type').val('request_to_generate_batch_list');
										   $('#list_of_application').val(list_of_application_new);
										   $('#batch_number').val(json_p.batch_number);
										  
										   $('#modified_by').val(  $( "#user_to_send_to" ).val());
										   //var userid_1 = $( "#user_to_send_to" ).val(); 
										   
										 //  $('#modified_by').val(localStorage.getItem('fullname'));
										   $('#modified_by_id').val( localStorage.getItem('userid'));
										   // $('#downloadForm').submit();

										   
		*/								    
											if(json_p.success == true) {
												$.ajax({
														type: "POST",
														url: "GenerateCaseReports",
														target : '_blank',
														data: {
															request_type: 'request_to_generate_request_list',
																list_of_application: list_of_application_new,
																batch_number: json_p.batch_number,
																modified_by : localStorage.getItem('fullname'),
																modified_by_id : localStorage.getItem('userid'),
															  send_to_name: send_to_name,
														   send_to_id: send_to_id
																 },
														cache: false,
														xhrFields : {
															   responseType : 'blob'
														   },
														beforeSend: function () {
														   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
														   //console.log("before ajax");
														   
														   
														   
														   
														},
														success: function(data) {
															console.log(data)
														   
														   
															   $('#elisDocumentPreview').modal({
																  backdrop: 'static',
																});
															
															
															var blob = new Blob(
																	   [ data ],
																	   {
																		   type : "application/pdf"
																	   });
														   var objectUrl = URL
																	   .createObjectURL(blob);
															   // window.open(objectUrl);
															   console.log("success ajax");
		
															$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
															   
															   
															   
															 
														},
														complete: function(){
															console.log("Completed ajax");
															$('#viewBatchlistModal').modal('hide');
															console.log("Completed 3 ajax");
															 //Clear Local storage Bactlist
															   localStorage.setItem('requestBatchingListData', '');
															   //prepareBatchlistModal();
															   
															  
														  }
														});  
							   
													}

													else {

														$.notify({
															message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Oops! Action can not be done. The selected officer has '+json_p.user_count+' case(s).</span>',
														}, {
															type: 'danger'
														});

														alert('Oops! Action can not be done. The selected officer has '+json_p.user_count+' case(s).')
													}
									}
									}); 

							});

							

							$("#btn_process_to_arachive_request_list").click(function(event){
					   	 
								//alert(JSON.stringify(table)); 
						   let request_type ="";
						   var list_of_application_new = JSON.stringify(table)
							   
						   var table = storeTblValues();
						   list_of_application_new = JSON.stringify(table);
						   //console.log(list_of_application_new);
							
	
	
						   function storeTblValues()
						   {
							   var TableData = new Array();
	
							   $('#ArchiveListdataTable tr').each(function(row, tr){
								   TableData[row]={
									   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
									   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
									   "locality" : $(tr).find('td:eq(3)').text().trim(),
									   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
									   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
									   "remarks" : $(tr).find('td:eq(5)').text().trim()
									   
								   }    
							   }); 
							   TableData.shift();  // first row will be empty - so remove
							   return TableData;
						   }
							
							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									   request_type: 'process_request_list_to_archive',
										 list_of_application:list_of_application_new,
										 },
								cache: false,
							   
								success: function(response) {
									   console.log(response)
									   
									 var json_p = JSON.parse(response);
									
									  /* $('#request_type').val('request_to_generate_batch_list');
									   $('#list_of_application').val(list_of_application_new);
									   $('#batch_number').val(json_p.batch_number);
									  
									   $('#modified_by').val(  $( "#user_to_send_to" ).val());
									   //var userid_1 = $( "#user_to_send_to" ).val(); 
									   
									 //  $('#modified_by').val(localStorage.getItem('fullname'));
									   $('#modified_by_id').val( localStorage.getItem('userid'));
									   // $('#downloadForm').submit();

									   
	*/								    
												if(json_p.success == true) {

													$('#viewArchiveListModal').modal('hide');
													
													$.notify({
														message: '<i class="fa fa-check-circle  fa-3x fa-fw"></i><span class="text-bold"> Selected request has been archived successfully.</span>',
													}, {
														type: 'success'
													});
													localStorage.setItem('requestArchiveListData', '');

											// $.ajax({
											// 		type: "POST",
											// 		url: "GenerateCaseReports",
											// 		target : '_blank',
											// 		data: {
											// 			request_type: 'request_to_generate_request_list',
											// 				list_of_application: list_of_application_new,
											// 				batch_number: json_p.batch_number,
											// 				modified_by : localStorage.getItem('fullname'),
											// 				modified_by_id : localStorage.getItem('userid'),
											// 			  send_to_name: send_to_name,
											// 		   send_to_id: send_to_id
											// 				 },
											// 		cache: false,
											// 		xhrFields : {
											// 			   responseType : 'blob'
											// 		   },
											// 		beforeSend: function () {
											// 		   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
											// 		   //console.log("before ajax");
													   
													   
													   
													   
											// 		},
											// 		success: function(data) {
											// 			console.log(data)
													   
													   
											// 			   $('#elisDocumentPreview').modal({
											// 				  backdrop: 'static',
											// 				});
														
														
											// 			var blob = new Blob(
											// 					   [ data ],
											// 					   {
											// 						   type : "application/pdf"
											// 					   });
											// 		   var objectUrl = URL
											// 					   .createObjectURL(blob);
											// 			   // window.open(objectUrl);
											// 			   console.log("success ajax");
	
											// 			$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
														   
														   
														   
														 
											// 		},
											// 		complete: function(){
											// 			console.log("Completed ajax");
											// 			$('#viewBatchlistModal').modal('hide');
											// 			console.log("Completed 3 ajax");
											// 			 //Clear Local storage Bactlist
											// 			   localStorage.setItem('batchlistdata', '');
											// 			   //prepareBatchlistModal();
														   
														  
											// 		  }
											// 		});  
						   
												}

												else {

													$.notify({
														message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Oops! Action can not be done. Something went wrong.</span>',
													}, {
														type: 'danger'
													});

													alert('Oops! Something went wrong.')
												}
								}
								}); 

						});

							$('#req_job_purpose').on('change', function(e) {

								var job_purpose = $('#req_job_purpose').val();
								var job_number = $('#req_job_number').val();

								console.log(job_number);

								if(job_purpose == 'Certificate Generation' || job_purpose == 'Certificate Generation Transition' ||  job_purpose == 'Folio and Volume Generation') {

									$.ajax({
										type: "POST",
										url: "Case_Management_Serv",
										data: {
											   request_type: 'select_check_wkt_polygon_by_job_number',
											   job_number : job_number,
											},
										cache: false,
									   
										success: function(response) {
											//console.log(response)
											   
											var json_p = JSON.parse(response);

											if(json_p.data || json_p.data != null){
												$('#btnaddreqtolistFinal').removeClass('d-none');
											} else {
												$('#btnaddreqtolistFinal').addClass('d-none');

												alert('Application has not been noted');
		
												$.notify({
													message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Application has not been noted</span>',
												}, { type : 'danger' , z_index: 9999  });

											}
											
										}
									}); 

								} else {
									$('#btnaddreqtolistFinal').removeClass('d-none');
								}

							})




		   $('#checkAppdetailsforRequest').on('show.bs.modal', function(e) {
			// $('#req_job_number').val($(e.relatedTarget).data('job_number'));
			// $('#req_ar_name').val($(e.relatedTarget).data('transaction_number'));

			var job_number = $(e.relatedTarget).data('job_number');
			var transaction_number = $(e.relatedTarget).data('transaction_number')

			if(transaction_number || job_purpose) {

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						   request_type: 'select_check_application_details_for_request',
						   job_number : job_number,
						   transaction_number: transaction_number
						},
					cache: false,
				   
					success: function(response) {
						
						   
						var json_p = JSON.parse(response);
						console.log(json_p)

						var registration_district_number = json_p.parcel_details.registration_district_number
						var registration_section_number = json_p.parcel_details.registration_section_number
						var registration_block_number = json_p.parcel_details.registration_block_number
						var folio_number = json_p.transaction_details.folio_number
						var volume_number = json_p.transaction_details.volume_number
						var parcel_wkt = json_p.parcel_wkt

						$('#reqsss_job_number').val(job_number)
						$('#req_districk_no').val(registration_district_number)
						$('#req_section_no').val(registration_section_number)
						$('#req_block_no').val(registration_block_number)
						$('#req_folio_no').val(folio_number)
						$('#req_volume_no').val(volume_number)
						$('#req_parcel_wkt').val(parcel_wkt)
					}
				}); 

			} else {
				//
			}
				
           });


		   $('#btnAddAlltoRequestlist').on('click', function(e) {
				var remarks_notes = $("#txt_general_remarks_notes").val();
			
				if (remarks_notes) {
					var confirmText = "Are you sure you want to add these application to the list?";
					if (confirm(confirmText)) {
						$("#job_casemgtdetailsdataTable input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked").each(
							function() {
								var row = $(this).closest("tr")[0];
								var job_number = row.cells[2].innerHTML;
								var ar_name = row.cells[3].innerHTML;
								var business_process_sub_name = row.cells[4].innerHTML;
								var job_purpose = row.cells[5].innerHTML;
								addRequestToList(
									job_number,
									ar_name,
									business_process_sub_name,
									"",
									job_purpose,
									remarks_notes
								);
							});

							prepareRequestBatchingModal();

							// $('#viewBatchlistModal #lbl_batch_type').val('cst');
					}
				} else {
					$.notify(
						{
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
						}, {
							type : 'danger' , z_index: 9999 
						});
				}

			});

			

			$('#btnAddAlltoArchivelist').on('click', function(e) {
				var remarks_notes = $("#txt_general_archive_notes").val();

				localStorage.removeItem('requestArchiveListData');
			
				if (remarks_notes) {
					var confirmText = "Are you sure you want to add these application to the archive list?";
					if (confirm(confirmText)) {
						$("#job_casemgtdetailsdataTable input[type=checkbox]:checked").each(
							function() {
								var row = $(this).closest("tr")[0];
								var job_number = row.cells[2].innerHTML;
								var ar_name = row.cells[3].innerHTML;
								var business_process_sub_name = row.cells[4].innerHTML;
								var job_purpose = row.cells[5].innerHTML;
								addArchiveToList(
									job_number,
									ar_name,
									business_process_sub_name,
									"",
									job_purpose,
									remarks_notes
								);
							});

							prepareRequestArchiveModal();

							// $('#viewBatchlistModal #lbl_batch_type').val('cst');
					}
				} else {
					$.notify(
						{
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Note for archiving is required ! </span>',
						}, {
							type : 'danger' , z_index: 9999 
						});
				}

			});
});