/*document.getElementsByTagName('select')[0].onchange = function() {
  var index = this.selectedIndex;
  var inputText = this.children[index].innerHTML.trim();
  console.log(inputText);
}*/

$(document).ready(function(){

	console.log('very ready');
	console.log("OTP should work");
	
	var text = document.getElementById("vc_6");

	$("#vc_6").on('keyup', function (event) {
	//if (event.keyCode === 13) {
      if (text.value.length == 1) {
         console.log("Enter key pressed!!!!!");
          //$("#frmVerification").submit(); 
		  $("#otp-form").submit();
      }
   });
	
	/*$("#vc_4").keyup(function(){

	 $("#frmVerification").submit(); // Submit the form
	});
	*/

	
	OTPInput();
			
  
  function OTPInput() {
			const inputs = document.querySelectorAll('#otp > *[id]');
			for (let i = 0; i < inputs.length; i++) { 
				inputs[i].addEventListener('keydown', function(event) { 
					if (event.key==="Backspace" ) 
					{ inputs[i].value='' ; if (i !==0) inputs[i - 1].focus(); 
					
					} else { if (i===inputs.length - 1 && inputs[i].value !=='' ) 
					{ return true; 
					} else if (event.keyCode> 47 && event.keyCode < 58) { 
						inputs[i].value=event.key; 
						if (i !==inputs.length - 1) inputs[i + 1].focus(); event.preventDefault(); 
						} else if (event.keyCode> 64 && event.keyCode < 91) { 
							inputs[i].value=String.fromCharCode(event.keyCode); 
							if (i !==inputs.length - 1) inputs[i + 1].focus(); 
							event.preventDefault(); 
							} 
							} 
							
				}); 
				} 
				} 
			    


	
	
 
});