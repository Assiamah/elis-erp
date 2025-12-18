$(function(){
	
	 $('#tickets_open').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			 let regional_code= $('input[name="regional_code"]').val();
			 //console.log(regional_code);
			
			$.ajax({
				url:"cica_tickets_serv",
				method:"POST",
				data:{"request_type":"load_tickets",
						"regional_code":regional_code,
						"status":0},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let reference_id= json_result.data[i].reference_id;
			              	let division= json_result.data[i].division;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
							let destination= json_result.data[i].destination;
			               	let date_created=new Date(json_result.data[i].created_at).toISOString().split('T')[0];	 		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_tickets_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division);
			               html.push('<div style="text-transform: capitalize">'+reference_id+'</div>'); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(focal_reply);
			               html.push(message);
						   html.push(destination);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[11] == true && data[13] == 1){
									$(row).addClass('bg-warning');
								}
								else if(data[11] == true && data[13] == 2){
									$(row).addClass('bg-info');
								}
								else if(data[12] == 1 && data[13] == 2){
									$(row).addClass('bg-success');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="List of Open Tickets";
			 $("#body-bg-1").addClass('bg-active');
			 $("#body-bg-2, #body-bg-3,#body-bg-4").removeClass('bg-active');
			 $("#btnViewBatchlist").removeClass('disabled')
				
		})
		
		
		$('#tickets_pending').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			 let regional_code= $('input[name="regional_code"]').val();
			
			$.ajax({
				url:"cica_tickets_serv",
				method:"POST",
				data:{"request_type":"load_tickets",
						"regional_code":regional_code,
						"status":2},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let reference_id= json_result.data[i].reference_id;
			              	let division= json_result.data[i].division;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
							let destination= json_result.data[i].destination;
			               	let date_created= new Date(json_result.data[i].created_at).toISOString().split('T')[0];	               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_tickets_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division);
			               html.push(reference_id); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(focal_reply);
			               html.push(message);
						   html.push(destination);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								//console.log(data[13])

								if(data[11] == true && data[13] == 1){
									$(row).addClass('bg-warning');
								}
								else if(data[11] == true && data[13] == 2){
									$(row).addClass('bg-info');
								}
								else if(data[12] == 1 && data[13] == 2){
									$(row).addClass('bg-success');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="List of Pending Tickets";
			 $("#body-bg-3").addClass('bg-active');
			 $("#body-bg-2, #body-bg-4,#body-bg-1").removeClass('bg-active');
			 $("#btnViewBatchlist").removeClass('disabled')
				
		})
		
		
		$('#tickets_hold').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			 let regional_code= $('input[name="regional_code"]').val();
			
			$.ajax({
				url:"cica_tickets_serv",
				method:"POST",
				data:{"request_type":"load_tickets",
						"regional_code":regional_code,
						"status":1},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let reference_id= json_result.data[i].reference_id;
			              	let division= json_result.data[i].division;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
							let destination= json_result.data[i].destination;
			               	let date_created=new Date(json_result.data[i].created_at).toISOString().split('T')[0];	 	               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_tickets_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division);
			               html.push(reference_id); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(focal_reply);
			               html.push(message);
						   html.push(destination);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[11] == true && data[13] == 1){
									$(row).addClass('bg-warning');
								}
								else if(data[11] == true && data[13] == 2){
									$(row).addClass('bg-info');
								}
								else if(data[12] == 1 && data[13] == 2){
									$(row).addClass('bg-success');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="List of Hold Tickets";
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-3, #body-bg-4,#body-bg-1").removeClass('bg-active');
			 $("#btnViewBatchlist").removeClass('disabled')
				
		})
		
		
		$('#tickets_resolved').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="block";
			 //let regional_code= $('input[name="regional_code"]').val();
			
			/*$.ajax({
				url:"cica_tickets",
				method:"POST",
				data:{"request_type":"load_tickets",
						"regional_code":regional_code,
						"status":3},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`
					              	`
					              	 <form action="cica_tickets" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
										<input type="hidden"  name="view_by" value="1">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
		
			                dataSet.push(html);
		            		}

							}*/
							
							$('#table_list').DataTable().clear().destroy();
								
							/*$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[10] == true && data[11] == true){
									$(row).addClass('bg-success');
								}
								else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})*/
				
			 document.getElementById("card_title").innerHTML="List of Resolved Tickets";
			 $("#body-bg-4").addClass('bg-active');
			 $("#body-bg-3, #body-bg-2,#body-bg-1").removeClass('bg-active');
			 $("#btnViewBatchlist").addClass('disabled');
				
		})
		
		
		$('#tickets_incoming').on('click', function() {
			
			let dataSet =[];
			document.getElementById("focal_person_archived_search").style.display="none";
			
			$.ajax({
				url:"cica_focal_person_serv",
				method:"POST",
				data:{"request_type":"load_focal_person_tickets",
						"focal_foward":0},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-description="${json_result.data[i].description}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
							let job_number= json_result.data[i].reference_id;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));	
							let note = json_result.data[i].note;
							let note_date = json_result.data[i].note_date;
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_focal_person_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(job_number); 
			               html.push(date_created);
						   html.push(note_date);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
			               html.push(message);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();

							$.fn.dataTable.ext.type.detect.unshift(
								function ( d ) {
									return (d === 'Low' || d === 'Medium' || d === 'High' || d === 'Urgent') ?
										'priority' :
										null;
								}
							);
							
							$.fn.dataTable.ext.type.order['priority'] = function ( d ) {
								switch ( d ) {
									case 'Low'      :   return 1;
									case 'Medium'   :   return 2;
									case 'High'     :   return 3;
									case 'Urgent'   :   return 4;
								}
								return 0;
							};
								
							$('#table_list').DataTable({ 
								data: dataSet,
								"order"     : [[ 6, "asc" ]],
								"createdRow": function(row,data,dataIndex){
									if(data[13] == 1){
										$(row).addClass('bg-success');
									}
									else if(data[11] == true){
										$(row).addClass('bg-info');
									}
									else if(data[12] == true){
										$(row).addClass('bg-warning');
									}
								},

							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="List of Incoming Tickets";
			 $("#body-bg-1").addClass('bg-active');
			 $("#body-bg-2").removeClass('bg-active');
			 $("#btnViewBatchlist").removeClass('disabled')
				
		})
		
		
		$('#tickets_outgoing').on('click', function() {
			
			let dataSet =[];
			document.getElementById("focal_person_archived_search").style.display="block";
			
			/*$.ajax({
				url:"cica_focal_person",
				method:"POST",
				data:{"request_type":"load_focal_person_tickets",
						"focal_foward":1},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`
					              	`
					              	 <form action="cica_tickets" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
										<input type="hidden"  name="view_by" value="1">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
		
			                dataSet.push(html);
		            		}

							}*/
							
							$('#table_list').DataTable().clear().destroy();
								
							/*$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[10] == true && data[11] == true){
									$(row).addClass('bg-success');
								}
								else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})*/
				
			 document.getElementById("card_title").innerHTML="List of Outgoing Tickets";
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1").removeClass('bg-active');
			 $("#btnViewBatchlist").addClass('disabled')
				
		})
		
		$('#tickets_replies').on('click', function() {
			
			let dataSet =[];
			document.getElementById("replies_archived_search").style.display="none";
			
			$.ajax({
				url:"cica_replies_serv",
				method:"POST",
				data:{"request_type":"load_replies",
						"focal_foward":0},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" ${json_result.data[i].message == 1 ? '' : 'disabled'} type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_replies_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">View Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
			               html.push(message);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12] == 1){
									$(row).addClass('bg-success');
								}
								/*else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}*/
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="List of Replied Tickets";
			 $("#body-bg-1").addClass('bg-active');
			 $("#body-bg-2").removeClass('bg-active');
			 $("#btnViewBatchlist").removeClass('disabled')
				
		})
		
		$('#tickets_archived').on('click', function() {
			
			let dataSet =[];
			document.getElementById("replies_archived_search").style.display="block";
			
			/*$.ajax({
				url:"cica_focal_person",
				method:"POST",
				data:{"request_type":"load_focal_person_tickets",
						"focal_foward":1},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`
					              	`
					              	 <form action="cica_tickets" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
										<input type="hidden"  name="view_by" value="1">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
		
			                dataSet.push(html);
		            		}

							}*/
							
							$('#table_list').DataTable().clear().destroy();
								
							/*$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[10] == true && data[11] == true){
									$(row).addClass('bg-success');
								}
								else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})*/
				
			 document.getElementById("card_title").innerHTML="List of Archived Tickets";
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1").removeClass('bg-active');
			 $("#btnViewBatchlist").addClass('disabled')
				
		})
		
		
		 $('#enquiry_non_service').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			 let regional_code= $('input[name="regional_code"]').val();
			
			$.ajax({
				url:"cica_tickets_serv",
				method:"POST",
				data:{"request_type":"load_enquiry_service",
						"regional_code":regional_code,
						"purpose":"enquiry_non_service"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd" type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let ticket_id= json_result.data[i].client_id;
			                let complainant_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	//let contact_by= json_result.data[i].contact_type;
			              	let complainant_phone= json_result.data[i].client_phone;
			              	let complainant_email= json_result.data[i].client_email;
			              	//let related_service= json_result.data[i].related_service;
			              	//let service_number= json_result.data[i].service_number;
			              	//let priority= json_result.data[i].priority;
			              	let region=json_result.data[i].region;
			               	let unit=json_result.data[i].unit;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	let unread_reply=json_result.data[i].unread_reply;			               	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}">Reply</a>
			              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i].client_id}">Forward</a>

			              	    <a class="dropdown-item status" href="#" id="${json_result.data[i].client_id}">Update Status</a>
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description);  
			              // html.push(contact_by); 
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(region); 
			               html.push(unit); 
			               //html.push(priority);
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(unread_reply);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12]){
									$(row).addClass('greenClass');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="Non-Service Related Enquires";
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1, #body-bg-3,#body-bg-4").removeClass('bg-active');
				
		})
		
		 $('#complaints_service').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			 let regional_code= $('input[name="regional_code"]').val();
			
			$.ajax({
				url:"cica_tickets_serv",
				method:"POST",
				data:{"request_type":"load_enquiry_service",
						"regional_code":regional_code,
						"purpose":"complaints_service"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd" type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let ticket_id= json_result.data[i].client_id;
			                let complainant_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	//let contact_by= json_result.data[i].contact_type;
			              	let complainant_phone= json_result.data[i].client_phone;
			              	let complainant_email= json_result.data[i].client_email;
			              	let region=json_result.data[i].region;
			               	let unit=json_result.data[i].unit;
			              	//let related_service= json_result.data[i].related_service;
			              	//let service_number= json_result.data[i].service_number;
			              	//let priority= json_result.data[i].priority;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	let unread_reply=json_result.data[i].unread_reply;			               	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}">Reply</a>
			              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i].client_id}">Forward</a>
			              	    <a class="dropdown-item status" href="#" id="${json_result.data[i].client_id}">Update Status</a>
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description);  
			              // html.push(contact_by); 
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(region); 
			               html.push(unit); 
			               //html.push(priority);
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(unread_reply);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12]){
									$(row).addClass('greenClass');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="Service Related Complaints";
			 $("#body-bg-3").addClass('bg-active');
			 $("#body-bg-1, #body-bg-2,#body-bg-4").removeClass('bg-active');
				
		})
	
		
		 $('#complaints_non_service').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			 let regional_code= $('input[name="regional_code"]').val();
			
			$.ajax({
				url:"cica_tickets_serv",
				method:"POST",
				data:{"request_type":"load_enquiry_service",
						"regional_code":regional_code,
						"purpose":"complaints_non_service"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd" type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let ticket_id= json_result.data[i].client_id;
			                let complainant_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	//let contact_by= json_result.data[i].contact_type;
			              	let complainant_phone= json_result.data[i].client_phone;
			              	let complainant_email= json_result.data[i].client_email;
			              	//let related_service= json_result.data[i].related_service;
			              	//let service_number= json_result.data[i].service_number;
			              	//let priority= json_result.data[i].priority;
			              	let region=json_result.data[i].region;
			               	let unit=json_result.data[i].unit;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	let unread_reply=json_result.data[i].unread_reply;			               	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}">Reply</a>
			              	   <a class="dropdown-item forward" href="#" id="${json_result.data[i].client_id}">Forward</a>
			              	    <a class="dropdown-item status" href="#" id="${json_result.data[i].client_id}">Update Status</a>
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description);  
			              // html.push(contact_by); 
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(region); 
			               html.push(unit); 
			               //html.push(priority);
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(unread_reply);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12]){
									$(row).addClass('greenClass');
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="Non-Service Related Complaints";
			 $("#body-bg-4").addClass('bg-active');
			 $("#body-bg-1, #body-bg-2,#body-bg-3").removeClass('bg-active');
				
		})
		
	$('#table_list').on('click', '.reply', function() {
		
		 let id = $(this).prop('id');
		 $('input[name="ticket_id"]').val(id);
		$('#replyModal').modal('show');
		document.getElementById("all_replies").innerHTML="";
		
		$.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"get_replies",
				"id":id,
				"type":"tickets"
			},
			success:function(response){
			 // console.log(response);
			  let json_result = JSON.parse(response);

			 if(json_result.success){
				const replies=json_result.data[0].replies;
				let html="";
				 if(json_result.data !== null){	
						replies.forEach(function(reply){
							//console.log(reply);
							
							let d = new Date(reply.date);
							let replydate=d.toString().slice(0,24);
							
						html+=`
			               
			                <div class="card">
			                  <div class="card-body">
			                    ${reply.reply}
			                    <div class="card-title mt-2">${reply.fullname} | <span class="text-primary">${reply.unit_name}</span> </div>
			                    <div class="label">
				                <span class="">${replydate}</span>
				            </div>
			                  </div>
			                  <div class="card-footer">
			                    <a class="btn btn-primary btn-sm send_client"
			                    id="${json_result.data[0].id}"
			                    data-id="${reply.reply}">Send to client</a>
			                    <!-- <a class="btn btn-danger btn-sm">Delete</a> -->
			                  </div>
			                </div>`;

						});
					}
					document.getElementById("all_replies").innerHTML=html;
                } 
              else {
                        toastr["error"]("No replies", "CICA");
                 }

			  }
		})
		
	})
	
	
	$('#table_list').on('click', '.status', function() {
		
		 let id = $(this).prop('id');
		 $('#updateStatusModal').modal('show');
		 $('input[name="status_ticket_id"]').val(id);
	})

	
	
	$('#all_replies').on('click', '.send_client', function() {
		
		 let id = $(this).prop('id');
		 let reply=$(this).attr('data-id');
		 $('input[name="ticket_id_client"]').val(id);
		 $('#reply_input_client').val(reply);
		
		 $("#replyModal").find('form').trigger('reset');
         $("#replyModal").modal('hide');
         
         $("#replyClientModal").modal('show');
         document.getElementById("all_client_replies").innerHTML="";
         
         $.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"get_client_replies",
				"id":id
			},
			success:function(response){
			 // console.log(response);
			  let json_result = JSON.parse(response);

			 if(json_result.success){
				const replies=json_result.data[0].replies_to_client;
				let html="";
				 if(json_result.data !== null){	
						replies.forEach(function(reply){
							//console.log(reply);
							
							let d = new Date(reply.date);
							let replydate=d.toString().slice(0,24);
							
						html+=`
			               
			                <div class="card">
			                  <div class="card-body">
			                    ${reply.reply}
			                    <div class="card-title mt-2">${reply.fullname} | <span class="text-primary">${reply.unit_name}</span> </div>
			                    <div class="label">
				                <span class="">${replydate}</span>
				            </div>
			                  </div>
			        
			                </div>`;

						});	
					}
					document.getElementById("all_client_replies").innerHTML=html;
                } 
              else {
                        toastr["error"]("No replies", "CICA");
                 }

			  }
		})
		
	})
	
	
	$("#replyForm").submit(function(e){
   		 e.preventDefault();
   		 
   		  $("#reply_ticket").prop('disabled', true);
		  $("#reply_ticket").text("Please wait ...")
   		 
   		 let ticket_id= $('input[name="ticket_id"]').val();
   		 let userid =  $('input[name="userid"]').val();
   		 let fullname =  $('input[name="fullname"]').val();
   		 let unit_name =  $('input[name="unit_name"]').val();
   		 let unit_id =  $('input[name="unit_id"]').val();
   		 let reply= $('#reply_input').val();
   		 let date=Date.now();
   		 
   		// let replies=JSON.parse(localStorage.getItem('replies')) || [];
   		 
   		 const reply_obj = {"userid": userid,
						"fullname":fullname,
						"unit_name": unit_name,
						"unit_id":unit_id,
						"reply": reply,
						"date":date
						};
						
			//replies.push(reply_obj);
			//localStorage.removeItem('replies');
        	//localStorage.setItem('replies',JSON.stringify(replies));
        	console.log(reply_obj);
   		 
   		 	$.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"reply_ticket",
				  "replies":JSON.stringify(reply_obj),
				  "ticket_id":ticket_id,
				  "type":"tickets"
			},
			success:function(response){
			  console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket replied successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Repling Ticket", "CICA");
                 }

                    $("#replyModal").find('form').trigger('reset');
                    $("#replyModal").modal('hide');
                    
                    $("#reply_ticket").prop('disabled', false);
					$("#reply_ticket").text("Reply")
                  
			}	
		})
   		 
   	})
   	
   	$("#clientReplyForm").submit(function(e){
   		 e.preventDefault();
   		 
   		  $("#client_reply_ticket").prop('disabled', true);
		  $("#client_reply_ticket").text("Please wait ...")
   		 
   		 let ticket_id= $('input[name="ticket_id_client"]').val();
   		 let userid =  $('input[name="userid_client"]').val();
   		 let fullname =  $('input[name="fullname_client"]').val();
   		 let unit_name =  $('input[name="unit_name_client"]').val();
   		 let unit_id =  $('input[name="unit_id_client"]').val();
   		 let reply= $('#reply_input_client').val();
   		 let date=Date.now();
   		 
   		 const reply_obj = {"userid": userid,
						"fullname":fullname,
						"unit_name": unit_name,
						"unit_id":unit_id,
						"reply": reply,
						"date":date
						};

   		 
   		 	$.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"client_reply",
				  "replies":JSON.stringify(reply_obj),
				  "ticket_id":ticket_id
			},
			success:function(response){
			 // console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket replied successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Repling Ticket", "CICA");
                 }

                    $("#replyClientModal").find('form').trigger('reset');
                    $("#replyClientModal").modal('hide');
                    
                    $("#client_reply_ticket").prop('disabled', false);
					$("#client_reply_ticket").text("Send")
                  
			}	
		})
   		 
   	})
   	
   	
   	$("#updateStatusForm").submit(function(e){
   		 e.preventDefault();
   		 
   		  $("#update_status").prop('disabled', true);
		  $("#update_status").text("Please wait ...");
   		 
   		 let ticket_id= $('input[name="status_ticket_id"]').val();
   		 let userid =  $('input[name="userid_client"]').val();
   		 let fullname =  $('input[name="fullname_client"]').val();
   		 let unit_name =  $('input[name="unit_name_client"]').val();
   		 let unit_id =  $('input[name="unit_id_client"]').val();
   		 let date=Date.now();
   		 
   		 let status=$('#status_select').find(":selected").val();
   		 
   		 const status_obj = {"userid": userid,
						"fullname":fullname,
						"unit_name": unit_name,
						"unit_id":unit_id,
						"status": status,
						"date":date
						};
   		 
   		 	$.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"status_update",
				  "status_obj":JSON.stringify(status_obj),
				  "ticket_id":ticket_id,
				  "status":status,
				  "type":"tickets"
			},
			success:function(response){
					 //console.log(response);
					 let json_result = JSON.parse(response);

					 if(json_result.success){
						 toastr["success"]("Ticket updated successfully", "CICA");
		                } 
		              else {
		                        toastr["error"]("Error updating Ticket", "CICA");
		                 }

                    $("#updateStatusModal").find('form').trigger('reset');
                    $("#updateStatusModal").modal('hide');
                    
                    $("#update_status").prop('disabled', false);
					$("#update_status").text("Update")
                  
                  setInterval(function(){
	                       location.reload();
	                 },1000); 
	                 
			}	
		})
   		 
   	})
   	
   	
   		$("#btnCCJobSearch").on("click", function () {
			  // Check if radio button and input field filled
			  if(checkInput()){
				  // Submit Search
				  var enq_search_type = "";
					var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					if (selected_rbtn.length > 0) {
						enq_search_type = selected_rbtn.val();
						//console.log("selected " + enq_search_type);
					}

					var enq_search_value = $(
							"#cc_search_value").val();
					console.log('Search Value: '
							+ enq_search_value);
					
					if (enq_search_type.length <= 0){
						$.notify({
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
						}, { type : 'danger' , z_index: 9999  });
						
					} else {

						$("#cc-search-results-section")
								.hide();
						let dataSet =[];
						$.ajax({
				            type : "POST",
				            url : "cica_tickets_serv",
				            data : {
				                request_type : 'search_archived',
				                search_value : enq_search_value,
				                search_type: enq_search_type,
				                type:"tickets"
				            },
				            cache : false,
				                    success : function(
				                            response) {

				                       //  console.log(response);
								let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let division= json_result.data[i].division;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_tickets_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division);
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(focal_reply);
			               html.push(message);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12] == 1){
									$(row).addClass('bg-success');
								}
								else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}
							}
							 }).draw();
					
								
		              	
						}						
					}
				})


				                    }
				                }

                       })
                       
 
                       
                       
      $("#btnFPJobSearch").on("click", function () {
			  // Check if radio button and input field filled
			  if(checkInput()){
				  // Submit Search
				  var enq_search_type = "";
					var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					if (selected_rbtn.length > 0) {
						enq_search_type = selected_rbtn.val();
						//console.log("selected " + enq_search_type);
					}

					var enq_search_value = $(
							"#cc_search_value").val();
					console.log('Search Value: '
							+ enq_search_value);
					
					if (enq_search_type.length <= 0){
						$.notify({
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
						}, { type : 'danger' , z_index: 9999  });
						
					} else {

						$("#cc-search-results-section")
								.hide();
						let dataSet =[];
						$.ajax({
				            type : "POST",
				            url : "cica_tickets_serv",
				            data : {
				                request_type : 'search_archived',
				                search_value : enq_search_value,
				                search_type: enq_search_type,
				                type:"tickets"
				            },
				            cache : false,
				                    success : function(
				                            response) {

				                       //  console.log(response);
								let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_focal_person" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
			                html.push(message);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12] == 1){
									$(row).addClass('bg-success');
								}
								else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}
							}
							 }).draw();
					
								
		              	
						}						
					}
				})


				                    }
				                }

                       })


$("#btnRRJobSearch").on("click", function () {
			  // Check if radio button and input field filled
			  if(checkInput()){
				  // Submit Search
				  var enq_search_type = "";
					var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					if (selected_rbtn.length > 0) {
						enq_search_type = selected_rbtn.val();
						//console.log("selected " + enq_search_type);
					}

					var enq_search_value = $(
							"#cc_search_value").val();
					console.log('Search Value: '
							+ enq_search_value);
					
					if (enq_search_type.length <= 0){
						$.notify({
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
						}, { type : 'danger' , z_index: 9999  });
						
					} else {

						$("#cc-search-results-section")
								.hide();
						let dataSet =[];
						$.ajax({
				            type : "POST",
				            url : "cica_tickets_serv",
				            data : {
				                request_type : 'search_archived',
				                search_value : enq_search_value,
				                search_type: enq_search_type,
				                type:"tickets"
				            },
				            cache : false,
				                    success : function(
				                            response) {

				                       //  console.log(response);
								let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let unread_reply= json_result.data[i].unread_reply;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			              	let message= json_result.data[i].message;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let actions=/*`<div class="dropdown no-arrow text-center">
								           <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               		<i class="fas fa-ellipsis-v ms-2"></i>
			              	 			</a>
					              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					              	  	<a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
					              	    <a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
					              	    <a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
					              	  </div>
					              	</div>`*/
					              	`
					              	 <form action="cica_replies_post" method="post">
				              	  		<input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
										<input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
										<input type="hidden"  name="request_type" value="load_ticket_details">
				              	    	<div class="text-end">
				              	    		<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
				              	    	</div>
						             </form> 
			              	
			              	`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(region_name); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(dcu_reply);
			               html.push(focal_reply);
			               html.push(message);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[12] == 1){
									$(row).addClass('bg-success');
								}
								else if(data[10] == true){
									$(row).addClass('bg-info');
								}
								else if(data[11] == true){
									$(row).addClass('bg-warning');
								}
							}
							 }).draw();
					
								
		              	
						}						
					}
				})


				                    }
				                }

                       })

					   $("#btnENJobSearch").on("click", function () {
						// Check if radio button and input field filled
						if(checkInput()){
							// Submit Search
							var enq_search_type = "";
							  var selected_rbtn = $("input[name='rbtn_search_type']:checked");
							  if (selected_rbtn.length > 0) {
								  enq_search_type = selected_rbtn.val();
								  //console.log("selected " + enq_search_type);
							  }
				
							  var enq_search_value = $(
									  "#cc_search_value").val();
							  console.log('Search Value: '
									  + enq_search_value);
							  
							  if (enq_search_type.length <= 0){
								  $.notify({
									  message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
								  }, { type : 'danger' , z_index: 9999  });
								  
							  } else {
				
								  $("#cc-search-results-section")
										  .hide();
								  let dataSet =[];
								  $.ajax({
									  type : "POST",
									  url : "cica_tickets_serv",
									  data : {
										  request_type : 'search_archived',
										  search_value : enq_search_value,
										  search_type: enq_search_type,
										  type:"tickets"
									  },
									  cache : false,
											  success : function(
													  response) {
				
												 //  console.log(response);
										  let json_result = JSON.parse(response);
					  
						  
						   if(json_result.success){
								  if(json_result.data !== null){
									  
									  for(let i=0; i<json_result.data.length; i++){
									  let html=[];
									  let id=`<div class="form-check"> <input class="form-check-input fwd tickets" type="checkbox" id="gridCheck" data_id="${json_result.data[i]._id}" data-purpose="${json_result.data[i].purpose}" data-subject="${json_result.data[i].subject}" data-client_name="${json_result.data[i].client_name}" data-ticket_no="${json_result.data[i].ticket_no}"></div>`
									  let ticket_id= json_result.data[i].ticket_no;
									  let name= json_result.data[i].client_name;
										let priority= json_result.data[i].priority;
										let purpose= json_result.data[i].purpose;
										if(purpose == 1) {
										  purpose = 'Service Enquiry'
									  } else if (purpose == 3) {
										  purpose = 'Service Complaint'
									  } else {
										  purpose = "Non-service Complaint"
									  }
										let subject= json_result.data[i].subject;
										let status= json_result.data[i].status;
										if(status == 0) {
										  status = 'Open'
									  }
									  if (status == 1) {
										  status = 'Hold'
									  } 
									  if (status == 2) {
										  status = 'Pending'
									  }
									  if (status == 3) {
										  status = 'Resolved'
									  }
										let region_name= json_result.data[i].region_name;
										let unread_reply= json_result.data[i].unread_reply;
										let division= json_result.data[i].division;
										let focal_reply= json_result.data[i].focal_reply;
										let message= json_result.data[i].message;
										 let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
										let actions=/*`<div class="dropdown no-arrow text-center">
													 <a class="icon dropdown-toggle btn btn-primary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
														 <i class="fas fa-ellipsis-v ms-2"></i>
													 </a>
												  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
													  <a class="dropdown-item reply" href="#" id="${json_result.data[i]._id}">Reply</a>
													<a class="dropdown-item forward" href="#" id="${json_result.data[i]._id}">Forward</a>
													<a class="dropdown-item status" href="#" id="${json_result.data[i]._id}">Update Status</a>
												  </div>
												</div>`*/
												`
												 <form action="cica_enquiry_details" method="post">
													  <input type="hidden" name="ticket_id" value="${json_result.data[i]._id}">
												  <input type="hidden"  name="ticket_no" value="${json_result.data[i].ticket_no}">
												  <input type="hidden"  name="request_type" value="load_ticket_details">
													<div class="text-end">
														<button type="submit" class=" btn btn-primary btn-sm" href="#">Ticket Details</button>
													</div>
											   </form> 
										
										`;
								  
									  
									 html.push(id);
									 html.push(ticket_id);
									 html.push(name);
									 html.push(purpose); 
									 html.push(subject); 
									 html.push('<div class="text-center">'+status+'</div>'); 
									 html.push('<div class="text-center">'+priority+'</div>'); 
									 html.push(division);
									 html.push(region_name); 
									 html.push(date_created);
									 html.push(actions);
									 html.push(focal_reply);
									 html.push(message);
				  
									  dataSet.push(html);
									  }
				
									  }
									  
									  $('#table_list').DataTable().clear().destroy();
										  
									  $('#table_list').DataTable({ data: dataSet,
									  "createdRow": function(row,data,dataIndex){
										  if(data[12] == 1){
											  $(row).addClass('bg-success');
										  }
										  else if(data[10] == true){
											  $(row).addClass('bg-info');
										  }
										  else if(data[11] == true){
											  $(row).addClass('bg-warning');
										  }
									  }
									   }).draw();
							  
										  
									
								  }						
							  }
						  })
				
				
											  }
										  }
				
								 })


function checkInput(){
	 let checkedList=[];
	 let cc_search_value = $('#cc_search_value').val();
    let checkBoxes =document.getElementsByClassName('rbtn_search_type');
    for (let i=0;i<checkBoxes.length;i++){
        if(checkBoxes[i].checked){
            checkedValue=checkBoxes[i].value;
            checkedList.push(checkedValue);
        }
    }
    
    if(checkedList.length === 0){
        toastr["error"]("Nothing selected ", "Error");
        return false;
    } else if (!cc_search_value){
		toastr["error"]("Search keyword required ", "Error");
        return false;
	}
    else{
   	 
   	 
   	 return true;
    }
}


	 $("#forwardbtn").on('click',function(e){
		e.preventDefault();
		let checkedList=[];
		let checkBoxes = document.getElementsByClassName('fwd');
		
		for(let i=0; i<checkBoxes.length;i++){
			if(checkBoxes[i].checked){
				
				checkedList.push(Number(checkBoxes[i].getAttribute('data_id')));
			}
		}
		
		console.log(checkedList);
		
		if(checkedList.length === 0){
			toastr["error"]("No Tickets Selected ", "CICA TICKETS");
		}
		else{
			
			$("#forwardbtn").text("Please wait");
			$("#forwardbtn").prop('disabled',true);
			
			$.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"get_tickets_by_id",
				"list":checkedList
			},
			success:function(response){
				
				console.log(response);
				
				
				}
			})
			
		}
		
		
	})
	
	$('#table_list').on('click', '.forward', function() {
		let id = $(this).prop('id');
		$('input[name="forward_ticket_id"]').val(id);
		$('#forwardModal').modal('show');
		
	})
	
	let region=document.getElementById("region");
	 
	  
	  region.addEventListener("change",function () {
			 let x=region.value;
			 let division=$('#division').find(":selected").val();
			
			 if(division == ""){
				 toastr["warning"]("Select Division", "LEGAL");
				 $('#division').focus();
			 }
			 else{
				 
				 $.ajax({
						url:"Case_Management_Serv",
						method:"POST",
						data:{
								request_type:"get_lc_list_of_units"
						},
						success:function(response){
							console.log(response);
							let json_p = JSON.parse(response);
							var datalist = $("#listofunits");
							datalist.empty();
							
							$(json_p.data).each(
											function() {
														
															if(this.unit_division ==division){
															datalist
																	.append('<option data-name="'
																			+ this.unit_name
																			+ '" data-id="'
																			+ this.unit_id
																			+ '" value="'
																			+ this.unit_id
																			+ '" >'
																			+this.unit_name
																			+'</option>');
															}
											
													});
						}
							
						})
			 }
	  })
	  
	
	 $("#forwardForm").on('submit',function(e){
		e.preventDefault();
		
		$("#forward_ticket").prop('disabled', true);
		
		let ticket_id=$('input[name="forward_ticket_id"]').val();
		let division=$('#division').find(":selected").val();
		let region=$('#region').find(":selected").val();
		let unit=$('input[name="unit"]').val();
	
				$.ajax({
						url:"cica_tickets_serv",
						method:"POST",
						data:{
								request_type:"forward_ticket",
								ticket_id:ticket_id,
								division:division,
								region:region,
								unit:unit
						},
						success:function(response){
							
							
							
							let json_result = JSON.parse(response);

							 if(json_result.success){
								 toastr["success"]("Ticket updated successfully", "CICA");
				                } 
				              else {
				                        toastr["error"]("Error updating Ticket", "CICA");
				                 }
		
		                    $("#forwardModal").find('form').trigger('reset');
		                    $("#forwardModal").modal('hide');
		                    
		                   $("#forward_ticket").prop('disabled', false);
		                  
		                  setInterval(function(){
			                       location.reload();
			                 },1000); 
						}
							
						})
		
		
	})
	
	/************************************************************************************************** */
	
	$('#table_list').on('click', '.attach', function() {
        //let id = $(this).prop('id');
        //let ticket_no=$(this).attr('data-ticket_no');
        //let client_name=$(this).attr('data-client_name');
        //let purpose=$(this).attr('data-purpose');
        //let subject=$(this).attr('data-subject');
        
       	//const attachModal=$('#attachmentModal');
       	//attachModal.modal('show');
        //$('input[name="suit_number"]').val(suit_number);
       	//$('input[name="type_of_document"]').val(type_of_document);
        //$('input[name="case_id"]').val(id);
        //$('input[name="court_process"]').val(court_process);

    })
	
		 // Receive Cases 
	 $("#btnViewBatchlist").on('click',function(e){
		e.preventDefault();
		let checkedList=[];
		let checkBoxes = document.getElementsByClassName('tickets');
		
		for(let i=0; i<checkBoxes.length;i++){
			if(checkBoxes[i].checked){
				const checkedValue = {
					"ticket_no": checkBoxes[i].getAttribute('data-ticket_no'),
					"client_name":checkBoxes[i].getAttribute('data-client_name'),
					"purpose":checkBoxes[i].getAttribute('data-purpose'),
					"subject":checkBoxes[i].getAttribute('data-subject')
				};
				checkedList.push(checkedValue);
			}
		}
		
		let dataSelected=[];
		
		console.log(checkedList);
		
		if(checkedList.length === 0){
			toastr["error"]("No file selected", "Outgoing Files");
		}
		else{
			
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			localStorage.removeItem("checkedList");
			localStorage.setItem('checkedList', JSON.stringify(checkedList));
			
			$('#showBatchlist').modal('show');
			
		}
		
		
	})
	
	
	$("#showBatchlist").on('shown.bs.modal', function() {
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		
		let txt = '<table id="batchTable" class="table"><thead ><th>Ticket Number</th><th>Name</th><th>Purpose</th><th>Subject</th><th>Action</th></thead><tbody>';
		if(checkedList != null){
			for (let i = 0; i < checkedList.length; i++) {
				var purpose = checkedList[i].purpose;
				if(purpose == 1) {
					purpose = 'Service Enquiry'
				}
				if(purpose == 3) {
					purpose = 'Service Complaint'
				}
				if(purpose == 4) {
					purpose = 'Non Service Complaint'
				}
                txt += '<tr><td>' + checkedList[i].ticket_no + '</td>';
                txt += '<td>' + checkedList[i].client_name + '</td>';
                txt += '<td>' + purpose + '</td>';
                txt += '<td>' + checkedList[i].subject + '</td>';
                txt +=`<td><button class="btn btn-danger remove" onclick="deleteRow(this)" data-ticket_no="${checkedList[i].ticket_no}"><i class="fas fa-trash"></i></button></td></tr>`
            }
            txt += '</tbody></table';
        } else {
            txt = "<tr>No Data</tr>";
        }

        document.getElementById("batch_list").innerHTML = txt;
	})


	$("#btnViewRequestlist").on('click',function(e){
		e.preventDefault();
		let checkedList=[];
		let checkBoxes = document.getElementsByClassName('tickets');
		
		for(let i=0; i<checkBoxes.length;i++){
			if(checkBoxes[i].checked){
				const checkedValue = {
					"ticket_no": checkBoxes[i].getAttribute('data-ticket_no'),
					"client_name":checkBoxes[i].getAttribute('data-client_name'),
					"purpose":checkBoxes[i].getAttribute('data-purpose'),
					"subject":checkBoxes[i].getAttribute('data-subject')
				};
				checkedList.push(checkedValue);
			}
		}
		
		let dataSelected=[];
		
		console.log(checkedList);
		
		if(checkedList.length === 0){
			toastr["error"]("No ticket selected", "Outgoing Files");
		}
		else{
			
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			localStorage.removeItem("checkedList");
			localStorage.setItem('checkedList', JSON.stringify(checkedList));
			
			$('#showRequestlist').modal('show');
			
		}
		
		
	})
	
	
	$("#showRequestlist").on('shown.bs.modal', function() {
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		
		let txt = '<table id="batchTable" class="table"><thead ><th>Ticket Number</th><th>Name</th><th>Purpose</th><th>Subject</th><th>Action</th></thead><tbody>';
		if(checkedList != null){
			for (let i = 0; i < checkedList.length; i++) {
				var purpose = checkedList[i].purpose;
				if(purpose == 1) {
					purpose = 'Service Enquiry'
				}
				if(purpose == 3) {
					purpose = 'Service Complaint'
				}
				if(purpose == 4) {
					purpose = 'Non Service Complaint'
				}
                txt += '<tr><td>' + checkedList[i].ticket_no + '</td>';
                txt += '<td>' + checkedList[i].client_name + '</td>';
                txt += '<td>' + purpose + '</td>';
                txt += '<td>' + checkedList[i].subject + '</td>';
                txt +=`<td><button class="btn btn-danger remove" onclick="deleteRow(this)" data-ticket_no="${checkedList[i].ticket_no}"><i class="fas fa-trash"></i></button></td></tr>`
            }
            txt += '</tbody></table';
        } else {
            txt = "<tr>No Data</tr>";
        }

        document.getElementById("request_list").innerHTML = txt;
	})


	$('#btn_print').on('click',function(){
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		let division = $('#ft_division').val();
		let region = $('#ft_region').val();

		//console.log(okay)
		
		if(checkedList != null || !division || !region){
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			//$('#showBatchlist').modal('hide');
			
			$.ajax({
				url:"cica_tickets_serv",
				type:"POST",
				data:{
					request_type:"forward_tickets",
					list:list,
					region:region,
					division:division
				},
				success:function(response){
					console.log(response);
				
					
							let json_result = JSON.parse(response);

							 if(json_result.success){
								 toastr["success"]("Ticket updated successfully", "Success");
				                } 
				              else {
				                        toastr["error"]("Error updating Ticket", "Error");
				                 }
		
		                    $("#showBatchlist").find('form').trigger('reset');
		                    $("#showBatchlist").modal('hide');
		                    
		                   $("#btn_print").prop('btn_print', false);
		                  
		                  setInterval(function(){
			                       location.reload();
			                 },1000); 
					
				}
			})  
		}
		else{
			
			toastr["error"]("No file selected", "Error");
		}
		
	}) 	


	$('#btn_print_bulk_request').on('click',function(){
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		let division = $('#ft_division').val();
		let region = $('#ft_region').val();

		//console.log(okay)
		
		if(checkedList != null || !division || !region){
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			//$('#showBatchlist').modal('hide');
			
			$.ajax({
				url:"cica_tickets_serv",
				type:"POST",
				data:{
					request_type:"forward_tickets",
					list:list,
					region:region,
					division:division
				},
				success:function(response){
					console.log(response);
				
					
							let json_result = JSON.parse(response);

							 if(json_result.success){
								 toastr["success"]("Ticket updated successfully", "Success");
				                } 
				              else {
				                        toastr["error"]("Error updating Ticket", "Error");
				                 }
		
		                    $("#showBatchlist").find('form').trigger('reset');
		                    $("#showBatchlist").modal('hide');
		                    
		                   $("#btn_print_bulk_request").prop('btn_print_bulk_request', false);
		                  
		                  setInterval(function(){
			                       location.reload();
			                 },1000); 
					
				}
			})  
		}
		else{
			
			toastr["error"]("No file selected", "Error");
		}
		
	})
	
	
	$('#btn_focal_print').on('click',function(){
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		
		if(checkedList != null || !division || !region){
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			//$('#showBatchlist').modal('hide');
			
			$.ajax({
				url:"cica_focal_person_serv",
				type:"POST",
				data:{
					request_type:"forward_tickets",
					list:list
				},
				success:function(response){
					console.log(response);
				
					
							let json_result = JSON.parse(response);

							 if(json_result.success){
								 toastr["success"]("Ticket updated successfully", "Success");
				                } 
				              else {
				                        toastr["error"]("Error updating Ticket", "Error");
				                 }
		
		                    $("#showBatchlist").find('form').trigger('reset');
		                    $("#showBatchlist").modal('hide');
		                    
		                   $("#btn_print").prop('btn_print', false);
		                  
		                  setInterval(function(){
			                       location.reload();
			                 },1000); 
					
				}
			})  
		}
		else{
			
			toastr["error"]("No file selected", "Error");
		}
		
	}) 
	
	
	$('#btn_archive_replies').on('click',function(){
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		
		if(checkedList != null || !division || !region){
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			//$('#showBatchlist').modal('hide');
			
			$.ajax({
				url:"cica_replies_serv",
				type:"POST",
				data:{
					request_type:"forward_tickets",
					list:list
				},
				success:function(response){
					console.log(response);
				
					
							let json_result = JSON.parse(response);

							 if(json_result.success){
								 toastr["success"]("Ticket updated successfully", "Success");
				                } 
				              else {
				                        toastr["error"]("Error updating Ticket", "Error");
				                 }
		
		                    $("#showBatchlist").find('form').trigger('reset');
		                    $("#showBatchlist").modal('hide');
		                    
		                   $("#btn_print").prop('btn_print', false);
		                  
		                  setInterval(function(){
			                       location.reload();
			                 },1000); 
					
				}
			})  
		}
		else{
			
			toastr["error"]("No file selected", "Error");
		}
		
	}) 

	// $('#btn_forward_ticket').on('click', function(e) {
	// 	e.preventDefault();

	// 	var ft_divisin = $('#ft_division').val();
	// 	var ft_region = $('#ft_region').val();

	// 	if(!ft_divisin || !ft_region) {

	// 	} else {
	// 		$.ajax({
	// 			url:"cica_replies_serv",
	// 			type:"POST",
	// 			data:{
	// 				request_type:"forward_tickets",
	// 				list:list
	// 			},
	// 			success:function(response){
	// 				console.log(response);
				
					
	// 						let json_result = JSON.parse(response);

	// 						 if(json_result.success){
	// 							 toastr["success"]("Ticket updated successfully", "Success");
	// 			                } 
	// 			              else {
	// 			                        toastr["error"]("Error updating Ticket", "Error");
	// 			                 }
		
	// 	                    $("#showBatchlist").find('form').trigger('reset');
	// 	                    $("#showBatchlist").modal('hide');
		                    
	// 	                   $("#btn_print").prop('btn_print', false);
		                  
	// 	                  setInterval(function(){
	// 		                       location.reload();
	// 		                 },1000); 
					
	// 			}
	// 		}) 
	// 	}
	// })
	
	
})