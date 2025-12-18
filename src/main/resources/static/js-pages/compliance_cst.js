$(document).ready(function() {
	
	$(".open_app_withOfficers_cst").on("click", function(e){
		e.preventDefault();

		let datatable = $("#cst_apps_with_staff_summary_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		let division = $(this).data('target_division');
		//console.log(division);
		$("#cst_modal_divison_name").html(division);
		
		
		
		//call for data
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_application_assigned_by_division_cst',
				division : division,
				
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)
				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_recieved_by,
									this.total,
									this.total_over,
									'<button  class="btn btn-info btn-icon-split open_apps_with_staff_cst"  data-title="View files"  data-staff_id="'
											+ this.job_recieved_by_id
											
											+ '" data-staff_name="' + this.job_recieved_by  +  '" >'
											+ ' <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Files</span>'
											+ ' </button>'
									
									// `<button  class="btn btn-info btn-icon-split showApplicationsWithOfficerCSTModal" data-title="${this.job_recieved_by}'s" data-method="apps_with_division" data-key="staff" data-date data-value="${this.job_recieved_by_id}" data-url="DashboardAppsWithDivision" 
									// 	data-staff="{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}","total":${this.total}}">
									// <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Files</span>
									// </button>`

								]).draw(false);
					});

				
				}catch(e){
					
				}
			}

		});
		
		
		$("#cstStaffSummaryModal").modal("show");
		
	});
	
	
	
	$(document).on("click",".open_apps_with_staff_cst", function(e){
		e.preventDefault();

		let datatable_list = $("#cst_apps_with_staff_details_table")
		.DataTable({
			stateSave : true,
			"createdRow" : function(row, data, dataIndex) {
				if (data[7] >= 7) {
					$(row).addClass('tr-passed-7-days');
				}else if(data[2] >= 5){
					$(row).addClass('tr-passed-5-days');
				}else if(data[2] >= 3){
					$(row).addClass('tr-passed-3-days');
				}
			},
		
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		let division = $(this).data('staff_id');
		//console.log(division);
		$("#cst_modal_staff_name").html($(this).data('staff_name'));
				
		//call for data
		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_application_assigned_to_staff_cst',
				userid : division,
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)
				datatable_list.search("").draw();
				datatable_list.state.clear();
				datatable_list.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					$(json_p.data).each(function() {
						//Add to table
						datatable_list.row.add(
								[
									this.job_number,
									this.date_received,
									this.duration,
									this.job_forwarded_by,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});
					
					datatable_list.column(2).data().sort();

				
				}catch(e){
					
				}
			}

		});
		$("#cstStaffDetailsModal").css('z-index',90000);
		$("#cstStaffDetailsModal").modal("toggle");
		
	});

    $("#sendMessageModal").css("z-index",90000);

	function show_hide_column(col_no, do_show){
		const table  = document.getElementById('cst_unit_summary_details_table')
		const column = table.getElementsByTagName('col')[col_no]
		if ( column ){
		   column.style.visibility = do_show ? "" : "collapse";
		}
	 }
  
	$(document).on("click","#cst_apps_at_qc", function(e){
		e.preventDefault();

		let datatable = $("#qc_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		show_hide_column(3, false)

		$("#cst_us_modal_name").html('QC/FURTHER ENTRIES');
		$("#qcUnitSummaryModal").modal("show");

		//$("#hide_from_qc").addClass('d-none');

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_summary',
				summary_type : 'cst_apps_at_qc',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									// `<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
									// 	class="btn btn-info btn-icon-split "
									// >
									// <span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									// </button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});
	
	
	$(document).on("click","#cst_cordiantor_comp", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('COMPLETED READY FOR SUMMARY');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_summary',
				summary_type : 'cst_cordiantor_comp',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(document).on("click","#cst_cordiantor_in", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('INCOMING APPLICATIONS FOR REC INFO');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_summary',
				summary_type : 'cst_cordiantor_in',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});
	
	////End doc ready

	$(document).on("click","#cst_summary_in", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('NOT ASSIGNED BY UNIT HEAD');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_summary',
				summary_type : 'cst_summary_in',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(document).on("click","#cst_summary_comp", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('COMPLETED APPLICATIONS');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_summary',
				summary_type : 'cst_summary_comp',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(document).on("click","#cst_summary_queried", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('QUERIED APPLICATIONS');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_summary',
				summary_type : 'cst_summary_queried',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(".open_app_withOfficers_frrv_cst").on("click", function(e){
		e.preventDefault();

		let datatable = $("#cst_apps_with_staff_summary_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		let division = $(this).data('target_division');
		//console.log(division);
		$("#cst_modal_divison_name").html(division);
		
		
		
		//call for data
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_app_assigned_by_division_frrv_cst',
				division : division,
				
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)
				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_recieved_by,
									this.total,
									this.total_over,
									'<button  class="btn btn-info btn-icon-split open_apps_with_staff_frrv_cst"  data-title="View files"  data-staff_id="'
											+ this.job_recieved_by_id
											
											+ '" data-staff_name="' + this.job_recieved_by  +  '" >'
											+ ' <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Files</span>'
											+ ' </button>'
									
									// `<button  class="btn btn-info btn-icon-split showApplicationsWithOfficerCSTModal" data-title="${this.job_recieved_by}'s" data-method="apps_with_division" data-key="staff" data-date data-value="${this.job_recieved_by_id}" data-url="DashboardAppsWithDivision" 
									// 	data-staff="{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}","total":${this.total}}">
									// <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Files</span>
									// </button>`

								]).draw(false);
					});

				
				}catch(e){
					
				}
			}

		});
		
		
		$("#cstStaffSummaryModal").modal("show");
		
	});
	
	
	
	$(document).on("click",".open_apps_with_staff_frrv_cst", function(e){
		e.preventDefault();

		let datatable_list = $("#cst_apps_with_staff_details_table")
		.DataTable({
			stateSave : true,
			"createdRow" : function(row, data, dataIndex) {
				if (data[7] >= 7) {
					$(row).addClass('tr-passed-7-days');
				}else if(data[2] >= 5){
					$(row).addClass('tr-passed-5-days');
				}else if(data[2] >= 3){
					$(row).addClass('tr-passed-3-days');
				}
			},
		
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		let division = $(this).data('staff_id');
		//console.log(division);
		$("#cst_modal_staff_name").html($(this).data('staff_name'));
				
		//call for data
		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_app_assigned_to_staff_frrv_cst',
				userid : division,
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)
				datatable_list.search("").draw();
				datatable_list.state.clear();
				datatable_list.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					$(json_p.data).each(function() {
						//Add to table
						datatable_list.row.add(
								[
									this.job_number,
									this.date_received,
									this.duration,
									this.job_forwarded_by,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});
					
					datatable_list.column(2).data().sort();

				
				}catch(e){
					
				}
			}

		});
		$("#cstStaffDetailsModal").css('z-index',90000);
		$("#cstStaffDetailsModal").modal("toggle");
		
	});

    $("#sendMessageModal").css("z-index",90000);

	function show_hide_column(col_no, do_show){
		const table  = document.getElementById('cst_unit_summary_details_table')
		const column = table.getElementsByTagName('col')[col_no]
		if ( column ){
		   column.style.visibility = do_show ? "" : "collapse";
		}
	 }
  
	$(document).on("click","#frrv_cst_apps_at_qc", function(e){
		e.preventDefault();

		let datatable = $("#qc_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		show_hide_column(3, false)

		$("#qc_us_modal_name").html('QC/FURTHER ENTRIES');
		$("#qcUnitSummaryModal").modal("show");

		//$("#hide_from_qc").addClass('d-none');

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_summary',
				summary_type : 'frrv_cst_apps_at_qc',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									// `<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
									// 	class="btn btn-info btn-icon-split "
									// >
									// <span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									// </button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});
	
	
	$(document).on("click","#frrv_cst_cordiantor_comp", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('COMPLETED READY FOR SUMMARY');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_summary',
				summary_type : 'frrv_cst_cordiantor_comp',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(document).on("click","#frrv_cst_cordiantor_in", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('INCOMING APPLICATIONS FOR REC INFO');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_summary',
				summary_type : 'frrv_cst_cordiantor_in',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});
	
	////End doc ready

	$(document).on("click","#frrv_cst_summary_in", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('NOT ASSIGNED BY UNIT HEAD');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_summary',
				summary_type : 'frrv_cst_summary_in',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(document).on("click","#frrv_cst_summary_comp", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('COMPLETED APPLICATIONS');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_summary',
				summary_type : 'frrv_cst_summary_comp',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$(document).on("click","#frrv_cst_summary_queried", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table")
		.DataTable({
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name").html('QUERIED APPLICATIONS');
		$("#cstUnitSummaryModal").modal("show");

		$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_summary',
				summary_type : 'frrv_cst_summary_queried',
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									`<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	$('#corporate_stamping_unit_staff').on('click', function(e) {
		e.preventDefault();
  
	 $("#serviceTypeModal1").modal("show");  
  
	 var unit_code=$(this).data('id');

	 var unit_name=$(this).data('name');
	 
	//  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
	//  var created_for_id = $('#bank_id').val();
  
  
	//  console.log(created_for_id === "" ? null : $('#bank_id').val());
  
  
	 console.log(unit_code);
  
  
	 var title  = unit_name+"'S"+" "+"STAFF";
		  
	 document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'corporate_processing_units_staff',
				unit_code: unit_code			},
			cache: false,
			success: function(response) {
  
				var json_result = JSON.parse(response);
				console.log(json_result.data);
  
	            if (json_result.data == null){
  
	              alert('Sorry Data Not Found');
  
	
	}else {
  
		let dataSet1 = [];
		let num1 = 0;
  
	  $('#services_table').DataTable().clear().destroy();
  
  
  
	  for(let i=0; i<json_result.data.length; i++) {
		let html = [];
		num1 = +num1 + 1;

		let fullname = json_result.data[i].fullname;
		let count = json_result.data[i].count;
		let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_corporate_unit_staff_apps"  
		class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

		// let payment_status = e[i].payment_status;
		// let buttons = e[i].buttons;
		

		html.push(fullname);
		html.push(count);
		html.push(action);
		// html.push(payment_status);
		// html.push(buttons);

		dataSet1.push(html);

	  //console.log(dataSet)
	  }
  
		// let dataTable_Obj = $('#recievedtoday').DataTable({
		//     data: dataSet1
		//   })
  
		  $('#services_table').DataTable().clear().destroy();
						
		  $('#services_table').DataTable({ data: dataSet1,
			dom : 'Bfrtip',
						  lengthMenu : [
							  [ 10, 25, 50, -1 ],
							  [ '10 rows', '25 rows',
								  '50 rows', 'Show all' ] ],
						  buttons : [ 'pageLength', 'copy',
							  'csv', 'excel', 'pdf', 'print' ] 
		  }).draw();
		  
  
	 }
  
			   
  
			   
  
  
			}
		})
	})	





	$('#corporate_registration_unit_staff').on('click', function(e) {
		e.preventDefault();
  
	 $("#serviceTypeModal1").modal("show");  
  
	 var unit_code=$(this).data('id');

	 var unit_name=$(this).data('name');
	 
	//  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
	//  var created_for_id = $('#bank_id').val();
  
  
	//  console.log(created_for_id === "" ? null : $('#bank_id').val());
  
  
	 console.log(unit_code);
  
  
	 var title  = unit_name+"'S"+" "+"STAFF";
		  
	 document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'corporate_processing_units_staff',
				unit_code: unit_code			},
			cache: false,
			success: function(response) {
  
				var json_result = JSON.parse(response);
				console.log(json_result.data);
  
	            if (json_result.data == null){
  
	              alert('Sorry Data Not Found');
  
	
	}else {
  
		let dataSet1 = [];
		let num1 = 0;
  
	  $('#services_table').DataTable().clear().destroy();
  
  
  
	  for(let i=0; i<json_result.data.length; i++) {
		let html = [];
		num1 = +num1 + 1;

		let fullname = json_result.data[i].fullname;
		let count = json_result.data[i].count;
		let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_corporate_unit_staff_apps"  
		class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

		// let payment_status = e[i].payment_status;
		// let buttons = e[i].buttons;
		

		html.push(fullname);
		html.push(count);
		html.push(action);
		// html.push(payment_status);
		// html.push(buttons);

		dataSet1.push(html);

	  //console.log(dataSet)
	  }
  
		// let dataTable_Obj = $('#recievedtoday').DataTable({
		//     data: dataSet1
		//   })
  
		  $('#services_table').DataTable().clear().destroy();
						
		  $('#services_table').DataTable({ data: dataSet1,
			dom : 'Bfrtip',
						  lengthMenu : [
							  [ 10, 25, 50, -1 ],
							  [ '10 rows', '25 rows',
								  '50 rows', 'Show all' ] ],
						  buttons : [ 'pageLength', 'copy',
							  'csv', 'excel', 'pdf', 'print' ] 
		  }).draw();
		  
  
	 }
  
			   
  
			   
  
  
			}
		})
	})	









	$('#corporate_concurrence_unit_staff').on('click', function(e) {
		e.preventDefault();
  
	 $("#serviceTypeModal1").modal("show");  
  
	 var unit_code=$(this).data('id');

	 var unit_name=$(this).data('name');
	 
	//  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
	//  var created_for_id = $('#bank_id').val();
  
  
	//  console.log(created_for_id === "" ? null : $('#bank_id').val());
  
  
	 console.log(unit_code);
  
  
	 var title  = unit_name+"'S"+" "+"STAFF";
		  
	 document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'corporate_processing_units_staff',
				unit_code: unit_code			},
			cache: false,
			success: function(response) {
  
				var json_result = JSON.parse(response);
				console.log(json_result.data);
  
	            if (json_result.data == null){
  
	              alert('Sorry Data Not Found');
  
	
	}else {
  
		let dataSet1 = [];
		let num1 = 0;
  
	  $('#services_table').DataTable().clear().destroy();
  
  
  
	  for(let i=0; i<json_result.data.length; i++) {
		let html = [];
		num1 = +num1 + 1;

		let fullname = json_result.data[i].fullname;
		let count = json_result.data[i].count;
		let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_corporate_unit_staff_apps"  
		class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

		// let payment_status = e[i].payment_status;
		// let buttons = e[i].buttons;
		

		html.push(fullname);
		html.push(count);
		html.push(action);
		// html.push(payment_status);
		// html.push(buttons);

		dataSet1.push(html);

	  //console.log(dataSet)
	  }
  
		// let dataTable_Obj = $('#recievedtoday').DataTable({
		//     data: dataSet1
		//   })
  
		  $('#services_table').DataTable().clear().destroy();
						
		  $('#services_table').DataTable({ data: dataSet1,
			dom : 'Bfrtip',
						  lengthMenu : [
							  [ 10, 25, 50, -1 ],
							  [ '10 rows', '25 rows',
								  '50 rows', 'Show all' ] ],
						  buttons : [ 'pageLength', 'copy',
							  'csv', 'excel', 'pdf', 'print' ] 
		  }).draw();
		  
  
	 }
  
			   
  
			   
  
  
			}
		})
	})	









	$('#corporate_search_unit_staff').on('click', function(e) {
		e.preventDefault();
  
	 $("#serviceTypeModal1").modal("show");  
  
	 var unit_code=$(this).data('id');

	 var unit_name=$(this).data('name');
	 
	//  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
	//  var created_for_id = $('#bank_id').val();
  
  
	//  console.log(created_for_id === "" ? null : $('#bank_id').val());
  
  
	 console.log(unit_code);
  
  
	 var title  = unit_name+"'S"+" "+"STAFF";
		  
	 document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
		$.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'corporate_processing_units_staff',
				unit_code: unit_code			},
			cache: false,
			success: function(response) {
  
				var json_result = JSON.parse(response);
				console.log(json_result.data);
  
	            if (json_result.data == null){
  
	              alert('Sorry Data Not Found');
  
	
	}else {
  
		let dataSet1 = [];
		let num1 = 0;
  
	  $('#services_table').DataTable().clear().destroy();
  
  
  
	  for(let i=0; i<json_result.data.length; i++) {
		let html = [];
		num1 = +num1 + 1;

		let fullname = json_result.data[i].fullname;
		let count = json_result.data[i].count;
		let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_corporate_unit_staff_apps"  
		class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

		// let payment_status = e[i].payment_status;
		// let buttons = e[i].buttons;
		

		html.push(fullname);
		html.push(count);
		html.push(action);
		// html.push(payment_status);
		// html.push(buttons);

		dataSet1.push(html);

	  //console.log(dataSet)
	  }
  
		// let dataTable_Obj = $('#recievedtoday').DataTable({
		//     data: dataSet1
		//   })
  
		  $('#services_table').DataTable().clear().destroy();
						
		  $('#services_table').DataTable({ data: dataSet1,
			dom : 'Bfrtip',
						  lengthMenu : [
							  [ 10, 25, 50, -1 ],
							  [ '10 rows', '25 rows',
								  '50 rows', 'Show all' ] ],
						  buttons : [ 'pageLength', 'copy',
							  'csv', 'excel', 'pdf', 'print' ] 
		  }).draw();
		  
  
	 }
  
			   
  
			   
  
  
			}
		})
	})	






	$(document).on('click','#view_corporate_unit_staff_apps',function(e){
		e.preventDefault();
		var staff_id=$(this).data('id');

		var staff_name=$(this).data('name_full');
		//var user_created_name = $(e.currentTarget).data("name");

		var title = "APPLICATIONS WITH"+" "+staff_name
	  
		document.getElementById('applicationsModalLabelRecievedYear').innerHTML = title;
	  
		console.log(staff_id,staff_name);
	   
	  $("#corporate_unit_staff_apps_modals").modal("show");  
	   
	
	   let dataSet2 = [];
	   let num2 = 0;
	  
	  $('#corporate_unit_staff_apps_table').DataTable().clear().destroy();
	  
	   $.ajax({
		   type : "POST",
		   url : "Case_Management_Serv",
		   data : {
			   request_type : 'corporate_processing_units_application_with_staff',
			   staff_id : staff_id
		   },
		   cache: false,
		   success: function(response) {
	  
			// console.log(response)
	  
			   var json_result = JSON.parse(response);
			   console.log(json_result)
	  
			   if (json_result.apps_at_division == null){
	  
				// console.log("data not found"); 
				alert('Sorry Data Not Found');      
	  
	  }else {
	  
		for(let i=0; i<json_result.apps_at_division.length; i++) {
		  let html = [];
		  num2 = +num2 + 1;
	  
		  let job_number = json_result.apps_at_division[i].job_number;
		  let ar_name = json_result.apps_at_division[i].ar_name;
		  let business_process_name = json_result.apps_at_division[i].business_process_name;
		  let created_date = json_result.apps_at_division[i].created_date;
		  let date_batched = json_result.apps_at_division[i].date_batched;
		  let days_due = json_result.apps_at_division[i].days_due;
		  let days_since_received = json_result.apps_at_division[i].days_since_received;
		  let action = `<div class="btn-group" role="group">
     <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
       Actions
     </button>
     <div class="dropdown-menu">  
     <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${json_result.apps_at_division[i].job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
     <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
       <input type="hidden" name="case_number" id="case_number" value="${json_result.apps_at_division[i].transaction_number}">
       <input type="hidden" name="search_text" id="search_text" value="${json_result.apps_at_division[i].case_number}">
       <input type="hidden" name="job_number" id="job_number" value=""${json_result.apps_at_division[i].job_number}">
       <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value=""${json_result.apps_at_division[i].case_number}">
       <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
     </form> 
     </div>
   </div>`;
		  

		  
		 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
		  // let payment_status = e[i].payment_status;
		  // let buttons = e[i].buttons;
		  
	  
		  html.push(job_number);
		  html.push(ar_name);
		  html.push(business_process_name);
		  html.push(created_date);
		  html.push(date_batched);
		  html.push(days_due);
		  html.push(days_since_received);
		  html.push(action);
		  


		  // html.push(buttons);
	  
		  dataSet2.push(html);
	  
		//console.log(dataSet)
		}
	  
	  // let dataTable_Obj = $('#recievedtoday').DataTable({
	  //     data: dataSet1
	  //   })
	  
		$('#corporate_unit_staff_apps_table').DataTable().clear().destroy();
					  
		$('#corporate_unit_staff_apps_table').DataTable({ data: dataSet2,
		  dom : 'Bfrtip',
		  lengthMenu : [
			  [ 10, 25, 50, -1 ],
			  [ '10 rows', '25 rows',
				  '50 rows', 'Show all' ] ],
		  buttons : [ 'pageLength', 'copy',
			  'csv', 'excel', 'pdf', 'print' ] }).draw();
	  
	  }
			  
	  
			   
	  
	  
		   }
	   })
	  
	  });





	  $('#cabinetModal')
.on(
    'show.bs.modal',
    function(event) {
      var job_number = $(event.relatedTarget)
          .data('target-id') // Extract
      // info from
      // data-*
      // attributes
      var table = $('#cabinet-tracking');
      table.find("tbody tr").remove();

      $("#enq_applicant_name").val("");
      $("#enq_applicant_type").val("");
      $("#enq_cabinet_name").val("");
      // $("#enq_job_purpose").val(this.job_purpose);
      $("#enq_job_status").val("");

      console.log(job_number);

      $
          .ajax({
            type : "POST",
            url : "Case_Management_Serv",
            data : {
              request_type : 'load_application_cabinet_details_by_job_number',
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

              // console.log(jobdetails);
              var json_p = JSON
                  .parse(jobdetails);

              // console.log();
              $(
                  json_p.cabinet_tracking)
                  .each(
                      function() {

                        table
                            .append("<tr><td>"
                                + this.officers_general_comments
                                + "</td><td>"
                                + this.division
                                + "</td><td>"
                                + this.created_by
                                + "</td><td>"
                                + this.created_date
                                + '</tr>');

                      });

              $(json_p.cabinet_data)
                  .each(
                      function() {

                        $(
                            "#enq_applicant_name")
                            .val(
                                this.ar_name);
                        $(
                            "#enq_applicant_type")
                            .val(
                                this.business_process_sub_name);
                        $(
                            "#enq_cabinet_name")
                            .val(
                                this.file_number);
                        $(
                            "#enq_job_purpose")
                            .val(
                                this.job_purpose);
                        $(
                            "#enq_job_status")
                            .val(
                                this.job_status);

                        $(
                            "#enq_current_application_status")
                            .val(
                                this.current_application_status);

                      });

            }
          });

    });
});