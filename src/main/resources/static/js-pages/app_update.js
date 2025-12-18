$(document).ready(function() {

   
	
	$('#frmTempBarcodingFind').on('submit',function(e) {

		// validation code here
		e.preventDefault();
		// console.log('how are your search');

		var job_search_value = $("#job_search_value").val().toUpperCase();;
        console.log('Search Value: ' + job_search_value);

        if (!(job_search_value.length >= 6)) {
            $.notify({
                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please Valid Job Number </span>',
                }, {
                    type: 'danger'
                });
        } else {

		
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
							   // console.log('how come')
						        console.log(result)
		
		                    
						        if(result.job_detail !==null){
						        	//console.log("not null")
						        	$("#rs_ar_name").val( result.transaction_details.ar_name);
								    $("#rs_case_number").val( result.parcel_details.case_number);
								    $("#rs_locality").val(result.parcel_details.locality);
								    $("#rs_job_number").val(result.job_detail.job_number);
								    
								    $("#febusiness_process_sub_name").val( result.job_detail.business_process_sub_name);
								    $("#main_service_id_fe").val( result.job_detail.business_process_id);
								    $("#main_service_sub_id_fe").val(result.job_detail.business_process_sub_id);
								    $("#fe_job_number").val(result.job_detail.job_number);
								    $("#fe_client_name").val( result.transaction_details.ar_name);
								    
								    $('.make-hidden').show();
								    
						        }else{
						        	
						        	$.notify({
					                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
					                }, {
					                    type: 'danger'
					                });
						        	
						        }
						        
						        
		                }
		            });
					
			

						
					
		}
	});
	
	
    
    $('#btnUncomplete').on('click',function(e) {

		// validation code here
		e.preventDefault();
		// console.log('how are your search');

		var barcode_job_number = $("#rs_job_number").val().toUpperCase();;
        //console.log('Search Value: ' + barcode_job_number);

        if (!(barcode_job_number.length >= 6)) {
            $.notify({
                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please Valid Job Number </span>',
                }, {
                    type: 'danger'
                });
        } else {
			
			$.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'app_update_job_set_uncompleted',
                    job_number: barcode_job_number
                },
                cache: false,
                
                beforeSend: function() {
                		//alert("soth");
                },
                success: function(data) {

                   if(data.includes('Success')){
                	   $.notify({
                           message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Successful </span>',
                       }, {
                           type: 'success'
                       });
                   }else{
                	   $.notify({
                           message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error. Something went wrong </span>',
                       }, {
                           type: 'danger'
                       });
                   }
                }
            });

						
					
		}
	});
    
    
    
    $('#btnCopyName').on('click',function(e) {

		// validation code here
		e.preventDefault();
		// console.log('how are your search');

		var barcode_job_number = $("#rs_job_number").val().toUpperCase();;
        console.log('Search Value: ' + barcode_job_number);

        if (!(barcode_job_number.length >= 6)) {
            $.notify({
                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please Valid Job Number </span>',
                }, {
                    type: 'danger'
                });
        } else {
			
			$.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'app_update_copy_name_to_job_table',
                    job_number: barcode_job_number
                },
                cache: false,
                
                beforeSend: function() {
                		//alert("soth");
                },
                success: function(data) {

                   if(data.includes('Success')){
                	   $.notify({
                           message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Successful </span>',
                       }, {
                           type: 'success'
                       });
                   }else{
                	   $.notify({
                           message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error. Something went wrong </span>',
                       }, {
                           type: 'danger'
                       });
                   }
                }
            });

						
					
		}
	});

/*----------------------------------------------*/



    // ------ end of $(doc).ready
});