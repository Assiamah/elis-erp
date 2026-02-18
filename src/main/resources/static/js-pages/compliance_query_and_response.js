$(document).ready(function(){

    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    function convertDate(date_str) {
        temp_date = date_str.split("-");
        return temp_date[2] + " " + months[Number(temp_date[1]) - 1] + " " + temp_date[0];
    }

    window.initializeTooltips();

    $('#table_list').DataTable();

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

        removeAllActiveStates();

        $("#card_title").text("LVD");

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
                            let created_by = response.data[i].created_by;
                            let region_name = response.data[i].region_name;
                            let unit_name = response.data[i].unit_name;
                            let reply = response.data[i].reply;
                            let tat = response.data[i].tat;
                            let notice_type = response.data[i].notice_type;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));
                            let modified_by = response.data[i].modified_by;
                            let modified_date = !response.data[i].modified_date ? '' : 	convertDate(response.data[i].modified_date.slice(0,10));
                            let action = `<!-- Action Menu Button -->
                                        <div class="dropdown action-menu";">
                                            <button class="btn btn-sm btn-primary btn-icon border-0" 
                                                    type="button" 
                                                    id="actionMenu${i}" 
                                                    data-bs-toggle="dropdown" 
                                                    aria-expanded="false"
                                                    aria-label="Action menu for ${response.data[i].job_number}">
                                                <i class="ri-more-2-fill"></i>
                                            </button>
                                            
                                            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 py-2" 
                                                aria-labelledby="actionMenu${i}" style="width: 200px">
                                                
                                                <!-- View Application -->
                                                <li>
                                                    <form action="front_office_view_application" method="post">
                                                        <input type="hidden" name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2 px-3 py-2">
                                                            <i class="ri-eye-line text-primary"></i>
                                                            <span>View Application</span>
                                                        </button>
                                                    </form>
                                                </li>
                                                
                                                <!-- View Messages -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 view-messages"
                                                            data-notice_id="${response.data[i].notice_id}">
                                                        <i class="ri-message-2-line text-info"></i>
                                                        <span>View Messages</span>
                                                        <!--<span class="badge bg-info-subtle text-info ms-auto small">${response.data[i].message_count || 0}</span>-->
                                                    </button>
                                                </li>
                                                
                                                <!-- Send Message -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 sendMessage_unit_case"
                                                            data-receiver_name="${response.data[i].receiver_name}"
                                                            data-officer_name="${response.data[i].receiver_name}"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-officer_id="${response.data[i].receiver_id}">
                                                        <i class="ri-send-plane-line text-success"></i>
                                                        <span>Send Message</span>
                                                    </button>
                                                </li>
                                                
                                                <li><hr class="dropdown-divider my-1"></li>
                                                
                                                <!-- Set To Inactive -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 text-danger"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-bs-target="#changequerystatusModal"
                                                            data-bs-toggle="modal">
                                                        <i class="ri-toggle-line"></i>
                                                        <span>Set To Inactive</span>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>`


                            html.push(`<span class="small">${num}</span>`);
                            html.push(`<span class="text-primary small">${job_number}</span>`);
                            html.push(`<div class="small text-dark" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${details}">
                        ${truncateText(details, 60)}
                      </div>`);
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${receiver_name}</div>
                                        </div>
                                    </div>`); 
                            html.push(`<span class="small">${unit_name}</span>`);
                            // html.push(division_name); 
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${!modified_by ? created_by : modified_by}</div>
                                        </div>
                                    </div>`);
                            html.push(`<span class="small">${!modified_date ? created_at : modified_date}</span>`); 
                            html.push(`<span class="small">${tat} days</span>`); 
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
                                $(row).addClass('table-success text-dark');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('table-danger text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('table-warning text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('table-info text-dark');
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

                    setTimeout(function() {
                        window.initializeTooltips();
                    }, 50);
								
                }
    
            })

			// $("#body-bg-1").addClass('bg-active');
            // $("#body-bg-2").removeClass('bg-active');
			// $("#body-bg-3").removeClass('bg-active');
            // $("#body-bg-4").removeClass('bg-active');
            highlightActiveCard(1);
        }
    })

    $('#lrd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("lrd_pending_queries")
        
        removeAllActiveStates();

        $("#card_title").text("LRD");

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
                 //  console.log(result)
    
                    var response = JSON.parse(result)
                    //console.log(response)
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
                            let modified_by = response.data[i].modified_by;
                            let modified_date = !response.data[i].modified_date ? '' : 	convertDate(response.data[i].modified_date.slice(0,10));
                            let action = `<!-- Action Menu Button -->
                                        <div class="dropdown action-menu";">
                                            <button class="btn btn-sm btn-primary btn-icon border-0" 
                                                    type="button" 
                                                    id="actionMenu${i}" 
                                                    data-bs-toggle="dropdown" 
                                                    aria-expanded="false"
                                                    aria-label="Action menu for ${response.data[i].job_number}">
                                                <i class="ri-more-2-fill"></i>
                                            </button>
                                            
                                            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 py-2" 
                                                aria-labelledby="actionMenu${i}" style="width: 200px">
                                                
                                                <!-- View Application -->
                                                <li>
                                                    <form action="front_office_view_application" method="post">
                                                        <input type="hidden" name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2 px-3 py-2">
                                                            <i class="ri-eye-line text-primary"></i>
                                                            <span>View Application</span>
                                                        </button>
                                                    </form>
                                                </li>
                                                
                                                <!-- View Messages -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 view-messages"
                                                            data-notice_id="${response.data[i].notice_id}">
                                                        <i class="ri-message-2-line text-info"></i>
                                                        <span>View Messages</span>
                                                        <!--<span class="badge bg-info-subtle text-info ms-auto small">${response.data[i].message_count || 0}</span>-->
                                                    </button>
                                                </li>
                                                
                                                <!-- Send Message -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 sendMessage_unit_case"
                                                            data-receiver_name="${response.data[i].receiver_name}"
                                                            data-officer_name="${response.data[i].receiver_name}"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-officer_id="${response.data[i].receiver_id}">
                                                        <i class="ri-send-plane-line text-success"></i>
                                                        <span>Send Message</span>
                                                    </button>
                                                </li>
                                                
                                                <li><hr class="dropdown-divider my-1"></li>
                                                
                                                <!-- Set To Inactive -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 text-danger"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-bs-target="#changequerystatusModal"
                                                            data-bs-toggle="modal">
                                                        <i class="ri-toggle-line"></i>
                                                        <span>Set To Inactive</span>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>`

                            html.push(`<span class="small">${num}</span>`);
                            html.push(`<span class="text-primary small">${job_number}</span>`);
                            html.push(`<div class="small text-dark" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${details}">
                        ${truncateText(details, 60)}
                      </div>`);
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${receiver_name}</div>
                                        </div>
                                    </div>`); 
                            html.push(`<span class="small">${unit_name}</span>`);
                            // html.push(division_name); 
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${!modified_by ? created_by : modified_by}</div>
                                        </div>
                                    </div>`);
                            html.push(`<span class="small">${!modified_date ? created_at : modified_date}</span>`); 
                            html.push(`<span class="small">${tat} days</span>`); 
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
                                $(row).addClass('table-success text-dark');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('table-danger text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('table-warning text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('table-info text-dark');
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

                    setTimeout(function() {
                        window.initializeTooltips();
                    }, 50);
                }
    
            })

			// $("#body-bg-1").removeClass('bg-active');
            // $("#body-bg-2").addClass('bg-active');
			// $("#body-bg-3").removeClass('bg-active');
            // $("#body-bg-4").removeClass('bg-active');
            highlightActiveCard(2);
        }
    })

    $('#smd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("smd_pending_queries")

        removeAllActiveStates();

        $("#card_title").text("SMD");

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
                            let modified_by = response.data[i].modified_by;
                            let modified_date = !response.data[i].modified_date ? '' : 	convertDate(response.data[i].modified_date.slice(0,10));
                            let action = `<!-- Action Menu Button -->
                                        <div class="dropdown action-menu";">
                                            <button class="btn btn-sm btn-primary btn-icon border-0" 
                                                    type="button" 
                                                    id="actionMenu${i}" 
                                                    data-bs-toggle="dropdown" 
                                                    aria-expanded="false"
                                                    aria-label="Action menu for ${response.data[i].job_number}">
                                                <i class="ri-more-2-fill"></i>
                                            </button>
                                            
                                            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 py-2" 
                                                aria-labelledby="actionMenu${i}" style="width: 200px">
                                                
                                                <!-- View Application -->
                                                <li>
                                                    <form action="front_office_view_application" method="post">
                                                        <input type="hidden" name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2 px-3 py-2">
                                                            <i class="ri-eye-line text-primary"></i>
                                                            <span>View Application</span>
                                                        </button>
                                                    </form>
                                                </li>
                                                
                                                <!-- View Messages -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 view-messages"
                                                            data-notice_id="${response.data[i].notice_id}">
                                                        <i class="ri-message-2-line text-info"></i>
                                                        <span>View Messages</span>
                                                        <!--<span class="badge bg-info-subtle text-info ms-auto small">${response.data[i].message_count || 0}</span>-->
                                                    </button>
                                                </li>
                                                
                                                <!-- Send Message -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 sendMessage_unit_case"
                                                            data-receiver_name="${response.data[i].receiver_name}"
                                                            data-officer_name="${response.data[i].receiver_name}"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-officer_id="${response.data[i].receiver_id}">
                                                        <i class="ri-send-plane-line text-success"></i>
                                                        <span>Send Message</span>
                                                    </button>
                                                </li>
                                                
                                                <li><hr class="dropdown-divider my-1"></li>
                                                
                                                <!-- Set To Inactive -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 text-danger"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-bs-target="#changequerystatusModal"
                                                            data-bs-toggle="modal">
                                                        <i class="ri-toggle-line"></i>
                                                        <span>Set To Inactive</span>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>`

                                          html.push(`<span class="small">${num}</span>`);
                            html.push(`<span class="text-primary small">${job_number}</span>`);
                           html.push(`<div class="small text-dark" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${details}">
                        ${truncateText(details, 60)}
                      </div>`);
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${receiver_name}</div>
                                        </div>
                                    </div>`); 
                            html.push(`<span class="small">${unit_name}</span>`);
                            // html.push(division_name); 
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${!modified_by ? created_by : modified_by}</div>
                                        </div>
                                    </div>`);
                            html.push(`<span class="small">${!modified_date ? created_at : modified_date}</span>`); 
                            html.push(`<span class="small">${tat} days</span>`); 
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
                                $(row).addClass('table-success text-dark');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('table-danger text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('table-warning text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('table-info text-dark');
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

                    setTimeout(function() {
                        window.initializeTooltips();
                    }, 50);
								
                }
    
            })

			// $("#body-bg-1").removeClass('bg-active');
            // $("#body-bg-2").removeClass('bg-active');
			// $("#body-bg-3").addClass('bg-active');
            // $("#body-bg-4").removeClass('bg-active');
            highlightActiveCard(3);
        }
    })

    $('#pvlmd_card').on('click', function(e) {
        e.preventDefault()

        $("#pending_queries_input").val("pvlmd_pending_queries")

        removeAllActiveStates();

        $("#card_title").text("PVLMD");

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
                            let notice_type = response.data[i].notice_type;
                            let tat = response.data[i].tat;
                            let created_at = convertDate(response.data[i].created_date.slice(0,10));	
                            let modified_by = response.data[i].modified_by;
                            let modified_date = !response.data[i].modified_date ? '' : 	convertDate(response.data[i].modified_date.slice(0,10));
                           let action = `<!-- Action Menu Button -->
                                        <div class="dropdown action-menu";">
                                            <button class="btn btn-sm btn-primary btn-icon border-0" 
                                                    type="button" 
                                                    id="actionMenu${i}" 
                                                    data-bs-toggle="dropdown" 
                                                    aria-expanded="false"
                                                    aria-label="Action menu for ${response.data[i].job_number}">
                                                <i class="ri-more-2-fill"></i>
                                            </button>
                                            
                                            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 py-2" 
                                                aria-labelledby="actionMenu${i}" style="width: 200px">
                                                
                                                <!-- View Application -->
                                                <li>
                                                    <form action="front_office_view_application" method="post">
                                                        <input type="hidden" name="search_text" value="${response.data[i].case_number}">
                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2 px-3 py-2">
                                                            <i class="ri-eye-line text-primary"></i>
                                                            <span>View Application</span>
                                                        </button>
                                                    </form>
                                                </li>
                                                
                                                <!-- View Messages -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 view-messages"
                                                            data-notice_id="${response.data[i].notice_id}">
                                                        <i class="ri-message-2-line text-info"></i>
                                                        <span>View Messages</span>
                                                        <!--<span class="badge bg-info-subtle text-info ms-auto small">${response.data[i].message_count || 0}</span>-->
                                                    </button>
                                                </li>
                                                
                                                <!-- Send Message -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 sendMessage_unit_case"
                                                            data-receiver_name="${response.data[i].receiver_name}"
                                                            data-officer_name="${response.data[i].receiver_name}"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-officer_id="${response.data[i].receiver_id}">
                                                        <i class="ri-send-plane-line text-success"></i>
                                                        <span>Send Message</span>
                                                    </button>
                                                </li>
                                                
                                                <li><hr class="dropdown-divider my-1"></li>
                                                
                                                <!-- Set To Inactive -->
                                                <li>
                                                    <button type="button" 
                                                            class="dropdown-item d-flex align-items-center gap-2 px-3 py-2 text-danger"
                                                            data-job_number="${response.data[i].job_number}"
                                                            data-bs-target="#changequerystatusModal"
                                                            data-bs-toggle="modal">
                                                        <i class="ri-toggle-line"></i>
                                                        <span>Set To Inactive</span>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>`

                                            //console.log(notice_type)

                            html.push(`<span class="small">${num}</span>`);
                            html.push(`<span class="text-primary small">${job_number}</span>`);
                           html.push(`<div class="small text-dark" data-bs-toggle="tooltip"  data-bs-custom-class="tooltip-primary" title="${details}">
                        ${truncateText(details, 60)}
                      </div>`);
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${receiver_name}</div>
                                        </div>
                                    </div>`); 
                            html.push(`<span class="small">${unit_name}</span>`);
                            // html.push(division_name); 
                            html.push(`<div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium small">${!modified_by ? created_by : modified_by}</div>
                                        </div>
                                    </div>`);
                            html.push(`<span class="small">${!modified_date ? created_at : modified_date}</span>`); 
                            html.push(`<span class="small">${tat} days</span>`); 
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
                                $(row).addClass('table-success text-dark');
                            } 
                            else if (data[10] === null || data[10].toLowerCase() === 'query') {
                                $(row).addClass('table-danger text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'warning') {
                                $(row).addClass('table-warning text-dark');
                            } 
                            else if (data[10].toLowerCase() === 'reminder') {
                                $(row).addClass('table-info text-dark');
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

                    setTimeout(function() {
                        window.initializeTooltips();
                    }, 50);
								
                }
    
            })

			// $("#body-bg-1").removeClass('bg-active');
            // $("#body-bg-2").removeClass('bg-active');
			// $("#body-bg-3").removeClass('bg-active');
            // $("#body-bg-4").addClass('bg-active');
            highlightActiveCard(4);
        }
    });

    function removeAllActiveStates() {
    	// Remove all light background classes
		$("#body-bg-1, #body-bg-2, #body-bg-4, #body-bg-5, #body-bg-6, #body-bg-7")
			.removeClass('bg-primary-light bg-danger-light bg-warning-light bg-info-light bg-success-light bg-secondary-light');
		
		// Reset text colors (optional - keep text as is)
		$("#number-text-1, #number-text-2, #number-text-4, #number-text-5, #number-text-6, #number-text-7")
			.removeClass('text-white');
		
		// Remove active class from all cards
		$('.dashboard-main-card').removeClass('active-card');
	}

	function highlightActiveCard(inbox_type) {
		switch (inbox_type) {
			case 1: // Incoming Files - Primary
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-1").addClass('bg-primary-light');
				$("#number-text-1").addClass('text-white');
				$("#card-lvd").addClass('active-card');
				break;
			case 2: // Queried - Danger
				$(".btn-to-be-disabled").prop('disabled', false);
				$("#body-bg-2").addClass('bg-danger-light');
				$("#number-text-2").addClass('text-white');
				$("#card-lrd").addClass('active-card');
				break;
			case 3: // Awaiting Payments - Warning
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-3").addClass('bg-info-light');
				$("#number-text-3").addClass('text-white');
				$("#card-smd").addClass('active-card');
				break;
			case 4: // Awaiting Request - Info
				$(".btn-to-be-disabled").prop('disabled', true);
				$("#body-bg-4").addClass('bg-warning-light');
				$("#number-text-4").addClass('text-white');
				$("#card-pvlmd").addClass('active-card');
				break;
			default:
				// No card selected
		}
	}


    // $('#sendMessageModal').on('show.bs.modal',function(event) {
	// 	$("#sendMessageModal #officer_name").val($(event.relatedTarget).data('officer_name'));	
	// 	$("#sendMessageModal #job_numbers").val('[{"job_number":"'+$(event.relatedTarget).data('job_number')+'"}]');
	// 	$("#sendMessageModal #officer_id").val($(event.relatedTarget).data('officer_id'));
	// 	 //$("#sendMessageModal #sendMessageModalLabel").val('Send Message To '+$(event.relatedTarget).data('receiver_name'));	
    //     document.getElementById('sendMessageModalLabel').innerHTML = 'Send Message To <span class="text-primary">'+$(event.relatedTarget).data('receiver_name')+'</span>'
	// 	// $("#sendMessageModal #e_lawyer_address").val($(event.relatedTarget).data('lawyer_address'));
	// 	// $("#sendMessageModal #e_lawyer_chamber").val($(event.relatedTarget).data('lawyer_chamber'));
	// });

   $(document).on("click", ".sendMessage_unit_case", function (event) {
    event.preventDefault();
    
    const officerName = $(this).data('officer_name');
    const receiverName = $(this).data('receiver_name');
    const jobNumber = $(this).data('job_number');
    const officerId = $(this).data('officer_id');
    
    // Parse job numbers (could be a single job number or array)
    let jobNumbersArray = [];
    if (jobNumber) {
        if (Array.isArray(jobNumber)) {
            jobNumbersArray = jobNumber.map(job => ({ job_number: job }));
        } else {
            jobNumbersArray = [{ job_number: jobNumber }];
        }
    }
    
    // Update modal with data
    updateSendMessageModal({
        officer_id: officerId,
        officer_name: officerName,
        receiver_name: receiverName,
        job_numbers: jobNumbersArray
    });
});

// Function to update the send message modal with data
function updateSendMessageModal(data) {
    const modal = document.getElementById('sendMessageModal');
    const sendMessageModal = $(modal);

    // console.log(data);
    
    // Update hidden fields
    sendMessageModal.find("#officer_id").val(data.officer_id || '');
    sendMessageModal.find("#officer_name").val(data.officer_name || '');
    sendMessageModal.find("#job_numbers").val(JSON.stringify(data.job_numbers || []));
    
    // Update modal title
    const titleText = data.receiver_name ? 
        `Send Message to <span class="text-primary">${data.receiver_name}</span>` : 
        'Send Message';
    sendMessageModal.find("#modalTitleText").html(titleText);
    
    // Update recipient info card
    if (data.receiver_name) {
        sendMessageModal.find("#recipientNameDisplay").text(data.receiver_name);
    } else if (data.officer_name) {
        sendMessageModal.find("#recipientNameDisplay").text(data.officer_name);
    } else {
        sendMessageModal.find("#recipientNameDisplay").text('Select a recipient');
    }
    
    // Update recipient info
    if (data.officer_id) {
        sendMessageModal.find("#recipientInfo").text(`ID: ${data.officer_id}`);
    } else {
        sendMessageModal.find("#recipientInfo").text('No ID available');
    }
    
    // Update job count badge
    const jobCount = Array.isArray(data.job_numbers) ? data.job_numbers.length : 0;
    sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
    
    // Reset form to clean state
    resetMessageForm();
    
    // Show the modal (Bootstrap 5)
    const bsModal = new bootstrap.Modal(modal);
    bsModal.show();
    
    // Log for debugging
    // console.log('Send message modal data:', {
    //     officer_id: data.officer_id,
    //     officer_name: data.officer_name,
    //     receiver_name: data.receiver_name,
    //     job_count: jobCount,
    //     job_numbers: data.job_numbers
    // });
}

// Reset message form function
function resetMessageForm() {
    // const form = $('#message-form')[0];
    // if (form) {
    //     form.reset();
    // }
    
    // Reset character count
    $('#charCount').text('0/1000 characters').removeClass('warning danger');
    
    // Reset preview
    $('#messagePreview').html('<small class="text-muted">Start typing to see preview</small>');
    $('#previewCard').hide();
    
    // Set default message type to "query" (since this is for compliance)
    $('#message_type_query').prop('checked', true);
    updateSubmitButton();
    
    // Clear any validation states
    $('.form-control').removeClass('is-invalid is-valid');
    $('#message-form').removeClass('was-validated');
    
    // Clear the message textarea
    $('#message').val('');
}

// Update submit button text based on message type
function updateSubmitButton() {
    const messageType = $('input[name="message_type"]:checked').val();
    let buttonText = 'Send Message';
    
    switch(messageType) {
        case 'query':
            buttonText = 'Send Query';
            break;
        case 'reminder':
            buttonText = 'Send Reminder';
            break;
        case 'message':
        default:
            buttonText = 'Send Message';
    }
    
    $('#submitButtonText').text(buttonText);
}

// Handle form submission
$(document).on('submit', '#message-form', function(e) {
    e.preventDefault();
    
    const form = $(this);
    const officerId = form.find('#officer_id').val();
    const officerName = form.find('#officer_name').val();
    const jobNumbers = form.find('#job_numbers').val();
    const messageType = form.find('input[name="message_type"]:checked').val();
    const message = form.find('#message').val().trim();
    
    // Validation
    if (!message) {
        Swal.fire({
            title: 'Message Required',
            text: 'Please enter a message to send.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    if (!officerId) {
        Swal.fire({
            title: 'No Recipient',
            text: 'No recipient selected for the message.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    // Parse job numbers
    let jobNumbersArray;
    try {
        jobNumbersArray = JSON.parse(jobNumbers);
    } catch (error) {
        console.error('Error parsing job numbers:', error);
        jobNumbersArray = [];
    }
    
    if (jobNumbersArray.length === 0) {
        Swal.fire({
            title: 'No Applications',
            text: 'No applications selected to send message for.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    // Prepare confirmation message
    const jobCount = jobNumbersArray.length;
    const confirmationMessage = `
        <div class="text-start">
            <p>You are about to send a <strong>${messageType}</strong> to:</p>
            <ul class="mb-2">
                <li><strong>${officerName}</strong></li>
                <li><strong>${jobCount}</strong> application(s)</li>
            </ul>
            <div class="alert alert-light border small mt-3">
                <i class="ri-information-line me-1"></i>
                Message: "${message.substring(0, 100)}${message.length > 100 ? '...' : ''}"
            </div>
        </div>
    `;
    
    // Show confirmation dialog
    Swal.fire({
        title: 'Send Message?',
        html: confirmationMessage,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, Send Message',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#0d6efd',
        cancelButtonColor: '#6c757d',
        reverseButtons: true,
        showLoaderOnConfirm: true,
        preConfirm: () => {
            return new Promise((resolve, reject) => {
                // const formData = form.serialize();

                const formData = {
                  "request_type": $("#sendMessageModal").find("#request_type").val(),
                  "officer_id": officerId,
                  "officer_name": officerName,
                  "job_numbers" : jobNumbers,
                  "message_type" : messageType,
                  "message" : message
                }
                
                $.ajax({
                    type: "POST",
                    url: "SendComplianceMessage",
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response && response.success !== false) {
                            resolve(response);
                        } else {
                            reject(new Error(response?.message || 'Failed to send message'));
                        }
                    },
                    error: function(xhr, status, error) {
                        reject(new Error(`Server error: ${status}`));
                    }
                });
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed) {
            // Success handling
            const response = result.value;
            
            Swal.fire({
                title: 'Success!',
                html: `
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="ri-checkbox-circle-line text-success" style="font-size: 4rem;"></i>
                        </div>
                        <h5 class="fw-semibold">Message Sent Successfully</h5>
                        <p class="text-muted">
                            Your ${messageType} has been sent to ${officerName}
                        </p>
                        ${response?.message_id ? `
                        <div class="alert alert-light border small mt-3">
                            <i class="ri-information-line me-1"></i>
                            Reference ID: <strong>${response.message_id}</strong>
                        </div>
                        ` : ''}
                    </div>
                `,
                icon: 'success',
                confirmButtonText: 'Done',
                confirmButtonColor: '#0d6efd',
                timer: 4000,
                timerProgressBar: true,
                willClose: () => {
                    // Close the modal after success
                    const modal = bootstrap.Modal.getInstance(document.getElementById('sendMessageModal'));
                    if (modal) {
                        modal.hide();
                    }
                    
                    // Reset the form for next use
                    resetMessageForm();
                }
            });
            
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Swal.fire({
                title: 'Cancelled',
                text: 'Message was not sent.',
                icon: 'info',
                confirmButtonText: 'OK',
                confirmButtonColor: '#6c757d',
                timer: 2000
            });
        }
    }).catch((error) => {
        // Error handling
        console.error('Error sending message:', error);
        
        Swal.fire({
            title: 'Sending Failed',
            html: `
                <div class="text-center">
                    <div class="mb-3">
                        <i class="ri-error-warning-line text-danger" style="font-size: 4rem;"></i>
                    </div>
                    <h5 class="fw-semibold">Unable to Send Message</h5>
                    <p class="text-muted">
                        ${error.message || 'An unexpected error occurred. Please try again.'}
                    </p>
                    <div class="mt-3">
                        <button class="btn btn-outline-secondary me-2" onclick="Swal.close()">
                            Close
                        </button>
                        <button class="btn btn-primary" onclick="retrySendMessage()">
                            <i class="ri-refresh-line me-1"></i> Try Again
                        </button>
                    </div>
                </div>
            `,
            icon: 'error',
            showConfirmButton: false,
            showCancelButton: false
        });
    });
    
    return false;
});

// Retry function for error case
function retrySendMessage() {
    Swal.close();
    // Trigger form submission again after a delay
    setTimeout(() => {
        $('#message-form').trigger('submit');
    }, 500);
}

// Initialize message modal functionality on page load
$(document).ready(function() {
    // Character counter
    $('#message').on('input', function() {
        const length = $(this).val().length;
        $('#charCount').text(`${length}/1000 characters`);
        
        // Update character count styling
        $('#charCount').removeClass('warning danger');
        if (length > 800) {
            $('#charCount').addClass('warning');
        }
        if (length > 950) {
            $('#charCount').addClass('danger');
        }
        
        // Update preview
        updateMessagePreview();
    });
    
    // Template buttons
    $('.template-btn').on('click', function() {
        const template = $(this).data('template');
        insertTemplate(template);
    });
    
    // Message type radio buttons
    $('input[name="message_type"]').on('change', function() {
        updateMessagePreview();
        updateSubmitButton();
    });
    
    // Reset form button
    $('#btnResetForm').on('click', function() {
        resetMessageForm();
    });
});

// Helper function to update message preview
function updateMessagePreview() {
    const message = $('#message').val();
    const messageType = $('input[name="message_type"]:checked').val();
    const recipient = $('#recipientNameDisplay').text() || 'Recipient';
    
    let preview = '';
    
    if (message) {
        preview = `<strong>To:</strong> ${recipient}\n`;
        preview += `<strong>Type:</strong> ${messageType || 'Message'}\n\n`;
        preview += message.substring(0, 200);
        
        if (message.length > 200) {
            preview += '...';
        }
        
        // Show preview card
        $('#previewCard').show();
    } else {
        preview = '<small class="text-muted">Start typing to see preview</small>';
        $('#previewCard').hide();
    }
    
    $('#messagePreview').html(preview.replace(/\n/g, '<br>'));
}

// Helper function to insert template text
function insertTemplate(template) {
    const templates = {
        query: "Dear Officer,\n\nPlease provide an update on the status of the application mentioned above. This requires urgent attention.\n\nBest regards,\n[Your Name]",
        followup: "Dear Officer,\n\nFollowing up on the previous communication regarding this application. Please advise on the current status and any pending actions.\n\nRegards,\n[Your Name]",
        reminder: "Dear Officer,\n\nThis is a reminder that the application is approaching/passed its TAT deadline. Kindly expedite action to avoid further delays.\n\nThank you,\n[Your Name]",
        update: "Dear Officer,\n\nPlease update the status of this application in the system as soon as possible. If there are any issues, please let us know immediately.\n\nSincerely,\n[Your Name]"
    };
    
    const $textarea = $('#message');
    const currentText = $textarea.val();
    const templateText = templates[template] || '';
    
    // Insert template, preserving existing text
    if (currentText && !currentText.includes(templateText)) {
        $textarea.val(currentText + '\n\n' + templateText);
    } else if (!currentText) {
        $textarea.val(templateText);
    }
    
    // Trigger input event for character count and preview
    $textarea.trigger('input');
    
    // Show success notification
    Swal.fire({
        title: 'Template Inserted',
        text: `"${template}" template has been inserted`,
        icon: 'success',
        confirmButtonText: 'OK',
        confirmButtonColor: '#0d6efd',
        timer: 2000
    });
}

      $('#changequerystatusModal').on('show.bs.modal', function(event) {
            const button = $(event.relatedTarget);
            const jobNumber = button.data('job_number');
            
            // Update hidden input
            $('#changequerystatusModal #job_number').val(jobNumber);
            
            // Update display
            $('#displayJobNumber').text(jobNumber);
            
            // Update modal title with job number
            $('#changequerystatusModalLabel').html(`
                Set Query as Inactive
                <small class="text-muted d-block fw-normal mt-1">Job #${jobNumber}</small>
            `);
            
            // Reset form state
            const form = $('#update-query-form')[0];
            form.classList.remove('was-validated');
            $('#confirmInactive').prop('checked', false);
            $('#confirmSubmit').prop('disabled', true);
        });

        // Enable/disable submit button based on checkbox
        $('#changequerystatusModal').on('change', '#confirmInactive', function() {
            $('#confirmSubmit').prop('disabled', !this.checked);
        });

        $("#update-query-form").on("submit", function (event) {
        event.preventDefault();
        
        const form = $(this);
        const modal = $("#changequerystatusModal");
        const submitBtn = form.find('button[type="submit"]');
        const originalBtnText = submitBtn.html();
        
        // Get form data
        const formData = {
            "request_type": "update_compliance_application_notice",
            "job_number": modal.find("#job_number").val()
        };
        
        // Validate
        if (!formData.job_number) {
            showAlert("error", "Error", "Job number is required.");
            return;
        }
        
        // Show loading state
        submitBtn.prop("disabled", true).html(`
            <span class="mdi mdi-spin mdi-loading me-1" role="status" aria-hidden="true"></span>
            Processing...
        `);
        
        // Disable cancel button during submission
        modal.find('button[data-bs-dismiss="modal"]').prop("disabled", true);
        
        $.ajax({
            type: "POST",
            url: "/SendComplianceMessage",
            data: formData,
            cache: false,
            //dataType: "json", // Expect JSON response
            timeout: 30000, // 30 second timeout
            
            success: function(response) {
            // console.log("API Response:", response);
                
                if (response === "Success") {
                    submitBtn.html('<i class="ri-check-circle-fill me-1"></i> Success!');
                    submitBtn.removeClass("btn-warning").addClass("btn-success");

                    showSwalNotification(
                        "success",
                        "Query Updated",
                        response.message
                    );

                    setTimeout(() => {
                        modal.modal("hide");

                        setTimeout(() => {
                            submitBtn.html(originalBtnText).prop("disabled", false);
                            submitBtn.removeClass("btn-success").addClass("btn-warning");
                            modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
                            form[0].reset();

                            if (typeof window.refreshQueryTable === "function") {
                                window.refreshQueryTable();
                            }

                            $(document).trigger(
                                "queryStatusUpdated",
                                [formData.job_number, "inactive"]
                            );
                        }, 300);
                    }, 1500);

                } else {
                    handleError(
                        response.message || "Update failed. Please try again.",
                        submitBtn,
                        originalBtnText
                    );
                    modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
                }
            },
            
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                
                let errorMessage = "Network error. Please check your connection.";
                
                if (xhr.status === 0) {
                    errorMessage = "Cannot connect to server. Please check your network.";
                } else if (xhr.status === 404) {
                    errorMessage = "Request endpoint not found.";
                } else if (xhr.status === 500) {
                    errorMessage = "Server error. Please try again later.";
                } else if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMessage = xhr.responseJSON.message;
                }
                
                handleError(errorMessage, submitBtn, originalBtnText);
                modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
            },
            
            complete: function() {
                // Re-enable cancel button if still in error state
                setTimeout(() => {
                    if (submitBtn.prop("disabled")) {
                        modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
                    }
                }, 2000);
            }
        });
    });

// Helper function for error handling with SweetAlert2
async function handleError(message, submitBtn = null, originalBtnText = null) {
    if (submitBtn && originalBtnText) {
        submitBtn.html('<i class="ri-error-warning-line me-1"></i> Failed');
        submitBtn.removeClass("btn-warning").addClass("btn-danger");
    }
    
    // Show SweetAlert2 error notification
    await showSwalNotification('error', 'Update Failed', message);
    
    // Reset button after delay if provided
    if (submitBtn && originalBtnText) {
        setTimeout(() => {
            submitBtn.html(originalBtnText).prop("disabled", false);
            submitBtn.removeClass("btn-danger").addClass("btn-warning");
        }, 3000);
    }
}

// SweetAlert2 notification function (replaces toast)
function showSwalNotification(type, title, message, options = {}) {
    const defaultOptions = {
        icon: type,
        title: title,
        text: message,
        // toast: true,
        // position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        }
    };
    
    // Merge custom options
    const finalOptions = { ...defaultOptions, ...options };
    
    return Swal.fire(finalOptions);
}


          // Event handlers for action buttons
$(document).on('click', '.view-messages', function() {
    $('#viewresponseModal').modal('show');

    // Load messages for this noticeId
    const noticeId = $(this).data('notice_id');
    const modal = $('#viewresponseModal');
    
    // Show loading state
    modal.find('#responseLoading').removeClass('d-none');
    modal.find('#responseContainer').addClass('d-none');
    modal.find('#responseEmpty').addClass('d-none');
    
    // Clear previous content
    modal.find('#response_list').empty();
    modal.find('#responseCount').text('0 responses');
    
    // Prepare data
    const data = {
        "notice_id": noticeId,
        "request_type": "select_responses_on_compliance_application_notice",
    };
    
    // Make AJAX request
    $.ajax({
        type: "POST",
        url: "/SendComplianceMessage",
        data: data,
        cache: false,
        success: function(result) {
            
            try {
                const response = JSON.parse(result);
                
                // Hide loading
                modal.find('#responseLoading').addClass('d-none');
                
                if (response.data && response.data.length > 0) {
                    // 🔽 Sort by created_date DESC (latest first)
                    response.data.sort((a, b) => {
                        return new Date(b.created_date) - new Date(a.created_date);
                    });

                    let html = '';
                    let responseCount = response.data.length;

                    response.data.forEach((item, index) => {
                        html += `
                            <li>
                            <div class="d-flex align-items-start gap-3">
                                <div>
                                    <span class="avatar avatar-md bg-warning rounded-circle me-2">
                                        <i class="ri-user-line"></i>
                                    </span>
                                </div>
                                <div class="flex-fill">
                                    <div class="d-flex align-items-start justify-content-between mb-1 flex-wrap">
                                        <div class="d-block fw-semibold">${item.created_by || 'Unknown User'}</div>
                                        <span class="badge bg-light text-muted border">
                                            ${convertDate(item.created_date.slice(0,10))}
                                        </span>
                                    </div>
                                    <div class="descrption">
                                        ${item.reply_details || 'No details provided'}
                                    </div>
                                </div>
                            </div>
                            </li>
                        `;
                    });

                    modal.find('#responseCount').text(
                        `${responseCount} ${responseCount === 1 ? 'response' : 'responses'}`
                    );

                    modal.find('#response_list').html(html);
                    modal.find('#responseContainer').removeClass('d-none');
                    
                    // Add animation to timeline items
                    setTimeout(() => {
                        modal.find('.timeline-item').each(function(index) {
                            $(this).css({
                                'opacity': '0',
                                'transform': 'translateX(-20px)'
                            }).delay(100 * index).animate({
                                'opacity': '1',
                                'transform': 'translateX(0)'
                            }, 300);
                        });
                    }, 100);
                    
                } else {
                    // Show empty state
                    modal.find('#responseEmpty').removeClass('d-none');
                }
                
            } catch (error) {
                console.error('Error parsing response:', error);
                modal.find('#responseLoading').addClass('d-none');
                modal.find('#response_list').html(`
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        Error loading responses. Please try again.
                    </div>
                `);
                modal.find('#responseContainer').removeClass('d-none');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            modal.find('#responseLoading').addClass('d-none');
            modal.find('#response_list').html(`
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    Failed to load responses. Please check your connection and try again.
                </div>
            `);
            modal.find('#responseContainer').removeClass('d-none');
        }
    }); 
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


        // Variable to store DataTable instance
let pendingQueriesTable = null;

$("#btnPendingQueries").on("click", function(e) {
    const pending_queries_input = $("#pending_queries_input").val();
    let region_id = $('#sel_change_region_compliance').val();

    // Validate input
    if (!pending_queries_input) {
        Swal.fire({
            icon: 'warning',
            title: 'Selection Required',
            text: 'Please select a division to load queries',
            confirmButtonColor: '#ffc107'
        });
        return;
    }

    // Clean region ID
    region_id = region_id.replace(".0", "");

    // Set modal title based on selection
    const titles = {
        'lvd_pending_queries': "LVD's Pending Queries",
        'smd_pending_queries': "SMD's Pending Queries",
        'pvlmd_pending_queries': "PVLMD's Pending Queries",
        'lrd_pending_queries': "LRD's Pending Queries"
    };

    $('#pendingQueriesModalLabel').text(titles[pending_queries_input] || "Pending Queries");
    $('#modalSubtitle').text(`Region: ${$('#sel_change_region_compliance option:selected').text()}`);

    // Show loading state
    const modal = $('#pending_queries_modal');
    modal.modal('show');
    
    // Show loading in modal
    showModalLoading(modal);

    // Make AJAX request
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'select_pending_queries_for_compliance_notice',
            pending_queries_input: pending_queries_input,
            region_id: region_id
        },
        cache: false,
        success: function(result) {
            try {
                const response = JSON.parse(result);
                if (response.success && response.data) {
                    initializePendingQueriesTable(response.data);
                    $('#queryCountQR').text(response.data.length);

                } else {
                    showEmptyTableState('No pending queries found');
                }
            } catch (error) {
                console.error('Error parsing response:', error);
                showEmptyTableState('Error loading data');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            showEmptyTableState('Error loading data. Please try again.');
        },
        complete: function() {
            // Remove loading state
            hideModalLoading(modal);
        }
    });
});

// Function to initialize the DataTable
function initializePendingQueriesTable(data) {
    // Prepare data for DataTable
    const dataSet = data.map((item, index) => {
        // Determine row class based on notice_type
        let rowClass = '';
        let statusBadge = '';
        
        if (item.notice_type === 'query') {
            rowClass = 'table-danger';
            statusBadge = '<span class="badge bg-danger-subtle text-danger small">Queried</span>';
        } else if (item.notice_type === 'Warning') {
            rowClass = 'table-warning';
            statusBadge = '<span class="badge bg-warning-subtle text-warning small">Warning</span>';
        } else if (item.notice_type === 'Reminder') {
            rowClass = 'table-info';
            statusBadge = '<span class="badge bg-info-subtle text-info small">Reminder</span>';
        }

        // Format TAT with color coding
        const tatValue = parseInt(item.tat) || 0;
        let tatClass = 'bg-success';
        let tatLabel = 'Normal';
        
        if (tatValue > 90) {
            tatClass = 'bg-danger';
            tatLabel = 'Critical';
        } else if (tatValue > 20) {
            tatClass = 'bg-warning';
            tatLabel = 'Warning';
        }

        // Format date
        const formattedDate = item.created_date ? 
            new Date(item.created_date.slice(0,10)).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            }) : 'N/A';

        // Prepare actions dropdown
        const actions = `
            <div class="dropdown">
                <button class="btn btn-sm btn-light border dropdown-toggle" 
                        type="button" 
                        data-bs-toggle="dropdown"
                        aria-expanded="false">
                    <i class="ri-more-2-line"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow">
                    <li>
                        <form action="front_office_view_application" method="post">
                            <input type="hidden" name="search_text" value="${item.case_number}">
                            <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                <i class="ri-eye-line text-primary"></i>
                                View Application
                            </button>
                        </form>
                    </li>
                    <li>
                        <button type="button" 
                                class="dropdown-item d-flex align-items-center gap-2 sendMessage_unit_case"
                                data-receiver_name="${item.receiver_name}"
                                data-officer_name="${item.receiver_name}"
                                data-job_number="${item.job_number}"
                                data-officer_id="${item.receiver_id}">
                            <i class="ri-send-plane-line text-success"></i>
                            Send Message
                        </button>
                    </li>
                </ul>
            </div>
        `;

        return {
            index: `<span class="small text-dark">${index + 1}</span>`,
            job_number: `<div class="d-flex align-items-center gap-2">
                            <span class="fw-medium small text-primary">${item.job_number}</span>
                            ${statusBadge}
                         </div>`,
            details: `<div class="small text-dark" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${item.details}">
                        ${truncateText(item.details, 60)}
                      </div>`,
            receiver_name: `<span class="small text-dark">${item.receiver_name}</span>`,
            unit_name: `<span class="small text-dark">${item.unit_name}</span>`,
            tat: `<div class="d-flex align-items-center gap-2">
                    <span class="badge ${tatClass}">${tatLabel}</span>
                    <small class="text-muted">${tatValue}d</small>
                  </div>`,
            created_at: `<span class="small text-dark">${formattedDate}</span>`,
            actions: actions,
            row_class: rowClass,
            _raw_data: item // Store raw data for reference
        };
    });

    // Destroy existing DataTable instance if exists
    if (pendingQueriesTable) {
        pendingQueriesTable.destroy();
        $('#pending_queries_table_list tbody').empty();
    }

    // Initialize DataTable
    pendingQueriesTable = $('#pending_queries_table_list').DataTable({
        data: dataSet,
        destroy: true,
        responsive: true,
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
             "<'row'<'col-sm-12'tr>>" +
             "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        buttons: [
            {
                extend: 'excel',
                text: '<i class="ri-file-excel-line me-1"></i> Excel',
                className: 'btn btn-outline-primary btn-sm',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4, 5, 6],
                    format: {
                        body: function(data, row, column, node) {
                            // Remove HTML tags for export
                            return $(data).text().trim();
                        }
                    }
                }
            },
            {
                extend: 'pdf',
                text: '<i class="ri-file-pdf-line me-1"></i> PDF',
                className: 'btn btn-outline-danger btn-sm',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4, 5, 6]
                }
            },
            {
                extend: 'print',
                text: '<i class="ri-printer-line me-1"></i> Print',
                className: 'btn btn-outline-secondary btn-sm',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4, 5, 6]
                },
                customize: function (win) {
                    $(win.document.body)
                        .css('font-size', '10pt')
                        .prepend('<h5>' + $('#pendingQueriesModalLabel').text() + '</h5>');
                    
                    $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                }
            }
        ],
        columns: [
            { data: 'index', className: 'text-center' },
            { data: 'job_number' },
            { data: 'details' },
            { data: 'receiver_name' },
            { data: 'unit_name' },
            { data: 'tat', className: 'text-center' },
            { data: 'created_at' },
            { 
                data: 'actions', 
                className: 'text-end',
                orderable: false,
                searchable: false 
            }
        ],
        columnDefs: [
            {
                targets: 0,
                width: '40px'
            },
            {
                targets: [1, 4, 5, 6],
                width: '100px'
            },
            {
                targets: 7,
                width: '80px'
            }
        ],
        createdRow: function(row, data) {
            if (data.row_class) {
                $(row).addClass(data.row_class);
            }
        },
        order: [[5, 'desc']], // Sort by TAT descending
        pageLength: 10,
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
        language: {
            emptyTable: "No pending queries found",
            info: "Showing _START_ to _END_ of _TOTAL_ queries",
            infoEmpty: "Showing 0 to 0 of 0 queries",
            infoFiltered: "(filtered from _MAX_ total queries)",
            lengthMenu: "Show _MENU_ queries",
            loadingRecords: "Loading...",
            processing: "Processing...",
            search: "",
            searchPlaceholder: "Search queries...",
            zeroRecords: "No matching queries found",
            paginate: {
                first: '<i class="ri-arrow-left-s-line"></i>',
                last: '<i class="ri-arrow-right-s-line"></i>',
                next: '<i class="ri-arrow-right-s-line"></i>',
                previous: '<i class="ri-arrow-left-s-line"></i>'
            }
        },
        initComplete: function() {
            // Add custom styling to search input
            $('.dataTables_filter input').addClass('form-control form-control-sm').attr('placeholder', 'Search queries...');
            $('.dataTables_length select').addClass('form-select form-select-sm');
            
            // Initialize tooltips
            setTimeout(() => {
                $('[data-bs-toggle="tooltip"]').tooltip();
            }, 100);
            
            // Attach event handlers for action buttons
            // attachModalActionHandlers();
        },
        drawCallback: function() {
            // Re-initialize tooltips after each draw
            $('[data-bs-toggle="tooltip"]').tooltip();
            
            // Update query count
            const visibleRows = this.api().rows({ filter: 'applied' }).count();
            $('#queryCountQR').text(visibleRows);
        }
    });

    // Add custom search handler
    $('#pending_queries_table_list').off('keyup').on('keyup', function() {
        pendingQueriesTable.search(this.value).draw();
    });
}

// Helper function to show empty table state
function showEmptyTableState(message) {
    if (pendingQueriesTable) {
        pendingQueriesTable.destroy();
    }
    
    $('#pending_queries_table_list tbody').html(`
        <tr>
            <td colspan="8" class="text-center py-5">
                <div class="text-muted">
                    <i class="ri-inbox-line display-4"></i>
                    <p class="mt-2">${message}</p>
                </div>
            </td>
        </tr>
    `);
    $('#queryCountQR').text('0');
}

// Helper function to show loading state
function showModalLoading(modal) {
    const tableBody = modal.find('tbody');
    tableBody.html(`
        <tr>
            <td colspan="8" class="text-center py-5">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="text-muted mt-2">Loading queries...</p>
            </td>
        </tr>
    `);
}

function hideModalLoading(modal) {
    // Loading state is replaced by DataTable
}

// Helper function to truncate text
function truncateText(text, maxLength) {
    if (!text) return '';
    if (text.length <= maxLength) return text;
    return text.substr(0, maxLength) + '...';
}

// Helper function to attach action button handlers
// function attachModalActionHandlers() {
//     // Handle Send Message button clicks
//     $(document).off('click', '.send-message-btn').on('click', '.send-message-btn', function() {
//         const receiverName = $(this).data('receiver_name');
//         const officerName = $(this).data('officer_name');
//         const jobNumber = $(this).data('job_number');
//         const officerId = $(this).data('officer_id');
        
//         // Check if sendMessageModal exists
//         if ($('#sendMessageModal').length) {
//             // Populate modal data
//             $('#sendMessageModal input[name="receiver_name"]').val(receiverName);
//             $('#sendMessageModal input[name="officer_name"]').val(officerName);
//             $('#sendMessageModal input[name="job_number"]').val(jobNumber);
//             $('#sendMessageModal input[name="officer_id"]').val(officerId);
            
//             // Show modal
//             const modal = new bootstrap.Modal(document.getElementById('sendMessageModal'));
//             modal.show();
//         } else {
//             Swal.fire({
//                 icon: 'error',
//                 title: 'Modal Not Found',
//                 text: 'Send Message modal is not available',
//                 confirmButtonColor: '#dc3545'
//             });
//         }
//     });
    
//     // Handle View Application form submissions
//     $(document).off('submit', 'form[action="front_office_view_application"]').on('submit', 'form[action="front_office_view_application"]', function(e) {
//         // Close modal if form is inside it
//         const modal = $(this).closest('.modal');
//         if (modal.length) {
//             modal.modal('hide');
//         }
//     });
// }

// Handle modal close events
$('#pending_queries_modal').on('hidden.bs.modal', function() {
    // Clean up DataTable instance
    if (pendingQueriesTable) {
        pendingQueriesTable.destroy();
        pendingQueriesTable = null;
    }
    
    // Clear table body
    $('#pending_queries_table_list tbody').empty();
    $('#queryCountQR').text('0');
});
})