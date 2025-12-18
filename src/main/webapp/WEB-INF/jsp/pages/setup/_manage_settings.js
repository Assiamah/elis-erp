$(document)
		.ready(
				function() {
					
					
					
					
					
					
					$('#frmSearchforBillDetails').on('submit', function (e) {
						e.preventDefault();
	               		//console.log("hit")
	               		
						   var ref_number =$("#ack_ref_number").val() ;
						   console.log("hit: " + ref_number);
						   
						   if(isNaN(ref_number) || ref_number.length != 5){
							   alert("Please anter a valid reference number");
						   }else{
							   
			        		  	 $.ajax({
			        				 type: "POST",
			        				 url: "Case_Management_Serv",
			        				 data: {
			        	                	request_type: 'reverse_acknowledgement',
			        	                	ref_number: ack_ref_number,
			        				 	   },
			        				 cache: false,
			        				 beforeSend: function () {
			        					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			        				 },
			        				 success: function(jobdetails) {
			        					
			       				        		        	
			       				            
			        				 }
			        		  	 });

						   }
					});
					
					
					$('#frmReverseBillAcknowledgement').on('submit', function (e) {
						e.preventDefault();
	               		//console.log("hit")
	               		
						   var ref_number =$("#ack_ref_number").val() ;
						   console.log("hit: " + ref_number);
						   
						   if(isNaN(ref_number) || ref_number.length != 5){
							   alert("Please anter a valid reference number");
						   }else{
							   
			        		  	 $.ajax({
			        				 type: "POST",
			        				 url: "Case_Management_Serv",
			        				 data: {
			        	                	request_type: 'reverse_acknowledgement',
			        	                	ref_number: ack_ref_number,
			        				 	   },
			        				 cache: false,
			        				 beforeSend: function () {
			        					 //$('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			        				 },
			        				 success: function(jobdetails) {
			        					
														        	
			       				            
			        				 }
			        		  	 });

						   }
					});
					
					
					
					

					// ------ end of $(doc).ready
				});