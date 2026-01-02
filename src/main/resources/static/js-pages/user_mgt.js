$(document).ready(function() {
	//console.log("testing User js");
	
	
	/*$('#ur_region').change(function() {
		//alert($(this).val());
		var selected_region_coed = $(this).val();
		var selected_region_name = $("#ur_region option:selected").html();
		//alert(selected_region_name)
		//$("#ur_department").val("");
		$("#btn_process_batchlist").hide();
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'get_lc_list_of_units',
			},
			cache : false,
			success : function(jobdetails) {

				//console.log(jobdetails);
				var json_p = JSON.parse(jobdetails);
				var datalist = $("#listofunitsbatching");
				datalist.empty();
						
				$(json_p.data).each(function() {
					//console.log("Outer " + this.unit_division + " - " + this.unit_name);
					if (selected_region == this.unit_division) {
						//console.log("Inner " + this.unit_division + " - " + this.unit_name);
						datalist.append('<option data-name="' + this.unit_name + '" data-id="' + this.unit_id + '" value="' + this.unit_name + '" ></option>');
					}
				});
			}
		});

		
	});*/
	
	
	$('#ur_district').change(function() {
		
		$('#ur_division').val("")	
		$('#ur_department').val("")
		datalist.empty();
	});
		
		
		
	$('#ur_division').change(function() {
		//alert($(this).val());
		var selected_division = $(this).val();
		var office_id = $("#ur_district").val();
		
		$("#ur_department").val("");
		/*$("#btn_process_batchlist").hide();*/
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'get_lc_list_of_units',
				office_id: office_id
			},
			cache : false,
			success : function(jobdetails) {

			//	console.log(jobdetails);
				var json_p = JSON.parse(jobdetails);
				var datalist = $("#listofunits");
				datalist.empty();
						
				$(json_p.data).each(function() {
					//console.log("Outer " + this.unit_division + " - " + this.unit_name);
					if (this.unit_division.includes(selected_division)) {
						//console.log("Inner " + this.unit_division + " - " + this.unit_name);
						datalist.append('<option data-name="' + this.unit_name + '" data-id="' + this.unit_id + '" value="' + this.unit_name + '" ></option>');
					}
				});
			}
		});

		
	});
	
	
	$('#addupdateuserdatails').on('show.bs.modal', function(event) {
    const button = $(event.relatedTarget);
    const selected_division = button.data('division');
    
    // Clear form fields
    $("#ur_department").val("");
    $("#listofunits").empty();
    
    // Set basic user information
    $("#ur_userid").val(button.data('userid'));
    $("#ur_username").val(button.data('username'));
    $("#ur_fullname").val(button.data('fullname'));
    $("#ur_userprofile").val(button.data('userprofile'));
    $("#ur_isdisabled").val(button.data('isdisabled') ? "Yes" : "No");
    $("#ur_view_all_offices").val(button.data("view_all_offices"));
    $("#usr_access_level").val(button.data("usr_access_level"));
    
    // Set personal information
    $("#ur_staffnumber").val(button.data('staffnumber'));
    $("#ur_title").val(button.data('title'));
    $("#ur_address").val(button.data('address'));
    $("#ur_phone").val(button.data('phone'));
    $("#ur_mobile").val(button.data('mobile'));
    $("#ur_emailaddress").val(button.data('emailaddress'));
    
    // Set system information
    $("#ur_id").val(button.data('id'));
    $("#ur_passwordchanged").val(button.data('passwordchanged'));
    $("#ur_canpasswordexpire").val(button.data('canpasswordexpire') ? "Yes" : "No");
    $("#ur_passwordvaliditydays").val(button.data('passwordvaliditydays'));
    $("#ur_passwordexpirydate").val(button.data('passwordexpirydate'));
    $("#ur_user_level").val(parseInt(button.data('user_level')));

	console.log(button.data('usr_access_level'))
    // Load departments/units

	

    // Load regions
	setTimeout(function() {
    $.ajax({
        type: "POST",
        url: "app_modal_fills_serv",
        data: {
            request_type: 'get_region_list'
        },
        cache: false,
        success: function(response) {
            const json_p = JSON.parse(response);
            const options = $("#ur_region");
            options.empty();
            options.append(new Option("-- Select --", ""));
            
            $(json_p).each(function() {
                options.append(new Option(this.region_name, this.region_name));
            });
            
            $("#ur_region").val(button.data('region'));
        }
    });
}, 500);
    // Load districts

	setTimeout(function() {
    $.ajax({
        type: "POST",
        url: "app_modal_fills_serv",
        data: {
            request_type: 'get_all_office_region'
        },
        cache: false,
        success: function(response) {
            const json_p = JSON.parse(response);
            const options = $("#ur_district");
            options.empty();
            options.append(new Option("-- Select --", ""));
            
            $(json_p).each(function() {
                options.append(new Option(this.ord_region_name, this.ord_region_code));
            });
            
            $("#ur_district").val(parseInt(button.data('district_code')));
        }
    });
}, 500);
    // Load designations

	setTimeout(function() {
    $.ajax({
        type: "POST",
        url: "app_modal_fills_serv",
        data: {
            request_type: 'get_list_of_designation'
        },
        cache: false,
        success: function(response) {
            const json_p = JSON.parse(response);
            const options = $("#ur_designation");
            options.empty();
            options.append(new Option("-- Select --", ""));
            
            $(json_p).each(function() {
                options.append(new Option(this.designation_name, this.designation_name));
            });
            
            $("#ur_designation").val(button.data('designation'));
        }
    });
}, 500);
    // Load divisions

	setTimeout(function() {
    $.ajax({
        type: "POST",
        url: "app_modal_fills_serv",
        data: {
            request_type: 'get_divisions_get_list'
        },
        cache: false,
        success: function(response) {
            const json_p = JSON.parse(response);
            const options = $("#ur_division");
            options.empty();
            options.append(new Option("-- Select --", ""));
            
            $(json_p).each(function() {
                options.append(new Option(this.division_name, this.division_name));
            });
            
            $("#ur_division").val(button.data('division'));
        }
    });
	}, 500);

	setTimeout(function() {
	$.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'get_lc_list_of_units',
            office_id: button.data('regional_code')
        },
        cache: false,
        success: function(response) {
            const json_p = JSON.parse(response);
            const datalist = $("#listofunits");
            datalist.empty();
            
            $(json_p.data).each(function() {
                if (this.unit_division.includes(selected_division)) {
                    datalist.append(`<option 
                        data-name="${this.unit_name}" 
                        data-id="${this.unit_id}" 
                        value="${this.unit_name}"
                    ></option>`);
                }
            });
            
            // Set department value after options are loaded
            const departmentValue = button.data('department');
            $("#ur_department").val(departmentValue);

            // Validate if the value exists in datalist
            const exists = $('#listofunits option').filter(function() {
                return $(this).val() === departmentValue;
            }).length > 0;

            if (!exists && departmentValue) {
                // If value doesn't exist in datalist but we have a value,
                // add it as an option
                datalist.append(`<option 
                    data-name="${departmentValue}" 
                    data-id="${button.data('department_id')}" 
                    value="${departmentValue}"
                ></option>`);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading departments:", error);
        }
    });
	}, 500);
});

$(document).on('click', '#togglePassword', function() {
	const passwordInput = document.getElementById('ur_web_pass');
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
})

// Add validation for department input
$("#ur_department").on('input', function() {
    const value = $(this).val();
    const exists = $('#listofunits option').filter(function() {
        return $(this).val() === value;
    }).length > 0;

    if (!exists) {
        $(this).addClass('is-invalid');
    } else {
        $(this).removeClass('is-invalid');
    }
});

	$('#assignReassignUserProfile').on('show.bs.modal',function(event) {
			var button = $(event.relatedTarget) // Button
			// that
			// triggered
			// the
			// modal

			$("#up_userid").val(
					$(event.relatedTarget).data(
							'userid'));
			$("#up_fullname").val(
					$(event.relatedTarget).data(
							'fullname'));

				$("#up_username").val(
					$(event.relatedTarget).data(
							'username'));

			// var dt =
			// $('#tbl_user_profile_list_dataTable').DataTable();
			var up_userid = $(event.relatedTarget)
					.data('userid');

			// var table_cl =
			// $('#tbl_user_profile_list_dataTable');
			// table_cl.find("tbody tr").remove();
			// console.log(up_userid);
			$.ajax({
				type : "POST",
				url : "user_mgt_serv",
				data : {
					request_type : 'get_user_profile_per_user',
					userid : up_userid
				},
				cache : false,
				success : function(jobdetails) {

					var table = $('#tbl_user_profile_list_dataTable');

					/*
					 * var table = $(
					 * '#tbl_user_profile_list_dataTable')
					 * .DataTable();
					 */

					table.find("tbody tr")
							.remove();

					// console.log(jobdetails);
					var json_p = JSON
							.parse(jobdetails);

					$(json_p.data).each(function() {

						
						if(this.option_check){
							table.append(
								"<tr>" +
									"<td>" + this.profile_name + "</td>" +
									"<td>" + this.profile_auto + "</td>" +
									"<td>" +
										"<input type='checkbox' " +
										"class='form-check-input profile-checkbox' " +
										"value='" + this.profile_auto + "' checked />" +
									"</td>" +
								"</tr>"
							);
						}else{
							table.append(
								"<tr><td>"
									+ this.profile_name
									+ "</td><td>"
									+ this.profile_auto 
									+ "</td><td><input type='checkbox' value='" + this.profile_auto + "' class='form-check-input profile-checkbox'/></td>"
									+ "</tr>"
								);
						}
						

					});

					updateSelectionCount();

				}
			});

		});

		function updateSelectionCount() {
			const checkboxes = document.querySelectorAll('.profile-checkbox:checked');
			const count = checkboxes.length;
			document.getElementById('selectedCount').textContent = count;
			
			// Update summary message
			const summaryEl = document.getElementById('selectionSummary');
			if (count === 0) {
				summaryEl.className = 'alert alert-warning mt-3 mb-0';
				summaryEl.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i><span id="selectedCount">0</span> role(s) selected';
			} else if (count === 1) {
				summaryEl.className = 'alert alert-info mt-3 mb-0';
				summaryEl.innerHTML = `<i class="fas fa-info-circle me-2"></i><span id="selectedCount">1</span> role selected`;
			} else {
				summaryEl.className = 'alert alert-success mt-3 mb-0';
				summaryEl.innerHTML = `<i class="fas fa-check-circle me-2"></i><span id="selectedCount">${count}</span> roles selected`;
			}
		}

		document.addEventListener('change', function(e) {
			if (e.target.type === 'checkbox' && e.target.closest('#tbl_user_profile_list_dataTable')) {
				updateSelectionCount();
			}
		});


		$('#assignMilestoneUserProfile')
							.on(
									'show.bs.modal',
									function(event) {

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_main_service',
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

													//	console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#main_service_assign_milestone");

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
																			// console
																			// 		.log(this.business_process_id);

																			// if
																			// (this.business_process_on_case
																			// ==
																			// 'No')
																			// {
																			$(
																					'#main_service_assign_milestone')
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

														// business_process_id
													}
												});

									

									});

									$('#main_service_assign_milestone')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_assign_milestone");
										var main_service = select_id.options[select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

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

													//	console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#sub_service_assign_milestone");

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

																			// console
																			// 		.log(select_id);
																			// console
																			// 		.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				// if
																				// (this.business_process_on_case
																				// ==
																				// 'No')
																				// {
																				$(
																						'#sub_service_assign_milestone')
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
											});	



											$('#sub_service_assign_milestone')
							.change(
									function() {
										// alert($(this).val());
										var main_select_id = document
												.getElementById("main_service_assign_milestone");
										var main_service = main_select_id.options[main_select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_assign_milestone");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');

										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										var ms_userid = $("#ms_userid").val();

										console.log(main_service_id);
										console.log(sub_service_id);
										console.log(ms_userid);

										$
												.ajax({
													type : "POST",
													url : "user_mgt_serv",
													data : {
														request_type : 'select_lc_milestone_per_user',
														main_service_id : main_service_id,
														sub_service_id : sub_service_id,
														userid : ms_userid
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(jobdetails) {

														console.log(jobdetails);
														//var json_p = JSON.parse(jobdetails);
														var table = $('#tbl_user_milestone_list_dataTable');

														/*
														 * var table = $(
														 * '#tbl_user_profile_list_dataTable')
														 * .DataTable();
														 */
									
														table.find("tbody tr")
																.remove();
									
														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
									
														$(json_p.data).each(function() {
									
															
															if(this.option_check){
																table.append("<tr><td>"
																		+ this.milestone_description
																		+ "</td><td><input type='checkbox'checked/></td><td>"
																		+ this.ms_id 
																		+ "</td>"
									
																		
									
																		+ "</tr>");
															}else{
																table.append("<tr><td>"
																		+ this.milestone_description
																		+ "</td><td><input type='checkbox' /></td><td>"
																		+ this.ms_id 
																		+ "</td>"
									
																		
									
																		+ "</tr>");
															}
															
									
														});
														
													}
												});
											});	

					// var oTable =
					// $('#tbl_user_profile_list_dataTable').DataTable();

					/*
					 * $('#tbl_user_profile_list_dataTable tbody').on( 'click',
					 * 'tr', function () {
					 * 
					 * 
					 * $(this).toggleClass('selected'); var pos =
					 * oTable.row(this).index(); var row =
					 * oTable.row(pos).data(); console.log(row); } );
					 */

					$('#btn_save_user_profile_details').click(function() {
						// Collect selected profiles
						var array = [];
						var userid = $("#up_userid").val();
						var fullname = $("#up_fullname").val();
						
						// $('#tbl_user_profile_list_dataTable tr').has('td :checkbox:checked').each(function() {
						// 	var arrayItem = {};
						// 	$('td', $(this)).each(function(index,item) {
						// 		if (index == 0) {
						// 			return true;
						// 		} else {
						// 			arrayItem["profile_auto"] = $(item).html();
						// 			arrayItem["userid"] = userid;
						// 			arrayItem["option_check"] = true;
						// 			arrayItem["module_name"] = 'No Module Name';
						// 		}
						// 	});
						// 	array.push(arrayItem);
						// });

						$('#tbl_user_profile_list_dataTable tr').has('td :checkbox:checked').each(function() {
							var arrayItem = {};
							var profileName = $(this).find('td:first').text().trim();
							
							$(this).find('td').each(function(index, item) {
								if (index === 0) {
									return true; // Skip profile name column
								} else if (index === 1) {
									// Get profile ID from the checkbox value
									const profileId = $(this)
										.closest('tr')
										.find('input.profile-checkbox')
										.val();
									arrayItem["profile_auto"] = profileId;
									arrayItem["userid"] = userid;
									arrayItem["option_check"] = true;
									arrayItem["module_name"] = 'No Module Name';
									arrayItem["profile_name"] = profileName;
								}
							});
							array.push(arrayItem);
						});
						
						// Check if any profiles are selected
						if (array.length === 0) {
							Swal.fire({
								title: 'No Roles Selected',
								text: 'Please select at least one role to assign.',
								icon: 'warning',
								confirmButtonText: 'OK',
								confirmButtonColor: '#3085d6'
							});
							return;
						}
						
						// Create confirmation message
						// console.log(array);
						var roleCount = array.length;
						var roleNames = array.map(item => item.profile_name).slice(0, 5); // Show first 5 roles
						var roleList = roleNames.join(', ');
						
						if (roleCount > 5) {
							roleList += ` and ${roleCount - 5} more role(s)`;
						}
						
						// Show confirmation dialog
						Swal.fire({
							title: 'Confirm Role Assignment',
							html: `
								<div class="text-start">
									<p><strong>User:</strong> ${fullname}</p>
									<p><strong>Roles to assign:</strong> ${roleList}</p>
									<p><strong>Total roles:</strong> ${roleCount}</p>
									<p class="text-muted small mt-2">This action will update the user's access permissions.</p>
								</div>
							`,
							icon: 'question',
							showCancelButton: true,
							confirmButtonText: 'Yes, Assign Roles',
							cancelButtonText: 'Cancel',
							confirmButtonColor: '#28a745',
							cancelButtonColor: '#6c757d',
							reverseButtons: true,
							showLoaderOnConfirm: true,
							preConfirm: () => {
								return new Promise((resolve, reject) => {
									var profile_list1 = JSON.stringify(array);
									// console.log(profile_list1);
									// console.log(userid);
									$.ajax({
										type: "POST",
										url: "user_mgt_serv",
										data: {
											request_type: 'update_user_profile',
											profile_list: profile_list1,
											userid: userid
										},
										cache: false,
										success: function(jobdetails) {
											//console.log(jobdetails);
											resolve(jobdetails);
										},
										error: function(xhr, status, error) {
											reject('Failed to save: ' + error);
										}
									});
								});
							},
							allowOutsideClick: () => !Swal.isLoading()
						}).then((result) => {
							if (result.isConfirmed) {
								// Success handling
								try {
									var response = result.value;
									var responseData;
									
									// Try to parse JSON response
									try {
										responseData = JSON.parse(response);
									} catch (e) {
										responseData = response;
									}

									console.log(responseData);
									
									if (responseData == 'User Profile Added/Updated Successfullly') {
										Swal.fire({
											title: 'Success!',
											html: `
												<div class="text-center">
													<div class="mb-3">
														<i class="fas fa-check-circle text-success fa-4x"></i>
													</div>
													<p><strong>${roleCount} role(s) assigned successfully!</strong></p>
													<p class="text-muted">User: ${fullname}</p>
													<p class="small">Roles have been updated and will take effect immediately.</p>
												</div>
											`,
											icon: 'success',
											confirmButtonText: 'OK',
											confirmButtonColor: '#28a745'
										}).then(() => {
											// Close the modal
											$('#assignReassignUserProfile').modal('hide');
											
											// Optionally refresh user list or show updated status
											// setTimeout(() => {
											// 	// You can trigger a table refresh here if needed
											// 	// $('#tbl_user_list_dataTable').DataTable().ajax.reload();
												
											// 	// Show success notification
											// 	// toastr.success('Roles updated successfully!', 'Success', {
											// 	// 	positionClass: "toast-top-right",
											// 	// 	timeOut: 3000
											// 	// });
											// }, 500);
										});
									} else {
										// Handle error response
										var errorMsg = typeof responseData === 'object' ? 
											(responseData.message || responseData.error || 'Unknown error occurred') : 
											responseData;
										
										Swal.fire({
											title: 'Update Failed',
											text: errorMsg,
											icon: 'error',
											confirmButtonText: 'OK',
											confirmButtonColor: '#dc3545'
										});
									}
								} catch (error) {
									Swal.fire({
										title: 'Error',
										text: 'An unexpected error occurred: ' + error,
										icon: 'error',
										confirmButtonText: 'OK',
										confirmButtonColor: '#dc3545'
									});
								}
							}
						}).catch((error) => {
							// Handle AJAX error
							Swal.fire({
								title: 'Server Error',
								text: 'Failed to save changes: ' + error,
								icon: 'error',
								confirmButtonText: 'OK',
								confirmButtonColor: '#dc3545'
							});
						});
					});

					$('#btn_save_user_assigned_milestone_details').click(function() {

						var main_select_id = document
												.getElementById("main_service_assign_milestone");
										var main_service = main_select_id.options[main_select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_assign_milestone");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');

										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										var ms_userid = $("#ms_userid").val();

										console.log(main_service_id);
										console.log(sub_service_id);
										console.log(ms_userid);

						var array = [];
						// var headers = [];

						var userid = $("#ms_userid").val();
						$('#tbl_user_milestone_list_dataTable tr').has('td :checkbox:checked').each(function() {
							var arrayItem = {};
							$('td', $(this)).each(function(index,item) {
								if (index == 0) {
									return true;
								} else {
									arrayItem["ms_id"] = $(item).html();
									arrayItem["userid"] = userid;
									arrayItem["option_check"] = true;
									arrayItem["milestone_description"] = 'No Module Name';
									arrayItem["main_service_id"] = main_service_id;
									arrayItem["sub_service_id"] = sub_service_id;
								}
							});
							array.push(arrayItem);
						});
						console.log(array);

						var profile_list1 = JSON.stringify(array);

						console.log(profile_list1);

						$.ajax({
							type : "POST",
							url : "user_mgt_serv",
							data : {
								request_type : 'update_user_milestone',
								profile_list : profile_list1,
								userid : userid,
							},
							cache : false,
							
							success : function(jobdetails) {

								console.log(jobdetails);
								// var json_p =
								// JSON.parse(jobdetails);

								// $('#case_file_number').val(jobdetails);
								// alert(jobdetails);
								$("#general_message_dialog").modal();
								// $('#general_message_dialog
								// #general_message_dialog_msg').val(jobdetails);
								$('#general_message_dialog #general_message_dialog_msg_new').val(jobdetails);

							}
						});

					});

					// $('#frmAddEditUser').on("submit",function() {
					// 	// var oTable =
					// 	// $('#tbl_user_profile_list_dataTable').DataTable();
					// 	var department = $("#ur_department").val();  // $( "#user_to_send_to option:selected" ).text();
				   	//  	var department_id  = $('#listofunits option').filter(function() {return this.value == department; }).data('id');
				   	// 	var department_name= $('#listofunits option').filter(function() {return this.value == department; }).data('name');
				   		
				   	// 	var district = $("#ur_district").val();
				   	// 	var district_name = $("#ur_district option:selected").html();
				   	// 	var region = $("#ur_region").val();
				   	// 	var region_id = $("#ur_region").find(':selected').data('id')
				   		
				   		
				   		
				   		
				   	// 	var userid = $("#ur_userid").val();
					// 	var username = $("#ur_username").val();
					// 	var password = $("#ur_web_pass").val();
					// 	var password_conf = $("#ur_web_pass_confirm").val();
					// 	var fullname = $("#ur_fullname").val();
					// 	var userprofile = $("#ur_userprofile").val();
					// 	var isdisabled = $("#ur_isdisabled").val()=='Yes'?'true':'false';
					// 	var canpasswordexpire = $("#ur_canpasswordexpire").val()=='Yes'?'true':'false';
					// 	var passwordexpirydate = $("#ur_passwordexpirydate").val();
					// 	var passwordchanged = $("#ur_passwordchanged").val();
					// 	var staffnumber = $("#ur_staffnumber").val();
					// 	var title = $("#ur_title").val();
					// 	var designation = $("#ur_designation").val();
					// 	var division = $("#ur_division").val();
					// 	var emailaddress = $("#ur_emailaddress").val();
					// 	var address = $("#ur_address").val();
					// 	var phone = $("#ur_phone").val();
					// 	var mobile = $("#ur_mobile").val();
					// 	var user_level = $("#ur_user_level").val();
					// 	var view_all_offices = $("#ur_view_all_offices").val();
						
						
					// 	/*console.log("department: "+ department);
				   	// 	console.log("department_id: "+ department_id);
				   	// 	console.log("department_name: "+ department_name);
				   	// 	console.log("district: "+ district);
				   	// 	console.log("district_name: "+ district_name);
				   	// 	console.log("region :"+ region );
				   	// 	console.log("password: "+ password );*/
						
				   	// 	if(!department || !department_id || !department_name || !district || !district_name || !region || !user_level || !view_all_offices){
				   	// 	  alert("Some required fields are not filed. Pls Review");
				   	// 	  /*$("#general_message_dialog").modal(); 
					// 	  $('#general_message_dialog  #general_message_dialog_msg_new').val("Some required fields are not filed. Pls Review");*/
				   	// 	}else if(password && (password != password_conf) ){
				   	// 		alert("Password and Confirmation must be the same");
				   	// 		/*$("#general_message_dialog").modal(); 
					// 		$('#general_message_dialog  #general_message_dialog_msg_new').val("Password and Confirmation must be the same");*/
				   	// 	}
				   		
				   	// 	else{
				   	// 		$.ajax({
					// 			type : "POST",
					// 			url : "user_mgt_serv",
					// 			data : {
					// 				request_type : 'add',
					// 				userid : userid,
					// 				username: username,
					// 				password : password,
					// 				fullname :fullname,
					// 				userprofile : userprofile,
					// 				isdisabled : isdisabled,
					// 				canpasswordexpire :canpasswordexpire,
					// 				passwordexpirydate : passwordexpirydate,
					// 				passwordchanged : passwordchanged,
					// 				staffnumber : staffnumber,
					// 				title : title,
					// 				designation : designation,
					// 				division :division,
					// 				emailaddress : emailaddress,
					// 				address : address,
					// 				phone : phone,
					// 				mobile : mobile,
					// 				user_level : user_level,
					// 				department_id  : department_id, 
					// 		   		department_name : department_name,
					// 		   		district_code : district,
					// 		   		district_name : district_name,
					// 		   		region : region,
					// 		   		region_id : region_id,
					// 		   		view_all_offices: view_all_offices,
									
					// 			},
					// 			cache : false,
					// 			success : function(
					// 					jobdetails) {

					// 				//console.log(jobdetails);
					// 				// var json_p =
					// 				// JSON.parse(jobdetails);

					// 				// $('#case_file_number').val(jobdetails);
					// 				alert(jobdetails);
									
					// 				  $("#general_message_dialog").modal(); 
					// 				  $('#general_message_dialog  #general_message_dialog_msg_new').val(jobdetails);
									 

					// 			}
					// 		});
				   	// 	}
				   		
						
	
					// });

					$('#frmAddEditUser').on("submit", async function(e) {
    e.preventDefault();

    // Get form data
    const departmentValue = $("#ur_department").val();
    const departmentOption = $('#listofunits option').filter(function() {
        return this.value === departmentValue;
    });

    const formData = {
        userid: $("#ur_userid").val(),
        title: $("#ur_title").val(),
        fullname: $("#ur_fullname").val(),
        address: $("#ur_address").val(),
        emailaddress: $("#ur_emailaddress").val(),
        phone: $("#ur_phone").val(),
        mobile: $("#ur_mobile").val(),
        staffnumber: $("#ur_staffnumber").val(),
        designation: $("#ur_designation").val(),
        region: $("#ur_region").val(),
        region_id: $("#ur_region").find(':selected').data('id'),
        district_code: $("#ur_district").val(),
        district_name: $("#ur_district option:selected").text(),
        division: $("#ur_division").val(),
        department: $("#ur_department").val(),
        username: $("#ur_username").val(),
        userprofile: $("#ur_userprofile").val(),
        password: $("#ur_web_pass").val(),
        password_conf: $("#ur_web_pass_confirm").val(),
        isdisabled: $("#ur_isdisabled").val() === 'Yes' ? 'true' : 'false',
        passwordchanged: $("#ur_passwordchanged").val(),
        canpasswordexpire: $("#ur_canpasswordexpire").val() === 'Yes' ? 'true' : 'false',
        passwordexpirydate: $("#ur_passwordexpirydate").val(),
        user_level: $("#ur_user_level").val(),
        lrd_user_level: $("#ur_lrd_user_level").val(),
        view_all_offices: $("#ur_view_all_offices").val(),
        usr_access_level: $("#usr_access_level").val(),
        department: departmentValue,
        department_id: departmentOption.data('id'),
        department_name: departmentOption.data('name'),
    };

    // Validate required fields
    const requiredFields = [
        { field: 'title', label: 'Title' },
        { field: 'fullname', label: 'Full Name' },
        { field: 'emailaddress', label: 'Email Address' },
        { field: 'phone', label: 'Phone Number' },
        { field: 'staffnumber', label: 'Staff Number' },
        { field: 'region', label: 'Region' },
        { field: 'district_code', label: 'Office Location' },
        { field: 'department', label: 'Department' },
        { field: 'username', label: 'Username' },
        { field: 'user_level', label: 'User Level' },
        { field: 'usr_access_level', label: 'User Access Level' }
    ];

    const missingFields = requiredFields.filter(item => !formData[item.field] || formData[item.field].toString().trim() === '');
    
    if (missingFields.length > 0) {
        await Swal.fire({
            title: 'Missing Information',
            html: `
                <div class="text-start">
                    <p>The following required fields are empty:</p>
                    <ul class="text-danger">
                        ${missingFields.map(item => `<li>${item.label}</li>`).join('')}
                    </ul>
                    <p class="small text-muted">Please fill in all required fields marked with *</p>
                </div>
            `,
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#dc3545'
        });
        return;
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (formData.emailaddress && !emailRegex.test(formData.emailaddress)) {
        await Swal.fire({
            title: 'Invalid Email',
            text: 'Please enter a valid email address',
            icon: 'error',
            confirmButtonText: 'OK'
        });
        return;
    }

    // Validate password
    if (formData.password || formData.password_conf) {
        // Check if passwords match
        if (formData.password !== formData.password_conf) {
            await Swal.fire({
                title: 'Password Mismatch',
                text: 'Password and confirmation password do not match',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return;
        }

        // Check password strength (if required)
        if (formData.password.length > 0 && formData.password.length < 6) {
            await Swal.fire({
                title: 'Weak Password',
                html: `
                    <div class="text-start">
                        <p>Password must be at least 6 characters long.</p>
                        <p class="small text-muted">For better security, consider using:</p>
                        <ul class="small">
                            <li>8+ characters</li>
                            <li>Mix of uppercase and lowercase</li>
                            <li>Numbers and special characters</li>
                        </ul>
                    </div>
                `,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Use Anyway',
                cancelButtonText: 'Change Password',
                reverseButtons: true
            }).then((result) => {
                if (!result.isConfirmed) {
                    $("#ur_web_pass").focus();
                    return Promise.reject('Password change requested');
                }
            });
        }
    }

    // Prepare confirmation message
    const isEditMode = formData.userid && formData.userid !== '0' && formData.userid !== '0';
    const actionText = isEditMode ? 'update' : 'create';
    const userStatus = formData.isdisabled === 'true' ? 'Disabled' : 'Active';
    
    // Show confirmation dialog
    const result = await Swal.fire({
        title: `${isEditMode ? 'Update' : 'Create'} User Account`,
        html: `
            <div class="text-start">
                <div class="mb-3">
                    <h6 class="mb-1">User Details:</h6>
                    <p class="mb-1"><strong>Name:</strong> ${formData.title} ${formData.fullname}</p>
                    <p class="mb-1"><strong>Username:</strong> ${formData.username}</p>
                    <p class="mb-1"><strong>Email:</strong> ${formData.emailaddress}</p>
                    <p class="mb-1"><strong>Staff #:</strong> ${formData.staffnumber}</p>
                </div>
                <div class="mb-3">
                    <h6 class="mb-1">Access Details:</h6>
                    <p class="mb-1"><strong>Region:</strong> ${formData.region}</p>
                    <p class="mb-1"><strong>Department:</strong> ${formData.department}</p>
                    <p class="mb-1"><strong>Access Level:</strong> ${formData.usr_access_level}</p>
                    <p class="mb-1"><strong>Status:</strong> <span class="badge ${userStatus === 'Active' ? 'bg-success' : 'bg-danger'}">${userStatus}</span></p>
                </div>
                ${formData.password ? `
                <div class="alert alert-warning p-2 small">
                    <i class="fas fa-exclamation-triangle me-1"></i>
                    <strong>Note:</strong> Password will be ${isEditMode ? 'updated' : 'set'} for this user
                </div>
                ` : ''}
                <p class="text-muted small">Are you sure you want to ${actionText} this user account?</p>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: `Yes, ${actionText} user`,
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#6c757d',
        reverseButtons: true,
        showLoaderOnConfirm: true,
        preConfirm: () => {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: "POST",
                    url: "user_mgt_serv",
                    data: {
                        request_type: 'add',
                        ...formData
                    },
                    cache: false,
                    success: function(response) {
                        resolve(response);
                    },
                    error: function(xhr, status, error) {
                        reject(`Error: ${error}`);
                    }
                });
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
    });

    if (result.isConfirmed) {
        try {
            const response = result.value;
            
            // Parse response if it's JSON
            let responseData;
            try {
                responseData = JSON.parse(response);
            } catch (e) {
                responseData = { message: response, success: true };
            }
            
            if (responseData.success !== false) {
                // Success notification
                await Swal.fire({
                    title: 'Success!',
                    html: `
                        <div class="text-center">
                            <div class="mb-3">
                                <i class="fas fa-check-circle text-success fa-4x"></i>
                            </div>
                            <h5>User ${isEditMode ? 'Updated' : 'Created'} Successfully</h5>
                            <div class="mt-3 text-start">
                                <p><strong>User:</strong> ${formData.username}</p>
                                <p><strong>Name:</strong> ${formData.fullname}</p>
                                <p class="small text-muted">User account has been ${isEditMode ? 'updated' : 'created'} in the system.</p>
                            </div>
                        </div>
                    `,
                    icon: 'success',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#28a745',
                    timer: 3000,
                    timerProgressBar: true
                });

                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('addupdateuserdatails'));
                modal.hide();

                // Refresh user list (if you have a DataTable or similar)
                if (typeof refreshUserTable === 'function') {
                    refreshUserTable();
                } else {
                    // Optionally reload the page after a delay
                    setTimeout(() => {
                        location.reload();
                    }, 1000);
                }

            } else {
                // Server returned error
                throw new Error(responseData.message || 'Unknown server error');
            }
            
        } catch (error) {
            // Show error message
            await Swal.fire({
                title: 'Operation Failed',
                html: `
                    <div class="text-start">
                        <p>Failed to ${actionText} user account:</p>
                        <div class="alert alert-danger small">
                            <strong>Error:</strong> ${error.message || error}
                        </div>
                        <p class="small text-muted">Please check the information and try again.</p>
                    </div>
                `,
                icon: 'error',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
            });
            
            // Log error for debugging
            console.error('User save error:', error);
        }
    }
});

// Optional: Add input validation as user types
$(document).ready(function() {
    // Email validation
    $('#ur_emailaddress').on('blur', function() {
        const email = $(this).val();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        if (email && !emailRegex.test(email)) {
            $(this).addClass('is-invalid');
            $('#emailError').remove();
            $(this).after('<div id="emailError" class="invalid-feedback">Please enter a valid email address</div>');
        } else {
            $(this).removeClass('is-invalid');
            $('#emailError').remove();
        }
    });

    // Password validation
    $('#ur_web_pass_confirm').on('keyup', function() {
        const password = $('#ur_web_pass').val();
        const confirmPassword = $(this).val();
        
        if (password && confirmPassword && password !== confirmPassword) {
            $(this).addClass('is-invalid');
            $('#passwordError').remove();
            $(this).after('<div id="passwordError" class="invalid-feedback">Passwords do not match</div>');
        } else {
            $(this).removeClass('is-invalid');
            $('#passwordError').remove();
        }
    });

    // Real-time required field validation
    $('.form-control[required]').on('blur', function() {
        if (!$(this).val().trim()) {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });
});

// Optional: Add form reset when modal closes
$('#addupdateuserdatails').on('hidden.bs.modal', function() {
    // Clear validation states
    $('.form-control').removeClass('is-invalid');
    $('.invalid-feedback').remove();
    
    // Reset form if needed (optional)
    // $('#frmAddEditUser')[0].reset();
});

					/*
					 * ======================================== Actions for User
					 * Management ==================
					 */

					$('#btnsavecorpuserdetails').on("click",function() {
				   		
						var userid = $("#corp_userid").val();
					 var username = $("#corp_username").val();
					 var password = $("#corp_web_pass").val();
					 var password_conf = $("#corp_web_pass_confirm").val();
					 var fullname = $("#corp_fullname").val();
					 //var userprofile = $("#corp_userprofile").val();
					 var isdisabled = $("#corp_isdisabled").val()=='Yes'?'true':'false';
					 var canpasswordexpire = $("#corp_canpasswordexpire").val()=='Yes'?'true':'false';
					 var passwordexpirydate = $("#corp_passwordexpirydate").val();
					 var passwordchanged = $("#corp_passwordchanged").val();
					 var staffnumber = $("#corp_staffnumber").val();
					 var title = $("#corp_title").val();
					 var designation = $("#corp_designation").val();
					 //var division = $("#ur_division").val();
					 var emailaddress = $("#corp_emailaddress").val();
					 var address = $("#corp_address").val();
					 var phone = $("#corp_phone").val();
					 var mobile = $("#corp_mobile").val();
					 var user_level = $("#corp_user_level").val();
					 var org_name = $("#corp_org_name").val();


					 console.log(org_name);
					 
					 
					 /*console.log("department: "+ department);
						console.log("department_id: "+ department_id);
						console.log("department_name: "+ department_name);
						console.log("district: "+ district);
						console.log("district_name: "+ district_name);
						console.log("region :"+ region );
						console.log("password: "+ password );*/
					 
						if(!user_level || !org_name){
						  alert("Some required fields are not filed. Pls Review");
						  /*$("#general_message_dialog").modal(); 
					   $('#general_message_dialog  #general_message_dialog_msg_new').val("Some required fields are not filed. Pls Review");*/
						}else if(password && (password != password_conf) ){
							alert("Password and Confirmation must be the same");
							/*$("#general_message_dialog").modal(); 
						 $('#general_message_dialog  #general_message_dialog_msg_new').val("Password and Confirmation must be the same");*/
						}
						
						else{
							$.ajax({
						 	type : "POST",
						 	url : "user_mgt_serv",
						 	data : {
						 		request_type : 'corp_add',
						 		userid : userid,
						 		username: username,
						 		password : password,
						 		fullname :fullname,
						 		//userprofile : userprofile,
						 		isdisabled : isdisabled,
						 		canpasswordexpire :canpasswordexpire,
						 		passwordexpirydate : passwordexpirydate,
						 		passwordchanged : passwordchanged,
						 		staffnumber : staffnumber,
						 		title : title,
						 		designation : designation,
						 		//division :division,
						 		emailaddress : emailaddress,
						 		address : address,
						 		phone : phone,
						 		mobile : mobile,
						 		user_level : user_level,
						 		org_name  : org_name.replace(".0", ""), 
						    		// department_name : department_name,
						    		// district_code : district,
						    		// district_name : district_name,
						    		// region : region,
						    		// region_id : region_id,
						    		// view_all_offices: view_all_offices,
								 
						 	},
						 	cache : false,
						 	success : function(
						 			jobdetails) {

						 		console.log(jobdetails);
						 		// var json_p =
						 		// JSON.parse(jobdetails);

						 		// $('#case_file_number').val(jobdetails);
						 		alert(jobdetails);
								 
						 		  $("#general_message_dialog").modal(); 
						 		  $('#general_message_dialog  #general_message_dialog_msg_new').val(jobdetails);
								  

						 	}
						 });
						}
						
					 
 
				 });



					$('#addupdatecorporateuserdatails').on('show.bs.modal',function(event) {
		
						var button = $(event.relatedTarget) // Button that triggered the  modal
				
						$("#corp_userid").val($(event.relatedTarget).data('userid'));
						$("#corp_username").val($(event.relatedTarget).data('username'));
						$("#corp_fullname").val($(event.relatedTarget).data('fullname'));
						//$("#corp_userprofile").val($(event.relatedTarget).data('userprofile'));
						$("#corp_isdisabled").val(!($(event.relatedTarget).data('isdisabled'))?"No":"Yes");
						
						$("#corp_staffnumber").val($(event.relatedTarget).data('staffnumber'));
						$("#corp_title").val($(event.relatedTarget).data('title'));
						
						
						$("#corp_address").val($(event.relatedTarget).data('address'));
						$("#corp_phone").val($(event.relatedTarget).data('phone'));
						//$("#ur_fax").val($(event.relatedTarget).data('fax'));
						$("#corp_mobile").val($(event.relatedTarget).data('mobile'));
						//$("#ur_websiteaddress").val($(event.relatedTarget).data('websiteaddress'));
						$("#corp_emailaddress").val($(event.relatedTarget).data('emailaddress'));
						//$("#ur_department").val($(event.relatedTarget).data('department'));
						//$("#ur_location").val($(event.relatedTarget).data('location'));
						//$("#ur_district").val($(event.relatedTarget).data('district'));
						
						$("#corp_id").val($(event.relatedTarget).data('id'));
						$("#corp_passwordchanged").val($(event.relatedTarget).data('passwordchanged'));
						$("#corp_canpasswordexpire").val(!($(event.relatedTarget).data('canpasswordexpire'))?"No":"Yes");
						//$("#ur_canpasswordexpire22").val(!($(event.relatedTarget).data('canpasswordexpire'))?"No":"Yes");
						$("#corp_passwordvaliditydays").val($(event.relatedTarget).data('passwordvaliditydays'));
						$("#corp_passwordexpirydate").val($(event.relatedTarget).data('passwordexpirydate'));
						$("#corp_user_level").val(parseInt($(event.relatedTarget).data('user_level')));
						$("#corp_org_name").val(parseInt($(event.relatedTarget).data('org_id')));
						$("#corp_designation").val($(event.relatedTarget).data('designation'));
						
						
						
					
					});


					$('#btnsavecorpdetails').on("click",function() {
						console.log('jkbwrfjbkerjkfberbjw');
				  var org_id = $("#frmAddEditCorp #org_id").val();
				 //  var username = $("#org_username").val();
				 //  var password = $("#org_web_pass").val();
				 //  var password_conf = $("#org_web_pass_confirm").val();
				  var fullname = $("#frmAddEditCorp #org_fullname").val();
				  var subscription_paid = $("#frmAddEditCorp #org_subscription_paid").val();
				  var subscription_due = $("#frmAddEditCorp #org_subscription_due").val();
				 //  var isdisabled = $("#org_isdisabled").val()=='Yes'?'true':'false';
				 //  var canpasswordexpire = $("#org_canpasswordexpire").val()=='Yes'?'true':'false';
				 //  var passwordexpirydate = $("#org_passwordexpirydate").val();
				 //  var passwordchanged = $("#org_passwordchanged").val();
				  //var staffnumber = $("#org_staffnumber").val();
				  var registration_no = $("#frmAddEditCorp #org_registration_no").val();
				  var contact_person_name = $("#frmAddEditCorp #org_contact_person_name").val();
				  var industry = $("#frmAddEditCorp #org_industry").val();
				  var emailaddress = $("#frmAddEditCorp #org_emailaddress").val();
				  var address = $("#frmAddEditCorp #org_address").val();
				  var phone = $("#frmAddEditCorp #org_phone").val();
				  var mobile = $("#frmAddEditCorp #org_mobile").val();
				 //  var user_level = $("#org_user_level").val();
				  //var org_name = $("#corp_org_name").val();
				  var account_number = $("#frmAddEditCorp #org_account_number").val();
				  var good_standing = $("#frmAddEditCorp #org_good_standing").val();
				  var contact_person_phone = $("#frmAddEditCorp #org_contact_person_phone").val();

				  /*console.log("department: "+ department);
					 console.log("department_id: "+ department_id);
					 console.log("department_name: "+ department_name);
					 console.log("district: "+ district);
					 console.log("district_name: "+ district_name);
					 console.log("region :"+ region );
					 console.log("password: "+ password );*/
				  
					 
						 $.ajax({
						  type : "POST",
						  url : "user_mgt_serv",
						  data : {
							  request_type : 'corp_acc_add',
							  org_id : org_id,
							 //  username: username,
							 //  password : password,
							  fullname :fullname,
							  subscription_paid : subscription_paid,
							  //isdisabled : isdisabled,
							 //  canpasswordexpire :canpasswordexpire,
							 //  passwordexpirydate : passwordexpirydate,
							 //  passwordchanged : passwordchanged,
							  //staffnumber : staffnumber,
							  //title : title,
							  //designation : designation,
							  subscription_due :subscription_due,
							  emailaddress : emailaddress,
							  address : address,
							  phone : phone,
							  mobile : mobile,
							  //user_level : user_level,
							  registration_no  : registration_no, 
							  contact_person_name: contact_person_name,
							  industry: industry,
							  account_number: account_number,
							  good_standing: good_standing,
							  contact_person_phone: contact_person_phone
								 // department_name : department_name,
								 // district_code : district,
								 // district_name : district_name,
								 // region : region,
								 // region_id : region_id,
								 // view_all_offices: view_all_offices,
							  
						  },
						  cache : false,
						  success : function(
								  jobdetails) {

							  console.log(jobdetails);
							  // var json_p =
							  // JSON.parse(jobdetails);

							  // $('#case_file_number').val(jobdetails);
							  //alert(jobdetails);
							  
								$("#general_message_dialog").modal(); 
								$('#general_message_dialog  #general_message_dialog_msg_new').val(jobdetails);
							   

						  }
					  });
					 
					 
				  

			  });


				 $("#select_corporate_users").on('change', function() {

					var corp_id = $(this).val()

					console.log(corp_id.replace(".0", ""));

					$('#tbl_corp_user_list_dataTable').DataTable().clear().destroy();

					let datatable = $("#tbl_corp_user_list_dataTable")
						.DataTable();

						

					$.ajax({
						type : "POST",
						url : "user_mgt_serv",
						data : {
							request_type : 'select_corporate_users_by_org',
							corp_id : corp_id.replace(".0", "")
							
						},
						cache : false,
						success : function(
								jobdetails) {

							//console.log(jobdetails)

							datatable.search("").draw();
							datatable.state.clear();
				
							try{
								var json_p = JSON.parse(jobdetails);
								
								$(json_p.data).each(function() {
									//Add to table
									datatable.row
									.add(
											[

												this.username,
												this.fullname,
												this.staffnumber,
												this.designation,
												this.org_name,
												`<button 
												data-target="#addupdatecorporateuserdatails" data-toggle="modal"
													class="btn btn-info btn-icon-split"
													id="btn_edit_user-${this.username}" 
													data-userid="${this.userid}" 
													
													data-username="${this.username}" 
													data-fullname="${this.fullname}"  
													data-isdisabled="${this.isdisabled}" 
													data-staffnumber="${this.staffnumber}"  
													data-title="${this.title}" 
													data-designation="${this.designation}" 
													data-address="${this.address}" 
													data-phone="${this.phone}" 
													data-mobile="${this.mobile}" 
										data-emailaddress="${this.emailaddress}"  
										data-loglocation="${this.loglocation}" 
										data-id="${this.id}" 
										data-passwordchanged="${this.passwordchanged}"  
										data-canpasswordexpire="${this.canpasswordexpire}" 
										data-passwordvaliditydays="${this.passwordvaliditydays}" 
										data-passwordexpirydate="${this.passwordexpirydate}" 
										data-user_level="${this.user_level}"  
										data-org_name="${this.org_name}" 
										data-org_id="${this.org_id}"
									>
									<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View/Edit</span>
									</button>`

								]).draw(false);
					});

				
				}catch(e){
					
				}

						}
					});
				 });

});