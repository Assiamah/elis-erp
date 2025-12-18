$(function(){
	
	       let dataSet =[];
		   let regional_code= $('input[name="regional_code"]').val();
		   let unit_id= $('input[name="unit_id"]').val();
			 
			$.ajax({
				url:"cica_replies_serv",
				method:"POST",
				data:{"request_type":"load_unit_tickets",
						"regional_code":regional_code,
						"unit_id":unit_id
						},
				success:function(response){
					
					console.log(response);
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
			              	let purpose= getPurpose((json_result.data[i].purpose).trim());
			              	let complainant_phone= json_result.data[i].client_phone;
			              	let complainant_email= json_result.data[i].client_email;
			              	//let related_service= json_result.data[i].related_service;
			              	//let service_number= json_result.data[i].service_number;
			              	//let priority= json_result.data[i].priority;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	let region=json_result.data[i].region;
			               	let unit=json_result.data[i].unit;
			               	let unread_reply=json_result.data[i].unread_reply;			               	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}">Reply</a>
			              	  </div>
			              	</div>`;
			                let unit_replied=json_result.data[i].unit_replied;	
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(purpose);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description);  
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(region); 
			               html.push(unit); 
			               //html.push(priority);
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
			               html.push(unread_reply);
			               html.push(unit_replied);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet,
							"createdRow": function(row,data,dataIndex){
								if(data[13]){
									$(row).addClass('redClass');
								}
								else{
									if(data[14]){
										$(row).addClass('greenClass');
									}
								}
							}
							 }).draw();
					
								
		              	
						}				
					}
				})
	
	
	
	
	 $('#tickets').on('click', function() {
			
			let dataSet =[];
			
			$.ajax({
				url:"cica_replies_serv",
				method:"POST",
				data:{"request_type":"load_replies",
						"type":"tickets"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input " type="checkbox" id="gridCheck" data_id="${json_result.data[i].id}" ></div>`
			                let ticket_id= json_result.data[i].id;
			                let complainant_name= json_result.data[i].complainant_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	let complainant_phone= json_result.data[i].complainant_phone;
			              	let complainant_email= json_result.data[i].complainant_email;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].id}" data-type="tickets">Reply</a>
			           
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description);  
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet }).draw();
							
						
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="Open";
			 $("#body-bg-1").addClass('bg-active');
			 $("#body-bg-2, #body-bg-3,#body-bg-4").removeClass('bg-active');
				
		})
		
		
		$('#complaints').on('click', function() {
			
			let dataSet =[];
			
			$.ajax({
				url:"cica_replies_serv",
				method:"POST",
				data:{"request_type":"load_replies",
						"type":"complaints"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input " type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let ticket_id= json_result.data[i].client_id;
			                let complainant_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	let complainant_phone= json_result.data[i].client_phone;
			              	let complainant_email= json_result.data[i].client_email;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	
			              		let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}" data-type="complaints">Reply</a>
			              	  </div>
			              	</div>`;
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description); 
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet }).draw();
							
						
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="Open";
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1, #body-bg-3,#body-bg-4").removeClass('bg-active');
				
		})
	
	$('#enquiries').on('click', function() {
			
			let dataSet =[];
			
			$.ajax({
				url:"cica_replies_serv",
				method:"POST",
				data:{"request_type":"load_replies",
						"type":"enquiry"},
				success:function(response){
					
					//console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input " type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let ticket_id= json_result.data[i].client_id;
			                let complainant_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	let complainant_phone= json_result.data[i].client_phone;
			              	let complainant_email= json_result.data[i].client_email;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			               	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}" data-type="enquiry">Reply</a>
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(ticket_id);
			               html.push(complainant_name);
			               html.push(subject); 
			               html.push(description); 
			               html.push(complainant_phone); 
			               html.push(complainant_email); 
			               html.push(created_by); 
			               html.push(date_created);
			               html.push(actions);
		
			                dataSet.push(html);
		            		}

							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet }).draw();
							
						
		              	
						}				
					}
				})
				
			 document.getElementById("card_title").innerHTML="Open";
			 $("#body-bg-3").addClass('bg-active');
			 $("#body-bg-1, #body-bg-2,#body-bg-4").removeClass('bg-active');
				
		})
		
		
		
		
	$('#table_list').on('click', '.reply', function() {
		
		 let id = $(this).prop('id');
		 $('input[name="ticket_id"]').val(id);
		$('#replyModal').modal('show');
		document.getElementById("all_replies").innerHTML="";
	
		$.ajax({
			type:"POST",
			url:"cica_replies_serv",
			data:{"request_type":"get_replies",
				"id":id
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
			 console.log(response);
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
						
						$('#m_receiver').val(json_result.data[0].client_email);
						$('#m_name').val(json_result.data[0].client_name);
						$('#m_phone').val(json_result.data[0].client_phone);
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
   		 let type='unit';
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
			data:{"request_type":"reply_ticket",
				  "replies":JSON.stringify(reply_obj),
				  "ticket_id":ticket_id,
				  "type":type
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
   		 let type=$('input[name="type_client"]').val();;
   		 let date=Date.now();
   		 let receiver=$('input[name="m_receiver"]').val(); 
   		 let name = $('input[name="m_name"]').val();
   		 let phone =$('input[name="m_phone"]').val();   		 
   		 const reply_obj = {"userid": userid,
						"fullname":fullname,
						"unit_name": unit_name,
						"unit_id":unit_id,
						"reply": reply,
						"date":date
						};

		console.log(receiver);
   		 
   		 	$.ajax({
			type:"POST",
			url:"cica_replies",
			data:{"request_type":"client_reply",
				  "replies":JSON.stringify(reply_obj),
				  "ticket_id":ticket_id,
				  "type":type,
				  "receiver":receiver,
				  "name":name,
				  "message":reply,
				  "phone":phone,
				  "date":date
				  
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
			url:"cica_tickets",
			data:{"request_type":"status_update",
				  "status_obj":JSON.stringify(status_obj),
				  "ticket_id":ticket_id,
				  "status":status
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
   	
   	
   	function getPurpose(x){
			let purpose;
			if(x=='1'){
				purpose='Service Related Enquiry';
			}
			else if(x=='2'){
				purpose='Other Enquiry';
			}
			else if(x=='3'){
				purpose='Service Related Complaint'
			}
			else{
				purpose='Non Service Complaint'
			}
			
			return purpose;
    }
   	
	
	
})