$(document)
		.ready(
				function() {

					var datatable_cordinator = $(
							"#job_casemgtdetailsdataTable_elis_reports_stpc")
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
										 buttons : [ 'pageLength','csv', 'excel' ]
									});

					$('#main_service_rpt_stpc')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_rpt_stpc");
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
														var options = $("#sub_service_rpt_stpc");

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
																						'#sub_service_rpt_stpc')
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

					$('#btn_generate_details_reports_new_stpc')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt_stpc");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt_stpc");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

									
										main_service_id = main_service_id
												.replace('.0', '');
										
										//console.log(main_service_id);
										//console.log(sub_service_id);
										//console.log(date_from);
										//console.log(date_to);
										//console.log(type_of_report_name);


										var date_from = $("#date_from_stpc").val();
										var date_to = $("#date_to_stpc").val();
										var ar_name_search_stpc = $("#ar_name_search_stpc").val();
										//console.log(ar_name_search_stpc);
										var type_of_report_name = $(
												"#type_of_report_name_stpc").val();

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt_stpc").focus();
											return false;
										}

										var table = $("#job_casemgtdetailsdataTable_elis_reports_stpc");
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
														request_type : 'report_general_new_stpc',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														ar_name_search_stpc: ar_name_search_stpc
													},
													cache : false,
													success : function(
															jobdetails) {
													 console.log("ddd: "+ jobdetails);
														// create Tabulator on
														// DOM element with id
														// "example-table"

														var json_p = JSON
																.parse(jobdetails);
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
						
																									this.assessed_value ? this.assessed_value
																											: " ",
																									this.stamp_duty_payable ? this.stamp_duty_payable
																											: " ",
																									this.ref_number ? this.ref_number
																												: "",

																									this.bill_amount ? this.bill_amount
																											: "",
																									this.payment_date ? this.payment_date
																											: "",
																									this.client_ref ? this.client_ref
																											: "",

																									this.payment_amount ? this.payment_amount
																									: ""
																						
																								// 	 '<form action="front_office_view_application_st" method="post">'
																								// 	+ '<input type="hidden" name="case_number" id="case_number" value="'+ this.transaction_number +'">'
																								// 	+ '<input type="hidden" name="job_number" id="job_number" value="'+ this.job_number +'">'
																								// 	+ '<input id="search_text" name="search_text" type="hidden" value="'+ this.case_number +'">'
																								// 	+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'+ this.case_number +'}">'
																								   
																								   
																								//    + '<button type="submit" class="btn btn-primary dropdown-item" id="btn_application_details" title="View Application Details" > '
																								//    + '<span class="icon text-black-50"> <i class="fas fa-info-circle"></i>  </span><span  class="text">Application Details</span></button>'
																								   
																								   
																								   
																								   
																								//    + '</form>'

																							])
																					.draw(
																							false);

																		});

													}
												});

									});





				});