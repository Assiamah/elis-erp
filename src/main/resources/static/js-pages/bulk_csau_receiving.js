$(document)
		.ready(
				function() {

					
					
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

																	if(!jobdetails) {

																		$.notify({
																			message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found!</span>',
																		}, { type : 'danger' , z_index: 9999  });

																		$('#enquiry_alert').removeClass('d-none');
																		
																		return;
																	}

																	console.log(jobdetails);
                                                             if(jobdetails == ''){
                                                                
                                                                $.notify({
                                                                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found! </span>',
                                                                }, { type : 'danger' , z_index: 9999  });

                                                             } else {

                                                                $(
																	"#enq-search-results-section")
																	.show();

															 var table = $('#tbl-bulk-receiving-table');
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
																								+ this.business_process_sub_name
																								+ "</td><td>"
																								+ this.glpin
																								+ "</td><td>"
																								+ this.locality
																								+ "</td><td>"
																								+ this.regional_number
                                                                                                + "</td><td>"
                                                                                                + "<div class='d-inline p-2'>"
																								+ "<button class='btn btn-primary btn-sm mb-2' data-toggle='modal' data-target='#publicFileUploadModal' data-br_case_number='"+this.case_number+"'><i class='fas fa-upload'></i>Upload </button>"
																								+ "</div>"
																								+ "<div class='d-inline p-2'>"
																								+ "<button class='btn btn-warning btn-sm' data-toggle='modal' data-target='#publicViewFileModal' data-br_case_number='"+this.case_number+"'><i class='fas fa-eye'></i>View </button>"
																								+ "</div>"
																								+ "</td>"

																								+ '</tr>');

																			});
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

					
                                    $('#btnBatchBulkReceiving').on('click', function(e) {

										var job_purpose =$("#bcd_submission_type").val();
										var bcd_depositor_by =$("#bcd_depositor_by").val();
										var bcd_depositor_id_type =$("#bcd_depositor_id_type").val();
                                        var bcd_depositor_id_number =$("#bcd_depositor_id_number").val();
										var bcd_depositor_phone_number =$("#bcd_depositor_phone_number").val();
										var bcd_depositor_email =$("#bcd_depositor_email").val();
										var bcd_submission_type =$("#bcd_submission_type").val();

                                                if(!bcd_depositor_by || !bcd_depositor_id_type || !bcd_depositor_id_number || !bcd_depositor_phone_number || !bcd_submission_type){
													
													$.notify({
														message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please the required fields! </span>',
													}, {
														type: 'danger'
													});

                                                }else{
                                                    
												  var confirmText = "Are you sure you want to add these application to the list?";
                                                  if(confirm(confirmText)) {
														var table1 = document.getElementById("tbl-bulk-receiving-table")
														var tr = $('#tbl-bulk-receiving-table tbody tr')

                                                     // $("#tbl-bulk-receiving-table tbody tr").each(function () {
														for(var i = 0; i < tr.length; i++) {
                                                         // var row = $(this).closest("tr")[0];
														  //console.log(row)
                                                          var job_number = table1.rows[i+1].cells[2].innerHTML;
                                                             var ar_name =  table1.rows[i+1].cells[0].innerHTML;
                                                             var business_process_sub_name = table1.rows[i+1].cells[3].innerHTML;;

                                                             addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,"");
                                                             
                                                            //console.log("testing click " + business_process_sub_name);
                                                      };
                                                      
                                                      
                                                     prepareBatchlistModal();
                                                    }
                                                }
                                                
                                         }); 
					// ------ end of $(doc).ready
				});