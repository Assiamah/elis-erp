$(document).ready(function() {
					
	$('#appsCompletedMonthModal').on('shown.bs.modal', function (e) {
		let table = $("#report_dashboard_apps_comp_month_by_user_table");
		table.find("tbody tr").remove();
		$
		.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'report_dashboard_apps_comp_month_by_user',
			},
			cache : false,
			success : function(data) {
				//console.log(data);
				try{
						json_p = JSON.parse(data);
					$(json_p).each(function() {
	
						table.append(`<tr><td>${this.job_number}</td>
									 <td>${this.business_process_sub_name}</td>
									 <td>${this.ar_name}</td>
									 <td>${this.created_date}</td>`
	
												);
	
							});
				}catch(e){
					console.log(e);
				}
				
				
			}
		});
		
		
	});
	
	$('#appsReceivedMonthModal').on('shown.bs.modal', function (e) {
		let table = $("#report_dashboard_apps_rec_month_by_user_table");
		table.find("tbody tr").remove();
		$
		.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'report_dashboard_apps_rec_month_by_user',
			},
			cache : false,
			success : function(data) {
				//console.log(data);
				try{
					
					json_p = JSON.parse(data);
					$(json_p).each(function() {

						table.append(`<tr><td>${this.job_number}</td>
									 <td>${this.business_process_sub_name}</td>
									 <td>${this.ar_name}</td>
									 <td>${this.date_created}</td><td>${this.sender_name}</td>`
								

												);

							});
				}catch(e){
					console.log(e);
				}
				
			}
		});
		
		
	});
	
	
	$('#appsPassedDueModal').on('shown.bs.modal', function (e) {
		let table = $("#report_dashboard_apps_past_due_date_by_user_table");
		table.find("tbody tr").remove();
		$
		.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'report_dashboard_apps_past_due_date_by_user',
			},
			cache : false,
			success : function(data) {
				//console.log(data);
				try{
					json_p = JSON.parse(data);
					$(json_p).each(function() {
	
						table.append(`<tr><td>${this.job_number}</td>
									 <td>${this.business_process_sub_name}</td>
									 <td>${this.ar_name}</td>
									 <td>${this.modified_date}</td>
									 <td>
									 
									 <form action="registration_application_progress_details" method="post">
										<input type="hidden" name="case_number" id="case_number" value="${this.case_number}">
										<input type="hidden" name="transaction_number" id="transaction_number" value="${this.transaction_number}">
										<input type="hidden" name="job_number" id="job_number" value="${this.job_number}">
										<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${this.modified_date}">
										
											<button type="submit" name="save" class="btn btn-info btn-icon-split">
											<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
											</button>
									</form>
									 </td>`
												);
	
							});
					
					
					
				}catch(e){
					console.log(e);
				}
				
			}
		});
		
		
	});


	$('#corpappsPassedDueModal').on('shown.bs.modal', function (e) {
		let table = $("#report_dashboard_corp_apps_past_due_date_by_user_table");
		table.find("tbody tr").remove();
		$
		.ajax({
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'report_dashboard_corp_apps_past_due_date_by_user',
			},
			cache : false,
			success : function(data) {
				//console.log(data);
				try{
					json_p = JSON.parse(data);
					$(json_p).each(function() {
	
						table.append(`<tr><td>${this.job_number}</td>
									 <td>${this.business_process_sub_name}</td>
									 <td>${this.ar_name}</td>
									 <td>${this.modified_date}</td>
									 <td>
									 
									 <form action="registration_application_progress_details" method="post">
										<input type="hidden" name="case_number" id="case_number" value="${this.case_number}">
										<input type="hidden" name="transaction_number" id="transaction_number" value="${this.transaction_number}">
										<input type="hidden" name="job_number" id="job_number" value="${this.job_number}">
										<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${this.modified_date}">
										
											<button type="submit" name="save" class="btn btn-info btn-icon-split">
											<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
											</button>
									</form>
									 </td>`
												);
	
							});
					
					
					
				}catch(e){
					console.log(e);
				}
				
			}
		});
		
		
	});

	//End function document ready
});