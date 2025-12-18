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
														request_type : 'get_lc_sub_service',
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

					

					

					

					

				});