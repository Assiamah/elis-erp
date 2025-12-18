$(function(){
	
	$("#enquiry_tab").hide();
	
	 $("#addTicketModal").on('shown.bs.modal', function() {
			
		let complainant_name=$('input[name="complainant_name"]').val();
		let complainant_phone=$('input[name="complainant_phone"]').val();
		let complainant_email=$('input[name="complainant_email"]').val();
		
		$('input[name="ticket_name"]').val(complainant_name);
		$('input[name="ticket_email"]').val(complainant_email);
		$('input[name="ticket_tel"]').val(complainant_phone);
		
		})
		
		
		/// Submit ticket
		$("#ticketForm").on('submit',function(e){
			e.preventDefault();
		
			$("#save_btn").prop('disabled', true);
			$("#save_btn").text("Please wait ...");
			
			
			let complainant_name=$('input[name="ticket_name"]').val();
			let complainant_phone=$('input[name="ticket_tel"]').val();
			let complainant_email=$('input[name="ticket_email"]').val();
			let subject=$('input[name="subject"]').val();
			let description=$('#description').val();
			let contact_type=$('#contact_type').find(":selected").text();
			let complaint_type=$('#complaint_type').find(":selected").text();
			let priority=$('#priority').find(":selected").text();
			let related_service=$('#related_service').find(":selected").text();
			let service_number=$('input[name="service_number"]').val();
			let request_by=$('input[name="request_by"]').val();
			let request_by_id=$('input[name="request_by_id"]').val();
			
			
		$.ajax({
			type:"POST",
			url:"clients_serv",
			data:{"request_type":"open_ticket",
				  "complainant_name":complainant_name,
				  "complainant_phone":complainant_phone,
				  "complainant_email":complainant_email,
				  "subject":subject,
				  "description":description,
				  "contact_type":contact_type,
				  "complaint_type":complaint_type,
				  "priority":priority,
				  "related_service":related_service,
				  "service_number":service_number,
				   "request_by":request_by,
			  		"request_by_id":request_by_id
			},
			success:function(response){
			  console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket Added successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Adding Ticket", "CICA");
                 }

                    $("#addTicketModal").find('form').trigger('reset');
                    $("#addTicketModal").modal('hide');
                    
                    $("#save_btn").prop('disabled', false);
					$("#save_btn").text("Save")
                  
			}	
		})
	}) 
	 

	$('#trackingModal').on('show.bs.modal',function(event) {
			var job_number = $(event.relatedTarget)
					.data('target-id') 

			$('#sms-tracking').DataTable().clear().destroy();
			$('#case-query').DataTable().clear().destroy();

			var table = $('#app-tracking');
			table.find("tbody tr").remove();

			$("#enq_applicant_name").val("");
			$("#enq_applicant_type").val("");
			$("#enq_cabinet_name").val("");
			// $("#enq_job_purpose").val(this.job_purpose);
			$("#enq_job_status").val("");

			let purpose = parseInt($('#purpose').find(":selected").val());

			//console.log(job_number);

			$('input[name="reference_id"]').val(job_number);

			var table_ = $('#cabinet-tracking');
										table_.find("tbody tr").remove();

										function CallA() {

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
														var json_q = JSON
																.parse(jobdetails);

														// console.log();
														$(
															json_q.cabinet_tracking)
																.each(
																		function() {

																			table_
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

														// $(json_q.cabinet_data)
														// 		.each(
														// 				function() {

														// 					$(
														// 							"#enq_applicant_name")
														// 							.val(
														// 									this.ar_name);
														// 					$(
														// 							"#enq_applicant_type")
														// 							.val(
														// 									this.business_process_sub_name);
														// 					$(
														// 							"#enq_cabinet_name")
														// 							.val(
														// 									this.file_number);
														// 					$(
														// 							"#enq_job_purpose")
														// 							.val(
														// 									this.job_purpose);
														// 					$(
														// 							"#enq_job_status")
														// 							.val(
														// 									this.job_status);

														// 					$(
														// 							"#enq_current_application_status")
														// 							.val(
														// 									this.current_application_status);

														// 				});

														var cabinet_status = json_q.cabinet_tracking[json_q.cabinet_tracking.length-1].officers_general_comments

														console.log(cabinet_status);

														sessionStorage.setItem("cabinet_status", cabinet_status)

														// if(cabinet_status.includes('cabinet') || cabinet_status.includes('collected') ) {

														// 	let html = "";
															
														// 	$('#priority').val('Low')
														// 	$('#case_query').addClass('d-none');
															

														// 	$('#within_time_frame').val(1)
														// 	$('#case_query').addClass('d-none');

														// 	html=`<div class="row mb-3">
														// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Provide Milestone Status To Enquirer</b><span class="text-danger">*</span>:</label>
														// 		<div class="col-sm-8">
														// 			<textarea class="form-control" name="milestone_status" id="milestone_status" required></textarea>
														// 		</div>
														// 		</div>`;
															
														// 	document.getElementById("tab_extra2").innerHTML =html;
														// 	$("#submitBtn").prop('disabled', false);

														// 	let	app_status = ""
														// 	app_status = "Completed"
								
														// 	document.getElementById('app_status').innerHTML = app_status;

														// }
														CallB();

													}
													

													
												});

											}


						function CallB(){

			$.ajax({
						type : "POST",
						url : "Case_Management_Serv",
						data : {
							request_type : 'load_application_milestone_for_tracking_by_job',
							job_number : job_number
						},
						cache : false,
						success : function(
								jobdetails) {

							console.log(jobdetails);
							var json_p = JSON.parse(jobdetails);

							var case_number = json_p.application_details[0].case_number
							console.log(case_number);
							$("#cs_main_case_number").val(case_number);

							var is_completed = false;
							//console.log(is_completed);

							var cabinet_status = sessionStorage.getItem("cabinet_status");

							if(cabinet_status.includes('cabinet') || cabinet_status.includes('collected') ) {
								is_completed = true;
							}
							
							let total_required_days = 0;
							for(var i = 0; i < json_p.milestones.length; i++) {
								total_required_days = total_required_days + parseFloat(json_p.milestones[i].working_day_required);
								//console.log(json_p.milestones[i].working_day_required);
							}

							let query_status = "0";

							if(json_p.case_query != null) {
								query_status = json_p.case_query[0].status

								//console.log("query text")
							}

							console.log(query_status)

							//console.log(total_required_days);
							//console.log(json_p.application_details[0].created_date);

							let days_passed = 0;
							let reminder = 0
							var startDate = json_p.application_details[0].created_date;
							startDate = new Date(startDate.replace(/-/g, "/"));
							var endDate = "", noOfDaysToAdd = 5, count = 0;
							while(count < noOfDaysToAdd){
								endDate = new Date(startDate.setDate(startDate.getDate() + 1));
								if(endDate.getDay() != 0 && endDate.getDay() != 6){
								//Date.getDay() gives weekday starting from 0(Sunday) to 6(Saturday)
								count++;
								}
							}

							var nxt_date = '';
						
							var datex = new Date(endDate);
							let day = (datex.getDate());
							let month = ((datex.getMonth()+1));
							let year = datex.getFullYear();
						
							nxt_date = `${month}/${day}/${year}`;
							
							var today = new Date().toJSON().slice(0,10).replace(/-/g,'/');
							var date1 = new Date(today);
							var date2 = new Date(nxt_date);
							var diffDays = parseInt((date1 - date2) / (1000 * 60 * 60 * 24), 10);
							days_passed = diffDays;

							//console.log(days_passed);

							if((purpose == 1 || purpose == 3) && query_status == "0") {
								$('textarea[name="description"]').val('Application pending for '+days_passed+' days since submission.');
								$('#case_query').addClass('d-none');
							}
							// else if((purpose == 1 || purpose == 3) && query_status == "0") {
							// 	$('#description').val('Application pending for '+days_passed+' days since submission.');
							// }

							reminder = (days_passed/total_required_days) * 100;

							//console.log(reminder);

							let app_status = "";

							if(is_completed == true) {
								app_status = "Completed"
							}
							else if(query_status == "1") {
								app_status = "Queried"
								$('#case_query').removeClass('d-none');
								
							} 
							else if(reminder <= 0 && query_status == "0") {
								app_status = "Within TIme Frame"
								$('#case_query').addClass('d-none');
							} 
							else if(reminder > 0 && query_status == "0") {
								app_status = "Delayed"
								$('#case_query').addClass('d-none');
							}

							document.getElementById('app_status').innerHTML = app_status;
							document.getElementById('days_passed').innerHTML = days_passed;

							let html = "";

							if(is_completed == true && purpose == 1) {
								$('#within_time_frame').val(1)
								$('#case_query').addClass('d-none');

								html=`<div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Provide Milestone Status To Enquirer</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										 <textarea class="form-control" name="milestone_status" id="milestone_status"  required="required"></textarea>
									   </div>
									 </div>`;
								
								document.getElementById("tab_extra2").innerHTML =html;
								$("#submitBtn").prop('disabled', false);
							}
							else if(query_status == "1" && purpose == 1){

								$('#within_time_frame').val(0)
								$('#case_query').removeClass('d-none');

								html=`<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
										<select class="form-control" aria-label="Default select example" name="subject" id="subject"  required="required" >
											<option value="" disabled selected>--select--</option>
											<option value="Payment Issues">Payment Issues</option>
											<option value="Delayed">Delayed</option>
											<option value="Upload issues">Upload issues</option>
											<option value="Queried" selected>Queried</option>
											<option value="Other Issues">Other Issues</option>
										</select>
									</div>
								</div>
								<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
									<textarea class="form-control" name="description" id="description" required></textarea>
									</div>
								</div>
								
								<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
									<select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type"  required="required">
										<option value="" disabled selected>-- select --</option>
										<option value="SMS">SMS</option>
									<option value="Email">Email</option>	
									</select>
									</div>
								</div>
								
								<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
									<input class="form-control" type="text"  name="priority" id="priority" required readonly>
									</div>
								</div>
								<div class="row mb-3">
								<label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
								<div class="col-sm-8">
									<select class="form-control" aria-label="Default select example" name="division" id="division" required>
										<option value="" disabled selected>-- select --</option>
										<option value="PVLMD">PVLMD</option>
										<option value="LRD">LRD</option>
										<option value="LVD">LVD</option>	
										<option value="SMD">SMD</option>	
										<option value="CORPORATE">CORPORATE</option>		
									</select>
								</div>
							</div>
							
							<div class="row mb-3">
								<label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
								<div class="col-sm-8">
									<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()"  required="required">
										<option value="" disabled selected>-- select --</option>
										<option value="11">Greater Accra</option>
									<option value="14">Western</option>
									<option value="19">Volta</option>	
									<option value="12">Eastern</option>	
									<option value="13">Ashanti</option>	
									<option value="15">Central</option>	
									<option value="18">Northern</option>	
									<option value="16">Upper East</option>	
									<option value="17">Upper West</option>	
									<option value="10">Tema</option>
									<option value="22">Oti</option>	
									<option value="23">Bono East</option>	
									<option value="24">Ahafo</option>	
									<option value="20">Bono</option>	
									<option value="25">North East </option>	
									<option value="26">Savannah</option>
									<option value="21">Western North</option>	
									</select>
								</div>
							</div>
								<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
									<select class="form-control" id="related_service" name="related_service" required="required">
										<option value="" disabled selected>-- select --</option>
										<option value="Search">Search</option>
										<option value="Stamp Duty">Stamp Duty</option>
										<option value="Concurrence">Concurrence</option>
										<option value="Consent">Consent</option>
										<option value="Plan Approval">Plan Approval</option>
										<option value="Title Registration">Title Registration</option>
										<option value="PVLMD Plotting">PVLMD Plotting</option>
										<option value="Reguralization">Reguralization</option>
										<option value="Certified True Copy">Certified True Copy</option>
										<option value="Dispute">Dispute</option>
										<option value="Composite Plan">Composite Plan</option>
										<option value="General Valuation">General Valuation</option>
										<option value="Compensation">Compensation</option>
										<option value="Deed Registration">Deed Registration</option>
										<option value="Substituted Certificate">Substituted Certificate</option>
										<option value="State Land Rent">State Land Rent</option>
										<option value="Other Services">Other Services</option>
									</select>
									</div>
								</div>
								<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Reference No.</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
									<input type="text" class="form-control required-input" name="reference_id" id="reference_id" value="${job_number}">
									</div>
								</div>`;
								
								document.getElementById("tab_extra2").innerHTML = html;
								$("#submitBtn").prop('disabled', false);
								
							}
						// 	else if(is_completed == true && purpose == 3){
						// 		$('#within_time_frame').val(1)

						// 		html=`<div class="row mb-3">
						// 			   <label for="inputText" class="col-sm-4 col-form-label"><b>Provide Milestone Status To Enquirer</b><span class="text-danger">*</span>:</label>
						// 			   <div class="col-sm-8">
						// 				 <textarea class="form-control" name="milestone_status" id="milestone_status" required></textarea>
						// 			   </div>
						// 			 </div>`;
								
						// 		document.getElementById("tab_extra2").innerHTML = html;
						// 		$("#submitBtn").prop('disabled', false);
						// 		//document.getElementById('service_complainant_div').hidden = true;
						// 		//$('#service_complainant_div').addClass('d-none');
						// 		//document.getElementById('service_complainant_div').style.display = "none";
						// 	}
						// 	else if(is_completed == false && purpose == 3){
						// 		//$('#service_complainant_div')
						// 		//document.getElementById('service_complainant_div').style.display = "block";

						// 		html=`
						// 		<div class="row mb-3">
						// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
						// 		<div class="col-sm-8">
										 
						// 		 <select class="form-control" aria-label="Default select example" name="subject" id="subject" required >
									 
						// 			 <option value="" disabled selected>--select--</option>
						// 			 <option value="Payment Issues">Payment Issues</option>
						// 			 <option value="Delayed">Delayed</option>
						// 			 <option value="Upload issues">Upload issues</option>
						// 			 <option value="Other Issues">Other Issues</option>
						// 		   </select>
						// 		</div>
						// 	  </div>
						// 	  <div class="row mb-3">
						// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
						// 		<div class="col-sm-8">
						// 		  <textarea class="form-control" name="description" id="description" required></textarea>
						// 		</div>
						// 	  </div>
							
						// 	  <div class="row mb-3">
						// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
						// 		<div class="col-sm-8">
						// 		  <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type" required>
						// 			<option disabled selected>-- select --</option>
						// 			<option value="SMS">SMS</option>
						// 			 <option value="Email">Email</option>	
						// 		  </select>
						// 		</div>
						// 	  </div>
							 
						// 	  <div class="row mb-3">
						// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
						// 		<div class="col-sm-8">
						// 		  <input class="form-control" type="text"  name="priority" id="priority" required readonly>
						// 		</div>
						// 	  </div>
						// 	  <div class="row mb-3">
						// 	  <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
						// 	 <div class="col-sm-8">
						// 		 <select class="form-control" aria-label="Default select example" name="division" id="division" required>
						// 			 <option value="" disabled selected>-- select --</option>
						// 			 <option value="PVLMD">PVLMD</option>
						// 			 <option value="LRD">LRD</option>
						// 			 <option value="LVD">LVD</option>	
						// 			 <option value="SMD">SMD</option>	
						// 			 <option value="CORPORATE">CORPORATE</option>		
						// 		   </select>
						// 	 </div>
						//  </div>
						 
						//  <div class="row mb-3">
						// 	 <label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
						// 	 <div class="col-sm-8">
						// 		 <select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()" required>
						// 			 <option disabled selected>-- select --</option>
						// 			 <option value="11">Greater Accra</option>
						// 			 <option value="14">Western</option>
						// 			 <option value="19">Volta</option>	
						// 			 <option value="12">Eastern</option>	
						// 			 <option value="13">Ashanti</option>	
						// 			 <option value="15">Central</option>	
						// 			 <option value="18">Northern</option>	
						// 			 <option value="16">Upper East</option>	
						// 			 <option value="17">Upper West</option>	
						// 			 <option value="10">Tema</option>
						// 			 <option value="22">Oti</option>	
						// 			 <option value="23">Bono East</option>	
						// 			 <option value="24">Ahafo</option>	
						// 			 <option value="20">Bono</option>	
						// 			 <option value="25">North East </option>	
						// 			 <option value="26">Savannah</option>
						// 			 <option value="21">Western North</option>	
						// 		   </select
						// 	 </div>
						//  </div></div>
						 
						// 	  <div class="row mb-3">
						// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
						// 		<div class="col-sm-8">
						// 		  <select class="form-control" id="related_service" name="related_service" required>
						// 			 <option value="" disabled selected>-- select --</option>
						// 			 <option value="Search">Search</option>
						// 			 <option value="Stamp Duty">Stamp Duty</option>
						// 			 <option value="Concurrence">Concurrence</option>
						// 			 <option value="Consent">Consent</option>
						// 			 <option value="Plan Approval">Plan Approval</option>
						// 			 <option value="Title Registration">Title Registration</option>
						// 			 <option value="PVLMD Plotting">PVLMD Plotting</option>
						// 			 <option value="Reguralization">Reguralization</option>
						// 			 <option value="Certified True Copy">Certified True Copy</option>
						// 			 <option value="Dispute">Dispute</option>
						// 			 <option value="Composite Plan">Composite Plan</option>
						// 			 <option value="General Valuation">General Valuation</option>
						// 			 <option value="Compensation">Compensation</option>
						// 			 <option value="Deed Registration">Deed Registration</option>
						// 			 <option value="Substituted Certificate">Substituted Certificate</option>
						// 			 <option value="State Land Rent">State Land Rent</option>
						// 			 <option value="Other Services">Other Services</option>
						// 		 </select>
						// 		</div>
						// 	  </div>
						// 	  <div class="row mb-3">
						// 		<label for="inputText" class="col-sm-4 col-form-label"><b>Reference No.</b><span class="text-danger">*</span>:</label>
						// 		<div class="col-sm-8">
						// 		  <input type="text" class="form-control required-input" name="reference_id" id="reference_id" value="${job_number}" >
						// 		</div>
						// 	  </div>
						// 			`;
								
						// 		document.getElementById("tab_extra2").innerHTML = html;
						// 		$("#submitBtn").prop('disabled', false);
						// 	}
							else if(query_status == "1" && purpose == 3){

								$('#within_time_frame').val(1)

								html=`
									<option value="" disabled selected>--select--</option>
												<option value="Payment Issues">Payment Issues</option>
												<option value="Delayed">Delayed</option>
												<option value="Upload issues">Upload issues</option>
												<option value="Queried" selected>Queried</option>
												<option value="Other Issues">Other Issues</option>
								`;

								document.getElementById('subject').innerHTML = html;
								
								//document.getElementById("tab_extra2").innerHTML =html;
								//$("#submitBtn").prop('disabled', false);

								$('#case_query').removeClass('d-none');
								
							}
							else if(reminder <= 0 && purpose == 1){

								$('#within_time_frame').val(1)
								$('#case_query').addClass('d-none');

								html=`<div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Provide Milestone Status To Enquirer</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										 <textarea class="form-control" name="milestone_status" id="milestone_status"  required="required"></textarea>
									   </div>
									 </div>`;
								
								document.getElementById("tab_extra2").innerHTML =html;
								$("#submitBtn").prop('disabled', false);
								
							}
							else if((reminder > 0 && purpose == 1) && query_status == "0"){

								$('#within_time_frame').val(0)
								$('#case_query').addClass('d-none');

								html=`
									 <div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
											<select class="form-control" aria-label="Default select example" name="subject" id="subject"  required="required" >
												<option value="" disabled selected>--select--</option>
												<option value="Payment Issues">Payment Issues</option>
												<option value="Delayed">Delayed</option>
												<option value="Upload issues">Upload issues</option>
												<option value="Queried">Queried</option>
												<option value="Other Issues">Other Issues</option>
											</select>
									   </div>
									 </div>
									 <div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										 <textarea class="form-control" name="description" id="description"  required="required">Application pending for ${days_passed} days since submission.</textarea>
									   </div>
									 </div>
								   
									 <div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										 <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type"  required="required">
										   <option  value="" disabled selected>-- select --</option>
										   <option value="SMS">SMS</option>
										<option value="Email">Email</option>	
										 </select>
									   </div>
									 </div>
									
									 <div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										<input class="form-control" type="text"  name="priority" id="priority" required readonly  required="required">
									   </div>
									 </div>
									 <div class="row mb-3">
									  <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
									<div class="col-sm-8">
										<select class="form-control" aria-label="Default select example" name="division" id="division" required>
											<option value="" disabled selected>-- select --</option>
											<option value="PVLMD">PVLMD</option>
											<option value="LRD">LRD</option>
											<option value="LVD">LVD</option>	
											<option value="SMD">SMD</option>	
											<option value="CORPORATE">CORPORATE</option>		
										  </select>
									</div>
								</div>
								
								<div class="row mb-3">
									<label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
									<div class="col-sm-8">
										<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()"  required="required">
											<option value="" disabled selected>-- select --</option>
											<option value="11">Greater Accra</option>
										<option value="14">Western</option>
										<option value="19">Volta</option>	
										<option value="12">Eastern</option>	
										<option value="13">Ashanti</option>	
										<option value="15">Central</option>	
										<option value="18">Northern</option>	
										<option value="16">Upper East</option>	
										<option value="17">Upper West</option>	
										<option value="10">Tema</option>
										<option value="22">Oti</option>	
										<option value="23">Bono East</option>	
										<option value="24">Ahafo</option>	
										<option value="20">Bono</option>	
										<option value="25">North East </option>	
										<option value="26">Savannah</option>
										<option value="21">Western North</option>	
										  </select>
									</div>
								</div>
									 <div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										 <select class="form-control" id="related_service" name="related_service"  required="required">
											<option value="" disabled selected>-- select --</option>
											<option value="Search">Search</option>
											<option value="Stamp Duty">Stamp Duty</option>
											<option value="Concurrence">Concurrence</option>
											<option value="Consent">Consent</option>
											<option value="Plan Approval">Plan Approval</option>
											<option value="Title Registration">Title Registration</option>
											<option value="PVLMD Plotting">PVLMD Plotting</option>
											<option value="Reguralization">Reguralization</option>
											<option value="Certified True Copy">Certified True Copy</option>
											<option value="Dispute">Dispute</option>
											<option value="Composite Plan">Composite Plan</option>
											<option value="General Valuation">General Valuation</option>
											<option value="Compensation">Compensation</option>
											<option value="Deed Registration">Deed Registration</option>
											<option value="Substituted Certificate">Substituted Certificate</option>
											<option value="State Land Rent">State Land Rent</option>
											<option value="Other Services">Other Services</option>
										</select>
									   </div>
									 </div>
									 <div class="row mb-3">
									   <label for="inputText" class="col-sm-4 col-form-label"><b>Reference No.</b><span class="text-danger">*</span>:</label>
									   <div class="col-sm-8">
										 <input type="text" class="form-control required-input" name="reference_id" id="reference_id" value="${job_number}" required="required" >
									   </div>
									 </div>`;
									 
								document.getElementById("tab_extra2").innerHTML =html;
								$("#submitBtn").prop('disabled', false);
							}

							if(is_completed == true){
								$('#priority').val('Low')
								$('#case_query').addClass('d-none');
							}
							else if(reminder > 100 && query_status == "0") {
								$('#priority').val('Urgent')
								$('#case_query').addClass('d-none');
							}

							else if(reminder > 70 && reminder <= 100 && query_status == "0") {
								$('#priority').val('High')
								$('#case_query').addClass('d-none');
							}

							else if(reminder > 50 && reminder <= 70 && query_status == "0") {
								$('#priority').val('Medium')
								$('#case_query').addClass('d-none');
							}

							else {
								$('#priority').val('Low')
							}

							$(json_p.milestones)
									.each(
											function(index, value) {
												//console.log("pro:" + this.priority_value);
												//console.log("aps:" + json_p.application_stage +1);
												var int_index = ++index;
												if(parseInt(this.priority_value) < parseInt(json_p.application_stage) ){
													table
													.append("<tr class='bg-success text-dark'><td>"
															+ int_index
															+ "</td><td>"
															+ this.milestone_description
															+ "</td><td>Completed" 
															+ "</td><td class='text-center'>"
															+ this.working_day_required
															+ "</td></tr>"
															);
												}else if(parseInt(this.priority_value) == parseInt(json_p.application_stage) ){
													table
													.append("<tr class='bg-info text-dark'><td>"
															+ int_index
															+ "</td><td>"
															+ this.milestone_description
															+"</td><td>Ongoing" 
															+ "</td><td class='text-center'>"
															+ this.working_day_required
															+ "</td></tr>"
															);
												}else{
													table
													.append("<tr class='bg-danger text-light'><td>"
															+ int_index
															+ "</td><td>"
															+ this.milestone_description
															+ "</td><td>Not Completed" 
															+ "</td><td class='text-center'>"
															+ this.working_day_required
															+ "</td></tr>"
															);
												}	
												

											});
							$(json_p.notifications)
							.each(
									function(index, value) {
										//console.log("pro:" + this.priority_value);
										//console.log("aps:" + json_p.application_stage +1);
										var int_index = ++index;
										/*if(parseInt(this.priority_value) <= parseInt(json_p.application_stage) + 1){
											table
											.append("<tr class='bg-success text-dark'><td>"
													+ int_index
													+ "</td><td>"
													+ this.milestone_description
													+ "</td><td>Completed</td></tr>"
													);
										}else{
											table
											.append("<tr class='bg-danger text-light'><td>"
													+ int_index
													+ "</td><td>"
													+ this.milestone_description
													+ "</td><td>Not Completed</td></tr>"
													);
										}	*/
										
										$('#sms-tracking').append("<tr ><td>"
												+ int_index
												+ "</td><td>"
												+ this.sms_message
												+ "</td><td>" +  this.sms_date_sent +"</td></tr>"
												);
										

									});

							$(json_p.application_details)
									.each(
											function() {

												$("#submitted_by_text").html(
																this.client_name);
												$("#sub_service_text")
														.html(
																this.business_process_sub_name);
												$("#date_created_text").html(
																this.created_date);
												$("#job_number_text").html(
																job_number);
												$("#status_text").html(
																this.job_status);

												$("#main_service_text").html(
																this.business_process_name);

											});
							

								$(json_p.case_query)
								.each(
										function(index, value) {
											var int_index = ++index;
											
											$('#case-query').append("<tr ><td>"
													+ int_index
													+ "</td><td>"
													+ this.reasons
													+ "</td><td>" 
													+ this.query_response
													+ "</td><td>" 
													+ this.created_date 
													+ "</td></tr>"
													);
											
	
										});
							
							

						}
					});
				}

				CallA();

					

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
		
		
		
		
		
})
