$('#main_service_cp').change(function(){
        	   // alert($(this).val());
           		var select_id = document.getElementById("main_service_cp");
            		var main_service=select_id.options[select_id.selectedIndex].value;
            		
            		const main_service_name_id = main_service.split('-');
  
         			var main_service_id = main_service_name_id[0];
             		var main_service_name = main_service_name_id[1];
            		
            		 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'get_lc_sub_service',
        	                	},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        					
        					 
        					    //console.log(jobdetails);
        					    var json_p = JSON.parse(jobdetails);
        					    var options = $("#sub_service_cp");

        				       // var options = $("#selector");
        				        options.empty();
        				        options.append(new Option("-- Select --", 0));
        				     
        					    $(json_p).each(function () {
        				          
        					    	//console.log(select_id);
        					    	//console.log(this.business_process_id);
        				          
        				         if (main_service_id ==this.business_process_id){
        				        	 if (this.business_process_on_case =='No' ){
           				        	  $('#sub_service_cp').append('<option value="' + this.business_process_sub_id + '-'+ this.business_process_sub_name +'">' + this.business_process_sub_name + '</option>');
           	        					 
           				        } 
        				        }
        				           });
        				//business_process_id	  
        				 }
        				 }); 
            		
        	})
        	
        	
        	  
         $('#sub_service_cp').change(function(){
     	    //alert($(this).val());
			        var select_id = document.getElementById("main_service_cp");
			  		var main_service=select_id.options[select_id.selectedIndex].value;
			  		const main_service_name_id = main_service.split('-');
					var main_service_id = main_service_name_id[0];
			   		var main_service_name = main_service_name_id[1];
         			
			   		var sub_select_id = document.getElementById("sub_service_cp");
         			var sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
         		
         			const sub_service_name_id = sub_service.split('-');
					var sub_service_id = sub_service_name_id[0];
			   		var sub_service_name = sub_service_name_id[1];
			   		if(main_service_name==='APPLICATION FOR REGIONAL NUMBER'){
			   			$('#reg-no-div').show();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').hide();
			   			
			   			$('#checksigs-no-div').show();
			   			$('#selectlocality-no-div').show();
			   			
			   			$('#new_bill_application_client_name').val([]);
						$('#new_bill_application_client_name').prop("readonly", false);

			   			
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR STAMPING'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').show();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').hide();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').hide();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR REGISTRATION'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').show();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').hide();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		if(main_service_name==='APPLICATION FOR PVLMD PLOTTING'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		

			   		if(main_service_name==='APPLICATION FOR PERMIT SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		
			   		if(sub_service_name==='APPLICATION FOR PERMIT SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		if(sub_service_name==='APPLICATION FOR ADMINISTRATIVE SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		if(sub_service_name==='APPLICATION FOR SMD SITE PLAN SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   		if(sub_service_name==='APPLICATION FOR LRD SITE PLAN SEARCH'){
			   			$('#reg-no-div').hide();
			   			$('#stp-no-div').hide();
			   			$('#freg-no-div').hide();
			   			$('#fsearches-no-div').show();
			   			$('#checksigs-no-div').hide();
			   			$('#selectlocality-no-div').show();
			   		}
			   		
			   	   $('#addNewserviceBillModal #main_service_id').val(main_service_id);
 				   $('#addNewserviceBillModal #main_service_sub_id').val(sub_service_id);
 				   $('#addNewserviceBillModal #main_service_desc').val(main_service_name);
 				   $('#addNewserviceBillModal #main_service_sub_desc').val(sub_service_name);
 				 
			   		
 					 $.ajax({
	    				 type: "POST",
	    				 url: "Case_Management_Serv",
	    				 data: {
	    	                	request_type: 'get_lc_checklist',
	    	                	main_service_id:main_service_id,
	    	                	sub_service_id:sub_service_id},
	    				 cache: false,
	    				 beforeSend: function () {
	    					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	    				 },
	    				 success: function(jobdetails) {
	    					
	    						//loadingOverlay().cancel(spinHandle);
	    					 
	    					  var table = $('#new_checlist_table_billdataTable');
	    					    table.find("tbody tr").remove();
	    					
	    					    //console.log(jobdetails);
	    					    var json_p = JSON.parse(jobdetails);
	    					    
	    					    $(json_p).each(function () {
	    				               
	    								    table.append("<tr><td>" + this.business_process_checklist_name + "</td><td class='text-center'>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="form-check-input" name="select-item"  id="checklistitem" value="1002" /></div>' + "</td>"
	    								    		
	    								    		    + "</tr>");
	    							        
	    				              });
	    					  
	    				 }
	    				 }); 


				if(main_service_name==='APPLICATION FOR STAMPING'){
			   		
							$.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							data: {
									request_type: 'get_list_of_revenue_item_list',
									},
							cache: false,
							success: function(jobdetails) {
								// console.log(jobdetails);
									var json_p = JSON.parse(jobdetails);
									var options = $("#new_type_of_revenue_item");
									options.empty();
									options.append(new Option("-- Select --", 0));
								
									$(json_p).each(function () {
									
										//if (sub_service_id ==this.is_inspection_required){
										$('#new_type_of_revenue_item').append('<option value="' + this.id + '_'+ this.revenue_items_name +'">' + this.revenue_items_name + '</option>');
											
										//}
									});
							//business_process_id	  
							}
							});
			   	}
 					 
 					 
 					 $.ajax({
        				 type: "POST",
        				 url: "Case_Management_Serv",
        				 data: {
        	                	request_type: 'get_type_of_forms_list',
        	                	main_service_id:main_service_id,
	    	                	sub_service_id:sub_service_id},
        				 cache: false,
        				 beforeSend: function () {
        					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        				 },
        				 success: function(jobdetails) {
        						
        					 //loadingOverlay().cancel(spinHandle);
        					 
        					    // console.log( 'get_type_of_forms_list: ' + jobdetails);
        					    
        					    if(jobdetails.includes('Error')){
									// console.log('error : ' + jobdetails);
									//return false;
									// loadingOverlay().cancel(spinHandle);
                                    loadingOverlay.hide();
                                    return;
								}else{

                                    loadingOverlay.hide();

									var json_p = JSON.parse(jobdetails);
	        					    var options = $("#new_bill_registration_forms");
	        					    
	        					    options.empty();
	        				        options.append(new Option("-- Select --", 0));
	        				        
	        				        $(json_p).each(function () {
	        				        	  $('#new_bill_registration_forms').append('<option value="' + this.form_number + '-'+ this.form_name +'">' + this.form_name + '</option>');
	        	        			});
	        				        
								}

        				 }
        				 });
 				   
         		
     	})

$('#lc_btn_check_status_of_lincense_surveyor').on('click', function(e) { 
    var ls_number = $("#new_bill_application_ls_number").val();


    if(!ls_number) {
    swal.fire({
        title: 'Error Alert',
        text: 'Please enter valid search value',
        icon: 'error',
        confirmButtonText: 'OK'
    })
        return;
    }



    $('#addNewserviceBillModal #new_bill_application_surveyors_name').val([]);
        $('#addNewserviceBillModal #new_bill_application_surveyors_status').val([]);

//	console.log(id_number);
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
            request_type: 'select_load_details_of_licenced_surveyor',
            ls_number:ls_number},
            cache: false,
            beforeSend: function () {
            // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(jobdetails) {
            
            // console.log(jobdetails);
            
				var error_msg = jobdetails;
				error_msg = error_msg.trim();
				//alert('Surveyor number does not exist, or Surveyor is not in good standing')
				if(error_msg==="Error in loading Data"){
					// alert('Surveyor number does not exist, or Surveyor is not in good standing')
					//return false;

					swal.fire({
						title: 'Warning Alert',
						text: 'Surveyor number does not exist, or Surveyor is not in good standing',
						icon: 'warning',
						confirmButtonText: 'OK'
					})
				}else{
					var json_p = JSON.parse(jobdetails);
					//console.log(json_p);
					// $('#case_file_number').val(jobdetails);
						$('#addNewserviceBillModal #new_bill_application_surveyors_name').val(json_p.licensed_surveyor_name);
						$('#addNewserviceBillModal #new_bill_application_surveyors_status').val(json_p.licensed_surveyor_status);
						
					$('#addNewserviceBillModal #new_bill_application_client_id').val(json_p.licensed_surveyor_number);
					//$('#addNewserviceBillModal #new_bill_application_surveyors_status').val(json_p.licensed_surveyor_email);
				
				}
            
    
            }
        }); 
//	
});

let currentStep = 1;
const totalSteps = 5;

// Initialize wizard
initWizard();

function initWizard() {
    updateStepDisplay();
    
    // Next button click
    document.getElementById('btnNextStep').addEventListener('click', function() {
        if (validateStep(currentStep)) {
            if (currentStep < totalSteps) {
                currentStep++;
                updateStepDisplay();
            }
        }
    });
    
    // Previous button click
    document.getElementById('btnPrevStep').addEventListener('click', function() {
        if (currentStep > 1) {
            currentStep--;
            updateStepDisplay();
        }
    });
    
    // Step click navigation
    document.querySelectorAll('.wizard-steps .step').forEach(step => {
        step.addEventListener('click', function() {
            const stepNum = parseInt(this.dataset.step);
            if (stepNum <= currentStep) {
                currentStep = stepNum;
                updateStepDisplay();
            }
        });
    });
    
    // Complete Process button
    document.getElementById('btnCompleteProcess').addEventListener('click', function() {
        if (validateStep(currentStep)) {
            // Complete the process
            alert('Process completed successfully!');
            $('#NotoncaseafterPaymentModalonCase').modal('hide');
        }
    });
}

function validateStep(step) {
    switch(step) {
        case 1:
            // Validate checklist
            return validateChecklist();
        case 2:
            // Validate bills
            return true;
        case 3:
            // Validate confirmation
            return validateConfirmation();
        case 4:
            // Validate file upload
            return validateFileUpload();
        case 5:
            return true;
        default:
            return true;
    }
}

function validateChecklist() {
    const checkboxes = document.querySelectorAll('#tbl_not_on_case_after_payment_ap_checklist_dataTable input[type="checkbox"]:required');
    let isValid = true;
    
    checkboxes.forEach(cb => {
        if (!cb.checked) {
            isValid = false;
            cb.parentElement.classList.add('text-danger');
        }
    });
    
    if (!isValid) {
        Swal.fire({
            title: 'Validation Required',
            text: 'Please complete all required checklist items',
            icon: 'warning',
            confirmButtonText: 'OK'
        });
    }
    
    return isValid;
}

function validateConfirmation() {
    // Add your validation logic here
    return true;
}

function validateFileUpload() {
    const fileInput = document.getElementById('fileUploadFormatCSAU');
    if (!fileInput.files.length) {
        Swal.fire({
            title: 'File Required',
            text: 'Please upload the required document',
            icon: 'warning',
            confirmButtonText: 'OK'
        });
        return false;
    }
    return true;
}

function updateStepDisplay() {
    // Update step indicators
    document.querySelectorAll('.wizard-steps .step').forEach((step, index) => {
        const stepNum = index + 1;
        
        step.classList.remove('active', 'completed');
        
        if (stepNum < currentStep) {
            step.classList.add('completed');
        } else if (stepNum === currentStep) {
            step.classList.add('active');
        }
    });
    
    // Update content visibility
    document.querySelectorAll('.step-content').forEach(content => {
        content.classList.remove('active');
    });
    
    document.getElementById(`step-${currentStep}-content`).classList.add('active');
    
    // Update button visibility
    const btnPrev = document.getElementById('btnPrevStep');
    const btnNext = document.getElementById('btnNextStep');
    const btnComplete = document.getElementById('btnCompleteProcess');
    
    btnPrev.style.display = currentStep > 1 ? 'inline-block' : 'none';
    btnNext.style.display = currentStep < totalSteps ? 'inline-block' : 'none';
    btnComplete.style.display = currentStep === totalSteps ? 'inline-block' : 'none';
    
    if (currentStep === totalSteps) {
        btnNext.textContent = 'Finish';
    } else {
        btnNext.innerHTML = 'Next Step <i class="fas fa-chevron-right ms-2"></i>';
    }
}

$('#main_service_on_case').change(function(){
	//  alert($(this).val());
	var select_id = document.getElementById("main_service_on_case");
	var main_service=select_id.options[select_id.selectedIndex].value;
	
	const main_service_name_id = main_service.split('-');

		var main_service_id = main_service_name_id[0];
		var main_service_name = main_service_name_id[1];
		
		
		// console.log(main_service_name);
		if(main_service_name==='APPLICATION FOR PLAN APPROVAL'){
			$('#oncasereg-no-div').show();
			$('#oncasereglandsize-no-div').show();
			
			$('#oncasestp-no-div').hide();
			$('#oncasefreg-no-div').hide();
			$('#oncasefpublication-no-div').hide();
			
		}
		
		if(main_service_name==='APPLICATION FOR STAMPING'){
			$('#oncasereg-no-div').hide();
			$('#oncasereglandsize-no-div').hide();
			$('#oncasestp-no-div').show();
			$('#oncasefreg-no-div').hide();
		}
		
		if(main_service_name==='APPLICATION FOR REGISTRATION'){
			$('#oncasereg-no-div').hide();
			$('#oncasereglandsize-no-div').hide();
			$('#oncasestp-no-div').hide();
			$('#oncasefreg-no-div').show();
		}
		
		$.ajax({
			type: "POST",
			url: "Case_Management_Serv",
			data: {
				request_type: 'get_lc_sub_service',
				},
			cache: false,
			beforeSend: function () {
			// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			},
			success: function(jobdetails) {
			
				
				// console.log(jobdetails);
				var json_p = JSON.parse(jobdetails);
				var options = $("#sub_service_on_case");

				// var options = $("#selector");
				options.empty();
				options.append(new Option("-- Select --", 0));
				
				$(json_p).each(function () {
					
					// console.log(select_id);
					// console.log(this.business_process_id);
					
					if (main_service_id ==this.business_process_id){
						$('#sub_service_on_case').append('<option value="' + this.business_process_sub_id + '-'+ this.business_process_sub_name +'">' + this.business_process_sub_name + '</option>');
							
				}
					
				
					});
				//business_process_id	  
				}
			}); 
		
})

$('#sub_service_on_case').change(function(){
     	    //alert($(this).val());
		var select_id = document.getElementById("main_service_on_case");
		var main_service=select_id.options[select_id.selectedIndex].value;
		var sub_service = $(this).val();
		const main_service_name_id = main_service.split('-');
		const sub_service_name_id = sub_service.split('-');
		var main_service_id = main_service_name_id[0];
		var main_service_name = main_service_name_id[1];
		var sub_service_id = sub_service_name_id[0];
		var sub_service_name = sub_service_name_id[1];

		if(main_service_name==='APPLICATION FOR PLAN APPROVAL'){
			$('#oncasereg-no-div').show();
			$('#oncasereglandsize-no-div').show();
			$('#oncasestp-no-div').hide();
			$('#oncasefreg-no-div').hide();
			$('#oncasefpublication-no-div').hide();
			
		}
		
		if(main_service_name==='APPLICATION FOR STAMPING'){
			$('#oncasereg-no-div').hide();
			$('#oncasereglandsize-no-div').hide();
			$('#oncasestp-no-div').show();
			$('#oncasefreg-no-div').hide();
			$('#oncasefpublication-no-div').hide();
		}
		
		if(sub_service_name==='APPLICATION FOR FIRST REGISTRATION (STOOL)'){
			$('#oncasereg-no-div').hide();
			$('#oncasereglandsize-no-div').hide();
			$('#oncasestp-no-div').hide();
			$('#oncasefreg-no-div').show();
			$('#oncasefpublication-no-div').show();
			
		}
		
		if(sub_service_name==='APPLICATION FOR MORTGAGES'){
			$("#on_application_client_name").val('');
			document.getElementById("on_application_client_name").readOnly = false;
			
		}
		
		if(sub_service_name==='APPLICATION FOR OBJECTION'){
			$("#on_application_client_name").val('');
			document.getElementById("on_application_client_name").readOnly = false;
			
		}


		CallA();

		function CallA() {
			
			$.ajax({
				type: "POST",
				url: "Case_Management_Serv",
				data: {
					request_type: 'get_lc_checklist',
					main_service_id:main_service_id,
					sub_service_id:sub_service_id},
				cache: false,
				beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				},
				success: function(jobdetails) {
				
					var table = $('#on_case_checlist_table_billdataTable');
					table.find("tbody tr").remove();
				
					//console.log(jobdetails);
					var json_p = JSON.parse(jobdetails);
					
					$(json_p).each(function () {
						table.append("<tr><td>" + this.business_process_checklist_name + "</td><td>" +   '<div class="custom-control custom-checkbox"> <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" /></div>' + "</td>"
						//	  +  '<td><p data-placement="top" data-toggle="tooltip" title="Transaction Details"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#modalrecordinformation" data-target-id="' + this.ms_id + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Add to List</span></button></p></td>'
						+ "</tr>");
					});

					CallB();
				}
			}); 

		}
		
		
		function CallB() {

			$.ajax({
				type: "POST",
				url: "Case_Management_Serv",
				data: {
					request_type: 'get_type_of_forms_list',
					main_service_id:main_service_id,
					sub_service_id:sub_service_id},
				cache: false,
				beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				},
				success: function(jobdetails) {
				
					
					// console.log(jobdetails);
					var json_p = JSON.parse(jobdetails);
					var options = $("#new_bill_registration_forms_on_case");

					// var options = $("#selector");
					options.empty();
					options.append(new Option("-- Select --", 0));
					
					$(json_p).each(function () {
						$('#new_bill_registration_forms_on_case').append('<option value="' + this.form_number + '-'+ this.form_name +'">' + this.form_name + '</option>');
					
					});
					//business_process_id	  

					CallC();
				}
			});

		}

		function CallC() {
		
			$.ajax({
				type: "POST",
				url: "Case_Management_Serv",
				data: {
					request_type: 'get_list_of_revenue_item_list',
					},
				cache: false,
				beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				},
				success: function(jobdetails) {
					var json_p = JSON.parse(jobdetails);
					var options = $("#new_type_of_revenue_item_on_case");

					// var options = $("#selector");
					options.empty();
					options.append(new Option("-- Select --", 0));
					
					$(json_p).each(function () {
						
					
						if (sub_service_id ==this.is_inspection_required){
								$('#new_type_of_revenue_item_on_case').append('<option value="' + this.id + '_'+ this.revenue_items_name +'">' + this.revenue_items_name + '</option>');
									
						}
						
					});
			//business_process_id	  
				}
			});

		}
			
})

$('#btnAddAlltoBatchlist').on('click', function(e) {
    var job_purpose =$("#txt_general_job_purpose").val();

    var remarks_notes = $("#txt_general_remarks_notes").val();

    if(!job_purpose || !remarks_notes) {

		// $.notify(
		// 	{
		// 		message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose and remarks field are required!! </span>',
		// 	}, {
		// 		type : 'danger' , z_index: 9999 
		// 	});

		swal.fire({
			title: 'Ops!',
			text: 'Purpose and remarks field are required!',
			icon: 'warning',
			confirmButtonText: 'OK'
		})

		return;
	}

	if(job_purpose){
		Swal.fire({
			title: 'Confirm Action',
			text: 'Are you sure you want to add these applications to the list?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonText: 'Yes, add them',
			cancelButtonText: 'Cancel',
			// confirmButtonColor: '#0d6efd',
			// cancelButtonColor: '#6c757d',
			reverseButtons: true
		}).then((result) => {

			if (result.isConfirmed) {

				$("#job_casemgtdetailsdataTableCSAU input[type=checkbox]:checked, \
				#job_detailsdataTable input[type=checkbox]:checked, \
				#job_casemgtdetailsdataTable_frrv input[type=checkbox]:checked, \
				#job_casemgtdetailsdataTable_tpp input[type=checkbox]:checked, \
				#job_casemgtdetailsdataTable_cst input[type=checkbox]:checked, \
				#job_casemgtdetailsdataTable_frrv_cst input[type=checkbox]:checked")
				.each(function () {

					var row = $(this).closest("tr")[0];
					var job_number = row.cells[1].innerHTML;
					var ar_name = row.cells[2].innerHTML;
					var business_process_sub_name = row.cells[3].innerHTML;

					addJobToBatchlist(
						job_number,
						ar_name,
						business_process_sub_name,
						job_purpose,
						remarks_notes
					);
				});

				$("#job_casemgtdetailsdataTable input[type=checkbox]:checked").each(function () {

					var row = $(this).closest("tr")[0];
					var job_number = row.cells[2].innerHTML;
					var ar_name = row.cells[3].innerHTML;
					var business_process_sub_name = row.cells[4].innerHTML;

					addJobToBatchlist(
						job_number,
						ar_name,
						business_process_sub_name,
						job_purpose,
						remarks_notes
					);
				});

				prepareBatchlistModal();

				Swal.fire({
					icon: 'success',
					title: 'Added!',
					text: 'Selected applications have been added successfully.',
					timer: 2000,
					showConfirmButton: false
				});
			}
		});

	}else{
		
		// $.notify({
		// 	message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
		// }, {
		// 	type: 'danger'
		// });

		swal.fire({
			title: 'Ops!',
			text: 'Purpose of batching required!',
			icon: 'warning',
			confirmButtonText: 'OK'
		})
	}
		
}); 

window.addJobToBatchlist = function (
    job_number_html,
    ar_name_html,
    business_process_sub_name,
    job_purpose,
    remarks_notes
) {

    var job_number_plain = $('<div>').html(job_number_html).text().trim();

    var obj = {
        jobNumberPlain: job_number_plain,
        jobNumberHtml: job_number_html,
        applicantNameHtml: ar_name_html,
        applicationType: business_process_sub_name,
        batchingPurpose: job_purpose,
        remarksNotes: remarks_notes
    };

    var existing = localStorage.getItem('batchlistdata');
    existing = existing ? JSON.parse(existing) : {};

    existing[job_number_plain] = obj;

    localStorage.setItem('batchlistdata', JSON.stringify(existing));
};

window.removeJobFromBatchlist = function (job_number_plain) {

    Swal.fire({
        title: 'Remove Application',
        text: 'Are you sure you want to remove this application?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, remove it',
        confirmButtonColor: '#dc3545'
    }).then(result => {

        if (!result.isConfirmed) return;

        var existing = JSON.parse(localStorage.getItem('batchlistdata') || '{}');

        delete existing[job_number_plain];

        if (Object.keys(existing).length === 0) {
            localStorage.removeItem('batchlistdata');
        } else {
            localStorage.setItem('batchlistdata', JSON.stringify(existing));
        }

        prepareBatchlistModal();

        Swal.fire({
            icon: 'success',
            title: 'Removed',
            timer: 1200,
            showConfirmButton: false
        });
    });
};


window.prepareBatchlistModal = function () {

    const existing = localStorage.getItem('batchlistdata');

    if (!existing) {
        Swal.fire({
            title: 'No Applications',
            text: 'No applications in batch list!',
            icon: 'warning'
        });
        return;
    }

    const data = JSON.parse(existing);

    // ✅ Keep ONLY valid application objects
    const values = Object.values(data).filter(item =>
        item &&
        item.jobNumberPlain &&              // must exist
        item.jobNumberHtml &&               // must exist
        item.jobNumberPlain !== 'Job Number'
    );

    // Nothing valid left
    if (!values.length) {
        $('#batchlistdataTable').empty();
        updateBatchCount();
        return;
    }

    $('#batchlistdataTable').empty();

    values.forEach(item => {

        const row = $('<tr/>');

        row.append($('<td/>').html(item.jobNumberHtml));
        row.append($('<td/>').html(item.applicantNameHtml));
        row.append($('<td/>').html(item.applicationType));
        row.append($('<td/>').html(item.batchingPurpose));
        row.append($('<td/>').html(item.remarksNotes));

        row.append(
            $('<td class="text-center"/>').append(
                $('<button/>', {
                    type: 'button',
                    class: 'btn btn-sm btn-danger',
                    html: '<i class="ri-delete-bin-line"></i>',
                    click: () => removeJobFromBatchlist(item.jobNumberPlain)
                })
            )
        );

        $('#batchlistdataTable').append(row);
    });

    $('#viewBatchlistModal').modal('show');
    updateBatchCount();
};

$('#btnViewBatchlist').on('click', function(e) {
        
	prepareBatchlistModal();
		
});

// Handle batch type radio buttons
$('input[name="batch_type_radio"]').on('change', function() {
	const type = $(this).val();
	$('#batch_type').val(type);
	
	// Hide all sections first
	$('.batch-section').hide().removeClass('active-section');
	
	// Show selected section
	switch(type) {
		case 'Unit':
			$('#unit-batching-section').show().addClass('active-section');
			break;
		case 'Individual':
			$('#individual-batching-section').show().addClass('active-section');
			break;
		case 'Cabinet':
			$('#cabinet-batching-section').show().addClass('active-section');
			break;
	}
	
	// Show/hide process button
	const hasItems = $('#batchlistdataTable tr').length > 0;
	if (hasItems) {
		$('#btn_process_batchlist_ft').show();
	}
});

// Handle form submission for cabinet batching
$('#frmBatchToCabinet').on('submit', function(e) {
	e.preventDefault();
	// Add your cabinet batching logic here
	console.log('Batch to cabinet:', $('#cabinet_to_send_to').val());
});

// Update batch count
function updateBatchCount() {
    // Count rows in the table body
    const count = $('#batchlistTable tbody tr').length;
    $('#batch-count').text(count);
    
    // Show/hide empty state
    if (count === 0) {
        $('#empty-batch-state').show();
        $('#batchlistTable').hide();
    } else {
        $('#empty-batch-state').hide();
        $('#batchlistTable').show();
    }
    
    // Show/hide process button
    if (count > 0 && $('#batch_type').val()) {
        $('#btn_process_batchlist_ft').show();
    } else {
        $('#btn_process_batchlist_ft').hide();
    }
}

// Remove all from list
$('#remove_all_from_list').on('click', function () {

    Swal.fire({
        title: 'Clear All Applications',
        text: 'This action cannot be undone.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, clear all',
        confirmButtonColor: '#dc3545'
    }).then(result => {

        if (!result.isConfirmed) return;

        localStorage.removeItem('batchlistdata');

        // ✅ correct table
        $('#batchlistdataTable').empty();

        updateBatchCount();

        Swal.fire({
            title: 'Cleared!',
            icon: 'success',
            timer: 1500,
            showConfirmButton: false
        });
    });
});

// Add this to handle remove button clicks via event delegation
$(document).on('click', '.remove-from-batch', function() {
    const $row = $(this).closest('tr');
    const jobNumber = $row.find('td:first-child').text().trim();
    
    swal.fire({
        title: 'Remove Application',
        text: 'Are you sure you want to remove application ' + jobNumber + ' from the batch?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, remove it',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d'
    }).then((result) => {
        if (result.isConfirmed) {
            // Remove from localStorage
            var existing = localStorage.getItem('batchlistdata');
            existing = existing ? JSON.parse(existing) : {};
            delete existing[jobNumber];
            localStorage.setItem('batchlistdata', JSON.stringify(existing));
            
            // Remove from table
            $row.remove();
            updateBatchCount();
            
            // Show success message
            swal.fire({
                title: 'Removed!',
                text: 'Application removed from batch list.',
                icon: 'success',
                confirmButtonText: 'OK',
                confirmButtonColor: '#0d6efd',
                timer: 1500
            });
        }
    });
});

$('#unit_division_to_send_to').on('change', function() {
    const selected_division = $(this).val();
    const $select = $("#unit_to_send_to");
    const $container = $select.closest('.datalist-container');
    const $unitCount = $("#unit-count");
    const $unitIcon = $("#unit-icon");
    
    // Reset and show loading state
    $select.prop('disabled', true).empty();
    $select.append($('<option>', {
        value: '',
        text: 'Loading units...',
        disabled: true,
        selected: true
    }));
    $container.addClass('datalist-loading');
    $unitIcon.removeClass('ri-building-2-line').addClass('ri-loader-4-line animate-spin');
    $(".process-btn").hide();
    
    if (!selected_division || selected_division === "") {
        $select.empty().append($('<option>', {
            value: '',
            text: 'Please select a division first',
            disabled: true,
            selected: true
        }));
        $container.removeClass('datalist-loading');
        $unitIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-building-2-line');
        return;
    }
    
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'get_lc_list_of_units',
        },
        cache: false,
        success: function(jobdetails) {
            try {
                const json_p = JSON.parse(jobdetails);
                const $select = $("#unit_to_send_to");
                let unitCount = 0;
                
                // Remove loading state
                $container.removeClass('datalist-loading');
                $unitIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-building-2-line');
                
                // Clear and add default option
                $select.empty().append($('<option>', {
                    value: '',
                    text: 'Select a unit',
                    disabled: true,
                    selected: true
                }));
                
                // Add units to select
                $(json_p.data).each(function() {
                    if (this.unit_division && this.unit_division.includes(selected_division)) {
                        const option = $('<option>', {
                            value: this.unit_id || this.unit_name,
                            text: this.unit_name || '',
                            'data-division': this.unit_division || ''
                        });
                        
                        $select.append(option);
                        unitCount++;
                    }
                });
                
                // Update UI based on results
                if (unitCount > 0) {
                    $select.prop('disabled', false);
                    $unitCount.text(`(${unitCount} units)`).removeClass('text-danger').addClass('text-success');
                    
                    // Show success feedback
                    showUnitNotification(`${unitCount} units loaded successfully`, 'success');
                    
                    // Enable when a unit is selected
                    $select.on('change', function() {
                        if ($(this).val()) {
                            $(".process-btn").show();
                            $(this).removeClass('is-invalid').addClass('is-valid');
                        } else {
                            $(".process-btn").hide();
                            $(this).removeClass('is-valid');
                        }
                    });
                } else {
                    $select.append($('<option>', {
                        value: '',
                        text: 'No units available for this division',
                        disabled: true,
                        selected: true
                    }));
                    $unitCount.text('(No units)').removeClass('text-success').addClass('text-danger');
                    showUnitNotification('No units found for this division', 'warning');
                }
                
            } catch (error) {
                console.error('Error loading units:', error);
                $select.empty().append($('<option>', {
                    value: '',
                    text: 'Error loading units',
                    disabled: true,
                    selected: true
                }));
                $unitCount.text('(Error)').addClass('text-danger');
                $container.addClass('datalist-error');
                $unitIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-error-warning-line text-danger');
                showUnitNotification('Failed to load units. Please try again.', 'danger');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', error);
            $("#unit_to_send_to").empty().append($('<option>', {
                value: '',
                text: 'Network error loading units',
                disabled: true,
                selected: true
            }));
            $unitCount.text('(Error)').addClass('text-danger');
            $container.addClass('datalist-error');
            $unitIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-wifi-off-line text-danger');
            showUnitNotification('Network error. Please check your connection.', 'danger');
        }
    });
});

// Helper function for notifications (keep as is)
function showUnitNotification(message, type = 'info') {
    let $notification = $('.unit-notification');
    if (!$notification.length) {
        $notification = $(`
            <div class="unit-notification alert alert-dismissible fade show shadow-sm" 
                 role="alert" style="margin-top: 0.5rem;">
                <div class="d-flex align-items-center">
                    <span class="notification-icon me-2"></span>
                    <span class="notification-message"></span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `).insertAfter($('#unit_to_send_to').closest('.datalist-container'));
    }
    
    const icons = {
        'success': 'ri-checkbox-circle-line text-success',
        'warning': 'ri-alert-line text-warning',
        'danger': 'ri-error-warning-line text-danger',
        'info': 'ri-information-line text-info'
    };
    
    $notification
        .removeClass('alert-success alert-warning alert-danger alert-info')
        .addClass(`alert-${type}`)
        .find('.notification-icon')
            .removeClass()
            .addClass(`notification-icon ${icons[type]}`)
        .end()
        .find('.notification-message')
            .text(message);
    
    setTimeout(() => {
        $notification.alert('close');
    }, 3000);
}

function loadUnitUsers() {
    const selected_division = $("#division_to_send_to").val();
    const $select = $("#user_to_send_to");
    const $container = $select.closest('.datalist-container');
    const $userCount = $("#user-count");
    const $userIcon = $("#user-icon");
    
    // Reset and show loading state
    $select.prop('disabled', true).empty();
    $select.append($('<option>', {
        value: '',
        text: 'Loading users...',
        disabled: true,
        selected: true
    }));
    $container.addClass('datalist-loading');
    $userIcon.removeClass('ri-user-line').addClass('ri-loader-4-line animate-spin');
    
    if (!selected_division) {
        $select.empty().append($('<option>', {
            value: '',
            text: 'Please select a division first',
            disabled: true,
            selected: true
        }));
        $container.removeClass('datalist-loading');
        $userIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-user-line');
        return;
    }
    
    const regional_code_general = $("#regional_code_general").text();
    
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'get_lc_list_of_users',
        },
        cache: false,
        success: function(jobdetails) {
            try {
                const json_p = JSON.parse(jobdetails);
                let userCount = 0;
                
                // Remove loading state
                $container.removeClass('datalist-loading');
                $userIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-user-line');
                
                // Clear and add default option
                $select.empty().append($('<option>', {
                    value: '',
                    text: 'Select a user',
                    disabled: true,
                    selected: true
                }));
                
                // Add users to select
                $(json_p).each(function() {
                    if (selected_division == this.unit_name && regional_code_general == this.regional_code) {
                        const option = $('<option>', {
                            value: this.userid,
                            text: this.fullname || '',
                            'data-unit': this.unit_name || '',
                            'data-regional': this.regional_code || ''
                        });
                        
                        $select.append(option);
                        userCount++;
                    }
                });
                
                // Update UI based on results
                if (userCount > 0) {
                    $select.prop('disabled', false);
                    $userCount.text(`(${userCount} users)`).removeClass('text-danger').addClass('text-success');
                    
                    // Show success feedback
                    showUserNotification(`${userCount} users loaded successfully`, 'success');
                    
                    // Add change event handler
                    $select.off('change.userChange').on('change.userChange', function() {
                        const userId = $(this).val();
                        const userName = $(this).find('option:selected').text();
                        
                        if (userId) {
                            // Store selected user data
                            $(this).data('selected-user-id', userId);
                            $(this).data('selected-user-name', userName);
                            $(this).removeClass('is-invalid').addClass('is-valid');
                        } else {
                            $(this).removeClass('is-valid');
                        }
                    });
                } else {
                    $select.append($('<option>', {
                        value: '',
                        text: 'No users available for this division',
                        disabled: true,
                        selected: true
                    }));
                    $userCount.text('(No users)').removeClass('text-success').addClass('text-danger');
                    showUserNotification(`No users found in ${selected_division}`, 'warning');
                }
                
            } catch (error) {
                console.error('Error loading users:', error);
                $select.empty().append($('<option>', {
                    value: '',
                    text: 'Error loading users',
                    disabled: true,
                    selected: true
                }));
                $userCount.text('(Error)').addClass('text-danger');
                $container.addClass('datalist-error');
                $userIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-error-warning-line text-danger');
                showUserNotification('Failed to load users. Please try again.', 'danger');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', error);
            $select.empty().append($('<option>', {
                value: '',
                text: 'Network error loading users',
                disabled: true,
                selected: true
            }));
            $userCount.text('(Error)').addClass('text-danger');
            $container.addClass('datalist-error');
            $userIcon.removeClass('ri-loader-4-line animate-spin').addClass('ri-wifi-off-line text-danger');
            showUserNotification('Network error. Please check your connection.', 'danger');
        }
    });
}

// Helper function for user notifications
function showUserNotification(message, type = 'info') {
    let $notification = $('.user-notification');
    if (!$notification.length) {
        $notification = $(`
            <div class="user-notification alert alert-dismissible fade show shadow-sm" 
                 role="alert" style="margin-top: 0.5rem;">
                <div class="d-flex align-items-center">
                    <span class="notification-icon me-2"></span>
                    <span class="notification-message"></span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `).insertAfter($('#user_to_send_to').closest('.datalist-container'));
    }
    
    const icons = {
        'success': 'ri-checkbox-circle-line text-success',
        'warning': 'ri-alert-line text-warning',
        'danger': 'ri-error-warning-line text-danger',
        'info': 'ri-information-line text-info'
    };
    
    $notification
        .removeClass('alert-success alert-warning alert-danger alert-info')
        .addClass(`alert-${type}`)
        .find('.notification-icon')
            .removeClass()
            .addClass(`notification-icon ${icons[type]}`)
        .end()
        .find('.notification-message')
            .text(message);
    
    setTimeout(() => {
        $notification.alert('close');
    }, 3000);
}

// Call loadUnitUsers when needed (e.g., when division is selected or modal opens)
$(document).ready(function() {
    // Load users when modal opens (if division is already set)
    $('#viewBatchlistModal').on('shown.bs.modal', function() {
        if ($("#division_to_send_to").val()) {
            loadUnitUsers();
        }
    });
    
    // Or load when individual batch type is selected
    $('input[name="batch_type_radio"][value="Individual"]').on('change', function() {
        if ($(this).is(':checked')) {
            loadUnitUsers();
			$("#lbl_batch_type").val('Individual');
        }
    });

	$('input[name="batch_type_radio"][value="Unit"]').on('change', function() {
        if ($(this).is(':checked')) {
			$("#lbl_batch_type").val('Unit');
        }
    });
});

$('#askForPurposeOfBatching').on('show.bs.modal', function(e) {
	$('#bl_job_number_new').val($(e.relatedTarget).data('job_number'));
	$('#bl_ar_name_new').val($(e.relatedTarget).data('ar_name'));
	$('#bl_business_process_sub_name_new').val($(e.relatedTarget).data('business_process_sub_name'));
	$('#bl_application_stage').val($(e.relatedTarget).data('application_stage'));
	$('#bl_application_stage_name').val($(e.relatedTarget).data('application_stage_name'));
	$('#bl_application_stage_baby_step').val($(e.relatedTarget).data('application_stage_baby_step'));
	$('#bl_application_stage_name_baby_step').val($(e.relatedTarget).data('application_stage_name_baby_step'));

		
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
		
			
			// console.log(jobdetails);
			var json_p = JSON.parse(jobdetails);
			var options = $("#bl_job_purpose_new");
			var adv_options = $("#adv_job_purpose");

			// var options = $("#selector");
			options.empty();
			options.append(new Option("-- Select --", 0));

			adv_options.empty();
			adv_options.append(new Option("-- Select --", 0));
			
			$(json_p).each(function () {
				
			//	console.log(select_id);
			//	console.log(this.business_process_id);
				
			//   if (main_service_id ==this.business_process_id){
			$('#bl_job_purpose_new').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');

			$('#adv_job_purpose').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');
						
			//  }
				
			
			});  
		}
	});
		
});

$('#btnaddjobtolistFinal').on('click', function(e) {
	//console.log('Add to batchlist');
	var job_number = $("#bl_job_number_new").val();
	//var send_by_id = $("#modified_by_id").val();
	//var send_by =$("#modified_by").val();
	var ar_name = $("#bl_ar_name_new").val();
	var business_process_sub_name =$("#bl_business_process_sub_name_new").val();
	var job_purpose =$("#bl_job_purpose_new").val();
	var remarks_notes =$("#bl_remarks_notes").val(); 

	// console.log("job_num: " + job_number);
	// console.log("ar_name: " + ar_name);
	// console.log("business_process_sub_name: " + business_process_sub_name);
	// console.log("job_purpose: " + job_purpose);
	// console.log("remarks_notes: " + remarks_notes);
	
	if(job_purpose == 'KEEP –IN-VIEW' || !remarks_notes) {
		// alert('Add remarks or notes to continue!!')
		swal.fire({
			title: 'Ops!',
			text: 'Add remarks or notes to continue!',
			icon: 'warning',
			confirmButtonText: 'OK'
		})
		return;
	}

	if(job_purpose && job_purpose != "0"){

		$('#askForPurposeOfBatching').modal('hide');

		addJobToBatchlist(job_number,ar_name,business_process_sub_name,job_purpose,remarks_notes);
		
		prepareBatchlistModal();

		Swal.fire({
			icon: 'success',
			title: 'Added!',
			text: 'Selected applications have been added successfully.',
			timer: 2000,
			showConfirmButton: false
		});

	}else{
		// $.notify({
		// 	message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Purpose of Bacthing Required </span>',
		// }, {
		// 	type: 'danger'
		// });

		swal.fire({
			title: 'Ops!',
			text: 'Purpose of batching required!',
			icon: 'warning',
			confirmButtonText: 'OK'
		})
	}

}); 


$("#btn_process_batchlist_ft").click(function(event) {
    event.preventDefault();
    
    // Validate batch type selection
    if (!validateBatchTypeSelection()) {
        return;
    }
    
    // Process the batch
    processBatch();
});

// Function to validate batch type selection
function validateBatchTypeSelection() {
    const batchType = $('#batch_type').val();
    
    if (!batchType) {
        Swal.fire({
            title: 'Missing Information',
            text: 'Please select where to send the batch (Unit or Individual)',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#0d6efd'
        });
        return false;
    }
    
    if (batchType === 'Unit') {
        const unitSelected = $("#unit_to_send_to").val();
        if (!unitSelected) {
            Swal.fire({
                title: 'Unit Required',
                text: 'Please select a unit to send the batch to',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#0d6efd'
            });
            return false;
        }
    } else if (batchType === 'Individual') {
        const userSelected = $("#user_to_send_to").val();
        if (!userSelected) {
            Swal.fire({
                title: 'User Required',
                text: 'Please select a user to send the batch to',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#0d6efd'
            });
            return false;
        }
    }
    
    // Validate there are items in the batch
    const batchItems = getBatchItemsFromTable();
    if (batchItems.length === 0) {
        Swal.fire({
            title: 'Empty Batch',
            text: 'There are no applications in the batch list',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#0d6efd'
        });
        return false;
    }
    
    return true;
}

// Function to get batch items from table
function getBatchItemsFromTable() {
    const batchItems = [];
    
    $('#batchlistdataTable tr').each(function() {
        const $row = $(this);
        const item = {
            job_number: $row.find('td:eq(0)').text().trim(),
            ar_name: $row.find('td:eq(1)').text().trim(),
            business_process_sub_name: $row.find('td:eq(2)').text().trim(),
            job_purpose: $row.find('td:eq(3)').text().trim(),
            remarks_notes: $row.find('td:eq(4)').text().trim()
        };
        
        // Only add if we have a job number
        if (item.job_number) {
            batchItems.push(item);
        }
    });
    
    return batchItems;
}

// Function to get recipient information
function getRecipientInfo(batchType) {
    let recipient = {
        id: '',
        name: '',
        type: batchType
    };
    
    if (batchType === 'Unit') {
        const $unitSelect = $("#unit_to_send_to");
        const selectedOption = $unitSelect.find('option:selected');
        
        // Get the selected value
        const selectedValue = $unitSelect.val();
        
        if (selectedValue) {
            // Get data attributes from the selected option
            recipient.id = selectedOption.data('id') || selectedValue;
            recipient.name = selectedOption.text() || selectedValue;
            
            // If no data-id, use the value as ID
            if (!recipient.id) {
                recipient.id = selectedValue;
            }
        }
    } else if (batchType === 'Individual') {
        const $userSelect = $("#user_to_send_to");
        const selectedOption = $userSelect.find('option:selected');
        
        // Get the selected value
        const selectedValue = $userSelect.val();
        
        if (selectedValue) {
            // Get data attributes from the selected option
            recipient.id = selectedOption.data('id') || selectedValue;
            recipient.name = selectedOption.text() || selectedValue;
            
            // Try to get from data attributes if available
            const userId = selectedOption.data('user-id') || selectedOption.data('id');
            const userName = selectedOption.data('name') || selectedOption.text();
            
            if (userId) recipient.id = userId;
            if (userName) recipient.name = userName;
        }
    }
    
    return recipient;
}

// Function to determine request type
function getRequestType(batchType, lblBatchType) {
    const requestTypes = {
        'Unit': 'process_batch_list_unit',
        'Individual': 'process_batch_list_new',
        'frrv': 'process_batch_list_frrv',
        'frrv_supervisor': 'process_batch_list_frrv_supervisor',
        'frrv_supervisor_to_cordinator': 'process_batch_list_frrv_supervisor_to_cordinator',
        'tpp': 'process_batch_list_tpp',
        'tpp_supervisor': 'process_batch_list_tpp_supervisor',
        'tpp_supervisor_to_cordinator': 'process_batch_list_tpp_supervisor_to_cordinator',
        'cst': 'process_batch_list_cst',
        'cst_supervisor': 'process_batch_list_cst_supervisor',
        'cst_supervisor_to_cordinator': 'process_batch_list_cst_supervisor_to_cordinator',
        'frrv_cst': 'process_batch_list_frrv_cst',
        'frrv_cst_supervisor': 'process_batch_list_frrv_cst_supervisor',
        'frrv_cst_supervisor_to_cordinator': 'process_batch_list_frrv_cst_supervisor_to_cordinator'
    };
    
    // Check for special batch types first
    if (lblBatchType && requestTypes[lblBatchType]) {
        return requestTypes[lblBatchType];
    }
    
    // Return default based on batch type
    return requestTypes[batchType] || 'process_batch_list_new';
}

// Main function to process batch
function processBatch() {
    // Show loading state
    Swal.fire({
        title: 'Processing Batch',
        text: 'Please wait while we process your batch...',
        icon: 'info',
        showConfirmButton: false,
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
    
    // Get batch data
    const batchType = $('#batch_type').val();
    const lblBatchType = $("#lbl_batch_type").val();
    const batchItems = getBatchItemsFromTable();
    const listOfApplications = JSON.stringify(batchItems);
    
    // Get recipient information
    const recipient = getRecipientInfo(batchType);
    if (!recipient.id || !recipient.name) {
        Swal.fire({
            title: 'Error',
            text: 'Could not determine recipient information',
            icon: 'error',
            confirmButtonText: 'OK',
            confirmButtonColor: '#0d6efd'
        });
        return;
    }
    
    // Get request type
    const requestType = getRequestType(batchType, lblBatchType);
    
    // Prepare AJAX data
    const ajaxData = {
        request_type: requestType,
        division: localStorage.getItem('division') || '',
        list_of_application: listOfApplications,
        send_to_name: recipient.name,
        send_to_id: recipient.id,
        is_map_plotting: $("#is_map_plotting").val() || 'no'
    };
    
    // First AJAX call to process batch
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: ajaxData,
        cache: false,
        success: function(response) {
            try {
                const jsonResponse = JSON.parse(response);
                
                if (jsonResponse.error) {
                    throw new Error(jsonResponse.error);
                }
                
                // Get batch number from response
                const batchNumber = jsonResponse.batch_number;
                
                // Generate PDF report
                generateBatchReport(batchItems, batchNumber, recipient);
                
            } catch (error) {
                console.error('Error processing batch:', error);
                Swal.fire({
                    title: 'Processing Error',
                    text: 'Failed to process batch: ' + error.message,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#0d6efd'
                });
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', error);
            Swal.fire({
                title: 'Server Error',
                text: 'Unable to connect to server. Please try again.',
                icon: 'error',
                confirmButtonText: 'OK',
                confirmButtonColor: '#0d6efd'
            });
        }
    });
}

// Function to generate batch report PDF
function generateBatchReport(batchItems, batchNumber, recipient) {
    const reportData = {
        request_type: 'request_to_generate_batch_list',
        list_of_application: JSON.stringify(batchItems),
        batch_number: batchNumber,
        modified_by: localStorage.getItem('fullname') || '',
        modified_by_id: localStorage.getItem('userid') || '',
        send_to_name: recipient.name,
        send_to_id: recipient.id
    };
    
    $.ajax({
        type: "POST",
        url: "GenerateCaseReports",
        data: reportData,
        cache: false,
        xhrFields: {
            responseType: 'blob'
        },
        success: function(data) {
            // Close loading alert
            Swal.close();
            
            // Display PDF in modal
            displayPdfInModal(data, batchNumber);
            
            // Clean up after successful processing
            cleanupAfterBatchProcessing();
        },
        error: function(xhr, status, error) {
            console.error('Error generating report:', error);
            Swal.fire({
                title: 'Report Generation Failed',
                text: 'Batch was processed but report generation failed.',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#0d6efd'
            }).then(() => {
                // Still clean up even if report failed
                cleanupAfterBatchProcessing();
            });
        }
    });
}

// Function to display PDF in modal
function displayPdfInModal(pdfData, batchNumber) {
    // Create blob from PDF data
    const blob = new Blob([pdfData], { type: "application/pdf" });
    const objectUrl = URL.createObjectURL(blob);
    
    // Update modal with batch info
    $('#pdfModalLabel').text(`Batch ${batchNumber} - Processing Complete`);
    $('#pdfPreviewFrame').attr('src', objectUrl);
    
    // Show modal
    const pdfModal = new bootstrap.Modal(document.getElementById('pdfModal'));
    pdfModal.show();
    
    // Clean up URL when modal is closed
    $('#pdfModal').on('hidden.bs.modal', function() {
        URL.revokeObjectURL(objectUrl);
    });
}

// Function to clean up after batch processing
function cleanupAfterBatchProcessing() {
    // Clear localStorage
    localStorage.removeItem('batchlistdata');
    
    // Clear table
    $('#batchlistdataTable').empty();
    
    // Update batch count
    updateBatchCount();
    
    // Hide process button
    $('#btn_process_batchlist_ft').hide();
    
    // Close batch list modal
    const batchModal = bootstrap.Modal.getInstance(document.getElementById('viewBatchlistModal'));
    if (batchModal) {
        batchModal.hide();
    }
    
    // Reset form fields
    $('#unit_to_send_to').val('');
    $('#user_to_send_to').val('');
    $('#batch_type').val('');
    
    // Show success message
    setTimeout(() => {
        Swal.fire({
            title: 'Batch Processed Successfully!',
            text: 'The batch has been processed and sent.',
            icon: 'success',
            confirmButtonText: 'OK',
            confirmButtonColor: '#0d6efd',
            timer: 3000
        });
    }, 500);
}

// Add PDF modal HTML to your page (if not already present)
const pdfModalHTML = `
<div class="modal fade effect-fade modal-blur" id="pdfModal" tabindex="-1" aria-labelledby="pdfModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="pdfModalLabel">Batch Processing Report</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <iframe id="pdfPreviewFrame" src="" width="100%" height="800px" style="border: none;"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="downloadPdfReport()">
                    <i class="ri-download-line me-1"></i>Download PDF
                </button>
            </div>
        </div>
    </div>
</div>
`;

// Function to download PDF report
function downloadPdfReport() {
    const iframe = document.getElementById('pdfPreviewFrame');
    const pdfUrl = iframe.src;
    
    if (pdfUrl) {
        const a = document.createElement('a');
        a.href = pdfUrl;
        a.download = `Batch_Report_${new Date().getTime()}.pdf`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }
}

// Append PDF modal to body if not exists
if (!$('#pdfModal').length) {
    $('body').append(pdfModalHTML);
}


// Initialize modal
$('#newQueryModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var qid = button.data('id');
    var action = button.data('action');
    var modal = $(this);
    
    // Reset form validation
    $('#form_add_query').removeClass('was-validated');
    $('.form-control').removeClass('is-invalid is-valid');
    
    // Clear alert space
    $('#alert-display-space-query').empty();
    
    // Handle edit mode
    if (qid > 0) {
        // Edit existing query
        populateEditMode(button, modal);
        updateSubmitButtonText('Update Query');
    } else {
        // New query mode
        populateNewMode(modal);
        updateSubmitButtonText('Create Query');
    }
    
    // Handle action parameter
    if (typeof action === "undefined" || action.includes("new")) {
        populateNewMode(modal);
        updateSubmitButtonText('Create Query');
    }
    
    // Adjust requirements based on user level
    if (localStorage.getItem("user_level") < 2) {
        $("#query_remarks").prop('required', false);
        $("input[name='query_attachement_requried']").prop('required', false);
        $("#query_reasons").prop('required', false);
    }
});

// Function to populate edit mode
function populateEditMode(button, modal) {
    $("#qid").val(button.data('id'));
    
    // Populate fields from button data attributes
    $("#query_created_by").val(button.data('created_by') || '');
    $("#query_created_date").val(formatDateForDisplay(button.data('created_date')) || '');
    $("#query_modified_by").val(button.data('modified_by') || button.data('created_by') || '');
    $("#query_modified_date").val(formatDateForDisplay(button.data('modified_date')) || formatDateForDisplay(button.data('created_date')) || '');
    $("#query_status").val(button.data('status') || '1');
    $("#query_reasons").val(button.data('reasons') || '');
    $("#query_remarks").val(button.data('remarks') || '');
    $("#query_response").val(button.data('query_response') || '');
    $("#query_general_reason").val(button.data('general_reason') || '');
	$("#query_job_number").val(button.data('job_number') || '');
	$("#query_case_number").val(button.data('case_number') || '');
    
    // Set attachment required radio buttons
    const attachmentRequired = button.data('attachment_required');
    if (attachmentRequired == 1) {
        $("#query_attachement_requried1").prop('checked', true);
    } else if (attachmentRequired == 0) {
        $("#query_attachement_requried2").prop('checked', true);
    }
    
    // Disable response field
    $("#query_response").prop('disabled', true).addClass('bg-light');
}

// Function to populate new mode
function populateNewMode(modal) {
    // Clear all fields
    $("#qid").val('0');
    $("#query_created_by").val('');
    $("#query_created_date").val('');
    $("#query_modified_by").val('');
    $("#query_modified_date").val('');
    $("#query_status").val('1');
    $("#query_reasons").val('');
    $("#query_remarks").val('');
    $("#query_general_reason").val('');
    $("#query_response").val('');
    
    // Reset radio buttons
    $("input[name='query_attachement_requried']").prop('checked', false);
    
    // Enable response field
    $("#query_response").prop('disabled', true).addClass('bg-light');
    
    // Set current user and date for new queries
    const currentUser = localStorage.getItem('fullname') || 'Current User';
    const currentDate = new Date().toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
    
    $("#query_created_by").val(currentUser);
    $("#query_created_date").val(currentDate);
    $("#query_modified_by").val(currentUser);
    $("#query_modified_date").val(currentDate);
}

// Function to format date for display
function formatDateForDisplay(dateString) {
    if (!dateString) return '';
    
    try {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    } catch (e) {
        return dateString;
    }
}

// Function to update submit button text
function updateSubmitButtonText(text) {
    $('#submitButtonText').text(text);
}

// Validate query form
function validateQueryForm() {
    const form = $('#form_add_query');
    const generalReason = $('#query_general_reason').val().trim();
    
    // Reset validation
    form.removeClass('was-validated');
    $('.form-control').removeClass('is-invalid');
    
    // Check general reason
    if (!generalReason) {
        $('#query_general_reason').addClass('is-invalid');
        showAlert('Please enter general reasons for the query', 'danger');
        return false;
    }
    
    // Check status
    const status = $('#query_status').val();
    if (!status) {
        $('#query_status').addClass('is-invalid');
        showAlert('Please select a status', 'danger');
        return false;
    }
    
    // For higher level users, check additional fields
    if (localStorage.getItem("user_level") >= 2) {
        const reasons = $('#query_reasons').val().trim();
        const remarks = $('#query_remarks').val().trim();
        const attachment = $('input[name="query_attachement_requried"]:checked').val();
        
        if (!reasons) {
            $('#query_reasons').addClass('is-invalid');
            showAlert('Please enter reasons for applicant', 'danger');
            return false;
        }
        
        if (!remarks) {
            $('#query_remarks').addClass('is-invalid');
            showAlert('Please enter remarks and recommendations', 'danger');
            return false;
        }
        
        if (!attachment) {
            showAlert('Please select if document attachment is required', 'danger');
            return false;
        }
    }
    
    form.addClass('was-validated');
    return true;
}

$('#form_add_query').on('submit', function(e){
    e.preventDefault();
    // console.log('form submited Clicked');

	// Validate form
	if (!validateQueryForm()) {
		return false;
	}
    
    // Show confirmation SweetAlert before submission
    Swal.fire({
        title: 'Are you sure?',
        text: "Do you want to submit this query?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, submit it!',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            // Proceed with form submission
            var action_on_form = $("#action_on_form_query").val();
            var qid = parseInt($("#qid").val());
            var case_number = $("#query_case_number").val();
            var job_number = $("#query_job_number").val();
            var query_reasons = $("#query_reasons").val();
            var query_remarks = $("#query_remarks").val();
            var query_status = $("#query_status").val();
            var query_attachment = $("input[name='query_attachement_requried']:checked").val();
            var query_general_reason = $("#query_general_reason").val();
			var query_response = $("#query_response").val();
            
            var request_type = "";
            
            if(action_on_form == "edit"){ 
                request_type = "select_lc_case_query_add_and_update"; 
            } else { 
                request_type = "select_lc_case_query_add_and_update"; 
            }
            
            // Show loading state
            Swal.fire({
                title: 'Submitting...',
                text: 'Please wait while we process your request',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
            
            $.ajax({
                type: "POST",
                url: "lc_case_query_serv",
                data: {
                    request_type: request_type,
                    qid: qid,
                    case_number: case_number,
                    job_number: job_number,
                    reasons: query_reasons,
                    remarks: query_remarks,
                    status: query_status,
                    query_attachment: query_attachment,
                    query_general_reason: query_general_reason
                },
                cache: false,
                success: function(jobdetails) {
                    // Show success message
                    Swal.fire({
                        title: 'Success!',
                        text: 'Query has been submitted successfully',
                        icon: 'success',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'OK'
                    })
                   
					$('#newQueryModal').modal('hide');
                },
                error: function(xhr, status, error) {
                    // Show error message
                    Swal.fire({
                        title: 'Error!',
                        text: 'An error occurred while submitting the query. Please try again.',
                        icon: 'error',
                        confirmButtonColor: '#d33',
                        confirmButtonText: 'OK'
                    });
                    console.error('AJAX Error:', error);
                }
            });
        }
    });
});

// Show alert message
function showAlert(message, type = 'info') {
    const alertHtml = `
        <div class="alert alert-${type} alert-dismissible fade show" role="alert">
            <i class="ri-${type === 'success' ? 'checkbox-circle' : type === 'warning' ? 'alert' : 'information'}-line me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;
    
    $('#alert-display-space-query').html(alertHtml);
}

$(document).on('click', '.view-minute-btn', function(event) {
    event.preventDefault();
    
    const button = $(this);
    const modal = $('#viewMinutesModal');
    
    // Get data from button attributes
    const minuteData = {
        id: button.data('minute-id'),
        description: button.data('minute-description'),
        fromOfficer: button.data('minute-from'),
        toOfficer: button.data('minute-to'),
        date: button.data('minute-date'),
        caseNumber: button.data('minute-case-number'),
        jobNumber: button.data('minute-job-number'),
        status: button.data('minute-status')
    };
    
    // Populate basic data immediately
    modal.find('#minuteDescription').text(minuteData.description);
    modal.find('#minuteFromOfficer').text(minuteData.fromOfficer);
    modal.find('#minuteToOfficer').text(minuteData.toOfficer);
    modal.find('#minuteDate').text(minuteData.date);
    modal.find('#minuteActivityDate').text(minuteData.date);
    modal.find('#minuteCaseNumber').text(minuteData.caseNumber);
    modal.find('#minuteJobNumber').text(minuteData.jobNumber);
    modal.find('#minuteStatus').text(minuteData.status.charAt(0).toUpperCase() + minuteData.status.slice(1));
    
});

$('#btn_load_scanned_documents').on('click', function(e) { 
	   
    var table_docs = $('#lc_scanned_documents_dataTable');
    table_docs.find("tbody tr").remove(); 	
    
    var table_docs_mains = $('#lc_main_scanned_documents_dataTable');
    table_docs_mains.find("tbody tr").remove(); 

    var case_number = $("#cs_main_case_number").val();

    $.ajax({
        type: "POST",
        url: "LoadLRDJackets",
        data: {
        request_type: 'load_case_scanned_document_new',
        case_number:case_number},
        cache: false,
        beforeSend: function () {},
        success: function(serviceresponse) {
            if(!serviceresponse){
                return;
            }
            try{
                var json_p = JSON.parse(serviceresponse);              
                
                $(json_p).each(function () {
                        
                    table_docs.append("<tr><td>" + this.doc_description + "</td><td>" +this.document_extention + "</td>"
                        +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td>'
                        + "</tr>");

                    table_docs_mains.append('<tr><td> <a class="link-post text-secondary" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 
                        + "</tr>");

                });

            }catch(e){
                console.log(e)
            }
        }
    }); 
});

$('#btn_load_scanned_documents_public').on('click', function(e) { 
		   
    var table_docs_mains = $('#lc_public_documents_dataTable');
    table_docs_mains.find("tbody tr").remove(); 

 	var case_number = $("#cs_main_case_number").val();

	 $.ajax({
        type: "POST",
        url: "LoadLRDJackets",
        data: {
        request_type: 'load_case_scanned_document_public_new',
        case_number:case_number},
        cache: false,
        beforeSend: function () {},
        success: function(serviceresponse) {
            if(!serviceresponse){
                return;
            }
            try{
                var json_p = JSON.parse(serviceresponse);
                                
                $(json_p).each(function () {
                    table_docs_mains.append('<tr><td> <a class="link-post text-secondary" href="' + this.doc_uuid + '">' + this.doc_description+ '</a></td><td>.pdf</td>' 
                    + "</tr>");
                });
            }catch(e){
                console.log(e)
            }
        }
    }); 
});

$('#generateEGCRModal').on('shown.bs.modal', function(e) {

    var bill_number_ref = $(e.relatedTarget).data('ref_number')

    $.ajax({
        type : "POST",
        url : "payment_serv_egcr",
        data : {
            request_type : 'generate_egcr',
            ref_number : bill_number_ref,
            receipt_number : bill_number_ref
        },
        cache : false,
        xhrFields : {
            responseType : 'blob'
        },
        success : function(jobdetails) {
            

            try {
                var blob = new Blob([ jobdetails ], {type : "application/pdf"});
                var objectUrl = URL.createObjectURL(blob);
                ///window.open(objectUrl);
                //$("#egcrReceipt").modal('show');
                // $('#egcrblobinnerfile').attr('src',objectUrl);

                if (/Mobi|Android/i.test(navigator.userAgent)) {
                    $('#generateEGCRModal').modal('hide');
                    window.open(objectUrl, '_blank');
                } else {
                    $('#egcrblobinnerfile').attr('src', objectUrl);
                }
            } catch (error) {

                swal.fire({
                    title: 'Error Alert',
                    text: 'Ops! An error occurred. Try agin or contact support team for help.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                })
            }
        }
    });
});

$('#viewQueryModal').on('show.bs.modal', function(event) {
    const button = $(event.relatedTarget);
    
    // Get all data from button attributes
    const queryData = {
        id: button.data('id'),
        job_number: button.data('job_number'),
        case_number: button.data('case_number'),
        reasons: button.data('reasons'),
        remarks: button.data('remarks'),
        general_reason: button.data('general_reason'),
        status: parseInt(button.data('status')),
        created_by: button.data('created_by'),
        created_date: button.data('created_date'),
        modified_by: button.data('modified_by'),
        modified_date: button.data('modified_date'),
        attachment_required: parseInt(button.data('attachment_required'))
    };
    
    // Populate all fields
    populateQueryData(queryData);
});

// Populate query data function
function populateQueryData(data) {
    // Basic info
    $('#queryIdDisplay').text(data.id);
    $('#queryCaseNumberDisplay').text(data.case_number);
    $('#queryCaseTitle').text(`${data.case_number} - Query`);
    
    // Job and Case numbers
    $('#queryJobNumberDisplay').val(data.job_number);
    $('#queryCaseNumberDisplay').val(data.case_number);
    
    // Query content
    $('#queryGeneralReasonDisplay').text(data.general_reason || 'No general reason provided');
    $('#queryReasonsDisplay').text(data.reasons || 'No reasons specified');
    $('#queryRemarksDisplay').text(data.remarks || 'No remarks provided');
    $('#queryResponseDisplay').text(data.query_response || 'No query response provided');
    
    // Status
    const isActive = data.status === 1;
    const statusText = isActive ? 'Active' : 'Resolved';
    const statusClass = isActive ? 'bg-danger text-white' : 'bg-success text-white';
    
    $('#queryStatusText').text(statusText);
    $('#queryStatusBadge').removeClass().addClass(`badge fs-13 px-3 py-2 mb-1 ${statusClass}`);
    
    // Timeline status
    $('#timelineStatus').text(statusText);
    $('#timelineStatusMarker').removeClass().addClass(`timeline-marker ${isActive ? 'bg-danger' : 'bg-success'}`);
    
    // Dates
    const createdDate = formatDate(data.created_date);
    const modifiedDate = formatDate(data.modified_date);
    
    $('#queryCreatedDateDisplay').text(createdDate);
    $('#queryCreatedDateDisplay2').text(createdDate);
    $('#queryModifiedDateDisplay').text(modifiedDate || 'Never');
    
    $('#timelineCreated').text(createdDate);
    $('#timelineModified').text(modifiedDate || 'Never modified');
    
    // Users
    $('#queryCreatedByDisplay').text(data.created_by || 'Unknown');
    $('#queryModifiedByDisplay').text(data.modified_by || 'Not modified');
    
    // Attachment requirement
    const needsAttachment = data.attachment_required === 1;
    if (needsAttachment) {
        $('#attachmentIcon').html('<i class="bi bi-check-circle-fill text-success fs-5"></i>');
        $('#attachmentText').text('Yes').addClass('text-success');
    } else {
        $('#attachmentIcon').html('<i class="bi bi-x-circle-fill text-secondary fs-5"></i>');
        $('#attachmentText').text('No').addClass('text-muted');
    }
}

// Copy to clipboard function
window.copyToClipboard = function(elementId) {
    const element = document.getElementById(elementId);
    if (element && element.value) {
        navigator.clipboard.writeText(element.value).then(function() {
            showToast('Copied to clipboard!', 'success');
        }).catch(function() {
            showToast('Failed to copy', 'error');
        });
    }
};

// Copy WKT to clipboard
window.copyWktToClipboard = function (elementId) {
    const wktTextarea = document.getElementById(elementId);
    if (wktTextarea && wktTextarea.value) {
        navigator.clipboard.writeText(wktTextarea.value).then(() => {
            showToast('Copied to clipboard!', 'success');
        }).catch(function() {
            showToast('Failed to copy', 'error');
        });
    }
}

// Format date function
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    try {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    } catch (e) {
        return dateString;
    }
}

// Show toast notification
function showToast(message, type) {
    const toast = $(`
        <div class="toast align-items-center text-white bg-${type} border-0" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    `);
    
    $('#toastContainer').append(toast);
    const bsToast = new bootstrap.Toast(toast[0]);
    bsToast.show();
    
    toast.on('hidden.bs.toast', function() {
        $(this).remove();
    });
}

// Initialize toast container if not exists
if (!$('#toastContainer').length) {
    $('body').append(`
        <div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3"></div>
    `);
}

$(document).ready(function() {
    // Configuration for both modals
    const modalConfig = {
        'public': {
            modalId: '#publicFileUploadModal',
            fileInputName: 'samplePublicFile',
            containerId: '#fileContainer',
            addButtonId: '#addFile',
            uploadButtonId: '#btn_upload_public_case_file',
            clearButtonId: '#btnClearForm',
            documentTypeId: '#file_type_pu',
            caseNumberId: '#public_file_upload_case_number',
            progressId: '#uploadProgress',
            progressBarId: '#uploadProgressBar',
            statusId: '#uploadStatus',
            spinnerId: '#uploadSpinner',
            endpoint: 'document_upload_multiple_public_new',
            maxFiles: 5
        },
        'application': {
            modalId: '#fileUploadModal',
            fileInputName: 'sampleApplicationFile',
            containerId: '#apFileContainer',
            addButtonId: '#apAddFile',
            uploadButtonId: '#btn_upload_application_case_file',
            clearButtonId: '#apBtnClearForm',
            documentTypeId: '#file_type_au',
            caseNumberId: '#application_file_upload_case_number',
            progressId: '#fileUploadProgress',
            progressBarId: '#fileUploadProgressBar',
            statusId: '#fileUploadStatus',
            spinnerId: '#apUploadSpinner',
            endpoint: 'document_upload_mutiple_new',
            maxFiles: 5
        }
    };

    // State management for each modal
    const modalState = {};

    // Initialize modals
    $.each(modalConfig, function(modalType, config) {
        modalState[modalType] = {
            fileCount: 1
        };

        // Initialize modal - clear all added file inputs when modal closes
        $(config.modalId).on('show.bs.modal', function() {
            resetForm(modalType);
            updateUploadButton(modalType);
        });

        // Also reset when modal is hidden (when user clicks close button)
        $(config.modalId).on('hidden.bs.modal', function() {
            resetForm(modalType);
        });

        // Add more files functionality
        $(config.addButtonId).on('click', function(e) {
            e.preventDefault();
            addFileInput(modalType);
        });

        // Remove file functionality - using event delegation
        $(config.containerId).on('click', '.remove-file-btn', function() {
            const card = $(this).closest('.file-upload-card');
            const container = card.closest('.file-upload-container');
            const allCards = container.find('.file-upload-card');
            
            // Don't remove if it's the first card
            if (allCards.length > 1) {
                card.remove();
                modalState[modalType].fileCount--;
                updateFileNumbers(modalType);
                updateUploadButton(modalType);
            }
        });

        // File input change handler - using event delegation
        $(config.containerId).on('change', '.file-input', function() {
            handleFileChange(modalType, this);
        });

        // Preview button click handler - using event delegation
        $(config.containerId).on('click', '.preview-btn:not([disabled])', function(e) {
            e.preventDefault();
            const card = $(this).closest('.file-upload-card');
            const fileInput = card.find('.file-input')[0];
            
            if (fileInput && fileInput.files && fileInput.files[0]) {
                previewFile(fileInput.files[0]);
            }
        });

        // Upload button click handler
        $(config.uploadButtonId).on('click', function() {
            uploadDocuments(modalType);
        });

        // Clear form button
        $(config.clearButtonId).on('click', function() {
            resetForm(modalType);
        });

        // Document type change handler
        $(config.documentTypeId).on('change', function() {
            updateUploadButton(modalType);
        });
    });

    // Add file input to specific modal
    function addFileInput(modalType) {
        const config = modalConfig[modalType];
        const state = modalState[modalType];
        
        if (state.fileCount >= config.maxFiles) {
            showToast(`Maximum ${config.maxFiles} files allowed`, 'warning');
            return;
        }
        
        const newFileInput = createFileInput(modalType, state.fileCount + 1);
        $(config.containerId).append(newFileInput);
        state.fileCount++;
        updateFileNumbers(modalType);
    }

    // Handle file change event
    function handleFileChange(modalType, inputElement) {
        const file = inputElement.files[0];
        const card = $(inputElement).closest('.file-upload-card');
        const previewBtn = card.find('.preview-btn');
        const fileInfo = card.find('.file-info');
        const removeBtn = card.find('.remove-file-btn');
        const fileName = card.find('.file-name');
        const fileSize = card.find('.file-size');
        
        if (file) {
            // Validate file size (10MB = 10 * 1024 * 1024 bytes)
            const maxSize = 10 * 1024 * 1024;
            if (file.size > maxSize) {
                showToast('File size must be less than 10MB', 'danger');
                $(inputElement).val('');
                resetFileCard(card);
                return;
            }
            
            // Validate file type
            const validTypes = [
                'application/pdf',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                'image/jpeg',
                'image/jpg',
                'image/png'
            ];
            
            if (!validTypes.includes(file.type)) {
                showToast('Invalid file type. Please upload PDF, DOC, DOCX, JPG, or PNG files.', 'danger');
                $(inputElement).val('');
                resetFileCard(card);
                return;
            }
            
            // Update UI
            fileName.text(file.name);
            fileSize.text(formatFileSize(file.size));
            fileInfo.removeClass('d-none');
            previewBtn.prop('disabled', false);
            removeBtn.removeClass('d-none');
            
            // Store the file reference on the preview button
            previewBtn.data('file', file);
        } else {
            resetFileCard(card);
        }
        
        updateUploadButton(modalType);
    }

    // Reset file card UI
    function resetFileCard(card) {
        card.find('.file-info').addClass('d-none');
        card.find('.preview-btn').prop('disabled', true).removeData('file');
        card.find('.file-name').text('');
        card.find('.file-size').text('');
    }

    // Create new file input
    function createFileInput(modalType, fileNumber) {
        const config = modalConfig[modalType];
        return `
            <div class="file-upload-card mb-3">
                <div class="card border">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-light rounded-circle me-3">
                                <span class="text-primary">${fileNumber}</span>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1 fw-semibold">Document ${fileNumber}</h6>
                                <p class="text-muted small mb-2">Select document file</p>
                                <div class="input-group">
                                    <input type="file" 
                                           class="form-control file-input" 
                                           name="${config.fileInputName}[]"
                                           accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                                           data-max-size="10">
                                    <button class="btn btn-outline-secondary preview-btn" type="button" disabled>
                                        <i class="bi bi-eye"></i> Preview
                                    </button>
                                </div>
                            </div>
                            <button class="btn btn-sm btn-outline-danger remove-file-btn ms-2 mt-5 ${modalState[modalType].fileCount > 1 ? '' : 'd-none'}">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                        
                        <!-- File Info -->
                        <div class="file-info mt-2 d-none">
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">
                                    <span class="file-name"></span>
                                    (<span class="file-size"></span>)
                                </small>
                                <span class="badge bg-success file-status">
                                    <i class="bi bi-check-circle me-1"></i>Ready
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }

    // Update file numbers
    function updateFileNumbers(modalType) {
        const config = modalConfig[modalType];
        $(config.containerId).find('.file-upload-card').each(function(index) {
            const fileNumber = index + 1;
            $(this).find('.avatar span').text(fileNumber);
            $(this).find('h6').text(`Document ${fileNumber}`);
            
            // Show/hide remove button (don't show on first card)
            const removeBtn = $(this).find('.remove-file-btn');
            if (fileNumber === 1) {
                removeBtn.addClass('d-none');
            } else {
                removeBtn.removeClass('d-none');
            }
        });
    }

    // Update upload button state
    function updateUploadButton(modalType) {
        const config = modalConfig[modalType];
        const documentType = $(config.documentTypeId).val();
        const hasFiles = $(config.containerId).find('.file-input').filter(function() {
            return $(this).val() !== '';
        }).length > 0;
        
        const uploadBtn = $(config.uploadButtonId);
        if (documentType && hasFiles) {
            uploadBtn.prop('disabled', false);
        } else {
            uploadBtn.prop('disabled', true);
        }
    }

    // Upload documents function
    function uploadDocuments(modalType) {
        const config = modalConfig[modalType];
        const documentType = $(config.documentTypeId).val();
        const caseNumber = $(config.caseNumberId).val();
        const files = $(config.containerId).find('.file-input').filter(function() {
            return $(this).val() !== '';
        });
        
        if (!documentType) {
            showToast('Please select a document type', 'danger');
            return;
        }
        
        if (files.length === 0) {
            showToast('Please select at least one file', 'danger');
            return;
        }
        
        // Prepare form data
        const formData = new FormData();
        formData.append('case_number', caseNumber);
        formData.append('file_name', documentType);
        
        // Add files
        files.each(function(index, input) {
            const file = input.files[0];
            formData.append(config.fileInputName, file);
        });
        
        // Show upload progress
        $(config.progressId).removeClass('d-none');
        $(config.uploadButtonId).prop('disabled', true);
        $(config.spinnerId).removeClass('d-none');
        
        // Simulate upload progress
        simulateUploadProgress(modalType);
        
        // Submit via AJAX
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: config.endpoint,
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            success: function(response) {
                // console.log(response);
                if (response) {
                    showToast('Documents uploaded successfully!', 'success');
                    
                    // Close modal after success
                    setTimeout(() => {
                        $(config.modalId).modal('hide');
                        resetForm(modalType);
                        
                        // Refresh documents list if needed
                        if (modalType === 'public' && typeof refreshPublicDocuments === 'function') {
                            refreshPublicDocuments();
                        } else if (modalType === 'application' && typeof refreshApplicationDocuments === 'function') {
                            refreshApplicationDocuments();
                        }
                    }, 1500);
                } else {
                    showToast(response.message || 'Upload failed', 'danger');
                    resetUploadState(modalType);
                }
            },
            error: function(xhr, status, error) {
                console.error('Upload error:', error);
                showToast('Upload failed. Please try again.', 'danger');
                resetUploadState(modalType);
            }
        });
    }

    // Simulate upload progress
    function simulateUploadProgress(modalType) {
        const config = modalConfig[modalType];
        let progress = 0;
        const interval = setInterval(() => {
            progress += 5;
            if (progress <= 90) {
                $(config.progressBarId).css('width', progress + '%');
                $(config.statusId).text(`Uploading... ${progress}%`);
            } else {
                clearInterval(interval);
                $(config.progressBarId).css('width', '100%');
                $(config.statusId).text('Processing files...');
            }
        }, 200);
    }

    // Reset upload state
    function resetUploadState(modalType) {
        const config = modalConfig[modalType];
        $(config.progressId).addClass('d-none');
        $(config.progressBarId).css('width', '0%');
        $(config.uploadButtonId).prop('disabled', false);
        $(config.spinnerId).addClass('d-none');
    }

    // Reset form - COMPLETELY resets the modal
    function resetForm(modalType) {
        const config = modalConfig[modalType];
        const state = modalState[modalType];
        
        // Reset document type
        $(config.documentTypeId).val('');
        
        // Remove ALL file cards except the first one
        const container = $(config.containerId);
        const firstCard = container.find('.file-upload-card').first();
        
        // Clear all cards
        container.find('.file-upload-card').remove();
        
        // Add back only the first card with default state
        container.append(`
            <div class="file-upload-card mb-3">
                <div class="card border">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-light rounded-circle me-3">
                                <i class="bi bi-file-earmark-arrow-up text-primary"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1 fw-semibold">Select Document</h6>
                                <p class="text-muted small mb-2">Supported formats: PDF, DOC, DOCX, JPG, PNG (Max 10MB)</p>
                                <div class="input-group">
                                    <input type="file" 
                                           class="form-control file-input" 
                                           name="${config.fileInputName}"
                                           accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                                           data-max-size="10">
                                    <button class="btn btn-outline-secondary preview-btn" type="button" disabled>
                                        <i class="bi bi-eye"></i> Preview
                                    </button>
                                </div>
                            </div>
                            <button class="btn btn-sm btn-outline-danger remove-file-btn ms-2 mt-5 d-none">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                        
                        <!-- File Info -->
                        <div class="file-info mt-2 d-none">
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">
                                    <span class="file-name"></span>
                                    (<span class="file-size"></span>)
                                </small>
                                <span class="badge bg-success file-status">
                                    <i class="bi bi-check-circle me-1"></i>Ready
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `);
        
        // Reset state
        state.fileCount = 1;
        updateUploadButton(modalType);
        resetUploadState(modalType);
    }

    // Preview file function - FIXED VERSION
    function previewFile(file) {
        // Create preview modal if it doesn't exist
        if (!$('#previewModal').length) {
            $('body').append(`
                <div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="previewModalLabel">Document Preview</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div id="previewLoading" class="text-center p-5">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                    <p class="mt-2">Loading preview...</p>
                                </div>
                                <div id="previewError" class="d-none text-center p-5">
                                    <i class="bi bi-exclamation-triangle text-warning fs-1"></i>
                                    <p class="mt-2">Preview not available for this file type</p>
                                </div>
                                <div id="previewContent" class="d-none"></div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            `);
        }
        
        const previewModal = new bootstrap.Modal(document.getElementById('previewModal'));
        const previewContent = $('#previewContent');
        const previewLoading = $('#previewLoading');
        const previewError = $('#previewError');
        
        // Reset preview modal
        previewContent.addClass('d-none').empty();
        previewError.addClass('d-none');
        previewLoading.removeClass('d-none');
        
        // Show modal
        previewModal.show();
        
        // Check file type and show appropriate preview
        if (file.type === 'application/pdf') {
            // For PDF files
            const reader = new FileReader();
            reader.onload = function(e) {
                previewLoading.addClass('d-none');
                previewContent.removeClass('d-none').html(`
                    <div class="pdf-preview-container" style="height: 600px;">
                        <iframe src="${e.target.result}" 
                                width="100%" 
                                height="100%" 
                                frameborder="0"
                                title="PDF Preview"></iframe>
                    </div>
                `);
            };
            reader.onerror = function() {
                previewLoading.addClass('d-none');
                previewError.removeClass('d-none');
            };
            reader.readAsDataURL(file);
        } else if (file.type.startsWith('image/')) {
            // For image files
            const reader = new FileReader();
            reader.onload = function(e) {
                previewLoading.addClass('d-none');
                previewContent.removeClass('d-none').html(`
                    <div class="text-center">
                        <img src="${e.target.result}" 
                             class="img-fluid rounded" 
                             alt="Document Preview"
                             style="max-height: 500px;">
                    </div>
                `);
            };
            reader.onerror = function() {
                previewLoading.addClass('d-none');
                previewError.removeClass('d-none');
            };
            reader.readAsDataURL(file);
        } else {
            // For unsupported preview types (Word documents, etc.)
            setTimeout(function() {
                previewLoading.addClass('d-none');
                previewError.removeClass('d-none');
                previewError.html(`
                    <div class="text-center p-4">
                        <i class="bi bi-file-earmark-text text-primary fs-1"></i>
                        <h5 class="mt-3">${file.name}</h5>
                        <p class="text-muted">${formatFileSize(file.size)}</p>
                        <p class="text-muted mb-0">Preview not available for this file type.</p>
                        <p class="text-muted">You can download the file to view it.</p>
                    </div>
                `);
            }, 500);
        }
    }

    // Format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    // Show toast notification
    function showToast(message, type) {
        const toast = $(`
            <div class="toast align-items-center text-white bg-${type} border-0" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        ${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        `);
        
        $('#toastContainer').append(toast);
        const bsToast = new bootstrap.Toast(toast[0]);
        bsToast.show();
        
        toast.on('hidden.bs.toast', function() {
            $(this).remove();
        });
    }

    // Initialize toast container if not exists
    if (!$('#toastContainer').length) {
        $('body').append(`
            <div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3"></div>
        `);
    }

    // Copy to clipboard function (for case number)
    // window.copyToClipboard = function(elementId) {
    //     const element = document.getElementById(elementId);
    //     const text = element.value;
        
    //     navigator.clipboard.writeText(text).then(function() {
    //         showToast('Copied to clipboard!', 'success');
    //     }).catch(function(err) {
    //         console.error('Failed to copy: ', err);
    //         showToast('Failed to copy', 'danger');
    //     });
    // };
});

$('#lc_public_documents_dataTable, #lc_main_scanned_documents_dataTable').on('click', '.link-post', function (e) {
    e.preventDefault();

    $('#previewModal').modal('show');

    const previewContent = $('#previewContent');
    const previewLoading = $('#previewLoading');
    const previewError = $('#previewError');

    previewContent.addClass('d-none');
    previewError.addClass('d-none');
    previewLoading.removeClass('d-none');

    const file_to_open = e.currentTarget.getAttribute('href');

    if (!file_to_open) {
        console.error('File path is empty');
        previewLoading.addClass('d-none');
        previewError.removeClass('d-none').text('Invalid file path');
        return;
    }

    const file_path = file_to_open.replace(/^file:\/\//, '');

    $.ajax({
        type: "POST",
        url: "open_pdffile",
        data: {
            request_type: 'request_to_generate_batch_list',
            file_to_open: file_path
        },
        xhrFields: {
            responseType: 'blob'
        },
        success: function (jobdetails) {

            const blob = new Blob([jobdetails], {
                type: "application/pdf"
            });

            const objectUrl = URL.createObjectURL(blob);

            previewLoading.addClass('d-none');
            previewContent.removeClass('d-none').html(`
                <div class="pdf-preview-container" style="height: 800px;">
                    <iframe src="${objectUrl}" width="100%" height="100%" frameborder="0"></iframe>
                </div>
            `);
        },
        error: function () {
            previewLoading.addClass('d-none');
            previewError.removeClass('d-none').text('Failed to load document');
        }
    });
});

$('#appsPassedDueModal').on('shown.bs.modal', function (e) {
  // Destroy existing DataTable instance if it exists
  const table = $('#report_dashboard_apps_past_due_date_by_user_table').DataTable();
  if (table) {
    table.destroy();
  }
  
  // Clear the table body
  $('#report_dashboard_apps_past_due_date_by_user_table tbody').empty();
  
  // Make AJAX request
  $.ajax({
    type: "POST",
    url: "Case_Management_Serv",
    data: {
      request_type: 'report_dashboard_apps_past_due_date_by_user',
    },
    cache: false,
    success: function(data) {
        if(!data){
            initializePassedDueAppsTable([]);
            return;
        }
      try {
        const jsonData = JSON.parse(data);
        initializePassedDueAppsTable(jsonData);
      } catch(e) {
        console.error("Error parsing data:", e);
        // Initialize empty table if there's an error
        initializePassedDueAppsTable([]);
      }
    },
    error: function(xhr, status, error) {
      console.error("AJAX error:", error);
      // Initialize empty table if there's an error
      initializePassedDueAppsTable([]);
    }
  });
});

// Modal hidden event to clean up DataTable
$('#appsPassedDueModal').on('hidden.bs.modal', function (e) {
  const table = $('#report_dashboard_apps_past_due_date_by_user_table').DataTable();
  if (table) {
    table.destroy();
  }
  $('#report_dashboard_apps_past_due_date_by_user_table tbody').empty();
});

// Modified initializePassedDueAppsTable function with your column structure
function initializePassedDueAppsTable(data) {
  // Adjust the columns to match your data structure
  const table = $('#report_dashboard_apps_past_due_date_by_user_table').DataTable({
    data: data,
    destroy: true,
    responsive: true,
    dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
         '<"row"<"col-sm-12"tr>>' +
         '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>' +
         '<"row"<"col-sm-12"B>>',
    buttons: [
      {
        extend: 'excel',
        text: '<i class="ri-file-excel-line me-1"></i>Excel',
        className: 'btn btn-outline-primary btn-sm',
        exportOptions: {
          columns: [0, 1, 2, 3] // Adjust column indices as needed
        }
      },
      {
        extend: 'print',
        text: '<i class="ri-printer-line me-1"></i>Print',
        className: 'btn btn-outline-secondary btn-sm',
        exportOptions: {
          columns: [0, 1, 2, 3] // Adjust column indices as needed
        }
      }
    ],
    columns: [
      { 
        data: 'job_number',
        title: 'Job Number',
        render: function(data, type, row) {
          return `<span class="fw-medium text-primary small">${data}</span>`;
        }
      },
      { 
        data: 'business_process_sub_name',
        title: 'Application Type',
        render: function(data, type, row) {
          return `<span class="text-muted small">${data}</span>`;
        }
      },
      { 
        data: 'ar_name',
        title: 'Applicant Name',
        render: function(data, type, row) {
          return `
            <div class="d-flex align-items-center">
              <div class="avatar avatar-xs bg-light rounded-circle me-2">
                <i class="ri-user-line text-muted"></i>
              </div>
              <div>
                <div class="fw-medium small">${data}</div>
              </div>
            </div>
          `;
        }
      },
      { 
        data: 'modified_date',
        title: 'Date Received',
        render: function(data, type, row) {
          return `<span class="small">${data}</span>`;
        }
      },
      { 
        data: null,
        title: 'Action',
        orderable: false,
        searchable: false,
        render: function(data, type, row) {
          return `
            <form action="registration_application_progress_details" method="post" class="d-inline">
              <input type="hidden" name="case_number" value="${row.case_number}">
              <input type="hidden" name="transaction_number" value="${row.transaction_number}">
              <input type="hidden" name="job_number" value="${row.job_number}">
              <input type="hidden" name="business_process_sub_name" value="${row.business_process_sub_name}">
              <button type="submit" name="save" class="btn btn-info btn-sm">
                <i class="fas fa-folder-open me-1"></i>
                <span class="text">Work</span>
              </button>
            </form>
          `;
        }
      }
    ],
    order: [[3, 'desc']], // Sort by modified_date descending
    pageLength: 10,
    language: {
      emptyTable: "No past due applications found",
      info: "Showing _START_ to _END_ of _TOTAL_ entries",
      infoEmpty: "Showing 0 to 0 of 0 entries",
      infoFiltered: "(filtered from _MAX_ total entries)",
      lengthMenu: "Show _MENU_ entries",
      loadingRecords: "Loading...",
      processing: "Processing...",
      search: "",
      searchPlaceholder: "Search applications...",
      zeroRecords: "No matching records found",
      paginate: {
        first: '<i class="ri-arrow-left-s-line"></i>',
        last: '<i class="ri-arrow-right-s-line"></i>',
        next: '<i class="ri-arrow-right-s-line"></i>',
        previous: '<i class="ri-arrow-left-s-line"></i>'
      }
    },
    initComplete: function() {
      // Add custom search input if needed
      $('.dataTables_filter input').attr('placeholder', 'Search applications...');
    },
    drawCallback: function() {
      // Update any dynamic content after table draw
      // You can add additional callbacks here if needed
    }
  });
  
  return table;
}

$('#appsReceivedMonthModal').on('shown.bs.modal', function (e) {
  // Destroy existing DataTable instance if it exists
  const existingTable = $('#report_dashboard_apps_rec_month_by_user_table').DataTable();
  if (existingTable) {
    existingTable.destroy();
  }
  
  // Clear the table body
  $('#report_dashboard_apps_rec_month_by_user_table tbody').empty();
  
  // Make AJAX request
  $.ajax({
    type: "POST",
    url: "Case_Management_Serv",
    data: {
      request_type: 'report_dashboard_apps_rec_month_by_user',
    },
    cache: false,
    success: function(data) {
        if(!data){
            initializeReceivedMonthAppsTable([]);
            return;
        }
      try {
        const jsonData = JSON.parse(data);
        initializeReceivedMonthAppsTable(jsonData);
      } catch(e) {
        console.error("Error parsing data:", e);
        // Initialize empty table if there's an error
        initializeReceivedMonthAppsTable([]);
      }
    },
    error: function(xhr, status, error) {
      console.error("AJAX error:", error);
      // Initialize empty table if there's an error
      initializeReceivedMonthAppsTable([]);
    }
  });
});

// Modal hidden event to clean up DataTable
$('#appsReceivedMonthModal').on('hidden.bs.modal', function (e) {
  const table = $('#report_dashboard_apps_rec_month_by_user_table').DataTable();
  if (table) {
    table.destroy();
  }
  $('#report_dashboard_apps_rec_month_by_user_table tbody').empty();
});

// DataTable initialization function
function initializeReceivedMonthAppsTable(data) {
  const table = $('#report_dashboard_apps_rec_month_by_user_table').DataTable({
    data: data,
    destroy: true,
    responsive: true,
    dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
         '<"row"<"col-sm-12"tr>>' +
         '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>' +
         '<"row"<"col-sm-12"B>>',
    buttons: [
      {
        extend: 'excel',
        text: '<i class="ri-file-excel-line me-1"></i>Excel',
        className: 'btn btn-outline-primary btn-sm',
        exportOptions: {
          columns: [0, 1, 2, 3, 4]
        }
      },
      {
        extend: 'print',
        text: '<i class="ri-printer-line me-1"></i>Print',
        className: 'btn btn-outline-secondary btn-sm',
        exportOptions: {
          columns: [0, 1, 2, 3, 4]
        }
      },
    //   {
    //     extend: 'colvis',
    //     text: '<i class="ri-eye-line me-1"></i>Columns',
    //     className: 'btn btn-outline-info btn-sm'
    //   }
    ],
    columns: [
      { 
        data: 'job_number',
        title: 'Job Number',
        render: function(data, type, row) {
          return `<span class="fw-medium text-primary small">${data}</span>`;
        }
      },
      { 
        data: 'business_process_sub_name',
        title: 'Application Type',
        render: function(data, type, row) {
          return `<span class="text-muted small">${data}</span>`;
        }
      },
      { 
        data: 'ar_name',
        title: 'Applicant Name',
        render: function(data, type, row) {
          return `
            <div class="d-flex align-items-center">
              <div class="avatar avatar-xs bg-light rounded-circle me-2">
                <i class="ri-user-line text-muted"></i>
              </div>
              <div>
                <div class="fw-medium small">${data}</div>
              </div>
            </div>
          `;
        }
      },
      { 
        data: 'date_created',
        title: 'Date Received',
        render: function(data, type, row) {
          // Format date if needed
          return `<span class="small">${data}</span>`;
        }
      },
      { 
        data: 'sender_name',
        title: 'Sent By',
        render: function(data, type, row) {
          return `
            <div class="d-flex align-items-center">
              <div class="avatar avatar-xs bg-info bg-opacity-10 rounded-circle me-2">
                <i class="ri-send-plane-line text-info"></i>
              </div>
              <div>
                <div class="small">${data}</div>
              </div>
            </div>
          `;
        }
      }
    ],
    order: [[3, 'desc']], // Sort by date_created descending
    pageLength: 10,
    language: {
      emptyTable: "No applications received this month",
      info: "Showing _START_ to _END_ of _TOTAL_ entries",
      infoEmpty: "Showing 0 to 0 of 0 entries",
      infoFiltered: "(filtered from _MAX_ total entries)",
      lengthMenu: "Show _MENU_ entries",
      loadingRecords: "Loading...",
      processing: "Processing...",
      search: "",
      searchPlaceholder: "Search applications...",
      zeroRecords: "No matching records found",
      paginate: {
        first: '<i class="ri-arrow-left-s-line"></i>',
        last: '<i class="ri-arrow-right-s-line"></i>',
        next: '<i class="ri-arrow-right-s-line"></i>',
        previous: '<i class="ri-arrow-left-s-line"></i>'
      }
    },
    initComplete: function() {
      // Add custom search input styling
      $('.dataTables_filter input').addClass('form-control form-control-sm').attr('placeholder', 'Search applications...');
      $('.dataTables_length select').addClass('form-control form-control-sm');
    },
    drawCallback: function() {
      // Add any post-draw operations here
    }
  });
  
  return table;
}

$('#appsCompletedMonthModal').on('shown.bs.modal', function (e) {
  // Destroy existing DataTable instance if it exists
  const existingTable = $('#report_dashboard_apps_comp_month_by_user_table').DataTable();
  if (existingTable) {
    existingTable.destroy();
  }
  
  // Clear the table body
  $('#report_dashboard_apps_comp_month_by_user_table tbody').empty();
  
  // Make AJAX request
  $.ajax({
    type: "POST",
    url: "Case_Management_Serv",
    data: {
      request_type: 'report_dashboard_apps_comp_month_by_user',
    },
    cache: false,
    success: function(data) {
        if(!data){
            initializeCompletedMonthAppsTable([]);
            return;
        }
      try {
        const jsonData = JSON.parse(data);
        initializeCompletedMonthAppsTable(jsonData);
      } catch(e) {
        console.error("Error parsing data:", e);
        // Initialize empty table if there's an error
        initializeCompletedMonthAppsTable([]);
      }
    },
    error: function(xhr, status, error) {
      console.error("AJAX error:", error);
      // Initialize empty table if there's an error
      initializeCompletedMonthAppsTable([]);
    }
  });
});

// Modal hidden event to clean up DataTable
$('#appsCompletedMonthModal').on('hidden.bs.modal', function (e) {
  const table = $('#report_dashboard_apps_comp_month_by_user_table').DataTable();
  if (table) {
    table.destroy();
  }
  $('#report_dashboard_apps_comp_month_by_user_table tbody').empty();
});

// DataTable initialization function
function initializeCompletedMonthAppsTable(data) {
  const table = $('#report_dashboard_apps_comp_month_by_user_table').DataTable({
    data: data,
    destroy: true,
    responsive: true,
    dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
         '<"row"<"col-sm-12"tr>>' +
         '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>' +
         '<"row"<"col-sm-12"B>>',
    buttons: [
      {
        extend: 'excel',
        text: '<i class="ri-file-excel-line me-1"></i>Excel',
        className: 'btn btn-outline-primary btn-sm',
        exportOptions: {
          columns: [0, 1, 2, 3]
        }
      },
      {
        extend: 'print',
        text: '<i class="ri-printer-line me-1"></i>Print',
        className: 'btn btn-outline-secondary btn-sm',
        exportOptions: {
          columns: [0, 1, 2, 3]
        }
      },
    //   {
    //     extend: 'colvis',
    //     text: '<i class="ri-eye-line me-1"></i>Columns',
    //     className: 'btn btn-outline-info btn-sm'
    //   }
    ],
    columns: [
      { 
        data: 'job_number',
        title: 'Job Number',
        render: function(data, type, row) {
          return `<span class="fw-medium text-primary small">${data}</span>`;
        }
      },
      { 
        data: 'business_process_sub_name',
        title: 'Application Type',
        render: function(data, type, row) {
          return `<span class="text-muted small">${data}</span>`;
        }
      },
      { 
        data: 'ar_name',
        title: 'Applicant Name',
        render: function(data, type, row) {
          return `
            <div class="d-flex align-items-center">
              <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                <i class="ri-user-line text-muted"></i>
              </div>
              <div>
                <div class="fw-medium small">${data}</div>
              </div>
            </div>
          `;
        }
      },
      { 
        data: 'created_date',
        title: 'Date Completed',
        render: function(data, type, row) {
          return `
            <div class="d-flex align-items-center">
              <div class="avatar avatar-xs bg-light rounded-circle me-2">
                <i class="ri-calendar-check-line text-muted"></i>
              </div>
              <div>
                <div class="fw-medium small">${data}</div>
              </div>
            </div>
          `;
        }
      }
    ],
    order: [[3, 'desc']], // Sort by created_date descending
    pageLength: 10,
    language: {
      emptyTable: "No applications completed this month",
      info: "Showing _START_ to _END_ of _TOTAL_ entries",
      infoEmpty: "Showing 0 to 0 of 0 entries",
      infoFiltered: "(filtered from _MAX_ total entries)",
      lengthMenu: "Show _MENU_ entries",
      loadingRecords: "Loading...",
      processing: "Processing...",
      search: "",
      searchPlaceholder: "Search completed applications...",
      zeroRecords: "No matching records found",
      paginate: {
        first: '<i class="ri-arrow-left-s-line"></i>',
        last: '<i class="ri-arrow-right-s-line"></i>',
        next: '<i class="ri-arrow-right-s-line"></i>',
        previous: '<i class="ri-arrow-left-s-line"></i>'
      }
    },
    initComplete: function() {
      // Add custom search input styling
      $('.dataTables_filter input').addClass('form-control form-control-sm').attr('placeholder', 'Search completed applications...');
      $('.dataTables_length select').addClass('form-control form-control-sm');
    },
    drawCallback: function() {
      // Update statistics or add additional styling
    //   const total = table.data().count();
    //   if (total > 0) {
    //     $('.dataTables_info').prepend(`<span class="badge bg-success me-2">${total} completed</span>`);
    //   }
    }
  });
  
  return table;
}