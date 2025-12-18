$(function(){

	localStorage.removeItem('parties');
	$.ajax({
			url:"secretariat_serv",
			method:"POST",
			data:{"request_type":"get_courts"},
			success:function(response){
				//console.log(response);
				
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
				
				console.log(court_region)

			let courts_list=JSON.parse(localStorage.getItem('courts')) || [];
			
			
			let html='<option  disabled selected>-- select --</option>'
				for(let i=0; i<courts_list.length; i++){
					
					if(courts_list[i].region ==court_region){
					html+=`<option value="${courts_list[i].id}" >${courts_list[i].court_name} </option>`
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
	
	 $('#search_btn').on('click', function() {
		
		let suit_number =  $('input[name="search_suit_number"]').val();
		$("#search_btn").prop('disabled',true);
		
		let region_id = 0;
		
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
						if(json_result.cases !== null){
							
							//$('#nature_of_case').val(json_result.cases[0].nature_of_case)
							//document.getElementById("court_region").innerHTML = json_result.cases[0].region == null ? `<option value="">-- select --</option>` :  `<option value="${json_result.cases[0].region}">${json_result.cases[0].region}</option>`
							//document.getElementById("court").innerHTML = json_result.cases[0].court_id == null ? `<option value="">-- select --</option>` : `<option value="${json_result.cases[0].court_id}">${json_result.cases[0].court_name}</option>`
							//document.getElementById("nature_of_case").innerHTML = json_result.cases[0].nature_of_case == null ? `<option value="">-- select --</option>` : `<option value="${json_result.cases[0].nature_of_case}">${json_result.court_id[0].nature_of_case}</option>`
							//$('#court_region').val(json_result.cases[0].region)
							//$('#court').val(json_result.cases[0].court_name)

							if(json_result.cases[0].region == null) {
								$('#court_region').val("-- select --")
							} else {
								switch (json_result.cases[0].region) {
									case "Greater Accra":
										region_id = 11;
										break;
									
									case "Western":
										region_id = 10;
										break;

									case "Volta":
										region_id = 9;
										break;

									case "Eastern":
										region_id = 4;
										break;

									case "Ashanti":
										region_id = 1;
										break;

									case "Central":
										region_id = 3;
										break;

									case "Northern":
										region_id = 6;
										break;

									case "Upper East":
										region_id = 7;
										break;

									case "Upper West":
										region_id = 8;
										break;

									case "Tema":
										region_id = 11;
										break;

									case "Oti":
										region_id = 21;
										break;

									case "Bono East":
										region_id = 23;
										break;

									case "Ahafo":
										region_id = 24;
										break;

									case "Bono":
										region_id = 2;
										break;

									case "North East":
										region_id = 5;
										break;

									case "Savannah":
										region_id = 26;
										break;

									case "Western North":
										region_id = 21;
										break;
								}
								document.getElementById("court_region").innerHTML = `<option value="${region_id}">${json_result.cases[0].region}</option>`
							}
							
							if(json_result.cases[0].court_id == null) {
								$('#court').val("-- select --")
							} else {
								document.getElementById("court").innerHTML = `<option value="${json_result.cases[0].court_id}">${json_result.cases[0].court_name}</option>`
							}
							
							if(json_result.cases[0].nature_of_case == null) {
								$('#nature_of_case').val("-- select --")
							} else {
								document.getElementById("nature_of_case").innerHTML = `<option value="${json_result.cases[0].nature}">${json_result.cases[0].nature_of_case}</option>`
							}
							
							
							$('#court_city').val(json_result.cases[0].city)
							$('#reliefs').val(json_result.cases[0].releifs)
							$('#summary').val(json_result.cases[0].summary)
							
							
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
							
							document.getElementById('party_type').innerHTML = option_parties;
                            
						
						let parties=json_result.cases[0].parties;
						//console.log(parties)
						if(parties !== null){
						
							localStorage.removeItem('parties');
        					localStorage.setItem('parties',JSON.stringify(json_result.cases[0].parties));
						display_parties(parties);
						
						 }
						 
						 
						 $('input[name="suit_number"]').val(json_result.cases[0].suit_number);
						 	toastr["success"]("Suit Found", "LEGAL");
								
						}
			}
			else{
				$('#nature_of_case').val("-- select --")
				$('#court_region').val("-- select --")
				$('#court').val("-- select --")
				$('#court_city').val("")
				$("input[type=date]").val("");
				
				toastr["warning"]("Suit Not Found", "LEGAL");
	            $('input[name="suit_number"]').val(suit_number);
			}	
		
			$("#search_btn").prop('disabled',false);
				}
		
		})
		
		
		})
	//on click save case
	
	$("table").on("click", "button.btn-edit", function(event){

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
    
    // $("#parties_tbl").on("click", ".btn-cancel", function(event){

    //     var party_type = $(event.currentTarget).data('party_type');
    //     var party_name = $(event.currentTarget).data('party_name');
    //     var party_address = $(event.currentTarget).data('party_address');
    //     var party_lawyer = $(event.currentTarget).data('party_lawyer');
    //     var lawyer_tel = $(event.currentTarget).data('lawyer_tel');
    //     var lawyer_address = $(event.currentTarget).data('lawyer_address');
    //     var lawyer_chamber = $(event.currentTarget).data('lawyer_chamber');

    //     $(this).parents("tr").find("td:eq(0)").text(party_type);
    //     $(this).parents("tr").find("td:eq(1)").text(party_name);
    //     $(this).parents("tr").find("td:eq(2)").text(party_address);
    //     $(this).parents("tr").find("td:eq(3)").text(party_lawyer);
    //     $(this).parents("tr").find("td:eq(4)").text(lawyer_tel);
    //     $(this).parents("tr").find("td:eq(5)").text(lawyer_address);
    //     $(this).parents("tr").find("td:eq(6)").text(lawyer_chamber);

    //     $(this).parents("tr").find(".btn-edit").show();
    //     $(this).parents("tr").find(".btn-update").remove();
    //     $(this).parents("tr").find(".btn-cancel").remove();

    // });
    
    
    
	$("#add_case").submit(function(e){
   		 e.preventDefault();
   		 
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
		
		let suit_number =  $('input[name="search_suit_number"]').val();
		let json_data = JSON.stringify(_jsonData);
		
		if(suit_number !==null){
			let nature_of_case =  $('#nature_of_case').find(":selected").val();
			let court = $('#court').find(":selected").val();
			let court_region = $('#court_region').find(":selected").val();
			let date_received =  $('input[name="date_received"]').val();
			let reference_number =  $('input[name="reference_number"]').val();
			let court_description =  $('input[name="court_description"]').val();
			let court_process =  $('input[name="court_process"]').val();
			let date_document =  $('input[name="date_document"]').val();
			let received_at =  $('input[name="received_at"]').val();
			//let parties=JSON.parse(localStorage.getItem('parties')) || [];
			let parties = json_data
			//console.log(parties);
			//parties=JSON.stringify(parties);
			let reliefs =  $('#reliefs').val();
			let summary =  $('#summary').val();
			
			const arr = court_description.split(" ");
			
			for (var i = 0; i < arr.length; i++) {
			    arr[i] = arr[i].charAt(0).toUpperCase() + arr[i].slice(1).toLowerCase();
			
			}
			
			let str = arr.join(" ");
			
			const arr1 = court_process.split(" ");
			
			for (var i = 0; i < arr1.length; i++) {
			    arr1[i] = arr1[i].charAt(0).toUpperCase() + arr1[i].slice(1).toLowerCase();
			
			}
			
			let str1 = arr1.join(" ");
			
			//console.log(reliefs)
			//console.log(summary)
			//console.log(str2)
			
			$.ajax({
			type:"POST",
			url:"legacy_cases_serv",
			data:{"request_type":"secretariat_add_case",
				  "suit_number":suit_number,
				  "reference_number":reference_number,
				  "nature_of_case":nature_of_case,
				  "court_process":str1,
				  "court":court,
				  "court_description":str,
				  "date_received":date_received,
				  "date_document":date_document,
				  "parties":parties,
				  "received_at":received_at,
				  "reliefs":reliefs,
				  "summary":summary,
				  "court_region":court_region
			},
			success:function(response){
				//console.log(response)
				
				let json_result = JSON.parse(response);
			
					//console.log(json_result)
					
					if(json_result.success){
						
					toastr["success"]("Saved Successfully", "LEGAL");
			      
	                  setInterval(function(){
	                       //location.reload();
	                       location.href = "secretariat";
	                 },1000); 
	                 
	               }
	               else{
						toastr["danger"]("Saving unsuccessfully", "LEGAL");
		                
		                setInterval(function(){
	                       location.reload();
	                 },1000); 
					}
				
				}
			
			})
			
			
		}
		else{
			
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
		const party = {"party_tel": "",
						"lawyer_tel": lawyer_tel,
						"party_name":party_name,
						//"party_address":party_address,
						"party_type": party_type,
						"party_lawyer":party_lawyer,
						"party_address": party_address,
						"lawyer_address":lawyer_address,
						"lawyer_chamber": lawyer_chamber
						};
		console.log(party)

		if(parties_save(party)){
		
		      $("#addPartyModal").find('form').trigger('reset');
                    $("#addPartyModal").modal('hide');
                    $("#add_party").prop('disabled', false);
                    
                     toastr["success"]("Party Added", "LEGAL");
                 
              	let parties=JSON.parse(localStorage.getItem('parties')) || [];
              	display_parties(parties);
				
		}
		else{
			  toastr["danger"]("Adding party unsuccessful", "LEGAL");
		      $("#addPartyModal").find('form').trigger('reset');
                    $("#addPartyModal").modal('hide');
                    $("#add_party").prop('disabled', false);
                    
                
                 
             let parties=JSON.parse(localStorage.getItem('parties')) || [];
             display_parties(parties);
		}
		
		}
	})
	
	
	$(function() {
	  $("#nature_of_case").on("change",function() {
	    console.log(parseInt($("#nature_of_case").val()))
	    
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
		
		document.getElementById('party_type').innerHTML = option_parties;
	  }); 
	});
		
		
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
						<td> <button type="button" class="btn-edit btn btn-sm btn-secondary"
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
	
	
})