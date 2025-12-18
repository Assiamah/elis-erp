$(document).ready(function() {

    console.log('rwegergerferfe')

    $("#btn_send_message").on('click', function(){
        var am_to_officer = $("#am_to_officer").val();
        var userid  = $("#userid").val();
        var message = $("#message_compose_text").val();

        if (!message || !userid){
            alert("Please enter a message");
        }else{
            $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_send_message_to_officer',
                    am_to_officer : am_to_officer,
                    userid : userid,
                    message : message
                },
                cache : false,
                beforeSend : function() {
                    // $('#district').html('<img
                    // src="img/loading.gif"
                    // alt="" width="24"
                    // height="24">');
                },
                success : function(jobdetails) {

                    console.log(jobdetails);
                }
            })
        }
    })

});