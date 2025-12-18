$(function(){

	let se_within_time_frame =document.getElementById("se_within_time_frame");
 	se_within_time_frame.addEventListener("change",function(){
	let htmlDiv="";
	let x=se_within_time_frame.value;
	 switch(x){
	 	case '1':
	 		  htmlDiv=`
	 			 <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>PROVIDE 
		           MILESTONE STATUS 
		           TO ENQUIRER</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="milestone_status" id="milestone_status" required></textarea>
		           </div>
		         </div>
	 		  `;
	 		  document.getElementById("se_div").innerHTML=htmlDiv;
	 		break;
	 	case '0':
	 		htmlDiv=`
	           	<hr />
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input  class="form-control" name="subject" id="subject" list="datalistOptions"  placeholder="Type to search..." required>        
					  <datalist id="datalistOptions">
					    <option value="Can not upload site plan"></option>
					    <option value="Document can not be found"></option>
					    <option value="Can not acknowledge bill"></option>
					    <option value="Did not get acknowledgement slip"></option>
					  </datalist>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="description" id="description" required></textarea>
		           </div>
		         </div>
		       
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type" required>
		               <option disabled selected>-- select --</option>
		               <option value="telephone">Telephone</option>
						<option value="email">Email</option>
						<option value="both">Both</option>		
		             </select>
		           </div>
		         </div>
		        
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="priority" id="priority" required>
		               <option disabled selected>-- select --</option>
		               <option value="1">Low</option>
						<option value="2">Medium</option>
						<option value="3">High</option>
						<option value="4">Urgent</option>
		             </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" id="related_service" name="related_service" required>
					    <option value="" disabled selected>-- select --</option>
					    <option value="Job Number">Job Number</option>
					    <option value="Bill Number">Bill Number</option>
					    <option value="Bill Number">Case Number</option>
					    <option value="Bill Number">Regional Number</option>
				    </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Reference ID</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input type="text" class="form-control required-input" name="reference_id" id="reference_id" >
		           </div>
		         </div>`;
		         document.getElementById("se_div").innerHTML=htmlDiv;
	 		break;
	 	default:
	 	
	 }

 })

let sc_within_time_frame =document.getElementById("sc_within_time_frame");
 	sc_within_time_frame.addEventListener("change",function(){
	let htmlDiv="";
	let x=sc_within_time_frame.value;
	 switch(x){
	 	case '1':
	 		  htmlDiv=`
	 			 <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>PROVIDE 
		           MILESTONE STATUS 
		           TO ENQUIRER</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="sc_milestone_status" id="sc_milestone_status" required></textarea>
		           </div>
		         </div>
	 		  `;
	 		  document.getElementById("sc_div").innerHTML=htmlDiv;
	 		break;
	 	case '0':
	 		htmlDiv=`
	           	<hr />
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input  class="form-control" name="subject" id="subject" list="datalistOptions"  placeholder="Type to search..." required>        
					  <datalist id="datalistOptions">
					    <option value="Can not upload site plan"></option>
					    <option value="Document can not be found"></option>
					    <option value="Can not acknowledge bill"></option>
					    <option value="Did not get acknowledgement slip"></option>
					  </datalist>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="description" id="description" required></textarea>
		           </div>
		         </div>
		       
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type" required>
		               <option disabled selected>-- select --</option>
		               <option value="telephone">Telephone</option>
						<option value="email">Email</option>
						<option value="both">Both</option>		
		             </select>
		           </div>
		         </div>
		        
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="priority" id="priority" required>
		               <option disabled selected>-- select --</option>
		               <option value="1">Low</option>
						<option value="2">Medium</option>
						<option value="3">High</option>
						<option value="4">Urgent</option>
		             </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" id="related_service" name="related_service" required>
					    <option value="" disabled selected>-- select --</option>
					    <option value="Job Number">Job Number</option>
					    <option value="Bill Number">Bill Number</option>
					    <option value="Bill Number">Case Number</option>
					    <option value="Bill Number">Regional Number</option>
				    </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Reference ID</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input type="text" class="form-control required-input" name="reference_id" id="reference_id" >
		           </div>
		         </div>`;
		         document.getElementById("sc_div").innerHTML=htmlDiv;
	 		break;
	 	default:
	 	
	 }

 })
	
	
	
	
	/// Submit ticket
		$("#ServiceEnquiryForm").on('submit',function(e){
			e.preventDefault();
		
			$(".save_btn").prop('disabled', true);
			$(".save_btn").text("Please wait ...");
			
			let complainant_name=$('input[name="se_ticket_name"]').val();
			let complainant_phone=$('input[name="se_ticket_tel"]').val();
			let complainant_email=$('input[name="se_ticket_email"]').val();
			let within_time_frame=parseInt($('#se_within_time_frame').find(":selected").val());
			let milestone_status=within_time_frame?$('#milestone_status').val():null;
			let subject=!within_time_frame?$('input[name="subject"]').val():null;
			let description=!within_time_frame?$('#description').val():null;
			let contact_type=!within_time_frame?$('#contact_type').find(":selected").text():null;
			let purpose=1;
			let priority=!within_time_frame?$('#priority').find(":selected").text():null;
			let related_service=!within_time_frame?$('#related_service').find(":selected").text():null;
			let reference_id=!within_time_frame?$('input[name="reference_id"]').val():null;
			
			$.ajax({
			type:"POST",
			url:"cica_clients",
			data:{"request_type":"service_enquiry",
				  "complainant_name":complainant_name,
				  "complainant_phone":complainant_phone,
				  "complainant_email":complainant_email,
				  "subject":subject,
				  "description":description,
				  "contact_type":contact_type,
				  "purpose":purpose,
				  "priority":priority,
				  "related_service":related_service,
				  "reference_id":reference_id,
				  "milestone_status":milestone_status,
				  "within_time_frame":within_time_frame,
			},
			success:function(response){
			 //console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket Added successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Adding Ticket", "CICA");
                 }

                    $("#ServiceEnquiryTicketModal").find('form').trigger('reset');
                    $("#ServiceEnquiryTicketModal").modal('hide');
                    
                    $(".save_btn").prop('disabled', false);
					$(".save_btn").text("Save")
                  
			}	
		})
			
	
		
		})
		
		
		$("#OtherEnquiryForm").on('submit',function(e){
			e.preventDefault();
		
			$(".save_btn").prop('disabled', true);
			$(".save_btn").text("Please wait ...");
			
			let complainant_name=$('input[name="oe_ticket_name"]').val();
			let complainant_phone=$('input[name="oe_ticket_tel"]').val();
			let complainant_email=$('input[name="oe_ticket_email"]').val();
			let reference_source=$('#reference_source').val();
			let purpose=2;
			
			$.ajax({
			type:"POST",
			url:"cica_clients",
			data:{"request_type":"other_enquiry",
				  "complainant_name":complainant_name,
				  "complainant_phone":complainant_phone,
				  "complainant_email":complainant_email,
				  "reference_source":reference_source,
				  "purpose":purpose,
			},
			success:function(response){
			 //console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket Added successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Adding Ticket", "CICA");
                 }

                    $("#OtherEnquiryTicketModal").find('form').trigger('reset');
                    $("#OtherEnquiryTicketModal").modal('hide');
                    
                    $(".save_btn").prop('disabled', false);
					$(".save_btn").text("Save")
                  
			}	
		})
			
	
		
		})
		
		
		$("#ServiceComplaintForm").on('submit',function(e){
			e.preventDefault();
		
			$(".save_btn").prop('disabled', true);
			$(".save_btn").text("Please wait ...");
			
			let complainant_name=$('input[name="sc_ticket_name"]').val();
			let complainant_phone=$('input[name="sc_ticket_tel"]').val();
			let complainant_email=$('input[name="sc_ticket_email"]').val();
			let within_time_frame=parseInt($('#sc_within_time_frame').find(":selected").val());
			let milestone_status=within_time_frame?$('#sc_milestone_status').val():null;
			let subject=!within_time_frame?$('input[name="subject"]').val():null;
			let description=!within_time_frame?$('#description').val():null;
			let contact_type=!within_time_frame?$('#contact_type').find(":selected").text():null;
			let purpose=3;
			let priority=!within_time_frame?$('#priority').find(":selected").text():null;
			let related_service=!within_time_frame?$('#related_service').find(":selected").text():null;
			let reference_id=!within_time_frame?$('input[name="reference_id"]').val():null;
			
			$.ajax({
			type:"POST",
			url:"cica_clients",
			data:{"request_type":"service_enquiry",
				  "complainant_name":complainant_name,
				  "complainant_phone":complainant_phone,
				  "complainant_email":complainant_email,
				  "subject":subject,
				  "description":description,
				  "contact_type":contact_type,
				  "purpose":purpose,
				  "priority":priority,
				  "related_service":related_service,
				  "reference_id":reference_id,
				  "milestone_status":milestone_status,
				  "within_time_frame":within_time_frame,
			},
			success:function(response){
			 //console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket Added successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Adding Ticket", "CICA");
                 }

                    $("#ServiceComplaintTicketModal").find('form').trigger('reset');
                    $("#ServiceComplaintTicketModal").modal('hide');
                    
                    $(".save_btn").prop('disabled', false);
					$(".save_btn").text("Save")
                  
			}	
		})

		})
		
		
		$("#NonServiceComplaintForm").on('submit',function(e){
			e.preventDefault();
		
			$(".save_btn").prop('disabled', true);
			$(".save_btn").text("Please wait ...");
			
			let complainant_name=$('input[name="ns_ticket_name"]').val();
			let complainant_phone=$('input[name="ns_ticket_tel"]').val();
			let complainant_email=$('input[name="ns_ticket_email"]').val();
			let subject=$('input[name="ns_subject"]').val();
			let description=$('#ns_description').val();
			let division=$('#division').find(":selected").val();
			let region=$('#region').find(":selected").val();
			let purpose=4;
			let unit=$('input[name="unit"]').val();
			
			$.ajax({
			type:"POST",
			url:"cica_clients",
			data:{"request_type":"non_service_complaint",
				  "complainant_name":complainant_name,
				  "complainant_phone":complainant_phone,
				  "complainant_email":complainant_email,
				  "subject":subject,
				  "description":description,
				  "division":division,
				  "purpose":purpose,
				  "region":region,
				  "unit":unit,
			},
			success:function(response){
			 //console.log(response);
			 let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Ticket Added successfully", "CICA");
                } 
              else {
                        toastr["error"]("Error Adding Ticket", "CICA");
                 }

                    $("#NonServiceComplaintTicketModal").find('form').trigger('reset');
                    $("#NonServiceComplaintTicketModal").modal('hide');
                    
                    $(".save_btn").prop('disabled', false);
					$(".save_btn").text("Save")
                  
			}	
		})
			
	
		
		})
		
		
		
})