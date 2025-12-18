$(function(){

	localStorage.clear();

	show_status();
	//load documents
	load_documents();
	//load notes
	load_notes();
	// Load Timelines
	load_timelines();
	

	//$('#parties_tbl').DataTable();
	//$('#attachments').DataTable();
	$('#process_tbl').DataTable();
	//$('#notes_table').DataTable();
	$('#notes_table_2').DataTable();
	//$('#requested_info').DataTable();
	//$('#provided_docs').DataTable();
	$('#minutes_tbl').DataTable();
	$('#parties_tbl_main').DataTable();

	$("#add_new_party").on('click',function(e){
		e.preventDefault();
		
		 $("#addPartyModal").modal('show');
		
		let suit_number =  $('input[name="suit_number"]').val();
		
		$.ajax({
			type:"POST",
			url:"legacy_cases_serv",
			data:{"request_type":"search_suit",
				  "suit_number":suit_number,
			},
			success:function(response){
			
			let json_result = JSON.parse(response);

			if(json_result.success){
					if(json_result.cases !== null){
						
						let parties=json_result.cases[0].parties;
						
						//console.log(parties)
						if(parties !== null){
						
							localStorage.removeItem('parties');
        					localStorage.setItem('parties',JSON.stringify(json_result.cases[0].parties));

						 }
							
				}
			}
		}
		
		})
	})

	let suit_number =  $('input[name="suit_number"]').val();
		
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
		}
		
		})
		
	$("#add_party").on("click",function(){
		
		$("#add_party").prop('disabled', true);
		
		//let _id = Math.floor(Math.random() * 1000);
		let party_type =  $('#party_type').find(":selected").val();
		let party_name =  $('input[name="party_name"]').val();
		let party_address =  $("#party_address").val();
		let party_lawyer =  $('input[name="party_lawyer"]').val();
		let lawyer_tel =  $('input[name="lawyer_tel"]').val();
		let lawyer_address =  $("#lawyer_address").val();
		let lawyer_chamber =  $('input[name="lawyer_chamber"]').val();
		
		if(!party_type|| !party_name) {
			$("#add_party").prop('disabled', false);
			toastr["error"]("Required fields cannot be empty", "Error");
		}
		else {
		
		const party = {
			//"id":_id,
			"party_tel": "",
			"lawyer_tel": lawyer_tel,
			"party_name":party_name,
			"party_type": party_type,
			"party_lawyer":party_lawyer,
			"party_address": party_address,
			"lawyer_address":lawyer_address,
			"lawyer_chamber": lawyer_chamber
		};
		
		console.log(party);

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
		//document.getElementById('remove_parties_tbl').innerHTML="";
		
		}
	}
	
	/*$('#editPartyModal').on('show.bs.modal',function(event) {
		$("#editPartyModal #e_party_type").val($(event.relatedTarget).data('party_type'));	
		$("#editPartyModal #e_party_name").val($(event.relatedTarget).data('party_name'));
		$("#editPartyModal #e_party_lawyer").val($(event.relatedTarget).data('party_lawyer'));
		$("#editPartyModal #e_lawyer_tel").val($(event.relatedTarget).data('lawyer_tel'));	
		$("#editPartyModal #e_lawyer_address").val($(event.relatedTarget).data('lawyer_address'));
		$("#editPartyModal #e_lawyer_chamber").val($(event.relatedTarget).data('lawyer_chamber'));
	});*/
	
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

	$("#parties_tbl").on("click", ".btn-edit", function(event){

		//console.log('ok')

		$('#editPartyModal').modal({
			backdrop : 'static',
		});
		$('#editPartyModal').modal('show');

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
    
    
    $("#parties_tbl").on("click", ".btn-cancel", function(event){

        var party_type = $(event.currentTarget).data('party_type');
        var party_name = $(event.currentTarget).data('party_name');
        var party_address = $(event.currentTarget).data('party_address');
        var party_lawyer = $(event.currentTarget).data('party_lawyer');
        var lawyer_tel = $(event.currentTarget).data('lawyer_tel');
        var lawyer_address = $(event.currentTarget).data('lawyer_address');
        var lawyer_chamber = $(event.currentTarget).data('lawyer_chamber');

        $(this).parents("tr").find("td:eq(0)").text(party_type);
        $(this).parents("tr").find("td:eq(1)").text(party_name);
        $(this).parents("tr").find("td:eq(2)").text(party_address);
        $(this).parents("tr").find("td:eq(3)").text(party_lawyer);
        $(this).parents("tr").find("td:eq(4)").text(lawyer_tel);
        $(this).parents("tr").find("td:eq(5)").text(lawyer_address);
        $(this).parents("tr").find("td:eq(6)").text(lawyer_chamber);

        $(this).parents("tr").find(".btn-edit").show();
        $(this).parents("tr").find(".btn-update").remove();
        $(this).parents("tr").find(".btn-cancel").remove();

    });
    
    
     $("#parties_tbl").on("click", ".btn-update", function(){
		 
		 //$('#party_type').find(":selected").val();

        var party_type = $(this).parents("tr").find(":selected").val();
        var party_name = $(this).parents("tr").find("input[name='party_name']").val();
        var party_address = $(this).parents("tr").find("input[name='party_address']").val();
        var party_lawyer = $(this).parents("tr").find("input[name='party_lawyer']").val();
        var lawyer_tel = $(this).parents("tr").find("input[name='lawyer_tel']").val();
        var lawyer_address = $(this).parents("tr").find("input[name='lawyer_address']").val();
        var lawyer_chamber = $(this).parents("tr").find("input[name='lawyer_chamber']").val();

        $(this).parents("tr").find("td:eq(0)").text(party_type);
        $(this).parents("tr").find("td:eq(1)").text(party_name);
        $(this).parents("tr").find("td:eq(2)").text(party_address);
        $(this).parents("tr").find("td:eq(3)").text(party_lawyer);
        $(this).parents("tr").find("td:eq(4)").text(lawyer_tel);
        $(this).parents("tr").find("td:eq(5)").text(lawyer_address);
        $(this).parents("tr").find("td:eq(6)").text(lawyer_chamber);

        $(this).parents("tr").attr('data-party_type', party_type);
        $(this).parents("tr").attr('data-party_name', party_name);
        $(this).parents("tr").attr('data-party_address', party_address);
        $(this).parents("tr").attr('data-party_lawyer', party_lawyer);
        $(this).parents("tr").attr('data-lawyer_tel', lawyer_tel);
        $(this).parents("tr").attr('data-lawyer_address', lawyer_address);
        $(this).parents("tr").attr('data-lawyer_chamber', lawyer_chamber);

        $(this).parents("tr").find(".btn-edit").show();
        $(this).parents("tr").find(".btn-cancel").remove();
        $(this).parents("tr").find(".btn-update").remove();

    });
    
    $(".btn_update_parties").on("click", function(e){
		e.preventDefault();
		
	   	var _table = document.getElementById("parties_tbl");
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
		
		let json_data = JSON.stringify(_jsonData);
		let suit_number =  $('input[name="suit_number"]').val();
		let case_id =  $('input[name="case_id"]').val();
		
		console.log(json_data +','+suit_number+','+case_id);
		
		$.ajax({
			type:"POST",
			url:"legacy_cases_serv",
			data:{
				"request_type":"update_parties",
			  	"parties":json_data,
			 	"suit_number":suit_number,
				"case_id":case_id,
			},
			success:function(response){
			
				let json_result = JSON.parse(response);
	
				if(json_result.success == true){
					toastr["success"]("Updated successfully", "Parties");
					
					setTimeout(function(){
                        location.reload();
                    },1000); 
				}
			}
		
		})
	});
	
	//Attach letter
	$("#attach_letter").on('click',function(e){
		e.preventDefault();
		let suit_number =  $('input[name="suit_number"]').val();
		
		let data_id=$(this).attr('data_id');
		let status="";
		if(data_id="PS1"){
			status="Appearance";
		}
		
		$("#attachmentModal").modal('show');
		
		$('input[name="a_suit_number"]').val(suit_number);
		$('input[name="type_of_document"]').val(status);
	})	
	
	$("#letter_upload").on('submit',function(e){
		e.preventDefault();
		
		let suit_number=$('input[name="suit_number"]').val();
		let type_of_document=$('#a_type_of_document').val();
		let case_id=$('input[name="case_id"]').val();
		//console.log(type_of_document)
		
		let formdata = new FormData();
		
		formdata.append("request_type","cases_upload");
		formdata.append("suit_number",suit_number);
		formdata.append("case_id",case_id);
		formdata.append("scan_type","unit_case");
		formdata.append("type_of_document",type_of_document);
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
	
	// Show Notes Modal
	$("#make_note").on('click',function(e){
		e.preventDefault();
		let suit_number =  $('input[name="suit_number"]').val();

		$("#notesModal").modal('show');
		
		$('input[name="n_suit_number"]').val(suit_number);
		
	})
	
	// Saving notes
	$("#case_note").on('submit',function(e){
		
		e.preventDefault();
		$("#make_note").prop('disabled', true);
		let case_id=$('input[name="n_case_id"]').val();
		let suit_number=$('input[name="n_suit_number"]').val();
		let subject=$('input[name="subject"]').val();
		let notes=$('textarea#notes_text').val();
		let created_by=$('input[name="created_by"]').val();
		
		$.ajax({
			type:"POST",
			url:"case_work_serv",
			data:{"request_type":"case_note",
				  "suit_number":suit_number,
				  "subject":subject,
				  "notes":notes,
				  "created_by":created_by,
				  "case_id":case_id,
			},
			success:function(response){
				console.log(response);
				
				let json_results=JSON.parse(response);
				
				if(json_results.success){
					 toastr["success"]("Note saved successfully", "Note");
					 
					  setInterval(function(){
	                       location.reload();
	                 },1000); 
	                 
	                 $("#notesModal").modal('hide');
                } 
              else {
                        toastr["error"]("Error occurred saving note", "Note");
                 }

                    $("#notesModal").find('form').trigger('reset');
                    
                    $("#make_note").prop('disabled', false);
				}
		})
	})
	
	
	$("#btnEditReliefnSummary").on('click',function(){
		
		//e.preventDefault();
		$("#btnEditReliefnSummary").prop('disabled', true);
		let case_id=$('input[name="case_id"]').val();
		let releifs=$('textarea#rs_releifs').val();
		let summary=$('textarea#rs_summary').val();
		
		$.ajax({
			type:"POST",
			url:"case_work_serv",
			data:{"request_type":"update_releifs_and_summary",
				  "case_id":case_id,
				  "releifs":releifs,
				  "summary":summary
			},
			success:function(response){
				console.log(response);
				
				let json_results=JSON.parse(response);
				
				if(json_results.success){
					
             	toastr["success"]("Saved Successfully", "LEGAL");
			      
	                  setInterval(function(){
	                       location.reload();
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
	})
	
	//Generate Appearance letter
	$("#generate_appearance").on('click',function(e){
		e.preventDefault();
		let suit_number =  $('input[name="suit_number"]').val();
		let content=$("#file_appearance").text();
		console.log(content);
		
		//let textbox = $('body #tinymce.mce-conent-body')
		//let textbox2 =$("#tinymce");
		//tinymce.activeEditor.dom.addClass(tinymce.activeEditor.dom.select('p'), 'someclass');

		
		let paragraphs=document.body.querySelectorAll(".bbbb");
		
		let conts=tinymce.activeEditor.selection.getContent({ format: 'text' });
	
		console.log(paragraphs);
		console.log(conts);
		 for (let i=0;i<paragraphs.length;i++){
            
              console.log(paragraphs[i].textContent);
        }
		
		// Button Hide
	 	$("#generate_appearance").prop('disabled', true);
	 	
	 	var formdata = new FormData();
	 	formdata.append("request_type","generate_appearance");
		formdata.append("suit_number",suit_number);
		formdata.append("content",content);
		
	//	console.log(formdata);
		
		/*$.ajax({
				type : "POST",
				url : "case_work",
				data : {"request_type":"generate_appearance",
						"suit_number":suit_number,
						"content":content},
				//processData : false,
				//contentType : false,
				cache : false,
				xhrFields : {
					responseType : 'blob'
				},
				timeout : 600000,
				success : function(data) {
					console.log("ok")
				
				}
			})*/
		
	})
	
	
	function load_documents(){
		let suit_number =  $('input[name="suit_number"]').val();
		//console.log(suit_number)
		var table_docs = $('#attachments');
		table_docs.find("tbody tr").remove();
		
		
			$.ajax({
		url:"load_scanned_documents",
		method:"POST",
		data:{
				"request_type":"load_scanned_document",
				"suit_number":suit_number
		},
		success:function(response){
			//console.log(response);
			

			var json_p = JSON
					.parse(response);
			console.log(json_p)

			$(json_p)
					.each(
							function() {

								table_docs
										.append("<tr>"
												+ '<td> <a class="link-post" data-file_path="'+ this.document_name +'" href="'
												+ this.document_file
												+ '">'
												+ this.document_name
												+ '</a></td>'
												+'<td>'
												+ this.document_extention
												+ "</td>"
												+ "</tr>");
									
							});
					}
				})
	
		}
		
		
		
		$('#attachments')
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
								request_type: 'open_case_doc',
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
			

		
		function load_notes(){
			let suit_number =  $('input[name="suit_number"]').val();
			
			var table_docs = $('#notes_table');
			table_docs.find("tbody tr").remove();
			
			var table_docs_ = $('#notes_table_2');
			table_docs_.find("tbody tr").remove();
	
			$.ajax({
					url:"case_work_serv",
					method:"POST",
					data:{
					"request_type":"load_notes",
					"suit_number":suit_number
					},
				success:function(response){
					//console.log(response);
					
					var json_p = JSON
					.parse(response);
			//console.log(json_p)
			
	              	
			$(json_p.data)
					.each(
							function() {

								table_docs
										.append("<tr>"
												+ '<td>'
												+ this.subject
												+ '</td><td>'
												+ this.notes
												+ '</td>'
												+'<td>'
												+ `<div class="dropdown no-arrow">
	              	  								
									              	  <button class="btn btn-default btn-sm  text-primary" data-toggle="modal" href="#notesModal" data-note_id="${this.id}" data-subject="${this.subject}" data-notes="${this.notes}">
									              	  <span class="fas fa-edit"></span>
									              	  Edit</button>
									              	</div>`
												+ "</td>"
												+ "</tr>");

							});
							
							      	
			$(json_p.data)
					.each(
							function() {

								table_docs_
										.append("<tr>"
												+ '<td>'
												+ this.subject
												+ '</td><td>'
												+ this.notes
												+ '</td>'
												+ "</tr>");

							});
					
					
				}
			})
			
	}
	
	
	$('#notesModal').on('show.bs.modal',function(event) {
		$("#notesModal #subject").val($(event.relatedTarget).data('subject'));	
		$("#notesModal #notes_text").val($(event.relatedTarget).data('notes'));
		$("#notesModal #n_case_id").val($(event.relatedTarget).data('note_id'));
	});
	
	
	$('#editPartyModal').on('show.bs.modal',function(event) {
		$("#editPartyModal #e_party_type").val($(event.relatedTarget).data('party_type'));	
		$("#editPartyModal #e_party_name").val($(event.relatedTarget).data('party_name'));
		$("#editPartyModal #e_party_lawyer").val($(event.relatedTarget).data('party_lawyer'));
		$("#editPartyModal #e_lawyer_tel").val($(event.relatedTarget).data('lawyer_tel'));	
		$("#editPartyModal #e_lawyer_address").val($(event.relatedTarget).data('lawyer_address'));
		$("#editPartyModal #e_lawyer_chamber").val($(event.relatedTarget).data('lawyer_chamber'));
	});
	
////////////////////////////////Parties ///////////////////////////////////////////////////////////////////

  $('.edit_parties').click(function(){
       
       	let suit_number =  $('input[name="suit_number"]').val();
        //console.log(suit_number)
        const partiesModal=$("#partiesModal");
        
      

        $.ajax({
					url:"case_work_serv",
					method:"POST",
					data:{
					"request_type":"load_case_details",
					"suit_number":suit_number
					},
				success:function(response){
					
					//console.log(response);
					
					var json_p = JSON.parse(response);
					
					//console.log(json_p.data[0].plaintiffs); 
					
					const parties_obj= {plaintiffs:json_p.data[0].plaintiffs,
										defendants:json_p.data[0].defendants};
										
					//console.log(parties_obj);
										
					localStorage.removeItem('parties');
					localStorage.setItem('parties',JSON.stringify(parties_obj))

					partiesModal.modal('show');

				}
			})
        
    })

	 $("#partiesModal").on('shown.bs.modal', function() {
			
		partiesModalDisplay() 
		
		})



	function partiesModalDisplay(){
		
		let parties = JSON.parse(localStorage.getItem('parties')) || [];
			 
			 let plaintiffs="";
			 let defendants="";
			 
			 //console.log(parties)
			 //console.log(parties.plaintiffs)
			 $(parties.plaintiffs)
					.each(function() {
						plaintiffs+='<li>'+this.plaintiffs_name+'</li>'
					})
					
			$(parties.defendants)
					.each(function() {
						defendants+='<li>'+this.defendants_name+'</li>'
					})
			
			
			var plaintiffs_list = $('#plaintiffs_list');
			var defendants_list=$('#defendants_list');
			plaintiffs_list.find("li").remove();
			defendants_list.find("li").remove();			
			plaintiffs_list.append(plaintiffs);
			defendants_list.append(defendants);
		
	}
	
	function show_status(){
		let status_of_case = parseInt($('input[name="status_of_case"]').val());
		console.log(status_of_case);
		try{
		 var activeStatus = document.getElementById(status_of_case);
	  	activeStatus.classList.add("bg-warning");
	  	}
	  	catch(err){
		 console.log("error checking status");
		}
	}
	/*$('#add_plaintiff').click(function(){
       
       let input_plaintiff =  $('input[name="input_plaintiff"]').val();
       
       let parties = JSON.parse(localStorage.getItem('parties')) || [];
       
       
       let plaintiffs=parties.plaintiffs;
       let defendants=parties.defendants;
       
       if(input_plaintiff ===""){
			toastr["error"]("Empty field", "Parties");
		}else{
			
			const plaintiffs_obj={"plaintiffs_name":input_plaintiff}
			plaintiffs.push(plaintiffs_obj);
			parties={"plaintiffs":plaintiffs,"defendants":defendants}
			localStorage.removeItem('parties');
			localStorage.setItem('parties',JSON.stringify(parties));
			partiesModalDisplay(); 
			$('input[name="input_plaintiff"]').val("");
		}
       
     })*/
     
     /*$('#add_defendant').click(function(){
       
       let input_defendant =  $('input[name="input_defendant"]').val();
      // console.log(input_defendant);
       
       
       let parties = JSON.parse(localStorage.getItem('parties')) || [];
       
       
       let plaintiffs=parties.plaintiffs;
       let defendants=parties.defendants;
       
       if(input_defendant ===""){
			toastr["error"]("Empty field", "Parties");
		}else{
			
			const defendant_obj={"defendants_name":input_defendant}
			defendants.push(defendant_obj);
			parties={"plaintiffs":plaintiffs,"defendants":defendants}
			localStorage.removeItem('parties');
			localStorage.setItem('parties',JSON.stringify(parties));
			partiesModalDisplay(); 
			$('input[name="input_defendant"]').val("");
		}
       
     })*/

	$("#save_parties").click(function(){
		
			    $("#save_parties").prop('disabled', true);
			    
			   let suit_number =  $('input[name="suit_number"]').val();
		       let parties = JSON.parse(localStorage.getItem('parties')) || [];
		       
		       console.log(parties);
       
		       let plaintiffs=JSON.stringify(parties.plaintiffs);
		       let defendants=JSON.stringify(parties.defendants);
		       
		       console.log(plaintiffs);
		       
		       $.ajax({
					url:"case_work_serv",
					method:"POST",
					data:{
					"request_type":"update_parties",
					"suit_number":suit_number,
					"plaintiffs":plaintiffs,
					"defendants":defendants
					},
				success:function(response){
					
					console.log(response);
					 let json_result = JSON.parse(response);

					 if(json_result.success){
						 toastr["success"]("Parties updated successfully", "Parties");
		                } 
		              else {
		                        toastr["error"]("Error occurred updating parties", "Parties");
		                 }
		
                    $("#partiesModal").modal('hide');
                    $("#save_parties").prop('disabled', false);
                    
                    setTimeout(function(){
                        location.reload(1);
                    },1000);
	
				}
			})
		       
		       
	})


///////////////////////////// End Parties /////////////////////////////////////////////////////////////////
 $('#generate_letter').on('submit',function(e){
	       e.preventDefault();
	  $("#generateLetterBtn").prop('disabled', false);
	  
	    let suit_number =  $('input[name="suit_number"]').val();
	    let letter_template=$('#letter_template').val();
	    let txt = document.getElementById("text-area-first").value;
 		//let txttostore = '<p>' + txt.replace(/\n/g, "</p>\n<p>") + '</p>';
 		let txtarray=txt.split('\n');
 		console.log(txtarray);
 		let txtarrayobj={"paragraphs":txtarray}
 		let txtarraystr=JSON.stringify(txtarrayobj)
 		$.ajax({
					url:"case_work_serv",
					method:"POST",
					data:{
					"request_type":"generate_letters",
					"suit_number":suit_number,
					"letter_template":letter_template,
					"txtarray":txtarraystr
					},
				success:function(response){
					
					console.log(response);
					showbatchlist(response,suit_number,letter_template);
					
					}
			})
 		
	       
})


function showbatchlist(timestamp,suit_number,letter_template){
		
				
				
				
				$.ajax({
							type : "POST",
							url : "case_work_serv",
							// target:'_blank',
							data : {
								"request_type" : 'open_pdf',
								"timestamp" : timestamp,
								"suit_number": suit_number,
								"letter_template":letter_template
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


					}
	//$('#elisDocumentPreview').on('hidden.bs.modal',function(){
	//	setTimeout(function(){
     //                   location.reload();
     //               },1000); 
	//})
	
	
	$("#update_status_form").on('submit',function(e){
		e.preventDefault();

		let suit_number=document.forms["update_status_form"]["suit_number"].value;
		let case_id=parseInt(document.forms["update_status_form"]["case_id"].value);
		let status_of_case=parseInt($('#status_case').find(":selected").val());
		let updated_by=document.forms["update_status_form"]["updated_by"].value;
		let start_date=document.forms["update_status_form"]["start_date"].value;
		let end_date=document.forms["update_status_form"]["end_date"].value;
		let request_type = "update_case_status";
		
		console.log(request_type)
		
		console.log(status_of_case);
		$.ajax({
			method:"POST",
			url : "case_work_serv",
			data : {"suit_number":suit_number,
					"case_id":case_id,
					"status_of_case":status_of_case,
					"start_date":start_date,
					"end_date":end_date,
					"updated_by":updated_by,  
					"request_type":request_type},
			success:function(response){
				console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success == true){
				 toastr["success"]("Status Updated", "Case");
                } 
              else {
                        toastr["error"]("Error updating status", "Case");
                 }

                    $("#updateStatusModal").find('form').trigger('reset');
                    $("#updateStatusModal").modal('hide');
                   setTimeout(function(){
                        location.reload();
                    },1000); 
			}
			
		})
	})
	
	
	///////////////////////////////////////////////////////////////////////////
	function load_timelines(){
		let suit_number =  $('input[name="suit_number"]').val();
			
		$.ajax({
			type:"POST",
			url:"case_work_serv",
			data:{"request_type":"load_suit_number_timeline",
				  "suit_number":suit_number
			},
			success:function(response){
				
				console.log(response);
				let json_results=JSON.parse(response);
				
				let html_upcoming="";
				let html_past="";
				if(json_results.success){
					
					if(json_results.data !== null){
						json_results.data.forEach(function(data){
					
					var todayDate = new Date(); //Today Date    
			       	var dateOne = new Date(data.end_date);    
			        if (todayDate > dateOne) {
							html_past+=` <li>
					          <a class="${data.timeline_status_id == 0 ? 'text-danger' : 'text-success'}" href="#viewTimelineDetails" data-toggle="modal" data-timeline_id="${data.id}" data-notes="${data.notes}">${data.nature_of_case}</a>
					          <span class="${data.timeline_status_id == 0 ? 'text-danger' : 'text-success'}  float-end">${data.end_date}</span>
					          <p class="mt-2"><strong>${data.description}</strong></p>
					          <p class="mt-2">${data.court_name}</p>
					        </li>`;
			         }else {    
			            html_upcoming+=` <li>
					          <a class="${data.timeline_status_id == 0 ? 'text-warning' : 'text-success'}" href="#viewTimelineDetails" data-toggle="modal" data-timeline_id="${data.id}" data-notes="${data.notes}">${data.nature_of_case}</a>
					          <span class="${data.timeline_status_id == 0 ? 'text-warning' : 'text-success'} float-end">${data.end_date}</span>
					          <p class="mt-2"><strong>${data.description}</strong></p>
					          <p class="mt-2">${data.court_name}</p>
					        </li>`;  
			        }    
				 	 
					
			      })
					}
				 
				 
			      
                } 
              else {
                        
                 }
                 
               document.getElementById('upcoming').innerHTML=html_upcoming;
                document.getElementById('past').innerHTML=html_past;

			}
		})	
		
	}
	
	$('#viewTimelineDetails').on('show.bs.modal',function(event) {
		$("#viewTimelineDetails #up_case_id").val($(event.relatedTarget).data('timeline_id'));	
		$("#viewTimelineDetails #up_notes").val($(event.relatedTarget).data('notes'));
		
		console.log($(event.relatedTarget).data('notes'))
	});
	
	
	$('#update_status_form_with_note').on('submit',function(e){
		e.preventDefault();
		
		let up_notes =$("#up_notes").val();
		let up_case_id =$("#up_case_id").val();
		let up_suit_number =$("#up_suit_number").val();
		
	
		
		$.ajax({
			url:"case_work_serv",
			method:"POST",
			data:{
				up_notes:up_notes,
			    up_case_id:up_case_id,
				up_suit_number:up_suit_number,
				request_type:"update_status_form_with_note",
			},
            success:function(response){
				console.log(response)
               let json_result = JSON.parse(response);
			
					//console.log(json_result)
					
					if(json_result.success){
                    toastr["success"]("Case status updated successfully", "Case");
                }

                
                    setTimeout(function(){
                        location.reload()
                    },1000);
            }
		})
		
		
	})
	
	
	 $('#update_parties').on('click', function() {
		 let parties=JSON.parse(localStorage.getItem('parties')) || [];
		 
		 console.log(parties);
		 
		 if (!Array.isArray(parties)) {
	        
	     } else if (parties.length == 0) {
	        
	     } else if (parties.length != 0) {
			 
		 }
	 })
	

		
})



document.addEventListener('DOMContentLoaded', function() {
		
	var table_pro_docs = $('#provided_docs');
		table_pro_docs.find("tbody tr").remove();

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
                if(result.success == true){
					
					if(result.data){
						for(let i = 0; i<result.data.length; i++) {
						let html = [];
						num = (+num + 1);
						
						let notes = result.data[i].notes;
						let file_location = result.data[i].file_location;
						let file_name = result.data[i].file_name;
						let provided_by = result.data[i].provided_by;
						let date_provided = result.data[i].date_provided.split('T')[0];
						let attach_file = result.data[i].attach_file;
						let unit = result.data[i].unit;
						let division = result.data[i].division;
						let action = `<div>
							<button class="btn btn-primary btn-sm link-post" data-notes="${notes}" data-file_path="${file_location}" data-suit_number="${suit_number}">View</button>
						</div>`
						
						var notesArr = notes.split(" ");
						var noteShort = notesArr.splice(0, 4).join(" ");
						
						html.push(noteShort+"...");
						/*html.push(' <a class="link-post" data-file_path="'+ file_location +'" href="'
													+ file_location
													+ '">'
													+ file_name
													+ '</a>');*/
						html.push(division);
						html.push(provided_by);
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
		            
		            document.getElementById("provided_docs").style.width = "1000px";
					}
					
					
				}
			
			}
		})
		
		
		//$('#elisDocumentPreview').on('show.bs.modal',function(event) {
			//$("#view_notes #ll_reference_no").val($(event.relatedTarget).data('suit_number'));	
			//document.getElementById("p_suit_number").innerHTML = $(event.relatedTarget).data('suit_number');	
			//document.getElementById("n_notes").innerHTML = $(event.relatedTarget).data('notes');
		//});
		
		
		$('#provided_docs')
		.on(
				'click',
				'.link-post',
				function(event) {
					// console.log(e)
					event.preventDefault();

					var suit_number=$('input[name="suit_number"]').val();
					var file_path = $(event.currentTarget).data('file_path');
					
					document.getElementById("p_suit_number").innerHTML = $(event.currentTarget).data('suit_number');	
					document.getElementById("n_notes").innerText = $(event.currentTarget).data('notes');
					
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
				
		var table_req_docs = $('#requested_info');
		table_req_docs.find("tbody tr").remove();
		
		let dataSet_ = [];
    	var num = '';	
		
				
		$.ajax({
			url:"record_info_serv",
			method:"POST",
			data:{
					"request_type":"load_requested_record_info",
					"suit_number":suit_number,
					"case_id":case_id,
			},
			success:function(response){
				console.log(response);
				
				var result = JSON.parse(response);
                if(result.success == true){
					
					if(result.data){
						for(let i = 0; i<result.data.length; i++) {
						let html_ = [];
						num = (+num + 1);
						
						let subject = result.data[i].subject;
						let description = result.data[i].description;
						let deadline = result.data[i].deadline;
						let movement_status = result.data[i].movement_status;
						let requested_date = result.data[i].requested_date.split('T')[0];
						let action = `<div>
							<button class="btn btn-primary btn-sm" data-notes="${notes}" data-suit_number="${suit_number}" data-toggle="modal" data-target="#view_notes">View More</button>
						</div>`
						
						/*var notesArr = notes.split(" ");
						var noteShort = notesArr.splice(0, 4).join(" ");*/
						
						if(movement_status == 'incoming') {
							movement_status = 'Pending'
						} else {
							movement_status = ''
						}
						
						html_.push(subject);
						html_.push(description);
						html_.push(deadline);
						html_.push(movement_status);
		                html_.push(requested_date);
		                //html.push(action);

            			dataSet_.push(html_);
					}
					
					$('#requested_info').DataTable({
		                //pageLength: 10,
		                data: dataSet_,
		                searching: false, 
		                paging: false, 
		                info: false,
		                ordering: false
		            });
		            
		            document.getElementById("requested_info").style.width = "1000px";

					}
					
					
				}
			
			}
		})	
		
 })