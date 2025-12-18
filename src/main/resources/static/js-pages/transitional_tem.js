$(document)
		.ready(
				function() {

					$('#applicationStatusupdate')
							.on(
									'show.bs.modal',
									function(e) {

										//console.log('Add to batchlist');

										$('#bl_job_number_msu').val($('#fe_job_number').val());
										$('#bl_ar_name_msu').val($('#fe_client_name').val());
										$('#bl_business_process_sub_name_msu').val($('#febusiness_process_sub_name').val());

										var business_process_id = $("#main_service_id_fe").val();

										var business_process_sub_id = $(
												"#main_service_sub_id_fe")
												.val();

										business_process_id = business_process_id
												.replace('.0', '');

										business_process_sub_id = business_process_sub_id
												.replace('.0', '');
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_tracking_milestones',
														main_service_id : business_process_id,
														sub_service_id : business_process_sub_id
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

														var table = $('#tbl_list_of_milestone_stone_dataTable');
														table.find("tbody tr")
																.remove();

														//console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$(json_p.data)
																.each(
																		function() {

																			/*
																			 * console
																			 * .log(new_priority_value);
																			 */

																			table
																					.append("<tr id='row' class='bg-success text-white red-tooltip' title='Aplication Stage Completed'  data-toggle='tooltip' data-placement='left'} ><td>"
																							+ this.milestone_description
																							+ "</td><td>"
																							+ this.priority_value
																							+ "</td><td><input type='radio' name='selectmiletonestagerb' value='"
																							+ this.priority_value
																							+ "' />"
																							+ "</td>"

																							+ "</tr>");

																		});

													}
												});

									});

					$('#btn_update_milestone_status_for_application')
							.on(
									'click',
									function(e) {

										var application_stage = $(
												'input:radio[name="selectmiletonestagerb"]:checked')
												.val()

										// alert(milestone_stage); // output 10

										var job_number = $("#bl_job_number_msu")
												.val();

										var userid = $("#up_userid").val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'select_update_application_stage_for_a_job',
														job_number : job_number,
														application_stage : application_stage,

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
														//console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														alert(jobdetails);

														$(
																'#applicationStatusupdate')
																.modal('hide');

													}
												});

									});
				});