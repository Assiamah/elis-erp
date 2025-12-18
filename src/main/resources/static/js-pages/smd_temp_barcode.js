$(document).ready(function() {

   
	
	$('#frmTempBarcodingFind').on('submit',function(e) {

		// validation code here
		e.preventDefault();
		// console.log('how are your search');

		var job_search_value = $("#job_search_value").val().toUpperCase();;
        console.log('Search Value: ' + job_search_value);

        if (!(job_search_value.length >= 10)) {
            $.notify({
                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please Valid Job Number </span>',
                }, {
                    type: 'danger'
                });
        } else {
        	if(job_search_value.includes("SMD")){
        		
        	

					/*$("#enq-search-results-section").hide();
					$("#batchlist_value").empty();
					$("#batchlist_value").append(enq_batchlist_val);
					$("#BachlistModal").modal("show");*/
					
		
					$.ajax({
		                type: "POST",
		                url: "Case_Management_Serv",
		                data: {
		                    request_type: 'load_application_details_by_job_number',
		                    job_number: job_search_value
		                },
		                success: function(jobdetails) {
							
							 //console.log(jobdetails)
							
							 
							  var table = $('#job_detailsdataTable');
									    table.find("tbody tr").remove();
							 
							    var result = JSON.parse(jobdetails);
							    console.log('how come')
						        console.log(result)
		
		                    
						        if(result.job_detail !==null){
						        	//console.log("not null")
						        	$("#rs_ar_name").val( result.transaction_details.ar_name);
								    
								    $("#rs_case_number").val( result.parcel_details.case_number);
								    
								    $("#rs_locality").val(result.parcel_details.locality);
								    
								    $("#rs_job_number").val(result.job_detail.job_number);
						        }else{
						        	
						        	$.notify({
					                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
					                }, {
					                    type: 'danger'
					                });
						        	
						        }
						        
						        
						        
		 					   
		
		
		
		
		                }
		            });
					
			}else{
				alert("System Cannot generate for this Job Number")
			}

						
					
		}
	});
	
	
    
    $('#frmTempBarcoding').on('submit',function(e) {

		// validation code here
		e.preventDefault();
		// console.log('how are your search');

		var barcode_job_number = $("#rs_job_number").val().toUpperCase();;
        console.log('Search Value: ' + barcode_job_number);

        if (!(barcode_job_number.length >= 10)) {
            $.notify({
                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please Valid Job Number </span>',
                }, {
                    type: 'danger'
                });
        } else {


			/*$("#enq-search-results-section").hide();
			$("#batchlist_value").empty();
			$("#batchlist_value").append(enq_batchlist_val);
			$("#BachlistModal").modal("show");*/
			

			$.ajax({
                type: "POST",
                url: "GenerateCaseReports",
                target: '_blank',
                data: {
                    request_type: 'request_to_generate_smd_temp_barcode',
                    job_number: barcode_job_number
                },
                cache: false,
                xhrFields: {
                    responseType: 'blob'
                },
                beforeSend: function() {
                		//alert("soth");
                },
                success: function(data) {

                    console.log(data);
                    $('#elisDocumentPreview').modal({
                        backdrop: 'static',
                    });


                    var blob = new Blob(
                        [data], {
                            type: "application/pdf"
                        });
                    var objectUrl = URL
                        .createObjectURL(blob);
                    // window.open(objectUrl);
                    console.log("success ajax");

                    $('#elisdovumentpreviewblobfile').attr('src', objectUrl);




                }
            });

						
					
		}
	});

/*----------------------------------------------*/



    // ------ end of $(doc).ready
});