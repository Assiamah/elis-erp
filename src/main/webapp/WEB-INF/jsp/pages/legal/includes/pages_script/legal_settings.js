  $(document).ready(function() {
	  
	  $('#nature_list').DataTable();
	  $('#court_list').DataTable();
	  
	  $('#btnAddNature').on('click', function() {
	        
	      $("#addNatureModal").modal('show');
	       
	       $("#addnature #nature_of_case_id").val("1234567890");
            $("#addnature #nature_of_case").val("");
	
	    })
	    
	  $('.btnEditNature').on('click', function(event) {
	        
	      $("#addNatureModal").modal('show');
	       
	        $("#addnature #nature_of_case_id").val($(event.currentTarget).data('nature_of_case_id'));
            $("#addnature #nature_of_case").val($(event.currentTarget).data('nature_of_case'));
	
	    })
	    
	   $('#addnature').on('submit',function(e){
		   e.preventDefault();
			
			$("#save_btn").prop('disabled', true);
			
			
			let nature_of_case=$('input[name="nature_of_case"]').val();
			let nature_of_case_id=$('input[name="nature_of_case_id"]').val();

			
			$.ajax({
				url:"legal_settings_serv",
				method:"POST",
				data:{"request_type":"add_nature",
					"nature_of_case": nature_of_case,
					"nature_of_case_id": nature_of_case_id
					},
				success:function(response){
					
					console.log(response)
					
					let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Uploaded successfully", "File");
                } 
              else {
                        toastr["error"]("Error occurred uploading file", "File");
                 }

                    $("#addNatureModal").find('form').trigger('reset');
                    $("#addNatureModal").modal('hide');
                    $("#save_btn").prop('disabled', false);
                    
                     setTimeout(function(){
                        location.reload();
                    },1000); 
					}
				})
				

	   });
	   
	   $('#btnAddCourt').on('click', function() {
	        
	      $("#addCourtModal").modal('show');
	       
	       $("#addcourt #court_name").val("");
            $("#addcourt #court_region").val("");
            $("#addcourt #city").val("");
            $("#addcourt #description").val("");
            $("#addcourt #court_id").val("1234567890");
	
	    })
	    
	    $('.btnEditCourt').on('click', function(event) {
	        
	      $("#addCourtModal").modal('show');
	       
	        $("#addcourt #court_name").val($(event.currentTarget).data('court_name'));
            $("#addcourt #court_region").val($(event.currentTarget).data('region'));
            $("#addcourt #city").val($(event.currentTarget).data('city'));
            $("#addcourt #description").val($(event.currentTarget).data('description'));
             $("#addcourt #court_id").val($(event.currentTarget).data('court_id'));
	
	    })
	    
	    $('#addcourt').on('submit',function(e){
		   e.preventDefault();
			
			$("#save_court_btn").prop('disabled', true);
			
			
			let court_name=$('input[name="court_name"]').val();;
			let court_region=$('#court_region').find(":selected").val();
			let city=$('input[name="city"]').val();
			let description=$('input[name="description"]').val();
			let court_id=$('input[name="court_id"]').val();

			
			$.ajax({
				url:"legal_settings_serv",
				method:"POST",
				data:{"request_type":"add_court",
					"court_name": court_name,
					"court_region": court_region,
					"city": city,
					"description": description,
					"court_id": court_id
					},
				success:function(response){
					
					console.log(response)
					
					let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Uploaded successfully", "File");
                } 
              else {
                        toastr["error"]("Error occurred uploading file", "File");
                 }

                    $("#addCourtModal").find('form').trigger('reset');
                    $("#addCourtModal").modal('hide');
                    $("#save_court_btn").prop('disabled', false);
                    
                     setTimeout(function(){
                        location.reload();
                    },1000); 
					}
				})
				

	   });
	
	  
  })