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

								if (enq_search_value.length < 8) {
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
									}, { type : 'danger' , z_index: 9999  });
									
								} else if (enq_search_type.length <= 0){
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
									}, { type : 'danger' , z_index: 9999  });
									
								}else {

									$("#enq-search-results-section").hide();

									$.ajax({
												type : "POST",
												url : "Case_Management_Serv",
												data : {
													request_type : 'load_application_details_for_enquiries',
													job_number : enq_search_value,
													search_type: enq_search_type
												},
												cache : false,
												
												success : function(
														jobdetails) {

															if(!jobdetails) {

																$.notify({
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found!</span>',
																}, { type : 'danger' , z_index: 9999  });
																return;
															}

													 //console.log(jobdetails);
													$(
															"#enq-search-results-section")
															.show();

													var table = $('#enq-search-results-table');
													table.find(
															"tbody tr")
															.remove();
													if(jobdetails
															.includes('no search type')) {
														alert('Reference Number has not been acknowleged or does not exist')
														return false;
													}else{
														
													
													// console.log(jobdetails);
													var json_p = JSON
															.parse(jobdetails);

													$(json_p)
															.each(
																	function() {
																		// console.log(this.job_number);
																		table
																				.append("<tr><td>"
																						+ this.ar_name
																						+ "</td><td>"
																						+ this.case_number
																						+ "</td><td>"
																						+ this.job_number
																						+ "</td><td>"
																						+ this.glpin
																						+ "</td><td>"
																						+ this.locality
																						+ "</td><td>"
																						+ this.regional_number
																						+ "</td>"

																						+ '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
																						+ ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
																						+ ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'

																						+ '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
																						+ ' data-target-id="'
																						+ this.job_number
																						+ '"> '
																						+ '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Cabinet</span> </button><div class="dropdown-divider"></div>'

																						+ '<form action="front_office_view_application" method="post">'
																						+ '<input type="hidden" name="case_number" id="case_number" value="'+ this.transaction_number +'">'
																						+ '<input type="hidden" name="job_number" id="job_number" value="'+ this.job_number +'">'
																						+ '<input id="search_text" name="search_text" type="hidden" value="'+ this.case_number +'">'
																						+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'+ this.case_number +'}">'
																						
																						
																						+ '<button type="submit" class="btn btn-primary dropdown-item" id="btn_application_details" title="View Application Details" > '
																						+ '<span class="icon text-black-50"> <i class="fas fa-info-circle"></i>  </span><span  class="text">Application Details</span></button>'
																						
																						
																						
																						
																						+ '</form>'
																						
																						+ '<div class="dropdown-divider"></div>'
																						+ '<button type="button" class="btn btn-primary dropdown-item" id="track_file" title="Physical File History" data-toggle="modal" data-target="#filelistModal"'
																								+ ' data-target-id="'
																								+ this.job_number
																								+ '"> '
																								+ '<span class="icon text-black-50"> <i class="fas fa-archive"></i> </span><span  class="text">Track Physical File </span> </button><div class="dropdown-divider"></div>'
																						+ '</div></div></td></tr>');

																	});
													}

												}
											});
								}
							});

					/*
					 * =========================================== Actions for
					 * InspectionModal ==================
					 */
					$('#cabinetModal')
							.on(
									'show.bs.modal',
									function(event) {
										var job_number = $(event.relatedTarget)
												.data('target-id') // Extract
										// info from
										// data-*
										// attributes
										var table = $('#cabinet-tracking');
										table.find("tbody tr").remove();

										$("#enq_applicant_name").val("");
										$("#enq_applicant_type").val("");
										$("#enq_cabinet_name").val("");
										// $("#enq_job_purpose").val(this.job_purpose);
										$("#enq_job_status").val("");

										console.log(job_number);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'load_application_cabinet_details_by_job_number',
														job_number : job_number
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

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														// console.log();
														$(
																json_p.cabinet_tracking)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.officers_general_comments
																							+ "</td><td>"
																							+ this.division
																							+ "</td><td>"
																							+ this.created_by
																							+ "</td><td>"
																							+ this.created_date
																							+ '</tr>');

																		});

														$(json_p.cabinet_data)
																.each(
																		function() {

																			$(
																					"#enq_applicant_name")
																					.val(
																							this.ar_name);
																			$(
																					"#enq_applicant_type")
																					.val(
																							this.business_process_sub_name);
																			$(
																					"#enq_cabinet_name")
																					.val(
																							this.file_number);
																			$(
																					"#enq_job_purpose")
																					.val(
																							this.job_purpose);
																			$(
																					"#enq_job_status")
																					.val(
																							this.job_status);

																			$(
																					"#enq_current_application_status")
																					.val(
																							this.current_application_status);

																		});

													}
												});

									});

					

					
					
/*----------------------------------------------*/
					
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
					
					
					$('#filelistModal').on('show.bs.modal',function(e)  {

						// validation code here
						//e.preventDefault();
						// console.log('how are your search');
						
						var enq_batchlist_val = $(e.relatedTarget).data('target-id');;
						console.log('Search Value: ' + enq_batchlist_val);

						if (!(enq_batchlist_val.length >= 4)) {
							$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 6 or more characters to search </span>',
							}, {type : 'danger' , z_index: 9999 });
						} else {

							
							

							$.ajax({
								type : "POST",
								url : "Case_Management_Serv",
								data : {
									request_type : 'load_application_file_location',
									job_number : enq_batchlist_val
								},
								cache : false,
								beforeSend : function() {
									
								},
								success : function(jobdetails) {
									try {
										var table = $('#tbl_file_history');
										table.find("tbody tr").remove();

										//console.log(jobdetails);
										
										var json_p = JSON.parse(jobdetails);

										$(json_p).each(function() {

											table.append("<tr><td>" + this.created_date
														+ "</td><td>" + this.division
														+ "</td><td>" + this.user_fullname
														+ "</td><td>" + this.created_by
														+ "</td>"
														+ '</tr>');

											});
										
										//$("#enq-search-results-section").hide();
										//$("#batchlist_value").empty();
										//$("#batchlist_value").append(enq_batchlist_val);
										//$("#BachlistModal").modal("show");
										}
										catch(err) {
										 console.log(err.message);
										}
								}

							});

										
									
						}
					});
					

					

					
					// ------ end of $(doc).ready
				});