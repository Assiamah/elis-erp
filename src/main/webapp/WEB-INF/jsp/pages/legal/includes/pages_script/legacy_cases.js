$(function(){

	$('#search_legacy_btn').on('click', function(e) {

		e.preventDefault()
		
		let suit_number =  $('input[name="search_suit_number"]').val();
		//$("#search_btn").prop('disabled',true);
		
		
		$.ajax({
			type:"POST",
			url:"legacy_cases_serv",
			data:{"request_type":"search_suit",
				  "suit_number":suit_number,
			},
			success:function(response){
				console.log(response);
			let html="";
			let json_result = JSON.parse(response);
			
			console.log(json_result)
			
			if(json_result.success){
						// if(json_result.cases !== null){
							
							
								
						// }

						toastr["warning"]("Suit Already Existed", "LEGAL");
						$('#legacy_case_form').addClass('d-none');
			}
			else{
				
				$('#legacy_case_form').removeClass('d-none');

				$('#suit_number').val(suit_number);

			}	
			}
		
		})
		
		
		})


	localStorage.removeItem('parties');
	$.ajax({
			url:"secretariat_serv",
			method:"POST",
			data:{"request_type":"get_courts"},
			success:function(response){
				console.log(response);
				
				let json_result = JSON.parse(response);
				//console.log(json_result.data);
				
				localStorage.removeItem('courts');
        		localStorage.setItem('courts',JSON.stringify(json_result.data));
				
			}
		})
		
		let date_document=document.getElementById("date_document");
		date_document.addEventListener("change",function () {
 			 let min_date=date_document.value;
 			 const filling_date=document.getElementById("date_received");
 			 filling_date.value="";
 			 filling_date.setAttribute("min",min_date);
		})
		
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
			
			let court_id=$('#court').find(":selected").val();
			//console.log(court_id)
			$('input[name="court_city"]').val();

			let courts_list=JSON.parse(localStorage.getItem('courts')) || [];
			
			
			let html=""
				for(let i=0; i<courts_list.length; i++){
					
					if(courts_list[i].id ==court_id){
					$('input[name="court_city"]').val(courts_list[i].city);
					}
				}
		})
	
	
	//on click save case
	$("#save_legacy_entry").on('click', function(e){
   		 e.preventDefault();
   		 
   		 $('#save_case').prop('disabled',true).text('Saving ...');
   		 
		let parties=JSON.parse(localStorage.getItem('parties')) || [];
		if(parties.length === 0){
			alert("Enter Parties");
			 $('#save_case').prop('disabled',false).text('Save');
		}
		else{
		let suit_number =  $('input[name="search_suit_number"]').val();
		
		if(suit_number !==null){
			let nature_of_case =  $('#nature_of_case').find(":selected").val();
			let court = $('#court').find(":selected").val();
			let date_received =  $('input[name="date_received"]').val();
			let date_document =  $('input[name="date_document"]').val();
			let received_by =  $('input[name="received_by"]').val();
			let releifs = $("#releifs").val();
			let summary =$("#summary").val();

			let files = $("#file")[0].files.length;
			
			console.log(parties);
			parties=JSON.stringify(parties);
			let files_location =  $('input[name="files_location"]').val();
			$.ajax({
			type:"POST",
			url:"legacy_cases_serv",
			data:{"request_type":"add_case",
				  "suit_number":suit_number,
				  "nature_of_case":nature_of_case,
				  "court":court,
				  "date_received":date_received,
				  "date_document":date_document,
				  "parties":parties,
				  "releifs":releifs,
				  "summary":summary,
				  "received_by":received_by,
				  "files_location":files_location
			},
			success:function(response){
				console.log(response)
				
				let json_result = JSON.parse(response);
			
					//console.log(json_result)
					
					if(json_result.success){
						
					// 	document.getElementById("alert").innerHTML =`<div class="alert alert-success col-md-8 text-center" role="alert">
		            //     				Saved Successfully
		            //     			</div>`;
		            //    toastr["success"]("Saved successfully", "Cases");
			      
	                //   setInterval(function(){
	                //       // Get Cases 
					// get_cases(suit_number);
	                //  },1000); 
	                 
	                //  $("#add_case").trigger('reset');
	                //    $('input[name="suit_number"]').val(suit_number);

					if (files != 0) {
   
						let suit_number=$('input[name="suit_number"]').val();
						let case_number=$('input[name="case_number"]').val();
						let type_of_document="legacy_entry";
						
						let formdata = new FormData();
						formdata.append("request_type","cases_upload");
						formdata.append("suit_number",suit_number);
						formdata.append("type_of_document",type_of_document);
						formdata.append("scan_type","");
						formdata.append("case_id",case_number);
						jQuery.each(jQuery('#file')[0].files,function(i,file){
							formdata.append('file',file);
						})

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
								toastr["success"]("Saved successfully", "File");
					
								setTimeout(function(){
									location.reload()
								},1000);
					
								} 
							else {
										toastr["error"]("Error occurred uploading file", "File");
								}
					
									// $("#attachmentDoc").find('form').trigger('reset');
									// $("#attachmentDoc").modal('hide');
									// $("#upload_btn").prop('disabled', false);
									
									//  setTimeout(function(){
									// 	location.href();
									// },1000); 
								
							}
							
						})

					 } else {
						
						// file not selected
						toastr["success"]("Saved successfully", "File");
					
								setTimeout(function(){
									location.reload()
								},1000);
					 }
	                 
	               }
	               else{
						document.getElementById("alert").innerHTML =`<div class="alert alert-danger col-md-8 text-center" role="alert">
		                				Something went wrong ....
		                </div>`;
		                
		                setInterval(function(){
	                       location.reload();
	                 },1000); 
					}
				$('#save_case').prop('disabled',false).text('Save');
				}
			
			})
			
			
		}
		else{
			alert("Suit Number not entered");
		}
		
		}
	})
	
	// On click save parties
	$("#add_party").on("click",function(){
		
		$("#add_party").prop('disabled', true);
		
		let party_type =  $('#party_type').find(":selected").val();
		let party_name =  $('input[name="party_name"]').val();
		let party_address =  $("#party_address").val();
		let party_lawyer =  $('input[name="party_lawyer"]').val();
		let lawyer_tel =  $('input[name="lawyer_tel"]').val();
		let lawyer_address =  $("#lawyer_address").val();
		let lawyer_chamber =  $('input[name="lawyer_chamber"]').val();
		
		if(!party_type || !party_name) {
			$("#add_party").prop('disabled', false);
			toastr["error"]("Required fields cannot be empty", "Error");
		}
		else {
		
		const party = {"party_tel": "","lawyer_tel": lawyer_tel,
						"party_name":party_name,
						"party_type": party_type,
						"party_lawyer":party_lawyer,
						"party_address": party_address,
						"lawyer_address":lawyer_address,
						"lawyer_chamber": lawyer_chamber
						};

		if(parties_save(party)){
			
		      $("#addPartyModal").find('form').trigger('reset');
                    $("#addPartyModal").modal('hide');
                    $("#add_party").prop('disabled', false);
                    
                    toastr["success"]("Saved successfully", "Parties");
                 
              	let parties=JSON.parse(localStorage.getItem('parties')) || [];
              	display_parties(parties);
				
		}
		else{
			
		      $("#addPartyModal").find('form').trigger('reset');
                    $("#addPartyModal").modal('hide');
                    $("#add_party").prop('disabled', false);
                    
                      toastr["success"]("Saved successfully", "Parties");
                 
             let parties=JSON.parse(localStorage.getItem('parties')) || [];
             display_parties(parties);
		}
		}
	})
		
		
	// Add party to local storage	
	const parties_save=(party)=>{
		if(party !== null){
			
			let parties=JSON.parse(localStorage.getItem('parties')) || [];
			
			parties.push(party);
			localStorage.removeItem('parties');
        	localStorage.setItem('parties',JSON.stringify(parties));
			
			return true;	
		}
		else{
			return false;
		}
	}
	
	const display_parties=(parties)=>{
		console.log(parties);
		let html="";
		let num = 0;
		if(parties !== null){
		parties.forEach(function(parties){
			num = +num + 1;				
			html+=`<tr id="${num}">
					<td>${num}</td>
						<td>${parties.party_type}</td>
						<td>${parties.party_name}</td>
						<td>${parties.party_address}</td>
						<td>${parties.party_lawyer}</td>
						<td>${parties.lawyer_tel}</td>
						<td>${parties.lawyer_address}</td>
						<td>${parties.lawyer_chamber}</td>
						<td> <button type="button" class="btn-edit"
						data-party_type="${parties.party_type}" 
				        data-party_name="${parties.party_name}" 
				        data-party_address="${parties.party_address}" 
				        data-party_lawyer="${parties.party_lawyer}" 
				        data-lawyer_tel="${parties.lawyer_tel}"
				        data-lawyer_address="${parties.lawyer_address}"
				        data-lawyer_chamber="${parties.lawyer_chamber}"
						data-id_num="${num}">
							<span class="me-2 ms-2">Edit</span>
						</button>
						
						</td>
					</tr>`

		})
		
		document.getElementById('parties_tbl').innerHTML=html;
		
		}
	} 


	$("#parties_tbl").on("click", ".btn-edit", function(event){

		$('#editPartyModal').modal({
			backdrop : 'static',
		});

		var party_int = parseInt($("#nature_of_case").val());
		let option_parties = '<option disabled selected>-- select --</option>';
		
		if(party_int == 6) {
			option_parties = `<option disabled selected>-- select --</option>
				<option value="Plaintiff">Plaintiff</option>
				<option value="Defendant">Defendant</option>`
		} else if(party_int == 1) {
			option_parties = `<option disabled selected>-- select --</option>
				<option value="Applicant">Applicant</option>
				<option value="Respondent">Respondent</option>`
		} else if(party_int == 2) {
			option_parties = `<option disabled selected>-- select --</option>
				<option value="Applicant">Applicant</option>
				<option value="Respondent">Respondent</option>`
		}else if(party_int == 3) {
			option_parties = `<option disabled selected>-- select --</option>
				<option value="Applicant">Applicant</option>
				<option value="Respondent">Respondent</option>`
		}else if(party_int == 4) {
			option_parties = `<option disabled selected>-- select --</option>
				<option value="Applicant">Applicant</option>
				<option value="Respondent">Respondent</option>`
		} else {
			option_parties = `<option disabled selected>-- select --</option>
				<option value="Party 1">Party 1</option>
				<option value="Party 2">Party 2</option>`
		}
		
		document.getElementById('e_party_type').innerHTML = option_parties;

		$("#e_party_type").val($(event.currentTarget).data('party_type'));
		$("#e_party_name").val($(event.currentTarget).data('party_name'));
		$("#e_party_address").val($(event.currentTarget).data('party_address'));
		$("#e_party_lawyer").val($(event.currentTarget).data('party_lawyer'));
		$("#e_lawyer_tel").val($(event.currentTarget).data('lawyer_tel'));
		$("#e_lawyer_address").val($(event.currentTarget).data('lawyer_address'));
		$("#e_lawyer_chamber").val($(event.currentTarget).data('lawyer_chamber'));
		$("#row_num").val($(event.currentTarget).data('id_num'));

    });

	$('#btn-update-party').on('click', function(){ 

        var id = $('#row_num').val();

		localStorage.removeItem('parties');

		var col = document.getElementById(id).getElementsByTagName("td");

        $(col[0]).text($('#row_num').val());
        $(col[1]).text($('#e_party_type').val());
		$(col[2]).text($('#e_party_name').val());
        $(col[3]).text($('#e_party_address').val());
		$(col[4]).text($('#e_party_lawyer').val());
        $(col[5]).text($('#e_lawyer_tel').val());
		$(col[6]).text($('#e_lawyer_address').val());
        $(col[7]).text($('#e_lawyer_chamber').val());

		var _table = document.getElementById("parties_tbl_main");
		var _trLength = _table.getElementsByTagName("tr").length;
		var _jsonData = [];
		var _obj = {};
		
		var _htmlToJSON = function(index){
		    var _tr = _table.getElementsByTagName("tr")[index];
		    var _td = _tr.getElementsByTagName("td");
		    var _arr = [].map.call( _td, function( td ) {
		        return td.innerHTML;
		    }).join( ',' );
		    var _data = _arr.split(",");
		    
		    _obj = {
		         party_type : _data[1]
		        ,party_name : _data[2]
		        ,party_address : _data[3]
		        ,party_lawyer : _data[4]
		        ,lawyer_tel : _data[5]
		        ,lawyer_address : _data[6]
		        ,lawyer_chamber : _data[7]
		    };
		    
		    _jsonData.push(_obj);
		    
		};
		
		for(var j = 1; j < _trLength; j++){
		    _htmlToJSON(j);
		}

		//$('#'+id).remove();

		let json_data = JSON.stringify(_jsonData);

		json_data = json_data.replace("[","");
		json_data = json_data.replace("]","");

		console.log(json_data);

		// if(parties_save(json_data)){
				  
		// 	toastr["warning"]("Party updated", "LEGAL");
			
		// 	let parties=JSON.parse(localStorage.getItem('parties')) || [];
		// 	display_parties(parties);
			  
		// }
		// else{
		// 	toastr["danger"]("Updating party unsuccessful", "LEGAL");
				
		// 	let parties=JSON.parse(localStorage.getItem('parties')) || [];
		// 	display_parties(parties);
		// }

		// localStorage.removeItem('parties');
        // localStorage.setItem('parties',JSON.stringify(json_data));

		let parties = JSON.parse(localStorage.getItem('parties')) || [];
			
		parties.push(JSON.parse(json_data));
		console.log(JSON.parse(json_data));
		localStorage.setItem('parties',JSON.stringify(parties));
		parties = JSON.parse(localStorage.getItem('parties')) || [];

		display_parties(parties);
	
    });
	
	
	// const changeNatureofCase = (value) => {
	//   const $select = document.querySelector('#nature_of_case');
	//   $select.value = "2.0"
	// };
	
	// const get_cases=(suit_number) =>{
	// 	$.ajax({
	// 		type:"POST",
	// 		url:"legacy_cases",
	// 		data:{"request_type":"suit_all_cases",
	// 			  "suit_number":suit_number,
	// 		},
	// 		success:function(response){
	// 			console.log(response);
				
	// 			let json_result = JSON.parse(response);
			
	// 				//console.log(json_result)
	// 				let html="";
	// 				if(json_result.success){
						
	// 					if(json_result.cases !== null){
	// 						let cases=json_result.cases;
							
	// 						cases.forEach(function(cases){
							
	// 							html+=`<tr>
	// 								<td>${cases.id}</td>
	// 								<td>${cases.nature_of_case}</td>
	// 								<td>${cases.court_name}</td>
	// 								<td>${cases.region}</td>
	// 							</tr>`;
	// 					})
	// 				}

	// 			}
		
	// 				document.getElementById('cases_table').innerHTML=html;
						
					
	// 		}
	// 	})
	// }


	// $('#court_region').on('change',function(){
			
	// 	let court_region=$('#court_region').find(":selected").text();
		
	// 	//console.log(court_region);
		
	// 	let courts_list=JSON.parse(localStorage.getItem('courts_list')) || [];
		
	// 	//console.log(courts_list);
		
	// 	let html=""
	// 		for(let i=0; i<courts_list.length; i++){
				
	// 			if(courts_list[i].region ==court_region){
	// 			html+=`<option value="${courts_list[i].id}" >${courts_list[i].court_name} - (${courts_list[i].city}) </option>`
	// 			}
	// 		}
						
	// 		document.getElementById("court_id").innerHTML=html; 
		
		
	// })
	
	
	$('#court_id').on('change',function(){
		
		let court=$('#court_id').find(":selected").val();

		let courts_list=JSON.parse(localStorage.getItem('courts_list')) || [];

			for(let i=0; i<courts_list.length; i++){
				
				if(courts_list[i].id ==court){
					$('input[name="court_city"]').val(courts_list[i].city);
					$('input[name="court_region"]').val(courts_list[i].region);
					$('input[name="court_description"]').val(courts_list[i].description);
					
				}
			}

	})

	// Attachment  Show Modal
	
	$('#attachmentModal').on('shown.bs.modal', function (e) {
			
			let suit_number=$('input[name="page_suit_number"]').val();
	
			 $('input[name="suit_number"]').val(suit_number);
		})
			
$("#cases_upload").on('submit',function(e){
	e.preventDefault();
	
	$("#upload_btn").prop('disabled', true);
	
	let suit_number=$('input[name="suit_number"]').val();
	let case_number=$('input[name="case_number"]').val();
	let type_of_document="further_entry";
	
	let formdata = new FormData();
	formdata.append("request_type","cases_upload");
	formdata.append("suit_number",suit_number);
	formdata.append("type_of_document",type_of_document);
	formdata.append("scan_type","full");
	formdata.append("case_id",case_number);
	jQuery.each(jQuery('#file')[0].files,function(i,file){
		formdata.append('file',file);
	})
	//formdata.append("file",fileinput.files[0]);
	
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

			 setTimeout(function(){
				location.reload()
			},1000);

			} 
		  else {
					toastr["error"]("Error occurred uploading file", "File");
			 }

				$("#attachmentDoc").find('form').trigger('reset');
				$("#attachmentDoc").modal('hide');
				$("#upload_btn").prop('disabled', false);
				
				 setTimeout(function(){
					location.href();
				},1000); 
			  
		}
		
	})
})
	
	
})