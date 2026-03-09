$(document).ready(function() {
	
	$(".open_app_withOfficers_cst").on("click", function(e){
		e.preventDefault();
     
		console.log("Find")
		
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
				console.log(jobdetails)
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
		let staffName = $(this).data('staff_name');
		console.log(division,staffName);
		$("#cst_modal_staff_name").html($(this).data('staff_name'));

		//   const staff = $(this).data("receiver_name");
//   const staffid = $(this).data("officer_id");

		    const sendMsgButton = `
        <button 
          class="sendMessageCST btn btn-info d-flex align-items-center shadow-sm px-4 py-2 ml-auto"
          id="send_message"
          data-officer_id="${division}"
		  data-receiver_name="${staffName}"
          data-jobnumber="${division}"
          type="button"
        >
          <i class="fas fa-paper-plane mr-2"></i> Send Message
        </button>`;
      document.getElementById("sendmsg").innerHTML = sendMsgButton;


				
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

					const checkbox = `
          <div class="text-center">
            <input type="checkbox" class="app-checkbox" value="${this.job_number}">
          </div>`;


					var json_p = JSON.parse(jobdetails);
					$(json_p.data).each(function() {
						//Add to table
						datatable_list.row.add(
								[
									checkbox,
									this.job_number,
									this.date_received,
									this.duration,
									this.job_forwarded_by,
									// `<button data-job-number="${this.job_number}" id="sendMessage" data-staff='{"staff":"${this.job_recieved_by}","staff_id":"${this.job_recieved_by_id}"}'
									// 	class="btn btn-info btn-icon-split "
									// >
									// <span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									// </button>`,

								]).draw(false);
					});
					
					datatable_list.column(2).data().sort();

				
				}catch(e){
					
				}
			}

		});
		// $("#cstStaffDetailsModal").css('z-index',70000);
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


					                // 👇 Get officer info from first row
                    let officerId  = json_p.data[0].job_recieved_by_id;
                    let staffName  = json_p.data[0].job_recieved_by;
                    let job_number   = json_p.data[0].job_number;

                    // 👇 Build Send Message Button WITH DATA
                    const sendMsgButton = `
                        <button 
                            class="sendMessageCSTUnit btn btn-info btn-sm d-flex align-items-center shadow-sm px-3 py-1"
                            data-officer_id="${officerId}"
                            data-receiver_name="${staffName}"
                            data-jobnumber="${job_number}"
                            type="button"
                        >
                            <i class="fas fa-paper-plane me-2"></i> Send Message
                        </button>
                    `;

                    $("#sendmsg1").html(sendMsgButton);


					
					$(json_p.data).each(function() {
						const checkbox = `
                        <div class="text-center">
                            <input type="checkbox"
                                   class="app-checkbox"
                                   value="${this.job_number}">
                        </div>
                    `;
						//Add to table
						datatable.row
						.add(
								[
                                    checkbox,
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

	$(document).on("click","#cst_cordiantor_in", function(e){

    e.preventDefault();

    let datatable = $("#cst_unit_summary_details_table")
    .DataTable({
        destroy: true,
        dom: 'Bfrtip',
        buttons: [
            'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    });

    $("#cst_us_modal_name").html('INCOMING APPLICATIONS FOR REC INFO');

    var modal = new bootstrap.Modal(
        document.getElementById('cstUnitSummaryModal')
    );
    modal.show();

    $.ajax({
        type : "POST",
        url : "Case_Management_Serv",
        data : {
            request_type : 'load_cst_unit_summary',
            summary_type : 'cst_cordiantor_in',
        },
        cache : false,
        success : function(jobdetails) {

            datatable.clear();

            try{

                var json_p = JSON.parse(jobdetails);

                if(json_p.data.length > 0){

                    // 👇 Get officer info from first row
                    let officerId  = json_p.data[0].job_recieved_by_id;
                    let staffName  = json_p.data[0].job_recieved_by;
                    let job_number   = json_p.data[0].job_number;

                    // 👇 Build Send Message Button WITH DATA
                    const sendMsgButton = `
                        <button 
                            class="sendMessageCSTUnit btn btn-info btn-sm d-flex align-items-center shadow-sm px-3 py-1"
                            data-officer_id="${officerId}"
                            data-receiver_name="${staffName}"
                            data-jobnumber="${job_number}"
                            type="button"
                        >
                            <i class="fas fa-paper-plane me-2"></i> Send Message
                        </button>
                    `;

                    $("#sendmsg1").html(sendMsgButton);
                }

                // Populate Table
                $(json_p.data).each(function(){

                    const checkbox = `
                        <div class="text-center">
                            <input type="checkbox"
                                   class="app-checkbox"
                                   value="${this.job_number}">
                        </div>
                    `;

                    datatable.row.add([
                        checkbox,
                        this.job_number,
                        this.ar_name,
                        this.date_received,
                        this.duration
                    ]).draw(false);

                });

            }catch(e){
                console.log(e);
            }

        }

    });

});
	
	////End doc ready

	$(document).on("click","#cst_summary_in", function(e){
		e.preventDefault();

		let datatable = $("#cst_unit_summary_details_table_2")
		.DataTable({
			    destroy: true, // <-- Add this line
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name_2").html('NOT ASSIGNED BY UNIT HEAD');
		$("#cstUnitSummaryModal_2").modal("show");

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
									`<button data-job-number="`+this.job_number+`" data-staff="`+this.job_recieved_by+`" data-staff_id="`+this.job_recieved_by_id+`"  id="sendMessage"
										class="btn btn-info btn-icon-split sendMessageCSS"
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

		let datatable = $("#cst_unit_summary_details_table_2")
		.DataTable({
			 destroy: true,
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name_2").html('COMPLETED APPLICATIONS');
		$("#cstUnitSummaryModal_2").modal("show");

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
									`<button data-job-number="`+this.job_number+`" data-staff="`+this.job_recieved_by+`" data-staff_id="`+this.job_recieved_by_id+`"  id="sendMessage"
										class="btn btn-info btn-icon-split sendMessageCSS"
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

		let datatable = $("#cst_unit_summary_details_table_2")
		.DataTable({
			destroy: true, 
			dom: 'Bfrtip',						
			buttons: [
				'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
			]
		});

		$("#cst_us_modal_name_2").html('QUERIED APPLICATIONS');
		$("#cstUnitSummaryModal_2").modal("show");

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
									`<button data-job-number="`+this.job_number+`" data-staff="`+this.job_recieved_by+`" data-staff_id="`+this.job_recieved_by_id+`"  id="sendMessage"
										class="btn btn-info btn-icon-split sendMessageCSS"
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





	   $(document).off('click', '.showOfficerModal').on('click', '.showOfficerModal', function (event) {
// $(document).on("click", ".showOfficerModal", function (event) {
    event.preventDefault();

	console.log("Found");
    let item = $(this);


    
    let modal = $("#officerModal");
    let type = item.data("type") ?? "";
    let title = item.data("title");
    let date = item.data("date") ?? "";
    let url = item.data("url");
    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");
    let division = item.data("division");
    let unit = item.data("unit-id");
    let count = item.data("count");



    let title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;


    //       let title_ = "";

    // if (date == ""){
    //  title_ = title + " " +" From " + StrD + " to "+ " "+ EndD;

    // }else {
    //   title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;
    // }



    //let action = method + "_officers_all"; // Action for all data
    let action =
      method +
      (typeof period === "undefined" ? "" : `_${period}`) +
      (typeof by === "undefined" ? "" : `_${by}`) +
      "_officers";

    // Show loading in modal
    modal.find(".modal-body table tbody").html('<tr><td colspan="3" class="text-center">Loading...</td></tr>');

    submitAjax(url, action, { division, unit }, function (data) {
        let officersData = data.apps_at_unit.map(function (item) {
            return {
                name: item.staff,
                total: item.total,
                action: `<a href="#" 
                    class="btn btn-sm btn-outline-primary showApplicationsModal"
                    data-staff='${JSON.stringify(item)}'
                    data-method="${method}" 
                    ${typeof period === "undefined" ? "" : `data-period="${period}"`}
                    data-url="${url}"
                    ${typeof by === "undefined" ? "" : `data-by="${by}"`}
                    data-type="${item.staff}'s"
                    data-title="${title}" 
                    data-date="${date}"
                    data-key="staff"
                    data-value="${item.staff_id}"
                ><i class="ri-eye-line me-2"></i>View</a>`,
            };
        });

        // Destroy existing DataTable if it exists
        if ($.fn.DataTable.isDataTable(modal.find(".modal-body table"))) {
            modal.find(".modal-body table").DataTable().destroy();
        }

        // Initialize new DataTable
        // let table = modal.find(".modal-body table").DataTable({
        //     responsive: true,
        //     data: officersData,
        //     columns: [
        //         { data: "name" },
        //         { data: "total" },
        //         { data: "action" }
        //     ],
        //     order: [[1, "desc"]],
        //     buttons: [
        //         { 
        //             extend: "excel", 
        //             exportOptions: { columns: [0, 1] } 
        //         },
        //         { 
        //             extend: "print", 
        //             exportOptions: { columns: [0, 1] } 
        //         },
        //         // "colvis"
        //     ],
        //     dom: '<"row"<"col-sm-4"l><"col-sm-4"B><"col-sm-4"f>>rtip',
        //     pageLength: 25,
        //     lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        //     pageLength: 10,
        //     language: {
        //         //emptyTable: "No compliance applications found",
        //         info: "Showing _START_ to _END_ of _TOTAL_ entries",
        //         infoEmpty: "Showing 0 to 0 of 0 entries",
        //         infoFiltered: "(filtered from _MAX_ total entries)",
        //         lengthMenu: "Show _MENU_ entries",
        //         loadingRecords: "Loading...",
        //         processing: "Processing...",
        //         search: "",
        //         searchPlaceholder: "Search Officers...",
        //         zeroRecords: "No matching records found"
        //     }
        // });

                modal.find(".modal-body table").DataTable({
  destroy: true,
  responsive: true,
  data: officersData,

  columns: [
    { data: 'name', title: 'Officer' },
    { data: 'total', title: 'Count' },
    { data: 'action', title: 'Action', orderable: false }
  ],

  dom: "<'row'<'col-sm-4'l><'col-sm-4'B><'col-sm-4'f>>" +
       "<'row'<'col-sm-12'tr>>" +
       "<'row'<'col-sm-5'i><'col-sm-7'p>>",

  buttons: getServiceTypeButtons(title_)
});


    });

    modal.find("#officerModalLabel")
        .html(`${type}'s Officers ${title} <span class="text-primary">${date}</span>`);

    modal.modal("show");
});

  



        function getServiceTypeButtons(title_) {
  return [
    {
      extend: 'copy',
      title: title_,
      documentTitle: title_,
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'csv',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'excel',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'pdf',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'print',
      text: 'Print',
      title: '',
      documentTitle: '',
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      },
      customize: function (win) {
        $(win.document.body).prepend(`
          <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">
            ${title_}
          </h3>
          <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
            This report is generated using the Enterprise Land Information System
          </p>
        `);
      }
    },
    'pageLength'
  ];
}





  function submitAjax(
    url,
    requestType,
    data = {},
    success = function () { },
    error = function () { }
  ) {

    var region_id = $('#sel_change_region_compliance').val();
    //console.log(region_id)

    if (region_id != undefined) {
      region_id = region_id.replace(".0", "");
    }

    $.ajax({
      type: "POST",
      url,
      data: {
        request_type: requestType,
        region_id: region_id,
        start_date: startDate,
         end_date: endDate,
        ...data,
      },
      cache: false,
      success: function (response) {
        //console.log(response)
        //  let totalPerRec = reccc.apps_rec_divisional[0].total;
        // let lrdData = reccc.apps_at_division.find(item => item.division === "LRD");
        // let  lrdTotal = lrdData.total;
        //console.log(lrdTotal);
        try {

          var reccc = JSON.parse(response);
          firmList = reccc;
          success(JSON.parse(response));
        } catch (e) {
          alert(
            "Failed to get requested data. Please try again shortly or contact IT Support if issue persists."
          );
          console.error(e);
        }
      },
      error: function (xhr) {
        error(xhr);
      },
    });
  }





  // Event handler for showing applications modal
  $(document).off('click', '.showApplicationsModal').on('click', '.showApplicationsModal', function (event) {
    event.preventDefault();
    
    let item = $(this);
    let modal = $("#applicationsModal");
    let type = item.data("type") ?? "";
    let title = item.data("title");
    let date = item.data("date") ?? "";
    let url = item.data("url");
    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");
    let key = item.data("key");
    let value = item.data("value");


	let title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;


    //        let title_ = "";

    // if (date == ""){
    //  title_ = title + " " +" From " + StrD + " to "+ " "+ EndD;

    // }else {
    //   title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;
    // }



    
    // Determine which modal to use based on method or data attribute
    let modalType = item.data("modal-type") || "applications";



   if (title.toLowerCase().includes("completed"))  {
     modalType = "completed"
   }else {

    modalType = item.data("modal-type") || "applications";

   }


    
    if (modalType === "completed") {
        modal = $("#completedapplicationsModal");
    } else if (modalType === "new") {
        modal = $("#newApplicationModal");
    }
    
    // Set modal title
    modal.find(".modal-title").html(
        `${type} ${title} <span class="text-primary">${date}</span>`
    );
    
    // Show loading state
    modal.find("table tbody").html('<tr><td colspan="8" class="text-center"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></td></tr>');
    
    // Prepare AJAX request
    let action = method + (period ? "_" + period : "") + (by ? "_" + by : "") + "_applications";
    
    let requestData = {};
    requestData[key] = value;
    
    // Get staff data if available
    let staff = null;
    try {
        staff = JSON.parse(item.data("staff"));
    } catch (e) {
        staff = item.data("staff");
    }
    
    // Show modal
    let bsModal = new bootstrap.Modal(modal[0]);
    bsModal.show();

       console.log(action);

    
    // Make AJAX request
    submitAjax(url, action, requestData, function (data) {

        console.log(data);

      data = data.apps_with_staff || data.apps_at_division || [];

        function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }


        let applicationsData = data.map(function (app) {
              let actionButton = `            
             <td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(app.job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Track
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
						
					

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="viewApplicationDetails('${app.job_number}','${app.transaction_number}','${app.case_number}','${app.business_process_sub_name}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
							

						</ul>
					</div>
				</td>`;

            // console.log(staff)
            
            // Add send message button if staff data is available
            if (staff && staff.staff_id) {
                // actionButton += ` <button class="btn btn-sm btn-outline-warning sendMessage_unit_case" data-receiver_name="${staff.staff}" data-officer_name="${staff.staff}" data-officer_id="${staff.staff_id}" data-job_number="${app.job_number}">
                //   <i class="ri-send-plane-line"></i>
                // </button>`;

                actionButton += `
<button 
  class="btn btn-sm btn-outline-warning messageReply"
  data-receiver_name="${staff.staff}" 
  data-officer_name="${staff.staff}" 
  data-officer_id="${staff.staff_id}" 
  data-job_number="${app.job_number}"
  title="Notices & Replies">
    <i class="ri-reply-line"></i>
</button>`;

            }

            function formatDate(dateString) {
                    if (!dateString) return '';

                    // Trim hidden characters
                    const clean = dateString.toString().trim();

                    // Force ISO format
                    const iso = clean.includes('T')
                        ? clean
                        : `${clean}T00:00:00`;

                    const date = new Date(iso);

                    return isNaN(date.getTime())
                        ? ''
                        : date.toLocaleDateString('en-US', {
                            year: 'numeric',
                            month: 'short',
                            day: 'numeric'
                        });
                    }

					

                    const checkbox = `
          <div class="text-center">
            <input type="checkbox" class="app-checkbox" value="${app.job_number}">
          </div>`;

            
            return {
               checkbox :checkbox,
                job_number: app.job_number,
                ar_name: app.ar_name,
                business_process_sub_name: app.business_process_sub_name,
                created_date: formatDate(app.created_date),
                due_date: formatDate(app.due_date),
                // due_date: app.due_date ? new Date(app.due_date).toLocaleDateString() : '',
                // completed_date: app.completed_date ? new Date(app.completed_date).toLocaleDateString() : '',
                completed_date: formatDate(app.completed_date),
                days_due: app.days_due,
                days_since_batched: app.days_since_batched || '',
                job_purpose: app.job_purpose || '',
                action: actionButton
            };
        });
        
        // Define columns based on modal type
        let columns = [];
        
        if (modalType === "completed") {
            columns = [
                { 
                  data: "job_number",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "ar_name",
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "business_process_sub_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "created_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  }
                },
                { 
                  data: "completed_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  }
                },
                { 
                  data: "days_due" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return `<div class="d-flex justify-content-end gap-2">${data}</div>`;
                    }
                }
            ];
        } else if (modalType === "new") {
            columns = [
                { 
                  data: "job_number",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "ar_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "business_process_sub_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "created_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  } 
                },
                { 
                  data: "due_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  }
                },
                { 
                  data: "days_due" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "days_since_batched" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "job_purpose" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return  `<div class="d-flex justify-content-end gap-2">${data}</div>`;
                    }
                }
            ];
        } else {
            columns = [
                { 
                  data: "checkbox",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "job_number",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "ar_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "business_process_sub_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "created_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  } 
                },
                { 
                  data: "due_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  } 
                },
                { 
                  data: "days_due" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "days_since_batched" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return `<div class="d-flex justify-content-end gap-2">${data}</div>`;
                    }
                }
            ];
        }
        
        // Initialize DataTable
        let tableId = modalType === "completed" ? "#completedApplicationsTable" : 
                     modalType === "new" ? "#newApplicationsTable" : "#applicationsTable";
        
        // initializeApplicationsDataTable(tableId, columns, applicationsData);
                initializeApplicationsDataTable(
    tableId,
    columns,
    applicationsData,
    `${type} ${title} ${date}`
);
        
        // Add send message button to modal header if staff data exists
        if (staff && staff.staff_id) {
            let sendMessageBtn = $(`
                <button class="btn btn-primary ms-auto sendMessage" 
                        data-officer_id="${staff.staff_id}"
                        data-receiver_name="${staff.staff || 'Officer'}"
                        data-officer_name="${staff.staff || 'Officer'}"
                  >
                    <i class="bi bi-chat-text"></i> Send Message to All
                </button>
            `);
            
            // Remove existing send message button if any
            modal.find(".sendMessage").remove();
            
            // Add new button to modal header
            modal.find(".modal-header").append(sendMessageBtn);
        }
    });
});




  // Helper function to format date
  function formatDate(dateString) {
    if (!dateString) return '';

    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }



function initializeApplicationsDataTable(tableId, columns, data, title_) {

    // Destroy existing DataTable if it exists
    if ($.fn.DataTable.isDataTable(tableId)) {
        $(tableId).DataTable().destroy();
    }

    return $(tableId).DataTable({
        responsive: true,
        data: data,
        columns: columns,
        order: [[1, "desc"]],

        // ✅ CENTRALIZED BUTTONS
        buttons: getServiceTypeButtons(title_),

        dom: '<"row"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
             '<"row"<"col-sm-12"tr>>' +
             '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',

        pageLength: 10,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            paginate: {
                first: "First",
                last: "Last",
                next: "Next",
                previous: "Previous"
            }
        }
    });
}







  $(document).off('click', '.sendMessageCST').on('click', '.sendMessageCST', function (event) {

    // $(document).on("click", ".sendMessage", function (event) {
  event.preventDefault();

  const table = $("#cst_apps_with_staff_details_table").DataTable();

  // ✅ Collect all selected rows using existing checkboxes
  const selectedRows = [];
  $(".app-checkbox:checked").each(function () {
    const row = $(this).closest("tr");
    const rowData = table.row(row).data();

		console.log(rowData);

    // Assuming DataTable columns: [checkbox, job_number, ar_name, ...]
    const jobNumber = rowData.job_number || rowData[1];
    const arName = rowData.ar_name || rowData[2];
    // const pendingDays = rowData.days_due || rowData[5];

    selectedRows.push({
      job_number: jobNumber,
      ar_name: arName,
    //   pendindays: pendingDays,
    });
  });

  // ✅ If nothing selected, show professional alert and stop
  if (selectedRows.length === 0) {
    Swal.fire({
      icon: "warning",
      title: "No Applications Selected",
      text: "Please select at least one application before sending a message.",
      confirmButtonColor: "#0d6efd",
      confirmButtonText: "OK",
    });
    return;
  }

  // ✅ Get staff details
  const staff = $(this).data("receiver_name");
  const staffid = $(this).data("officer_id");


  //  data-receiver_name="${StaffName}" 
  //                data-officer_name="${StaffName}"
  //                 data-receiver_name="${StaffName}"
  //                 data-="${staffID}"> 

  console.log(staff);

  // ✅ Populate modal hidden fields
  const sendMessageModal = $("#sendMessageModal");
  sendMessageModal.find("#officer_id").val(staffid);
  sendMessageModal.find("#officer_name").val(staff);
  sendMessageModal.find("#job_numbers").val(JSON.stringify(selectedRows));



  //  console.log(data);
    
        // Update modal title
    const titleText = staff ? 
        `Send Message to <span class="text-primary">${staff}</span>` : 
        'Send Message';
    sendMessageModal.find("#modalTitleText").html(titleText);
    
    // Update recipient info card
    if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else {
        sendMessageModal.find("#recipientNameDisplay").text('Select a recipient');
    }
    
    // Update recipient info
    if (staffid) {
        sendMessageModal.find("#recipientInfo").text(`ID: ${staffid}`);
    } else {
        sendMessageModal.find("#recipientInfo").text('No ID available');
    }
    
    // Update job count badge
    const jobCount = Array.isArray(selectedRows) ? selectedRows.length : 0;
    sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
    
    // Reset form to clean state    
    // Show the modal (Bootstrap 5)
    // const bsModal = new bootstrap.Modal(modal);
    // bsModal.show();



  

  // ✅ Build HTML table for selected applications
  let selectedTable = `
    <div class="alert alert-info shadow-sm">
      <strong>Selected Applications (${selectedRows.length}):</strong>
      <div class="table-responsive mt-2">
        <table class="table table-sm table-bordered align-middle mb-0">
          <thead class="table-light">
            <tr>
              <th>Job Number</th>
              <th>Created Date</th>
            </tr>
          </thead>
          <tbody>
            ${selectedRows
              .map(
                (item) => `
              <tr>
                <td><code>${item.job_number}</code></td>
                <td>${item.ar_name}</td>
              </tr>
            `
              )
              .join("")}
          </tbody>
        </table>
      </div>
    </div>
  `;

  // ✅ Replace previous list/table if reopening
  sendMessageModal.find(".modal-body .alert-info").remove();
  sendMessageModal.find(".rec-table").prepend(selectedTable);

  // ✅ Update modal title and show
  sendMessageModal
    .find("#sendMessageModalLabel")
    .html(`Send Message To <span class="text-primary">${staff}</span>`);

  sendMessageModal.modal("show");


    resetMessageForm();

});




  $(document).off('click', '.sendMessageCSTUnit').on('click', '.sendMessageCSTUnit', function (event) {

    // $(document).on("click", ".sendMessage", function (event) {
  event.preventDefault();

  const table = $("#cst_unit_summary_details_table").DataTable();

  // ✅ Collect all selected rows using existing checkboxes
  const selectedRows = [];
  $(".app-checkbox:checked").each(function () {
    const row = $(this).closest("tr");
    const rowData = table.row(row).data();

		console.log(rowData);

    // Assuming DataTable columns: [checkbox, job_number, ar_name, ...]
    const jobNumber = rowData.job_number || rowData[1];
    const arName = rowData.ar_name || rowData[2];
    // const pendingDays = rowData.days_due || rowData[5];

    selectedRows.push({
      job_number: jobNumber,
      ar_name: arName,
    //   pendindays: pendingDays,
    });
  });

  // ✅ If nothing selected, show professional alert and stop
  if (selectedRows.length === 0) {
    Swal.fire({
      icon: "warning",
      title: "No Applications Selected",
      text: "Please select at least one application before sending a message.",
      confirmButtonColor: "#0d6efd",
      confirmButtonText: "OK",
    });
    return;
  }

  // ✅ Get staff details
  const staff = $(this).data("receiver_name");
  const staffid = $(this).data("officer_id");


  //  data-receiver_name="${StaffName}" 
  //                data-officer_name="${StaffName}"
  //                 data-receiver_name="${StaffName}"
  //                 data-="${staffID}"> 

  console.log(staff);

  // ✅ Populate modal hidden fields
  const sendMessageModal = $("#sendMessageModal");
  sendMessageModal.find("#officer_id").val(staffid);
  sendMessageModal.find("#officer_name").val(staff);
  sendMessageModal.find("#job_numbers").val(JSON.stringify(selectedRows));



  //  console.log(data);
    
        // Update modal title
    const titleText = staff ? 
        `Send Message to <span class="text-primary">${staff}</span>` : 
        'Send Message';
    sendMessageModal.find("#modalTitleText").html(titleText);
    
    // Update recipient info card
    if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else {
        sendMessageModal.find("#recipientNameDisplay").text('Select a recipient');
    }
    
    // Update recipient info
    if (staffid) {
        sendMessageModal.find("#recipientInfo").text(`ID: ${staffid}`);
    } else {
        sendMessageModal.find("#recipientInfo").text('No ID available');
    }
    
    // Update job count badge
    const jobCount = Array.isArray(selectedRows) ? selectedRows.length : 0;
    sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
    
    // Reset form to clean state    
    // Show the modal (Bootstrap 5)
    // const bsModal = new bootstrap.Modal(modal);
    // bsModal.show();



  

  // ✅ Build HTML table for selected applications
  let selectedTable = `
    <div class="alert alert-info shadow-sm">
      <strong>Selected Applications (${selectedRows.length}):</strong>
      <div class="table-responsive mt-2">
        <table class="table table-sm table-bordered align-middle mb-0">
          <thead class="table-light">
            <tr>
              <th>Job Number</th>
              <th>Created Date</th>
            </tr>
          </thead>
          <tbody>
            ${selectedRows
              .map(
                (item) => `
              <tr>
                <td><code>${item.job_number}</code></td>
                <td>${item.ar_name}</td>
              </tr>
            `
              )
              .join("")}
          </tbody>
        </table>
      </div>
    </div>
  `;

  // ✅ Replace previous list/table if reopening
  sendMessageModal.find(".modal-body .alert-info").remove();
  sendMessageModal.find(".rec-table").prepend(selectedTable);

  // ✅ Update modal title and show
  sendMessageModal
    .find("#sendMessageModalLabel")
    .html(`Send Message To <span class="text-primary">${staff}</span>`);

  sendMessageModal.modal("show");


    resetMessageForm();

});






$(document).off('click', '.sendMessageCSS').on('click', '.sendMessageCSS', function (event) {
  event.preventDefault();

  const table = $("#applicationsTable").DataTable();

  // // ✅ Collect all selected rows using existing checkboxes
  // const selectedRows = [];
  // $(".app-checkbox:checked").each(function () {
  //   const row = $(this).closest("tr");
  //   const rowData = table.row(row).data();

  //   // Assuming DataTable columns: [checkbox, job_number, ar_name, ...]
  //   const jobNumber = rowData.job_number || rowData[1];
  //   const arName = rowData.ar_name || rowData[2];
  //   const pendingDays = rowData.days_due || rowData[5];

  //   selectedRows.push({
  //     job_number: jobNumber,
  //     ar_name: arName,
  //     pendindays: pendingDays,
  //   });
  // });

  // // ✅ If nothing selected, show professional alert and stop
  // if (selectedRows.length === 0) {
  //   Swal.fire({
  //     icon: "warning",
  //     title: "No Applications Selected",
  //     text: "Please select at least one application before sending a message.",
  //     confirmButtonColor: "#0d6efd",
  //     confirmButtonText: "OK",
  //   });
  //   return;
  // }

  // ✅ Get staff details
  const staff = $(this).data("staff");
  const staffid = $(this).data("staff_id");
  const JObNumber = $(this).data("job-number");


  //  data-receiver_name="${StaffName}" 
  //                data-officer_name="${StaffName}"
  //                 data-receiver_name="${StaffName}"
  //                 data-="${staffID}"> 

  console.log(staff,JObNumber);
  const jobArray = JObNumber.split(",");

// Convert to required JSON structure
const formattedJobs = jobArray.map(job => ({
    job_number: job.trim(),
}));



  // ✅ Populate modal hidden fields
  const sendMessageModal = $("#sendMessageModal");
  sendMessageModal.find("#officer_id").val(staffid);
  sendMessageModal.find("#officer_name").val(staff);
  sendMessageModal.find("#job_numbers").val(JSON.stringify(formattedJobs));

  // sendMessageModal.find("#job_numbers").val(JSON.stringify(selectedRows));



  //  console.log(data);
    
        // Update modal title
    const titleText = staff ? 
        `Send Message to <span class="text-primary">${staff}</span>` : 
        'Send Message';
    sendMessageModal.find("#modalTitleText").html(titleText);
    
    // Update recipient info card
    if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else {
        sendMessageModal.find("#recipientNameDisplay").text('Select a recipient');
    }
    
    // Update recipient info
    if (staffid) {
        sendMessageModal.find("#recipientInfo").text(`ID: ${staffid}`);
    } else {
        sendMessageModal.find("#recipientInfo").text('No ID available');
    }
    
    // Update job count badge
    // const jobCount = Array.isArray(selectedRows) ? selectedRows.length : 0;
    // sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
        // Update job count badge
        const jobNumber = $(this).data("job-number");
        const jobCount = jobNumber ? jobNumber.split(",").length : 0;
        sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
    
    // Reset form to clean state    
    // Show the modal (Bootstrap 5)
    // const bsModal = new bootstrap.Modal(modal);
    // bsModal.show();



  

  // // ✅ Build HTML table for selected applications
  // let selectedTable = `
  //   <div class="alert alert-info shadow-sm">
  //     <strong>Selected Applications (${selectedRows.length}):</strong>
  //     <div class="table-responsive mt-2">
  //       <table class="table table-sm table-bordered align-middle mb-0">
  //         <thead class="table-light">
  //           <tr>
  //             <th>Job Number</th>
  //             <th>Applicant Name</th>
  //             <th>Pending Days</th>
  //           </tr>
  //         </thead>
  //         <tbody>
  //           ${selectedRows
  //             .map(
  //               (item) => `
  //             <tr>
  //               <td><code>${item.job_number}</code></td>
  //               <td>${item.ar_name}</td>
  //                <td>${item.pendindays}</td>
  //             </tr>
  //           `
  //             )
  //             .join("")}
  //         </tbody>
  //       </table>
  //     </div>
  //   </div>
  // `;

  // // ✅ Replace previous list/table if reopening
  // sendMessageModal.find(".modal-body .alert-info").remove();
  // sendMessageModal.find(".rec-table").prepend(selectedTable);

  // ✅ Update modal title and show
  sendMessageModal
    .find("#sendMessageModalLabel")
    .html(`Send Message To <span class="text-primary">${staff}</span>`);

  sendMessageModal.modal("show");


    resetMessageForm();

});




// Reset message form function
function resetMessageForm() {
    // const form = $('#message-form')[0];
    // if (form) {
    //     form.reset();
    // }
    
    // Reset character count
    $('#charCount').text('0/1000 characters').removeClass('warning danger');
    
    // Reset preview
    $('#messagePreview').html('<small class="text-muted">Start typing to see preview</small>');
    $('#previewCard').hide();
    
    // Set default message type to "query" (since this is for compliance)
    $('#message_type_query').prop('checked', true);
    updateSubmitButton();
    
    // Clear any validation states
    $('.form-control').removeClass('is-invalid is-valid');
    $('#message-form').removeClass('was-validated');
    
    // Clear the message textarea
    $('#message').val('');
}



// Update submit button text based on message type
function updateSubmitButton() {
    const messageType = $('input[name="message_type"]:checked').val();
    let buttonText = 'Send Message';
    
    switch(messageType) {
        case 'query':
            buttonText = 'Send Query';
            break;
        case 'reminder':
            buttonText = 'Send Reminder';
            break;
        case 'message':
        default:
            buttonText = 'Send Message';
    }
    
    $('#submitButtonText').text(buttonText);
}



  $(document).on('change', '#select-all', function() {
  const isChecked = $(this).is(':checked');
  $('.app-checkbox').prop('checked', isChecked);
});

// Handle individual checkbox changes (optional)
$(document).on('change', '.app-checkbox', function() {
  if (!$(this).is(':checked')) {
    $('#select-all').prop('checked', false);
  } else if ($('.app-checkbox:checked').length === $('.app-checkbox').length) {
    $('#select-all').prop('checked', true);
  }
});




$(document).on('submit', '#message-form', function(e) {
    e.preventDefault();
    
    const form = $(this);
    const officerId = form.find('#officer_id').val();
    const officerName = form.find('#officer_name').val();
    const jobNumbers = form.find('#job_numbers').val();
    const messageType = form.find('input[name="message_type"]:checked').val();
    const message = form.find('#message').val().trim();

     console.log(form);
      console.log(officerId);
       console.log(officerName);
        console.log(messageType);
         console.log(message);
          console.log(jobNumbers);
    
    // Validation
    if (!message) {
        Swal.fire({
            title: 'Message Required',
            text: 'Please enter a message to send.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    if (!officerId) {
        Swal.fire({
            title: 'No Recipient',
            text: 'No recipient selected for the message.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    // Parse job numbers
    let jobNumbersArray;
    try {
        jobNumbersArray = JSON.parse(jobNumbers);
    } catch (error) {
        console.error('Error parsing job numbers:', error);
        jobNumbersArray = [];
    }
    
    if (jobNumbersArray.length === 0) {
        Swal.fire({
            title: 'No Applications',
            text: 'No applications selected to send message for.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    // Prepare confirmation message
    const jobCount = jobNumbersArray.length;
    const confirmationMessage = `
        <div class="text-start">
            <p>You are about to send a <strong>${messageType}</strong> to:</p>
            <ul class="mb-2">
                <li><strong>${officerName}</strong></li>
                <li><strong>${jobCount}</strong> application(s)</li>
            </ul>
            <div class="alert alert-light border small mt-3">
                <i class="ri-information-line me-1"></i>
                Message: "${message.substring(0, 100)}${message.length > 100 ? '...' : ''}"
            </div>
        </div>
    `;
    
    // Show confirmation dialog
    Swal.fire({
        title: 'Send Message?',
        html: confirmationMessage,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, Send Message',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#0d6efd',
        cancelButtonColor: '#6c757d',
        reverseButtons: true,
        showLoaderOnConfirm: true,
        preConfirm: () => {
            return new Promise((resolve, reject) => {
                // const formData = form.serialize();

                const formData = {
                  "request_type": $("#sendMessageModal").find("#request_type").val(),
                  "officer_id": officerId,
                  "officer_name": officerName,
                  "job_numbers" : jobNumbers,
                  "message_type" : messageType,
                  "message" : message
                }
                
                $.ajax({
                    type: "POST",
                    url: "SendComplianceMessage",
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response && response.success !== false) {
                            resolve(response);
                        } else {
                            reject(new Error(response?.message || 'Failed to send message'));
                        }
                    },
                    error: function(xhr, status, error) {
                        reject(new Error(`Server error: ${status}`));
                    }
                });
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed) {
            // Success handling
            const response = result.value;
            
            Swal.fire({
                title: 'Success!',
                html: `
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="ri-checkbox-circle-line text-success" style="font-size: 4rem;"></i>
                        </div>
                        <h5 class="fw-semibold">Message Sent Successfully</h5>
                        <p class="text-muted">
                            Your ${messageType} has been sent to ${officerName}
                        </p>
                        ${response?.message_id ? `
                        <div class="alert alert-light border small mt-3">
                            <i class="ri-information-line me-1"></i>
                            Reference ID: <strong>${response.message_id}</strong>
                        </div>
                        ` : ''}
                    </div>
                `,
                icon: 'success',
                confirmButtonText: 'Done',
                confirmButtonColor: '#0d6efd',
                timer: 4000,
                timerProgressBar: true,
                willClose: () => {
                    // Close the modal after success
                    const modal = bootstrap.Modal.getInstance(document.getElementById('sendMessageModal'));
                    if (modal) {
                        modal.hide();
                    }
                    
                    // Reset the form for next use
                    resetMessageForm();
                }
            });
            
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Swal.fire({
                title: 'Cancelled',
                text: 'Message was not sent.',
                icon: 'info',
                confirmButtonText: 'OK',
                confirmButtonColor: '#6c757d',
                timer: 2000
            });
        }
    }).catch((error) => {
        // Error handling
        console.error('Error sending message:', error);
        
        Swal.fire({
            title: 'Sending Failed',
            html: `
                <div class="text-center">
                    <div class="mb-3">
                        <i class="ri-error-warning-line text-danger" style="font-size: 4rem;"></i>
                    </div>
                    <h5 class="fw-semibold">Unable to Send Message</h5>
                    <p class="text-muted">
                        ${error.message || 'An unexpected error occurred. Please try again.'}
                    </p>
                    <div class="mt-3">
                        <button class="btn btn-outline-secondary me-2" onclick="Swal.close()">
                            Close
                        </button>
                        <button class="btn btn-primary" onclick="retrySendMessage()">
                            <i class="ri-refresh-line me-1"></i> Try Again
                        </button>
                    </div>
                </div>
            `,
            icon: 'error',
            showConfirmButton: false,
            showCancelButton: false
        });
    });
    
    return false;
});

// Retry function for error case
function retrySendMessage() {
    Swal.close();
    // Trigger form submission again after a delay
    setTimeout(() => {
        $('#message-form').trigger('submit');
    }, 500);
}






$(document).ready(function() {
    // Character counter
    $('#message').on('input', function() {
        const length = $(this).val().length;
        $('#charCount').text(`${length}/1000 characters`);
        
        // Update character count styling
        $('#charCount').removeClass('warning danger');
        if (length > 800) {
            $('#charCount').addClass('warning');
        }
        if (length > 950) {
            $('#charCount').addClass('danger');
        }
        
        // Update preview
        updateMessagePreview();
    });
    
    // Template buttons
    $('.template-btn').on('click', function() {
        const template = $(this).data('template');
        insertTemplate(template);
    });
    
    // Message type radio buttons
    $('input[name="message_type"]').on('change', function() {
        updateMessagePreview();
        updateSubmitButton();
    });
    
    // Reset form button
    $('#btnResetForm').on('click', function() {
        resetMessageForm();
    });
});

// Helper function to update message preview
function updateMessagePreview() {
    const message = $('#message').val();
    const messageType = $('input[name="message_type"]:checked').val();
    const recipient = $('#recipientNameDisplay').text() || 'Recipient';
    
    let preview = '';
    
    if (message) {
        preview = `<strong>To:</strong> ${recipient}\n`;
        preview += `<strong>Type:</strong> ${messageType || 'Message'}\n\n`;
        preview += message.substring(0, 200);
        
        if (message.length > 200) {
            preview += '...';
        }
        
        // Show preview card
        $('#previewCard').show();
    } else {
        preview = '<small class="text-muted">Start typing to see preview</small>';
        $('#previewCard').hide();
    }
    
    $('#messagePreview').html(preview.replace(/\n/g, '<br>'));
}

// Helper function to insert template text
function insertTemplate(template) {
    const templates = {
        query: "Dear Officer,\n\nPlease provide an update on the status of the application mentioned above. This requires urgent attention.\n\nBest regards,\n[Your Name]",
        followup: "Dear Officer,\n\nFollowing up on the previous communication regarding this application. Please advise on the current status and any pending actions.\n\nRegards,\n[Your Name]",
        reminder: "Dear Officer,\n\nThis is a reminder that the application is approaching/passed its TAT deadline. Kindly expedite action to avoid further delays.\n\nThank you,\n[Your Name]",
        update: "Dear Officer,\n\nPlease update the status of this application in the system as soon as possible. If there are any issues, please let us know immediately.\n\nSincerely,\n[Your Name]"
    };
    
    const $textarea = $('#message');
    const currentText = $textarea.val();
    const templateText = templates[template] || '';
    
    // Insert template, preserving existing text
    if (currentText && !currentText.includes(templateText)) {
        $textarea.val(currentText + '\n\n' + templateText);
    } else if (!currentText) {
        $textarea.val(templateText);
    }
    
    // Trigger input event for character count and preview
    $textarea.trigger('input');
    
    // Show success notification
    Swal.fire({
        title: 'Template Inserted',
        text: `"${template}" template has been inserted`,
        icon: 'success',
        confirmButtonText: 'OK',
        confirmButtonColor: '#0d6efd',
        timer: 2000
    });
}










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