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
																		return;
																	}

															 //console.log(jobdetails);
															$(
																	"#enq-search-results-section")
																	.show();

															var table = $('#enq-search-results-table');
															table.find(
																	"tbody tr")
																	.remove();
															if(jobdetails
																	.includes('no search type')) {
																alert('Reference Number has not been acknowleged or does not exist')
																return false;
															}else{
																
															
															// console.log(jobdetails);
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
																								+ this.locality
																								+ '<td>'

																								+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#uploadScannedPlanModal"'
																								+ ' data-case_number="'
																								+ this.case_number
																								+ '"> '
																								+ '<span class="icon text-black-50"> <i class="fas fa-upload"></i> </span><span  class="text">Upload Plan</span> </button>'

																								

																								+ '</td></tr>');

																			});
															}

														}
													});
										}
									});


            $('#uploadScannedPlanModal').on('show.bs.modal', function(event) {

                //event.preventDefault()

                $('#uploadScannedPlanModal #scanned_plan_case_number').val($(event.relatedTarget).data('case_number'))
            })




            $("#btn_upload_scanned_site_plan").click(function(event) {
                // $('form').submit(function(event) {
                // stop submit the form, we will post it
                // manually.
                event.preventDefault();
                //console.log("CLicekd me")
                // Get form
                // var form = $('#fileUploadForm')[0];
        
                // var form =
                // $('#fileUploadForm')[0].files[0];
                var case_number = $(
                        "#scanned_plan_case_number")
                        .val();
        
                var sampleFile = document
                        .getElementById("scannedFileUploadForm").files[0];
        
                // var fileInput =
                // document.getElementById('upload');
                var filename = document
                        .getElementById("scannedFileUploadForm").files[0].name;
        
                console.log(filename);
        
                var formdata = new FormData();
        
                formdata.append("case_number",
                        case_number);
                formdata.append("file_name", filename);
        
                formdata.append("sampleFile",
                        sampleFile);
        
                // Create an FormData object
                // var data = new FormData(form);
                // console.log(data);
                // If you want to add an extra field for
                // the FormData
                // data.append("case_number",
                // case_number);
                // console.log(data);
                // // disabled the submit button
                $("#btn_upload_scanned_site_plan").prop(
                        "disabled", true);
                ////console.log(formdata); 
                $
                        .ajax({
                            type : "POST",
                            enctype : 'multipart/form-data',
                            url : "scanned_site_plan_upload",
                            data : formdata,
                            processData : false,
                            contentType : false,
                            cache : false,
                            timeout : 600000,
                            success : function(data) {
        
                                // $("#result").text(data);
                                alert(data);
        
                                $('#uploadScannedPlanModal').modal('hide');
                                console.log("SUCCESS : ",data);
                                $("#btn_upload_scanned_site_plan").prop("disabled",false);
        
                            },
                            error : function(e) {
        
                                // $("#result").text(e.responseText);
                                console.log("ERROR : ",e);
                                $("#btn_upload_scanned_site_plan").prop("disabled",false);
        
                            }
                        });
        
            });
});