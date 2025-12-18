$(document)
		.ready(
				function() {

					/*
					 * $('#addNewserviceBillModalProfessional').modal({ keyboard :
					 * true, backdrop : "static", show : false,
					 * 
					 * }).on('show', function() { var getIdFromRow =
					 * $(event.target).closest('tr').data('id'); // make your
					 * ajax call populate items or what even you // need })
					 */

					$('#addNewserviceBillModalProfessional')
							.on(
									'show.bs.modal',
									function(e) {

										$("#main_service_id_pf").val(
												$(e.relatedTarget).data(
														'business_process_id'));
										$("#main_service_desc_pf")
												.val(
														$(e.relatedTarget)
																.data(
																		'business_process_name'));

										var main_service_id = $(e.relatedTarget)
												.data('business_process_id');
										var main_service_name = $(
												e.relatedTarget).data(
												'business_process_name');

										if (main_service_name === 'APPLICATION FOR REGIONAL NUMBER') {
											$('#ap-reg-no-div').show();
											$('#ap-stp-no-div').hide();

											$('#ap-partysearch-no-div').hide();

											$('#ap-typeofuse-no-div').hide();
											$('#ap-selectlocality-no-div')
													.show();

											$('#checksigs-no-div_afp').show();

										}

										if (main_service_name === 'APPLICATION FOR PLAN APPROVAL') {
											$('#oncasereg-no-div_pf').show();
											$('#oncasereglandsize-no-div_pf')
													.show();

											$('#oncasestp-no-div_pf').hide();
											$('#checksigs-no-div_pf').hide();
											$('#oncasefpublication-no-div_pf')
													.hide();

										}

										if (main_service_name === 'APPLICATION FOR STAMPING') {
											$('#ap-reg-no-div').hide();
											$('#ap-stp-no-div').show();

											$('#ap-typeofuse-no-div').show();
											$('#ap-selectlocality-no-div')
													.hide();
											$('#ap-partysearch-no-div').show();
											$('#checksigs-no-div_afp').hide();
										}

										if (main_service_name === 'APPLICATION FOR SEARCH') {

											$('#ap-reg-no-div').hide();
											$('#ap-stp-no-div').hide();

											$('#ap-typeofuse-no-div').show();
											$('#ap-selectlocality-no-div')
													.show();
											$('#ap-partysearch-no-div').show();
											$('#checksigs-no-div_afp').hide();
										}

										if (main_service_name === 'APPLICATION FOR REGISTRATION') {

											$('#ap-reg-no-div').hide();
											$('#ap-stp-no-div').hide();

											$('#ap-typeofuse-no-div').show();
											$('#ap-selectlocality-no-div')
													.show();
											$('#ap-partysearch-no-div').show();
											$('#checksigs-no-div_afp').hide();
										}

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
														var options = $("#sub_service_on_case_pf");

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
																					.log(main_service_id);
																			console
																					.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				$(
																						'#sub_service_on_case_pf')
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
														var options = $("#new_bill_type_of_use_pf");

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
																					'#new_bill_type_of_use_pf')
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

										var cs_main_need_for_new_transaction = $(
												"#cs_main_need_for_new_transaction")
												.val();

										if (cs_main_need_for_new_transaction === 'Yes') {

											$('#on_application_client_name')
													.val([]);

											$('#on_application_client_name')
													.prop("readonly", false);
										} else {
											$('#on_application_client_name')
													.prop("readonly", true);
										}

									});

					$('#sub_service_on_case_pf')
							.change(
									function() {
										// alert($(this).val());
										/*
										 * var select_id = document
										 * .getElementById("sub_service_on_case_pf");
										 * var main_service =
										 * select_id.options[select_id.selectedIndex].value;
										 */

										var sub_service = $(this).val();

										var main_service_id = $(
												"#main_service_id_pf").val();

										var main_service_name = $(
												"#main_service_desc_pf").val();
										const
										sub_service_name_id = sub_service
												.split('-');

										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);
										console.log(main_service_name);
										console.log(sub_service_id);
										console.log(sub_service_name);

										if (main_service_name === 'APPLICATION FOR REGIONAL NUMBER') {
											$('#checksigs-no-div_pf').show();
											$('#reg-no-div_pf').show();
											$('#selectlocality-no-div_pf')
													.show();
											$('#stp-no-div_pf').hide();
											$('#fsearches-no-div_pf').hide();
											$('#freg-no-div_pf').hide();

										}

										if (main_service_name === 'APPLICATION FOR PLAN APPROVAL') {
											$('#checksigs-no-div_pf').show();
											$('#reg-no-div_pf').show();
											$('#selectlocality-no-div_pf')
													.show();
											$('#stp-no-div_pf').hide();
											$('#fsearches-no-div_pf').hide();
											$('#freg-no-div_pf').hide();

										}

										if (main_service_name === 'APPLICATION FOR STAMPING') {
											$('#checksigs-no-div_pf').hide();
											$('#reg-no-div_pf').hide();
											$('#selectlocality-no-div_pf')
													.show();
											$('#stp-no-div_pf').show();
											$('#fsearches-no-div_pf').hide();
											$('#freg-no-div_pf').hide();
										}

										if (main_service_name === 'APPLICATION FOR SEARCH') {

											$('#checksigs-no-div_pf').hide();
											$('#reg-no-div_pf').hide();
											$('#selectlocality-no-div_pf')
													.show();
											$('#stp-no-div_pf').hide();
											$('#fsearches-no-div_pf').show();
											$('#freg-no-div_pf').hide();
										}

										if (main_service_name === 'APPLICATION FOR REGISTRATION') {
											$('#checksigs-no-div_pf').hide();
											$('#reg-no-div_pf').hide();
											$('#selectlocality-no-div_pf')
													.show();
											$('#stp-no-div_pf')
											$('#fsearches-no-div_pf').show();
											$('#stp-no-div_pf').show();
											$('#freg-no-div_pf').hide();
										}

										/*
										 * if(sub_service_name==='APPLICATION
										 * FOR WHOLE TRANFER'){
										 * $("#on_application_client_name").val('');
										 * document.getElementById("on_application_client_name").readOnly =
										 * false; }
										 */
										if (sub_service_name === 'APPLICATION FOR MORTGAGES') {
											$("#on_application_client_name")
													.val('');
											document
													.getElementById("on_application_client_name").readOnly = false;

										}

										if (sub_service_name === 'APPLICATION FOR OBJECTION') {
											$("#on_application_client_name")
													.val('');
											document
													.getElementById("on_application_client_name").readOnly = false;

										}

										/*
										 * if(sub_service_name==='APPLICATION
										 * FOR OBJECTION'){
										 * $("#on_application_client_name").val('');
										 * document.getElementById("on_application_client_name").readOnly =
										 * false; }
										 */

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_checklist',
														main_service_id : main_service_id,
														sub_service_id : sub_service_id
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

														var table = $('#new_checlist_pf_table_billdataTable');
														table.find("tbody tr")
																.remove();

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$(json_p)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.business_process_checklist_name
																							+ "</td><td>"
																							+ '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" /></div>'
																							+ "</td>"

																							+ "</tr>");

																		});

													}
												});

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_type_of_forms_list',
														main_service_id : main_service_id,
														sub_service_id : sub_service_id
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

														console.log('get_type_of_forms_list : ' + jobdetails);
														
														if(jobdetails.includes('Error')){
															console.log('error : ' + jobdetails);
															return false;
														}else{
															var json_p = JSON.parse(jobdetails);
															var options = $("#new_bill_registration_forms");
															
															options.empty();
															options.append(new Option("-- Select --",0));
															
															$(json_p).each(function() {

																
																$('#new_bill_registration_forms').append('<option value="'
																						+ this.form_number
																						+ '-'
																						+ this.form_name
																						+ '">'
																						+ this.form_name
																						+ '</option>');


															});
														}
														

														
													}
												});

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_list_of_revenue_item_list',
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

														console.log('get_list_of_revenue_item_list: '+ jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#new_type_of_revenue_item");

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

																			if (sub_service_id == this.is_inspection_required) {
																				$(
																						'#new_type_of_revenue_item')
																						.append(
																								'<option value="'
																										+ this.revenue_items_name
																										+ '_'
																										+ this.revenue_items_amount
																										+ '">'
																										+ this.revenue_items_name
																										+ '</option>');

																			}

																		});
														// business_process_id
													}
												});

									});

									

					$('#btn_save_to_generate_new_bill_not_on_case_pf')
							.on(
									'click',
									function(e) {

										var main_service_id = $(
												"#main_service_id_pf").val();

										var main_service_name = $(
												"#main_service_desc_pf").val();

										var sub_select_id = document
												.getElementById("sub_service_on_case_pf");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var client_name = $(
												"#new_bill_application_client_name_pf")
												.val();
										var office_region = $(
												"#new_bill_application_office_region_pf")
												.val();

										var revenue_item = '0';

										var licensed_surveyor_name = '';

										if (main_service_name === 'APPLICATION FOR REGIONAL NUMBER') {
											var type_of_use = '';
											var registration_forms = '';
											var land_size = '0';
											var publication_type = '';

											var ar_gender = $(
													"#new_bill_application_gender_pf")
													.val();
											var locality = $(
													"#new_bill_application_locality_pf")
													.val();
											var ar_district = $(
													"#new_bill_application_district_pf")
													.val();
											var ar_region = $(
													"#new_bill_application_region_pf")
													.val();

											var licensed_surveyor_number = $(
													"#new_bill_application_ls_number_pf")
													.val();
											var no_of_copy = $(
													"#new_bill_application_qty_pf")
													.val();
											client_name = $(
													"#new_bill_application_client_name_pf")
													.val();
											licensed_surveyor_name = $(
													"#new_bill_application_surveyors_name_pf")
													.val();

											if (licensed_surveyor_number == "") {
												// $('#new_bill_application_ls_number').after('<span
												// class="error">This field is
												// required</span>');
												alert("Please enter Surveyor's Number.");
												$(
														"#new_bill_application_ls_number_pf")
														.focus();
												return false;
											}

										}

										if (main_service_name === 'APPLICATION FOR STAMPING') {
											var type_of_use = $(
													"#new_bill_type_of_use_pf")
													.val();
											var registration_forms = $(
													"#new_bill_registration_forms_pf")
													.val();
											var land_size = '0';
											var publication_type = $(
													"#new_bill_publication_type_pf")
													.val();

											var ar_gender = $(
													"#new_bill_application_gender_pf")
													.val();
											var locality = $(
													"#new_bill_application_locality_pf")
													.val();
											var ar_district = $(
													"#new_bill_application_district_pf")
													.val();
											var ar_region = $(
													"#new_bill_application_region_pf")
													.val();

											var licensed_surveyor_number = $(
													"#new_bill_application_ls_number_pf")
													.val();
											var no_of_copy = $(
													"#new_number_of_copies_pf")
													.val();
											var revenue_item = $(
													"#new_type_of_revenue_item_pf")
													.val();
										}

										if (main_service_name === 'APPLICATION FOR REGISTRATION') {
											var type_of_use = $(
													"#new_bill_type_of_use_pf")
													.val();
											var registration_forms = $(
													"#new_bill_registration_forms_pf")
													.val();
											var land_size = $(
													"#new_bill_land_size_pf")
													.val();
											var publication_type = $(
													"#new_bill_publication_type_pf")
													.val();

											var ar_gender = $(
													"#new_bill_application_gender_pf")
													.val();
											var locality = $(
													"#new_bill_application_locality_pf")
													.val();
											var ar_district = $(
													"#new_bill_application_district_pf")
													.val();
											var ar_region = $(
													"#new_bill_application_region_pf")
													.val();

											var licensed_surveyor_number = $(
													"#new_bill_application_ls_number_pf")
													.val();
											var no_of_copy = '0';
										}

										if (main_service_name === 'APPLICATION FOR SEARCH') {
											var type_of_use = $(
													"#new_bill_type_of_use_pf")
													.val();
											var registration_forms = '';
											var land_size = $(
													"#new_bill_land_size_pf")
													.val();
											var publication_type = '';
											var ar_gender = '';
											var locality = $(
													"#new_bill_application_locality_pf")
													.val();
											var ar_district = '';
											var ar_region = '';

											var licensed_surveyor_number = '';
											var no_of_copy = '0';
										}

										if (main_service_name === 'APPLICATION FOR PVLMD PLOTTING') {
											var type_of_use = $(
													"#new_bill_type_of_use_pf")
													.val();
											var registration_forms = '';
											var land_size = $(
													"#new_bill_land_size_pf")
													.val();
											var publication_type = '';

											var ar_gender = '';
											var locality = $(
													"#new_bill_application_locality_pf")
													.val();
											var ar_district = '';
											var ar_region = '';

											var licensed_surveyor_number = '';
											var no_of_copy = '0';
										}

										if (main_service_name === 'APPLICATION FOR PERMIT SEARCH') {
											var type_of_use = $(
													"#new_bill_type_of_use_pf")
													.val();
											var registration_forms = '';
											var land_size = $(
													"#new_bill_land_size_pf")
													.val();
											var publication_type = '';

											var ar_gender = '';
											var locality = $(
													"#new_bill_application_locality_pf")
													.val();
											var ar_district = '';
											var ar_region = '';

											var licensed_surveyor_number = '';
											var no_of_copy = '0';
										}

										if (main_service_name === 'APPLICATION FOR STATE LAND') {
											var type_of_use = '';
											var registration_forms = '';
											var land_size = '0';
											var publication_type = '';
											var ar_gender = '';
											var locality = '0';
											var ar_district = '';
											var ar_region = '';

											var licensed_surveyor_number = '';
											var no_of_copy = '0';
										}

										console.log(client_name);
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'process_online_select_bill_for_registration',
														main_service_id : main_service_id,
														main_service_sub_id : sub_service_id,
														main_service_desc : main_service_name,
														main_service_sub_desc : sub_service_name,
														client_name : client_name,
														land_size : land_size,
														registration_forms : registration_forms,
														publication_type : publication_type,
														type_of_use : type_of_use,
														licensed_surveyor_number : licensed_surveyor_number,
														licensed_surveyor_name : licensed_surveyor_name,
														locality : locality,
														ar_gender : ar_gender,
														ar_district : ar_district,
														ar_region : ar_region,
														paper_size : 0,
														revenue_item : revenue_item,
														no_of_copy : no_of_copy,
														office_region : office_region,
														submission_type : 'Online'
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
																	type : "application/pdf"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

														$(
																'#addNewserviceBillModalProfessional')
																.modal('hide');

													}
												});

									});

					$('#NotoncaseafterPaymentModalonCaseProfessional')
							.on(
									'show.bs.modal',
									function(e) {

										var job_number = $(e.relatedTarget)
												.data('ref_number');

										console.log(job_number);
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'select_load_details_for_payment',
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

														console.log(jobdetails);

														var table_bp = $('#tbl_not_on_case_ap_bills_payments_dataTable_pf');
														table_bp.find(
																"tbody tr")
																.remove();

														var table_cl = $('#tbl_not_on_case_after_payment_ap_checklist_dataTable_pf');
														table_cl.find(
																"tbody tr")
																.remove();

														console.log(jobdetails);

														var json_p = JSON
																.parse(jobdetails);

														$(
																'#txt_not_on_case_ap_main_service_id_pf')
																.val(
																		json_p.jobdetails.business_process_id);
														$(
																'#txt_not_on_case_ap_main_service_sub_id_pf')
																.val(
																		json_p.jobdetails.business_process_sub_id);
														$(
																'#txt_not_on_case_ap_jn_id_pf')
																.val(
																		json_p.jobdetails.jn_id);
														$(
																'#txt_not_on_case_ap_main_service_desc_pf')
																.val(
																		json_p.jobdetails.business_process_name);
														$(
																'#txt_not_on_case_ap_main_service_sub_desc_pf')
																.val(
																		json_p.jobdetails.business_process_sub_name);
														$(
																'#txt_not_on_case_ap_client_name_pf')
																.val(
																		json_p.jobdetails.lessees_name);
														$(
																'#txt_not_on_case_ap_ar_name_pf')
																.val(
																		json_p.jobdetails.lessees_name);
														$(
																'#txt_not_on_case_ap_land_size_pf')
																.val(
																		json_p.jobdetails.extent);
														$(
																'#txt_not_on_case_ap_job_number_pf')
																.val(job_number);
														$(
																'#txt_not_on_case_bl_txt_ar_name_pf')
																.val(
																		json_p.jobdetails.lessees_name);

														$(
																'#txt_not_on_case_bl_txt_ar_gender_pf')
																.val(
																		json_p.jobdetails.gender);
														$(
																'#txt_not_on_case_ap_district_pf')
																.val(
																		json_p.jobdetails.district);
														$(
																'#txt_not_on_case_ap_region_pf')
																.val(
																		json_p.jobdetails.region);
														$(
																'#txt_not_on_case_ap_licensed_surveyor_number_pf')
																.val(
																		json_p.jobdetails.licensed_surveyor_number);
														$(
																'#new_bill_application_ls_number_afp_pf')
																.val(
																		json_p.jobdetails.licensed_surveyor_number);

														$(
																'#txt_not_on_case_ap_licensed_surveyor_name_pf')
																.val(
																		json_p.jobdetails.licensed_surveyor_name);
														$(
																'#txt_not_on_case_ap_locality_of_parcel_pf')
																.val(
																		json_p.jobdetails.locality);
														$(
																'#txt_not_on_case_ap_type_of_use_pf')
																.val(
																		json_p.jobdetails.type_of_use);

														// var
														// new_bill_land_size =
														// $("#new_bill_land_size").val();

														console
																.log(json_p.jobdetails.business_process_name);

														if (json_p.jobdetails.business_process_name === 'APPLICATION FOR REGIONAL NUMBER') {
															$(
																	'#ap-reg-no-div_pf')
																	.show();
															$(
																	'#ap-stp-no-div_pf')
																	.hide();

															$(
																	'#ap-partysearch-no-div_pf')
																	.hide();

															$(
																	'#ap-typeofuse-no-div_pf')
																	.hide();
															$(
																	'#ap-selectlocality-no-div_pf')
																	.show();

															$(
																	'#checksigs-no-div_afp_pf')
																	.show();

														}

														if (json_p.jobdetails.business_process_name === 'APPLICATION FOR STAMPING') {
															$(
																	'#ap-reg-no-div_pf')
																	.hide();
															$(
																	'#ap-stp-no-div_pf')
																	.show();

															$(
																	'#ap-typeofuse-no-div_pf')
																	.show();
															$(
																	'#ap-selectlocality-no-div_pf')
																	.hide();
															$(
																	'#ap-partysearch-no-div_pf')
																	.show();
															$(
																	'#checksigs-no-div_afp_pf')
																	.hide();
														}

														if (json_p.jobdetails.business_process_name === 'APPLICATION FOR SEARCH') {
															$(
																	'#ap-reg-no-div_pf')
																	.hide();
															$(
																	'#ap-stp-no-div_pf')
																	.hide();

															$(
																	'#ap-typeofuse-no-div_pf')
																	.show();
															$(
																	'#ap-selectlocality-no-div_pf')
																	.show();
															$(
																	'#ap-partysearch-no-div_pf')
																	.show();
															$(
																	'#checksigs-no-div_afp_pf')
																	.hide();
														}

														/*
														 * if(json_p.jobdetails.business_process_name==='APPLICATION
														 * FOR REGISTRATION'){
														 * $('#ap-reg-no-div').hide();
														 * $('#ap-stp-no-div').show();
														 * $('#ap-freg-no-div').hide(); }
														 */

														$(json_p.payments)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.bill_number
																							+ "</td><td>"
																							+ this.customer_id
																							+ "</td><td>"
																							+ this.bill_amount
																							+ "</td><td>"
																							+ this.payment_amount
																							+ "</td><td> </td><td>"
																							+ this.division
																							+ "</td>"
																							+ "</tr>");
																		});

														/*
														 * $(json_p.payments).each(function () {
														 * table_bp.append("<tr><td>" +
														 * this.bill_number + "</td><td>"
														 * +this.customer_id + "</td><td>"
														 * +this.bill_amount + "</td><td>"
														 * +this.payment_amount + "</td><td>"
														 * +this.division + "</td>" + "</tr>");
														 * });
														 */

														$
																.ajax({
																	type : "POST",
																	url : "Case_Management_Serv",
																	data : {
																		request_type : 'get_lc_checklist',
																		main_service_id : json_p.jobdetails.business_process_id,
																		sub_service_id : json_p.jobdetails.business_process_sub_id
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

																		var table = $('#tbl_not_on_case_after_payment_ap_checklist_dataTable_pf');
																		table
																				.find(
																						"tbody tr")
																				.remove();

																		console
																				.log(jobdetails);
																		var json_p = JSON
																				.parse(jobdetails);

																		$(
																				json_p)
																				.each(
																						function() {

																							// result.append('<div
																							// class="form-group">
																							// <label><input
																							// type="radio"
																							// name="bl_milestone"
																							// value="'
																							// +
																							// this.ms_id
																							// + '"
																							// /> '
																							// +
																							// this.milestone_description
																							// +
																							// '</label>
																							// </div>');

																							table
																									.append("<tr><td>"
																											+ this.business_process_checklist_name
																											+ "</td><td>"
																											+ '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" /></div>'
																											+ "</td>"

																											// +
																											// '<td><p
																											// data-placement="top"
																											// data-toggle="tooltip"
																											// title="Transaction
																											// Details"><button
																											// class="btn
																											// btn-info
																											// btn-icon-split"
																											// data-title="Delete"
																											// data-toggle="modal"
																											// data-target="#modalrecordinformation"
																											// data-target-id="'
																											// +
																											// this.ms_id
																											// +
																											// '"><span
																											// class="icon
																											// text-white-50">
																											// <i
																											// class="fas
																											// fa-info-circle"></i></span><span
																											// class="text">Add
																											// to
																											// List</span></button></p></td>'

																											+ "</tr>");

																						});

																	}
																});

														// select_address_register_by_id_number
														/*
														 * $.ajax({ type:
														 * "POST", url:
														 * "Case_Management_Serv",
														 * data: { request_type:
														 * 'select_address_register_by_id_number',
														 * id_number:job_number, },
														 * cache: false,
														 * beforeSend: function () { //
														 * $('#district').html('<img
														 * src="img/loading.gif"
														 * alt="" width="24"
														 * height="24">'); },
														 * success:
														 * function(jobdetails) {
														 * 
														 * var table =
														 * $('#tbl_not_on_case_client_details_datatable');
														 * table.find("tbody
														 * tr").remove();
														 * 
														 * console.log(jobdetails);
														 * var json_p =
														 * JSON.parse(jobdetails);
														 * 
														 * $(json_p).each(function () { //
														 * result.append('<div
														 * class="form-group">
														 * <label><input
														 * type="radio"
														 * name="bl_milestone"
														 * value="' + this.ms_id + '" /> ' +
														 * this.milestone_description + '</label>
														 * </div>');
														 * 
														 * 
														 * table.append("<tr><td>" +
														 * this.ar_client_id + "</td><td>"
														 * +this.ar_name + "</td><td>"
														 * +this.ar_gender + "</td><td>"
														 * +this.ar_cell_phone + "</td><td>"
														 * +this.type_of_party + "</td>" // + '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button
														 * class="btn btn-info
														 * btn-icon-split"
														 * data-title="Delete"
														 * data-toggle="modal"
														 * data-target="#modalrecordinformation"
														 * data-target-id="' +
														 * this.ms_id + '"><span
														 * class="icon
														 * text-white-50"> <i
														 * class="fas
														 * fa-info-circle"></i></span><span
														 * class="text">Add to
														 * List</span></button></p></td>' + "</tr>");
														 * 
														 * }); } });
														 */

													}
												});

									});

					$('#btn_not_on_case_ap_generate_acknowledgement_pf')
							.on(
									'click',
									function(e) {

										var main_service_id = $(
												"#txt_not_on_case_ap_main_service_id_pf")
												.val();
										var main_service_sub_id = $(
												"#txt_not_on_case_ap_main_service_sub_id_pf")
												.val();
										var main_service_desc = $(
												"#txt_not_on_case_ap_main_service_desc_pf")
												.val();
										var main_service_sub_desc = $(
												"#txt_not_on_case_ap_main_service_sub_desc_pf")
												.val();
										var client_name = $(
												"#txt_not_on_case_bl_txt_ar_name_pf")
												.val();
										// var client_name =
										// $("#txt_not_on_case_ap_client_name").val();
										var land_size = $(
												"#txt_not_on_case_ap_land_size_pf")
												.val();
										var locality_of_parcel = $(
												"#txt_not_on_case_ap_locality_of_parcel_pf")
												.val();
										var application_type = $(
												"#txt_not_on_case_ap_application_type_pf")
												.val();
										var type_of_interest = $(
												"#txt_not_on_case_ap_type_of_instrument_pf")
												.val();
										var job_number = $(
												"#txt_not_on_case_ap_job_number_pf")
												.val();
										// var case_number =
										// $("#txt_on_case_ap_case_number").val();
										var land_size = $(
												"#txt_not_on_case_ap_land_size_pf")
												.val();

										var case_number = 'No';
										var jn_id = $(
												"#txt_not_on_case_ap_jn_id_pf")
												.val();

										// var txt_on_case_ap_client_name =
										// $("#txt_on_case_ap_ar_name").val();
										var ar_gender = $(
												"#txt_not_on_case_bl_txt_ar_gender_pf")
												.val();

										// txt_not_on_case_bl_txt_ar_gender
										var ar_cell_phone = $(
												"#txt_not_on_case_bl_txt_ar_cell_phone_pf")
												.val();

										var ar_client_address = $(
												"#txt_not_on_case_bl_txt_client_address_pf")
												.val();

										var ar_id_type = '';
										var ar_id_number = '';
										var type_of_party = 'Applicant';

										/*
										 * var ar_id_type =
										 * $("#txt_not_on_case_bl_cbo_ar_id_type").val();
										 * var ar_id_number =
										 * $("#txt_not_on_case_bl_txt_ar_id_number").val();
										 * var type_of_party =
										 * $("#txt_not_on_case_bl_cbo_type_of_party").val();
										 */

										var region = $(
												"#txt_not_on_case_ap_region_pf")
												.val();
										var district = $(
												"#txt_not_on_case_ap_district_pf")
												.val();
										var licensed_surveyor_number = $(
												"#txt_not_on_case_ap_licensed_surveyor_number_pf")
												.val();
										var licensed_surveyor_name = $(
												"#txt_not_on_case_ap_licensed_surveyor_name_pf")
												.val();

										var type_of_use = $(
												"#txt_not_on_case_ap_type_of_use_pf")
												.val();

										// console.log(on_application_client_name);

										// console.log(on_application_client_name);
										// console.log(on_application_client_name);
										// var userid =
										// $("#txt_not_on_case_ap_userid").val();
										// var fullname =
										// $("#txt_not_on_case_ap_user_fullname").val();
										var userid = localStorage
												.getItem('userid');
										var fullname = localStorage
												.getItem('fullname');

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',
													data : {
														request_type : 'process_online_select_acknowledgement_not_on_case',
														main_service_id : main_service_id,
														main_service_sub_id : main_service_sub_id,
														main_service_desc : main_service_desc,
														main_service_sub_desc : main_service_sub_desc,
														client_name : client_name,
														ar_address : ar_client_address,
														licensed_surveyor_name : '',
														land_size : land_size,
														locality_of_parcel : locality_of_parcel,
														application_type : application_type,
														type_of_interest : type_of_interest,
														type_of_use : type_of_use,
														job_number : job_number,
														case_number : case_number,
														jn_id : jn_id,
														userid : userid,
														fullname : fullname,
														ar_gender : ar_gender,
														ar_cell_phone : ar_cell_phone,
														ar_id_type : ar_id_type,
														ar_id_number : ar_id_number,
														ap_type_of_party : type_of_party,

														region : region,
														district : district,
														licensed_surveyor_number : licensed_surveyor_number,
														licensed_surveyor_name : licensed_surveyor_name,

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

														console.log(jobdetails);

														$(
																'#NotoncaseafterPaymentModalonCase')
																.modal('hide');

														/*
														 * $ .ajax({ type :
														 * "POST", url :
														 * "Case_Management_Serv",
														 * data : { request_type :
														 * 'select_address_register_add_new',
														 * case_number :
														 * job_number,
														 * type_of_party :
														 * type_of_party,
														 * ar_name : ar_name,
														 * ar_gender :
														 * ar_gender,
														 * ar_cell_phone :
														 * ar_cell_phone,
														 * ar_id_type :
														 * ar_id_type,
														 * ar_id_number :
														 * ar_id_number }, cache :
														 * false, beforeSend :
														 * function() { //
														 * $('#district').html('<img //
														 * src="img/loading.gif" //
														 * alt="" // width="24" //
														 * height="24">'); },
														 * success : function(
														 * jobdetails) {
														 * 
														 * var table =
														 * $('#tbl_not_on_case_client_details_datatable');
														 * table .find( "tbody
														 * tr") .remove();
														 * 
														 * console
														 * .log(jobdetails); var
														 * json_p = JSON
														 * .parse(jobdetails); $(
														 * json_p) .each(
														 * function() {
														 * 
														 * table .append("<tr><td>" +
														 * this.ar_client_id + "</td><td>" +
														 * this.ar_name + "</td><td>" +
														 * this.ar_gender + "</td><td>" +
														 * this.ar_cell_phone + "</td><td>" +
														 * this.type_of_party + "</td>" // + // '<td><p //
														 * data-placement="top" //
														 * data-toggle="tooltip" //
														 * title="Transaction //
														 * Details"><button //
														 * class="btn //
														 * btn-info //
														 * btn-icon-split" //
														 * data-title="Delete" //
														 * data-toggle="modal" //
														 * data-target="#modalrecordinformation" //
														 * data-target-id="' // + //
														 * this.ms_id // + //
														 * '"><span //
														 * class="icon //
														 * text-white-50"> // <i //
														 * class="fas //
														 * fa-info-circle"></i></span><span //
														 * class="text">Add //
														 * to // List</span></button></p></td>' + "</tr>");
														 * }); } });
														 */

														// Generate CAGD Receipt
														var request = new XMLHttpRequest();
														var params = '{"agencyUniqueReference": "LC0003","receiptDescription": "Stamp duty","recipientName": "Kofi Ghana","recipientEmail": "kofi.ghana@gmail.com","recipientPhone": "0242012137", "amount": "165.5","receiptType": "LC-GEN","receivedBy": "Joe Bloggs"}';
														// request.responseType
														// = 'blob';
														request.onreadystatechange = function() {
															if (this.readyState == 4
																	&& this.status == 200) {
																// console.log(this.responseText);

																var blob = new Blob(
																		[ this.response ],
																		{
																			type : "application/pdf"
																		});
																var objectUrl = URL
																		.createObjectURL(blob);
																window
																		.open(objectUrl);

															}
														};

														request
																.open(
																		'POST',
																		'https://uat-cagdmdaapi.paqtechnologies.com/v1/receipts/createreceiptandfile',
																		true);
														request.responseType = 'blob';
														request
																.setRequestHeader(
																		'X-Api-Key',
																		'K0rDNV5zn7UdQsYjMJpRziRBsc3R80KM7MT8Q/O2Ddg=');
														request
																.setRequestHeader(
																		"Content-type",
																		"application/json");

														request.send(params);

													}
												});

									});

					$('#applicationStatusChecking')
							.on(
									'show.bs.modal',
									function(e) {

										console.log('Add to batchlist');

										$('#bl_job_number_mss').val(
												$(e.relatedTarget).data(
														'job_number'));
										$('#bl_ar_name_mss').val(
												$(e.relatedTarget).data(
														'ar_name'));
										$('#bl_business_process_sub_name_mss')
												.val(
														$(e.relatedTarget)
																.data(
																		'business_process_sub_name'));

										var business_process_id = $(
												e.relatedTarget).data(
												'business_process_id');
										var business_process_sub_id = $(
												e.relatedTarget).data(
												'business_process_sub_id');

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

														var table = $('#tbl_list_of_milestone_stone_dataTable_pf');
														table.find("tbody tr")
																.remove();

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$(json_p.data)
																.each(
																		function() {

																			var new_priority_value = this.priority_value;
																			console
																					.log(new_priority_value);
																			table
																					.append("<tr class='bg-success text-white red-tooltip' title='Aplication Stage Completed'  data-toggle='tooltip' data-placement='left'} ><td>"
																							+ this.milestone_description
																							+ "</td><td>"
																							+ this.mile_stone_status
																							+ "</td>"

																							+ "</tr>");

																		});

													}
												});

									});

					$('#servicePayment')
							.on(
									'show.bs.modal',
									function(e) {

										console.log($(e.relatedTarget).data(
												'ar_name'));

										$('#sp_job_number').val(
												$(e.relatedTarget).data(
														'ref_number'));
										$('#sp_ar_name').val(
												$(e.relatedTarget).data(
														'ar_name'));
										$('#sp_amount_due').val(
												$(e.relatedTarget).data(
														'bill_amount'));

										var ref_number = $(e.relatedTarget)
												.data('ref_number');
										var amount_due = $(e.relatedTarget)
												.data('bill_amount');

										$
												.ajax({
													type : "POST",
													url : "payment_serv",
													data : {
														request_type : 'generate_payment_payment_checkout',
														totalAmount : amount_due,
														description : 'Processing Fes',
														merchantAccountNumber : '',
														/*
														 * callbackUrl :
														 * 'http://localhost:8080/gelis_online_service_live/rest/payment_service/lc_payment_confirmation_for_bill_from_checkout',
														 * cancellationUrl :
														 * 'http://localhost:8080/gelis_online_service_live/rest/payment_service/lc_payment_confirmation_for_bill_from_checkout',
														 * returnUrl :
														 * 'http://localhost:8080/gelis_online_service_live/rest/payment_service/lc_payment_confirmation_for_bill_from_checkout',
														 */
														clientReference : ref_number
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

														$('#paymentcheckoutUrl')
																.attr(
																		'src',
																		json_p.data.checkoutUrl);

													}
												});

									});

					$('#servicePaymentcsau')
							.on(
									'show.bs.modal',
									function(e) {

										$('#sp_job_number').val(
												$(e.relatedTarget).data(
														'ref_number'));
										$('#sp_ar_name').val(
												$(e.relatedTarget).data(
														'ar_name'));
										$('#sp_amount_due').val(
												$(e.relatedTarget).data(
														'bill_amount'));

										var ref_number = $(e.relatedTarget)
												.data('ref_number');
										var amount_due = $(e.relatedTarget)
												.data('bill_amount');

										$
												.ajax({
													type : "POST",
													url : "payment_serv",
													data : {
														request_type : 'generate_payment_payment_checkout',
														totalAmount : amount_due,
														description : 'Processing Fes',
														merchantAccountNumber : '',
														callbackUrl : 'http://localhost:8080/gelis_online_service_live/rest/payment_service/lc_payment_confirmation_for_bill_from_checkout',
														cancellationUrl : 'http://localhost:8080/gelis_online_service_live/rest/payment_service/lc_payment_confirmation_for_bill_from_checkout',
														returnUrl : 'http://localhost:8080/gelis_online_service_live/rest/payment_service/lc_payment_confirmation_for_bill_from_checkout',
														clientReference : ref_number
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

														$('#paymentcheckoutUrl')
																.attr(
																		'src',
																		json_p.data.checkoutUrl);

													}
												});

									});

					$('#egcrReceipt')
							.on(
									'show.bs.modal',
									function(e) {

										console.log('Hosoddsf')
										$('#egcr_job_number').val(
												$(e.relatedTarget).data(
														'ref_number'));
										$('#egcr_ar_name').val(
												$(e.relatedTarget).data(
														'ar_name'));
										$('#egcr_amount_due').val(
												$(e.relatedTarget).data(
														'bill_amount'));

										var ref_number = $(e.relatedTarget)
												.data('ref_number');

										var ar_name = $(e.relatedTarget).data(
												'ar_name');

										var amount_due = $(e.relatedTarget)
												.data('bill_amount');

										// Generate CAGD Receipt
										var request = new XMLHttpRequest();
										var params = '{"agencyUniqueReference":"'
												+ ref_number
												+ '","receiptDescription": "Processing Fee","recipientName":"'
												+ ar_name
												+ '","recipientEmail": "kofi.ghana@gmail.com","recipientPhone": "0242012137", "amount":"'
												+ amount_due
												+ '","receiptType": "LC-GEN","receivedBy": "Assiamah"}';

										console.log(params);
										// request.responseType = 'blob';
										request.onreadystatechange = function() {
											if (this.readyState == 4
													&& this.status == 200) {
												// console.log(this.responseText);

												var blob = new Blob(
														[ this.response ],
														{
															type : "application/pdf"
														});
												var objectUrl = URL

												.createObjectURL(blob);
												// window.open(objectUrl);

												$('#egcrblobfile').attr('src',
														objectUrl);

											}
										};

										request
												.open(
														'POST',
														'https://uat-cagdmdaapi.paqtechnologies.com/v1/receipts/createreceiptandfile',
														true);
										request.responseType = 'blob';
										request
												.setRequestHeader('X-Api-Key',
														'K0rDNV5zn7UdQsYjMJpRziRBsc3R80KM7MT8Q/O2Ddg=');
										request.setRequestHeader(
												"Content-type",
												"application/json");

										request.send(params);

									});

				});