$(document)
		.ready(
				function() {

                    var coor_tbl = $("#job_casemgtdetailsdataTable").DataTable({
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
                     */
                    });
					
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

											$("#enq-search-results-section").hide();

											$.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_for_enquiries',
															job_number : enq_search_value,
															search_type: enq_search_type
														},
														cache : false,
														
														success : function(
																jobdetails) {

															console.log(jobdetails);

                                                             if(jobdetails == ''){
                                                                
                                                                $.notify({
                                                                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found! </span>',
                                                                }, { type : 'danger' , z_index: 9999  });

                                                             } else {

                                                                $(
																	"#enq-search-results-section")
																	.show();

															 var table = $('#transactional-plotting-table');
															// table.find(
															// 		"tbody tr")
															// 		.remove();
															if(jobdetails
																	.includes('no search type')) {
																alert('Reference Number has not been acknowleged or does not exist')
																return false;
															}else{
																
															
															
															var json_p = JSON
																	.parse(jobdetails);


                                                            var job_number = json_p[0].job_number;
                                                            localStorage.setItem('job_number', job_number);

															$(json_p)
																	.each(
																			function() {
																				// console.log(this.job_number);
																				table
																						.append("<tr><td>"
																								+ this.ar_name
																								+ "</td><td>"
																								+ this.case_number
																								+ "</td><td>"
																								+ this.job_number
																								+ "</td><td>"
																								// + this.glpin
																								// + "</td><td>"
																								+ this.locality
																								+ "</td><td>"
																								+ (this.current_application_status == null ? `` : this.current_application_status)
                                                                                                + "</td>"
                                                                                                +"<td><form action='further_entries' method='post'>"
                                                                                                +"<input type='hidden' name='transaction_number'  value='" + this.transaction_number +"'>"
                                                                                                +'<input type="hidden" name="job_number"  value="' + this.job_number +'">'
                                                                                                +'<input  name="case_number" type="hidden" value="' + this.case_number +'">'
                                                                                                +'<input type="hidden" name="business_process_sub_name" value="' + this.business_process_sub_name +'">'
                                                                                                +'<button type="submit" name="save" class="btn btn-danger btn-icon-split" >'
                                                                                                +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span><span class="text">Entries</span></button></form></td><td>'
                                                                                                + "<div class='text-center'>"
                                                                                                // + "<span>Add To List</span><br>"
																								+ "<input class='form-check-input checked' type='checkbox' id='' data-jn_id='"+this.jn_id+"' data-ar_name='"+this.ar_name+"' data-case_number='"+this.case_number+"' data-job_number='"+this.job_number+"' data-locality='"+this.locality+"'>"
																								+ "</div>"
																								+ "</td>"

																								+ '</tr>');

																			});



                                                           //const job_number_length =  $('#cabinet-completed-searches-table').DataTable().search(job_number).row({search: 'applied'}).data();
                                                           

                                                            // var count = $('#cabinet-completed-searches-table').DataTable()
                                                            //             .column( 0 ) 
                                                            //             .data()
                                                            //             .filter( function (value, index) {
                                                            //                 return value = job_number;
                                                            //             }).length;

                                                            //              console.log(count);

															}
                                                             }
															

														}
													});
										}
									});

                                    $('#publicFileUploadModal').on('show.bs.modal', function(event) {
                                        $('#publicFileUploadModal #public_file_upload_case_number').val($(event.relatedTarget).data('br_case_number'));
                                    })

									$('#publicViewFileModal').on('show.bs.modal', function(event) {
                                        $('#publicViewFileModal #cs_main_case_number').val($(event.relatedTarget).data('br_case_number'));
                                    })

				
									function storeTblValues() {
										var TableData = new Array();

										$('#tbl-bulk-receiving-table tr')
												.each(
														function(row, tr) {
															TableData[row] = {
																"ar_name" : $(
																		tr)
																		.find(
																				'td:eq(0)')
																		.text()
																		.trim(),
																"job_number" : $(
																		tr)
																		.find(
																				'td:eq(2)')
																		.text()
																		.trim(),
															
															}
														});
										TableData.shift(); // first row
										// will be empty
										// - so remove
										return TableData;
									}

					
                                    // $('#btnBatchBulkReceiving').on('click', function(e) {

									// 	var job_purpose =$("#txt_general_job_purpose").val();
									// 	var bcd_depositor_by =$("#bcd_depositor_by").val();
									// 	var bcd_depositor_id_type =$("#bcd_depositor_id_type").val();
                                    //     var bcd_depositor_id_number =$("#bcd_depositor_id_number").val();
									// 	var bcd_depositor_phone_number =$("#bcd_depositor_phone_number").val();
									// 	var bcd_depositor_email =$("#bcd_depositor_email").val();
									// 	var bcd_submission_type =$("#bcd_submission_type").val();

                                    //             if(!bcd_depositor_by || !bcd_depositor_id_type || !bcd_depositor_id_number || !bcd_depositor_phone_number || !bcd_depositor_email || !bcd_submission_type){
													
									// 				$.notify({
									// 					message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
									// 				}, {
									// 					type: 'danger'
									// 				});

                                    //             }else{
                                                    
									// 			  var confirmText = "Are you sure you want to add these application to the list?";
                                    //               if(confirm(confirmText)) {
									// 					var table1 = document.getElementById("tbl-bulk-receiving-table")
									// 					var tr = $('#tbl-bulk-receiving-table tbody tr')

                                    //                  // $("#tbl-bulk-receiving-table tbody tr").each(function () {
									// 					for(var i = 0; i < tr.length; i++) {
                                    //                      // var row = $(this).closest("tr")[0];
									// 					  //console.log(row)
                                    //                       var job_number = table1.rows[i+1].cells[2].innerHTML;
                                    //                          var ar_name =  table1.rows[i+1].cells[0].innerHTML;
                                    //                          var business_process_sub_name = "";

                                    //                          addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose);
                                                             
                                    //                         //console.log("testing click " + business_process_sub_name);
                                    //                   };
                                                      
                                                      
                                    //                  prepareBatchlistModal();
                                    //                 }
                                    //             }
                                                
                                    //      }); 
					// ------ end of $(doc).ready


                    $("#btnViewCabinetlist").on('click',function(e){
                        e.preventDefault();
                        let checkedList=[];
                        let checkBoxes = document.getElementsByClassName('checked');
                        
                        for(let i=0; i<checkBoxes.length;i++){
                            if(checkBoxes[i].checked){
                                const checkedValue ={
                                                    "jn_id": checkBoxes[i].getAttribute('data-jn_id'),
                                                    "ar_name": checkBoxes[i].getAttribute('data-ar_name'),
                                                     "case_number":checkBoxes[i].getAttribute('data-case_number'),
                                                     "job_number":checkBoxes[i].getAttribute('data-job_number'),
                                                     "locality":checkBoxes[i].getAttribute('data-locality')};
                                checkedList.push(checkedValue);
                            }
                        }
                        
                        let dataSelected=[];
                        
                        console.log(checkedList);
                        
                        if(checkedList.length === 0){
                            $.notify({
                                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select job application to cabinet.</span>',
                            }, { type : 'danger' , z_index: 9999  });
                        }
                        else{
                            
                            
                            const json_list ={"list":checkedList};
                            
                            let list = JSON.stringify(json_list);
                            console.log(list);
                            
                            localStorage.removeItem("checkedList");
                            localStorage.setItem('checkedList', JSON.stringify(checkedList));
                            
                            $('#showCabinetlist').modal('show');
                            
                        }

                        $.ajax({
                            type: "POST",
                            url: "app_modal_fills_serv",
                            data: {
                                   request_type: 'tags_for_batching_jobs_list'},
                            cache: false,
                            beforeSend: function () {
                               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                            },
                            success: function(jobdetails) {
                               
                                
                                   console.log(jobdetails);
                                   var json_p = JSON.parse(jobdetails);
                                   var options = $("#bl_job_purpose_new");
       
                                  // var options = $("#selector");
                                   options.empty();
                                   options.append(new Option("-- Select --", 0));
                                
                                   $(json_p).each(function () {
                                     
                                   //	console.log(select_id);
                                  //	console.log(this.business_process_id);
                                     
                                 //   if (main_service_id ==this.business_process_id){
                                         $('#bl_job_purpose_new').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');
                                            
                                 //  }
                                     
                                   
                                      });  
                            }
                            });
                        
                        
                    })


                    $("#showCabinetlist").on('shown.bs.modal', function() {
		
                        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
                        
                        let txt = '<table id="cabinetTable" class="table table-bordered " ><thead ><th>Applicant Name</th><th>Job Number</th><th>Locality</th><th>Action</th></thead><tbody>';
                        if(checkedList != null){
                            for (let i = 0; i < checkedList.length; i++) {
                                txt += '<tr><td>' + checkedList[i].ar_name + '</td>';
                                txt += '<td>' + checkedList[i].job_number + '</td>';
                                txt += '<td>' + checkedList[i].locality + '</td>';
                                txt +=`<td><button class="btn btn-danger remove" onclick="deleteRow(this)" id="${checkedList[i].jn_id}" data-jn_id="${checkedList[i].jn_id}"><i class="fas fa-trash"></i></button></td></tr>`
                            }
                            txt += '</tbody></table>';
                        } else {
                            txt = "<tr>No Data</tr>";
                        }
                
                        document.getElementById("approval_list").innerHTML = txt;
                        })
                        
                        
                        
                    // Remove from batchlist
                     $('.remove').on('click', function(e) {
                         //e.prevent
                        alert("hello");
                    
                                //let id = $(this).prop('id');
                                let jn_id=$(this).attr('data-jn_id');
                                
                                let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
                               
                               for(let i=0;i<checkedList.length;i++){
                                    if(checkedList[i].jn_id = jn_id){
                                        checkedList.splice(i, 1);
                                    }
                                }
                              
                            localStorage.removeItem("checkedList");
                            localStorage.setItem('checkedList', JSON.stringify(checkedList));
                            
                            checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
                        
                            let txt = '<table id="cabinetTable" class="table " ><thead ><th>Suit Number</th><th>Court Process</th><th>Nature of Case</th><th>Action</th></thead><tbody>';
                            if(checkedList != null){
                                for (let i = 0; i < checkedList.length; i++) {
                                    txt += '<tr><td>' + checkedList[i].ar_name + '</td>';
                                    txt += '<td>' + checkedList[i].job_number + '</td>';
                                    txt += '<td>' + checkedList[i].locality + '</td>';
                                    txt +='<td><button class="btn btn-danger remove" data-jn_id="'+checkedList[i].jn_id+'"><i class="fas fa-trash"></i></button></td></tr>'
                                }
                                txt += '</tbody></table';
                            } else {
                                txt = "<tr>No Data</tr>";
                            }
                    
                            document.getElementById("approval_list").innerHTML = txt;
                        
                        
                        
                     })



                     $('#btn_process_batchlist_tt').on('click',function(){
		
                        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
                        if(checkedList != null){
                            
                            const json_list = checkedList;
                            
                            let list_of_application = JSON.stringify(json_list);
                            //let cabinet_to_send_to = $('#cabinet_to_send_to').val();

                            console.log(list_of_application);
                            
                            //$('#showBatchlist').modal('hide');

                            if ($('#batch_type').val() === 'Unit') {

                                //request_type = 'process_batch_list_unit';
                                var userid_1 = $("#unit_to_send_to")
                                        .val(); // $(
                                // "#user_to_send_to
                                // option:selected"
                                // ).text();
                                var send_to_id = $(
                                        '#listofunitsbatching option')
                                        .filter(
                                                function() {
                                                    return this.value == userid_1;
                                                }).data('id');
                                var send_to_name = $(
                                        '#listofunitsbatching option')
                                        .filter(
                                                function() {
                                                    return this.value == userid_1;
                                                }).data('name');

                            } else {
                                request_type = 'process_batch_list_new';
                                var userid_1 = $("#user_to_send_to")
                                        .val(); // $(
                                // "#user_to_send_to
                                // option:selected"
                                // ).text();
                                var send_to_id = $(
                                        '#listofusersbatching option')
                                        .filter(
                                                function() {
                                                    return this.value == userid_1;
                                                }).data('id');
                                var send_to_name = $(
                                        '#listofusersbatching option')
                                        .filter(
                                                function() {
                                                    return this.value == userid_1;
                                                }).data('name');

                            }
                            
                            
                            $.ajax({
                                url:"Case_Management_Serv",
                                type:"POST",
                                data:{
                                    request_type:"select_applications_for_transitional_plotting",
                                    list_of_application:list_of_application,
                                    //cabinet_to_send_to:cabinet_to_send_to
                                    send_to_id: send_to_id,
                                    send_to_name: send_to_name
                                },
                                success:function(response){
                                    console.log(response);

                                    let json_b = JSON.parse(response)

                                    if(json_b.success == true) {

                                        $('#showCabinetlist').modal('hide');

                                        $.notify({
                                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Transaction Approval(s) have been reversed successfully.</span>',
                                        }, { type : 'success', z_index : 9999 });
                    
                                        // setTimeout(function(){
                                        //     location.reload();
                                        // },1000); 
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
                                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select job application.</span>',
                            }, { type : 'danger' , z_index: 9999  });
                            
                        }
                        
                    })


                    $("#general_message_dialog").on('hidden.bs.modal', function() { 

                        console.log("okkkkk")

                        var plotting_page_name = $("#plotting_page_name").val();

                        if(plotting_page_name == "coordinate_entry_and_record_verification") {

                            window.location.replace("/coordinate_entry_and_record_verification");

                        } else if(plotting_page_name == "plot_vetting_and_approval"){

                            window.location.replace("/plot_vetting_and_approval");
                        }
                      });


                    $(".btnLoadIncomingApplications").on('click', function(e) {

                        document.getElementById("th_id").innerHTML = 'Sent By';

                        $.ajax({

                            type : "POST",
                                url : "Case_Management_Serv",
                                data : {
                                    request_type : 'load_incoming_application_for_transitional_plotting',
                                    // job_number : enq_search_value,
                                    // search_type: enq_search_type
                                },
                                cache : false,
                                success : function(jobdetails) {

                                    var json_p = JSON.parse(jobdetails);

                                    coor_tbl.search("")
                                            .draw();
                                    coor_tbl.state.clear();
                                    coor_tbl.clear();
                                    
                                    $(json_p.data)
                                        .each(
                                                function() {

                                                    coor_tbl.row
                                                            .add([

                                                                //this.job_worked_on_status,

                                                                '<input type="checkbox"/>',
                                                                this.created_date,
                                                                this.job_number,
                                                                this.ar_name,
                                                                this.business_process_sub_name,
                                                                this.current_application_status,
                                                                this.job_forwarded_by,
                                                                this.plot_location,
                                                                //this.smd_type_of_plotting,

                                                                '<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
                                                                        + this.job_number
                                                                        + '" data-job_number="'
                                                                        + this.job_number
                                                                        + '" data-ar_name="'
                                                                        + this.ar_name
                                                                        + '" data-business_process_sub_name="'
                                                                        + this.business_process_sub_name
                                                                        + '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
                                                                        + ' <span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Add to Batch</span>'
                                                                        + ' </button>',

                                                                '<form action="front_office_view_application" method="post">'
                                                                        + '<input type="hidden" name="case_number" id="case_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="search_text" id="search_text" value="'
                                                                        + this.case_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="job_number" id="job_number" value="'
                                                                        + this.job_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
                                                                        + this.business_process_sub_name
                                                                        + '">'

                                                                        + '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'

                                                                        + '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
                                                                        + '	</button></form>',

                                                                        '<form action="map_plotting_application_progress_details" method="post">'
                                                                        + '<input type="hidden" name="case_number" id="case_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="transaction_number" id="transaction_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="job_number" id="job_number" value="'
                                                                        + this.job_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
                                                                        + this.business_process_sub_name
                                                                        + '">'

                                                                        + '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

                                                                        + '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
                                                                        + '	</button></form>'

                                                                    ])
                                                            .draw(
                                                                    false);
                                                    coor_tbl
                                                            .column(
                                                                    2)
                                                            .data()
                                                            .sort();

                                                });
                                }
                        })

                        $("#body-dg-1").addClass('bg-active');
			            $("#body-dg-2, #body-dg-3").removeClass('bg-active');
                        $("#number-text-1").removeClass('text-gray-800');
                        $("#number-text-1").addClass('text-white');
					    $("#number-text-2, #number-text-3").addClass('text-gray-800');

                    })


                    $(".btnLoadUnitPendingApplications").on('click', function(e) {

                        document.getElementById("th_id").innerHTML = 'Sent To';

                        $.ajax({

                            type : "POST",
                                url : "Case_Management_Serv",
                                data : {
                                    request_type : 'load_pending_application_for_transitional_plotting',
                                    // job_number : enq_search_value,
                                    // search_type: enq_search_type
                                },
                                cache : false,
                                success : function(jobdetails) {

                                    var json_p = JSON.parse(jobdetails);

                                    coor_tbl.search("")
                                            .draw();
                                    coor_tbl.state.clear();
                                    coor_tbl.clear();
                                    
                                    $(json_p.data)
                                        .each(
                                                function() {

                                                    coor_tbl.row
                                                            .add([

                                                                //this.job_worked_on_status,

                                                                '<input type="checkbox"/>',
                                                                this.created_date,
                                                                this.job_number,
                                                                this.ar_name,
                                                                this.business_process_sub_name,
                                                                this.current_application_status,
                                                                this.job_recieved_by,
                                                                this.plot_location,
                                                                //this.smd_type_of_plotting,

                                                                '<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
                                                                        + this.job_number
                                                                        + '" data-job_number="'
                                                                        + this.job_number
                                                                        + '" data-ar_name="'
                                                                        + this.ar_name
                                                                        + '" data-business_process_sub_name="'
                                                                        + this.business_process_sub_name
                                                                        + '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
                                                                        + ' <span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Add to Batch</span>'
                                                                        + ' </button>',

                                                                '<form action="front_office_view_application" method="post">'
                                                                        + '<input type="hidden" name="case_number" id="case_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="search_text" id="search_text" value="'
                                                                        + this.case_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="job_number" id="job_number" value="'
                                                                        + this.job_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
                                                                        + this.business_process_sub_name
                                                                        + '">'

                                                                        + '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'

                                                                        + '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
                                                                        + '	</button></form>',

                                                                        '<form action="map_plotting_application_progress_details" method="post">'
                                                                        + '<input type="hidden" name="case_number" id="case_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="transaction_number" id="transaction_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="job_number" id="job_number" value="'
                                                                        + this.job_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
                                                                        + this.business_process_sub_name
                                                                        + '">'

                                                                        + '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

                                                                        + '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
                                                                        + '	</button></form>'

                                                                    ])
                                                            .draw(
                                                                    false);
                                                    coor_tbl
                                                            .column(
                                                                    2)
                                                            .data()
                                                            .sort();

                                                });
                                }
                        })

                        $("#body-dg-2").addClass('bg-active');
			            $("#body-dg-1, #body-dg-3").removeClass('bg-active');
                        $("#number-text-2").removeClass('text-gray-800');
                        $("#number-text-2").addClass('text-white');
					    $("#number-text-1, #number-text-3").addClass('text-gray-800');

                    })



                    $(".btnLoadUnitCompletedApplications").on('click', function(e) {

                        document.getElementById("th_id").innerHTML = 'Sent To';

                        $.ajax({

                            type : "POST",
                                url : "Case_Management_Serv",
                                data : {
                                    request_type : 'load_completed_application_for_transitional_plotting',
                                    // job_number : enq_search_value,
                                    // search_type: enq_search_type
                                },
                                cache : false,
                                success : function(jobdetails) {

                                    var json_p = JSON.parse(jobdetails);

                                    coor_tbl.search("")
                                            .draw();
                                    coor_tbl.state.clear();
                                    coor_tbl.clear();
                                    
                                    $(json_p.data)
                                        .each(
                                                function() {

                                                    coor_tbl.row
                                                            .add([

                                                                //this.job_worked_on_status,

                                                                '<input type="checkbox"/>',
                                                                this.created_date,
                                                                this.job_number,
                                                                this.ar_name,
                                                                this.business_process_sub_name,
                                                                this.current_application_status,
                                                                this.job_recieved_by,
                                                                this.plot_location,
                                                                //this.smd_type_of_plotting,

                                                                '<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
                                                                        + this.job_number
                                                                        + '" data-job_number="'
                                                                        + this.job_number
                                                                        + '" data-ar_name="'
                                                                        + this.ar_name
                                                                        + '" data-business_process_sub_name="'
                                                                        + this.business_process_sub_name
                                                                        + '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
                                                                        + ' <span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Add to Batch</span>'
                                                                        + ' </button>',

                                                                '<form action="front_office_view_application" method="post">'
                                                                        + '<input type="hidden" name="case_number" id="case_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="search_text" id="search_text" value="'
                                                                        + this.case_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="job_number" id="job_number" value="'
                                                                        + this.job_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
                                                                        + this.business_process_sub_name
                                                                        + '">'

                                                                        + '	<button type="submit" name="save" class="btn btn-primary btn-icon-split" >'

                                                                        + '	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
                                                                        + '	</button></form>',

                                                                        '<form action="map_plotting_application_progress_details" method="post">'
                                                                        + '<input type="hidden" name="case_number" id="case_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="transaction_number" id="transaction_number" value="'
                                                                        + this.transaction_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="job_number" id="job_number" value="'
                                                                        + this.job_number
                                                                        + '">'
                                                                        + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
                                                                        + this.business_process_sub_name
                                                                        + '">'

                                                                        + '	<button type="submit" name="save" class="btn btn-danger btn-icon-split btn-to-be-disabled to_hide_on_level_1" >'

                                                                        + '	<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>'
                                                                        + '	</button></form>'

                                                                    ])
                                                            .draw(
                                                                    false);
                                                    coor_tbl
                                                            .column(
                                                                    2)
                                                            .data()
                                                            .sort();

                                                });
                                }
                        })

                        $("#body-dg-3").addClass('bg-active');
			            $("#body-dg-1, #body-dg-2").removeClass('bg-active');
                        $("#number-text-3").removeClass('text-gray-800');
                        $("#number-text-3").addClass('text-white');
					    $("#number-text-1, #number-text-2").addClass('text-gray-800');
                    })
});