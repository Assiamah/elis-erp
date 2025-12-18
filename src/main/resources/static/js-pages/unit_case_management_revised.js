$(document).ready(function() {

	// Initialize tooltips on page load
    window.initializeTooltips();

	var datatable = $("#job_casemgtdetailsdataTable").DataTable({
		// responsive: true,
		stateSave : true,
		"createdRow" : function(row, data, dataIndex) {
			if (data[0] == "1") {
				$(row).addClass('tr-completed-work');
			}
		},
		dom: 'Bfrtip',						 
		buttons: [
			'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
		]

		/*
			* columns: [ { // Responsive control column data:
			* null, defaultContent: '', className: 'control',
			* orderable: false },
			*  ],
			*/
	});
					
	let queries_datatable = $("#tbl_responded_queries_result").DataTable({
		dom: 'Bfrtip',						
		buttons: [
			'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
		]
	});


	$(".btnLoadUnitApplications").click(function(event) {
		
		var inbox_type = $(this).data('id');

		var inc_1 = $('#inc_1').val();
		var com_3 = $('#com_3').val();
		var que_2 = $('#que_2').val();
		var awa_4 = $('#awa_4').val();

		var awrq_5 = $('#awa_req_5').val();
		var ctrq_6 = $('#req_com_6').val();
		var atr_7 = $('#req_com_7').val();
		

		datatable.search("").draw();
		datatable.state.clear();
		datatable.clear();

		//console.log(inc_1, com_3, que_2, awa_4)

		switch (inbox_type) {
			case 1:
				if(inc_1 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
						} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
						} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
						} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
				
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					datatable.search("").draw();
					datatable.state.clear();
					datatable.clear();

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}

			case 3:
				if(com_3 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}

			case 2:
				if(que_2 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}

			case 4:
				if(awa_4 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}

		
				case 5:
				if(awrq_5 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}
				case 6:
				if(ctrq_6 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}
				case 7:
				if(atr_7 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').val('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').val('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').val('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}
		}

	})

	$('.exclude_job_search').addClass('d-none');
	//$('.include_job_search').removeClass('d-none');

	$('input[name="adv_search_type"]').on('click', function() {
		

		var adv_search_type = $('input[name="adv_search_type"]:checked').val();
		//console.log(adv_search_type)

		if(adv_search_type == 'f_job_number') {
			$('.exclude_job_search').addClass('d-none');
			$('.include_job_search').removeClass('d-none');
		} else if(adv_search_type == 'f_app_type') {
			$('.exclude_app_type').addClass('d-none');
			$('.include_app_type').removeClass('d-none');
		} else if(adv_search_type == 'f_job_purpose') {
			$('.exclude_job_purpose').addClass('d-none');
			$('.include_job_purpose').removeClass('d-none');
		} else if(adv_search_type == 'f_date_range') {
			$('.exclude_date_range').addClass('d-none');
			$('.include_date_range').removeClass('d-none');
		} else if(adv_search_type == 'f_limit') {
			$('.exclude_limit').addClass('d-none');
			$('.include_limit').removeClass('d-none');
		}
	});
				

	$('#btn_load_adv_filter').on('click', function(e) {

		var adv_search_type = $('input[name="adv_search_type"]:checked').val();
		var inbox_type = $('#adv_inbox_type').val();
		//var adv_filter;
		//console.log(inbox_type)

		var adv_job_number = $('#adv_job_number').val()
		var adv_application_type = $('#adv_application_type').val()
		var adv_limit = $('#adv_limit').val()
		var adv_from_date = $('#adv_from_date').val()
		var adv_to_date = $('#adv_to_date').val()
		var enq_search_type = "job_number";
		var adv_job_purpose = $('#adv_job_purpose').val()
		var adv_sorting = $('#adv_sorting').val()

		if(adv_search_type == 'f_job_number') {

			inbox_type = '0';

			if(!adv_job_number) {
				// $.notify({
				// 	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter a job number</span>',
				// }, { type : 'danger' , z_index: 9999  });

				// alert('Please enter a job number');

				swal.fire({
					title: 'Ops!',
					text: 'Please enter a job number',
					icon: 'warning',
					confirmButtonText: 'OK'
				})

				return;
			}

		} else if(adv_search_type == 'f_app_type') {
			//console.log(adv_application_type,adv_limit,adv_sorting )
			if(adv_application_type == 0 || !adv_limit || !adv_sorting || adv_limit > 1000) {
				// $.notify({
				// 	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required with the exception of job purpose</span>',
				// }, { type : 'danger' , z_index: 9999  });

				// alert('Please all the field are required with the exception of job purpose');

				swal.fire({
					title: 'Ops!',
					text: 'Please all the field are required with the exception of job purpose',
					icon: 'warning',
					confirmButtonText: 'OK'
				})

				return;
			}
			
		} else if(adv_search_type == 'f_job_purpose') {

			if(adv_job_purpose == '0' || !adv_limit || adv_limit > 1000) {
				// $.notify({
				// 	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
				// }, { type : 'danger' , z_index: 9999  });

				// alert('Please all the field are required');

				swal.fire({
					title: 'Ops!',
					text: 'Please all the field are required',
					icon: 'warning',
					confirmButtonText: 'OK'
				})

				return;
			}
			
		} else if(adv_search_type == 'f_date_range') {
			if(!adv_from_date || !adv_limit || !adv_to_date|| adv_limit > 1000) {
				// $.notify({
				// 	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
				// }, { type : 'danger' , z_index: 9999  });

				// alert('Please all the field are required');

				swal.fire({
					title: 'Ops!',
					text: 'Please all the field are required',
					icon: 'warning',
					confirmButtonText: 'OK'
				})

				return;
			}
			
		} else if(adv_search_type == 'f_limit') {
			if(!adv_limit || !adv_sorting || adv_limit > 1000) {
				// $.notify({
				// 	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please all the field are required</span>',
				// }, { type : 'danger' , z_index: 9999  });

				// alert('Please all the field are required');

				swal.fire({
					title: 'Ops!',
					text: 'Please all the field are required',
					icon: 'warning',
					confirmButtonText: 'OK'
				})

				return;
			} 
		} 

		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_incoming_app_for_unit_using_adv_filter',
				//adv_filter : adv_filter,
				adv_job_number: adv_job_number,
				adv_application_type: adv_application_type,
				adv_from_date: adv_from_date == '' ? '12-12-2000' : adv_from_date,
				adv_to_date: adv_to_date == '' ? '12-12-2000' : adv_to_date,
				adv_limit: adv_limit == '' ? 0 : adv_limit,
				enq_search_type: enq_search_type,
				inbox_type: inbox_type + '_false',
				adv_job_purpose : adv_job_purpose,
				adv_sorting : adv_sorting,
				adv_search_type : adv_search_type
			},
			success : function(jobdetails) {

				if(!jobdetails) {
					return;
				}
														
				// console.log(jobdetails);
				var json_p = JSON.parse(jobdetails);

				$('#incoming_advanced_search').modal('hide');
				
				/*
					* $('th:nth-child(7)').show(); 
					* $('th:nth-child(8)').show();
					*/

				datatable.column(0).visible(true);
				// datatable.column(1).visible(false);

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();

				// Remove all active state classes first
            	removeAllActiveStates();


				$(json_p.data).each(function() {
					datatable.row.add([
						// 0: Checkbox
						'<div class="form-check d-flex justify-content-center align-items-center">' +
							'<input class="form-check-input row-checkbox" type="checkbox" id="checkbox-' + (this.job_number || '') + '">' +
						'</div>',

						// 1: Created Date
						'<span class="small">' + (formatDate(this.created_date) || '') + '</span>',

						// 2: Job Number
						'<span class="font-weight-bold text-primary small">' + (this.job_number || '') + '</span>',

						// 3: Applicant Name
						'<div class="applicant-name small">' +
							'<a href="#" class="custom-tooltip" ' +
								'data-bs-toggle="tooltip" ' +
								'data-bs-custom-class="tooltip-primary" ' +
								'data-bs-placement="top" ' +
								'title="' + (this.ar_name || '') + '">' +
								((this.ar_name || '').length > 20 
									? (this.ar_name || '').substring(0, 20) + '...' 
									: (this.ar_name || '')) +
							'</a>' +
						'</div>',

						// 4: Application Type
						'<span class="small">' + (this.business_process_sub_name || '') + '</span>',

						// 5: Status
						'<span data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" data-bs-placement="top" title="' + (this.job_status || '') + '" class="badge ' +
							(this.current_application_status === 'Completed' ? 'bg-success' :
							this.current_application_status === 'Queried' ? 'bg-danger' :
							this.current_application_status === 'In Progress' ? 'bg-warning' : 'bg-dark') + '">' +
							((this.job_status || '').length > 15 ? (this.job_status || '').substring(0, 15) + '...' : (this.job_status || '')) +
						'</span>' +
						((this.objections || 0) > 0 ? '<i class="fas fa-exclamation-circle ml-1 text-danger" data-toggle="tooltip" title="Has Objections"></i>' : ''),

						// 6: Sent By
						'<span class="small">' + (this.job_forwarded_by || '') + '</span>',

						// 7: Locality
						'<span class="small">' + (this.locality || '') + '</span>',

						// 8: Type of Plotting
						'<span class="small">' + (this.plotting_type || this.smd_type_of_plotting || '') + '</span>',

						// 9: Actions
						'<div class="d-flex justify-content-center">' +
							'<button class="btn btn-icon btn-sm me-1 btn-outline-info btn-wave waves-effect waves-light btn-add-batch" ' +
								'id="btnAddToBatchlist-' + this.job_number + '" ' +
								'data-job_number="' + this.job_number + '" ' +
								'data-ar_name="' + this.ar_name + '" ' +
								'data-business_process_sub_name="' + this.business_process_sub_name + '" ' +
								'data-application_stage="' + this.application_stage + '" ' +
								'data-application_stage_name="' + this.application_stage_name + '" ' +
								'data-application_stage_baby_step="' + this.application_stage_baby_step + '" ' +
								'data-application_stage_name_baby_step="' + this.application_stage_name_baby_step + '" ' +
								'data-bs-target="#askForPurposeOfBatching" data-bs-toggle="modal">' +
								'<i class="fas fa-plus"></i>' +
							'</button>' +
							'<form action="front_office_view_application" method="post" class="d-inline">' +
								'<input type="hidden" name="case_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="search_text" value="' + this.case_number + '">' +
								'<input type="hidden" name="job_number" value="' + this.job_number + '">' +
								'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">' +
								'<button type="submit" name="save" class="btn btn-icon btn-sm me-1 btn-outline-primary btn-wave waves-effect waves-light">' +
									'<i class="fas fa-eye"></i>' +
								'</button>' +
							'</form>' +
							'<form action="request_application_progress_details_advance" method="post" class="d-inline">' +
								'<input type="hidden" name="case_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="transaction_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="job_number" value="' + this.job_number + '">' +
								'<input type="hidden" name="review_type" value="GeneralWorkRequest">' +
								'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">' +
								'<button type="submit" name="save" class="btn btn-icon btn-sm me-1 btn-outline-danger btn-wave waves-effect waves-light to_hide_on_level_1">' +
									'<i class="fas fa-folder-open"></i>' +
								'</button>' +
							'</form>' +
						'</div>'
					]).draw(false);
					
					datatable.column(2).data().sort();

				});

				highlightActiveCard(inbox_type);

				// Reinitialize tooltips after a brief delay
				setTimeout(function() {
					window.initializeTooltips();
				}, 50);

				if (localStorage.getItem('user_level') < 2) {
					// $('th:nth-child(8),
					// th:nth-child(8)').hide();
					// $('.to_hide_on_level_1').hide();
					datatable.column(11).visible(false);

				}

			}
		})
	})


	function LoadUnitApplications(inbox_type){
		//var inbox_type = $(this).data('id');

		const tooltipTriggerList = document.querySelectorAll('.custom-tooltip');

		tooltipTriggerList.forEach(el => {
			new bootstrap.Tooltip(el, {
				delay: { show: 500, hide: 100 }, // delay in ms
				customClass: 'tooltip-primary',
				placement: 'top'
			});
		});
										
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_applications_at_unit_by_inbox_type',
				inbox_type : inbox_type + '_false',
			},

			success : function(jobdetails) {

				if(!jobdetails) {
					return;
				}
														
				// console.log(jobdetails);
				var json_p = JSON.parse(jobdetails);


				/*
					* $('th:nth-child(7)').show(); 
					* $('th:nth-child(8)').show();
					*/

				datatable.column(0).visible(true);
				// datatable.column(1).visible(false);

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();

				// Remove all active state classes first
            	removeAllActiveStates();


				$(json_p.data).each(function() {
					datatable.row.add([
						// 0: Checkbox
						'<div class="form-check d-flex justify-content-center align-items-center">' +
							'<input class="form-check-input row-checkbox" type="checkbox" id="checkbox-' + (this.job_number || '') + '">' +
						'</div>',

						// 1: Created Date
						'<span class="small">' + (formatDate(this.created_date) || '') + '</span>',

						// 2: Job Number
						'<span class="font-weight-bold text-primary small">' + (this.job_number || '') + '</span>',

						// 3: Applicant Name
						'<div class="applicant-name small">' +
							'<a href="#" class="custom-tooltip" ' +
								'data-bs-toggle="tooltip" ' +
								'data-bs-custom-class="tooltip-primary" ' +
								'data-bs-placement="top" ' +
								'title="' + (this.ar_name || '') + '">' +
								((this.ar_name || '').length > 20 
									? (this.ar_name || '').substring(0, 20) + '...' 
									: (this.ar_name || '')) +
							'</a>' +
						'</div>',

						// 4: Application Type
						'<span class="small">' + (this.business_process_sub_name || '') + '</span>',

						// 5: Status
						'<span data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" data-bs-placement="top" title="' + (this.job_status || '') + '" class="badge ' +
							(this.current_application_status === 'Completed' ? 'bg-success' :
							this.current_application_status === 'Queried' ? 'bg-danger' :
							this.current_application_status === 'In Progress' ? 'bg-warning' : 'bg-dark') + '">' +
							((this.job_status || '').length > 15 ? (this.job_status || '').substring(0, 15) + '...' : (this.job_status || '')) +
						'</span>' +
						((this.objections || 0) > 0 ? '<i class="fas fa-exclamation-circle ml-1 text-danger" data-toggle="tooltip" title="Has Objections"></i>' : ''),

						// 6: Sent By
						'<span class="small">' + (this.job_forwarded_by || '') + '</span>',

						// 7: Locality
						'<span class="small">' + (this.locality || '') + '</span>',

						// 8: Type of Plotting
						'<span class="small">' + (this.plotting_type || this.smd_type_of_plotting || '') + '</span>',

						// 9: Actions
						'<div class="d-flex justify-content-center">' +
							'<button class="btn btn-icon btn-sm me-1 btn-outline-info btn-wave waves-effect waves-light btn-add-batch" ' +
								'id="btnAddToBatchlist-' + this.job_number + '" ' +
								'data-job_number="' + this.job_number + '" ' +
								'data-ar_name="' + this.ar_name + '" ' +
								'data-business_process_sub_name="' + this.business_process_sub_name + '" ' +
								'data-application_stage="' + this.application_stage + '" ' +
								'data-application_stage_name="' + this.application_stage_name + '" ' +
								'data-application_stage_baby_step="' + this.application_stage_baby_step + '" ' +
								'data-application_stage_name_baby_step="' + this.application_stage_name_baby_step + '" ' +
								'data-bs-target="#askForPurposeOfBatching" data-bs-toggle="modal">' +
								'<i class="fas fa-plus"></i>' +
							'</button>' +
							'<form action="front_office_view_application" method="post" class="d-inline">' +
								'<input type="hidden" name="case_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="search_text" value="' + this.case_number + '">' +
								'<input type="hidden" name="job_number" value="' + this.job_number + '">' +
								'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">' +
								'<button type="submit" name="save" class="btn btn-icon btn-sm me-1 btn-outline-primary btn-wave waves-effect waves-light">' +
									'<i class="fas fa-eye"></i>' +
								'</button>' +
							'</form>' +
							'<form action="request_application_progress_details_advance" method="post" class="d-inline">' +
								'<input type="hidden" name="case_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="transaction_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="job_number" value="' + this.job_number + '">' +
								'<input type="hidden" name="review_type" value="GeneralWorkRequest">' +
								'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">' +
								'<button type="submit" name="save" class="btn btn-icon btn-sm me-1 btn-outline-danger btn-wave waves-effect waves-light to_hide_on_level_1">' +
									'<i class="fas fa-folder-open"></i>' +
								'</button>' +
							'</form>' +
						'</div>'
					]).draw(false);
					
					datatable.column(2).data().sort();

				});

				highlightActiveCard(inbox_type);

				// Reinitialize tooltips after a brief delay
				setTimeout(function() {
					window.initializeTooltips();
				}, 50);

				if (localStorage.getItem('user_level') < 2) {
					// $('th:nth-child(8),
					// th:nth-child(8)').hide();
					// $('.to_hide_on_level_1').hide();
					datatable.column(11).visible(false);

				}

			}

		});

	};

	function removeAllActiveStates() {
    	// Remove all light background classes
		$("#body-bg-1, #body-bg-2, #body-bg-4, #body-bg-5, #body-bg-6, #body-bg-7")
			.removeClass('bg-primary-light bg-danger-light bg-warning-light bg-info-light bg-success-light bg-secondary-light');
		
		// Reset text colors (optional - keep text as is)
		$("#number-text-1, #number-text-2, #number-text-4, #number-text-5, #number-text-6, #number-text-7")
			.removeClass('text-white');
		
		// Remove active class from all cards
		$('.dashboard-main-card').removeClass('active-card');
	}

	function highlightActiveCard(inbox_type) {
		switch (inbox_type) {
			case 1: // Incoming Files - Primary
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-1").addClass('bg-primary-light');
				$("#number-text-1").addClass('text-white');
				$("#card-incoming").addClass('active-card');
				break;
			case 2: // Queried - Danger
				$(".btn-to-be-disabled").prop('disabled', false);
				$("#body-bg-2").addClass('bg-danger-light');
				$("#number-text-2").addClass('text-white');
				$("#card-queried").addClass('active-card');
				break;
			case 4: // Awaiting Payments - Warning
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-4").addClass('bg-warning-light');
				$("#number-text-4").addClass('text-white');
				$("#card-awaiting_payments").addClass('active-card');
				break;
			case 5: // Awaiting Request - Info
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-5").addClass('bg-info-light');
				$("#number-text-5").addClass('text-white');
				$("#card-awaiting_request").addClass('active-card');
				break;
			case 6: // Request Completed - Success
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-6").addClass('bg-success-light');
				$("#number-text-6").addClass('text-white');
				$("#card-request_completed").addClass('active-card');
				break;
			case 7: // Attention Required - Secondary
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-7").addClass('bg-secondary-light');
				$("#number-text-7").addClass('text-white');
				$("#card-attention_required").addClass('active-card');
				break;
			default:
				// No card selected
		}
	}

	function formatDate(dateString) {
		if (!dateString) return 'N/A';
		const date = new Date(dateString);
		return date.toLocaleDateString('en-US', { 
			year: 'numeric', 
			month: 'short', 
			day: 'numeric' 
		});
    }


					let queriesDatatable = null;

$("#btn_load_resolved_queries").on("click", function(e) {
    e.preventDefault();
    loadRespondedQueries();
});

// Function to load responded queries
function loadRespondedQueries() {

	const modalEl = document.getElementById('respondedQueriesModal');

    // 1️⃣ Check if instance already exists
    let bsModal = bootstrap.Modal.getInstance(modalEl);

    if (bsModal) {
        // 2️⃣ Kill existing modal completely
        bsModal.hide();
        bsModal.dispose();
    }

    // 3️⃣ Create a fresh modal instance
    bsModal = new bootstrap.Modal(modalEl, {
        backdrop: 'static',
        keyboard: false
    });

    // 4️⃣ Open modal
    bsModal.show();
    
    // Show loading state
    $('#loadingQueries').show();
    $('#emptyQueries').hide();
    $('#tbl_responded_queries_result').closest('.table-responsive').show();
    
    // Load data
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'load_responded_queried_applications_at_unit'
        },
        success: function(jobdetails) {
            try {
                const json_p = JSON.parse(jobdetails);
                
                // Hide loading
                $('#loadingQueries').hide();
                
                if (json_p.data && json_p.data.length > 0) {
                    // Process data
                    const dataSet = processRespondedQueriesData(json_p.data);
                    
                    // Initialize or update DataTable
                    initializeRespondedQueriesTable(dataSet);
                    
                    // Update query count
                    $('#queryCount').text(`${dataSet.length} queries`);
                    
                    // Show table
                    $('#tbl_responded_queries_result').closest('.table-responsive').show();
                    $('#emptyQueries').hide();
                } else {
                    // Show empty state
                    $('#tbl_responded_queries_result').closest('.table-responsive').hide();
                    $('#emptyQueries').show();
                    $('#queryCount').text('0 queries');
                }
                
                // Show modal
                bsModal.show();
                
            } catch (e) {
                console.error('Error processing queries data:', e);
                $('#loadingQueries').hide();
                $('#emptyQueries').show();
                
                Swal.fire({
                    title: 'Error',
                    text: 'Failed to load responded queries',
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', error);
            $('#loadingQueries').hide();
            $('#emptyQueries').show();
            
            Swal.fire({
                title: 'Connection Error',
                text: 'Unable to load data. Please check your connection.',
                icon: 'error',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
            });
        }
    });
}

// Process responded queries data
function processRespondedQueriesData(data) {
    return data.map(function(item) {
        return {
            // For DataTable display
            checkbox: '<div class="form-check"><input class="form-check-input row-checkbox" type="checkbox" value="' + item.job_number + '"></div>',
            job_number: item.job_number || 'N/A',
            ar_name: item.ar_name || 'N/A',
            business_process_sub_name: item.business_process_sub_name || 'N/A',
            locality: item.locality || 'N/A',
            modified_by: item.modified_by || 'N/A',
            actions: createQueryActions(item),
            
            // Additional data for actions
            _transaction_number: item.transaction_number,
            _qid: item.qid,
            _reasons: item.reasons,
            _remarks: item.remarks,
            _status: item.status,
            _query_response: item.query_response,
            _created_by: item.created_by,
            _created_date: item.created_date,
            _modified_date: item.modified_date,
            _query_general_reason: item.query_general_reason,
            _attachment_required: item.attachment_required
        };
    });
}

// Create action buttons for queries
function createQueryActions(item) {
    return `
        <div class="action-btn-group">
            <!-- Add to Batch Button -->
            <button type="button" class="btn btn-sm btn-outline-primary add-to-batch"
                    data-bs-toggle="modal" data-bs-target="#askForPurposeOfBatching"
                    data-job_number="${item.job_number}"
                    data-ar_name="${item.ar_name}"
                    data-business_process_sub_name="${item.business_process_sub_name}">
                <i class="ri-list-check"></i>
            </button>
            
            <!-- View/Edit Query Button -->
            <button type="button" class="btn btn-sm btn-outline-info edit-query"
                    data-bs-toggle="modal" data-bs-target="#newQueryModal"
                    data-action="edit"
                    data-id="${item.qid}"
                    data-job_number="${item.job_number}"
					data-case_number="${item.case_number}"
                    data-reasons="${item.reasons || ''}"
                    data-remarks="${item.remarks || ''}"
                    data-status="${item.status || ''}"
                    data-query_response="${item.query_response || ''}"
                    data-created_by="${item.created_by || ''}"
                    data-created_date="${item.created_date || ''}"
                    data-modified_by="${item.modified_by || ''}"
                    data-modified_date="${item.modified_date || ''}"
                    data-general_reason="${item.query_general_reason || ''}"
                    data-attachment_required="${item.attachment_required || ''}">
                <i class="ri-edit-line"></i>
            </button>
            
            <!-- Work Button -->
            <form action="registration_application_progress_details" method="post" class="d-inline">
                <input type="hidden" name="case_number" value="${item.transaction_number}">
                <input type="hidden" name="transaction_number" value="${item.transaction_number}">
                <input type="hidden" name="job_number" value="${item.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${item.business_process_sub_name}">
                <button type="submit" name="save" class="btn btn-sm btn-outline-danger">
                    <i class="ri-folder-open-line"></i>
                </button>
            </form>
        </div>
    `;
}

// Initialize DataTable for responded queries
function initializeRespondedQueriesTable(dataSet) {
    
    // Initialize DataTable
    $('#tbl_responded_queries_result').DataTable({
        data: dataSet,
        destroy: true, // This is the key - destroys previous instance
        responsive: true,
        dom: "<'row'<'col-sm-12'tr>>" +
             "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        columns: [
            { 
                data: 'checkbox',
                orderable: false,
                searchable: false,
                className: 'text-center'
            },
            { 
                data: 'job_number',
                render: function(data) {
                    return `<span class="fw-medium text-primary">${data}</span>`;
                }
            },
            { 
                data: 'ar_name',
                render: function(data) {
                    return `<span class="small">${data}</span>`;
                }
            },
            { 
                data: 'business_process_sub_name',
                render: function(data) {
                    return `<span class="small">${data}</span>`;
                }
            },
            { 
                data: 'locality',
                render: function(data) {
                    return `<span class="small">${data}</span>`;
                }
            },
            { 
                data: 'modified_by',
                render: function(data) {
                    return `<span class="small text-muted">${data}</span>`;
                }
            },
            { 
                data: 'actions',
                orderable: false,
                searchable: false,
                className: 'text-center'
            }
        ],
        order: [[1, 'asc']], // Sort by job number
        pageLength: 10,
        language: {
            emptyTable: "No responded queries found",
            info: "Showing _START_ to _END_ of _TOTAL_ queries",
            infoEmpty: "Showing 0 to 0 of 0 queries",
            infoFiltered: "(filtered from _MAX_ total queries)",
            lengthMenu: "Show _MENU_ queries",
            loadingRecords: "Loading...",
            processing: "Processing...",
            search: "",
            searchPlaceholder: "Search queries...",
            zeroRecords: "No matching queries found",
            paginate: {
                first: '<i class="ri-arrow-left-s-line"></i>',
                last: '<i class="ri-arrow-right-s-line"></i>',
                next: '<i class="ri-arrow-right-s-line"></i>',
                previous: '<i class="ri-arrow-left-s-line"></i>'
            }
        },
        initComplete: function() {
            // Add search functionality
            $('#searchQueries').on('keyup', function() {
                queriesDatatable.search(this.value).draw();
            });
            
            // Initialize select all checkbox
            initializeCheckboxSelection();
        },
        drawCallback: function() {
            // Reinitialize checkbox selection after draw
            initializeCheckboxSelection();
        }
    });
}

// Initialize checkbox selection
function initializeCheckboxSelection() {
    // Select all checkbox
    $('#selectAllCheckbox').off('change').on('change', function() {
        const isChecked = $(this).is(':checked');
        $('.row-checkbox').prop('checked', isChecked);
        updateBatchButtonState();
    });
    
    // Individual row checkboxes
    $('.row-checkbox').off('change').on('change', function() {
        updateSelectAllCheckbox();
        updateBatchButtonState();
    });
}

// Update select all checkbox state
function updateSelectAllCheckbox() {
    const totalCheckboxes = $('.row-checkbox').length;
    const checkedCheckboxes = $('.row-checkbox:checked').length;
    
    if (checkedCheckboxes === 0) {
        $('#selectAllCheckbox').prop('checked', false);
        $('#selectAllCheckbox').prop('indeterminate', false);
    } else if (checkedCheckboxes === totalCheckboxes) {
        $('#selectAllCheckbox').prop('checked', true);
        $('#selectAllCheckbox').prop('indeterminate', false);
    } else {
        $('#selectAllCheckbox').prop('checked', false);
        $('#selectAllCheckbox').prop('indeterminate', true);
    }
}

// Update batch button state
function updateBatchButtonState() {
    const checkedCount = $('.row-checkbox:checked').length;
    const $batchBtn = $('#btnBatchSelected');
    
    if (checkedCount > 0) {
        $batchBtn.removeClass('btn-outline-success').addClass('btn-success');
        $batchBtn.html(`<i class="ri-list-check-2 me-1"></i>Batch Selected (${checkedCount})`);
    } else {
        $batchBtn.removeClass('btn-success').addClass('btn-outline-success');
        $batchBtn.html('<i class="ri-list-check-2 me-1"></i>Batch Selected');
    }
}

// Event handlers
$(document).on('click', '#btnSelectAll', function() {
    $('#selectAllCheckbox').trigger('click');
});

$(document).on('click', '#btnBatchSelected', function() {
    const selectedJobs = [];
    $('.row-checkbox:checked').each(function() {
        selectedJobs.push($(this).val());
    });
    
    if (selectedJobs.length === 0) {
        Swal.fire({
            title: 'No Selection',
            text: 'Please select at least one application to batch',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return;
    }
    
    // Open batch modal with selected jobs
    openBatchModalForSelected(selectedJobs);
});

$(document).on('click', '#btnExportData', function() {
    if (queriesDatatable) {
        queriesDatatable.button('.buttons-excel').trigger();
    }
});

$(document).on('click', '#btnRefreshQueries', function() {
    loadRespondedQueries();
});

// Function to open batch modal for selected jobs
function openBatchModalForSelected(jobNumbers) {
    if (jobNumbers.length === 0) return;
    
    // Show confirmation
    Swal.fire({
        title: 'Batch Selected Applications',
        html: `You are about to batch <strong>${jobNumbers.length}</strong> selected applications.<br><br>
               <div class="text-start small">
                   <strong>Selected Jobs:</strong><br>
                   ${jobNumbers.slice(0, 5).map(job => `• ${job}`).join('<br>')}
                   ${jobNumbers.length > 5 ? `<br>... and ${jobNumbers.length - 5} more` : ''}
               </div>`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Continue to Batch',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#0d6efd',
        cancelButtonColor: '#6c757d',
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // Open the batch modal
            $('#askForPurposeOfBatching').modal('show');
            
            // You might want to store the selected job numbers in a global variable
            // or data attribute for the batch modal to use
            $('#askForPurposeOfBatching').data('selectedJobs', jobNumbers);
        }
    });
}

// Clean up when modal closes
$('#respondedQueriesModal').on('hidden.bs.modal', function() {
    // Reset checkboxes
    $('#selectAllCheckbox').prop('checked', false).prop('indeterminate', false);
    $('.row-checkbox').prop('checked', false);
    
    // Clear search
    $('#searchQueries').val('');
    
    // Reset batch button
    $('#btnBatchSelected').removeClass('btn-success').addClass('btn-outline-success')
        .html('<i class="ri-list-check-2 me-1"></i>Batch Selected');
});

					$('#incoming_advanced_search').on('hidden.bs.modal', function(e){
						$('#adv_inbox_type').val('')
					})

					
					$('#incoming_advanced_search').on('shown.bs.modal', function(e){

						function CallA(){

							var inbox_type = $('#adv_inbox_type').val() == '' ? '5' : $('#adv_inbox_type').val();
							//console.log(inbox_type)
							if(inbox_type == '5'){
								$('#adv_status').val('All');
								$('.exclude_all').addClass('d-none')
								//$("#adv_filter_type_1").prop("checked", true);
								document.getElementById('adv_filter_type_1').click();
							}

							$.ajax({
								type : "POST",
								url : "Case_Management_Serv",
								data : {
									request_type : 'load_sub_process_application_type_for_adv_filter',
									inbox_type : inbox_type == '5' ? '1' : inbox_type +  '_false',
								},
	
								success : function(jobdetails) {
									// console.log(jobdetails)

									if(!jobdetails){
										return;
									}

									var json_p = JSON.parse(jobdetails);
	
									var select = $("#adv_application_type");
									select.empty();
									select
											.append(new Option(
													"-- Select --",
													0));
	
									$(json_p).each(function() {
														
										select.append('<option value="'
												+ this.business_process_sub_id
												+ '">'
												+ this.business_process_sub_name
												+ '</option>');
									});
								}
	
							})

							CallB()
						}

						function CallB(){
							
							$.ajax({
								type: "POST",
								url: "app_modal_fills_serv",
								data: {
									   request_type: 'tags_for_batching_jobs_list'},
								cache: false,
								beforeSend: function () {
								   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
								},
								success: function(jobdetails) {
								   
									
									   //console.log(jobdetails);
									   var json_p = JSON.parse(jobdetails);
									   var options = $("#adv_job_purpose");
		   
									   options.empty();
									   options.append(new Option("-- Select --", 0));
		
									
									   $(json_p).each(function () {
		   
											 $('#adv_job_purpose').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');
											
										  });  
									}
								});
						}

						CallA()

					})


					// $('#btn_load_adv_filter').on('click', function(e) {

					// 	var adv_filter;

					// 	var adv_job_number = $('#adv_job_number').val()
					// 	var adv_application_type = $('#adv_application_type').val()
					// 	var adv_limit = $('#adv_limit').val()
					// 	var adv_from_date = $('#adv_from_date').val()
					// 	var adv_to_date = $('#adv_to_date').val()
					// 	var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					// 	var enq_search_type = "";

					// 	var inbox_type = $(this).data('id');

					// 	if(adv_job_number != ""){
					// 		//$('#adv_job_number').css('border-color', 'green');
					// 		if (selected_rbtn.length > 0) {
					// 			enq_search_type = selected_rbtn.val();
					// 			//console.log("selected " + enq_search_type);
					// 		}

					// 		if (enq_search_type.length <= 0){
					// 			$.notify({
					// 				message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
					// 			}, { type : 'danger' , z_index: 9999  });

					// 			alert('Please select the type of field for your search');

					// 			return;
								
					// 		}

					// 		adv_limit = 1000;
					// 	}

					// 	if(!adv_limit){
					// 		$.notify({
					// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter the limit.</span>',
					// 		}, { type : 'danger' , z_index: 9999  });

					// 		alert('Please enter the limit.');

					// 		return;
							
					// 	}

					// 	// if(adv_job_number || adv_application_type == "0" || !adv_from_date || !adv_to_date) {
					// 	// 	adv_filter = "adv_filter_1"
						
					// 	// } else if(!adv_job_number || adv_application_type == "0" || !adv_from_date || !adv_to_date){
					// 	// 	adv_filter = "adv_filter_2"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}

					// 	// } else if(!adv_job_number || adv_application_type != "0" || adv_from_date || adv_to_date){
					// 	// 	adv_filter = "adv_filter_5"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}

					// 	// } else if(!adv_job_number || adv_application_type != "0" || !adv_from_date || !adv_to_date){
					// 	// 	adv_filter = "adv_filter_6"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}
					// 	// } else if(!adv_job_number || adv_application_type != "0" || adv_from_date || adv_to_date){
					// 	// 	adv_filter = "adv_filter_7"

					// 	// 	if(adv_limit > 1000){
					// 	// 		$.notify({
					// 	// 			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 	// 		}, { type : 'danger' , z_index: 9999  });
	
					// 	// 		return;
					// 	// 	}
					// 	// }

					// 	if(adv_application_type != "0" || !adv_from_date || !adv_to_date){
					// 		adv_filter = "adv_filter_6"

					// 		if(adv_limit > 1000){
					// 			$.notify({
					// 				message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 			}, { type : 'danger' , z_index: 9999  });

					// 			alert('Limit should not be more than 1000.');
	
					// 			return;
					// 		}
					// 	} else if(adv_application_type == "0" || !adv_from_date || !adv_to_date){
					// 		adv_filter = "adv_filter_6"

					// 		if(adv_limit > 1000){
					// 			$.notify({
					// 				message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Limit should not be more than 1000.</span>',
					// 			}, { type : 'danger' , z_index: 9999  });

					// 			alert('Limit should not be more than 1000.');
	
					// 			return;
					// 		}
					// 	}

					// 	//console.log(adv_filter, adv_job_number, adv_application_type, adv_from_date, adv_to_date,adv_limit );

					// 	$.ajax({
					// 		type : "POST",
					// 		url : "Case_Management_Serv",
					// 		data : {
					// 			request_type : 'load_incoming_app_for_unit_using_adv_filter',
					// 			adv_filter : adv_filter,
					// 			adv_job_number: adv_job_number,
					// 			adv_application_type: adv_application_type,
					// 			adv_from_date: adv_from_date == '' ? '12-12-2000' : adv_from_date,
					// 			adv_to_date: adv_to_date == '' ? '12-12-2000' : adv_to_date,
					// 			adv_limit: adv_limit,
					// 			enq_search_type: enq_search_type,
					// 			inbox_type: inbox_type + '_false',
					// 		},

					// 		success : function(
					// 			jobdetails) {
							
					// 		// console.log(jobdetails);
					// 		var json_p = JSON
					// 				.parse(jobdetails);


					// 		/*
					// 		 * $('th:nth-child(7)').show();
					// 		 * $('th:nth-child(8)').show();
					// 		 */

					// 		datatable.column(0)
					// 				.visible(false);
					// 		// datatable.column(1).visible(false);

							
					// 		datatable.column(0).visible(false);
					// 		//datatable.column(1).visible(false);

					// 		datatable.search("")
					// 				.draw();
					// 		datatable.state.clear();
					// 		datatable.clear();

					// 		$("#body-bg-1")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-1")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-1")
					// 				.addClass(
					// 						'text-gray-800');
					// 		$("#body-bg-2")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-2")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-2")
					// 				.addClass(
					// 						'text-gray-800');
					// 		$("#body-bg-3")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-3")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-3")
					// 				.addClass(
					// 						'text-gray-800');
					// 		$("#body-bg-4")
					// 				.removeClass(
					// 						'bg-dark');
					// 		$("#number-text-4")
					// 				.removeClass(
					// 						'text-white');
					// 		$("#number-text-4")
					// 				.addClass(
					// 						'text-gray-800');

					// 		$(json_p.data)
					// 				.each(
					// 						function() {

					// 							datatable.row
					// 									.add([

					// 										this.job_worked_on_status,

					// 										'<input type="checkbox"/>',
					// 										this.created_date,
					// 										this.job_number,
					// 										this.ar_name,
					// 										this.business_process_sub_name,
					// 										this.job_status,
					// 										this.job_forwarded_by,
					// 										this.locality,
					// 										this.smd_type_of_plotting,

					// 										'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
					// 												+ this.job_number
					// 												+ '" data-job_number="'
					// 												+ this.job_number
					// 												+ '" data-ar_name="'
					// 												+ this.ar_name
					// 												+ '" data-business_process_sub_name="'
					// 												+ this.business_process_sub_name
					// 												+ '" data-application_stage="'
					// 												+ this.application_stage
					// 												+ '" data-application_stage_name="'
					// 												+ this.application_stage_name
					// 												+ '" data-application_stage_baby_step="'
					// 												+ this.application_stage_baby_step
					// 												+ '" data-application_stage_name_baby_step="'
					// 												+ this.application_stage_name_baby_step
					// 												+ '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
					// 												+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
					// 												+ ' </button>',

					// 										'<form action="front_office_view_application" method="post">'
					// 												+ '<input type="hidden" name="case_number" id="case_number" value="'
					// 												+ this.transaction_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="search_text" id="search_text" value="'
					// 												+ this.case_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="job_number" id="job_number" value="'
					// 												+ this.job_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
					// 												+ this.business_process_sub_name
					// 												+ '">'

					// 												+ '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'

					// 												+ '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
					// 												+ '	</button></form>',

					// 												'<form action="registration_application_progress_details" method="post">'
					// 												+ '<input type="hidden" name="case_number" id="case_number" value="'
					// 												+ this.transaction_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="transaction_number" id="transaction_number" value="'
					// 												+ this.transaction_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="job_number" id="job_number" value="'
					// 												+ this.job_number
					// 												+ '">'
					// 												+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
					// 												+ this.business_process_sub_name
					// 												+ '">'

					// 												+ '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

					// 												+ '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
					// 												+ '	</button></form>'

					// 											])
					// 									.draw(
					// 											false);
					// 							datatable
					// 									.column(
					// 											2)
					// 									.data()
					// 									.sort();

					// 						});

					// 		switch (inbox_type) {
					// 		case 1:

					// 			$(".btn-to-be-disabled").prop('disabled',true);
					// 			datatable.column(11).visible(true);

					// 			$("#body-bg-1")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-1")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-1")
					// 					.addClass(
					// 							'text-white');

					// 			break;
					// 		case 2:

					// 			$(
					// 					".btn-to-be-disabled")
					// 					.prop(
					// 							'disabled',
					// 							false);

					// 			$("#body-bg-2")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-2")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-2")
					// 					.addClass(
					// 							'text-white');
					// 			datatable.column(11).visible(true);

					// 			break;
					// 		case 3:
					// 			$(
					// 					".btn-to-be-disabled")
					// 					.prop(
					// 							'disabled',
					// 							false);

					// 			$("#body-bg-3")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-3")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-3")
					// 					.addClass(
					// 							'text-white');
					// 			datatable.column(11).visible(true);
					// 			break;
					// 		case 4:
					// 			$(
					// 					".btn-to-be-disabled")
					// 					.prop(
					// 							'disabled',
					// 							true);
					// 			datatable
					// 					.column(11)
					// 					.visible(
					// 							false);

					// 			$("#body-bg-4")
					// 					.addClass(
					// 							'bg-dark');
					// 			$("#number-text-4")
					// 					.removeClass(
					// 							'text-gray-800');
					// 			$("#number-text-4")
					// 					.addClass(
					// 							'text-white');
					// 			break;
					// 		default:
					// 			// code block
					// 		}

					// 		if (localStorage
					// 				.getItem('user_level') < 2) {
					// 			// $('th:nth-child(8),
					// 			// th:nth-child(8)').hide();
					// 			// $('.to_hide_on_level_1').hide();
					// 			datatable
					// 					.column(11)
					// 					.visible(
					// 							false);

					// 		}

					// 	}

					// 	})
					// })

					$('#rbtn_search_type1').on('click', function(e){

					})

				});