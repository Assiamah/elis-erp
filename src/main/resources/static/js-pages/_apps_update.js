$(document).ready(function() {

    var datatable = $("#job_casemgtdetailsdataTable_req")
							.DataTable({
								// responsive: true,

								stateSave : true,
								"createdRow" : function(row, data, dataIndex) {
									if (data[0] == "1") {
										$(row).addClass('tr-completed-work');
									}
								},

							/*
							 * columns: [ { // Responsive control column data:
							 * null, defaultContent: '', className: 'control',
							 * orderable: false },
							 *  ],
							 */});

    $('#btnJobNumberSearch_mm').on('click', function(e){
         	      	  
        // validation code here
           e.preventDefault();
       //console.log('how are your search new');
       
       var job_number = $("#search_job_number").val().toUpperCase();
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                   request_type: 'load_application_details_by_job_number_within_unit',
                   job_number:job_number},
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(jobdetails) {
               
                console.log(jobdetails);
               
                
                   //console.log(result)
                   
               if(jobdetails !=='Error in loading Data'){
                  //console.log("not null")

                var result = JSON.parse(jobdetails);
                  
                   $("job_number_placeholder").append(result.job_detail.job_number);  
                   
                   
                   $("#fe_client_name").val( result.transaction_details.ar_name);
                   $("#bl_ar_name_msu").val( result.transaction_details.ar_name);
                  $("#febusiness_process_sub_name").val(result.job_detail.business_process_sub_name); 
                   $("#bl_business_process_sub_name_msu").val(result.job_detail.business_process_sub_name); 
                      
                      
                  
                 $("#fe_job_number").val(result.job_detail.job_number);
                 $("#bl_job_number_msu").val(result.job_detail.job_number)
                 
                $("#fe_nature_of_instrument").val(result.transaction_details.nature_of_instrument);
                   $("#fe_type_of_interest").val(result.transaction_details.type_of_interest);
                   $("#fe_type_of_use").val(result.transaction_details.type_of_use);
                   $("#fe_consideration_fee").val(result.transaction_details.consideration_fee);
                   //console.log('date: '+result.transaction_details.date_of_document);
                   $("#fe_date_of_document").val(result.transaction_details.date_of_document);
                   $("#fe_commencement_date").val(result.transaction_details.commencement_date);
                     $("#fe_transaction_number").val(result.transaction_details.transaction_number);
              
                   $("#fe_term").val(result.transaction_details.term);
                   $("#fe_renewal_term").val(result.transaction_details.renewal_term);
                   $("#fe_family_name").val(result.transaction_details.stool_family_name);
                   $("#fe_grantor_family").val(result.transaction_details.family_of_grantor);
                   $("#fe_annual_rent").val(result.transaction_details.annual_rent);
                    $("#fe_file_number").val(result.transaction_details.case_file_number);
                  
               
                   
                 
                   $("#fe_surveyor_number").val(result.parcel_details.licensed_no);
                   $("#fe_regional_number").val(result.parcel_details.regional_number);
                   $("#fe_land_size").val(result.parcel_details.land_size);
                   $("#fe_case_number").val(result.transaction_details.case_number);
                   $("#fe_locality").val(result.parcel_details.locality);
                   $("#fe_district").val(result.parcel_details.district);
                   $("#fe_region").val(result.parcel_details.region);
                   $("#fe_extent").val(result.parcel_details.extent);
               $("#fe_registry_mapref").val(result.parcel_details.registry_mapref);

                   
                     $("#main_service_id_fe").val(result.job_detail.business_process_id); 
                     $("#main_service_sub_id_fe").val(result.job_detail.business_process_sub_id); 
                     
  
                  
                  // var fe_case_number_new= result.transaction_details.transaction_number;
                  var business_process_id = result.job_detail.business_process_id;
                  var business_process_sub_id = result.job_detail.business_process_sub_id;
                   
                   //console.log("case is " + fe_case_number_new);
                  
                //   $.ajax({
                //    type: "POST",
                //    url: "Case_Management_Serv",
                //    data: {
                //           request_type: 'select_get_parties_by_case',
                //           case_number: fe_case_number_new},
                //    cache: false,
                //    beforeSend: function () {
                //       // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                //    },
                //    success: function(jobdetails) {
                      
                //        //console.log("details: " + jobdetails);
                //       if(jobdetails.includes("Data Not Received")){
                //           //console.log("not ");
                //       }else{
                          
                      
                //        var result = JSON.parse(jobdetails);
                       
                //        var table = $('#party_details_datatable');
                //         table.find("tbody tr").remove();
                    
                //         //console.log(jobdetails);
                //         var json_p = JSON.parse(jobdetails);
                        
                //         $(json_p).each(function () {
                               
                //                //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');
                //               //<td>" + this.ar_client_id + "</td>
                                  
                //                     table.append("<tr><td>" +this.ar_name + "</td><td>" +this.ar_gender + "</td><td>" +this.ar_cell_phone + "</td><td>" +this.type_of_party + "</td>"
                                            
                                            
                                                 
                //                           +  '<td><p data-placement="top"  title="Edit Party"> ' 
                //                           +'<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"'
                //                           +'data-target="#addeditpartyGeneral"' 
                //                           +' data-target-id="' + this.ar_client_id 
                //                           +'"  data-ar_name="' + this.ar_name 
                //                           +'"  data-ar_gender="' + this.ar_gender 
                //                          +'"  data-ar_address="' + this.ar_address
                //                           +'"  data-ar_cell_phone="' + this.ar_cell_phone 
                //                           +'" data-ar_cell_phone2="' + this.ar_cell_phone2
                //                           +'" data-ar_tin_no="' + this.ar_tin_no 
                //                           +'" data-ar_id_type="' + this.ar_id_type 
                //                           +'" data-ar_id_number="' + this.ar_id_number
                //                           +'" data-ar_location="' + this.ar_location 
                //                           +'" data-ar_district="' + this.ar_district 
                //                           +'" data-type_of_party="' + this.type_of_party
                //                           +'" data-ar_region="' + this.ar_region
                //                           +'" data-ar_person_type="' + this.ar_person_type
                //                           + '"> ' 
                //                           +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
                                           
                //              + "</tr>");
                                    
                //               });
                          
                    

                //    }}
                //    });
                  
                  
                  //$('#btn_Update_existing_milestone').trigger('click');
                  //$('#applicationStatusupdate').modal('show');

                  $
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_tracking_milestones',
														main_service_id : business_process_id,
														sub_service_id : business_process_sub_id
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

														var table = $('#tbl_list_of_milestone_stone_dataTable');
														table.find("tbody tr")
																.remove();

														//console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$(json_p.data)
																.each(
																		function() {

																			/*
																			 * console
																			 * .log(new_priority_value);
																			 */

																			table
																					.append("<tr id='row' class='bg-success text-white red-tooltip' title='Aplication Stage Completed'  data-toggle='tooltip' data-placement='left'} ><td>"
																							+ this.milestone_description
																							+ "</td><td>"
																							+ this.priority_value
																							+ "</td><td><input type='radio' name='selectmiletonestagerb' value='"
																							+ this.priority_value
																							+ "' />"
																							+ "</td>"

																							+ "</tr>");

																		});

													}
												});


                                                $('.mile_stone_details').show();
                  
                  
              }else{
                $('.mile_stone_details').hide();
                  
                  $.notify({
                      message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
                  }, {
                      type: 'danger'
                  });
                  
              }

            }
            }); 
   });

   

   $('#btn_update_milestone_status_for_application_mm')
							.on(
									'click',
									function(e) {

										var application_stage = $(
												'input:radio[name="selectmiletonestagerb"]:checked')
												.val()

										// alert(milestone_stage); // output 10

										var job_number = $("#bl_job_number_msu")
												.val();

										var userid = $("#up_userid").val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'select_update_application_stage_for_a_job',
														job_number : job_number,
														application_stage : application_stage,

													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',

													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														//console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														//alert(jobdetails);

														// $(
														// 		'#applicationStatusupdate')
														// 		.modal('hide');
                                                        var json_b = JSON.parse(jobdetails);
                                                        if(json_b.success == true) {
                                                            $.notify({
                                                                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Milestone has been updated successfully.</span>',
                                                            }, { type : 'success', z_index : 9999 });
                                                        }

													}
												});

									});


                                    
                                    $('#btn_load_app_details_req')
							.on(
									'click',
									function(e) {

										// alert(milestone_stage); // output 10

										var job_number = $("#req_job_number")
												.val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'select_load_app_details_for_request',
														job_number : job_number,

													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',

													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

                                                                console.log(jobdetails)

                                                            var json_b = JSON.parse(jobdetails);

                                                        if(json_b.success == true) {


                                                            $("#req_app_name").val(json_b.data.ar_name);
                                                            $("#req_to").val(json_b.data.job_recieved_by);
                                                            $("#req_to_id").val(json_b.data.job_recieved_by_id);

                                                        } else {
                                                            $.notify({
                                                                message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
                                                            }, {
                                                                type: 'danger'
                                                            });

                                                            alert('Job number not Found')

                                                            return;
                                                        }

                                                        

													}
												});

									});


                                    $('#btn_make_request').on('click', function(e){
                                        
                                        var job_number = $('#req_job_number').val();
                                        var req_to = $('#req_to').val();
                                        var req_to_id = $('#req_to_id').val();
                                        var req_note = $('#req_note').val();

                                        if(!job_number||!req_to||!req_to_id||!req_note) {
                                            alert('Please fill all the fields.')
                                            return;
                                        }

                                        var confirmText = 'Are you sure you want to make a request?'

                                        if(confirm(confirmText)) {

                                       
                                        $
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													// target:'_blank',

													data : {
														request_type : 'select_send_request_for_app',
														job_number : job_number,
                                                        req_to : req_to,
                                                        req_note : req_note,
                                                        req_to_id : req_to_id
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',

													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

                                                                if(jobdetails == ''){
                                                                    return;
                                                                }

                                                            var json_b = JSON.parse(jobdetails);

                                                        if(json_b.success == true) {

                                                            $('#make_app_request_modal').modal('hide');

                                                            $.notify({
                                                                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request sent successfully.</span>',
                                                            }, { type : 'success', z_index : 9999 });

                                                        } else {
                                                            $.notify({
                                                                message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error! Something bad happened.</span>',
                                                            }, {
                                                                type: 'danger'
                                                            });

                                                            alert('Error! Something bad happened.')

                                                            return;
                                                        }

                                                        

													}
												});

                                            }
                                    });

                                    $('.btnLoadRequest').on('click', function(e) {

                                        var inbox_type = $(this).data('id');

                                        datatable.state.clear();

                                        $.ajax({
                                            type : "POST",
                                            url : "Case_Management_Serv",
                                            data : {
                                                request_type : 'load_request_apps_at_unit_by_inbox_type',
                                                inbox_type : inbox_type,
                                            },

                                            success : function(
                                                    jobdetails) {
                                                
                                                console.log(jobdetails)
                                               

                                                    var json_p = JSON
                                                    .parse(jobdetails);
                                              


                                                datatable.search("")
                                                        .draw();
                                                datatable.state.clear();
                                                datatable.clear();

                                                $("#body-bg-1")
                                                        .removeClass(
                                                                'bg-dark');
                                                $("#incoming_count")
                                                        .removeClass(
                                                                'text-white');
                                                $("#incoming_count")
                                                        .addClass(
                                                                'text-gray-800');
                                                $("#body-bg-2")
                                                        .removeClass(
                                                                'bg-dark');
                                                $("#outgoing_count")
                                                        .removeClass(
                                                                'text-white');
                                                $("#outgoing_count")
                                                        .addClass(
                                                                'text-gray-800');

                                                $(json_p.data)
                                                        .each(
                                                                function() {

                                                                    datatable.row
                                                                            .add([
                                                                                '<input type="checkbox" />',
                                                                                this.created_on,
                                                                                this.job_number,
                                                                                this.req_from,
                                                                                this.req_to,
                                                                                this.req_status == 'pending' ? '<div class="text-center"><span class="badge badge-warning">Pending</span></div>' : this.req_status == 'approved' ? '<div class="text-center"><span class="badge badge-success">Approved</span></div>' : '<div class="text-center"><span class="badge badge-danger">Declined</span></div>',
                                                                                inbox_type == 1 ?
                                                                               ' <form action="app_request_details" method="post">'
                                                                                  + ' <input type="hidden" name="req_id" value="'+this.req_id+'">'
                                                                                  + ' <input type="hidden"  name="request_type" value="load_app_request_details">'
                                                                                  + '<div class="text-end">'
                                                                                   +     '<button type="submit" class=" btn btn-primary btn-sm w-100" href="#">View Details</button>'
                                                                                  + '</div>'
                                                                              +'  </form> '
                                                                                :
                                                                                '<button type="button" class=" btn btn-primary btn-sm w-100" data-toggle="modal" data-target="#view_response_details_modal" data-req_id="'+this.req_id+'" data-job_number="'+this.job_number+'" data-accepted_by="'+this.accepted_by+'" data-req_status="'+this.req_status+'" data-response_note="'+this.response_note+'" data-accepted_on="'+this.accepted_on+'">View Details</button>'
                                                                                    ])
                                                                            .draw(
                                                                                    false);
                                                                   

                                                                });

                                                switch (inbox_type) {
                                                case 1:

                                                    $(".btn-to-be-disabled").prop('disabled',true);
                                                    //datatable.column(11).visible(true);

                                                    $("#body-bg-1")
                                                            .addClass(
                                                                    'bg-dark');
                                                    $("#incoming_count")
                                                            .removeClass(
                                                                    'text-gray-800');
                                                    $("#incoming_count")
                                                            .addClass(
                                                                    'text-white');

                                                    break;
                                                case 2:

                                                    $(
                                                            ".btn-to-be-disabled")
                                                            .prop(
                                                                    'disabled',
                                                                    false);

                                                    $("#body-bg-2")
                                                            .addClass(
                                                                    'bg-dark');
                                                    $("#outgoing_count")
                                                            .removeClass(
                                                                    'text-gray-800');
                                                    $("#outgoing_count")
                                                            .addClass(
                                                                    'text-white');
                                                   // datatable.column(11).visible(true);

                                                    break;
                                                default:
                                                    // code block
                                                }

                                            }

                                        });
                                    })



                    $('#btn_respond_app_request').on('click', function(e) {
                        e.preventDefault();

                       var res_type = $("#res_type").val();
                       var res_id = $("#res_id").val();
                       var res_job_number = $("#res_job_number").val();
                       var req_response_note = $("#req_response_note").val();

                       if(!res_type || !res_id || !res_job_number || !req_response_note) {
                       // alert('Please fill all the fields');
                        $.notify({
                            message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please fill all the fields.</span>',
                        }, {
                            type: 'danger'
                        });
                        return;
                       }

                       var confirmText = 'Are you sure you want to respond to the request?';

                       if(confirm(confirmText)){
                       $
                       .ajax({
                           type : "POST",
                           url : "Case_Management_Serv",
                           // target:'_blank',

                           data : {
                               request_type : 'select_respond_to_app_request',
                               job_number : res_job_number,
                               response_type : res_type,
                               resquest_id : res_id,
                               response_note : req_response_note

                           },
                           cache : false,
                           // responseType:
                           // 'arraybuffer',
                           // dataType:'blob',

                           beforeSend : function() {
                               // $('#district').html('<img
                               // src="img/loading.gif"
                               // alt="" width="24"
                               // height="24">');
                           },
                           success : function(
                                   jobdetails) {

                                       console.log(jobdetails)

                                   var json_b = JSON.parse(jobdetails);

                               if(json_b.success == true) {


                                //    $("#req_app_name").val(json_b.data.ar_name);
                                //    $("#req_to").val(json_b.data.job_recieved_by);
                                //    $("#req_to_id").val(json_b.data.job_recieved_by_id);

                                if(json_b.response == 'approved') {

                                $.notify({
                                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request approved successfully.</span>',
                                }, { type : 'success', z_index : 9999 });

                                setTimeout(function(){ location.reload(); }, 2000);

                            } else {
                                $.notify({
                                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request declined successfully.</span>',
                                }, { type : 'success', z_index : 9999 });

                                setTimeout(function(){ location.reload(); }, 2000);
                            }

                               } else {
                                   $.notify({
                                       message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error! Something went wrong. </span>',
                                   }, {
                                       type: 'danger'
                                   });

                                   //alert('Job number not Found')

                                   return;
                               }

                               

                           }
                       });
                    }

                    })

                    $('#view_response_details_modal').on('shown.bs.modal', function(e){

                        // var inbox_type = $(this).data('req_id');
                        // console.log(inbox_type)

                        $("#re_job_number").val($(e.relatedTarget).data('job_number')); 
		               		$("#re_accepted_by").val($(e.relatedTarget).data('accepted_by')); 
		               		$("#re_status").val($(e.relatedTarget).data('req_status'));
		               		$("#res_note").val($(e.relatedTarget).data('response_note'));
		               		$("#res_accepted_on").val($(e.relatedTarget).data('accepted_on'));
                    })


                    $('#frmEnquiryJobSearch')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										 //console.log('how are your search');

                                        
										var enq_search_type = "";
										var selected_rbtn = $("input[name='rbtn_search_type']:checked");
										if (selected_rbtn.length > 0) {
											enq_search_type = selected_rbtn.val();
											//console.log("selected " + enq_search_type);
										}
										
										
										var enq_search_value = $("#enq_search_value").val();
										//console.log('Search Value: ' + enq_search_value);

										if (enq_search_value.length < 4) {
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
											}, { type : 'danger' , z_index: 9999  });
											
										} else if (enq_search_type.length <= 0){
											$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
											}, { type : 'danger' , z_index: 9999  });
											
										}else {

											//$("#enq-search-results-section").hide();

											$.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_for_enquiries',
															job_number : enq_search_value,
															search_type: enq_search_type
														},
														cache : false,
														
														success: function(jobdetails) {
                                                            if (!jobdetails) {
                                                                $.notify({
                                                                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found!</span>',
                                                                }, { type: 'danger', z_index: 9999 });
                                                                //$('#enquiry_alert').removeClass('d-none');
                                                                return;
                                                            }

                                                            $("#enq-search-results-section").show();

                                                            var table = $('#tbl-appData_tranfer');

                                                            if (jobdetails.includes('no search type')) {
                                                                alert('Reference Number has not been acknowledged or does not exist');
                                                                return false;
                                                            } else {
                                                                var json_p = JSON.parse(jobdetails);

                                                                $(json_p).each(function() {
                                                                    var jobNumber = this.job_number;

                                                                    // Check if this job number already exists
                                                                    var alreadyExists = false;
                                                                    table.find('tbody tr').each(function() {
                                                                        var existingJobNumber = $(this).find('td').eq(2).text().trim(); // index 2 = job number column
                                                                        if (existingJobNumber === jobNumber) {
                                                                            alreadyExists = true;
                                                                            return false; // break loop
                                                                        }
                                                                    });

                                                                    if (alreadyExists) {
                                                                        $.notify({
                                                                            message: '<i class="fa fa-info-circle fa-3x fa-fw"></i><span class="text-bold">Job number ' + jobNumber + ' is already in the table and will not be added again.</span>',
                                                                        }, { type: 'info', z_index: 9999 });
                                                                        return; // Skip
                                                                    }

                                                                    // Add row with remove button
                                                                    var newRow = $("<tr>" +
                                                                        "<td>" + this.ar_name + "</td>" +
                                                                        "<td>" + this.case_number + "</td>" +
                                                                        "<td>" + this.job_number + "</td>" +
                                                                        "<td>" + this.business_process_sub_name + "</td>" +
                                                                        "<td>" + this.locality + "</td>" +
                                                                        "<td>" + this.regional_number + "</td>" +
                                                                        "<td><button type='button' class='btn btn-warning btn-sm remove-row-btn'>Remove</button></td>" +
                                                                    "</tr>");

                                                                    table.find('tbody').append(newRow);
                                                                });

                                                                // Attach event to remove buttons
                                                                table.find('.remove-row-btn').off('click').on('click', function() {
                                                                    $(this).closest('tr').remove();
                                                                });
                                                            }
                                                        }
													});
										}
                                         
									});

                                    $("#btn-remove-all").on('click', function() {
                                        var table = $('#tbl-appData_tranfer');
                                        var confirmed = confirm("Are you sure you want to remove all rows?");
                                        if (confirmed) {
                                            table.find('tbody').empty();
                                        }
                                    });

});