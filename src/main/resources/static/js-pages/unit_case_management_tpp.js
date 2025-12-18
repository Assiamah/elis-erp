$(document)
		.ready(
				function() {

					var datatable_cordinator = $("#job_casemgtdetailsdataTable_tpp")
							.DataTable({
								stateSave : true,
								"createdRow" : function(row, data, dataIndex) {
									if (data[0] == "1") {
										$(row).addClass('tr-completed-work');
									}
								},
								dom: 'Bfrtip',
								lengthMenu: [
						            [ 10, 25, 50, -1 ],
						            [ '10 rows', '25 rows', '50 rows', 'Show all' ]
						        ],
						        buttons: [
						        	'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
						        ]
							});
					
					var datatable = $("#job_casemgtdetailsdataTable__supervisor_tpp")
					.DataTable({
						stateSave : true,
						"createdRow" : function(row, data, dataIndex) {
							if(Math.round((new Date() - new Date(data[6]) )/ (1000 * 60 * 60 * 24)) >="3" && Math.round((new Date() - new Date(data[6]) )/ (1000 * 60 * 60 * 24)) <"5"){
								$(row).addClass('tr-passed-3-days');
							}else if(Math.round((new Date() - new Date(data[6]) )/ (1000 * 60 * 60 * 24)) >="5" && Math.round((new Date() - new Date(data[6]) )/ (1000 * 60 * 60 * 24)) <"7"){
								$(row).addClass('tr-passed-5-days');
							}else if(Math.round((new Date() - new Date(data[6]) )/ (1000 * 60 * 60 * 24)) <"7"){
								$(row).addClass('tr-passed-7-days');
							}
							
							
						},
						dom: 'Bfrtip',
						lengthMenu: [
				            [ 10, 25, 50, -1 ],
				            [ '10 rows', '25 rows', '50 rows', 'Show all' ]
				        ],
				        buttons: [
				        	'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
				        ]
					});

					
					$(".btnLoadUnitApplicationsTpp")
							.click(
									function(event) {
										// console.log('Clicked
										// btnLoadUnitApplicationsTpp');
										// return false;
										var inbox_type = $(this).data('id');
										let request_type ='';
										if(inbox_type == 1 || inbox_type == 2 ){
											request_type = 'load_applications_at_unit_by_inbox_type';
											datatable_cordinator.column(5).visible(false);
											datatable_cordinator.column(6).visible(false);
											datatable_cordinator.column(7).visible(true);
										}else{
											request_type = 'load_applications_at_unit_by_inbox_type_tpp_coordinator';
											datatable_cordinator.column(5).visible(true);
											datatable_cordinator.column(6).visible(true);
											datatable_cordinator.column(7).visible(false);
										}
										// console.log(request_type)
										
										$.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : request_type,
														inbox_type : (inbox_type == 1 || inbox_type ==2) ? inbox_type + '_false' : inbox_type,
													},

													success : function(jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON.parse(jobdetails);
														
														datatable_cordinator.column(0).visible(false);
														datatable_cordinator.column(6).data().sort();
														/*
														 * datatable.column(0)
														 * .visible(false);
														 * datatable.column(1)
														 * .visible(false);
														 */
														datatable_cordinator.search("").draw();
														datatable_cordinator.state.clear();
														datatable_cordinator.clear();

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
														$("#body-dg-5").removeClass('bg-dark');
														$("#number-text-5").removeClass('text-white');
														$("#number-text-5").addClass('text-gray-800');
														$("#body-dg-6").removeClass('bg-dark');
														$("#number-text-6").removeClass('text-white');
														$("#number-text-6").addClass('text-gray-800');
														
														$("#body-dg-7").removeClass('bg-dark');
														$("#number-text-7").removeClass('text-white');
														$("#number-text-7").addClass('text-gray-800');
														/*
														 * $("#body-dg-6").removeClass('bg-dark');
														 * $("#number-text-6").removeClass('text-white');
														 * $("#number-text-6").addClass('text-gray-800');
														 */
														let col1=0
															
														$(json_p.data)
																.each(
																		function() {
																		
																			col1 = Object.is(this.job_worked_on_status, undefined) ? "0" : this.job_worked_on_status;
																			datatable_cordinator.row.add(
																							[
																									
																								col1,
																									'<input type="checkbox"/>',
																									this.job_number? this.job_number : '',
																									this.ar_name? this.ar_name : '',
																									this.business_process_sub_name ? this.business_process_sub_name :'',
																									this.divisions_awaiting? this.divisions_awaiting: '',
																									this.job_datesend? this.job_datesend : '',
																									

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

																									+ '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'

																									+ '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
																									+ '	</button></form>',
																								

																							]).draw(false);

																		});
														datatable_cordinator.column(2).data().sort();
														switch (inbox_type) {
														case 1:

															// $(".btn-to-be-disabled").prop('disabled',true);

															$("#body-dg-1").addClass('bg-dark');
															$("#number-text-1").removeClass('text-gray-800');
															$("#number-text-1").addClass('text-white');
															$(".show-for-tab-1").show();
															$(".show-for-tab-2").hide();
															break;
														case 2:

															// $(".btn-to-be-disabled").prop('disabled',false);
															$("#body-dg-2").addClass('bg-dark');
															$("#number-text-2").removeClass('text-gray-800');
															$("#number-text-2").addClass('text-white');
															$(".show-for-tab-2").show();
															$(".show-for-tab-1").hide();

															break;
														case 3:
															// $(".btn-to-be-disabled").prop('disabled',false);

															$("#body-dg-3").addClass('bg-dark');
															$("#number-text-3").removeClass('text-gray-800');
															$("#number-text-3").addClass('text-white');
															$(".show-for-tab-1").hide();
															$(".show-for-tab-2").hide();
															break;
														case 4:
															// $(".btn-to-be-disabled").prop('disabled',true);

															$("#body-dg-4").addClass('bg-dark');
															$("#number-text-4").removeClass('text-gray-800');
															$("#number-text-4").addClass('text-white');
															$(".show-for-tab-1").hide();
															$(".show-for-tab-2").hide();
															break;
														case 5:
															// $(".btn-to-be-disabled").prop('disabled',false);

															$("#body-dg-5").addClass('bg-dark');
															$("#number-text-5").removeClass('text-gray-800');
															$("#number-text-5").addClass('text-white');
															$(".show-for-tab-1").hide();
															$(".show-for-tab-2").hide();
															break;
														case 6:
															// $(".btn-to-be-disabled").prop('disabled',false);

															$("#body-dg-6").addClass('bg-dark');
															$("#number-text-6").removeClass('text-gray-800');
															$("#number-text-6").addClass('text-white');
															$(".show-for-tab-1").hide();
															$(".show-for-tab-2").hide();
															break;
														case 7:
															// $(".btn-to-be-disabled").prop('disabled',false);

															$("#body-dg-7").addClass('bg-dark');
															$("#number-text-7").removeClass('text-gray-800');
															$("#number-text-7").addClass('text-white');
															$(".show-for-tab-1").hide();
															$(".show-for-tab-2").hide();
															break;
														default:
															// code block
														}

														

													}

												});

									});
					
					
					$(".btnLoadSupervisor_applicstions_Tpp")
					.click(
							function(event) {
								// console.log('Clicked
								// btnLoadUnitApplicationsfrrv');
								var inbox_type = $(this).data('id');
								let request_type ='';
								
									request_type = 'load_applications_at_unit_by_inbox_type_tpp';
								
								// console.log(request_type)
								
								$
										.ajax({
											type : "POST",
											url : "Case_Management_Serv",
											data : {
												request_type : request_type,
												inbox_type : inbox_type,
											},

											success : function(
													jobdetails) {
												// console.log(jobdetails);

												var json_p = JSON.parse(jobdetails);

												
												datatable.search("").draw();
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
												
												let today = new Date().getTime(); 

												$(json_p.data)
														.each(
																function() {
																	let date_received = new Date(this.date_received).getTime(); 
																	var Difference_In_Days = parseInt((today - date_received) / (1000 * 3600 * 24)); 
																	// console.log("days
																	// " +
																	// parseInt(Difference_In_Days)
																	// );

																	datatable.row
																			.add(
																					[
																							/*
																							 * this.created_date,
																							 * this.job_worked_on_status,
																							 */

																							'<input type="checkbox"/>',
																							this.job_number,
																							this.ar_name,
																							this.business_process_sub_name,
																							this.date_received,
																							this.locality,
																							Difference_In_Days,
																							

																							'<form action="registration_application_progress_details_tpp" method="post">'
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

																});

												switch (inbox_type) {
												case 1:

													$(".btn-to-be-disabled").prop('disabled',true);

													$("#body-dg-1").addClass('bg-dark');
													$("#number-text-1").removeClass('text-gray-800');
													$("#number-text-1").addClass('text-white');
													$("tr").removeClass("tr-passed-3-days");
													$("tr").removeClass("tr-passed-5-days");
													$("tr").removeClass("tr-passed-7-days");
													datatable.column(6).visible(false)

													break;
												case 2:

													$(".btn-to-be-disabled").prop('disabled',false);
													$("#body-dg-2").addClass('bg-dark');
													$("#number-text-2").removeClass('text-gray-800');
													$("#number-text-2").addClass('text-white');
													$("tr").removeClass("tr-passed-3-days");
													$("tr").removeClass("tr-passed-5-days");
													$("tr").removeClass("tr-passed-7-days");
													
													datatable.column(6).visible(false)


													break;
												case 3:
													$(".btn-to-be-disabled").prop('disabled',false);

													$("#body-dg-3").addClass('bg-dark');
													$("#number-text-3").removeClass('text-gray-800');
													$("#number-text-3").addClass('text-white');
													$("tr").removeClass("tr-passed-3-days");
													$("tr").removeClass("tr-passed-5-days");
													$("tr").removeClass("tr-passed-7-days");
													datatable.column(6).visible(false)

													break;
												case 4:
													$(".btn-to-be-disabled").prop('disabled',true);

													$("#body-dg-4").addClass('bg-dark');
													$("#number-text-4").removeClass('text-gray-800');
													$("#number-text-4").addClass('text-white');
													
													datatable.column(6).visible(true)
													break;
												case 5:
													$(".btn-to-be-disabled").prop('disabled',false);

													$("#body-dg-5").addClass('bg-dark');
													$("#number-text-5").removeClass('text-gray-800');
													$("#number-text-5").addClass('text-white');
													break;
												case 6:
													$(".btn-to-be-disabled").prop('disabled',false);

													$("#body-dg-6").addClass('bg-dark');
													$("#number-text-6").removeClass('text-gray-800');
													$("#number-text-6").addClass('text-white');
													break;
												default:
													// code block
												}

												/*
												 * if (localStorage
												 * .getItem('user_level') < 2) { //
												 * $('th:nth-child(8), //
												 * th:nth-child(8)').hide(); //
												 * $('.to_hide_on_level_1').hide();
												 * datatable .column(7)
												 * .visible( false); }
												 */

											}

										});

							});
					
					
					
					
					
					$('#btnAddAlltoBatchlisttpp')
							.on(
									'click',
									function(e) {
										var job_purpose = $(
												"#txt_general_job_purpose")
												.val();

										// console.log('How how are you');
										if (job_purpose) {
											var confirmText = "Are you sure you want to add these application to the list?";
											if (confirm(confirmText)) {
												$(
														"#job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked")
														.each(
																function() {
																	var row = $(this).closest("tr")[0];
																	var job_number = row.cells[1].innerHTML;
																	var ar_name = row.cells[2].innerHTML;
																	var business_process_sub_name = row.cells[3].innerHTML;
																	addJobToBatchlist(
																			job_number,
																			ar_name,
																			business_process_sub_name,
																			job_purpose,
																		"");
																});
												prepareBatchlistModal();

												$(
														'#viewBatchlistModal #lbl_batch_type')
														.val('tpp');
											}
										} else {

											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										}

									});

					$('#btnAddAlltoBatchlistforsupervisor')
							.on(
									'click',
									function(e) {
										var job_purpose = $(
												"#txt_general_job_purpose")
												.val();

										// console.log('How how are you');
										if (job_purpose) {
											var confirmText = "Are you sure you want to add these application to the list?";
											if (confirm(confirmText)) {
												$(
														"#job_casemgtdetailsdataTable__supervisor_tpp input[type=checkbox]:checked")
														.each(
																function() {
																	var row = $(
																			this)
																			.closest(
																					"tr")[0];
																	var job_number = row.cells[1].innerHTML;
																	var ar_name = row.cells[2].innerHTML;
																	var business_process_sub_name = row.cells[3].innerHTML;
																	addJobToBatchlist(
																			job_number,
																			ar_name,
																			business_process_sub_name,
																			job_purpose,
																		"");
																});
												prepareBatchlistModal();

												$(
														'#viewBatchlistModal #lbl_batch_type')
														.val('tpp_supervisor');
											}
										} else {

											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										}

									});

					$('#btnAddAlltoBatchlistforsupervisor_to_cordinator')
							.on(
									'click',
									function(e) {
										var job_purpose = $(
												"#txt_general_job_purpose")
												.val();

										// console.log('How how are you');
										if (job_purpose) {
											var confirmText = "Are you sure you want to add these application to the list?";
											if (confirm(confirmText)) {
												$(
														"#job_casemgtdetailsdataTable__supervisor_tpp input[type=checkbox]:checked")
														.each(
																function() {
																	var row = $(
																			this)
																			.closest(
																					"tr")[0];
																	var job_number = row.cells[1].innerHTML;
																	var ar_name = row.cells[2].innerHTML;
																	var business_process_sub_name = row.cells[3].innerHTML;
																	addJobToBatchlist(
																			job_number,
																			ar_name,
																			business_process_sub_name,
																			job_purpose,
																		"");
																});
												prepareBatchlistModal();

												$(
														'#viewBatchlistModal #lbl_batch_type')
														.val(
																'tpp_supervisor_to_cordinator');
											}
										} else {

											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										}

									});

					$('#btn_sent_for_tpp_batchlist')
							.on(
									'click',
									function(e) {

										// console.log('Add to batchlist');
										$('#askForPurposeOfBatching').modal(
												'hide');

										var job_number = $("#bl_job_number_new")
												.val();
										// var send_by_id =
										// $("#modified_by_id").val();
										// var send_by =$("#modified_by").val();
										var ar_name = $("#bl_ar_name_new")
												.val();
										var business_process_sub_name = $(
												"#bl_business_process_sub_name_new")
												.val();
										var job_purpose = $(
												"#bl_job_purpose_new").val();
										if (job_purpose) {
											addJobToBatchlist(job_number,
													ar_name,
													business_process_sub_name,
													job_purpose,
												"");
											prepareBatchlistModal();
										} else {
											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Purpose of Bacthing Required </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										}

									});
					
					
					
					$('#viewRecordsInfoModal').on('show.bs.modal', function (e) {
						  // do something...
						var job_number =  $(e.relatedTarget).data('job_number');
						$("#notes_job_number_label").html(job_number);
						// console.log("notes modal" + job_number);
						$("#note_records_section").html("");
						
						
						
						
						$.ajax({
							 type: "POST",
							 url: "Case_Management_Serv",
							 data: {
				                	request_type: 'select_load_record_notes',
				                	job_number:job_number},
							 cache: false,
							 beforeSend: function () {
								// $('#district').html('<img
								// src="img/loading.gif" alt="" width="24"
								// height="24">');
							 },
							 success: function(jobdetails) {
								 // console.log(jobdetails);
								 var json_p = JSON.parse(jobdetails);
								 let counter = 1;
								 let content ='<div id="accordion">';
					              $(json_p).each(function () {
					            	 // console.log(this.an_division);
					               content = content + '<div class="card">'
					               
								    + '<div class="card-header" id="'+ this.created_date.replaceAll(' ','') + counter +'">'
								    + '  <h5 class="mb-0">'
								    + '  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#'
								    + this.created_by.replaceAll(' ','') + counter 
								    +'" aria-expanded="false" aria-controls="' + this.created_date.replaceAll(' ','') + counter +'">'
								    +  		this.an_division + ' by ' + this.created_by + ' on ' + this.created_date 
								    + '   </button>'
								    + '  </h5>'
								    + '</div>'
								
								    + '<div id="'+ this.created_by.replaceAll(' ','') + counter +'" class="collapse" aria-labelledby="'+ this.created_date.replaceAll(' ','') + counter + '" data-parent="#accordion">'
								    + '  <div class="card-body">'
								    +  		this.an_description
								    + ' </div>'
								    + '</div>'
								    + '</div> <br>';
					               counter ++;
								        
					              });
					              content = content + "</div>"
					              $("#note_records_section").html(content);

							 }
							 });
						
					});
					
					
					
					$('#btnSendAllForTpp').on('click',function(e) {
						if ($("#job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked").length > 0)
						{
						    // any one is checked
						
							var confirmText = "Are you sure you want to move these applications for TPP?";
							// console.log('How how are you');
						
						
								if (confirm(confirmText)) {
									let obj_p = [];
									$("#job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked").each(function() {
										var row = $(this).closest("tr")[0];
										var job_number = row.cells[1].innerHTML;
										var ar_name = row.cells[2].innerHTML;
										var business_process_sub_name = row.cells[3].innerHTML;
										obj_p.push({"job_number":job_number,"ar_name":ar_name,"business_process_sub_name":business_process_sub_name, "job_purpose":"Batched for Title Plan Preparation"});
									});
									
									let json_list = JSON.stringify(obj_p);
									
									
									$.ajax({
										 type: "POST",
										 url: "Case_Management_Serv",
										 data: {
							                	request_type: 'process_batch_list_tpp',
							                	
												list_of_application : json_list,
												send_to_name : 'TPP',
												send_to_id : 'TPP',
							                	},
										 cache: false,
										 beforeSend: function () {
											// $('#district').html('<img
											// src="img/loading.gif" alt=""
											// width="24" height="24">');
										 },
										 success: function(jobdetails) {
											 // console.log(jobdetails);
											 // var json_p =
												// JSON.parse(jobdetails);
											 $.notify(
														{
															message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Success! Jobs sent to all divisions for Title Plan Preparation <br><br></span>',
														}, {
															type : 'success', z_index : 9999
														}); 
											  
		
										 }
										 });	
		
								}else{
									
									$.notify(
											{
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">You canceled your previous action <br><br></span>',
											}, {
												type : 'danger' , z_index: 9999 
											}); 
								}
								
						}
						else
						{
							$.notify(
									{
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Pls select jobs to be sent <br><br></span>',
									}, {
										type : 'danger' , z_index: 9999 
									}); 
						  
						}

						
						

					});
					
					
					$('#btnAddAlltofinishedList').on('click',function(e) {
						// var job_purpose =
						// $("#txt_general_job_purpose").val();
						
						if ($("#job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked").length > 0)
						{
						    // any one is checked
						
							var confirmText = "Do you want to move all selected jobs to next Milestone? This action will notify clients that TPP completed and connot be reversed";
							// console.log('How how are you');
						
						
								if (confirm(confirmText)) {
									let obj_p = [];
									$("#job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked").each(function() {
										var row = $(this).closest("tr")[0];
										var job_number = row.cells[1].innerHTML;
										var ar_name = row.cells[2].innerHTML;
										var business_process_sub_name = row.cells[3].innerHTML;
										obj_p.push({"job_number":job_number});
									});
									
									let json_list = JSON.stringify(obj_p);
									
									
									$.ajax({
										 type: "POST",
										 url: "Case_Management_Serv",
										 data: {
							                	request_type: 'update_job_step_status_bulk',
							                	
												list_of_application : json_list
												
							                	},
										 cache: false,
										 beforeSend: function () {
											// $('#district').html('<img
											// src="img/loading.gif" alt=""
											// width="24" height="24">');
										 },
										 success: function(jobdetails) {
											// console.log(jobdetails);
											 // var json_p =
												// JSON.parse(jobdetails);
											 $.notify(
														{
															message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Success! Jobs updated as Records Verification Completed <br><br></span>',
														}, {
															type : 'success', z_index : 9999
														}); 
											  
		
										 }
										 });	
		
								}else{
									
									$.notify(
											{
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">You canceled your previous action <br><br></span>',
											}, {
												type : 'danger' , z_index: 9999 
											}); 
								}
								
						}
						else
						{
							$.notify(
									{
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Pls select jobs to be finished <br><br></span>',
									}, {
										type : 'danger' , z_index: 9999 
									}); 
						  
						}

						
						

					});
					
					
					
					
					
					$('button:contains("Finish Step")').hide();
					$('button:contains("Reverse to Prev")').hide();
					
					/*
					 * ======================================== Actions for User
					 * Management ==================
					 */

				});