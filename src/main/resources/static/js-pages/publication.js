$(document).ready(function() {
//$('#unpublishedList').tab('show')
	
	$('#frmFindJobForPublication').on('submit',function(e) {

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
					
					 
					  //var table = $('#job_detailsdataTable');
							    //table.find("tbody tr").remove();
					 try{
						var result = JSON.parse(jobdetails);
						
						if(result.job_detail !==null){
				        	//console.log("not null")
				        	$("#rs_ar_name").val( result.transaction_details.ar_name);
				        	$("#rs_grantor_name").val( result.transaction_details.party_grantors_name);
						    $("#rs_case_number").val( result.parcel_details.case_number);
						    $("#rs_locality").val(result.parcel_details.locality);
						    $("#rs_job_number").val(result.job_detail.job_number);
						    $("#rs_type_of_interest").val(result.transaction_details.type_of_interest);
						    $("#rs_extent").val( result.parcel_details.extent);
						    $("#rs_registry_mapref").val(result.parcel_details.registry_mapref);
						   
				        }else{
				        	
				        	$.notify({
			                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
			                }, {
			                    type: 'danger'
			                });
				        	
				        }
						
						
					}catch(e){
						console.log(e)
					}
					    
					    //console.log('how come')
				        

                    
				        
				        
				        
				        
 					   




                }
            });

						
					
		}
	});
	
	
    
    $('#frmAddToPublicationList').on('submit',function(e) {

		// validation code here
		e.preventDefault();
		// console.log('how are your search');

		var v_case_number = $("#rs_case_number").val().toUpperCase();;
        //console.log('Search Value: ' + barcode_job_number);

        if (!(v_case_number.length >= 10)) {
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
                    request_type: 'add_application_to_publication_list',
                    case_number: v_case_number
                },                
                success: function(data) {
                    //console.log("data: "+typeof data);
                    try{
						if(parseInt(data)===1){
	                    	alert("Application Added");
	                    	location.reload(true);
                    	}
					}catch(e){
						console.log(e)
					}
                    
                }
            });

						
					
		}
	});
	
	
	/*$("#btnAddOldCase").click(function(event){ 	 
	    //alert("kjlkjhkljf")
		
                       	 		                    	 		    
    });*/
	$('#unpublishedDataTable').DataTable();
	
	$("#btnViewPublicationList").click(function(event){
	 	 
		    
		                
		              
		              
			            var send_to_address = "test";
		                var publication_list = storeTblValues();
		                //publication_list = JSON.stringify(publication_list);
		                //console.log(publication_list);
		                //modified_by = localStorage.getItem("fullname");
		                //modified_by_id = localStorage.getItem("userid");
		                
		    
		                function storeTblValues()
		                {
		                    var TableData = new Array();
		    
		                    $('#unpublishedDataTable tr').each(function(row, tr){
		                        TableData[row]={
									"client_number" : $(tr).find('td:eq(1)').text().trim(), //Get the number from the client
									"case_number" : $(tr).find('td:eq(3)').text().trim() ,
									"business_process_sub_name" : $(tr).find('td:eq(4)').text().trim(),
								   "glpin" : $(tr).find('td:eq(5)').text().trim(),
									"ar_name" : $(tr).find('td:eq(6)').text().trim(),
									"location" : $(tr).find('td:eq(7)').text().trim(),
									"grantor" : $(tr).find('td:eq(8)').text().trim(),
									"extent" : $(tr).find('td:eq(9)').text().trim(),
									"interest" : $(tr).find('td:eq(10)').text().trim(),
									"registry_map" : $(tr).find('td:eq(11)').text().trim(),
									"description" : $(tr).find('td:eq(12)').text().trim()                     
		                        }    
		                    }); 
		                    
		                 
		                    TableData.shift();  // first row will be empty - so remove
		                    return TableData;
		                }
		                //console.log("tESTING First : " + typeof publication_list);
		                
	 		                 //var json_p = JSON.parse(publication_list);
	 		                  
	 		                var sorted_publication_list = _.groupBy(publication_list, 'location');

							//console.log("cars: ", JSON.stringify(sorted_publication_list));
							
							//let sorted_publication_list = _.sortBy(sorted_publication_list,[function(o) { return o; }]);
							const ordered = {};
							Object.keys(sorted_publication_list).sort().forEach(function(key) {
							  ordered[key] = sorted_publication_list[key];
							});

							//console.log(ordered);
	 		                  
	 		                 $.ajax({
								 type: "POST",
								 url: "GenerateCaseReports",
								 target : '_blank',
								 data: {
									 request_type: 'request_to_generate_publication_list',
									 publication_list: JSON.stringify(ordered),
		           					 to_email_address : send_to_address
		           					 
					                  	},
								 cache: false,
								 xhrFields : {
										responseType : 'blob'
									},
								 beforeSend: function () { },
								 success: function(data) {
									 //console.log(data)
										$('#elisDocumentPreview').modal({
			     	    	 			 backdrop: 'static',
			     	    				});
										// console.log("pdf blob sdata");
										 //console.log(data);
										var blob = new Blob(
												[ data ],
												{
													type : "application/pdf"
												});
									var objectUrl = URL
												.createObjectURL(blob);
										// window.open(objectUrl);
									///	console.log("success ajax");

 	    							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
										
										
										
								      
								 },
								 complete: function(){
									 //console.log("Completed ajax");
									 //$('#viewBatchlistModal').modal('hide');
									 //console.log("Completed 3 ajax");
 	    							 //Clear Local storage Bactlist
 	    				       		//localStorage.setItem('batchlistdata', '');
 	    				       		//prepareBatchlistModal();
 	    				       		
 	    				       	   
								   }
								 });
	 		                  
	 		                  
	 		                  	 		                    	 		    
	 		              }) ;
 		                
		            
		$("#btnPreviewSP").click(function(e){
	 	 
		    
		                
		              
		              
			            let send_to_address = "test";
		                
		                let publication_list = $("#lc_search_report_summary_details").val() == '' ? $("#lc_search_report_summary_details_2").val() : $("#lc_search_report_summary_details").val();
		                
	 		                 $.ajax({
								 type: "POST",
								 url: "GenerateCaseReports",
								 target : '_blank',
								 data: {
									 request_type: 'request_to_generate_special_publication',
									 publication_list: publication_list,
		           					 to_email_address : send_to_address
		           					 
					                  	},
								 cache: false,
								 xhrFields : {
										responseType : 'blob'
									},
								 beforeSend: function () { },
								 success: function(data) {
									 //console.log(data)
										$('#elisDocumentPreview').modal({
			     	    	 			 backdrop: 'static',
			     	    				});
									 
										 var blob = new Blob(
												[ data ],
												{
													type : "application/pdf"
												});
									var objectUrl = URL
												.createObjectURL(blob);
										// window.open(objectUrl);
										console.log("success ajax");

 	    							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
										
										
										
								      
								 },
								 
							 });
	 		                  
	 		                  
	 		                  	 		                    	 		    
          }) ;
 		                
		            
			        
		$("#btnAddToSP").click(function(event){	  
			var confirmText = "<br><br><h5> You have requested to add this application details to the Special Publication list. </h5>  <br> <span style='color:red'>Pls Confirm</span> <br><br>";

			
			
			
			bootbox.confirm({
			    title: "Adding applications to Special Publication!",
			    message: confirmText,
			    buttons: {
			        cancel: {
			            label: '<i class="fa fa-times"></i> Cancel'
			        },
			        confirm: {
			            label: '<i class="fa fa-check"></i> Confirm'
			        }
			    },
			    callback: function (result) {
			        console.log('This was logged in the callback: ' + result);
			        if(result){
						$("#addOldCaseModal").modal("hide");
						
						$("#sp_ar_name").val( $("#rs_ar_name").val());
			        	$("#sp_grantor_name").val($("#rs_grantor_name").val());
					    $("#sp_case_number").val($("#rs_case_number").val());
					    $("#sp_locality").val($("#rs_locality").val());
					    $("#sp_job_number").val($("#rs_job_number").val());
					    
					    
					    
					    
					    $("#sp_type_of_interest").val($("#rs_type_of_interest").val());
					    $("#sp_extent").val($("#rs_extent").val());
					    $("#sp_registry_mapref").val($("#rs_registry_mapref").val());
					    
					    $('#specialPublicationList').tab('show');
					    $('#btnActionsSP').show();
					    
						
					   
					}
					
			    }
			});
			
		});      
			      	        
			        
			  
		$("#btnSaveSP").click(function(){
 		 	 
 		    var confirmText = "<br><br><h5> Pls select the publication agency to sent list to</h5>  <br> <span style='color:red'>Note that this cannot be undone!</span> <br><br>";
 		
 			bootbox.prompt({
 			    title: "Sending applications for Publication!",
 			    message: confirmText,
 			    inputType: 'select',
 			    required :true,
 			    inputOptions: [
	 			    {
	 			        text: 'Choose agency...',
	 			        value: '',
	 			    },
	 			    {
	 			        text: 'Daily Graphic',
	 			        value: 'judeyamoah@gmail.com',
	 			    },
	 			    {
	 			        text: 'The Spectator',
	 			        value: 'judeyamoah@gmail.com',
	 			    },
	 			    {
	 			        text: 'The Daily Times',
	 			        value: 'judeyamoah@gmail.com',
	 			    }
	 			    ],
 			    callback: function (result) {
 			        //console.log('This was logged in the callback: ' + result);
 			        
 			        if(result) {
 		                
 		              	try{
							//Generating Doc , Attach to case
							let send_to_address = result;
		                
			                let publication_list = $("#lc_search_report_summary_details").val();
			                
		 		                 $.ajax({
									 type: "POST",
									 url: "GenerateCaseReports",
									 target : '_blank',
									 data: {
										 request_type: 'request_to_generate_special_publication_on_case',
										 publication_list: publication_list,
										 case_number: $('#sp_case_number').val(),
			           					 to_email_address : send_to_address
			           					 
						                  	},
									 cache: false,
									 xhrFields : {
											responseType : 'blob'
										},
									 beforeSend: function () { },
									 success: function(data) {
										 //console.log(data)
											$('#elisDocumentPreview').modal({
				     	    	 			 backdrop: 'static',
				     	    				});
										 
											 var blob = new Blob(
													[ data ],
													{
														type : "application/pdf"
													});
										var objectUrl = URL
													.createObjectURL(blob);
											// window.open(objectUrl);
											console.log("success ajax");
	
	 	    							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
											
											
											
									      
									 },
									 
								 });
							
							//Send Mail with doc
							
						}catch(e){
						
						}
					}
				}
			});
 		
 		});    
	
	
		$("#btnSendPublicationList").click(function(event){
 		 	 
 		    var confirmText = "<br><br><h5> Pls select the publication agency to sent list to</h5>  <br> <span style='color:red'>Note that this cannot be undone!</span> <br><br>";
 		    
 		    
	 	    bootbox.prompt({
 			    title: "Sending applications for Publication!",
 			    message: confirmText,
 			    inputType: 'select',
 			    required :true,
 			    inputOptions: [
	 			    {
	 			        text: 'Choose agency...',
	 			        value: '',
	 			    },
	 			    {
	 			        text: 'Daily Graphic',
	 			        value: 'judeyamoah@gmail.com',
	 			    },
	 			    {
	 			        text: 'The Spectator',
	 			        value: 'judeyamoah@gmail.com',
	 			    },
	 			    {
	 			        text: 'The Daily Times',
	 			        value: 'judeyamoah@gmail.com',
	 			    }
	 			    ],
 			    callback: function (result) {
 			        //console.log('This was logged in the callback: ' + result);
 			        
 			        if(result) {
 		                
 		              try{
	
					}catch(e){
						
					}
 		              
 			            var send_to_address = result;
 		                var publication_list = storeTblValues();
 		                publication_list = JSON.stringify(publication_list);
 		                //console.log(publication_list);
 		                //modified_by = localStorage.getItem("fullname");
 		                //modified_by_id = localStorage.getItem("userid");
 		                
 		    
 		                function storeTblValues()
 		                {
 		                    var TableData = new Array();
 		    
 		                    $('#unpublishedDataTable tr').each(function(row, tr){
 		                        TableData[row]={
 		                          "client_number" : $(tr).find('td:eq(1)').text().trim(), //Get the number from the client
 		                          "case_number" : $(tr).find('td:eq(3)').text().trim() ,
 		                          "business_process_sub_name" : $(tr).find('td:eq(4)').text().trim(),
								  "glpin" : $(tr).find('td:eq(5)').text().trim(),
 		                          "ar_name" : $(tr).find('td:eq(6)').text().trim(),
 		                          "location" : $(tr).find('td:eq(7)').text().trim(),
 		                          "grantor" : $(tr).find('td:eq(8)').text().trim(),
 		                          "extent" : $(tr).find('td:eq(9)').text().trim(),
 		                          "interest" : $(tr).find('td:eq(10)').text().trim(),
 		                          "registry_map" : $(tr).find('td:eq(11)').text().trim(),
 		                          "description" : $(tr).find('td:eq(12)').text().trim()                       
 		                        }    
 		                    }); 
 		                    
 		                 
 		                    TableData.shift();  // first row will be empty - so remove
 		                    return TableData;
 		                }
 		                //console.log("tESTING First : " + typeof publication_list);
 		                               
	 		              $.ajax({
		 		               type: "POST",
		 		               url: "Case_Management_Serv",
		 		               data: {
	 		                          request_type: 'select_set_cases_published',
	 		                          publication_list: publication_list,
	 		                          to_email_address: send_to_address
	 		                          //modified_by: modified_by,
	 		                          //modified_by_id: modified_by_id
		 		                },
		 		               cache: false,
		 		               beforeSend: function () {
		 		            	   //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		 		               },
		 		               success: function(jobdetails) {
		 		                
		 		                  //var json_p = JSON.parse(jobdetails);
		 		                  
		 		                  /* var json_p_details = JSON.parse(json_p.jobdetails);
		 		                  console.log(json_p_details) */
		 		    
		 		                  // alert("All Applications sent for Publication, Awaiting Date of Publication");
		 		                  $("#general_message_dialog").modal();
		 		                  //$('#general_message_dialog #general_message_dialog_msg').val(jobdetails);
		 		                  $('#general_message_dialog #general_message_dialog_msg_new').val("All Applications sent for Publication, Awaiting Date of Publication");
		 		                      
		 		                  //Reload Page
		 		               //location.reload(publication_list);
		 		                  //console.log("test list 1: " + publication_list);
		 		                 var json_p = JSON.parse(publication_list);
		 		                  
		 		                 /*var sorted_publication_list = json_p.reduce(function (r, a) {
		 		                    r[a.location] = r[a.location] || [];
		 		                    r[a.location].push(a);
		 		                    return r;
		 		                 }, Object.create(null));*/

		 		                var sorted_publication_list = _.groupBy(json_p, 'location');
		 		               const ordered = {};
								Object.keys(sorted_publication_list).sort().forEach(function(key) {
								  ordered[key] = sorted_publication_list[key];
								});
								  
		 		                 $.ajax({
									 type: "POST",
									 url: "GenerateCaseReports",
									 target : '_blank',
									 data: {
										 request_type: 'request_to_generate_publication_list',
										 publication_list: JSON.stringify(ordered),
			           					 to_email_address : send_to_address
			           					 
						                  	},
									 cache: false,
									 xhrFields : {
											responseType : 'blob'
										},
									 beforeSend: function () {
										// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
										//console.log("before ajax");
										
									 },
									 success: function(data) {
										 //console.log(data)
											$('#elisDocumentPreview').modal({
				     	    	 			 backdrop: 'static',
				     	    				});
										 
 										 var blob = new Blob(
													[ data ],
													{
														type : "application/pdf"
													});
										var objectUrl = URL
													.createObjectURL(blob);
											// window.open(objectUrl);
											console.log("success ajax");

     	    							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
											
											
											
									      
									 }
									
									 });
		 		                  
		 		                  
		 		                  	 		                    	 		    
		 		               }
	 		               });
	 		                
 		            }
 			        
 			        
 			        
 			    }
 			});
 	  });
 	  
 	  
 	  
 	  
 	  
 	  
 	  $("#btnPublishedListDateUpdate").click(function(event){
				
 		  var confirmText = "Are you sure you set publication date for all selected applications?";
		    if(confirm(confirmText)) {
		        
	    		
	      		
	      		published_date = $("#date_sent_for_publication").val();
	      		if(published_date){
	      			var publication_list1 = storeTblValues();
		      		//console.log(publication_list1);
		      		publication_list1 = JSON.stringify(publication_list1);
		      		//console.log(publication_list1);
	      		
	      		//modified_by = localStorage.getItem("fullname");
	      		//modified_by_id = localStorage.getItem("userid");
	      		//publication_list = JSON.parse(publication_list);

	      		function storeTblValues()
	      		{
	      		    var TableData = new Array();

	      		    $('#publishedDataTable tbody tr.selected').each(function(row, tr){
	      		    	
	      		    	 	TableData[row]={
 	      		            "case_number" : $(tr).find('td:eq(3)').text().trim() ,
 	      		         	"job_number" : $(tr).find('td:eq(1)').text().trim() ,
 	      		            "ar_name" : $(tr).find('td:eq(5)').text().trim(),
 	      		            "client_number" : $(tr).find('td:eq(0)').text().trim(), //Get the number from the client
 	      		            "business_process_sub_name" : $(tr).find('td:eq(4)').text().trim()
	    	      		      }       
	      		    	 
	      		    }); 
	      		    //TableData.shift();  // first row will be empty - so remove
	      		    return TableData;
	      		}
   		
				    // console.log(publication_list1); 					   
				    $.ajax({
						 type: "POST",
						 url: "Case_Management_Serv",
						 data: {
			                	request_type: 'select_udate_published_date_on_case',
			                	publication_list1: publication_list1,
			                	published_date: published_date,
			                	//modified_by: modified_by,
			                	//modified_by_id: modified_by_id
			           		 },
						 cache: false,
						 beforeSend: function () {
							// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
						 },
						 success: function(jobdetails) {
							
							 //var json_p = JSON.parse(jobdetails);
							 
							 location.reload(true);

				           
							    

						 }
						 });
	      			}else{
	      				alert("Date Field is required");
	      			}
	      		}
		    return false;
			}); 
 	  
 	  
 	//find_new_update			 
      $("#publishedButNotWorkedOnModal").on("show.bs.modal", function(e) {

      	
          $.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
		                	request_type: 'select_load_published_but_not_worked_on',
		                	
	                  	},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(response) {
					//console.log(response)
					if(response=='{"success" : true, "data" : null}'){
						return ;
					} else{
						
						try{
							var json_p = JSON.parse(response);
							//console.log("Loaded here : " + json_p.success.toString());
							
							var table = $('#jobs_publishedButNotWorkedOnTable');
						    table.find("tbody tr").remove();
						    
						    $(json_p.data).each(function () {
				               
							table.append("<tr><td>" + this.job_number + "</td><td>" +this.ar_name + "</td><td>" +this.business_process_name + "</td><td>" +this.publicity_date + "</td>"
							    	+ ' <td> '
							    	+ ' <button ' 
		                    		+ ' class="btn btn-info btn-icon-split" ' 
		                        	+ ' data-title="Add to Batch List" ' 
		                        	//+ ' id="btnAddToBatchlist-' + this.job_number
		                        	+ ' data-job_number="' + this.job_number + '" '
		                        	+ ' data-ar_name="' + this.ar_name +'"  '
		                        	+ ' data-business_process_sub_name="' + this.business_process_sub_name +'" '
		                        	+ ' data-target="#askForPurposeOfBatching" data-toggle="modal" >'
		                        	+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span>'
		                        	+ ' <span class="text">Add to Batch</span>'
		                        	+ ' </button>'

					    		    + "</tr>");
				        
				              
								    
							        
				        	});
						    
						    
						}catch(e){
							console.log(e)
						}
						
						
						
					}    
					
 
				 }
		     });
           
           
      });	


	  $('#edit_application_for_publication').on('shown.bs.modal', function(e){
         	      	  
		// validation code here
		   e.preventDefault();
	   //console.log('how are your search new');
	   
	   var job_number = $("#job_search_value").val().toUpperCase();

	   if (!(job_number.length >= 10)) {
		$.notify({
				message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please Valid Job Number </span>',
			}, {
				type: 'danger'
			});

			$('#edit_application_for_publication').modal('hide');
			
			return;
		}

		$.ajax({
			type: "POST",
			url: "Case_Management_Serv",
			data: {
				   request_type: 'load_application_details_by_job_number',
				   job_number:job_number},
			cache: false,
			beforeSend: function () {
			   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			},
			success: function(jobdetails) {
			   
			   // console.log(jobdetails);
			   
				var result = JSON.parse(jobdetails);
				
				   //console.log(result)
				   
			   if(result.job_detail !==null){
				  //console.log("not null")
				  
				   $("job_number_placeholder").append(result.job_detail.job_number);  
				   
				   
				   $("#fe_client_name").val( result.transaction_details.ar_name);
				  $("#febusiness_process_sub_name").val(result.job_detail.business_process_sub_name); 
					  
					  
				  
				 $("#fe_job_number").val(result.job_detail.job_number);
				 
				 
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
					 
  
				  
				   var fe_case_number_new= result.transaction_details.transaction_number;
				   
				   //console.log("case is " + fe_case_number_new);
				  
				  $.ajax({
				   type: "POST",
				   url: "Case_Management_Serv",
				   data: {
						  request_type: 'select_get_parties_by_case',
						  case_number: fe_case_number_new},
				   cache: false,
				   beforeSend: function () {
					  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				   },
				   success: function(jobdetails) {
					  
					   //console.log("details: " + jobdetails);
					  if(jobdetails.includes("Data Not Received")){
						  //console.log("not ");
					  }else{
						  
					  
					   var result = JSON.parse(jobdetails);
					   
					   var table = $('#party_details_datatable');
						table.find("tbody tr").remove();
					
						//console.log(jobdetails);
						var json_p = JSON.parse(jobdetails);
						
						$(json_p).each(function () {
							   
							   //   result.append('<div class="form-group"> <label><input type="radio" name="bl_milestone" value="' + this.ms_id + '" /> ' + this.milestone_description + '</label>  </div>');
							  //<td>" + this.ar_client_id + "</td>
								  
									table.append("<tr><td>" +this.ar_name + "</td><td>" +this.ar_gender + "</td><td>" +this.ar_cell_phone + "</td><td>" +this.type_of_party + "</td>"
											
											
												 
										  +  '<td><p data-placement="top"  title="Edit Party"> ' 
										  +'<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"'
										  +'data-target="#addeditpartyGeneral"' 
										  +' data-target-id="' + this.ar_client_id 
										  +'"  data-ar_name="' + this.ar_name 
										  +'"  data-ar_gender="' + this.ar_gender 
										 +'"  data-ar_address="' + this.ar_address
										  +'"  data-ar_cell_phone="' + this.ar_cell_phone 
										  +'" data-ar_cell_phone2="' + this.ar_cell_phone2
										  +'" data-ar_tin_no="' + this.ar_tin_no 
										  +'" data-ar_id_type="' + this.ar_id_type 
										  +'" data-ar_id_number="' + this.ar_id_number
										  +'" data-ar_location="' + this.ar_location 
										  +'" data-ar_district="' + this.ar_district 
										  +'" data-type_of_party="' + this.type_of_party
										  +'" data-ar_region="' + this.ar_region
										  +'" data-ar_person_type="' + this.ar_person_type
										  + '"> ' 
										  +'<span class="icon text-white-50"> <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button></p></td>'
										   
							 + "</tr>");
									
							  });
						  
					

				   }}
				   });
				  
				  
				  
				  
				  
			  }else{
				  
				  $.notify({
					  message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number not Found </span>',
				  }, {
					  type: 'danger'
				  });
				  
			  }
				   
				   
				   
				 //-----------------------------  
				 


			}
			}); 
   });

   $('#frmFurtherEntries_pm').on('submit', function(e){
	// validation code here
	e.preventDefault();
	
		
   var registry_mapref = $("#fe_registry_mapref").val();
   var job_number = $("#fe_job_number").val();
	var locality =  $("#fe_locality").val();
	   
	var case_number 		= $("#fe_case_number").val();
	var transaction_number 	= $("#fe_transaction_number").val();
	var extent				= $("#fe_extent").val();
	var type_of_interest	= $("#fe_type_of_interest").val();
	var modified_by 		= localStorage.getItem("fullname");
	var modified_by_id		= localStorage.getItem("userid");
	
	//console.log('form submited Clicked New: ' + registry_mapref);
	
	
	 $.ajax({
			type: "POST",
			url: "Case_Management_Serv",
			data: {
				   request_type			: 'further_entries_update_case_for_publication',
				   job_number:job_number,
				   locality :  locality,
				   registry_mapref:registry_mapref,

				   case_number   			: case_number,
				   transaction_number		: transaction_number,
				   extent   				: extent,
				   type_of_interest 		: type_of_interest,
				   modified_by 			: modified_by,
				   modified_by_id 			: modified_by_id
				   },
			cache: false,
			beforeSend: function () {
				//$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			},
			success: function(jobdetails) {
					var result = JSON.parse(jobdetails);
					//console.log(jobdetails)
				   if(result.data.includes('Success')){
					  
					document.getElementById('frmFindJobForPublication').submit();

					alert('Case details saved successfully.');

					$("#rs_locality").val(locality);
					//$("#rs_job_number").val(job_number);
					$("#rs_registry_mapref").val(registry_mapref);
					// $("#rs_case_number").val(case_number);
					// $("#rs_transaction_number").val(transaction_number);
					$("#rs_extent").val(extent);
					$("#rs_type_of_interest").val(type_of_interest);


					$('#edit_application_for_publication').modal('hide')

					$.notify({
						message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Case details saved successfully.</span>',
					}, { type : 'success', z_index : 9999 });

					   
				   } else{
					  
					$.notify({
						message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error. Contact IT for support.</span>',
					}, { type : 'danger' , z_index: 9999  });

					alert('Error. Contact IT for support.');
				   }
			}
		   
   }); });
		
 	  
});