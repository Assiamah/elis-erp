$(document).ready(function() {


   
    $('#approve_step').on('shown.bs.modal', function(e) {
        var stepId = $(e.relatedTarget).data('bs-id');
        $('#cs_main_step_id').val(stepId);
    })

    
    $('#view_approve_comment').on('shown.bs.modal', function(e) {
        var stepId = $(e.relatedTarget).data('bs-id');
        var job_number = $('#cs_main_job_number').val();

        $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_load_step_approved_comment',
                    bs_id: parseInt(stepId),
                    job_number: job_number,
                    //approve_comment: approve_comment
                },
                cache: false,
                success: function(response) {

                    console.log(response)

                    if(!response) {
                        $
														.notify(
																{
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No comment!! <br><br></span>',
																},
																{
																	type : 'danger' , z_index: 9999 
																});

                                                                //alert("Approve comment is required!!")

                                                                $('#view_approve_comment').modal("hide");

											return;
                    }
                   
                    var json_result = JSON.parse(response);
                    
                    
                   if (json_result.success){
                        $('#approved_comment').val(json_result.data[0].approved_comment)
                        $('#approved_by').val(json_result.data[0].approved_by)
                        $('#approved_date').val(json_result.data[0].approved_date)

                   }else{
                    alert(json_result.msg)
                   }
                }
            })
    })

    $('#btn_approve_step').on('click', function(e) {
        e.preventDefault();

        var job_number = $('#cs_main_job_number').val();
        var stepId = $('#cs_main_step_id').val();
        var approve_comment = $('#approve_comment_').val();
        if(!approve_comment) {
											$
														.notify(
																{
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Approve comment is required!! <br><br></span>',
																},
																{
																	type : 'danger' , z_index: 9999 
																});

                                                                alert("Approve comment is required!!")
											return;
										}

                                        const confirmation = confirm('Are you sure you want to approve the step?');

                                        if (confirmation) {

                                        $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_review_baby_steps_check_for_completion',
                    bs_id: parseInt(stepId),
                    job_number: job_number,
                    approve_comment: approve_comment
                },
                cache: false,
                success: function(response) {

                    console.log(response)
                   
                    var json_result = JSON.parse(response);
                   if (json_result.success){
                    alert(json_result.msg)
                    location.reload()
                   }else{
                    alert(json_result.msg)
                   }

                }
            })
        }
    })

    $('#_verify_ffrv_application_status').on('click', function(e){
										e.preventDefault();
										var job_number = $('#verify_ffrv_job_number').val();

										if(!job_number) {
											$
														.notify(
																{
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number is required!! <br><br></span>',
																},
																{
																	type : 'danger' , z_index: 9999 
																});
											return;
										}

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'select_verify_ffrv_from_division',
														job_number : job_number

													},
													cache : false,

													success : function(
															jobdetails) {
														console.log("jobdetails:" + jobdetails);
														var json_b = JSON.parse(jobdetails)
														var pvlmd_status = json_b.pvlmd_completed;
														var smd_status = json_b.smd_completed;
														var lrd_status = json_b.lrd_completed;

														let _html_lrd_badge;
														let _html_smd_badge;
														let _html_pvlmd_badge;

														if(pvlmd_status == 1){
															_html_pvlmd_badge = '<span class="badge badge-success">Approved</span'
														} else {
															_html_pvlmd_badge = '<span class="badge badge-danger">Not Approved</span'
														}

														if(smd_status == 1){
															_html_smd_badge = '<span class="badge badge-success">Approved</span'
														} else {
															_html_smd_badge = '<span class="badge badge-danger">Not Approved</span'
														}

														if(lrd_status == 1){
															_html_lrd_badge = '<span class="badge badge-success">Approved</span'
														} else {
															_html_lrd_badge = '<span class="badge badge-danger">Not Approved</span'
														}

														document.getElementById('_html_pvlmd_badge_ffrv_v').innerHTML = _html_pvlmd_badge;
														document.getElementById('_html_smd_badge_ffrv_v').innerHTML = _html_smd_badge;
														document.getElementById('_html_lrd_badge_ffrv_v').innerHTML = _html_lrd_badge;

														if(pvlmd_status == 1 && smd_status == 1 && lrd_status == 1 ) {
															$('#btn_update_app_status_ffrv').show()
														} else {
															$('#btn_update_app_status_ffrv').hide()
														}

													},
													error : function(request) {
														alert("Request falied");
													}
												});


									})
  
                                    $('#btn_work').on('click', function (e) {

                                        var form = document.getElementById('registration_application_progress_details');

                                        form.submit();
                                    })


                                


$('#frmSaveCollection')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('how are your search');

										var col_job_number = $(
												"#cs_main_job_number").val();
										console.log('Save: ' + col_job_number);

										col_collected_by_id_type = $(
												"#col_id_type").val();
										col_collected_by = $(
												"#col_collected_by").val();
										col_collected_by_id_number = $(
												"#col_id_number").val();
										col_collected_by_phone_number = $(
												"#col_phone_number").val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'load_save_collection_details_by_job_number',
														job_number : col_job_number,
														collected_by_id_type : col_collected_by_id_type,
														collected_by : col_collected_by,
														collected_by_id_number : col_collected_by_id_number,
														collected_by_phone_number : col_collected_by_phone_number
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														// console.log();

														console.log(json_p.msg)
														if (json_p.msg == "SUCCESS") {
															$(
																	"#general_message_dialog")
																	.modal();
															// $('#general_message_dialog
															// #general_message_dialog_msg').val(jobdetails);
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			"Collection details saved successfully");

															// $('#collectionModal').modal('hide');
														}

													}
												});

									});


                                    $("#send_a_message_to_client").on('shown.bs.modal', function() {
		
        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        
        let txt = '<table id="cabinetTable" class="table table-bordered " ><thead ><th>Applicant Name</th><th>Job Number</th><th>Locality</th></thead><tbody>';
        if(checkedList != null){
            for (let i = 0; i < checkedList.length; i++) {
                txt += `<tr><td>${ar_name} </td>`;
                txt += `<td>${job_number} </td>`;
                txt += `<td>${locality}</td>`;
                // txt +=`<td><button class="btn btn-danger remove" onclick="deleteRow(this)" id="${checkedList[i].jn_id}" data-jn_id="${checkedList[i].jn_id}"><i class="fas fa-trash"></i>Remove</button></td></tr>`
            }
            txt += '</tbody></table>';
        } else {
            txt = "<tr>No Data</tr>";
        }

        document.getElementById("cabinet_list").innerHTML = txt;
    })



                                    $('#btn_process_cabinet').on('click',function(){
		
        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        if(checkedList != null){
            
            const json_list = checkedList;
            
            let list_of_application = JSON.stringify(json_list);
            let cabinet_to_send_to = $('#cabinet_to_send_to').val();

            console.log(list_of_application);
            
            //$('#showBatchlist').modal('hide');
            
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_cabinet_completed_searches",
                    list_of_application:list_of_application,
                    cabinet_to_send_to:cabinet_to_send_to
                },
                success:function(response){
                    console.log(response);

                    let json_b = JSON.parse(response)

                    if(json_b.success == true) {

                        $('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Job application(s) have been completed successfully.</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
            })  
        }
        else{
            
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select job application to cabinet.</span>',
            }, { type : 'danger' , z_index: 9999  });
            
        }
        
    })


    $('#btn_load_scanned_documents___').on('click', function(e) { 
	   
	   var table_docs = $('#lc_scanned_documents_dataTable___');
	  table_docs.find("tbody tr").remove(); 	
	  
	  
	  
	   var table_docs_mains = $('#lc_main_scanned_documents_dataTable___');
	   table_docs_mains.find("tbody tr").remove(); 
 
	  var case_number = $("#cs_main_case_number").val();
	  //console.log(case_number);
	  $.ajax({
		   type: "POST",
		   url: "LoadLRDJackets",
		   data: {
				  request_type: 'load_case_scanned_document_new',
				  case_number:case_number},
		   cache: false,
		   beforeSend: function () {
			  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		   },
		   success: function(serviceresponse) {
			  // if(!serviceresponse){
			  // 	return;
			  // }
			  try{
				  var json_p = JSON.parse(serviceresponse);
				  //console.log(json_p)
									  
				  
				   $(json_p).each(function () {
						  
					   table_docs.append("<tr><td>" + this.doc_description + "</td><td>" +this.document_extention + "</td>"
							   +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td>'

									  + "</tr>");

					   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

							  + "</tr>");

				   });

			  }catch(e){
											  console.log(e)
										  }
			  
				
		   }
		   }); 
  //	
  });


  $('#btn_process_completed_app_cabinet').on('click',function(){
		
     
            var cabinet_to_send_to = $('#cabinet_to_send_to').val();
            var job_number = $("#cs_main_job_number").val();

           // console.log(job_number, cabinet_to_send_to);
            //return;

            if(!job_number || !cabinet_to_send_to) {

                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Cabinet name and Job is required.</span>',
                }, { type : 'danger' , z_index: 9999  });

                return;
            }
            
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_cabinet_completed_application",
                    job_number:job_number,
                    cabinet_to_send_to:cabinet_to_send_to
                },
                success:function(response){
                    console.log(response);

                    let json_b = JSON.parse(response)

                    if(json_b.success == true) {

                       // $('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Job application(s) have been completed successfully.</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
            })  
     //   }
        
        
    })

    $("#view_parcel_and_transaction").on('shown.bs.modal', function(e) {

      var bs_desc = $(e.relatedTarget).data("bs-desc");
      //  console.log(bs_desc + 'vhgvgv')
        
        if(bs_desc == 'View and Confirm Parcel and Transaction'){
          $("#btn_confirm_registration_transaction").removeClass('d-none');
        } else {
          $("#btn_confirm_registration_transaction").addClass('d-none');
        }

      })

    
    $('#btn_confirm_registration_transaction').on('click',function(){
		
      
            var case_number = $('#cs_main_case_number').val();
            var job_number = $("#cs_main_job_number").val();
            var transaction_number = $("#cs_main_transaction_number").val();

           // console.log(job_number, cabinet_to_send_to);
           // return;

            if(!job_number) {

                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job is required.</span>',
                }, { type : 'danger' , z_index: 9999  });

                return;
            }
            var confirmText = "Are you sure you want to confirm parcel and transaction?";
            if (confirm(confirmText)) {
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_confirm_registration_transaction",
                    job_number:job_number,
                    case_number:case_number,
                    transaction_number: transaction_number
                },
                success:function(response){
                  //  console.log(response);

                   // let json_b = JSON.parse(response)

                    if(response == 'Application Successfully completed') {

                        //$('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Transaction has been confirmed successfully</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
                
            })  
       }
        
        
    })


    $("#link_to_mother_file").on('shown.bs.modal', function(e) {

      //  var linkedMotherFile = $("#linkedMotherFile").val();
        let htmlLinkedMotherFile;

        var case_number = $("#cs_main_case_number").val();
        var job_number = $("#cs_main_job_number").val();

        $.ajax({
          url:"Case_Management_Serv",
          type:"POST",
          data:{
              request_type:"select_check_if_motherfile_linked",
              job_number:job_number,
              case_number:case_number
          },
          success:function(response){
            console.log(response)
            response = JSON.parse(response);
            if(response.count >= 1) {

              let mother_file_job_number = response.data.mc_job_number

              htmlLinkedMotherFile = '<div class="alert alert-success" role="alert"><i class="fas fa-info-circle mr-2"></i>Mother File [ '+mother_file_job_number+' ] has been linked.</div>';

            $("#lrd_search_for_mother_transction_to_child").prop('disabled', true);
            $("#lrd_btn_search_for_mother_transction_to_child").prop('disabled', true);

            document.getElementById("htmlLinkedMotherFile").innerHTML = htmlLinkedMotherFile;

            } else {
              htmlLinkedMotherFile = '<div class="alert alert-danger" role="alert"><i class="fas fa-info-circle mr-2"></i>Mother File has not been linked yet.</div>';
              $("#lrd_search_for_mother_transction_to_child").prop('disabled', false);
              $("#lrd_btn_search_for_mother_transction_to_child").prop('disabled', false);

              document.getElementById("htmlLinkedMotherFile").innerHTML = htmlLinkedMotherFile;
            }

          }
        })
    })

    $("#compose_certificate").on('shown.bs.modal', function(e) {
        var bs_id = $(e.relatedTarget).data("bs-id");
        var bs_desc = $(e.relatedTarget).data("bs-desc");

        console.log(bs_id)


        if(parseInt(bs_id) == 23 || bs_desc == 'Check Certificate Details' || parseInt(bs_id) == 20){
         
          $("#cert_type_for_reg").removeClass('d-none');
        } else {
          $("#cert_type_for_reg").addClass('d-none');
        }

    })

   

    
    $("#determining_type_of_transfer").on('shown.bs.modal', function(e) {
        var bs_id = $(e.relatedTarget).data("bs-id");
        var bs_desc = $(e.relatedTarget).data("bs-desc");

        console.log(bs_id)

        // if(parseInt(bs_id) == 23 || parseInt(bs_id) == 21 || parseInt(bs_id) == 18 || parseInt(bs_id) == 20){
        //   $("#btn_compose_certificate_template").prop('disabled', true);
          
        // } else {
        //   $("#btn_compose_certificate_template").prop('disabled', false);
        // }

        if(bs_desc == 'Review Type of Transfer' || bs_desc == 'Check Type of Transfer'){
         
          $("#lc_btn_determine_type_of_transfer").addClass('d-none');
        } else {
          $("#lc_btn_determine_type_of_transfer").removeClass('d-none');
        }

    })

    
    $("#enter_encumbrance_transaction_on_mother").on('shown.bs.modal', function(e) {
       var case_number = $("#m_es_case_number").val();
       var job_number = $("#m_es_job_number").val();
       console.log(case_number)

       $.ajax({
          url:"Case_Management_Serv",
          type:"POST",
          data:{
              request_type:"select_linked_motherfile_details",
              job_number:job_number,
              case_number:case_number
          },
          success:function(response){
            console.log(response)

            var json_p = JSON
																.parse(response);

                                $("#newEncumberancesOnMotherModal #m_es_registered_number").val(json_p.data.registered_number);

                               
														var table_bp = $('#lrd_encumberance_details_dataTable');
														table_bp.find(
																"tbody tr")
																.remove();
														$(json_p.encumbrances)
																.each(
																		function() {
																			table_bp
																					.append("<tr><td>"
																							+ this.es_date_of_instrument
																							+ "</td><td>"
																							+ this.es_date_of_registration
																							+ "</td><td>"
																							+ this.es_registered_number
																							+ "</td><td>"
																							+ this.es_memorials
																							+ "</td><td>"
																							+ this.es_remarks
																							+ "</td><td>"
																							+ this.es_entry_number
																							+ "</td>"
																							+ '<td><p data-placement="top" data-toggle="tooltip"  title="Edit"> '
																							+ '<button class="btn btn-secondary btn-icon-split" data-title="Delete"  data-toggle="modal"'
																							+ 'data-target="#newEncumberancesOnMotherModal"'
																							+ '  data-target-id="'
																							+ this.es_id
																							+ '"  data-es_id="'
																							+ this.es_id
																							+ '"  data-es_registered_number="'
																							+ this.es_registered_number
																							+ '"  data-cs_date_of_registration="'
																							+ this.cs_date_of_registration
																							+ '"  data-es_case_number="'
																							+ this.es_case_number
																							+ '"  data-es_date_of_registration="'
																							+ this.es_date_of_registration
																							+ '"  data-es_date_of_instrument="'
																							+ this.es_date_of_instrument
																							+ '"  data-es_memorials="'
																							+ this.es_memorials
																							+ '"  data-es_back="'
																							+ this.es_back
																							+ '" data-es_forward="'
																							+ this.es_forward
                                              + '" data-es_remarks="'
																							+ this.es_remarks
                                              + '" data-es_signature="'
																							+ this.es_signature
																							+ '" data-es_entry_number="'
																							+ this.es_entry_number
																							+ '"> '
																							+ '<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
																							+ "</tr>");
																		});
          }
        })
    })

   
});