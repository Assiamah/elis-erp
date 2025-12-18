document.addEventListener('DOMContentLoaded', function() { 
	
	//load_documents();
	
	$("#request_for_info").on('submit',function(e){
		e.preventDefault();
		
		let suit_number=$('#suit_number').val();
		let nature_of_case_desc=$('#nature_of_case_desc').val();
		let court_name=$('#court_name').val();
		let division=$('#division').val();
		let region=$('#region').val();
		let unit=$('#unit').val();
		let subject=$('#subject').val();
		let description=$('#description').val();
		let deadline=$('#deadline').val();
		let attach_file=$('#attach_file').val();
		let request_type=$('#request_type').val();
		let request_by=$('#request_by').val();
		let case_id=$('#case_id').val();
		let nature_of_case=$('#nature_of_case').val();
		//console.log(type_of_document)
		
		let formdata = new FormData();
		
		formdata.append("request_type",request_type);
		formdata.append("suit_number",suit_number);
		formdata.append("case_id",case_id);
		formdata.append("nature_of_case_desc",nature_of_case_desc);
		formdata.append("court_name",court_name);
		formdata.append("division",division);
		formdata.append("region",region);
		formdata.append("unit",unit);
		formdata.append("subject",subject);
		formdata.append("description",description);
		formdata.append("deadline",deadline);
		formdata.append("attach_file",attach_file);
		formdata.append("request_by",request_by);
		formdata.append("nature_of_case",nature_of_case);
		jQuery.each(jQuery('#file')[0].files,function(i,file){
			formdata.append('file',file);
		})
		//formdata.append("file",fileinput.files[0]);
		
		console.log(formdata)
		
		$.ajax({
			method:"POST",
			enctype : 'multipart/form-data',
			url : "record_info",
			data : formdata,
			processData : false,
			contentType : false,
			cache : false,
			success:function(response){
				console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Uploaded successfully", "File");
                } 
              else {
                        toastr["error"]("Error occurred uploading file", "File");
                 }

                    $("#attachmentModal").find('form').trigger('reset');
                    $("#attachmentModal").modal('hide');
                   setTimeout(function(){
                        location.reload();
                    },1000); 
			}
			
		})
	})
	
	
	$("#requested_note").on('submit',function(e){
		e.preventDefault();
		
		let suit_number=$('#suit_number').val();
		let case_id=$('#case_id').val();
		let note_provided=$('#note_provided').val();
		//let attach_file=$('#attach_file_').val();
		let request_type=$('#request_type').val();
		//console.log(attach_file)
		let isChecked = $('#attach_file_').is(':checked');
		
		let formdata = new FormData();
		
		formdata.append("request_type",request_type);
		formdata.append("suit_number",suit_number);
		formdata.append("case_id",case_id);
		formdata.append("notes",note_provided);
		//formdata.append("attach_file",attach_file);
		// jQuery.each(jQuery('#file_')[0].files,function(i,file){
		// 	formdata.append('file',file);
		// })

		if(isChecked == true) {
			jQuery.each(jQuery('#file_')[0].files,function(i,file){
				formdata.append('file',file);
			})
			
			formdata.append("attach_file","yes");
		} else {
			formdata.append("attach_file","");
		}
		 
		$.ajax({
			method:"POST",
			enctype : 'multipart/form-data',
			url : "record_info_serv",
			data : formdata,
			processData : false,
			contentType : false,
			cache : false,
			success:function(response){
				console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Uploaded successfully", "File");
                } 
              else {
                        toastr["error"]("Error occurred uploading file", "File");
                 }

                    $("#requested_note").find('form').trigger('reset');
                    //$("#attachmentModal").modal('hide');
                   setTimeout(function(){
                        location.reload();
                    },1000); 
			}
			
		})
	})
	
	
	var table_req_docs = $('#provided_docs');
		table_req_docs.find("tbody tr").remove();

		let suit_number=$('#suit_number').val();
		let case_id=$('#case_id').val();
		
		let dataSet = [];
    	var num = '';
		
		$.ajax({
			url:"record_info_serv",
			method:"POST",
			data:{
					"request_type":"load_provided_record_info",
					"suit_number":suit_number,
					"case_id":case_id,
			},
			success:function(response){
				console.log(response);
				
				var result = JSON.parse(response);
                if(result.data != null){
					
					
					for(let i = 0; i<result.data.length; i++) {
						let html = [];
						num = (+num + 1);
						let suit_number = result.data[i].suit_number;
						let notes = result.data[i].notes;
						let file_location = result.data[i].file_location;
						let file_name = result.data[i].file_name;
						file_name = file_name == null ? '' : file_name
						let provided_by = result.data[i].provided_by;
						let date_provided = result.data[i].date_provided.split('T')[0];
						let attach_file = result.data[i].attach_file;
						let action = `<div>
							<button class="btn btn-primary btn-sm" data-notes="${notes}" data-suit_number="${suit_number}" data-toggle="modal" data-target="#view_notes">View More</button>
						</div>`
						
						var notesArr = notes.split(" ");
						var noteShort = notesArr.splice(0, 4).join(" ");
						
						html.push(noteShort+"...");
						html.push(' <a class="link-post" data-file_path="'+ file_location +'" href="'
													+ file_location
													+ '">'
													+ file_name
													+ '</a>');
		                html.push(date_provided);
		                html.push(action);

            			dataSet.push(html);
					}
					
					$('#provided_docs').DataTable({
		                //pageLength: 10,
		                data: dataSet,
		                searching: false, 
		                paging: false, 
		                info: false,
		                ordering: false
		            });
		            
		            document.getElementById("provided_docs").style.width = "800px";
					
				}
			
			}
		})
		
		$('#view_notes').on('show.bs.modal',function(event) {
			//$("#view_notes #ll_reference_no").val($(event.relatedTarget).data('suit_number'));	
			document.getElementById("n_suit_number").innerHTML = $(event.relatedTarget).data('suit_number');	
			document.getElementById("n_notes").innerHTML = $(event.relatedTarget).data('notes');
		});
		
		
		$('#provided_docs')
		.on(
				'click',
				'.link-post',
				function(event) {
					// console.log(e)
					event.preventDefault();

					var suit_number=$('input[name="suit_number"]').val();
					var file_path = $(event.currentTarget).data('file_path');
					
					console.log(file_path);
					console.log(suit_number);
						
					//var file_to_open = event.target.href;
					// C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
					//console.log(file_to_open)
					// var str = "Visit Microsoft!";
					//var file_path = file_to_open.replace("http://localhost:8080/U", "file:///u");
					
					$.ajax({
								type : "POST",
								//url : "open_pdffile",
								url: "legal_unit_serv",
								// target:'_blank',
								data : {
									//request_type : 'request_to_generate_batch_list',
									request_type: 'open_provided_doc',
									suit_number : suit_number,
									file_path: file_path
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
	
})