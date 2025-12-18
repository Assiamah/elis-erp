$(document).ready(function() {
	
	
	
	
	$('.set_as_recorded').on('click', function(e){
			e.preventDefault();
			let ref_number = $(this).data('ref_number');
			 bootbox.confirm({
	     		    title: "Action confrimation!",
	     		    message: "Are you sure you want to set this Payment as Updated? this is irreverable",
	     		    buttons: {
	     		        cancel: {
	     		            label: '<i class="fa fa-times"></i> Cancel'
	     		        },
	     		        confirm: {
	     		            label: '<i class="fa fa-check"></i> Confirm'
	     		        }
	     		    },
	     		    callback: function (result) {
	     		    	if(result){
	         	    		
	         	     	    
	         	     		 $.ajax({
	         	 				 type: "POST",
	         	 				 url: "Case_Management_Serv",
	         	 				 data: {
	         	 	                	request_type: 'account_report_on_ground_rent_bill_update',
	         	 	                	ref_number: ref_number 
	         	 				 	   },
	         	 				 cache: false,
	         	 				 
	         	 				 success: function(jobdetails) {
	         	 					 
	         	 					//var json_p = JSON.parse(jobdetails);
	         	 					if( jobdetails.includes("Success")){
	         	 						$.notify({
	        			                    message: '<i class="fas fa-check  fa-3x fa-fw"></i><span class="text-bold">Success! Payment set as Updated </span>',
	        			                }, {
	        			                    type: 'success'
	        			                });
	        				        	

	         	 					}else{
	         	 						$.notify({
	        			                    message: '<i class="fas fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Sorry! Somthing went wrong </span>',
	        			                }, {
	        			                    type: 'danger'
	        			                });
	        				        	
	         	 					}
	         	 					
	         	 				
	         	 
	         	 				 }
	         	 				
	         	 				});
	         	     		 //return false;
	         	    	
	         	    	}
	     		    }
	     		});
	     	 	
	
	});

	
	
	
	
	 $("#tbl_transactions_result")
	.DataTable({
		dom: 'Bfrtip',						
        buttons: [
        	'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
        ]
	});
	
	
	
	
	
					


// ------ end of $(doc).ready
});