$(document)
		.ready(
				function() {

					$('#frmCCJobSearch')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('how are your search');
										var enq_search_type = "";
										var selected_rbtn = $("input[name='rbtn_search_type']:checked");
										if (selected_rbtn.length > 0) {
											enq_search_type = selected_rbtn.val();
											//console.log("selected " + enq_search_type);
										}

										var enq_search_value = $(
												"#cc_search_value").val();
										console.log('Search Value: '
												+ enq_search_value);

										if (!(enq_search_value.length >= 8)) {
											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										}else if (enq_search_type.length <= 0){
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
											}, { type : 'danger' , z_index: 9999  });
											
										} else {

											$("#cc-search-results-section")
													.hide();

											$
													.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_for_enquiries',
															job_number : enq_search_value,
															search_type: enq_search_type
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
															$(
																	"#cc-search-results-section")
																	.show();

															var table = $('#cc-search-results-table');
															table.find(
																	"tbody tr")
																	.remove();

															// console.log(jobdetails);
															var json_p = JSON
																	.parse(jobdetails);

															$(json_p)
																	.each(
																			function() {
																				//console.log(this);
																				table
																						.append("<tr><td>"
																								+ this.ar_name
																								+ "</td><td>"
																								/*+ this.case_number
																								+ "</td><td>"*/
																								+ this.job_number
																								+ "</td><td>"
																								/*+ this.glpin
																								+ "</td><td>"*/
																								+ this.locality
																								+ "</td><td>"
																								+ this.regional_number
																								+ "</td><td>"
																								+ this.current_application_status
																								+ "</td>"

																								+ '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
																								+ ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
																								+ ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'

																								+ '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#trackingModal"'
																								+ ' data-target-id="'
																								+ this.job_number
																								+ '"> '
																								+ '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Track Application</span> </button><div class="dropdown-divider"></div>'

																								/*+ '<button type="button" class="btn btn-primary dropdown-item" id="track_file" title="Physical File History" data-toggle="modal" data-target="#filelistModal"'
																								+ ' data-target-id="'
																								+ this.job_number
																								+ '"> '*/
																								/*+ '<span class="icon text-black-50"> <i class="fas fa-archive"></i> </span><span  class="text">Track Physical File </span> </button><div class="dropdown-divider"></div>'

																	

																								*/
																								+ '<form action="front_office_view_application" method="post">'
																								+ '<input type="hidden" name="case_number" id="case_number" value="'+ this.transaction_number +'">'
																								+ '<input type="hidden" name="job_number" id="job_number" value="'+ this.job_number +'">'
																								+ '<input id="search_text" name="search_text" type="hidden" value="'+ this.case_number +'">'
																								+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'+ this.case_number +'}">'
																								
																								
																								+ '<button type="submit" class="btn btn-primary dropdown-item" id="btn_application_details" title="View Application Details" > '
																								+ '<span class="icon text-black-50"> <i class="fas fa-info-circle"></i>  </span><span  class="text">Application Details</span></button>'
																								
																								
																								
																								
																								+ '</form>'
																								
																								/*+ '<div class="dropdown-divider"></div>'

																								+ '<button type="button" class="btn btn-primary dropdown-item" id="btn_collection"  title="Issue out Application" data-toggle="modal" data-target="#collectionModal" '
																								+ ' data-target-id="'
																								+ this.job_number
																								+ '"> '
																								+ '<span class="icon text-black-50"> <i class="fas fa-hand-holding"></i> </span><span  class="text">Collection</span></button>'
																								+ '<div class="dropdown-divider"></div>'*/

																								/*
																								 * + '<button
																								 * type="button"
																								 * class="btn
																								 * btn-primary
																								 * dropdown-item"
																								 * id="btn_file_number"
																								 * title="File
																								 * Number" ' + '
																								 * data-target-id="' +
																								 * this.job_number +
																								 * '"> ' + '
																								 * <span
																								 * class="icon
																								 * text-black-50">
																								 * <i
																								 * class="fas
																								 * fa-file-alt"></i>
																								 * </span><span
																								 * class="text">File
																								 * number :
																								 * LRD565
																								 * </span></button>' + '
																								 * <div
																								 * class="dropdown-divider"></div>'
																								 */

																								/*+ '<button type="button" class="btn btn-primary  dropdown-item" id="btn_add_fees"   title="Add Fees">'
																								+ '<span class="icon text-black"> <i class="fa fa-dollar-sign"></i>  </span> <span  class="text">Add Fees</span></button>'
*/
																								+ '</div></div></td></tr>');

																			});

														}
													});
										}
									});

					
					$('#trackingModal').on('show.bs.modal',function(event) {
										var job_number = $(event.relatedTarget)
												.data('target-id') 
										
										var table = $('#cabinet-tracking');
										table.find("tbody tr").remove();

										$("#enq_applicant_name").val("");
										$("#enq_applicant_type").val("");
										$("#enq_cabinet_name").val("");
										// $("#enq_job_purpose").val(this.job_purpose);
										$("#enq_job_status").val("");

										//console.log(job_number);

										$.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'load_application_milestone_for_tracking_by_job',
														job_number : job_number
													},
													cache : false,
													success : function(
															jobdetails) {

														console.log(jobdetails);
														var json_p = JSON.parse(jobdetails);
														

														// console.log();
														$(json_p.milestones)
																.each(
																		function(index, value) {
																			//console.log("pro:" + this.priority_value);
																			//console.log("aps:" + json_p.application_stage +1);
																			var int_index = ++index;
																			if(parseInt(this.priority_value) < parseInt(json_p.application_stage) ){
																				table
																				.append("<tr class='bg-success text-dark'><td>"
																						+ int_index
																						+ "</td><td>"
																						+ this.milestone_description
																						+ "</td><td>Completed" 
																						+ "</td></tr>"
																						);
																			}else if(parseInt(this.priority_value) == parseInt(json_p.application_stage) ){
																				table
																				.append("<tr class='bg-info text-dark'><td>"
																						+ int_index
																						+ "</td><td>"
																						+ this.milestone_description
																						 +"</td><td>Ongoing" 
																						+ "</td></tr>"
																						);
																			}else{
																				table
																				.append("<tr class='bg-danger text-light'><td>"
																						+ int_index
																						+ "</td><td>"
																						+ this.milestone_description
																						+ "</td><td>Not Completed" 
																						+ "</td></tr>"
																						);
																			}	
																			

																		});
														$(json_p.notifications)
														.each(
																function(index, value) {
																	//console.log("pro:" + this.priority_value);
																	//console.log("aps:" + json_p.application_stage +1);
																	var int_index = ++index;
																	/*if(parseInt(this.priority_value) <= parseInt(json_p.application_stage) + 1){
																		table
																		.append("<tr class='bg-success text-dark'><td>"
																				+ int_index
																				+ "</td><td>"
																				+ this.milestone_description
																				+ "</td><td>Completed</td></tr>"
																				);
																	}else{
																		table
																		.append("<tr class='bg-danger text-light'><td>"
																				+ int_index
																				+ "</td><td>"
																				+ this.milestone_description
																				+ "</td><td>Not Completed</td></tr>"
																				);
																	}	*/
																	
																	$('#sms-tracking').append("<tr ><td>"
																			+ int_index
																			+ "</td><td>"
																			+ this.sms_message
																			+ "</td><td>" +  this.sms_date_sent +"</td></tr>"
																			);
																	

																});

														$(json_p.application_details)
																.each(
																		function() {

																			$("#submitted_by_text").html(
																							this.client_name);
																			$("#sub_service_text")
																					.html(
																							this.business_process_sub_name);
																			$("#date_created_text").html(
																							this.created_date);
																			$("#job_number_text").html(
																							job_number);
																			$("#status_text").html(
																							this.job_status);

																			$("#main_service_text").html(
																							this.business_process_name);

																		});
														
														
														

													}
												});

									});
					
					
					
					
					$('#frmEnquiryApplicantDetails').on('submit',function(e) {
						$("#tbl_applicant_details_section").hide();
						// validation code here
						e.preventDefault();
						// console.log('how are your search');

						var enq_batchlist_val = $("#hpl_job_number").val();
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
									request_type : 'load_applicant_details_by_job_number',
									job_number : enq_batchlist_val
								},
								cache : false,
								beforeSend : function() {
									
								},
								success : function(jobdetails) {
									try {
										var table = $('#tbl_applicant_details');
										table.find("tbody tr").remove();

										console.log(jobdetails);
										
										var json_p = JSON.parse(jobdetails);
										if(json_p.data == null){
											alert("No details found for this job")
										}else{
											$(json_p.data).each(function() {
												$("#tbl_applicant_details_section").show()
												$("#tbl_applicant_details_section").html(
														`<br><br>
														<h4 class="mb-4">Current Applicant details for Job Number : ${enq_batchlist_val}</h4>
											        	<table class="table text-xl" id="tbl_applicant_details">
											        		<tr><th>Name: </th><td>${this.ar_name}</td></tr>
											        		<tr><th>Phone: </th><td>${this.phone}</td></tr>
											        		<tr><th>Email: </th><td>${this.email}</td></tr>
											        	</table>`
												);
											});
										}
										
										
									}catch(err) {
										 console.log(err.message);
									}
								}

							});

										
									
						}
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