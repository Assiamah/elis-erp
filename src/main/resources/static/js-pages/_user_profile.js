$(document).ready(function() {

	
		
			
	
	$('#frmUdateProfile').on('submit', function(e){
   	    // validation code here
   	    e.preventDefault();
   	    //console.log('form submited Clicked');
   	    //alert("good");
   	    $("#profileUpdate").modal("toggle");
   	   
   	    var userid = $("#pr_userid").val();
   	    var phone = $("#pr_phone").val();
   	    var phone2 = $("#pr_mobile").val();
   	    var password =  $("#pr_web_pass").val();
   	    var confpassword =  $("#pr_web_pass_confirm").val();
   	    if(password === null){
   	    	$.notify({
				message : '<i class="fa fa-exclamation fa-fw"></i><span class="text-bold">Please enter password</span>',
			},{
				type: 'danger'
			});
   	    	return;
   	    }
   	    
   	    //check set password
   	    if(password == confpassword){
   	    	//save
   	    	$.ajax({
				 type: "POST",
				 url: "Case_Management_Serv",
				 data: {
	                	request_type: 'update_user_profile',
	                	phone: phone,
	                  	phone2:phone2,
	                  	password: password,
	                  	},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(response) {
					  console.log(response)
					  //var json_p = JSON.parse(response);
					  if(response == "Success"){
						  $.notify('<i class="fa fa-exclamation fa-fw"></i><span class="text-bold">Password has been changed successfully</span>');

					  }
					 					    				      
				 }
			});
   	    	
   	    }else{
   	    	$.notify({
				message : '<i class="fa fa-exclamation fa-fw"></i><span class="text-bold">the passwords entered are not the same</span>',
			},{
				type: 'danger'
			});
   	    	
   	    }
   	    
   	    
   	    
   	    
   		
 	});
   	
   	
   	
   	
   	//------ end of $(doc).ready
});