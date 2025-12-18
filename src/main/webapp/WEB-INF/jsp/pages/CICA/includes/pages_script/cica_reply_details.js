document.addEventListener('DOMContentLoaded', function() {  
	
	$('#phone_div').hide()
	$('#email_div').hide()
	
	$("#contact_by").on('change',function(){
		let contact_by= $('#contact_by').find(":selected").val();
		
		if(contact_by == 'Telephone') {
			$('#phone_div').show()
			$('#email_div').hide()
		} else if(contact_by == 'Email') {
			$('#email_div').show()
			$('#phone_div').hide()
		}
	})
	
   $("#send_reply_to_client").on('submit',function(e){
	   
		e.preventDefault();

		let ticket_no=$('input[name="ticket_no"]').val();
		let sent_by_id=$('input[name="sent_by_id"]').val();
		let contact_by=$('#contact_by').find(":selected").val();
		let client_contact=$('#contact_by').find(":selected").val() == "Email" ? $('input[name="client_email"]').val() : $('input[name="client_phone"]').val();
		let message=$('#message').val();
		let sent_by=$('input[name="sent_by"]').val();
		
		console.log(client_contact, ticket_no, sent_by_id, contact_by, message, sent_by)
		
		let request_type = "send_reply_to_client";
		
		if(!contact_by) {
			toastr["error"]("Select conatact type", "Error");
		}
		
		else {
			$.ajax({
				method:"POST",
				url : "cica_replies_serv",
				data : {"ticket_no":ticket_no,
						"sent_by_id":sent_by_id,
						"contact_by":contact_by,
						"client_contact":client_contact,
						"message":message,
						"sent_by":sent_by,  
						"request_type":request_type
						},
				success:function(response){
					
					console.log(response);
				 let json_result = JSON.parse(response);
	
				 if(json_result.success == true){
					 toastr["success"]("Message Sent Successfully", "Success");
	                } 
	              else {
	                        toastr["error"]("Message not sent", "Error");
	                 }
	
	                    $("#send_reply_to_client").find('form').trigger('reset');
	                    //$("#updateStatusModal").modal('hide');
	                   setTimeout(function(){
	                        location.reload();
	                    },1000); 
				}
				
			})
		}
	})
	
	 var table_status_note = $('#status_note');
		table_status_note.find("tbody tr").remove();
		
		let ticket_no=$('input[name="ticket_no"]').val();
		
		let dataSet_ = [];
    	var num = '';	
		
				
		$.ajax({
			url:"cica_tickets_serv",
			method:"POST",
			data:{
					"request_type":"load_status_note",
					"ticket_no":ticket_no,
			},
			success:function(response){
				console.log(response);
				
				var result = JSON.parse(response);
                if(result.success == true){
					
					if(result.data){
						for(let i = 0; i<result.data.length; i++) {
						let html_ = [];
						num = (+num + 1);
						
						let note = result.data[i].note;
						let status = result.data[i].status_id;
						let updated_by = result.data[i].updated_by;
						let updated_at = result.data[i].updated_at.split('T')[0];
						
						if(status == 2) {
							status = 'Pending'
						}
						if(status == 1) {
							status = 'On Hold'
						}
						if(status == 3) {
							status = 'Resolved'
						}
						
						html_.push(note);
						html_.push(status);
						html_.push(updated_by);
						html_.push(updated_at);

            			dataSet_.push(html_);
					}
					
					$('#status_note').DataTable({
		                //pageLength: 10,
		                data: dataSet_,
		                searching: false, 
		                paging: false, 
		                info: false,
		                ordering: false
		            });
		            
		           document.getElementById("status_note").style.width = "870px";
					}
					
					
				}
			
			}
		})
		
				
				
	var table_replies = $('#one_replies_tbl');
		table_replies.find("tbody tr").remove();
		
		//let ticket_no=$('input[name="ticket_no"]').val();
		
		let dataSet__ = [];
    	var num = '';	
		
				
		$.ajax({
			url:"cica_tickets_serv",
			method:"POST",
			data:{
					"request_type":"load_ticket_one_replies",
					"ticket_no":ticket_no,
			},
			success:function(response){
				console.log(response);
				
				var result = JSON.parse(response);
                if(result.success == true){
					
					if(result.data){
						for(let i = 0; i<result.data.length; i++) {
						let html_ = [];
						num = (+num + 1);
						
						let ticket_no = result.data[i].ticket_no;
						let description = result.data[i].description;
						let attachment = result.data[i].attachment;
						let region = result.data[i].region;
						let division = result.data[i].division;
						let replied_by = result.data[i].replied_by;
						let attachment_path = result.data[i].attachment_path;
						let replied_on = result.data[i].replied_on.split('T')[0];
						let action = `
							<div class="text-end">
								<button class="btn btn-primary btn-sm link-post" data-attachment="${attachment}" data-description="${description}" data-attachment_path="${attachment_path}" data-ticket_no="${ticket_no}">View</button>
							</div>
						`;
						
						if(attachment == true) {
							attachment = 'Yes'
						}
						if(attachment == false) {
							attachment = 'No'
						};

						let msg = result.data[0].description;
						$('#message').val('Dear valued client, '+msg+'\nTicket No.: '+ticket_no);
						
						var descriptionArr = description.split(" ");
						var descriptionShort = descriptionArr.splice(0, 10).join(" ");
						
						html_.push(descriptionShort+"...");
						//html_.push(description);
						html_.push('<div class="text-center">'+attachment+'</div>');
						html_.push(region);
						html_.push(division);
						html_.push(replied_by);
						html_.push(replied_on);
						html_.push(action);

            			dataSet__.push(html_);
					}
					
					$('#one_replies_tbl').DataTable({
		                //pageLength: 10,
		                data: dataSet__,
		                searching: false, 
		                paging: false, 
		                info: false,
		                ordering: false
		            });
		            
		           document.getElementById("one_replies_tbl").style.width = "870px";
					}
					
					
				}
			
			}
		})
		
		
		$('#one_replies_tbl')
		.on(
				'click',
				'.link-post',
				function(event) {
					// console.log(e)
					event.preventDefault();

					var ticket_no=$(event.currentTarget).data('ticket_no');
					var attachment_path = $(event.currentTarget).data('attachment_path');
					var attachment = $(event.currentTarget).data('attachment');
					
					if(attachment == false) {
						$('#attachment_status').addClass('d-none');
					} else {
						$('#attachment_status').removeClass('d-none');
					}
					
					document.getElementById("r_ticket_no").innerHTML = $(event.currentTarget).data('ticket_no');	
					document.getElementById("r_description").innerHTML = $(event.currentTarget).data('description');
					
					// console.log(ticket_no);
					// console.log(attachment_path);
						
					//var file_to_open = event.target.href;
					// C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
					//console.log(file_to_open)
					// var str = "Visit Microsoft!";
					//var file_path = file_to_open.replace("http://localhost:8080/U", "file:///u");
					
					$.ajax({
								type : "POST",
								//url : "open_pdffile",
								url: "cica_tickets_serv",
								// target:'_blank',
								data : {
									//request_type : 'request_to_generate_batch_list',
									request_type: 'open_replied_doc',
									ticket_no : ticket_no,
									attachment_path: attachment_path
								},
								cache : false,
								xhrFields : {
									responseType : 'blob'
								},
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success : function(jobdetails) {
									console.log(jobdetails);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);
									$('#elisDocumentPreviewx').modal('show');
									$('#elisDocumentPreviewx')
											.modal(
													{
														backdrop : 'static',
													});

									var blob = new Blob(
											[ jobdetails ],
											{
												type : "application/pdf"
											});
									var objectUrl = URL
											.createObjectURL(blob);
									// window.open(objectUrl);

									$(
											'#elisdovumentpreviewblobfile')
											.attr('src',
													objectUrl);

									$(
											'#fedocumentPreviewblobfile')
											.attr('src',
													objectUrl);

									// $('#NotoncaseafterPaymentModalonCase').modal('hide');

								}
							});

				});
				
				
		var table_sms_message = $('#sms_message');
		table_sms_message.find("tbody tr").remove();
		
		//let ticket_no=$('input[name="ticket_no"]').val();
		
		let dataSet = [];
    	var num = '';	
		
				
		$.ajax({
			url:"cica_tickets_serv",
			method:"POST",
			data:{
					"request_type":"load_sms_messages",
					"ticket_no":ticket_no,
			},
			success:function(response){
				console.log(response);
				
				var result = JSON.parse(response);
                if(result.success == true){
					
					if(result.data){
						for(let i = 0; i<result.data.length; i++) {
						let html = [];
						num = (+num + 1);
						
						let message = result.data[i].message;
						let contact_by = result.data[i].contact_by;
						let client_contact = result.data[i].client_contact;
						let sent_by = result.data[i].sent_by;
						let sent_date = result.data[i].sent_date.split('T')[0];
						
						/*if(status == 2) {
							status = 'Pending'
						}
						if(status == 1) {
							status = 'On Hold'
						}
						if(status == 3) {
							status = 'Resolved'
						}*/
						
						html.push(message);
						html.push(client_contact);
						html.push(sent_by);
						html.push(sent_date);

            			dataSet.push(html);
					}
					
					$('#sms_message').DataTable({
		                //pageLength: 10,
		                data: dataSet,
		                searching: false, 
		                paging: false, 
		                info: false,
		                ordering: false
		            });
		            
		           document.getElementById("sms_message").style.width = "870px";
					}
					
					
				}
			
			}
		})		
		
})