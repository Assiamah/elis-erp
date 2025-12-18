$(document).ready(function(){
	
	var option_destinations = '<option>-- select --</option>';
	var option_activities = '<option>-- select --</option>';
	var option_officers = '<option>-- select --</option>';
	
	$.ajax({
		type: "POST",
		url: "files_track",
		data: {
			request_type: "select_destination"
		},
		cache: false,
		success: function(results){
			//console.log(results);
			response = JSON.parse(results)
			if(response.data !== null) {
				for(let i = 0; i<response.data.length; i++) {
					let destination = `${response.data[i].destination}`
					option_destinations += `
						<option value="${destination}">${destination}</option>
						`
				}
				document.getElementById("destination").innerHTML = option_destinations;
				document.getElementById("re_destination").innerHTML = option_destinations;
			} else {
				option_destinations = `
					<option>-- select --</option>
					`
				document.getElementById("destination").innerHTML = option_destinations;
				document.getElementById("re_destination").innerHTML = option_destinations;
			}
		}
	})
	
	$.ajax({
		type: "POST",
		url: "files_track",
		data: {
			request_type: "select_activity_types"
		},
		cache: false,
		success: function(results){
			//console.log(results);
			response = JSON.parse(results)
			if(response.data !== null) {
				for(let i = 0; i<response.data.length; i++) {
					let activity_type = `${response.data[i].activity_type}`
					option_activities += `
						<option value="${activity_type}">${activity_type}</option>
						`
				}
				document.getElementById("activity_type").innerHTML = option_activities;
			} else {
				option_activities = `
					<option>-- select --</option>
					`
				document.getElementById("activity_type").innerHTML = option_activities;
			}
		}
	})
	
	$.ajax({
		type: "POST",
		url: "files_track",
		data: {
			request_type: "select_officers"
		},
		cache: false,
		success: function(results){
			//console.log(results);
			response = JSON.parse(results)
			if(response.data !== null) {
				for(let i = 0; i<response.data.length; i++) {
					let officer = `${response.data[i].officer}`
					option_officers += `
						<option value="${officer}">${officer}</option>
						`
				}
				document.getElementById("gr_officer").innerHTML = option_officers;
			} else {
				option_officers = `
					<option>-- select --</option>
					`
				document.getElementById("gr_officer").innerHTML = option_officers;
			}
		}
	})
	
	$('#btn-search').click(function() {
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
							let lodgement_no = `${response.data[i].lodgement_no}`
							let file_name = `${response.data[i].file_name}`
							let created_by = `${response.data[i].created_by}`
							let activity_type = `${response.data[i].activity_type}`
							let status = `${response.data[i].status}`
							let destination = `${response.data[i].destination}`
							let subject = `${response.data[i].subject}`
							let purpose = `${response.data[i].purpose}`
							let update_date_time = `${response.data[i].update_date_time}`
							let actions = `
									<td>
							    		<div class="dropdown show d-flex justify-content-center">
										  <a class="btn btn-info" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										    <i class="fas fa-ellipsis-v m-1"></i>
										  </a>
										  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										    <a class="dropdown-item" href="#"
										    	data-id="${_id}"
								    			data-lodgement_no="${lodgement_no}"
								    			data-toggle="modal"
								    			data-target="#file_logs"
										    ><i class="fas fa-info-circle  me-2"></i>Lodgement History</a>
										    ${status == 1 ? `
										    <a class="dropdown-item" href="#"
										    	data-id="${_id}"
								    			data-lodgement_no="${lodgement_no}"
								    			data-purpose="${purpose}"
								    			data-toggle="modal"
								    			data-target="#assign_to_officer"
										    ><i class="fas fa-user-plus me-2"></i>Assign To Officer</a>
										    ` : ``}
										    ${status == 3 ? `
										    <a class="dropdown-item" href="#"
										    	data-id="${_id}"
								    			data-lodgement_no="${lodgement_no}"
								    			data-purpose="${purpose}"
								    			data-toggle="modal"
								    			data-target="#assign_to_officer"
										    ><i class="fas fa-user-plus me-2"></i>Assign To Officer</a>
										    ` : ``}
										    ${status == 2 ? `
										    <a class="dropdown-item" href="#"
										    	data-id="${_id}"
								    			data-lodgement_no="${lodgement_no}"
								    			data-toggle="modal"
								    			data-target="#return_file"
										    ><i class="fas fa-undo me-2"></i>Return From Officer</a>
										    ` : ``}
										    ${status == 2 ? `` : `
										    <a class="dropdown-item" href="#"
										    	data-lodgement_no="${lodgement_no}"
								    			data-name="${file_name}"
								    			data-subject="${subject}"
								    			data-destination="${destination}"
								    			data-purpose="${purpose}"
								    			data-toggle="modal"
								    			data-target="#re_assign_file"
										    ><i class="fas fa-paper-plane me-2" data-toggle="tooltip" data-placement="top" title="Re-assign"></i>Forward To Unit</a>
										    `}
										  </div>
										</div>
							    	</td>
							`
							
							html.push(num);
							html.push(lodgement_no);
			                html.push(file_name);
			                html.push(activity_type);
			                //html.push(subject);
			                html.push(created_by);
			                //html.push(destination);
			                //html.push(purpose);
			                html.push(update_date_time);
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

	$(document).on('submit', '#file_track_form', function(e) {
		e.preventDefault();
		var lodgement_no = $("#lodgement_no").val();
      	var name = $("#name").val();
      	var subject = $("#subject").val();
      	var activity_type = $("#activity_type").val();
		var destination = $("#destination").val();
		var purpose = $("#purpose").val();
		
		$("#lodgement_no").keypress(function(){
		    $("#lodgement_no").removeAttr('style');
		});
		 
		$("#name").keypress(function(){
			$("#name").removeAttr('style');
		});
		
		$("#activity_type").change(function(){
		    $("#activity_type").removeAttr('style');
		});
		 
		$("#destination").change(function(){
			$("#destination").removeAttr('style');
		});
		
		$("#purpose").keypress(function(){
			$("#purpose").removeAttr('style');
		});
		
		if(!lodgement_no || activity_type == '-- select --' || destination == '-- select --' || !name || !purpose) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!lodgement_no) {
				$("#lodgement_no").css({ 'border': '1px solid red'});
			}
			if(activity_type == '-- select --') {
				$("#activity_type").css({ 'border': '1px solid red'});
			}
			if(destination == '-- select --') {
				$("#destination").css({ 'border': '1px solid red'});
			}
			if(!name) {
				$("#name").css({ 'border': '1px solid red'});
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
					request_type: "select_add_file",
					lodgement_no: lodgement_no,
					file_name: name,
					subject: subject,
					activity_type: activity_type,
					destination: destination,
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
							text: 'The file has been added successfully.',
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
				      		text: 'Sorry! The loadgement number has already been added.',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
						$("#lodgement_no").css({ 'border': '1px solid red'});
					}
				}
			})
		}
	})
	
	$('#btn-new-destination').click(function() {
		$('#add_new_destination').modal('show')
		$('#add_new_file').modal('hide')
	});
	
	$('#btn-close-destination').click(function() {
		$('#add_new_file').modal('show')
		$('#add_new_destination').modal('hide')
	});
	
	$('#btn-new-activity').click(function() {
		$('#add_new_activity').modal('show')
		$('#add_new_file').modal('hide')
	});
	
	$('#btn-close-activity').click(function() {
		$('#add_new_file').modal('show')
		$('#add_new_activity').modal('hide')
	});
	
	$(document).on('submit', '#destination_form', function(e) {
		e.preventDefault();
		var destination = $("#destination_form #destination").val();
		 
		$("#destination_form #destination").change(function(){
			$("#destination_form #destination").removeAttr('style');
		});
		
		if(!destination) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!destination) {
				$("#destination_form #destination").css({ 'border': '1px solid red'});
			}
		} else {
			var $this = $('#btn-add-destination');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
	        if ($('#btn-add-destination').html() !== loadingText) {
	          $this.data('original-text', $('#btn-add-destination').html());
	          $this.html(loadingText);
	          $('#btn-add-destination').prop('disabled', true);
	          $('#btn-close-destination').hide();
	        }
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_add_destination",
					destination: destination,
				},
				cache: false,
				success: function(results){
					console.log(results);
					json_data = JSON.parse(results)
					if(json_data.success == true) {
						$('#btn-add-destination').prop('disabled', false);
						$('#btn-close-destination').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'Success',
							text: 'New destination been added successfully.',
							showHideTransition: 'slide',
							icon: 'success',
							loaderBg: '#f96868',
							position: 'bottom-right',
							hideAfter: 10000 
				    	})
						$('#destination_form')[0].reset();
					} else {
						$('#btn-add-destination').prop('disabled', false);
						$('#btn-close-destination').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! The destination has already been added.',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
						$("#destination_form #destination").css({ 'border': '1px solid red'});
					}
				}
			})
		}
	});
	
	
	$(document).on('submit', '#activity_form', function(e) {
		e.preventDefault();
		var activity_type = $("#activity_form #activity_type").val();
		 
		$("#activity_form #activity_type").change(function(){
			$("#activity_form #activity_type").removeAttr('style');
		});
		
		if(!destination) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!activity_type) {
				$("#activity_form #activity_type").css({ 'border': '1px solid red'});
			}
		} else {
			var $this = $('#btn-add-activity');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
	        if ($('#btn-add-activity').html() !== loadingText) {
	          $this.data('original-text', $('#btn-add-activity').html());
	          $this.html(loadingText);
	          $('#btn-add-activity').prop('disabled', true);
	          $('#btn-close-activity').hide();
	        }
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_add_activity",
					activity_type: activity_type,
				},
				cache: false,
				success: function(results){
					console.log(results);
					json_data = JSON.parse(results)
					if(json_data.success == true) {
						$('#btn-add-activity').prop('disabled', false);
						$('#btn-close-activity').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'Success',
							text: 'New activity type has been added successfully.',
							showHideTransition: 'slide',
							icon: 'success',
							loaderBg: '#f96868',
							position: 'bottom-right',
							hideAfter: 10000 
				    	})
						$('#activity_form')[0].reset();
					} else {
						$('#btn-add-activity').prop('disabled', false);
						$('#btn-close-activity').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! The activity type has already been added.',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
						$("#activity_form #activity_type").css({ 'border': '1px solid red'});
					}
				}
			})
		}
	});
	
	$('#refresh-destination').click(function() {
		var $this = $('#refresh-destination');
        var loadingText = '<i class="fas fa-refresh fa-spin m-1"></i>';
        if ($('#refresh-destination').html() !== loadingText) {
          $this.data('original-text', $('#refresh-destination').html());
          $this.html(loadingText);
          $('#refresh-destination').prop('disabled', true);
        }
        
		var option_destinations = '<option>-- select --</option>';
	
		$.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_destination"
			},
			cache: false,
			success: function(results){
				//console.log(results);
				$('#refresh-destination').prop('disabled', false);
				$this.html($this.data('original-text'));
				response = JSON.parse(results)
				if(response.data !== null) {
					for(let i = 0; i<response.data.length; i++) {
						let destination = `${response.data[i].destination}`
						option_destinations += `
							<option value="${destination}">${destination}</option>
							`
					}
					document.getElementById("destination").innerHTML = option_destinations;
				} else {
					option_destinations = `
						<option>-- select --</option>
						`
					document.getElementById("destination").innerHTML = option_destinations;
				}
			}
		})
	});
	
	
	$('#refresh-activity').click(function() {
		var $this = $('#refresh-activity');
        var loadingText = '<i class="fas fa-refresh fa-spin m-1"></i>';
        if ($('#refresh-activity').html() !== loadingText) {
          $this.data('original-text', $('#refresh-activity').html());
          $this.html(loadingText);
          $('#refresh-activity').prop('disabled', true);
        }
        
		var option_activities = '<option>-- select --</option>';
	
		$.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_activity_types"
			},
			cache: false,
			success: function(results){
				//console.log(results);
				$('#refresh-activity').prop('disabled', false);
				$this.html($this.data('original-text'));
				response = JSON.parse(results)
				if(response.data !== null) {
					for(let i = 0; i<response.data.length; i++) {
						let activity_type = `${response.data[i].activity_type}`
						option_activities += `
							<option value="${activity_type}">${activity_type}</option>
							`
					}
					document.getElementById("activity_type").innerHTML = option_activities;
				} else {
					option_activities = `
						<option>-- select --</option>
						`
					document.getElementById("activity_type").innerHTML = option_activities;
				}
			}
		})
	});
	
	$('#re_assign_file').on('show.bs.modal',function(event) {
		$("#re_assign_file #re_lodgement_no").val($(event.relatedTarget).data('lodgement_no'));
		$("#re_assign_file #re_name").val($(event.relatedTarget).data('name'));
		$("#re_assign_file #re_subject").val($(event.relatedTarget).data('subject'));
		$("#re_assign_file #re_destination").val($(event.relatedTarget).data('destination'));
		$("#re_assign_file #re_purpose").val($(event.relatedTarget).data('purpose'));				
	});
	
	$('#btn-re-destination').click(function() {
		$('#re_add_destination').modal('show')
		$('#re_assign_file').modal('hide')
	});
	
	$('#btn-re-close-destination').click(function() {
		$('#re_add_destination').modal('hide')
	});
	
	$(document).on('submit', '#re_destination_form', function(e) {
		e.preventDefault();
		var destination = $("#re_destination_form #re_destination").val();
		 
		$("#re_destination_form #re_destination").change(function(){
			$("#re_destination_form #re_destination").removeAttr('style');
		});
		
		if(!destination) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!destination) {
				$("#re_destination_form #re_destination").css({ 'border': '1px solid red'});
			}
		} else {
			var $this = $('#re-btn-add-destination');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
	        if ($('#re-btn-add-destination').html() !== loadingText) {
	          $this.data('original-text', $('#re-btn-add-destination').html());
	          $this.html(loadingText);
	          $('#re-btn-add-destination').prop('disabled', true);
	          $('#re-btn-close-destination').hide();
	        }
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_add_destination",
					destination: destination,
				},
				cache: false,
				success: function(results){
					console.log(results);
					json_data = JSON.parse(results)
					if(json_data.success == true) {
						$('#re-btn-add-destination').prop('disabled', false);
						$('#re-btn-close-destination').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'Success',
							text: 'New destination been added successfully.',
							showHideTransition: 'slide',
							icon: 'success',
							loaderBg: '#f96868',
							position: 'bottom-right',
							hideAfter: 10000 
				    	})
						$('#re_destination_form')[0].reset();
					} else {
						$('#re-btn-add-destination').prop('disabled', false);
						$('#re-btn-close-destination').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! The destination has already been added.',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
						$("#re_destination_form #re_destination").css({ 'border': '1px solid red'});
					}
				}
			})
		}
	});
	
	$('#re-refresh-destination').click(function() {
		var $this = $('#re-refresh-destination');
        var loadingText = '<i class="fas fa-refresh fa-spin m-1"></i>';
        if ($('#re-refresh-destination').html() !== loadingText) {
          $this.data('original-text', $('#re-refresh-destination').html());
          $this.html(loadingText);
          $('#re-refresh-destination').prop('disabled', true);
        }
        
        var option_destinations = '<option>-- select --</option>';
	
		$.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_destination"
			},
			cache: false,
			success: function(results){
				//console.log(results);
				$('#re-refresh-destination').prop('disabled', false);
				$this.html($this.data('original-text'));
				response = JSON.parse(results)
				if(response.data !== null) {
					for(let i = 0; i<response.data.length; i++) {
						let destination = `${response.data[i].destination}`
						option_destinations += `
							<option value="${destination}">${destination}</option>
							`
					}
					document.getElementById("re_destination").innerHTML = option_destinations;
				} else {
					option_json = `
						<option>-- select --</option>
						`
					document.getElementById("re_destination").innerHTML = option_destinations;
				}
			}
		})
	});
	
	$('#btn-add-officer-form').click(function() {
		$('#add_new_officer').modal('show')
		$('#assign_to_officer').modal('hide')
	});
	
	$(document).on('submit', '#add_new_officer_form', function(e) {
		e.preventDefault();
		var officer = $("#add_new_officer_form #officer").val();
		 
		$("#add_new_officer_form #officer").change(function(){
			$("#add_new_officer_form #officer").removeAttr('style');
		});
		
		if(!officer) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!officer) {
				$("#add_new_officer_form #officer").css({ 'border': '1px solid red'});
			}
		} else {
			var $this = $('#btn-add-officer');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
	        if ($('#btn-add-officer').html() !== loadingText) {
	          $this.data('original-text', $('#btn-add-officer').html());
	          $this.html(loadingText);
	          $('#btn-add-officer').prop('disabled', true);
	          $('#btn-close-officer').hide();
	        }
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_add_officer",
					officer: officer,
				},
				cache: false,
				success: function(results){
					console.log(results);
					json_data = JSON.parse(results)
					if(json_data.success == true) {
						$('#btn-add-officer').prop('disabled', false);
						$('#btn-close-officer').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'Success',
							text: 'New officer been added successfully.',
							showHideTransition: 'slide',
							icon: 'success',
							loaderBg: '#f96868',
							position: 'bottom-right',
							hideAfter: 10000 
				    	})
						$('#add_new_officer_form')[0].reset();
					} else {
						$('#btn-add-officer').prop('disabled', false);
						$('#btn-close-officer').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! The officer has already been added.',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
						$("#add_new_officer_form #officer").css({ 'border': '1px solid red'});
					}
				}
			})
		}
	});
	
	$('#refresh-officers').click(function() {
		var $this = $('#refresh-officers');
        var loadingText = '<i class="fas fa-refresh fa-spin m-1"></i>';
        if ($('#refresh-officers').html() !== loadingText) {
          $this.data('original-text', $('#refresh-officers').html());
          $this.html(loadingText);
          $('#refresh-officers').prop('disabled', true);
        }
        
        var option_officers = '<option>-- select --</option>';
	
		$.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_officers"
			},
			cache: false,
			success: function(results){
				//console.log(results);
				$('#refresh-officers').prop('disabled', false);
				$this.html($this.data('original-text'));
				response = JSON.parse(results)
				if(response.data !== null) {
				for(let i = 0; i<response.data.length; i++) {
					let officer = `${response.data[i].officer}`
					option_officers += `
						<option value="${officer}">${officer}</option>
						`
				}
				document.getElementById("officer").innerHTML = option_officers;
				} else {
					option_officers = `
						<option>-- select --</option>
						`
					document.getElementById("officer").innerHTML = option_officers;
				}
			}
		})
	});
	
	$(document).on('submit', '#re_assign_form', function(e) {
		e.preventDefault();
		var re_lodgement_no = $("#re_lodgement_no").val();
  	//var re_name = $("#re_name").val();
      	var re_subject = $("#re_subject").val();
		var re_destination = $("#re_destination").val();
		var re_purpose = $("#re_purpose").val();
		
		$("#re_lodgement_no").keypress(function(){
		    $("#re_lodgement_no").removeAttr('style');
		});
		 
		/*$("#re_name").keypress(function(){
			$("#re_name").removeAttr('style');
		});*/
		 
		$("#re_destination").change(function(){
			$("#re_destination").removeAttr('style');
		});
		
		$("#re_purpose").keypress(function(){
			$("#re_purpose").removeAttr('style');
		});
		
		if(!re_lodgement_no || re_destination == '-- select --' || !re_purpose) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!re_lodgement_no) {
				$("#re_lodgement_no").css({ 'border': '1px solid red'});
			}
			if(re_destination == '-- select --') {
				$("#re_destination").css({ 'border': '1px solid red'});
			}
			/*if(!re_name) {
				$("#re_name").css({ 'border': '1px solid red'});
			}*/
			if(!re_purpose) {
				$("#re_purpose").css({ 'border': '1px solid red'});
			}
		} else {
			var $this = $('#btn-re-assign');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
	        if ($('#btn-re-assign').html() !== loadingText) {
	          $this.data('original-text', $('#btn-re-assign').html());
	          $this.html(loadingText);
	          $('#btn-re-assign').prop('disabled', true);
	          $('#re-btn-close').hide();
	        }
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_update_file_logs",
					lodgement_no: re_lodgement_no,
					//file_name: re_name,
					subject: re_subject,
					destination: re_destination,
					purpose: re_purpose
				},
				cache: false,
				success: function(results){
					console.log(results);
					json_data = JSON.parse(results)
					if(json_data.success == true) {
						$('#btn-re-assign').prop('disabled', false);
	          			$('#re-btn-close').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'Success',
							text: 'The file has been updated successfully.',
							showHideTransition: 'slide',
							icon: 'success',
							loaderBg: '#f96868',
							position: 'bottom-right',
							hideAfter: 10000 
				    	})
						$('#re_assign_file').modal('hide');
					} else {
						$('#btn-re-assign').prop('disabled', false);
	          			$('#re-btn-close').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! Something went wrong, please try again.',
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
	
	$('#assign_to_officer').on('show.bs.modal',function(event) {
		$("#assign_to_officer #sc_lodgement_no").val($(event.relatedTarget).data('lodgement_no'));				
	});
	
	$(document).on('submit', '#assign_to_officer_form', function(e) {
		e.preventDefault();
		var sc_lodgement_no = $("#sc_lodgement_no").val();
      	var scheduled_officer = $("#scheduled_officer").val();
		var sc_purpose = $("#sc_purpose").val();
		
		$("#sc_lodgement_no").keypress(function(){
		    $("#sc_lodgement_no").removeAttr('style');
		});
		 
		$("#scheduled_officer").keypress(function(){
			$("#scheduled_officer").removeAttr('style');
		});
		
		$("#sc_purpose").change(function(){
		    $("#sc_purpose").removeAttr('style');
		});
		
		if(!sc_lodgement_no || !scheduled_officer || !sc_purpose) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!sc_lodgement_no) {
				$("#sc_lodgement_no").css({ 'border': '1px solid red'});
			}
			if(!scheduled_officer) {
				$("#scheduled_officer").css({ 'border': '1px solid red'});
			}
			if(!sc_purpose) {
				$("#sc_purpose").css({ 'border': '1px solid red'});
			}
		} else {
			var $this = $('#btn-sc-assign');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
	        if ($('#btn-sc-assign').html() !== loadingText) {
	          $this.data('original-text', $('#btn-sc-assign').html());
	          $this.html(loadingText);
	          $('#btn-sc-assign').prop('disabled', true);
	          $('#sc-btn-close').hide();
	        }
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_assign_to_officer",
					lodgement_no: sc_lodgement_no,
					scheduled_officer: scheduled_officer,
					purpose: sc_purpose
				},
				cache: false,
				success: function(results){
					console.log(results);
					json_data = JSON.parse(results)
					if(json_data.success == true) {
						$('#btn-sc-assign').prop('disabled', false);
						$('#sc-btn-close').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'Success',
							text: 'The file has been added successfully.',
							showHideTransition: 'slide',
							icon: 'success',
							loaderBg: '#f96868',
							position: 'bottom-right',
							hideAfter: 10000 
				    	})
						$('#assign_to_officer').modal('hide');
					} else {
						$('#btn-sc-assign').prop('disabled', false);
						$('#sc-btn-close').show();
						$this.html($this.data('original-text'));
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! The loadgement number has already been added.',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
						$("#sc_lodgement_no").css({ 'border': '1px solid red'});
					}
				}
			})
		}
	})
	
	$(document).on('submit', '#generate_report_form', function(e) {
		e.preventDefault();
		var from_date = $("#from_date").val();
      	var to_date = $("#to_date").val();
		//var gr_activity_type = $("#gr_activity_type").val();
		
		$("#from_date").change(function(){
		    $("#from_date").removeAttr('style');
		});
		 
		$("#to_date").change(function(){
			$("#to_date").removeAttr('style');
		});
		 
		/*$("#gr_activity_type").change(function(){
			$("#gr_activity_type").removeAttr('style');
		});*/
		
		if(!from_date || !to_date) {
			$.toast({
				heading: 'Warning',
				text: 'Please fill the required fields.',
				showHideTransition: 'slide',
				icon: 'error',
				loaderBg: '#f2a654',
				position: 'bottom-right',
				hideAfter: 10000 
	   		})
			if(!from_date) {
				$("#from_date").css({ 'border': '1px solid red'});
			}
			if(!to_date) {
				$("#to_date").css({ 'border': '1px solid red'});
			}
			/*if(gr_activity_type == '-- select --') {
				$("#gr_activity_type").css({ 'border': '1px solid red'});
			}*/
		} else {
			var $this = $('#btn-generate-report');
	        var loadingText = '<span class="text-white"><i class="fa fa-spinner fa-spin fa-fw"></i>Generating...</span>';
	        if ($('#btn-generate-report').html() !== loadingText) {
	          $this.data('original-text', $('#btn-generate-report').html());
	          $this.html(loadingText);
	          $('#btn-generate-report').prop('disabled', true);
	          //$('#gr-btn-close').hide();
	        }
	        
	        $('#report_list').DataTable().clear().destroy();
	        
	        let dataSet = [];
    		var num = '';
	        
	        $.ajax({
				type: "POST",
				url: "files_track",
				data: {
					request_type: "select_generate_reports",
					from_date: from_date,
					to_date: to_date,
					//activity_type: gr_activity_type,
				},
				cache: false,
				success: function(results){
					//console.log(results);
					response = JSON.parse(results)
					if(response.data !== null) {
						$this.html($this.data('original-text'));
						$('#btn-generate-report').prop('disabled', false);
						//$('#gr-btn-close').show();
						
						for(let i = 0; i<response.data.length; i++) {
							let html = [];
							num = (+num + 1);
							let lodgement_no = `${response.data[i].lodgement_no}`
							let destination = `${response.data[i].destination}`
							let received_from = `${response.data[i].received_from}`
							let scheduled_officer = `${response.data[i].scheduled_officer}`
							let status = `${response.data[i].status}`
							let update_date_time = `${response.data[i].update_date_time}`
							let logs = `
								${status == 1 ? `<p>${lodgement_no} was received from <b>${received_from}</b> on ${update_date_time}<p>` : ``}
								${status == 2 ? `<p>${lodgement_no} was assigned to <b>${scheduled_officer}</b> on ${update_date_time}</p>` : ``}
								${status == 3 ? `<p>${lodgement_no} was returned on ${update_date_time}</p>` : ``}
								${status == 4 ? `<p>${lodgement_no} was fowarded to <b>${destination}</b> on ${update_date_time}</p>` : ``}
							`
							html.push(num+'.');
							html.push(logs);
	
	            			dataSet.push(html);
						}
						
						$('#report_list').DataTable({
			                pageLength: 10,
			                data: dataSet,
			                dom: 'Bfrtip',
			                buttons: [
								'copy','csv','excel','pdf','print'
							],
							//order: [0, 'desc'],
			            });
			            
			            //$('#generate_report').modal('hide')
			            //$('#reports').modal('show')
			            
			            document.getElementById("from_date_id").innerHTML = from_date;
			            document.getElementById("to_date_id").innerHTML = to_date;
			            
					} else {
						$this.html($this.data('original-text'));
						$('#btn-generate-report').prop('disabled', false);
						//$('#gr-btn-close').show();
						$.toast({
				      		heading: 'System Failed',
				      		text: 'Sorry! There is no record match. Please try again',
				      		showHideTransition: 'slide',
				      		icon: 'error',
				      		loaderBg: '#f2a654',
				      		position: 'bottom-right',
				      		hideAfter: 10000 
				    	})
				    	
				    	document.getElementById("from_date_id").innerHTML = from_date;
			            document.getElementById("to_date_id").innerHTML = to_date;
					}
				}
			})
		}
	})
	
	$('#file_logs').on('show.bs.modal',function(event) {
		$("#file_logs #fl_lodgement_no").val($(event.relatedTarget).data('lodgement_no'));
		$("#file_logs #fl_id").val($(event.relatedTarget).data('id'));			
	});
	
	$('#btn-file-logs').on('click', function(e) {
		e.preventDefault();
		var lodgement_no = $("#fl_lodgement_no").val();
		
		$('#file_logs_list').DataTable().clear().destroy();
		
		var $this = $('#btn-file-logs');
        var loadingText = '<span><i class="fa fa-spinner fa-spin fa-fw"></i>Loading...</span>';
        if ($('#btn-file-logs').html() !== loadingText) {
          $this.data('original-text', $('#btn-file-logs').html());
          $this.html(loadingText);
          $('#btn-file-logs').prop('disabled', true);
        }
        
        let dataSet = [];
		var num = '';
        
        $.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_file_logs",
				lodgement_no: lodgement_no
			},
			cache: false,
			success: function(results){
				//console.log(results);
				response = JSON.parse(results)
				if(response.data !== null) {
					$('#btn-file-logs').prop('disabled', false);
					$this.html($this.data('original-text'));
					for(let i = 0; i<response.data.length; i++) {
						let html = [];
						num = (+num + 1);
						//let created_by = `${response.data[i].created_by}`
						let destination = `${response.data[i].destination}`
						let received_from = `${response.data[i].received_from}`
						let scheduled_officer = `${response.data[i].scheduled_officer}`
						let status = `${response.data[i].status}`
						let update_date_time = `${response.data[i].update_date_time}`
						let logs = `
							${status == 1 ? `<p>${num}. The lodgement number was received from <b>${received_from}</b> on ${update_date_time}<p>` : ``}
							${status == 2 ? `<p>${num}. The lodgement number was assigned to <b>${scheduled_officer}</b> on ${update_date_time}</p>` : ``}
							${status == 3 ? `<p>${num}. The lodgement number was returned on ${update_date_time}</p>` : ``}
							${status == 4 ? `<p>${num}. The lodgement number was fowarded to <b>${destination}</b> on ${update_date_time}</p>` : ``}
						`
						html.push(logs);

            			dataSet.push(html);
					}
					
					$('#file_logs_list').DataTable({
		                pageLength: 10,
		                data: dataSet
		            });
				} else {
					$('#btn-file-logs').prop('disabled', false);
					$this.html($this.data('original-text'));
					$.toast({
			      		heading: 'System Failed',
			      		text: 'Sorry! Something went wrong, please try again.',
			      		showHideTransition: 'slide',
			      		icon: 'error',
			      		loaderBg: '#f2a654',
			      		position: 'bottom-right',
			      		hideAfter: 10000 
			    	})
				}
			}
		})
	})
	
	$('#return_file').on('show.bs.modal',function(event) {
		$("#return_file #rs_lodgement_no").val($(event.relatedTarget).data('lodgement_no'));		
	});
	
	$('#btn-return').on('click', function(e) {
		e.preventDefault();
		var lodgement_no = $("#rs_lodgement_no").val();
		
		var $this = $('#btn-return');
        var loadingText = '<span><i class="fa fa-spinner fa-spin fa-fw"></i>Saving...</span>';
        if ($('#btn-return').html() !== loadingText) {
          $this.data('original-text', $('#btn-return').html());
          $this.html(loadingText);
          $('#btn-return').prop('disabled', true);
          $('#rs-btn-close').hide();
        }
        
        $.ajax({
			type: "POST",
			url: "files_track",
			data: {
				request_type: "select_return_file",
				lodgement_no: lodgement_no
			},
			cache: false,
			success: function(results){
				//console.log(results);
				response = JSON.parse(results)
				if(response.success == true) {
					$('#btn-return').prop('disabled', false);
					$('#rs-btn-close').show();
					$this.html($this.data('original-text'));
					$.toast({
			      		heading: 'Success',
						text: 'The file has been returned from assigned officer.',
						showHideTransition: 'slide',
						icon: 'success',
						loaderBg: '#f96868',
						position: 'bottom-right',
						hideAfter: 10000 
			    	})
					$('#return_file').modal('hide');
				} else {
					$('#btn-return').prop('disabled', false);
					$('#rs-btn-close').show();
					$this.html($this.data('original-text'));
					$.toast({
			      		heading: 'System Failed',
			      		text: 'Sorry! Something went wrong, please try again.',
			      		showHideTransition: 'slide',
			      		icon: 'error',
			      		loaderBg: '#f2a654',
			      		position: 'bottom-right',
			      		hideAfter: 10000 
			    	})
				}
			}
		})
	})
	
	$('#activity_type_form').hide();
	$('#assigned_officer_form').hide();
	$('#outgoing_form').hide();
	$('#general_logs_form').hide();

    $('input[type=radio][name=search_radio]').change(function() {
        if (this.value == 'incoming') {
            $('#incoming_form').show();
            $('#activity_type_form').hide();
			$('#assigned_officer_form').hide();
			$('#outgoing_form').hide();
			$('#general_logs_form').hide();
        }
        else if (this.value == 'activity_type') {
            $('#incoming_form').hide();
            $('#activity_type_form').show();
			$('#assigned_officer_form').hide();
			$('#outgoing_form').hide();
			$('#general_logs_form').hide();
        }
        else if (this.value == 'assigned_officer') {
            $('#incoming_form').hide();
            $('#activity_type_form').hide();
			$('#assigned_officer_form').show();
			$('#outgoing_form').hide();
			$('#general_logs_form').hide();
        }
        else if (this.value == 'outgoing') {
            $('#incoming_form').hide();
            $('#activity_type_form').hide();
			$('#assigned_officer_form').hide();
			$('#outgoing_form').show();
			$('#general_logs_form').hide();
        }
        else if (this.value == 'general_logs') {
            $('#incoming_form').hide();
            $('#activity_type_form').hide();
			$('#assigned_officer_form').hide();
			$('#outgoing_form').hide();
			$('#general_logs_form').show();
        }
    });
	
});