$(document)
		.ready(
				function() {
					
					$('#test_json_sort').on('click', function (e) {
						e.preventDefault();
	               		console.log("hit");
	               		
	               		var data = [{"name":"Jude", "age":35, "locality":"Accra"},
	               			{"name":"James", "age":135, "locality":"Accra"},
	               			{"name":"Newt", "age":235, "locality":"Accra"},
	               			{"name":"John", "age":367, "locality":"Accra"},
							{"name":"Peter", "age":344, "locality":"Lapaz"},
							{"name":"Sam", "age":935, "locality":"Accra"},
							{"name":"Dow", "age":359, "locality":"Accra"},
							{"name":"Lower", "age":35, "locality":"Cape"},
							{"name":"Carl Nove", "age":23, "locality":"Lapaz"},	
							{"name":"Prev Ho", "age":36, "locality":"Cape"}];
						/*data.sort(function(a, b){
							return a.locality.localeCompare( b.locality);
						});
						 console.log(data);*/
						 
						 /*var grouped = _.mapValues(_.groupBy(data, 'locality'),
		                          clist => clist.map(data => _.omit(data, 'locality')));
						 console.log(grouped);*/
						 
						 
						 
						
						
						
						var grouped = _.groupBy(data, 'locality');

						console.log("cars: ", grouped);
	               		
					});
				
					
					
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
										request_type : 'get_tracking_milestones',
										main_service_id : main_service_id,
										sub_service_id:sub_service_id
									},
									cache : false,
									
									success : function(jobdetails) {

										//console.log(jobdetails);
										var table = $('#milestones-results-table');
										table.find("tbody tr").remove();
										
										
												
										var json_p = JSON.parse(jobdetails);
												
										$(json_p.data).each(function() {																	
											console.log(this);
											table.append("<tr><td>"
													+ this.milestone_description
													+ "</td><td>"
													+ this.priority_value
													+ "</td><td>"
													+ this.milestone_text_message
													+ "</td><td>"
													+ this.milestone_app_message
													+ "</td><td>"
													+ this.working_day_required
													+ "</td><td>"
													
													+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#editMilestoneModal"'
													+ ' data-ms_id="'
													+ this.ms_id
													+ '"  data-business_process_id ="'
													+ this.business_process_id
													
													+ '"  data-business_process_sub_id ="'
													+ this.business_process_sub_id
													+ '"  data-mile_stone_option ="'
													+ this.mile_stone_option
													+ '"  data-mile_stone_status ="'
													+ this.mile_stone_status
													+ '"  data-milestone_app_link ="'
													+ this.milestone_app_link
													+ '"  data-milestone_app_message ="'
													+ this.milestone_app_message
													+ '"  data-milestone_description ="'
													+ this.milestone_description
													+ '"  data-milestone_link ="'
													+ this.milestone_link
													+ '"  data-milestone_remaining ="'
													+ this.milestone_remaining
													+ '"  data-milestone_text_message ="'
													+ this.milestone_text_message
													+ '"  data-priority_value ="'
													+ this.priority_value
													+ '"  data-working_day_required ="'
													+ this.working_day_required
													
													+ '">Edit</button> '
													
													+ "</td></tr>"
													
											
											);
											
										});
										table.append("<tr><td colspan='6'><button class='btn btn-lg btn-info' data-toggle='modal' data-target='#editMilestoneModal'>Add New</button></td></tr>")
										
										
									}
								});

							});
					
					$('#editMilestoneModal').on('show.bs.modal', function (e) {
						 	$("#milestone_text_message").val($(e.relatedTarget).data('milestone_text_message')); 
		               		$("#milestone_app_message").val($(e.relatedTarget).data('milestone_app_message')); 
		               		$("#milestone_app_link").val($(e.relatedTarget).data('milestone_app_link'));
		               		$("#milestone_remaining").val($(e.relatedTarget).data('milestone_remaining'));
		               		$("#priority_value").val($(e.relatedTarget).data('priority_value'));
		               		$("#mile_stone_status").val($(e.relatedTarget).data('mile_stone_status'));
		               		$("#milestone_description").val($(e.relatedTarget).data('milestone_description')); 
		               		$("#working_day_required").val($(e.relatedTarget).data('working_day_required')); 
		               		$("#mile_stone_option").val($(e.relatedTarget).data('mile_stone_option')); 
		               		/*$("#business_process_sub_id").val($(e.relatedTarget).data('business_process_sub_id')); 
		               		$("#business_process_id").val($(e.relatedTarget).data('business_process_id')); */
		               		$("#ms_id").val($(e.relatedTarget).data('ms_id')); 
		               		
					});
					
					
					$('#edit_add_milestone').on('submit', function (e) {
						e.preventDefault();
	               		console.log("hit")
	               		var ms_id = 0;
	               		if ($("#ms_id").val()  || $("#ms_id").val() !=="" ) {
						   var ms_id =$("#ms_id").val() ;
						   //console.log("test: " + ms_id)
						}
	               		//get all values
	        		  	 $.ajax({
	        				 type: "POST",
	        				 url: "Case_Management_Serv",
	        				 data: {
	        	                	request_type: 'milestones_add_and_update',
	        	                	ms_id: ms_id ,
	        	                	milestone_description: $("#milestone_description").val() ,
	        	    				mile_stone_status: $("#mile_stone_status").val(),
	        	    				mile_stone_option: $("#mile_stone_option").val(),
	        	    				priority_value: $("#priority_value").val(),
	        	    				working_day_required: $("#working_day_required").val(),
	        	    				milestone_app_link : $("#milestone_app_link").val(),
	        	    				milestone_link : $("#milestone_link").val(),
	        	    				milestone_text_message : $("#milestone_text_message").val(),
	        	    				milestone_app_message : $("#milestone_app_message").val(),
	        	    				milestone_remaining : $("#milestone_remaining").val(),
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
									
									
											
									var json_p = JSON.parse(jobdetails);
											
									$(json_p.data).each(function() {																	
										console.log(this);
										table.append("<tr><td>"
												+ this.milestone_description
												+ "</td><td>"
												+ this.priority_value
												+ "</td><td>"
												+ this.milestone_text_message
												+ "</td><td>"
												+ this.milestone_app_message
												+ "</td><td>"
												+ this.working_day_required
												+ "</td><td>"
												
												+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#editMilestoneModal"'
												+ ' data-ms_id="'
												+ this.ms_id
												+ '"  data-business_process_id ="'
												+ this.business_process_id
												
												+ '"  data-business_process_sub_id ="'
												+ this.business_process_sub_id
												+ '"  data-mile_stone_option ="'
												+ this.mile_stone_option
												+ '"  data-mile_stone_status ="'
												+ this.mile_stone_status
												+ '"  data-milestone_app_link ="'
												+ this.milestone_app_link
												+ '"  data-milestone_app_message ="'
												+ this.milestone_app_message
												+ '"  data-milestone_description ="'
												+ this.milestone_description
												+ '"  data-milestone_link ="'
												+ this.milestone_link
												+ '"  data-milestone_remaining ="'
												+ this.milestone_remaining
												+ '"  data-milestone_text_message ="'
												+ this.milestone_text_message
												+ '"  data-priority_value ="'
												+ this.priority_value
												+ '"  data-working_day_required ="'
												+ this.working_day_required
												
												+ '">Edit</button> '
												
												+ "</td></tr>"
												
										
										);
										
									});
									table.append("<tr><td colspan='6'><button class='btn btn-lg btn-info' data-toggle='modal' data-target='#editMilestoneModal'>Add New</button></td></tr>")
													        	
	       				            
	        				 }
	        		  	 });
					});
					
					
					$('#btn_delete_milestone').on('click', function (e) {
						e.preventDefault();
	               		console.log("hit")
	               		var ms_id = 0;
	               		if ($("#ms_id").val()  || $("#ms_id").val() !=="" ) {
						   var ms_id =$("#ms_id").val() ;
						   console.log("test: " + ms_id)
						}
	               		//get all values
	        		  	 $.ajax({
	        				 type: "POST",
	        				 url: "Case_Management_Serv",
	        				 data: {
	        	                	request_type: 'lc_milestones_remove',
	        	                	ms_id: ms_id ,
	        	    				business_process_sub_id:$("#sub_service_ms").val(),
	        	    				business_process_id:$("#main_service_ms").val(),
	        				 	   },
	        				 cache: false,
	        				 beforeSend: function () {
	        					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
	        				 },
	        				 success: function(jobdetails) {
	        					
	        					 
	        					 var table = $('#milestones-results-table');
									table.find("tbody tr").remove();
									
									
											
									var json_p = JSON.parse(jobdetails);
											
									$(json_p.data).each(function() {																	
										console.log(this);
										table.append("<tr><td>"
												+ this.milestone_description
												+ "</td><td>"
												+ this.priority_value
												+ "</td><td>"
												+ this.milestone_text_message
												+ "</td><td>"
												+ this.milestone_app_message
												+ "</td><td>"
												+ this.working_day_required
												+ "</td><td>"
												
												+ '<button type="button" class="btn btn-primary" id="btn_cabinet" title="" data-toggle="modal" data-target="#editMilestoneModal"'
												+ ' data-ms_id="'
												+ this.ms_id
												+ '"  data-business_process_id ="'
												+ this.business_process_id
												
												+ '"  data-business_process_sub_id ="'
												+ this.business_process_sub_id
												+ '"  data-mile_stone_option ="'
												+ this.mile_stone_option
												+ '"  data-mile_stone_status ="'
												+ this.mile_stone_status
												+ '"  data-milestone_app_link ="'
												+ this.milestone_app_link
												+ '"  data-milestone_app_message ="'
												+ this.milestone_app_message
												+ '"  data-milestone_description ="'
												+ this.milestone_description
												+ '"  data-milestone_link ="'
												+ this.milestone_link
												+ '"  data-milestone_remaining ="'
												+ this.milestone_remaining
												+ '"  data-milestone_text_message ="'
												+ this.milestone_text_message
												+ '"  data-priority_value ="'
												+ this.priority_value
												+ '"  data-working_day_required ="'
												+ this.working_day_required
												
												+ '">Edit</button> '
												
												+ "</td></tr>"
												
										
										);
										
									});
									table.append("<tr><td colspan='6'><button class='btn btn-lg btn-info' data-toggle='modal' data-target='#editMilestoneModal'>Add New</button></td></tr>")
											
	        					 
	        					 
	        				 }
	        		  	 });
					});
					

					// ------ end of $(doc).ready
				});