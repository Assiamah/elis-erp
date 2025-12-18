$(document)
		.ready(
				function() {
					
					
					$('#office_region_on_tc')
					.change(
							function() {
								// alert($(this).val());

								var sub_service = $(this).val();

								const
								sub_service_name_id = sub_service
										.split('_');

								var main_service_id = sub_service_name_id[0];
								var main_service_name = sub_service_name_id[1];

								// console.log(main_service_id);
								// console.log(main_service_name);

								$
										.ajax({
											type : "POST",
											url : "Case_Management_Serv",
											data : {
												request_type : 'get_list_of_locality',
												region_id : main_service_id
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
												var options = $("#locality_on_tc");

												// var options =
												// $("#selector");
												options.empty();
												options
														.append(new Option(
																"-- Select --",
																0));

												$(json_p)
														.each(
																function() {

																	$(
																			'#locality_on_tc')
																			.append(
																					'<option value="'

																							+ this.location_name
																							+ '">'
																							+ this.location_name
																							+ '</option>');

																});
											}
										});

							});

					
					
					
					$('#office_region_on_tc_e')
					.change(
							function() {
								// alert($(this).val());

								var sub_service = $(this).val();

								const
								sub_service_name_id = sub_service
										.split('_');

								var main_service_id = sub_service_name_id[0];
								var main_service_name = sub_service_name_id[1];

								 console.log(main_service_id);
								 console.log(main_service_name);

								$
										.ajax({
											type : "POST",
											url : "Case_Management_Serv",
											data : {
												request_type : 'get_list_of_locality',
												region_id : main_service_id
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
												var options = $("#locality_on_tc_e");

												// var options =
												// $("#selector");
												options.empty();
												options
														.append(new Option(
																"-- Select --",
																0));

												$(json_p)
														.each(
																function() {

																	$(
																			'#locality_on_tc_e')
																			.append(
																					'<option value="'

																							+ this.location_name
																							+ '">'
																							+ this.location_name
																							+ '</option>');

																});
											}
										});

							});
					
					
					
					
					
					$('#CreateJobNumberModal')
							.on(
									'show.bs.modal',
									function(event) {

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_temporal_service',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#main_service_on_tc");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			//console.log(this.business_process_id);

																			// if
																			// (this.business_process_on_case
																			// ==
																			// 'No')
																			// {
																			$(
																					'#main_service_on_tc')
																					.append(
																							'<option value="'
																									+ this.business_process_id
																									+ '-'
																									+ this.business_process_name
																									+ '">'
																									+ this.business_process_name
																									+ '</option>');
																			// }

																		});

														// business_process_id
													}
												});

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_type_of_use_list',
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

														console.log("Type of use: " + jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#type_of_use_on_tc");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			// console.log(this.business_process_id);

																			// if
																			// (main_service_id
																			// ==this.business_process_id){
																			$(
																					'#type_of_use_on_tc')
																					.append(
																							'<option value="'
																									+ this.typeofuse_id
																									+ '_'
																									+ this.typeofuse_name
																									+ '">'
																									+ this.typeofuse_name
																									+ '</option>');

																			// }

																		});
														// business_process_id
													}
												});


												$
												.ajax({
													type : "POST",
													url : "app_modal_fills_serv",
													data : {
														request_type : 'get_all_office_region',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#office_region_on_tc");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			// console.log(this.business_process_id);

																			// if
																			// (main_service_id
																			// ==this.business_process_id){
																			$(
																					'#office_region_on_tc')
																					.append(
																							'<option value="'
																									+ this.ord_region_code
																									+ '_'
																									+ this.ord_region_name
																									+ '">'
																									+ this.ord_region_name
																									+ '</option>');

																			// }

																		});
														// business_process_id
													}
												});

									});

					$('#main_service_on_tc')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_on_tc");
										var main_service = select_id.options[select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_sub_service',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#sub_service_on_tc");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			console
																					.log(select_id);
																			console
																					.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				// if
																				// (this.business_process_on_case
																				// ==
																				// 'No')
																				// {
																				$(
																						'#sub_service_on_tc')
																						.append(
																								'<option value="'
																										+ this.business_process_sub_id
																										+ '-'
																										+ this.business_process_sub_name
																										+ '">'
																										+ this.business_process_sub_name
																										+ '</option>');

																				// }

																			}

																		});
														// business_process_id
													}
												});

										/*
										 * $.each(data, function() {
										 * 
										 * });
										 */

										// var sub_select_id =
										// document.getElementById("sub_service_on_case");
										// var
										// sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
									});
					$('#btn_create_new_job_and_case_number')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_on_tc");
										var main_service = select_id.options[select_id.selectedIndex].value;

										var sub_select_id = document
												.getElementById("sub_service_on_tc");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');
										const
										sub_service_name_id = sub_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);
										console.log(main_service_name);
										console.log(sub_service_id);
										console.log(sub_service_name);

										main_service_id = main_service_id
												.replace('.0', '');

										var new_land_size = '0';

										var applicant_name_on_tc = $(
												"#applicant_name_on_tc").val();

										land_size_on_tc = $("#land_size_on_tc")
												.val();
										//console.log(new_land_size);
										var office_region_on_tc = $("#office_region_on_tc").val();
										
										const office_region_name_id = office_region_on_tc.split('_');
										var office_region_id = office_region_name_id[0];
										var office_region_name = office_region_name_id[1];
										
										
										
										
										
										
										var locality_on_tc = $(
												"#locality_on_tc").val();
										var type_of_use_on_tc = $(
												"#type_of_use_on_tc").val();

										var type_of_interest_on_tc = $(
												"#type_of_interest_on_tc")
												.val();
										var nature_of_instrument_on_tc = $(
												"#nature_of_instrument_on_tc")
												.val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'online_select_process_acknowledgement_not_on_case_exist',
														main_service_id : main_service_id,
														main_service_sub_id : sub_service_id,
														main_service_desc : main_service_name,
														main_service_sub_desc : sub_service_name,
														client_name : applicant_name_on_tc,
														land_size : land_size_on_tc,
														locality : locality_on_tc,
														type_of_use : type_of_use_on_tc,
														type_of_interest : type_of_interest_on_tc,
														nature_of_instrument : nature_of_instrument_on_tc,
														office_region_id: office_region_id,
														office_region_name:office_region_name
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',

													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

														console.log(jobdetails);

														var json_p = JSON
																.parse(jobdetails);

														// $('#addlrdtransaction
														// #lrd_td_gid').val(gid);
														$("#job_number_on_tc")
																.val(
																		json_p.job_number);
														$("#case_number_on_tc")
																.val(
																		json_p.case_number);
													}
												});

									});
					$('#CreateJobNumberModalExisting')
							.on(
									'show.bs.modal',
									function(event) {

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_main_service',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#main_service_on_tc_e");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			console
																					.log(this.business_process_id);

																			// if
																			// (this.business_process_on_case
																			// ==
																			// 'No')
																			// {
																			$(
																					'#main_service_on_tc_e')
																					.append(
																							'<option value="'
																									+ this.business_process_id
																									+ '-'
																									+ this.business_process_name
																									+ '">'
																									+ this.business_process_name
																									+ '</option>');
																			// }

																		});

														// business_process_id
													}
												});

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_type_of_use_list',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#type_of_use_on_tc_e");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			// console.log(this.business_process_id);

																			// if
																			// (main_service_id
																			// ==this.business_process_id){
																			$(
																					'#type_of_use_on_tc_e')
																					.append(
																							'<option value="'
																									+ this.typeofuse_id
																									+ '_'
																									+ this.typeofuse_name
																									+ '">'
																									+ this.typeofuse_name
																									+ '</option>');

																			// }

																		});
														// business_process_id
													}
												});



												$
												.ajax({
													type : "POST",
													url : "app_modal_fills_serv",
													data : {
														request_type : 'get_all_office_region',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#office_region_on_tc_e");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			// console.log(this.business_process_id);

																			// if
																			// (main_service_id
																			// ==this.business_process_id){
																			$(
																					'#office_region_on_tc_e')
																					.append(
																							'<option value="'
																									+ this.ord_region_code
																									+ '_'
																									+ this.ord_region_name
																									+ '">'
																									+ this.ord_region_name
																									+ '</option>');

																			// }

																		});
														// business_process_id
													}
												});

									});

					$('#main_service_on_tc_e')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_on_tc_e");
										var main_service = select_id.options[select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_sub_service',
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#sub_service_on_tc_e");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			console
																					.log(select_id);
																			console
																					.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				// if
																				// (this.business_process_on_case
																				// ==
																				// 'No')
																				// {
																				$(
																						'#sub_service_on_tc_e')
																						.append(
																								'<option value="'
																										+ this.business_process_sub_id
																										+ '-'
																										+ this.business_process_sub_name
																										+ '">'
																										+ this.business_process_sub_name
																										+ '</option>');

																				// }

																			}

																		});
														// business_process_id
													}
												});

										/*
										 * $.each(data, function() {
										 * 
										 * });
										 */

										// var sub_select_id =
										// document.getElementById("sub_service_on_case");
										// var
										// sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
									});
					$('#btn_create_new_job_and_case_number_e')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_on_tc_e");
										var main_service = select_id.options[select_id.selectedIndex].value;

										var sub_select_id = document
												.getElementById("sub_service_on_tc_e");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');
										const
										sub_service_name_id = sub_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

//										console.log(main_service_id);
//										console.log(main_service_name);
//										console.log(sub_service_id);
//										console.log(sub_service_name);

										main_service_id = main_service_id
												.replace('.0', '');

										var new_land_size = '0';

										var applicant_name_on_tc = $(
												"#applicant_name_on_tc_e")
												.val();

										land_size_on_tc = $(
												"#land_size_on_tc_e").val();
										console.log(new_land_size);
										
										var office_region_on_tc = $("#office_region_on_tc_e").val();
										
										const office_region_name_id = office_region_on_tc.split('_');
										var office_region_id = office_region_name_id[0];
										var office_region_name = office_region_name_id[1];

										var locality_on_tc = $(
												"#locality_on_tc_e").val();
										var type_of_use_on_tc = $(
												"#type_of_use_on_tc_e").val();

										var type_of_interest_on_tc = $(
												"#type_of_interest_on_tc_e")
												.val();
										var nature_of_instrument_on_tc = $(
												"#nature_of_instrument_on_tc_e")
												.val();

										var job_number_on_tc = $(
												"#job_number_on_tc_e").val();
										var case_number_on_tc = $(
												"#case_number_on_tc_e").val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'online_select_process_acknowledgement_not_on_case_exist_cj',
														main_service_id : main_service_id,
														main_service_sub_id : sub_service_id,
														main_service_desc : main_service_name,
														main_service_sub_desc : sub_service_name,
														client_name : applicant_name_on_tc,
														land_size : land_size_on_tc,
														locality : locality_on_tc,
														type_of_use : type_of_use_on_tc,
														type_of_interest : type_of_interest_on_tc,

														job_number : job_number_on_tc,
														case_number : case_number_on_tc,

														nature_of_instrument : nature_of_instrument_on_tc,
														office_region_id: office_region_id,
														office_region_name:office_region_name
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',

													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

														alert(jobdetails);
														console.log(jobdetails);

														var json_p = JSON
																.parse(jobdetails);

														// $('#addlrdtransaction
														// #lrd_td_gid').val(gid);
														$("#job_number_on_tc_e")
																.val(
																		json_p.job_number);
														$("#case_number_on_tc_e")
																.val(
																		json_p.case_number);
													}
												});

									});

					$('#pvlmd_btn_search_case_by_job_number')
							.on(
									'click',
									function(e) {

										var job_number = $(
												"#pvlmd_search_case_by_job_number")
												.val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'load_application_details_by_job_number_all',
														job_number : job_number

													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',

													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$(json_p.data)
																.each(
																		function() {

																			$(
																					"#txt_lc_cd_case_number")
																					.val(
																							this.case_number);
																			$(
																					"#txt_lc_cd_transaction_number")
																					.val(
																							this.transaction_number);
																			$(
																					"#txt_lc_cd_ar_name")
																					.val(
																							this.ar_name);

																			$(
																					"#txt_lc_cd_glpin")
																					.val(
																							this.glpin);
																			$(
																					"#txt_lc_cd_business_process_sub_name")
																					.val(
																							this.business_process_sub_name);
																			$(
																					"#txt_lc_cd_file_number")
																					.val(
																							this.file_number);
																			$(
																					"#txt_lc_cd_land_size")
																					.val(
																							this.land_size);
																			$(
																					"#txt_lc_cd_regional_number")
																					.val(
																							this.regional_number);
																			$(
																					"#txt_lc_cd_locality")
																					.val(
																							this.locality);
																			$(
																					"#txt_lc_cd_date_of_document")
																					.val(
																							this.date_of_document);
																			$(
																					"#txt_lc_cd_nature_of_instrument")
																					.val(
																							this.nature_of_instrument);
																			$(
																					"#txt_lc_cd_type_of_use")
																					.val(
																							this.type_of_use);
																			$(
																					"#txt_lc_cd_term")
																					.val(
																							this.term);
																			$(
																					"#txt_lc_cd_commencement_date")
																					.val(
																							this.commencement_date);
																			$(
																					"#txt_lc_cd_plot_number")
																					.val(
																							this.plot_number);
																			$(
																					"#txt_lc_cd_grantors_name")
																					.val(
																							this.grantors_name);

																		});
													}
												});

									});

				});