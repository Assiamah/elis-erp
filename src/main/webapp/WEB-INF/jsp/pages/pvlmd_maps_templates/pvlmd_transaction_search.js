$(document)
		.ready(
				function() {

					$('#pvlmd_btn_search_by_transaction_reference_number')
							.on(
									'click',
									function(e) {

										var reference_number = $(
												'#pvlmd_search_by_text').val();

										var table = $('#pvlmd_transaction_detailsdataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'pvlmd_transaction_select_by_reference_number',
														reference_number : reference_number,
														gid_fk : 0
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
															serviceresponse) {

														var json_p = JSON
																.parse(serviceresponse);
														console.log(json_p)

														$(json_p.data)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.doc_number
																							+ "</td><td>"
																							+ this.instrument_type
																							+ "</td><td>"
																							+ this.instrument_date
																							+ "</td><td>"
																							+ this.consent_date
																							+ "</td><td>"
																							+ this.party1_plaintiff
																							+ "</td><td>"
																							+ this.party2_defendant
																							+ "</td><td>"
																							+ this.reference_number
																							+ "</td><td>"
																							+ this.remarks
																							+ "</td>"

																							+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addpvlmdtransactionlong_t" data-target-id="'
																							+ this.t_id
																							+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																							+ "</tr>");
																		});

													}
												});

									});


	$('#pvlmd_btn_search_by_transaction_reference_number_edit')
							.on(
									'click',
									function(e) {

										var reference_number = $(
												'#pvlmd_search_by_text').val();

										var table = $('#pvlmd_transaction_detailsdataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'pvlmd_transaction_select_by_reference_number',
														reference_number : reference_number,
														gid_fk : 0
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
															serviceresponse) {

														var json_p = JSON
																.parse(serviceresponse);
														console.log(json_p)

														$(json_p.data)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.doc_number
																							+ "</td><td>"
																							+ this.instrument_type
																							+ "</td><td>"
																							+ this.instrument_date
																							+ "</td><td>"
																							+ this.consent_date
																							+ "</td><td>"
																							+ this.party1_plaintiff
																							+ "</td><td>"
																							+ this.party2_defendant
																							+ "</td><td>"
																							+ this.reference_number
																							+ "</td><td>"
																							+ this.remarks
																							+ "</td>"

																							+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addpvlmdtransactionlong_e" data-target-id="'
																							+ this.t_id
																							+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																							+ "</tr>");
																		});

													}
												});

									});

					$('#pvlmd_btn_search_by_transaction_reference_number_add')
							.on(
									'click',
									function(e) {

										var reference_number = $(
												'#pvlmd_search_by_text').val();

										var table = $('#pvlmd_transaction_detailsdataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'pvlmd_transaction_select_by_reference_number',
														reference_number : reference_number,
														gid_fk : 0
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
															serviceresponse) {

														var json_p = JSON
																.parse(serviceresponse);
														console.log(json_p)

														$(json_p.data)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.doc_number
																							+ "</td><td>"
																							+ this.instrument_type
																							+ "</td><td>"
																							+ this.instrument_date
																							+ "</td><td>"
																							+ this.consent_date
																							+ "</td><td>"
																							+ this.party1_plaintiff
																							+ "</td><td>"
																							+ this.party2_defendant
																							+ "</td><td>"
																							+ this.reference_number
																							+ "</td><td>"
																							+ this.remarks
																							+ "</td>"
																							/*
																							 * + '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button
																							 * class="btn
																							 * btn-info
																							 * btn-icon-split"
																							 * data-dismiss="modal"
																							 * data-toggle="modal"
																							 * href="#addpvlmdtransactionlong"
																							 * data-target-id="' +
																							 * this.t_id +
																							 * '"><span
																							 * class="icon
																							 * text-white-50">
																							 * <i
																							 * class="fas
																							 * fa-info-circle"></i></span><span
																							 * class="text">Details</span></button></p></td>'
																							 */
																							+ "</tr>");
																		});

													}
												});

									});

					$("#addpvlmdtransactionlong")
							.on(
									"show.bs.modal",
									function(e) {
										var t_id = $(e.relatedTarget).data(
												'target-id');

										console.log('t_id');
										console.log(t_id);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_gid')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_t_id')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_reference_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_file_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_property_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_nt_number')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_mutation_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_deed_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_serial_number')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_sheet_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_plan_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_plot_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_lvb_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_doc_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_tel_no')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plantiff_add')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_email')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_tel_no')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_email')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_add')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_instrument_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_instrument_type')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_term')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_commencement_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_purpose')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_consent_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_consideration')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_consideration_currency')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_premium')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_premium_currency')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_compensation_status')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_suit_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_floor_level')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_apartment_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_rent')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_submission_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_unit_description')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_judgement_in_favour_of')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_remarks')
												.val([]);

										var today = new Date();
										var dd = String(today.getDate())
												.padStart(2, '0');
										var mm = String(today.getMonth() + 1)
												.padStart(2, '0'); // January
										// is 0!
										var yyyy = today.getFullYear();

										today = mm + '/' + dd + '/' + yyyy;

										if (t_id) {
											console
													.log('addpvlmdtransactionlong loading '
															+ 'valid ')

											/*
											 * $( '#addlrdtransaction
											 * #lrd_td_fid_id_fk')
											 * .val($('#lrd_ps_fid').val());
											 * $('#addlrdtransaction
											 * #lrd_td_gid') .val(gid); $(
											 * '#addlrdtransaction
											 * #lrd_td_plotted_by_reg') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_checked_by') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_plott_date_reg')
											 * .val(today); //
											 * $('#addlrdtransaction //
											 * #lrd_td_job_numnber').val(job_number); $(
											 * '#addlrdtransaction
											 * #lrd_td_reference_number') .val( $(
											 * '#lrd_ps_reference_number')
											 * .val());
											 */
											$
													.ajax({
														type : "POST",
														url : 'Maps',
														data : {
															request_type : 'select_pvlmd_transactions_details_by_t_id',
															t_id : t_id
														},
														cache : false,
														beforeSend : function() {
															// $('#district').html('<img
															// src="img/loading.gif"
															// alt="" width="24"
															// height="24">');
														},
														success : function(
																serviceresponse) {

															var json_p = JSON
																	.parse(serviceresponse);
															console.log(json_p)

															$(json_p.data)
																	.each(
																			function() {

																				$(
																						"#pvlmd_tr_gid")
																						.val(
																								$(
																										"#pvlmd_gid")
																										.val());

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_t_id')
																						.val(
																								this.t_id);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_reference_number')
																						.val(
																								this.reference_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_file_number')
																						.val(
																								this.file_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_property_number')
																						.val(
																								this.property_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_nt_number')
																						.val(
																								this.nt_number);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_mutation_number')
																						.val(
																								this.mutation_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_deed_number')
																						.val(
																								this.deed_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_serial_number')
																						.val(
																								this.serial_number);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_sheet_number')
																						.val(
																								this.sheet_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_plan_number')
																						.val(
																								this.plan_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_plot_number')
																						.val(
																								this.plot_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_lvb_number')
																						.val(
																								this.lvb_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_doc_number')
																						.val(
																								this.doc_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff')
																						.val(
																								this.party1_plaintiff);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_tel_no')
																						.val(
																								this.party1_plaintiff_tel_no);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plantiff_add')
																						.val(
																								this.party1_plantiff_add);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_email')
																						.val(
																								this.party1_plaintiff_email);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant')
																						.val(
																								this.party2_defendant);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_tel_no')
																						.val(
																								this.party2_defendant_tel_no);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_email')
																						.val(
																								this.party2_defendant_email);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_add')
																						.val(
																								this.party2_defendant_add);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_instrument_date')
																						.val(
																								this.instrument_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_instrument_type')
																						.val(
																								this.instrument_type);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_term')
																						.val(
																								this.term);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_commencement_date')
																						.val(
																								this.commencement_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_purpose')
																						.val(
																								this.purpose);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_consent_date')
																						.val(
																								this.consent_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_consideration')
																						.val(
																								this.consideration);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_consideration_currency')
																						.val(
																								this.consideration_currency);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_premium')
																						.val(
																								this.premium);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_premium_currency')
																						.val(
																								this.premium_currency);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_compensation_status')
																						.val(
																								this.compensation_status);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_suit_number')
																						.val(
																								this.suit_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_floor_level')
																						.val(
																								this.floor_level);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_apartment_number')
																						.val(
																								this.apartment_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_rent')
																						.val(
																								this.rent);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_submission_date')
																						.val(
																								this.submission_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_unit_description')
																						.val(
																								this.unit_description);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_judgement_in_favour_of')
																						.val(
																								this.judgement_in_favour_of);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_remarks')
																						.val(
																								this.remarks);

																			});

														}
													});

										} else {

											$("#pvlmd_tr_t_id").val('0');
											$("#pvlmd_tr_gid").val(
													$("#pvlmd_gid").val());

											$("#pvlmd_tr_reference_number")
													.val(
															$(
																	"#pvlmd_reference_number")
																	.val());
											$("#pvlmd_tr_nt_number")
													.val(
															$(
																	"#pvlmd_nt_number")
																	.val());
											$("#pvlmd_tr_file_number").val(
													$("#pvlmd_file_number")
															.val());
											$("#pvlmd_tr_cro_reference").val(
													$("#pvlmd_cro_reference")
															.val());

											$("#pvlmd_tr_property_number").val(
													$("#pvlmd_property_number")
															.val());

										}

									});

					$("#addpvlmdtransactionlong_t")
							.on(
									"show.bs.modal",
									function(e) {
										var t_id = $(e.relatedTarget).data(
												'target-id');

										console.log('t_id');
										console.log(t_id);

										// showSuggestions(job_number);

										/*
										 * $.get( "/controller/" + id, function(
										 * data ) {
										 * $(".modal-body").html(data.html); });
										 */
										// $('#edit
										// #job_numnber').val(job_number);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_gid_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_t_id_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_reference_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_file_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_property_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_nt_number_t')
												.val([]);

										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_mutation_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_deed_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_serial_number_t')
												.val([]);

										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_sheet_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_plan_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_plot_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_lvb_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_doc_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plaintiff_t')
												.val([]);

										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plaintiff_tel_no_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plantiff_add_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plaintiff_email_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_t')
												.val([]);

										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_tel_no_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_email_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_add_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_instrument_date_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_instrument_type_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_term_t')
												.val([]);

										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_commencement_date_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_purpose_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_consent_date_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_consideration_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_consideration_currency_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_premium_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_premium_currency_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_compensation_status_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_suit_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_floor_level_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_apartment_number_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_rent_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_submission_date_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_unit_description_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_judgement_in_favour_of_t')
												.val([]);
										$(
												'#addpvlmdtransactionlong_t #pvlmd_tr_remarks_t')
												.val([]);

										var today = new Date();
										var dd = String(today.getDate())
												.padStart(2, '0');
										var mm = String(today.getMonth() + 1)
												.padStart(2, '0'); // January
										// is 0!
										var yyyy = today.getFullYear();

										today = mm + '/' + dd + '/' + yyyy;

										if (t_id) {
											console
													.log('addpvlmdtransactionlong loading '
															+ 'valid ')

											/*
											 * $( '#addlrdtransaction
											 * #lrd_td_fid_id_fk')
											 * .val($('#lrd_ps_fid').val());
											 * $('#addlrdtransaction
											 * #lrd_td_gid') .val(gid); $(
											 * '#addlrdtransaction
											 * #lrd_td_plotted_by_reg') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_checked_by') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_plott_date_reg')
											 * .val(today); //
											 * $('#addlrdtransaction //
											 * #lrd_td_job_numnber').val(job_number); $(
											 * '#addlrdtransaction
											 * #lrd_td_reference_number') .val( $(
											 * '#lrd_ps_reference_number')
											 * .val());
											 */
											$
													.ajax({
														type : "POST",
														url : 'Maps',
														data : {
															request_type : 'select_pvlmd_transactions_details_by_t_id',
															t_id : t_id
														},
														cache : false,
														beforeSend : function() {
															// $('#district').html('<img
															// src="img/loading.gif"
															// alt="" width="24"
															// height="24">');
														},
														success : function(
																serviceresponse) {

															var json_p = JSON
																	.parse(serviceresponse);
															console.log(json_p)

															$(json_p.data)
																	.each(
																			function() {

																				$(
																						"#pvlmd_tr_gid_t")
																						.val(
																								'0');

																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_t_id_t')
																						.val(
																								this.t_id);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_reference_number_t')
																						.val(
																								this.reference_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_file_number_t')
																						.val(
																								this.file_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_property_number_t')
																						.val(
																								this.property_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_nt_number_t')
																						.val(
																								this.nt_number);

																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_mutation_number_t')
																						.val(
																								this.mutation_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_deed_number_t')
																						.val(
																								this.deed_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_serial_number_t')
																						.val(
																								this.serial_number);

																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_sheet_number_t')
																						.val(
																								this.sheet_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_plan_number_t')
																						.val(
																								this.plan_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_plot_number_t')
																						.val(
																								this.plot_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_lvb_number_t')
																						.val(
																								this.lvb_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_doc_number_t')
																						.val(
																								this.doc_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plaintiff_t')
																						.val(
																								this.party1_plaintiff);

																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plaintiff_tel_no_t')
																						.val(
																								this.party1_plaintiff_tel_no);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plantiff_add_t')
																						.val(
																								this.party1_plantiff_add);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party1_plaintiff_email_t')
																						.val(
																								this.party1_plaintiff_email);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_t')
																						.val(
																								this.party2_defendant);

																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_tel_no_t')
																						.val(
																								this.party2_defendant_tel_no);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_email_t')
																						.val(
																								this.party2_defendant_email);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_party2_defendant_add_t')
																						.val(
																								this.party2_defendant_add);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_instrument_date_t')
																						.val(
																								this.instrument_date);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_instrument_type_t')
																						.val(
																								this.instrument_type);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_term_t')
																						.val(
																								this.term);

																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_commencement_date_t')
																						.val(
																								this.commencement_date);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_purpose_t')
																						.val(
																								this.purpose);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_consent_date_t')
																						.val(
																								this.consent_date);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_consideration_t')
																						.val(
																								this.consideration);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_consideration_currency_t')
																						.val(
																								this.consideration_currency);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_premium_t')
																						.val(
																								this.premium);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_premium_currency_t')
																						.val(
																								this.premium_currency);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_compensation_status_t')
																						.val(
																								this.compensation_status);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_suit_number_t')
																						.val(
																								this.suit_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_floor_level_t')
																						.val(
																								this.floor_level);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_apartment_number_t')
																						.val(
																								this.apartment_number);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_rent_t')
																						.val(
																								this.rent);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_submission_date_t')
																						.val(
																								this.submission_date);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_unit_description_t')
																						.val(
																								this.unit_description);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_judgement_in_favour_of_t')
																						.val(
																								this.judgement_in_favour_of);
																				$(
																						'#addpvlmdtransactionlong_t #pvlmd_tr_remarks_t')
																						.val(
																								this.remarks);

																			});

														}
													});

										} else {

											$("#pvlmd_tr_t_id_t").val('0');
											$("#pvlmd_tr_gid_t").val(
													$("#pvlmd_gid_t").val());

											$("#pvlmd_tr_reference_number_t")
													.val(
															$(
																	"#pvlmd_reference_number_t")
																	.val());
											$("#pvlmd_tr_nt_number_t").val(
													$("#pvlmd_nt_number_t")
															.val());
											$("#pvlmd_tr_file_number_t").val(
													$("#pvlmd_file_number_t")
															.val());
											$("#pvlmd_tr_cro_reference_t").val(
													$("#pvlmd_cro_reference_t")
															.val());

											$("#pvlmd_tr_property_number_t")
													.val(
															$(
																	"#pvlmd_property_number_t")
																	.val());

										}

									});



	$("#addpvlmdtransactionlong_e")
							.on(
									"show.bs.modal",
									function(e) {
										var t_id = $(e.relatedTarget).data(
												'target-id');

										console.log('t_id');
										console.log(t_id);

										// showSuggestions(job_number);

										/*
										 * $.get( "/controller/" + id, function(
										 * data ) {
										 * $(".modal-body").html(data.html); });
										 */
										// $('#edit
										// #job_numnber').val(job_number);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_gid_e')
												.val('0');
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_t_id_e')
												.val('0');
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_reference_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_file_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_property_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_nt_number_e')
												.val([]);

										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_mutation_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_deed_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_serial_number_e')
												.val([]);

										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_sheet_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_plan_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_plot_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_lvb_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_doc_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plaintiff_e')
												.val([]);

										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plaintiff_tel_no_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plantiff_add_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plaintiff_email_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_e')
												.val([]);

										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_tel_no_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_email_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_add_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_instrument_date_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_instrument_type_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_term_e')
												.val([]);

										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_commencement_date_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_purpose_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_consent_date_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_consideration_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_consideration_currency_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_premium_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_premium_currency_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_compensation_status_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_suit_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_floor_level_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_apartment_number_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_rent_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_submission_date_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_unit_description_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_judgement_in_favour_of_e')
												.val([]);
										$(
												'#addpvlmdtransactionlong_e #pvlmd_tr_remarks_e')
												.val([]);

										var today = new Date();
										var dd = String(today.getDate())
												.padStart(2, '0');
										var mm = String(today.getMonth() + 1)
												.padStart(2, '0'); // January
										// is 0!
										var yyyy = today.getFullYear();

										today = mm + '/' + dd + '/' + yyyy;

										if (t_id) {
											console
													.log('addpvlmdtransactionlong loading '
															+ 'valid ')

											/*
											 * $( '#addlrdtransaction
											 * #lrd_td_fid_id_fk')
											 * .val($('#lrd_ps_fid').val());
											 * $('#addlrdtransaction
											 * #lrd_td_gid') .val(gid); $(
											 * '#addlrdtransaction
											 * #lrd_td_plotted_by_reg') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_checked_by') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_plott_date_reg')
											 * .val(today); //
											 * $('#addlrdtransaction //
											 * #lrd_td_job_numnber').val(job_number); $(
											 * '#addlrdtransaction
											 * #lrd_td_reference_number') .val( $(
											 * '#lrd_ps_reference_number')
											 * .val());
											 */
											$
													.ajax({
														type : "POST",
														url : 'Maps',
														data : {
															request_type : 'select_pvlmd_transactions_details_by_t_id',
															t_id : t_id
														},
														cache : false,
														beforeSend : function() {
															// $('#district').html('<img
															// src="img/loading.gif"
															// alt="" width="24"
															// height="24">');
														},
														success : function(
																serviceresponse) {

															var json_p = JSON
																	.parse(serviceresponse);
															console.log(json_p)

															$(json_p.data)
																	.each(
																			function() {

																				$(
																						"#pvlmd_tr_t_id_e")
																						.val(
																								'0');

																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_t_id_e')
																						.val(
																								this.t_id);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_reference_number_e')
																						.val(
																								this.reference_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_file_number_e')
																						.val(
																								this.file_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_property_number_e')
																						.val(
																								this.property_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_nt_number_e')
																						.val(
																								this.nt_number);

																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_mutation_number_e')
																						.val(
																								this.mutation_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_deed_number_e')
																						.val(
																								this.deed_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_serial_number_e')
																						.val(
																								this.serial_number);

																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_sheet_number_e')
																						.val(
																								this.sheet_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_plan_number_e')
																						.val(
																								this.plan_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_plot_number_e')
																						.val(
																								this.plot_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_lvb_number_e')
																						.val(
																								this.lvb_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_doc_number_e')
																						.val(
																								this.doc_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plaintiff_e')
																						.val(
																								this.party1_plaintiff);

																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plaintiff_tel_no_e')
																						.val(
																								this.party1_plaintiff_tel_no);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plantiff_add_e')
																						.val(
																								this.party1_plantiff_add);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party1_plaintiff_email_e')
																						.val(
																								this.party1_plaintiff_email);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_e')
																						.val(
																								this.party2_defendant);

																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_tel_no_e')
																						.val(
																								this.party2_defendant_tel_no);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_email_e')
																						.val(
																								this.party2_defendant_email);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_party2_defendant_add_e')
																						.val(
																								this.party2_defendant_add);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_instrument_date_e')
																						.val(
																								this.instrument_date);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_instrument_type_e')
																						.val(
																								this.instrument_type);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_term_e')
																						.val(
																								this.term);

																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_commencement_date_e')
																						.val(
																								this.commencement_date);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_purpose_e')
																						.val(
																								this.purpose);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_consent_date_e')
																						.val(
																								this.consent_date);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_consideration_e')
																						.val(
																								this.consideration);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_consideration_currency_e')
																						.val(
																								this.consideration_currency);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_premium_e')
																						.val(
																								this.premium);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_premium_currency_e')
																						.val(
																								this.premium_currency);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_compensation_status_e')
																						.val(
																								this.compensation_status);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_suit_number_e')
																						.val(
																								this.suit_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_floor_level_e')
																						.val(
																								this.floor_level);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_apartment_number_e')
																						.val(
																								this.apartment_number);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_rent_e')
																						.val(
																								this.rent);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_submission_date_e')
																						.val(
																								this.submission_date);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_unit_description_e')
																						.val(
																								this.unit_description);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_judgement_in_favour_of_e')
																						.val(
																								this.judgement_in_favour_of);
																				$(
																						'#addpvlmdtransactionlong_e #pvlmd_tr_remarks_e')
																						.val(
																								this.remarks);

																			});

														}
													});

										} else {

											$("#pvlmd_tr_t_id_t").val('0');
											$("#pvlmd_tr_gid_t").val(
													$("#pvlmd_gid_t").val());

											$("#pvlmd_tr_reference_number_t")
													.val(
															$(
																	"#pvlmd_reference_number_t")
																	.val());
											$("#pvlmd_tr_nt_number_t").val(
													$("#pvlmd_nt_number_t")
															.val());
											$("#pvlmd_tr_file_number_t").val(
													$("#pvlmd_file_number_t")
															.val());
											$("#pvlmd_tr_cro_reference_t").val(
													$("#pvlmd_cro_reference_t")
															.val());

											$("#pvlmd_tr_property_number_t")
													.val(
															$(
																	"#pvlmd_property_number_t")
																	.val());

										}

									});
									
									
					$('#pvlmd_tr_btn_save_transaction_long_t')
							.on(
									'click',
									function(e) {

										var pvlmd_gid = document
												.getElementById("pvlmd_gid_t").value;

										var pvlmd_tr_t_id = document
												.getElementById("pvlmd_tr_t_id_t").value;

										var reference_number = document
												.getElementById("pvlmd_tr_reference_number_t").value;
										var file_number = document
												.getElementById("pvlmd_tr_file_number_t").value;
										var property_number = document
												.getElementById("pvlmd_tr_property_number_t").value;
										var submission_date = document
												.getElementById("pvlmd_tr_submission_date_t").value;
										var mutation_number = document
												.getElementById("pvlmd_tr_mutation_number_t").value;
										var deed_number = document
												.getElementById("pvlmd_tr_deed_number_t").value;
										var serial_number = document
												.getElementById("pvlmd_tr_serial_number_t").value;
										var sheet_number = document
												.getElementById("pvlmd_tr_sheet_number_t").value;
										var plan_number = document
												.getElementById("pvlmd_tr_plan_number_t").value;
										var plot_number = document
												.getElementById("pvlmd_tr_plot_number_t").value;
										var lvb_number = document
												.getElementById("pvlmd_tr_lvb_number_t").value;
										var instrument_date = document
												.getElementById("pvlmd_tr_instrument_date_t").value;
										var instrument_type = document
												.getElementById("pvlmd_tr_instrument_type_t").value;
										var doc_number = document
												.getElementById("pvlmd_tr_doc_number_t").value;
										var party1_plaintiff = document
												.getElementById("pvlmd_tr_party1_plaintiff_t").value;
										var party1_plaintiff_tel_no = document
												.getElementById("pvlmd_tr_party1_plaintiff_tel_no_t").value;
										var party1_plaintiff_email = document
												.getElementById("pvlmd_tr_party1_plaintiff_email_t").value;
										var party2_defendant = document
												.getElementById("pvlmd_tr_party2_defendant_t").value;
										var party2_defendant_tel_no = document
												.getElementById("pvlmd_tr_party2_defendant_tel_no_t").value;
										var party2_defendant_email = document
												.getElementById("pvlmd_tr_party2_defendant_email_t").value;
										var term = document
												.getElementById("pvlmd_tr_term_t").value;
										var commencement_date = document
												.getElementById("pvlmd_tr_commencement_date_t").value;
										var purpose = document
												.getElementById("pvlmd_tr_purpose_t").value;

										var consideration = document
												.getElementById("pvlmd_tr_consideration_t").value;
										var consideration_currency = document
												.getElementById("pvlmd_tr_consideration_currency_t").value;
										var premium = document
												.getElementById("pvlmd_tr_premium_t").value;
										var premium_currency = document
												.getElementById("pvlmd_tr_premium_currency_t").value;
										var compensation_status = document
												.getElementById("pvlmd_tr_compensation_status_t").value;

										var remarks = document
												.getElementById("pvlmd_tr_remarks_t").value;
										var suit_number = document
												.getElementById("pvlmd_tr_suit_number_t").value;
										var party1_plantiff_add = document
												.getElementById("pvlmd_tr_party1_plantiff_add_t").value;
										var party2_defendant_add = document
												.getElementById("pvlmd_tr_party2_defendant_add_t").value;
										var judgement_in_favour_of = document
												.getElementById("pvlmd_tr_judgement_in_favour_of_t").value;
										var floor_level = document
												.getElementById("pvlmd_tr_floor_level_t").value;
										var apartment_number = document
												.getElementById("pvlmd_tr_apartment_number_t").value;
										var rent = document
												.getElementById("pvlmd_tr_rent_t").value;

										var unit_description = document
												.getElementById("pvlmd_tr_unit_description_t").value;
										var consent_date = document
												.getElementById("pvlmd_tr_consent_date_t").value;
										var plot_number = document
												.getElementById("pvlmd_tr_t_id_t").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'save_pvlmd_transaction',
														reference_number : reference_number,
														file_number : file_number,
														property_number : property_number,
														submission_date : submission_date,
														mutation_number : mutation_number,
														deed_number : deed_number,
														serial_number : serial_number,
														sheet_number : sheet_number,
														plan_number : plan_number,
														plot_number : plot_number,
														lvb_number : lvb_number,
														instrument_date : instrument_date,
														instrument_type : instrument_type,
														doc_number : doc_number,
														party1_plaintiff : party1_plaintiff,
														party1_plaintiff_tel_no : party1_plaintiff_tel_no,
														party1_plaintiff_email : party1_plaintiff_email,
														party2_defendant : party2_defendant,
														party2_defendant_tel_no : party2_defendant_tel_no,
														party2_defendant_email : party2_defendant_email,
														term : term,
														commencement_date : commencement_date,
														purpose : purpose,

														consideration : consideration,
														consideration_currency : consideration_currency,
														premium : premium,
														premium_currency : premium_currency,
														compensation_status : compensation_status,

														remarks : remarks,
														suit_number : suit_number,
														party1_plantiff_add : party1_plantiff_add,
														party2_defendant_add : party2_defendant_add,
														judgement_in_favour_of : judgement_in_favour_of,
														floor_level : floor_level,
														apartment_number : apartment_number,
														rent : rent,
														gid_id_fk : pvlmd_gid,
														unit_description : unit_description,
														consent_date : consent_date,
														t_id : pvlmd_tr_t_id

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
														console.log(jobdetails)
														alert(jobdetails);

														/*
														 * var json_p = JSON
														 * .parse(jobdetails); $(
														 * "#pvlmdparcelinformation")
														 * .modal(); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_gid')
														 * .val(json_p.gid); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});
									
					$('#pvlmd_tr_btn_save_transaction_long_e')
							.on(
									'click',
									function(e) {

										var pvlmd_gid = document
												.getElementById("pvlmd_tr_gid_e").value;

										var pvlmd_tr_t_id = document
												.getElementById("pvlmd_tr_t_id_e").value;

										var reference_number = document
												.getElementById("pvlmd_tr_reference_number_e").value;
										var file_number = document
												.getElementById("pvlmd_tr_file_number_e").value;
										var property_number = document
												.getElementById("pvlmd_tr_property_number_e").value;
										var submission_date = document
												.getElementById("pvlmd_tr_submission_date_e").value;
										var mutation_number = document
												.getElementById("pvlmd_tr_mutation_number_e").value;
										var deed_number = document
												.getElementById("pvlmd_tr_deed_number_e").value;
										var serial_number = document
												.getElementById("pvlmd_tr_serial_number_e").value;
										var sheet_number = document
												.getElementById("pvlmd_tr_sheet_number_e").value;
										var plan_number = document
												.getElementById("pvlmd_tr_plan_number_e").value;
										var plot_number = document
												.getElementById("pvlmd_tr_plot_number_e").value;
										var lvb_number = document
												.getElementById("pvlmd_tr_lvb_number_e").value;
										var instrument_date = document
												.getElementById("pvlmd_tr_instrument_date_e").value;
										var instrument_type = document
												.getElementById("pvlmd_tr_instrument_type_e").value;
										var doc_number = document
												.getElementById("pvlmd_tr_doc_number_e").value;
										var party1_plaintiff = document
												.getElementById("pvlmd_tr_party1_plaintiff_e").value;
										var party1_plaintiff_tel_no = document
												.getElementById("pvlmd_tr_party1_plaintiff_tel_no_e").value;
										var party1_plaintiff_email = document
												.getElementById("pvlmd_tr_party1_plaintiff_email_e").value;
										var party2_defendant = document
												.getElementById("pvlmd_tr_party2_defendant_e").value;
										var party2_defendant_tel_no = document
												.getElementById("pvlmd_tr_party2_defendant_tel_no_e").value;
										var party2_defendant_email = document
												.getElementById("pvlmd_tr_party2_defendant_email_e").value;
										var term = document
												.getElementById("pvlmd_tr_term_e").value;
										var commencement_date = document
												.getElementById("pvlmd_tr_commencement_date_e").value;
										var purpose = document
												.getElementById("pvlmd_tr_purpose_e").value;

										var consideration = document
												.getElementById("pvlmd_tr_consideration_e").value;
										var consideration_currency = document
												.getElementById("pvlmd_tr_consideration_currency_e").value;
										var premium = document
												.getElementById("pvlmd_tr_premium_e").value;
										var premium_currency = document
												.getElementById("pvlmd_tr_premium_currency_e").value;
										var compensation_status = document
												.getElementById("pvlmd_tr_compensation_status_e").value;

										var remarks = document
												.getElementById("pvlmd_tr_remarks_e").value;
										var suit_number = document
												.getElementById("pvlmd_tr_suit_number_e").value;
										var party1_plantiff_add = document
												.getElementById("pvlmd_tr_party1_plantiff_add_e").value;
										var party2_defendant_add = document
												.getElementById("pvlmd_tr_party2_defendant_add_e").value;
										var judgement_in_favour_of = document
												.getElementById("pvlmd_tr_judgement_in_favour_of_e").value;
										var floor_level = document
												.getElementById("pvlmd_tr_floor_level_e").value;
										var apartment_number = document
												.getElementById("pvlmd_tr_apartment_number_e").value;
										var rent = document
												.getElementById("pvlmd_tr_rent_e").value;

										var unit_description = document
												.getElementById("pvlmd_tr_unit_description_e").value;
										var consent_date = document
												.getElementById("pvlmd_tr_consent_date_e").value;
										var plot_number = document
												.getElementById("pvlmd_tr_t_id_e").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'save_pvlmd_transaction',
														reference_number : reference_number,
														file_number : file_number,
														property_number : property_number,
														submission_date : submission_date,
														mutation_number : mutation_number,
														deed_number : deed_number,
														serial_number : serial_number,
														sheet_number : sheet_number,
														plan_number : plan_number,
														plot_number : plot_number,
														lvb_number : lvb_number,
														instrument_date : instrument_date,
														instrument_type : instrument_type,
														doc_number : doc_number,
														party1_plaintiff : party1_plaintiff,
														party1_plaintiff_tel_no : party1_plaintiff_tel_no,
														party1_plaintiff_email : party1_plaintiff_email,
														party2_defendant : party2_defendant,
														party2_defendant_tel_no : party2_defendant_tel_no,
														party2_defendant_email : party2_defendant_email,
														term : term,
														commencement_date : commencement_date,
														purpose : purpose,

														consideration : consideration,
														consideration_currency : consideration_currency,
														premium : premium,
														premium_currency : premium_currency,
														compensation_status : compensation_status,

														remarks : remarks,
														suit_number : suit_number,
														party1_plantiff_add : party1_plantiff_add,
														party2_defendant_add : party2_defendant_add,
														judgement_in_favour_of : judgement_in_favour_of,
														floor_level : floor_level,
														apartment_number : apartment_number,
														rent : rent,
														gid_id_fk : pvlmd_gid,
														unit_description : unit_description,
														consent_date : consent_date,
														t_id : pvlmd_tr_t_id

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
														console.log(jobdetails)
														alert(jobdetails);

														/*
														 * var json_p = JSON
														 * .parse(jobdetails); $(
														 * "#pvlmdparcelinformation")
														 * .modal(); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_gid')
														 * .val(json_p.gid); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});

					$('#btn_open_pvlmd_transaction_short').on(
							'click',
							function(e) {

								$("#pvlmd_gid").val('0');
								$("#pvlmd_tr_st_t_id").val('0');
								$('#pvlmd_tr_st_reference_number').val([]);
								$('#pvlmd_tr_st_reference_number').prop(
										"readonly", false);
								$('#addpvlmdtransactionshort').modal({
									backdrop : 'static',
								});

							});
							
							
							
				       $('#btn_open_pvlmd_transaction_long').on(
							'click',
							function(e) {

								$("#pvlmd_tr_gid_e").val('0');
								$("#pvlmd_tr_t_id_e").val('0');
								$('#pvlmd_tr_reference_number_e').val([]);
								$('#pvlmd_tr_reference_number_e').prop(
										"readonly", false);
								$('#addpvlmdtransactionlong_e').modal({
									backdrop : 'static',
								});

							});
							
							
							
							
							
							
							
							

					$('#btn_save_pvlmd_transaction_short')
							.on(
									'click',
									function(e) {

										//console.log('Assiamah');

										var pvlmd_gid = document
												.getElementById("pvlmd_gid").value;

										var pvlmd_tr_st_t_id = document
												.getElementById("pvlmd_tr_st_t_id").value;

										var reference_number = document
												.getElementById("pvlmd_tr_st_reference_number").value;
										var file_number = document
												.getElementById("pvlmd_tr_st_file_number").value;
										var property_number = document
												.getElementById("pvlmd_tr_st_property_number").value;
										var submission_date = document
												.getElementById("pvlmd_tr_st_submission_date").value;
										var plot_number = document
												.getElementById("pvlmd_tr_st_plot_number").value;
										var doc_number = document
												.getElementById("pvlmd_tr_st_document_number").value;

										var party1_plaintiff = document
												.getElementById("pvlmd_tr_st_party1_plaintiff").value;
										var party1_plaintiff_tel_no = document
												.getElementById("pvlmd_tr_st_party1_plaintiff_tel_no").value;

										var party2_defendant = document
												.getElementById("pvlmd_tr_st_party2_defendant").value;
										var party2_defendant_tel_no = document
												.getElementById("pvlmd_tr_st_party2_defendant_tel_no").value;
										var term = document
												.getElementById("pvlmd_tr_st_term").value;

										var commencement_date = document
												.getElementById("pvlmd_tr_st_commencement_date").value;

										var purpose = document
												.getElementById("pvlmd_tr_st_purpose").value;

										var consent_date = document
												.getElementById("pvlmd_tr_st_consent_date").value;

										var instrument_date = document
												.getElementById("pvlmd_tr_st_instrument_date").value;
										var instrument_type = document
												.getElementById("pvlmd_tr_st_instrument_type").value;

										var remarks = document
												.getElementById("pvlmd_tr_remarks").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'save_pvlmd_transaction_short',
														reference_number : reference_number,
														file_number : file_number,
														property_number : property_number,
														submission_date : submission_date,
														plot_number : plot_number,
														instrument_date : instrument_date,
														instrument_type : instrument_type,
														doc_number : doc_number,
														party1_plaintiff : party1_plaintiff,
														party1_plaintiff_tel_no : party1_plaintiff_tel_no,

														party2_defendant : party2_defendant,
														party2_defendant_tel_no : party2_defendant_tel_no,

														term : term,
														commencement_date : commencement_date,
														purpose : purpose,
														remarks : remarks,
														gid_id_fk : pvlmd_gid,
														consent_date : consent_date,
														t_id : pvlmd_tr_st_t_id

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
														console.log(jobdetails)
														alert(jobdetails);

														/*
														 * var json_p = JSON
														 * .parse(jobdetails); $(
														 * "#pvlmdparcelinformation")
														 * .modal(); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_gid')
														 * .val(json_p.gid); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});

					$('#btn_open_pvlmd_number_generation_form').on(
							'click',
							function(e) {

								$("#pvlmd_id_ngf").val('0');
								$('#pvlmd_reference_number_ngf').val([]);
								$('#pvlmd_applicant_name_ngf').val([]);
								$('#pvlmd_locality_ngf').val([]);
								$('#pvlmd_number_format_ngf').val([]);
								$('#pvlmd_old_ref_number_ngf').prop("readonly",
										false);

								$('#pvlmdnumbergenerationtemplatesaveupdate')
										.modal({
											backdrop : 'static',
										});

							});
					$('#btn_generate_pvlmd_transaction_no_fts')
							.on(
									'click',
									function(e) {

										// console.log('Assiamah');

										var id = $('#pvlmd_id_ngf').val();

										var reference_number = $(
												'#pvlmd_reference_number_ngf')
												.val();

										var applicant_name = $(
												'#pvlmd_applicant_name_ngf')
												.val();

										var locality = $('#pvlmd_locality_ngf')
												.val();
										var number_format = $(
												'#pvlmd_number_format_ngf')
												.val();

										var old_ref_number = $(
												'#pvlmd_old_ref_number_ngf')
												.val();

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'pvlmd_number_generation_add_update',
														id : id,
														reference_number : reference_number,
														applicant_name : applicant_name,
														locality : locality,
														number_format : number_format,
														old_ref_number : old_ref_number
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
														console.log(jobdetails)
														alert(jobdetails);

														var json_p = JSON
																.parse(jobdetails);
														$(
																'#pvlmdnumbergenerationtemplatesaveupdate #pvlmd_old_ref_number_ngf')
																.val(
																		json_p.ref_number);

													}
												});

									});

					$('#pvlmd_tr_btn_delete_transaction_long_e')
							.on(
									'click',
									function(e) {

										var confirmText = "Are you sure you want to delete the selected transaction? Note that this cannot be undone";
										if (confirm(confirmText)) {
											var pvlmd_tr_t_id = $(
													'#pvlmd_tr_t_id_e').val();
											$
													.ajax({
														type : "POST",
														url : "Maps",
														// target : '_blank',
														data : {
															request_type : 'select_delete_pvlmd_transactions_all',
															parcel_id : pvlmd_tr_t_id
														},
														cache : false,
														success : function(
																jobdetails) {
															alert(jobdetails);
														}
													});
										}

									});

					// $('#pvlmd_tr_btn_delete_parcel')
					// 		.on(
					// 				'click',
					// 				function(e) {

					// 					var confirmText = "Are you sure you want to delete the selected plotting? Note that this cannot be undone";
					// 					if (confirm(confirmText)) {
					// 						var pvlmd_gid = $('#pvlmd_gid')
					// 								.val();
					// 						$
					// 								.ajax({
					// 									type : "POST",
					// 									url : "Maps",
					// 									// target : '_blank',
					// 									data : {
					// 										request_type : 'select_delete_pvlmd_parcles',
					// 										parcel_id : pvlmd_gid
					// 									},
					// 									cache : false,
					// 									success : function(
					// 											jobdetails) {
					// 										console
					// 												.log(jobdetails)
					// 										alert(jobdetails);

					// 									}
					// 								});
					// 					}

					// 				});

				});
