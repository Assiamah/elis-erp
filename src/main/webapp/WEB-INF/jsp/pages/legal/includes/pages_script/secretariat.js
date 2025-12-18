$(function(){
		
		 let dataSet =[];

		// Get writs at secretariat
		$.ajax({
			url:"secretariat_serv",
			method:"POST",
			data:{"request_type":"secretariat_writs"},
			success:function(response){
			
				//console.log(response);
				
			let json_result = JSON.parse(response);
			//console.log(json_result);
			if(json_result.success){
				if(json_result.data !==null){
				for(let i=0; i<json_result.data.length; i++){
	                let html=[];
	                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.data[i].id}" data-id="${json_result.data[i].id}" data-suit="${json_result.data[i].suit_number}" data-court_process="${json_result.data[i].court_process}" data-nature="${json_result.data[i].nature_of_case}"></div>`
	                let suit_number= json_result.data[i].suit_number;
	                let nature_of_case= json_result.data[i].nature_of_case;
	                let court_process= json_result.data[i].court_process;
	               	let date_of_document=convertDate(json_result.data[i].date_of_document.slice(0,10));
	               	let date_received=convertDate(json_result.data[i].date_received.slice(0,10));
	               	let received_at=json_result.data[i].secretariat;
	               	let incoming = json_result.data[i].incoming;
	               	let status_of_case=json_result.data[i].status_of_case;
	               	//console.log(incoming)
	              	let actions=`
	              	    <td class="d-flex justify-content-center"><button class="btn btn-outline-secondary btn-fw attach text-center" id="${json_result.data[i].id}" data_id='${json_result.data[i].suit_number}' data_type='${json_result.data[i].nature_of_case}' data_court_process='${json_result.data[i].court_process}' href="#"><i class="fas fa-upload ms-2"></i></button></td>
	              	  `;
	                       
       				/*<a class="dropdown-item edit" id="${json_result.data[i].id}" data_id='${json_result.data[i].suit_number}' href="#">Edit</a> */
	                let attached=json_result.data[i].attached;
	                let court_name=json_result.data[i].court_name;
	                let region=json_result.data[i].region;
	                let plaintiffs="";
	                let defendants="";
	                if(json_result.data[i].parties !== null){
						
						const plaintiffs_arr=get_plaintiffs(json_result.data[i].parties);
						const defendants_arr=get_defendants(json_result.data[i].parties);
						
						plaintiffs=plaintiffs_arr;
						defendants=defendants_arr;
						console.log(defendants_arr);
					}
					
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
	               
	               html.push(id);
	               html.push(suit_number);
	               html.push(nature_of_case);
	               html.push(court_process);
	               html.push(court_name);
	               html.push(region);    
	               html.push(plaintiffs); 
	               html.push(defendants); 
	               html.push(date_of_document); 
	               html.push(date_received); 
	               html.push(display_reminder);
	               html.push(actions); 
	               html.push(attached);
	               html.push(incoming);

	                dataSet.push(html);
            		}
				 }
	                	$('#table_list').DataTable({
	                    data: dataSet,
	                    dom: 'Bfrtip',
	                    columns: [
	                        { title: "#",visible: true,
					                searchable: false, },
	                        { title: "Suit Number" },
	                        { title: "Nature of Case" },
	                        { title: "Court Process" },
	                        {title:"Court"},
	                        {title: "Court Region"},
	                        { title: "Plaintiff(s)" },
	                        { title: "Defendant(s)"},
	                        { title: "Date of Filing"},
	                        { title: "Received Date"},
	                        { title: "Reminder"},
	                        { title: "Actions"},
	                        {title:"attached",visible: false,
					                searchable: false,}       
	                    ],
	                    buttons:[
	                        
	                    ],
	                    "createdRow": function( row, data, dataIndex){
						if(data[13]){
		                    $(row).addClass('yellowClass');
		                  }
		                else if( data[12]){
		                    $(row).addClass('greenClass');
		                  }
		                  
		               },
		              
	                } );
			}
			
			}
		})
		
		// Attachment  Show Modal
				
			 $('#table_list').on('click', '.attach', function() {
		        let id = $(this).prop('id');
		        let suit_number=$(this).attr('data_id');
		        let type_of_document=$(this).attr('data_type');
		        let court_process=$(this).attr('data_court_process');
		        
		        const attachModal=$('#attachmentModal');
		        attachModal.modal('show');
		        $('input[name="suit_number"]').val(suit_number);
		       	$('input[name="type_of_document"]').val(type_of_document);
		        $('input[name="case_id"]').val(id);
		        $('input[name="court_process"]').val(court_process);

		    })
		
		// Edit Show Modal
				
			 $('#table_list').on('click', '.attach', function() {
		        let id = $(this).prop('id');
		        let suit_number=$(this).attr('data_id');
		        
		        const attachModal=$('#attachmentModal');
		        attachModal.modal('show');
		        $('input[name="suit_number"]').val(suit_number);
		       
		
		    })
		
		// Get courts on modals show
		$('#addModal').on('shown.bs.modal',function(){
			
				// Get writs at secretariat
		$.ajax({
			url:"secretariat_serv",
			method:"POST",
			data:{"request_type":"get_courts"},
			success:function(response){
				//console.log(resposne);
				
					let json_result = JSON.parse(response);
					console.log(json_result);
					if(json_result.success){
						if(json_result.data !==null){
							
							const courts= json_result.data;
							
							localStorage.removeItem('courts_list');
        					localStorage.setItem('courts_list',JSON.stringify(courts));
        					
        					let html="<option disabled selected>-- select --</option>"
        					for(let i=0; i<json_result.data.length; i++){
								
								html+=`<option value="${json_result.data[i].id}" >${json_result.data[i].court_name} - (${json_result.data[i].city}) </option>`
							}
        					
        					document.getElementById("court").innerHTML=html;
						}
					}	
			}
			

			})
			
		})


		// On change region change court list
		
		$('#court_region').on('change',function(){
			
			let court_region=$('#court_region').find(":selected").text();
				$('input[name="court_city"]').val("");

			let courts_list=JSON.parse(localStorage.getItem('courts')) || [];
			
			
			let html='<option  disabled selected>-- select --</option>'
				for(let i=0; i<courts_list.length; i++){
					
					if(courts_list[i].region ==court_region){
					html+=`<option value="${courts_list[i].id}" >${courts_list[i].court_name} - (${courts_list[i].city}) </option>`
					}
				}
        					
				document.getElementById("court").innerHTML=html; 
			
			
		})
		
		
		$('#court').on('change',function(){
			
			let court=$('#court').find(":selected").val();

			let courts_list=JSON.parse(localStorage.getItem('courts_list')) || [];

				for(let i=0; i<courts_list.length; i++){
					
					if(courts_list[i].id ==court){
						$('input[name="court_city"]').val(courts_list[i].city);
					}
				}

		})
		
		$("#cases_upload").on('submit',function(e){
		e.preventDefault();
		
		$("#upload_btn").prop('disabled', true);
		
		let suit_number=$('input[name="suit_number"]').val();
		let type_of_document=$('input[name="type_of_document"]').val();
		let case_id=$('input[name="case_id"]').val();
		
		let formdata = new FormData();
		formdata.append("request_type","cases_upload");
		formdata.append("suit_number",suit_number);
		formdata.append("case_id",case_id);
		formdata.append("type_of_document",type_of_document);
		formdata.append("scan_type","partial");
		jQuery.each(jQuery('#file')[0].files,function(i,file){
			formdata.append('file',file);
		})
		//formdata.append("file",fileinput.files[0]);

		//console.log(suit_number);
		
		$.ajax({
			method:"POST",
			enctype : 'multipart/form-data',
			url : "cases_upload_serv",
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
                    $("#upload_btn").prop('disabled', false);
                    
                     setTimeout(function(){
                        location.reload();
                    },1000); 
                  
			}
			
		})
	})
	
		 // Receive Cases 
	 $("#btnViewBatchlist").on('click',function(e){
		e.preventDefault();
		let checkedList=[];
		let checkBoxes = document.getElementsByClassName('suits');
		
		for(let i=0; i<checkBoxes.length;i++){
			if(checkBoxes[i].checked){
				const checkedValue ={
									"suit_id": checkBoxes[i].getAttribute('data-id'),
									 "suit_number":checkBoxes[i].getAttribute('data-suit'),
									 "court_process":checkBoxes[i].getAttribute('data-court_process'),
									 "nature":checkBoxes[i].getAttribute('data-nature')};
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
		
		let txt = '<table id="batchTable" class="table" ><thead  ><th>Suit Number</th><th>Court Process</th><th>Nature of Case</th><th>Action</th></thead><tbody>';
		if(checkedList != null){
			for (let i = 0; i < checkedList.length; i++) {
                txt += '<tr><td>' + checkedList[i].suit_number + '</td>';
                txt += '<td>' + checkedList[i].court_process + '</td>';
                txt += '<td>' + checkedList[i].nature + '</td>';
                txt +=`<td><button class="btn btn-danger remove" onclick="deleteRow(this)" id="${checkedList[i].suit_id}" data_id="${checkedList[i].suit_id}"><i class="fas fa-trash"></i>Remove</button></td></tr>`
            }
            txt += '</tbody></table';
        } else {
            txt = "<tr>No Data</tr>";
        }

        document.getElementById("batch_list").innerHTML = txt;
		})
		
		
		
	// Remove from batchlist
	 $('.remove').on('click', function(e) {
		 //e.prevent
		alert("hello");
	
		        let id = $(this).prop('id');
		        let suit_number=$(this).attr('data_id');
		        
		        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		       
		       for(let i=0;i<checkedList.length;i++){
					if(checkedList[i].suit_number = suit_number){
						checkedList.splice(i, 1);
					}
				}
			  
			localStorage.removeItem("checkedList");
			localStorage.setItem('checkedList', JSON.stringify(checkedList));
			
			checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		
			let txt = '<table id="batchTable" class="table " ><thead ><th>Suit Number</th><th>Court Process</th><th>Nature of Case</th><th>Action</th></thead><tbody>';
			if(checkedList != null){
				for (let i = 0; i < checkedList.length; i++) {
	                txt += '<tr><td>' + checkedList[i].suit_number + '</td>';
	                txt += '<td>' + checkedList[i].court_process + '</td>';
	                txt += '<td>' + checkedList[i].nature + '</td>';
	                txt +='<td><button class="btn btn-danger remove" data_id="'+checkedList[i].suit_id+'"><i class="fas fa-trash"></i>Remove</button></td></tr>'
	            }
	            txt += '</tbody></table';
	        } else {
	            txt = "<tr>No Data</tr>";
	        }
	
	        document.getElementById("batch_list").innerHTML = txt;
		
		
		
	 })


	$('#btn_print').on('click',function(){
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		if(checkedList != null){
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			$('#showBatchlist').modal('hide');
			
			
			$.ajax({
				url:"secretariat_serv",
				type:"POST",
				data:{
					request_type:"forward_cases",
					list:list
				},
				success:function(response){
					console.log(response);
				
					//showbatchlist(response);

					toastr["success"]("Files sent to Legal Unit successfully", "LEGAL");

					setTimeout(function(){
                        location.reload();
                    },1000); 
					
				}
			})  
		}
		else{
			
			toastr["error"]("No file selected", "Incoming Files");
		}
		
	})
	
	function showbatchlist(response){
		
				
				var file_path =response;
				console.log(file_path);
				
				$.ajax({
							type : "POST",
							url : "legal_unit_serv",
							// target:'_blank',
							data : {
								request_type : 'open_pdf',
								file_path : file_path
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


					}
	$('#elisDocumentPreview').on('hidden.bs.modal',function(){
		setTimeout(function(){
                        location.reload();
                    },1000); 
	})
	
	
	
	
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
		
		
		
});
	
