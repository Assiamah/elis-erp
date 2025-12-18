$(document).ready(function() {

    //console.log('rwegergerferfe');

    $("#btn_send_message").on('click', function(e){

        e.preventDefault();
        
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

                    if(jobdetails = 'success'){
                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Message sent successfully.</span>',
                        }, { type : 'success', z_index : 9999 });

                        setTimeout(function(){
                            window.location.reload();
                         }, 2000);

                    }else {
                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error. Contact IT for support.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }			
                }
            })
        }
    })

    $(".load_message_details").on('click', function(event) {
        event.preventDefault()

        var message_id  = $(event.currentTarget).data('message_id');
        let html = "";
        var userid = $('#userid').val()
        var receiver_name  = $(event.currentTarget).data('receiver_name');
        ///console.log(userid)

        $("#receiver_name").val(receiver_name)

        message_id = message_id.replace('.0', '')

        $.ajax({
            type : "POST",
            url : "Case_Management_Serv",
            data : {
                request_type : 'select_load_message_details',
                message_id : message_id,
            },
            cache : false,
            beforeSend : function() {
                // $('#district').html('<img
                // src="img/loading.gif"
                // alt="" width="24"
                // height="24">');
            },
            success : function(jobdetails) {

                let json_result = JSON.parse(jobdetails);
                //console.log(json_result)
                if(json_result.success){
                    if(json_result.data !== null){
                        for(let i=0; i<json_result.data.length; i++){
                            let id= json_result.data[i].id;
                            let message_id= json_result.data[i].message_id;
                            let sent_by_id= json_result.data[i].sent_by_id;
                            let message= json_result.data[i].message;
                            let sender_name= json_result.data[i].sender_name;
                            let sent_date= json_result.data[i].sent_date;

                            html+= userid == sent_by_id ? '<div class="col-md-9">'
                                    +'<div class="card mb-2 d-flex justify-content-start">'
                                        +'<div class="card-body">'
                                            +'<span>'+message+'</span><br><br>'
                                            +'<i><small>From: Me</small></i><br>'
                                            +'<i><small> Date: '+sent_date+'</small></i>'
                                        +'</div>'
                                    +'</div>'
                                +'</div>' : '<div class="col-md-9">'
                                +'<div class="card mb-2 bg-info">'
                                    +'<div class="card-body">'
                                        +'<span>'+message+'</span><br><br>'
                                        +'<i><small>From: '+sender_name+'</small></i><br>'
                                        +'<i><small> Date: '+sent_date+'</small></i>'
                                    +'</div>'
                                +'</div>'
                            +'</div>'
                        }

                        document.getElementById("message_details").innerHTML = html;
                    }
                }

            }
        })

        $("#text_message_div").removeClass('d-none')
        $("#send_button_div").removeClass('d-none')
        
    })

    $("#btn_reply_message").on('click', function(e){

        e.preventDefault();
        
        var am_to_officer = $("#receiver_name").val();
        var userid  = $("#userid").val();
        var message = $("#txt_reply_message").val();

        console.log(am_to_officer)

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

                    if(jobdetails = 'success'){
                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Message sent successfully.</span>',
                        }, { type : 'success', z_index : 9999 });

                        setTimeout(function(){
                            window.location.reload();
                         }, 2000);

                    }else {
                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error. Contact IT for support.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }			
                }
            })
        }
    })


    

});