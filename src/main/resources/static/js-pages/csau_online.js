$(document)
	.ready(
		function () {

			var datatable_gra_reports = $("#tbl_stamp_duty_result")
				.DataTable({
					dom: 'Bfrtip',
					buttons: [
						'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
					]
				});
			var datatable_gra_rec_reports = $("#tbl_stamp_duty_confirmed_result")
				.DataTable({
					dom: 'Bfrtip',
					buttons: [
						'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
					]
				});

			$("#btn_upload_regional_by_csv").prop('disabled', true);
			$("#btn_process_bulk_regional_number").prop('disabled',
				true);

			$("#smartwizardCSAUModal")
				.on(
					"leaveStep",
					function (e, anchorObject, stepNumber,
						stepDirection) {

						/*
						 * confirm("Do you want to leave the
						 * step " + stepNumber + "?");
						 * 
						 * 
						 * 
						 */

						if (stepNumber == 0) {
							var lenghtOfUnchecked = $(
								'#tbl_not_on_case_after_payment_ap_checklist_dataTable')
								.find(
									"input:checkbox:not(:checked)").length
							if (lenghtOfUnchecked > 0) {
								alert("Please ensure all checklist are met!");
								return false;
							}

						} else {
							return true;
						}

						if (stepNumber == 3) {
							if (document
								.getElementById("fileUploadFormatCSAU").files.length == 0) {
								console
									.log("No files selected for Upload. Please select a pdf file");
								alert("No files selected for Upload. Please select a pdf file");

								return false;
							}

						} else {
							return true;
						}

						// return;

					});

			$("#smartwizardCSAUModalOnCase")
				.on(
					"leaveStep",
					function (e, anchorObject, stepNumber,
						stepDirection) {

						/*
						 * confirm("Do you want to leave the
						 * step " + stepNumber + "?");
						 * 
						 * 
						 * 
						 */

						if (stepNumber == 0) {
							var lenghtOfUnchecked = $(
								'#tbl_on_case_ap_checklist_dataTable')
								.find(
									"input:checkbox:not(:checked)").length
							if (lenghtOfUnchecked > 0) {
								alert("Please ensure all checklist are met!");
								return false;
							}

						} else {
							return true;
						}

						if (stepNumber == 3) {
							if (document
								.getElementById("fileUploadFormatCSAU").files.length == 0) {
								console
									.log("No files selected for Upload. Please select a pdf file");
								alert("No files selected for Upload. Please select a pdf file");

								return false;
							}

						} else {
							return true;
						}

						// return;

					});

			var btnNext = $('<button></button>').text('Next').addClass(
				'btn btn-info').on('click', function () {

					$('#smartwizardCSAUModal').smartWizard("next");
					return true;
				});

			var btnPrevious = $('<button></button>').text('Previous')
				.addClass('btn btn-info').on('click', function () {

					$('#smartwizardCSAUModal').smartWizard("prev");
					return true;

				});

			var new_external_tool_bar = [];

			new_external_tool_bar = [btnPrevious, btnNext];

			$('#smartwizardCSAUModal').smartWizard({
				selected: 0,
				theme: 'arrows',
				transitionEffect: 'fade',
				showStepURLhash: false,

				toolbarSettings: {
					toolbarPosition: 'bottom',
					toolbarButtonPosition: 'end',
					showNextButton: false, // show/hide a Next button
					showPreviousButton: false, // show/hide a Previous
					// button
					// toolbarExtraButtons: [btnFinish,btnQuery,
					// btnCancel]
					toolbarExtraButtons: new_external_tool_bar
				},
				anchorSettings: {
					anchorClickable: false, // Enable/Disable anchor
					// navigation
					enableAllAnchors: false, // Activates all anchors
					// clickable all times
					markDoneStep: false, // add done css
					enableAnchorOnDoneStep: false
					// Enable/Disable the done steps navigation
				},

			});

			var btnNextOnCase = $('<button></button>').text('Next')
				.addClass('btn btn-info').on(
					'click',
					function () {

						$('#smartwizardCSAUModalOnCase')
							.smartWizard("next");
						return true;
					});

			var btnPreviousOnCase = $('<button></button>').text(
				'Previous').addClass('btn btn-info').on(
					'click',
					function () {

						$('#smartwizardCSAUModalOnCase').smartWizard(
							"prev");
						return true;

					});

			var new_external_tool_barOnCase = [];

			new_external_tool_barOnCase = [btnPreviousOnCase,
				btnNextOnCase];

			$('#smartwizardCSAUModalOnCase').smartWizard({
				selected: 0,
				theme: 'arrows',
				transitionEffect: 'fade',
				showStepURLhash: false,

				toolbarSettings: {
					toolbarPosition: 'bottom',
					toolbarButtonPosition: 'end',
					showNextButton: false, // show/hide a Next button
					showPreviousButton: false, // show/hide a Previous
					// button
					// toolbarExtraButtons: [btnFinish,btnQuery,
					// btnCancel]
					toolbarExtraButtons: new_external_tool_barOnCase
				},
				anchorSettings: {
					anchorClickable: false, // Enable/Disable anchor
					// navigation
					enableAllAnchors: false, // Activates all anchors
					// clickable all times
					markDoneStep: false, // add done css
					enableAnchorOnDoneStep: false
					// Enable/Disable the done steps navigation
				},

			});

			$('#signUpForm')
				.on(
					'submit',
					function (e) {

						// validation code here
						e.preventDefault();

						var cl_first_name = $("#cl_first_name")
							.val()
						var cl_other_names = $(
							"#cl_other_names").val();

						var cl_last_name = $("#cl_last_name")
							.val();
						var cl_email = $("#cl_email").val();
						var cl_country = $("#cl_country").val();
						var cl_address = $("#cl_address").val();
						var cl_phone = $("#cl_phone").val();
						var cl_gender = $("#cl_gender").val();
						var cl_tin = $("#cl_tin").val();
						var cl_id_type = $("#cl_id_type").val();
						var cl_id_number = $("#cl_id_number")
							.val();
						var cl_contact_person = $(
							"#cl_contact_person").val();
						var cl_contact_person_phone = $(
							"#cl_contact_person_phone")
							.val();
						// var cl_id_number =
						// $("#cl_id_number").val();

						$
							.ajax({
								type: "POST",
								url: "csau_mgt_serv",
								// target:'_blank',

								data: {
									request_type: 'select_portal_users_add_update',
									cl_first_name: cl_first_name,
									cl_other_names: cl_other_names,
									cl_last_name: cl_last_name,
									cl_email: cl_email,
									cl_country: cl_country,
									cl_address: cl_address,
									cl_phone: cl_phone,
									cl_gender: cl_gender,
									cl_tin: cl_tin,
									cl_id_type: cl_id_type,
									cl_id_number: cl_id_number,
									cl_contact_person: cl_contact_person,
									cl_contact_person_phone: cl_contact_person_phone,
									// office_region :
									// office_region,
									submission_type: 'Online'
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									//console.log(jobdetails);
									alert(jobdetails);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									/*
									 * var blob = new Blob([
									 * jobdetails ], { type :
									 * "application/pdf" });
									 * var objectUrl =
									 * URL.createObjectURL(blob);
									 * window.open(objectUrl);
									 */

									location.reload();

									$('#createUserModal')
										.modal('hide');

								}
							});

					});

			/*
			 * $('#client_by_email_phone_search').on('click',
			 * 
			 * nction(e) { var id = $(e.target).closest('tr').fi
			 * ").html();
			 * 
			 * console.log(id) })
			 */

			$('#btnFindClientDetails')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#client_by_email_phone_search")
							.val();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)
							&& client_phone_search != '123') {
							// $
							// 		.notify(
							// 				{
							// 					message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
							// 				}, {
							// 					type : 'danger' , z_index: 9999 
							// 				});

							// swal.fire({
							// 					title: 'Error Alert',
							// 					text: 'Please enter valid search value',
							// 					icon: 'error',
							// 					confirmButtonText: 'OK'
							// 				})

							if (!client_phone_search) {
								showValidationError('Please enter valid search value', '#client_by_email_phone_search');
								return;
							}

							return;
						}

						var $this = $('#btnFindClientDetails');
						var loadingText = '<span class=""><i class="mdi mdi-spin mdi-loading me-1"></i>Loading...</span>';

						if ($('#btnFindClientDetails').html() !== loadingText) {
							$this.data('original-text', $('#btnFindClientDetails').html());
							$this.html(loadingText);
							$('#btnFindClientDetails').prop('disabled', true);
						}

						$
							.ajax({
								type: "POST",
								url: "csau_mgt_serv",
								// target:'_blank',

								data: {
									request_type: 'select_portal_users_by_email',
									search_by: client_phone_search,
									submission_type: 'Online'
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									// console.log(jobdetails);
									// alert(jobdetails);

									var table = $('#clientsearchlist_dataTable');
									table.find("tbody tr")
										.remove();

									// console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									if (json_p.data === null) {
										// createUserModal
										// $(
										// 		"#createUserModal")
										// 		.modal(
										// 				"show");
										// return;

										// alert("Sorry! Client's email or phone number does not exist.");

										swal.fire({
											title: 'Search Alert',
											text: 'Client does not exist. Please try again.',
											icon: 'warning',
											confirmButtonText: 'OK'
										})

										$this.html($this.data('original-text'));
										$this.prop('disabled', false);
									}

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.first_name
														+ ' '
														+ this.other_names
														+ ' '
														+ this.last_name
														+ "</td><td>"
														+ this.email
														+ "</td><td>"
														+ this.type
														+ "</td><td>"
														+ this.phone
														+ "</td><td>"
														+ this.address
														+ "</td>"

														/*
														 * + '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button
														 * class="btn
														 * btn-success
														 * btn-circle
														 * btn-sm"
														 * data-title="Delete"
														 * data-toggle="modal"
														 * data-target="#accountDetailsModal" ' +
														 * 'data-pu_name="' +
														 * this.name + '" ' +
														 * 'data-pu_email="' +
														 * this.email + '" ' +
														 * 'data-pu_country="' +
														 * this.country + '" ' +
														 * 'data-pu_account_number="' +
														 * this.account_number + '" ' +
														 * 'data-pu_type="' +
														 * this.type + '" ' +
														 * 'data-pu_address="' +
														 * this.address + '"
														 * id="deletedew"><span
														 * class="fas
														 * fa-check"></span></button></p>
														 * </td>'
														 */

														+ '<td class="text-end"><button title="Create New Job" class="btn btn-success btn-icon-split btn-sm" data-bs-toggle="modal" data-bs-target="#addNewserviceBillModal" '
														+ 'data-pu_name="'
														+ this.first_name
														+ ' '
														+ this.other_names
														+ ' '
														+ this.last_name
														+ '" '
														+ 'data-pu_email="'
														+ this.email
														+ '" '
														+ 'data-pu_country="'
														+ this.country
														+ '" '
														+ 'data-pu_account_number="'
														+ this.account_number
														+ '" '
														+ 'data-pu_type="'
														+ this.type
														+ '" '
														+ 'data-pu_address="'
														+ this.address
														+ '">'
														+ '<span class="icon text-white-50"> <i class="fas fa-plus"></i></span></button>'

														+ '<button title="Link Job to Client" class="btn btn-info btn-icon-split ms-2 btn-sm" data-bs-toggle="modal" data-bs-target="#linkaccounttoJobsModal" '
														+ 'data-pu_name="'
														+ this.first_name
														+ ' '
														+ this.other_names
														+ ' '
														+ this.last_name
														+ '" '
														+ 'data-pu_email="'
														+ this.email
														+ '" '
														+ 'data-pu_country="'
														+ this.country
														+ '" '
														+ 'data-pu_account_number="'
														+ this.account_number
														+ '" '
														+ 'data-pu_type="'
														+ this.type
														+ '" '
														+ 'data-pu_address="'
														+ this.address
														+ '">'
														+ '<span class="icon text-white-50"> <i class="fas fa-check"></i></span></button> </td>'

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

									$this.html($this.data('original-text'));
									$this.prop('disabled', false);

									searchClientErrorAlert.style.display = 'none';
								}
							});

					});





			$('#btnFindClientDetailsManualBill')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#client_by_email_phone_search_mb")
							.val();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)
							&& client_phone_search != '123') {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						let request_type;
						const keywords = ["LVD", "PVLMD", "LRD"];

						if (keywords.some(keyword => client_phone_search.includes(keyword))) {
							request_type = 'select_portal_users_by_job_number'
						} else {
							request_type = 'select_portal_users_by_email'
						}

						$.ajax({
							type: "POST",
							url: "csau_mgt_serv",
							// target:'_blank',

							data: {
								request_type: request_type,
								search_by: client_phone_search,
								submission_type: 'Online'
							},
							cache: false,
							// responseType:
							// 'arraybuffer',
							// dataType:'blob',
							/*
							 * xhrFields : { responseType :
							 * 'blob' },
							 */
							beforeSend: function () {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
							success: function (
								jobdetails) {

								var table = $('#clientsearchlistManualBills_dataTable');
								table.find("tbody tr")
									.remove();

								// console.log(jobdetails);

								var json_p = JSON
									.parse(jobdetails);

								if (json_p.data === null) {
									// createUserModal
									$("#createUserModal").modal("show");
									return;
								}

								$(json_p.data)
									.each(
										function () {


											table
												.append("<tr><td>"
													+ this.first_name
													+ ' '
													+ this.other_names
													+ ' '
													+ this.last_name
													+ "</td><td>"
													+ this.email
													+ "</td><td>"
													+ this.type
													+ "</td><td>"
													+ this.phone
													+ "</td><td>"
													+ this.address
													+ "</td>"


													+ '<td class="text-end"><button title="Create New Bill" class="btn btn-info label-btn" data-bs-toggle="modal" data-bs-target="#generateManualBillModal" '
													+ 'data-pu_name="'
													+ this.first_name
													+ ' '
													+ this.other_names
													+ ' '
													+ this.last_name
													+ '" '
													+ 'data-pu_email="'
													+ this.email
													+ '" '
													+ 'data-pu_country="'
													+ this.country
													+ '" '
													+ 'data-pu_account_number="'
													+ this.account_number
													+ '" '
													+ 'data-pu_type="'
													+ this.type
													+ '" '
													+ 'data-pu_address="'
													+ this.address
													+ '">'
													+ ' <i class="ri-add-line label-btn-icon me-2"></i> Generate Bill </button> </td>'
													+ "</tr>");

													

										});

							}
						});

					});


// Clear form button
    $('#btnClearManualBillForm').on('click', function() {
        Swal.fire({
            title: 'Clear Form?',
            text: 'Are you sure you want to clear all form fields?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, clear all',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                form[0].reset();
                form.removeClass('was-validated');
                $('#manualbillblobfile').attr('src', '');
                
                // Clear validation classes and reset selects
                form.find('.form-control, .form-select').removeClass('is-invalid');
                $('#mbm_sub_service_cp').html('<option value="" selected disabled>Select Sub Service</option>').prop('disabled', true);
            }
        });
    });

			$('#btnFindClientDetailsRegionalTransitionalBill')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#client_by_email_phone_search_mb")
							.val();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)
							&& client_phone_search != '123') {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						$.ajax({
							type: "POST",
							url: "csau_mgt_serv",
							// target:'_blank',

							data: {
								request_type: 'select_portal_users_by_email',
								search_by: client_phone_search,
								submission_type: 'Online'
							},
							cache: false,
							// responseType:
							// 'arraybuffer',
							// dataType:'blob',
							/*
							 * xhrFields : { responseType :
							 * 'blob' },
							 */
							beforeSend: function () {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
							success: function (
								jobdetails) {

								var table = $('#clientsearchlistRegionalTransitionalBill_dataTable');
								table.find("tbody tr")
									.remove();

								// console.log(jobdetails);

								var json_p = JSON
									.parse(jobdetails);

								if (json_p.data === null) {
									// createUserModal
									$("#createUserModal").modal("show");
									return;
								}

								$(json_p.data)
									.each(
										function () {


											table
												.append("<tr><td>"
													+ this.first_name
													+ ' '
													+ this.other_names
													+ ' '
													+ this.last_name
													+ "</td><td>"
													+ this.email
													+ "</td><td>"
													+ this.type
													+ "</td><td>"
													+ this.phone
													+ "</td><td>"
													+ this.address
													+ "</td>"


													+ '<td><button title="Create New Bill" class="btn btn-secondary btn-icon-split btn-sm" data-toggle="modal" data-target="#generateRegionalTransitionalBillModal" '
													+ 'data-pu_name="'
													+ this.first_name
													+ ' '
													+ this.other_names
													+ ' '
													+ this.last_name
													+ '" '
													+ 'data-pu_email="'
													+ this.email
													+ '" '
													+ 'data-pu_country="'
													+ this.country
													+ '" '
													+ 'data-pu_account_number="'
													+ this.account_number
													+ '" '
													+ 'data-pu_type="'
													+ this.type
													+ '" '
													+ 'data-pu_address="'
													+ this.address
													+ '">'
													+ '<span class="icon text-white-50"> <i class="fas fa-plus"></i></span> <span class="text"> Add New Manual Bill </span></button> </td>'
													+ "</tr>");

										});

							}
						});

					});



			$('#btn_load_bill_details_after_payment')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_ref_number_for_payment")
							.val();

						if (!client_phone_search) {
							showValidationError('Please enter a reference number', '#txt_ref_number_for_payment');
							return;
						}

						$
							.ajax({
								type: "POST",
								url: "payment_serv",
								// target:'_blank',

								data: {
									request_type: 'lc_payment_verification_for_bill_revised',
									ref_number: client_phone_search
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									// console.log('jjj'+jobdetails);
									// alert(jobdetails);

									var table = $('#bill_for_payment_list_dataTable');
									table.find("tbody tr")
										.remove();

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);

									if (json_p.data == null) {
										swal.fire({
											title: 'Ops!',
											text: 'Bill not found. Check and try again.',
											icon: 'warning',
											confirmButtonText: 'OK'
										})
									}

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 
												// console.log(this.payment_confiration_status);
												if (this.payment_confiration_status === 0) {
													// alert('Bill has not been paid. It cannot be acknowledge')
													Swal.fire({
														title: 'Ops!',
														text: 'Bill has not been paid. It cannot be acknowledged.',
														icon: 'warning',
														confirmButtonText: 'OK'
													});

												} else {
													if (this.bill_number !== 'Not Case') {
														table
															.append("<tr><td>"
																+ this.ref_number
																+ "</td><td>"
																+ this.lessees_name
																+ "</td><td>"
																+ this.bill_amount
																+ "</td>"

																// + '<td><p data-placement="top" data-toggle="tooltip" title="Initiate Digital Payment">'
																// + '<button data-backdrop="static" data-keyboard="false" class="btn btn-danger '
																// + '" data-title="Initiate Digital Payment" data-toggle="modal" data-target="#servicePayment" '
																// + 'data-ref_number="'
																// + this.ref_number
																// + '" '
																// + 'data-ar_name="'
																// + this.lessees_name
																// + '" '
																// + 'data-locality="'
																// + this.locality
																// + '" '
																// + 'data-bill_amount="'
																// + this.bill_amount
																// + '" ><span class="fas fa-coins"></span> Pay</button></p> </td>'

																+ '<td class="text-center"><span class="badge bg-success"><i class="fas fa-check-circle me-2"></i>Paid</span></td>'

																+ '<td class="text-end"><p data-placement="top" data-toggle="tooltip" title="Acknowledge Bill">'
																+ '<button class="btn btn-info" data-title="Acknowledge Bill" data-backdrop="static" '
																+ 'data-keyboard="false" data-bs-toggle="modal" data-bs-target="#afterPaymentModalonCase" '
																+ 'data-ref_number="'
																+ this.ref_number
																+ '" '
																+ 'data-ar_name="'
																+ this.lessees_name
																+ '" '
																+ 'data-transaction_number="'
																+ this.bill_number
																+ '" '
																+ 'data-business_process_id="'
																+ this.business_process_id
																+ '" '
																+ 'data-business_process_name="'
																+ this.business_process_name
																+ '" '
																+ 'data-business_process_sub_id="'
																+ this.business_process_sub_id
																+ '" '
																+ 'data-locality="'
																+ this.locality
																+ '" '
																+ 'data-business_process_sub_name="'
																+ this.business_process_sub_name
																+ '" '
																+ 'data-bill_amount="'
																+ this.bill_amount

																+ '" id="deletedew"><span class="fas fa-arrow-right"></span> Acknowledge</button></p> </td>'

																+ "</tr>");
													} else {
														table
															.append("<tr><td>"
																+ this.ref_number
																+ "</td><td>"
																+ this.lessees_name
																+ "</td><td>"
																+ this.bill_amount
																+ "</td>"

																// + '<td class="text-center"><p data-placement="top" data-toggle="tooltip" title="Initiate Digital Payment"><button data-backdrop="static" class="btn btn-danger " data-title="Initiate Digital Payment" data-toggle="modal" data-target="#servicePayment" '
																// + 'data-ref_number="'
																// + this.ref_number
																// + '" '
																// + 'data-ar_name="'
																// + this.lessees_name
																// + '" '
																// + 'data-bill_amount="'
																// + this.bill_amount
																// + '" ><span class="fas fa-coins"></span> Pay</button></p></td>'

																+ '<td class="text-center"><span class="badge bg-success"><i class="fas fa-check-circle me-2"></i>Paid</span></td>'

																+ '<td class="text-end"><p data-placement="top" data-bs-toggle="tooltip" title="Acknowledge Bill"><button class="btn btn-info" data-title="Acknowledge Bill" data-bs-toggle="modal" data-bs-target="#NotoncaseafterPaymentModalonCase" '
																+ 'data-ref_number="'
																+ this.ref_number
																+ '" '
																+ 'data-ar_name="'
																+ this.lessees_name
																+ '" '
																+ 'data-bill_amount="'
																+ this.bill_amount

																+ '" ><span class="fas fa-arrow-right"></span> Acknowledge</button></p> </td>'

																+ "</tr>");
													}
												}

											});

								}
							});

					});

			$('#btn_load_bill_details_after_payment_stamp_duty_csau').on('click', function (e) {

				var client_phone_search = $(
					"#txt_ref_number_for_payment")
					.val();

				$
					.ajax({
						type: "POST",
						url: "payment_serv",
						// target:'_blank',

						data: {
							request_type: 'lc_payment_verification_for_bill_revised',
							ref_number: client_phone_search
						},
						cache: false,

						beforeSend: function () {

						},
						success: function (
							jobdetails) {
							// console.log(jobdetails);
							// alert(jobdetails);

							var table = $('#stamp_duty_bill_list_dataTable');
							table.find("tbody tr")
								.remove();

							//console.log(jobdetails);
							try {
								var json_p = JSON
									.parse(jobdetails);

								$(json_p.data)
									.each(
										function () {

											// console.log(this.payment_confiration_status);
											if (this.payment_confiration_status === 0) {
												alert('Bill has not been paid. It cannot be acknowledge')
											} else {
												$('#payment_details_section').html(`
																			
																			<hr>
																          	<h3>Bill Details</h3>
																          	<hr>
																          	
																			  <div class="form-group row">
																			  <div class="col-sm-6">
																			  	  <label  class="form-label">Bill Number</label>
																			      <input type="text" disabled class="form-control"  value="${this.ref_number}">
																			    </div>
																			    
																			    <div class="col-sm-6">
																			      <label  class="form-label">Bill Amount</label>
																			      <input type="text" disabled class="form-control"  value="${this.bill_amount}">
																			    </div>
																			  </div>
																			  <div class="form-group row">
																			    <label class="col form-label">Applicant Name</label>
																			    <div class="col-sm-12">
																			      <input type="text" disabled class="form-control"  value="${this.lessees_name}">
																			    </div>
																			  </div>
																			  
																			 
																			  <hr>
																          	<h3>Payment Details <span class="badge badge-pill badge-success p-3 mr-10"> Paid </span></h3>
																          	<hr>
																			  
																			  
																			  
																			  <div class="form-group row">
																			    <label  class="col-sm-4 col-form-label">Payment Date</label>
																			    <div class="col-sm-8">
																			      <input type="text" disabled class="form-control"  value="${this.payment_date}">
																			    </div>
																			  </div>
																			  <div class="form-group row">
																			    <label class="col-sm-4 col-form-label">Payment Amount</label>
																			    <div class="col-sm-8">
																			      <input type="text" disabled class="form-control"  value="${this.payment_amount}">
																			    </div>
																			  </div>
																			  
																			  
																			  <div class="form-group row">
																			    <label  class="col-sm-4 col-form-label">Payment Mode </label>
																			    <div class="col-sm-8">
																			      <input type="text" disabled class="form-control"  value="${this.payment_mode}">
																			    </div>
																			  </div>
																			  <div class="form-group row">
																			    <label class="col-sm-4 col-form-label">Payment Bank</label>
																			    <div class="col-sm-8">
																			      <input type="text" disabled class="form-control"  value="${this.payment_bank}">
																			    </div>
																			  </div>
																			  
																			  <div class="form-group row">
																			    <label class="col-sm-4 col-form-label">GH.gov Ref number</label>
																			    <div class="col-sm-8">
																			      <input type="text" disabled class="form-control"  value="${this.checkout_id}">
																			    </div>
																			  </div>
																			  
																			  <div class="form-group row">
																			    
																			    <div class="col-sm-12">
																			    	<button  data-keyboard="false" class="confirmPaymentDetails btn btn-danger btn-block  p-3 col"
																					data-title="Recieve Document"  
																					data-ref_number=${this.ref_number} data-job_number="${this.job_number}" 
																					data-business_process_sub_name="APPLICATION FOR STAMPING" id="confirmPaymentDetails"
																					>
																					Confirm Payment Against Stamp Duty Payable
																					</button>
																			    </div>
																			  </div>
																			  
																			  
																			  
																			  
																			`);


											}

										});



							} catch (e) {
								console.log(e)
							}


						}
					});


			});

			$('#payment_details_section').on('click', '.confirmPaymentDetails', function (e) {
				var ref_number = $(this).data("ref_number");
				var job_number = $(this).data("job_number");
				// console.log("iii")


				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'lc_regional_stamp_duty_bill_log',
						job_number: job_number,
						ref_number: ref_number
					},
					cache: false,
					beforeSend: function () {
						// $('#district').html('<img
						// src="img/loading.gif" alt="" width="24"
						// height="24">');
					},
					success: function (jobdetails) {

						var json_p = JSON.parse(jobdetails);
						console.log(json_p.msg)
						if (json_p.msg.includes("success")) {


							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Confirmation of bill #' + ref_number + ' Successful </span>',
							}, {
								type: 'success', z_index: 9999
							});
							setTimeout(function () {
								alert('Reloading Page');
								location.reload(true);
							}, 5000);
						} else {
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">!Error. Somthing went wrong. Please try again </span>',
							}, {
								type: 'danger', z_index: 9999
							});

							setTimeout(function () {
								alert('Reloading Page');
								location.reload(true);
							}, 5000);
						}


					}
				});



			});




			$('#btn_load_bill_details_after_payment_stamp_duty_receive').on('click', function (e) {

				var client_phone_search = $(
					"#txt_ref_number_for_payment_rec").val();


				$
					.ajax({
						type: "POST",
						url: "payment_serv",
						// target:'_blank',

						data: {
							request_type: 'lc_payment_verification_for_bill_stamping',
							ref_number: client_phone_search
						},
						cache: false,

						beforeSend: function () {

						},
						success: function (
							jobdetails) {
							// console.log(jobdetails);
							// alert(jobdetails);

							var table = $('#stamp_duty_bill_list_dataTable');
							table.find("tbody tr")
								.remove();

							// console.log(jobdetails);
							try {
								var json_p = JSON
									.parse(jobdetails);

								$(json_p.data)
									.each(
										function () {

											// console.log(this);
											if (this.payment_confiration_status === 0 || this.payment_confiration_status == null) {
												alert('Bill has not been paid. It cannot be acknowledge')
											} else {

												// get case number
												// from job_number
												$('#document-section').show();

												$('#payment_details_section').html(`
																	
																	<hr>
														          	<h3>Bill Details</h3>
														          	<hr>
														          	 <input type="hidden" id="business_process_sub_name" value="${this.business_process_sub_name_actual}" >
														          	  <input type="hidden" id="cs_main_case_number" value="${this.case_number}" >
																	  <div class="form-group row">
																	  <div class="col-sm-6">
																	  	  <label  class="form-label">Bill Number</label>
																	      <input type="text" disabled class="form-control"  value="${this.ref_number}">
																	    </div>
																	    
																	    <div class="col-sm-6">
																	      <label  class="form-label">Bill Amount</label>
																	      <input type="text" disabled class="form-control"  value="${this.bill_amount}">
																	    </div>
																	  </div>
																	  <div class="form-group row">
																	    <label class="col form-label">Applicant Name</label>
																	    <div class="col-sm-12">
																	      <input type="text" disabled class="form-control"  value="${this.lessees_name}">
																	    </div>
																	  </div>
																	  
																	 
																	  <hr>
														          	<h3>Payment Details <span class="badge badge-pill badge-success p-3 mr-10"> Paid </span></h3>
														          	<hr>
																	  
																	  
																	  
																	  <div class="form-group row">
																	    <label  class="col-sm-4 col-form-label">Payment Date</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_date}">
																	    </div>
																	  </div>
																	  <div class="form-group row">
																	    <label class="col-sm-4 col-form-label">Payment Amount</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_amount}">
																	    </div>
																	  </div>
																	  
																	  
																	  <div class="form-group row">
																	    <label  class="col-sm-4 col-form-label">Payment Mode </label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_mode}">
																	    </div>
																	  </div>
																	  <!--div class="form-group row">
																	    <label class="col-sm-4 col-form-label">Payment Bank</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_bank}">
																	    </div>
																	  </div-->
																	  
																	  <div class="form-group row">
																	    <label class="col-sm-4 col-form-label">GH.gov Ref number</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.checkout_id}">
																	    </div>
																	  </div>
																	  
																	  <div class="form-group row">
																	    
																	    <div class="col-sm-12">
																	    	<button data-backdrop="static" data-keyboard="false" class="receiveDocument btn btn-danger btn-block  p-3 col"
																			data-title="Recieve Document" data-toggle="modal" data-target="#receiveDocsStampingModal" 
																			data-ref_number=${this.ref_number} data-ar_name="${this.lessees_name}" 
																			data-business_process_sub_name="${this.business_process_sub_name_actual}" data-job_number="${this.job_number}"
																			>
																			Receive Hardcopy document for Stamping
																			</button>
																	    </div>
																	  </div>
																	`);
											}
										});

							} catch (e) {
								console.log(e)
							}


						}
					});

			});

			$('#btn_load_bill_details_after_payment_stamp_duty').on('click', function (e) {
				$('#payment_details_section').html('');
				var client_phone_search = $(
					"#txt_ref_number_for_payment_rec").val();
				// console.log(client_phone_search);


				$

					.ajax({
						type: "POST",
						url: "payment_serv",
						// target:'_blank',

						data: {
							request_type: 'lc_payment_verification_for_bill_stamping',
							ref_number: client_phone_search
						},
						cache: false,

						beforeSend: function () {

						},
						success: function (
							jobdetails) {
							//console.log(jobdetails);
							// alert(jobdetails);

							var table = $('#stamp_duty_bill_list_dataTable');
							table.find("tbody tr")
								.remove();

							// console.log(jobdetails);
							try {
								var json_p = JSON
									.parse(jobdetails);

								$(json_p.data)
									.each(
										function () {

											if (this.payment_confiration_status === 0 || this.payment_confiration_status == null) {
												$('#btnPrintEgcr2').data('ref_number', this.ref_number);
												$('#btnPrintEgcr2').html("Check for Payment details from Online");
												alert('Bill has not been paid. It cannot be acknowledge');
												$('#document-section').show();
											} else {

												// get case number
												// from job_number
												$('#document-section').show();
												$('#btnPrintEgcr2').data('ref_number', this.ref_number);

												$('#btnPrintEgcr2').html("View eGCR");
												$('#payment_details_section').html(`
																	
																	<hr>
														          	<h3>Bill Details</h3>
														          	<hr>
														          	 <input type="hidden" id="business_process_sub_name" value="${this.business_process_sub_name_actual}" >
														          	  <input type="hidden" id="cs_main_case_number" value="${this.case_number}" >
																	  <div class="form-group row">
																	  <div class="col-sm-6">
																	  	  <label  class="form-label">Bill Number</label>
																	      <input type="text" disabled class="form-control"  value="${this.ref_number}">
																	    </div>
																	    
																	    <div class="col-sm-6">
																	      <label  class="form-label">Bill Amount</label>
																	      <input type="text" disabled class="form-control"  value="${this.bill_amount}">
																	    </div>
																	  </div>
																	  <div class="form-group row">
																	    <label class="col form-label">Applicant Name</label>
																	    <div class="col-sm-12">
																	      <input type="text" disabled class="form-control"  value="${this.lessees_name}">
																	    </div>
																	  </div>
																	  
																	 
																	  <hr>
														          	<h3>Payment Details <span class="badge badge-pill badge-success p-3 mr-10"> Paid </span></h3>
														          	<hr>
																	  
																	  
																	  
																	  <div class="form-group row">
																	    <label  class="col-sm-4 col-form-label">Payment Date</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_date}">
																	    </div>
																	  </div>
																	  <div class="form-group row">
																	    <label class="col-sm-4 col-form-label">Payment Amount</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_amount}">
																	    </div>
																	  </div>
																	  
																	  
																	  <div class="form-group row">
																	    <label  class="col-sm-4 col-form-label">Payment Mode </label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_mode}">
																	    </div>
																	  </div>
																	  <!--div class="form-group row">
																	    <label class="col-sm-4 col-form-label">Payment Bank</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.payment_bank}">
																	    </div>
																	  </div-->
																	  
																	  <div class="form-group row">
																	    <label class="col-sm-4 col-form-label">GH.gov Ref number</label>
																	    <div class="col-sm-8">
																	      <input type="text" disabled class="form-control"  value="${this.checkout_id}">
																	    </div>
																	  </div>

																	  <div class="form-group row">
																	  <label class="col-sm-4 col-form-label">Receipt Number</label>
																	  <div class="col-sm-8">
																		<input type="text" disabled class="form-control" id="lbl_payment_slip_number_for_egcr" value="${this.payment_slip_number}">
																	  </div>
																	</div>
																	  
																	  <div class="form-group row">
																	    
																	   
																	  </div>
																	`);
											}
										});

							} catch (e) {
								console.log(e)
							}


						}
					});

			});

			$('.txt-action-rec').on('click', function (e) {

				e.preventDefault();
				console.log("clicked me" + $(this).attr('value'))
				$('#smtp_document_description').val($('#smtp_document_description').val().length > 1 ? $('#smtp_document_description').val() + ", " + $(this).attr('value') : $(this).attr('value'));

			});

			$('#frmReceiveDocsStamping').on('submit', function (e) {

				e.preventDefault();
				/* $('#receiveDocsStampingModal').modal("hide"); */

				var job_number = $('#stmp_job_number').val();
				var smtp_depositor_phone = $('#smtp_depositor_phone').val();
				var smtp_depositor_name = $('#smtp_depositor_name').val();
				var smtp_document_description = $('#smtp_document_description').val();
				// console.log(smtp_depositor_phone);
				// console.log(smtp_depositor_name)

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'lc_stamp_duty_document_received',
						job_number: job_number,
						smtp_depositor_phone: smtp_depositor_phone,
						smtp_depositor_name: smtp_depositor_name,
						smtp_document_description: smtp_document_description
					},
					cache: false,
					beforeSend: function () {
						// $('#district').html('<img
						// src="img/loading.gif" alt="" width="24"
						// height="24">');
					},
					success: function (jobdetails) {

						var json_p = JSON.parse(jobdetails);
						// console.log(json_p.msg)
						if (json_p.msg.includes("success")) {

							// $("#btnSumitRecDoc").hide();
							/* $("#btnSumitRecDocSecion").html(
									 
									 `<br><div class="alert alert-success">Record Saved and added to batchlist</div>`
									 
							 );*/

							addJobToBatchlist(job_number, $('#stmp_ar_name').val(), $('#stmp_business_process_sub_name').val(), 'Hard Copy Document Recieved For Further Processing', '');

							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Action Successful </span>',
							}, {
								type: 'success', z_index: 9999
							});
						} else {
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">!Error. Somthing went wrong. Please try again </span>',
							}, {
								type: 'danger', z_index: 9999
							});
						}


					}
				});
			});


			$('#frmStampDutyFilter').on('submit', function (e) {

				e.preventDefault();
				/* $('#receiveDocsStampingModal').modal("hide"); */

				var date_from = $('#md_date_from').val();
				var date_to = $('#md_date_to').val();
				// console.log(smtp_depositor_phone);
				// console.log(smtp_depositor_name)

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'account_report_on_bill_by_dates_gra',
						date_to: date_to,
						date_from: date_from,
					},
					cache: false,
					beforeSend: function () {
						// $('#district').html('<img
						// src="img/loading.gif" alt="" width="24"
						// height="24">');
					},
					success: function (jobdetails) {
						// console.log(jobdetails)
						try {

							var json_p = JSON.parse(jobdetails);

							datatable_gra_reports.search("").draw();
							datatable_gra_reports.state.clear();
							datatable_gra_reports.clear();

							$("#gra_tatal_count").html(new Intl.NumberFormat().format(json_p.summary.total_count));
							$("#gra_tatal_amount").html(new Intl.NumberFormat('en-US', { style: 'currency', currency: 'GHS', }).format(json_p.summary.total_amount));

							$(json_p.data).each(function () {
								datatable_gra_reports.row
									.add([
										this.payment_date || " ",
										this.ref_number || " ",
										this.payment_slip_number || " ",

										this.lessees_name || " ",
										this.payment_amount || " ",
										this.payment_mode || " ",
										this.job_number || " "
									]).draw(false);
							});
						} catch (e) {
							console.log("Error: " + e);
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">!Error. Somthing went wrong. Please try again </span>',
							}, {
								type: 'danger', z_index: 9999
							});
						}
						// console.log(json_p.msg)



					}
				});
			});

			$('#frmStampDutyRecFilter').on('submit', function (e) {

				e.preventDefault();
				/* $('#receiveDocsStampingModal').modal("hide"); */

				var date_from = $('#mr_date_from').val();
				var date_to = $('#mr_date_to').val();
				console.log("date : " + date_from);
				console.log("date_to: " + date_to);

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'account_report_on_received_gra',
						date_to: date_to,
						date_from: date_from,
					},
					cache: false,
					beforeSend: function () {
						// $('#district').html('<img
						// src="img/loading.gif" alt="" width="24"
						// height="24">');
					},
					success: function (jobdetails) {
						console.log("account_report_on_received_gra" + jobdetails);
						try {
							var json_p = JSON.parse(jobdetails);

							datatable_gra_rec_reports.search("").draw();
							datatable_gra_rec_reports.state.clear();
							datatable_gra_rec_reports.clear();

							$("#gra_tatal_rec_count").html(new Intl.NumberFormat().format(parseInt(json_p.data.length)));

							$(json_p.data).each(function () {
								datatable_gra_rec_reports.row
									.add([
										this.created_date || " ",
										this.ref_number || " ",
										this.created_by || " ",
										this.job_number || " "
									]).draw(false);
							});
						} catch (e) {
							console.log("Error: " + e);
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">!Error. Somthing went wrong. Please try again </span>',
							}, {
								type: 'danger', z_index: 9999
							});
						}
						// console.log(json_p.msg)



					}
				});
			});



			$('#receiveDocsStampingModal').on('shown.bs.modal', function (e) {


				$("#stmp_job_number").val($(e.relatedTarget).data("job_number"));
				$("#stmp_business_process_sub_name").val($(e.relatedTarget).data("business_process_sub_name"));
				$("#stmp_ar_name").val($(e.relatedTarget).data("ar_name"));

			});

			$('#receiveDocsStampingModal').on('hide.bs.modal', function (e) {
				location.reload();
			});










			/*================begin of recieve plan approval hard copy js========================
								added on 27/07/2022 by Jude YamoaH */

			$('#btn_load_bill_details_plan_approval_receive').on('click', function () {
				//clear existing search result data
				$('#job_details_section').html('');
				$('#document-section').hide();
				$('#lc_main_scanned_documents_dataTable', '#lc_public_documents_dataTable').find("tbody tr").remove();

				//get search param
				var src_job_number = $("#txt_job_number_for_receive").val() ? $("#txt_job_number_for_receive").val() : '0';

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					// target:'_blank',

					data: {
						request_type: 'online_select_application_details_by_job_number',
						job_number: src_job_number
					},
					cache: true,

					beforeSend: function () {

					},
					success: function (
						jobdetails) {

						// console.log(jobdetails);
						try {
							var json_p = JSON
								.parse(jobdetails);

							$(json_p).each(
								function () {

									// console.log(this.payment_confiration_status);
									$('#document-section').show();

									$('#job_details_section').html(`
															
															<hr>
												          	<h3>Application Details for <span class="text-success">${this.job_number}</span></h3>
												          	<hr>
												          	
												          	<div class="form-group row">
															    <label class="col form-label">Application Type</label>
															    <div class="col-sm-12">
															      <input type="text" disabled class="form-control"  value="${this.business_process_sub_name}">
															    </div>
															  </div>
															  <div class="form-group row">
															    <label class="col form-label">Applicant Name</label>
															    <div class="col-sm-12">
															      <input type="text" disabled class="form-control"  value="${this.ar_name}">
															    </div>
															  </div>
															  <div class="form-group row">
															   
															  <div class="col-sm-6">
															  	  <label  class="form-label">Case Number</label>
															      <input type="text" disabled class="form-control" id="cs_main_case_number" value="${this.case_number}">
															    </div>
															    
															    <div class="col-sm-6">
															      <label  class="form-label">Transaction Number</label>
															      <input type="text" disabled class="form-control"  value="${this.transaction_number}">
															    </div>
															  </div>
															 <br><br>
															  <hr>
															 
															  <div class="form-group row">
																	    
															    <div class="col-sm-12">
															    	<button data-backdrop="static" data-keyboard="false" class="receiveDocument btn btn-danger btn-block  p-3 col"
																	data-title="Recieve Document" data-toggle="modal" data-target="#receiveDocsStampingModal" 
																	data-ref_number=${this.ref_number} data-ar_name="${this.ar_name}" 
																	data-business_process_sub_name="${this.business_process_sub_name}" data-job_number="${this.job_number}"
																	>Receive Hardcopy/Supplementary Document for Stamping</button>
															    </div>
															  </div>
															`);

								});

						} catch (e) {
							$('#job_details_section').html(`<hr>
												          	<h3 class='text-danger'>No Details found for <span class="text-success">${$('#txt_job_number_for_receive').val()}</span></h3>
												          	<hr>`);
							console.log(e)
						}


					}
				});


			});







			//================end of recieve plan approval hard copy js========================//













			$('#btn_load_bill_details_after_payment_change_of_names').on('click', function (e) {

				var chng_ref_number = $("#chng_ref_number_for_payment").val();
				$.ajax({
					type: "POST",
					url: "payment_serv",
					// target:'_blank',

					data: {
						request_type: 'lc_payment_verification_for_name_change',
						ref_number: chng_ref_number
					},
					cache: false,
					success: function (jobdetails) {
						console.log(jobdetails);
						var table = $('#bill_for_payment_list_dataTable_change_of_name');
						table.find("tbody tr").remove();
						var json_p = JSON.parse(jobdetails);

						$(json_p.data).each(function () {
							console.log(this);
							if (this.payment_confiration_status === 0) {
								alert('Bill has not been paid. It cannot be acknowledge')
							} else {

								table.append("<tr><td>" +
									this.ref_number +
									"</td><td>" +
									this.ar_name +
									"</td><td>" +
									this.bill_amount +
									"</td>" +
									'<td><p data-placement="top" data-toggle="tooltip" title="Change Details">' +
									'<button class="btn btn-success"  data-backdrop="static" '

									+
									'data-ref_number="' +
									this.ref_number +
									'" data-ar_name="' +
									this.ar_name +
									'" data-transaction_number="' +
									this.bill_number +
									'" data-business_process_name="' +
									this.business_process_name +
									'" data-locality="' +
									this.locality +
									'" data-business_process_sub_name="' +
									this.business_process_sub_name +
									'" data-bill_amount="' +
									this.bill_amount +
									'" data-district="' +
									this.district +
									'" data-region="' +
									this.region +
									'" id="chng_load_details"><span class="fas fa-download"></span> Load Details</button></p> </td>' +
									"</tr>");

								$('#chng_load_details').on('click', function (e) {
									// console.log("jjj " +
									// $(this).data('region'))
									// e.preventDefault();
									$('#ch_ar_name').val($(this).data('ar_name'));
									$('#new_bill_application_region').val($(this).data('region').toUpperCase());
									// $('#new_bill_application_region').trigger('change');
									$('#new_bill_application_district').append($('<option>', {
										value: $(this).data('district'),
										text: $(this).data('district')
									}))

									$('#new_bill_application_district').val($(this).data('district'));
									$('#new_bill_application_locality').val($(this).data('locality').toUpperCase());
									$('#new_bill_application_transaction').val($(this).data('transaction_number'));


									$('#btnSaveChangeOfNames').show();
								});



							}





						});



					}
				});
			});




			$('#frmChangeofNames').on('submit', function (e) {

				e.preventDefault();
				let ch_ar_name = $('#ch_ar_name').val();
				let ch_region = $('#new_bill_application_region').val();
				let ch_district = $('#new_bill_application_district').val();
				let ch_locality = $('#new_bill_application_locality').val();
				let ch_transaction_number = $('#new_bill_application_transaction').val();

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'update_application_details',
						ar_name: ch_ar_name,
						region: ch_region,
						district: ch_district,
						locality: ch_locality,
						transaction_number: ch_transaction_number

					},


					cache: false,
					beforeSend: function () { },
					success: function (
						jobdetails) {
						// console.log(jobdetails);
						// alert(jobdetails);
						$
							.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Data Changed Successfuly </span>',
							}, {
								type: 'success', z_index: 9999
							});

					}
				});

			});






			$(
				'#btn_load_bill_details_after_payment_bulk_regional_number')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_ref_number_for_brn")
							.val();

						$
							.ajax({
								type: "POST",
								url: "payment_serv",
								// target:'_blank',

								data: {
									request_type: 'lc_payment_verification_for_bill_revised',
									ref_number: client_phone_search
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									// console.log(jobdetails);
									// alert(jobdetails);

									var table = $('#bill_for_payment_list_dataTable');
									table.find("tbody tr")
										.remove();

									//console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 
												console
													.log(this.payment_confiration_status);
												if (this.payment_confiration_status === 0) {
													alert('Bill has not been paid. It cannot be acknowledge');
													$(
														"#btn_upload_regional_by_csv")
														.prop(
															'disabled',
															true);
													$(
														"#btn_process_bulk_regional_number")
														.prop(
															'disabled',
															true);
												} else {
													$(
														"#btn_upload_regional_by_csv")
														.prop(
															'disabled',
															false);
													$(
														"#btn_process_bulk_regional_number")
														.prop(
															'disabled',
															false);
												}

											});

								}
							});

					});

			$('#btnAddNewUser').on('show.bs.modal', function (e) {

				$("#cl_first_name").val([])
				$("#cl_other_names").val();

				$("#cl_last_name").val([]);
				$("#cl_email").val([]);
				$("#cl_country").val([]);
				$("#cl_address").val([]);
				$("#cl_phone").val([]);
				$("#cl_gender").val([]);
				$("#cl_tin").val([]);
				$("#cl_id_type").val([]);
				$("#cl_id_number").val([]);
				$("#cl_contact_person").val([]);
				$("#cl_contact_person_phone").val([]);

			});

			$('#accountDetailsModal').on(
				'show.bs.modal',
				function (e) {

					/*
					 * $("#main_service_id_pf").val(
					 * $(e.relatedTarget).data(
					 * 'business_process_id'));
					 * $("#main_service_desc_pf").val(
					 * $(e.relatedTarget).data(
					 * 'business_process_name'));
					 */
					alert($(e.relatedTarget).data('pu_name'));
					$("#pu_name").val(
						$(e.relatedTarget).data('pu_name'));
					$("#pu_email").val(
						$(e.relatedTarget).data('pu_email'));
					$("#pu_country").val(
						$(e.relatedTarget).data('pu_country'));
					$("#pu_account_number").val(
						$(e.relatedTarget).data(
							'pu_account_number'));
					$("#pu_type").val(
						$(e.relatedTarget).data('pu_type'));
					$("#pu_address").val(
						$(e.relatedTarget).data('pu_address'));

					/*
					 * $ .ajax({ type : "POST", url :
					 * "Case_Management_Serv", data : { request_type :
					 * 'get_lc_sub_service', }, cache : false,
					 * beforeSend : function() { //
					 * $('#district').html('<img //
					 * src="img/loading.gif" // alt="" width="24" //
					 * height="24">'); }, success : function(
					 * jobdetails) {
					 * 
					 * console.log(jobdetails); var json_p = JSON
					 * .parse(jobdetails); var options =
					 * $("#sub_service_on_case_pf"); // var options = //
					 * $("#selector"); options.empty(); options
					 * .append(new Option( "-- Select --", 0));
					 * 
					 * $(json_p) .each( function() {
					 * 
					 * console .log(main_service_id); console
					 * .log(this.business_process_id);
					 * 
					 * if (main_service_id ==
					 * this.business_process_id) { $(
					 * '#sub_service_on_case_pf') .append( '<option
					 * value="' + this.business_process_sub_id + '-' +
					 * this.business_process_sub_name + '">' +
					 * this.business_process_sub_name + '</option>'); }
					 * 
					 * }); // business_process_id } }); $ .ajax({
					 * type : "POST", url : "Case_Management_Serv",
					 * data : { request_type :
					 * 'get_type_of_use_list', }, cache : false,
					 * beforeSend : function() { //
					 * $('#district').html('<img //
					 * src="img/loading.gif" // alt="" width="24" //
					 * height="24">'); }, success : function(
					 * jobdetails) {
					 * 
					 * console.log(jobdetails); var json_p = JSON
					 * .parse(jobdetails); var options =
					 * $("#new_bill_type_of_use_pf"); // var options = //
					 * $("#selector"); options.empty(); options
					 * .append(new Option( "-- Select --", 0));
					 * 
					 * $(json_p) .each( function() { //
					 * console.log(select_id); //
					 * console.log(this.business_process_id); // if //
					 * (main_service_id //
					 * ==this.business_process_id){ $(
					 * '#new_bill_type_of_use_pf') .append( '<option
					 * value="' + this.typeofuse_id + '_' +
					 * this.typeofuse_name + '">' +
					 * this.typeofuse_name + '</option>'); // }
					 * 
					 * }); // business_process_id } });
					 */

				});

			$('#afterPaymentModalonCase')
				.on(
					'show.bs.modal',
					function (event) {

						$("#txt_on_case_ap_land_size").val(
							$(event.relatedTarget).data(
								'land_size'));

						var job_number = $(event.relatedTarget)
							.data('ref_number');

						// console.log(job_number);
						$("#btnPrintEgcr2").attr("data-ref_number", job_number);

						$("#txt_on_case_ap_transaction_number")
							.val(
								$(event.relatedTarget)
									.data(
										'transaction_number'));

						$("#txt_on_case_ap_case_number").val(
							$(event.relatedTarget).data(
								'transaction_number'));

						$("#new_ap_locality_oncase").val(
							$(event.relatedTarget).data(
								'locality'));

						$("#txt_on_case_ap_job_number").val(
							$(event.relatedTarget).data(
								'ref_number'));


								setTimeout(() => {

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_list_of_natureofinstrument',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#txt_on_case_ap_type_of_instrument");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												// console.log(select_id);
												// console.log(this.business_process_id);

												// if
												// (main_service_id
												// ==this.business_process_id){
												$(
													'#txt_on_case_ap_type_of_instrument')
													.append(
														'<option value="'
														+ this.natureofinstrument_id
														+ '-'
														+ this.natureofinstrument_id
														+ '">'
														+ this.natureofinstrument_name
														+ '</option>');

												// }

											});
									// business_process_id
								}
							});

							}, 300);

						// console.log('enter data');
							setTimeout(() => {
						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_load_details_for_payment',
									job_number: job_number
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);

									var table_bp = $('#tbl_on_case_ap_bills_payments_dataTable');
									table_bp.find(
										"tbody tr")
										.remove();

									var table_cl = $('#tbl_on_case_ap_checklist_dataTable');
									table_cl.find(
										"tbody tr")
										.remove();

									// console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(
										'#txt_on_case_ap_main_service_id')
										.val(
											json_p.jobdetails.business_process_id);
									$(
										'#txt_on_case_ap_main_service_sub_id')
										.val(
											json_p.jobdetails.business_process_sub_id);
									$(
										'#txt_on_case_ap_jn_id')
										.val(
											json_p.jobdetails.jn_id);
									$(
										'#txt_on_case_ap_main_service_desc')
										.val(
											json_p.jobdetails.business_process_name);
									$(
										'#txt_on_case_ap_main_service_sub_desc')
										.val(
											json_p.jobdetails.business_process_sub_name);
									$(
										'#txt_on_case_ap_client_name')
										.val(
											json_p.jobdetails.lessees_name);
									$(
										'#txt_on_case_ap_ar_name')
										.val(
											json_p.jobdetails.lessees_name);

									$(
										'#txt_on_case_ap_land_size')
										.val(
											json_p.jobdetails.extent);
									$(
										'#new_ap_application_surveyors_name_oncase')
										.val(
											json_p.jobdetails.licensed_surveyor_name);

									$(
										'#txt_on_case_ap_type_of_instrument')
										.val(
											json_p.jobdetails.type_of_interest);
									$(
										'#txt_on_case_ap_type_of_use')
										.val(
											json_p.jobdetails.type_of_use);

									if (json_p.jobdetails.business_process_name === 'APPLICATION FOR PLAN APPROVAL') {
										$(
											'#oncasepaap-no-div')
											.show();
										$(
											'#oncasestpap-no-div')
											.hide();
										$(
											'#oncaseregap-no-div')
											.hide();
										$(
											'#oncaseparty-no-div')
											.hide();

									}

									if (json_p.jobdetails.business_process_name === 'APPLICATION FOR STAMPING') {
										$(
											'#oncasepaap-no-div')
											.hide();
										$(
											'#oncasestpap-no-div')
											.show();
										$(
											'#oncaseregap-no-div')
											.hide();
										$(
											'#oncaseparty-no-div')
											.hide();
									}

									if (json_p.jobdetails.business_process_name === 'APPLICATION FOR REGISTRATION') {
										$(
											'#oncasepaap-no-div')
											.hide();
										$(
											'#oncasestpap-no-div')
											.show();
										$(
											'#oncaseregap-no-div')
											.hide();
										$(
											'#oncaseparty-no-div')
											.hide();
									}

									if (json_p.jobdetails.business_process_sub_name === 'APPLICATION FOR OBJECTION') {
										$(
											'#oncasepaap-no-div')
											.hide();
										$(
											'#oncasestpap-no-div')
											.show();
										$(
											'#oncaseregap-no-div')
											.hide();
										$(
											'#oncaseparty-no-div')
											.show();
									}

									if (json_p.jobdetails.business_process_sub_name === 'APPLICATION FOR MORTGAGES') {
										$(
											'#oncasepaap-no-div')
											.hide();
										$(
											'#oncasestpap-no-div')
											.show();
										$(
											'#oncaseregap-no-div')
											.hide();
										$(
											'#oncaseparty-no-div')
											.show();
									}

									if (json_p.jobdetails.business_process_sub_name === 'APPLICATION FOR WHOLE TRANFER') {
										$(
											'#oncasepaap-no-div')
											.hide();
										$(
											'#oncasestpap-no-div')
											.show();
										$(
											'#oncaseregap-no-div')
											.hide();
										$(
											'#oncaseparty-no-div')
											.show();
									}

									$(json_p.payments)
										.each(
											function () {
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

									setTimeout(() => {
									$
										.ajax({
											type: "POST",
											url: "Case_Management_Serv",
											data: {
												request_type: 'get_lc_checklist',
												main_service_id: json_p.jobdetails.business_process_id,
												sub_service_id: json_p.jobdetails.business_process_sub_id
											},
											cache: false,
											beforeSend: function () {
												// $('#district').html('<img
												// src="img/loading.gif"
												// alt=""
												// width="24"
												// height="24">');
											},
											success: function (
												jobdetails) {

												var table = $('#tbl_on_case_ap_checklist_dataTable');
												table
													.find(
														"tbody tr")
													.remove();

												// console.log(jobdetails);
												var json_p = JSON
													.parse(jobdetails);

												$(
													json_p)
													.each(
														function () {

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
																	+ '<div class="custom-control custom-checkbox text-center"> <input type="checkbox" class="select-item checkbox form-check-input" name="select-item" value="1002" /></div>'
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

										}, 300);

								}
							});

							}, 300);

					});

			$('#btn_save_to_generate_new_bill_not_on_case').on('click', function (e) {
				e.preventDefault();

				// Show loading state on button
				// const button = $(this);
				// const originalText = button.html();
				// button.html('<span class="spinner-border spinner-border-sm me-2"></span>Processing...');
				// button.prop('disabled', true);

				// // Store original content
				// button.data('originalHtml', originalText);

				try {
					// Get form values
					const mainServiceSelect = document.getElementById("main_service_cp");
					const subServiceSelect = document.getElementById("sub_service_cp");

					// =========== VALIDATION START ===========

					// 1. Main Service Validation
					if (!mainServiceSelect || !mainServiceSelect.value) {
						showValidationError('Please select a main service', '#main_service_cp');
						//restoreButton(button);
						return;
					}

					const mainService = mainServiceSelect.value;
					const mainServiceParts = mainService.split('-');
					if (mainServiceParts.length < 2) {
						showValidationError('Invalid main service selection', '#main_service_cp');
						//restoreButton(button);
						return;
					}

					let mainServiceId = mainServiceParts[0].replace('.0', '');
					const mainServiceName = mainServiceParts[1];

					// 2. Sub Service Validation
					if (!subServiceSelect || !subServiceSelect.value) {
						showValidationError('Please select a sub service', '#sub_service_cp');
						//restoreButton(button);
						return;
					}

					const subService = subServiceSelect.value;
					const subServiceParts = subService.split('-');
					if (subServiceParts.length < 2) {
						showValidationError('Invalid sub service selection', '#sub_service_cp');
						//restoreButton(button);
						return;
					}

					let subServiceId = subServiceParts[0].replace('.0', '');
					const subServiceName = subServiceParts[1];

					// 3. Client Name Validation
					const clientName = $("#new_bill_application_client_name").val();
					if (!clientName || clientName.trim() === '') {
						showValidationError('Client name is required', '#new_bill_application_client_name');
						//restoreButton(button);
						return;
					}

					// 4. Office Region Validation
					const officeRegion = $("#new_bill_application_office_region").val();
					if (!officeRegion) {
						showValidationError('Please select office region', '#new_bill_application_office_region');
						//restoreButton(button);
						return;
					}

					const officeRegionValue = officeRegion.replace('.0', '');

					// =========== SERVICE-SPECIFIC VALIDATION ===========

					// Initialize common variables
					let type_of_use = '';
					let registration_forms = '';
					let land_size = '0';
					let publication_type = '';
					let ar_gender = '';
					let locality = '';
					let ar_district = '';
					let ar_region = '';
					let licensed_surveyor_number = '';
					let licensed_surveyor_name = '';
					let no_of_copy = '0';
					let revenue_item = '0';
					let surveyors_client = '';
					let errorField = null;
					let errorMessage = '';

					// Validate based on service type
					switch (mainServiceName) {
						case 'APPLICATION FOR REGIONAL NUMBER':
							// Get required fields for this service
							ar_gender = $("#new_bill_application_gender").val();
							locality = $("#new_bill_application_locality").val();
							ar_district = $("#new_bill_application_district").val();
							ar_region = $("#new_bill_application_region").val();
							licensed_surveyor_number = $("#new_bill_application_ls_number").val();
							licensed_surveyor_name = $("#new_bill_application_surveyors_name").val();
							no_of_copy = '1';
							surveyors_client = $("#new_bill_application_client_name").val();

							// Validate required fields
							if (!licensed_surveyor_number) {
								errorField = '#new_bill_application_ls_number';
								errorMessage = "Please enter Surveyor's Number";
							} else if (!licensed_surveyor_name) {
								errorField = '#new_bill_application_ls_number';
								errorMessage = 'Please verify surveyor details';
							} else if (!ar_gender || ar_gender === '-1') {
								errorField = '#new_bill_application_gender';
								errorMessage = 'Please select gender';
							} else if (!ar_region || ar_region === '-1') {
								errorField = '#new_bill_application_region';
								errorMessage = 'Please select region';
							} else if (!ar_district || ar_district === '-1') {
								errorField = '#new_bill_application_district';
								errorMessage = 'Please select district';
							} else if (!locality || locality === '-1') {
								errorField = '#new_bill_application_locality';
								errorMessage = 'Please select locality';
							}

							break;

						case 'APPLICATION FOR STAMPING':
							type_of_use = $("#new_bill_type_of_use").val();
							registration_forms = $("#new_bill_registration_forms").val();
							publication_type = $("#new_bill_publication_type").val();
							ar_gender = $("#new_bill_application_gender").val();
							locality = $("#new_bill_application_locality").val();
							ar_district = $("#new_bill_application_district").val();
							ar_region = $("#new_bill_application_region").val();
							licensed_surveyor_number = $("#new_bill_application_ls_number").val();
							no_of_copy = $("#new_number_of_copies").val();
							revenue_item = $("#new_type_of_revenue_item").val();

							// Validate required fields
							// if (!ar_gender || ar_gender === '-1') {
							// 	errorField = '#new_bill_application_gender';
							// 	errorMessage = 'Please select gender';
							// } else 
							// if (!locality || locality === '-1') {
							// 	errorField = '#new_bill_application_locality';
							// 	errorMessage = 'Please select locality';
							// } else if (!ar_district || ar_district === '-1') {
							// 	errorField = '#new_bill_application_district';
							// 	errorMessage = 'Please select district';
							// } else 
							if (!ar_region || ar_region === '-1') {
								errorField = '#new_bill_application_region';
								errorMessage = 'Please select region';
								// } else if (!type_of_use || type_of_use === '-1') {
								// 	errorField = '#new_bill_type_of_use';
								// 	errorMessage = 'Please select type of use';
								// } else if (!registration_forms || registration_forms === '-1') {
								// 	errorField = '#new_bill_registration_forms';
								// 	errorMessage = 'Please select registration forms';
								// } else if (!publication_type) {
								// 	errorField = '#new_bill_publication_type';
								// 	errorMessage = 'Please select publication type';
								// } else if (!licensed_surveyor_number) {
								// 	errorField = '#new_bill_application_ls_number';
								// 	errorMessage = "Please enter Surveyor's Number";
							} else if (!no_of_copy || no_of_copy < 1) {
								errorField = '#new_number_of_copies';
								errorMessage = 'Please enter valid number of copies';
							} else if (!revenue_item || revenue_item === '-1') {
								errorField = '#new_type_of_revenue_item';
								errorMessage = 'Please select revenue item';
							}
							break;

						case 'APPLICATION FOR REGISTRATION':
							type_of_use = $("#new_bill_type_of_use").val();
							registration_forms = $("#new_bill_registration_forms").val();
							land_size = $("#new_bill_land_size").val();
							publication_type = $("#new_bill_publication_type").val();
							ar_gender = $("#new_bill_application_gender").val();
							locality = $("#new_bill_application_locality").val();
							ar_district = $("#new_bill_application_district").val();
							ar_region = $("#new_bill_application_region").val();
							licensed_surveyor_number = $("#new_bill_application_ls_number").val();

							// Validate land size is numeric and positive
							if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
								errorField = '#new_bill_land_size';
								errorMessage = 'Please enter valid land size (greater than 0)';
							} else if (!type_of_use || type_of_use === '-1') {
								errorField = '#new_bill_type_of_use';
								errorMessage = 'Please select type of use';
							} else if (!registration_forms || registration_forms === '-1') {
								errorField = '#new_bill_registration_forms';
								errorMessage = 'Please select registration forms';
							} else if (!publication_type) {
								errorField = '#new_bill_publication_type';
								errorMessage = 'Please select publication type';
							} else if (!ar_gender || ar_gender === '-1') {
								errorField = '#new_bill_application_gender';
								errorMessage = 'Please select gender';
							} else if (!locality || locality === '-1') {
								errorField = '#new_bill_application_locality';
								errorMessage = 'Please select locality';
							} else if (!ar_district || ar_district === '-1') {
								errorField = '#new_bill_application_district';
								errorMessage = 'Please select district';
							} else if (!ar_region || ar_region === '-1') {
								errorField = '#new_bill_application_region';
								errorMessage = 'Please select region';
							}
							break;

						case 'APPLICATION FOR SEARCH':
						case 'APPLICATION FOR PVLMD PLOTTING':
						case 'APPLICATION FOR PERMIT SEARCH':
						case 'APPLICATION FOR ADMINISTRATIVE SEARCH':
						case 'APPLICATION FOR SMD SITE PLAN SEARCH':
							type_of_use = $("#new_bill_type_of_use").val();
							land_size = $("#new_bill_land_size").val();
							locality = $("#new_bill_application_locality").val();

							if (!type_of_use || type_of_use === '-1') {
								errorField = '#new_bill_type_of_use';
								errorMessage = 'Please select type of use';
							} else if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
								errorField = '#new_bill_land_size';
								errorMessage = 'Please enter valid land size (greater than 0)';
							} else if (!locality || locality === '-1') {
								errorField = '#new_bill_application_locality';
								errorMessage = 'Please select locality';
							}
							break;

						case 'APPLICATION FOR STATE LAND':
							// No additional validation needed for this service
							break;

						default:
							// For other services, check if sub-service requires validation
							if (subServiceName === 'APPLICATION FOR LRD SITE PLAN SEARCH') {
								type_of_use = $("#new_bill_type_of_use").val();
								land_size = $("#new_bill_land_size").val();
								locality = $("#new_bill_application_locality").val();

								if (!type_of_use || type_of_use === '-1') {
									errorField = '#new_bill_type_of_use';
									errorMessage = 'Please select type of use';
								} else if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
									errorField = '#new_bill_land_size';
									errorMessage = 'Please enter valid land size (greater than 0)';
								} else if (!locality || locality === '-1') {
									errorField = '#new_bill_application_locality';
									errorMessage = 'Please select locality';
								}
							}
					}

					// Check if there was a validation error
					if (errorField) {
						showValidationError(errorMessage, errorField);
						// restoreButton(button);
						return;
					}

					// =========== ADDITIONAL VALIDATIONS ===========

					// Validate client ID
					const clientId = $("#new_bill_application_client_id").val();
					if (!clientId || clientId.trim() === '') {
						showValidationError('Client reference is required', '#new_bill_application_client_id');
						// restoreButton(button);
						return;
					}

					// Validate number of copies if applicable
					// if (no_of_copy && (isNaN(no_of_copy) || parseInt(no_of_copy) < 1)) {
					// 	showValidationError('Please enter a valid number of copies (minimum 1)', '#new_number_of_copies');
					// 	restoreButton(button);
					// 	return;
					// }

					// =========== PROCEED WITH AJAX CALL ===========

					// Prepare data object
					const requestData = {
						request_type: 'process_online_select_bill_for_registration',
						main_service_id: mainServiceId,
						main_service_sub_id: subServiceId,
						main_service_desc: mainServiceName,
						main_service_sub_desc: subServiceName,
						client_name: clientName,
						case_number: 'Not Case',
						land_size: land_size,
						registration_forms: registration_forms,
						publication_type: publication_type,
						type_of_use: type_of_use,
						licensed_surveyor_number: licensed_surveyor_number,
						licensed_surveyor_name: licensed_surveyor_name,
						locality: locality,
						ar_gender: ar_gender,
						ar_district: ar_district,
						ar_region: ar_region,
						paper_size: 0,
						revenue_item: revenue_item,
						no_of_copy: no_of_copy,
						office_region: officeRegionValue,
						submission_type: 'Office',
						surveyors_client: surveyors_client || clientName,
						created_for: clientName,
						created_for_id: clientId,
						application_required_additional_bill: 'No'
					};

					// Show global loading overlay
					loadingOverlay.show('Generating bill...');

					// Make AJAX call
					$.ajax({
						type: "POST",
						url: "Case_Management_Serv",
						data: requestData,
						cache: false,
						xhrFields: {
							responseType: 'blob'
						},
						success: function (jobdetails) {
							// Hide loading states
							loadingOverlay.hide();
							//restoreButton(button);

							// Open PDF in new window
							const blob = new Blob([jobdetails], { type: "application/pdf" });
							const objectUrl = URL.createObjectURL(blob);

							// Check if blob is valid
							if (blob.size === 0) {
								Swal.fire({
									title: 'Error!',
									text: 'Failed to generate PDF. Please try again.',
									icon: 'error',
									confirmButtonText: 'OK'
								});
								return;
							}

							// Open PDF
							window.open(objectUrl);

							// Close modal
							$('#addNewserviceBillModal').modal('hide');

							// Show success message
							Swal.fire({
								title: 'Success!',
								text: 'Bill generated successfully',
								icon: 'success',
								confirmButtonText: 'OK',
								timer: 2000
							});

							// Optional: Additional call for specific service
							if (subServiceName === 'APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)') {
								// Make additional AJAX call if needed
							}
						},
						error: function (xhr, status, error) {
							// Hide loading states
							loadingOverlay.hide();
							//restoreButton(button);

							// Show error message
							Swal.fire({
								title: 'Error!',
								text: 'Failed to generate bill: ' + (xhr.responseText || error),
								icon: 'error',
								confirmButtonText: 'OK'
							});

							console.error('AJAX Error:', error, xhr);
						},
						complete: function () {
							// Clean up any remaining loading states
							setTimeout(() => loadingOverlay.hide(), 500);
						}
					});

				} catch (error) {
					// Handle any unexpected errors
					console.error('Unexpected error:', error);
					//restoreButton(button);
					loadingOverlay.hide();

					Swal.fire({
						title: 'Unexpected Error!',
						text: 'An unexpected error occurred: ' + error.message,
						icon: 'error',
						confirmButtonText: 'OK'
					});
				}
			});

			// =========== HELPER FUNCTIONS ===========

			function showValidationError(message, fieldSelector) {
				// Highlight the field
				$(fieldSelector).addClass('is-invalid');

				// Show error message
				Swal.fire({
					title: 'Validation Error',
					text: message,
					icon: 'warning',
					confirmButtonText: 'OK',
					confirmButtonColor: '#dc3545'
				}).then(() => {
					// Focus on the field
					$(fieldSelector).focus();
				});

				// Remove error class after 5 seconds
				setTimeout(() => {
					$(fieldSelector).removeClass('is-invalid');
				}, 5000);
			}

			function restoreButton(button) {
				if (button.data('originalHtml')) {
					button.html(button.data('originalHtml'));
				}
				button.prop('disabled', false);
			}

			// Add validation styles
			$(document).ready(function () {
				// Add CSS for validation
				$('head').append(`
		<style>
			.is-invalid {
				border-color: #dc3545 !important;
				background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath stroke-linejoin='round' d='M5.8 3.6h.4L6 6.5z'/%3e%3ccircle cx='6' cy='8.2' r='.6' fill='%23dc3545' stroke='none'/%3e%3c/svg%3e");
				background-repeat: no-repeat;
				background-position: right calc(0.375em + 0.1875rem) center;
				background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
				padding-right: calc(1.5em + 0.75rem);
			}
			
			.is-invalid:focus {
				border-color: #dc3545;
				box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
			}
			
			.invalid-feedback {
				display: none;
				width: 100%;
				margin-top: 0.25rem;
				font-size: 0.875em;
				color: #dc3545;
			}
			
			.is-invalid ~ .invalid-feedback {
				display: block;
			}
		</style>
	`);

				// Clear validation on input
				$('input, select').on('input change', function () {
					$(this).removeClass('is-invalid');
				});
			});

			$('#btn_save_to_generate_on_application').on('click', function (e) {
    e.preventDefault();

    try {
        // Get form elements
        const mainServiceSelect = document.getElementById("main_service_on_case");
        const subServiceSelect = document.getElementById("sub_service_on_case");

        // =========== VALIDATION START ===========

        // 1. Main Service Validation
        if (!mainServiceSelect || !mainServiceSelect.value || mainServiceSelect.value === '-1') {
            showValidationError('Please select a main service', '#main_service_on_case');
            return;
        }

        const mainService = mainServiceSelect.value;
        const mainServiceParts = mainService.split('-');
        if (mainServiceParts.length < 2) {
            showValidationError('Invalid main service selection', '#main_service_on_case');
            return;
        }

        let mainServiceId = mainServiceParts[0].replace('.0', '');
        const mainServiceName = mainServiceParts[1];

        // 2. Sub Service Validation
        if (!subServiceSelect || !subServiceSelect.value || subServiceSelect.value === '-1') {
            showValidationError('Please select a sub service', '#sub_service_on_case');
            return;
        }

        const subService = subServiceSelect.value;
        const subServiceParts = subService.split('-');
        if (subServiceParts.length < 2) {
            showValidationError('Invalid sub service selection', '#sub_service_on_case');
            return;
        }

        let subServiceId = subServiceParts[0].replace('.0', '');
        const subServiceName = subServiceParts[1];

        // 3. Office Region Validation
        const officeRegion = $("#new_bill_application_office_region_on_case").val();
        if (!officeRegion || officeRegion === '-1') {
            showValidationError('Please select office region', '#new_bill_application_office_region_on_case');
            return;
        }

        const officeRegionValue = officeRegion.replace('.0', '');

        // =========== SERVICE-SPECIFIC VALIDATION ===========

        // Initialize common variables
        let type_of_use = '';
        let registration_forms = '';
        let land_size = '0';
        let publication_type = '';
        let locality = '';
        let licensed_surveyor_number = '';
        let licensed_surveyor_name = '';
        let no_of_copy = '0';
        let revenue_item = '0';
        let errorField = null;
        let errorMessage = '';

        // Get client information
        const clientName = $("#on_application_client_name").val();
        const caseNumber = $("#new_bill_case_number_on_case").val();

        if (!clientName || clientName.trim() === '') {
            showValidationError('Client name is required', '#on_application_client_name');
            return;
        }

        if (!caseNumber || caseNumber.trim() === '') {
            showValidationError('Transaction number is required', '#new_bill_case_number_on_case');
            return;
        }

        // Validate based on service type
        switch (mainServiceName) {
            case 'APPLICATION FOR PLAN APPROVAL':
                land_size = $("#new_bill_land_size_on_case").val();
                locality = $("#new_bill_locality_on_case_1").val();
                licensed_surveyor_number = $("#new_bill_application_ls_number_oncase").val();
                licensed_surveyor_name = $("#new_bill_application_surveyors_name_oncase").val();

                // Validate required fields
                if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
                    errorField = '#new_bill_land_size_on_case';
                    errorMessage = 'Please enter valid land size (greater than 0)';
                } else if (!locality || locality.trim() === '') {
                    errorField = '#new_bill_locality_on_case_1';
                    errorMessage = 'Please enter locality';
                } else if (!licensed_surveyor_number || licensed_surveyor_number.trim() === '') {
                    errorField = '#new_bill_application_ls_number_oncase';
                    errorMessage = "Please enter Surveyor's Number";
                } else if (!licensed_surveyor_name || licensed_surveyor_name.trim() === '') {
                    errorField = '#new_bill_application_ls_number_oncase';
                    errorMessage = 'Please verify surveyor details';
                }
                break;

            case 'APPLICATION FOR STAMPING':
                type_of_use = $("#new_bill_type_of_use_on_case").val();
                no_of_copy = $("#new_number_of_copies_on_case").val();
                revenue_item = $("#new_type_of_revenue_item_on_case").val();

                // Validate required fields
                if (!type_of_use || type_of_use === '-1') {
                    errorField = '#new_bill_type_of_use_on_case';
                    errorMessage = 'Please select type of use';
                } else if (!no_of_copy || isNaN(no_of_copy) || parseInt(no_of_copy) < 1) {
                    errorField = '#new_number_of_copies_on_case';
                    errorMessage = 'Please enter valid number of copies (minimum 1)';
                } else if (!revenue_item || revenue_item === '-1') {
                    errorField = '#new_type_of_revenue_item_on_case';
                    errorMessage = 'Please select nature of instrument';
                }
                break;

            case 'APPLICATION FOR REGISTRATION':
                type_of_use = $("#new_bill_type_of_use_on_case").val();
                registration_forms = $("#new_bill_registration_forms_on_case").val();
                land_size = $("#new_bill_land_size_on_case").val();
                locality = $("#new_bill_locality_on_case_1").val();
                publication_type = $("#new_bill_publication_type_on_case").val();

                // Validate required fields
                if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
                    errorField = '#new_bill_land_size_on_case';
                    errorMessage = 'Please enter valid land size (greater than 0)';
                } else if (!type_of_use || type_of_use === '-1') {
                    errorField = '#new_bill_type_of_use_on_case';
                    errorMessage = 'Please select type of use';
                } else if (!registration_forms || registration_forms === '-1') {
                    errorField = '#new_bill_registration_forms_on_case';
                    errorMessage = 'Please select registration forms';
                } else if (!publication_type) {
                    errorField = '#new_bill_publication_type_on_case';
                    errorMessage = 'Please select publication type';
                } else if (!locality || locality.trim() === '') {
                    errorField = '#new_bill_locality_on_case_1';
                    errorMessage = 'Please enter locality';
                }
                break;

            case 'APPLICATION FOR SEARCH':
            case 'APPLICATION FOR PVLMD PLOTTING':
            case 'APPLICATION FOR PERMIT SEARCH':
            case 'APPLICATION FOR ADMINISTRATIVE SEARCH':
            case 'APPLICATION FOR SMD SITE PLAN SEARCH':
                type_of_use = $("#new_bill_type_of_use_on_case").val();
                land_size = $("#new_bill_land_size_on_case").val();
                locality = $("#new_bill_locality_on_case_1").val();

                if (!type_of_use || type_of_use === '-1') {
                    errorField = '#new_bill_type_of_use_on_case';
                    errorMessage = 'Please select type of use';
                } else if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
                    errorField = '#new_bill_land_size_on_case';
                    errorMessage = 'Please enter valid land size (greater than 0)';
                } else if (!locality || locality.trim() === '') {
                    errorField = '#new_bill_locality_on_case_1';
                    errorMessage = 'Please enter locality';
                }
                break;

            case 'APPLICATION FOR REGIONAL NUMBER':
                licensed_surveyor_number = $("#new_bill_application_ls_number_oncase").val();
                licensed_surveyor_name = $("#new_bill_application_surveyors_name_oncase").val();

                if (!licensed_surveyor_number || licensed_surveyor_number.trim() === '') {
                    errorField = '#new_bill_application_ls_number_oncase';
                    errorMessage = "Please enter Surveyor's Number";
                } else if (!licensed_surveyor_name || licensed_surveyor_name.trim() === '') {
                    errorField = '#new_bill_application_ls_number_oncase';
                    errorMessage = 'Please verify surveyor details';
                }
                break;

            default:
                // For other services, check if sub-service requires validation
                if (subServiceName === 'APPLICATION FOR LRD SITE PLAN SEARCH') {
                    type_of_use = $("#new_bill_type_of_use_on_case").val();
                    land_size = $("#new_bill_land_size_on_case").val();
                    locality = $("#new_bill_locality_on_case_1").val();

                    if (!type_of_use || type_of_use === '-1') {
                        errorField = '#new_bill_type_of_use_on_case';
                        errorMessage = 'Please select type of use';
                    } else if (!land_size || isNaN(land_size) || parseFloat(land_size) <= 0) {
                        errorField = '#new_bill_land_size_on_case';
                        errorMessage = 'Please enter valid land size (greater than 0)';
                    } else if (!locality || locality.trim() === '') {
                        errorField = '#new_bill_locality_on_case_1';
                        errorMessage = 'Please enter locality';
                    }
                }
        }

        // Check if there was a validation error
        if (errorField) {
            showValidationError(errorMessage, errorField);
            return;
        }

        // =========== PREPARE REQUEST DATA ===========

        const requestData = {
            request_type: 'process_online_select_bill_for_registration',
            main_service_id: mainServiceId,
            main_service_sub_id: subServiceId,
            main_service_desc: mainServiceName,
            main_service_sub_desc: subServiceName,
            client_name: clientName,
            case_number: caseNumber,
            land_size: land_size,
            registration_forms: registration_forms,
            publication_type: publication_type,
            type_of_use: type_of_use,
            licensed_surveyor_number: licensed_surveyor_number,
            licensed_surveyor_name: licensed_surveyor_name,
            revenue_item: revenue_item,
            locality: locality,
            ar_gender: '',
            ar_district: '',
            ar_region: '',
            paper_size: 0,
            no_of_copy: no_of_copy,
            office_region: officeRegionValue,
            submission_type: 'Office',
            surveyors_client: '-',
            created_for: clientName,
            created_for_id: clientName, // Using client name as ID since no specific ID field in this modal
            application_required_additional_bill: 'No'
        };

        // Show loading overlay
        loadingOverlay.show('Generating bill...');

        // =========== MAKE AJAX CALL ===========
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: requestData,
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            success: function (jobdetails) {
                // Hide loading overlay
                loadingOverlay.hide();

                // Open PDF in new window
                const blob = new Blob([jobdetails], { type: "application/pdf" });
                const objectUrl = URL.createObjectURL(blob);

                // Check if blob is valid
                if (blob.size === 0) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Failed to generate PDF. Please try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                // Open PDF
                window.open(objectUrl);

                // Close modal
                $('#addNewserviceBillModalonCase').modal('hide');

                // Show success message
                Swal.fire({
                    title: 'Success!',
                    text: 'Bill generated successfully',
                    icon: 'success',
                    confirmButtonText: 'OK',
                    timer: 2000
                });
            },
            error: function (xhr, status, error) {
                // Hide loading overlay
                loadingOverlay.hide();

                // Show error message
                Swal.fire({
                    title: 'Error!',
                    text: 'Failed to generate bill: ' + (xhr.responseText || error),
                    icon: 'error',
                    confirmButtonText: 'OK'
                });

                console.error('AJAX Error:', error, xhr);
            },
            complete: function () {
                // Clean up any remaining loading states
                setTimeout(() => loadingOverlay.hide(), 500);
            }
        });

    } catch (error) {
        // Handle any unexpected errors
        console.error('Unexpected error:', error);
        loadingOverlay.hide();

        Swal.fire({
            title: 'Unexpected Error!',
            text: 'An unexpected error occurred: ' + error.message,
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
});


			$('#fileUploadFormatCSAUonCase').on('change', function () {
				// console.log("hhh on " );
				const upload_size = this.files[0].size;

				if (upload_size > 10285760) {
					alert("Document is bigger than 10MB. Pls reduce the document's size");
				}
			});

			$('#btn_on_case_ap_generate_acknowledgement')
				.on(
					'click',
					function (e) {
						// console.log('assiamah');
						if (document.getElementById("fileUploadFormatCSAUonCase").files.length == 0) {
							// console.log("no files selected");
							alert("No files selected for Upload. Please select a pdf file");
							return;
						}
						if (document.getElementById("fileUploadFormatCSAUonCase").files[0].size > 10285760) {
							alert("Document is bigger than 10MB. Pls reduce the document's size");
							return;
						}

						var main_service_id = $(
							"#txt_on_case_ap_main_service_id")
							.val();
						var main_service_sub_id = $(
							"#txt_on_case_ap_main_service_sub_id")
							.val();
						var main_service_desc = $(
							"#txt_on_case_ap_main_service_desc")
							.val();
						var main_service_sub_desc = $(
							"#txt_on_case_ap_main_service_sub_desc")
							.val();
						var client_name = $(
							"#txt_on_case_ap_client_name")
							.val();

						var land_size = $(
							"#txt_on_case_ap_land_size")
							.val();
						console.log(land_size)

						// var locality_of_parcel =
						// $("#cs_main_locality").val();
						var locality_of_parcel = ' ';
						var application_type = $(
							"#txt_not_on_case_ap_application_type")
							.val();
						var type_of_interest = $(
							"#txt_on_case_ap_type_of_instrument")
							.val();
						var type_of_use = $(
							"#txt_on_case_ap_type_of_use")
							.val();

						var job_number = $(
							"#txt_on_case_ap_job_number")
							.val();
						var case_number = $(
							"#txt_on_case_ap_case_number")
							.val();
						var transaction_number = $(
							"#txt_on_case_ap_transaction_number")
							.val();
						var jn_id = $("#txt_on_case_ap_jn_id")
							.val();

						var licensed_surveyor_name = $(
							"#new_ap_application_surveyors_name_oncase")
							.val();

						var userid = localStorage
							.getItem('userid');
						var fullname = localStorage
							.getItem('fullname');

						// var txt_on_case_ap_client_name =
						// $("#txt_on_case_ap_ar_name").val();
						var ar_gender = $(
							"#txt_on_case_ap_bl_cbo_ar_gender")
							.val();
						var ar_cell_phone = $(
							"#txt_on_case_ap_ar_cell_phone")
							.val();
						var ar_id_type = $(
							"#cbo_on_case_ap_ar_id_type")
							.val();
						var ar_id_number = $(
							"#txt_on_case_ap_ar_id_number")
							.val();
						var type_of_party = $(
							"#cbo_on_case_ap_type_of_party")
							.val();



						if (main_service_desc === 'APPLICATION FOR PLAN APPROVAL') {
							land_size = $(
								"#txt_on_case_ap_land_size")
								.val();
							var locality = $(
								"#new_ap_locality_oncase")
								.val();

							var locality_of_parcel = $(
								"#new_ap_locality_oncase")
								.val();
							// console.log(land_size)
						}

						var FiletoUpload = document
							.getElementById("fileUploadFormatCSAUonCase").files[0];

						var filename = document
							.getElementById("fileUploadFormatCSAUonCase").files[0].name;

						var formdata = new FormData();

						formdata
							.append("request_type",
								'process_online_select_acknowledgement_on_case');
						formdata.append("main_service_id",
							main_service_id);
						formdata.append("main_service_sub_id",
							main_service_sub_id);
						formdata.append("main_service_desc",
							main_service_desc);
						formdata.append(
							"main_service_sub_desc",
							main_service_sub_desc);
						formdata.append("client_name",
							client_name);
						formdata.append(
							"licensed_surveyor_name",
							licensed_surveyor_name);
						formdata.append("land_size", land_size);
						formdata.append("locality_of_parcel",
							locality_of_parcel);
						formdata.append("application_type",
							application_type);
						formdata.append("type_of_interest",
							type_of_interest);
						formdata.append("type_of_use",
							type_of_use);
						formdata.append("job_number",
							job_number);
						formdata.append("case_number",
							case_number);
						formdata.append("transaction_number",
							transaction_number);
						formdata.append("jn_id", jn_id);
						formdata.append("userid", userid);
						formdata.append("fullname", fullname);
						formdata.append("ar_gender", ar_gender);
						formdata.append("ar_cell_phone",
							ar_cell_phone);
						formdata.append("ar_id_type",
							ar_id_type);
						formdata.append("ar_id_number",
							ar_id_number);
						formdata.append("ap_type_of_party",
							type_of_party);

						formdata.append("file_name", filename);

						formdata.append("sampleFile",
							FiletoUpload);

						// console.log(formdata);
						$
							.ajax({
								type: "POST",
								enctype: 'multipart/form-data',
								url: "Case_Management_Serv_Upload",
								data: formdata,
								processData: false,
								contentType: false,
								cache: false,
								xhrFields: {
									responseType: 'blob'
								},
								timeout: 600000,
								success: function (data) {
									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$('#oncaseakblobfile')
										.attr('src',
											objectUrl);
								},
								error: function (e) {

								}
							});

						/*
						 * $( '#afterPaymentModalonCase')
						 * .modal('hide');
						 */

					});

			$('#NotoncaseafterPaymentModalonCase').on('hidden.bs.modal', function () { location.reload(); });

			$('#afterPaymentModalonCase').on('hidden.bs.modal', function () { location.reload(); });

			$("#next-btn")
				.on(
					"click",
					function () {
						// Navigate next
						$('#smartwizardCSAUModal').smartWizard(
							"next");

						alert('hidden event fired!');

						if (document
							.getElementById("videoUploadFile").files.length == 0) {
							console.log("no files selected");
						}

						return true;
					});


			$("#btnPrintEgcr, #btnPrintEgcr2").on("click", function (e) {
				e.preventDefault();
				let ref_number = $(e.relatedTarget).data('ref_number');
				ref_number = $(this).data("ref_number");
				// console.log(ref_number);

				var lbl_payment_slip_number_for_egcr = $("#lbl_payment_slip_number_for_egcr").val();
				$.ajax({
					type: "POST",
					url: "payment_serv_egcr",
					// target:'_blank',
					data: {
						request_type: 'generate_egcr',
						ref_number: ref_number,
						receipt_number: lbl_payment_slip_number_for_egcr,
					},
					cache: false,
					xhrFields: {
						responseType: 'blob'
					},
					beforeSend: function () {
						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
					},
					success: function (jobdetails) {
						//console.log(jobdetails);
						// const arrayBuffer = _base64ToArrayBuffer(jobdetails);

						var blob = new Blob([jobdetails], { type: "application/pdf" });
						var objectUrl = URL.createObjectURL(blob);
						window.open(objectUrl);

					}
				});

				// 	var request = new XMLHttpRequest();
				//     // var params = '{"agencyUniqueReference":
				// 	// "LC0003","receiptDescription": "Stamp
				// 	// duty","recipientName": "Kofi Ghana","recipientEmail":
				// 	// "kofi.ghana@gmail.com","recipientPhone":
				// 	// "0242012137", "amount": "165.5","receiptType":
				// 	// "LC-GEN","receivedBy": "Joe Bloggs"}';
				//     // request.responseType = 'blob';
				//     request.onreadystatechange = function() {
				//     	loadingOverlay().cancel(spinHandle);
				//         if (this.readyState == 4 && this.status == 200) {
				//         	console.log("loadni good");
				//             var blob = new Blob([this.response], {type: "application/pdf"});
				// 	        var objectUrl = URL.createObjectURL(blob);
				// 	        window.open(objectUrl);
				//         }
				//     };
				//    request.onloadstart  = function () {
				// 	  console.log("loadni");
				// 	  spinHandle = loadingOverlay().activate();

				// 	};
				// 	request.onerror = function(){
				// 		loadingOverlay().cancel(spinHandle);
				// 		console.log("loadni error");
				// 	}

				// 	 let json = JSON.stringify({
				// 		ref_number: ref_number
				// 	  });
				// 	  console.log(document.location.origin);
				// 	request.open('GET',  'http://localhost:1001/lc_official_receipt_service/generate_egcr_pdf_only/' + ref_number , true);
				//     request.responseType = 'blob';
				//    request.setRequestHeader('x-api-key','fb469d7ef430b0baf0cab6c436e70375');
				//     request.setRequestHeader("Content-type", "application/json");
				// 	// request.send(json);
				//    request.send();


				//  xhr.open("POST", '/submit')
				//  xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');

				// xhr.send(json);



				/*
				 * const headers = new Headers();
				 * headers.append('content-type', 'application/json');
				 * 
				 * const body = `{"ref_number": "11602848"}`;
				 * 
				 * const init = { method: 'GET', headers };
				 * 
				 * fetch('http://localhost:8080/gelis_online_service_live/rest/lc_official_receipt_service/generate_egcr_pdf_only/11602865',
				 * init) .then((response) => { //return response.json(); //
				 * or .text() or .blob() ... let data = response.blob();
				 * console.log(data ) //console.log("jqXHR "
				 * +JSON.stringify(jqXHR) ) var blob = new Blob( [ data ], {
				 * type : "application/pdf" }); var objectUrl = URL
				 * .createObjectURL(blob); window.open(objectUrl); })
				 * .then((text) => { // text is the response body })
				 * .catch((e) => { console.log(e.message); });
				 */



			});




			$('#NotoncaseafterPaymentModalonCase').on('show.bs.modal', function (e) {
				const $modal = $(this);
				const $relatedTarget = $(e.relatedTarget);
				const jobNumber = $relatedTarget.data('ref_number');

				// Set data attributes and values
				$("#btnPrintEgcr, .btnPrintEgcr").attr("data-ref_number", jobNumber);
				$('#sp_job_number').val(jobNumber);

				// Clear tables
				$('#tbl_not_on_case_ap_bills_payments_dataTable tbody, #tbl_not_on_case_after_payment_ap_checklist_dataTable tbody').empty();

				// First fetch job details
				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'select_load_details_for_payment',
						job_number: jobNumber
					},
					cache: false,
					success: function (response) {
						try {
							const jobDetails = JSON.parse(response);

							// Populate job details and show/hide sections
							populateJobDetails(jobDetails, jobNumber);
							toggleSectionsBasedOnService(jobDetails.jobdetails.business_process_name);

							// Populate payments table
							populatePaymentsTable(jobDetails.payments || []);

							// Fetch checklist data
							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_checklist',
									main_service_id: jobDetails.jobdetails.business_process_id,
									sub_service_id: jobDetails.jobdetails.business_process_sub_id
								},
								cache: false,
								success: function (checklistResponse) {
									try {
										const checklistData = JSON.parse(checklistResponse);
										populateChecklistTable(checklistData);
									} catch (e) {
										console.error('Error parsing checklist:', e);
									}
								},
								error: function (xhr, status, error) {
									console.error('Error fetching checklist:', error);
								}
							});

						} catch (e) {
							console.error('Error parsing job details:', e);
						}
					},
					error: function (xhr, status, error) {
						console.error('Error fetching job details:', error);
					}
				});

				// Fetch dropdown data in parallel
				setTimeout(() => {
					$.ajax({
						type: "POST",
						url: "Case_Management_Serv",
						data: { request_type: 'get_list_of_natureofinstrument' },
						cache: false,
						success: function (response) {
							try {
								const natureOfInstrument = JSON.parse(response);
								populateDropdown('#txt_not_on_case_ap_type_of_instrument', natureOfInstrument,
									'natureofinstrument_id', 'natureofinstrument_name', '-');
							} catch (e) {
								console.error('Error parsing nature of instrument:', e);
							}
						},
						error: function (xhr, status, error) {
							console.error('Error fetching nature of instrument:', error);
						}
					});
				}, 300);

				setTimeout(() => {
					// $.ajax({
					// 	type: "POST",
					// 	url: "Case_Management_Serv",
					// 	data: { request_type: 'get_type_of_use_list' },
					// 	cache: false,
					// 	success: function (response) {
					// 		try {
					// 			const typeOfUse = JSON.parse(response);
					// 			populateDropdown('#txt_not_on_case_ap_type_of_use', typeOfUse,
					// 				'typeofuse_id', 'typeofuse_name', '_');
					// 		} catch (e) {
					// 			console.error('Error parsing type of use:', e);
					// 		}
					// 	},
					// 	error: function (xhr, status, error) {
					// 		console.error('Error fetching type of use:', error);
					// 	}
					// });
					$.ajax({
						type: "POST",
						url: "Case_Management_Serv",
						data: {
							request_type: 'get_type_of_use_list',
						},
						cache: false,
						beforeSend: function () {
							// $('#district').html('<img
							// src="img/loading.gif"
							// alt="" width="24"
							// height="24">');
						},
						success: function (jobdetails) {

							// console.log(jobdetails);
							var json_p = JSON.parse(jobdetails);
							var options = $("#txt_not_on_case_ap_type_of_use");

							// var options =
							// $("#selector");
							options.empty();
							options.append(new Option("-- Select --", 0));

							$(json_p).each(function () {

								// console.log(select_id);
								// console.log(this.business_process_id);

								// if
								// (main_service_id
								// ==this.business_process_id){
								$('#txt_not_on_case_ap_type_of_use').append(
									'<option value="'
									+ this.typeofuse_id
									+ '_'
									+ this.typeofuse_name
									+ '">'
									+ this.typeofuse_name
									+ '</option>'
								);

								// }

							});
							// business_process_id
						}
					});
				}, 300);
			});

			// Helper functions
			function populateJobDetails(data, jobNumber) {
				const job = data.jobdetails;

				// Map field IDs to data properties
				const fieldMap = {
					'#txt_not_on_case_ap_main_service_id': job.business_process_id,
					'#txt_not_on_case_ap_main_service_sub_id': job.business_process_sub_id,
					'#txt_not_on_case_ap_jn_id': job.jn_id,
					'#txt_not_on_case_ap_main_service_desc': job.business_process_name,
					'#txt_not_on_case_ap_main_service_sub_desc': job.business_process_sub_name,
					'#txt_not_on_case_ap_client_name': job.lessees_name,
					'#txt_not_on_case_ap_ar_name': job.lessees_name,
					'#txt_not_on_case_ap_land_size': job.extent,
					'#txt_not_on_case_ap_job_number': jobNumber,
					'#txt_not_on_case_bl_txt_ar_name': job.lessees_name,
					'#txt_not_on_case_bl_txt_ar_gender': job.gender,
					'#txt_not_on_case_ap_district': job.district,
					'#txt_not_on_case_ap_region': job.region,
					'#txt_not_on_case_ap_licensed_surveyor_number': job.licensed_surveyor_number,
					'#new_bill_application_ls_number_afp': job.licensed_surveyor_number,
					'#txt_not_on_case_ap_licensed_surveyor_name': job.licensed_surveyor_name,
					'#txt_not_on_case_ap_locality_of_parcel': job.locality,
					'#txt_not_on_case_ap_type_of_use': job.type_of_use
				};

				// Populate all fields
				Object.entries(fieldMap).forEach(([selector, value]) => {
					$(selector).val(value || '');
				});
			}

			function populatePaymentsTable(payments) {
				const table = $('#tbl_not_on_case_ap_bills_payments_dataTable tbody');
				table.empty();

				payments.forEach(payment => {
					const row = `
            <tr>
                <td>${payment.bill_number || '--'}</td>
                <td>${payment.customer_id || '--'}</td>
                <td class='text-end'>${payment.bill_amount || '--'}</td>
                <td class='text-end'>${payment.payment_amount || '--'}</td>
                <td>${payment.payment_mode || '--'}</td>
                <td>${payment.division || '--'}</td>
            </tr>
        `;
					table.append(row);
				});
			}

			function populateChecklistTable(data) {
				const table = $('#tbl_not_on_case_after_payment_ap_checklist_dataTable tbody');
				table.empty();

				data.forEach(item => {
					const row = `
            <tr>
                <td>${item.business_process_checklist_name || '--'}</td>
                <td class='text-center'>
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="form-check-input" name="select-item" value="${item.id || ''}" />
                    </div>
                </td>
            </tr>
        `;
					table.append(row);
				});
			}

			function populateDropdown(selector, data, valueField, textField, separator = '') {
				const $select = $(selector);
				$select.empty().append('<option value="0">-- Select --</option>');

				data.forEach(item => {
					const value = separator ?
						`${item[valueField]}${separator}${item[valueField]}` :
						item[valueField];
					const option = `<option value="${value}">${item[textField]}</option>`;
					$select.append(option);
				});
			}

			function toggleSectionsBasedOnService(serviceName) {
				// Reset all sections first
				$('#ap-reg-no-div, #ap-stp-no-div, #ap-partysearch-no-div, #ap-typeofuse-no-div, #ap-selectlocality-no-div, #checksigs-no-div_afp, #txt_not_on_case_ap_application_type').hide();

				// Show specific sections based on service type
				switch (serviceName) {
					case 'APPLICATION FOR REGIONAL NUMBER':
						$('#ap-reg-no-div, #ap-selectlocality-no-div, #checksigs-no-div_afp').show();
						break;

					case 'APPLICATION FOR STAMPING':
						$('#ap-stp-no-div, #ap-typeofuse-no-div, #ap-partysearch-no-div').show();
						break;

					case 'APPLICATION FOR SEARCH':
						$('#ap-typeofuse-no-div, #ap-selectlocality-no-div, #ap-partysearch-no-div').show();
						break;

					default:
						// Handle other cases if needed
						break;
				}
			}

			$('#btn_job_number_for_adding_case_and_status')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_job_number_for_adding_case_and_status")
							.val().toUpperCase();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)) {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'load_application_details_by_job_number_all',
									job_number: client_phone_search
								},
								cache: false,

								success: function (
									jobdetails) {

									console.log(jobdetails);

									var table = $('#tbl_job_detail_dataTable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									if (json_p.data === null) {
										// $
										// 		.notify(
										// 				{
										// 					message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Application not found </span>',
										// 				},
										// 				{
										// 					type : 'danger' , z_index: 9999 
										// 				});

										swal.fire({
											title: 'Ops!',
											text: 'Application not found. Please try again.',
											icon: 'warning',
											confirmButtonText: 'OK'
										})

										return false;
									}
									$(json_p.data)
										.each(
											function () {

												table
													.append("<tr><td>"
														+ this.job_number
														+ "</td><td>"
														+ this.case_number
														+ "</td><td>"
														+ this.ar_name
														// + "</td><td>"
														// + this.current_application_status
														+ "</td>"

														/*
														 * + '<td><p data-placement="top" data-toggle="tooltip" title="Details of Case"><button
														 * class="btn
														 * btn-success
														 * btn-circle
														 * btn-sm"
														 * data-title="Delete"
														 * data-toggle="modal"
														 * data-target="#NotoncaseafterPaymentModalonCase" ' +
														 * 'data-ref_number="' +
														 * this.job_number + '" ' +
														 * 'data-ar_name="' +
														 * this.case_number + '" ' +
														 * 'data-ar_name="' +
														 * this.ar_name + '" ' +
														 * 'data-bill_amount="' +
														 * this.current_application_status + '"
														 * id="deletedew"><span
														 * class="fa
														 * fa-info-circle"></span></button></p>
														 * </td>'
														 */

														// Add
														// Job
														+ '<td class="text-end"><button class="btn btn-primary btn-circle btn-sm me-2" data-bs-backdrop="static" data-bs-keyboard="false" data-title="Add New Service" data-bs-toggle="modal" data-bs-target="#addNewserviceBillModalonCase" '
														+ 'data-ref_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-land_size="'
														+ this.land_size
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-created_for_id="'
														+ this.created_for_id
														+ '" '
														+ 'data-licensed_no="'
														+ this.licensed_no
														+ '" '
														+ 'data-locality="'
														+ this.locality
														+ '" '
														+ 'data-bill_amount="'
														+ this.current_application_status

														+ '" id="ad_new_service"><span class="fa fa-plus-circle"></span></button>'

														+ '<button class="btn btn-info btn-circle btn-sm" data-title="Add New Service"  data-backdrop="static" data-keyboard="false" data-bs-toggle="modal" data-bs-target="#generateTransitionalBillModal" '
														+ 'data-ref_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-transaction_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-land_size="'
														+ this.land_size
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-created_for_id="'
														+ this.created_for_id
														+ '" '
														+ 'data-business_process_name="'
														+ this.business_process_name
														+ '" '
														+ 'data-locality="'
														+ this.locality
														+ '" '

														+ 'data-licensed_no="'
														+ this.licensed_no
														+ '" '
														+ 'data-bill_amount="'
														+ this.current_application_status

														+ '" id="ad_new_service"><span class="fa fa-receipt"></span></button></td>'


														// + '<td><p data-placement="top" data-toggle="tooltip" title="Receive After Payment"><button class="btn btn-info btn-circle btn-sm" data-title="Add New Service"  data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#reSubmissionAppModal" '
														// + 'data-job_number="'
														// + this.job_number
														// + '" '
														// + 'data-case_number="'
														// + this.case_number
														// + '" '
														// + 'data-transaction_number="'
														// + this.transaction_number
														// + '" '
														// + 'data-land_size="'
														// + this.land_size
														// + '" '
														// + 'data-ar_name="'
														// + this.ar_name
														// + '" '
														// + 'data-created_for_id="'
														// + this.created_for_id
														// + '" '
														// + 'data-business_process_name="'
														// + this.business_process_name
														// + '" '
														// + 'data-locality="'
														// + this.locality
														// + '" '

														// + 'data-licensed_no="'
														// + this.licensed_no
														// + '" '
														// + 'data-bill_amount="'
														// + this.current_application_status

														// + '" id="ad_new_service"><span class="fa fa-receipt"></span></button></p> </td>'


														+ "</tr>");

											});

								}
							});

					});

			$('#btn_job_number_for_adding_name_change_bill')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_job_number_for_adding_case_and_status")
							.val().toUpperCase();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)) {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'load_application_details_by_job_number_all',
									job_number: client_phone_search
								},
								cache: false,

								success: function (
									jobdetails) {

									var table = $('#tbl_job_detail_dataTable_nameChange');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									if (json_p.data === null) {
										$
											.notify(
												{
													message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Application not found </span>',
												},
												{
													type: 'danger', z_index: 9999
												});
										return false;
									}
									$(json_p.data)
										.each(
											function () {

												table
													.append("<tr><td>"
														+ this.job_number
														/*
														 * + "</td><td>" +
														 * this.case_number
														 */
														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.locality
														+ "</td><td>"
														+ this.regional_number
														+ "</td><td>"
														/*
														 * +
														 * this.current_application_status + "</td><td>"
														 */

														// Add
														// Job
														+ '<p data-placement="top" data-toggle="tooltip" title="Add New Bill"><button class="btn btn-primary  btn-circle btn-sm" data-backdrop="static" data-keyboard="false" data-title="Add New Service" data-toggle="modal" data-target="#addNewserviceBillModalonCase" '
														+ 'data-ref_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-land_size="'
														+ this.land_size
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-created_for_id="'
														+ this.created_for_id
														+ '" '
														+ 'data-licensed_no="'
														+ this.licensed_no
														+ '" '
														+ 'data-locality="'
														+ this.locality
														+ '" '
														+ 'data-region="'
														+ this.region
														+ '" '
														+ 'data-district="'
														+ this.district
														+ '" '
														+ 'data-licensed_no="'
														+ this.licensed_no
														+ '" '
														+ 'data-bill_amount="'
														+ this.current_application_status

														+ '" id="ad_new_service"><span class="fa fa-plus-circle"></span></button></p> </td>'

														/*
														 * + '<td><p data-placement="top" data-toggle="tooltip" title="generate Transitional Bill"><button
														 * class="btn
														 * btn-info
														 * btn-circle
														 * btn-sm"
														 * data-title="Add
														 * New
														 * Service"
														 * data-backdrop="static"
														 * data-keyboard="false"
														 * data-toggle="modal"
														 * data-target="#generateTransitionalBillModal" ' +
														 * 'data-ref_number="' +
														 * this.job_number + '" ' +
														 * 'data-case_number="' +
														 * this.case_number + '" ' +
														 * 'data-transaction_number="' +
														 * this.transaction_number + '" ' +
														 * 'data-land_size="' +
														 * this.land_size + '" ' +
														 * 'data-ar_name="' +
														 * this.ar_name + '" ' +
														 * 'data-created_for_id="' +
														 * this.created_for_id + '" ' +
														 * 'data-locality="' +
														 * this.locality + '" ' +
														 * 'data-licensed_no="' +
														 * this.licensed_no + '" ' +
														 * 'data-bill_amount="' +
														 * this.current_application_status + '"
														 * id="ad_new_service"><span
														 * class="fa
														 * fa-receipt"></span></button></p>
														 * </td>'
														 */

														+ "</tr>");

											});

								}
							});

					});

			$('#addNewserviceBillModalonCase')
				.on(
					'show.bs.modal',
					function (event) {
						// alert("sdsd: " +
						// $(event.relatedTarget).data('locality'));

						$("#on_application_client_name").val(
							$(event.relatedTarget).data(
								'ar_name'));
						$("#new_bill_case_number_on_case").val(
							$(event.relatedTarget).data(
								'case_number'));
						$("#new_bill_land_size_on_case").val(
							$(event.relatedTarget).data(
								'land_size'));

						$("#new_bill_client_id_on_case").val(
							$(event.relatedTarget).data(
								'created_for_id'));

						$("#new_bill_locality_on_case_1").val(
							$(event.relatedTarget).data(
								'locality'));

						$(
							"#new_bill_application_ls_number_oncase")
							.val(
								$(event.relatedTarget)
									.data(
										'licensed_no'));

						// sub_service_on_case
						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_main_service',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#main_service_on_case");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									// console.log('${case_process_stage}')
									if ('${case_process_stage}' == '1') {
										$(
											'#main_service_on_case')
											.append(
												'<option value="'
												+ '2'
												+ '-'
												+ 'APPLICATION FOR PLAN APPROVAL'
												+ '">'
												+ 'APPLICATION FOR PLAN APPROVAL'
												+ '</option>');

									} else {
										$(json_p)
											.each(
												function () {

													// console.log(select_id);
													// console.log(this.business_process_id);

													// if(main_service_id
													// ==this.business_process_id){
													$(
														'#main_service_on_case')
														.append(
															'<option value="'
															+ this.business_process_id
															+ '-'
															+ this.business_process_name
															+ '">'
															+ this.business_process_name
															+ '</option>');
													// }

												});
									}

									// business_process_id
								}
							});

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_type_of_use_list',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#new_bill_type_of_use_on_case");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												// console.log(select_id);
												// console.log(this.business_process_id);

												// if
												// (main_service_id
												// ==this.business_process_id){
												$(
													'#new_bill_type_of_use_on_case')
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

			$('#addNewserviceBillModal')
				.on(
					'show.bs.modal',
					function (event) {

						$("#new_bill_application_client_name")
							.val(
								$(event.relatedTarget)
									.data('pu_name'));

						$("#new_bill_application_client_id")
							.val(
								$(event.relatedTarget)
									.data(
										'pu_email'));

						$("#new_bill_case_number").val(
							'No Case');

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_main_service',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#main_service_cp");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												// console.log(select_id);
												// console.log(this.business_process_id);

												if (this.business_process_on_case == 'No') {
													$(
														'#main_service_cp')
														.append(
															'<option value="'
															+ this.business_process_id
															+ '-'
															+ this.business_process_name
															+ '">'
															+ this.business_process_name
															+ '</option>');
												}

											});

									// business_process_id
								}
							});

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_type_of_use_list',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#new_bill_type_of_use");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												// console.log(select_id);
												// console.log(this.business_process_id);

												// if
												// (main_service_id
												// ==this.business_process_id){
												$(
													'#new_bill_type_of_use')
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

					});


			// $('#fileUploadFormatCSAU').on('change', function(){

			// 	// console.log("hhh " );
			// 	const upload_size = this.files[0].size;
			// 	console.log("hhh " + upload_size);
			// 	if(upload_size >  10285760){
			// 		alert("Document is bigger than 10MB. Pls reduce the document's size");
			// 	}
			// });

			$('#btn_not_on_case_ap_generate_acknowledgement').on('click', function (e) {
				e.preventDefault();

				// File validation
				const fileInput = document.getElementById("fileUploadFormatCSAU");
				if (!validateFileUpload(fileInput)) {
					return;
				}

				// Collect form data
				const formData = prepareFormData();

				// Submit form
				submitAcknowledgementRequest(formData);
			});

			// Validation functions
			function validateFileUpload(fileInput) {
				if (fileInput.files.length === 0) {
					alert("No files selected for Upload. Please select a pdf file");
					return false;
				}

				const file = fileInput.files[0];

				// Check file size (10MB = 10 * 1024 * 1024 bytes)
				if (file.size === 0 || file.size > 10 * 1024 * 1024) {
					alert("Document is bigger than 10MB. Please reduce the document's size");
					return false;
				}

				// Check file type (optional)
				if (!file.name.toLowerCase().endsWith('.pdf')) {
					alert("Please select a PDF file");
					return false;
				}

				return true;
			}

			function prepareFormData() {
				const formData = new FormData();
				const fileInput = document.getElementById("fileUploadFormatCSAU");
				const file = fileInput.files[0];

				// Collect all form values
				const formValues = {
					request_type: 'process_online_select_acknowledgement_not_on_case',
					main_service_id: $("#txt_not_on_case_ap_main_service_id").val(),
					main_service_sub_id: $("#txt_not_on_case_ap_main_service_sub_id").val(),
					main_service_desc: $("#txt_not_on_case_ap_main_service_desc").val(),
					main_service_sub_desc: $("#txt_not_on_case_ap_main_service_sub_desc").val(),
					client_name: $("#txt_not_on_case_bl_txt_ar_name").val(),
					ar_address: '',
					land_size: $("#txt_not_on_case_ap_land_size").val(),
					locality_of_parcel: $("#txt_not_on_case_ap_locality_of_parcel").val(),
					application_type: $("#txt_not_on_case_ap_application_type").val() || '',
					type_of_interest: $("#txt_not_on_case_ap_type_of_instrument").val(),
					type_of_use: $("#txt_not_on_case_ap_type_of_use").val(),
					job_number: $("#txt_not_on_case_ap_job_number").val(),
					case_number: 'No',
					jn_id: $("#txt_not_on_case_ap_jn_id").val(),
					ar_gender: '',
					ar_cell_phone: '',
					ar_id_type: '',
					ar_id_number: '',
					ap_type_of_party: 'Applicant',
					region: $("#txt_not_on_case_ap_region").val(),
					district: $("#txt_not_on_case_ap_district").val(),
					licensed_surveyor_number: $("#txt_not_on_case_ap_licensed_surveyor_number").val(),
					licensed_surveyor_name: $("#txt_not_on_case_ap_licensed_surveyor_name").val(),
					file_name: file.name
				};

				// Append all values to FormData
				Object.entries(formValues).forEach(([key, value]) => {
					formData.append(key, value);
				});

				// Append file
				formData.append("sampleFile", file);

				// console.log(file);

				return formData;
			}

			function submitAcknowledgementRequest(formData) {
				//  console.log("FormData contents:");
				// for (const [key, value] of formData.entries()) {
				// 	if (value instanceof File) {
				// 		console.log(key, `File → ${value.name} (${value.size} bytes)`);
				// 	} else {
				// 		console.log(key, value);
				// 	}
				// }

				// console.log("=== FormData FILES ===");
				// for (const [k, v] of formData.entries()) {
				// 	if (v instanceof File) {
				// 		console.log("FILE:", k, v.name);
				// 	}
				// }

				$.ajax({
					type: "POST",
					enctype: "multipart/form-data",
					url: "Case_Management_Serv_Upload",
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					xhrFields: {
						responseType: 'blob'
					},
					timeout: 600000,
					beforeSend: function () {
						// Optional: Show loading indicator
						$('#btn_not_on_case_ap_generate_acknowledgement').prop('disabled', true).html('Generating...');
					},
					success: function (response) {
						console.log("AJAX Success:", response);
						// Check if response is a valid blob
						// if (data instanceof Blob && data.size > 0) {
						// 	const blob = new Blob([data], { type: "application/pdf" });
						// 	const objectUrl = URL.createObjectURL(blob);

						// 	// Display PDF in iframe
						// 	$('#notoncaseakblobfile').attr('src', objectUrl);

						// 	// Optionally auto-download
						// 	autoDownloadPDF(blob, `Acknowledgement_${Date.now()}.pdf`);
						// } else {
						// 	//handleServerError("Invalid response from server");
						// 	swal.fire({
						// 		title: 'Ops!',
						// 		text: 'Invalid response from server. Please try again.',
						// 		icon: 'warning',
						// 		confirmButtonText: 'OK'
						// 	})
						// }

						const blob = new Blob([response], { type: "application/pdf" });
						const objectUrl = URL.createObjectURL(blob);

						// Display PDF in iframe
						$('#notoncaseakblobfile').attr('src', objectUrl);

						// Optionally auto-download
						autoDownloadPDF(blob, `Acknowledgement_${Date.now()}.pdf`);
					},
					error: function (xhr, status, error) {
						console.error("AJAX Error:", status, error);

						if (status === "timeout") {
							//alert("Request timeout. Please try again.");
							swal.fire({
								title: 'Ops!',
								text: 'Request timeout. Please try again.',
								icon: 'warning',
								confirmButtonText: 'OK'
							})
						} else if (xhr.status === 413) {
							//alert("File too large. Please upload a smaller file.");
							swal.fire({
								title: 'Ops!',
								text: 'File too large. Please upload a smaller file.',
								icon: 'warning',
								confirmButtonText: 'OK'
							})
						} else if (xhr.status === 415) {
							//alert("Unsupported file type. Please upload a PDF file.");
							swal.fire({
								title: 'Ops!',
								text: 'Unsupported file type. Please upload a PDF file.',
								icon: 'warning',
								confirmButtonText: 'OK'
							})
						} else {
							//alert("Error generating acknowledgement. Please check console for details.");
							swal.fire({
								title: 'Ops!',
								text: 'Error generating acknowledgement. Please try again.',
								icon: 'warning',
								confirmButtonText: 'OK'
							})
						}
					},
					complete: function () {
						// Re-enable button
						$('#btn_not_on_case_ap_generate_acknowledgement').prop('disabled', false).html('Generate Acknowledgement');
					}
				});
			}

			// Optional helper functions
			function autoDownloadPDF(blob, filename) {
				const link = document.createElement('a');
				link.href = URL.createObjectURL(blob);
				link.download = filename;
				document.body.appendChild(link);
				link.click();
				document.body.removeChild(link);
				setTimeout(() => URL.revokeObjectURL(link.href), 100);
			}

			function handleServerError(message) {
				console.error(message);
				alert(message);
			}


			$('#generateManualBillModal').on(
				'show.bs.modal',
				function (e) {

					$("#new_bill_application_client_name_mb").val(
						$(e.relatedTarget).data('pu_name'));
					$("#new_bill_application_client_id_mb").val(
						$(e.relatedTarget).data('pu_email'));

				});


			$('#generateRegionalTransitionalBillModal').on(
				'show.bs.modal',
				function (e) {

					$("#new_bill_application_client_name_rtb").val(
						$(e.relatedTarget).data('pu_name'));
					$("#new_bill_application_client_id_rtb").val(
						$(e.relatedTarget).data('pu_email'));

				});


			$('#linkaccounttoJobsModal').on(
				'show.bs.modal',
				function (e) {

					$("#lja_applicant_name").val(
						$(e.relatedTarget).data('pu_name'));
					$("#lja_applicant_id").val(
						$(e.relatedTarget).data('pu_email'));

				});

			$('#generateTransitionalBillModal')
				.on(
					'show.bs.modal',
					function (e) {

						$("#tb_job_number").val(
							$(e.relatedTarget).data(
								'ref_number'));
						$("#tb_case_number").val(
							$(e.relatedTarget).data(
								'case_number'));
						$("#tb_applicant_name").val(
							$(e.relatedTarget).data(
								'ar_name'));

						$("#tb_created_for_id").val(
							$(e.relatedTarget).data(
								'created_for_id'));

					});


			$('#reSubmissionAppModal')
				.on(
					'show.bs.modal',
					function (e) {

						$("#res_job_number").val(
							$(e.relatedTarget).data(
								'job_number'));

						$("#res_case_number").val(
							$(e.relatedTarget).data(
								'case_number'));
						$("#res_applicant_name").val(
							$(e.relatedTarget).data(
								'ar_name'));

						$("#res_created_for_id").val(
							$(e.relatedTarget).data(
								'created_for_id'));

						$("#res_business_process_name").val(
							$(e.relatedTarget).data(
								'business_process_name'));

					});


			$('#publicFileUploadModal').on('show.bs.modal', function (e) {
				var res_case_number = $("#res_case_number").val();
				//console.log(res_case_number);
				//$('#public_file_upload_case_number').val(res_case_number);
			})


			$('#publicFileUploadModal').on('shown.bs.modal', function () {
				$("#reSubmissionAppModal").css("z-index", "1029");
			})

			$('#publicFileUploadModal').on('hidden.bs.modal', function () {
				$("#reSubmissionAppModal").css("z-index", "");
			})

			$('#viewBatchlistModal').on('shown.bs.modal', function () {
				$("#reSubmissionAppModal").css("z-index", "1029");
			})

			$('#viewBatchlistModal').on('hidden.bs.modal', function () {
				$("#reSubmissionAppModal").css("z-index", "");
			})


			$("#btnresumbitapplication").on('click', function (e) {
				var job_number = $("#res_job_number").val();
				var ar_name = $("#res_applicant_name").val();

				var name_of_depositor = $("#res_name_of_depositor").val();
				var id_number = $("#res_id_number").val();
				var id_type = $("#res_id_type").val();
				var job_purpose = $("#res_purpose").val();
				var depositor_tel = $("#res_depositor_tel").val();
				var business_process_sub_name = $("#res_business_process_name").val();

				if (!name_of_depositor || !id_number || !id_type || !job_purpose || !depositor_tel) {
					//let alert = ``

					document.getElementById('required_alert').innerHTML = `<div class="alert alert-danger" role="alert">
																									Fill the required fields!
																								</div>`;

					setTimeout(function () {
						$('.alert').fadeOut(1000);
					}, 10000);

				} else {
					addJobToBatchlist(
						job_number,
						ar_name,
						business_process_sub_name,
						job_purpose,
						"");
				}

			})

			$('#btn_lja_search_for_job_number_details').on('click', function() {
							const jobNumber = $('#lja_job_number').val().trim();
							
							if (!jobNumber) {
								Swal.fire({
									title: 'Job Number Required',
									text: 'Please enter a job number to search',
									icon: 'warning',
									confirmButtonText: 'OK'
								});
								$('#lja_job_number').focus();
								return;
							}
							
							// Show loading state
							const button = $(this);
							const originalHtml = button.html();
							button.html('<span class="mdi mdi-loading mdi-spin me-2"></span>Searching...');
							button.prop('disabled', true);

							$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'load_application_details_by_job_number_all',
														job_number : jobNumber

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
														var json_p = JSON
																.parse(jobdetails);

														$(json_p.data)
																.each(
																		function() {

																			$(
																					"#lja_case_number")
																					.val(
																							this.case_number);
																			$(
																					"#lja_transaction_number")
																					.val(
																							this.transaction_number);
																			$(
																					"#lja_ar_name")
																					.val(
																							this.ar_name);
																			$(
																					"#lja_job_number_result")
																					.val(
																							this.job_number);

																		});

																		button.html(originalHtml);
																		button.prop('disabled', false);
																	}
												});

							
							
							
						});

			$('#btn_save_link_job_to_account')
				.on(
					'click',
					function (e) {
						var lja_applicant_id = $(
							"#lja_applicant_id").val();
						var lja_applicant_name = $(
							"#lja_applicant_name").val();
						var lja_job_number = $(
							"#lja_job_number_result").val();

							// Check if job details are loaded
        if (!$('#lja_job_number_result').val()) {
            Swal.fire({
                title: 'Job Required',
                text: 'Please search and select a job first',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

		const button = $(this);
							const originalHtml = button.html();
							button.html('<span class="mdi mdi-loading mdi-spin me-2"></span>Linking...');
							button.prop('disabled', true);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_link_account_to_jobs',

									client_name: lja_applicant_name,
									job_number: lja_job_number,
									created_for_id: lja_applicant_id
								},
								cache: false,

								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									/*
									 * var blob = new Blob( [
									 * data ], { type :
									 * "application/pdf" });
									 * var objectUrl = URL
									 * .createObjectURL(blob); //
									 * window.open(objectUrl); $(
									 * '#transitionalbillblobfile')
									 * .attr('src',
									 * objectUrl);
									 */

									//alert(data);

									swal.fire({
										title: 'Success',
										text: 'Job linked successfully',
										icon: 'success',
										confirmButtonText: 'OK'
									});

									$(
										'#linkaccounttoJobsModal')
										.modal('hide');
								}
							});
					});

			$('#btn_generate_transitional_bill')
				.on(
					'click',
					function (e) {

						var tb_job_number = $("#tb_job_number")
							.val();
						var case_number = $("#tb_case_number")
							.val();
						var client_name = $(
							"#tb_applicant_name").val();
						var publication_type = $(
							"#tb_bill_type").val();

						var tb_bill_amount = $(
							"#tb_bill_amount").val();

						var created_for_id = $(
							"#tb_created_for_id").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_online_select_bill_for_registration',
									main_service_id: '999',
									main_service_sub_id: '999',
									main_service_desc: 'Additional Bill',
									main_service_sub_desc: 'Additional Bill',
									client_name: client_name,
									case_number: case_number,
									land_size: tb_bill_amount,
									registration_forms: 'No',
									publication_type: publication_type,
									type_of_use: '',
									licensed_surveyor_number: '',
									licensed_surveyor_name: '',
									locality: '',
									ar_gender: '',
									ar_district: '',
									ar_region: '',
									paper_size: '0',
									revenue_item: '',
									no_of_copy: '0',
									office_region: '01_Greater Accra',
									submission_type: 'Office',
									created_for: client_name,
									created_for_id: created_for_id,
									application_required_additional_bill: 'No'
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$(
										'#transitionalbillblobfile')
										.attr('src',
											objectUrl);

								}
							});

					});


			$('#btn_generate_regeneration_slip')
				.on(
					'click',
					function (e) {

						var job_number = $("#res_job_number")
							.val();
						var case_number = $("#res_case_number")
							.val();
						var client_name = $(
							"#res_applicant_name").val();
						var publication_type = $(
							"#res_bill_type").val();


						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_resubmission_slip',
									client_name: client_name,
									case_number: case_number,
									publication_type: publication_type,
									job_number: job_number
								},
								cache: false,

								xhrFields: {
									responseType: 'blob'
								},

								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$(
										'#resubmissionbillblobfile')
										.attr('src',
											objectUrl);

								}
							});

					});


			$('#btn_load_bill_details_after_payment_mre')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_ref_number_for_payment_mre")
							.val();

						$
							.ajax({
								type: "POST",
								url: "payment_serv",
								// target:'_blank',

								data: {
									request_type: 'load_bill_for_payment_individual',
									bill_number: client_phone_search
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									// alert(jobdetails);

									var table = $('#bill_for_payment_list_dataTable_mre');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.bill_number
														+ "</td><td>"
														+ this.customer_name
														+ "</td><td>"
														+ this.bill_amount
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button data-backdrop="static" data-keyboard="false" class="btn btn-success btn-circle btn-sm" data-title="Initiat Payment" data-toggle="modal" data-target="#manualBillPayment" '
														+ 'data-bill_number="'
														+ this.bill_number
														+ '" '
														+ 'data-ar_name="'
														+ this.customer_name
														+ '" '
														+ 'data-bill_amount="'
														+ this.bill_amount
														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ "</tr>");
											});

								}
							});

					});

			$('#btn_load_bill_details_after_payment_gra')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_ref_number_for_payment_gra")
							.val();

						$
							.ajax({
								type: "POST",
								url: "payment_serv",
								// target:'_blank',

								data: {
									request_type: 'load_bill_for_payment_individual',
									bill_number: client_phone_search
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									// alert(jobdetails);

									var table = $('#bill_for_payment_list_dataTable_gra');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.bill_number
														+ "</td><td>"
														+ this.customer_name
														+ "</td><td>"
														+ this.bill_amount
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button data-backdrop="static" data-keyboard="false" class="btn btn-success btn-circle btn-sm" data-title="Initiat Payment" data-toggle="modal" data-target="#manualBillPayment" '
														+ 'data-bill_number="'
														+ this.bill_number
														+ '" '
														+ 'data-ar_name="'
														+ this.customer_name
														+ '" '
														+ 'data-bill_amount="'
														+ this.bill_amount
														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ "</tr>");

											});

								}
							});

					});

			$('#manualBillPayment')
				.on(
					'show.bs.modal',
					function (e) {

						$("#mre_bill_number").val(
							$(e.relatedTarget).data(
								'bill_number'));

						$("#mre_ar_name").val(
							$(e.relatedTarget).data(
								'ar_name'));

						$("#mre_amount_due").val(
							$(e.relatedTarget).data(
								'bill_amount'));

						$("#mre_amount_paid").val([]);
						$("#mre_receipt_number").val([]);
						$("#mre_payment_mode").val([]);
						$("#mre_payment_remarks").val([]);
						$('#mreblobfile').attr('src', '');

					});

			$('#btn_mre_save_payment')
				.on(
					'click',
					function (e) {
						// console.log("mre_amount_paid is " );
						var mre_bill_number = $(
							"#mre_bill_number").val();
						var mre_ar_name = $("#mre_ar_name")
							.val();
						var mre_amount_due = $(
							"#mre_amount_due").val();
						var mre_amount_paid = parseFloat(
							$("#mre_amount_paid").val())
							.toFixed(2);
						console.log("mre_amount_paid is "
							+ mre_amount_paid);
						var mre_receipt_number = $(
							"#mre_receipt_number").val();

						var mre_payment_mode = $(
							"#mre_payment_mode").val();
						var mre_payment_remarks = $(
							"#mre_payment_remarks").val();

						/*
						 * var payment_bank = $(
						 * "#payment_bank").val();
						 */

						var payment_bank = 'GRA';
						var payment_bank_branch = 'GRA';

						$
							.ajax({
								type: "POST",
								url: "payment_serv",
								// target:'_blank',

								data: {
									request_type: 'capture_manual_bill_payment',
									bill_number: mre_bill_number,
									client_name: mre_ar_name,
									payment_slip_number: mre_receipt_number,
									payment_remarks: mre_payment_remarks,
									payment_mode: mre_payment_mode,
									payment_bank: payment_bank,
									payment_bank_branch: payment_bank_branch,
									payment_amount: mre_amount_paid,
									assessed_amount: mre_amount_due,

								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									// console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									// alert(data);

									/*
									 * $('#manualBillPayment')
									 * .modal('hide');
									 */

									/*
									 * var blob = new Blob( [
									 * data ], { type :
									 * "application/pdf" });
									 * var objectUrl = URL
									 * .createObjectURL(blob); //
									 * window.open(objectUrl); $(
									 * '#transitionalbillblobfile')
									 * .attr('src',
									 * objectUrl);
									 */

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$('#mreblobfile').attr(
										'src',
										objectUrl);

								}
							});

					});

			$('#btn_load_bill_details_after_payment_gra_old')
				.on(
					'click',
					function (e) {

						console.log('uuuewyrur');

						var client_phone_search = $(
							"#txt_ref_number_for_payment_gra_old")
							.val();

						$
							.ajax({
								type: "POST",
								url: "payment_serv",
								// target:'_blank',

								data: {
									request_type: 'load_bill_for_payment_individual_old',
									job_number: client_phone_search
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									// alert(jobdetails);

									var table = $('#bill_for_payment_list_dataTable_gra_old');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number
														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.stamp_duty_payable
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button data-backdrop="static" data-keyboard="false" class="btn btn-success btn-circle btn-sm" data-title="Initiat Payment" data-toggle="modal" data-target="#manualBillPayment" '
														+ 'data-bill_number="'
														+ this.job_number
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-bill_amount="'
														+ this.stamp_duty_payable
														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ "</tr>");

											});

								}
							});

					});

			$('#btn-uploadregionalnumbercsv')
				.click(
					function () {

						var table_bp = $('#bulk_regional_number_list_dataTable_smd');
						table_bp.find("tbody tr").remove();

						var csv = $('#txtFileUploaduploadregionalnumbercsv');
						var csvFile = csv[0].files[0];
						var ext = csv.val().split(".").pop()
							.toLowerCase();

						if ($.inArray(ext, ["csv"]) === -1) {
							alert('upload csv');
							return false;
						}
						if (csvFile != undefined) {
							reader = new FileReader();
							reader.onload = function (e) {

								console.log(e.target.result)
								csvResult = e.target.result
									.split(/\r|\n|\r\n/);
								// $('.csv').append(csvResult);
								console.log(csvResult)
								var list_from_csv = e.target.result;

								var coordinates = list_from_csv
									.split('\n');

								var points = [];
								console.log('coodinates list');
								console.log(coordinates);

								// console.log(coodinates.length);
								console.log('length:'
									+ coordinates.length);
								coordinates
									.forEach(function (entry) {
										// console.log(entry);

										points = entry
											.split(",");

										if (points.length > 1) {
											// polypoints.push(ol.proj.transform([parseFloat(points[0]),parseFloat(points[1])],'EPSG:4326','EPSG:3857'))
											// polypoints.push([parseFloat(points[0]),parseFloat(points[1])])
											console
												.log(points[0]);
											var table = $('#bulk_regional_number_list_dataTable_smd');
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
													+ points[3]
													+ "</td><td>"

													+ points[4]
													+ "</td><td>"
													+ ''
													+ "</td>"

													+ "</tr>");
										}

									});
							}
							reader.readAsText(csvFile);

							$('#uploadregionalnumbercsv')
								.modal('hide');
						}
					});

			$('#open_attached_document')
				.on(
					'click',
					function (e) {

						// var job_number =
						// $("#cs_main_job_number").val();
						// var case_number =
						// $("#cs_main_case_number").val();

						$.ajax({
							type: "POST",
							url: "open_pdffile",
							// target:'_blank',
							data: {
								request_type: 'print_rent_demand_notice'

							},
							cache: false,
							xhrFields: {
								responseType: 'blob'
							},
							beforeSend: function () {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
							success: function (
								jobdetails) {
								console.log(jobdetails);
								// const arrayBuffer =
								// _base64ToArrayBuffer(jobdetails);

								$(
									'#elisDocumentPreview')
									.modal(
										{
											backdrop: 'static',
										});

								var blob = new Blob(
									[jobdetails],
									{
										type: "application/pdf"
									});
								var objectUrl = URL
									.createObjectURL(blob);
								// window.open(objectUrl);

								$(
									'#elisdovumentpreviewblobfile')
									.attr('src',
										objectUrl);

							}
						});

					});

			$("#btn_upload_rn_file")
				.click(
					function (event) {
						// $('form').submit(function(event) {
						// stop submit the form, we will post it
						// manually.
						event.preventDefault();

						// Get form
						// var form = $('#fileUploadForm')[0];

						// var form =
						// $('#fileUploadForm')[0].files[0];
						/*
						 * var case_number = $(
						 * "#file_upload_case_number") .val();
						 */

						console.log('Hoe are you')

						var sampleFile = document
							.getElementById("fileUploadFormregionalnumber").files[0];

						// var fileInput =
						// document.getElementById('upload');
						var filename = document
							.getElementById("fileUploadFormregionalnumber").files[0].name;

						console.log(filename);

						var formdata = new FormData();

						/*
						 * formdata.append("case_number",
						 * case_number);
						 */
						formdata.append("file_name", filename);

						formdata.append("sampleFile",
							sampleFile);

						$("#btn_upload_rn_file").prop(
							"disabled", true);
						console.log(formdata);
						$
							.ajax({
								type: "POST",
								enctype: 'multipart/form-data',
								url: "UploadRegionalNumberCSV",
								// url :
								// "UploadRegionalNumberCSV",
								data: formdata,
								processData: false,
								contentType: false,
								cache: false,
								timeout: 600000,
								success: function (data) {

									console.log(data);

									var table_bp = $('#bulk_regional_number_list_dataTable_smd');
									table_bp.find(
										"tbody tr")
										.remove();

									// $("#result").text(data);
									// alert(data);

									var json_p = JSON
										.parse(data);

									var table = $('#bulk_regional_number_list_dataTable_smd');
									// table.find("tbody
									// tr").remove();

									$(json_p)
										.each(
											function () {
												table_bp
													.append("<tr><td>"
														+ this.id
														+ "</td><td>"
														+ this.applicant_name
														+ "</td><td>"

														+ this.locality
														+ "</td><td>"
														+ this.gender
														+ "</td><td>"
														+ this.district
														+ "</td><td>"
														+ this.region
														+ "</td>"
														+ "</tr>");
											});

									$(
										'#filefileRegionalNumberUploadModal')
										.modal('hide');
									console.log(
										"SUCCESS : ",
										data);
									$("#btn_upload_rn_file")
										.prop(
											"disabled",
											false);

								},
								error: function (e) {

									// $("#result").text(e.responseText);
									console.log("ERROR : ",
										e);
									$("#btn_upload_rn_file")
										.prop(
											"disabled",
											false);

								}
							});
					});

			$("#btn_process_bulk_regional_number")
				.click(
					function (event) {

						var select_id = document
							.getElementById("main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;

						var main_service_1 = $(
							"#main_service_cp").val();

						// console.log(main_service);
						// console.log(main_service_1);

						const
							main_service_name_id = main_service
								.split('-');
						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						var sub_select_id = document
							.getElementById("sub_service_cp");
						var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

						const
							sub_service_name_id = sub_service
								.split('-');
						var sub_service_id = sub_service_name_id[0];
						var sub_service_name = sub_service_name_id[1];
						main_service_id = main_service_id
							.replace('.0', '');

						var txt_brn_licenced_number = $(
							"#txt_brn_licenced_number")
							.val();

						var licensed_surveyor_name = $(
							"#txt_brn_licenced_name").val();

						var txt_ref_number_for_brn = $(
							"#txt_ref_number_for_brn")
							.val();

						var fullname = $('#fullname').val();
						var userid = $('#userid').val();

						var send_by_name = localStorage
							.getItem('fullname');

						var someSession = '<%=Session["fullname"] %>';

						var table = storeTblValues()
						var list_of_application_new = JSON
							.stringify(table)
						console.log(list_of_application_new);

						function storeTblValues() {
							var TableData = new Array();

							$(
								'#bulk_regional_number_list_dataTable_smd tr')
								.each(
									function (row, tr) {
										TableData[row] = {
											"reference_number": txt_ref_number_for_brn,
											// "fullname"
											// :
											// someSession,
											// "userid"
											// : userid,

											"business_process_id": main_service_id,
											"business_process_sub_id": sub_service_id,
											"business_process_name": main_service_name,
											"business_process_sub_name": sub_service_name,

											"ar_name": $(
												tr)
												.find(
													'td:eq(1)')
												.text()
												.trim(),
											"locality_of_parcel": $(
												tr)
												.find(
													'td:eq(2)')
												.text()
												.trim(),
											"ar_gender": $(
												tr)
												.find(
													'td:eq(3)')
												.text()
												.trim(),
											"district": $(
												tr)
												.find(
													'td:eq(4)')
												.text()
												.trim(),

											"region": $(
												tr)
												.find(
													'td:eq(5)')
												.text()
												.trim(),
											"licensed_surveyor_number": txt_brn_licenced_number
											// "send_to_name"
											// :
											// send_to_name,
											// "send_to_id"
											// : send_to_id
										}
									});
							TableData.shift(); // first row
							// will be empty
							// - so remove
							return TableData;
						}

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',
								data: {
									request_type: 'online_select_process_acknowledgement_regional_number_bulk',
									regional_number_list: list_of_application_new,
									ref_number: txt_ref_number_for_brn,
									business_process_id: main_service_id,
									business_process_sub_id: sub_service_id,
									business_process_name: main_service_name,
									business_process_sub_name: sub_service_name,
									licensed_surveyor_name: licensed_surveyor_name

								},
								cache: false,

								xhrFields: {
									responseType: 'blob'
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);

									$(
										"#btn_upload_regional_by_csv")
										.prop(
											'disabled',
											true);
									$(
										"#btn_process_bulk_regional_number")
										.prop(
											'disabled',
											true);

									$(
										'#elisDocumentPreview')
										.modal(
											{
												backdrop: 'static',
											});

									var blob = new Blob(
										[jobdetails],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$(
										'#elisdovumentpreviewblobfile')
										.attr('src',
											objectUrl);

								}
							});
					});

			/*
			 * $("#btn_upload_rn_file").click(function(event) {
			 * 
			 * });
			 */

			$('#generateManualBillModal')
				.on(
					'show.bs.modal',
					function (event) {

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_main_service',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#mbm_main_service_cp");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												// console.log(select_id);
												console
													.log(this.business_process_id);

												if (this.registration_related == 'ManualBill') {
													$(
														'#mbm_main_service_cp')
														.append(
															'<option value="'
															+ this.business_process_id
															+ '-'
															+ this.business_process_name
															+ '">'
															+ this.business_process_name
															+ '</option>');
												}

											});

									// business_process_id
								}
							});

					});

			$('#generateRegionalTransitionalBillModal')
				.on(
					'show.bs.modal',
					function (event) {

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_main_service',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#rtb_main_service_cp");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												// console.log(select_id);
												console
													.log(this.business_process_id);

												// if (this.business_process_on_case == 'No') {
												$(
													'#rtb_main_service_cp')
													.append(
														'<option value="'
														+ this.business_process_id
														+ '-'
														+ this.business_process_name
														+ '">'
														+ this.business_process_name
														+ '</option>');
												//}

											});

									// business_process_id
								}
							});

					});

			$('#mbm_main_service_cp')
				.change(
					function () {
						// alert($(this).val());
						var select_id = document
							.getElementById("mbm_main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;

						const
							main_service_name_id = main_service
								.split('-');

						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_sub_service',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#mbm_sub_service_cp");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												console
													.log(select_id);
												console
													.log(this.business_process_id);

												if (main_service_id == this.business_process_id) {
													// if
													// (this.business_process_on_case
													// ==
													// 'No')
													// {
													$(
														'#mbm_sub_service_cp')
														.append(
															'<option value="'
															+ this.business_process_sub_id
															+ '-'
															+ this.business_process_sub_name
															+ '">'
															+ this.business_process_sub_name
															+ '</option>');

													// }

												}

											});
									// business_process_id
								}
							});

					})


			$('#rtb_main_service_cp')
				.change(
					function () {
						// alert($(this).val());
						var select_id = document
							.getElementById("rtb_main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;

						const
							main_service_name_id = main_service
								.split('-');

						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_lc_sub_service',
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#rtb_sub_service_cp");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												console
													.log(select_id);
												console
													.log(this.business_process_id);

												if (main_service_id == this.business_process_id) {
													// if
													// (this.business_process_on_case
													// ==
													// 'No')
													// {
													$(
														'#rtb_sub_service_cp')
														.append(
															'<option value="'
															+ this.business_process_sub_id
															+ '-'
															+ this.business_process_sub_name
															+ '">'
															+ this.business_process_sub_name
															+ '</option>');

													// }

												}

											});
									// business_process_id
								}
							});

					})

			$('#btn_generate_manual_bill')
				.on(
					'click',
					function (e) {

						var select_id = document
							.getElementById("mbm_main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;
						const
							main_service_name_id = main_service
								.split('-');
						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						var sub_select_id = document
							.getElementById("mbm_sub_service_cp");
						var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

						const
							sub_service_name_id = sub_service
								.split('-');
						var sub_service_id = sub_service_name_id[0];
						var sub_service_name = sub_service_name_id[1];

						var client_name = $(
							"#new_bill_application_client_name_mb").val();
						var client_id = $("#new_bill_application_client_id_mb").val();

						var tb_bill_amount = $(
							"#mbm_bill_amount").val();

						var mbm_bill_description = $(
							"#mbm_bill_description").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_online_select_bill_for_registration',
									main_service_id: main_service_id,
									main_service_sub_id: sub_service_id,
									main_service_desc: main_service_name,
									main_service_sub_desc: sub_service_name,
									client_name: client_name,
									case_number: 'Not Case',
									land_size: tb_bill_amount,
									registration_forms: 'Manual Bill',
									publication_type: 'No Pubication',
									type_of_use: '',
									licensed_surveyor_number: '',
									licensed_surveyor_name: '',
									locality: '',
									ar_gender: '',
									ar_district: '',
									ar_region: '',
									paper_size: '0',
									revenue_item: 'Manual Bill',
									no_of_copy: '0',
									office_region: '01_Greater Accra',
									submission_type: 'Office',
									created_for: client_name,
									created_for_id: client_id,
									application_required_additional_bill: 'No',
									manual_bill_desc: mbm_bill_description
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$('#manualbillblobfile')
										.attr('src',
											objectUrl);

								}
							});

					});

			$('#btn_search_old_bill_number_rtb').on('click', function (e) {

				var bill_number = $('#old_bill_number_rtb').val();
				var regional_code = $('#new_bill_application_office_region_on_case_rtb').val();

				console.log(bill_number, regional_code)

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					// target:'_blank',

					data: {
						request_type: 'select_load_previous_bill_number',
						bill_number: bill_number,
						regional_code: regional_code.replace(".0", "")
					},
					cache: false,

					success: function (jobdetails) {
						console.log(jobdetails)
						var json_p = JSON.parse(jobdetails);

						if (json_p.data == null) {
							alert("Bill number not found.")
							return;
						}

						$("#rtb_bill_amount").val(json_p.data[0].bill_amount)
						$("#rtb_previous_client_name").val(json_p.data[0].applicant_name)
						$("#rtb_previous_sub_service").val(json_p.data[0].business_process_sub_name)
					}
				})

			})

			$('#btn_generate_manual_bill_rtb')
				.on(
					'click',
					function (e) {

						var select_id = document
							.getElementById("rtb_main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;
						const
							main_service_name_id = main_service
								.split('-');
						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						var sub_select_id = document
							.getElementById("rtb_sub_service_cp");
						var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

						const
							sub_service_name_id = sub_service
								.split('-');
						var sub_service_id = sub_service_name_id[0];
						var sub_service_name = sub_service_name_id[1];

						var client_name = $(
							"#new_bill_application_client_name_rtb").val();
						var client_id = $("#new_bill_application_client_id_rtb").val();

						var tb_bill_amount = $(
							"#rtb_bill_amount").val();

						var mbm_bill_description = $(
							"#rtb_bill_description").val();
						var old_bill_number = $(
							"#old_bill_number_rtb").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_online_select_bill_for_regional_transitional',
									main_service_id: main_service_id,
									main_service_sub_id: sub_service_id,
									main_service_desc: main_service_name,
									main_service_sub_desc: sub_service_name,
									client_name: client_name,
									case_number: 'Not Case',
									land_size: '0',
									bill_amount: tb_bill_amount,
									registration_forms: 'Manual Bill',
									publication_type: 'No Pubication',
									type_of_use: '',
									licensed_surveyor_number: '',
									licensed_surveyor_name: '',
									locality: '',
									ar_gender: '',
									ar_district: '',
									ar_region: '',
									paper_size: '0',
									revenue_item: '0',
									no_of_copy: '0',
									office_region: '01_Greater Accra',
									submission_type: 'Office',
									created_for: client_name,
									created_for_id: client_id,
									application_required_additional_bill: 'No',
									manual_bill_desc: mbm_bill_description,
									old_bill_number: old_bill_number
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$('#manualbillblobfile_rtb')
										.attr('src',
											objectUrl);

								}
							});

					});

			$('#btn_generate_stamp_duty_bill')
				.on(
					'click',
					function (e) {

						var select_id = document
							.getElementById("stp_main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;
						const
							main_service_name_id = main_service
								.split('-');
						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						var sub_select_id = document
							.getElementById("stp_sub_service_cp");
						var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

						const
							sub_service_name_id = sub_service
								.split('-');
						var sub_service_id = sub_service_name_id[0];
						var sub_service_name = sub_service_name_id[1];

						var client_name = $(
							"#stp_applicant_name").val();

						var tb_bill_amount = $(
							"#stp_bill_amount").val();

						var mbm_bill_description = $(
							"#stp_bill_description").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_online_select_bill_for_registration',
									main_service_id: main_service_id,
									main_service_sub_id: sub_service_id,
									main_service_desc: main_service_name,
									main_service_sub_desc: sub_service_name,
									client_name: client_name,
									case_number: 'Not Case',
									land_size: tb_bill_amount,
									registration_forms: 'Stamp Duty Payment',
									publication_type: 'No Pubication',
									type_of_use: '',
									licensed_surveyor_number: '',
									licensed_surveyor_name: '',
									locality: '',
									ar_gender: '',
									ar_district: '',
									ar_region: '',
									paper_size: '0',
									revenue_item: 'Stamp Duty Payment',
									no_of_copy: '0',
									office_region: '01_Greater Accra',
									submission_type: 'Office',
									created_for: client_name,
									created_for_id: mbm_bill_description,
									application_required_additional_bill: 'No'
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$('#stpbillblobfile')
										.attr('src',
											objectUrl);

								}
							});

					});


			$('#btn_scm_job_number_search')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									// console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									if (jobdetails.includes('Error Loading Data')) {
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {
										var json_p = JSON.parse(jobdetails);
										$(json_p)
											.each(
												function () {

													// data-toggle="modal"
													// data-target="#accountDetailsModal"
													// 

													table
														.append("<tr><td>"
															+ this.job_number

															+ "</td><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.business_process_sub_name
															+ "</td><td>"

															+ this.current_application_status
															+ "</td>"

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#transitional_certificate_template" data-backdrop="static" data-keyboard="false" '
															+ 'data-transaction_number="'
															+ this.transaction_number

															+ '" '
															+ 'data-job_number="'
															+ this.job_number
															+ '" '
															+ 'data-case_number="'
															+ this.case_number
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'
															+ '<td>'


															+ '<form action="registration_application_progress_details" method="post">'
															+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'

															+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

															+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
															+ '	</button></form>'



															+ '</td>'
															+ '<td><form action="further_entries" method="post">'
															+ '<input type="hidden" name="transaction_number"  value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number"  value="' + this.job_number + '">'
															+ '<input  name="case_number" type="hidden" value="' + this.case_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">'
															+ '<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span></button></form></td>'


															+ "</tr>");

												});
									}





								}
							});

					});



			$('#btn_mf_job_number_search').on(
				'click',
				function (e) {

					// console.log('Assiama');
					var new_job_number = $(
						"#scm_job_number_search").val();

					$
						.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							// target:'_blank',

							data: {
								request_type: 'online_select_application_details_by_job_number',
								job_number: new_job_number,
								submission_type: 'Online'
							},
							cache: false,

							success: function (
								jobdetails) {
								// console.log(jobdetails);

								var table = $('#tbl_search_for_job_details_datatable');
								table.find("tbody tr")
									.remove();

								console.log(jobdetails);
								if (jobdetails.includes('Error Loading Data')) {
									$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
									return false;
								} else {
									var json_p = JSON.parse(jobdetails);
									$(json_p)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number

														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.business_process_sub_name
														+ "</td><td>"

														+ this.current_application_status
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														// + '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
														// + 'data-job_number="'
														// + this.job_number

														// + '" '
														// + 'data-ar_name="'
														// + this.ar_name
														// + '" '
														// + 'data-business_process_sub_name="'
														// + this.business_process_sub_name
														// + '" '

														// + 'data-business_process_sub_name="'
														// + this.business_process_sub_name

														// + '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#transitional_certificate_template" data-backdrop="static" data-keyboard="false" '
														+ 'data-transaction_number="'
														+ this.transaction_number

														+ '" '
														+ 'data-job_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span> View Details</button> </td>'
														+ '<td>'


														+ '<form action="motherfile_application_progress_details" method="post">'
														+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
														+ '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
														+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
														+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'

														+ '	<button type="submit" name="save" class="btn btn-danger btn-sm btn-to-be-disabled to_hide_on_level_1" >'

														+ '	<i class="fas fa-folder-open"></i>Work'
														+ '	</button></form>'



														+ '</td>'
														+ '<td><form action="further_entries" method="post">'
														+ '<input type="hidden" name="transaction_number"  value="' + this.transaction_number + '">'
														+ '<input type="hidden" name="job_number"  value="' + this.job_number + '">'
														+ '<input  name="case_number" type="hidden" value="' + this.case_number + '">'
														+ '<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">'
														+ '<button type="submit" name="save" class="btn btn-primary btn-sm" >'
														+ '<i class="fas fa-pen"></i>Entries</button></form></td>'


														+ "</tr>");

											});
								}





							}
						});

				});


			$('#btn_ar_job_number_search')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									// console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									if (jobdetails.includes('Error Loading Data')) {
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {
										var json_p = JSON.parse(jobdetails);
										$(json_p)
											.each(
												function () {

													// data-toggle="modal"
													// data-target="#accountDetailsModal"
													// 

													table
														.append("<tr><td>"
															+ this.job_number

															+ "</td><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.business_process_sub_name
															+ "</td><td>"

															+ this.current_application_status
															+ "</td>"

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#transitional_certificate_template" data-backdrop="static" data-keyboard="false" '
															+ 'data-transaction_number="'
															+ this.transaction_number

															+ '" '
															+ 'data-job_number="'
															+ this.job_number
															+ '" '
															+ 'data-case_number="'
															+ this.case_number
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'
															+ '<td>'


															+ '<form action="review_application_progress_details" method="post">'
															+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'

															+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

															+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
															+ '	</button></form>'



															+ '</td>'
															+ '<td><form action="further_entries" method="post">'
															+ '<input type="hidden" name="transaction_number"  value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number"  value="' + this.job_number + '">'
															+ '<input  name="case_number" type="hidden" value="' + this.case_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">'
															+ '<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span></button></form></td>'


															+ "</tr>");

												});
									}





								}
							});

					});


			$('#btn_sam_job_number_search')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									// console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									if (jobdetails.includes('Error Loading Data')) {
										return false;
									} else {
										var json_p = JSON.parse(jobdetails);
										$(json_p)
											.each(
												function () {

													// data-toggle="modal"
													// data-target="#accountDetailsModal"
													// 

													table
														.append("<tr><td>"
															+ this.job_number

															+ "</td><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.business_process_sub_name
															+ "</td><td>"

															+ this.current_application_status
															+ "</td>"

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#transitional_certificate_template" data-backdrop="static" data-keyboard="false" '
															+ 'data-transaction_number="'
															+ this.transaction_number

															+ '" '
															+ 'data-job_number="'
															+ this.job_number
															+ '" '
															+ 'data-case_number="'
															+ this.case_number
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'
															+ '<td>'


															+ '<form action="map_plotting_application_progress_details" method="post">'
															+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'

															+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

															+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
															+ '	</button></form>'



															+ '</td>'
															+ '<td><form action="further_entries" method="post">'
															+ '<input type="hidden" name="transaction_number"  value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number"  value="' + this.job_number + '">'
															+ '<input  name="case_number" type="hidden" value="' + this.case_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">'
															+ '<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span></button></form></td>'


															+ "</tr>");

												});
									}





								}
							});

					});


			$('#btn_scm_job_number_search_csp')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number_or_certificate_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									if (jobdetails.includes('Error Loading Data')) {
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number or certificate number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {
										var json_p = JSON.parse(jobdetails);
										$(json_p)
											.each(
												function () {

													// data-toggle="modal"
													// data-target="#accountDetailsModal"
													// 

													table
														.append("<tr><td>"
															+ this.job_number

															+ "</td><td>"
															+ this.certificate_number

															+ "</td><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.business_process_sub_name
															// + "</td><td>"

															// + this.current_application_status
															// + "</td>"


															+ '</td><td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#transitional_certificate_template" data-backdrop="static" data-keyboard="false" '
															+ 'data-transaction_number="'
															+ this.transaction_number

															+ '" '
															+ 'data-job_number="'
															+ this.job_number
															+ '" '
															+ 'data-case_number="'
															+ this.case_number
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'
															// +'<td>'


															// + '<form action="registration_application_progress_details" method="post">'
															// + '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
															// + '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
															// + '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
															// + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'

															// + '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

															// + '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
															// + '	</button></form>'																						



															// +'</td>'
															// +'<td><form action="further_entries" method="post">'
															// +'<input type="hidden" name="transaction_number"  value="' + this.transaction_number +'">'
															// +'<input type="hidden" name="job_number"  value="' + this.job_number +'">'
															// +'<input  name="case_number" type="hidden" value="' + this.case_number +'">'
															// +'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name +'">'
															// +'<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
															// +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span></button></form></td>'


															+ "</tr>");


													$('#csd_job_number').val(this.job_number);
													$('#csd_certificate_number').val(this.certificate_number);

												});
									}





								}
							});

					});

			$('#btn_scm_job_number_search_fr')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_archived_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									// console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									if (jobdetails.includes('Error Loading Data')) {
										return false;
									} else {
										var json_p = JSON.parse(jobdetails);
										$(json_p)
											.each(
												function () {

													// data-toggle="modal"
													// data-target="#accountDetailsModal"
													// 

													table
														.append("<tr><td>"
															+ this.job_number

															+ "</td><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.business_process_sub_name
															+ "</td><td>"

															+ this.current_application_status
															+ "</td>"

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Add Job to Client Attention Required"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#clientAttentionRequiredModal" data-backdrop="static" data-keyboard="false" '
															+ 'data-transaction_number="'
															+ this.transaction_number

															+ '" '
															+ 'data-job_number="'
															+ this.job_number
															+ '" '
															+ 'data-case_number="'
															+ this.case_number
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'


															+ "</tr>");

												});
									}





								}
							});

					});


			$('#btn_tcnp_job_number_search')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search").val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									// console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									if (jobdetails.includes('Error Loading Data')) {
										return false;
									} else {
										var json_p = JSON.parse(jobdetails);
										$(json_p)
											.each(
												function () {

													// data-toggle="modal"
													// data-target="#accountDetailsModal"
													// 

													table
														.append("<tr><td>"
															+ this.job_number

															+ "</td><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.business_process_sub_name
															+ "</td><td>"

															+ this.current_application_status
															+ "</td>"

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
															+ 'data-job_number="'
															+ this.job_number

															+ '" '
															+ 'data-ar_name="'
															+ this.ar_name
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

															+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#transitional_certificate_template" data-backdrop="static" data-keyboard="false" '
															+ 'data-transaction_number="'
															+ this.transaction_number

															+ '" '
															+ 'data-job_number="'
															+ this.job_number
															+ '" '
															+ 'data-case_number="'
															+ this.case_number
															+ '" '
															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name
															+ '" '

															+ 'data-business_process_sub_name="'
															+ this.business_process_sub_name

															+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'
															+ '<td>'


															+ '<form action="transitional_application_for_coordinate_noting_and_plotting" method="post">'
															+ '<input type="hidden" name="case_number" id="case_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="transaction_number" id="transaction_number" value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number" id="job_number" value="' + this.job_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="' + this.business_process_sub_name + '">'

															+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

															+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
															+ '	</button></form>'



															+ '</td>'
															+ '<td><form action="further_entries" method="post">'
															+ '<input type="hidden" name="transaction_number"  value="' + this.transaction_number + '">'
															+ '<input type="hidden" name="job_number"  value="' + this.job_number + '">'
															+ '<input  name="case_number" type="hidden" value="' + this.case_number + '">'
															+ '<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">'
															+ '<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span></button></form></td>'


															+ "</tr>");

												});
									}





								}
							});

					});


			$('#new_bill_application_office_region')
				.change(
					function () {
						// alert($(this).val());

						var sub_service = $(this).val();

						const
							sub_service_name_id = sub_service
								.split('-');

						var main_service_id = sub_service_name_id[0];
						var main_service_name = sub_service_name_id[1];

						// console.log(main_service_id);
						//console.log(main_service_name);
						main_service_id = main_service_id
							.replace('.0', '');

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_list_of_locality',
									region_id: main_service_id
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#new_bill_application_locality");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												$(
													'#new_bill_application_locality')
													.append(
														'<option value="'

														+ this.location_name
														+ '">'
														+ this.location_name
														+ '</option>');

											});
									// business_process_id
								}
							});

					})

			$('#new_bill_application_office_region_on_case')
				.change(
					function () {
						// alert($(this).val());

						var sub_service = $(this).val();

						const
							sub_service_name_id = sub_service
								.split('_');

						var main_service_id = sub_service_name_id[0];
						var main_service_name = sub_service_name_id[1];

						// console.log(main_service_id);
						// console.log(main_service_name);
						main_service_id = main_service_id
							.replace('.0', '');
						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'get_list_of_locality',
									region_id: main_service_id
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									var options = $("#new_bill_locality_on_case_1");

									// var options =
									// $("#selector");
									options.empty();
									options
										.append(new Option(
											"-- Select --",
											0));

									$(json_p)
										.each(
											function () {

												$(
													'#new_bill_locality_on_case_1')
													.append(
														'<option value="'

														+ this.location_name
														+ '">'
														+ this.location_name
														+ '</option>');

											});
									// business_process_id
								}
							});

					})

			$('#btn_scm_job_number_search_plan')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search_plan")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(json_p)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number

														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.business_process_sub_name
														+ "</td><td>"

														+ this.current_application_status
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#frmlrdtitleplanupdatemodal" data-backdrop="static" data-keyboard="false" '
														+ 'data-transaction_number="'
														+ this.transaction_number

														+ '" '
														+ 'data-job_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#newTransferMothertoChildModal" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-transaction_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ "</tr>");

											});

								}
							});

					});


			$('#btn_scm_job_number_search_plan_smd')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search_plan_smd")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable_smd');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(json_p)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number

														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.business_process_sub_name
														+ "</td><td>"

														+ this.current_application_status
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#frmlrdtitleplanupdatemodal_smd" data-backdrop="static" data-keyboard="false" '
														+ 'data-transaction_number="'
														+ this.transaction_number

														+ '" '
														+ 'data-job_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'



														+ "</tr>");

											});

								}
							});

					});


			$('#btn_uhpd_job_number_search_plan')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search_plan")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(json_p)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number

														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.business_process_sub_name
														+ "</td><td>"

														+ this.current_application_status
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#frmlrdtitlehardcopyplanupdatemodal" data-backdrop="static" data-keyboard="false" '
														+ 'data-transaction_number="'
														+ this.transaction_number

														+ '" '
														+ 'data-job_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#newTransferMothertoChildModal" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-transaction_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ "</tr>");

											});

								}
							});

					});


			$('#btn_mecd_job_number_search_plan')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#scm_job_number_search_plan")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									console.log(jobdetails);

									var table = $('#tbl_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(json_p)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number

														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.business_process_sub_name
														+ "</td><td>"

														+ this.current_application_status
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Link to Job"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#frmlrdtitlemecdplanupdatemodal" data-backdrop="static" data-keyboard="false" '
														+ 'data-transaction_number="'
														+ this.transaction_number

														+ '" '
														+ 'data-job_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#newTransferMothertoChildModal" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number

														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-transaction_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

														+ "</tr>");

											});

								}
							});

					});

			$('#btn_gld_job_number_search_plan')
				.on(
					'click',
					function (e) {

						// console.log('Assiama');
						var new_job_number = $(
							"#txt_gld_job_number_search_plan")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_select_application_details_by_job_number',
									job_number: new_job_number,
									submission_type: 'Online'
								},
								cache: false,

								success: function (
									jobdetails) {
									console.log(jobdetails);

									var table = $('#tbl_gld_search_for_job_details_datatable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(json_p)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 

												table
													.append("<tr><td>"
														+ this.job_number

														+ "</td><td>"
														+ this.ar_name
														+ "</td><td>"
														+ this.business_process_sub_name
														+ "</td><td>"

														+ this.current_application_status
														+ "</td>"

														+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#frmlrdgeneratelsnumberdeedsmodal" data-backdrop="static" data-keyboard="false" '
														+ 'data-job_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.case_number
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-certificate_number="'
														+ this.certificate_number
														+ '" '
														+ 'data-plot_number="'
														+ this.plot_number
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" '

														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name
														+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'


														+ "</tr>");

											});

								}
							});

					});

			$('#btn_brn_licenced_number_search')
				.on(
					'click',
					function (e) {
						var ls_number = $(
							"#txt_brn_licenced_number")
							.val();

						// console.log(id_number);
						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_load_details_of_licenced_surveyor',
									ls_number: ls_number
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									// console.log("lINCESE
									// SURV: " +jobdetails);

									if (jobdetails
										.includes('Error in loading Data')) {
										alert('Surveyor number does not exist, or Surveyor is not in good standing')
										return false;
									} else {
										var json_p = JSON
											.parse(jobdetails);
										console.log(json_p);
										// $('#case_file_number').val(jobdetails);
										$(
											'#txt_brn_licenced_name')
											.val(
												json_p.licensed_surveyor_name);
										$(
											'#txt_brn_licenced_status_new')
											.val(
												json_p.licensed_surveyor_status);

									}

								}
							});
						//	
					});

			$('#btn_brn_generate_bill')
				.on(
					'click',
					function (e) {

						var select_id = document
							.getElementById("main_service_cp");
						var main_service = select_id.options[select_id.selectedIndex].value;
						const
							main_service_name_id = main_service
								.split('-');

						var main_service_id = main_service_name_id[0];
						var main_service_name = main_service_name_id[1];

						var sub_select_id = document
							.getElementById("sub_service_cp");
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
							"#txt_brn_licenced_name").val();

						var office_region = $(
							"#new_bill_application_office_region_reg_no")
							.val();

						if (office_region === "") {
							alert('Please select office Region');
							$(
								"#new_bill_application_office_region_reg_no")
								.focus();
							return false;
						}

						if (office_region === "null") {
							alert('Please select office Region');
							$(
								"#new_bill_application_office_region_reg_no")
								.focus();
							return false;
						}

						if (office_region === "-1") {
							alert('Please select office Region');
							$(
								"#new_bill_application_office_region_reg_no")
								.focus();
							return false;
						}

						// var office_region = '10_Greater
						// Accra';

						var revenue_item = $(
							"#new_type_of_revenue_item_t")
							.val();

						var no_of_copy = $(
							"#txt_brn_bill_application_qty")
							.val();

						var licensed_surveyor_name = '';
						var land_size = '0';

						if (main_service_name === 'APPLICATION FOR REGIONAL NUMBER') {

							var revenue_item = '0';

							var type_of_use = '';
							var registration_forms = '';
							var land_size = '0';
							var publication_type = '';

							var ar_gender = 'N/A';
							var locality = 'N/A';
							var ar_district = $(
								"#new_bill_application_office_region_reg_no")
								.val();
							var ar_region = $(
								"#new_bill_application_office_region_reg_no")
								.val();
							;

							var licensed_surveyor_number = $(
								"#txt_brn_licenced_number")
								.val();

							client_name = $(
								"#txt_brn_licenced_name")
								.val();
							licensed_surveyor_name = $(
								"#txt_brn_licenced_name")
								.val();

							if (licensed_surveyor_number == "") {
								// $('#new_bill_application_ls_number').after('<span
								// class="error">This field is
								// required</span>');
								alert("Please enter licensed surveyor's number.");
								$("#txt_brn_licenced_number")
									.focus();
								return false;
							}

						}

						var created_for = $(
							"#txt_brn_licenced_name").val();
						;
						var created_for_id = $(
							"#txt_brn_licenced_number")
							.val();
						;
						var application_required_additional_bill = 'No';
						var case_number = 'Not Case';

						// console.log('land_size');
						// console.log(land_size);
						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_online_select_bill_for_registration',
									main_service_id: main_service_id,
									main_service_sub_id: sub_service_id,
									main_service_desc: main_service_name,
									main_service_sub_desc: sub_service_name,
									client_name: client_name,
									case_number: case_number,
									land_size: land_size,
									registration_forms: registration_forms,
									publication_type: publication_type,
									type_of_use: type_of_use,
									licensed_surveyor_number: licensed_surveyor_number,
									licensed_surveyor_name: licensed_surveyor_name,
									locality: locality,
									ar_gender: ar_gender,
									ar_district: ar_district,
									ar_region: ar_region,
									paper_size: 0,
									revenue_item: revenue_item,
									no_of_copy: no_of_copy,
									office_region: office_region,
									submission_type: 'Office',
									surveyors_client: '-',
									created_for: created_for,
									created_for_id: created_for_id,
									application_required_additional_bill: application_required_additional_bill
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[jobdetails],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									window.open(objectUrl);

									console.log(jobdetails);

								}
							});

					});

			$('#btn_brn_client_number_search')
				.on(
					'click',
					function (e) {
						var client_phone_search = $(
							"#txt_brn_licenced_number")
							.val();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)
							&& client_phone_search != '123') {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						$
							.ajax({
								type: "POST",
								url: "csau_mgt_serv",
								// target:'_blank',

								data: {
									request_type: 'select_portal_users_by_email',
									search_by: client_phone_search,
									submission_type: 'Online'
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								/*
								 * xhrFields : {
								 * responseType : 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									// console.log(jobdetails);
									// alert(jobdetails);

									console.log(jobdetails);

									var json_p = JSON
										.parse(jobdetails);

									$(json_p.data)
										.each(
											function () {

												// data-toggle="modal"
												// data-target="#accountDetailsModal"
												// 
												$(
													'#txt_brn_licenced_name')
													.val(
														+this.first_name
														+ ' '
														+ this.other_names
														+ ' '
														+ this.last_name);
												$(
													'#txt_brn_client_status_new')
													.val(
														+this.email);

											});

								}
							});

					});

			$('#lc_btn_save_print_consent_fees')
				.on(
					'click',
					function (e) {

						var job_number = $(
							"#cs_main_job_number").val();
						var case_number = $(
							"#cs_main_case_number").val();
						var transaction_number = $(
							"#cs_main_transaction_number")
							.val();

						var tb_job_number = $(
							"#cs_main_job_number").val();
						var case_number = $(
							"#cs_main_case_number").val();
						var client_name = $("#cs_main_ar_name")
							.val();
						var publication_type = 'Consent Fees';

						/*
						 * var publication_type = $(
						 * "#tb_bill_type").val();
						 */
						var tb_bill_amount = $(
							"#txt_lc_consent_fee").val();

						/*
						 * var created_for_id = $(
						 * "#tb_created_for_id").val();
						 */
						var created_for_id = 'Consent Fees';

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'process_online_select_bill_for_registration',
									main_service_id: '999',
									main_service_sub_id: '999',
									main_service_desc: 'Consent Fees',
									main_service_sub_desc: 'Consent Fees',
									client_name: client_name,
									case_number: case_number,
									land_size: tb_bill_amount,
									registration_forms: 'No',
									publication_type: publication_type,
									type_of_use: '',
									licensed_surveyor_number: '',
									licensed_surveyor_name: '',
									locality: '',
									ar_gender: '',
									ar_district: '',
									ar_region: '',
									paper_size: '0',
									revenue_item: 'Manual Bill',
									no_of_copy: '0',
									office_region: '01_Greater Accra',
									submission_type: 'Office',
									created_for: client_name,
									created_for_id: created_for_id,
									application_required_additional_bill: 'No'
								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									var blob = new Blob(
										[data],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									window.open(objectUrl);

									$(
										'#transitionalbillblobfile')
										.attr('src',
											objectUrl);

								}
							});

					});

			$('#btn_save_certificate_ground_rent_revised')
				.on(
					'click',
					function (e) {

						console.log('hoe');

						var job_number = $(
							"#cs_main_job_number").val();
						var case_number = $(
							"#cs_main_case_number").val();
						var transaction_number = $(
							"#cs_main_transaction_number")
							.val();
						var ground_rent = $(
							"#txt_certificate_ground_rent")
							.val();

						console
							.log('btn_save_certificate_ground_rent');

						$
							.ajax({

								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',
								data: {
									request_type: 'select_update_application_ground_rent',
									job_number: job_number,
									case_number: transaction_number,
									transaction_number: transaction_number,
									ground_rent: ground_rent

								},
								cache: false,
								/*
								 * xhrFields:{ responseType:
								 * 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									alert(jobdetails);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									/*
									 * var blob = new
									 * Blob([jobdetails],
									 * {type:
									 * "application/pdf"});
									 * var objectUrl =
									 * URL.createObjectURL(blob);
									 * window.open(objectUrl);
									 */
								}
							});
					});

			$('#btnLinktoExistingCaselist')
				.on(
					'click',
					function (e) {

						// console.log('hoe');

						var job_number = $("#fe_job_number")
							.val();
						var case_number = $("#fe_case_number")
							.val();
						var transaction_number = $(
							"#fe_transaction_number").val();

						$("#linkjobtoTransactionModal").modal(
							"show");

						$(
							'#linkjobtoTransactionModal #ljt_new_job_number')
							.val(job_number);
						$(
							'#linkjobtoTransactionModal #ljt_new_transaction_number')
							.val(transaction_number);

					});

			$('#btn_ljt_search_for_job_number_details')
				.on(
					'click',
					function (e) {

						var job_number = $("#ljt_job_number")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'load_application_details_by_job_number_all',
									job_number: job_number

								},
								cache: false,
								// responseType:
								// 'arraybuffer',
								// dataType:'blob',

								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);

									$(json_p.data)
										.each(
											function () {

												$(
													"#ljt_case_number")
													.val(
														this.case_number);
												$(
													"#ljt_transaction_number")
													.val(
														this.transaction_number);
												$(
													"#ljt_ar_name")
													.val(
														this.ar_name);
												$(
													"#ljt_job_number_result")
													.val(
														this.job_number);

											});
								}
							});

					});

			$('#btn_save_link_job_to_transaction')
				.on(
					'click',
					function (e) {
						var new_transaction_number = $(
							"#ljt_new_transaction_number")
							.val();

						var new_job_number = $(
							"#ljt_new_job_number").val();

						var old_transaction_number = $(
							"#ljt_transaction_number")
							.val();

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'online_link_account_to_jobs',

									new_transaction_number: new_transaction_number,
									new_job_number: new_job_number,
									old_transaction_number: old_transaction_number
								},
								cache: false,

								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (data) {
									console.log(data);

									alert(data);

									$(
										'#linkjobtoTransactionModal')
										.modal('hide');
								}
							});
					});

			$('#add_records_information_notes').on(
				'click',
				function (e) {

					$("#addNotesModal").modal();

					$('#addNotesModal #an_type').val(
						'Regsitration_Search');

				});

			$('#lc_btn_add_note_on_application_all').on('click',
				function (e) {

					$("#addNotesModal").modal();
					$('#addNotesModal #an_id').val('0');
					$('#addNotesModal #an_description').val('');
					document.getElementById('an_description').readOnly = false;

				});


			$('#btn_save_generate_lc_number_deeds_number_gld').on('click',
				function (e) {

					$("#lc_txt_certificate_number_gld").val('WN202021');
					$("#lc_txt_plot_number_gld").val('WN8782021');


				});


			$('#frmlrdgeneratelsnumberdeedsmodal')
				.on(
					'show.bs.modal',
					function (event) {

						var job_number = $(event.relatedTarget)
							.data('job_number');
						var transaction_number = $(
							event.relatedTarget).data(
								'transaction_number');
						var case_number = $(event.relatedTarget)
							.data('case_number');

						var ar_name = $(event.relatedTarget)
							.data('ar_name');


						$("#txt_lc_job_number_gld").val(job_number);
						//$("#cs_main_case_number").val(transaction_number);
						$("#txt_lc_case_number_gld").val(case_number);
						$("#txt_lc_ar_name_gld").val(ar_name);


						console.log(job_number);
						console.log(transaction_number);
						console.log(case_number);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_general_case_details',
									job_number: job_number,
									transaction_number: transaction_number,
									case_number: case_number

								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {


								}
							});

					});

			$('#frmlrdtitleplanupdatemodal')
				.on(
					'show.bs.modal',
					function (event) {

						var job_number = $(event.relatedTarget)
							.data('job_number');
						var transaction_number = $(
							event.relatedTarget).data(
								'transaction_number');
						var case_number = $(event.relatedTarget)
							.data('case_number');

						//	console.log(job_number);
						//	console.log(transaction_number);
						//	console.log(case_number);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_general_case_details',
									job_number: job_number,
									transaction_number: transaction_number,
									case_number: case_number

								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);

									var result = JSON
										.parse(jobdetails);

									// console.log(result)

									if (result.parcel_details !== null) {
										// console.log("not


										$("#gid_pl")
											.val([]);

										$(
											"#cs_main_case_number")
											.val([]);

										$(
											"#txt_glpin_pl")
											.val([]);

										$(
											"#cs_main_licensed_no")
											.val([]);

										$(
											"#cs_main_regional_number")
											.val([]);

										$(
											"#cs_main_locality")
											.val([]);
										$(
											"#cs_main_district")
											.val([]);

										$("#cs_main_region")
											.val([]);

										$(
											"#txt_lc_size_of_land_pl")
											.val([]);

										$(
											"#txt_lc_registry_mapref_pl")
											.val([]);

										$(
											"#txt_lc_plan_no_pl")
											.val([]);

										$("#cs_main_cc_no")
											.val([]);

										$("#ltr_plan_no_pl")
											.val([]);
										$(
											"#cs_main_locality_class")
											.val([]);
										$(
											"#txt_lc_registration_district_number_pl")
											.val([]);

										$(
											"#txt_lc_registration_section_number_pl")
											.val([]);
										$(
											"#txt_lc_registration_block_number_pl")
											.val([]);



										$(
											"#lc_txt_transaction_number_pl")
											.val([]);

										$(
											"#lc_txt_certificate_number_pl")
											.val([]);

										$(
											"#lc_txt_volume_number_pl")
											.val([]);
										$(
											"#lc_txt_folio_number_pl")
											.val([]);



										$("#gid_pl")
											.val(
												result.parcel_details.gid);

										$(
											"#cs_main_case_number")
											.val(
												result.parcel_details.case_number);

										$(
											"#txt_glpin_pl")
											.val(
												result.parcel_details.glpin);

										$(
											"#cs_main_licensed_no")
											.val(
												result.parcel_details.licensed_no);

										$(
											"#cs_main_regional_number")
											.val(
												result.parcel_details.regional_number);

										$(
											"#cs_main_locality")
											.val(
												result.parcel_details.locality);
										$(
											"#cs_main_district")
											.val(
												result.parcel_details.district);

										$("#cs_main_region")
											.val(
												result.parcel_details.region);

										$(
											"#txt_lc_size_of_land_pl")
											.val(
												result.parcel_details.land_size);

										$(
											"#txt_lc_registry_mapref_pl")
											.val(
												result.parcel_details.registry_mapref);

										$(
											"#txt_lc_plan_no_pl")
											.val(
												result.parcel_details.plan_no);

										$("#cs_main_cc_no")
											.val(
												result.parcel_details.cc_no);

										$("#ltr_plan_no_pl")
											.val(
												result.parcel_details.ltr_plan_no);
										$(
											"#cs_main_locality_class")
											.val(
												result.parcel_details.locality_class);
										$(
											"#txt_lc_registration_district_number_pl")
											.val(
												result.parcel_details.registration_district_number);

										$(
											"#txt_lc_registration_section_number_pl")
											.val(
												result.parcel_details.registration_section_number);
										$(
											"#txt_lc_registration_block_number_pl")
											.val(
												result.parcel_details.registration_block_number);



										$(
											"#lc_txt_transaction_number_pl")
											.val(
												result.transaction_details.transaction_number);

										$(
											"#lc_txt_certificate_number_pl")
											.val(
												result.transaction_details.certificate_number);

										$(
											"#lc_txt_volume_number_pl")
											.val(
												result.transaction_details.volume_number);
										$(
											"#lc_txt_folio_number_pl")
											.val(
												result.transaction_details.folio_number);
									}

									// -----------------------------

								}
							});

					});

			$('#frmlrdtitlehardcopyplanupdatemodal')
				.on(
					'show.bs.modal',
					function (event) {

						var job_number = $(event.relatedTarget)
							.data('job_number');
						var transaction_number = $(
							event.relatedTarget).data(
								'transaction_number');
						var case_number = $(event.relatedTarget)
							.data('case_number');

						//	console.log(job_number);
						//	console.log(transaction_number);
						//	console.log(case_number);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_general_case_details',
									job_number: job_number,
									transaction_number: transaction_number,
									case_number: case_number

								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);

									var result = JSON
										.parse(jobdetails);

									// console.log(result)

									if (result.parcel_details !== null) {
										// console.log("not


										$("#gid_uhp")
											.val([]);

										$(
											"#cs_main_case_number_uhp")
											.val([]);

										$(
											"#txt_glpin_uhp")
											.val([]);

										$(
											"#cs_main_licensed_no_uhp")
											.val([]);

										$(
											"#cs_main_regional_number_uhp")
											.val([]);

										$(
											"#cs_main_locality_uhp")
											.val([]);
										$(
											"#cs_main_district_uhp")
											.val([]);

										$("#cs_main_region_uhp")
											.val([]);

										$(
											"#txt_lc_size_of_land_uhp")
											.val([]);

										$(
											"#txt_lc_registry_mapref_uhp")
											.val([]);

										$(
											"#txt_lc_plan_no_uhp")
											.val([]);

										$("#cs_main_cc_no_uhp")
											.val([]);

										$("#ltr_plan_no_uhp")
											.val([]);
										$(
											"#cs_main_locality_class_uhp")
											.val([]);
										$(
											"#txt_lc_registration_district_number_uhp")
											.val([]);

										$(
											"#txt_lc_registration_section_number_uhp")
											.val([]);
										$(
											"#txt_lc_registration_block_number_uhp")
											.val([]);



										$(
											"#lc_txt_transaction_number_uhp")
											.val([]);

										$(
											"#lc_txt_certificate_number_uhp")
											.val([]);

										$(
											"#lc_txt_volume_number_uhp")
											.val([]);
										$(
											"#lc_txt_folio_number_uhp")
											.val([]);



										$("#gid_uhp")
											.val(
												result.parcel_details.gid);

										$(
											"#cs_main_case_number_uhp")
											.val(
												result.parcel_details.case_number);

										$(
											"#txt_glpin_uhp")
											.val(
												result.parcel_details.glpin);

										$(
											"#cs_main_licensed_no_uhp")
											.val(
												result.parcel_details.licensed_no);

										$(
											"#cs_main_regional_number_uhp")
											.val(
												result.parcel_details.regional_number);

										$(
											"#cs_main_locality_uhp")
											.val(
												result.parcel_details.locality);
										$(
											"#cs_main_district_uhp")
											.val(
												result.parcel_details.district);

										$("#cs_main_region_uhp")
											.val(
												result.parcel_details.region);

										$(
											"#txt_lc_size_of_land_uhp")
											.val(
												result.parcel_details.land_size);

										$(
											"#txt_lc_registry_mapref_uhp")
											.val(
												result.parcel_details.registry_mapref);

										$(
											"#txt_lc_plan_no_uhp")
											.val(
												result.parcel_details.plan_no);

										$("#cs_main_cc_no_uhp")
											.val(
												result.parcel_details.cc_no);

										$("#ltr_plan_no_uhp")
											.val(
												result.parcel_details.ltr_plan_no);
										$(
											"#cs_main_locality_class_uhp")
											.val(
												result.parcel_details.locality_class);
										$(
											"#txt_lc_registration_district_number_uhp")
											.val(
												result.parcel_details.registration_district_number);

										$(
											"#txt_lc_registration_section_number_uhp")
											.val(
												result.parcel_details.registration_section_number);
										$(
											"#txt_lc_registration_block_number_uhp")
											.val(
												result.parcel_details.registration_block_number);



										$(
											"#lc_txt_transaction_number_uhp")
											.val(
												result.transaction_details.transaction_number);

										$(
											"#lc_txt_certificate_number_uhp")
											.val(
												result.transaction_details.certificate_number);

										$(
											"#lc_txt_volume_number_uhp")
											.val(
												result.transaction_details.volume_number);
										$(
											"#lc_txt_folio_number_uhp")
											.val(
												result.transaction_details.folio_number);
									}

									// -----------------------------

								}
							});

					});


			$('#frmlrdtitlemecdplanupdatemodal')
				.on(
					'show.bs.modal',
					function (event) {

						var job_number = $(event.relatedTarget)
							.data('job_number');
						var transaction_number = $(
							event.relatedTarget).data(
								'transaction_number');
						var case_number = $(event.relatedTarget)
							.data('case_number');

						//	console.log(job_number);
						//	console.log(transaction_number);
						//	console.log(case_number);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_general_case_details',
									job_number: job_number,
									transaction_number: transaction_number,
									case_number: case_number

								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);

									var result = JSON
										.parse(jobdetails);

									// console.log(result)

									if (result.parcel_details !== null) {
										// console.log("not


										$("#gid_mecd")
											.val([]);

										$(
											"#cs_main_case_number_mecd")
											.val([]);

										$(
											"#txt_glpin_uhp")
											.val([]);

										$(
											"#cs_main_licensed_no_mecd")
											.val([]);

										$(
											"#cs_main_regional_number_mecd")
											.val([]);

										$(
											"#cs_main_locality_mecd")
											.val([]);
										$(
											"#cs_main_district_mecd")
											.val([]);

										$("#cs_main_region_uhp")
											.val([]);

										$(
											"#txt_lc_size_of_land_mecd")
											.val([]);

										$(
											"#txt_lc_registry_mapref_mecd")
											.val([]);

										$(
											"#txt_lc_plan_no_mecd")
											.val([]);

										$("#cs_main_cc_no_mecd")
											.val([]);

										$("#ltr_plan_no_mecd")
											.val([]);
										$(
											"#cs_main_locality_class_mecd")
											.val([]);
										$(
											"#txt_lc_registration_district_number_mecd")
											.val([]);

										$(
											"#txt_lc_registration_section_number_mecd")
											.val([]);
										$(
											"#txt_lc_registration_block_number_mecd")
											.val([]);



										$(
											"#lc_txt_transaction_number_mecd")
											.val([]);

										$(
											"#lc_txt_certificate_number_mecd")
											.val([]);

										$(
											"#lc_txt_volume_number_mecd")
											.val([]);
										$(
											"#lc_txt_folio_number_mecd")
											.val([]);



										$("#gid_mecd")
											.val(
												result.parcel_details.gid);

										$(
											"#cs_main_case_number_mecd")
											.val(
												result.parcel_details.case_number);

										$(
											"#txt_glpin_mecd")
											.val(
												result.parcel_details.glpin);

										$(
											"#cs_main_licensed_no_mecd")
											.val(
												result.parcel_details.licensed_no);

										$(
											"#cs_main_regional_number_mecd")
											.val(
												result.parcel_details.regional_number);

										$(
											"#cs_main_locality_mecd")
											.val(
												result.parcel_details.locality);
										$(
											"#cs_main_district_mecd")
											.val(
												result.parcel_details.district);

										$("#cs_main_region_mecd")
											.val(
												result.parcel_details.region);

										$(
											"#txt_lc_size_of_land_mecd")
											.val(
												result.parcel_details.land_size);

										$(
											"#txt_lc_registry_mapref_mecd")
											.val(
												result.parcel_details.registry_mapref);

										$(
											"#txt_lc_plan_no_mecd")
											.val(
												result.parcel_details.plan_no);

										$("#cs_main_cc_no_mecd")
											.val(
												result.parcel_details.cc_no);

										$("#ltr_plan_no_mecd")
											.val(
												result.parcel_details.ltr_plan_no);
										$(
											"#cs_main_locality_class_mecd")
											.val(
												result.parcel_details.locality_class);
										$(
											"#txt_lc_registration_district_number_mecd")
											.val(
												result.parcel_details.registration_district_number);

										$(
											"#txt_lc_registration_section_number_mecd")
											.val(
												result.parcel_details.registration_section_number);
										$(
											"#txt_lc_registration_block_number_mecd")
											.val(
												result.parcel_details.registration_block_number);



										$(
											"#lc_txt_transaction_number_mecd")
											.val(
												result.transaction_details.transaction_number);

										$(
											"#lc_txt_certificate_number_mecd")
											.val(
												result.transaction_details.certificate_number);

										$(
											"#lc_txt_volume_number_mecd")
											.val(
												result.transaction_details.volume_number);
										$(
											"#lc_txt_folio_number_mecd")
											.val(
												result.transaction_details.folio_number);
									}

									// -----------------------------

								}
							});

					});

			$('#btn_save_lrd_title_plan_update_details')
				.on(
					'click',
					function (e) {

						console.log('hoe');

						var gid = $("#gid_pl").val();
						var registry_mapref = $(
							"#txt_lc_registry_mapref_pl")
							.val();
						var size_of_land = $(
							"#txt_lc_size_of_land_pl")
							.val();
						var plan_no = $("#txt_lc_plan_no_pl")
							.val();

						var ltr_plan_no = $("#ltr_plan_no_pl")
							.val();
						var registration_district_number = $(
							"#txt_lc_registration_district_number_pl")
							.val();
						var registration_section_number = $(
							"#txt_lc_registration_section_number_pl")
							.val();
						var registration_block_number = $(
							"#txt_lc_registration_block_number_pl")
							.val();



						var certificate_number = $(
							"#lc_txt_certificate_number_pl")
							.val();
						var volume_number = $(
							"#lc_txt_volume_number_pl")
							.val();
						var folio_number = $(
							"#lc_txt_folio_number_pl")
							.val();


						var transaction_number = $(
							"#lc_txt_transaction_number_pl")
							.val();


						console
							.log('btn_save_certificate_ground_rent');

						$
							.ajax({

								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',
								data: {
									request_type: 'select_update_title_plan_details',
									gid: gid,
									registry_mapref: registry_mapref,
									size_of_land: size_of_land,
									plan_no: plan_no,
									ltr_plan_no: ltr_plan_no,
									registration_district_number: registration_district_number,
									registration_section_number: registration_section_number,
									registration_block_number: registration_block_number,
									transaction_number: transaction_number,
									certificate_number: certificate_number,
									volume_number: volume_number,
									folio_number: folio_number

								},
								cache: false,
								/*
								 * xhrFields:{ responseType:
								 * 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									alert(jobdetails);

								}
							});
					});


			$('#btn_save_lrd_title_hardcopy_plan_update_details')
				.on(
					'click',
					function (e) {

						console.log('hoe');

						var gid = $("#gid_uhp").val();
						var registry_mapref = $(
							"#txt_lc_registry_mapref_uhp")
							.val();
						var size_of_land = $(
							"#txt_lc_size_of_land_uhp")
							.val();
						var plan_no = $("#txt_lc_plan_no_uhp")
							.val();

						var ltr_plan_no = $("#ltr_plan_no_uhp")
							.val();
						var registration_district_number = $(
							"#txt_lc_registration_district_number_uhp")
							.val();
						var registration_section_number = $(
							"#txt_lc_registration_section_number_uhp")
							.val();
						var registration_block_number = $(
							"#txt_lc_registration_block_number_uhp")
							.val();



						var certificate_number = $(
							"#lc_txt_certificate_number_uhp")
							.val();
						var volume_number = $(
							"#lc_txt_volume_number_uhp")
							.val();
						var folio_number = $(
							"#lc_txt_folio_number_uhp")
							.val();


						var transaction_number = $(
							"#lc_txt_transaction_number_uhp")
							.val();

						var cc_no = $("#cs_main_cc_no_uhp").val()


						console
							.log('btn_save_certificate_ground_rent');

						$
							.ajax({

								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',
								data: {
									request_type: 'select_update_title_plan_details',
									gid: gid,
									registry_mapref: registry_mapref,
									size_of_land: size_of_land,
									plan_no: plan_no,
									ltr_plan_no: ltr_plan_no,
									registration_district_number: registration_district_number,
									registration_section_number: registration_section_number,
									registration_block_number: registration_block_number,
									transaction_number: transaction_number,
									certificate_number: certificate_number,
									volume_number: volume_number,
									folio_number: folio_number,
									cc_no: cc_no

								},
								cache: false,
								/*
								 * xhrFields:{ responseType:
								 * 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									alert(jobdetails);

								}
							});
					});

			$('#btn_save_lrd_title_mecd_plan_update_details')
				.on(
					'click',
					function (e) {

						console.log('hoe');

						var gid = $("#gid_mecd").val();
						var registry_mapref = $(
							"#txt_lc_registry_mapref_mecd")
							.val();
						var size_of_land = $(
							"#txt_lc_size_of_land_mecd")
							.val();
						var plan_no = $("#txt_lc_plan_no_mecd")
							.val();

						var ltr_plan_no = $("#ltr_plan_no_mecd")
							.val();
						var registration_district_number = $(
							"#txt_lc_registration_district_number_mecd")
							.val();
						var registration_section_number = $(
							"#txt_lc_registration_section_number_mecd")
							.val();
						var registration_block_number = $(
							"#txt_lc_registration_block_number_mecd")
							.val();



						var certificate_number = $(
							"#lc_txt_certificate_number_mecd")
							.val();
						var volume_number = $(
							"#lc_txt_volume_number_mecd")
							.val();
						var folio_number = $(
							"#lc_txt_folio_number_mecd")
							.val();


						var transaction_number = $(
							"#lc_txt_transaction_number_mecd")
							.val();

						var certificate_type = $(
							"#lc_txt_type_of_certificate_mecd")
							.val();


						// console
						// 		.log('btn_save_certificate_ground_rent');

						if (certificate_number == "-" || volume_number == "-" || !folio_number == "-" || !transaction_number == "-" || !certificate_type == "-1" || !size_of_land) {
							alert("Please Fill All Fields");
							return;
						} else {

							$
								.ajax({

									type: "POST",
									url: "Case_Management_Serv",
									// target:'_blank',
									data: {
										request_type: 'select_update_title_plan_details',
										gid: gid,
										registry_mapref: registry_mapref,
										size_of_land: size_of_land,
										plan_no: plan_no,
										ltr_plan_no: ltr_plan_no,
										registration_district_number: registration_district_number,
										registration_section_number: registration_section_number,
										registration_block_number: registration_block_number,
										transaction_number: transaction_number,
										certificate_number: certificate_number,
										volume_number: volume_number,
										folio_number: folio_number,
										certificate_type: certificate_type

									},
									cache: false,
									/*
									 * xhrFields:{ responseType:
									 * 'blob' },
									 */
									beforeSend: function () {
										// $('#district').html('<img
										// src="img/loading.gif"
										// alt="" width="24"
										// height="24">');
									},
									success: function (
										jobdetails) {
										console.log(jobdetails);
										alert(jobdetails);

									}
								});

						}
					});


			$('#frmlrdtitleplanupdatemodal_smd')
				.on(
					'show.bs.modal',
					function (event) {

						var job_number = $(event.relatedTarget)
							.data('job_number');
						var transaction_number = $(
							event.relatedTarget).data(
								'transaction_number');
						var case_number = $(event.relatedTarget)
							.data('case_number');

						//	console.log(job_number);
						//	console.log(transaction_number);
						//	console.log(case_number);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_general_case_details',
									job_number: job_number,
									transaction_number: transaction_number,
									case_number: case_number

								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);

									var result = JSON
										.parse(jobdetails);

									// console.log(result)

									if (result.parcel_details !== null) {
										// console.log("not


										$("#gid_pl_smd")
											.val([]);

										$(
											"#cs_main_case_number")
											.val([]);

										$(
											"#txt_glpin_pl_smd")
											.val([]);

										$(
											"#cs_main_licensed_no_smd")
											.val([]);

										$(
											"#cs_main_regional_number_smd")
											.val([]);

										$(
											"#cs_main_locality_smd")
											.val([]);
										$(
											"#cs_main_district_smd")
											.val([]);

										$("#cs_main_region_smd")
											.val([]);

										$(
											"#txt_lc_size_of_land_pl_smd")
											.val([]);

										$(
											"#txt_lc_registry_mapref_pl_smd")
											.val([]);

										$(
											"#txt_lc_plan_no_pl_smd")
											.val([]);

										$("#cs_main_cc_n_smd")
											.val([]);

										$("#ltr_plan_no_pl_smd")
											.val([]);
										$(
											"#cs_main_locality_class_smd")
											.val([]);
										$(
											"#txt_lc_registration_district_number_pl_smd")
											.val([]);

										$(
											"#txt_lc_registration_section_number_pl_smd")
											.val([]);
										$(
											"#txt_lc_registration_block_number_pl_smd")
											.val([]);



										$(
											"#lc_txt_transaction_number_pl_smd")
											.val([]);

										$(
											"#lc_txt_certificate_number_pl_smd")
											.val([]);

										$(
											"#lc_txt_volume_number_pl_smd")
											.val([]);
										$(
											"#lc_txt_folio_number_pl_smd")
											.val([]);



										$("#gid_pl_smd")
											.val(
												result.parcel_details.gid);

										$(
											"#cs_main_case_number_smd")
											.val(
												result.parcel_details.case_number);

										$(
											"#txt_glpin_pl_smd")
											.val(
												result.parcel_details.glpin);

										$(
											"#cs_main_licensed_no_smd")
											.val(
												result.parcel_details.licensed_no);

										$(
											"#cs_main_regional_number_smd")
											.val(
												result.parcel_details.regional_number);

										$(
											"#cs_main_locality_smd")
											.val(
												result.parcel_details.locality);
										$(
											"#cs_main_district_smd")
											.val(
												result.parcel_details.district);

										$("#cs_main_region")
											.val(
												result.parcel_details.region);

										$(
											"#txt_lc_size_of_land_pl_smd")
											.val(
												result.parcel_details.land_size);

										$(
											"#txt_lc_registry_mapref_pl_smd")
											.val(
												result.parcel_details.registry_mapref);

										$(
											"#txt_lc_plan_no_pl_smd")
											.val(
												result.parcel_details.plan_no);

										$("#cs_main_cc_no_smd")
											.val(
												result.parcel_details.cc_no);

										$("#ltr_plan_no_pl_smd")
											.val(
												result.parcel_details.ltr_plan_no);
										$(
											"#cs_main_locality_class_smd")
											.val(
												result.parcel_details.locality_class);
										$(
											"#txt_lc_registration_district_number_pl_smd")
											.val(
												result.parcel_details.registration_district_number);

										$(
											"#txt_lc_registration_section_number_pl_smd")
											.val(
												result.parcel_details.registration_section_number);
										$(
											"#txt_lc_registration_block_number_pl_smd")
											.val(
												result.parcel_details.registration_block_number);



										$(
											"#lc_txt_transaction_number_pl_smd")
											.val(
												result.transaction_details.transaction_number);

										$(
											"#lc_txt_certificate_number_pl_smd")
											.val(
												result.transaction_details.certificate_number);

										$(
											"#lc_txt_volume_number_pl_smd")
											.val(
												result.transaction_details.volume_number);
										$(
											"#lc_txt_folio_number_pl_smd")
											.val(
												result.transaction_details.folio_number);
									}

									// -----------------------------

								}
							});

					});

			$('#btn_save_lrd_title_plan_update_details_smd')
				.on(
					'click',
					function (e) {

						console.log('hoe');

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
						var registration_district_number = $(
							"#txt_lc_registration_district_number_pl_smd")
							.val();
						var registration_section_number = $(
							"#txt_lc_registration_section_number_pl_smd")
							.val();
						var registration_block_number = $(
							"#txt_lc_registration_block_number_pl_smd")
							.val();



						var certificate_number = $(
							"#lc_txt_certificate_number_pl_smd")
							.val();
						var volume_number = $(
							"#lc_txt_volume_number_pl_smd")
							.val();
						var folio_number = $(
							"#lc_txt_folio_number_pl_smd")
							.val();


						var transaction_number = $(
							"#lc_txt_transaction_number_pl_smd")
							.val();


						console
							.log('btn_save_certificate_ground_rent');

						$
							.ajax({

								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',
								data: {
									request_type: 'select_update_title_plan_details',
									gid: gid,
									registry_mapref: registry_mapref,
									size_of_land: size_of_land,
									plan_no: plan_no,
									ltr_plan_no: ltr_plan_no,
									registration_district_number: registration_district_number,
									registration_section_number: registration_section_number,
									registration_block_number: registration_block_number,
									transaction_number: transaction_number


								},
								cache: false,
								/*
								 * xhrFields:{ responseType:
								 * 'blob' },
								 */
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									console.log(jobdetails);
									alert(jobdetails);

								}
							});
					});


			$('#elisapplicationdetailsmodal')
				.on(
					'show.bs.modal',
					function (event) {

						var job_number = $(event.relatedTarget)
							.data('job_number');
						var transaction_number = $(
							event.relatedTarget).data(
								'transaction_number');
						var case_number = $(event.relatedTarget)
							.data('case_number');

						console.log(job_number);
						console.log(transaction_number);
						console.log(case_number);

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'select_general_case_details',
									job_number: job_number,
									transaction_number: transaction_number,
									case_number: case_number

								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {

									console.log(jobdetails);

									var result = JSON
										.parse(jobdetails);

									// console.log(result)

									if (result.parcel_details !== null) {
										// console.log("not

										$(
											"#cs_main_case_number_ed")
											.val(
												result.parcel_details.case_number);

										$(
											"#cs_main_glpin_ed")
											.val(
												result.parcel_details.glpin);

										$(
											"#cs_main_licensed_no_ed")
											.val(
												result.parcel_details.licensed_no);

										$(
											"#cs_main_regional_number_ed")
											.val(
												result.parcel_details.regional_number);

										$(
											"#cs_main_locality_ed")
											.val(
												result.parcel_details.locality);
										$(
											"#cs_main_district_ed")
											.val(
												result.parcel_details.district);

										$(
											"#cs_main_region_ed")
											.val(
												result.parcel_details.region);

										$(
											"#cs_main_size_of_land_ed")
											.val(
												result.parcel_details.land_size);

										$(
											"#cs_main_registry_mapref_ed")
											.val(
												result.parcel_details.registry_mapref);

										$(
											"#cs_main_plan_no_ed")
											.val(
												result.parcel_details.plan_no);

										$(
											"#cs_main_cc_no_ed")
											.val(
												result.parcel_details.cc_no);

										$(
											"#cs_main_ltr_plan_no_ed")
											.val(
												result.parcel_details.ltr_plan_no);
										$(
											"#cs_main_locality_class_ed")
											.val(
												result.parcel_details.locality_class);
										$(
											"#cs_main_registration_district_number_ed")
											.val(
												result.parcel_details.registration_district_number);

										$(
											"#cs_main_registration_section_number_ed")
											.val(
												result.parcel_details.registration_section_number);
										$(
											"#cs_main_registration_block_number_ed")
											.val(
												result.parcel_details.registration_block_number);
									}

									if (result.transaction_details !== null) {
										// console.log("not

										$(
											"#cs_main_ar_name_ed")
											.val(
												result.transaction_details.ar_name);
										$(
											"#cs_main_case_number_ed")
											.val(
												result.transaction_details.case_number);
										$(
											"#cs_main_transaction_number_ed")
											.val(
												result.transaction_details.transaction_number);
										$(
											"#cs_main_date_of_document_ed")
											.val(
												result.transaction_details.date_of_document);
										$(
											"#cs_main_nature_of_instrument_ed")
											.val(
												result.transaction_details.nature_of_instrument);
										$(
											"#cs_main_certificate_number_ed")
											.val(
												result.transaction_details.certificate_number);
										$(
											"#cs_main_type_of_interest_ed")
											.val(
												result.transaction_details.type_of_interest);

										$(
											"#cs_main_type_of_use_ed")
											.val(
												result.transaction_details.type_of_use);
										$(
											"#cs_main_volume_number_ed")
											.val(
												result.transaction_details.volume_number);
										$(
											"#cs_main_folio_number_ed")
											.val(
												result.transaction_details.folio_number);

										$(
											"#cs_main_term_ed")
											.val(
												result.transaction_details.term);
										$(
											"#cs_main_commencement_date_ed")
											.val(
												result.transaction_details.commencement_date);

										$(
											"#cs_main_renewal_term_ed")
											.val(
												result.transaction_details.renewal_term);

										$(
											"#cs_main_consideration_fee_ed")
											.val(
												result.transaction_details.consideration_fee);
										$(
											"#cs_main_stamp_duty_payable_ed")
											.val(
												result.transaction_details.stamp_duty_payable);

										$(
											"#cs_main_assessed_value_ed")
											.val(
												result.transaction_details.assessed_value);

										$(
											"#cs_main_parcel_description_ed")
											.val(
												result.transaction_details.parcel_description);
										$(
											"#cs_main_plot_number_ed")
											.val(
												result.transaction_details.plot_number);
										$(
											"#cs_main_publicity_date_ed")
											.val(
												result.transaction_details.publicity_date);
										$(
											"#cs_main_date_of_registration_ed")
											.val(
												result.transaction_details.date_of_registration);

										$(
											"#cs_main_case_status_ed")
											.val(
												result.transaction_details.case_status);
										$(
											"#cs_main_case_file_number_ed")
											.val(
												result.transaction_details.case_file_number);

									}

									/*
									 * if (result.job_detail
									 * !== null) { //
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
											"job_number_placeholder_ed")
											.append(
												result.job_detail.job_number);

										$(
											"#cs_main_business_process_id_ed")
											.val(
												result.job_detail.business_process_id);
										$(
											"#cs_main_business_process_name_ed")
											.val(
												result.job_detail.business_process_name);

										$(
											"#cs_main_business_process_sub_id_ed")
											.val(
												result.job_detail.business_process_sub_id);

										$(
											"#cs_main_business_process_sub_name_ed")
											.val(
												result.job_detail.business_process_sub_name);

										$(
											"#cs_main_job_number_ed")
											.val(
												result.job_detail.job_number);

										/*
										 * console
										 * .log("case is " +
										 * fe_case_number_new);
										 */

										if (result.parties !== null) {
											var table = $('#lc_parties_details_dataTable');
											table
												.find(
													"tbody tr")
												.remove();

											$(
												result.parties)
												.each(
													function () {

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

																+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addeditpartyGeneral" '
																+ 'data-id="'
																+ this.ar_client_id
																+ '" '
																+ 'data-ar_name="'
																+ this.ar_name
																+ '" '
																+ 'data-ar_gender="'
																+ this.ar_gender
																+ '" '
																+ 'data-ar_cell_phone="'
																+ this.ar_cell_phone
																+ '" '
																+ 'data-ar_cell_phone2="'
																+ this.ar_cell_phone2
																+ '" '
																+ 'data-ar_tin_no="'
																+ this.ar_tin_no
																+ '" '
																+ 'data-ar_id_type="'
																+ this.ar_id_type
																+ '" '
																+ 'data-ar_id_number="'
																+ this.ar_id_number
																+ '" '
																+ 'data-ar_location="'
																+ this.ar_location
																+ '" '
																+ 'data-ar_district="'
																+ this.ar_district
																+ '" '
																+ 'data-type_of_party="'
																+ this.type_of_party
																+ '" '
																+ 'data-ar_region="'
																+ this.ar_region
																+ '" '
																+ 'data-ar_person_type="'
																+ this.ar_person_type
																+ '" data-target-id="this.ar_client_id"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p> </td>'

																+ "</tr>");
													});

										}

										if (result.case_query !== null) {
											var table = $('#lc_case_query_dataTable');
											table
												.find(
													"tbody tr")
												.remove();

											$(
												result.case_query)
												.each(
													function () {

														table
															.append("<tr><td>"
																+ this.job_number
																+ "</td><td>"
																+ this.reasons
																+ "</td><td>"
																+ this.remarks
																+ "</td><td>"
																+ this.created_date

																+ "</td>"

																+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newQueryModal" '
																+ 'data-qid="'
																+ this.qid
																+ '" '
																+ 'data-job_number="'
																+ this.job_number
																+ '" '
																+ 'data-reasons="'
																+ this.reasons
																+ '" '
																+ 'data-remarks="'
																+ this.remarks
																+ '" '

																+ 'data-created_date="'
																+ this.created_date
																+ '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Respond</span></button></p> </td>'

																+ "</tr>");
													});

										}

										if (result.job_details !== null) {
											var table = $('#lc_jobs_related_dataTable');
											table
												.find(
													"tbody tr")
												.remove();

											$(
												result.job_details)
												.each(
													function () {

														table
															.append("<tr><td>"
																+ this.job_number
																+ "</td><td>"

																+ this.business_process_sub_name

																+ "</td>"

																+ "</tr>");
													});

										}

										if (result.payment_bill !== null) {
											var table = $('#bill_payment_dataTable');
											table
												.find(
													"tbody tr")
												.remove();

											$(
												result.payment_bill)
												.each(
													function () {

														table
															.append("<tr><td>"
																+ this.bill_number
																+ "</td><td>"
																+ this.bill_amount
																+ "</td><td>"
																+ this.payment_slip_number
																+ "</td><td>"
																+ this.payment_date

																+ "</td>"

																+ '<td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newCertificateModal" '
																+ 'data-bill_number="'
																+ this.bill_number
																+ '" '
																+ 'data-bill_amount="'
																+ this.bill_amount
																+ '" '
																+ 'data-payment_slip_number="'
																+ this.payment_slip_number

																+ '" '
																+ 'data-payment_date="'
																+ this.payment_date
																+ '" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">EGCR</span></button></p> </td>'

																+ "</tr>");
													});

										}

									} else {

										$
											.notify(
												{
													message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
												},
												{
													type: 'danger', z_index: 9999
												});

									}

									// -----------------------------

								}
							});

					});
			$('#newQueryModal').on(
				'show.bs.modal',
				function (event) {
					var button = $(event.relatedTarget) // Button
					// that
					// triggered
					// the modal

					var qid = $(event.relatedTarget).data('qid');
					// console.log(qid);
					var modal = $(this)
					if (qid > 0) {

						$("#qid").val(qid);
						// console.log("test am" + qid);
						/*
						 * $("#query_created_by").val(
						 * button.data('created_by'));
						 * $("#query_created_date").val(
						 * $(event.relatedTarget).data(
						 * 'created_date'));
						 * $("#query_modified_by").val(
						 * button.data('created_by'));
						 * $("#query_modified_date").val(
						 * $(event.relatedTarget).data(
						 * 'created_date'));
						 */
						$("#query_status").val(
							$(event.relatedTarget).data(
								'status'));
						$("#query_reasons").val(
							$(event.relatedTarget).data(
								'reasons'));
						$("#query_remarks").val(
							$(event.relatedTarget).data(
								'remarks'));

					}

				});

			$('#lrd_btn_add_new_public_document')
				.on(
					'click',
					function (e) {

						var case_number = $(
							"#cs_main_case_number").val();

						$("#fileUploadModalPublic").modal({
							backdrop: 'static',
							keyboard: false
						});
						$(
							'#fileUploadModalPublic #file_upload_case_number_pu')
							.val(case_number);
					});

			$("#btn_upload_case_file_pu")
				.click(
					function (event) {
						// $('form').submit(function(event) {
						// stop submit the form, we will post it
						// manually.
						event.preventDefault();

						// Get form
						// var form = $('#fileUploadForm')[0];

						// var form =
						// $('#fileUploadForm')[0].files[0];
						var case_number = $(
							"#file_upload_case_number_pu")
							.val();

						var sampleFile = document
							.getElementById("fileUploadForm_pu").files[0];

						// var fileInput =
						// document.getElementById('upload');
						var filename = document
							.getElementById("fileUploadForm_pu").files[0].name;

						console.log(filename);

						var formdata = new FormData();

						formdata.append("case_number",
							case_number);
						formdata.append("file_name", filename);

						formdata.append("sampleFile",
							sampleFile);

						// Create an FormData object
						// var data = new FormData(form);
						// console.log(data);
						// If you want to add an extra field for
						// the FormData
						// data.append("case_number",
						// case_number);
						// console.log(data);
						// // disabled the submit button
						$("#btn_upload_case_file_pu").prop(
							"disabled", true);
						console.log(formdata);
						$
							.ajax({
								type: "POST",
								enctype: 'multipart/form-data',
								url: "document_upload_new",
								data: formdata,
								processData: false,
								contentType: false,
								cache: false,
								timeout: 600000,
								success: function (data) {

									// $("#result").text(data);
									alert(data);

									$(
										'#fileUploadModalPublic')
										.modal('hide');
									console.log(
										"SUCCESS : ",
										data);
									$(
										"#btn_upload_case_file_pu")
										.prop(
											"disabled",
											false);

								},
								error: function (e) {

									// $("#result").text(e.responseText);
									console.log("ERROR : ",
										e);
									$(
										"#btn_upload_case_file_pu")
										.prop(
											"disabled",
											false);

								}
							});

					});

			// $('#btn_load_scanned_documents_public')
			// .on(
			// 'click',
			// function(e) {
			//
			// var table_docs_mains = $('#lc_public_documents_dataTable');
			// table_docs_mains.find("tbody tr")
			// .remove();
			//
			// var case_number = $(
			// "#cs_main_case_number").val();
			// console.log(case_number);
			// $
			// .ajax({
			// type : "POST",
			// url : "LoadLRDJackets",
			// data : {
			// request_type : 'load_case_scanned_document_public',
			// case_number : case_number
			// },
			// cache : false,
			// beforeSend : function() {
			// // $('#district').html('<img
			// // src="img/loading.gif"
			// // alt="" width="24"
			// // height="24">');
			// },
			// success : function(
			// serviceresponse) {
			//
			// var json_p = JSON
			// .parse(serviceresponse);
			// console.log(json_p)
			//
			// $(json_p)
			// .each(
			// function() {
			// table_docs_mains
			// .append('<tr><td> <a class="link-post" href="'
			// + this.document_file
			// + '">'
			// + this.document_name
			// + '</a></td><td>'
			// + this.document_extention
			// + '</td>'
			// + "</tr>");
			//
			// });
			//
			// }
			// });
			// //
			// });

			/*
			 * $('#lc_public_documents_dataTable') .on( 'click',
			 * '.link-post', function(e) { // console.log(e)
			 * e.preventDefault(); // Get row data //
			 * console.log(e.currentTarget.href); //
			 * console.log(e.target); // console.log(event.target.href);
			 * 
			 * var file_to_open = event.target.href; //
			 * C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf //
			 * var str = "Visit Microsoft!"; var file_path =
			 * file_to_open.replace( "file:///", ""); $ .ajax({ type :
			 * "POST", url : "open_pdffile", // target:'_blank', data : {
			 * request_type : 'request_to_generate_batch_list',
			 * file_path : file_path }, cache : false, xhrFields : {
			 * responseType : 'blob' }, beforeSend : function() { //
			 * $('#district').html('<img // src="img/loading.gif" //
			 * alt="" width="24" // height="24">'); }, success :
			 * function( jobdetails) { console.log(jobdetails); // const
			 * arrayBuffer = // _base64ToArrayBuffer(jobdetails); $(
			 * '#elisDocumentPreview') .modal( { backdrop : 'static',
			 * });
			 * 
			 * var blob = new Blob( [ jobdetails ], { type :
			 * "application/pdf" }); var objectUrl = URL
			 * .createObjectURL(blob); // window.open(objectUrl); $(
			 * '#elisdovumentpreviewblobfile') .attr('src', objectUrl); $(
			 * '#fedocumentPreviewblobfile') .attr('src', objectUrl); //
			 * $('#NotoncaseafterPaymentModalonCase').modal('hide'); }
			 * });
			 * 
			 * });
			 */
			$('#btn_load_scanned_documents_ed')
				.on(
					'click',
					function (e) {

						var table_docs = $('#lc_scanned_documents_dataTable');
						table_docs.find("tbody tr").remove();

						var table_docs_mains = $('#lc_main_scanned_documents_dataTable_ed');
						table_docs_mains.find("tbody tr")
							.remove();

						var case_number = $(
							"#cs_main_case_number_ed")
							.val();
						console.log(case_number);
						$
							.ajax({
								type: "POST",
								url: "LoadLRDJackets",
								data: {
									request_type: 'load_case_scanned_document_new',
									case_number: case_number
								},
								cache: false,
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									serviceresponse) {


									try {
										var json_p = JSON
											.parse(serviceresponse);
										console.log(json_p)

										$(json_p)
											.each(
												function () {

													table_docs
														.append("<tr><td>"
															+ this.document_name
															+ "</td><td>"
															+ this.document_extention
															+ "</td>"
															+ '<td> <a class="link-post" href="'
															+ this.document_file
															+ '">'
															+ this.document_name
															+ '</a></td>'

															+ "</tr>");

													table_docs_mains
														.append('<tr><td> <a class="link-post" href="'
															+ this.document_file
															+ '">'
															+ this.document_name
															+ '</a></td><td>'
															+ this.document_extention
															+ '</td>'

															+ "</tr>");

												});

									} catch (e) {
										console.log(e)
									}

								}
							});
						//	
					});

			var lc_main_scanned_documents_dataTable = $(
				'#lc_main_scanned_documents_dataTable_ed')
				.DataTable();

			$('#lc_main_scanned_documents_dataTable_ed')
				.on(
					'click',
					'.link-post',
					function (e) {
						// console.log(e)
						e.preventDefault();

						// Get row data

						// console.log(e.currentTarget.href);
						// console.log(e.target);
						// console.log(event.target.href);

						var file_to_open = event.target.href;
						// C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf

						// var str = "Visit Microsoft!";
						var file_path = file_to_open.replace(
							"file:///", "");

						$
							.ajax({
								type: "POST",
								url: "open_pdffile",
								// target:'_blank',
								data: {
									request_type: 'request_to_generate_batch_list',
									file_path: file_path
								},
								cache: false,
								xhrFields: {
									responseType: 'blob'
								},
								beforeSend: function () {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success: function (
									jobdetails) {
									//console.log(jobdetails);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);

									$(
										'#elisDocumentPreview')
										.modal(
											{
												backdrop: 'static',
											});

									var blob = new Blob(
										[jobdetails],
										{
											type: "application/pdf"
										});
									var objectUrl = URL
										.createObjectURL(blob);
									// window.open(objectUrl);

									$(
										'#elisdovumentpreviewblobfile')
										.attr('src',
											objectUrl);

									$(
										'#fedocumentPreviewblobfile')
										.attr('src',
											objectUrl);

									// $('#NotoncaseafterPaymentModalonCase').modal('hide');

								}
							});

					});



			$('#btn_job_number_for_change_of_job_service')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_job_number_for_adding_case_and_status")
							.val().toUpperCase();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)) {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						$('#btnSaveChangeOfService').hide();
						$('#chs_job_number').val("");
						$('#chs_ar_name').val("");
						$('#chs_business_process_name').val("");
						$('#chs_business_process_sub_name').val("");
						$('#chs_comment').val("");

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'load_application_details_by_job_number_all',
									job_number: client_phone_search
								},
								cache: false,

								success: function (
									jobdetails) {

									//console.log(jobdetails);

									var table = $('#tbl_job_detail_dataTable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									if (json_p.data === null) {
										// $
										// 		.notify(
										// 				{
										// 					message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Application not found </span>',
										// 				},
										// 				{
										// 					type : 'danger' , z_index: 9999 
										// 				});

										swal.fire({
											title: 'Ops!',
											text: 'Application not found. Please try again.',
											icon: 'warning',
											confirmButtonText: 'OK'
										});


										return false;
									}
									$(json_p.data)
										.each(
											function () {

												table
													.append("<tr><td>"
														+ this.job_number
														+ "</td><td>"
														+ this.case_number
														+ "</td><td>"
														+ this.ar_name
														// + "</td><td>"
														// + this.current_application_status
														+ "</td>"

														/*
														 * + '<td><p data-placement="top" data-toggle="tooltip" title="Details of Case"><button
														 * class="btn
														 * btn-success
														 * btn-circle
														 * btn-sm"
														 * data-title="Delete"
														 * data-toggle="modal"
														 * data-target="#NotoncaseafterPaymentModalonCase" ' +
														 * 'data-ref_number="' +
														 * this.job_number + '" ' +
														 * 'data-ar_name="' +
														 * this.case_number + '" ' +
														 * 'data-ar_name="' +
														 * this.ar_name + '" ' +
														 * 'data-bill_amount="' +
														 * this.current_application_status + '"
														 * id="deletedew"><span
														 * class="fa
														 * fa-info-circle"></span></button></p>
														 * </td>'
														 */

														// Add
														// Job
														+ '<td><p data-placement="top" data-toggle="tooltip" title="Change Details">' +
														'<button class="btn btn-warning"  data-backdrop="static" '
														+ 'data-ref_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-land_size="'
														+ this.land_size
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-created_for_id="'
														+ this.created_for_id
														+ '" '
														+ 'data-licensed_no="'
														+ this.licensed_no
														+ '" '
														+ 'data-locality="'
														+ this.locality
														+ '" '
														+ 'data-business_process_id="'
														+ this.business_process_id
														+ '" '
														+ 'data-business_process_name="'
														+ this.business_process_name
														+ '" '
														+ 'data-business_process_sub_id="'
														+ this.business_process_sub_id
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="chs_load_data"><span class="fa fa-download"></span> Load Data</button></p> </td>'


														+ "</tr>");


												// $('#chng_load_details').on('click',function(e){
												// 	// console.log("jjj " +
												// 	// $(this).data('region'))
												// 	// e.preventDefault();
												// 	$('#ch_ar_name').val($(this).data('ar_name'));
												// 	$('#new_bill_application_region').val($(this).data('region').toUpperCase());
												// 	// $('#new_bill_application_region').trigger('change');
												// 	$('#new_bill_application_district').append($('<option>', {
												// 		value: $(this).data('district'),
												// 		text: $(this).data('district')
												// 	}))

												// 	$('#new_bill_application_district').val($(this).data('district'));
												// 	$('#new_bill_application_locality').val($(this).data('locality').toUpperCase());
												// 	$('#new_bill_application_transaction').val($(this).data('transaction_number'));


												// 	$('#btnSaveChangeOfNames').show();
												// });

												$('#chs_load_data').on('click', function (e) {

													$('#chs_job_number').val($(this).data('ref_number'));
													$('#chs_ar_name').val($(this).data('ar_name'));
													$('#chs_business_process_name').val($(this).data('business_process_name'));
													//$('#chs_job_number').val($(event.relatedTarget).data('ref_number'));

													var main_service_id = $(this).data('business_process_id');


													$
														.ajax({
															type: "POST",
															url: "Case_Management_Serv",
															data: {
																request_type: 'get_lc_sub_service_all',
															},
															cache: false,
															beforeSend: function () {
																// $('#district').html('<img
																// src="img/loading.gif"
																// alt="" width="24"
																// height="24">');
															},
															success: function (
																jobdetails) {

																//console.log(jobdetails);
																var json_p = JSON
																	.parse(jobdetails);
																var options = $("#chs_business_process_sub_name");

																// var options =
																// $("#selector");
																options.empty();
																options
																	.append(new Option(
																		"-- Select --",
																		0));

																$(json_p)
																	.each(
																		function () {

																			//console.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				// if
																				// (this.business_process_on_case
																				// ==
																				// 'No')
																				// {
																				$(
																					'#chs_business_process_sub_name')
																					.append(
																						'<option value="'
																						+ this.business_process_sub_id
																						+ '-'
																						+ this.business_process_sub_name
																						+ '">'
																						+ this.business_process_sub_name
																						+ '</option>');

																				// }

																			}

																		});
																// business_process_id
															}
														});

													$('#btnSaveChangeOfService').show();
												});

											});

								}
							});

					});


			// $('#btnSaveChangeOfService').on('click', function(e) {

			// })

			$('#frmChangeofService').on('submit', function (e) {

				e.preventDefault();

				var chs_job_number = $('#chs_job_number').val();
				var chs_comment = $('#chs_comment').val();
				var sub_service = $('#chs_business_process_sub_name').val();

				if (sub_service == 0) {

					$
						.notify({
							message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please bussiness service </span>',
						}, {
							type: 'danger', z_index: 9999
						});
				} else {

					const
						sub_service_name_id = sub_service
							.split('-');

					var chs_sub_service_id = sub_service_name_id[0];
					var chs_sub_service_name = sub_service_name_id[1];

					$.ajax({
						type: "POST",
						url: "Case_Management_Serv",
						data: {
							request_type: 'update_application_sub_service',
							job_number: chs_job_number,
							sub_service_id: chs_sub_service_id,
							sub_service_name: chs_sub_service_name,
							officer_comment: chs_comment

						},


						cache: false,
						beforeSend: function () { },
						success: function (
							jobdetails) {
							// console.log(jobdetails);
							// alert(jobdetails);
							$
								.notify({
									message: '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Data Changed Successfuly </span>',
								}, {
									type: 'success', z_index: 9999
								});

						}
					});

				}

			});



			$('#btn_search_job_number_for_acknowledgement_slip')
				.on(
					'click',
					function (e) {

						var client_phone_search = $(
							"#txt_job_number_for_adding_case_and_status")
							.val().toUpperCase();

						if (!(client_phone_search.length >= 6 || client_phone_search === undefined)) {
							$
								.notify(
									{
										message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter valid search Value </span>',
									}, {
									type: 'danger', z_index: 9999
								});
							return;
						}

						$('#btnSaveChangeOfService').hide();
						$('#chs_job_number').val("");
						$('#chs_ar_name').val("");
						$('#chs_business_process_name').val("");
						$('#chs_business_process_sub_name').val("");

						$
							.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								// target:'_blank',

								data: {
									request_type: 'load_application_details_by_job_number_all',
									job_number: client_phone_search
								},
								cache: false,

								success: function (
									jobdetails) {

									//console.log(jobdetails);

									var table = $('#tbl_job_detail_dataTable');
									table.find("tbody tr")
										.remove();

									console.log(jobdetails);
									var json_p = JSON
										.parse(jobdetails);
									if (json_p.data === null) {
										// $
										// 		.notify(
										// 				{
										// 					message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Application not found </span>',
										// 				},
										// 				{
										// 					type : 'danger' , z_index: 9999 
										// 				});

										swal.fire({
											title: 'Ops!',
											text: 'Application not found. Please try again.',
											icon: 'warning',
											confirmButtonText: 'OK'
										})

										return false;
									}
									$(json_p.data)
										.each(
											function () {

												table
													.append("<tr><td>"
														+ this.job_number
														+ "</td><td>"
														+ this.case_number
														+ "</td><td>"
														+ this.ar_name
														// + "</td><td>"
														// + this.current_application_status
														+ "</td>"

														/*
														 * + '<td><p data-placement="top" data-toggle="tooltip" title="Details of Case"><button
														 * class="btn
														 * btn-success
														 * btn-circle
														 * btn-sm"
														 * data-title="Delete"
														 * data-toggle="modal"
														 * data-target="#NotoncaseafterPaymentModalonCase" ' +
														 * 'data-ref_number="' +
														 * this.job_number + '" ' +
														 * 'data-ar_name="' +
														 * this.case_number + '" ' +
														 * 'data-ar_name="' +
														 * this.ar_name + '" ' +
														 * 'data-bill_amount="' +
														 * this.current_application_status + '"
														 * id="deletedew"><span
														 * class="fa
														 * fa-info-circle"></span></button></p>
														 * </td>'
														 */

														// Add
														// Job
														+ '<td><p data-placement="top" data-toggle="tooltip" title="Change Details">' +
														'<button class="btn btn-warning"  data-backdrop="static" '
														+ 'data-ref_number="'
														+ this.job_number
														+ '" '
														+ 'data-case_number="'
														+ this.transaction_number
														+ '" '
														+ 'data-land_size="'
														+ this.land_size
														+ '" '
														+ 'data-ar_name="'
														+ this.ar_name
														+ '" '
														+ 'data-created_for_id="'
														+ this.created_for_id
														+ '" '
														+ 'data-licensed_no="'
														+ this.licensed_no
														+ '" '
														+ 'data-locality="'
														+ this.locality
														+ '" '
														+ 'data-business_process_id="'
														+ this.business_process_id
														+ '" '
														+ 'data-business_process_name="'
														+ this.business_process_name
														+ '" '
														+ 'data-business_process_sub_id="'
														+ this.business_process_sub_id
														+ '" '
														+ 'data-business_process_sub_name="'
														+ this.business_process_sub_name

														+ '" id="btn_regenerate_acknowledgement_slip"><span class="fa fa-download"></span> Generate</button></p> </td>'
														+ "</tr>");


												$('#btn_regenerate_acknowledgement_slip').on('click', function (e) {

													var job_number = $(this).data('ref_number');

													//console.log(job_number)

													$
														.ajax({
															type: "POST",
															url: "Case_Management_Serv",
															data: {
																request_type: 'online_select_regenerate_process_acknowledgment_slip',
																job_number: job_number
															},
															cache: false,
															// responseType:
															// 'arraybuffer',
															// dataType:'blob',
															xhrFields: {
																responseType: 'blob'
															},
															beforeSend: function () {
																// $('#district').html('<img
																// src="img/loading.gif"
																// alt=""
																// width="24"
																// height="24">');
															},
															success: function (
																jobdetails) {
																console
																	.log(jobdetails);
																// const
																// arrayBuffer
																// =
																// _base64ToArrayBuffer(jobdetails);

																var blob = new Blob(
																	[jobdetails],
																	{
																		type: "application/pdf"
																	});
																var objectUrl = URL
																	.createObjectURL(blob);
																window
																	.open(objectUrl);

																console
																	.log(jobdetails);

															}
														});
												});
											});

								}
							});

					});



			$('#frmSearchMotherfile')
				.on(
					'submit',
					function (e) {

						// validation code here
						e.preventDefault();
						//console.log('how are your search');

						var enq_search_type = "";
						var selected_rbtn = $("input[name='rbtn_search_type']:checked");
						if (selected_rbtn.length > 0) {
							enq_search_type = selected_rbtn.val();
							//console.log("selected " + enq_search_type);
						}


						var enq_search_value = $("#enq_search_value").val();
						//console.log('Search Value: ' + enq_search_value);

						// if (enq_search_value.length < 8) {
						// 	$.notify({
						// 		message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
						// 	}, { type : 'danger' , z_index: 9999  });

						// } else 
						if (enq_search_type.length <= 0) {
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
							}, { type: 'danger', z_index: 9999 });

						} else {

							$("#enq-search-results-section").hide();

							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'online_select_application_details_by_job_number_or_certificate_number',
									job_number: enq_search_value,
									search_type: enq_search_type
								},
								cache: false,

								success: function (
									jobdetails) {

									//console.log(jobdetails);
									$(
										"#enq-search-results-section")
										.show();

									var table = $('#enq-search-results-table');
									table.find(
										"tbody tr")
										.remove();
									if (jobdetails.includes('Error Loading Data')) {
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {


										console.log(jobdetails);
										var json_p = JSON
											.parse(jobdetails);

										$(json_p)
											.each(
												function () {
													// console.log(this.job_number);
													table
														.append("<tr><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.certificate_number
															+ "</td><td>"
															+ this.job_number
															+ "</td><td>"
															+ this.locality
															+ "</td>"

															// + '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
															// + ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
															// + ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'

															// + '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
															// + ' data-target-id="'
															// + this.job_number
															// + '"> '
															// + '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Cabinet</span> </button><div class="dropdown-divider"></div>'


															// + '</div></div></td>'
															+ '<td>'
															+ '<button type="button" id="btn-view-mother-Child-details"  data-job_number="'
															+ this.job_number
															+ '" data-case_number="'
															+ this.case_number
															+ '" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
															+ '</button>'
															+ '</td>'
															+ '</tr>');

												});
									}

								}
							});
						}
					});


			$('#linkSearchMotherfile')
				.on(
					'submit',
					function (e) {

						// validation code here
						e.preventDefault();
						//console.log('how are your search');

						var enq_search_type = "";
						var selected_rbtn = $("input[name='link_search_type']:checked");
						if (selected_rbtn.length > 0) {
							enq_search_type = selected_rbtn.val();
							//console.log("selected " + enq_search_type);
						}


						var enq_search_value = $("#link_search_value").val();
						//console.log('Search Value: ' + enq_search_value);

						// if (enq_search_value.length < 8) {
						// 	$.notify({
						// 		message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
						// 	}, { type : 'danger' , z_index: 9999  });

						// } else 
						if (enq_search_type.length <= 0) {
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
							}, { type: 'danger', z_index: 9999 });

						} else {

							$("#link-search-results-section").hide();

							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'online_select_application_details_by_job_number_or_certificate_number',
									job_number: enq_search_value,
									search_type: enq_search_type
								},
								cache: false,

								success: function (jobdetails) {

									//console.log(jobdetails);
									$(
										"#link-search-results-section")
										.show();

									var table = $('#link-search-results-table');
									table.find(
										"tbody tr")
										.remove();
									if (jobdetails.includes('Error Loading Data') || !jobdetails) {
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {


										// console.log(jobdetails);
										var json_p = JSON
											.parse(jobdetails);

										$(json_p)
											.each(
												function () {
													// console.log(this.job_number);
													table
														.append("<tr><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.certificate_number
															+ "</td><td>"
															+ this.job_number
															+ "</td><td>"
															+ this.locality
															+ "</td>"

															// + '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
															// + ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
															// + ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'

															// + '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
															// + ' data-target-id="'
															// + this.job_number
															// + '"> '
															// + '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Cabinet</span> </button><div class="dropdown-divider"></div>'


															// + '</div></div></td>'
															+ '<td>'
															+ '<button type="button" id="btn-view-mother-Child-details"  data-job_number="'
															+ this.job_number
															+ '" data-case_number="'
															+ this.case_number
															+ '" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
															+ '</button>'
															+ '</td>'
															+ '</tr>');

												});
									}

								}
							});
						}
					});


			$('#linkSearchMotherfile_')
				.on(
					'submit',
					function (e) {

						// validation code here
						e.preventDefault();
						//console.log('how are your search');

						var enq_search_type = "";
						var selected_rbtn = $("input[name='link_search_type_']:checked");
						if (selected_rbtn.length > 0) {
							enq_search_type = selected_rbtn.val();
							//console.log("selected " + enq_search_type);
						}


						var enq_search_value = $("#link_search_value_").val();
						//console.log('Search Value: ' + enq_search_value);

						// if (enq_search_value.length < 8) {
						// 	$.notify({
						// 		message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
						// 	}, { type : 'danger' , z_index: 9999  });

						// } else 
						if (enq_search_type.length <= 0) {
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
							}, { type: 'danger', z_index: 9999 });

						} else {

							$("#link-search-results-section_").hide();

							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'online_select_application_details_by_job_number_or_certificate_number',
									job_number: enq_search_value,
									search_type: enq_search_type
								},
								cache: false,

								success: function (jobdetails) {

									console.log(jobdetails);



									if (jobdetails.includes('Error Loading Data') || !jobdetails || jobdetails.includes('[]')) {
										$("#link-search-results-section_").hide();
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {

										var table = $('#link-search-results-table_');
										table.find(
											"tbody tr")
											.remove();
										// console.log(jobdetails);
										var json_p = JSON
											.parse(jobdetails);

										$(
											"#link-search-results-section_")
											.show();

										$(json_p)
											.each(
												function () {
													// console.log(this.job_number);
													table
														.append("<tr><td>"
															+ this.ar_name
															+ "</td><td>"
															+ this.certificate_number
															+ "</td><td>"
															+ this.job_number
															+ "</td><td>"
															+ this.locality
															+ "</td>"

															// + '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
															// + ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
															// + ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'

															// + '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
															// + ' data-target-id="'
															// + this.job_number
															// + '"> '
															// + '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Cabinet</span> </button><div class="dropdown-divider"></div>'


															// + '</div></div></td>'
															+ '<td>'
															+ '<button type="button" id="btn-view-mother-Child-details"  data-job_number="'
															+ this.job_number
															+ '" data-case_number="'
															+ this.case_number
															+ '" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >'
															+ '<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
															+ '</button>'
															+ '</td>'
															+ '</tr>');

												});
									}

								}
							});
						}
					});



			$('#linkSearchMotherfile__')
				.on(
					'submit',
					function (e) {

						// validation code here
						e.preventDefault();
						//console.log('how are your search');

						var enq_search_type = "";
						var selected_rbtn = $("input[name='link_search_type__']:checked");
						if (selected_rbtn.length > 0) {
							enq_search_type = selected_rbtn.val();
							//console.log("selected " + enq_search_type);
						}


						var enq_search_value = $("#link_search_value__").val();
						//console.log('Search Value: ' + enq_search_value);

						// if (enq_search_value.length < 8) {
						// 	$.notify({
						// 		message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
						// 	}, { type : 'danger' , z_index: 9999  });

						// } else 
						if (enq_search_type.length <= 0) {
							$.notify({
								message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
							}, { type: 'danger', z_index: 9999 });

						} else {

							$("#link-search-results-section__").hide();

							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									request_type: 'online_select_application_details_by_job_number_or_certificate_number',
									job_number: enq_search_value,
									search_type: enq_search_type
								},
								cache: false,

								success: function (jobdetails) {

									// console.log(jobdetails);



									if (jobdetails.includes('Error Loading Data') || !jobdetails || jobdetails.includes('[]')) {
										$("#link-search-results-section__").hide();
										$.notify({ message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>', }, { type: 'danger', z_index: 9999 });
										return false;
									} else {

										var json_p = JSON
											.parse(jobdetails);

										$(
											"#link-search-results-section__")
											.show();

										console.log(json_p)

										$("#chk_interest_number").val(json_p[0].interest_number);
										$("#chk_sub_interest_number").val(json_p[0].sub_interest_number);
									}

								}
							});
						}
					});



			$('#incoming_advanced_search_fr').on('shown.bs.modal', function (e) {

				//console.log('kjnbvsfkje')

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'load_sub_process_application_type_for_adv_filter',
						inbox_type: '10_false'
					},

					success: function (jobdetails) {
						//console.log(jobdetails)

						if (!jobdetails) {
							return;
						}

						var json_p = JSON.parse(jobdetails);

						var select = $("#adv_application_typefr");
						select.empty();
						select
							.append(new Option(
								"-- Select --",
								0));

						$(json_p).each(function () {

							select.append('<option value="'
								+ this.business_process_sub_id
								+ '">'
								+ this.business_process_sub_name
								+ '</option>');
						});
					}

				})


			})

			$('.exclude_job_search').addClass('d-none');

			$('input[name="adv_search_type"]').on('click', function () {


				var adv_search_type = $('input[name="adv_search_type"]:checked').val();

				if (adv_search_type == 'f_job_number') {
					$('.exclude_job_search').addClass('d-none');
					$('.include_job_search').removeClass('d-none');
				} else if (adv_search_type == 'f_app_type') {
					$('.exclude_app_type').addClass('d-none');
					$('.include_app_type').removeClass('d-none');
				} else if (adv_search_type == 'f_date_range') {
					$('.exclude_date_range').addClass('d-none');
					$('.include_date_range').removeClass('d-none');
				} else if (adv_search_type == 'f_limit') {
					$('.exclude_limit').addClass('d-none');
					$('.include_limit').removeClass('d-none');
				}
			});



			$('#btn_load_adv_filterfr').on('click', function (e) {

				var adv_search_type = $('input[name="adv_search_type"]:checked').val();
				var inbox_type = $('#adv_inbox_typefr').val();
				var adv_job_number = $('#adv_job_numberfr').val()
				var adv_application_type = $('#adv_application_typefr').val()
				var adv_limit = $('#adv_limitfr').val()
				var adv_from_date = $('#adv_from_datefr').val()
				var adv_to_date = $('#adv_to_datefr').val()
				var enq_search_type = "job_numberfr";
				//var adv_job_purpose = $('#adv_job_purposefr').val()
				var adv_sorting = $('#adv_sortingfr').val()

				if (adv_search_type == 'f_job_number') {
					if (!adv_job_number) {
						$.notify({
							message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter a job number</span>',
						}, { type: 'danger', z_index: 9999 });

						alert('Please enter a job number');

						return;
					}

				} else if (adv_search_type == 'f_app_type') {
					//console.log(adv_application_type,adv_limit,adv_sorting )
					if (adv_application_type == 0 || !adv_limit || !adv_sorting || adv_limit > 1000) {
						$.notify({
							message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required with the exception of job purpose</span>',
						}, { type: 'danger', z_index: 9999 });

						alert('Please all the field are required with the exception of job purpose');

						return;
					}
				} else if (adv_search_type == 'f_date_range') {
					if (!adv_from_date || !adv_limit || !adv_to_date || adv_limit > 1000) {
						$.notify({
							message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
						}, { type: 'danger', z_index: 9999 });

						alert('Please all the field are required');

						return;
					}

				} else if (adv_search_type == 'f_limit') {
					if (!adv_limit || !adv_sorting || adv_limit > 1000) {
						$.notify({
							message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
						}, { type: 'danger', z_index: 9999 });

						alert('Please all the field are required');

						return;
					}
				}

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						request_type: 'load_incoming_app_for_unit_using_adv_filter',
						//adv_filter : adv_filter,
						adv_job_number: adv_job_number,
						adv_application_type: adv_application_type,
						adv_from_date: adv_from_date == '' ? '12-12-2000' : adv_from_date,
						adv_to_date: adv_to_date == '' ? '12-12-2000' : adv_to_date,
						adv_limit: adv_limit == '' ? 0 : adv_limit,
						enq_search_type: enq_search_type,
						inbox_type: '10_false',
						//adv_job_purpose : adv_job_purpose,
						adv_sorting: adv_sorting,
						adv_search_type: adv_search_type
					},

					success: function (
						jobdetails) {

						console.log(jobdetails)

						var table = $('#tbl_search_for_job_details_datatable');
						table.find("tbody tr")
							.remove();

						console.log(jobdetails);
						if (jobdetails.includes('Error Loading Data')) {
							return false;
						} else {
							var json_p = JSON.parse(jobdetails);
							$(json_p.data)
								.each(
									function () {
										table
											.append("<tr><td>"
												+ this.job_number

												+ "</td><td>"
												+ this.ar_name
												+ "</td><td>"
												+ this.business_process_sub_name
												+ "</td><td>"

												+ this.current_application_status
												+ "</td>"

												+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-plus btn-sm" data-toggle="modal" data-target="#askForPurposeOfBatching" data-backdrop="static" data-keyboard="false" '
												+ 'data-job_number="'
												+ this.job_number

												+ '" '
												+ 'data-ar_name="'
												+ this.ar_name
												+ '" '
												+ 'data-business_process_sub_name="'
												+ this.business_process_sub_name
												+ '" '

												+ 'data-business_process_sub_name="'
												+ this.business_process_sub_name

												+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'

												+ '<td><p data-placement="top" data-toggle="tooltip" title="Add Job to Client Attention Required"><button class="btn btn-secondary btn-icon-split float-left" data-toggle="modal" data-target="#clientAttentionRequiredModal" data-backdrop="static" data-keyboard="false" '
												+ 'data-transaction_number="'
												+ this.transaction_number

												+ '" '
												+ 'data-job_number="'
												+ this.job_number
												+ '" '
												+ 'data-case_number="'
												+ this.case_number
												+ '" '
												+ 'data-business_process_sub_name="'
												+ this.business_process_sub_name
												+ '" '

												+ 'data-business_process_sub_name="'
												+ this.business_process_sub_name

												+ '" id="deletedew"><span class="fas fa-check"></span></button></p> </td>'


												+ "</tr>");

									});
						}
					}

				})
			})

		});
