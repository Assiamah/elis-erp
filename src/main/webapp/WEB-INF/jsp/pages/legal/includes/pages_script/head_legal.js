$(function(){
		
		 $('#table_list').DataTable();
		 $("#btnViewStatistics").prop('disabled',true);
		 $("#btnViewUpcomingCases").prop('disabled',true);
		 
		 document.getElementById("archived_search").style.display="none";
		
		 $('#unit_cases').on('click', function() {
			 
			 document.getElementById("archived_search").style.display="none"; 
			 
		 let dataSet =[];
		 let num = "";
		 
		 $.ajax({
				url:"legal_unit_serv",
				method:"POST",
				data:{"request_type":"load_data"},
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
			               	let received_at=json_result.cases[i].secretariat;
			              	let actions="";
			                let court_name=json_result.cases[i].court_name;          
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
			                let region=json_result.cases[i].region;
			                let status_of_case=json_result.cases[i].status_of_case;
			                let nature_of_case_id=json_result.cases[i].nature_of_case_id;
			                
			                /*let reminder = 0;
			                
							if(nature_of_case_id == 6 && status_of_case == null) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 8, count = 0;
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
							}
							
							if(nature_of_case_id == 6 && status_of_case == 6) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 14, count = 0;
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
							}
							
							if(nature_of_case_id == 6 && status_of_case == 7) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 7, count = 0;
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
							}*/
							
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
			                
			                if(entry_complete == true && attachment == true) {
								 actions=`<div class="dropdown no-arrow">
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
				              	    <a class="dropdown-item assign" id="${json_result.cases[i].id}" data_id='${json_result.cases[i].suit_number}' href="#">Assign</a>
				              	  </div>
				              	</div>`;
							}
			                
			               else if(entry_complete == false) {
								 actions=`<div class="dropdown no-arrow">
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
							}
							
							else if(attachment == false) {
								 actions=`<div class="dropdown no-arrow">
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
					
					}
				})
				
			 document.getElementById("card_title").innerHTML="Unit";
			 $("#btnViewStatistics").prop('disabled',true);
			 $("#btnViewUpcomingCases").prop('disabled',true);
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1, #body-bg-3, #body-bg-4, #body-bg-5").removeClass('bg-active');
	})	
	
	$('#assigned_cases').on('click', function() {
		 let dataSet =[];
		 let num = "";
		 
		 document.getElementById("archived_search").style.display="none"; 
		 
		 $.ajax({
				url:"head_legal_serv",
				method:"POST",
				data:{"request_type":"assigned_unit_cases"},
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
			               	let received_at=json_result.cases[i].assigned_to;
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
				              	    <a class="dropdown-item assign" id="${json_result.cases[i].id}" data_id='${json_result.cases[i].suit_number}' href="#">Reassign</a>
				              	  </div>
				              	</div>`;
			                let court_name=json_result.cases[i].court_name;          
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
			                let region=json_result.cases[i].region;
			                let status_of_case=json_result.cases[i].status_of_case;
			                //let nature_of_case_id=json_result.cases[i].nature_of_case_id;
			                let end_date=json_result.cases[i].end_date;
			                let start_date=json_result.cases[i].start_date;
			                console.log(end_date, start_date)
			                
							
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
								}
								 else if(data[12]){
									$(row).addClass('yellowClass');
								}
				               },
							}).draw();
							
		              	
						}
					
					}
				})
				
			 document.getElementById("card_title").innerHTML="Assigned";
			 $("#btnViewStatistics").prop('disabled',false);
			 $("#btnViewUpcomingCases").prop('disabled',false);
			  $("#body-bg-3").addClass('bg-active');
			 $("#body-bg-2, #body-bg-1, #body-bg-4, #body-bg-5").removeClass('bg-active');
	})		
		
			// Show Incoming Cases
$('#incoming').on('click', function() {
	
	document.getElementById("archived_search").style.display="none"; 
		
	   let num ="";
	   //load incoming cases
		 $.ajax({
			url:"legal_unit_serv",
			method:"POST",
			data:{"request_type":"load_incoming_cases"},
			success:function(response){
				
				//console.log(response);
				let json_result = JSON.parse(response);
				 //console.log(json_result);
				 let incomingSet=[];
				 if(json_result.success && json_result.data !== null){
						for(let i=0; i<json_result.data.length; i++){
							
							let html=[];
							num = (+num + 1);
			                let id=`<div class="form-check"> <input class="form-check-input incoming_checks" type="checkbox" id="gridCheck" value="${json_result.data[i].id}" data-suit="${json_result.data[i].suit_number}" data-nature="${json_result.data[i].nature_of_case}"></div>`
			                let suit_number= json_result.data[i].suit_number;
			                let nature_of_case= json_result.data[i].nature_of_case;
			                let court_process= json_result.data[i].court_process;
			                let plaintiffs="";
			                let defendants="";
			                if(json_result.data[i].parties !== null){
								
								const plaintiffs_arr=get_plaintiffs(json_result.data[i].parties);
								const defendants_arr=get_defendants(json_result.data[i].parties);
								
								plaintiffs=plaintiffs_arr;
								defendants=defendants_arr;
							}
			               	let date_of_document=convertDate(json_result.data[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.data[i].date_received.slice(0,10));
			               	let received_at=json_result.data[i].secretariat;
			             	let actions=``;
			                let court_name=json_result.data[i].court_name;
			                let region=json_result.data[i].region;
			                let incoming = json_result.data[i].incoming;
			                let attached=json_result.data[i].attached;
			      			let status_of_case=json_result.data[i].status_of_case;
			                let nature_of_case_id=json_result.data[i].nature_of_case_id;
			                
			                /*let reminder = 0;
			                
							if(nature_of_case_id == 6 && status_of_case == null) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 8, count = 0;
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
							}
							
							if(nature_of_case_id == 6 && status_of_case == 6) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 14, count = 0;
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
							}
							
							if(nature_of_case_id == 6 && status_of_case == 7) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 7, count = 0;
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
							}*/
							
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
			               html.push(attached);
	               			html.push(incoming);
			               		       
		
			                incomingSet.push(html);

							}
				
					}
					
						$('#table_list').DataTable().clear();
							
							$('#table_list').DataTable().rows.add(incomingSet).draw();
				
				}
			})
			
			document.getElementById("card_title").innerHTML="Incoming";
			 $("#btnViewBatchlist").prop('disabled',false);
			 
			  $("#body-bg-1").addClass('bg-active');
			 $("#body-bg-2, #body-bg-3, #body-bg-5, #body-bg-4").removeClass('bg-active');
	        
	 })	
	// Pending
	$('#pending').on('click', function() {
			
			$("#btnViewStatistics").prop('disabled',true);
			$("#btnViewUpcomingCases").prop('disabled',true);
			let dataSet =[];
			let num ="";
			
			document.getElementById("archived_search").style.display="none"; 
			
			$.ajax({
				url:"head_legal_serv",
				method:"POST",
				data:{"request_type":"load_pending_actions"},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.data !== null){
							
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
						              	  	<form  action="case_details_post" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.data[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.data[i].suit_number}">
												<input type="hidden"  name="request_type" value="case_details">
						              	    	<button type="submit" class="dropdown-item" href="#">Case Details</button>
						              	    </form>	   
						              <a class="dropdown-item assign" id="${json_result.data[i].id}" data_id='${json_result.data[i].suit_number}' href="#">Assign</a>	  
						              <a class="dropdown-item archive" id="${json_result.data[i].id}" data_id='${json_result.data[i].suit_number}' href="#">Archive</a>	     
						              	  </div>
						              	</div>`;
			                let court_name=json_result.data[i].court_name;          
		       				let entry_complete=json_result.data[i].entry_complete;
			                let attachment=json_result.data[i].attachment;
			                let region=json_result.data[i].region;
			                let status_of_case=json_result.data[i].status_of_case;
			                let nature_of_case_id=json_result.data[i].nature_of_case_id;
			                
			                /*let reminder = 0;
			                
							if(nature_of_case_id == 6 && status_of_case == null) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 8, count = 0;
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
							}
							
							if(nature_of_case_id == 6 && status_of_case == 6) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 14, count = 0;
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
							}
							
							if(nature_of_case_id == 6 && status_of_case == 7) {
								var startDate = json_result.data[i].date_received;
								startDate = new Date(startDate.replace(/-/g, "/"));
								var endDate = "", noOfDaysToAdd = 7, count = 0;
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
							}*/
							
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
				               if( data[12] && data[11]){
				                    $(row).addClass('greenClass');
				                  }
				                  else if(data[12]){
									$(row).addClass('redClass');
								}
								 else if(data[11]){
									$(row).addClass('yellowClass');
								}
				               },
							
							
							}).draw();
							
							
		              	
						}
				 
				 document.getElementById("card_title").innerHTML="Officer";
				 $("#body-bg-4").addClass('bg-active');
				  $("#body-bg-1, #body-bg-2, #body-bg-3, #body-bg-5").removeClass('bg-active');
					
					
					}
				})
				
		})
		
		
	$('#archive_cases').on('click', function() {
			 
			 document.getElementById("archived_search").style.display="block"; 
			 document.getElementById("card_title").innerHTML="Unit";
			 $("#btnViewStatistics").prop('disabled',true);
			 $("#btnViewUpcomingCases").prop('disabled',true);
			 $("#body-bg-5").addClass('bg-active');
			 $("#body-bg-1, #body-bg-3, #body-bg-4, #body-bg-2 ").removeClass('bg-active');
			 
			 $('#table_list').DataTable().clear().destroy();
			 
			 
	})	
	
	
	$('#btnCCJobSearch').on('click', function(e) {
		e.preventDefault();
		
		var case_id = $('#search_case_value').val()
		
		if(!case_id) {
			
		} else {
			
			$('#table_list').DataTable().clear().destroy();
			
			let dataSet =[];
			let num ="";
		
			$.ajax({
				url:"head_legal_serv",
				method:"POST",
				data:{"request_type":"search_archived_case", case_id: case_id},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let id = `<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.data[i].id}" ></div>`
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
						              	  	<form  action="case_details_post" method="post">
						              	  		<input type="hidden" name="case_id" value="${json_result.data[i].id}">
												<input type="hidden"  name="suit_number" value="${json_result.data[i].suit_number}">
												<input type="hidden"  name="request_type" value="case_details">
						              	    	<button type="submit" class="dropdown-item" href="#">Case Details</button>
						              	    </form>	   
						              <a class="dropdown-item restore" id="${json_result.data[i].id}" data_id='${json_result.data[i].suit_number}' href="#">Restore</a>	    
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

							} else {
								
								
							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function( row, data, dataIndex){
				               if( data[12] && data[11]){
				                    $(row).addClass('greenClass');
				                  }
				                  else if(data[12]){
									$(row).addClass('redClass');
								}
								 else if(data[11]){
									$(row).addClass('yellowClass');
								}
				               },
							
							
							}).draw();
							
							
		              	
						}
				 
					
					
				}
			})
		}
	})
			
	$('#table_list').on('click', '.assign', function() {
		
		 let id = $(this).prop('id');
		 let data_id=$(this).attr('data_id');
		 $('input[name="case_id"]').val(id);
		 $('input[name="suit_number"]').val(data_id);
		 
		 $("#assignCaseModal").modal('show');
		 
		 $.ajax({
				type : "POST",
				url : "Case_Management_Serv",
				data : {
					request_type : 'get_lc_list_of_users',
				},
				cache : false,
				success : function(response) {
					console.log(response)
					
					let selected_unit='LEGAL UNIT';
					let json_p = JSON.parse(response);
					var datalist = $("#listofusersbatching");
														datalist.empty();
					
					$(json_p).each(
									function() {
												if (selected_unit == this.unit_name) {
													
													datalist
															.append('<option data-name="'
																	+ this.fullname
																	+ '" data-id="'
																	+ this.userid
																	+ '" value="'
																	+ this.fullname
																	+ '" ></option>');
												}
											});
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
        
        
    $('#table_list').on('click', '.restore', function() {
		
		 let id = $(this).prop('id');
		 let data_id=$(this).attr('data_id');
		 $('input[name="case_id"]').val(id);
		 $('input[name="suit_number"]').val(data_id);
		 
		 $("#restoreCaseModal").modal('show');
	})
        

 

   // Assign on case
   $('#assign_one').on('submit',function(e){
	       e.preventDefault();
	
	let suit_number =  $('input[name="suit_number"]').val();
	let case_id =  $('input[name="case_id"]').val();
	let user_to_send_to_name=$('input[name="user_to_send_to"]').val();
	let reasons = $('#assigned_reasons').val();
	
	console.log(reasons);


	let user_to_send_to_id = $('#listofusersbatching option')
						.filter(
							function() {
								return this.value == user_to_send_to_name;
							}).data('id');
		
	$.ajax({
		url:"head_legal_serv",
		method:"POST",
		data:{"request_type":"assign_one_case",
			  "suit_number":suit_number,
			  "case_id":case_id,
			  "user_to_send_to_name":user_to_send_to_name,
			  "user_to_send_to_id":user_to_send_to_id,
			  "reasons":reasons
			  },
		success:function(response){
			//console.log(response);
			 let json_result = JSON.parse(response);
			 if (json_result.success) {
                        toastr["success"]("Assigned successfully", "Assign");
                    } else {
                        toastr["error"]("Error occurred assigning case", "Assign");
                    }

                    $('#AssignCaseModal').find('form').trigger('reset');
                     $('#AssignCaseModal').modal('hide');
                    
                    setTimeout(function(){
                        location.reload(1);
                    },1000); 
		} 
	})
	
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


$('#restore_one').on('submit',function(e){
	       e.preventDefault();
	
	let suit_number =  $('input[name="suit_number"]').val();
	let case_id =  $('input[name="case_id"]').val();
	//let user_to_send_to_name=$('input[name="user_to_send_to"]').val();
	//let reasons = $('#archive_reasons').val();
	
	//console.log(reasons);


	//let user_to_send_to_id = $('#listofusersbatching option')
						//.filter(
							//function() {
								//return this.value == user_to_send_to_name;
							//}).data('id');
		
	$.ajax({
		url:"head_legal_serv",
		method:"POST",
		data:{"request_type":"restore_one_case",
			  "suit_number":suit_number,
			  "case_id":case_id,
			  //"user_to_send_to_name":user_to_send_to_name,
			 // "user_to_send_to_id":user_to_send_to_id,
			  //"reasons":reasons
			  },
		success:function(response){
			//console.log(response);
			 let json_result = JSON.parse(response);
			 if (json_result.success) {
                        toastr["success"]("Restored successfully", "Restore");
                    } else {
                        toastr["error"]("Error occurred archiving case", "Restore");
                    }

                    $('#restoreCaseModal').find('form').trigger('reset');
                     $('#restoreCaseModal').modal('hide');
                    
                    setTimeout(function(){
                        location.reload(1);
                    },1000); 
		} 
	})
	
})
   
   // Assign Multiple Cases
////////////////////////////////Cases Assigned////////////////////////////////////////////////////////////////////////////////////////

$("#btnViewStatistics").on('click',function(){
		
		
		$('#assignedCasesModal').modal('show')
		
		var table_assigned = $('#assigned_table');
		table_assigned.find("tbody tr").remove();
		
		$.ajax({
		url:"head_legal",
		method:"POST",
		data:{"request_type":"assigned_cases"
			  },
		success:function(response){
			
				console.log(response);
				var json_p = JSON
					.parse(response);
				console.log(json_p)
				
				const series=[];
				const labels=[];
				$(json_p.data)
					.each(
							function() {

								table_assigned
										.append("<tr>"
												+ '<td>'
												+ this.fullname
												+ '</td><td>'
												+ this.count
												+ '</td><td>'
												+ '<button type="button" class="btn btn-default btn-sm view" id="'+this.fullname+'">'
											    + '<span class="text-primary">view</span>'
											    +  '</button>'
												+ "</td>"
												+ "</tr>");
									
									series.push(this.count)
									labels.push(this.fullname)


							});
							
							showApexChart(series,labels);
					}
				})
			
		})
		
		
		$("#btnViewUpcomingCases").on('click',function(){
		
			$('#upcomingcasesModal').modal('show')
		
			$.ajax({
				type:"POST",
				url:"case_work_serv",
				data:{"request_type":"load_timeline"
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
						          <span class="text-danger">${data.nature_of_case}</span>
						          <span class="text-danger  float-end">${data.end_date}</span>
						           <p ><strong>${data.suit_number}</strong></p>
						          <p class="mt-2"><strong>${data.description}</strong></p>
						          <p class="mt-2">${data.court_name}</p>
						        </li>`;
				         }else {    
				            html_upcoming+=` <li>
						          <span class="text-primary">${data.nature_of_case}</span>
						          <span class="text-primary float-end">${data.end_date}</span>
						          <p ><strong>${data.suit_number}</strong></p>
						          <p class="mt-2"><strong>${data.description}</strong></p>
						          <p class="mt-2">${data.court_name}</p>
						        </li>`;  
				        }    
					 	 
						
				      })
				      
	                } 
	              else {
	                        
	                 }
	                 
	               //document.getElementById('upcoming').innerHTML=html_upcoming;
	                //document.getElementById('past').innerHTML=html_past;
	
				}
			})
			
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


$('#assigned_table').on('click', '.view', function() {
		
		 let fullname = $(this).prop('id');
		 
		 console.log(fullname);
		 $('#assignedCasesUserModal').modal('show')
		 let dataSet =[];
		 
		 $.ajax({
		url:"head_legal",
		method:"POST",
		data:{"request_type":"assigned_cases_user",
			  "fullname":fullname
			  },
		success:function(response){
			console.log(response);
			
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.cases !== null){
							
							for(let i=0; i<json_result.cases.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.cases[i].id}" ></div>`
			                let suit_number= json_result.cases[i].suit_number;
			                let nature_of_case= json_result.cases[i].nature_of_case;
			                let plaintiffs=(json_result.cases[i].plaintiffs !==null)? json_result.cases[i].plaintiffs[0].plaintiffs_name:"";
			                let defendants=(json_result.cases[i].defendants !==null)? json_result.cases[i].defendants[0].defendants_name:"";
			               	let date_of_document=convertDate(json_result.cases[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.cases[i].date_received.slice(0,10));
			               	let received_at=json_result.cases[i].secretariat;
			              	let actions=`<div class="dropdown no-arrow">
				              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
							                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
							              </svg>
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
			                let region=json_result.cases[i].region;
			                
			               html.push(id);
			               html.push(suit_number);
			               html.push(nature_of_case); 
			               html.push(court_name);  
			               html.push(region); 
			               html.push(plaintiffs); 
			               html.push(defendants); 
			               html.push(date_of_document); 
			               html.push(date_received); 
			               html.push(received_at);
			               html.push(actions);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#assigned_user_table').DataTable().clear().destroy();
								
							$('#assigned_user_table').DataTable({ data: dataSet
							}).draw();
							
		              	
						}
			
			}
		})
		 
		 
		 
})
 /// Apex Chart
showApexChart = (series,labels) => {
  new ApexCharts(document.querySelector("#donutChart"), {
						                    series: series,
						                    chart: {
						                      height: 350,
						                      type: 'donut',
						                      toolbar: {
						                        show: true
						                      }
						                    },
						                    labels: labels,
						                  }).render();
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


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
			
})


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
			data:{"request_type":"load_timeline"
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
	                
	                //console.log(dd_end_date.toLocaleDateString('en-GB'))
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



