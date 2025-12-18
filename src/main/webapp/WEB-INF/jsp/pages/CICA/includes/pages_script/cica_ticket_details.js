document.addEventListener('DOMContentLoaded', function() {  
	
   $("#update_status_form").on('submit',function(e){
	   
		e.preventDefault();

		let ticket_no=$('input[name="ticket_no"]').val();
		let ticket_id=$('input[name="ticket_id"]').val();
		let status_id=parseInt($('#status_id').find(":selected").val());
		let updated_by=$('input[name="updated_by"]').val();
		let status_note=$('#txt_note').val();
		let updated_by_id=$('input[name="updated_by_id"]').val();
		let req_client_phone=$('#req_client_phone').val();
		
		//console.log(status_note)
		
		let request_type = "update_ticket_status";
		
		$.ajax({
			method:"POST",
			url : "cica_tickets_serv",
			data : {"ticket_no":ticket_no,
					"ticket_id":ticket_id,
					"status_id":status_id,
					"status_note":status_note,
					"updated_by_id":updated_by_id,
					"updated_by":updated_by,  
					"request_type":request_type,
					"req_client_phone":req_client_phone
					},
			success:function(response){
				
				//console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success == true){
				 toastr["success"]("Status Updated", "Success");
                } 
              else {
                        toastr["error"]("Error updating status", "Error");
                 }

                    $("#updateStatusModal").find('form').trigger('reset');
                    $("#updateStatusModal").modal('hide');
                   setTimeout(function(){
                        location.reload();
                    },1000); 
			}
			
		})
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
				//console.log(response);
				
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
						let attachment = result.data[i].attachment;
						
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
						html_.push("<a class='link-post' data-file_path="+ attachment +" href=''>View</a>");

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


				// $(result)
				// 	.each(
				// 			function() {
				// 				if(this.status == 2) {
				// 					this.status = 'Pending'
				// 				}
				// 				if(this.status == 1) {
				// 					this.status = 'On Hold'
				// 				}
				// 				if(this.status == 3) {
				// 					this.status = 'Resolved'
				// 				}
											
				// 				table_status_note
				// 						.append("<tr>"
				// 								+'<td>'
				// 								+ this.note
				// 								+ "</td>"
				// 								+'<td>'
				// 								+ this.status
				// 								+ "</td>"
				// 								+'<td>'
				// 								+ this.updated_by
				// 								+ "</td>"
				// 								+'<td>'
				// 								+ this.updated_at
				// 								+ "</td>"
				// 								+ '<td>' +
												// +'<a class="link-post" data-file_path="'+ this.document_name +'" href="'
												// + this.document_file
												// + '">'
												// + this.document_name
												// + '</a>'+
							// 					'</td>'
							// 					+ "</tr>");


							// });
					
					
				}
			
			}
		})


		$('#status_note')
		.on(
				'click',
				'.link-post',
				function(event) {
					// console.log(e)
					event.preventDefault();

					//var ticket_no=$('input[name="ticket_no"]').val();
					var file_path = $(event.currentTarget).data('file_path');
					
					var ticket_no = $('#req_ticket_no').val();
				//var file_path =response;
				//console.log(file_path);
				
				$.ajax({
							type : "POST",
							url : "cica_focal_person_serv",
							// target:'_blank',
							data : {
								request_type : 'open_requested_pdf',
								file_path : file_path,
								ticket_no: ticket_no
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
							
								$('#elisDocumentPreview').modal('show');
								$('#elisDocumentPreview')
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
										'#elisdovumentpreviewblobfilexx')
										.attr('src',
												objectUrl);

								$(
										'#elisdovumentpreviewblobfilexx')
										.attr('src',
												objectUrl);

								// $('#NotoncaseafterPaymentModalonCase').modal('hide');

							}
						});

				});
		
		
		
		$("#reply_to_ticket").on('submit',function(e){
			e.preventDefault();
			
			let description=$('#reply_desc').val();
			let ticket_id=$('#ticket_id').val();
			let ticket_no=$('#ticket_no').val();
			let replied_by=$('#replied_by').val();
			//let attach_file=$('#attach_file').val();
			let request_type=$('#request_type').val();
			let isChecked = $('#attach_file').is(':checked');
			let reply_from=$('input[name="view_by"]').val();
			//console.log(isChecked)
			let move_to=$('#move_to').find(":selected").text();

			//console.log(move_to)
			
			let formdata = new FormData();
			
			formdata.append("request_type",request_type);
			formdata.append("description",description);
			formdata.append("ticket_id",ticket_id);
			formdata.append("ticket_no",ticket_no);
			formdata.append("replied_by",replied_by);
			formdata.append("reply_from",reply_from);
			formdata.append("move_to",move_to);
			
			if(isChecked == true) {
				jQuery.each(jQuery('#file')[0].files,function(i,file){
					formdata.append('file',file);
				})
				
				formdata.append("attach_file","yes");
			} else {
				formdata.append("attach_file","");
			}
			
		//formdata.append("file",fileinput.files[0]);
		
		console.log(formdata)
		
		$.ajax({
			method:"POST",
			enctype : 'multipart/form-data',
			url : "cica_multipartfile_serv",
			data : formdata,
			processData : false,
			contentType : false,
			cache : false,
			success:function(response){
				//console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Replied successfully", "Success");
                } 
              else {
                        toastr["error"]("Error occurred uploading file", "Error");
                 }

                    $("#attachmentModal").find('form').trigger('reset');
                    $("#attachmentModal").modal('hide');
                   setTimeout(function(){
                        location.reload();
                    },1000); 
			}
			
		})
	})
	
	
	var table_replies = $('#replies_tbl');
		table_replies.find("tbody tr").remove();
		
		//let ticket_no=$('input[name="ticket_no"]').val();
		
		let dataSet = [];
    	var num = '';	
		
				
		$.ajax({
			url:"cica_tickets_serv",
			method:"POST",
			data:{
					"request_type":"load_ticket_replies",
					"ticket_no":ticket_no,
			},
			success:function(response){
				//console.log(response);
				
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

            			dataSet.push(html_);
					}
					
					//$('#replies_tbl').DataTable().clear().destroy();
					
					$('#replies_tbl').DataTable({
		                //pageLength: 10,
		                data: dataSet, 
		                searching: false, 
		                paging: false, 
		                info: false,
		                ordering: false
		            });
		            
		           document.getElementById("replies_tbl").style.width = "870px";
					}
					
					
				}
			
			}
		})
		
		
		$('#replies_tbl')
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
					
					//console.log(ticket_no);
					//console.log(attachment_path);
						
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
									//console.log(jobdetails);
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
		
		ticket_no=$('input[name="ticket_no"]').val();
		
		let dataSet__ = [];
    	var num = '';	
		
				
		$.ajax({
			url:"cica_tickets_serv",
			method:"POST",
			data:{
					"request_type":"load_sms_messages",
					"ticket_no":ticket_no,
			},
			success:function(response){
				//console.log(response);
				
				var result = JSON.parse(response);
                if(result.success == true){
					
					if(result.data){
						for(let i = 0; i<result.data.length; i++) {
						let html__ = [];
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
						
						html__.push(message);
						html__.push(client_contact);
						html__.push(sent_by);
						html__.push(sent_date);

            			dataSet__.push(html__);
					}
					
					//$('#sms_message').DataTable().clear().destroy();
					
					$('#sms_message').DataTable({
		                //pageLength: 10,
		                data: dataSet__,
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
		
		
		$('#status_id').on('change', function(e) {
			e.preventDefault()
			//console.log('egbrgt')
			let status_id = $('#status_id').find(":selected").val()

			if(status_id == 1) {
				$('#txt_note').val('Dear valued client, ');
			}
		})


		$("#frmUpdateTicket").on('submit',function(e){
	   
			e.preventDefault();
	
			let rt_ticket_no=$('#rt_ticket_no').val();
			let rt_purpose=$('#rt_purpose').val();
			let rt_subject=$('#rt_subject').val();
			let rt_description=$('#rt_description').val();
			let rt_related_service=$('#rt_related_service').val();
			let rt_reference_no=$('#rt_reference_no').val();
			
			console.log(rt_ticket_no)
			
			let request_type = "update_ticket_details";
			
			$.ajax({
				method:"POST",
				url : "cica_tickets_serv",
				data : {
					ticket_no:rt_ticket_no,
					purpose:rt_purpose,
					subject:rt_subject,
					description:rt_description,
					related_service:rt_related_service,
					reference_no:rt_reference_no,  
					request_type:request_type
				},
				success:function(response){
					
					console.log(response);
				 	let json_result = JSON.parse(response);
	
				 if(json_result.success == true){
					 toastr["success"]("Ticket Updated", "Success");
					} 
				  else {
							toastr["error"]("Error updating ticket", "Error");
					 }
	
						//$("#updateStatusModal").find('form').trigger('reset');
						$("#editModal").modal('hide');
					   setTimeout(function(){
							location.reload();
						},1000); 
				}
				
			})
		})
})