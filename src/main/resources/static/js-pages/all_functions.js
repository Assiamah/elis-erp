window.JSON2CSV = function JSON2CSV(objArray) {
	var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
	var str = '';
	var line = '';

	if ($("#labels").is(':checked')) {
		var head = array[0];
		if ($("#quote").is(':checked')) {
			for ( var index in array[0]) {
				var value = index + "";
				line += '"' + value.replace(/"/g, '""') + '",';
			}
		} else {
			for ( var index in array[0]) {
				line += index + ',';
			}
		}

		line = line.slice(0, -1);
		str += line + '\r\n';
	}

	for (var i = 0; i < array.length; i++) {
		var line = '';

		if ($("#quote").is(':checked')) {
			for ( var index in array[i]) {
				var value = array[i][index] + "";
				line += '"' + value.replace(/"/g, '""') + '",';
			}
		} else {
			for ( var index in array[i]) {
				line += array[i][index] + ',';
			}
		}

		line = line.slice(0, -1);
		str += line + '\r\n';
	}
	return str;
}



	  function appendMessage(sender, text) {
									// const chatBox = document.getElementById("chatBox");
									// const messageDiv = document.createElement("div");
									// messageDiv.classList.add("chat-message", sender === 'user' ? 'user-message' : 'agent-message');

									// const bubble = document.createElement("div");
									// bubble.classList.add("message-bubble", sender === 'user' ? 'user-bubble' : 'agent-bubble');
									// bubble.innerText = text;

									// messageDiv.appendChild(bubble);
									// chatBox.appendChild(messageDiv);
									// chatBox.scrollTop = chatBox.scrollHeight;
								}

								function handleKeyPress(event) {
									if (event.key === "Enter") {
									sendMessage();
									}
								}

							

								function showTypingIndicator() {
									document.getElementById("typingIndicator").style.display = "block";
								}

								function hideTypingIndicator() {
									document.getElementById("typingIndicator").style.display = "none";
								}

								function showError(message) {
									const errorDiv = document.getElementById("errorMessage");
									errorDiv.innerText = message;
									errorDiv.style.display = "block";
									setTimeout(() => {
									errorDiv.style.display = "none";
									}, 5000);
								}


function loadEmbeddedPage(url) {
					const container = document.getElementById('embeddedPageContainer');
					if (url) {
					container.innerHTML = '<div class="text-center text-muted"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';
					fetch(url)
						.then(response => {
						if (!response.ok) throw new Error('Network error');
						return response.text();
						})
						.then(html => {
						container.innerHTML = html;
						})
						.catch(() => {
						container.innerHTML = '<div class="text-danger">Failed to load content.</div>';
						});
					} else {
					container.innerHTML = '<em class="text-muted">Select a page from the dropdown to load its content here.</em>';
					}
				}

				function appendJsonTableToChatBox(jsonArray) {
					if (!Array.isArray(jsonArray) || jsonArray.length === 0) {
						appendMessage('agent', 'No data to display.');
						return;
					}

					// Extract headers from keys
					const headers = Object.keys(jsonArray[0]);

					let tableHTML = '<div class="message agent"><div class="bubble"><table class="table table-sm table-bordered">';
					tableHTML += '<thead><tr>';

					headers.forEach(header => {
						tableHTML += `<th>${header.charAt(0).toUpperCase() + header.slice(1)}</th>`;
					});

					tableHTML += '</tr></thead><tbody>';

					jsonArray.forEach(row => {
						tableHTML += '<tr>';
						headers.forEach(header => {
						tableHTML += `<td>${row[header]}</td>`;
						});
						tableHTML += '</tr>';
					});

					tableHTML += '</tbody></table></div></div>';

					$('#chatBox').append(tableHTML);
					$('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
					}
$(document)
		.ready(
				function() {

				
		appendMessage("agent", `Hello, how can we assist with this application)?`);
	
	
			/*function clickEvent(first,last){
			if(first.value.length){
				document.getElementById(last).focus();
			}
		} 
	*/
					
					
					
					$('#lrd_proprietorship_details_dataTable_final_approval').dataTable({
					    //"rowCallback": function( row, data, index ) {
					        //if(data[0] == "1"){
								//$(row).addClass('danger');
					       // }else{
					           //$(row).addClass('warning');
					       // }
					    //  }
					"createdRow" : function(row, data, dataIndex) {
								console.log('new  row');
									console.log(data[0]);
									if (data[0] =="1.0") {
										$(row).addClass('tr-completed-work');
									}
								},
					});
					
					
					 	
					
				         if ($('#txt_certificete_approval_status').val() === "1") {
						   // $("#none").show("fast");
			                $('#lc_btn_approve_certicate_for_signature').removeClass('btn-danger').addClass('btn-success ');
 						 $('#lc_btn_activate_final_deeds_certificate').removeClass('btn-danger').addClass('btn-success ');
						  } else {
						   
						  }
				
				 		if ($('#txt_final_approval_status').val() === "1") {
						   // $("#none").show("fast");
			               $('#lc_btn_generate_activation_code').removeClass('btn-danger').addClass('btn-success ');
  						   $('#lc_btn_activate_final_registration_confirm').removeClass('btn-danger').addClass('btn-success ');

						  } else {
						   
						  }
				
				
					
					
				
					
  
					//$(this).addClass('btn-success').removeClass('btn-primary ');
					
					$(".card-btn").click(
							function(e) {
								e.preventDefault();

								var $this = $(this);

								if ($this.children('i').hasClass(
										'fa-expand-arrows-alt')) {
									$this.children('i').removeClass(
											'fa-expand-arrows-alt');
									$this.children('i').addClass(
											'fa-compress-arrows-alt');
								} else if ($this.children('i').hasClass(
										'fa-compress-arrows-alt')) {
									$this.children('i').removeClass(
											'fa-compress-arrows-alt');
									$this.children('i').addClass(
											'fa-expand-arrows-alt');
								}
								$(this).closest('.card').toggleClass(
										'card-fullscreen');
							});
					/*
					 * =========================================== Actions for
					 * newCertificateModal ==================
					 */
					$('#newCertificateModal').on(
							'show.bs.modal',
							function(event) {
								/*
								 * var button = $(event.relatedTarget) // Button
								 * that triggered the modal var recipient =
								 * button.data('action') // Extract info from
								 * data-* attributes var modal = $(this)
								 * if(recipient=='edit'){
								 * modal.find('.modal-body
								 * #action_on_form_certificate').val(recipient)
								 * modal.find('.modal-title').text(recipient.toUpperCase() +" "+
								 * modal.find('.modal-title').text().toUpperCase() ) }
								 */

								var cs_id = parseInt($(event.relatedTarget)
										.data('cs_id') ? $(event.relatedTarget)
										.data('cs_id') : 0);
								var cs_case_number = $(event.relatedTarget)
										.data('cs_case_number');
								var cs_official_notes = $(event.relatedTarget)
										.data('cs_official_notes');
								var cs_date_of_registration = $(
										event.relatedTarget).data(
										'cs_date_of_registration');
								var cs_to_whom_issued = $(event.relatedTarget)
										.data('cs_to_whom_issued');
								var cs_serial_number = $(event.relatedTarget)
										.data('cs_serial_number');

								// console.log("dsdd: " + cs_id);
								if (cs_id == "" || cs_id == undefined
										|| cs_id == 0) {
									cs_id = '0';
									$(".btn_reg_root_delete_action").hide();
								} else {
									$(".btn_reg_root_delete_action").show();
								}

								// $(".btn_reg_root_delete_action").show();

								$("#cs_id").val(cs_id);
								// $("#cs_case_number").val(cs_case_number);
								$("#cs_official_notes").val(cs_official_notes);
								$("#cs_date_of_registration").val(
										cs_date_of_registration);
								$("#cs_to_whom_issued").val(cs_to_whom_issued);
								$("#cs_serial_number").val(cs_serial_number);

							});

					$('#form_add_certificate')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										// console.log('form submited Clicked');
										var action_on_form = $(
												"#action_on_form_certificate")
												.val();
										var cs_id = $("#cs_id").val();
										var cs_case_number = $(
												"#cs_case_number").val();
										var cs_official_notes = $(
												"#cs_official_notes").val();
										var cs_date_of_registration = $(
												"#cs_date_of_registration")
												.val();
										var cs_to_whom_issued = $(
												"#cs_to_whom_issued").val();
										var cs_serial_number = $(
												"#cs_serial_number").val();

										/*
										 * var modified_by
										 * =$("#modified_by").val(); var
										 * modified_by_id
										 * =$("#modified_by_id").val();
										 */
										var request_type = "select_lrd_certificate_section_add_and_update";

										if (action_on_form == "edit") {
											request_type = "select_lrd_certificate_section_add_and_update";
										} else {
											request_type = "select_lrd_certificate_section_add_and_update";
										}

										$
												.ajax({
													type : "POST",
													url : "lrd_certificate_section_serv",
													data : {
														request_type : request_type,
														cs_id : cs_id,
														cs_case_number : cs_case_number,
														cs_official_notes : cs_official_notes,
														cs_date_of_registration : cs_date_of_registration,
														cs_to_whom_issued : cs_to_whom_issued,
														cs_serial_number : cs_serial_number,
													/*
													 * modified_by :
													 * modified_by,
													 * modified_by_id :
													 * modified_by_id
													 */
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
														// console.log(jobdetails)

														$(
																'#newCertificateModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Successfully Saved Certificate Details");

														var json_p = JSON
																.parse(jobdetails);

														var table_bp = $('#lrd_certificate_details_dataTable');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.data)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.cs_date_of_registration
																							+ "</td><td>"
																							+ this.cs_to_whom_issued
																							+ "</td><td>"
																							+ this.cs_serial_number
																							+ "</td><td>"
																							+ this.cs_official_notes
																							+ "</td>"

																							+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																							+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																							+ 'data-target="#newCertificateModal"'
																							+ '  data-target-id="'
																							+ this.cs_id
																							+ '"  data-cs_id="'
																							+ this.cs_id
																							+ '"  data-cs_case_number="'
																							+ this.cs_case_number
																							+ '"  data-cs_date_of_registration="'
																							+ this.cs_date_of_registration
																							+ '"  data-cs_to_whom_issued="'
																							+ this.cs_to_whom_issued
																							+ '"  data-cs_serial_number="'
																							+ this.cs_serial_number
																							+ '" data-cs_official_notes="'
																							+ this.cs_official_notes
																							+ '"> '
																							+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																							+ "</tr>");
																		});

														/*
														 * var result =
														 * JSON.parse(jobdetails);
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Certificate Record
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space-certificate"
														 * ).append( alert_mess ); }
														 */
													}

												});
									});

					

									$('#form_add_reservation')
									.on(
											'submit',
											function(e) {
												// validation code here
												e.preventDefault();
												// console.log('form submited Clicked');
												var action_on_form = $(
														"#action_on_form_reservation")
														.val();
												var rs_id = $("#rs_id").val();
												var rs_case_number = $(
														"#rs_case_number").val();
												var rs_reservation_description = $(
														"#rs_reservation_description").val();
		
												/*
												 * var modified_by
												 * =$("#modified_by").val(); var
												 * modified_by_id
												 * =$("#modified_by_id").val();
												 */
												var request_type = "select_lrd_reservation_section_add_and_update";
		
												if (action_on_form == "edit") {
													request_type = "select_lrd_reservation_section_add_and_update";
												} else {
													request_type = "select_lrd_reservation_section_add_and_update";
												}
		
												$
														.ajax({
															type : "POST",
															url : "lrd_reservation_section_serv",
															data : {
																request_type : request_type,
																rs_id : rs_id,
																rs_case_number : rs_case_number,
																rs_reservation_description : rs_reservation_description,
																// cs_date_of_registration : cs_date_of_registration,
																// cs_to_whom_issued : cs_to_whom_issued,
																// cs_serial_number : cs_serial_number,
															/*
															 * modified_by :
															 * modified_by,
															 * modified_by_id :
															 * modified_by_id
															 */
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
																// console.log(jobdetails)
		
																$(
																		'#newReservationModal')
																		.modal('hide');
																$(
																		"#general_message_dialog")
																		.modal();
																// $('#general_message_dialog
																// #general_message_dialog_msg').val(jobdetails);
																$(
																		'#general_message_dialog #general_message_dialog_msg_new')
																		.val(
																				"Successfully Saved Certificate Details");
		
																var json_p = JSON
																		.parse(jobdetails);
		
																var table_bp = $('#lrd_reservation_details_dataTable');
																table_bp.find(
																		"tbody tr")
																		.remove();
																$(json_p.data)
																		.each(
																				function() {
																					table_bp
																							.append("<tr><td>"
																									+ this.reservation_description
																									+ "</td><td>"
																									+ this.modified_by
																									+ "</td><td>"
																									+ this.created_date
																									+ "</td>"
		
																									+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																									+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																									+ 'data-target="#newReservationModal"'
																									+ '  data-target-id="'
																									+ this.rs_id
																									+ '"  data-rs_id="'
																									+ this.rs_id
																									+ '"  data-rs_case_number="'
																									+ this.case_number
																									+ '" data-rs_reservation_description="'
																									+ this.reservation_description
																									+ '"> '
																									+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																									+ "</tr>");
																				});
		
																/*
																 * var result =
																 * JSON.parse(jobdetails);
																 * var alert_mess = '<div
																 * class="alert
																 * alert-success fade
																 * show" id="bsalert">' + '<a
																 * href="#"
																 * class="close"
																 * data-dismiss="alert"
																 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
																 * Certificate Record
																 * saved successfully</div>';
																 * if(result.data=='Success'){ $(
																 * "#alert-display-space-certificate"
																 * ).append( alert_mess ); }
																 */
															}
		
														});
											});

					// ============================================= End Actions
					// for Certificate
					// ===============================================

					/*
					 * =========================================== Actions for
					 * Encumbrance ==================
					 */
					$('#newEncumberancesModal')
							.on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget) // Button
										// that
										// triggered
										// the modal
										var recipient = button.data('action') // Extract
										// info
										// from
										// data-* attributes
										// If necessary, you could initiate an
										// AJAX request here
										// (and then do the updating in a
										// callback).
										// Update the modal's content. We'll use
										// jQuery here, but
										// you could use a data binding library
										// or other methods
										// instead.
										var modal = $(this)
										if (recipient == 'edit') {
											modal
													.find(
															'.modal-body #action_on_form_encumbrances')
													.val(recipient)
											modal
													.find('.modal-title')
													.text(
															recipient
																	.toUpperCase()
																	+ " "
																	+ modal
																			.find(
																					'.modal-title')
																			.text()
																			.toUpperCase())

											// Get the objection data for
											// editing
											/*
											 * $.ajax({ type: "POST", url:
											 * "Case_Management_Serv", data: {
											 * request_type:
											 * 'update_stamp_duty_records',
											 * job_number:job_number }, cache:
											 * false, beforeSend: function () {
											 * //$('#district').html('<img
											 * src="img/loading.gif" alt=""
											 * width="24" height="24">'); },
											 * success: function(jobdetails) {
											 * console.log(jobdetails) var
											 * result = JSON.parse(jobdetails);
											 * if(result.data=='Success'){
											 * //Load all Objection data into
											 * form } }
											 */
										}

									});

					//$('#newEncumberancesModal').
					$('#newEncumberancesModal').on('show.bs.modal',function(event) {
						
						$("#newEncumberancesModal #es_id").val($(event.relatedTarget).data('es_id'));	
						$("#newEncumberancesModal #es_registered_number").val($(event.relatedTarget).data('es_registered_number'));
						var es_date_of_registration = $(event.relatedTarget).data('es_date_of_registration')

						if(es_date_of_registration != undefined) {
							$("#newEncumberancesModal #es_date_of_registration").val(es_date_of_registration.slice(0,10));
							//console.log(es_date_of_registration.slice(0,10));
						} else {
							$("#newEncumberancesModal #es_date_of_registration").val('');
						}


						var es_date_of_instrument = $(event.relatedTarget).data('es_date_of_instrument')

						if(es_date_of_registration != undefined) {
							$("#newEncumberancesModal #es_date_of_instrument").val(es_date_of_instrument.slice(0,10));
							//console.log(es_date_of_registration.slice(0,10));
						}else {
							$("#newEncumberancesModal #es_date_of_instrument").val('');
						}

						//$("#newEncumberancesModal #es_date_of_instrument").val($(event.relatedTarget).data('es_date_of_instrument'));	
						$("#newEncumberancesModal #es_back").val($(event.relatedTarget).data('es_back'));
						$("#newEncumberancesModal #es_forward").val($(event.relatedTarget).data('es_forward'));
						$("#newEncumberancesModal #es_remarks").val($(event.relatedTarget).data('es_remarks'));	
						$("#newEncumberancesModal #es_memorials").val($(event.relatedTarget).data('es_memorials'));
						$("#newEncumberancesModal #es_signature").val($(event.relatedTarget).data('es_signature'));
						$("#newEncumberancesModal #action_on_form_encumbrances").val($(event.relatedTarget).data('es_action_on_form_encumbrances'));
						$("#newEncumberancesModal #es_entry_number").val($(event.relatedTarget).data('es_entry_number'));
					});

					$('#newEncumberancesOnMotherModal').on('show.bs.modal',function(event) {
						
						$("#newEncumberancesOnMotherModal #m_es_id").val($(event.relatedTarget).data('es_id'));	

						var m_es_registered_number = $(event.relatedTarget).data('es_registered_number') == null ? $("#m_es_registered_number").val() : $(event.relatedTarget).data('es_registered_number');

						$("#newEncumberancesOnMotherModal #m_es_registered_number").val(m_es_registered_number);
						var es_date_of_registration = $(event.relatedTarget).data('es_date_of_registration')


						if(es_date_of_registration != undefined) {
							$("#newEncumberancesOnMotherModal #m_es_date_of_registration").val(es_date_of_registration.slice(0,10));
							//console.log(es_date_of_registration.slice(0,10));
						} else {
							$("#newEncumberancesOnMotherModal #m_es_date_of_registration").val('');
						}


						var es_date_of_instrument = $(event.relatedTarget).data('es_date_of_instrument')

						if(es_date_of_registration != undefined) {
							$("#newEncumberancesOnMotherModal #m_es_date_of_instrument").val(es_date_of_instrument.slice(0,10));
							//console.log(es_date_of_registration.slice(0,10));
						}else {
							$("#newEncumberancesOnMotherModal #m_es_date_of_instrument").val('');
						}

						//$("#newEncumberancesModal #es_date_of_instrument").val($(event.relatedTarget).data('es_date_of_instrument'));	
						$("#newEncumberancesOnMotherModal #m_es_back").val($(event.relatedTarget).data('es_back'));
						$("#newEncumberancesOnMotherModal #m_es_forward").val($(event.relatedTarget).data('es_forward'));
						$("#newEncumberancesOnMotherModal #m_es_remarks").val($(event.relatedTarget).data('es_remarks'));	
						$("#newEncumberancesOnMotherModal #m_es_memorials").val($(event.relatedTarget).data('es_memorials'));
						$("#newEncumberancesOnMotherModal #m_es_signature").val($(event.relatedTarget).data('es_signature'));
						$("#newEncumberancesOnMotherModal #m_action_on_form_encumbrances").val($(event.relatedTarget).data('es_action_on_form_encumbrances'));
						$("#newEncumberancesOnMotherModal #m_es_entry_number").val($(event.relatedTarget).data('es_entry_number'));
					});


					$('#newReservationModal').on('show.bs.modal',function(event) {
						$("#newReservationModal #rs_id").val($(event.relatedTarget).data('rs_id'));	
						$("#newReservationModal #rs_reservation_description").val($(event.relatedTarget).data('rs_reservation_description'));
						//$("#newEncumberancesModal #es_forward").val($(event.relatedTarget).data('es_forward'));
					});

					$('#form_add_encumbrances')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										console.log('form submited Clicked');
										var action_on_form = $(
												"#action_on_form_encumbrances")
												.val();
										var es_id = $("#es_id").val();
										var es_case_number = $(
												"#es_case_number").val();
										var es_registered_number = $(
												"#es_registered_number").val();

										var es_date_of_registration = $(
												"#es_date_of_registration")
												.val();
										var es_date_of_instrument = $("#es_date_of_instrument").val();
										var es_memorials = $("#es_memorials").val();

												var es_remarks = $("#es_remarks")
												.val();

												
												var es_back = $("#es_back").val();
												var es_forward = $("#es_forward").val();
												var es_signature = $("#es_signature").val();

												var es_entry_number = $("#es_entry_number").val();

										/*
										 * var modified_by
										 * =$("#modified_by").val(); var
										 * modified_by_id
										 * =$("#modified_by_id").val();
										 */

										if (es_id){

										}else {
											es_id=0;
										}

										var request_type = "select_lrd_encumbrances_section_add_and_update";

										if (action_on_form == "edit") {
											request_type = "select_lrd_encumbrances_section_add_and_update";
										} else {
											request_type = "select_lrd_encumbrances_section_add_and_update";
										}

										$
												.ajax({
													type : "POST",
													url : "lrd_encumbrances_section_serv",
													data : {
														request_type : request_type,
														es_id : parseInt(es_id),
														es_registered_number : es_registered_number,
														es_case_number : es_case_number,
														es_date_of_registration : es_date_of_registration,
														es_date_of_instrument : es_date_of_instrument,
														es_memorials : es_memorials,
														es_back : es_back,
														es_forward : es_forward,
														es_remarks : es_remarks,
														es_signature : es_signature,
														es_entry_number : es_entry_number
													/*
													 * modified_by :
													 * modified_by,
													 * modified_by_id :
													 * modified_by_id
													 */
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

														$(
																'#newEncumberancesModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Successfully Saved Encumbrance Details");

														var json_p = JSON
																.parse(jobdetails);

														var table_bp = $('#lrd_encumberance_details_dataTable');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.data)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.es_date_of_instrument
																							+ "</td><td>"
																							+ this.es_date_of_registration
																							+ "</td><td>"
																							+ this.es_registered_number
																							+ "</td><td>"
																							+ this.es_memorials
																							+ "</td><td>"
																							+ this.es_remarks
																							+ "</td><td>"
																							+ this.es_entry_number
																							+ "</td>"
																							+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																							+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																							+ 'data-target="#newEncumberancesModal"'
																							+ '  data-target-id="'
																							+ this.es_id
																							+ '"  data-es_id="'
																							+ this.es_id
																							+ '"  data-es_registered_number="'
																							+ this.es_registered_number
																							+ '"  data-cs_date_of_registration="'
																							+ this.cs_date_of_registration
																							+ '"  data-es_case_number="'
																							+ this.es_case_number
																							+ '"  data-es_date_of_registration="'
																							+ this.es_date_of_registration
																							+ '"  data-es_date_of_instrument="'
																							+ this.es_date_of_instrument
																							+ '"  data-es_memorials="'
																							+ this.es_memorials
																							+ '"  data-es_back="'
																							+ this.es_back
																							+ '" data-es_forward="'
																							+ this.es_forward
																							+ '" data-es_entry_number="'
																							+ this.es_entry_number
																							+ '"> '
																							+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																							+ "</tr>");
																		});

														/*
														 * var result =
														 * JSON.parse(jobdetails);
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Encumbrance Record
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space-certificate"
														 * ).append( alert_mess ); }
														 */
													}

												});
									});

									$('#form_add_encumbrances_on_mother')
									.on(
											'submit',
											function(e) {
												// validation code here
												e.preventDefault();
												console.log('form submited Clicked');
												var action_on_form = $(
														"#m_action_on_form_encumbrances")
														.val();
												var es_id = $("#m_es_id").val();
												var es_case_number = $(
														"#m_es_case_number").val();
												var es_registered_number = $(
														"#m_es_registered_number").val();
		
												var es_date_of_registration = $(
														"#m_es_date_of_registration")
														.val();
												var es_date_of_instrument = $("#m_es_date_of_instrument").val();
												var es_memorials = $("#m_es_memorials").val();
		
														var es_remarks = $("#m_es_remarks")
														.val();
		
														
														var es_back = $("#m_es_back").val();
														var es_forward = $("#m_es_forward").val();
														var es_signature = $("#m_es_signature").val();
		
														var es_entry_number = $("#m_es_entry_number").val();
		
												/*
												 * var modified_by
												 * =$("#modified_by").val(); var
												 * modified_by_id
												 * =$("#modified_by_id").val();
												 */
		
												if (es_id){
		
												}else {
													es_id=0;
												}
		
												var request_type = "select_lrd_encumbrances_section_add_and_update";
		
												if (action_on_form == "edit") {
													request_type = "select_lrd_encumbrances_section_add_and_update";
												} else {
													request_type = "select_lrd_encumbrances_section_add_and_update";
												}
		
												$
														.ajax({
															type : "POST",
															url : "lrd_encumbrances_section_serv",
															data : {
																request_type : request_type,
																es_id : parseInt(es_id),
																es_registered_number : es_registered_number,
																es_case_number : es_case_number,
																es_date_of_registration : es_date_of_registration,
																es_date_of_instrument : es_date_of_instrument,
																es_memorials : es_memorials,
																es_back : es_back,
																es_forward : es_forward,
																es_remarks : es_remarks,
																es_signature : es_signature,
																es_entry_number : es_entry_number
															/*
															 * modified_by :
															 * modified_by,
															 * modified_by_id :
															 * modified_by_id
															 */
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
		
																$(
																		'#newEncumberancesModal')
																		.modal('hide');
																$(
																		"#general_message_dialog")
																		.modal();
																// $('#general_message_dialog
																// #general_message_dialog_msg').val(jobdetails);
																$(
																		'#general_message_dialog #general_message_dialog_msg_new')
																		.val(
																				"Successfully Saved Encumbrance Details");
		
																var json_p = JSON
																		.parse(jobdetails);
		
																var table_bp = $('#lrd_encumberance_details_dataTable');
																table_bp.find(
																		"tbody tr")
																		.remove();
																$(json_p.data)
																		.each(
																				function() {
																					table_bp
																							.append("<tr><td>"
																									+ this.es_date_of_instrument
																									+ "</td><td>"
																									+ this.es_date_of_registration
																									+ "</td><td>"
																									+ this.es_registered_number
																									+ "</td><td>"
																									+ this.es_memorials
																									+ "</td><td>"
																									+ this.es_remarks
																									+ "</td><td>"
																									+ this.es_entry_number
																									+ "</td>"
																									+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																									+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																									+ 'data-target="#newEncumberancesModal"'
																									+ '  data-target-id="'
																									+ this.es_id
																									+ '"  data-es_id="'
																									+ this.es_id
																									+ '"  data-es_registered_number="'
																									+ this.es_registered_number
																									+ '"  data-cs_date_of_registration="'
																									+ this.cs_date_of_registration
																									+ '"  data-es_case_number="'
																									+ this.es_case_number
																									+ '"  data-es_date_of_registration="'
																									+ this.es_date_of_registration
																									+ '"  data-es_date_of_instrument="'
																									+ this.es_date_of_instrument
																									+ '"  data-es_memorials="'
																									+ this.es_memorials
																									+ '"  data-es_back="'
																									+ this.es_back
																									+ '" data-es_forward="'
																									+ this.es_forward
																									+ '" data-es_remarks="'
																									+ this.es_remarks
													  												+ '" data-es_signature="'
																									+ this.es_signature
																									+ '" data-es_entry_number="'
																									+ this.es_entry_number
																									+ '"> '
																									+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																									+ "</tr>");
																				});
		
																/*
																 * var result =
																 * JSON.parse(jobdetails);
																 * var alert_mess = '<div
																 * class="alert
																 * alert-success fade
																 * show" id="bsalert">' + '<a
																 * href="#"
																 * class="close"
																 * data-dismiss="alert"
																 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
																 * Encumbrance Record
																 * saved successfully</div>';
																 * if(result.data=='Success'){ $(
																 * "#alert-display-space-certificate"
																 * ).append( alert_mess ); }
																 */
															}
		
														});
											});

					// ============================================= End Actions
					// for Encumbrance
					// ===============================================

					/*
					 * =========================================== Actions for
					 * newMemorialsModal ==================
					 */
					$('#newMemorialsModal')
							.on(
									'show.bs.modal',
									function(event) {
										/*
										 * var button = $(event.relatedTarget) //
										 * Button that triggered the modal var
										 * recipient = button.data('action') //
										 * Extract info from data-* attributes
										 * var modal = $(this)
										 * if(recipient=='edit'){
										 * modal.find('.modal-body
										 * #action_on_form_memorials').val(recipient)
										 * modal.find('.modal-title').text(recipient.toUpperCase() +" "+
										 * modal.find('.modal-title').text().toUpperCase() )
										 * 
										 */

										var mid = parseInt($(
												event.relatedTarget)
												.data('mid') ? $(
												event.relatedTarget)
												.data('mid') : 0);
										var m_case_number = $(
												event.relatedTarget).data(
												'm_case_number');
										var m_registered_no = $(
												event.relatedTarget).data(
												'm_registered_no');
										var m_memorials = $(event.relatedTarget)
												.data('m_memorials');
										var m_date_of_instrument = $(
												event.relatedTarget).data(
												'm_date_of_instrument');
										var m_date_of_registration = $(
												event.relatedTarget).data(
												'm_date_of_registration');

												var m_entry_number = $(
													event.relatedTarget).data(
													'm_entry_number');
										var m_remarks = $(
											event.relatedTarget).data(
											'm_remarks');

										if (mid == "" || mid == undefined
												|| mid == NaN) {
											mid = '0';
											m_memorials = 'Subject to the reservations, exceptions, restrictions, restrictive covenants and conditions contained or referred to in a lease (a true copy of which is annexed hereto) made between (Grantor_Here) of the one part and ${ar_name} of the other part';
											$(".btn_reg_root_delete_action")
													.hide();
										} else {
											$(".btn_reg_root_delete_action")
													.show();
										}

										var cs_main_registered_number = $("#cs_main_registered_number").val();
								console.log(cs_main_registered_number);
								// m_registered_no = cs_main_registered_number === undefined 
								// 		? m_registered_no 
								// 		: (cs_main_registered_number === '' ? m_registered_no : cs_main_registered_number);

								//console.log(m_registered_no)

										$("#mid").val(mid);
										// $("#m_case_number").val(m_case_number);
										$("#m_registered_no").val(m_registered_no ?? cs_main_registered_number);
										$("#m_memorials").val(m_memorials);
										$("#m_date_of_instrument").val(
												m_date_of_instrument);
										$("#m_date_of_registration").val(
												m_date_of_registration);

												$("#m_remarks").val(
													m_remarks);
													$("#m_entry_number").val(
														m_entry_number);

									});


									$('#newMemorialsMDModal')
							.on(
									'show.bs.modal',
									function(event) {
										/*
										 * var button = $(event.relatedTarget) //
										 * Button that triggered the modal var
										 * recipient = button.data('action') //
										 * Extract info from data-* attributes
										 * var modal = $(this)
										 * if(recipient=='edit'){
										 * modal.find('.modal-body
										 * #action_on_form_memorials').val(recipient)
										 * modal.find('.modal-title').text(recipient.toUpperCase() +" "+
										 * modal.find('.modal-title').text().toUpperCase() )
										 * 
										 */

										var mid = parseInt($(
												event.relatedTarget)
												.data('mid') ? $(
												event.relatedTarget)
												.data('mid') : 0);
										var m_case_number = $(
												event.relatedTarget).data(
												'm_case_number');
										var m_registered_no = $(
												event.relatedTarget).data(
												'm_registered_no');
										var m_memorials = $(event.relatedTarget)
												.data('m_memorials');
										var m_date_of_instrument = $(
												event.relatedTarget).data(
												'm_date_of_instrument');
										var m_date_of_registration = $(
												event.relatedTarget).data(
												'm_date_of_registration');

												var m_entry_number = $(
													event.relatedTarget).data(
													'm_entry_number');

										var m_remarks = $(
											event.relatedTarget).data(
											'm_remarks');

										if (mid == "" || mid == undefined
												|| mid == NaN) {
											mid = '0';
											m_memorials = 'Mortgage to ${ar_name} to secure [LOAN AMOUNT] and the interest thereon.';
											$(".btn_reg_root_delete_action")
													.hide();
										} else {
											$(".btn_reg_root_delete_action")
													.show();
										}

										var cs_main_registered_number = $("#cs_main_registered_number").val();
								//console.log($('#cs_main_case_number').val());
								m_registered_no = cs_main_registered_number == '' ? m_registered_no : cs_main_registered_number;

										$("#mid_MD").val(mid);
										// $("#m_case_number").val(m_case_number);
										$("#m_registered_no_MD").val(m_registered_no);
										$("#m_memorials_MD").val(m_memorials);
										$("#m_date_of_instrument_MD").val(
												m_date_of_instrument);
										$("#m_date_of_registration_MD").val(
												m_date_of_registration);

												$("#m_remarks_MD").val(
													m_remarks);

													$("#m_entry_number").val(
														m_entry_number);

													$
													.ajax({
														type : "POST",
														url : "lrd_memorials_section_serv",
														data : {
															request_type : 'select_lrd_memorials_section_mother_registered_no',
															case_number : $('#cs_main_case_number').val(),
														/*
														 * modified_by :
														 * modified_by,
														 * modified_by_id :
														 * modified_by_id
														 */
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

																var json_b = JSON.parse(jobdetails);
																let registered_no;
																if(json_b.data != null) {
																	 registered_no = json_b.data[0].m_registered_no;
																}

																$("#m_registered_no_MD").val(registered_no);
															}
																

														})	

									});

					$('#form_add_memorials')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										console.log('form submited Clicked');
										// var action_on_form =
										// $("#action_on_form_memorials").val();
										var mid = $("#mid").val();
										var m_case_number = $("#m_case_number")
												.val();
										var m_registered_no = $(
												"#m_registered_no").val();

												console.log(m_registered_no)
										var m_memorials = $("#m_memorials")
												.val();
										var m_date_of_instrument = $(
												"#m_date_of_instrument").val();
										var m_date_of_registration = $(
												"#m_date_of_registration")
												.val();
										console.log('form submited Clicked');

										// var m_back = $("#m_back").val();
										// var m_forward =
										// $("#m_forward").val();
										var m_remarks = $("#m_remarks").val();

										var m_entry_number = $("#m_entry_number").val();

										/*
										 * var modified_by
										 * =$("#modified_by").val(); var
										 * modified_by_id
										 * =$("#modified_by_id").val();
										 */

										var request_type = "";
										request_type = "select_lrd_memorials_section_add_and_update";
										// if(action_on_form =="edit"){
										// request_type =
										// "select_lrd_memorials_section_add_and_update";
										// }
										// else{ request_type
										// ="select_lrd_memorials_section_add_and_update";
										// }
										/*
										 * console.log(mid);
										 * console.log(case_number);
										 * console.log(m_registered);
										 * console.log(m_memorials);
										 * 
										 * console.log(m_date_of_instrument);
										 * console.log(m_date_of_registration);
										 * console.log(request_type);
										 */
										$
												.ajax({
													type : "POST",
													url : "lrd_memorials_section_serv",
													data : {
														request_type : request_type,
														mid : mid,
														m_case_number : m_case_number,
														m_registered_no : m_registered_no,
														m_memorials : m_memorials,
														m_date_of_registration : m_date_of_registration,
														m_date_of_instrument : m_date_of_instrument,
														m_back : '-',
														m_forward : '-',
														m_remarks : m_remarks,
														m_entry_number : m_entry_number
													/*
													 * modified_by :
													 * modified_by,
													 * modified_by_id :
													 * modified_by_id
													 */
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
														// console.log(jobdetails)

														$('#newMemorialsModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Successfully Saved Mamorails Details");

														var json_p = JSON
																.parse(jobdetails);

														var table_bp = $('#lrd_memorial_details_dataTable, #lrd_memorial_details_dataTable_2');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.data)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.m_registered_no
																							+ "</td><td>"
																							+ this.m_memorials
																							+ "</td><td>"
																							+ this.m_date_of_instrument
																							+ "</td><td>"
																							+ this.m_date_of_registration
																							+ "</td><td>"
																							+ this.m_entry_number
																							+ "</td>"
																							+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																							+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																							+ 'data-target="#newMemorialsModal"'
																							+ '  data-target-id="'
																							+ this.mid
																							+ '"  data-mid="'
																							+ this.mid
																							+ '"  data-m_case_number="'
																							+ this.m_case_number
																							+ '"  data-m_registered_no="'
																							+ this.m_registered_no
																							+ '"  data-m_memorials="'
																							+ this.m_memorials
																							+ '"  data-m_date_of_registration="'
																							+ this.m_date_of_registration
																							+ '"  data-m_date_of_instrument="'
																							+ this.m_date_of_instrument
																							+ '"  data-m_back="'
																							+ this.m_back
																							+ '"  data-m_forward="'
																							+ this.m_forward
																							+ '"  data-m_entry_number="'
																							+ this.m_entry_number
																							+ '" data-m_remarks="'
																							+ this.m_remarks
																							+ '"> '
																							+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																							+ "</tr>");
																		});

														/*
														 * var result =
														 * JSON.parse(jobdetails);
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Memorials Record
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space-memorials"
														 * ).append( alert_mess ); }
														 */
													}

												});
									});


									$('#form_add_memorials_MD')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										console.log('form submited Clicked');
										// var action_on_form =
										// $("#action_on_form_memorials").val();
										var mid = $("#mid_MD").val();
										var m_case_number = $("#m_case_number_MD").val();
										var m_registered_no = $("#m_registered_no_MD").val();

												console.log(m_registered_no)
										var m_memorials = $("#m_memorials_MD").val();
										var m_date_of_instrument = $("#m_date_of_instrument_MD").val();
										var m_date_of_registration = $("#m_date_of_registration_MD").val();
										console.log('form submited Clicked');

										// var m_back = $("#m_back").val();
										// var m_forward =
										// $("#m_forward").val();
										var m_remarks = $("#m_remarks_MD").val();
										var m_entry_number = $("#m_entry_number").val();
										/*
										 * var modified_by
										 * =$("#modified_by").val(); var
										 * modified_by_id
										 * =$("#modified_by_id").val();
										 */

										var request_type = "";
										request_type = "select_lrd_memorials_section_add_and_update";
										// if(action_on_form =="edit"){
										// request_type =
										// "select_lrd_memorials_section_add_and_update";
										// }
										// else{ request_type
										// ="select_lrd_memorials_section_add_and_update";
										// }
										/*
										 * console.log(mid);
										 * console.log(case_number);
										 * console.log(m_registered);
										 * console.log(m_memorials);
										 * 
										 * console.log(m_date_of_instrument);
										 * console.log(m_date_of_registration);
										 * console.log(request_type);
										 */
										$
												.ajax({
													type : "POST",
													url : "lrd_memorials_section_serv",
													data : {
														request_type : request_type,
														mid : mid,
														m_case_number : m_case_number,
														m_registered_no : m_registered_no,
														m_memorials : m_memorials,
														m_date_of_registration : m_date_of_registration,
														m_date_of_instrument : m_date_of_instrument,
														m_back : '-',
														m_forward : '-',
														m_remarks : m_remarks,
														m_entry_number: m_entry_number
													/*
													 * modified_by :
													 * modified_by,
													 * modified_by_id :
													 * modified_by_id
													 */
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
														// console.log(jobdetails)

														$('#newMemorialsModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Successfully Saved Mamorails Details");

														var json_p = JSON
																.parse(jobdetails);

														var table_bp = $('#lrd_memorial_details_dataTable, #lrd_memorial_details_dataTable_2');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.data)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.m_registered_no
																							+ "</td><td>"
																							+ this.m_memorials
																							+ "</td><td>"
																							+ this.m_date_of_instrument
																							+ "</td><td>"
																							+ this.m_date_of_registration
																							+ "</td><td>"
																							+ this.m_entry_number
																							+ "</td>"
																							+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																							+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																							+ 'data-target="#newMemorialsMDModal"'
																							+ '  data-target-id="'
																							+ this.mid
																							+ '"  data-mid="'
																							+ this.mid
																							+ '"  data-m_case_number="'
																							+ this.m_case_number
																							+ '"  data-m_registered_no="'
																							+ this.m_registered_no
																							+ '"  data-m_memorials="'
																							+ this.m_memorials
																							+ '"  data-m_date_of_registration="'
																							+ this.m_date_of_registration
																							+ '"  data-m_date_of_instrument="'
																							+ this.m_date_of_instrument
																							+ '"  data-m_back="'
																							+ this.m_back
																							+ '"  data-m_forward="'
																							+ this.m_forward
																							+ '"  data-m_entry_number="'
																							+ this.m_entry_number
																							+ '" data-m_remarks="'
																							+ this.m_remarks
																							+ '"> '
																							+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																							+ "</tr>");
																		});

														/*
														 * var result =
														 * JSON.parse(jobdetails);
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Memorials Record
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space-memorials"
														 * ).append( alert_mess ); }
														 */
													}

												});
									});

					// ============================================= End Actions
					// for
					// newMemorialsModal
					// ===============================================

					/*
					 * =========================================== Actions for
					 * newProprietorshipModal ==================
					 */
					$('#newProprietorshipModal').on(
							'show.bs.modal',
							function(event) {
								// var button = $(event.relatedTarget) // Button
								// that
								// triggered the modal
								// var recipient = button.data('action') //
								// Extract info
								// from data-* attributes
								// var target_id = button.data('target-id') //
								// Extract
								// info from data-* attributes

								// If necessary, you could initiate an AJAX
								// request here
								// (and then do the updating in a callback).
								// Update the modal's content. We'll use jQuery
								// here,
								// but you could use a data binding library or
								// other
								// methods instead.
								/*
								 * var modal = $(this) if(recipient=='edit'){
								 * modal.find('.modal-body
								 * #action_on_form_proprietory').val(recipient)
								 * modal.find('.modal-title').text(recipient.toUpperCase() +" "+
								 * modal.find('.modal-title').text().toUpperCase() ) }
								 */

								var ps_id = parseInt($(event.relatedTarget)
										.data('ps_id') ? $(event.relatedTarget)
										.data('ps_id') : "0");
								var ps_case_number = $(event.relatedTarget)
										.data('ps_case_number');
								var ps_registration_number = $(
										event.relatedTarget).data(
										'ps_registration_number');
								var ps_proprietor = $(event.relatedTarget)
										.data('ps_proprietor');
								var ps_date_of_instrument = $(event.relatedTarget).data('ps_date_of_instrument') ? ($(event.relatedTarget).data('ps_date_of_instrument')).slice(0, 10) : "";
								var ps_nature_of_instrument = $(
										event.relatedTarget).data(
										'ps_nature_of_instrument');
								var ps_date_of_registration = $(event.relatedTarget).data('ps_date_of_registration') ? ($(event.relatedTarget).data('ps_date_of_registration')).slice(0, 10) : "";
								var ps_transferor = $(event.relatedTarget)
										.data('ps_transferor');
								var ps_transferee = $(event.relatedTarget)
										.data('ps_transferee');
								var ps_price_paid = $(event.relatedTarget)
										.data('ps_price_paid');
								var ps_remarks = $(event.relatedTarget).data(
										'ps_remarks');

										var ps_signature = $(event.relatedTarget).data(
											'ps_signature');

											var ps_term = $(event.relatedTarget).data(
												'ps_term');	

								if (ps_id == "" || ps_id == undefined
										|| ps_id == NaN) {
									ps_id = '0';
									// console.log("testing P_ID");
									var cs_main_registered_number = $("#cs_main_registered_number").val() == null ? $("#fe_registered_number").val() : $("#cs_main_registered_number").val();
								//console.log(cs_main_registered_number);
								ps_registration_number = cs_main_registered_number;
									//$("#newProprietorshipModal #ps_registration_number").val(cs_main_registered_number);
									$(".btn_reg_root_delete_action").hide();
								} else {
									$(".btn_reg_root_delete_action").show();
								}

								$("#ps_id").val(ps_id);
								// $("#ps_case_number").val(ps_case_number);
								$("#ps_registration_number").val(ps_registration_number ?? cs_main_registered_number);
								$("#ps_proprietor").val(ps_proprietor);
								$("#ps_date_of_instrument").val(
										ps_date_of_instrument);
								$("#ps_nature_of_instrument").val(
										ps_nature_of_instrument);
								$("#ps_date_of_registration").val(
										ps_date_of_registration);
								$("#ps_transferor").val(ps_transferor);
								$("#ps_transferee").val(ps_transferee);
								$("#ps_price_paid").val(ps_price_paid);
								$("#ps_remarks").val(ps_remarks);
								$("#ps_signature").val(ps_signature);
								$("#ps_term").val(ps_term);

								

							});

					$('#form_add_proprietory')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										console.log('form submited Clicked'); 
										var action_on_form = $(
												"#action_on_form_proprietory")
												.val();

										var ps_id = parseInt($("#ps_id").val());
										var case_number = $("#ps_case_number")
												.val();
										var ps_registration_number = $(
												"#ps_registration_number")
												.val();
										var ps_proprietor = $("#ps_proprietor")
												.val();
										var ps_date_of_instrument = $(
												"#ps_date_of_instrument").val();
										var ps_nature_of_instrument = $(
												"#ps_nature_of_instrument")
												.val();
										var ps_date_of_registration = $(
												"#ps_date_of_registration")
												.val();
										var ps_transferor = $("#ps_transferor")
												.val();
										var ps_transferee = $("#ps_transferee")
												.val();
										var ps_price_paid = $("#ps_price_paid")
												.val();
										var ps_remarks = $("#ps_remarks").val();
										 var ps_signature = $("#ps_signature").val();
										 var ps_term = $("#ps_term").val();
										/*
										 * var modified_by
										 * =$("#modified_by").val(); var
										 * modified_by_id
										 * =$("#modified_by_id").val();
										 */
// console.log("ps_nature_of_instrument");
// console.log(ps_nature_of_instrument);
										var request_type = "";

										if (action_on_form == "edit") {
											request_type = "select_lrd_proprietorship_section_add_and_update";
										} else {
											request_type = "select_lrd_proprietorship_section_add_and_update";
										}

										$
												.ajax({
													type : "POST",
													url : "lrd_proprietorship_section_serv",
													data : {
														request_type : request_type,
														ps_id : ps_id,
														ps_case_number : case_number,
														ps_registration_number : ps_registration_number,
														ps_proprietor : ps_proprietor,
														ps_date_of_instrument : ps_date_of_instrument,
														ps_nature_of_instrument : ps_nature_of_instrument,
														ps_date_of_registration : ps_date_of_registration,
														ps_transferor : ps_transferor,
														ps_transferee : ps_transferee,
														ps_price_paid : ps_price_paid,
														ps_remarks : ps_remarks,
														ps_signature : ps_signature,
														ps_term : ps_term
													/*
													 * modified_by :
													 * modified_by,
													 * modified_by_id :
													 * modified_by_id
													 */
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
														var json_p = JSON
																.parse(jobdetails);

														$(
																'#newProprietorshipModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Successfully Saved Proprietorship Details");

														var table_bp = $('#lrd_proprietorship_details_dataTable, #lrd_proprietorship_details_dataTable_final_approval');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.data)
																.each(
																		function() {
																			table_bp
																					.append(`<tr><td>
																							 ${this.ps_registration_number}
																							</td><td>
																							${this.ps_proprietor}
																							</td><td>
																							${this.ps_date_of_instrument}
																							</td><td>
																							${this.ps_nature_of_instrument}
																							</td><td>
																							${this.ps_date_of_registration}
																							</td><td>
																							${this.ps_transferor} - ${this.ps_transferee}
																							</td><td>
																							${this.ps_price_paid}
																							</td><td>
																							${this.ps_remarks}
																							</td><td>
																							${this.ps_term}
																							</td>
																							<td class="">
																							<p data-placement="top" data-toggle="tooltip"  title="Edit">
																							<button class="btn btn-info btn-icon-split ${this.edit == 1 ? 'd-none' : ''} " data-title="Delete"data-toggle="modal"
																							data-target="#newProprietorshipModal"
																							data-target-id="${this.ps_id}" 
																							data-ps_id="${this.ps_id}"
																							data-ps_case_number="${this.ps_case_number}"
																							data-ps_registration_number="${this.ps_registration_number}"
																							data-ps_proprietor="${this.ps_proprietor}"
																							data-ps_date_of_instrument="${this.ps_date_of_instrument}"
																							data-ps_nature_of_instrument="${this.ps_nature_of_instrument}"
																							data-ps_date_of_registration="${this.ps_date_of_registration}"
																							data-ps_transferor="${this.ps_transferor}"
																							data-ps_transferee="${this.ps_transferee}"
																							data-ps_price_paid="${this.ps_price_paid}"
																							data-ps_remarks="${this.ps_remarks}"
																							data-ps_signature="${this.ps_signature}"
																							data-ps_term="${this.ps_term}"
																							>
																							<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>
																							</tr>`);
																		});


																		

														/*
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Proprietorship Record
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space-proprietory"
														 * ).append( alert_mess ); }
														 */
													}

												});
									});

					// ============================================= End Actions
					// for
					// newProprietorshipModal
					// ===============================================

					// =============Action for delete button ================

					$(".btn_reg_root_delete_action")
							.on(
									"click",
									function() {
										let
										target_element = $(this).data(
												'action_type');
										let
										ps_id = "";
										if (target_element === "valuation") {
											ps_id = $("#vs_id").val();
										} else if (target_element === "memorials") {
											ps_id = $("#mid").val();
										} else if (target_element === "proprietor") {
											ps_id = $("#ps_id").val();
										} else if (target_element === "certificate") {
											ps_id = $("#cs_id").val();
										} else {
											ps_id = 0;
										}

										// console.log("Testing =
										// "+target_element + " del_id:" +
										// ps_id);
										bootbox
												.confirm({
													title : "Action confrimation!",
													message : "Are you sure you want to Delete this record line from the Application?",
													buttons : {
														cancel : {
															label : '<i class="fa fa-times"></i> Cancel'
														},
														confirm : {
															label : '<i class="fa fa-check"></i> Confirm'
														}
													},
													callback : function(result) {
														if (result) {

															$
																	.ajax({
																		type : "POST",
																		url : "lrd_proprietorship_section_serv",
																		data : {
																			request_type : 'select_lrd_proprietorship_section_delete_by_id',
																			ps_id : parseInt(ps_id),
																			target_element : target_element,
																		},
																		cache : false,

																		success : function(
																				jobdetails) {

																			if (target_element === 'proprietor') {
																				try {
																					var json_p = JSON
																							.parse(jobdetails);
																					$(
																							'#newProprietorshipModal')
																							.modal(
																									'hide');
																					$(
																							"#general_message_dialog")
																							.modal();
																					$(
																							'#general_message_dialog #general_message_dialog_msg_new')
																							.val(
																									"Successfully Deleted Proprietorship Details");
																					var table_bp = $('#lrd_proprietorship_details_dataTable');
																					table_bp
																							.find(
																									"tbody tr")
																							.remove();
																					$(
																							json_p.data)
																							.each(
																									function() {
																										table_bp
																												.append("<tr><td>"
																														+ this.ps_registration_number
																														+ "</td><td>"
																														+ this.ps_proprietor
																														+ "</td><td>"
																														+ this.ps_date_of_instrument
																														+ "</td><td>"
																														+ this.ps_nature_of_instrument
																														+ "</td>"
																														+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																														+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																														+ 'data-target="#newProprietorshipModal"'
																														+ '  data-target-id="'
																														+ this.ps_id
																														+ '"  data-ps_id="'
																														+ this.ps_id
																														+ '"  data-ps_case_number="'
																														+ this.ps_case_number
																														+ '"  data-ps_registration_number="'
																														+ this.ps_registration_number
																														+ '"  data-ps_proprietor="'
																														+ this.ps_proprietor
																														+ '"  data-ps_date_of_instrument="'
																														+ this.ps_date_of_instrument
																														+ '"  data-ps_nature_of_instrument="'
																														+ this.ps_nature_of_instrument
																														+ '"  data-ps_date_of_registration="'
																														+ this.ps_date_of_registration
																														+ '"  data-ps_transferor="'
																														+ this.ps_transferor
																														+ '"  data-ps_transferee="'
																														+ this.ps_transferee
																														+ '"  data-ps_price_paid="'
																														+ this.ps_price_paid
																														+ '"  data-ps_remarks="'
																														+ this.ps_remarks
																														+ '" data-ps_signature="'
																														+ this.ps_signature
																														+ '"> '
																														+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																														+ "</tr>");
																									});
																				} catch (e) {

																				}

																			} else if (target_element === 'memorials') {
																				try {
																					$(
																							'#newMemorialsModal')
																							.modal(
																									'hide');
																					$(
																							"#general_message_dialog")
																							.modal();
																					$(
																							'#general_message_dialog #general_message_dialog_msg_new')
																							.val(
																									"Successfully Deleted Mamorails Details");

																					var json_p = JSON
																							.parse(jobdetails);

																					var table_bp = $('#lrd_memorial_details_dataTable');
																					table_bp
																							.find(
																									"tbody tr")
																							.remove();
																					$(
																							json_p.data)
																							.each(
																									function() {
																										table_bp
																												.append("<tr><td>"
																														+ this.m_registered_no
																														+ "</td><td>"
																														+ this.m_memorials
																														+ "</td><td>"
																														+ this.m_date_of_instrument
																														+ "</td><td>"
																														+ this.m_date_of_registration
																														+ '</td> <td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																														+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																														+ 'data-target="#newMemorialsModal"'
																														+ '  data-target-id="'
																														+ this.mid
																														+ '"  data-mid="'
																														+ this.mid
																														+ '"  data-m_case_number="'
																														+ this.m_case_number
																														+ '"  data-m_registered_no="'
																														+ this.m_registered_no
																														+ '"  data-m_memorials="'
																														+ this.m_memorials
																														+ '"  data-m_date_of_registration="'
																														+ this.m_date_of_registration
																														+ '"  data-m_date_of_instrument="'
																														+ this.m_date_of_instrument
																														+ '"  data-m_back="'
																														+ this.m_back
																														+ '"  data-m_forward="'
																														+ this.m_forward
																														+ '" data-m_remarks="'
																														+ this.m_remarks
																														+ '"> '
																														+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																														+ "</tr>");
																									});

																				} catch (e) {

																				}
																			} else if (target_element === 'valuation') {
																				try {
																					$(
																							'#newValuationModal')
																							.modal(
																									'hide');

																					$(
																							"#general_message_dialog")
																							.modal();
																					$(
																							'#general_message_dialog #general_message_dialog_msg_new')
																							.val(
																									"Successfully Deleted Valuation Details");

																					var json_p = JSON
																							.parse(jobdetails);

																					var table_bp = $('#lrd_valuation_details_dataTable');
																					table_bp
																							.find(
																									"tbody tr")
																							.remove();
																					$(
																							json_p.data)
																							.each(
																									function() {
																										table_bp
																												.append("<tr><td>"
																														+ this.vs_date_of_valuation
																														+ "</td><td>"
																														+ this.vs_amount
																														+ "</td><td>"
																														+ this.vs_remarks
																														+ "</td>"
																														+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																														+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																														+ 'data-target="#newValuationModal"'
																														+ '  data-target-id="'
																														+ this.vs_id
																														+ '"  data-vs_id="'
																														+ this.vs_id
																														+ '"  data-vs_case_number="'
																														+ this.vs_case_number
																														+ '"  data-vs_date_of_valuation="'
																														+ this.vs_date_of_valuation
																														+ '"  data-vs_amount="'
																														+ this.vs_amount
																														+ '" data-vs_remarks="'
																														+ this.vs_remarks
																														+ '"> '
																														+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																														+ "</tr>");
																									});
																				} catch (e) {

																				}
																			} else if (target_element === 'certificate') {
																				try {
																					$(
																							'#newCertificateModal')
																							.modal(
																									'hide');
																					$(
																							"#general_message_dialog")
																							.modal();
																					// $('#general_message_dialog
																					// #general_message_dialog_msg').val(jobdetails);
																					$(
																							'#general_message_dialog #general_message_dialog_msg_new')
																							.val(
																									"Successfully Deleted Certificate Details");

																					var json_p = JSON
																							.parse(jobdetails);

																					var table_bp = $('#lrd_certificate_details_dataTable');
																					table_bp
																							.find(
																									"tbody tr")
																							.remove();
																					$(
																							json_p.data)
																							.each(
																									function() {
																										table_bp
																												.append("<tr><td>"
																														+ this.cs_date_of_registration
																														+ "</td><td>"
																														+ this.cs_to_whom_issued
																														+ "</td><td>"
																														+ this.cs_serial_number
																														+ "</td><td>"
																														+ this.cs_official_notes
																														+ "</td>"

																														+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																														+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																														+ 'data-target="#newCertificateModal"'
																														+ '  data-target-id="'
																														+ this.cs_id
																														+ '"  data-cs_id="'
																														+ this.cs_id
																														+ '"  data-cs_case_number="'
																														+ this.cs_case_number
																														+ '"  data-cs_date_of_registration="'
																														+ this.cs_date_of_registration
																														+ '"  data-cs_to_whom_issued="'
																														+ this.cs_to_whom_issued
																														+ '"  data-cs_serial_number="'
																														+ this.cs_serial_number
																														+ '" data-cs_official_notes="'
																														+ this.cs_official_notes
																														+ '"> '
																														+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																														+ "</tr>");
																									});
																				} catch (e) {

																				}
																			}
																			// end
																			// IF
																			// console.log("Testing
																			// sjax
																			// = "
																			// +
																			// jobdetails
																			// + "
																			// id:"
																			// +
																			// ps_id);
																		}
																	});

														}

													}

												});

										// console.log("Testing action = " +
										// target_element + " id:" + ps_id);

									});

					// ==== End delete button action =====

					/*
					 * =========================================== Actions for
					 * newValuationModal ==================
					 */
					$('#newValuationModal').on(
							'show.bs.modal',
							function(event) {
								/*
								 * var button = $(event.relatedTarget) // Button
								 * that triggered the modal var recipient =
								 * button.data('action') // Extract info from
								 * data-* attributes // If necessary, you could
								 * initiate an AJAX request here (and then do
								 * the updating in a callback). // Update the
								 * modal's content. We'll use jQuery here, but
								 * you could use a data binding library or other
								 * methods instead. var modal = $(this)
								 * if(recipient=='edit'){
								 * modal.find('.modal-body
								 * #action_on_form_valuation').val(recipient)
								 * modal.find('.modal-title').text(recipient.toUpperCase() +" "+
								 * modal.find('.modal-title').text().toUpperCase() ) }
								 */
								var vs_id = parseInt($(event.relatedTarget)
										.data('vs_id') ? $(event.relatedTarget)
										.data('vs_id') : 0);
								var vs_case_number = $(event.relatedTarget)
										.data('vs_case_number');
								var vs_date_of_valuation = $(
										event.relatedTarget).data(
										'vs_date_of_valuation');
								var vs_amount = $(event.relatedTarget).data(
										'vs_amount');
								var vs_remarks = $(event.relatedTarget).data(
										'vs_remarks');

								if (vs_id == "" || vs_id == undefined
										|| vs_id == NaN) {
									vs_id = '0';
									$(".btn_reg_root_delete_action").hide();
								} else {
									$(".btn_reg_root_delete_action").show();
								}

								$("#vs_id").val(vs_id);
								// $("#vs_case_number").val(vs_case_number);
								$("#vs_date_of_valuation").val(
										vs_date_of_valuation);
								$("#vs_amount").val(vs_amount);
								$("#vs_remarks").val(vs_remarks);

							});

					$('#form_add_valuation')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										// console.log('form submited Clicked');
										var action_on_form = $(
												"#action_on_form_valuation")
												.val();
										var vs_id = parseInt($("#vs_id").val());
										var vs_case_number = $(
												"#vs_case_number").val();
										var vs_date_of_valuation = $(
												"#vs_date_of_valuation").val();
										var vs_amount = $("#vs_amount").val();
										var vs_remarks = $("#vs_remarks").val();

										/*
										 * var modified_by
										 * =$("#modified_by").val(); var
										 * modified_by_id
										 * =$("#modified_by_id").val();
										 */
										var request_type = "select_lrd_valuation_section_add_and_update";

										if (action_on_form == "edit") {
											request_type = "select_lrd_valuation_section_add_and_update";
										} else {
											request_type = "select_lrd_valuation_section_add_and_update";
										}

										$
												.ajax({
													type : "POST",
													url : "lrd_valuation_section_serv",
													data : {
														request_type : request_type,
														vs_id : vs_id,
														vs_case_number : vs_case_number,
														vs_date_of_valuation : vs_date_of_valuation,
														vs_amount : vs_amount,
														vs_remarks : vs_remarks,
													/*
													 * modified_by :
													 * modified_by,
													 * modified_by_id :
													 * modified_by_id
													 */
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
														// console.log(jobdetails)

														$('#newValuationModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Successfully Saved Valuation Details");

														var json_p = JSON
																.parse(jobdetails);

														var table_bp = $('#lrd_valuation_details_dataTable');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.data)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.vs_date_of_valuation
																							+ "</td><td>"
																							+ this.vs_amount
																							+ "</td><td>"
																							+ this.vs_remarks
																							+ "</td>"
																							+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																							+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																							+ 'data-target="#newValuationModal"'
																							+ '  data-target-id="'
																							+ this.vs_id
																							+ '"  data-vs_id="'
																							+ this.vs_id
																							+ '"  data-vs_case_number="'
																							+ this.vs_case_number
																							+ '"  data-vs_date_of_valuation="'
																							+ this.vs_date_of_valuation
																							+ '"  data-vs_amount="'
																							+ this.vs_amount
																							+ '" data-vs_remarks="'
																							+ this.vs_remarks
																							+ '"> '
																							+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																							+ "</tr>");
																		});

														/*
														 * var result =
														 * JSON.parse(jobdetails);
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Valuation Record
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space-valuation"
														 * ).append( alert_mess ); }
														 */
													}

												});
									});

					// btn-uploadcoordiantecsv
					$('#btn-uploadcoordiantecsv')
							.click(
									function() {

										var table_bp = $('#coordinatelis_Table');
										table_bp.find("tbody tr").remove();

										var csv = $('#txtFileUploaduploadcoordiantecsv');
										var csvFile = csv[0].files[0];
										var ext = csv.val().split(".").pop()
												.toLowerCase();

										if ($.inArray(ext, [ "csv" ]) === -1) {
											alert('upload csv');
											return false;
										}
										if (csvFile != undefined) {
											reader = new FileReader();
											reader.onload = function(e) {

												// console.log(e.target.result)
												csvResult = e.target.result
														.split(/\r|\n|\r\n/);
												// $('.csv').append(csvResult);
												// console.log(csvResult)
												var list_from_csv = e.target.result;

												var coordinates = list_from_csv
														.split('\n');

												var points = [];
												// console.log('coodinates
												// list');
												// console.log(coordinates);

												// console.log(coodinates.length);
												// console.log('length:'+
												// coordinates.length);
												coordinates
														.forEach(function(entry) {
															// console.log(entry);

															points = entry
																	.split(",");

															if (points.length > 1) {
																// polypoints.push(ol.proj.transform([parseFloat(points[0]),parseFloat(points[1])],'EPSG:4326','EPSG:3857'))
																// polypoints.push([parseFloat(points[0]),parseFloat(points[1])])
																// console.log(points[0]);
																var table = $('#coordinatelis_Table');
																// table.find("tbody
																// tr").remove();

																table
																		.append("<tr><td>"
																				+ points[0]
																				+ "</td><td>"
																				+ points[1]
																				+ "</td><td>"
																				+ points[2]
																				+ "</td><td>"
																				+ ''
																				+ "</td>"

																				// +
																				// '<td><p
																				// data-placement="top"
																				// data-toggle="tooltip"
																				// title="Milestone"><button
																				// class="btn
																				// btn-success
																				// btn-circle
																				// btn-sm"
																				// data-title="Delete"
																				// ' +
																				// result.job_number
																				// + '
																				// id="btnmilestoneslist"><span
																				// class="fas
																				// fa-check"></span></button></p>
																				// </td>'

																				/*
																				 * + '<td><p data-placement="top" data-toggle="tooltip" title="Remove"><button
																				 * class="btn
																				 * btn-info
																				 * btn-icon-split"
																				 * data-title="Delete"
																				 * data-toggle="modal"
																				 * data-target="#edit"
																				 * data-target-id="' +
																				 * points[0] +
																				 * '"><span
																				 * class="icon
																				 * text-white-50">
																				 * <i
																				 * class="fas
																				 * fa-info-circle"></i></span></button></p></td>'
																				 */
																				+ "</tr>");
															}

														});
											}
											reader.readAsText(csvFile);

											/*
											 * var file = evt.target.files[0];
											 * var reader = new FileReader();
											 * reader.readAsText(file);
											 * reader.onload = function(event) {
											 * //Jquery.csv
											 * createArray($.csv.toArrays(event.target.result)); };
											 */

											// $('#form_inspection').modal('hide');
											// $("#general_message_dialog").modal();
											// $('#general_message_dialog
											// #general_message_dialog_msg_new').val('CSV
											// File has been Uploaded
											// Successfully');
											$('#uploadcoordiantecsv').modal(
													'hide');
										}
									});



	$('#update_digital_workflow_milestone').on('show.bs.modal',function(event) {
			var button = $(event.relatedTarget) // Button
			var job_number = $(event.relatedTarget).data('job_number');
			var workflow_type = $(event.relatedTarget).data('workflow_type');

			console.log(up_userid);
			$.ajax({
				type : "POST",
				url : "valueadded_services_serv",
				data : {
					request_type : 'get_all_baby_steps_for_job',
					job_number : job_number,
					workflow_type : workflow_type
				},
				cache : false,
				success : function(jobdetails) {

					var table = $('#tbl_baby_steps_list_dataTable');

					table.find("tbody tr").remove();

					console.log(jobdetails);
					var json_p = JSON.parse(jobdetails);

					$(json_p.data).each(function() {

						// Build radio button with same name and correct value
						let radio = "<input type='radio' name='bse_selected' value='" + this.bse_id + "'";

						if (this.bse_option) {
							radio += " checked";  // Pre-select if marked in data
						}

						radio += " />";

						// Append row to table
						table.append(
							"<tr>" +
								"<td>" + this.bse_description + "</td>" +
								"<td>" + radio + "</td>" +
								
							"</tr>"
						);

					});

				}
			});

		});

		$("#btn_process_updated_milestone").on("click", function () {

				var bse_id = $("input[name='bse_selected']:checked").val();

				if (bse_id) {
					alert("Selected BSE ID: " + bse_id);
					console.log("Selected BSE ID:", bse_id);

					$.ajax({
								type : "POST",
								url : "valueadded_services_serv",
								data : {
									request_type : 'get_process_milestone_update_baby_steps_for_job',
									bse_id :  bse_id,
								},
								cache : false,
								success : function(jobdetails) {
									alert("bse_id: " + jobdetails);
								}
							});



				} else {
					alert("No option selected!");
				}

			});


									$('#lc_btn_generate_certificate_volume_folio_tsc').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number_tsc").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number_tsc").val();
										var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');
								
										//  if(!lc_txt_type_of_certificate) {
										// 	alert("Please select a certificate type");
										// 	 return;
										//  }
										 
										 if (confirm("Are you sure to generate certificate as "+lc_txt_type_of_certificate+"?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_create_volume_folio_number_tcs',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_certificate_volume_folio_tsc').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_certificate_number').val(json_p.certificate_number);
													 $('#lc_txt_volume_number').val(json_p.volume);
													 $('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('Certifificate, Folio and Volume Numbers has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });


									   $('#lc_btn_generate_certificate_volume_folio_tcs').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');
								
										//  if(!lc_txt_type_of_certificate) {
										// 	alert("Please select a certificate type");
										// 	 return;
										//  }
										 
										 if (confirm("Are you sure to generate certificate as "+lc_txt_type_of_certificate+"?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_create_volume_folio_number_tcs',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_certificate_volume_folio_tcs').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_certificate_number').val(json_p.certificate_number);
													 $('#lc_txt_volume_number').val(json_p.volume);
													 $('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('Certifificate, Folio and Volume Numbers has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });


									   $('#lc_btn_generate_certificate_number_only').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');

										 if(!lc_txt_type_of_certificate) {
											alert("Please select a certificate type");
											 return;
										 }
								
										 
										 if (confirm("Are you sure to generate certificate as "+lc_txt_type_of_certificate+"?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_generate_certificate_number_only',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_certificate_number_only').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_certificate_number').val(json_p.certificate_number);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 //$('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('Certifificate has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });

									   
									   $('#lc_btn_generate_deed_number_only').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										//var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');

										//  if(!lc_txt_type_of_certificate) {
										// 	alert("Please select a certificate type");
										// 	 return;
										//  }
								
										 
										 if (confirm("Are you sure to generate deed number?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_generate_deed_number_only',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													//type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_deed_number_only').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_deed_number').val(json_p.deed_number);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 //$('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('Deed number has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });

									   

									   $('#lc_btn_generate_ls_number_only').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										//var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');

										
										 if (confirm("Are you sure to generate ls number?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_generate_ls_number_only',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													//type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_ls_number_only').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_ls_number').val(json_p.ls_number);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 //$('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('Land serial number has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });

									   $('#lc_btn_generate_file_number_only').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										//var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');

										
										 if (confirm("Are you sure to generate ls number?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_generate_file_number_only',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													//type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_file_number_only').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_file_number').val(json_p.ls_number);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 //$('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('File number has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });


									   $('#lc_btn_generate_ground_rent_only').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										var lc_txt_ground_rent = $("#lc_txt_ground_rent").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');

										
										 if (confirm("Are you sure to update Ground Rent?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_generate_ground_rent_only',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													registration_district_number:txt_lc_registration_district_number,
													registration_section_number:txt_lc_registration_section_number,
													ground_rent:lc_txt_ground_rent,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_ground_rent_only').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													 $('#lc_txt_ground_rent').val(json_p.ground_rent);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 //$('#lc_txt_folio_number').val(json_p.folio);
													  
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('File number has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });


									   $('#lc_btn_determine_type_of_transfer').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										// var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										// var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										var lc_intended_interest = $("#lc_intended_interest").val();
										var lc_intended_parcel = $("#lc_intended_parcel").val();
										var lc_txt_type_of_transfer = $("#lc_txt_type_of_transfer").val();
										var send_by_id = localStorage.getItem('userid');
										var send_by_name = localStorage.getItem('fullname');
								
										 
										 if (confirm("Are you sure to select application transfer as "+lc_txt_type_of_transfer+"?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_determining_type_of_transfer',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													  // registration_district_number:txt_lc_registration_district_number,
													  // registration_section_number:txt_lc_registration_section_number,
													  lc_intended_parcel:lc_intended_parcel,
													  lc_intended_interest:lc_intended_interest,
													  type_of_transfer :lc_txt_type_of_transfer,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													
								
													if(jobdetails != ""){
														$('#lc_btn_determine_type_of_transfer').prop("disabled", true);


															
														// $('#form_inspection').modal('hide');
														$("#general_message_dialog").modal();
														//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														$('#general_message_dialog #general_message_dialog_msg_new').val('Application transfer type has been updated sucsessfully');
													} else {

														$('#general_message_dialog #general_message_dialog_msg_new').val('Ops! Error occurred!!');
													}
													
													// $('#case_file_number').val(jobdetails);
													// $('#lc_txt_type_of_transfer').val(lc_txt_type_of_transfer);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 //$('#lc_txt_folio_number').val(json_p.folio);
													  
								
												 }
												 }); 
												}
									   //	
									   });

									   $('#lc_btn_generate_volume_folio_number_only').on('click', function(e) { 
										var case_number = $("#cs_main_case_number").val();
										var transaction_number = $("#cs_main_transaction_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										
										var txt_lc_registration_district_number = $("#txt_new_lc_registration_district_number").val();
										var txt_lc_registration_section_number = $("#txt_new_lc_registration_section_number").val();
										var lc_txt_type_of_certificate = $("#lc_txt_type_of_certificate").val();
										   var send_by_id = localStorage.getItem('userid');
										 var send_by_name = localStorage.getItem('fullname');
								
										//  if(!lc_txt_type_of_certificate) {
										// 	alert("Please select a certificate type");
										// 	 return;
										//  }
										 
										 if (confirm("Are you sure to generate Volume and Folio as "+lc_txt_type_of_certificate+"?") == true) {
									
									   //	console.log(id_number);
											 $.ajax({
												 type: "POST",
												 url: "Case_Management_Serv",
												 data: {
													   request_type: 'select_generate_volume_and_folio_number_only',
													 case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
													   registration_district_number:txt_lc_registration_district_number,
													   registration_section_number:txt_lc_registration_section_number,
													type_of_certificate:lc_txt_type_of_certificate,
													   fullname:send_by_name,
													   userid:send_by_id},
												 cache: false,
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												 },
												 success: function(jobdetails) {
													
													console.log(jobdetails);
													var json_p = JSON.parse(jobdetails);
								
													if(jobdetails != ""){
														$('#lc_btn_generate_volume_folio_number_only').prop("disabled", true);
													}
													
													// $('#case_file_number').val(jobdetails);
													// $('#lc_txt_certificate_number').val(json_p.certificate_number);
													// $('#lc_txt_volume_number').val(json_p.volume);
													 $('#lc_txt_folio_number').val(json_p.folio);
													 $('#lc_txt_volume_number').val(json_p.volume);
															
														// $('#form_inspection').modal('hide');
														 $("#general_message_dialog").modal();
														 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
														 $('#general_message_dialog #general_message_dialog_msg_new').val('Certifificate, Folio and Volume Numbers has been generated sucsessfully');
								
												 }
												 }); 
												}
									   //	
									   });
										 
										 

									$('#btn_lc_save_parcel_for_general_noting').on('click', function(e) { 
	   	
										var job_number = $("#cs_main_job_number").val();
									   var case_number = $("#cs_main_case_number").val();
									   var wkt_polygon = $("#lc_bl_wkt_polygon").val() == undefined ? $("#lc_fr_bl_wkt_polygon").val() : $("#lc_bl_wkt_polygon").val();
									   
										var send_by_id = localStorage.getItem('userid');
									 var send_by_name = localStorage.getItem('fullname');
									   
										console.log(job_number,case_number, wkt_polygon, send_by_id, send_by_name );
										  $.ajax({
											  type: "POST",
											  url: "Maps",
											  data: {
													request_type: 'select_save_spatial_objects_undergoing_registration',
													wkt_polygon:wkt_polygon,
													case_number:case_number,
													job_number:job_number},
											  cache: false,
											  beforeSend: function () {
												 // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
											  },
											  success: function(jobdetails) {
												 
												 console.log(jobdetails);
												  //var json_p = JSON.parse(jobdetails);
												 
												 // $('#case_file_number').val(jobdetails);
											 //	alert(jobdetails);
												 $("#general_message_dialog").modal();
												 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
												 $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
									   
											  }
											  }); 
									//	
									});



   $('#lc_btn_generate_interest_number').on('click', function(e) { 
	   	
	var job_number = $("#cs_main_job_number").val();
   var case_number = $("#cs_main_case_number").val();
   
	var send_by_id = localStorage.getItem('userid');
var send_by_name = localStorage.getItem('fullname');
   
//	console.log(id_number);
	  $.ajax({
		  type: "POST",
		  url: "Case_Management_Serv",
		  data: {
				request_type: 'select_generate_interest_number',
				case_number:case_number,
				job_number:job_number,
				fullname:send_by_name,
				userid:send_by_id},
		  cache: false,
		  beforeSend: function () {
			 // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		  },
		  success: function(jobdetails) {
			 
			 console.log(jobdetails);
			  //var json_p = JSON.parse(jobdetails);
			 
			$('#lc_txt_interest_number').val(jobdetails);
			 //alert(jobdetails);
			 $("#general_message_dialog").modal();
			 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
			 $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
   
		  }
		  }); 
//	
});



$('#lc_btn_update_registered_number').on('click', function(e) { 
	   	
	var job_number = $("#cs_main_job_number").val();
   var case_number = $("#cs_main_case_number").val();
   var registered_number = $("#lc_txt_registered_number").val();
	var send_by_id = localStorage.getItem('userid');
var send_by_name = localStorage.getItem('fullname');
   
//	console.log(id_number);
	  $.ajax({
		  type: "POST",
		  url: "Case_Management_Serv",
		  data: {
				request_type: 'select_update_registered_number',
				case_number:case_number,
				job_number:job_number,
				registered_number: registered_number,
				fullname:send_by_name,
				userid:send_by_id},
		  cache: false,
		  beforeSend: function () {
			 // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		  },
		  success: function(jobdetails) {
			 
			 console.log(jobdetails);
			  //var json_p = JSON.parse(jobdetails);
			 
			//$('#lc_txt_interest_number').val(jobdetails);
			 //alert(jobdetails);
			 $("#general_message_dialog").modal();
			 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
			 $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
   
		  }
		  }); 
//	
});

$('#lc_btn_update_date_of_issue').on('click', function(e) { 
	   	
	var job_number = $("#cs_main_job_number").val();
   var case_number = $("#cs_main_case_number").val();
   var date_of_issue = $("#lc_txt_date_of_issue").val();
	var send_by_id = localStorage.getItem('userid');
var send_by_name = localStorage.getItem('fullname');
   
//	console.log(id_number);
	  $.ajax({
		  type: "POST",
		  url: "Case_Management_Serv",
		  data: {
				request_type: 'select_update_date_of_issue',
				case_number:case_number,
				job_number:job_number,
				date_of_issue: date_of_issue,
				fullname:send_by_name,
				userid:send_by_id},
		  cache: false,
		  beforeSend: function () {
			 // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		  },
		  success: function(jobdetails) {
			 
			 console.log(jobdetails);
			  //var json_p = JSON.parse(jobdetails);
			 
			//$('#lc_txt_interest_number').val(jobdetails);
			 //alert(jobdetails);
			 $("#general_message_dialog").modal();
			 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
			 $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
   
		  }
		  }); 
//	
});

$('#btn_send_to_frrv').on('click', function(e) {

	var job_number = $('#send_ffrv_job_number').val();

	$.ajax({
		type : "POST",
		url : "valueadded_services_serv",
		data : {
			request_type : 'process_sent_jobs_for_records_verification',
			job_number : job_number
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
			console
					.log(jobdetails);
			// var json_p =
			// JSON.parse(jobdetails);
			$
					.notify(
							{
								message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Success! Jobs sent to all divisions for frrv/cst <br><br></span>',
							},
							{
								type : 'success', z_index : 9999
							});

		}
	});

});

$('#send_to_frrv').on('shown.bs.modal', function (e) {

	var job_number = $("#cs_main_job_number").val();

	$.ajax({
		type: "POST",
		url: "Case_Management_Serv",
		data: {
			  request_type: 'select_frrv_details_on_job_number',
			 // case_number:case_number,
			  job_number:job_number,
			//   fullname:send_by_name,
			//   userid:send_by_id
			},
		cache: false,
		beforeSend: function () {
		   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		},
		success: function(jobdetails) {
		   
		   console.log(jobdetails);
			//var json_p = JSON.parse(jobdetails);
		   
		//   $('#lc_txt_sub_interest_number').val(jobdetails);
		//    //alert(jobdetails);
		//    $("#general_message_dialog").modal();
		//    //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
		//    $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);

		if(!jobdetails) {
			return;
		}

		var json_p = JSON.parse(jobdetails);

		if(json_p.count > 1){

			$('#btn_send_to_frrv').prop('disabled', true);
		}

		let _html_lrd_badge;
														let _html_smd_badge;
														let _html_pvlmd_badge;

		if(json_p.lrd == 1) {

			_html_lrd_badge = '<span class="badge badge-success">Sent</span'
		} else {
			_html_lrd_badge = '<span class="badge badge-danger">Not Sent</span'
		}

		if(json_p.smd == 1) {

			_html_smd_badge = '<span class="badge badge-success"> Sent</span'
			
		}else {
			_html_smd_badge = '<span class="badge badge-danger">Not Sent</span'
		}

		if(json_p.pvlmd == 1) {

			_html_pvlmd_badge = '<span class="badge badge-success">Sent</span'
			
		}else {
			_html_pvlmd_badge = '<span class="badge badge-danger">Not Sent</span'
		}

		document.getElementById('send_pvlmd_badge_ffrv_v').innerHTML = _html_pvlmd_badge;
														document.getElementById('send_smd_badge_ffrv_v').innerHTML = _html_smd_badge;
														document.getElementById('send_lrd_badge_ffrv_v').innerHTML = _html_lrd_badge;
 
		}
		}); 

});


$('#send_to_records_for_info').on('shown.bs.modal', function (e) {

	var job_number = $("#cs_main_job_number").val();

	$.ajax({
		type: "POST",
		url: "Case_Management_Serv",
		data: {
			  request_type: 'select_records_info_details_on_job_number',
			 // case_number:case_number,
			  job_number:job_number,
			//   fullname:send_by_name,
			//   userid:send_by_id
			},
		cache: false,
		beforeSend: function () {
		   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		},
		success: function(jobdetails) {
		   
		   console.log(jobdetails);
			//var json_p = JSON.parse(jobdetails);
		   
		//   $('#lc_txt_sub_interest_number').val(jobdetails);
		//    //alert(jobdetails);
		//    $("#general_message_dialog").modal();
		//    //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
		//    $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);

		if(!jobdetails) {
			return;
		}

		var json_p = JSON.parse(jobdetails);

		if(json_p.count > 1){

			$('#btn_send_to_frrv').prop('disabled', true);
		}

		let _html_pvlmd_badge;

		if(json_p.lrd == 1) {

			_html_pvlmd_badge = '<span class="badge badge-success">Sent</span'
		} else {
			_html_pvlmd_badge = '<span class="badge badge-danger">Not Sent</span'
		}
		document.getElementById('send_record_info_badge').innerHTML = _html_pvlmd_badge;
 
		}
		}); 

});


$('#lc_btn_generate_sub_interest_number').on('click', function(e) { 
	   	
	var job_number = $("#cs_main_job_number").val();
   var case_number = $("#cs_main_case_number").val();
   
	var send_by_id = localStorage.getItem('userid');
var send_by_name = localStorage.getItem('fullname');
   
//	console.log(id_number);
	  $.ajax({
		  type: "POST",
		  url: "Case_Management_Serv",
		  data: {
				request_type: 'select_generate_sub_interest_number',
				case_number:case_number,
				job_number:job_number,
				fullname:send_by_name,
				userid:send_by_id},
		  cache: false,
		  beforeSend: function () {
			 // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		  },
		  success: function(jobdetails) {
			 
			 console.log(jobdetails);
			  //var json_p = JSON.parse(jobdetails);
			 
			$('#lc_txt_sub_interest_number').val(jobdetails);
			 //alert(jobdetails);
			 $("#general_message_dialog").modal();
			 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
			 $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
   
		  }
		  }); 
//	
});

$('#lc_btn_generate_certificate_number').on('click', function(e) { 
	   	
	var job_number = $("#cs_main_job_number").val();
   var case_number = $("#cs_main_case_number").val();
   var certificate_number = $("#lc_xxx_certificate_number").val();
   
	var send_by_id = localStorage.getItem('userid');
var send_by_name = localStorage.getItem('fullname');
   
//	console.log(id_number);
	  $.ajax({
		  type: "POST",
		  url: "Case_Management_Serv",
		  data: {
				request_type: 'select_update_certificate_number_on_case',
				case_number:case_number,
				job_number:job_number,
				fullname:send_by_name,
				userid:send_by_id,
				certificate_number:certificate_number},
		  cache: false,
		  beforeSend: function () {
			 // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		  },
		  success: function(jobdetails) {
			 
			 console.log(jobdetails);
			  //var json_p = JSON.parse(jobdetails);
			 
			$('#lc_txt_certificate_number').val(jobdetails);
			 //alert(jobdetails);
			 $("#general_message_dialog").modal();
			 //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
			 $('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
   
		  }
		  }); 
//	
});

$('#btn_save_lrd_certificate_update_details')
.on(
		'click',
		function(e) {

		//	console.log('hoe');

		var job_number = $("#cs_main_job_number").val();
        var case_number = $("#cs_main_case_number").val();
   
		var certificate_number = $("#lc_txt_certificate_number").val();
		var volume_number = $("#lc_txt_volume_number").val();
		var folio_number = $("#lc_txt_folio_number").val();
		var certificate_type = $("#lc_txt_type_of_certificate").val();

	    var transaction_number = $("#lc_txt_transaction_number").val();
		

			$
					.ajax({

						type : "POST",
						url : "Case_Management_Serv",
						// target:'_blank',
						data : {
							request_type : 'select_update_title_plan_certificate_details',
							//gid : gid,
							case_number:case_number,
				            job_number:job_number,
							transaction_number : transaction_number,
							certificate_number : certificate_number,
							volume_number : volume_number,
							folio_number : folio_number,
							certificate_type:certificate_type
						},
						cache : false,
						/*
						 * xhrFields:{ responseType:
						 * 'blob' },
						 */
						beforeSend : function() {
							// $('#district').html('<img
							// src="img/loading.gif"
							// alt="" width="24"
							// height="24">');
						},
						success : function(
								jobdetails) {
							console.log(jobdetails);
							alert(jobdetails);
							
						}
					});
		});


		$('#btn_save_lrd_certificate_update_details_')
.on(
		'click',
		function(e) {

		//	console.log('hoe');

		var job_number = $("#cs_main_job_number").val();
        var case_number = $("#cs_main_case_number").val();
   
		var certificate_number = $("#lc_txt_certificate_number_").val();
		// var volume_number = $("#lc_txt_volume_number").val();
		// var folio_number = $("#lc_txt_folio_number").val();
		var certificate_type = $("#lc_txt_type_of_certificate_").val();

	    var transaction_number = $("#cs_main_transaction_number").val();
		

			$
					.ajax({

						type : "POST",
						url : "Case_Management_Serv",
						// target:'_blank',
						data : {
							request_type : 'select_update_title_plan_certificate_details',
							//gid : gid,
							case_number:case_number,
				            job_number:job_number,
							transaction_number : transaction_number,
							certificate_number : certificate_number,
							// volume_number : volume_number,
							// folio_number : folio_number,
							certificate_type:certificate_type
						},
						cache : false,
						/*
						 * xhrFields:{ responseType:
						 * 'blob' },
						 */
						beforeSend : function() {
							// $('#district').html('<img
							// src="img/loading.gif"
							// alt="" width="24"
							// height="24">');
						},
						success : function(
								jobdetails) {
							console.log(jobdetails);
							alert(jobdetails);
							
						}
					});
		});


$('#btn_save_lrd_title_plan_update_details_smd_new_update')
.on(
		'click',
		function(e) {

		console.log('hoe');

		var job_number = $("#cs_main_job_number").val();
   var case_number = $("#cs_main_case_number").val();
   

			var gid = $("#gid_pl_smd").val();
			
			var registry_mapref = $(
					"#txt_lc_registry_mapref_pl_smd")
					.val();
			var size_of_land = $(
					"#txt_lc_size_of_land_pl_smd")
					.val();
			var plan_no = $("#txt_lc_plan_no_pl_smd")
					.val();

			var ltr_plan_no = $("#ltr_plan_no_pl_smd")
					.val();

					var cc_no = $("#txt_cc_no_pl_smd")
					.val();		 

			// var registration_district_number = $(
			// 		"#txt_lc_registration_district_number_pl_smd")
			// 		.val();
			// var registration_section_number = $(
			// 		"#txt_lc_registration_section_number_pl_smd")
			// 		.val();
			// var registration_block_number = $(
			// 		"#txt_lc_registration_block_number_pl_smd")
			// 		.val();
	
	var transaction_number = $(
	"#lc_txt_transaction_number_pl_smd")
	.val();
			

			$
					.ajax({

						type : "POST",
						url : "Case_Management_Serv",
						// target:'_blank',
						data : {
							request_type : 'select_update_title_plan_details_smd',
							gid : gid,
							case_number:case_number,
				            job_number:job_number,
							registry_mapref : registry_mapref,
							size_of_land : size_of_land,
							plan_no : plan_no,
							ltr_plan_no : ltr_plan_no,
							cc_no : cc_no,
							// registration_district_number : registration_district_number,
							// registration_section_number : registration_section_number,
							// registration_block_number : registration_block_number,
							transaction_number : transaction_number
						},
						cache : false,
						/*
						 * xhrFields:{ responseType:
						 * 'blob' },
						 */
						beforeSend : function() {
							// $('#district').html('<img
							// src="img/loading.gif"
							// alt="" width="24"
							// height="24">');
						},
						success : function(
								jobdetails) {
							console.log(jobdetails);
							alert(jobdetails);
							
						}
					});
		});




							   

					$("#btn_upload_georeferenced_images_to_server")
							.click(
									function(event) {

										// var job_number =
										// $("#cs_main_job_number").val();

										$
												.ajax({
													type : "POST",
													url : "LoadGeotiffToGeoserver",
													data : {
														request_type : 'load_lrd_geotiff_path'

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
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(jobdetails);

													}

												});

										// $('#smartwizardfirstregistration').smartWizard("next");

										return true;
									});

					$('#new_bill_application_region')
							.change(
									function() {

										// var region_id = $(this).find(
										// 		':selected').attr('data-id');

												//var region_id = $(this).val();
												// var region_id = $(this).find(
												// 	':selected').attr('data-id');

												var sub_service = $(this).val();

										const
										sub_service_name_id = sub_service
												.split('-');

										var main_service_id = sub_service_name_id[0];
										var main_service_name = sub_service_name_id[1];

										console.log(main_service_id);
										//console.log(main_service_name);
										main_service_id = main_service_id
										.replace('.0', '');

										//  console.log("seleted gerion: " +  region_id);
										// //
										// region_id = region_id.replace('.0', '');

										// var region_id = ""

										// 		console.log(typeof main_service_id)

										// 		switch (parseInt(main_service_id)) {
										// 			case 11:
										// 				region_id = 5;
										// 			  	break;
										// 			case 10:
										// 				region_id = 5;
										// 				break;
										// 			case 14:
										// 				region_id = 10;
										// 				break;
										// 			case 15:
										// 				region_id = 3;
										// 				break;
										// 			case 18:
										// 				region_id = 6;
										// 				break;
										// 			case 20:
										// 				region_id = 2;
										// 				break;
										// 			case 17:
										// 				region_id = 7;
										// 				break;
										// 			case 16:
										// 				region_id = 8;
										// 				break;
										// 			case 19:
										// 				region_id = 9;
										// 				break;
										// 			case 12:
										// 				region_id = 4;
										// 				break;
										// 			case 13:
										// 				region_id = 1;
										// 				break;
										// 			case 21:
										// 				region_id = 21;
										// 				break;
										// 			case 22:
										// 				region_id = 22;
										// 				break;
										// 			case 23:
										// 				region_id = 23;
										// 				break;
										// 			case 24:
										// 				region_id = 24;
										// 				break;
										// 			case 25:
										// 				region_id = 25;
										// 				break;
										// 			case 26:
										// 				region_id = 26;
										// 		}

										// 		console.log(region_id);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_list_of_district',
														region_id : main_service_id
													},
													cache : false,
													
													success : function(
															jobdetails) {

														var select = $("#party_ar_district_gen");
														var select2 = $("#new_bill_application_district");
														select.empty();
														select2.empty();

														// console.log("District:
														// " + jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$(json_p)
																.each(
																		function() {
																			
																			select2
																					.append('<option value="'
																							+ this.district_name
																							+ '">'
																							+ this.district_name
																							+ '</option>');

																			/*
																			 * select.append("<tr><td>"
																			 * +this.officers_general_comments + "</td><td>"
																			 * +this.division + "</td><td>"
																			 * +this.created_by + "</td><td>"
																			 * +this.created_date +'</tr>');
																			 */

																		});

													}
												});


												// $
												// .ajax({
												// 	type : "POST",
												// 	url : "Case_Management_Serv",
												// 	data : {
												// 		request_type : 'get_list_of_locality',
												// 		region_id : main_service_id
												// 	},
												// 	cache : false,
												// 	beforeSend : function() {
												// 		// $('#district').html('<img
												// 		// src="img/loading.gif"
												// 		// alt="" width="24"
												// 		// height="24">');
												// 	},
												// 	success : function(
												// 			jobdetails) {

												// 		 //console.log(jobdetails);
												// 		var json_p = JSON
												// 				.parse(jobdetails);
												// 		var options = $("#new_bill_application_locality");

												// 		// var options =
												// 		// $("#selector");
												// 		options.empty();
												// 		options
												// 				.append(new Option(
												// 						"-- Select --",
												// 						0));

												// 		$(json_p)
												// 				.each(
												// 						function() {

												// 							$(
												// 									'#new_bill_application_locality')
												// 									.append(
												// 											'<option value="'

												// 													+ this.location_name
												// 													+ '">'
												// 													+ this.location_name
												// 													+ '</option>');

												// 						});
												// 		// business_process_id
												// 	}
												// });

									});

					$('#viewFinancialReportModal').on(
							'show.bs.modal',
							function(event) {
								var report_type = $(event.relatedTarget).data(
										'report_type') // Extract
								// info
								// from
								// data-*
								// attributes

								console.log(report_type);
								$("#report-modal-title-financial").empty();
								$("#report-modal-title-financial").html(
										report_type);

							});

					/*
					 * =========================================== Actions for
					 * ReceivedReportModal ==================
					 */
					$('#viewReceivedReportModal').on(
							'show.bs.modal',
							function(event) {
								var report_type = $(event.relatedTarget).data(
										'report_type') // Extract
								// info
								// from
								// data-*
								// attributes

								console.log(report_type);
								$("#report-modal-title-received").empty();
								$("#report-modal-title-received").html(
										report_type);

							});

					/*
					 * =========================================== Actions for
					 * CompletedReportModal ==================
					 */
					$('#viewCompletedReportModal').on(
							'show.bs.modal',
							function(event) {
								var report_type = $(event.relatedTarget).data(
										'report_type') // Extract
								// info
								// from
								// data-*
								// attributes

								console.log(report_type);
								$("#report-modal-title-completed").empty();
								$("#report-modal-title-completed").html(
										report_type);

							});

					// Select row table
					$('#publishedDataTable tbody, #job_detailsdataTable tbody')
							.on(
									'click',
									'tr',
									function() {
										var $row = $(this), isSelected = $row
												.hasClass('selected')
										$row.toggleClass('selected').find(
												':checkbox').prop('checked',
												!isSelected);

										$('#selectAll').prop('checked', false);

									});
					// select all in table
					$("#selectAll")
							.on(
									"click",
									function() {
										if ($(this).prop("checked") == true) {
											$(
													'#job_casemgtdetailsdataTableCS tbody tr, #job_batchedtouserlistdataTable tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_casemgtdetailsdataTableCSAU tbody tr, #job_casemgtdetailsdataTable_cst tbody tr, #job_casemgtdetailsdataTable_frrv tbody tr, #job_casemgtdetailsdataTable_elis_reports tbody tr, #job_casemgtdetailsdataTable__supervisor_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv tbody tr, #job_casemgtdetailsdataTable_tpp tbody tr, #job_casemgtdetailsdataTable__supervisor_tpp tbody tr, #job_detailsdataTable tbody tr, #publishedDataTable tbody tr, #job_casemgtdetailsdataTable_frrv_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv_cst tbody tr')
													.addClass('selected');

													$("#allBatchList").removeClass("d-none");
													
										} else {
											$(
													'#job_casemgtdetailsdataTableCS tbody tr, #job_batchedtouserlistdataTable tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_casemgtdetailsdataTableCSAU tbody tr, #job_casemgtdetailsdataTable_cst tbody tr, #job_casemgtdetailsdataTable_frrv tbody tr, #job_casemgtdetailsdataTable_elis_reports tbody tr, #job_casemgtdetailsdataTable__supervisor_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv tbody tr, #job_casemgtdetailsdataTable_tpp tbody tr, #job_casemgtdetailsdataTable__supervisor_tpp tbody tr, #job_detailsdataTable tbody tr, #publishedDataTable tbody tr, #job_casemgtdetailsdataTable_frrv_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv_cst tbody tr')
													.removeClass('selected');

													$("#allBatchList").addClass("d-none");
										}

										$(
												"#job_casemgtdetailsdataTableCS tbody tr, #job_batchedtouserlistdataTable tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_casemgtdetailsdataTableCSAU tbody tr, #job_casemgtdetailsdataTable_cst tbody tr, #job_casemgtdetailsdataTable_frrv tbody tr, #job_casemgtdetailsdataTable_elis_reports tbody tr, #job_casemgtdetailsdataTable__supervisor_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv tbody tr, #job_casemgtdetailsdataTable_tpp tbody tr, #job_casemgtdetailsdataTable__supervisor_tpp tbody tr, #job_detailsdataTable tbody tr, #publishedDataTable tbody tr, #job_casemgtdetailsdataTable_frrv_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv_cst tbody tr")
												.find(":checkbox")
												.prop('checked',
														$(this).prop('checked'));

									});
					
					/*$("#job_casemgtdetailsdataTable__supervisor_cst tbody tr").on('click', function(e){
						console.log("hello: " );
					});*/
					
					
					
					$('.data-table').DataTable({
						stateSave : true
					});
					$('[data-toggle="tooltip"]').tooltip();
					/*
					 * var $j = jQuery.noConflict();
					 * $j(".datepicker").datepicker();
					 */
					/*
					 * $("#fe_commencement_date, #fe_date_of_document,
					 * .date-picker").flatpickr( );
					 */

					if (localStorage.getItem('user_level') < 2) {
						$('.btn_Update_existing_milestone').hide();
						$('.to_hide_on_level_1').hide();
						$('.to_hide_on_level_2').show();
						// $('#btn_add_public_document').hide();
					} else {
						$('.btn_Update_existing_milestone').show();
						$('.to_hide_on_level_1').show();
						$('.to_hide_on_level_2').hide();
					}

					if (localStorage.getItem('user_level') < 3) {
						$('.to_show_on_level_3').addClass('d-none');
						// $('#btn_add_public_document').hide();
					} else {
						$('.to_show_on_level_3').removeClass('d-none');
					}

					if ($('#work-header').length
							&& $('#work-header')
									.html()
									.includes(
											"APPLICATION FOR STAMPING(FINANCIAL DOCUMENTS)")) {
						// console.log("testign innner");
						$("#assessed_value").prop('readonly', false);
						$("#stamp_duty").prop('readonly', false);
					}

					// $(document).ready(function(){

					/*
					 * =========================================== Actions for
					 * InspectionModal ==================
					 */
					$('#form_inspection')
							.on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget) // Button
										// that
										// triggered
										// the modal
										var recipient = button.data('action') // Extract
										// info
										// from
										// data-* attributes
										// If necessary, you could initiate an
										// AJAX request here
										// (and then do the updating in a
										// callback).
										// Update the modal's content. We'll use
										// jQuery here, but
										// you could use a data binding library
										// or other methods
										// instead.
										var modal = $(this)
										if (recipient == 'edit') {
											modal
													.find(
															'.modal-body #action_on_form_valuation')
													.val(recipient)
											modal
													.find('.modal-title')
													.text(
															recipient
																	.toUpperCase()
																	+ " "
																	+ modal
																			.find(
																					'.modal-title')
																			.text()
																			.toUpperCase())

											// Get the objection data for
											// editing
											/*
											 * $.ajax({ type: "POST", url:
											 * "Case_Management_Serv", data: {
											 * request_type:
											 * 'update_stamp_duty_records',
											 * job_number:job_number }, cache:
											 * false, beforeSend: function () {
											 * //$('#district').html('<img
											 * src="img/loading.gif" alt=""
											 * width="24" height="24">'); },
											 * success: function(jobdetails) {
											 * console.log(jobdetails) var
											 * result = JSON.parse(jobdetails);
											 * if(result.data=='Success'){
											 * //Load all Objection data into
											 * form } }
											 */
										}

									});

					$('#form_inspection')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('form submited Clicked');

										var case_number = $("#in_case_number")
												.val();
										console.log(case_number);
										var job_number = $("#in_job_number")
												.val();
										console.log(job_number);

										var inspection_date = $(
												"#in_inspection_date").val();
										console.log(inspection_date);
										var inspection_purpose = $(
												"#in_inspection_purpose").val();
										console.log(inspection_purpose);
										var development_level = $(
												"#in_development_level").val();
										console.log(development_level);
										var possession_person = $(
												"#in_possession_person").val();
										console.log(possession_person);
										var neighborhood_description = $(
												"#in_neighborhood_description")
												.val();
										console.log(neighborhood_description);
										var neighbor_names = $(
												"#in_neighbor_names").val();
										console.log(neighbor_names);
										var ground_opinion = $(
												"#in_ground_opinion").val();
										console.log(ground_opinion);
										var created_by = $("#in_modified_by")
												.val();
										console.log(created_by);
										var created_by_id = $(
												"#in_modified_by_id").val();
										console.log(created_by_id);

										var userid_1 = $("#requested_by").val(); // $(
										// "#user_to_send_to
										// option:selected"
										// ).text();
										var requested_by_id = $(
												'#listofusers option')
												.filter(
														function() {
															return this.value == userid_1;
														}).data('id');
										var requested_by = $(
												'#listofusers option')
												.filter(
														function() {
															return this.value == userid_1;
														}).data('name');

										console.log(requested_by);
										console.log(requested_by_id);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'insert_update_on_lc_inspection_reports',
														job_number : job_number,
														case_number : case_number,
														requested_by_id : requested_by_id,
														requested_by : requested_by,
														inspection_date : inspection_date,
														inspection_purpose : inspection_purpose,
														development_level : development_level,
														possession_person : possession_person,
														neighbor_names : neighbor_names,
														ground_opinion : ground_opinion,
														/*
														 * created_by
														 * :created_by,
														 * created_by_id :
														 * created_by_id,
														 */
														neighborhood_description : neighborhood_description

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

														$('#form_inspection')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(jobdetails);

														/*
														 * var result =
														 * JSON.parse(jobdetails);
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' + '<strong>Success!</strong>
														 * Inspection Report
														 * saved successfully</div>';
														 * if(result.data=='Success'){ $(
														 * "#alert-display-space"
														 * ).append( alert_mess ); }
														 */
													},
													error : function(err) {
														console.log(err);
													}

												});
									});

					// ============================================= End Actions
					// for iNSPECTION
					// ===============================================

					// ============================================= End Actions
					// for
					// Note and Reports
					// ===============================================
					$('#addNotesModal').on(
							'show.bs.modal',
							function(event) {
								// e.preventDefault();
								var an_id = $(event.relatedTarget).data(
										'target-id') // Extract
								var note_edit = $(event.relatedTarget).data(
									'note_edit')
								if (an_id > 0) {
									$("#an_id").val(am_id);
									// console.log("test am" + am_id);
									$("#an_description").val(
											$(event.relatedTarget).data(
													'an_description'));
									$("#an_created_by").val(
											$(event.relatedTarget).data(
													'created_by'));
									$("#an_created_date").val(
											$(event.relatedTarget).data(
													'created_date'));
									$("#an_modified_by").val(
											$(event.relatedTarget).data(
													'modified_by'));
									$("#an_modified_date").val(
											$(event.relatedTarget).data(
													'modified_date'));

									if ($(event.relatedTarget).data(
											'created_by') !== "${fullname}") {
										$("#btn_add_notes").hide();
									}

									if(note_edit == 1) {
										document.getElementById('an_description').readOnly = true;
									} else {
										document.getElementById('an_description').readOnly = false;
									}

									// hide others
									$(".list-to-hide").show();

								} else {
									$("#btn_add_notes").show();
									$(".list-to-hide").hide();

									// clear form
									$("#an_id").val("0");
									$("#an_description").val("");
									$("#an_created_by").val("");
									$("#an_created_date").val("");
									$("#an_modified_by").val("");
									$("#an_modified_date").val("");

								}

							});

					$('#form_add_notes')
							.on(
									'submit',
									function(e) {
										// validation code here
										e.preventDefault();
										// console.log('form submited Clicked');
										var an_id = $("#an_id").val();
										var an_case_number = $(
												"#an_case_number").val();
										var an_job_number = $("#an_job_number")
												.val();
										var an_description = $(
												"#an_description").val();
										var an_type = $("#an_type").val();

										/*
										 * console.log(an_case_number);
										 * console.log(an_job_number);
										 * console.log(an_description);
										 */

										// console.log('form submited Clicked');
										$
												.ajax({
													type : "POST",
													url : "lc_application_minutes_serv",

													data : {
														request_type : "select_lc_application_notes_add_and_update",
														an_id : an_id,
														an_case_number : an_case_number,
														an_job_number : an_job_number,
														an_description : an_description,
														an_type : an_type,

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
														// console.log(jobdetails)

														$('#addNotesModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		'Success!! Note has been added Successfully. Refresh page to see it in the list');

													}

												});
										return false;
									});

					// ============================================= End Actions
					// for Note
					// ===============================================

					$('#btn_assign_inspection')
							.on(
									'click',
									function(e) {
										// validation code here
										e.preventDefault();
										// console.log('form submited Clicked');

										var job_number = $(
												"#cs_main_job_number").val();
										var case_number = $(
												"#cs_main_transaction_number")
												.val();
										var purpose_of_inspection = $(
												"#purpose-of-inspection").val();
										var userid_1 = $("#in_user_to_send_to")
												.val(); // $(
										// "#user_to_send_to
										// option:selected"
										// ).text();
										var assigned_to_id = $(
												'#in_listofusers option')
												.filter(
														function() {
															return this.value == userid_1;
														}).data('id');
										var assigned_to = $(
												'#in_listofusers option')
												.filter(
														function() {
															return this.value == userid_1;
														}).data('name');

										/*
										 * console.log("case :" + case_number);
										 * console.log("job :" + job_number);
										 * console.log("purposr :" +
										 * purpose_of_inspection);
										 * 
										 * console.log("userid_1 :" + userid_1);
										 * console.log("sender :" +
										 * assigned_to); console.log("sender_id :" +
										 * assigned_to_id);
										 */

										/*var assigned_by = localStorage
												.getItem("fullname");
										var assigned_by_id = localStorage
												.getItem("userid");*/

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'assign_inspection_case_to_officer',
														case_number : case_number,
														job_number : job_number,
														purpose_of_inspection : purpose_of_inspection,
														assigned_to : assigned_to,
														assigned_to_id : assigned_to_id,
														
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
														// var result =
														// JSON.parse(jobdetails);
														/*
														 * var alert_mess = '<div
														 * class="alert
														 * alert-success fade
														 * show" id="bsalert">' ;
														 * alert_mess =
														 * alert_mess + '<a
														 * href="#"
														 * class="close"
														 * data-dismiss="alert"
														 * aria-label="close">&times;</a>' ;
														 * alert_mess =
														 * alert_mess + '<strong>Success!</strong>
														 * Assessment Values
														 * saved successfully</div>';
														 */
														console
																.log("jobdetails :"
																		+ jobdetails);

														// if(jobdetails ===
														// "Success"){
														// $(
														// "#alert-display-space2"
														// ).append( 'ood' );
														$(
																'#assignInspectionModal')
																.modal('hide');
														$(
																"#general_message_dialog")
																.modal();
														// $('#general_message_dialog
														// #general_message_dialog_msg').val(jobdetails);
														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(
																		"Assinging Inspection to to user! "
																				+ jobdetails);

														// }
													},
													error : function(request) {
														alert("Request falied");
													}
												});
									});

					$(".viewBillModalBtn")
							.on(
									"click",
									function(event) {
										// var button = $(event.relatedTarget)
										// // Button that triggered the
										// modal

										$("#egcr_container_btn").attr(
												'disabled', 'disabled');
										var ref_number = $(this).data(
												"ref_number");
										var egcr_id = $(this).data("egcr_id");

										var request = new XMLHttpRequest();
										// var params =
										// '{"agencyUniqueReference":
										// "LC0003","receiptDescription": "Stamp
										// duty","recipientName": "Kofi
										// Ghana","recipientEmail":
										// "kofi.ghana@gmail.com","recipientPhone":
										// "0242012137", "amount":
										// "165.5","receiptType":
										// "LC-GEN","receivedBy": "Joe
										// Bloggs"}';
										// request.responseType = 'blob';
										request.onreadystatechange = function() {
											loadingOverlay().cancel(spinHandle);
											if (this.readyState == 4
													&& this.status == 200) {
												var blob = new Blob(
														[ this.response ],
														{
															type : "application/pdf"
														});
												var objectUrl = URL
														.createObjectURL(blob);
												$('#egcrblobfile').attr('src',
														objectUrl);
												window.open(objectUrl);
											}
										};
										request.onloadstart = function() {
											console.log("loadni");
											spinHandle = loadingOverlay()
													.activate();
										};
										request.onerror = function() {
											loadingOverlay().cancel(spinHandle);
										}
 
										request
												.open(
														'GET',
														'http://localhost:8080/gelis_online_service_live/rest/lc_official_receipt_service/generate_egcr_pdf_only/'
																+ ref_number,
														true);
										request.responseType = 'blob';
										request.setRequestHeader(
												"Content-type",
												"application/json");
										request.send();

									});

					$('#btn_clear_all_batchlist')
							.on(
									'click',
									function(e) {

										var confirmText = "Are you sure you want to remove all applications from list? Note that this cannot be undone";
										if (confirm(confirmText)) {

											localStorage
													.removeItem('batchlistdata');
											prepareBatchlistModal();
										}

									});

					$('#btnCompleteJobtpp_we')
							.on(
									'click',
									function(e) {
										// validation code here
										// e.preventDefault();
										// console.log('form submited Clicked');
										let
										vr_comp_msg = '';
										let
										vr_ask_msg = '';
										// console.log('form submited Clicked');
										var type_of_work_completed = $(
												"#vr_job_status_tpp").val();
										if (type_of_work_completed == "7") {
											vr_request_type = 'select_approve_job_note_tpp_sealed'
											vr_comp_msg = 'Application Successfully Updated and Forwarded to Cordinator';
											vr_ask_msg = 'Are you sure you want to set this job as work completed and forwarded to Cordinator';
										} else {
											vr_request_type = 'select_update_application_as_work_done_tpp'
											vr_comp_msg = 'Application Successfully Updated and Forwarded to Unit Head';
											vr_ask_msg = 'Are you sure you want to set this job as work completed and forwarded to Unit Head';
										}
										bootbox
												.confirm({
													title : "Action confrimation!",
													message : vr_ask_msg,
													buttons : {
														cancel : {
															label : '<i class="fa fa-times"></i> Cancel'
														},
														confirm : {
															label : '<i class="fa fa-check"></i> Confirm'
														}
													},
													callback : function(result) {
														if (result) {

															var job_number = $(
																	"#cs_main_job_number")
																	.val();
															var ar_name = $(
																	"#cs_main_ar_name")
																	.val();
															var business_process_sub_name = $(
																	"#cs_main_business_process_sub_name")
																	.val();
															var job_purpose = "Work Completed";

															// console.log(type_of_work_completed)

															// var
															// vr_request_type =
															// null;

															console
																	.log(vr_request_type)

															$
																	.ajax({
																		type : "POST",
																		url : "Case_Management_Serv",
																		data : {
																			request_type : vr_request_type,
																			job_number : job_number
																		},
																		cache : false,

																		success : function(
																				jobdetails) {

																			console
																					.log(jobdetails)
																			try {
																				var json_p = JSON
																						.parse(jobdetails);
																				if (json_p.data == "Success") {
																					$(
																							"#general_message_dialog")
																							.modal();
																					$(
																							'#general_message_dialog #general_message_dialog_msg_new')
																							.val(
																									vr_comp_msg);
																				} else {
																					$(
																							"#general_message_dialog")
																							.modal();
																					$(
																							'#general_message_dialog #general_message_dialog_msg_new')
																							.val(
																									'Error Loading data!! ');
																				}
																				addJobToCompletedQueriedList(
																						job_number,
																						ar_name,
																						business_process_sub_name,
																						job_purpose);
																			} catch (e) {

																			}

																			// push
																			// to
																			// storage

																			/*
																			 * setTimeout(
																			 * function() {
																			 * window.history
																			 * .go(-1) },
																			 * 3000);
																			 */

																		}

																	});
															// return false;

														}
													}
												});

									});

					$('#btnApproveJobtpp_we')
							.on(
									'click',
									function(e) {

										// console.log('clicked me');
										var job_number = $(this).data(
												'job_number');

										// console.log('clicked me ' +
										// job_number);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'select_approve_job_note_tpp',
														job_number : job_number

													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log("jobdetails
														// :" +
														// jobdetails);

														console.log(jobdetails)

														if (jobdetails
																.includes("Success")) {
															$(
																	"#general_message_dialog")
																	.modal();
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			"Title Plan Approved and Forwarded for Vetting and Signing");

														} else {
															$(
																	"#general_message_dialog")
																	.modal();
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			"Error ! Something went wrong"
																					+ jobdetails);
														}

														var job_number = $(
																"#cs_main_job_number")
																.val();
														var ar_name = $(
																"#cs_main_ar_name")
																.val();
														var business_process_sub_name = $(
																"#cs_main_business_process_sub_name")
																.val();
														var job_purpose = "Work Completed";

														addJobToCompletedQueriedList(
																job_number,
																ar_name,
																business_process_sub_name,
																job_purpose);

													},
													error : function(request) {
														alert("Request falied");
													}
												});

									});

					$('#btnApproveJobtpp_signed_we')
							.on(
									'click',
									function(e) {

										// console.log('clicked me');
										var job_number = $(this).data(
												'job_number');

										// console.log('clicked me ' +
										// job_number);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'select_approve_job_note_tpp_signed',
														job_number : job_number

													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log("jobdetails
														// :" +
														// jobdetails);
														if (jobdetails
																.includes("Success")) {
															$(
																	"#general_message_dialog")
																	.modal();
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			"Title Plan Signed and Forwarded for Sealing ans Scanning");

														} else {
															$(
																	"#general_message_dialog")
																	.modal();
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			"Error ! Something went wrong"
																					+ jobdetails);
														}

														var job_number = $(
																"#cs_main_job_number")
																.val();
														var ar_name = $(
																"#cs_main_ar_name")
																.val();
														var business_process_sub_name = $(
																"#cs_main_business_process_sub_name")
																.val();
														var job_purpose = "Work Completed";

														addJobToCompletedQueriedList(
																job_number,
																ar_name,
																business_process_sub_name,
																job_purpose);

													},
													error : function(request) {
														alert("Request falied");
													}
												});

									});

					// ============================================= End Actions
					// for iNSPECTION
					// ===============================================

					/*
					 * $(document).on('click', 'input[name="interaction_type"]',
					 * function() { alert($(this).val()); });
					 */

					$('#btnupdateCaseDetailsForCertificate')
							.on(
									'click',
									function(e) {
										var case_number = $("#fe_case_number")
												.val();
										var transaction_number = $(
												"#fe_transaction_number").val();
										// var annual_rent =
										// $("#fe_annual_rent").val();
										var commencement_date = $(
												"#fe_commencement_date").val();
											var date_of_registration = $(
												"#fe_date_of_registration").val();
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
				

										var date_of_issue = $("#fe_date_of_issue").val();
										
										var registered_number = $("#fe_registered_number").val();
										
										var certificate_type = $("#fe_certificate_type").val();
										

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
														date_of_registration:date_of_registration,
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
														certificate_type:certificate_type,
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

					function showSuggestions(job_number) {

						$
								.ajax({
									type : "POST",
									url : "Case_Management_Serv",
									data : {
										request_type : 'select_load_details_for_batching',
										job_number : job_number
									},
									cache : false,
									beforeSend : function() {
										// $('#district').html('<img
										// src="img/loading.gif" alt=""
										// width="24" height="24">');
									},
									success : function(jobdetails) {

										var json_p = JSON.parse(jobdetails);

										// var json_p_details =
										// JSON.parse(json_p.jobdetails);
										// console.log(json_p_details)
										$('#edit #bl_job_number').val(
												json_p.jobdetails.job_number);
										$('#edit #bl_jn_id').val(
												json_p.jobdetails.jn_id);
										$('#edit #bl_ar_name').val(
												json_p.jobdetails.ar_name);

										$('#edit #bl_business_process_sub_name')
												.val(
														json_p.jobdetails.business_process_sub_name);

										var result = $('#result');
										result.html('');

									
										$(json_p.milestones)
												.each(
														function() {
															

															result
																	.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="'
																			+ this.ms_id
																			+ '" data-value="'
																			+ this.milestone_description
																			+ '" /> '
																			+ this.milestone_description
																			+ '</label>  </div>');
														});

									}
								});

					}

					$("#tbl_transactions_stp_result").DataTable(
							{
								dom : 'Bfrtip',
								buttons : [ 'pageLength', 'copy', 'csv',
										'excel', 'pdf', 'print' ]
							});

					$('#btn_compose_register_description')
							.on(
									'click',
									function(e) {
										var job_number = $(
												"#cs_main_job_number").val();
										var case_number = $(
												"#cs_main_transaction_number")
												.val();
										var business_process_sub_name = $(
												"#cs_main_business_process_sub_name")
												.val();

												var confirmText = "Are you sure you want to compose?";
										if (confirm(confirmText)) {


										$
												.ajax({
													type : "POST",
													url : "GenerateCaseReports",
													// target:'_blank',
													data : {
														request_type : 'request_to_compose_register_description',
														job_number : job_number,
														case_number : case_number,
														business_process_sub_name : business_process_sub_name,
														cert_type : 'consent_certificate'
													},
													cache : false,

													beforeSend : function() {

													},
													success : function(
															jobdetails) {
																$("#lc_description_of_land_lrd").val(jobdetails);
														//$('#lc_description_of_land_lrd').summernote('code','<ol><li>'+ jobdetails+ '</li></ol>');

														alert('Report New Composed Successfully')

													}
												});
											}
									});

							$('#btn_compose_register_description_2')
							.on(
									'click',
									function(e) {
										var job_number = $(
												"#cs_main_job_number").val();
										var case_number = $(
												"#cs_main_transaction_number")
												.val();
										var business_process_sub_name = $(
												"#cs_main_business_process_sub_name")
												.val();

												var confirmText = "Are you sure you want to compose?";
												if (confirm(confirmText)) {
		
		

										$
												.ajax({
													type : "POST",
													url : "GenerateCaseReports",
													// target:'_blank',
													data : {
														request_type : 'request_to_compose_register_description',
														job_number : job_number,
														case_number : case_number,
														business_process_sub_name : business_process_sub_name,
														cert_type : 'consent_certificate'
													},
													cache : false,

													beforeSend : function() {

													},
													success : function(
															jobdetails) {
																$("#lc_description_of_land_lrd_2").val(jobdetails);
														//$('#lc_description_of_land_lrd_2').summernote('code','<ol><li>'+ jobdetails+ '</li></ol>');

														alert('Report New Composed Successfully')

													}
												});

											}
									});

									// $("#btn_csd_save_details").click(function(event) {

									// 	var mc_job_number = $(
									// 			'#csd_job_number')
									// 			.val();
									// 	var job_number = $(
									// 			"#cs_main_job_number").val();
									// 	var case_number = $(
									// 			"#cs_main_case_number").val();
									// 	var mc_certificate_number = $(
									// 			"#csd_certificate_number")
									// 			.val();

									// 	$
									// 			.ajax({
									// 				type : "POST",
									// 				url : "Case_Management_Serv",
									// 				// target : '_blank',
									// 				data : {
									// 					request_type : 'lc_certificate_search_relation_details_add_update',
									// 					mc_job_number : mc_job_number,
									// 					job_number : job_number,
									// 					case_number : case_number,
									// 					mc_certificate_number : mc_certificate_number
									// 				},
									// 				cache : false,

									// 				success : function(
									// 						jobdetails) {
									// 					// console.log(jobdetails);
									// 					alert(jobdetails);

									// 				}
									// 			});

									// });


									$('#add_intended_interest_and_parcel_to_transaction')
									.on(
											'click',
											function(e) {
		
												var job_number = $(
														"#ip_job_number").val();
												var case_number = $(
														"#ip_case_number").val();
												var intended_land = $(
													"#lc_intended_land")
													.val();
												var intended_interest = $(
													"#lc_intended_interest")
													.val();
		
												console.log(job_number, case_number);
												$
														.ajax({
															type : "POST",
															url : "Case_Management_Serv",
															data : {
																request_type : 'select_add_intended_interest_and_parcel_to_transfer',
																//search_report : search_report,
																case_number : case_number,
																job_number : job_number,
																intended_land: intended_land,
																intended_interest: intended_interest
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
		
																var result = JSON.parse(jobdetails) 

																if(result.success == true) {
																	alert("Transfer updated successfully.")
																} else {
																	alert("Error! Updating failed.")
																}
		
															}
														});
												//	
											});



						$('#lc_btn_save_search_report_cs').on('click', function(e) { 

							var job_number = $("#cs_main_job_number").val();
							var case_number = $("#cs_main_case_number").val();
							var search_report = $("#lc_search_report_summary_details_cs").val();
								$.ajax({
									type: "POST",
									url: "Case_Management_Serv",
									data: {
										request_type: 'online_select_update_search_summary',
										search_report:search_report,
										case_number:case_number,
										job_number:job_number},
									cache: false,
									beforeSend: function () {},
									success: function(jobdetails) {
										
										console.log(jobdetails);
										$("#general_message_dialog").modal();
										//$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
										$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
									}
									}); 
						});

						$('#lc_btn_activate_final_concurrence_certificate_cs').on('click', function(e) {
							var job_number = $("#cs_main_job_number").val();
							var case_number = $("#cs_main_case_number").val();
							  var transaction_number = $("#cs_main_transaction_number").val();
							var registration_district_number = $("#txt_lc_registration_district_number").val();
							var registration_section_number = $("#txt_lc_registration_section_number").val();
							var type_of_certificate = $('#lc_txt_type_of_certificate').find(":selected").text() == "Land Certificate" ? "LAND CERTIFICATE" : $('#lc_txt_type_of_certificate').find(":selected").text();
			
							// console.log(job_number);
							// console.log(case_number);
							// console.log(transaction_number);
							
							  $.ajax({
								   type: "POST",
								   url: "GenerateCaseReports",
								  // target:'_blank',
								   data: {
										  request_type: 'request_to_generate_certificate',
										   job_number:job_number,
										   case_number:case_number,
										transaction_number:transaction_number,
										   cert_type:'CONCURRENCE',
										   registration_district_number:registration_district_number,
										   registration_section_number:registration_section_number,
										type_of_certificate: type_of_certificate.trim()  		                 	
								   },
								   cache: false,
								  xhrFields:{
									  responseType: 'blob'
								  },
								   beforeSend: function () { },
								   success: function(jobdetails) {
									   console.log(jobdetails);
									  var blob = new Blob([jobdetails], {type: "application/pdf"});
									  var objectUrl = URL.createObjectURL(blob);
									window.open(objectUrl);
										
								   }
								   }); 
						   });
					   

						   $('#lc_btn_generate_certificate_of_registration_of_instrument').on('click', function(e) {
							var job_number = $("#cs_main_job_number").val();
							var case_number = $("#cs_main_case_number").val();
							  var transaction_number = $("#cs_main_transaction_number").val();
							var registration_district_number = $("#txt_lc_registration_district_number").val();
							var registration_section_number = $("#txt_lc_registration_section_number").val();
							var type_of_certificate = $('#lc_txt_type_of_certificate').find(":selected").text() == "Land Certificate" ? "LAND CERTIFICATE" : $('#lc_txt_type_of_certificate').find(":selected").text();
			
							console.log(type_of_certificate);
							
							  $.ajax({
								   type: "POST",
								   url: "GenerateCaseReports",
								  // target:'_blank',
								   data: {
										  request_type: 'request_to_generate_certificate',
										   job_number:job_number,
										   case_number:case_number,
										transaction_number:transaction_number,
										   cert_type:'CERTIFICATE_FOR_REGISTRATION_OF_INSTRUMENT',
										   registration_district_number:registration_district_number,
										   registration_section_number:registration_section_number,
										type_of_certificate: type_of_certificate.trim()  		                 	
								   },
								   cache: false,
								  xhrFields:{
									  responseType: 'blob'
								  },
								   beforeSend: function () { },
								   success: function(jobdetails) {
									   console.log(jobdetails);
									  var blob = new Blob([jobdetails], {type: "application/pdf"});
									  var objectUrl = URL.createObjectURL(blob);
									window.open(objectUrl);
										
								   }
								   }); 
						   });

						   $('#btn_process_complete_milestone').on('click', function(e) {
							var job_number = $("#cs_main_job_number").val();
							var case_number = $("#cs_main_case_number").val();
							  var transaction_number = $("#cs_main_transaction_number").val();
							var registration_district_number = $("#txt_lc_registration_district_number").val();
							var registration_section_number = $("#txt_lc_registration_section_number").val();
							
							console.log(type_of_certificate);
							
							  $.ajax({
								   type: "POST",
								   url: "Case_Management_Serv",
								  // target:'_blank',
								   data: {
										  request_type: 'process_complete_milestone_for_job',
										   job_number:job_number,
										   case_number:case_number,
										transaction_number:transaction_number,
										  
										   registration_district_number:registration_district_number,
										   registration_section_number:registration_section_number,
										type_of_certificate: type_of_certificate.trim()  		                 	
								   },
								   cache: false,
								  xhrFields:{
									  responseType: 'blob'
								  },
								   beforeSend: function () { },
								   success: function(jobdetails) {
									   console.log(jobdetails);
									  var blob = new Blob([jobdetails], {type: "application/pdf"});
									  var objectUrl = URL.createObjectURL(blob);
									window.open(objectUrl);
										
								   }
								   }); 
						   });


						   $('#btn_completed_my_work')
						   .on(
								   'click',
								   function(e) {
									   // validation code here
									   // e.preventDefault();
									   console.log('form submited Clicked');

									   bootbox
											   .confirm({
												   title : "Action confrimation!",
												   message : "Are you sure you want to set this job as work completed and push to Unit Head?",
												   buttons : {
													   cancel : {
														   label : '<i class="fa fa-times"></i> Cancel'
													   },
													   confirm : {
														   label : '<i class="fa fa-check"></i> Confirm'
													   }
												   },
												   callback : function(result) {
													   if (result) {

														   var job_number = $(
																   "#cs_main_job_number").val();

														   $
																   .ajax({
																	   type : "POST",
																	   url : "Case_Management_Serv",
																	   data : {
																		   request_type : 'select_update_application_as_work_done_general',
																		   job_number : job_number
																	   },
																	   cache : false,

																	   success : function(
																			   jobdetails) {

																		   var json_p = JSON
																				   .parse(jobdetails);
																		   if (json_p.data == "Success") {
																			   $(
																					   "#general_message_dialog")
																					   .modal();
																			   $(
																					   '#general_message_dialog #general_message_dialog_msg_new')
																					   .val(
																							   'Application Successfully Updated and Moved to Unit Dashboard ');
																		   } else {
																			   $(
																					   "#general_message_dialog")
																					   .modal();
																			   $(
																					   '#general_message_dialog #general_message_dialog_msg_new')
																					   .val(
																							   'Error Loading data!! ');
																		   }

																		   // push
																		   // to
																		   // storage
																		   addJobToCompletedQueriedList(
																				   job_number,
																				   ar_name,
																				   business_process_sub_name,
																				   job_purpose);

																		   setTimeout(
																				   function() {
																					   window.history
																							   .go(-1)
																				   },
																				   3000);

																	   }

																   });
														   // return false;

													   }
												   }
											   });

								   });


						   

					$('#lc_btn_save_register_description')
							.on(
									'click',
									function(e) {

										var job_number = $(
												"#cs_main_job_number").val();
										var case_number = $(
												"#cs_main_case_number").val();
										var search_report = $("#lc_description_of_land_lrd").val()

										 console.log(search_report);
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'online_select_update_resgister_description',
														search_report : search_report,
														case_number : case_number,
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

														$(
																"#general_message_dialog")
																.modal();

														$(
																'#general_message_dialog #general_message_dialog_msg_new')
																.val(jobdetails);

													}
												});
										//	
									});

									$('#lc_btn_save_register_description_2')
									.on(
											'click',
											function(e) {
		
												var job_number = $(
														"#cs_main_job_number").val();
												var case_number = $(
														"#cs_main_case_number").val();
												var search_report = $("#lc_description_of_land_lrd_2").val()
		
												 console.log(search_report);
												$
														.ajax({
															type : "POST",
															url : "Case_Management_Serv",
															data : {
																request_type : 'online_select_update_resgister_description',
																search_report : search_report,
																case_number : case_number,
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
		
																$(
																		"#general_message_dialog")
																		.modal();
		
																$(
																		'#general_message_dialog #general_message_dialog_msg_new')
																		.val(jobdetails);
		
															}
														});
												//	
											});

					$("#lrd_btn_search_for_mother_transction_to_child").click(function(event) {

										var mc_job_number = $(
												'#lrd_search_for_mother_transction_to_child')
												.val();
										var job_number = $(
												"#cs_main_job_number").val();
										var case_number = $(
												"#cs_main_case_number").val();
										var transaction_number = $(
												"#cs_main_transaction_number")
												.val();


												var enq_search_type = "";
								var selected_rbtn = $("input[name='rbtn_search_type']:checked");
								if (selected_rbtn.length > 0) {
									enq_search_type = selected_rbtn.val();
									
								}
								console.log("selected " + enq_search_type);
								
								//var enq_search_value = $("#lrd_search_for_mother_transction_to_child").val();
								//console.log('Search Value: ' + enq_search_value);

								if (mc_job_number.length < 3) {
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 3 or more characters to search </span>',
									}, { type : 'danger' , z_index: 9999  });
									
								} else if (enq_search_type.length <= 0){
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
									}, { type : 'danger' , z_index: 9999  });
									
								}else {

									if (confirm("Are you sure to link the application to a mother file?") == true) {
										

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target : '_blank',
													data : {
														request_type : 'select_copy_mother_file_transaction_to_child',
														mc_job_number : mc_job_number,
														job_number : job_number,
														case_number : case_number,
														transaction_number : transaction_number,
														type_of_value: enq_search_type
													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log(jobdetails);

														if(jobdetails == '') {
															alert("Job number or Ceritifcate number can not be found");
															return;
														} else {

															var json_p_details =JSON.parse(jobdetails);
															alert("Mother file has been linked successfully");
														}
														//

													}
												});
											}

											else {
												return;
											}

										}

									});

									$("#btn_csd_save_details").click(function(event) {

										var mc_job_number = $(
												'#csd_job_number')
												.val();
										var job_number = $(
												"#cs_main_job_number").val();
										var case_number = $(
												"#cs_main_case_number").val();
										var mc_certificate_number = $(
												"#csd_certificate_number")
												.val();

												console.log(mc_certificate_number, case_number)

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target : '_blank',
													data : {
														request_type : 'lc_certificate_search_relation_details_add_update',
														mc_job_number : mc_job_number,
														job_number : job_number,
														case_number : case_number,
														mc_certificate_number : mc_certificate_number
													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log(jobdetails);
														alert('Saved Successfully');

													}
												});

									});

					$("#btn_copy_mother_file_transaction_to_child")
							.click(
									function(event) {

										var mc_job_number = $(
												'#tmc_mc_job_number').val();
										var job_number = $("#tmc_job_number")
												.val();
										var case_number = $("#tmc_case_number")
												.val();
										var transaction_number = $(
												"#tmc_transaction_number")
												.val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target : '_blank',
													data : {
														request_type : 'select_copy_mother_file_transaction_to_child',
														mc_job_number : mc_job_number,
														job_number : job_number,
														case_number : case_number,
														transaction_number : transaction_number
													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log(jobdetails);
														alert(jobdetails);

													}
												});

									});

					$('#newTransferMothertoChildModal').on(
							'show.bs.modal',
							function(event) {

								$("#tmc_job_number").val(
										$(event.relatedTarget).data(
												'job_number'));
								$("#tmc_transaction_number").val(
										$(event.relatedTarget).data(
												'transaction_number'));
								$("#tmc_case_number").val(
										$(event.relatedTarget).data(
												'case_number'));

							});
							
							
							
					$('#lrdtransactionapprovalmodal').on(
							'show.bs.modal',
							function(event) {

								$("#lbl_transaction_id").val(
										$(event.relatedTarget).data(
												'transaction_id'));
								$("#lbl_nature_of_instrument").val(
										$(event.relatedTarget).data(
												'ps_nature_of_instrument'));
								$("#lbl_proprietor").val(
										$(event.relatedTarget).data(
												'ps_proprietor'));

								$("#lbl_case_number").val(
										$(event.relatedTarget).data(
												'case_number'));


							});
							
							
							$("#btn_lrd_transaction_approval")
							.click(
									function(event) {


	 
     			 
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
										 var transaction_number = $("#cs_main_transaction_number").val();
						   
										  var send_by_id = localStorage.getItem('userid');
										var send_by_name = localStorage.getItem('fullname');
										
								   
											$.ajax({
												type: "POST",
												url: "Case_Management_Serv",
												data: {
													  request_type: 'online_select_verification_code_create',
													case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
												 type_of_transaction:'approval_of_register_transaction'
												 },
												cache: false,
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												},
												success: function(jobdetails) {
												   
												   //console.log(jobdetails);
											  var json_p = JSON.parse(jobdetails);
											  alert(json_p.msg);
												 
										 
												}
												}); 

										// var transaction_id = $('#lbl_transaction_id').val();
										// var nature_of_instrument = $("#lbl_nature_of_instrument").val();
										// var proprietor = $("#lbl_proprietor").val();
										// var case_number = $("#lbl_case_number").val();
										//     transaction_id = transaction_id.replace('.0', '');
										// var job_number = $("#cs_main_job_number").val();

										// $
										// 		.ajax({
										// 			type : "POST",
										// 			url : "Case_Management_Serv",
										// 			// target : '_blank',
										// 			data : {
										// 				request_type : 'online_select_transaction_approvals_create',
										// 				transaction_id : transaction_id,
										// 				nature_of_instrument : nature_of_instrument,
										// 				case_number : case_number,
										// 				job_number : job_number,
										// 				proprietor : proprietor
										// 			},
										// 			cache : false,

										// 			success : function(
										// 					jobdetails) {
										// 				// console.log(jobdetails);
										// 				alert(jobdetails);

										// 			}
										// 		});

									});
									
									
						$("#lc_btn_approve_certicate_for_signature")
							.click(
									function(event) {

								$("#lbl_ca_transaction_id").val('0');
								$("#lbl_ca_certificate_number").val($("#cs_main_certificate_number").val());
								$("#lbl_ca_ar_name").val($("#cs_main_ar_name").val());
								$("#lbl_ca_case_number").val($("#cs_main_case_number").val());
								$("#lbl_ca_job_number").val($("#cs_main_job_number").val());
								
								$("#lrdcertificateapprovalmodal").modal();
							});

							
							$("#lc_btn_approve_search_for_signature")
							.click(
									function(event) {

								$("#lbl_cs_transaction_id").val('0');
								$("#lbl_cs_certificate_number").val($("#cs_main_certificate_number").val());
								$("#lbl_cs_ar_name").val($("#cs_main_ar_name").val());
								$("#lbl_cs_case_number").val($("#cs_main_case_number").val());
								$("#lbl_cs_job_number").val($("#cs_main_job_number").val());
								
								$("#pvlmdsearchapprovalmodal").modal();
							});

							$("#lc_btn_approve_certicate_for_signature_")
							.click(
									function(event) {

								$("#lbl_ca_transaction_id_").val('0');
								$("#lbl_ca_certificate_number_").val($("#cs_main_certificate_number").val());
								$("#lbl_ca_ar_name_").val($("#cs_main_ar_name").val());
								$("#lbl_ca_case_number_").val($("#cs_main_case_number").val());
								$("#lbl_ca_job_number_").val($("#cs_main_job_number").val());
								
								$("#lrdcertificateapprovalmodal_").modal();
							});
							
							$("#lc_btn_approve_encumbrance_for_signature").click(function(event) {

								$("#lbl_en_transaction_id").val('0');
								$("#lbl_encumbrance_number").val($("#cs_main_certificate_number").val());
								$("#lbl_en_ar_name").val($("#cs_main_ar_name").val());
								$("#lbl_en_case_number").val($("#cs_main_case_number").val());
								$("#lbl_en_job_number").val($("#cs_main_job_number").val());
								
								$("#lrdencumbranceapprovalmodal").modal();
							});
							
							$('#final_registration_approval_dialog').on('shown.bs.modal', function () {
								$('#veri_code1').val("");
								$('#veri_code2').val("");
								$('#veri_code3').val("");
								$('#veri_code4').val("");
								$('#veri_code5').val("");
								$('#veri_code6').val("");
							})

							

							$("#lc_btn_approve_for_plot_transaction_to_smd_layer")
							.click(
									function(event) {

								$("#lbl_ca_transaction_id__").val('0');
								$("#lbl_ca_certificate_number__").val($("#cs_main_certificate_number").val());
								$("#lbl_ca_ar_name__").val($("#cs_main_ar_name").val());
								$("#lbl_ca_case_number__").val($("#cs_main_case_number").val());
								$("#lbl_ca_job_number__").val($("#cs_main_job_number").val());
								
								$("#smdplottransactionlayerapprovalmodal").modal();
							});
							
							$("#btn_lrd_ca_certificate_approval")
							.click(
									function(event) {
     			 
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
										 var transaction_number = $("#cs_main_transaction_number").val();
						   
										  var send_by_id = localStorage.getItem('userid');
										var send_by_name = localStorage.getItem('fullname');
										
								   
											$.ajax({
												type: "POST",
												url: "Case_Management_Serv",
												data: {
													  request_type: 'online_select_verification_code_create',
													case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
												 type_of_transaction:'approval_of_certificate_transaction'
												 },
												cache: false,
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												},
												success: function(jobdetails) {
												   
												   //console.log(jobdetails);
											//   var json_p = JSON.parse(jobdetails);
											//   alert(json_p.msg);

											var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							//$('#final_registration_approval_dialog').modal('hide');
							$('#final_registration_approval_dialog').modal('show');

							$("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
							$("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
							$("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
							$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
							$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							$("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);

							$('#final_registration_approval_dialog').on('shown.bs.modal', function () {
								$("#lrdcertificateapprovalmodal").css("z-index", "1029");
							  })
								
							  $('#final_registration_approval_dialog').on('hidden.bs.modal', function () {
								  $("#lrdcertificateapprovalmodal").css("z-index", "");
							  })

						}else {
							alert(json_p.msg);
						}
												 
										 
												}
												}); 

//cs_main_application_stage
//cs_main_client_number


									//	var transaction_id = $('#lbl_ca_transaction_id').val('0');
										// 	var transaction_id = '0';
										
										// var certificate_number = $("#lbl_ca_certificate_number").val();
										// var proprietor = $("#cs_main_ar_name").val();
										// var case_number = $("#cs_main_case_number").val();
										// //    transaction_id = transaction_id.replace('.0', '');
										// var job_number = $("#cs_main_job_number").val();
										// $
										// 		.ajax({
										// 			type : "POST",
										// 			url : "Case_Management_Serv",
										// 			// target : '_blank',
										// 			data : {
										// 				request_type : 'transaction_approvals_certificate_create',
										// 				transaction_id : transaction_id,
										// 				certificate_number : certificate_number,
										// 				case_number : case_number,
										// 			    job_number : job_number,
										// 				proprietor : proprietor
										// 			},
										// 			cache : false,

										// 			success : function(
										// 					jobdetails) {
										// 				// console.log(jobdetails);
										// 				alert(jobdetails);

										// 			}
										// 		});

									});

									

									$("#btn_pvlmd_search_approval")
							.click(
									function(event) {

										$("#pvlmdsearchapprovalmodal").modal('hide')
     			 
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
										 var transaction_number = $("#cs_main_transaction_number").val();
						   
										  var send_by_id = localStorage.getItem('userid');
										var send_by_name = localStorage.getItem('fullname');
										
								   
											$.ajax({
												type: "POST",
												url: "Case_Management_Serv",
												data: {
													  request_type: 'online_select_verification_code_create',
													case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
												 type_of_transaction:'approval_of_consolidated_search_signature'
												 },
												cache: false,
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												},
												success: function(jobdetails) {
												   
												   //console.log(jobdetails);
											//   var json_p = JSON.parse(jobdetails);
											//   alert(json_p.msg);

											var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							//$('#final_registration_approval_dialog').modal('hide');
							$('#final_registration_approval_dialog').modal('show');

							$("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
							$("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
							$("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
							$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
							$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							$("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);

							$('#final_registration_approval_dialog').on('shown.bs.modal', function () {
								$("#lrdcertificateapprovalmodal").css("z-index", "1029");
							  })
								
							  $('#final_registration_approval_dialog').on('hidden.bs.modal', function () {
								  $("#lrdcertificateapprovalmodal").css("z-index", "");
							  })

						}else {
							alert(json_p.msg);
						}
												 
										 
												}
												}); 

//cs_main_application_stage
//cs_main_client_number


									//	var transaction_id = $('#lbl_ca_transaction_id').val('0');
										// 	var transaction_id = '0';
										
										// var certificate_number = $("#lbl_ca_certificate_number").val();
										// var proprietor = $("#cs_main_ar_name").val();
										// var case_number = $("#cs_main_case_number").val();
										// //    transaction_id = transaction_id.replace('.0', '');
										// var job_number = $("#cs_main_job_number").val();
										// $
										// 		.ajax({
										// 			type : "POST",
										// 			url : "Case_Management_Serv",
										// 			// target : '_blank',
										// 			data : {
										// 				request_type : 'transaction_approvals_certificate_create',
										// 				transaction_id : transaction_id,
										// 				certificate_number : certificate_number,
										// 				case_number : case_number,
										// 			    job_number : job_number,
										// 				proprietor : proprietor
										// 			},
										// 			cache : false,

										// 			success : function(
										// 					jobdetails) {
										// 				// console.log(jobdetails);
										// 				alert(jobdetails);

										// 			}
										// 		});

									});


									
									$("#btn_smd_plot_transaction_approval")
							.click(
									function(event) {
     			 
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
										 var transaction_number = $("#cs_main_transaction_number").val();
						   
										  var send_by_id = localStorage.getItem('userid');
										var send_by_name = localStorage.getItem('fullname');
										
								   
											$.ajax({
												type: "POST",
												url: "Case_Management_Serv",
												data: {
													  request_type: 'online_select_verification_code_create',
													case_number:case_number,
													job_number:job_number,
													transaction_number:transaction_number,
												 type_of_transaction:'approval_of_sm_plot_transaction',
												 },
												cache: false,
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												},
												success: function(jobdetails) {
												   
												   //console.log(jobdetails);
											//   var json_p = JSON.parse(jobdetails);
											//   alert(json_p.msg);

											var json_p = JSON.parse(jobdetails);

						if(json_p.transaction_process_status == 'New') {

							//$('#final_registration_approval_dialog').modal('hide');
							$('#final_registration_approval_dialog').modal('show');

							$("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
							$("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
							$("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
							$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
							$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
							$("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);

							$('#final_registration_approval_dialog').on('shown.bs.modal', function () {
								$("#smdplottransactionlayerapprovalmodal").css("z-index", "1029");
							  })
								
							  $('#final_registration_approval_dialog').on('hidden.bs.modal', function () {
								  $("#smdplottransactionlayerapprovalmodal").css("z-index", "");
							  })

						}else {
							alert(json_p.msg);
						}
												 
										 
												}
												}); 

									});

									
									$("#btn_lrd_encumbrance_approval")
									.click(
											function(event) {
						  
												var case_number = $("#cs_main_case_number").val();
												var job_number = $("#cs_main_job_number").val();
												 var transaction_number = $("#cs_main_transaction_number").val();
								   
												  var send_by_id = localStorage.getItem('userid');
												var send_by_name = localStorage.getItem('fullname');
												
										   
													$.ajax({
														type: "POST",
														url: "Case_Management_Serv",
														data: {
															  request_type: 'online_select_verification_code_create',
															case_number:case_number,
															job_number:job_number,
															transaction_number:transaction_number,
														 type_of_transaction:'approval_of_encumbrance_transaction',
														 send_by_id:send_by_id,
														 send_by_name:send_by_name
														 },
														cache: false,
														beforeSend: function () {
														   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
														},
														success: function(jobdetails) {
														   
														   //console.log(jobdetails);
													//   var json_p = JSON.parse(jobdetails);
													//   alert(json_p.msg);
		
													var json_p = JSON.parse(jobdetails);
													
		
								if(json_p.transaction_process_status == 'New') {
		
									//$('#final_registration_approval_dialog').modal('hide');
									$('#final_registration_approval_dialog').modal('show');
		
									$("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
									$("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
									$("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
									$("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
									$("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
									$("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);
		
									$('#final_registration_approval_dialog').on('shown.bs.modal', function () {
										$("#lrdencumbranceapprovalmodal").css("z-index", "1029");
									  })
										
									  $('#final_registration_approval_dialog').on('hidden.bs.modal', function () {
										  $("#lrdencumbranceapprovalmodal").css("z-index", "");
									  })
		
								}else {
									alert(json_p.msg);
								}
														 
												 
														}
														}); 
		
											});
									
									
									$("#btn_lrd_ca_certificate_approval_")
									.click(
											function(event) {
						  
												var case_number = $("#cs_main_case_number").val();
												var job_number = $("#cs_main_job_number").val();
												 var transaction_number = $("#cs_main_transaction_number").val();
								   
												  var send_by_id = localStorage.getItem('userid');
												var send_by_name = localStorage.getItem('fullname');
												
										   
													$.ajax({
														type: "POST",
														url: "Case_Management_Serv",
														data: {
															  request_type: 'online_select_verification_code_create',
															case_number:case_number,
															job_number:job_number,
															transaction_number:transaction_number,
														 type_of_transaction:'approval_of_certificate_transaction'
														 },
														cache: false,
														beforeSend: function () {
														   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
														},
														success: function(jobdetails) {
														   
														   //console.log(jobdetails);
													//   var json_p = JSON.parse(jobdetails);
													//   alert(json_p.msg);
		
													var json_p = JSON.parse(jobdetails);
		
								if(json_p.transaction_process_status == 'New') {
		
									//$('#final_registration_approval_dialog').modal('hide');
									// $('#final_registration_approval_dialog').modal('show');
		
									// $("#final_registration_approval_dialog #ta_txt_ta_id").val(json_p.ta_id);
									// $("#final_registration_approval_dialog #ta_txt_job_number").val(json_p.job_number);
									// $("#final_registration_approval_dialog #ta_txt_case_number").val(json_p.case_number);
									// $("#final_registration_approval_dialog #ta_txt_type_of_transaction").val(json_p.type_of_transaction);
									// $("#final_registration_approval_dialog #ta_txt_business_process_sub_name").val(json_p.business_process_sub_name);
									// $("#final_registration_approval_dialog #ta_txt_transaction_details").val(json_p.transaction_details);
		
									// $('#final_registration_approval_dialog').on('shown.bs.modal', function () {
									// 	$("#lrdcertificateapprovalmodal").css("z-index", "1029");
									//   })
										
									//   $('#final_registration_approval_dialog').on('hidden.bs.modal', function () {
									// 	  $("#lrdcertificateapprovalmodal").css("z-index", "");
									//   })

									alert("OTP For Approval Transaction Sent");
		
								}else {
									alert(json_p.msg);
								}
														 
												 
														}
														}); 
		
		//cs_main_application_stage
		//cs_main_client_number
		
		
											//	var transaction_id = $('#lbl_ca_transaction_id').val('0');
												// 	var transaction_id = '0';
												
												// var certificate_number = $("#lbl_ca_certificate_number").val();
												// var proprietor = $("#cs_main_ar_name").val();
												// var case_number = $("#cs_main_case_number").val();
												// //    transaction_id = transaction_id.replace('.0', '');
												// var job_number = $("#cs_main_job_number").val();
												// $
												// 		.ajax({
												// 			type : "POST",
												// 			url : "Case_Management_Serv",
												// 			// target : '_blank',
												// 			data : {
												// 				request_type : 'transaction_approvals_certificate_create',
												// 				transaction_id : transaction_id,
												// 				certificate_number : certificate_number,
												// 				case_number : case_number,
												// 			    job_number : job_number,
												// 				proprietor : proprietor
												// 			},
												// 			cache : false,
		
												// 			success : function(
												// 					jobdetails) {
												// 				// console.log(jobdetails);
												// 				alert(jobdetails);
		
												// 			}
												// 		});
		
											});		
											
											
											$("#confirm_otp_for_approval_certificate").on('shown.bs.modal', function () {
												var case_number = $("#cs_main_case_number").val();
												var job_number = $("#cs_main_job_number").val();
												 var transaction_number = $("#cs_main_transaction_number").val();

												 $.ajax({
													type: "POST",
													url: "Case_Management_Serv",
													data: {
														  request_type: 'online_select_verification_code_details',
														case_number:case_number,
														job_number:job_number,
														transaction_number:transaction_number,
													 type_of_transaction:'approval_of_certificate_transaction'
													 },
													cache: false,
													beforeSend: function () {
													   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													},
													success: function(jobdetails) {

														if(!jobdetails) {
															alert("OTP has not been sent")
															return;
														}

														var json_p = JSON.parse(jobdetails);

														$("#confirm_otp_for_approval_certificate #ta_txt_ta_id_").val(json_p.ta_id);
														$("#confirm_otp_for_approval_certificate #ta_txt_job_number_").val(json_p.job_number);
														$("#confirm_otp_for_approval_certificate #ta_txt_case_number_").val(json_p.case_number);
														$("#confirm_otp_for_approval_certificate #ta_txt_type_of_transaction_").val(json_p.type_of_transaction);
														$("#confirm_otp_for_approval_certificate #ta_txt_business_process_sub_name_").val(json_p.business_process_sub_name);
														$("#confirm_otp_for_approval_certificate #ta_txt_transaction_details_").val(json_p.transaction_details);

													}
												})
											});

											
											$("#confirm_otp_for_approval_register").on('shown.bs.modal', function () {
												var case_number = $("#cs_main_case_number").val();
												var job_number = $("#cs_main_job_number").val();
												 var transaction_number = $("#cs_main_transaction_number").val();

												 $.ajax({
													type: "POST",
													url: "Case_Management_Serv",
													data: {
														  request_type: 'online_select_verification_code_details',
														case_number:case_number,
														job_number:job_number,
														transaction_number:transaction_number,
													 type_of_transaction:'approval_of_registration_activation_signature'
													 },
													cache: false,
													beforeSend: function () {
													   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													},
													success: function(jobdetails) {

														if(!jobdetails) {
															alert("OTP has not been sent")
															return;
														}

														var json_p = JSON.parse(jobdetails);

														$("#confirm_otp_for_approval_register #ta_txt_ta_id__").val(json_p.ta_id);
									$("#confirm_otp_for_approval_register #ta_txt_job_number__").val(json_p.job_number);
									$("#confirm_otp_for_approval_register #ta_txt_case_number__").val(json_p.case_number);
									$("#confirm_otp_for_approval_register #ta_txt_type_of_transaction__").val(json_p.type_of_transaction);
									$("#confirm_otp_for_approval_register #ta_txt_business_process_sub_name__").val(json_p.business_process_sub_name);
									$("#confirm_otp_for_approval_register #ta_txt_transaction_details__").val(json_p.transaction_details);

													}
												})
											});

											
											$("#confirm_otp_for_approval_mortgage").on('shown.bs.modal', function () {
												var case_number = $("#cs_main_case_number").val();
												var job_number = $("#cs_main_job_number").val();
												 var transaction_number = $("#cs_main_transaction_number").val();

												 $.ajax({
													type: "POST",
													url: "Case_Management_Serv",
													data: {
														  request_type: 'online_select_verification_code_details',
														case_number:case_number,
														job_number:job_number,
														transaction_number:transaction_number,
													 type_of_transaction:'approval_of_registration_activation_signature'
													 },
													cache: false,
													beforeSend: function () {
													   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													},
													success: function(jobdetails) {

														if(!jobdetails) {
															alert("OTP has not been sent")
															return;
														}

														var json_p = JSON.parse(jobdetails);

														$("#confirm_otp_for_approval_mortgage #ta_txt_ta_id___").val(json_p.ta_id);
									$("#confirm_otp_for_approval_mortgage #ta_txt_job_number___").val(json_p.job_number);
									$("#confirm_otp_for_approval_mortgage #ta_txt_case_number___").val(json_p.case_number);
									$("#confirm_otp_for_approval_mortgage #ta_txt_type_of_transaction___").val(json_p.type_of_transaction);
									$("#confirm_otp_for_approval_mortgage #ta_txt_business_process_sub_name___").val(json_p.business_process_sub_name);
									$("#confirm_otp_for_approval_mortgage #ta_txt_transaction_details___").val(json_p.transaction_details);

													}
												})
											});
										
					$("#lc_btn_generate_deeds_number")
							.click(
									function(event) {

			
										var number_format = 'PNGA';
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
										
										var deed_number = $("#txt_deeds_number_cs").val();
										
										
									
										if(deed_number!=='null'){
											alert('Deed Number has been generated already');
										}else{
											
											$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target : '_blank',
													data : {
														request_type : 'pvlmd_number_generation_deed_number_ls_number',
														case_number : case_number,
													    job_number : job_number,
														number_format : number_format
													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log(jobdetails);
														alert(jobdetails);
														
														
															var result = JSON
																.parse(jobdetails);
																
																
															$("#txt_deeds_number_cs").val(result.deed_ls_number);
															$("#lc_txt_volume_number").val(result.deed_ls_number);
								

													}
												});
										}
										
									

									});
							
							
								
							$("#lc_btn_generate_ls_number")
							.click(
									function(event) {

			
										var number_format = 'nt';
										var case_number = $("#cs_main_case_number").val();
										var job_number = $("#cs_main_job_number").val();
									   var certificate_number = $("#lc_txt_certificate_number").val();
											if(certificate_number!==''){
											alert('LS Number has been generated already');
										    }else{
											$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target : '_blank',
													data : {
														request_type : 'pvlmd_number_generation_deed_number_ls_number',
														case_number : case_number,
													    job_number : job_number,
														number_format : number_format
													},
													cache : false,

													success : function(
															jobdetails) {
														// console.log(jobdetails);
														alert(jobdetails);
														
														
															var result = JSON
																.parse(jobdetails);
																
																
															//$("#txt_deeds_number_cs").val(result.deed_ls_number);
															$("#lc_txt_certificate_number").val(result.deed_ls_number);
								

													}
												});
											}
											
										

									});
									
									
									//LVD Stuff
									$('#btn_save_comparable_main_changes_point').on('click', function(e) {

	var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

	console.log(wktplygonsearch);

	var parcel_uuid = $("#cbl_parcel_uuid_point").val();
	var transaction_date = $("#cbl_transaction_date_point").val();
	var request_type = 'save_lvd_parcel';
	var job_no = $("#cbl_job_no_point").val();
	var accreage_size_of_land = $("#cbl_accreage_size_of_land_point").val();
	var confirmed_acre_size = $("#cbl_confirmed_acre_size_point").val();
	var unexpired_term = $("#cbl_unexpired_term_point").val();
	var transaction_date = $("#cbl_transaction_date_point").val();
	var value_of_property = $("#cbl_value_of_property_point").val();
	var type_of_house = $("#cbl_type_of_house_point").val();
	var source_data = $("#cbl_source_data_point").val();
	var prominent_landmarks = $("#cbl_prominent_landmarks_point").val();
	var locality = $("#cbl_locality_point").val();
	var type_of_use = $("#cbl_type_of_use_point").val();
	var property_owner = $("#cbl_property_owner_point").val();

	$.ajax({
		type : "POST",
		url : 'Maps',
		data : {
			request_type : 'select_update_sp_parcels_lvd_point',
			// request_type :
			// request_type,
			parcel_uuid : parcel_uuid,
			job_no : job_no,
			accreage_size_of_land : accreage_size_of_land,
			confirmed_acre_size : confirmed_acre_size,
			unexpired_term : unexpired_term,
			transaction_date : transaction_date,
			value_of_property : value_of_property,
			type_of_house : type_of_house,
			source_data : source_data,
			prominent_landmarks : prominent_landmarks,
			locality : locality,
			type_of_use : type_of_use,
			property_owner : property_owner
		},
		cache : false,
		beforeSend : function() {
			// $('#district').html('<img
			// src="img/loading.gif"
			// alt=""
			// width="24"
			// height="24">');
		},
		success : function(scanned_docs_response) {

			// var json_p =
			// JSON.parse(scanned_docs_response);

			/*
			 * $("#newcomparabledata").modal(); $('#newcomparabledata
			 * #parcel_uuid').val( scanned_docs_response);
			 */

			alert(scanned_docs_response);
			$('#newcomparabledata_point').modal('hide');

		}
	});

});

$('#btn_save_comparable_main_changes_new').on('click', function(e) {
	var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

	console.log(wktplygonsearch);

	var parcel_uuid = $("#cbl_parcel_uuid").val();
	var transaction_date = $("#cbl_transaction_date").val();
	var request_type = 'save_lvd_parcel';
	var job_no = $("#cbl_job_no").val();
	var accreage_size_of_land = $("#cbl_accreage_size_of_land").val();
	var confirmed_acre_size = $("#cbl_confirmed_acre_size").val();
	var unexpired_term = $("#cbl_unexpired_term").val();
	var transaction_date = $("#cbl_transaction_date").val();
	var value_of_property = $("#cbl_value_of_property").val();
	var type_of_house = $("#cbl_type_of_house").val();
	var source_data = $("#cbl_source_data").val();
	var prominent_landmarks = $("#cbl_prominent_landmarks").val();
	var locality = $("#cbl_locality").val();
	var type_of_use = $("#cbl_type_of_use").val();
	var property_owner = $("#cbl_property_owner").val();

	var source_of_verification = $("#cbl_source_of_verification").val();
	var currency_of_value = $("#cbl_currency_of_value").val();
	var capital_value = $("#cbl_capital_value").val();
	var ground_rent = $("#cbl_ground_rent").val();
	var rental_value = $("#cbl_rental_value").val();
	var commencement_date = $("#cbl_commencement_date").val();
	var general_omment = $("#cbl_general_omment").val();
	var image_path = $("#cbl_property_owner").val();

	$.ajax({
		type : "POST",
		url : 'Maps',
		data : {
			request_type : 'save_lvd_parcel',
			// request_type :
			// request_type,
			parcel_uuid : parcel_uuid,
			job_no : job_no,
			accreage_size_of_land : accreage_size_of_land,
			confirmed_acre_size : confirmed_acre_size,
			unexpired_term : unexpired_term,
			transaction_date : transaction_date,
			value_of_property : value_of_property,
			type_of_house : type_of_house,
			source_data : source_data,
			prominent_landmarks : prominent_landmarks,
			locality : locality,
			type_of_use : type_of_use,
			property_owner : property_owner
		},
		cache : false,
		beforeSend : function() {
			// $('#district').html('<img
			// src="img/loading.gif"
			// alt=""
			// width="24"
			// height="24">');
		},
		success : function(scanned_docs_response) {

			// var json_p =
			// JSON.parse(scanned_docs_response);

			/*
			 * $("#newcomparabledata").modal(); $('#newcomparabledata
			 * #parcel_uuid').val( scanned_docs_response);
			 */

			alert(scanned_docs_response);
			$('#newcomparabledata').modal('hide');

		}
	});

});


 $('#btn_generate_smd_barcode_new_address_code').on('click', function(e) {
           	var job_number = $("#cs_main_job_number").val();
           	var case_number = $("#cs_main_transaction_number").val();
        	//var case_number = $("#cs_main_case_number").val();
        	var wkt_polygon = $("#lc_fr_bl_wkt_polygon").val();
           	
        		 $.ajax({
     				 type: "POST",
     				 url: "GenerateCaseReports",
     				// target:'_blank',
     				 data: {
     	                	request_type: 'request_to_generate_smd_barcode_with_address_code',
     	                	wkt_polygon:wkt_polygon,
 		                 	job_number:job_number,
 		                 	case_number:case_number
     				 },
     				 cache: false,
     				xhrFields:{
     	                responseType: 'blob'
     	            },
     				 beforeSend: function () {
     					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
     				 },
     				 success: function(jobdetails) {
     					 console.log(jobdetails);
     					var blob = new Blob([jobdetails], {type: "application/pdf"});
     			        var objectUrl = URL.createObjectURL(blob);
     			      window.open(objectUrl);
     					  
     				 }
     				 }); 
     		 });

			 
     		 $('#btn_compose_certificate_template_dcs').on('click', function(e) {
              	var job_number = $("#cs_main_job_number").val();
              	var case_number = $("#cs_main_transaction_number").val();
              	var business_process_sub_name = $("#cs_main_business_process_sub_name").val();
              	
           		 $.ajax({
        				 type: "POST",
        				 url: "GenerateCaseReports",
        				// target:'_blank',
        				 data: {
        	                	request_type: 'request_to_compose_certificate_template',
  		                 	job_number:job_number,
  		                 	case_number:case_number,
  		                 	business_process_sub_name:business_process_sub_name,
  		                 	cert_type:'concurrence_certificate'
        				 },
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					
        					 
        				
        					 $('#lc_search_report_summary_details_dcs').summernote('code', '<ol><li>'+ jobdetails +'</li></ol>');
         	 
        					 
        					console.log(jobdetails);
        					 alert('Report Composed Successfully')
        			
        				 }
        				 }); 
        		 });
     		 
     		 
		 $('#lc_btn_save_search_report_dcs').on('click', function(e) { 
	   	
	   	var job_number = $("#cs_main_job_number").val();
	  	var case_number = $("#cs_main_case_number").val();
	  	var search_report = $("#lc_search_report_summary_details_dcs").val();

			 $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	               	request_type: 'online_select_update_search_summary_deed',
	               	search_report:search_report,
	               	case_number:case_number,
	               	job_number:job_number},
				 cache: false,
				 beforeSend: function () {
					
				 },
				 success: function(jobdetails) {
					
			
					$("#general_message_dialog").modal();
					$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);
		  
					
				 }
				 }); 
	   //	
	   });
   		


 		$('#lc_btn_preview_consent_certificate_dcs').on('click', function(e) {
          	var job_number = $("#cs_main_job_number").val();
          	var case_number = $("#cs_main_case_number").val();
        	var ir_business_process_sub_name = $("#cs_main_business_process_sub_name").val();
          	var transaction_number = $("#cs_main_transaction_number").val();
        	var notes = $("#lc_search_report_summary_details_dcs").val();
          	
       			 $.ajax({
    						                 	
 		                 	 type: "POST",
 	        				 url: "GenerateCaseReports",
 	        				// target:'_blank',
 	        				 data: {
 	        	                	request_type: 'request_to_generate_consent_certificate_typed',
 	     		                 	job_number:job_number,
 	     		                 	case_number:case_number,
 	     		                 	transaction_number:transaction_number,
 	     		                 	notes:notes,
 	     		                 	ir_business_process_sub_name:'APPLICATION FOR CONCURRENCE'
 	     		              
 	     		                 	
    				 },
    				 cache: false,
    				xhrFields:{
    	                responseType: 'blob'
    	            },
    				 beforeSend: function () {
    					
    				 },
    				 success: function(jobdetails) {
    					
    			
    					var blob = new Blob([jobdetails], {type: "application/pdf"});
    			        var objectUrl = URL.createObjectURL(blob);
    			      window.open(objectUrl);
    					  
    				 }
    				 }); 
    		 });


			 var lc_bl_wkt_polygon = $("#lc_bl_wkt_polygon").val()

			 //console.log(lc_bl_wkt_polygon);

			 if(!lc_bl_wkt_polygon){
					$("#lc_btn_add_note_on_application_all").addClass('d-none')
			 } else {
				$("#lc_btn_add_note_on_application_all").removeClass('d-none')
			 }


			 $("#askForPurposeOfSendingRequest").on('shown.bs.modal', function (e) {

				var type_of_request = $(e.relatedTarget).data('bs-desc');
				//console.log(type_of_request);

				$.ajax({
						type : "POST",
						url : "Case_Management_Serv",
						data : {
							request_type : 'get_request_purpose',
						},
						cache : false,
						beforeSend : function() {
						},
						success : function(jobdetails) {
							//console.log(jobdetails);
							var json_p = JSON.parse(jobdetails);
							var options = $("#req_job_purpose");
							options.empty();
							options.append(new Option("-- select Purpose --",0));
							$(json_p).each(function() {
								switch (type_of_request) {
									case 'Further Entry (Enter Details)':
										if (this._id == 3) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Upload Coordinate and Save':
										if (this._id == 2) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Send for Records Information':
										if (this._id == 1 || this._id == 24) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Verify Records Information':
										if (this._id == 1 || this._id == 24) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Review Records Information':
										if (this._id == 1) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Inspection of Site (IF applicable)':
										if (this._id == 23) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Send for Publication':
										if (this._id == 21) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Send for Title Plan Preparation':
										if (this._id == 22 || this._id == 15) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Check for Objection':
										if (this._id == 19) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Check for Polygon':
										if (this._id == 2) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									// case 'Generate interest Number':
									// 	if (this._id == 14) {
									// 		$('#req_job_purpose').append(
									// 						'<option value="'
									// 								+ this.request_name
									// 								+ '">'
									// 								+ this.request_name
									// 								+ '</option>');
									// 	}
									// 	break;
									// case 'Generate sub Interest Number':
									// 	if (this._id == 18) {
									// 		$('#req_job_purpose').append(
									// 						'<option value="'
									// 								+ this.request_name
									// 								+ '">'
									// 								+ this.request_name
									// 								+ '</option>');
									// 	}
									// 	break;
									case 'Enter Root of Title':
										if (this._id == 4 || this._id == 20) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Generate Certificate Number':
										if (this._id == 16) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Generate Volume and Folio':
										if (this._id == 9) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Check Certificate':
										if (this._id == 4 || this._id == 16 || this._id == 3 || this._id == 9) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Check Register':
										if (this._id == 4 || this._id == 20 || this._id == 9) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Check/Review Documents':
										if (this._id == 24) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Review Documents':
										if (this._id == 24) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Check availability of Mother File':
										if (this._id == 25) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Link to Mother File':
										if (this._id == 25) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;	
									case 'Preview Certificate':
										if (this._id == 4 || this._id == 16 || this._id == 3 || this._id == 9) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break;
									case 'Enter Mortgage Transaction':
										if (this._id == 17) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break; 
									case 'View Register':
										if (this._id == 4) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break; 
									case 'Check Parcel Details':
										if (this._id == 3) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										}
										break; 
									case 'openall':
										// if (this._id == 17) {
											$('#req_job_purpose').append(
															'<option value="'
																	+ this.request_name
																	+ '">'
																	+ this.request_name
																	+ '</option>');
										//}
										break;
								}
								
							});
						}
					});
			});
     		 

			$("#btn_generate_smd_title_plan_numbers").on('click', function(e) {

				var job_number = $("#cs_main_job_number").val();
				var case_number = $("#cs_main_case_number").val();
				var transaction_number = $("#cs_main_transaction_number").val();

				$.ajax({
					type : "POST",
					url : "Case_Management_Serv",
					data : {
						request_type : 'select_generate_smd_title_plan_numbers',
						job_number : job_number,
						case_number : case_number,
						transaction_number : transaction_number
					},
					cache : false,
					beforeSend : function() {
					},
					success : function(jobdetails) {

						console.log(jobdetails);

						if(!jobdetails) {
							//alert("Title Plan Numbers have been generated already")

							$.notify({
								message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Something went wrong. Try again.</span>',
							}, { type : 'danger' , z_index: 9999  });

							return;
						} else {

						}

					}
				})
			});



					$('#btn_generate_ai_message').on('click', function(e) { 
	   	
									var job_number = $("#cs_main_job_number").val();
									var case_number = $("#cs_main_case_number").val();
									  console.log("AI Chats")
							 		
								 const input = document.getElementById("userInput");
            const query = input.value.trim();

									if (!query) return;
									let query_message = query + ' with job number ' + job_number;

									appendMessage("user", query_message);
									input.value = "";
									showTypingIndicator();

									$.ajax({
									type: "POST",
									url: "ai_serv",
									data: {
										request_type: "send_agent_question",
										query: query_message
									},
									success: function (results) {

										console.log(results)
										hideTypingIndicator();
										if (!results) {
										showError("No response from the agent. Please try again.");
										return;
										}
										try {
										// const json_p = JSON.parse(results);
										appendMessage("agent", results);
										// appendMessage("agent", json_p.agent);
										} catch (e) {
										showError("Invalid response format. Please try again.");
										}
									},
									error: function (xhr, status, error) {
										hideTypingIndicator();
										showError("Error communicating with the server. Please try again later.");
									}
									});
								});


						$('#cbo_predefine_messages_to_ai').change(function () {
								const selectedPage = $(this).val();
								//const $container = $('#embeddedPageContainer');
console.log(selectedPage)
								if (selectedPage) {
								var job_number = $("#cs_main_job_number").val();
									var case_number = $("#cs_main_case_number").val();
									  console.log("AI Chats")
							 		
								// const input = document.getElementById("userInput");
                                 const query = selectedPage;

									if (!query) return;
									let query_message = query + ' with job number ' + job_number;

									appendMessage("user", query_message);
									//input.value = "";
									showTypingIndicator();

									$.ajax({
									type: "POST",
									url: "ai_serv",
									data: {
										request_type: "send_agent_question",
										query: query_message
									},
									success: function (results) {

										console.log(results)
										hideTypingIndicator();
										if (!results) {
										showError("No response from the agent. Please try again.");
										return;
										}
										try {
										// const json_p = JSON.parse(results);
										appendMessage("agent", results);

										const sampleData =  [
    { collection_of_application_checklist_id: 4, collection_of_application_checklist_name: "Photo ID of Grantee", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 3 },
    { collection_of_application_checklist_id: 6, collection_of_application_checklist_name: "Photo ID of Collector", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 3 },
    { collection_of_application_checklist_id: 5, collection_of_application_checklist_name: "Authority Note from Grantee", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 3 },
    { collection_of_application_checklist_id: 8, collection_of_application_checklist_name: "Evidence of Payment of Concurrence", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 3 },
    { collection_of_application_checklist_id: 7, collection_of_application_checklist_name: "Evidence of Payment of Ground Rent", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 3 },
    { collection_of_application_checklist_id: 10, collection_of_application_checklist_name: "Authority Note from License Surveyor", collection_of_application_checklist_option: false, business_process_id: 2, business_process_sub_id: 2 },
    { collection_of_application_checklist_id: 9, collection_of_application_checklist_name: "Photo ID of License Surveyor", collection_of_application_checklist_option: false, business_process_id: 2, business_process_sub_id: 2 },
    { collection_of_application_checklist_id: 1, collection_of_application_checklist_name: "Photo ID of Grantee", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 16 },
    { collection_of_application_checklist_id: 2, collection_of_application_checklist_name: "Authority Note from Grantee", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 16 },
    { collection_of_application_checklist_id: 3, collection_of_application_checklist_name: "Photo ID of Collector", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 16 },
    { collection_of_application_checklist_id: 11, collection_of_application_checklist_name: "Photo ID of Grantee", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 17 },
    { collection_of_application_checklist_id: 12, collection_of_application_checklist_name: "Authority Note from Grantee", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 17 },
    { collection_of_application_checklist_id: 13, collection_of_application_checklist_name: "Photo ID of Collector", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 17 },
    { collection_of_application_checklist_id: 14, collection_of_application_checklist_name: "Photo ID of Grantee", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 18 },
    { collection_of_application_checklist_id: 15, collection_of_application_checklist_name: "Authority Note from Grantee", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 18 },
    { collection_of_application_checklist_id: 16, collection_of_application_checklist_name: "Photo ID of Collector", collection_of_application_checklist_option: false, business_process_id: 4, business_process_sub_id: 18 },
    { collection_of_application_checklist_id: 18, collection_of_application_checklist_name: "Photo ID of Collector", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 8 },
    { collection_of_application_checklist_id: 17, collection_of_application_checklist_name: "Authority Note from the Bank", collection_of_application_checklist_option: false, business_process_id: 3, business_process_sub_id: 8 }
  ];

										appendJsonTableToChatBox(sampleData);
										// appendMessage("agent", json_p.agent);
										} catch (e) {
										showError("Invalid response format. Please try again.");
										}
									},
									error: function (xhr, status, error) {
										hideTypingIndicator();
										showError("Error communicating with the server. Please try again later.");
									}
									});
								} else {
									showError("Error communicating with the server. Please try again later.");
								}

									
							});

							 $('#pageSelector').change(function () {
								const selectedPage = $(this).val();
								const $container = $('#embeddedPageContainer');

								if (selectedPage) {
									$container.html('<div class="text-center text-muted"><i class="fas fa-spinner fa-spin"></i> Loading...</div>');
									$.get(selectedPage, function (data) {
									$container.html(data);
									}).fail(function () {
									$container.html('<div class="text-danger">Failed to load content.</div>');
									});
								} else {
									$container.html('<em class="text-muted">Select a page from the dropdown to load its content here.</em>');
								}
							});



							var coor_tbl = $("#job_request_app_tbl").DataTable({
				// responsive: true,

				stateSave : true,
				"createdRow" : function(row, data, dataIndex) {
					if (data[0] == "1") {
						$(row).addClass('tr-completed-work');
					}
				}

			});

			// Store current row for AJAX
    var currentRow = null;

	 $('#btnViewRequestAppList').click(function() {
			$("#job_request_app_tbl").DataTable().destroy();

		

			$("#requestappModal").modal('show');

			$.ajax({

				type : "POST",
					url : "Case_Management_Serv",
					data : {
						request_type : 'load_request_application_batched_to_user',
					},
					cache : false,
					success : function(jobdetails) {

						var json_p = JSON.parse(jobdetails);

						coor_tbl.search("")
								.draw();
						coor_tbl.state.clear();
						coor_tbl.clear();

						
						$(json_p.data)
							.each(
									function() {

										coor_tbl.row.add([
    this.job_number || '',
    this.ar_name || '',
    this.business_process_sub_name || '',
    this.job_purpose || '',
    this.officer_comments || '',
    this.job_forwarded_by || '',
    this.job_datesend || '',
    // Column 8: Actions
    '<div class="btn-group btn-group-sm">' +
        // Work button (existing form)
        '<form action="request_application_progress_details_ai" method="post" class="d-inline">' +
            '<input type="hidden" name="case_number" value="' + (this.transaction_number || '') + '">' +
            '<input type="hidden" name="transaction_number" value="' + (this.transaction_number || '') + '">' +
            '<input type="hidden" name="review_instruction" value="' + (this.remarks || '') + '">' +
            '<input type="hidden" name="job_number" value="' + (this.job_number || '') + '">' +
            '<input type="hidden" name="job_purpose" value="' + (this.job_purpose || '') + '">' +
            '<input type="hidden" name="review_type" value="MainWorkFlow">' +
            '<input type="hidden" name="business_process_sub_name" value="' + (this.business_process_sub_name || '') + '">' +
            '<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1">' +
                '<span class="icon text-white-50"><i class="fas fa-folder-open"></i></span>' +
                '<span class="text">Work</span>' +
            '</button>' +
        '</form>' +
        // Complete Request button
        '<button class="btn btn-success btn-icon-split btn-complete-request" ' +
            'data-job_number="' + (this.job_number || '') + '" ' +
			 'data-rq_id="' + (this.rq_id || '') + '" ' +
            'data-transaction_number="' + (this.transaction_number || '') + '">' +
            '<span class="icon text-white-50"><i class="fas fa-check"></i></span>' +
            '<span class="text">Complete</span>' +
        '</button>' +
    '</div>'
]).draw(false);
										coor_tbl
												.column(
														2)
												.data()
												.sort();

									});

					}
				})
	  
});



// Handle Complete Request button click
    coor_tbl.on('click', '.btn-complete-request', function() {
        currentRow = coor_tbl.row($(this).closest('tr'));
        var job_number = $(this).data('job_number');
		 var rq_id = $(this).data('rq_id');
        var transaction_number = $(this).data('transaction_number');
		console.log('Values from Form')
		console.log(job_number)
		console.log(rq_id)
		console.log(transaction_number)

        // Show toast
        $('#completeRequestToast').toast('show');
    });

	// Handle Yes button in toast
    $('#confirmCompleteYes').on('click', function() {
        if (currentRow) {
            var job_number = currentRow.data().job_number;
            var rq_id = currentRow.data().rq_id;
			 var transaction_number = currentRow.data().transaction_number;

            $.ajax({
               type : "POST",
					url : "valueadded_services_serv",
					data : {
						request_type : 'select_set_request_as_completed',
						rq_id : rq_id,
						job_number : job_number,
						transaction_number : transaction_number,
					},
              
              
                success: function(response) {
                   console.log(response)
										if (!response) {
										showError("No response from the agent. Please try again.");
										return;
										}
					var response_p = JSON.parse(response);
								
					
					if (response_p.success) {
                        // Show success toast
                        $('#completeRequestToast').toast('hide');
                        showToast('Success', response_p.msg || 'Request completed successfully', 'success');
                        // Remove row from table
                        currentRow.remove().draw(false);
                    } else {
                        $('#completeRequestToast').toast('hide');
                        showToast('Error', response_p.msg || 'Failed to complete request', 'danger');
                    }
                    currentRow = null;
                },
                error: function(xhr) {
                    $('#completeRequestToast').toast('hide');
                    showToast('Error', xhr.responseJSON?.msg || 'Server error occurred', 'danger');
                    currentRow = null;
                }
            });
        }
    });

	// Handle No button in toast
    $('#confirmCompleteNo').on('click', function() {
        $('#completeRequestToast').toast('hide');
        currentRow = null;
    });

    // Helper function to show toast
    function showToast(title, message, type) {
        var toastHtml = `
            <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="3000" style="position: fixed; top: 20px; right: 20px; z-index: 1050;">
                <div class="toast-header bg-${type} text-white">
                    <strong class="mr-auto">${title}</strong>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="toast-body">
                    ${message}
                </div>
            </div>`;
        $('body').append(toastHtml);
        $('.toast').last().toast('show').on('hidden.bs.toast', function() {
            $(this).remove();
        });
    }

});