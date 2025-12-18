$(document).ready(function(){
	 $('#table_list').DataTable();
    // Display new ticket modal
    var modal = $('#newTicket');
    
     $('.newTicket').click(function(){
        modal.show();
        var title=$(this).prop('title');
        $('.modal-title').html(title);
       // $('#unit').html(title);
        $('#unit').val(title);
    }); 
    
    $('.close').click(function(){
        modal.hide();
    });
    
    // Insert inserting
    $("#addTicket").submit(function(e){
            e.preventDefault();
              $.ajax({
              url:"/ticket",
              method:"POST",
              enctype: 'multipart/form-data',
              data:new FormData(this),  
              contentType:false,  
              processData:false,
              beforeSend:function(){  
                       $('#addTicketBtn').prop('disabled','disabled').text('Submitting...');  
                   },
              success:function(results){           
                 alert('Add successful');
                 $('#addTicket').reset();
                 $('#addTicketBtn').prop('disabled','false').text('Create Ticket'); 
              } 

              });  
          });   

});
    
//Disable form submissions if there are invalid fields
/* (function() {
  'use strict';
  window.addEventListener('load', function() {
    // Get the forms we want to add validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})(); */
