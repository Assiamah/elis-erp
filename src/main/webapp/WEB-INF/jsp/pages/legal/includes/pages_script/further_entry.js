$(function(){
	
	localStorage.clear();
	
	$("#scroll_page").on("click",function(){
		
		window.scroll({
			  top: 200,
			  left: 100,
			  behavior: "smooth",
			});
	})

	let suit_number =  $('input[name="suit_number"]').val();

	function CallA() {

		$.ajax({
			type:"POST",
			url:"legacy_cases_serv",
			data:{"request_type":"search_suit",
				  "suit_number":suit_number,
			},
			success:function(response){
			
			let html="";
			let json_result = JSON.parse(response);

			if(json_result.success){
					if(json_result.cases !== null){
						
						let parties=json_result.cases[0].parties;
						
						//console.log(parties)
						if(parties !== null){
						
							localStorage.removeItem('parties');
        					localStorage.setItem('parties',JSON.stringify(json_result.cases[0].parties));
							display_parties(parties);
						
							
						 }
							
				}
			}

			CallB()
		}
		
		})
	}

	function CallB() {
		
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
        					       					
						}
					}	
			}
			
	})
	}
	/////
	
	
	CallA();


	$('#further_entry_form').on('submit',function(e){
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
		
		let court_id =parseInt($('#court_id').find(":selected").val());
		let case_id=parseInt($('input[name="case_id"]').val());
		let suit_number =$('input[name="suit_number"]').val();
		let court_description =  $('input[name="court_description"]').val();
		let reliefs =$("#reliefs").val();
		let nature_of_case =parseInt($('#nature_of_case').find(":selected").val());
		let reference_number =  $('input[name="reference_number"]').val();
		let court_process =  $('input[name="court_process"]').val();
		let summary =$("#summary").val(); 
        let date_of_document =$('input[name="date_of_document"]').val();
        let request_type =$('input[name="request_type"]').val();
      	//let parties=JSON.parse(localStorage.getItem('parties')) || [];
      	let parties = JSON.stringify(_jsonData);
      	
      	const arr = court_description.split(" ");
			
		for (var i = 0; i < arr.length; i++) {
		    arr[i] = arr[i].charAt(0).toUpperCase() + arr[i].slice(1).toLowerCase();
		}
		
		let str2 = arr.join(" ");
		
		console.log(parties)
		
		$.ajax({
			url:"legal_further_entries",
			method:"POST",
			data:{
				court_id:court_id,
			    case_id:case_id,
				suit_number:suit_number,
				reference_number:reference_number,
				reliefs:reliefs,
				nature_of_case:nature_of_case,
				summary:summary,
				court_process:court_process,
				court_description:str2,
				date_of_document:date_of_document,
				request_type:request_type,
				parties:parties,
			},
            success:function(response){
				console.log(response)
               let json_result = JSON.parse(response);
			
					//console.log(json_result)
					
					if(json_result.success){
                    toastr["success"]("Updated successfully", "Further Entry");
                }

                
                    setTimeout(function(){
                        location.reload()
                    },1000);
            }
		})
		
		
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
	
	// $("#parties_tbl").on("click", ".btn-edit", function(event){

    //     var party_type = $(event.currentTarget).data('party_type');
    //     var party_name = $(event.currentTarget).data('party_name');
    //     var party_address = $(event.currentTarget).data('party_address');
    //     var party_lawyer = $(event.currentTarget).data('party_lawyer');
    //     var lawyer_tel = $(event.currentTarget).data('lawyer_tel');
    //     var lawyer_address = $(event.currentTarget).data('lawyer_address');
    //     var lawyer_chamber = $(event.currentTarget).data('lawyer_chamber');

    //     //$(this).parents("tr").find("td:eq(0)").html('<input name="party_type" value="'+party_type+'">');
    //     $(this).parents("tr").find("td:eq(0)").html('<select name="party_type"><option value="'+party_type+'">'+party_type+'</option><option value="Plantiff">Plantiff</option><option value="Defendant">Defendant</option></select>');
    //     $(this).parents("tr").find("td:eq(1)").html('<input name="party_name" value="'+party_name+'">');
    //     $(this).parents("tr").find("td:eq(2)").html('<input name="party_address" value="'+party_address+'">');
    //     $(this).parents("tr").find("td:eq(3)").html('<input name="party_lawyer" value="'+party_lawyer+'">');
    //     $(this).parents("tr").find("td:eq(4)").html('<input name="lawyer_tel" value="'+lawyer_tel+'">');
    //     $(this).parents("tr").find("td:eq(5)").html('<input name="lawyer_address" value="'+lawyer_address+'">');
    //     $(this).parents("tr").find("td:eq(6)").html('<input name="lawyer_chamber" value="'+lawyer_chamber+'">');
	// 	$(this).parents("tr").find("td:eq(7)").prepend("<button type='button' class='btn-update'><span class='me-2 ms-2'>Save</span></button> ")

    //     $(this).hide();

    // });
    
    
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
    
    
    //  $("#parties_tbl").on("click", ".btn-update", function(){
		 
	// 	 //$('#party_type').find(":selected").val();

    //     var party_type = $(this).parents("tr").find(":selected").val();
    //     var party_name = $(this).parents("tr").find("input[name='party_name']").val();
    //     var party_address = $(this).parents("tr").find("input[name='party_address']").val();
    //     var party_lawyer = $(this).parents("tr").find("input[name='party_lawyer']").val();
    //     var lawyer_tel = $(this).parents("tr").find("input[name='lawyer_tel']").val();
    //     var lawyer_address = $(this).parents("tr").find("input[name='lawyer_address']").val();
    //     var lawyer_chamber = $(this).parents("tr").find("input[name='lawyer_chamber']").val();

    //     $(this).parents("tr").find("td:eq(0)").text(party_type);
    //     $(this).parents("tr").find("td:eq(1)").text(party_name);
    //     $(this).parents("tr").find("td:eq(2)").text(party_address);
    //     $(this).parents("tr").find("td:eq(3)").text(party_lawyer);
    //     $(this).parents("tr").find("td:eq(4)").text(lawyer_tel);
    //     $(this).parents("tr").find("td:eq(5)").text(lawyer_address);
    //     $(this).parents("tr").find("td:eq(6)").text(lawyer_chamber);

    //     $(this).parents("tr").attr('data-party_type', party_type);
    //     $(this).parents("tr").attr('data-party_name', party_name);
    //     $(this).parents("tr").attr('data-party_address', party_address);
    //     $(this).parents("tr").attr('data-party_lawyer', party_lawyer);
    //     $(this).parents("tr").attr('data-lawyer_tel', lawyer_tel);
    //     $(this).parents("tr").attr('data-lawyer_address', lawyer_address);
    //     $(this).parents("tr").attr('data-lawyer_chamber', lawyer_chamber);

    //     $(this).parents("tr").find(".btn-edit").show();
    //     $(this).parents("tr").find(".btn-cancel").remove();
    //     $(this).parents("tr").find(".btn-update").remove();

    // });

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
    
    	// On change region change court list
		
		$('#court_region').on('change',function(){
			
			let court_region=$('#court_region').find(":selected").text();
			
			//console.log(court_region);
			
			let courts_list=JSON.parse(localStorage.getItem('courts_list')) || [];
			
			//console.log(courts_list);
			
			let html=""
				for(let i=0; i<courts_list.length; i++){
					
					if(courts_list[i].region ==court_region){
					html+=`<option value="${courts_list[i].id}" >${courts_list[i].court_name} - (${courts_list[i].city}) </option>`
					}
				}
        					
				document.getElementById("court_id").innerHTML=html; 
			
			
		})
		
		
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
   