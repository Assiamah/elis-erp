document.addEventListener('DOMContentLoaded', function() {
	  
	  $('#table_list').DataTable();

	  	load_timelines();
	 /* unit_cases_unassigned */	
	 $('#unit_cases_unassigned').on('click', function() {
			
			let dataSet =[];
			let num = "";
			
			$.ajax({
				url:"legal_unit_serv",
				method:"POST",
				data:{"request_type":"unit_cases_unassigned"},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.cases !== null){
							
							for(let i=0; i<json_result.cases.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.cases[i].id}" ></div>`
			                let suit_number= json_result.cases[i].suit_number;
			                let nature_of_case= json_result.cases[i].nature_of_case;
			                let court_process= json_result.cases[i].court_process;
			                let plaintiffs="";
			                let defendants="";
			                if(json_result.cases[i].parties !== null){
								
								const plaintiffs_arr=get_plaintiffs(json_result.cases[i].parties);
								const defendants_arr=get_defendants(json_result.cases[i].parties);
								
								plaintiffs=plaintiffs_arr;
								defendants=defendants_arr;
							}
			               	let date_of_document=convertDate(json_result.cases[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.cases[i].date_received.slice(0,10));
			               	let received_at=json_result.cases[i].secretariat;
			              	let actions=`<div class="dropdown no-arrow">
								              	   <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<i class="fas fa-ellipsis-v ms-2"></i>
			              	  </a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<form  action="case_details_post" method="post">
					              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
											<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
											<input type="hidden"  name="request_type" value="case_details">
					              	    	<button type="submit" class="dropdown-item" href="#">Case Details</button>
					              	    </form>
					              	  </div>
					              	</div>`;
			                let court_name=json_result.cases[i].court_name;          
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
			                let region=json_result.cases[i].region;
			                let status_of_case=json_result.cases[i].status_of_case;
			                let nature_of_case_id=json_result.cases[i].nature_of_case_id;
			                
			                let reminder = 0;
							let display_reminder = '';
					                
							if(status_of_case == null) {
								var startDate = json_result.cases[i].date_received;
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
								var diffDays = parseInt((date2 - date1) / (1000 * 60 * 60 * 24), 10);
								reminder = diffDays;
								
								if(reminder <= 0) {
									var Str = reminder.toString();;
									var newStr = Str.replace('-','');
									
								  	display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`
							   	} else {
									display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`   
								}
							}
			                
			               html.push(num);
			               html.push(suit_number);
			               html.push(nature_of_case); 
			               html.push(court_process); 
			               html.push(court_name);  
			               html.push(region); 
			               html.push(plaintiffs); 
			               html.push(defendants); 
			               html.push(date_of_document); 
			               html.push(date_received); 
			               html.push(received_at);
			               html.push(display_reminder);
			               html.push(actions); 
			               html.push(entry_complete);
			               html.push(attachment);
		
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function( row, data, dataIndex){
				                if( data[13] && data[12]){
				                    $(row).addClass('greenClass');
				                  }
				                  else if(data[13]){
									$(row).addClass('redClass');
								}
								else if(data[12]){
									$(row).addClass('yellowClass');
								}
				               },
							
							}).draw();
							
							
		              	
						}
				 document.getElementById("card_title").innerHTML="Unassigned";
				  $("#body-bg-1").addClass('bg-active');
				  $("#body-bg-2, #body-bg-3, #body-bg-4").removeClass('bg-active');
					}
				})
				
		})
			
	  /*unit*/
	  $('#unit_cases').on('click', function() {
			
			let dataSet =[];
			let num = '';
			
			$.ajax({
				url:"legal_unit_serv",
				method:"POST",
				data:{"request_type":"unit_cases_assigned"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.cases !== null){
							
							for(let i=0; i<json_result.cases.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.cases[i].id}" ></div>`
			                let suit_number= json_result.cases[i].suit_number;
			                let nature_of_case= json_result.cases[i].nature_of_case;
			                let court_process= json_result.cases[i].court_process;
			                let plaintiffs="";
			                let defendants="";
			                if(json_result.cases[i].parties !== null){
								
								const plaintiffs_arr=get_plaintiffs(json_result.cases[i].parties);
								const defendants_arr=get_defendants(json_result.cases[i].parties);
								
								plaintiffs=plaintiffs_arr;
								defendants=defendants_arr;
							}
			               	let date_of_document=convertDate(json_result.cases[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.cases[i].date_received.slice(0,10));
			               	let received_at=json_result.cases[i].assign_to_fullname;
			              	let actions=`<div class="dropdown no-arrow">
							              	   <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<i class="fas fa-ellipsis-v ms-2"></i>
			              	  </a>
						              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						              	  	<form  action="case_details_post" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
												<input type="hidden"  name="request_type" value="case_details">
						              	    	<button type="submit" class="dropdown-item" href="#">Case Details</button>
						              	    </form>	              	    
						              	  </div>
						              	</div>`;
			                let court_name=json_result.cases[i].court_name;          
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
			                let region=json_result.cases[i].region;
			                let status_of_case=json_result.cases[i].status_of_case;
			                let end_date=json_result.cases[i].end_date;
			                
			                let reminder = 0;
							let display_reminder = '';
					                
							if(status_of_case == null) {
								var startDate = json_result.cases[i].date_received;
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
								var diffDays = parseInt((date2 - date1) / (1000 * 60 * 60 * 24), 10);
								reminder = diffDays;
								
								if(reminder <= 0) {
									var Str = reminder.toString();;
									var newStr = Str.replace('-','');
									
								  	display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`
							   	} else {
									display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`   
								}
							}
							
							if(status_of_case != null) {
								let date_1 = new Date();
								let date_2 = new Date(end_date);
								let difference = date_2.getTime() - date_1.getTime();
								
								let TotalDays = Math.ceil(difference / (1000 * 3600 * 24));
								
								
								if(TotalDays <= 0) {
									var Str = TotalDays.toString();;
									var newStr = Str.replace('-','');
									
								  	display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`
							   	} else {
									display_reminder = `<label class="badge badge-success">${TotalDays} Day(s) Left</label>`   
								}
							}
			                
			               html.push(num);
			               html.push(suit_number);
			               html.push(nature_of_case); 
			               html.push(court_process); 
			               html.push(court_name);  
			               html.push(region); 
			               html.push(plaintiffs); 
			               html.push(defendants); 
			               html.push(date_of_document); 
			               html.push(date_received); 
			               html.push(received_at);
			               html.push(display_reminder);
			               html.push(actions); 
			               html.push(entry_complete);
			               html.push(attachment);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function( row, data, dataIndex){
				                if( data[13] && data[12]){
				                    $(row).addClass('greenClass');
				                  }
				                  else if(data[13]){
									$(row).addClass('redClass');
								}else if(data[12]){
									$(row).addClass('yellowClass');
								}
				               },
							
							}).draw();
							
							
		              	
						}
					
					}
				})
				
			 document.getElementById("card_title").innerHTML="Assigned";
			$("#body-bg-2").addClass('bg-active');
				  $("#body-bg-1, #body-bg-3, #body-bg-4").removeClass('bg-active');
					
				
		})
	/* officer_cases 
	<form  action="case_details" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
												<input type="hidden"  name="request_type" value="case_details">
						              	    	<button type="submit" class="dropdown-item" href="#">Case Details</button>
						              	    </form> 
	 
						              	    <form  action="request_record_info" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
												<input type="hidden"  name="request_type" value="record_info">
						              	    	<button type="submit" class="dropdown-item" href="#">Request Record Info</button>
						              	    </form>  
	*/	
	 $('#officer_cases').on('click', function() {
			
			let dataSet =[];
			let num = "";
			
			$.ajax({
				url:"legal_case_management_serv",
				method:"POST",
				data:{"request_type":"officer_cases"},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.cases !== null){
							
							for(let i=0; i<json_result.cases.length; i++){
			                let html = [];
			                num = (+num + 1);
			                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.cases[i].id}" ></div>`
			                let suit_number= json_result.cases[i].suit_number;
			                let nature_of_case= json_result.cases[i].nature_of_case;
			                let court_process= json_result.cases[i].court_process;
			                let plaintiffs="";
			                let defendants="";
			                if(json_result.cases[i].parties !== null){
								
								const plaintiffs_arr=get_plaintiffs(json_result.cases[i].parties);
								const defendants_arr=get_defendants(json_result.cases[i].parties);
								
								plaintiffs=plaintiffs_arr;
								defendants=defendants_arr;
							}
			               	let date_of_document=convertDate(json_result.cases[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.cases[i].date_received.slice(0,10));
			               	let received_at=json_result.cases[i].assigned_to;
			              	let actions=`<div class="dropdown no-arrow">
							              	   <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               				<i class="fas fa-ellipsis-v ms-2"></i>
			              	  					</a>
						              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						              	  	  
						              	    <form  action="case_work" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
												<input type="hidden"  name="request_type" value="case_work">
						              	    	<button type="submit" class="dropdown-item" href="#">Work</button>
						              	    </form>    
											  <a class="dropdown-item archive" id="${json_result.cases[i].id}" data_id='${json_result.cases[i].suit_number}' href="#">Archive</a>	         	    
						              	  </div>
						              	</div>`;
			                let court_name=json_result.cases[i].court_name;          
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
			                let region=json_result.cases[i].region;
			                let status_of_case=json_result.cases[i].status_of_case;
			                let end_date=json_result.cases[i].end_date;
			                
			                let reminder = 0;
							let display_reminder = '';
					                
							if(status_of_case == null) {
								var startDate = json_result.cases[i].date_received;
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
								var diffDays = parseInt((date2 - date1) / (1000 * 60 * 60 * 24), 10);
								reminder = diffDays;
								
								if(reminder <= 0) {
									var Str = reminder.toString();;
									var newStr = Str.replace('-','');
									
								  	display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`
							   	} else {
									display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`   
								}
							}
							
							if(status_of_case != null) {
								let date_1 = new Date();
								let date_2 = new Date(end_date);
								let difference = date_2.getTime() - date_1.getTime();
								
								let TotalDays = Math.ceil(difference / (1000 * 3600 * 24));
								
								
								if(TotalDays <= 0) {
									var Str = TotalDays.toString();;
									var newStr = Str.replace('-','');
									
								  	display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`
							   	} else {
									display_reminder = `<label class="badge badge-success">${TotalDays} Day(s) Left</label>`   
								}
							}
									                
			               html.push(num);
			               html.push(suit_number);
			               html.push(nature_of_case); 
			               html.push(court_process); 
			               html.push(court_name);  
			               html.push(region); 
			               html.push(plaintiffs); 
			               html.push(defendants); 
			               html.push(date_of_document); 
			               html.push(date_received); 
			               html.push(received_at);
			               html.push(display_reminder);
			               html.push(actions); 
			               html.push(entry_complete);
			               html.push(attachment);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function( row, data, dataIndex){
				                if( data[13] && data[12]){
				                    $(row).addClass('greenClass');
				                  }
				                  else if(data[13]){
									$(row).addClass('redClass');
								}else if(data[12]){
									$(row).addClass('yellowClass');
								}
				               },
							
							}).draw();
							
							
		              	
						}
				 
				 document.getElementById("card_title").innerHTML="Officer";
				 $("#body-bg-3").addClass('bg-active');
				  $("#body-bg-1, #body-bg-2, #body-bg-4").removeClass('bg-active');
					
					
					}
				})
				
		})

		$('#table_list').on('click', '.archive', function() {
		
			let id = $(this).prop('id');
			let data_id=$(this).attr('data_id');
			$('input[name="case_id"]').val(id);
			$('input[name="suit_number"]').val(data_id);
			
			$("#archiveCaseModal").modal('show');
	   })

	   $('#archive_one').on('submit',function(e){
		e.preventDefault();
 
 let suit_number =  $('input[name="suit_number"]').val();
 let case_id =  $('input[name="case_id"]').val();
 //let user_to_send_to_name=$('input[name="user_to_send_to"]').val();
 let reasons = $('#archive_reasons').val();
 
 console.log(reasons);


 //let user_to_send_to_id = $('#listofusersbatching option')
					 //.filter(
						 //function() {
							 //return this.value == user_to_send_to_name;
						 //}).data('id');
	 
 $.ajax({
	 url:"head_legal_serv",
	 method:"POST",
	 data:{"request_type":"archive_one_case",
		   "suit_number":suit_number,
		   "case_id":case_id,
		   //"user_to_send_to_name":user_to_send_to_name,
		  // "user_to_send_to_id":user_to_send_to_id,
		   "reasons":reasons
		   },
	 success:function(response){
		 //console.log(response);
		  let json_result = JSON.parse(response);
		  if (json_result.success) {
					 toastr["success"]("Archived successfully", "Archive");
				 } else {
					 toastr["error"]("Error occurred archiving case", "Archive");
				 }

				 $('#archiveCaseModal').find('form').trigger('reset');
				  $('#archiveCaseModal').modal('hide');
				 
				 setTimeout(function(){
					 location.reload(1);
				 },1000); 
	 } 
 })
 
})
		
		/* Pending */	
	$('#pending').on('click', function() {
			
			$("#btnViewStatistics").prop('disabled',true);
			let dataSet =[];
			let num = "";
			
			$.ajax({
				url:"head_legal_serv",
				method:"POST",
				data:{"request_type":"load_user_pending_actions"},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.user !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.data[i].id}" ></div>`
			                let suit_number= json_result.data[i].suit_number;
			                let nature_of_case= json_result.data[i].nature_of_case;
			                let court_process= json_result.data[i].court_process;
			                let plaintiffs= "";
			                let defendants= "";
			                 if(json_result.data[i].parties !== null){
								
								const plaintiffs_arr=get_plaintiffs(json_result.data[i].parties);
								const defendants_arr=get_defendants(json_result.data[i].parties);
								
								plaintiffs=plaintiffs_arr;
								defendants=defendants_arr;
							}
			               	let date_of_document=convertDate(json_result.data[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.data[i].date_received.slice(0,10));
			               	let received_at=json_result.data[i].assigned_to;
			              	let actions=`<div class="dropdown no-arrow">
							              	   <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									               	<i class="fas fa-ellipsis-v ms-2"></i>
						              	  </a>
						              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						              	     <form  action="case_work" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.data[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.data[i].suit_number}">
												<input type="hidden"  name="request_type" value="case_work">
						              	    	<button type="submit" class="dropdown-item" href="#">Work</button>
						              	    </form>    
						              	  </div>
						              	</div>`;
			                let court_name=json_result.data[i].court_name;          
		       				let entry_complete=json_result.data[i].entry_complete;
			                let attachment=json_result.data[i].attachment;
			                let region=json_result.data[i].region;
			                let status_of_case=json_result.data[i].status_of_case;
			                let nature_of_case_id=json_result.data[i].nature_of_case_id;
			                
			               let reminder = 0;
							let display_reminder = '';
					                
							if(status_of_case == null) {
								var startDate = json_result.data[i].date_received;
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
								var diffDays = parseInt((date2 - date1) / (1000 * 60 * 60 * 24), 10);
								reminder = diffDays;
								
								if(reminder <= 0) {
									var Str = reminder.toString();;
									var newStr = Str.replace('-','');
									
								  	display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`
							   	} else {
									display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`   
								}
							}
			                
			               html.push(num);
			               html.push(suit_number);
			               html.push(nature_of_case); 
			               html.push(court_process); 
			               html.push(court_name);  
			               html.push(region); 
			               html.push(plaintiffs); 
			               html.push(defendants); 
			               html.push(date_of_document); 
			               html.push(date_received); 
			               html.push(received_at);
			               html.push(display_reminder);
			               html.push(actions); 
			               html.push(entry_complete);
			               html.push(attachment);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function( row, data, dataIndex){
				                if( data[13] && data[12]){
				                    $(row).addClass('greenClass');
				                  }
				                  else if(data[13]){
									$(row).addClass('redClass');
								}else if(data[12]){
									$(row).addClass('yellowClass');
								}
				               },
							
							}).draw();
							
							
		              	
						}
				 
				 document.getElementById("card_title").innerHTML="Officer";
				 $("#body-bg-4").addClass('bg-active');
				  $("#body-bg-1, #body-bg-2, #body-bg-3").removeClass('bg-active');
					
					
					}
				}) 
				
		})
		
		
		$("#btnViewUpcomingCases").on('click',function(){
		
			$('#upcomingcasesModal').modal('show')
		
			
			
		})
		
			$('#eventDetails').on('shown.bs.modal', function () {
			  //$('#myInput').trigger('focus')
			  //$("#eventDetails").modal({backdrop: true});
			  $("#upcomingcasesModal").css("z-index", "1029");
			})
			
			$('#eventDetails').on('hidden.bs.modal', function () {
			  //$('#myInput').trigger('focus')
			  //$("#eventDetails").modal({backdrop: true});
			  $("#upcomingcasesModal").css("z-index", "");
			})
			
	  ///////// Pending Action //////
 /*	  $.ajax({
		url:"legal_case_management",
		method:"POST",
		data:{"request_type":"pending_action"},
		success:function(response){
			//console.log(response);
			let json_result = JSON.parse(response);
			if(json_result.success){
				let cases= json_result.cases;
				
				cases.forEach(addToCalender);
			} 
             else {
                       
                }
			
			  let events=JSON.parse(localStorage.getItem('events')) || [];
			  console.log(events);
			  load_calender(events)		
	
			}
	  })
*/	  

 function formatDate(date) {
	  let d = new Date(date);
	  let month = (d.getMonth() + 1).toString();
	  let day = d.getDate().toString();
	  let year = d.getFullYear();
	  if (month.length < 2) {
	    month = '0' + month;
	  }
	  if (day.length < 2) {
	    day = '0' + day;
	  }
	  return [year, month, day].join('-');
 }
 
 
 const get_plaintiffs=(parties)=>{
		console.log(parties);
		let results=[];
		if(parties !== null){
		parties.forEach(function(parties){
			
			if(parties.party_type == "Plaintiff"){
				results.push(parties.party_name)
			}

		})
		}
		
		return results;
	}
	
	const get_defendants=(parties)=>{
		console.log(parties);
		let results=[];
		if(parties !== null){
		parties.forEach(function(parties){
			
			if(parties.party_type == "Defendant"){
				results.push(parties.party_name)
			}

		})
		}
		
		return results;
	}
	
	
	function load_timelines(){
		
		$.ajax({
			type:"POST",
			url:"case_work_serv",
			data:{"request_type":"load_user_timeline"
			},
			success:function(response){
				
				console.log(response);
				let json_results=JSON.parse(response);
				
				let html_upcoming="";
				let html_past="";
				if(json_results.success){
				 
				 json_results.data.forEach(function(data){
					
					var todayDate = new Date(); //Today Date    
			       	var dateOne = new Date(data.end_date);    
			         if (todayDate > dateOne) {
							html_past+=` <li>
					          <span class="${data.timeline_status_id == 0 ? 'text-danger' : 'text-success'}">${data.suit_number}</span>
					          <span class="${data.timeline_status_id == 0 ? 'text-danger' : 'text-success'}  float-end">${data.end_date}</span>
					          <p class="mt-2"><strong>${data.description}</strong></p>
					          <p class="mt-2">${data.court_name}</p>
					        </li>`;
			         }else {    
			            html_upcoming+=` <li>
					          <span class="${data.timeline_status_id == 0 ? 'text-warning' : 'text-success'}">${data.suit_number}</span>
					          <span class="${data.timeline_status_id == 0 ? 'text-warning' : 'text-success'} float-end">${data.end_date}</span>
					          <p class="mt-2"><strong>${data.description}</strong></p>
					          <p class="mt-2">${data.court_name}</p>
					        </li>`;  
			        }   
				 	 
					
			      })
			      
                } 
              else {
                        
                 }
                 
               document.getElementById('upcoming').innerHTML=html_upcoming;
                document.getElementById('past').innerHTML=html_past;

			}
		})	
		
	}
	

});
  
  
  
  $(function() {
	
  $('#calendar').fullCalendar({
	
    header: { 
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
     },
    views: {
      month: {
        titleFormat: 'MM, YYYY'
      }
    },
    /*validRange: function(nowDate) {
      return {
        start: nowDate,
        end: nowDate.clone().add(1, 'months')
      };
    },*/
    
    navLinks: true,
    selectable: true,
    selectHelper: true,
    /*select: function(start, end) {
      startDate = moment(new Date(start)).format("MM-DD-YYYY");
      $('#createBookingModal .modal-header .modal-title span').text(startDate);
      $('#createBookingModal').modal('show');
    },*/
    editable: true,
    eventLimit: true, // allow "more" link when too many events
    events: function(start, end, timezone, callback){
     
	    $.ajax({
			type:"POST",
			url:"case_work_serv",
			data:{"request_type":"load_user_timeline"
			},
	        cache: false,
	        success: function(response){
				jsonData = JSON.parse(response)
				var events = [];
				
				for(let i = 0; i<jsonData.data.length; i++) {
					
					let dd_end_date = new Date(new Date(jsonData.data[i].end_date).setDate(new Date(jsonData.data[i].end_date).getDate() + 1))
					dd_end_date = dd_end_date.toLocaleDateString('en-US')
					
					events.push({
				        title: `${jsonData.data[i].suit_number}`,
				        start: `${jsonData.data[i].start_date}`,
				        end: dd_end_date,
				        minTime: `${jsonData.data[i].case_id}`,
				        maxTime: `${jsonData.data[i].end_date}`,
				        description: `${jsonData.data[i].nature_of_case} - ${jsonData.data[i].description}`,
				        allDay: true,
	            		free: false,
				        color: `${jsonData.data[i].timeline_status_id == 0 ? '#DC4C64' : '#14A44D'}`,
				        textColor: '#FFFF'
				    });
	                
	                console.log(events)
				}
				callback(events);
	        }
	      });
    },
    
    eventClick: function(event, jsEvent, view) {
		
		start = moment(new Date(event.start)).format("MM-DD-YYYY");
		end = moment(new Date(event.maxTime)).format("MM-DD-YYYY");
		var new_end_date;
		
		//console.log(event.end)
		
		if(event.end == null) {
			new_end_date = start;
		} else {
			new_end_date = end;
		}
      	
        $('#eventDetails').modal('show');
        $('#eventDetails').find('#case_id').val(event.minTime);
        $('#eventDetails').find('#suit_number').val(event.title);
        $('#eventDetails').find('#start_date').val(start);
        $('#eventDetails').find('#end_date').val(new_end_date);
        $('#eventDetails').find('#description').val(event.description);

    },

    loading: function(bool) {
        $('#loading').toggle(bool);
    }
  });
});