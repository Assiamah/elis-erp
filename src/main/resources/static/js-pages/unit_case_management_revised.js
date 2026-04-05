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
		var req_8 = $('#req_inp_8').val();
		var awa_9 = $('#awa_insp_9').val();
		var awa_10 = $('#awa_pub_10').val();
		

		datatable.search("").draw();
		datatable.state.clear();
		datatable.clear();

		//console.log(inc_1, com_3, que_2, awa_4)

		switch (parseInt(inbox_type)) {
			case 1:

				$(".officerInd").text("Sent By");

				if(inc_1 > 500) {

					$('#adv_inbox_type').val(inbox_type);

					if(inbox_type == 1){
						$('#adv_status').text('Incoming Files');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 2) {
						$('#adv_status').text('Queried');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 3) {
						$('#adv_status').val('Completed Within Unit');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 4) {
						$('#adv_status').text('Awaiting Payment');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 5) {
						$('#adv_status').text('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').text('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').text('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').text('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').text('Awaiting Inspection');
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

				$(".officerInd").text("Sent By");

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
					} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
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

				$(".officerInd").text("Queried By");

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
					} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
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
				$(".officerInd").text("Assessed By");
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
					} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
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

				$(".officerInd").text("Assigned To");

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
					} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
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
				$(".officerInd").text("Completed By");
				// console.log("Completed By");
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
					} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
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
				$(".officerInd").text("Assigned To");
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
					} else if(inbox_type == 5) {
						$('#adv_status').val('Awaiting Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 6) {
						$('#adv_status').val('Completed Request');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 7) {
						$('#adv_status').val('Attention Required');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}

			case 8:
				$(".officerInd").text("Requested By");
				if(req_8 > 500) {

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
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');

					return;

				} else {

					LoadUnitApplications(inbox_type)
				}

			case 9:
				$(".officerInd").text("Requested By");
				if(awa_9 > 500) {

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
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
						$('.exclude_all').removeClass('d-none');
					} else {
						$('#adv_status').val('All');
					}

					$("#incoming_advanced_search").modal('show');
				} else {

					LoadUnitApplications(inbox_type)
				}

			case 10:
				$(".officerInd").text("Sent By");
				if(awa_10 > 500) {

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
					} else if(inbox_type == 8) {
						$('#adv_status').val('Request for Additional Input');
						$('.exclude_all').removeClass('d-none');
					} else if(inbox_type == 9) {
						$('#adv_status').val('Awaiting Inspection');
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
		} else if(adv_search_type == 'f_batch_list') {
			$('.exclude_batch_list').addClass('d-none');
			$('.include_batch_list').removeClass('d-none');
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
		var enq_search_type = adv_search_type == 'f_job_number' ? "job_number" : "batch_list_number";
		var adv_job_purpose = $('#adv_job_purpose').val()
		var adv_sorting = $('#adv_sorting').val()
		var adv_batch_list_number = $('#adv_batch_list_number').val()

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
		} else if(adv_search_type == 'f_batch_list') {

			inbox_type = '0';

			if(!adv_batch_list_number) {
				// $.notify({
				// 	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter a job number</span>',
				// }, { type : 'danger' , z_index: 9999  });

				// alert('Please enter a job number');

				swal.fire({
					title: 'Ops!',
					text: 'Please enter a batch list number',
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
				adv_search_type : adv_search_type,
				adv_batch_list_number : adv_batch_list_number
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
							'<form action="request_application_progress_details_ai" method="post" class="d-inline">' +
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
					//datatable.column(11).visible(false);

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

				if(inbox_type == 1) {
					$(".officerInd").text("Sent By");
				} else if(inbox_type == 2) {
					$(".officerInd").text("Queried By");
				} else if(inbox_type == 3) {
					$(".officerInd").text("Sent By");
				} else if(inbox_type == 4) {
					$(".officerInd").text("Assessed By");
				} else if(inbox_type == 5) {
					$(".officerInd").text("Assigned To");
				} else if(inbox_type == 6) {
					$(".officerInd").text("Completed By");
				} else if(inbox_type == 7) {
					$(".officerInd").text("Assigned To");
				} else if(inbox_type == 8) {
					$(".officerInd").text("Requested By");
				} else if(inbox_type == 9) {
					$(".officerInd").text("Requested By");
				} else if(inbox_type == 10) {
					$(".officerInd").text("Sent By");
				}

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

				// console.log(json_p.data);


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
						'<span data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" data-bs-placement="top" title="' + ((inbox_type == 6 || inbox_type == 1 || inbox_type == 5) ? this.job_purpose || '' : this.job_status || '') + '" >' +
							(((inbox_type == 6 || inbox_type == 1 || inbox_type == 5) ? this.job_purpose || '' : this.job_status || '').length > 30 ? ((inbox_type == 6 || inbox_type == 1 || inbox_type == 5) ? this.job_purpose || '' : this.job_status || '').substring(0, 30) + '...' : ((inbox_type == 6 || inbox_type == 1 || inbox_type == 5) ? this.job_purpose || '' : this.job_status || '')) +
						'</span>' +
						((this.objections || 0) > 0 ? '<i class="fas fa-exclamation-circle ml-1 text-danger" data-toggle="tooltip" title="Has Objections"></i>' : ''),

						// 6: Sent By
						'<span class="small">' + (inbox_type == 5 ? this.job_recieved_by || '' : this.job_forwarded_by || '') + '</span>',

						// 7: Locality
						'<span class="small">' + (this.locality || '') + '</span>',

						// 8: Type of Plotting
						'<span class="small">' + (this.plotting_type || this.smd_type_of_plotting || '') + '</span>',

						
						// 9: Actions
						'<div class="d-flex justify-content-center">' +
						'<button class="btn btn-icon btn-sm me-1 btn-outline-success btn-wave waves-effect waves-light btn-view-milestone" ' +
							'id="btnAddToBatchlist-' + this.job_number + '" ' +
							'data-job_number="' + this.job_number + '" ' +
							'data-ar_name="' + this.ar_name + '" ' +
							'data-business_process_sub_name="' + this.business_process_sub_name + '" ' +
							'data-application_stage="' + this.application_stage + '" ' +
							'data-application_stage_name="' + this.application_stage_name + '" ' +
							'data-application_stage_baby_step="' + this.application_stage_baby_step + '" ' +
							'data-application_stage_name_baby_step="' + this.application_stage_name_baby_step + '" ' +
							'data-bs-custom-class="tooltip-primary" title="View Milestone" data-bs-toggle="tooltip">' +
							'<i class="fas fa-list"></i>' +
						'</button>' +
						// (inbox_type == 9 ? 
						// '<button class="btn btn-icon btn-sm me-1 btn-warning btn-wave waves-effect waves-light btn_send_request" ' +
						// 		'id="btnAddToBatchlist-' + this.job_number + '" ' +
						// 		'data-job_number="' + this.job_number + '" ' +
						// 		'data-ar_name="' + this.ar_name + '" ' +
						// 		'data-business_process_sub_name="' + this.business_process_sub_name + '" ' +
						// 		'data-application_stage="' + this.application_stage + '" ' +
						// 		'data-locality="' + this.locality + '" ' +
						// 		'data-application_stage_name="' + this.application_stage_name + '" ' +
						// 		'data-application_stage_baby_step="' + this.application_stage_baby_step + '" ' +
						// 		'data-application_stage_name_baby_step="' + this.application_stage_name_baby_step + '" ' +
						// 		'data-bs-custom-class="tooltip-primary" title="Send Request" data-bs-toggle="tooltip">' +
						// 		'<i class="fas fa-paper-plane"></i>' +
						// 	'</button>' :
							'<div data-bs-custom-class="tooltip-primary" title="Add to Batch" data-bs-toggle="tooltip" ><button class="btn btn-icon btn-sm me-1 btn-outline-info btn-wave waves-effect waves-light btn-add-batch" ' +
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
							'</button></div>' +
						//)+
							'<form action="front_office_view_application" method="post" class="d-inline">' +
								'<input type="hidden" name="case_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="search_text" value="' + this.case_number + '">' +
								'<input type="hidden" name="job_number" value="' + this.job_number + '">' +
								'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">' +
								'<button type="submit" name="save" class="btn btn-icon btn-sm me-1 btn-outline-primary btn-wave waves-effect waves-light" data-bs-custom-class="tooltip-primary" title="View Application" data-bs-toggle="tooltip">' +
									'<i class="fas fa-eye"></i>' +
								'</button>' +
							'</form>' +
							(inbox_type == 6 ? 
							'<form action="request_application_progress_details_ai" method="post" class="d-inline">' +
								'<input type="hidden" name="case_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="transaction_number" value="' + this.transaction_number + '">' +
								'<input type="hidden" name="job_number" value="' + this.job_number + '">' +
								'<input type="hidden" name="review_type" value="GeneralWorkRequest">' +
								'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name + '">' +
								'<button type="submit" name="save" class="btn btn-icon btn-sm me-1 btn-outline-danger btn-wave waves-effect waves-light to_hide_on_level_1" data-bs-custom-class="tooltip-primary" title="Work" data-bs-toggle="tooltip">' +
									'<i class="fas fa-folder-open"></i>' +
								'</button>' +
							'</form>' : '' )+
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
					//datatable.column(11).visible(false);

				}

			}

		});

	};

	$(document).on('click', '.btn-view-milestone', function(e) {
        e.preventDefault();
        
        const jobNumber = $(this).data('job_number');
        const caseNumber = $(this).data('case_number') || 'N/A';
        
        // Store job info in modal
        $('#modalJobNumber').text(`Job: ${jobNumber}`);
        $('#modalCaseNumber').text(`Case: ${caseNumber}`);
        // $('#lastUpdatedTime').text(new Date().toLocaleString());
        
        // Show modal with loading state
        const modal = new bootstrap.Modal(document.getElementById('milestoneDetailsModal'));
        modal.show();
        
        // Show loading skeleton, hide containers
        $('#loadingSkeleton').show();
        $('#milestonesContainer').empty().hide();
        $('#noDataMessage').hide();
        $('#milestoneStatsContainer').empty();
        $('#overallProgressContainer').empty();
        
        // Make AJAX call
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'select_load_current_milestone_details',
                job_number: jobNumber,
            },
            cache: false,
            dataType: 'json',
            success: function(response) {
                console.log('Milestone Data:', response);
                
                // Hide loading skeleton
                $('#loadingSkeleton').hide();
                
                // Parse response if needed
                const milestoneData = (typeof response === 'string') ? JSON.parse(response) : response;
                
                // Check if data exists
                if (!milestoneData || milestoneData.length === 0) {
                    $('#noDataMessage').show();
                    return;
                }
                
                // Process and display milestones
                displayMilestoneData(milestoneData);
            },
            error: function(xhr, status, error) {
                console.error('Error loading milestone data:', error);
                
                // Hide loading skeleton
                $('#loadingSkeleton').hide();
                
                // Show error message
                Swal.fire({
                    title: 'Error',
                    html: `<div class="text-center">
                            <i class="fas fa-exclamation-circle text-danger fa-3x mb-3"></i>
                            <p>Failed to load milestone details</p>
                            <p class="text-muted small">${error}</p>
                        </div>`,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545',
                    background: 'white'
                });
                
                $('#noDataMessage').show();
            }
        });
    });
    
    // Function to display milestone data
    function displayMilestoneData(milestones) {
        
        // Calculate overall statistics
        const stats = calculateStats(milestones);
        
        // Render stats cards
        renderStatsCards(stats);
        
        // Render overall progress bar
        renderOverallProgress(stats);
        
        // Clear and render milestones container
        const container = $('#milestonesContainer');
        container.empty().show();
        
        // Loop through each milestone
        milestones.forEach((milestone, index) => {
            const milestoneHtml = renderMilestone(milestone, index);
            container.append(milestoneHtml);
        });
        
        // Initialize tooltips for new content
        initializeTooltips();
    }
    
    // Function to determine milestone status based on baby steps
	function determineMilestoneStatus(babySteps) {
		if (!babySteps || babySteps.length === 0) return 'Pending';
		
		const steps = babySteps || [];
		const totalSteps = steps.length;
		const completedSteps = steps.filter(s => s.bse_status === 'Completed').length;
		const ongoingSteps = steps.filter(s => s.bse_status === 'Ongoing').length;
		
		// If all steps are completed
		if (completedSteps === totalSteps) {
			return 'Completed';
		}
		
		// If any step is ongoing
		if (ongoingSteps > 0) {
			return 'Ongoing';
		}
		
		// If no steps are ongoing and not all are completed
		return 'Pending';
	}

	// Update the stats calculation function
	function calculateStats(milestones) {
		let totalBabySteps = 0;
		let completedSteps = 0;
		let ongoingSteps = 0;
		let pendingSteps = 0;
		
		let completedMilestones = 0;
		let ongoingMilestones = 0;
		let pendingMilestones = 0;
		
		milestones.forEach(milestone => {
			// Determine milestone status based on baby steps
			const milestoneStatus = determineMilestoneStatus(milestone.baby_steps);
			
			// Count milestone statuses
			if (milestoneStatus === 'Completed') completedMilestones++;
			else if (milestoneStatus === 'Ongoing') ongoingMilestones++;
			else pendingMilestones++;
			
			// Count baby steps
			if (milestone.baby_steps && Array.isArray(milestone.baby_steps)) {
				milestone.baby_steps.forEach(step => {
					totalBabySteps++;
					
					switch(step.bse_status) {
						case 'Completed':
							completedSteps++;
							break;
						case 'Ongoing':
							ongoingSteps++;
							break;
						case 'Pending':
							pendingSteps++;
							break;
					}
				});
			}
		});
		
		const overallProgress = totalBabySteps > 0 ? Math.round((completedSteps / totalBabySteps) * 100) : 0;
		
		return {
			totalMilestones: milestones.length,
			completedMilestones,
			ongoingMilestones,
			pendingMilestones,
			totalBabySteps,
			completedSteps,
			ongoingSteps,
			pendingSteps,
			overallProgress
		};
	}
    
    // Function to render stats cards
    function renderStatsCards(stats) {
        const container = $('#milestoneStatsContainer');
        
        const html = `
            <div class="col-md-3">
                <div class="card border-0 shadow-sm stat-card h-100">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="fas fa-tasks text-primary"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">${stats.totalMilestones}</h6>
                                <small class="text-muted">Total Milestones</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm stat-card h-100">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-success bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="fas fa-check-circle text-success"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">${stats.completedMilestones}</h6>
                                <small class="text-muted">Completed</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm stat-card h-100">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-warning bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="fas fa-spinner text-warning"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">${stats.ongoingMilestones}</h6>
                                <small class="text-muted">In Progress</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm stat-card h-100">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-danger bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="fas fa-clock text-danger"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">${stats.pendingMilestones}</h6>
                                <small class="text-muted">Pending</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        container.html(html);
    }
    
    // Function to render overall progress bar
    function renderOverallProgress(stats) {
        const container = $('#overallProgressContainer');
        
        const html = `
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div>
                            <span class="fw-bold">Overall Progress</span>
                            <span class="badge bg-light text-muted ms-2">
                                ${stats.completedSteps}/${stats.totalBabySteps} Steps
                            </span>
                        </div>
                        <span class="fw-bold text-primary">${stats.overallProgress}%</span>
                    </div>
                    <div class="progress" style="height: 0.5rem;">
                        <div class="progress-bar bg-gradient-primary" 
                             role="progressbar" 
                             style="width: ${stats.overallProgress}%;" 
                             aria-valuenow="${stats.overallProgress}" 
                             aria-valuemin="0" 
                             aria-valuemax="100">
                        </div>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <small class="text-muted">
                            <i class="fas fa-check-circle text-success me-1"></i> ${stats.completedSteps} Completed
                        </small>
                        <small class="text-muted">
                            <i class="fas fa-spinner text-warning me-1"></i> ${stats.ongoingSteps} In Progress
                        </small>
                        <small class="text-muted">
                            <i class="fas fa-clock text-danger me-1"></i> ${stats.pendingSteps} Pending
                        </small>
                    </div>
                </div>
            </div>
        `;
        
        container.html(html);
    }
    
    // Function to render a single milestone
    function renderMilestone(milestone, index) {
        
        // Determine milestone status and badge color
       	const status = determineMilestoneStatus(milestone.baby_steps);
        let badgeClass = '';
        let cardClass = '';
        
        
        
        // Calculate progress for this milestone
        const steps = milestone.baby_steps || [];
        const totalSteps = steps.length;
        const completedSteps = steps.filter(s => s.bse_status === 'Completed').length;
        const progressPercent = totalSteps > 0 ? Math.round((completedSteps / totalSteps) * 100) : 0;

		switch(status) {
            case 'Completed':
                badgeClass = 'bg-success';
                cardClass = 'completed';
                break;
            case 'Ongoing':
                badgeClass = 'bg-warning text-dark';
                cardClass = 'ongoing';
                break;
            default:
                badgeClass = 'bg-danger';
                cardClass = 'pending';
                break;
        }
        
        // Generate baby steps HTML
        let babyStepsHtml = '';
        
        steps.forEach((step, stepIndex) => {
            
            // Determine icon and color based on status
            let iconClass = '';
            let iconColor = '';
            let statusBadgeClass = '';
            
            switch(step.bse_status) {
                case 'Completed':
                    iconClass = 'fa-check-circle';
                    iconColor = 'text-success';
                    statusBadgeClass = 'bg-success';
                    break;
                case 'Ongoing':
                    iconClass = 'fa-spinner fa-spin';
                    iconColor = 'text-warning';
                    statusBadgeClass = 'bg-warning text-dark';
                    break;
                default:
                    iconClass = 'fa-times-circle';
                    iconColor = 'text-danger';
                    statusBadgeClass = 'bg-danger';
                    break;
            }
            
            // Format date
            const completeByDate = step.complete_by_date ? formatDate(step.complete_by_date) : 'N/A';
            
            babyStepsHtml += `
                <li class="mb-2 baby-step-item">
                    <div class="d-flex align-items-start gap-3">
                        <div class="mt-1">
                            <i class="fas ${iconClass} ${iconColor} fa-lg"></i>
                        </div>
                        <div class="flex-fill">
                            <div class="d-flex align-items-start justify-content-between mb-1 flex-wrap gap-2">
                                <div class="fw-semibold" 
                                     data-bs-toggle="tooltip" 
                                     data-bs-custom-class="tooltip-primary"
                                     data-bs-placement="top" 
                                     title="${escapeHtml(step.bse_description)}">
                                    ${escapeHtml(step.bse_description)}
                                </div>
                                <div class="d-flex gap-2">
                                    <span class="badge ${statusBadgeClass} bg-opacity-10 ${iconColor} border-0">
                                        ${step.bse_status}
                                    </span>
                                    <span class="badge bg-light text-muted border">
                                        <i class="fas fa-calendar me-1"></i> ${completeByDate}
                                    </span>
                                </div>
                            </div>
                            <div class="small">
                                <span class="text-muted">Performed by:</span>
                                <strong class="ms-1">
                                    ${step.completed_by ? escapeHtml(step.completed_by) : '<span class="text-muted fw-normal">Pending</span>'}
                                </strong>
                                ${step.start_date ? `
                                    <span class="text-muted ms-2">
                                        <i class="fas fa-play-circle me-1"></i> ${formatDateTime(step.start_date)}
                                    </span>
                                ` : ''}
                            </div>
                        </div>
                    </div>
                </li>
            `;
        });
        
        // Generate milestone HTML
        return `
            <div class="card shadow-sm mb-4 milestone-card ${cardClass}">
                <div class="card-header bg-white border-0 pt-3 pb-0">
                    <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                        <div class="d-flex align-items-center">
                            <span class="badge bg-light text-dark me-3 px-3 py-2">
                                MS-${milestone.ms_id || (index + 1)}
                            </span>
                            <h6 class="fw-bold mb-0">
                                ${escapeHtml(milestone.milestone_description)}
                            </h6>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="badge ${badgeClass} text-white px-3 py-2">
                                ${status}
                            </span>
                        </div>
                    </div>
                </div>
                <div class="card-body pt-3">
                    
                    <!-- Milestone Progress Bar -->
                    <div class="mb-3">
                        <div class="d-flex align-items-center justify-content-between mb-1">
                            <small class="text-muted">Milestone Progress</small>
                            <small class="fw-semibold">${completedSteps}/${totalSteps} steps</small>
                        </div>
                        <div class="progress" style="height: 0.3rem;">
                            <div class="progress-bar bg-gradient-primary" 
                                 role="progressbar" 
                                 style="width: ${progressPercent}%;" 
                                 aria-valuenow="${progressPercent}" 
                                 aria-valuemin="0" 
                                 aria-valuemax="100">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Baby Steps List -->
                    <ul class="list-unstyled mb-0">
                        ${babyStepsHtml}
                    </ul>
                    
                </div>
            </div>
        `;
    }
    
    // Helper function to format date
    function formatDate(dateString) {
        if (!dateString) return 'N/A';
        
        try {
            const date = new Date(dateString);
            if (isNaN(date.getTime())) return dateString;
            
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
        } catch (e) {
            return dateString;
        }
    }
    
    // Helper function to format date time
    function formatDateTime(dateTimeString) {
        if (!dateTimeString) return 'N/A';
        
        try {
            const date = new Date(dateTimeString);
            if (isNaN(date.getTime())) return dateTimeString;
            
            return date.toLocaleString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return dateTimeString;
        }
    }
    
    // Helper function to escape HTML and prevent XSS
    function escapeHtml(text) {
        if (!text) return '';
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.toString().replace(/[&<>"']/g, function(m) { return map[m]; });
    }
    
    // Initialize tooltips for dynamically added content
    function initializeTooltips() {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.forEach(function(tooltipTriggerEl) {
            try {
                const tooltip = bootstrap.Tooltip.getInstance(tooltipTriggerEl);
                if (tooltip) {
                    tooltip.dispose();
                }
                new bootstrap.Tooltip(tooltipTriggerEl, {
                    trigger: 'hover',
                    delay: { show: 300, hide: 100 }
                });
            } catch (e) {
                console.warn('Could not initialize tooltip:', e);
            }
        });
    }
    
    // Clear tooltips when modal is hidden
    $('#milestoneDetailsModal').on('hidden.bs.modal', function() {
        const tooltips = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltips.forEach(function(el) {
            const tooltip = bootstrap.Tooltip.getInstance(el);
            if (tooltip) {
                tooltip.dispose();
            }
        });
    });

	$(document).on('click', '.btn_send_request', function() {
        const jobNumber = $(this).data('job_number');
        const arName = $(this).data('ar_name');
        const businessProcessSubName = $(this).data('business_process_sub_name');
        const locality = $(this).data('locality');
        const description = $(this).data('bs-desc');

        // Open the modal with the data
        $('#askForPurposeOfSendingRequest').modal('show');
        $('#req_job_number').val(jobNumber);
        $('#req_ar_name').val(arName);
        $('#req_business_process_sub_name').val(businessProcessSubName);
        $('#req_locality').val(locality);
        $('#req_description').val(description);

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
                        $('#req_job_purpose').append(
                                                    '<option value="'
                                                            + this.request_name
                                                            + '">'
                                                            + this.request_name
                                                            + '</option>');
                        // switch (description) {
                        //     case 'Further Entry (Enter Details)':
                        //         if (this._id == 3) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Upload Coordinate and Save':
                        //         if (this._id == 2) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Send for Records Information':
                        //         if (this._id == 1 || this._id == 24) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Verify Records Information':
                        //         if (this._id == 1 || this._id == 24) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Review Records Information':
                        //         if (this._id == 1) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Inspection of Site (IF applicable)':
                        //         if (this._id == 23) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Send for Publication':
                        //         if (this._id == 21) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Send for Title Plan Preparation':
                        //         if (this._id == 22 || this._id == 15) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Check for Objection':
                        //         if (this._id == 19) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Check for Polygon':
                        //         if (this._id == 2) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     // case 'Generate interest Number':
                        //     // 	if (this._id == 14) {
                        //     // 		$('#req_job_purpose').append(
                        //     // 						'<option value="'
                        //     // 								+ this.request_name
                        //     // 								+ '">'
                        //     // 								+ this.request_name
                        //     // 								+ '</option>');
                        //     // 	}
                        //     // 	break;
                        //     // case 'Generate sub Interest Number':
                        //     // 	if (this._id == 18) {
                        //     // 		$('#req_job_purpose').append(
                        //     // 						'<option value="'
                        //     // 								+ this.request_name
                        //     // 								+ '">'
                        //     // 								+ this.request_name
                        //     // 								+ '</option>');
                        //     // 	}
                        //     // 	break;
                        //     case 'Enter Root of Title':
                        //         if (this._id == 4 || this._id == 20) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Generate Certificate Number':
                        //         if (this._id == 16) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Generate Volume and Folio':
                        //         if (this._id == 9) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Check Certificate':
                        //         if (this._id == 4 || this._id == 16 || this._id == 3 || this._id == 9) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Check Register':
                        //         if (this._id == 4 || this._id == 20 || this._id == 9) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Check/Review Documents':
                        //         if (this._id == 24) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Review Documents':
                        //         if (this._id == 24) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Check availability of Mother File':
                        //         if (this._id == 25) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Link to Mother File':
                        //         if (this._id == 25) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;	
                        //     case 'Preview Certificate':
                        //         if (this._id == 4 || this._id == 16 || this._id == 3 || this._id == 9) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break;
                        //     case 'Enter Mortgage Transaction':
                        //         if (this._id == 17) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break; 
                        //     case 'View Register':
                        //         if (this._id == 4) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break; 
                        //     case 'Check Parcel Details':
                        //         if (this._id == 3) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         }
                        //         break; 
                        //     case 'openall':
                        //         // if (this._id == 17) {
                        //             $('#req_job_purpose').append(
                        //                             '<option value="'
                        //                                     + this.request_name
                        //                                     + '">'
                        //                                     + this.request_name
                        //                                     + '</option>');
                        //         //}
                        //         break;
                        // }
                        
                    });
                }
            });
    });

	function removeAllActiveStates() {
    	// Remove all light background classes
		$("#body-bg-1, #body-bg-2, #body-bg-4, #body-bg-5, #body-bg-6, #body-bg-7, #body-bg-8, #body-bg-9, #body-bg-10")
			.removeClass('bg-primary-light bg-danger-light bg-warning-light bg-info-light bg-success-light bg-secondary-light');
		
		// Reset text colors (optional - keep text as is)
		$("#number-text-1, #number-text-2, #number-text-4, #number-text-5, #number-text-6, #number-text-7, #number-text-8, #number-text-9, #number-text-10")
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
			case 8: // Request Additional Input - Danger
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-8").addClass('bg-danger-light');
				$("#number-text-8").addClass('text-white');
				$("#card-request_additional_input").addClass('active-card');
				break;
			case 9: // Awaiting Inspection
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-9").addClass('bg-primary-light');
				$("#number-text-9").addClass('text-white');
				$("#card-awaiting_inspection").addClass('active-card');
				break;
			case 10: // Awaiting Publication
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-10").addClass('bg-warning-light');
				$("#number-text-10").addClass('text-white');
				$("#card-awaiting_publication").addClass('active-card');
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

$("#selectAll").on("click", function() {
	if ($(this).prop("checked") == true) {
		$('#job_casemgtdetailsdataTable tbody tr').addClass('selected');
		$('#allBatchList').removeClass('d-none');
	} else {
		$('#job_casemgtdetailsdataTable tbody tr').removeClass('selected');
		$('#allBatchList').addClass('d-none');
	}

	$("#job_casemgtdetailsdataTable tbody tr").find(":checkbox").prop('checked',
	$(this).prop('checked'));
});

$(document).on('change', '.row-checkbox', function () {
    const anyChecked = $('.row-checkbox:checked').length > 0;

    if (anyChecked) {
        $('#allBatchList').removeClass('d-none');
    } else {
        $('#allBatchList').addClass('d-none');
    }

    // Optional: keep row highlighting in sync
    $(this).closest('tr').toggleClass('selected', this.checked);
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