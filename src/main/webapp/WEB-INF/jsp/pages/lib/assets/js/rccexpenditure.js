$(document).ready(function(){

    // handle payment form on the modal
    $('form#expenditureForm').submit(function(etv){
        etv.preventDefault();
        var formData = new FormData($(this)[0]);
        var PayAction = $("#expenditureForm").attr('action');
            $.ajax({
                type: "POST",
                url: PayAction,
                data : formData,
                processData: false,
                contentType: false,
                async: false
            }).done(function(data, textStatus, jqXHR){
              if (data.code === 1) {
                swal("Payment Record Successfully added");
                $('table#expenditureTable TBODY').empty();
                $('#expenditureForm')[0].reset();
                $('#errorList').addClass('hidden');
                $.each(data.expense, function(idx, elem){
                    var thedollars = elem.amount_dollars ? elem.amount_dollars : "";
                    $('table#expenditureTable TBODY').append('<tr><td>'+ elem.description +'</td><td>'+ elem.amount +'</td><td>' + thedollars +'</td><td>'+ elem.expenditure_date +'</td></tr>');
                });
                // location.reload();
              } else {
                swal('Sorry! Payment Record could not be added. Please try again.');
              }
            }).fail(function(jqXHR){
              var expResponse = jqXHR.responseJSON;
              $('#errorList').html('');
              $('#errorList').removeClass('hidden');
              $('#errorList').addClass('alert alert-danger');
              $.each(expResponse, function(idx, val){
                  var errrorDisplay = '<ul><li>' + val + '</li></ul>'; 
                  $('#errorList').append(errrorDisplay)
              });
            });
    });
    
    // populate the modal with payment history for selected project
    // $("#modButt").click(function(){
    //     var pid = $("#hiddenID").val();
    //     var expAction = base_url + '/rccexpenditure/dohistory';
    //     $.ajax({
    //         type: "POST",
    //         data: { id : pid },
    //         url: expAction,
    //         success: function(data){
    //             console.log('there');
    //             if (data.code === "0") {
    //               $('table#expenditureTable TBODY').html('');
    //               $('table#expenditureTable TBODY').append('<tr><td colspan="4" align="center">No Expense recorded</td></tr>');
    //             }
    //             else {
    //               $('table#expenditureTable TBODY').empty();
    //               $.each(data, function(idx, elem){
    //                   $('table#expenditureTable TBODY').append('<tr><td>'+elem.description+ '</td><td>' +elem.amount+'</td><td>'+  elem.amount_dollars ? elem.amount_dollars : ""  + '</td><td>' +elem.expenditure_date + '</td></tr>');
    //               });
    //             }
    //         }
    //     });
    // });
});
