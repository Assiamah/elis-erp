$(function(){
	
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
								 <form action="cica_replies" method="post">
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
	
})