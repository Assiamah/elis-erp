$(document)
		.ready(
				function() {

					$('#lrd_btn_search_by_transaction_reference_number')
							.on(
									'click',
									function(e) {

										var reference_number = $(
												'#lrd_search_by_text').val();

										var table = $('#lrd_transaction_dataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'load_lrd_transaction_details_by_certificate_number',
														certificate_number : reference_number
													},
													cache : false,
													success : function(
															serviceresponse) {

														var json_p = JSON
																.parse(serviceresponse);
														console.log(json_p)

														/*
														 * $(
														 * '#lrd_txt_wkt_polygon')
														 * .val( json_p.wkt);
														 */

														$(json_p.data)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.applicant_name
																							+ "</td><td>"
																							+ this.grantor_name
																							+ "</td><td>"
																							+ this.certicate_number
																							+ "</td><td>"
																							+ this.nature_of_instument
																							+ "</td>"

																							+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addlrdtransaction" data-target-id="'
																							+ this.gid
																							+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																							+ "</tr>");
																		});

													}
												});

									});

					// $('#transitional_certificate_template')
					// 		.on(
					// 				'show.bs.modal',
					// 				function(event) {

					// 					var job_number = $(event.relatedTarget)
					// 							.data('job_number');
					// 					var transaction_number = $(
					// 							event.relatedTarget).data(
					// 							'transaction_number');
					// 					var case_number = $(event.relatedTarget)
					// 							.data('case_number');

					// 					//console.log(job_number);
					// 					//console.log(transaction_number);
					// 					//console.log(case_number);

					// 					$
					// 							.ajax({
					// 								type : "POST",
					// 								url : "Case_Management_Serv",
					// 								data : {
					// 									request_type : 'select_general_case_details',
					// 									job_number : job_number,
					// 									transaction_number : case_number,
					// 									case_number : case_number

					// 								},
					// 								cache : false,
					// 								beforeSend : function() {
					// 									// $('#district').html('<img
					// 									// src="img/loading.gif"
					// 									// alt="" width="24"
					// 									// height="24">');
					// 								},
					// 								success : function(
					// 										jobdetails) {

					// 									console.log(jobdetails);

					// 									var result = JSON
					// 											.parse(jobdetails);

					// 									// console.log(result)

					// 									if (result.parcel_details !== null) {
					// 										// console.log("not

					// 										$(
					// 												"#cs_main_case_number")
					// 												.val(
					// 														result.parcel_details.case_number);

					// 										$("#cs_main_glpin")
					// 												.val(
					// 														result.parcel_details.glpin);

					// 										$(
					// 												"#cs_main_licensed_no")
					// 												.val(
					// 														result.parcel_details.licensed_no);

					// 										$(
					// 												"#cs_main_regional_number")
					// 												.val(
					// 														result.parcel_details.regional_number);

					// 										$(
					// 												"#cs_main_locality")
					// 												.val(
					// 														result.parcel_details.locality);
					// 										$(
					// 												"#cs_main_district")
					// 												.val(
					// 														result.parcel_details.district);

					// 										$("#cs_main_region")
					// 												.val(
					// 														result.parcel_details.region);

					// 										$(
					// 												"#cs_main_size_of_land")
					// 												.val(
					// 														result.parcel_details.land_size);

					// 										$(
					// 												"#cs_main_registry_mapref")
					// 												.val(
					// 														result.parcel_details.registry_mapref);

					// 										$(
					// 												"#cs_main_plan_no")
					// 												.val(
					// 														result.parcel_details.plan_no);

					// 										$("#cs_main_cc_no")
					// 												.val(
					// 														result.parcel_details.cc_no);

					// 										$(
					// 												"#cs_main_ltr_plan_no")
					// 												.val(
					// 														result.parcel_details.ltr_plan_no);
					// 										$(
					// 												"#cs_main_locality_class")
					// 												.val(
					// 														result.parcel_details.locality_class);
					// 										$(
					// 												"#cs_main_registration_district_number")
					// 												.val(
					// 														result.parcel_details.registration_district_number);

					// 										$(
					// 												"#cs_main_registration_section_number")
					// 												.val(
					// 														result.parcel_details.registration_section_number);
					// 										$(
					// 												"#cs_main_registration_block_number")
					// 												.val(
					// 														result.parcel_details.registration_block_number);
					// 									}

					// 									if (result.transaction_details !== null) {
					// 										// console.log("not

					// 										$(
					// 												"#cs_main_ar_name")
					// 												.val(
					// 														result.transaction_details.ar_name);
					// 										$(
					// 												"#cs_main_case_number")
					// 												.val(
					// 														result.transaction_details.case_number);
					// 										$(
					// 												"#cs_main_transaction_number")
					// 												.val(
					// 														result.transaction_details.transaction_number);
					// 										$(
					// 												"#cs_main_date_of_document")
					// 												.val(
					// 														result.transaction_details.date_of_document);
					// 										$(
					// 												"#cs_main_nature_of_instrument")
					// 												.val(
					// 														result.transaction_details.nature_of_instrument);
					// 										$(
					// 												"#cs_main_certificate_number")
					// 												.val(
					// 														result.transaction_details.certificate_number);
					// 										$(
					// 												"#cs_main_type_of_interest")
					// 												.val(
					// 														result.transaction_details.type_of_interest);

					// 										$(
					// 												"#cs_main_type_of_use")
					// 												.val(
					// 														result.transaction_details.type_of_use);
					// 										$(
					// 												"#cs_main_volume_number")
					// 												.val(
					// 														result.transaction_details.volume_number);
					// 										$(
					// 												"#cs_main_folio_number")
					// 												.val(
					// 														result.transaction_details.folio_number);

					// 										$("#cs_main_term")
					// 												.val(
					// 														result.transaction_details.term);
					// 										$(
					// 												"#cs_main_commencement_date")
					// 												.val(
					// 														result.transaction_details.commencement_date);

					// 										$(
					// 												"#cs_main_renewal_term")
					// 												.val(
					// 														result.transaction_details.renewal_term);

					// 										$(
					// 												"#cs_main_consideration_fee")
					// 												.val(
					// 														result.transaction_details.consideration_fee);
					// 										$(
					// 												"#cs_main_stamp_duty_payable")
					// 												.val(
					// 														result.transaction_details.stamp_duty_payable);

					// 										$(
					// 												"#cs_main_assessed_value")
					// 												.val(
					// 														result.transaction_details.assessed_value);

					// 										$(
					// 												"#cs_main_parcel_description")
					// 												.val(
					// 														result.transaction_details.parcel_description);
					// 										$(
					// 												"#cs_main_plot_number")
					// 												.val(
					// 														result.transaction_details.plot_number);
					// 										$(
					// 												"#cs_main_publicity_date")
					// 												.val(
					// 														result.transaction_details.publicity_date);
					// 										$(
					// 												"#cs_main_date_of_registration")
					// 												.val(
					// 														result.transaction_details.date_of_registration);

					// 										$(
					// 												"#cs_main_case_status")
					// 												.val(
					// 														result.transaction_details.case_status);
					// 										$(
					// 												"#cs_main_case_file_number")
					// 												.val(
					// 														result.transaction_details.case_file_number);

					// 									}

					// 									/*
					// 									 * if (result.job_detail
					// 									 * !== null) { //
					// 									 * console.log("not
					// 									 * 
					// 									 * $("#fe_client_name")
					// 									 * .val(
					// 									 * result.job_detail.ar_name); }
					// 									 */

					// 									if (result.job_detail !== null) {
					// 										// console.log("not
					// 										// null")

					// 										$(
					// 												"job_number_placeholder")
					// 												.append(
					// 														result.job_detail.job_number);

					// 										$(
					// 												"#cs_main_business_process_id")
					// 												.val(
					// 														result.job_detail.business_process_id);
					// 										$(
					// 												"#cs_main_business_process_name")
					// 												.val(
					// 														result.job_detail.business_process_name);

					// 										$(
					// 												"#cs_main_business_process_sub_id")
					// 												.val(
					// 														result.job_detail.business_process_sub_id);

					// 										$(
					// 												"#cs_main_business_process_sub_name")
					// 												.val(
					// 														result.job_detail.business_process_sub_name);

					// 										$(
					// 												"#cs_main_job_number")
					// 												.val(
					// 														result.job_detail.job_number);

					// 										/*
					// 										 * console
					// 										 * .log("case is " +
					// 										 * fe_case_number_new);
					// 										 */

					// 										if (result.lrd_proprietorship_section !== null) {
					// 											var table = $('#lrd_proprietorship_details_dataTable');
					// 											table
					// 													.find(
					// 															"tbody tr")
					// 													.remove();

					// 											$(
					// 													result.lrd_proprietorship_section)
					// 													.each(
					// 															function() {

					// 																table
					// 																		.append("<tr><td>"
					// 																				+ this.ps_registration_number
					// 																				+ "</td><td>"
					// 																				+ this.ps_proprietor
					// 																				+ "</td><td>"
					// 																				+ this.ps_date_of_instrument
					// 																				+ "</td><td>"
					// 																				+ this.ps_nature_of_instrument

					// 																				+ "</td>"

					// 																				+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" '
					// 																				+ 'data-ps_id="'
					// 																				+ this.ps_id
					// 																				+ '" '
					// 																				+ 'data-ps_registration_number="'
					// 																				+ this.ps_registration_number
					// 																				+ '" '
					// 																				+ 'data-ps_proprietor="'
					// 																				+ this.ps_proprietor
					// 																				+ '" '
					// 																				+ 'data-ps_date_of_instrument="'
					// 																				+ this.ps_date_of_instrument
					// 																				+ '" '
					// 																				+ 'data-ps_nature_of_instrument="'
					// 																				+ this.ps_nature_of_instrument
					// 																				+ '" '
					// 																				+ 'data-ps_date_of_registration="'
					// 																				+ this.ps_date_of_registration
					// 																				+ '" '
					// 																				+ 'data-ps_transferor="'
					// 																				+ this.ps_transferor
					// 																				+ '" '
					// 																				+ 'data-ps_transferee="'
					// 																				+ this.ps_transferee
					// 																				+ '" '
					// 																				+ 'data-ps_price_paid="'
					// 																				+ this.ps_price_paid
					// 																				+ '" '
					// 																				+ 'data-ps_remarks="'
					// 																				+ this.ps_remarks
					// 																				+ '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

					// 																				+ "</tr>");
					// 															});

					// 										}

					// 										if (result.lrd_memorials_section !== null) {
					// 											var table = $('#lrd_memorial_details_dataTable');
					// 											table
					// 													.find(
					// 															"tbody tr")
					// 													.remove();

					// 											$(
					// 													result.lrd_memorials_section)
					// 													.each(
					// 															function() {

					// 																table
					// 																		.append("<tr><td>"
					// 																				+ this.m_registered_no
					// 																				+ "</td><td>"
					// 																				+ this.m_memorials
					// 																				+ "</td><td>"
					// 																				+ this.m_date_of_instrument
					// 																				+ "</td><td>"
					// 																				+ this.m_date_of_registration

					// 																				+ "</td>"

					// 																				+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newMemorialsModal" '
					// 																				+ 'data-mid="'
					// 																				+ this.mid
					// 																				+ '" '
					// 																				+ 'data-m_registered_no="'
					// 																				+ this.m_registered_no
					// 																				+ '" '
					// 																				+ 'data-m_memorials="'
					// 																				+ this.m_memorials
					// 																				+ '" '
					// 																				+ 'data-m_date_of_instrument="'
					// 																				+ this.m_date_of_instrument
					// 																				+ '" '
					// 																				+ 'data-m_date_of_registration="'
					// 																				+ this.m_date_of_registration
					// 																				+ '" '
					// 																				+ 'data-m_back="'
					// 																				+ this.m_back
					// 																				+ '" '
					// 																				+ 'data-m_forward="'
					// 																				+ this.m_forward
					// 																				+ '" '
					// 																				+ 'data-m_remarks="'
					// 																				+ this.m_remarks
					// 																				+ '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

					// 																				+ "</tr>");
					// 															});

					// 										}

					// 										if (result.lrd_valuation_section !== null) {
					// 											var table = $('#lrd_valuation_details_dataTable');
					// 											table
					// 													.find(
					// 															"tbody tr")
					// 													.remove();

					// 											$(
					// 													result.lrd_valuation_section)
					// 													.each(
					// 															function() {

					// 																table
					// 																		.append("<tr><td>"
					// 																				+ this.vs_date_of_valuation
					// 																				+ "</td><td>"
					// 																				+ this.vs_amount
					// 																				+ "</td><td>"
					// 																				+ this.vs_remarks

					// 																				+ "</td>"

					// 																				+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newValuationModal" '
					// 																				+ 'data-vs_id="'
					// 																				+ this.vs_id
					// 																				+ '" '
					// 																				+ 'data-vs_date_of_valuation="'
					// 																				+ this.vs_date_of_valuation
					// 																				+ '" '
					// 																				+ 'data-vs_amount="'
					// 																				+ this.vs_amount
					// 																				+ '" '

					// 																				+ 'data-vs_remarks="'
					// 																				+ this.vs_remarks
					// 																				+ '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

					// 																				+ "</tr>");
					// 															});

					// 										}

					// 										if (result.lrd_certificate_section !== null) {
					// 											var table = $('#lrd_certificate_details_dataTable');
					// 											table
					// 													.find(
					// 															"tbody tr")
					// 													.remove();

					// 											$(
					// 													result.lrd_certificate_section)
					// 													.each(
					// 															function() {

					// 																table
					// 																		.append("<tr><td>"
					// 																				+ this.cs_date_of_registration
					// 																				+ "</td><td>"
					// 																				+ this.cs_to_whom_issued
					// 																				+ "</td><td>"
					// 																				+ this.cs_serial_number
					// 																				+ "</td><td>"
					// 																				+ this.cs_official_notes

					// 																				+ "</td>"

					// 																				+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newCertificateModal" '
					// 																				+ 'data-mid="'
					// 																				+ this.cs_id
					// 																				+ '" '
					// 																				+ 'data-cs_date_of_registration="'
					// 																				+ this.cs_date_of_registration
					// 																				+ '" '
					// 																				+ 'data-cs_to_whom_issued="'
					// 																				+ this.cs_to_whom_issued
					// 																				+ '" '
					// 																				+ 'data-cs_serial_number="'
					// 																				+ this.cs_serial_number
					// 																				+ '" '
					// 																				+ 'data-cs_official_notes="'
					// 																				+ this.cs_official_notes

					// 																				+ '" '
					// 																				+ 'data-cs_official_notes="'
					// 																				+ this.cs_official_notes
					// 																				+ '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

					// 																				+ "</tr>");
					// 															});

					// 										}

					// 									} else {

					// 										$
					// 												.notify(
					// 														{
					// 															message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
					// 														},
					// 														{
					// 															type : 'danger' , z_index: 9999 
					// 														});

					// 									}

					// 									// -----------------------------

					// 								}
					// 							});

					// 				});

					/*$('#btn_update_case_of_old_application')
							.on(
									'click',
									function(e) {

										var registry_mapref = $(
												"#cs_main_registry_mapref")
												.val();

										var surveyor_number = $(
												"#cs_main_surveyor_number")
												.val();
										var regional_number = $(
												"#cs_main_regional_number")
												.val();
										var land_size = $("#cs_main_land_size")
												.val();
										var district = $("#cs_main_district")
												.val();
										var region = $("#cs_main_region").val();
										var locality = $("#cs_main_locality")
												.val();

										var case_number = $(
												"#cs_main_case_number").val();
										var transaction_number = $(
												"#cs_main_transaction_number")
												.val();
										var annual_rent = $(
												"#cs_main_annual_rent").val();
										var commencement_date = $(
												"#cs_main_commencement_date")
												.val();
										var stool_family_name = $(
												"#cs_main_family_name").val();
										var family_of_grantor = $(
												"#cs_main_grantor_family")
												.val();
										var renewal_term = $(
												"#cs_main_renewal_term").val();
										var term = $("#cs_main_term").val();
										var date_of_document = $(
												"#cs_main_date_of_document")
												.val();
										var consideration_fee = $(
												"#cs_main_consideration_fee")
												.val();
										var type_of_use = $(
												"#cs_main_type_of_use").val();
										var extent = $("#cs_main_extent").val();
										var size_of_land = $(
												"#cs_main_land_size").val();
										var type_of_interest = $(
												"#cs_main_type_of_interest")
												.val();
										var nature_of_instrument = $(
												"#cs_main_nature_of_instrument")
												.val();
										var file_number = $(
												"#cs_main_file_number").val();
										var modified_by = localStorage
												.getItem("fullname");
										var modified_by_id = localStorage
												.getItem("userid");

										console
												.log('form submited Clicked New: '
														+ registry_mapref);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'select_update_case_old_application',
														surveyor_number : surveyor_number,
														regional_number : regional_number,
														land_size : land_size,
														district : district,
														region : region,
														locality : locality,
														registry_mapref : registry_mapref,

														case_number : transaction_number,
														annual_rent : annual_rent,
														commencement_date : commencement_date,
														stool_family_name : stool_family_name,
														family_of_grantor : family_of_grantor,
														renewal_term : renewal_term,
														term : term,
														date_of_document : date_of_document,
														consideration_fee : consideration_fee,
														extent : extent,
														size_of_land : size_of_land,
														type_of_interest : type_of_interest,
														nature_of_instrument : nature_of_instrument,
														file_number : file_number,
														type_of_use : type_of_use,
														modified_by : modified_by,
														modified_by_id : modified_by_id
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
														var result = JSON
																.parse(jobdetails);

														if (result.data == 'Success') {
															var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Success!</strong> Case details saved successfully</div>';

															console
																	.log(jobdetails)

															$(
																	"#alert-display-space")
																	.append(
																			alert_mess);
															// Do Add to
															// Batclist
															// console.log('Add
															// to batchlist');

															var job_number = $(
																	"#cs_main_job_number")
																	.val();
															// var send_by_id =
															// $("#modified_by_id").val();
															// var send_by
															// =$("#modified_by").val();
															var ar_name = $(
																	"#cs_main_client_name")
																	.val();
															var business_process_sub_name = $(
																	"#cs_main_business_process_sub_name")
																	.val();

														} else {
															var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Failure!</strong> Something went wrong, Please try again</div>';

														}
													}

												});
									});*/ 

										$(
												'#lrd_btn_search_by_transaction_reference_number')
												.on(
														'click',
														function(e) {

															var reference_number = $(
																	'#lrd_search_by_text')
																	.val();

															var table = $('#lrd_transaction_dataTable');
															table.find(
																	"tbody tr")
																	.remove();
															$
																	.ajax({
																		type : "POST",
																		url : 'Maps',
																		data : {
																			request_type : 'load_lrd_transaction_details_by_certificate_number',
																			certificate_number : reference_number
																		},
																		cache : false,
																		success : function(
																				serviceresponse) {

																			var json_p = JSON
																					.parse(serviceresponse);
																			console
																					.log(json_p)

																			/*
																			 * $(
																			 * '#lrd_txt_wkt_polygon')
																			 * .val(
																			 * json_p.wkt);
																			 */

																			$(
																					json_p.data)
																					.each(
																							function() {

																								table
																										.append("<tr><td>"
																												+ this.applicant_name
																												+ "</td><td>"
																												+ this.grantor_name
																												+ "</td><td>"
																												+ this.certicate_number
																												+ "</td><td>"
																												+ this.nature_of_instument
																												+ "</td>"

																												+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addlrdtransaction" data-target-id="'
																												+ this.gid
																												+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																												+ "</tr>");
																							});

																		}
																	});

														});

										$('#transitional_certificate_template')
												.on(
														'show.bs.modal',
														function(event) {

															var job_number = $(
																	event.relatedTarget)
																	.data(
																			'job_number');
															var transaction_number = $(
																	event.relatedTarget)
																	.data(
																			'transaction_number');
															var case_number = $(
																	event.relatedTarget)
																	.data(
																			'case_number');

															console
																	.log(job_number);
															console
																	.log(transaction_number);
															console
																	.log(case_number);

															$
																	.ajax({
																		type : "POST",
																		url : "Case_Management_Serv",
																		data : {
																			request_type : 'select_general_case_details',
																			job_number : job_number,
																			transaction_number : case_number,
																			case_number : case_number

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

																			console.log(jobdetails);

																			var result = JSON
																					.parse(jobdetails);

																			// console.log(result)

																			if (result.parcel_details !== null) {
																				// console.log("not

																				$(
																						"#ts_main_case_number_sm")
																						.val(
																								result.parcel_details.case_number);

																				$(
																						"#ts_main_glpin_sm")
																						.val(
																								result.parcel_details.glpin);

																				$(
																						"#ts_main_licensed_no_sm")
																						.val(
																								result.parcel_details.licensed_no);

																				$(
																						"#ts_main_regional_number_sm")
																						.val(
																								result.parcel_details.regional_number);

																				$(
																						"#ts_main_locality_sm")
																						.val(
																								result.parcel_details.locality);
																				$(
																						"#ts_main_district_sm")
																						.val(
																								result.parcel_details.district);

																				$(
																						"#ts_main_region_sm")
																						.val(
																								result.parcel_details.region);

																				$(
																						"#ts_main_size_of_land_sm")
																						.val(
																								result.parcel_details.land_size);

																				$(
																						"#ts_main_registry_mapref_sm")
																						.val(
																								result.parcel_details.registry_mapref);

																				$(
																						"#ts_main_plan_no_sm")
																						.val(
																								result.parcel_details.plan_no);

																				$(
																						"#ts_main_cc_no_sm")
																						.val(
																								result.parcel_details.cc_no);

																				$(
																						"#ts_main_ltr_plan_no_sm")
																						.val(
																								result.parcel_details.ltr_plan_no);
																				$(
																						"#ts_main_locality_class_sm")
																						.val(
																								result.parcel_details.locality_class);
																				$(
																						"#ts_main_registration_district_number_sm")
																						.val(
																								result.parcel_details.registration_district_number);

																				$(
																						"#ts_main_registration_section_number_sm")
																						.val(
																								result.parcel_details.registration_section_number);
																				$(
																						"#ts_main_registration_block_number_sm")
																						.val(
																								result.parcel_details.registration_block_number);
																					
																								$(
																									"#ts_main_smd_reference_number_sm")
																									.val(
																											result.parcel_details.smd_reference_number);

																											$(
																												"#ts_main_smd_type_of_plotting_sm")
																												.val(
																														result.parcel_details.smd_type_of_plotting);
																			}

																			if (result.transaction_details !== null) {
																				// console.log("not

																				$(
																						"#ts_main_ar_name_sm")
																						.val(
																								result.transaction_details.ar_name);
																				$(
																						"#ts_main_case_number_sm")
																						.val(
																								result.transaction_details.case_number);
																				$(
																						"#ts_main_transaction_number_sm")
																						.val(
																								result.transaction_details.transaction_number);
																				$(
																						"#ts_main_date_of_document_sm")
																						.val(
																								result.transaction_details.date_of_document);
																				$(
																						"#ts_main_nature_of_instrument_sm")
																						.val(
																								result.transaction_details.nature_of_instrument);
																				$(
																						"#ts_main_certificate_number_sm")
																						.val(
																								result.transaction_details.certificate_number);
																				$(
																						"#ts_main_type_of_interest_sm")
																						.val(
																								result.transaction_details.type_of_interest);

																				$(
																						"#ts_main_type_of_use_sm")
																						.val(
																								result.transaction_details.type_of_use);
																				$(
																						"#ts_main_volume_number_sm")
																						.val(
																								result.transaction_details.volume_number);
																				$(
																						"#ts_main_folio_number_sm")
																						.val(
																								result.transaction_details.folio_number);

																				$(
																						"#ts_main_term_sm")
																						.val(
																								result.transaction_details.term);
																				$(
																						"#ts_main_commencement_date_sm")
																						.val(
																								result.transaction_details.commencement_date);

																				$(
																						"#ts_main_renewal_term_sm")
																						.val(
																								result.transaction_details.renewal_term);

																				$(
																						"#ts_main_consideration_fee_sm")
																						.val(
																								result.transaction_details.consideration_fee);
																				$(
																						"#ts_main_stamp_duty_payable_sm")
																						.val(
																								result.transaction_details.stamp_duty_payable);

																				$(
																						"#ts_main_assessed_value_sm")
																						.val(
																								result.transaction_details.assessed_value);

																				$(
																						"#ts_main_parcel_description_sm")
																						.val(
																								result.transaction_details.parcel_description);
																				$(
																						"#ts_main_plot_number_sm")
																						.val(
																								result.transaction_details.plot_number);
																				$(
																						"#ts_main_publicity_date_sm")
																						.val(
																								result.transaction_details.publicity_date);
																				$(
																						"#ts_main_date_of_registration_sm")
																						.val(
																								result.transaction_details.date_of_registration);

																				$(
																						"#ts_main_case_status_sm")
																						.val(
																								result.transaction_details.case_status);
																				$(
																						"#ts_main_case_file_number_sm")
																						.val(
																								result.transaction_details.case_file_number);

																								$(
																									"#ts_main_case_registered_number_sm")
																									.val(
																											result.transaction_details.registered_number);


																											$(
																												"#ts_main_case_consideration_fee_currency_sm")
																												.val(
																														result.transaction_details.consideration_fee_currency);

																														$(
																															"#ts_main_case_consideration_fee_adopted_rate_sm")
																															.val(
																																	result.transaction_details.consideration_fee_adopted_rate);

																								
																								
																								

																								$(
																									"#ts_main_case_date_of_issue_sm")
																									.val(
																											result.transaction_details.date_of_issue);
																								$(
																									"#ts_main_interest_number")
																									.val(
																											result.transaction_details.interest_number);

																											$(
																												"#ts_main_sub_interest_number")
																												.val(
																														result.transaction_details.sub_interest_number);

																			}

																			/*
																			 * if
																			 * (result.job_detail
																			 * !==
																			 * null) { //
																			 * console.log("not
																			 * 
																			 * $("#fe_client_name")
																			 * .val(
																			 * result.job_detail.ar_name); }
																			 */

																			if (result.job_detail !== null) {
																				// console.log("not
																				// null")

																				$(
																						"job_number_placeholder_sm")
																						.append(
																								result.job_detail.job_number);

																				$(
																						"#ts_main_business_process_id_sm")
																						.val(
																								result.job_detail.business_process_id);
																				$(
																						"#ts_main_business_process_name_sm")
																						.val(
																								result.job_detail.business_process_name);

																				$(
																						"#ts_main_business_process_sub_id_sm")
																						.val(
																								result.job_detail.business_process_sub_id);

																				$(
																						"#ts_main_business_process_sub_name_sm")
																						.val(
																								result.job_detail.business_process_sub_name);

																				$(
																						"#ts_main_job_number_sm")
																						.val(
																								result.job_detail.job_number);

																				/*
																				 * console
																				 * .log("case
																				 * is " +
																				 * fe_case_number_new);
																				 */

																				if (result.lrd_proprietorship_section !== null) {
																					var table = $('#lrd_proprietorship_details_dataTable_2, #lrd_proprietorship_details_dataTable_3');
																					table
																							.find(
																									"tbody tr")
																							.remove();

																					$(
																							result.lrd_proprietorship_section)
																							.each(
																									function() {

																										table
																												.append("<tr><td>"
																														+ this.ps_registration_number
																														+ "</td><td>"
																														+ this.ps_proprietor
																														+ "</td><td>"
																														+ this.ps_date_of_instrument
																														+ "</td><td>"
																														+ this.ps_nature_of_instrument

																														+ "</td>"

																														// + '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" '
																														// + 'data-ps_id="'
																														// + this.ps_id
																														// + '" '
																														// + 'data-ps_registration_number="'
																														// + this.ps_registration_number
																														// + '" '
																														// + 'data-ps_proprietor="' 
																														// + this.ps_proprietor
																														// + '" '
																														// + 'data-ps_date_of_instrument="'
																														// + this.ps_date_of_instrument
																														// + '" '
																														// + 'data-ps_nature_of_instrument="'
																														// + this.ps_nature_of_instrument
																														// + '" '
																														// + 'data-ps_date_of_registration="'
																														// + this.ps_date_of_registration
																														// + '" '
																														// + 'data-ps_transferor="'
																														// + this.ps_transferor
																														// + '" '
																														// + 'data-ps_transferee="'
																														// + this.ps_transferee
																														// + '" '
																														// + 'data-ps_price_paid="'
																														// + this.ps_price_paid
																														// + '" '
																														// + 'data-ps_remarks="'
																														// + this.ps_remarks
																														// + '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

																														+ "</tr>");
																									});

																				}

																				if (result.lrd_memorials_section !== null) {
																					var table = $('#lrd_memorial_details_dataTable_2, #lrd_memorial_details_dataTable_3');
																					table
																							.find(
																									"tbody tr")
																							.remove();

																					$(
																							result.lrd_memorials_section)
																							.each(
																									function() {

																										table
																												.append("<tr><td>"
																														+ this.m_registered_no
																														+ "</td><td>"
																														+ this.m_memorials
																														+ "</td><td>"
																														+ this.m_date_of_instrument
																														+ "</td><td>"
																														+ this.m_date_of_registration

																														+ "</td>"

																														// + '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newMemorialsModal" '
																														// + 'data-mid="'
																														// + this.mid
																														// + '" '
																														// + 'data-m_registered_no="'
																														// + this.m_registered_no
																														// + '" '
																														// + 'data-m_memorials="'
																														// + this.m_memorials
																														// + '" '
																														// + 'data-m_date_of_instrument="'
																														// + this.m_date_of_instrument
																														// + '" '
																														// + 'data-m_date_of_registration="'
																														// + this.m_date_of_registration
																														// + '" '
																														// + 'data-m_back="'
																														// + this.m_back
																														// + '" '
																														// + 'data-m_forward="'
																														// + this.m_forward
																														// + '" '
																														// + 'data-m_remarks="'
																														// + this.m_remarks
																														// + '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

																														+ "</tr>");
																									});

																				}

																				if (result.lrd_valuation_section !== null) {
																					var table = $('#lrd_valuation_details_dataTable_2, #lrd_valuation_details_dataTable_3');
																					table
																							.find(
																									"tbody tr")
																							.remove();

																					$(
																							result.lrd_valuation_section)
																							.each(
																									function() {

																										table
																												.append("<tr><td>"
																														+ this.vs_date_of_valuation
																														+ "</td><td>"
																														+ this.vs_amount
																														+ "</td><td>"
																														// + this.vs_remarks
																														// + "</td><td>"
																														+ this.vs_remarks

																														+ "</td>"

																														// + '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newValuationModal" '
																														// + 'data-mid="'
																														// + this.mid
																														// + '" '
																														// + 'data-m_registered_no="'
																														// + this.m_registered_no
																														// + '" '
																														// + 'data-m_memorials="'
																														// + this.m_memorials
																														// + '" '
																														// + 'data-m_date_of_instrument="'
																														// + this.m_date_of_instrument
																														// + '" '
																														// + 'data-m_date_of_registration="'
																														// + this.m_date_of_registration
																														// + '" '
																														// + 'data-m_back="'
																														// + this.m_back
																														// + '" '
																														// + 'data-m_forward="'
																														// + this.m_forward
																														// + '" '
																														// + 'data-m_remarks="'
																														// + this.m_remarks
																														// + '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

																														+ "</tr>");
																									});

																				}
																				
																				if (result.lrd_certificate_section !== null) {
																					var table = $('#lrd_certificate_details_dataTable_2, #lrd_certificate_details_dataTable_3');
																					table
																							.find(
																									"tbody tr")
																							.remove();

																					$(
																							result.lrd_certificate_section)
																							.each(
																									function() {

																										table
																												.append("<tr><td>"
																														+ this.cs_date_of_registration
																														+ "</td><td>"
																														+ this.cs_to_whom_issued
																														+ "</td><td>"
																														+ this.cs_serial_number
																														+ "</td><td>"
																														+ this.cs_official_notes

																														+ "</td>"

																														// + '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newCertificateModal" '
																														// + 'data-mid="'
																														// + this.cs_id
																														// + '" '
																														// + 'data-cs_date_of_registration="'
																														// + this.cs_date_of_registration
																														// + '" '
																														// + 'data-cs_to_whom_issued="'
																														// + this.cs_to_whom_issued
																														// + '" '
																														// + 'data-cs_serial_number="'
																														// + this.cs_serial_number
																														// + '" '
																														// + 'data-cs_official_notes="'
																														// + this.cs_official_notes

																														// + '" '
																														// + 'data-cs_official_notes="'
																														// + this.cs_official_notes
																														// + '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

																														+ "</tr>");
																									});

																				}

																				if (result.lrd_encumbrances_section !== null) {
																					var table = $('#lrd_registration_encumbrance_dataTable, #lrd_registration_encumbrance_dataTable_2');
																					table
																							.find(
																									"tbody tr")
																							.remove();

																					$(
																							result.lrd_encumbrances_section)
																							.each(
																									function() {

																										table
																												.append("<tr><td>"
																														+ this.es_registered_number
																														+ "</td><td>"
																														+ this.es_date_of_instrument
																														+ "</td><td>"
																														+ this.es_date_of_registration
																														+ "</td><td>"
																														+ this.es_memorials
																														+ "</td><td>"
																														+ this.es_remarks

																														+ "</td>"

																														// + '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newCertificateModal" '
																														// + 'data-mid="'
																														// + this.cs_id
																														// + '" '
																														// + 'data-cs_date_of_registration="'
																														// + this.cs_date_of_registration
																														// + '" '
																														// + 'data-cs_to_whom_issued="'
																														// + this.cs_to_whom_issued
																														// + '" '
																														// + 'data-cs_serial_number="'
																														// + this.cs_serial_number
																														// + '" '
																														// + 'data-cs_official_notes="'
																														// + this.cs_official_notes

																														// + '" '
																														// + 'data-cs_official_notes="'
																														// + this.cs_official_notes
																														// + '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

																														+ "</tr>");
																									});

																				}

																			} else {

																				$
																						.notify(
																								{
																									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
																								},
																								{
																									type : 'danger' , z_index: 9999 
																								});

																			}

																			// -----------------------------

																		}
																	});

														});

										$('#btn_update_case_of_old_application')
												.on(
														'click',
														function(e) {

															var registry_mapref = $(
																	"#cs_main_registry_mapref_sm")
																	.val();

															var surveyor_number = $(
																	"#cs_main_surveyor_number_sm")
																	.val();
															var regional_number = $(
																	"#cs_main_regional_number_sm")
																	.val();
															var land_size = $(
																	"#cs_main_land_size_sm")
																	.val();
															var district = $(
																	"#cs_main_district_sm")
																	.val();
															var region = $(
																	"#cs_main_region_sm")
																	.val();
															var locality = $(
																	"#cs_main_locality_sm")
																	.val();

															var case_number = $(
																	"#cs_main_case_number_sm")
																	.val();
															var transaction_number = $(
																	"#cs_main_transaction_number_sm")
																	.val();
															var annual_rent = $(
																	"#cs_main_annual_rent_sm")
																	.val();
															var commencement_date = $(
																	"#cs_main_commencement_date_sm")
																	.val();
															var stool_family_name = $(
																	"#cs_main_family_name_sm")
																	.val();
															var family_of_grantor = $(
																	"#cs_main_grantor_family_sm")
																	.val();
															var renewal_term = $(
																	"#cs_main_renewal_term_sm")
																	.val();
															var term = $(
																	"#cs_main_term_sm")
																	.val();
															var date_of_document = $(
																	"#cs_main_date_of_document_sm")
																	.val();
															var consideration_fee = $(
																	"#cs_main_consideration_fee_sm")
																	.val();
															var type_of_use = $(
																	"#cs_main_type_of_use_sm")
																	.val();
															var extent = $(
																	"#cs_main_extent_sm")
																	.val();
															var size_of_land = $(
																	"#cs_main_land_size_sm")
																	.val();
															var type_of_interest = $(
																	"#cs_main_type_of_interest_sm")
																	.val();
															var nature_of_instrument = $(
																	"#cs_main_nature_of_instrument_sm")
																	.val();
															var file_number = $(
																	"#cs_main_file_number_sm")
																	.val();
															/*var modified_by = localStorage
																	.getItem("fullname");
															var modified_by_id = localStorage
																	.getItem("userid");*/

															console
																	.log('form submited Clicked New: '
																			+ registry_mapref);

															$
																	.ajax({
																		type : "POST",
																		url : "Case_Management_Serv",
																		data : {
																			request_type : 'select_update_case_old_application',
																			surveyor_number : surveyor_number,
																			regional_number : regional_number,
																			land_size : land_size,
																			district : district,
																			region : region,
																			locality : locality,
																			registry_mapref : registry_mapref,

																			case_number : transaction_number,
																			annual_rent : annual_rent,
																			commencement_date : commencement_date,
																			stool_family_name : stool_family_name,
																			family_of_grantor : family_of_grantor,
																			renewal_term : renewal_term,
																			term : term,
																			date_of_document : date_of_document,
																			consideration_fee : consideration_fee,
																			extent : extent,
																			size_of_land : size_of_land,
																			type_of_interest : type_of_interest,
																			nature_of_instrument : nature_of_instrument,
																			file_number : file_number,
																			type_of_use : type_of_use,
																			modified_by : modified_by,
																			modified_by_id : modified_by_id
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
																			var result = JSON
																					.parse(jobdetails);

																			if (result.data == 'Success') {
																				var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'
																						+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																						+ '<strong>Success!</strong> Case details saved successfully</div>';

																				console
																						.log(jobdetails)

																				$(
																						"#alert-display-space")
																						.append(
																								alert_mess);
																				// Do
																				// Add
																				// to
																				// Batclist
																				// console.log('Add
																				// to
																				// batchlist');

																				var job_number = $(
																						"#cs_main_job_number_sm")
																						.val();
																				// var
																				// send_by_id
																				// =
																				// $("#modified_by_id").val();
																				// var
																				// send_by
																				// =$("#modified_by").val();
																				var ar_name = $(
																						"#cs_main_client_name_sm")
																						.val();
																				var business_process_sub_name = $(
																						"#cs_main_business_process_sub_name_sm")
																						.val();

																			} else {
																				var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">'
																						+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																						+ '<strong>Failure!</strong> Something went wrong, Please try again</div>';

																			}
																		}

																	});
														})

										$('#btn_newCertificateModal')
												.on(
														'click',
														function(e) {

															var case_number = $(
																	"#cs_main_case_number")
																	.val();

															$(
																	"#newCertificateModal")
																	.modal(
																			{
																				backdrop : 'static',
																				keyboard : false
																			});
															$(
																	'#newCertificateModal #cs_case_number')
																	.val(
																			case_number);
														});

										$('#btn_newValuationModal')
												.on(
														'click',
														function(e) {
															var case_number = $(
																	"#cs_main_case_number")
																	.val();

															$(
																	"#newValuationModal")
																	.modal(
																			{
																				backdrop : 'static',
																				keyboard : false
																			});

															$(
																	'#newValuationModal #vs_case_number')
																	.val(
																			case_number);
														});
										$('#btn_newMemorialsModal')
												.on(
														'click',
														function(e) {

															var case_number = $(
																	"#cs_main_case_number")
																	.val();
															$(
																	"#newMemorialsModal")
																	.modal(
																			{
																				backdrop : 'static',
																				keyboard : false
																			});

															$(
																	'#newMemorialsModal #m_case_number')
																	.val(
																			case_number);
														});

										$('#btn_newProprietorshipModal')
												.on(
														'click',
														function(e) {

															var case_number = $(
																	"#cs_main_case_number")
																	.val();

															$(
																	"#newProprietorshipModal")
																	.modal(
																			{
																				backdrop : 'static',
																				keyboard : false
																			});

															$(
																	'#newProprietorshipModal #ps_case_number')
																	.val(
																			case_number);
														});

									});

				
