$(document)
		.ready(
				function() {

					var datatable = $(
							"#tbl_load_back_office_further_entry_table")
							.DataTable({
								stateSave : true,
							});
					$("#btn_load_back_office_further_entry")
							.click(
									function(event) {

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'load_new_application_for_division'
													},
													success : function(
															jobdetails) {

														var json_p = JSON
																.parse(jobdetails);

														// var table =
														// $('#tbl_load_back_office_further_entry_table');
														// table.find("tbody
														// tr")
														// .remove();
														datatable.clear();

														if (json_p.data === null) {
															// createUserModal
															// $("#createUserModal").modal("show");
															// return;

														}

														$(json_p.data)
																.each(
																		function() {

																			// data-toggle="modal"
																			// data-target="#accountDetailsModal"
																			// 

																			datatable.row
																					.add(
																							[
																									'<input type="checkbox" /> </td>',

																									this.job_number,
																									this.ar_name,
																									this.business_process_sub_name,
																									this.current_application_status,

																									'<button title="Create New Job" class="btn btn-success btn-icon-split btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" '
																											+ 'data-job_number="'

																											+ this.job_number
																											+ '" '
																											+ 'data-ar_name="'
																											+ this.ar_name
																											+ '" '

																											+ 'data-business_process_sub_name="'
																											+ this.business_process_sub_name
																											+ '">'
																											+ '<span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span></button>',

																									'<form action="further_entries" method="post">'
																											+ '<input type="hidden" name="transaction_number"  value="'
																											+ this.transaction_number
																											+ '">'
																											+ '<input type="hidden" name="job_number"  value="'
																											+ this.job_number
																											+ '">'
																											+ '<input  name="case_number" type="hidden" value="'
																											+ this.case_number
																											+ '">'
																											+ '<input type="hidden" name="business_process_sub_name" value="'
																											+ this.business_process_sub_name
																											+ '">'

																											+ '<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
																											+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span>'
																											+ '</button>'
																											+ '</form>'

																							/*
																							 * <button
																							 * title="Check
																							 * Further
																							 * Entries"
																							 * class="btn
																							 * btn-danger
																							 * btn-icon-split
																							 * btn-to-be-disabled
																							 * to_hide_on_level_1"
																							 * data-toggle="modal"
																							 * data-target="#elisapplicationdetailsmodal" ' +
																							 * 'data-transaction_number="' +
																							 * this.transaction_number + '" ' +
																							 * 'data-job_number="' +
																							 * this.job_number + '" ' +
																							 * 'data-case_number="' +
																							 * this.case_number + '" ' +
																							 * 'data-business_process_sub_name="' +
																							 * this.business_process_sub_name +
																							 * '">' + '<span
																							 * class="icon
																							 * text-white-50">
																							 * <i
																							 * class="fas
																							 * fa-folder-open"></i></span><span
																							 * class="text">Check
																							 * Details</span></button> '
																							 */

																							])
																					.draw(
																							false);

																		});

														/*
														 * $(json_p.data) .each(
														 * function() { }
														 */

													}

												});

									});

					$('#frmFurtherEntries_only')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();

										// console .log('form submited Clicked
										// new');

										var case_number = $("#fe_case_number")
												.val();
										var transaction_number = $(
												"#fe_transaction_number").val();
										// var annual_rent =
										// $("#fe_annual_rent").val();
										var commencement_date = $(
												"#fe_commencement_date").val();
										var stool_family_name = $(
												"#fe_family_name").val();
										var family_of_grantor = $(
												"#fe_grantor_family").val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var term = $("#fe_term").val();
										var date_of_document = $(
												"#fe_date_of_document").val();
										var consideration_fee = $(
												"#fe_consideration_fee").val();
										var consideration_currency = $(
												"#fe_consideration_currency")
												.val()
										// console.log("cnsider:" +
										// consideration_currency)
										var type_of_use = $("#fe_type_of_use")
												.val();
										// var extent = $("#fe_extent").val();
										var size_of_land = $("#fe_land_size")
												.val();
										var type_of_interest = $(
												"#fe_type_of_interest").val();
										var nature_of_instrument = $(
												"#fe_nature_of_instrument")
												.val();
										var client_name = $("#fe_client_name")
												.val();
										var business_process_sub_name = $(
												"#febusiness_process_sub_name")
												.val();
										var job_number = $("#fe_job_number")
												.val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var annual_rent = $("#fe_annual_rent")
												.val();
										var surveyor_number = $(
												"#fe_surveyor_number").val();
										var regional_number = $(
												"#fe_regional_number").val();
										var land_size = $("#fe_land_size")
												.val();

										// var case_number =
										// $("#fe_case_number").val();

										var district = $("#fe_district").val();

										var locality = $("#fe_locality").val();
										var region = $("#fe_region").val();
										var extent = $("#fe_extent").val();
										var file_number = $("#fe_file_number")
												.val();
										var registry_mapref = $(
												"#fe_registry_mapref").val();

										var modified_by = localStorage
												.getItem("fullname");
										var modified_by_id = localStorage
												.getItem("userid");

												// var lc_bl_wkt_polygon = $('#lc_bl_wkt_polygon').val();

												// if(!lc_bl_wkt_polygon) {
													
												// 	alert('The WKT polygon is empty.')

												// 	return;
												// }

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'further_entries_update_case',
														case_number : case_number,
														annual_rent : annual_rent,
														commencement_date : commencement_date,
														stool_family_name : stool_family_name,
														family_of_grantor : family_of_grantor,
														renewal_term : renewal_term,
														term : term,
														date_of_document : date_of_document,
														consideration_fee : consideration_fee,
														consideration_currency : consideration_currency,
														extent : extent,
														size_of_land : size_of_land,
														type_of_interest : type_of_interest,
														nature_of_instrument : nature_of_instrument,
														type_of_use : type_of_use,
														transaction_number : transaction_number,
														client_name : client_name,
														business_process_sub_name : business_process_sub_name,
														job_number : job_number,
														surveyor_number : surveyor_number,
														regional_number : regional_number,
														land_size : land_size,
														locality : locality,
														district : district,
														region : region,
														file_number : file_number,
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
														console.log(jobdetails)

														var result = JSON
																.parse(jobdetails);

														if (result.data == 'Success') {
															var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Success!</strong> Case details saved successfully</div>';

															$(
																	"#alert-display-space")
																	.append(
																			alert_mess);
															// Do Add to
															// Batclist

															var job_number = $(
																	"#fe_job_number")
																	.val();
															// var send_by_id =
															// $("#modified_by_id").val();
															// var send_by
															// =$("#modified_by").val();
															var ar_name = $(
																	"#fe_client_name")
																	.val();
															var business_process_sub_name = $(
																	"#febusiness_process_sub_name")
																	.val();

															addJobToBatchlist(
																	job_number,
																	ar_name,
																	business_process_sub_name,
																	" ","");

															prepareBatchlistModal();

														} else {
															var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Failure!</strong> Something went wrong, Please try again</div>';

														}
													}

												});
									});



									$('#frmFurtherEntries_only_certificate').on('submit',function(e) {
										// validation code here
										e.preventDefault();

										// console .log('form submited Clicked
										// new');

										var case_number = $("#fe_case_number")
												.val();
										var transaction_number = $(
												"#fe_transaction_number").val();
										// var annual_rent =
										// $("#fe_annual_rent").val();
										var commencement_date = $(
												"#fe_commencement_date").val();
										var stool_family_name = $(
												"#fe_family_name").val();
										var family_of_grantor = $(
												"#fe_grantor_family").val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var term = $("#fe_term").val();
										var date_of_document = $(
												"#fe_date_of_document").val();
										var consideration_fee = $(
												"#fe_consideration_fee").val();
										var consideration_currency = $(
												"#fe_consideration_currency")
												.val()
										// console.log("cnsider:" +
										// consideration_currency)
										var type_of_use = $("#fe_type_of_use")
												.val();
										// var extent = $("#fe_extent").val();
										var size_of_land = $("#fe_land_size")
												.val();
										var type_of_interest = $(
												"#fe_type_of_interest").val();
										var nature_of_instrument = $(
												"#fe_nature_of_instrument")
												.val();
										var client_name = $("#fe_client_name")
												.val();
										var business_process_sub_name = $(
												"#febusiness_process_sub_name")
												.val();
										var job_number = $("#fe_job_number")
												.val();
										var renewal_term = $("#fe_renewal_term")
												.val();
										var annual_rent = $("#fe_annual_rent")
												.val();
										var surveyor_number = $(
												"#fe_surveyor_number").val();
										var regional_number = $(
												"#fe_regional_number").val();
										var land_size = $("#fe_land_size")
												.val();

										// var case_number =
										// $("#fe_case_number").val();

										var district = $("#fe_district").val();

										var locality = $("#fe_locality").val();
										var region = $("#fe_region").val();
										var extent = $("#fe_extent").val();
										var file_number = $("#fe_file_number").val();
										var registry_mapref = $("#fe_registry_mapref").val();
										var date_of_registration = $("#fe_date_of_registration").val();
										

										var date_of_issue = $("#fe_date_of_issue").val();
										
										var registered_number = $("#fe_registered_number").val();

										var modified_by = localStorage
												.getItem("fullname");
										var modified_by_id = localStorage
												.getItem("userid");

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'further_entries_update_case_certificate',
														case_number : case_number,
														annual_rent : annual_rent,
														commencement_date : commencement_date,
														stool_family_name : stool_family_name,
														family_of_grantor : family_of_grantor,
														renewal_term : renewal_term,
														term : term,
														date_of_document : date_of_document,
														consideration_fee : consideration_fee,
														consideration_currency : consideration_currency,
														extent : extent,
														size_of_land : size_of_land,
														type_of_interest : type_of_interest,
														nature_of_instrument : nature_of_instrument,
														type_of_use : type_of_use,
														transaction_number : transaction_number,
														client_name : client_name,
														business_process_sub_name : business_process_sub_name,
														job_number : job_number,
														surveyor_number : surveyor_number,
														regional_number : regional_number,
														land_size : land_size,
														locality : locality,
														district : district,
														region : region,
														file_number : file_number,
														date_of_issue : date_of_issue,
														registered_number : registered_number,
														registry_mapref : registry_mapref,
														modified_by : modified_by,
														modified_by_id : modified_by_id,
														date_of_registration: date_of_registration
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

														var result = JSON
																.parse(jobdetails);

														if (result.data == 'Success') {
															var alert_mess = '<div class="alert alert-success fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Success!</strong> Case details saved successfully</div>';

															$(
																	"#alert-display-space")
																	.append(
																			alert_mess);
															// Do Add to
															// Batclist

															var job_number = $(
																	"#fe_job_number")
																	.val();
															// var send_by_id =
															// $("#modified_by_id").val();
															// var send_by
															// =$("#modified_by").val();
															var ar_name = $(
																	"#fe_client_name")
																	.val();
															var business_process_sub_name = $(
																	"#febusiness_process_sub_name")
																	.val();

															addJobToBatchlist(
																	job_number,
																	ar_name,
																	business_process_sub_name,
																	" ","");

															prepareBatchlistModal();

														} else {
															var alert_mess = '<div class="alert alert-danger fade show" id="bsalert">'
																	+ '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
																	+ '<strong>Failure!</strong> Something went wrong, Please try again</div>';

														}
													}

												});
									});

					$('#btnJobNumberSearch')
							.on(
									'click',
									function(e) {

										// validation code here
										e.preventDefault();

										var job_number = $("#search_job_number")
												.val();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'load_application_details_by_job_number',
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

														var result = JSON
																.parse(jobdetails);

														// console.log(result)

														$(
																"job_number_placeholder")
																.append(
																		result.job_detail.job_number);

														$("#fe_client_name")
																.val(
																		result.transaction_details.ar_name);
														$(
																"#febusiness_process_sub_name")
																.val(
																		result.job_detail.business_process_sub_name);

														$("#fe_job_number")
																.val(
																		result.job_detail.job_number);

														$(
																"#fe_nature_of_instrument")
																.val(
																		result.transaction_details.nature_of_instrument);
														$(
																"#fe_type_of_interest")
																.val(
																		result.transaction_details.type_of_interest);
														$("#fe_type_of_use")
																.val(
																		result.transaction_details.type_of_use);
														$(
																"#fe_consideration_fee")
																.val(
																		result.transaction_details.consideration_fee);
														$(
																"#fe_date_of_document")
																.val(
																		result.transaction_details.date_of_document);
														$(
																"#fe_commencement_date")
																.val(
																		result.transaction_details.commencement_date);

														$("#fe_file_number")
																.val(
																		result.transaction_details.case_file_number);

														$(
																"#fe_transaction_number")
																.val(
																		result.transaction_details.transaction_number);

														$("#fe_term")
																.val(
																		result.transaction_details.term);
														$("#fe_renewal_term")
																.val(
																		result.transaction_details.renewal_term);
														$("#fe_family_name")
																.val(
																		result.transaction_details.stool_family_name);
														$("#fe_grantor_family")
																.val(
																		result.transaction_details.family_of_grantor);

														$("#fe_annual_rent")
																.val(
																		result.transaction_details.annual_rent);

														$("#fe_surveyor_number")
																.val(
																		result.parcel_details.licensed_no);
														$("#fe_regional_number")
																.val(
																		result.parcel_details.regional_number);
														$("#fe_land_size")
																.val(
																		result.parcel_details.land_size);
														$("#fe_case_number")
																.val(
																		result.parcel_details.case_number);
														$("#fe_locality")
																.val(
																		result.parcel_details.locality);
														$("#fe_district")
																.val(
																		result.parcel_details.district);
														$("#fe_region")
																.val(
																		result.parcel_details.region);
														$("#fe_extent")
																.val(
																		result.parcel_details.extent);

														$("#main_service_id_fe")
																.val(
																		result.job_detail.business_process_id);
														$(
																"#main_service_sub_id_fe")
																.val(
																		result.job_detail.business_process_sub_id);

														var fe_case_number_new = result.transaction_details.transaction_number;

														$("#fe_registry_mapref")
																.val(
																		result.parcel_details.registry_mapref);

														// console.log("case is
														// "+
														// fe_case_number_new);

														$
																.ajax({
																	type : "POST",
																	url : "Case_Management_Serv",
																	data : {
																		request_type : 'select_get_parties_by_case',
																		case_number : fe_case_number_new
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

																		var table = $('#party_details_datatable');
																		table
																				.find(
																						"tbody tr")
																				.remove();

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
																							// <td>"
																							// +
																							// this.ar_client_id
																							// +
																							// "</td>

																							table
																									.append("<tr><td>"
																											+ this.ar_name
																											+ "</td><td>"
																											+ this.ar_gender
																											+ "</td><td>"
																											+ this.ar_cell_phone
																											+ "</td><td>"
																											+ this.type_of_party
																											+ "</td>"

																											+ '<td><p data-placement="top"  title="Edit Party"> '
																											+ '<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"'
																											+ 'data-target="#addeditpartyGeneral"'
																											+ ' data-target-id="'
																											+ this.ar_client_id
																											+ '"  data-ar_name="'
																											+ this.ar_name
																											+ '"  data-ar_gender="'
																											+ this.ar_gender
																											+ '"  data-ar_address="'
																											+ this.ar_address
																											+ '"  data-ar_cell_phone="'
																											+ this.ar_cell_phone
																											+ '" data-ar_cell_phone2="'
																											+ this.ar_cell_phone2
																											+ '" data-ar_tin_no="'
																											+ this.ar_tin_no
																											+ '" data-ar_id_type="'
																											+ this.ar_id_type
																											+ '" data-ar_id_number="'
																											+ this.ar_id_number
																											+ '" data-ar_location="'
																											+ this.ar_location
																											+ '" data-ar_district="'
																											+ this.ar_district
																											+ '" data-type_of_party="'
																											+ this.type_of_party
																											+ '" data-ar_region="'
																											+ this.ar_region
																											+ '" data-ar_person_type="'
																											+ this.ar_person_type
																											+ '"> '
																											+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'

																											+ "</tr>");

																						});

																		// $('#form_inspection').modal('hide');

																		// $("#general_message_dialog").modal();
																		// $('#general_message_dialog
																		// #general_message_dialog_msg').val(jobdetails);
																		// $('#general_message_dialog
																		// #general_message_dialog_msg_new').val('Party
																		// has
																		// been
																		// saved
																		// Successfully');

																	}
																});

													}
												});
									});

					/*
					 * $('#btnsavenewpartyGeneral') .on( 'click', function(e) {
					 * 
					 * console.log('enter data for parties'); var ar_client_id =
					 * $("#party_id_gen") .val(); var ar_name =
					 * $("#party_ar_name_gen") .val(); var ar_gender = $(
					 * "#party_ar_gender_gen") .children("option:selected")
					 * .val(); var ar_cell_phone = $(
					 * "#party_ar_cell_phone_gen") .val(); var ar_cell_phone2 = $(
					 * "#party_ar_cell_phone2_gen") .val(); var ar_nationality = $(
					 * "#party_ar_nationality_gen") .children("option:selected")
					 * .val(); var ar_address = $(
					 * "#party_ar_address_gen").val(); var ar_tin_no = $(
					 * "#party_ar_tin_no_gen").val(); var ar_id_type = $(
					 * "#party_ar_id_type_gen") .children("option:selected")
					 * .val(); var ar_id_number = $( "#party_ar_id_number_gen")
					 * .val(); var ar_type_of_party = $(
					 * "#party_ar_type_of_party_gen")
					 * .children("option:selected") .val(); var ar_location = $(
					 * "#party_ar_location_gen").val(); var ar_district = $(
					 * "#party_ar_district_gen") .children("option:selected")
					 * .val(); var ar_region = $( "#party_ar_region_gen_gen")
					 * .children("option:selected") .val(); var ar_person_type = $(
					 * "#party_ar_person_type_gen") .children("option:selected")
					 * .val(); // set the grantor family and stool // anmes
					 * $('#fe_family_name').val( $('#family_name_gen').val());
					 * $('#fe_grantor_family').val(
					 * $('#grantor_family_gen').val());
					 * 
					 * var created_by = localStorage .getItem('fullname'); var
					 * created_by_id = localStorage .getItem('userid');
					 * 
					 * var case_number = $( "#fe_transaction_number").val();
					 * 
					 * if (ar_client_id == "") { var request_type =
					 * 'select_address_register_add_new_general'; } else { var
					 * request_type = 'select_address_register_edit_general' }
					 * console.log("name is " + ar_name) $ .ajax({ type :
					 * "POST", url : "Case_Management_Serv", data : {
					 * request_type : request_type, ar_client_id : ar_client_id,
					 * case_number : case_number, type_of_party :
					 * ar_type_of_party, ar_name : ar_name, ar_gender :
					 * ar_gender, ar_cell_phone : ar_cell_phone, ar_cell_phone2 :
					 * ar_cell_phone2, ar_nationality : ar_nationality,
					 * ar_address : ar_address, ar_tin_no : ar_tin_no,
					 * ar_id_type : ar_id_type, ar_id_number : ar_id_number,
					 * ar_location : ar_location, ar_district : ar_district,
					 * ar_region : ar_region, ar_person_type : ar_person_type,
					 * created_by : created_by, created_by_id : created_by_id },
					 * cache : false, beforeSend : function() { //
					 * $('#district').html('<img // src="img/loading.gif" //
					 * alt="" width="24" // height="24">'); }, success :
					 * function( jobdetails) {
					 * 
					 * var table = $('#party_details_datatable');
					 * table.find("tbody tr") .remove();
					 * 
					 * console.log(jobdetails); var json_p = JSON
					 * .parse(jobdetails);
					 * 
					 * if (this.data == 'Success') { } else {
					 * 
					 * $(json_p) .each( function() { // result.append('<div //
					 * class="form-group"> // <label><input // type="radio" //
					 * name="bl_milestone" // value="' // + // this.ms_id // + '" // /> ' // + //
					 * this.milestone_description // + // '</label> //
					 * </div>');
					 * 
					 * table .append("<tr><td>" + this.ar_name + "</td><td>" +
					 * this.ar_gender + "</td><td>" + this.ar_cell_phone + "</td><td>" +
					 * this.type_of_party + "</td>" + '<td><p data-placement="top" data-toggle="tooltip"  title="Edit Party"> ' + '<button
					 * class="btn btn-secondary btn-icon-split"
					 * data-title="Delete" data-toggle="modal"' +
					 * 'data-target="#addeditpartyGeneral"' + '
					 * data-target-id="' + this.ar_client_id + '"
					 * data-ar_name="' + this.ar_name + '" data-ar_gender="' +
					 * this.ar_gender + '" data-ar_address="' + this.ar_address + '"
					 * data-ar_cell_phone="' + this.ar_cell_phone + '"
					 * data-ar_cell_phone2="' + this.ar_cell_phone2 + '"
					 * data-ar_tin_no="' + this.ar_tin_no + '"
					 * data-ar_id_type="' + this.ar_id_type + '"
					 * data-ar_id_number="' + this.ar_id_number + '"
					 * data-ar_location="' + this.ar_location + '"
					 * data-ar_district="' + this.ar_district + '"
					 * data-ar_region="' + this.ar_region + '"
					 * data-type_of_party="' + this.type_of_party + '"
					 * data-ar_person_type="' + this.ar_person_type + '"> ' + '<span
					 * class="icon text-white-50"> <i class="fas fa-pen"></i></span>
					 * <span class="text">Edit</span> </button></p></td>' + "</tr>");
					 * 
					 * }); } } }); // $("#addeditparty").modal();
					 * $('#addeditpartyGeneral').modal( 'toggle') //
					 * $('#form_inspection').modal('hide');
					 * $("#general_message_dialog").modal(); //
					 * $('#general_message_dialog //
					 * #general_message_dialog_msg').val(jobdetails); $(
					 * '#general_message_dialog
					 * #general_message_dialog_msg_new') .val( 'Party
					 * Added/Edited Successfully');
					 * 
					 * });
					 */

					$('#party_ar_type_of_party_gen').change(
							function() {
								var ar_person_type = $(
										"#party_ar_type_of_party_gen")
										.children("option:selected").val();
								if (ar_person_type == 'Grantor') {
									$('#grantor-family-div').show();
								} else {
									$('#grantor-family-div').hide();
								}
							});

					$('#fe_consideration_currency').change(
							function(e) {
								// console.log('Changed');
								$('#inputGroupPrependConsideration').text(
										$(this).val());

							});

					// ------ end of $(doc).ready
				});