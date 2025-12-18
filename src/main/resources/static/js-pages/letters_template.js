$(document)
		.ready(
				function() {

					$('#lc_btn_add_update_letters').on('click',function(e) {
						
						    //$("#addUpdateLetterModal").closest('form').find("input[type=text], textarea").val("");
						
										var type_of_letter = $("#type_of_letter_new").val();
										//console.log($("#type_of_letter_new").val());
										$("#addUpdateLetterModal").modal();
										// $('#general_message_dialog
										// #general_message_dialog_msg').val(jobdetails);
										$('#addUpdateLetterModal #lt_letter_type').val($("#type_of_letter_new").val());
										$('#addUpdateLetterModal #lc_letter_template_cc').val("");
										$("#addUpdateLetterModal #lt_id").val("0");
										$.ajax({

													type : "POST",
													url : "GenerateCaseReports",
													// target:'_blank',
													data : {
														request_type : 'request_to_letter_template',
														type_of_letter : type_of_letter

													},
													cache : false,
													success : function(
															jobdetails) {

														//console.log(jobdetails);
														$('#lc_letter_template_description')
																.summernote(
																		'code',
																		'<ol><li>'
																				+ jobdetails
																				+ '</li></ol>');
														// console.log(jobdetails);
														// alert(jobdetails);

													}
												});

									});

					$('#btn_generate_letters')
							.on(
									'click',
									function(e) {

										$("#addUpdateLetterModal").modal();
										// $('#general_message_dialog
										// #general_message_dialog_msg').val(jobdetails);
										$('#addUpdateLetterModal #general_message_dialog_msg_new')
												.val(
														$("#type_of_letter_new")
																.val());
									});
					
					
					$('.edit_letter_modal_open').on('click',function(e) {
						$('#addUpdateLetterModal #lt_letter_type').val( $(this).data("letter_type"));
						$('#addUpdateLetterModal #lc_letter_template_cc').val( $(this).data("carbon_copy"));
						$("#addUpdateLetterModal #lt_id").val( $(this).data("id"));
						$('#addUpdateLetterModal #lc_letter_template_description')
						.summernote( 'code',  $(this).data("letter_template"));
						$("#addUpdateLetterModal").modal();
										
										
					});
					
					
					
					$('#btn_compose_letters')
							.on(
									'click',
									function(e) {

										var lc_letter_type = $(
												"#lt_letter_type").val();

										var job_number = $("#cs_main_job_number").val();
										var case_number = $("#cs_main_case_number").val();
										var lc_search_report_summary_details_final = $("#lc_letter_template_description").val();
										var letter_cc = $("#lc_letter_template_cc").val() ?  $("#lc_letter_template_cc").val() :  "none";

										$.ajax({
													type : "POST",
													url : "GenerateCaseReports",
													// target:'_blank',
													data : {
														request_type : 'request_to_generate_case_letter',
														job_number : job_number,
														case_number : case_number,
														lc_letter_type : lc_letter_type,
														lc_letter_cc: letter_cc,
														lc_search_report_summary_details_final : lc_search_report_summary_details_final
													},
													cache : false,
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
																	type : "application/pdf"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});
									});

					$('#btn_save_letters')
							.on(
									'click',
									function(e) {
										var id = $("#lt_id").val();
										if(typeof(id)!=="undefined"){
											id = parseInt(id);
										}
										var job_number = $("#lt_job_number")
												.val();
										var case_number = $("#lt_case_number")
												.val();
										var letter_template = $(
												"#lc_letter_template_description")
												.val();
										var letter_type = $("#lt_letter_type")
												.val();
										var letter_cc = $("#lc_letter_template_cc")
										.val();

										$
												.ajax({

													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',
													data : {
														request_type : 'lc_case_letters_add_update',
														id 				: id,
														job_number 		: job_number,
														case_number 	: case_number,
														letter_template : letter_template,
														letter_type 	: letter_type,
														letter_cc		: letter_cc

													},
													cache : false,
													success : function(
															jobdetails) {
														//console.log(jobdetails);
														alert(jobdetails);

													}
												});
									});
					
					
					//------------end of Doc redy

				});