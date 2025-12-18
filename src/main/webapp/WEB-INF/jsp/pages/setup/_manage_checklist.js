$(document)
		.ready(
				function() {
					
					
					
					
					$('#main_service_ms').change(function() {
						var main_service_id = $(this).val();
							
						$.ajax({
							type : "POST",
							url : "Case_Management_Serv",
							data : {
								request_type : 'get_lc_sub_service',
							},
							cache : false,
							success : function(jobdetails) {
								//console.log(jobdetails);
								var json_p = JSON.parse(jobdetails);
								var options = $("#sub_service_ms");								
								options.empty();
								options.append(new Option("-- Select --",0));
								$(json_p).each(function() {																	
									if (main_service_id == this.business_process_id) {
										options.append(new Option(this.business_process_sub_name,this.business_process_sub_id))														
									}
								});
							}
						});

					});
					
					
					
					$('#sub_service_ms').change(function() {
								

								var main_service_id = $('#main_service_ms').val();
								var sub_service_id = $(this).val(); 

								$.ajax({
									type : "POST",
									url : "Case_Management_Serv",
									data : {
										request_type : 'get_lc_checklist_new',
										main_service_id : main_service_id,
										sub_service_id:sub_service_id
									},
									cache : false,
									
									success : function(jobdetails) {

										//console.log(jobdetails);
										var table = $('#milestones-results-table');
										table.find("tbody tr").remove();
										
										if(jobdetails.includes('Error in loading Data')){
											//console.log(jobdetails)										
										}else{
											try{
												var json_p = JSON.parse(jobdetails);
												
												$(json_p).each(function() {																	
													//console.log(this);
													table.append("<tr><td>"
															+ this.business_process_checklist_name
															+ "</td><td>"
															
															
															+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#editChecklistModal"'
															+ ' data-id="'
															+ this.business_process_checklist_id
															+ '"  data-business_process_checklist_name ="'
															+ this.business_process_checklist_name
															
															+ '"  data-business_process_checklist_option ="'
															+ this.business_process_checklist_option
															+ '"  data-priority_value ="'
															+ this.priority_value
															
															+ '">Edit</button> '
															
															+ "</td></tr>"
															
													
													);
													
												});
											}catch(e){
												consol.log("Error in json : " + jobdetails)
											}
											
											

										}
										table.append("<tr><td colspan='6'><button class='btn btn-lg btn-info' data-toggle='modal' data-target='#editChecklistModal'>Add New</button></td></tr>")
										
									}
								});

							});
					
					$('#editChecklistModal').on('show.bs.modal', function (e) {
						 	$("#chk_description").val($(e.relatedTarget).data('business_process_checklist_name')); 
		               		$("#chk_option").val($(e.relatedTarget).data('business_process_checklist_option')); 
		               		$("#chk_priority_value").val($(e.relatedTarget).data('priority_value')); 
		               		$("#chk_id").val($(e.relatedTarget).data('id')); 
		               		
					});
					
					
					$('#edit_add_checklist').on('submit', function (e) {
						e.preventDefault();
	               		//console.log("hit")
	               		var ms_id = 0;
	               		if ($("#chk_id").val()  || $("#chk_id").val() !=="" ) {
						   var ms_id =$("#chk_id").val() ;
						}
	               		//get all values
	        		  	 $.ajax({
	        				 type: "POST",
	        				 url: "Case_Management_Serv",
	        				 data: {
	        	                	request_type: 'checklist_add_and_update',
	        	                	ms_id: ms_id ,
	        	                	checklist_description: $("#chk_description").val() ,
	        	                	checklist_priority_value: $("#chk_priority_value").val(),
	        	                	checklist_option: $("#chk_option").val(),
	        	    				
	        	    				business_process_sub_id:$("#sub_service_ms").val(),
	        	    				business_process_id:$("#main_service_ms").val(),
	        				 	   },
	        				 cache: false,
	        				 beforeSend: function () {
	        					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	        				 },
	        				 success: function(jobdetails) {
	        					//console.log(jobdetails)
	       					 	//var result = JSON.parse(jobdetails);
	       				        
	       				        	var table = $('#milestones-results-table');
									table.find("tbody tr").remove();
									
									try{
										var json_p = JSON.parse(jobdetails);
										
										$(json_p).each(function() {																	
											//console.log(this);
											table.append("<tr><td>"
													+ this.business_process_checklist_name
													+ "</td><td>"
													
													
													+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#editChecklistModal"'
													+ ' data-id="'
													+ this.business_process_checklist_id
													+ '"  data-business_process_checklist_name ="'
													+ this.business_process_checklist_name
													
													+ '"  data-business_process_checklist_option ="'
													+ this.business_process_checklist_option
													+ '"  data-priority_value ="'
													+ this.priority_value
													
													+ '">Edit</button> '
													
													+ "</td></tr>"
													
											
											);
											
										});
										table.append("<tr><td colspan='6'><button class='btn btn-lg btn-info' data-toggle='modal' data-target='#editChecklistModal'>Add New</button></td></tr>")
														        	
		       				            
									}catch(e){
										consol.log("Error in json : " + jobdetails)
									}
											
									
	        				 }
	        		  	 });
					});
					
					
					$('#btn_delete_milestone').on('click', function (e) {
						e.preventDefault();
	               		//console.log("hit")
	               		var ms_id = 0;
	               		if ($("#chk_id").val()  || $("#chk_id").val() !=="" ) {
						   var ms_id =$("#chk_id").val() ;
						   //console.log("test: " + ms_id)
						}
	               		//get all values
	        		  	 $.ajax({
	        				 type: "POST",
	        				 url: "Case_Management_Serv",
	        				 data: {
	        	                	request_type: 'select_lc_checlist_remove',
	        	                	ms_id: ms_id ,
	        	    				business_process_sub_id:$("#sub_service_ms").val(),
	        	    				business_process_id:$("#main_service_ms").val(),
	        				 	   },
	        				 cache: false,
	        				 beforeSend: function () {
	        					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	        				 },
	        				 success: function(jobdetails) {
	        					//console.log(jobdetails)
	        					 
	        					 var table = $('#milestones-results-table');
									table.find("tbody tr").remove();
									
									try{
										var json_p = JSON.parse(jobdetails);
										
										$(json_p.data).each(function() {																	
											//console.log(this);
											table.append("<tr><td>"
													+ this.business_process_checklist_name
													+ "</td><td>"
													
													
													+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#editChecklistModal"'
													+ ' data-id="'
													+ this.business_process_checklist_id
													+ '"  data-business_process_checklist_name ="'
													+ this.business_process_checklist_name
													
													+ '"  data-business_process_checklist_option ="'
													+ this.business_process_checklist_option
													+ '"  data-priority_value ="'
													+ this.priority_value
													
													+ '">Edit</button> '
													
													+ "</td></tr>"
													
											
											);
											
										});
										table.append("<tr><td colspan='6'><button class='btn btn-lg btn-info' data-toggle='modal' data-target='#editChecklistModal'>Add New</button></td></tr>")
												
		        					 
									}catch(e){
										consol.log("Error in json : " + jobdetails)
									}
											
									
	        					 
	        				 }
	        		  	 });
					});
					

					// ------ end of $(doc).ready
				});