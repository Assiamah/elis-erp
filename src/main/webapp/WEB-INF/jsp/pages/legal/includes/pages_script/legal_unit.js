$(function(){
		
	 $('#legal_unit_div').hide();
		$('#secratariat_unit_div').hide();
		
		 $('#table_list').DataTable();
		  $("#btnViewBatchlist").prop('disabled',true);
		 

		 $('#unit').on('click', function() {
			 
			 $('#legal_unit_div').show();
		$('#secratariat_unit_div').hide();
			
			let dataSet =[];
			let num ="";
			
			$.ajax({
				url:"legal_unit_serv",
				method:"POST",
				data:{"request_type":"load_data"},
				success:function(response){
					
					console.log(response);
				let json_result = JSON.parse(response);
				console.log(json_result);
				
				 if(json_result.success){
						if(json_result.cases !== null){
							
							for(let i=0; i<json_result.cases.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let id=`<div class="form-check"> <input class="form-check-input suits" type="checkbox" id="gridCheck" data_id="${json_result.cases[i].id}" ></div>`
			                let suit_number= json_result.cases[i].suit_number;
			                let nature_of_case= json_result.cases[i].nature_of_case;
			                let court_process= json_result.cases[i].court_process;
			                //let plaintiffs=(json_result.cases[i].plaintiffs !==null)? json_result.cases[i].plaintiffs[0].plaintiffs_name:"";
			               // let defendants=(json_result.cases[i].defendants !==null)? json_result.cases[i].defendants[0].defendants_name:"";
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
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
							let actions="";
							if(entry_complete == true && attachment == true) {
								actions=`<div class="dropdown no-arrow">
								<a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fas fa-ellipsis-v ms-2"></i>
								</a>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<form class="d-none" action="further_entry_post" method="post">
										<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
										<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
										<input type="hidden"  name="request_type" value="load_case">
										<button type="submit" class="dropdown-item" href="#">Further Entry</button>
									</form>
									<a class="dropdown-item summary" href="#" id="${json_result.cases[i].id}">Case Summary</a>
								</div>
								</div>`; 
							} else {
								actions=`<div class="dropdown no-arrow">
			              	  <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						               	<i class="fas fa-ellipsis-v ms-2"></i>
			              	  </a>
			              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			              	  	<form  action="further_entry_post" method="post">
			              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
									<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
									<input type="hidden"  name="request_type" value="load_case">
			              	    	<button type="submit" class="dropdown-item" href="#">Further Entry</button>
			              	    </form>
			              	    <a class="dropdown-item summary" href="#" id="${json_result.cases[i].id}">Case Summary</a>
			              	  </div>
			              	</div>`; 
							}
			              	
			                let court_name=json_result.cases[i].court_name;  
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
							
							/*$('#table_list').DataTable({                       
	                   
			                    "createdRow": function( row, data, dataIndex){
				                if( data[11]){
				                    $(row).addClass('greenClass');
				                  }
				               },
		              	} );*/
		              	
						}
					
					}
				})
				
			 document.getElementById("card_title").innerHTML="Unit";
			 $("#btnViewBatchlist").prop('disabled',true);
			 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-1, #body-bg-3").removeClass('bg-active');
				
		})
			
			// Show Incoming Cases
	 $('#incoming').on('click', function() {
		
		$('#legal_unit_div').hide();
		$('#secratariat_unit_div').show();
	   
	   //load incoming cases
		 $.ajax({
			url:"legal_unit_serv",
			method:"POST",
			data:{"request_type":"load_incoming_cases"},
			success:function(response){
				
				console.log(response);
				let json_result = JSON.parse(response);
				 //console.log(json_result);
				 let incomingSet=[];
				 if(json_result.success && json_result.data !== null){
						for(let i=0; i<json_result.data.length; i++){
							
							let html=[];
			                let id=`<div class="form-check"> <input class="form-check-input incoming_checks" type="checkbox" id="gridCheck" value="${json_result.data[i].id}" data-suit="${json_result.data[i].suit_number}" data-court_process="${json_result.data[i].court_process}"  data-nature="${json_result.data[i].nature_of_case}"></div>`
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
			               		       
			                incomingSet.push(html);

							}
				
					}
					
						$('#table_list').DataTable().clear().destroy();
							
							//$('#table_list').DataTable().rows.add(incomingSet).draw();
							$('#table_list').DataTable({
								data: incomingSet,
			                    "createdRow": function( row, data, dataIndex){
								if(data[12]){
				                    $(row).addClass('yellowClass');
				                  }
				                else if(data[11]){
				                    $(row).addClass('greenClass');
				                  }
				                  
				               },
							}).draw();
				
				}
			})
			
			document.getElementById("card_title").innerHTML="Incoming";
			 $("#btnViewBatchlist").prop('disabled',false);
			 
			  $("#body-bg-1").addClass('bg-active');
			 $("#body-bg-2, #body-bg-3").removeClass('bg-active');
	        
	 })
	 
	 
	 // Receive Cases 
	 $("#btnViewBatchlist").on('click',function(e){
		e.preventDefault();
		let checkedList=[];
		let checkBoxes = document.getElementsByClassName('incoming_checks');
		
		for(let i=0; i<checkBoxes.length;i++){
			if(checkBoxes[i].checked){
				const checkedValue ={"suit_id": checkBoxes[i].value,
									 "suit_number":checkBoxes[i].getAttribute('data-suit'),
									 "court_process":checkBoxes[i].getAttribute('data-court_process'),
									 "nature":checkBoxes[i].getAttribute('data-nature')};
				checkedList.push(checkedValue);
			}
		}
		
		let dataSelected=[];
		
		console.log(checkedList);
		
		if(checkedList.length === 0){
			toastr["error"]("No file selected", "Incoming Files");
		}
		else{
			
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			localStorage.removeItem("checkedList");
			localStorage.setItem('checkedList', JSON.stringify(checkedList));
			
			$('#showBatchlist').modal('show');
			
			
		/*	$.ajax({
				url:"legal_unit",
				type:"POST",
				data:{
					request_type:"receive_cases",
					list:list
				},
				success:function(response){
					console.log(response);
				
					showbatchlist(response);
					
				}
			})  */
			
		}
		
		
	})
	
	
	$("#showBatchlist").on('shown.bs.modal', function() {
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		
		let txt = '<table id="batchTable" class="table " ><thead  ><th>Suit Number</th><th>Court Process</th><th>Nature of Case</th><th>Action</th></thead><tbody>';
		if(checkedList != null){
			for (let i = 0; i < checkedList.length; i++) {
                txt += '<tr><td>' + checkedList[i].suit_number + '</td>';
                txt += '<td>' + checkedList[i].court_process + '</td>';
                txt += '<td>' + checkedList[i].nature + '</td>';
                txt +=`<td><button class="btn btn-danger uncheck" onclick="deleteRow(this)" id="${checkedList[i].suit_id}" data-suit_number="${checkedList[i].suit_number}"><i class="fas fa-trash"></i>Remove</button></td></tr>`
            }
            txt += '</tbody></table';
        } else {
            txt = "<tr>No Data</tr>";
        }

        document.getElementById("batch_list").innerHTML = txt;
         $('#batchTable').DataTable();
		
		
		})
		

	// Print batchlist
	$('#btn_print').on('click',function(){
		
		let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
		if(checkedList != null){
			
			const json_list ={"list":checkedList};
			
			let list = JSON.stringify(json_list);
			console.log(list);
			
			$('#showBatchlist').modal('hide');
			
			
			$.ajax({
				url:"head_legal_serv",
				type:"POST",
				data:{
					request_type:"receive_cases",
					list:list
				},
				success:function(response){
					console.log(response);
				
					showbatchlist(response);
					
				}
			})  
		}
		else{
			
			toastr["error"]("No file selected", "Incoming Files");
		}
		
	})
	
	
	// Show case details
	 $('#table_list').on('click', '.summary', function() {
		
		 let id = $(this).prop('id');
		 

        $('#summaryModal').modal('show'); 
        
        $.ajax({
				url:"case_summary",
				type:"POST",
				data:{"case_id":id,
					  "request_type":"case_summary"},
				success:function(response){
					console.log(response);
					
				let json_result = JSON.parse(response);
			
			
			
			 if(json_result.success){
					if(json_result.case !== null){
						
						 document.getElementById("summary").innerHTML=json_result.case[0].summary;
						 document.getElementById("reliefs").innerHTML=json_result.case[0].releifs;
						 $('input[name="suit_number"]').val(json_result.case[0].suit_number);
						
						}
				}
			
			
			}
		
		})  
		
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
	 
	 
})