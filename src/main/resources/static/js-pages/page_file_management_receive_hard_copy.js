$(document)
		.ready(
				function() {

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

														console.log(jobdetails);

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

																		+ '<td><p data-placement="top" data-toggle="tooltip" title="Receive After Payment"><button class="btn btn-info" data-title="Add New Service"  data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#reSubmissionAppModal" '
																		+ 'data-job_number="'
																		+ json_p.transaction_details.job_number
																		+ '" '
																		+ 'data-case_number="'
																		+  json_p.transaction_details.case_number
																		+ '" '
																		+ 'data-transaction_number="'
																		+ json_p.transaction_details.transaction_number
																		+ '" '
																		+ 'data-land_size="'
																		+  json_p.transaction_details.land_size
																		+ '" '
																		+ 'data-ar_name="'
																		+  json_p.transaction_details.ar_name
																		+ '" '
																		+ 'data-created_for_id="'
																		+  json_p.transaction_details.created_for_id
																		+ '" '

																		+ 'data-locality="'
																		+  json_p.transaction_details.locality
																		+ '" '

																		+ 'data-licensed_no="'
																		+  json_p.transaction_details.licensed_no
																		+ '" '
																		+ 'data-bill_amount="'
																		+  json_p.transaction_details.current_application_status
																		+ '" id="ad_new_service"><span class="fa fa-receipt"></span></button></p> </td>'

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

					

					
					// ------ end of $(doc).ready
				});