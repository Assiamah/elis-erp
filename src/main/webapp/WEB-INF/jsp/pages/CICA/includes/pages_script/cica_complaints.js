$(function(){
	
	 $('#open').on('click', function() {
			
			let dataSet =[];
			document.getElementById("archived_search").style.display="none";
			$.ajax({
				url:"cica_complaints_serv",
				method:"POST",
				data:{"request_type":"load_complaints",
						"status":"open"},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
			
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input " type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let enquiry_id= json_result.data[i].client_id;
			                let client_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	let client_phone= json_result.data[i].client_phone;
			              	let client_email= json_result.data[i].client_email;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10)); 	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			              	    <a class="dropdown-item reply" href="#" id="${json_result.data[i].client_id}">Reply</a>
			              	    <a class="dropdown-item status" href="#" id="${json_result.data[i].client_id}">Update Status</a>
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(enquiry_id);
			               html.push(client_name);
			               html.push(subject); 
			               html.push(description);
			               html.push(client_phone); 
			               html.push(client_email); 
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
			 $("#body-bg-2").removeClass('bg-active');
				
		})
		
		
		$('#archived').on('click', function() {
			
					let dataSet =[];
			document.getElementById("archived_search").style.display="block";
			 document.getElementById("card_title").innerHTML="Archived";
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1").removeClass('bg-active');
			 
				$('#table_list').DataTable().clear().destroy();
								
				$('#table_list').DataTable({ data: dataSet }).draw();	
				
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
				"type":"complaints"
			},
			success:function(response){
			  console.log(response);
			  let json_result = JSON.parse(response);

			 if(json_result.success){
				const replies=json_result.data[0].replies;
				let html="";
				 if(json_result.data !== null && json_result.data[0].replies !== null){	
						replies.forEach(function(reply){
							//console.log(reply);
							
							let d = new Date(reply.date);
							let replydate=d.toString().slice(0,24);
							
						html+=`
			               
			                <div class="card">
			                  <div class="card-body">
			                    <textarea class="form-control">${reply.reply}</textarea>
			                    <div class=" mt-2"><small>${reply.fullname} | <span class="text-primary">${reply.unit_name}</span></small> </div>
			                    <div class="label">
				                <small class="">${replydate}</small>
				            </div>
			                  </div>
			                  <!-- <div class="card-footer">
			                    <a class="btn btn-primary btn-sm send_client"
			                    id="${json_result.data[0].id}"
			                    data-id="${reply.reply}">Send to client</a>
			                    <a class="btn btn-danger btn-sm">Delete</a> 
			                  </div>-->
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
        	//console.log(reply_obj);
   		 
   		 	$.ajax({
			type:"POST",
			url:"cica_tickets_serv",
			data:{"request_type":"reply_ticket",
				  "replies":JSON.stringify(reply_obj),
				  "ticket_id":ticket_id,
				  "type":"complaints"
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
				  "type":"complaints"
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

document.getElementById("btnCCJobSearch").addEventListener("click", function () {
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
				                type:"complaints"
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
			                let id=`<div class="form-check"> <input class="form-check-input " type="checkbox" id="gridCheck" data_id="${json_result.data[i].client_id}" ></div>`
			                let enquiry_id= json_result.data[i].client_id;
			                let client_name= json_result.data[i].client_name;
			              	let subject= json_result.data[i].subject;
			              	let description= json_result.data[i].description;
			              	let client_phone= json_result.data[i].client_phone;
			              	let client_email= json_result.data[i].client_email;
			              	let created_by= json_result.data[i].created_by;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10)); 	
			              	let actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
						                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
						              </svg>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	
			           
			              	  </div>
			              	</div>`;
			            
			                
			               html.push(id);
			               html.push(enquiry_id);
			               html.push(client_name);
			               html.push(subject); 
			               html.push(description);
			               html.push(client_phone); 
			               html.push(client_email); 
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


				                    }
				                }

                       })
   	function checkInput(){
	 let checkedList=[];
    let checkBoxes =document.getElementsByClassName('rbtn_search_type');
    for (let i=0;i<checkBoxes.length;i++){
        if(checkBoxes[i].checked){
            checkedValue=checkBoxes[i].value;
            checkedList.push(checkedValue);
        }
    }
    
    if(checkedList.length === 0){
        toastr["error"]("Nothing selected ", "Job Search");
        return false;
    }
    else{
   	 
   	 
   	 return true;
    }
}

	
})