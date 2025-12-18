$(document)
		.ready(
				function() {

					
					
					$('#frmEnquiryJobSearch')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										 //console.log('how are your search');
										
										var enq_search_type = "";
										var selected_rbtn = $("input[name='rbtn_search_type']:checked");
										if (selected_rbtn.length > 0) {
											enq_search_type = selected_rbtn.val();
											//console.log("selected " + enq_search_type);
										}
										
										
										var enq_search_value = $("#enq_search_value").val();
										//console.log('Search Value: ' + enq_search_value);

										if (enq_search_value.length < 4) {
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
											}, { type : 'danger' , z_index: 9999  });
											
										} else if (enq_search_type.length <= 0){
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
											}, { type : 'danger' , z_index: 9999  });
											
										}else {

											//$("#enq-search-results-section").hide();

											$.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_for_enquiries',
															job_number : enq_search_value,
															search_type: enq_search_type
														},
														cache : false,
														
														success: function(jobdetails) {
																if (!jobdetails) {
																	$.notify({
																		message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found!</span>',
																	}, { type: 'danger', z_index: 9999 });
																	//$('#enquiry_alert').removeClass('d-none');
																	return;
																}

																$("#enq-search-results-section").show();

																var table = $('#tbl-bulk-collection-table');

																if (jobdetails.includes('no search type')) {
																	alert('Reference Number has not been acknowledged or does not exist');
																	return false;
																} else {
																	var json_p = JSON.parse(jobdetails);

																	$(json_p).each(function() {
																		var jobNumber = this.job_number;

																		// Check if this job number already exists in any row
																		var alreadyExists = false;
																		table.find('tbody tr').each(function() {
																			var existingJobNumber = $(this).find('td').eq(2).text().trim(); // Assuming job_number is in the 3rd column (index 2)
																			if (existingJobNumber === jobNumber) {
																				alreadyExists = true;
																				return false; // break loop
																			}
																		});

																		if (alreadyExists) {
																			// Optional: Notify user if duplicate is skipped
																			$.notify({
																				message: '<i class="fa fa-info-circle fa-3x fa-fw"></i><span class="text-bold">Job number ' + jobNumber + ' is already in the table and will not be added again.</span>',
																			}, { type: 'info', z_index: 9999 });
																			return; // Skip adding
																		}

																		// Add row if not duplicate
																		table.append("<tr><td>"
																			+ this.ar_name + "</td><td>"
																			+ this.case_number + "</td><td>"
																			+ this.job_number + "</td><td>"
																			+ this.glpin + "</td><td>"
																			+ this.locality + "</td><td>"
																			+ this.regional_number + "</td></tr>");
																	});
																}
															}
													});
										}
									});

				
									function storeTblValues() {
										var TableData = new Array();

										$('#tbl-bulk-collection-table tr')
												.each(
														function(row, tr) {
															TableData[row] = {
																"ar_name" : $(
																		tr)
																		.find(
																				'td:eq(0)')
																		.text()
																		.trim(),
																"job_number" : $(
																		tr)
																		.find(
																				'td:eq(2)')
																		.text()
																		.trim(),
															
															}
														});
										TableData.shift(); // first row
										// will be empty
										// - so remove
										return TableData;
									}

					
									$("#btn_process_bulk_collection")
									.click(
											function(event) {
		
												// alert(JSON.stringify(table));
												//let request_type = "";
												//var list_of_application_new = JSON.stringify(table)
												//var lbl_batch_type = $("#lbl_batch_type").val();
												
	
												//var table = $('#tbl-bulk-collection-table');
												var table = storeTblValues();
												list_of_application_new = JSON.stringify(table);
												console.log(list_of_application_new);
		
												var bcd_collected_by = $("#bcd_collected_by").val();
												var bcd_id_type = $("#bcd_id_type").val();
												var bcd_id_number = $("#bcd_id_number").val();
												var bcd_phone_number = $("#bcd_phone_number").val();

												if(!bcd_collected_by || !bcd_id_type || !bcd_id_number || !bcd_phone_number) {
													$.notify({
														message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please fill up all the fields</span>',
													}, { type : 'danger' , z_index: 9999  });
													return;
												}
		
												$
														.ajax({
															type : "POST",
															url : "Case_Management_Serv",
															data : {
																request_type : 'process_batch_list_issue_collection',
																list_of_application : list_of_application_new,
																bcd_collected_by : bcd_collected_by,
																bcd_id_type : bcd_id_type,
																bcd_id_number : bcd_id_number,
																bcd_phone_number : bcd_phone_number
															},
															cache : false,
															
															success : function(response) {
																console.log(response)
		
																var json_p = JSON.parse(response);
		
																$('#request_type')
																		.val(
																				'request_to_generate_batch_list');
																$(
																		'#list_of_application')
																		.val(
																				list_of_application_new);
																$('#batch_number')
																		.val(
																				json_p.batch_number);
		
																$('#modified_by')
																		.val(
																				$(
																						"#user_to_send_to")
																						.val());
																				$('#modified_by_id')
																		.val(
																				localStorage
																						.getItem('userid'));
																// $('#downloadForm').submit();
		
																$
																		.ajax({
																			type : "POST",
																			url : "GenerateCaseReports",
																			target : '_blank',
																			data : {
																				request_type : 'request_to_generate_batch_list_bulk_correction',
																				list_of_application : list_of_application_new,
																				batch_number : json_p.batch_number,
																				modified_by : localStorage
																						.getItem('fullname'),
																				modified_by_id : localStorage
																						.getItem('userid'),
																				
																			},
																			cache : false,
																			xhrFields : {
																				responseType : 'blob'
																			},
																		
																			success : function(
																					data) {
																				console
																						.log(data)
		
																				$(
																						'#elisDocumentPreview')
																						.modal(
																								{
																									backdrop : 'static',
																								});
		
																				var blob = new Blob(
																						[ data ],
																						{
																							type : "application/pdf"
																						});
																				var objectUrl = URL
																						.createObjectURL(blob);
																				 //window.open(objectUrl);
																				console.log("success ajax");
		
																				$(
																						'#elisdovumentpreviewblobfile')
																						.attr(
																								'src',
																								objectUrl);
		
																			},
																			complete : function() {
																			
		
																			}
																		});
		
															}
														});
		
											});

			
					
				
					// ------ end of $(doc).ready
				});