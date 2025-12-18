$(document)
		.ready(
				function() {

					var datatable_cordinator = $(
							"#job_casemgtdetailsdataTable_elis_reports")
							.DataTable(
									{
										stateSave : true,
										"createdRow" : function(row, data,
												dataIndex) {
											if (data[0] == "1") {
												$(row).addClass(
														'tr-completed-work');
											}
										},
										dom : 'Bfrtip',
										lengthMenu : [
												[ 10, 25, 50, -1 ],
												[ '10 rows', '25 rows',
														'50 rows', 'Show all' ] ],
										buttons : [ 'pageLength', 'copy',
												'csv', 'excel', 'pdf', 'print' ]
									});

					$('#main_service_rpt')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										// console.log(main_service_name);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_sub_service_all',
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt=""
														// width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#sub_service_rpt");

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

																			if (main_service_id == this.business_process_id) {
																				$(
																						'#sub_service_rpt')
																						.append(
																								'<option value="'
																										+ this.business_process_sub_id
																										+ '-'
																										+ this.business_process_sub_name
																										+ '">'
																										+ this.business_process_sub_name
																										+ '</option>');

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

									


									$('#report_count_main_service_rpt')
									.change(
											function() {
												// alert($(this).val());
												var select_id = document
														.getElementById("report_count_main_service_rpt");
												var main_service = select_id.options[select_id.selectedIndex].value;
		
												const
												main_service_name_id = main_service
														.split('-');
		
												var main_service_id = main_service_name_id[0];
												var main_service_name = main_service_name_id[1];
		
												// console.log(main_service_name);
		
												$
														.ajax({
															type : "POST",
															url : "Case_Management_Serv",
															data : {
																request_type : 'get_lc_sub_service_all',
															},
															cache : false,
															beforeSend : function() {
																// $('#district').html('<img
																// src="img/loading.gif"
																// alt=""
																// width="24"
																// height="24">');
															},
															success : function(
																	jobdetails) {
		
																// console.log(jobdetails);
																var json_p = JSON
																		.parse(jobdetails);
																var options = $("#report_count_sub_service_rpt");
		
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
		
																					if (main_service_id == this.business_process_id) {
																						$(
																								'#report_count_sub_service_rpt')
																								.append(
																										'<option value="'
																												+ this.business_process_sub_id
																												+ '-'
																												+ this.business_process_sub_name
																												+ '">'
																												+ this.business_process_sub_name
																												+ '</option>');
		
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

											



					$('#btn_generate_details_reports_new')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										// console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
										var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);
											console.log(regional_code);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

										var table = $("#job_casemgtdetailsdataTable_elis_reports");
										table.find("tbody tr").remove();

										datatable_cordinator.draw();
										datatable_cordinator.state.clear();
										datatable_cordinator.clear();

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',
													
													data : {
														request_type : 'report_general_new',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													success : function(
															jobdetails) {
														// console.log("ddd: "+
														// jobdetails);
														// create Tabulator on
														// DOM element with id
														// "example-table"

														var json_p = JSON
																.parse(jobdetails);
																console.log(json_p);
														$(json_p.data)
																.each(
																		function() {

																			datatable_cordinator.row
																					.add(
																							[
																									this.job_number ? this.job_number
																											: " ",

																									this.ar_name ? this.ar_name
																											: " ",

																									this.business_process_sub_name ? this.business_process_sub_name
																											: " ",

																									this.created_date ? this.created_date
																											: " ",

																									this.current_application_status ? this.current_application_status
																											: " ",
																									this.case_number ? this.case_number
																											: " ",
																									this.days_since_received ? this.days_since_received
																											: " ",
																									this.days_since_batched ? this.days_since_batched
																												: "",

																									this.completed_date ? this.completed_date
																											: "",
																									this.days_completed ? this.days_completed
																											: "",
																									this.collected_date ? this.collected_date
																											: "",
																						
																									'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
																											+ this.job_number
																											+ '" data-jn_id="'
																											+ this.jn_id
																											+ '" data-ar_name="'
																											+ this.ar_name
																											+ '" data-business_process_sub_name="'
																											+ this.business_process_sub_name
																											+ '" data-case_number="'
																											+ this.case_number
																											+ '" data-case_status="'
																											+ this.case_status
																											+ '" data-target="#applicationdetailsmodal" data-toggle="modal" >'
																											+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">View</span>'
																											+ ' </button>'

																							])
																					.draw(
																							false);

																		});

													}
												});

									});


      


									$('#btn_generate_count_reports')
									.on(
											'click',
											function(e) {
		
												var select_id = document
														.getElementById("report_count_main_service_rpt");
												var main_service = select_id.options[select_id.selectedIndex].value;
												const
												main_service_name_id = main_service
														.split('-');
		
												var main_service_id = main_service_name_id[0];
												var main_service_name = main_service_name_id[1];
		
												var sub_select_id = document
														.getElementById("report_count_sub_service_rpt");
												var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;
		
												const
												sub_service_name_id = sub_service
														.split('-');
												var sub_service_id = sub_service_name_id[0];
												var sub_service_name = sub_service_name_id[1];
		
												// console.log(main_service_id);
		
												main_service_id = main_service_id
														.replace('.0', '');
		
												var date_from = $("#report_count_date_from").val();
												var date_to = $("#report_count_date_to").val();
												var type_of_report_name = $(
														"#type_of_report_name").val();
												var regional_cod = $(
															"#report_count_sel_change_region_compliance").val();
												  let regional_code = Math.trunc(regional_cod);
													console.log(main_service_id,sub_service_id);


		
												// if (sub_service_name == "") {
		
												// 	alert("Please select a service.");
												// 	$("#report_count_sub_service_rpt").focus();
												// 	return false;
												// }
		
												// var table = $("#job_casemgtdetailsdataTable_elis_reports");
												// table.find("tbody tr").remove();
		
												// datatable_cordinator.draw();
												// datatable_cordinator.state.clear();
												// datatable_cordinator.clear();
		
												
												if (date_from !== '' && date_to !== '' && regional_cod !== ''  && sub_select_id !== '') {

													$.ajax({
														type : "POST",
														url : "reports_api",
														// target:'_blank',
														
														data : {
															request_type : 'report_general_count',
															main_service_rpt : main_service_id,
															sub_service_rpt : sub_service_id,
															date_from : date_from,
															date_to : date_to,
															region_code:regional_code
														},
														cache : false,
														success : function(
																job_details) {



	
													$.ajax({
														type : "POST",
														url : "reports_api",
														// target:'_blank',
														
														data : {
															request_type : 'report_general_count_query',
															main_service_rpt : main_service_id,
															sub_service_rpt : sub_service_id,
															date_from : date_from,
															date_to : date_to,
															region_code:regional_code
														},
														cache : false,
														success : function(
																jobdetails) {
															// console.log("ddd: "+
															// jobdetails);
															// create Tabulator on
															// DOM element with id
															// "example-table"
	
															var json_p = JSON
																	.parse(jobdetails);
																	console.log(json_p.data[0].total);
														let queries = json_p.data[0].total		

														document.getElementById('app-queried').innerHTML = queries;
														

														}
													});



	
															var jsonp = JSON
																	.parse(job_details);
																	//console.log(jsonp);
														

																	if (jsonp.data == null){
																		alert("Sorry Nothing Found");
																	}
																	else{

												// let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0 : ((totalRecComp / totalRec) * 100).toFixed(2);

												 let pending_count = jsonp?.data?.[0]?.total ?? 0;
                                                 let completed_count = jsonp?.data?.[1]?.total ?? 0;
														    // let pending_count = jsonp.data[0].total;
															// let completed_count = jsonp.data[1].total;

															//console.log(pending_count);

															$("#report_count_modal").modal("show");  
															document.getElementById('app-pending').innerHTML = pending_count;
															document.getElementById('app-completed').innerHTML = completed_count;
														
															var report_Count  = main_service_name+ "  " +"Report Count Between"+" "+date_from+ " "+"and"+" "+date_to;
															document.getElementById('reportCountModalLabel').innerHTML = report_Count;


															
     															}
														
														}
													});

												}else{
													alert("Please Fill Required Fields")
												}
														
		
											});						




					$('#btn_generate_details_reports_new_csv')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
												var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

									
										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : 'report_general_new',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',
													xhrFields : {
														responseType : 'blob'
													},
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														var blob = new Blob(
																[ jobdetails ],
																{
																	type : "application/vnd.ms-excel"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});

									});


					$('#btn_generate_details_reports')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
												var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : 'report_general',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',
													xhrFields : {
														responseType : 'blob'
													},
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														var blob = new Blob(
																[ jobdetails ],
																{
																	type : "application/vnd.ms-excel"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});

									});
									
									
										$('#btn_generate_details_based_on_users_csv')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
												var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : 'report_general',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',
													xhrFields : {
														responseType : 'blob'
													},
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														var blob = new Blob(
																[ jobdetails ],
																{
																	type : "application/vnd.ms-excel"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});

									});

					$('#unit_division_to_send_to_rpt')
							.change(
									function() {
										// alert("d");
										var selected_division = $(this).val();

										$("#unit_to_send_to_rpt").val("");
										$("#get_change_region_compliance").val("");
										// $("#btn_process_batchlist").hide();
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

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var datalist = $("#listofunitsbatching_rpt");
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

					$('#unit_to_send_to_rpt')
							.change(
									function() {
										
										var selected_division = $(this).val();
										var region_cod = $(
											"#get_change_region_compliance").val();
								  let region_code = Math.trunc(region_cod);

								  console.log(region_code);
										$("#user_to_send_to_rpt").val("");
										
										// $("#btn_process_batchlist").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_users_rpt',
														region_code : region_code
													},
													cache : false,
													success : function(
															jobdetails) {

														
														var json_p = JSON
																.parse(jobdetails);
																console.log(json_p.users);
														var datalist = $("#listofusersbatching_rpt");
														datalist.empty();

														$(json_p.users)
																.each(
																		function() {
																			// if (selected_division == this.unit_name) {
																				if (selected_division == this.unit_name) {

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

									
					$("#btn_generate_details_based_on_users")
							.click(
									function(event) {

										// alert(JSON.stringify(table));
										/*
										 * let request_type = ""; var
										 * list_of_application_new = JSON
										 * .stringify(table)
										 */
										datatable_cordinator.draw();
										datatable_cordinator.state.clear();
										datatable_cordinator.clear();

										var request_type = '';
										var type_of_report_name_rpt = $(
												"#type_of_report_name_rpt")
												.val();
										btn_process_batchlist
										if ($('#type_of_report_name_rpt').val() === 'Unit') {

											request_type = 'report_dashboard_unit_for_each_staff';
											var userid_1 = $(
													"#unit_to_send_to_rpt")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofunitsbatching_rpt option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');
											var send_to_name = $(
													'#listofunitsbatching_rpt option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										} else {
											request_type = 'report_dashboard_unit_for_each_staff';
											var userid_1 = $(
													"#user_to_send_to_rpt")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"_rpt
											// ).text();
											var send_to_id = $(
													'#listofusersbatching_rpt option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');
											var send_to_name = $(
													'#listofusersbatching_rpt option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										}

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : request_type,
														batch_to_id : send_to_id,

													},
													cache : false,
													success : function(
															jobdetails) {

														// create Tabulator on
														// DOM element with id
														// "example-table"
													    
														var json_p = JSON
																.parse(jobdetails);
																console.log(json_p)
														$(
																json_p.apps_with_staff)
																.each(
																		function() {

																			datatable_cordinator.row
																					.add(
																							[
																									this.job_number ? this.job_number
																											: "",

																									this.ar_name ? this.ar_name
																											: "",

																									this.business_process_sub_name ? this.business_process_sub_name
																											: "",

																									this.created_date ? this.created_date
																											: "",

																									this.current_application_status ? this.current_application_status
																											: "",
																									this.case_number ? this.case_number
																											: "",
																									this.days_since_received ? this.days_since_received
																											: "",
																									this.days_since_batched ? this.days_since_batched
																											: "",

																									this.completed_date ? this.completed_date
																											: "",

																									this.jobb_purpose ? this.jobb_purpose
																											: "",

																									
																									// this.days_completed ? this.days_completed
																									// 		: "",
																									this.collected_date ? this.collected_date
																											: "",
																									'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
																											+ this.job_number
																											+ '" data-jn_id="'
																											+ this.jn_id
																											+ '" data-ar_name="'
																											+ this.ar_name
																											+ '" data-business_process_sub_name="'
																											+ this.business_process_sub_name
																											+ '" data-case_number="'
																											+ this.case_number
																											+ '" data-case_status="'
																											+ this.case_status
																											+ '" data-target="#applicationdetailsmodal" data-toggle="modal" >'
																											+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">View</span>'
																											+ ' </button>'

																							])
																					.draw(
																							false);

																		});

													}
												});
									});



				});