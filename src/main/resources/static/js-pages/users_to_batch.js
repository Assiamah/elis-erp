$(document)
		.ready(
				function() {
					
					

					
					
					$('#radioBtnBatching a')
							.on(
									'click',
									function() {
										
										var sel = $(this).data('title');
										var tog = $(this).data('toggle');
										$('#' + tog).prop('value', sel);
										$("#btn_process_batchlist").hide();
										$("#btn_process_batchlist_tt").hide();
										$("#btn_process_batchlist_cs").hide();

										$('a[data-toggle="' + tog + '"]').not(
												'[data-title="' + sel + '"]')
												.removeClass('active')
												.addClass('notActive');
										$(
												'a[data-toggle="' + tog
														+ '"][data-title="'
														+ sel + '"]')
												.removeClass('notActive')
												.addClass('active');

												// console.log($('#batch_type').val());

										if ($('#batch_type').val() == 'Unit') {
											
											$('#unit-batching').show();
											$('#individual-batching').hide();
											$('#cabinet-batching').hide();

											$('#rs_unit-batching').show();
											$('#rs_individual-batching').hide();
											$('#rs_cabinet-batching').hide();

											// console.log("clicked here Unit");
											/*
											 * $('#adopted_value').prop("readonly",
											 * true);
											 * $('#assessed_value').prop("readonly",
											 * true);
											 */
										} else if ($('#batch_type').val() === 'Cabinet') {
											$('#unit-batching').hide();
											$('#cabinet-batching').show();
											$('#individual-batching').hide();

											$('#rs_unit-batching').hide();
											$('#rs_cabinet-batching').show();
											$('#rs_individual-batching').hide();

										} else {
											$('#unit-batching').hide();
											$('#cabinet-batching').hide();
											$('#individual-batching').show();

											$('#rs_unit-batching').hide();
											$('#rs_cabinet-batching').hide();
											$('#rs_individual-batching').show();
											// $('#unit_division_to_send_to').val(localStorage.getItem('division'));
											$('#division_to_send_to').trigger(
													"change");
											// $('#unit_division_to_send_to').val('${division}').change()
											// console.log("clicked Indi")
										}
									});

					$('#unit_division_to_send_to, #unit_division_to_send_to_2')
							.change(
									function() {
										 //alert("d");
										var selected_division = $(this).val();

										$("#unit_to_send_to").val("");
										$("#btn_process_batchlist").hide();
										$("#btn_process_batchlist_tt").hide();
										$("#btn_process_batchlist_cs").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_units',
													},
													cache : false,
													success : function(
															jobdetails) {

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var datalist = $("#listofunitsbatching");
														datalist.empty();

														$(json_p.data)
																.each(
																		function() {
																			// console.log("Outer
																			// " +
																			// this.unit_division
																			// + "
																			// - "
																			// +
																			// this.unit_name);
																			if (this.unit_division
																					.includes(selected_division)) {
																				// console.log("Inner
																				// " +
																				// this.unit_division
																				// + "
																				// - "
																				// +
																				// this.unit_name);
																				datalist
																						.append('<option data-name="'
																								+ this.unit_name
																								+ '" data-id="'
																								+ this.unit_id
																								+ '" value="'
																								+ this.unit_name
																								+ '" ></option>');
																			}
																		});
													}
												});

									});

									$('#get_change_region_compliance_crb')
							.change(
									function() {
										$("#unit_to_send_to_crb").val("");
										$('#unit_division_to_send_to_crb').val("")
										$("#btn_process_batchlist_crb").hide();
									});

					$('#unit_division_to_send_to_crb')
							.change(
									function() {
										 //alert("d");
										var selected_division = $(this).val();

										var region_id = $("#get_change_region_compliance_crb").val()
										console.log(region_id)

										if(!region_id){
											toastr.error("Please select region");
											return;
										}

										$("#unit_to_send_to_crb").val("");
										$("#btn_process_batchlist_crb").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_units_manage',
														office_id:region_id.replace(".0","")
													},
													cache : false,
													success : function(
															jobdetails) {

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var datalist = $("#listofunitsbatching");
														datalist.empty();

														$(json_p.data)
																.each(
																		function() {
																			// console.log("Outer
																			// " +
																			// this.unit_division
																			// + "
																			// - "
																			// +
																			// this.unit_name);
																			if (this.unit_division
																					.includes(selected_division)) {
																				// console.log("Inner
																				// " +
																				// this.unit_division
																				// + "
																				// - "
																				// +
																				// this.unit_name);
																				datalist
																						.append('<option data-name="'
																								+ this.unit_name
																								+ '" data-id="'
																								+ this.unit_id
																								+ '" value="'
																								+ this.unit_name
																								+ '" ></option>');
																			}
																		});
													}
												});

									});

									

									$('#unit_to_send_to_crb')
							.change(
									function() {
										$("#btn_process_batchlist_crb").show();
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

									$("#btn_process_batchlist_crb")
							.click(
									function(event) {

										 var confirmed = confirm("Are you sure you want to move applicaiton(s)?");

                                         if (confirmed) {
                                            
										

										// alert(JSON.stringify(table));
										let bl_job_purpose_new = $("#bl_job_purpose_new").val();
										let bl_remarks_notes = $("#bl_remarks_notes").val();

										if(!bl_job_purpose_new || bl_job_purpose_new == '-- Select --' || bl_job_purpose_new == '0' || !bl_remarks_notes){
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please fill up all the fields</span>',
											}, { type : 'danger' , z_index: 9999  });
											return;
										}
										
																				

										//var is_map_plotting = $("#is_map_plotting").val() == '' ? 'no' : $("#is_map_plotting").val();

										//var is_map_plotting = $("#is_map_plotting").val() == undefined ? 'no' : $("#is_map_plotting").val();

										var region_id = $("#get_change_region_compliance_crb").val()
										var region_name = $("#get_change_region_compliance_crb option:selected").text();
										console.log(region_name)
										var unit_division_to_send_to_crb = $("#unit_division_to_send_to_crb").val()

											request_type = 'process_batch_list_unit_crb';
											var userid_1 = $("#unit_to_send_to_crb")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofunitsbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');
											var send_to_name = $(
													'#listofunitsbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										

										//console.log(request_type);

										var table = storeTblValues();
										list_of_application_new = JSON
												.stringify(table);
										console.log(list_of_application_new);

										/*
										 * console.log("request_type: " +
										 * request_type); console.log("userid_1 " +
										 * userid_1); console.log("sender " +
										 * send_to_name); console.log("sender " +
										 * send_to_id);
										 */

										function storeTblValues() {
											var TableData = new Array();

											$('#tbl-appData_tranfer tr')
													.each(
															function(row, tr) {
																TableData[row] = {
																	"job_number" : $(
																			tr)
																			.find(
																					'td:eq(2)')
																			.text()
																			.trim(),
																	"ar_name" : $(
																			tr)
																			.find(
																					'td:eq(0)')
																			.text()
																			.trim(),
																	"job_purpose" : bl_job_purpose_new,
																	"business_process_sub_name" : $(
																			tr)
																			.find(
																					'td:eq(3)')
																			.text()
																			.trim(),
																	"remarks_notes" : bl_remarks_notes,
																// "send_to_name"
																// :
																// send_to_name,
																// "send_to_id"
																// : send_to_id
																}
															});
											TableData.shift(); // first row
											// will be empty
											// - so remove
											return TableData;
										}

										if(list_of_application_new == '[]'){
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select at least one application</span>',
											}, { type : 'danger' , z_index: 9999  });
											return;
										}

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : request_type,
														division : localStorage.getItem('division'),
														list_of_application : list_of_application_new,
														send_to_name : send_to_name,
														send_to_id : send_to_id,
														region_id : region_id.replace(".0",""),
														region_name: region_name,
														divison_name : unit_division_to_send_to_crb
														//is_map_plotting : is_map_plotting
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(response) {
														console.log(response)

														var json_p = JSON
																.parse(response);

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
														// var userid_1 = $(
														// "#user_to_send_to"
														// ).val();

														// $('#modified_by').val(localStorage.getItem('fullname'));
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
																		request_type : 'request_to_generate_batch_list',
																		list_of_application : list_of_application_new,
																		batch_number : json_p.batch_number,
																		modified_by : localStorage
																				.getItem('fullname'),
																		modified_by_id : localStorage
																				.getItem('userid'),
																		send_to_name : send_to_name,
																		send_to_id : send_to_id
																	},
																	cache : false,
																	xhrFields : {
																		responseType : 'blob'
																	},
																	beforeSend : function() {
																		// $('#district').html('<img
																		// src="img/loading.gif"
																		// alt=""
																		// width="24"
																		// height="24">');
																		// console.log("before
																		// ajax");

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
																		// window.open(objectUrl);
																		console
																				.log("success ajax");

																		$(
																				'#elisdovumentpreviewblobfile')
																				.attr(
																						'src',
																						objectUrl);

																	},
																	complete : function() {
																		console
																				.log("Completed ajax");
																		$(
																				'#viewBatchlistModal')
																				.modal(
																						'hide');
																		console
																				.log("Completed 3 ajax");
																		// Clear
																		// Local
																		// storage
																		// Bactlist
																		localStorage
																				.setItem(
																						'batchlistdata',
																						'');
																		// prepareBatchlistModal();

																		var tablex = $('#tbl-appData_tranfer');
																		 tablex.find('tbody').empty();

																	}
																});

													}
												});

											}

									});

					$('#division_to_send_to')
							.change(
									function() {
										var selected_division = $(this).val();
										$("#user_to_send_to").val("");
										$("#btn_process_batchlist").hide();
										$("#btn_process_batchlist_tt").hide();
										$("#btn_process_batchlist_cs").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_users',
													},
													cache : false,
													success : function(
															jobdetails) {
														let regional_code_general = $("#regional_code_general").text();
														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var datalist = $("#listofusersbatching");
														datalist.empty();

														$(json_p)
																.each(
																		function() {
																			if (selected_division == this.unit_name && regional_code_general==this.regional_code) {
																				// console.log(this.division
																				// + "
																				// - "
																				// +
																				// this.userid);
																				datalist
																						.append('<option data-name="'
																								+ this.fullname
																								+ '" data-id="'
																								+ this.userid
																								+ '" value="'
																								+ this.fullname
																								+ '" ></option>');
																			}
																		});
													}
												});

									});

									$('#unit_to_send_to, #unit_to_send_to_2')
									.change(
											function() {
												var selected_division = $(this).val();
												$("#user_to_send_to").val("");
												$("#btn_process_batchlist").hide();
												$("#btn_process_batchlist_tt").hide();
												$("#btn_process_batchlist_cs").hide();
												$
														.ajax({
															type : "POST",
															url : "Case_Management_Serv",
															data : {
																request_type : 'get_lc_list_of_users',
															},
															cache : false,
															success : function(
																	jobdetails) {
																let regional_code_general = $("#regional_code_general").text();
																console.log(jobdetails);
																var json_p = JSON
																		.parse(jobdetails);
																var datalist = $("#listofusersbatching");
																datalist.empty();
		
																$(json_p)
																		.each(
																				function() {
																					if (selected_division == this.unit_name && regional_code_general==this.regional_code) {
																						// console.log(this.division
																						// + "
																						// - "
																						// +
																						// this.userid);
																						datalist
																								.append('<option data-name="'
																										+ this.fullname
																										+ '" data-id="'
																										+ this.userid
																										+ '" value="'
																										+ this.fullname
																										+ '" ></option>');
																					}
																				});
															}
														});
		
											});

					$("#btn_process_batchlist")
							.click(
									function(event) {

										// alert(JSON.stringify(table));
										let
										request_type = "";
										var list_of_application_new = JSON
												.stringify(table)
										var lbl_batch_type = $(
												"#lbl_batch_type").val();
										//btn_process_batchlist

										console.log(lbl_batch_type)
																				

										//var is_map_plotting = $("#is_map_plotting").val() == '' ? 'no' : $("#is_map_plotting").val();

										var is_map_plotting = $("#is_map_plotting").val() == undefined ? 'no' : $("#is_map_plotting").val();

										if ($('#batch_type').val() === 'Unit') {

											request_type = 'process_batch_list_unit';
											var userid_1 = $("#unit_to_send_to")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofunitsbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');
											var send_to_name = $(
													'#listofunitsbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										} else {
											request_type = 'process_batch_list_new';
											var userid_1 = $("#user_to_send_to")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofusersbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');
											var send_to_name = $(
													'#listofusersbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										}

										if (lbl_batch_type === 'frrv') {
											request_type = 'process_batch_list_frrv';
										}

										if (lbl_batch_type === 'frrv_supervisor') {
											request_type = 'process_batch_list_frrv_supervisor';
										}

										if (lbl_batch_type === 'frrv_supervisor_to_cordinator') {
											request_type = 'process_batch_list_frrv_supervisor_to_cordinator';
										}
										
										if (lbl_batch_type === 'tpp') {
											request_type = 'process_batch_list_tpp';
										}

										if (lbl_batch_type === 'tpp_supervisor') {
											request_type = 'process_batch_list_tpp_supervisor';
										}

										if (lbl_batch_type === 'tpp_supervisor_to_cordinator') {
											request_type = 'process_batch_list_tpp_supervisor_to_cordinator';
										}
										if (lbl_batch_type === 'cst') {
											request_type = 'process_batch_list_cst';
										}

										if (lbl_batch_type === 'cst_supervisor') {
											request_type = 'process_batch_list_cst_supervisor';
										}

										if (lbl_batch_type === 'cst_supervisor_to_cordinator') {
											request_type = 'process_batch_list_cst_supervisor_to_cordinator';
										}
										if (lbl_batch_type === 'frrv_cst') {
											request_type = 'process_batch_list_frrv_cst';
										}

										if (lbl_batch_type === 'frrv_cst_supervisor') {
											request_type = 'process_batch_list_frrv_cst_supervisor';
										}

										if (lbl_batch_type === 'frrv_cst_supervisor_to_cordinator') {
											request_type = 'process_batch_list_frrv_cst_supervisor_to_cordinator';
										}

										//console.log(request_type);

										var table = storeTblValues();
										list_of_application_new = JSON
												.stringify(table);
										console.log(list_of_application_new);

										/*
										 * console.log("request_type: " +
										 * request_type); console.log("userid_1 " +
										 * userid_1); console.log("sender " +
										 * send_to_name); console.log("sender " +
										 * send_to_id);
										 */

										function storeTblValues() {
											var TableData = new Array();

											$('#batchlistdataTable tr')
													.each(
															function(row, tr) {
																TableData[row] = {
																	"job_number" : $(
																			tr)
																			.find(
																					'td:eq(0)')
																			.text()
																			.trim(),
																	"ar_name" : $(
																			tr)
																			.find(
																					'td:eq(1)')
																			.text()
																			.trim(),
																	"job_purpose" : $(
																			tr)
																			.find(
																					'td:eq(3)')
																			.text()
																			.trim(),
																	"business_process_sub_name" : $(
																			tr)
																			.find(
																					'td:eq(2)')
																			.text()
																			.trim(),
																	"remarks_notes" : $(
																		tr)
																		.find(
																				'td:eq(4)')
																		.text()
																		.trim(),
																// "send_to_name"
																// :
																// send_to_name,
																// "send_to_id"
																// : send_to_id
																}
															});
											TableData.shift(); // first row
											// will be empty
											// - so remove
											return TableData;
										}

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : request_type,
														division : localStorage
																.getItem('division'),
														list_of_application : list_of_application_new,
														send_to_name : send_to_name,
														send_to_id : send_to_id,
														is_map_plotting : is_map_plotting
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(response) {
														console.log(response)

														var json_p = JSON
																.parse(response);

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
														// var userid_1 = $(
														// "#user_to_send_to"
														// ).val();

														// $('#modified_by').val(localStorage.getItem('fullname'));
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
																		request_type : 'request_to_generate_batch_list',
																		list_of_application : list_of_application_new,
																		batch_number : json_p.batch_number,
																		modified_by : localStorage
																				.getItem('fullname'),
																		modified_by_id : localStorage
																				.getItem('userid'),
																		send_to_name : send_to_name,
																		send_to_id : send_to_id
																	},
																	cache : false,
																	xhrFields : {
																		responseType : 'blob'
																	},
																	beforeSend : function() {
																		// $('#district').html('<img
																		// src="img/loading.gif"
																		// alt=""
																		// width="24"
																		// height="24">');
																		// console.log("before
																		// ajax");

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
																		// window.open(objectUrl);
																		console
																				.log("success ajax");

																		$(
																				'#elisdovumentpreviewblobfile')
																				.attr(
																						'src',
																						objectUrl);

																	},
																	complete : function() {
																		console
																				.log("Completed ajax");
																		$(
																				'#viewBatchlistModal')
																				.modal(
																						'hide');
																		console
																				.log("Completed 3 ajax");
																		// Clear
																		// Local
																		// storage
																		// Bactlist
																		localStorage
																				.setItem(
																						'batchlistdata',
																						'');
																		// prepareBatchlistModal();

																	}
																});

													}
												});

									});

					$("#unit_to_send_to, #user_to_send_to ")
							.on(
									'change',
									function() {

										console.log($('#batch_type').val())

										if ($('#batch_type').val() === 'Unit') {
											
											var userid_1 = $("#unit_to_send_to")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofunitsbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');
															console.log(send_to_id)
											var send_to_name = $(
													'#listofunitsbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										} else if ($('#batch_type').val() === 'Cabinet') {
											// alert();
										} else {
											var userid_1 = $("#user_to_send_to")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofusersbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');

															console.log(send_to_id)
											var send_to_name = $(
													'#listofusersbatching option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										}

										if (send_to_id) {
											$("#btn_process_batchlist").show();
											$("#btn_process_batchlist_tt").show();
											$("#btn_process_batchlist_cs").show();
										} else {
											$("#btn_process_batchlist").hide();
											$("#btn_process_batchlist_tt").hide();
											$("#btn_process_batchlist_cs").hide();
										}

									});

					$("#btn_approve_registration_process")
							.click(
									function(event) {
										$('#stepconfirmationDialog').modal(
												'hide');

										var active_queries = $(
												"#cs_main_active_queries")
												.val();
										var active_objections = $(
												"#cs_main_active_objections")
												.val();

										if (!active_objections
												|| !active_queries
												|| active_queries > 0
												|| active_objections > 0) {
											$
													.notify(
															{
																message : '<div class="row"><div class="col-sm-2"><i class="fa fa-exclamation  fa-4x fa-fw"></i></div><div class="col-sm-8"><span class="text-bold">Sorry!!! Your request cannot be processed because the Application has a pending Query or Objection </span></div></div',
															}, {
																type : 'danger' , z_index: 9999 
															});
										} else {
											// do Update of Process Step

											var job_number = $(
													"#cs_main_job_number")
													.val();
											var current_step_number = $(
													"#cs_main_application_stage")
													.val();
											var business_process_id = $(
													"#cs_main_business_process_id")
													.val();
											var business_process_sub_id = $(
													"#cs_main_business_process_sub_id")
													.val();
											var business_process_name = $(
													"#cs_main_business_process_name")
													.val();
											var business_process_sub_name = $(
													"#cs_main_business_process_sub_name")
													.val();
											var client_number = $(
													"#cs_main_client_number")
													.val();
											var client_name = $(
													"#cs_main_ar_name").val();

											// stepContent
											console
											var created_by = localStorage
													.getItem("fullname");
											var created_by_id = localStorage
													.getItem("userid");

											$
													.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'update_job_step_status',
															current_step_number : current_step_number,
															business_process_id : business_process_id,
															business_process_sub_id : business_process_sub_id,
															job_number : job_number,

															business_process_name : business_process_name,
															business_process_sub_name : business_process_sub_name,
															client_number : client_number,
															client_name : client_name,

															created_by : created_by,
															created_by_id : created_by_id
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
															console
																	.log(jobdetails);
															$(
																	"#general_message_dialog")
																	.modal();
															// $('#general_message_dialog
															// #general_message_dialog_msg').val(jobdetails);
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			jobdetails);

															setTimeout(
																	function() {
																		window.history
																				.go(-1);
																	}, 1000);
														}

													});

											// $('#smartwizardfirstregistration').smartWizard("next");
										}
										return true;
									});

									$("#btn_approve_map_plotting_process")
									.click(
											function(event) {
												$('#stepconfirmationDialog').modal(
														'hide');
		
												var active_queries = $(
														"#cs_main_active_queries")
														.val();
												var active_objections = $(
														"#cs_main_active_objections")
														.val();
		
												if (!active_objections
														|| !active_queries
														|| active_queries > 0
														|| active_objections > 0) {
													$
															.notify(
																	{
																		message : '<div class="row"><div class="col-sm-2"><i class="fa fa-exclamation  fa-4x fa-fw"></i></div><div class="col-sm-8"><span class="text-bold">Sorry!!! Your request cannot be processed because the Application has a pending Query or Objection </span></div></div',
																	}, {
																		type : 'danger' , z_index: 9999 
																	});
												} else {
													// do Update of Process Step
		
													var job_number = $(
															"#cs_main_job_number")
															.val();
													var current_step_number = $(
															"#cs_main_application_stage")
															.val();
													var business_process_id = $(
															"#cs_main_business_process_id")
															.val();
													var business_process_sub_id = $(
															"#cs_main_business_process_sub_id")
															.val();
													var business_process_name = $(
															"#cs_main_business_process_name")
															.val();
													var business_process_sub_name = $(
															"#cs_main_business_process_sub_name")
															.val();
													var client_number = $(
															"#cs_main_client_number")
															.val();
													var client_name = $(
															"#cs_main_ar_name").val();
		
													// stepContent
													var created_by = localStorage
															.getItem("fullname");
													var created_by_id = localStorage
															.getItem("userid");
		
													$
															.ajax({
																type : "POST",
																url : "Case_Management_Serv",
																data : {
																	request_type : 'update_map_plotting_step_status',
																	current_step_number : current_step_number,
																	business_process_id : business_process_id,
																	business_process_sub_id : business_process_sub_id,
																	job_number : job_number,
		
																	business_process_name : business_process_name,
																	business_process_sub_name : business_process_sub_name,
																	client_number : client_number,
																	client_name : client_name,
		
																	created_by : created_by,
																	created_by_id : created_by_id
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
																	console
																			.log(jobdetails);
																	$(
																			"#general_message_dialog")
																			.modal();
																	// $('#general_message_dialog
																	// #general_message_dialog_msg').val(jobdetails);
																	$(
																			'#general_message_dialog #general_message_dialog_msg_new')
																			.val(
																					jobdetails);
		
																	// setTimeout(
																	// 		function() {
																	// 			window.history
																	// 					.go(-1);
																	// 		}, 1000);

																	// 		setTimeout(function(){
																	// 			window.location.reload();
																	// 		 }, 5000);

																	var coor_tbl = $("#job_coor_tbl").DataTable({
																		// responsive: true,
												
																		stateSave : true,
																		"createdRow" : function(row, data, dataIndex) {
																			if (data[0] == "1") {
																				$(row).addClass('tr-completed-work');
																			}
																		},
												
																	/*
																	 * columns: [ { // Responsive control column data:
																	 * null, defaultContent: '', className: 'control',
																	 * orderable: false },
																	 *  ],
																	 */
																	});
												
																	//console.log(111111111)
											
												
																	$("#transitionalcaseModal").modal('show');
																	$('#job_coor_tbl').DataTable().clear().destroy();
												
																	$.ajax({
												
																		type : "POST",
																			url : "Case_Management_Serv",
																			data : {
																				request_type : 'load_transitional_plotting_application_batched_to_user',
																				// job_number : enq_search_value,
																				// search_type: enq_search_type
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

																	setTimeout(
																		function() {
																			window.history
																					.go(-1);
																		}, 1000);
																	
																}
		
															});
		
													// $('#smartwizardfirstregistration').smartWizard("next");
												}
												return true;
											});


											$("#general_message_dialog").on('hidden.bs.modal', function() { 

												console.log("okkkkk")
						
												var plotting_page_name = $("#plotting_page_name").val();
						
												if(plotting_page_name == "coordinate_entry_and_record_verification") {
						
													window.location.replace("/coordinate_entry_and_record_verification");
						
												} else if(plotting_page_name == "plot_vetting_and_approval"){
						
													window.location.replace("/plot_vetting_and_approval");
												}
											  });

					$("#btn_reverse_approve_registration_process")
							.click(
									function(event) {
										$('#stepreverseconfirmationDialog')
												.modal('hide');

										// do Update of Process Step
										var active_queries = $(
												"#cs_main_active_queries")
												.val();
										var active_objections = $(
												"#cs_main_active_objections")
												.val();

										if (!active_objections
												|| !active_queries
												|| active_queries > 0
												|| active_objections > 0) {
											$
													.notify(
															{
																message : '<div class="row"><div class="col-sm-2"><i class="fa fa-exclamation  fa-4x fa-fw"></i></div><div class="col-sm-8"><span class="text-bold">Sorry!!! Your request cannot be processed because the Application has a pending Query or Objection </span></div></div',
															}, {
																type : 'danger' , z_index: 9999 
															});
										} else {
											var job_number = $(
													"#cs_main_job_number")
													.val();
											var current_step_number = $(
													"#cs_main_application_stage")
													.val();
											var business_process_id = $(
													"#cs_main_business_process_id")
													.val();
											var business_process_sub_id = $(
													"#cs_main_business_process_sub_id")
													.val();
											var business_process_name = $(
													"#cs_main_business_process_name")
													.val();
											var business_process_sub_name = $(
													"#cs_main_business_process_sub_name")
													.val();
											var client_number = $(
													"#cs_main_client_number")
													.val();
											var client_name = $(
													"#cs_main_ar_name").val();

											// stepContent
											console
											var created_by = localStorage
													.getItem("fullname");
											var created_by_id = localStorage
													.getItem("userid");

											$
													.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'update_job_step_status_reverse',
															current_step_number : current_step_number,
															business_process_id : business_process_id,
															business_process_sub_id : business_process_sub_id,
															job_number : job_number,

															business_process_name : business_process_name,
															business_process_sub_name : business_process_sub_name,
															client_number : client_number,
															client_name : client_name,

															created_by : created_by,
															created_by_id : created_by_id
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
															console
																	.log(jobdetails);
															$(
																	"#general_message_dialog")
																	.modal();
															// $('#general_message_dialog
															// #general_message_dialog_msg').val(jobdetails);
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			jobdetails);

															setTimeout(
																	function() {
																		window.history
																				.go(-1);
																	}, 1000);
														}

													});

											$('#smartwizardfirstregistration')
													.smartWizard("prev");

										}
										return true;
									});

					$("#frmBatchToCabinet")
							.on(
									'submit',
									function(event) {

										// alert(JSON.stringify(table));
										var list_of_application_new = JSON
												.stringify(table)

										var cabinet_name = $(
												'#cabinet_to_send_to').val();

										var table = storeTblValues();
										list_of_application_new = JSON
												.stringify(table);
										console.log(list_of_application_new);

										/*
										 * console.log("request_type: " +
										 * request_type); console.log("userid_1 " +
										 * userid_1); console.log("sender " +
										 * send_to_name); console.log("sender " +
										 * send_to_id);
										 */

										function storeTblValues() {
											var TableData = new Array();

											$('#batchlistdataTable tr')
													.each(
															function(row, tr) {
																TableData[row] = {
																	"job_number" : $(
																			tr)
																			.find(
																					'td:eq(0)')
																			.text()
																			.trim(),
																	"ar_name" : $(
																			tr)
																			.find(
																					'td:eq(1)')
																			.text()
																			.trim(),
																	"job_purpose" : $(
																			tr)
																			.find(
																					'td:eq(3)')
																			.text()
																			.trim(),
																	"business_process_sub_name" : $(
																			tr)
																			.find(
																					'td:eq(2)')
																			.text()
																			.trim()
																// "send_to_name"
																// :
																// send_to_name,
																// "send_to_id"
																// : send_to_id
																}
															});
											TableData.shift(); // first row
											// will be empty
											// - so remove
											return TableData;
										}

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'process_batch_list_cabinet',
														division : localStorage
																.getItem('division'),
														list_of_application : list_of_application_new,
														cabinet_name : cabinet_name,
													},
													cache : false,
													success : function(response) {
														//console.log(response)

														var json_p = JSON
																.parse(response);

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
														// var userid_1 = $(
														// "#user_to_send_to"
														// ).val();

														// $('#modified_by').val(localStorage.getItem('fullname'));
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
																		request_type : 'request_to_generate_batch_list',
																		list_of_application : list_of_application_new,
																		batch_number : json_p.batch_number,
																		modified_by : localStorage
																				.getItem('fullname'),
																		modified_by_id : localStorage
																				.getItem('userid'),
																		send_to_name : cabinet_name,
																		send_to_id : '0'
																	},
																	cache : false,
																	xhrFields : {
																		responseType : 'blob'
																	},
																	beforeSend : function() {
																		// $('#district').html('<img
																		// src="img/loading.gif"
																		// alt=""
																		// width="24"
																		// height="24">');
																		// console.log("before
																		// ajax");

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
																		var objectUrl = URL.createObjectURL(blob);
																		window.open(objectUrl);
																		//console.log("success ajax");

																		$('#elisdovumentpreviewblobfile').attr('src',objectUrl);

																	},
																	complete : function() {
																		//console.log("Completed ajax");
																		$('#viewBatchlistModal').modal('hide');
																		//console.log("Completed 3 ajax");
																		// Clear
																		// Local
																		// storage
																		// Bactlist
																		localStorage.setItem('batchlistdata','');
																		// prepareBatchlistModal();

																	}
																});

													}
												});

									});

					
					

					/*
					 * ======================================== Actions for User
					 * Management ==================
					 */

				});