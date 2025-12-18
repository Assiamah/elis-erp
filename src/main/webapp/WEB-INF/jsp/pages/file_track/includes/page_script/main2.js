$(document).ready(function(){
	
	//$('#add_selected_files').hide();
	
	//var tbl = document.getElementById("table_list");
	
	/*$('input[type="checkbox"]').change(function() {
		if (tbl.rows.length == 0) {
			$.toast({
				heading: 'Warning',
				text: 'Action cannot perform, the table is empty.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
		} else {
		    if($(this).is(":checked")) {
		        $("#add_selected_files").show();
		    } else {
		        $("#add_selected_files").hide();
		    }
		}
	});*/
	
	$('#search_tab').show();
	$('#incoming_tab').hide();
	$('#outgoing_tab').hide();
	$('#within_unit_tab').hide();
	
	$('#letter_form').hide();
	$('#file_form').hide();
	
	$("#application_type").change(function(){
        $(this).find("option:selected").each(function(){
            var optionValue = $(this).attr("value");
            if(optionValue ==  'Letter'){
                $('#letter_form').show()
                $('#file_form').hide()
            } else if(optionValue ==  'File'){
                $('#file_form').show()
                $('#letter_form').hide()
            } else {
				$('#file_form').hide()
                $('#letter_form').hide()
			}
        });
    }).change();
	
	
	$(document).on('submit', '#file_track_form', function(e) {
		e.preventDefault();
		var reference_no = $("#reference_no").val();
      	var application_type = $("#application_type").val();
      	var specific_type = $("#specific_type").val();
      	var application_name = $("#application_name").val();
      	var subject = $("#subject").val();
		var date_of_letter = $("#date_of_letter").val();
		var addressed_to = $("#addressed_to").val();
		var received_from = $("#received_from").val();
		var location = $("#location").val();
		var purpose = $("#purpose").val();
		
		$("#reference_no").keypress(function(){
		    $("#reference_no").removeAttr('style');
		});
		
		$("#application_type").change(function(){
		    $("#application_type").removeAttr('style');
		});
		
		$("#specific_type").change(function(){
		    $("#specific_type").removeAttr('style');
		});
		 
		$("#application_name").keypress(function(){
			$("#application_name").removeAttr('style');
		});
		
		$("#subject").keypress(function(){
			$("#subject").removeAttr('style');
		});
		
		$("#date_of_letter").change(function(){
		    $("#date_of_letter").removeAttr('style');
		});
		
		$("#addressed_to").keypress(function(){
			$("#addressed_to").removeAttr('style');
		});
		
		$("#received_from").keypress(function(){
			$("#received_from").removeAttr('style');
		});
		
		$("#location").keypress(function(){
			$("#location").removeAttr('style');
		});
		
		$("#purpose").keypress(function(){
			$("#purpose").removeAttr('style');
		});
		
		if(application_type == 'Letter') {
			if(!reference_no || !specific_type || !application_name || !subject || !date_of_letter || !purpose) {
				$.toast({
					heading: 'Warning',
					text: 'Please fill the required fields.',
					showHideTransition: 'slide',
					icon: 'error',
					loaderBg: '#f2a654',
					position: 'bottom-right',
					hideAfter: 10000 
		   		})
				if(!reference_no) {
					$("#reference_no").css({ 'border': '1px solid red'});
				}
				if(!specific_type) {
					$("#specific_type").css({ 'border': '1px solid red'});
				}
				if(!application_name) {
					$("#application_name").css({ 'border': '1px solid red'});
				}
				if(!subject) {
					$("#subject").css({ 'border': '1px solid red'});
				}
				if(!date_of_letter) {
					$("#date_of_letter").css({ 'border': '1px solid red'});
				}
				if(!purpose) {
					$("#purpose").css({ 'border': '1px solid red'});
				}
			} else {
				var $this = $('#btn-save');
		        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
		        if ($('#btn-login').html() !== loadingText) {
		          $this.data('original-text', $('#btn-save').html());
		          $this.html(loadingText);
		          $('#btn-save').prop('disabled', true);
		          $('#btn-close').hide();
		        }
		        
		        $.ajax({
					type: "POST",
					url: "files_track",
					data: {
						request_type: "insert_file",
						reference_no: reference_no,
						application_type: application_type,
						specific_type: specific_type,
						application_name: application_name,
						subject_location: subject,
						date_of_letter: date_of_letter,
						addressed_to: addressed_to,
						received_from: received_from,
						purpose: purpose
					},
					cache: false,
					success: function(results){
						console.log(results);
						json_data = JSON.parse(results)
						if(json_data.success == true) {
							$('#btn-save').prop('disabled', false);
							$('#btn-close').show();
							$this.html($this.data('original-text'));
							$.toast({
					      		heading: 'Success',
								text: 'New reference number has been added successfully.',
								showHideTransition: 'slide',
								icon: 'success',
								loaderBg: '#f96868',
								position: 'bottom-right',
								hideAfter: 10000 
					    	})
							$('#file_track_form')[0].reset();
						} else {
							$('#btn-save').prop('disabled', false);
							$('#btn-close').show();
							$this.html($this.data('original-text'));
							$.toast({
					      		heading: 'System Failed',
					      		text: 'Sorry! The reference number has already been added.',
					      		showHideTransition: 'slide',
					      		icon: 'error',
					      		loaderBg: '#f2a654',
					      		position: 'bottom-right',
					      		hideAfter: 10000 
					    	})
							$("#reference_no").css({ 'border': '1px solid red'});
						}
					}
				})
			}
		} else if(application_type == 'File') {
			if(!reference_no || !specific_type || !application_name || !location || !purpose) {
				$.toast({
					heading: 'Warning',
					text: 'Please fill the required fields.',
					showHideTransition: 'slide',
					icon: 'error',
					loaderBg: '#f2a654',
					position: 'bottom-right',
					hideAfter: 10000 
		   		})
				if(!reference_no) {
					$("#reference_no").css({ 'border': '1px solid red'});
				}
				if(!specific_type) {
					$("#specific_type").css({ 'border': '1px solid red'});
				}
				if(!application_name) {
					$("#application_name").css({ 'border': '1px solid red'});
				}
				if(!location) {
					$("#location").css({ 'border': '1px solid red'});
				}
				if(!purpose) {
					$("#purpose").css({ 'border': '1px solid red'});
				}
			} else {
				var $this = $('#btn-save');
		        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
		        if ($('#btn-login').html() !== loadingText) {
		          $this.data('original-text', $('#btn-save').html());
		          $this.html(loadingText);
		          $('#btn-save').prop('disabled', true);
		          $('#btn-close').hide();
		        }
		        
		        $.ajax({
					type: "POST",
					url: "files_track",
					data: {
						request_type: "insert_file",
						reference_no: reference_no,
						application_type: application_type,
						specific_type: specific_type,
						application_name: application_name,
						subject_location: location,
						received_from: received_from,
						purpose: purpose
					},
					cache: false,
					success: function(results){
						console.log(results);
						json_data = JSON.parse(results)
						if(json_data.success == true) {
							$('#btn-save').prop('disabled', false);
							$('#btn-close').show();
							$this.html($this.data('original-text'));
							$.toast({
					      		heading: 'Success',
								text: 'New reference number has been added successfully.',
								showHideTransition: 'slide',
								icon: 'success',
								loaderBg: '#f96868',
								position: 'bottom-right',
								hideAfter: 10000 
					    	})
							$('#file_track_form')[0].reset();
						} else {
							$('#btn-save').prop('disabled', false);
							$('#btn-close').show();
							$this.html($this.data('original-text'));
							$.toast({
					      		heading: 'System Failed',
					      		text: 'Sorry! The reference number has already been added.',
					      		showHideTransition: 'slide',
					      		icon: 'error',
					      		loaderBg: '#f2a654',
					      		position: 'bottom-right',
					      		hideAfter: 10000 
					    	})
							$("#reference_no").css({ 'border': '1px solid red'});
						}
					}
				})
			}
		}
		else {
			if(!application_type) {
				$("#application_type").css({ 'border': '1px solid red'});
				
				$.toast({
					heading: 'Warning',
					text: 'Please select application type.',
					showHideTransition: 'slide',
					icon: 'error',
					loaderBg: '#f2a654',
					position: 'bottom-right',
					hideAfter: 10000 
		   		})
			}
		}
	})
	
	
	$('#btn-search').click(function() {
		
		$('#search_tab').show();
		$('#incoming_tab').hide();
		$('#outgoing_tab').hide();
		$('#within_unit_tab').hide();
		
		var search_keyword = $("#search_keyword").val();
		
		$("#search_keyword").keypress(function(){
		    $("#search_keyword").removeAttr('style');
		});
		
		if(!search_keyword) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!search_keyword) {
				$("#search_keyword").css({ 'border': '1px solid red'});
			}
		} else {
			$('#table_list').DataTable().clear().destroy();
			
			var $this = $('#btn-search');
	        var loadingText = '<span class="text-dark"><i class="fa fa-spinner fa-spin fa-fw"></i>Searching...</span>';
	        if ($('#btn-login').html() !== loadingText) {
	          $this.data('original-text', $('#btn-search').html());
	          $this.html(loadingText);
	          $('#btn-search').prop('disabled', true);
	        }
	        
	        let dataSet = [];
    		var num = '';
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_search_files",
					search_keyword: search_keyword
				},
				cache: false,
				success: function(results){
					//console.log(results);
					response = JSON.parse(results)
					if(response.success == true) {
						$this.html($this.data('original-text'));
						$('#btn-search').prop('disabled', false);
						
						for(let i = 0; i<response.data.length; i++) {
							let html = [];
							num = (+num + 1);
							let _id = `${response.data[i]._id}`
							let reference_no = `${response.data[i].reference_no}`
							let application_name = `${response.data[i].application_name}`
							let application_type = `${response.data[i].application_type}`
							let specific_type = `${response.data[i].specific_type}`
							let subject_location = `${response.data[i].subject_location}`
							let date_of_letter = `${response.data[i].date_of_letter}`
							let addressed_to = `${response.data[i].addressed_to}`
							let received_from = `${response.data[i].received_from}`
							let unit_batched_to = `${response.data[i].unit_batched_to}`
							let unit_officer = `${response.data[i].unit_officer}`
							let unit_created_by = `${response.data[i].unit_created_by}`
							let purpose = `${response.data[i].purpose}`
							let status = `${response.data[i].status}`
							let created_on = `${response.data[i].created_on}`
							let check_input = `
							<td>
							<div class="d-flex justify-content-start">
								<input type="checkbox" name="check_item" class="form-check-label check-application" />
							</div>
							</td>
							`
							let actions =
							`
			                
							<div class="text-center">
			                  <a class="btn btn-info data-${_id}" data-reference_no="${reference_no}" href="#" role="button" data-toggle="modal" data-target="#batched_file_modal" aria-haspopup="true" aria-expanded="false">
							    <i class="fas fa-info m-1"></i>
							  </a>
			                </div>
			                
			                
									
							`
							
							html.push(check_input);
							html.push(reference_no);
			                html.push(application_type);
			                html.push(application_name);
			                html.push(subject_location);
			                //html.push(subject_location);
			                //html.push(destination);
			                html.push(purpose);
			                //html.push(update_date_time);
			                html.push(actions);

                			dataSet.push(html);
						}
						
						$('#table_list').DataTable({
			                pageLength: 10,
			                data: dataSet
			            });
					} else {
						$this.html($this.data('original-text'));
						$('#btn-search').prop('disabled', false);
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! There is no record match. Please try again',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
				    	$('#table_list').DataTable({
			                pageLength: 10,
			                data: dataSet
			            });
					}
				}
			})
		}
	});
	
	$(document).on('submit', '#batch_purpose_form', function(e) {
		e.preventDefault();
		
		var purpose = $("#batch_purpose_form #purpose").val();
		
		if(!purpose) {
			$.toast({
	      		heading: 'System Failed',
	      		text: 'Please enter purpose to proceed',
	      		showHideTransition: 'slide',
	      		icon: 'error',
	      		loaderBg: '#f2a654',
	      		position: 'bottom-right',
	      		hideAfter: 10000 
	    	})
		} else {
			$("#batch_purpose").modal('hide');
			$("#viewBatchlistModal").modal('show');
		}
	})
	
	/*$("#batchlistdataTable").on("hidden.bs.modal", function() {
	    $("#batchlistdataTable").html("");
	});*/
	
	$('#3').click(function() {
		$('#search_tab').hide();
		$('#incoming_tab').show();
		$('#outgoing_tab').hide();
		$('#within_unit_tab').hide();
		
		let dataSet = [];
		var num = '';
		
		$('#incoming_list').DataTable().clear().destroy();
        
        $.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_incoming_application"
			},
			cache: false,
			success: function(results){
				console.log(results);
				response = JSON.parse(results)
				if(response.success == true) {
					
					for(let i = 0; i<response.data.length; i++) {
						let html = [];
						num = (+num + 1);
						let _id = `${response.data[i]._id}`
						let reference_no = `${response.data[i].reference_no}`
						let application_name = `${response.data[i].application_name}`
						let application_type = `${response.data[i].application_type}`
						let specific_type = `${response.data[i].specific_type}`
						let subject_location = `${response.data[i].subject_location}`
						let date_of_letter = `${response.data[i].date_of_letter}`
						let addressed_to = `${response.data[i].addressed_to}`
						let received_from = `${response.data[i].received_from}`
						let unit_batched_to = `${response.data[i].unit_batched_to}`
						let unit_officer = `${response.data[i].unit_officer}`
						let unit_created_by = `${response.data[i].unit_created_by}`
						let purpose = `${response.data[i].purpose}`
						let status = `${response.data[i].status}`
						let created_on = `${response.data[i].created_on}`
						let check_input = `
						<td>
						<div class="d-flex justify-content-start">
							<input type="checkbox" name="check_item" class="form-check-label check-application" />
						</div>
						</td>
						`
						let actions =
						`
						<div class="text-center">
			                  <a class="btn btn-info data-${_id}" data-reference_no="${reference_no}" href="#" role="button" data-toggle="modal" data-target="#batched_file_modal" aria-haspopup="true" aria-expanded="false">
							    <i class="fas fa-info m-1"></i>
							  </a>
			                </div>
		                
		                
		                
		                
								
						`
						
						html.push(check_input);
						html.push(reference_no);
		                html.push(application_type);
		                html.push(application_name);
		                html.push(subject_location);
		                //html.push(subject_location);
		                //html.push(destination);
		                html.push(purpose);
		                //html.push(update_date_time);
		                html.push(actions);

            			dataSet.push(html);
					}
					
					$('#incoming_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				} else {
					$.toast({
			      		heading: 'System Failed',
			      		text: 'Sorry! There is no record match. Please try again',
			      		showHideTransition: 'slide',
			      		icon: 'error',
			      		loaderBg: '#f2a654',
			      		position: 'bottom-right',
			      		hideAfter: 10000 
			    	})
			    	$('#incoming_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				}
			}
		})
			 
			  $("#body-bg-3").addClass('bg-active');
			 $("#body-bg-2, #body-bg-4").removeClass('bg-active');
			 $('#text-3').addClass('text-white');
			 $('#text-2, #text-4').addClass('text-gray-800');
	})
	
	$('#2').click(function() {
		$('#search_tab').hide();
		$('#incoming_tab').hide();
		$('#outgoing_tab').show();
		$('#within_unit_tab').hide();
		
		let dataSet = [];
		var num = '';
		
		$('#outgong_list').DataTable().clear().destroy();
        
        $.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_outgoing_application"
			},
			cache: false,
			success: function(results){
				console.log(results);
				response = JSON.parse(results)
				if(response.success == true) {
					
					for(let i = 0; i<response.data.length; i++) {
						let html = [];
						num = (+num + 1);
						let _id = `${response.data[i]._id}`
						let reference_no = `${response.data[i].reference_no}`
						let application_name = `${response.data[i].application_name}`
						let application_type = `${response.data[i].application_type}`
						let specific_type = `${response.data[i].specific_type}`
						let subject_location = `${response.data[i].subject_location}`
						let date_of_letter = `${response.data[i].date_of_letter}`
						let addressed_to = `${response.data[i].addressed_to}`
						let received_from = `${response.data[i].received_from}`
						let unit_batched_to = `${response.data[i].unit_batched_to}`
						let unit_officer = `${response.data[i].unit_officer}`
						let unit_created_by = `${response.data[i].unit_created_by}`
						let purpose = `${response.data[i].purpose}`
						let status = `${response.data[i].status}`
						let created_on = `${response.data[i].created_on}`
						let check_input = `
						<td>
						<div class="d-flex justify-content-start">
							<input type="checkbox" name="check_item" class="form-check-label check-application" />
						</div>
						</td>
						`
						let actions =
						`
						<div class="text-center">
			                  <a class="btn btn-info data-${_id}" data-reference_no="${reference_no}" href="#" role="button" data-toggle="modal" data-target="#batched_file_modal" aria-haspopup="true" aria-expanded="false">
							    <i class="fas fa-info m-1"></i>
							  </a>
			                </div>
		                
		                
								
						`
						
						html.push(check_input);
						html.push(reference_no);
		                html.push(application_type);
		                html.push(application_name);
		                html.push(subject_location);
		                //html.push(subject_location);
		                //html.push(destination);
		                html.push(purpose);
		                //html.push(update_date_time);
		                html.push(actions);

            			dataSet.push(html);
					}
					
					$('#outgong_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				} else {
					$.toast({
			      		heading: 'System Failed',
			      		text: 'Sorry! There is no record match. Please try again',
			      		showHideTransition: 'slide',
			      		icon: 'error',
			      		loaderBg: '#f2a654',
			      		position: 'bottom-right',
			      		hideAfter: 10000 
			    	})
			    	$('#outgong_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				}
			}
		})
		
		 $("#body-bg-2").addClass('bg-active');
			 $("#body-bg-3, #body-bg-4").removeClass('bg-active');
			 $('#text-2').addClass('text-white');
			 $('#text-3, #text-4').addClass('text-gray-800');
			
		
	})
	
	
	$('#4').click(function() {
		$('#search_tab').hide();
		$('#incoming_tab').hide();
		$('#outgoing_tab').hide();
		$('#within_unit_tab').show();
		
		let dataSet = [];
		var num = '';
		
		$('#within_unit_list').DataTable().clear().destroy();
        
        $.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_application_within_unit"
			},
			cache: false,
			success: function(results){
				console.log(results);
				response = JSON.parse(results)
				if(response.success == true) {
					
					for(let i = 0; i<response.data.length; i++) {
						let html = [];
						num = (+num + 1);
						let _id = `${response.data[i]._id}`
						let reference_no = `${response.data[i].reference_no}`
						let application_name = `${response.data[i].application_name}`
						let application_type = `${response.data[i].application_type}`
						let specific_type = `${response.data[i].specific_type}`
						let subject_location = `${response.data[i].subject_location}`
						let date_of_letter = `${response.data[i].date_of_letter}`
						let addressed_to = `${response.data[i].addressed_to}`
						let received_from = `${response.data[i].received_from}`
						let unit_batched_to = `${response.data[i].unit_batched_to}`
						let unit_officer = `${response.data[i].unit_officer}`
						let unit_created_by = `${response.data[i].unit_created_by}`
						let purpose = `${response.data[i].purpose}`
						let status = `${response.data[i].status}`
						let created_on = `${response.data[i].created_on}`
						let check_input = `
						<td>
						<div class="d-flex justify-content-start">
							<input type="checkbox" name="check_item" class="form-check-label check-application" />
						</div>
						</td>
						`
						let actions =
						`
						<div class="text-center">
			                  <a class="btn btn-info data-${_id}" data-reference_no="${reference_no}" href="#" role="button" data-toggle="modal" data-target="#batched_file_modal" aria-haspopup="true" aria-expanded="false">
							    <i class="fas fa-info m-1"></i>
							  </a>
			                </div>
		                
		                
								
						`
						
						html.push(check_input);
						html.push(reference_no);
		                html.push(application_type);
		                html.push(application_name);
		                html.push(subject_location);
		                //html.push(subject_location);
		                //html.push(destination);
		                html.push(purpose);
		                //html.push(update_date_time);
		                html.push(actions);

            			dataSet.push(html);
					}
					
					$('#within_unit_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				} else {
					$.toast({
			      		heading: 'System Failed',
			      		text: 'Sorry! There is no record match. Please try again',
			      		showHideTransition: 'slide',
			      		icon: 'error',
			      		loaderBg: '#f2a654',
			      		position: 'bottom-right',
			      		hideAfter: 10000 
			    	})
			    	$('#within_unit_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				}
			}
		})
		
		 $("#body-bg-4").addClass('bg-active');
		$("#body-bg-2, #body-bg-3").removeClass('bg-active');
		
		$('#text-4').addClass('text-white');
		$('#text-2, #text-3').addClass('text-gray-800');
		
		
	})
	
	$('#batched_file_modal').on('show.bs.modal',function(event) {
		$("#batched_file_modal #ll_reference_no").val($(event.relatedTarget).data('reference_no'));			
	});
	
	$('#btn-load-logs').click(function(e) {
		
		var reference_no = $("#batched_file_modal #ll_reference_no").val();
		
		let dataSet = [];
	 	var num = '';
	 	
		$('#file_logs_tbl').DataTable().clear().destroy();
			  
			$.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_file_logs",
					reference_no: reference_no
				},
				cache: false,
				success: function(results){
					
					response = JSON.parse(results)
					console.log(response)
					
					if(response.success == true) {
						
						for(let i = 0; i<response.data.length; i++) {
							let html = [];
							num = (+num + 1);
							let fl_application_name = response.data[i].application_name
							let fl_division_name = response.data[i].division_name
							let fl_purpose = response.data[i].purpose
							let fl_status = response.data[i].status
							let fl_unit_batched_to = response.data[i].unit_batched_to
							let fl_unit_created_by = response.data[i].unit_created_by
							let fl_updated_on = response.data[i].updated_on
							let fl_unit_officer = response.data[i].unit_officer
							
							
							html.push(num);
							html.push(fl_unit_created_by);
							html.push(fl_unit_batched_to);
			                html.push(fl_unit_officer);
			                html.push(fl_purpose);
			                html.push(fl_updated_on);
			                
	            			dataSet.push(html);
						}
						
						$('#file_logs_tbl').DataTable({
			                pageLength: 10,
			                data: dataSet
			            });
					} else {
						$.toast({
			      		heading: 'System Failed',
			      		text: 'Sorry! There is no record match. Please try again',
			      		showHideTransition: 'slide',
			      		icon: 'error',
			      		loaderBg: '#f2a654',
			      		position: 'bottom-right',
			      		hideAfter: 10000 
			    	})
			    	$('#file_logs_tbl').DataTable({
			                pageLength: 10,
			                data: dataSet
			            });
					}
				}
			})

	})
	
	
});


function toggle(source) {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i] != source)
            checkboxes[i].checked = source.checked;
    }
}

function batch_selected_files() {
	
	$("#batchlistdataTable").find("tr:gt(0)").remove();
		
		if($('#search_tab').is(':visible')){
		  var table1 = document.getElementById("table_list"),
		    table2 = document.getElementById("batchlistdataTable"),
		    checkboxes = document.getElementsByName("check_item");
		}
		
		if($('#incoming_tab').is(':visible')){
		  var table1 = document.getElementById("incoming_list"),
		    table2 = document.getElementById("batchlistdataTable"),
		    checkboxes = document.getElementsByName("check_item");
		}
		
		if($('#outgoing_tab').is(':visible')){
		  var table1 = document.getElementById("outgong_list"),
		    table2 = document.getElementById("batchlistdataTable"),
		    checkboxes = document.getElementsByName("check_item");
		}
		
		if($('#within_unit_tab').is(':visible')){
		  var table1 = document.getElementById("within_unit_list"),
		    table2 = document.getElementById("batchlistdataTable"),
		    checkboxes = document.getElementsByName("check_item");
		}
		
	
		
	var purpose = $("#batch_purpose_form #purpose").val();
		
	for(var i = 0; i < checkboxes.length; i++) {
	
	 	if(checkboxes[i].checked) {
			
	        // create new row and cells
	        var newRow = table2.insertRow(table2.length),
	            cell1 = newRow.insertCell(0),
	            cell2 = newRow.insertCell(1),
	            cell3 = newRow.insertCell(2),
	            cell4 = newRow.insertCell(3),
	            cell5 = newRow.insertCell(4);
	            
	        // add values to the cells
	        cell1.innerHTML = table1.rows[i+1].cells[1].innerHTML;
	        cell2.innerHTML = table1.rows[i+1].cells[3].innerHTML;
	        cell3.innerHTML = table1.rows[i+1].cells[4].innerHTML;
	        cell4.innerHTML = purpose;
	        cell5.innerHTML = `<div class='text-center'><button type='button' class='btn btn-outline-danger text-center' onclick='document.getElementById("batchlistdataTable").deleteRow(${i+1})'><i class='fas fa-trash ml-2'></i></button></div>`;
	       
	    }
	}
    /*let batchlistdataTable = document.querySelector('#batchlistdataTable');
    
	let headers = [...batchlistdataTable.rows[0].cells].map(th => th.innerText);
	for(let row of [...batchlistdataTable.rows].slice(1, batchlistdataTable.rows.length)) {
	    batchList = Object.fromEntries(new Map([...row.cells].map((cell, i) => [headers.at(i), cell.innerText])));
	    //console.log(JSON.stringify(batchList));
	}*/
	
	var _table = document.getElementById("batchlistdataTable");
	var _trLength = _table.getElementsByTagName("tr").length;
	var _jsonData = [];
	var _obj = {};
	
	var _htmlToJSON = function(index){
	    var _tr = _table.getElementsByTagName("tr")[index];
	    var _td = _tr.getElementsByTagName("td");
	    var _arr = [].map.call( _td, function( td ) {
	        return td.innerHTML;
	    }).join( ',' );
	    var _data = _arr.split(",");
	    
	    _obj = {
	         reference_no     : _data[0]
	        ,application_name     : _data[1]
	        ,subject_location     : _data[2]
	        ,purpose     : _data[3]
	    };
	    
	    _jsonData.push(_obj);
	    
	};
	
	for(var j = 1; j < _trLength; j++){
	    _htmlToJSON(j);
	}
	//console.log("html to JSON",_jsonData);​
	
	
	$(document).ready(function (){
		
		$('#remove_all_from_list').click(function(){
			_jsonData = [];
		})
		
		$("#viewBatchlistModal").on("hidden.bs.modal", function() {
	    	_jsonData = [];
	    	//console.log(_jsonData)
		});
		
	    $('#btn_process_batchlist_ft').click(function(){
	        var json_data = JSON.stringify(_jsonData);
	        var unit_to_send_to = $('#viewBatchlistModal #unit_to_send_to').val();
	        var user_to_send_to = $('#viewBatchlistModal #user_to_send_to').val();
	        var unit_division_to_send_to = $('#viewBatchlistModal #unit_division_to_send_to').val();
	        
	        if(json_data == [] || !json_data) {
				$.toast({
		      		heading: 'Warning',
		      		text: 'Please select application to continue',
		      		showHideTransition: 'slide',
		      		icon: 'error',
		      		loaderBg: '#f2a654',
		      		position: 'bottom-right',
		      		hideAfter: 10000 
		    	})
			}else {
				var $this = $('#btn_process_batchlist_ft');
		        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
		        if ($('#btn_process_batchlist_ft').html() !== loadingText) {
		          $this.data('original-text', $('#btn_process_batchlist_ft').html());
		          $this.html(loadingText);
		          $('#btn_process_batchlist_ft').prop('disabled', true);
		          $('#btn_close_process').hide();
		        }
	        
				$.ajax({
					type: "POST",
					url: "files_track",
					data: {
						request_type: "batch_list_to_unit",
						unit_to_send_to: unit_to_send_to,
						user_to_send_to: user_to_send_to,
						unit_division_to_send_to: unit_division_to_send_to,
						json_data: json_data
					},
					cache: false,
					success: function(results){
						console.log(results);
						json_data = JSON.parse(results)
						if(json_data.success == true) {
							$('#btn_process_batchlist_ft').prop('disabled', false);
							$('#btn_close_process').show();
							$this.html($this.data('original-text'));
							$.toast({
					      		heading: 'Success',
								text: 'The application has been batched successfully.',
								showHideTransition: 'slide',
								icon: 'success',
								loaderBg: '#f96868',
								position: 'bottom-right',
								hideAfter: 10000 
					    	})
							$('#viewBatchlistModal').modal('hide');
							
						} else {
							$('#btn_process_batchlist_ft').prop('disabled', false);
							$('#btn_close_process').show();
							$this.html($this.data('original-text'));
							$.toast({
					      		heading: 'System Failed',
					      		text: 'Sorry! something went wrong, try again.',
					      		showHideTransition: 'slide',
					      		icon: 'error',
					      		loaderBg: '#f2a654',
					      		position: 'bottom-right',
					      		hideAfter: 10000 
					    	})
						}
					}
				})
			}  
	        
	    })
	})
}


function remove_all_from_list() {
	var tableHeaderRowCount = 1;
	var table = document.getElementById('batchlistdataTable');
	var rowCount = table.rows.length;
	for (var i = tableHeaderRowCount; i < rowCount; i++) {
	    table.deleteRow(tableHeaderRowCount);
	}
	
	var btn_process_batchlist_ft = document.getElementById('btn_process_batchlist_ft');
	btn_process_batchlist_ft.style.display = "none";
}