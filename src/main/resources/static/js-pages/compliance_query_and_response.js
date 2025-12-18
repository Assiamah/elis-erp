$(document).ready(function(){

    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    function convertDate(date_str) {
        temp_date = date_str.split("-");
        return temp_date[2] + " " + months[Number(temp_date[1]) - 1] + " " + temp_date[0];
    }

    var region_id =$('#sel_change_region_compliance').val();
   // console.log(region_id)

    if(region_id != undefined){
        region_id =  region_id.replace(".0", "");

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'select_compliance_application_notice_count_per_division',
                region_id: parseInt(region_id)
                },
            cache: false,
            beforeSend: function () {
            // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(result) {
//console.log(result)
    
                var response = JSON.parse(result)
                let lrd_total = response.lrd[0].count;
                let lvd_total = response.lvd[0].count;
                let smd_total = response.smd[0].count;
                let pvlmd_total = response.pvlmd[0].count;
    
                document.getElementById('lrd_total').innerHTML = lrd_total;
                document.getElementById('lvd_total').innerHTML = lvd_total;
                document.getElementById('smd_total').innerHTML = smd_total;
                document.getElementById('pvlmd_total').innerHTML = pvlmd_total;
            }
    
        })
    }

   

    $('#sel_change_region_compliance').on('change', function(e) {
        e.preventDefault()

        var region_id = $(this).val()

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                   request_type: 'select_compliance_application_notice_count_per_division',
                   region_id: parseInt(region_id)
                },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(result) {
                console.log(result)

                var response = JSON.parse(result)
                let lrd_total = response.lrd[0].count;
                let lvd_total = response.lvd[0].count;
                let smd_total = response.smd[0].count;
                let pvlmd_total = response.pvlmd[0].count;

                document.getElementById('lrd_total').innerHTML = lrd_total;
                document.getElementById('lvd_total').innerHTML = lvd_total;
                document.getElementById('smd_total').innerHTML = smd_total;
                document.getElementById('pvlmd_total').innerHTML = pvlmd_total;
            }

        })

        $('#table_list').DataTable().clear().destroy();
    })

    

    $('#lvd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("lvd_pending_queries")

        let dataSet =[];
        let num = 0;

        var region_id = $('#sel_change_region_compliance').find(":selected").val()
        var division_name = 'LVD'

        if(region_id == 0) {
            alert('Select a region');
        } else {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                       request_type: 'select_compliance_application_notice',
                       region_id: parseInt(region_id),
                       division_name: division_name
                    },
                cache: false,
                beforeSend: function () {
                   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                },
                success: function(result) {
                   // console.log(result)
    
                    var response = JSON.parse(result)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){
                            let html=[];
                            num = +num+1;
                            let notice_id = response.data[i].notice_id;
                            let job_number = response.data[i].job_number;
                            let details = response.data[i].details;
                            let receiver_name = response.data[i].receiver_name;
                            let created_by = response.data[i].created_by;
                            let region_name = response.data[i].region_name;
                            let unit_name = response.data[i].unit_name;
                            let reply = response.data[i].reply;
                            let tat = response.data[i].tat;
                            let notice_type = response.data[i].notice_type;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let action = `<div class="dropdown no-arrow">
                                                <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v ms-2"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    
                                                <form  action="front_office_view_application" method="post">
                                                <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                    <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                </form>     
                                                <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                <button type="button" class="dropdown-item" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                            </div>`


                            html.push(num);
                            html.push(job_number);
                            html.push(details);
                            html.push(receiver_name); 
                            html.push(unit_name);
                            // html.push(division_name); 
                            html.push(created_by);
                            html.push(created_at); 
                            html.push(tat); 
                            html.push(action); 
                            html.push(reply); 
                            html.push(notice_type); 

                            dataSet.push(html);
                        }
                    }

                    $('#table_list').DataTable().clear().destroy();
								
                    $('#table_list').DataTable({ 
                        data: dataSet,
                        "createdRow": function(row,data,dataIndex){
                            if (data[9] > 0) {
                                // Highest priority: always green if count > 0
                                $(row).addClass('bg-success text-white');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('bg-danger text-white');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('bg-warning text-gray-900');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('bg-info text-white');
                            }
                        },
                        dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                    }).draw();
								
                }
    
            })

			$("#body-bg-1").addClass('bg-active');
            $("#body-bg-2").removeClass('bg-active');
			$("#body-bg-3").removeClass('bg-active');
            $("#body-bg-4").removeClass('bg-active');
        }
    })

    $('#lrd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("lrd_pending_queries")

        let dataSet =[];
        let num = 0;

        var region_id = $('#sel_change_region_compliance').find(":selected").val()
        var division_name = 'LRD'

        if(region_id == 0) {
            alert('Select a region');
        } else {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                       request_type: 'select_compliance_application_notice',
                       region_id: parseInt(region_id),
                       division_name: division_name
                    },
                cache: false,
                beforeSend: function () {
                   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                },
                success: function(result) {
                //    console.log(result)
    
                    var response = JSON.parse(result)
                    console.log(response)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){
                            let html=[];
                            num = +num+1;
                            let notice_id = response.data[i].notice_id;
                            let job_number = response.data[i].job_number;
                            let details = response.data[i].details;
                            let receiver_name = response.data[i].receiver_name;
                            let division_name = response.data[i].division_name;
                            let created_by = response.data[i].created_by;
                            let unit_name = response.data[i].unit_name;
                            let reply = response.data[i].reply;
                            let tat = response.data[i].tat;
                            let notice_type = response.data[i].notice_type;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let action = `<div class="dropdown no-arrow">
                                                <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v ms-2"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    
                                                <form  action="front_office_view_application" method="post">
                                                <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                    <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                </form>     
                                                <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                <button type="button" class="dropdown-item" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                            </div>`

                            html.push(num);
                            html.push(job_number);
                            html.push(details);
                            html.push(receiver_name); 
                            html.push(unit_name);
                            // html.push(division_name); 
                            html.push(created_by);
                            html.push(created_at); 
                            html.push(tat); 
                            html.push(action); 
                            html.push(reply); 
                            html.push(notice_type); 

                            dataSet.push(html);
                        }
                    }

                    $('#table_list').DataTable().clear().destroy();
								
                    $('#table_list').DataTable({ 
                        data: dataSet,
                        "createdRow": function(row,data,dataIndex){
                            if (data[9] > 0) {
                                // Highest priority: always green if count > 0
                                $(row).addClass('bg-success text-white');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('bg-danger text-white');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('bg-warning text-gray-900');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('bg-info text-white');
                            }
                        },
                        dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                    }).draw();
                }
    
            })

			$("#body-bg-1").removeClass('bg-active');
            $("#body-bg-2").addClass('bg-active');
			$("#body-bg-3").removeClass('bg-active');
            $("#body-bg-4").removeClass('bg-active');
        }
    })

    $('#smd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("smd_pending_queries")

        let dataSet =[];
        let num = 0;

        var region_id = $('#sel_change_region_compliance').find(":selected").val()
        var division_name = 'SMD'

        if(region_id == 0) {
            alert('Select a region');
        } else {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                       request_type: 'select_compliance_application_notice',
                       region_id: parseInt(region_id),
                       division_name: division_name
                    },
                cache: false,
                beforeSend: function () {
                   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                },
                success: function(result) {
                   // console.log(result)
    
                    var response = JSON.parse(result)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){
                            let html=[];
                            num = +num+1;
                            let notice_id = response.data[i].notice_id;
                            let job_number = response.data[i].job_number;
                            let details = response.data[i].details;
                            let receiver_name = response.data[i].receiver_name;
                            let division_name = response.data[i].division_name;
                            let created_by = response.data[i].created_by;
                            let unit_name = response.data[i].unit_name;
                            let reply = response.data[i].reply;
                            let tat = response.data[i].tat;
                            let notice_type = response.data[i].notice_type;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let action = `<div class="dropdown no-arrow">
                                                <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v ms-2"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    
                                                <form  action="front_office_view_application" method="post">
                                                <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                    <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                </form>     
                                                <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal" >view messages</button>
                                                <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                <button type="button" class="dropdown-item" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                            </div>`

                                            html.push(num);
                                            html.push(job_number);
                                            html.push(details);
                                            html.push(receiver_name); 
                                            html.push(unit_name);
                                            // html.push(division_name); 
                                            html.push(created_by);
                                            html.push(created_at); 
                                            html.push(tat); 
                                            html.push(action); 
                                            html.push(reply); 
                                            html.push(notice_type);  

                            dataSet.push(html);
                        }
                    }

                    $('#table_list').DataTable().clear().destroy();
								
                    $('#table_list').DataTable({ 
                        data: dataSet,
                        "createdRow": function(row,data,dataIndex){
                            if (data[9] > 0) {
                                // Highest priority: always green if count > 0
                                $(row).addClass('bg-success text-white');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('bg-danger text-white');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('bg-warning text-gray-900');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('bg-info text-white');
                            }
                        },
                        dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                    }).draw();
								
                }
    
            })

			$("#body-bg-1").removeClass('bg-active');
            $("#body-bg-2").removeClass('bg-active');
			$("#body-bg-3").addClass('bg-active');
            $("#body-bg-4").removeClass('bg-active');
        }
    })

    $('#pvlmd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("pvlmd_pending_queries")

        let dataSet =[];
        let num = 0;

        var region_id = $('#sel_change_region_compliance').find(":selected").val()
        var division_name = 'PVLMD'

        if(region_id == 0) {
            alert('Select a region');
        } else {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                       request_type: 'select_compliance_application_notice',
                       region_id: parseInt(region_id),
                       division_name: division_name
                    },
                cache: false,
                beforeSend: function () {
                   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                },
                success: function(result) {
                    //console.log(result)
    
                    var response = JSON.parse(result)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){
                            let html=[];
                            num = +num+1;
                            let notice_id = response.data[i].notice_id;
                            let job_number = response.data[i].job_number;
                            let details = response.data[i].details;
                            let receiver_name = response.data[i].receiver_name;
                            let division_name = response.data[i].division_name;
                            let created_by = response.data[i].created_by;
                            let unit_name = response.data[i].unit_name;
                            let reply = response.data[i].reply;
                            let notice_type = response.data[i].notice_type;
                            let tat = response.data[i].tat;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let action = `<div class="dropdown no-arrow">
                                                <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v ms-2"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    
                                                <form  action="front_office_view_application" method="post">
                                                <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                    <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                </form>     
                                                <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                <button type="button" class="dropdown-item" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                            </div>`


                                            //console.log(notice_type)

                            html.push(num);
                            html.push(job_number);
                            html.push(details);
                            html.push(receiver_name); 
                            html.push(unit_name);
                            // html.push(division_name); 
                            html.push(created_by);
                            html.push(created_at); 
                            html.push(tat); 
                            html.push(action); 
                            html.push(reply); 
                            html.push(notice_type); 

                            dataSet.push(html);
                        }
                    }

                    $('#table_list').DataTable().clear().destroy();
								
                    $('#table_list').DataTable({ 
                        data: dataSet,
                        "createdRow": function(row,data,dataIndex){
                            if (data[9] > 0) {
                                // Highest priority: always green if count > 0
                                $(row).addClass('bg-success text-white');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('bg-danger text-white');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('bg-warning text-gray-900');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('bg-info text-white');
                            }
                        },
                        dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                    }).draw();
								
                }
    
            })

			$("#body-bg-1").removeClass('bg-active');
            $("#body-bg-2").removeClass('bg-active');
			$("#body-bg-3").removeClass('bg-active');
            $("#body-bg-4").addClass('bg-active');
        }
    })


    $('#sendMessageModal').on('show.bs.modal',function(event) {
		$("#sendMessageModal #officer_name").val($(event.relatedTarget).data('officer_name'));	
		$("#sendMessageModal #job_numbers").val('[{"job_number":"'+$(event.relatedTarget).data('job_number')+'"}]');
		$("#sendMessageModal #officer_id").val($(event.relatedTarget).data('officer_id'));
		 //$("#sendMessageModal #sendMessageModalLabel").val('Send Message To '+$(event.relatedTarget).data('receiver_name'));	
        document.getElementById('sendMessageModalLabel').innerHTML = 'Send Message To <span class="text-primary">'+$(event.relatedTarget).data('receiver_name')+'</span>'
		// $("#sendMessageModal #e_lawyer_address").val($(event.relatedTarget).data('lawyer_address'));
		// $("#sendMessageModal #e_lawyer_chamber").val($(event.relatedTarget).data('lawyer_chamber'));
	});

    $("#message-form").on("submit", function (event) {
        event.preventDefault();
    
        let form = $(this);
        let data = form.serializeArray();
        
        
        data = {
            "request_type": $("#sendMessageModal").find("#request_type").val(),
            "officer_id": $("#sendMessageModal").find("#officer_id").val(),
            "officer_name": $("#sendMessageModal").find("#officer_name").val(),
            "job_numbers" : $("#sendMessageModal").find("#job_numbers").val(),
            "message_type":$("#sendMessageModal").find("#message_type").val(),
            "message": $("#sendMessageModal").find("#message").val()
        }
        
        
        // submitAjax(
        //   $(this).attr("action"),
        //   "send_compliance_message",
        //   data,
        //   function () {
        //     form.trigger("reset");
        //     form.parents(".modal").modal("hide");
        //     alert("Message sent successfully.");
        //   },
        //   function () {
        //     alert(
        //       "We were not able to send your message. Please contact IT support if issue persists."
        //     );
        //   }
        // );

        $.ajax({
            type: "POST",
            url: "/SendComplianceMessage",
            data: data,
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(result) {
                var response = JSON.parse(result);
                console.log(response);

                if(response.success == 'true') {

                    form.trigger("reset");
                    form.parents(".modal").modal("hide");
                    alert("Message sent successfully.");

                } else {
                    alert("We were not able to send your message. Please contact IT support if issue persists.");
                }
            }

        })
      });

      $('#changequerystatusModal').on('show.bs.modal',function(event) {
		    $("#changequerystatusModal #job_number").val($(event.relatedTarget).data('job_number'));
            document.getElementById('changequerystatusModalLabel').innerHTML = 'Confirmation: <span class="text-primary">'+$(event.relatedTarget).data('job_number')+'</span>'
	    });

        $("#update-query-form").on("submit", function (event) {
            event.preventDefault();
        
            let form = $(this);
            let data = form.serializeArray();
            
            
            data = {
                "request_type": $("#changequerystatusModal").find("#request_type").val(),
                "job_number" : $("#changequerystatusModal").find("#job_number").val(),
            }
            
    
            $.ajax({
                type: "POST",
                url: "/SendComplianceMessage",
                data: data,
                cache: false,
                beforeSend: function () {
                   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                },
                success: function(result) {
                   // var response = JSON.parse(result);
                    console.log(result);
    
                    if(result == 'Success') {
    
                        //form.trigger("reset");
                        form.parents(".modal").modal("hide");
                        alert("Query updated successfully.");
    
                    } else {
                        alert("We were not able to send your message. Please contact IT support if issue persists.");
                    }
                }
    
            })
          });


          $("#viewresponseModal").on("show.bs.modal",function(event) {
            //event.preventDefault();
            
            data = {
                "notice_id": $(event.relatedTarget).data('notice_id'),
                "request_type": "select_responses_on_compliance_application_notice",
            }
            
            let html = ""
    
            $.ajax({
                type: "POST",
                url: "/SendComplianceMessage",
                data: data,
                cache: false,
                beforeSend: function () {
                   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                },
                success: function(result) {
                   // var response = JSON.parse(result);
                    //console.log(result);
                    var response = JSON.parse(result)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){

                            html += `<li><h6>${response.data[i].reply_details}</h6><br> — <i>${response.data[i].created_by}</i>| <span class="small">${convertDate(response.data[i].created_date.slice(0,10))}</span><hr></li>`

                        }

                        document.getElementById('response_list').innerHTML = html;
                    }
                    else {

                        html = `No response`
                        document.getElementById('response_list').innerHTML = html;
                    }
                }
    
            })
          });


          $('#compliance_query_apps_card').on('click', function(e) {
            e.preventDefault()
    
            let dataSet =[];
            let num = 0;
    
            var userid = $('#userid').val()

                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                           request_type: 'select_compliance_application_notice_by_division',
                           notice_status: 'compliance_query',
                        },
                    cache: false,
                    beforeSend: function () {
                       // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                    },
                    success: function(result) {
                        console.log(result)
        
                        var response = JSON.parse(result)
                        if(response.data !== null){
                            for(let i=0; i<response.data.length; i++){
                                let html=[];
                                num = +num+1;
                                let notice_id = response.data[i].notice_id;
                                let job_number = response.data[i].job_number;
                                let details = response.data[i].details;
                                let receiver_name = response.data[i].receiver_name;
                                let division_name = response.data[i].division_name;
                                let region_name = response.data[i].region_name;
                                let unit_name = response.data[i].unit_name;
                                let reply = response.data[i].reply;
                                let modified_by = response.data[i].modified_by;
                                let tat = response.data[i].tat;
                                let notice_type = response.data[i].notice_type;
                                let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                                let action = `<div class="dropdown no-arrow">
                                                    <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v ms-2"></i>
                                                    </a>
                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                        
                                                    <form  action="front_office_view_application" method="post">
                                                    <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                    </form>     
                                                    <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                    <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                    <button type="button" class="dropdown-item ${userid == response.data[i].created_by_id ? '' : 'd-none'}" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                                </div>`
    
                                html.push(num);
                                html.push(job_number);
                                html.push(details);
                                html.push(receiver_name); 
                                html.push(unit_name); 
                                html.push(modified_by);
                                html.push(created_at); 
                                html.push(tat); 
                                html.push(action); 
                                html.push(reply); 
                                html.push(notice_type); 
    
                                dataSet.push(html);
                            }
                        }
    
                        $('#table_list').DataTable().clear().destroy();
                                    
                        $('#table_list').DataTable({ 
                            data: dataSet,
                            "createdRow": function(row,data,dataIndex){
                                if (data[10] > 0) {
                                    // Highest priority: always green if count > 0
                                    $(row).addClass('bg-success text-white');
                                } 
                                else if (data[11] === null || data[11].toLowerCase() === 'query') {
                                    $(row).addClass('bg-danger text-white');
                                } 
                                else if (data[11].toLowerCase() === 'warning') {
                                    $(row).addClass('bg-warning text-gray-900');
                                } 
                                else if (data[11].toLowerCase() === 'reminder') {
                                    $(row).addClass('bg-info text-white');
                                }
                            },
                            dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                        }).draw();
                                    
                    }
        
                })
    
                $("#body-bg-1").addClass('bg-active');
                $("#body-bg-2").removeClass('bg-active');
                $("#body-bg-3").removeClass('bg-active');
          
        })


        $('#warning_apps_card').on('click', function(e) {
            e.preventDefault()
    
            let dataSet =[];
            let num = 0;
            var userid = $('#userid').val()
    
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                           request_type: 'select_compliance_application_notice_by_division',
                           notice_status: 'warnings',
                        },
                    cache: false,
                    beforeSend: function () {
                       // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                    },
                    success: function(result) {
                       // console.log(result)
        
                        var response = JSON.parse(result)
                        if(response.data !== null){
                            for(let i=0; i<response.data.length; i++){
                                let html=[];
                                num = +num+1;
                                let notice_id = response.data[i].notice_id;
                                let job_number = response.data[i].job_number;
                                let details = response.data[i].details;
                                let receiver_name = response.data[i].receiver_name;
                                let division_name = response.data[i].division_name;
                                let modified_by = response.data[i].modified_by;
                                let unit_name = response.data[i].unit_name;
                                let reply = response.data[i].reply;
                                let tat = response.data[i].tat;
                                let notice_type = response.data[i].notice_type;
                                let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                                let action = `<div class="dropdown no-arrow">
                                                    <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v ms-2"></i>
                                                    </a>
                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                        
                                                    <form  action="front_office_view_application" method="post">
                                                    <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                    </form>     
                                                    <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                    <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                    <button type="button" class="dropdown-item ${userid == response.data[i].created_by_id ? '' : 'd-none'}" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                                </div>`
    
                                html.push(num);
                                html.push(job_number);
                                html.push(details);
                                html.push(receiver_name); 
                                html.push(unit_name);
                                html.push(modified_by);
                                html.push(created_at); 
                                html.push(tat); 
                                html.push(action); 
                                html.push(reply); 
                                html.push(notice_type); 
    
                                dataSet.push(html);
                            }
                        }
    
                        $('#table_list').DataTable().clear().destroy();
                                    
                        $('#table_list').DataTable({ 
                            data: dataSet,
                            dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                        }).draw();
                                    
                    }
        
                })
    
                $("#body-bg-1").removeClass('bg-active');
                $("#body-bg-2").addClass('bg-active');
                $("#body-bg-3").removeClass('bg-active');
          
        })


        $('#reminder_apps_card').on('click', function(e) {
            e.preventDefault()
    
            let dataSet =[];
            let num = 0;
    
            var userid = $('#userid').val()
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                           request_type: 'select_compliance_application_notice_by_division',
                           notice_status: 'reminders',
                        },
                    cache: false,
                    beforeSend: function () {
                       // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                    },
                    success: function(result) {
                       // console.log(result)
        
                        var response = JSON.parse(result)
                        if(response.data !== null){
                            for(let i=0; i<response.data.length; i++){
                                let html=[];
                                num = +num+1;
                                let notice_id = response.data[i].notice_id;
                                let job_number = response.data[i].job_number;
                                let details = response.data[i].details;
                                let receiver_name = response.data[i].receiver_name;
                                let division_name = response.data[i].division_name;
                                let modified_by = response.data[i].modified_by;
                                let unit_name = response.data[i].unit_name;
                                let reply = response.data[i].reply;
                                let notice_type = response.data[i].notice_type;
                                let tat = response.data[i].tat;
                                let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                                let action = `<div class="dropdown no-arrow">
                                                    <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v ms-2"></i>
                                                    </a>
                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                        
                                                    <form  action="front_office_view_application" method="post">
                                                    <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                    </form>     
                                                    <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                    <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                    <button type="button" class="dropdown-item ${userid == response.data[i].created_by_id ? '' : 'd-none'}" href="#" data-job_number="${response.data[i].job_number}" data-target="#changequerystatusModal" data-toggle="modal" > Set To Inactive</button>
                                                </div>`
    
                                html.push(num);
                                html.push(job_number);
                                html.push(details);
                                html.push(receiver_name); 
                                html.push(unit_name); 
                                html.push(modified_by);
                                html.push(created_at); 
                                html.push(tat); 
                                html.push(action); 
                                html.push(reply); 
                                html.push(notice_type); 
    
                                dataSet.push(html);
                            }
                        }
    
                        $('#table_list').DataTable().clear().destroy();
                                    
                        $('#table_list').DataTable({ 
                            data: dataSet,
                            dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                        }).draw();
                                    
                    }
        
                })
    
                $("#body-bg-1").removeClass('bg-active');
                $("#body-bg-2").removeClass('bg-active');
                $("#body-bg-3").addClass('bg-active');
          
        })


        $('#cr_division_name').on('change', function(e) {
            var region_code = $('#cr_region_code').val()
            var division_name = $('#cr_division_name').val()
            //console.log(region_code, division_name)
            let html = ""

            if(!region_code){
                alert("Please select region")
                $('#cr_division_name').val("-- select --")
            } else {
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                           request_type: 'select_unit_for_compliance_report',
                           region_code: region_code =  region_code.replace(".0", ""),
                           division_name: division_name
                        },
                    cache: false,
                    beforeSend: function () {},
                    success: function(result) {
    
                        //console.log(result);
                        let json_result = JSON.parse(result);
                        html = '<option  disabled selected>-- select --</option>'
    
                        for(let i=0; i<json_result.data.length; i++){
                                
                            html += `<option value="${json_result.data[i].unit_id}" >${json_result.data[i].unit_name} </option>`
                           
                        }
                                    
                        document.getElementById("cr_unit_name").innerHTML = html; 
                    }
                })
            }
        })

        $('#cr_unit_name').on('change', function(e) {
            var unit_id = $('#cr_unit_name').val()

            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                       request_type: 'select_officers_for_compliance_report',
                       //region_code: region_code =  region_code.replace(".0", ""),
                       unit_id: unit_id
                    },
                cache: false,
                beforeSend: function () {},
                success: function(result) {

                    //console.log(result);
                    let json_result = JSON.parse(result);
                    html = '<option  disabled selected>-- select --</option>'

                    for(let i=0; i<json_result.data.length; i++){
                            
                        html += `<option value="${json_result.data[i].userid}" >${json_result.data[i].fullname} </option>`
                       
                    }
                                
                    document.getElementById("cr_user").innerHTML = html; 
                }
            })
            
        })

        $('#btn_compliance_notice_report').on('click', function(e) {

            e.preventDefault()
    
            let dataSet =[];
            let num = 0;

            var date_from = $('#date_from').val()
            var date_to = $('#date_to').val()
            var region_code = $('#cr_region_code').val()
            var division_name = $('#cr_division_name').val()
            var unit_id = $('#cr_unit_name').val()
            var officer_id = $('#cr_user').val();

            if(!date_from || !date_to || !region_code || !division_name || !unit_id){
                alert("Please fill the required field.")
            } else {

                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                           request_type: 'select_generate_compliance_notice_report',
                           //region_code: region_code =  region_code.replace(".0", ""),
                           officer_id: officer_id,
                           date_from: date_from,
                           date_to: date_to,
                           unit_id: unit_id
                        },
                    cache: false,
                    beforeSend: function () {},
                    success: function(result) {
    
                        console.log(result);
            
                        var response = JSON.parse(result)
                        if(response.data !== null){
                            for(let i=0; i<response.data.length; i++){
                                let html=[];
                                num = +num+1;
                                let notice_id = response.data[i].notice_id;
                                let job_number = response.data[i].job_number;
                                let details = response.data[i].details;
                                let receiver_name = response.data[i].receiver_name;
                                let division_name = response.data[i].division_name;
                                let region_name = response.data[i].region_name;
                                let reminder_date = response.data[i].reminder_date;
                                let warning_date = response.data[i].warning_date;
                                let reply = response.data[i].reply;
                                let notice_type = response.data[i].notice_type;
                                let tat = response.data[i].tat;
                                let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                                // let action = `<div class="dropdown no-arrow">
                                //                     <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                //                         <i class="fas fa-ellipsis-v ms-2"></i>
                                //                     </a>
                                //                     <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                        
                                //                     <form  action="front_office_view_application" method="post">
                                //                     <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                //                         <button type="submit" class="dropdown-item" href="#">View Application</button>
                                //                     </form>     
                                //                     <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                //                     <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                //                     <button type="button" class="dropdown-item" href="#" data-job_number="${response.data[i].job_number}" data-target="#viewComplianceLogsModal" data-toggle="modal">View Logs</button>
                                //                 </div>`
                                let action = `<div class="dropdown no-arrow">
                                                    <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v ms-2"></i>
                                                    </a>
                                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">   
                                                    <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                </div>`
    
                                html.push(num);
                                html.push(job_number);
                                html.push(notice_type);
                                html.push(details); 
                                html.push(receiver_name); 
                                html.push(division_name);
                                html.push(region_name); 
                                html.push(reminder_date);
                                html.push(warning_date);
                                html.push(created_at);
                                html.push(tat);
                                html.push(action); 
                                html.push(reply); 
                                html.push(notice_type); 
    
                                dataSet.push(html);
                            }
                        } else {
                            alert("No report found.")
                        }
    
                        $('#table_list').DataTable().clear().destroy();
                                    
                        $('#table_list').DataTable({ 
                            data: dataSet,
                            "createdRow": function(row,data,dataIndex){
                                if (data[9] > 0) {
                                    // Highest priority: always green if count > 0
                                    $(row).addClass('bg-success text-white');
                                } 
                                else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                    $(row).addClass('bg-danger text-white');
                                } 
                                else if (data[10].toLowerCase() === 'warning') {
                                    $(row).addClass('bg-warning text-gray-900');
                                } 
                                else if (data[10].toLowerCase() === 'reminder') {
                                    $(row).addClass('bg-info text-white');
                                }
                            },
                            dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                        }).draw();
                    }
                })
            }
        })

        $("#viewComplianceLogsModal").on("shown.bs.modal",function(e) {
            e.preventDefault();

            let dataSet =[];
            let num = 0;

            var job_number = $(e.relatedTarget).data('job_number');
            console.log(job_number);

            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                       request_type: 'select_compliance_notice_report_logs',
                       job_number: job_number
                    },
                cache: false,
                beforeSend: function () {},
                success: function(result) {

                    console.log(result);
        
                    var response = JSON.parse(result)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){
                            let html=[];
                            num = +num+1;
                            let notice_id = response.data[i].notice_id;
                            let job_number = response.data[i].job_number;
                            let details = response.data[i].details;
                            let receiver_name = response.data[i].receiver_name;
                            let division_name = response.data[i].division_name;
                            let region_name = response.data[i].region_name;
                            let reply = response.data[i].reply;
                            let notice_type = response.data[i].notice_type;
                            let tat = response.data[i].tat;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let action = `<div class="dropdown no-arrow">
                                                <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v ms-2"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    
                                                <form  action="front_office_view_application" method="post">
                                                <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                    <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                </form>     
                                                <button type="button" class="dropdown-item" href="#" data-notice_id="${response.data[i].notice_id}" data-target="#viewresponseModal" data-toggle="modal">view messages</button>
                                                <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                                <button type="button" class="dropdown-item" href="#" data-job_number="${response.data[i].job_number}" data-target="#viewComplianceLogsModal" data-toggle="modal">View Logs</button>
                                            </div>`

                            html.push(num);
                            html.push(job_number);
                            html.push(details);
                            html.push(notice_type);
                            html.push(receiver_name); 
                            html.push(division_name); 
                            html.push(region_name);
                            html.push(created_at); 
                            html.push(tat); 
                            html.push(action); 
                            html.push(reply); 
                            html.push(notice_type); 

                            dataSet.push(html);
                        }
                    } else {
                        alert("No report found.")
                    }

                    $('#table_list_logs').DataTable().clear().destroy();
                                
                    $('#table_list_logs').DataTable({ 
                        data: dataSet,
                        // "createdRow": function(row,data,dataIndex){
                        //     if(data[9] > 0){
                        //         $(row).addClass('bg-success text-white');
                        //     }
                        //     else if(data[10] == 'query'){
                        //         $(row).addClass('bg-danger text-white');
                        //     }
                        //     else if(data[10] == 'Warning'){
                        //         $(row).addClass('bg-warning text-secondary');
                        //     }
                        //     else if(data[10] == 'Reminder'){
                        //         $(row).addClass('bg-info text-white');
                        //     }
                        // },
                        dom: 'Bfrtip',
                        //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        buttons: [
                          {
                              extend: 'copyHtml5',
                              exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                              }
                          },
                          {
                              extend: 'excelHtml5',
                              exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                              }
                          },
                          {
                              extend: 'pdfHtml5',
                              exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                              }
                          },
                          {
                            extend: 'print',
                            exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                            }
                        }
                      ]
                    }).draw();
                }
            })

        })


        $("#btnPendingQueries").on("click", function(e){

            var pending_queries_input = $("#pending_queries_input").val();
            var region_id =$('#sel_change_region_compliance').val();

            let dataSet =[];
            let num = 0;
           //console.log(pending_queries_input)

            $("#pending_queries_modal").modal("show");

            if(pending_queries_input == 'lvd_pending_queries'){

                $("#applicationsModalLabelcq").text("LVD's Pending Queries")

            }else if(pending_queries_input == 'smd_pending_queries'){

                $("#applicationsModalLabelcq").text("SMD's Pending Queries")

            }else if(pending_queries_input == 'pvlmd_pending_queries'){

                $("#applicationsModalLabelcq").text("PVLMD's Pending Queries")

            }else if(pending_queries_input == 'lrd_pending_queries'){

                $("#applicationsModalLabelcq").text("LRD's Pending Queries")
            }
         
            region_id =  region_id.replace(".0", "");

            if(pending_queries_input == ""){

                alert('Please Select Division to load queries');

                return;
            }else{

                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                           request_type: 'select_pending_queries_for_compliance_notice',
                           pending_queries_input: pending_queries_input,
                           region_id: region_id
                        },
                    cache: false,
                    beforeSend: function () {},
                    success: function(result) {

                        var response = JSON.parse(result)
                    if(response.data !== null){
                        for(let i=0; i<response.data.length; i++){
                            let html=[];
                            num = +num+1;
                            let notice_id = response.data[i].notice_id;
                            let job_number = response.data[i].job_number;
                            let details = response.data[i].details;
                            let receiver_name = response.data[i].receiver_name;
                            let division_name = response.data[i].division_name;
                            let region_name = response.data[i].region_name;
                            let unit_name = response.data[i].unit_name;
                            let reply = response.data[i].reply;
                            let tat = response.data[i].tat;
                            let notice_type = response.data[i].notice_type;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let action = `<div class="dropdown no-arrow">
                                                <a class="icon dropdown-toggle btn btn-secondary" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v ms-2"></i>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    
                                                <form  action="front_office_view_application" method="post">
                                                <input type="hidden"  name="search_text" value="${response.data[i].case_number}">
                                                    <button type="submit" class="dropdown-item" href="#">View Application</button>
                                                </form>     
                                                <button type="button" class="dropdown-item" href="#" data-receiver_name="${response.data[i].receiver_name}" data-officer_name="${response.data[i].created_by}" data-job_number="${response.data[i].job_number}" data-officer_id="${response.data[i].created_by_id}" data-target="#sendMessageModal" data-toggle="modal" >Send Message</button>
                                               
                                            </div>`

                            html.push(num);
                            html.push(job_number);
                            html.push(details);
                            html.push(receiver_name); 
                            html.push(unit_name);
                            // html.push(division_name); 
                            // html.push(region_name);
                            html.push(tat);
                            html.push(created_at); 
                            html.push(action); 
                            html.push(reply); 
                            html.push(notice_type); 

                            dataSet.push(html);
                        }
                    }

                    $('#pending_queries_table_list').DataTable().clear().destroy();
								
                    $('#pending_queries_table_list').DataTable({ 
                        data: dataSet,
                        // "createdRow": function(row,data,dataIndex){
                        //     if(data[8] > 0){
                        //         $(row).addClass('bg-success text-white');
                        //     }
                        //     else if(data[9] == 'query'){
                        //         $(row).addClass('bg-danger text-white');
                        //     }
                        //     else if(data[9] == 'Warning'){
                        //         $(row).addClass('bg-warning text-secondary');
                        //     }
                        //     else if(data[9] == 'Reminder'){
                        //         $(row).addClass('bg-info text-white');
                        //     }
                        // }
                        dom: 'Bfrtip',
                            //buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                            buttons: [
                              {
                                  extend: 'copyHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'excelHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                  extend: 'pdfHtml5',
                                  exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                  }
                              },
                              {
                                extend: 'print',
                                exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            }
                          ]
                    }).draw();
                    }
                });
            }


        })
})