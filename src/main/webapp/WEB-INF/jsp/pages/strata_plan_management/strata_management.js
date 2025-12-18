$(document).ready(function() {

    var datatable = $("#job_casemgtdetailsdataTable").DataTable({
        // responsive: true,
        stateSave : true,
        "createdRow" : function(row, data, dataIndex) {
            // if (data[0] == "1") {
            // 	$(row).addClass('tr-completed-work');
            // }
            // if(data[6] == 'Approved'){
            //     $(row).addClass('bg-success text-white');
            // }
        },
    });

    $('#rts_select_type_').on('change', (e) => {
        e.preventDefault();

        datatable.search("").draw();
        datatable.state.clear();
        datatable.clear();

        var rts_select_type = $('#rts_select_type').val();

        if(rts_select_type == 'Plot Number'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');

        } else if(rts_select_type == 'Estate'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').addClass('d-none');
            
        } else if(rts_select_type == 'Name of Leasee/Assignee'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');
            
        } else if(rts_select_type == 'Certificate Number'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');
            
        }
    })


    $('#rt_region_code_').on('change', (e) => {
        e.preventDefault();
            
        var select_id = document.getElementById("rt_region_code");
        var main_service = select_id.options[select_id.selectedIndex].value;
        const main_service_name_id = main_service.split('_');
        var main_service_id = main_service_name_id[0];
        var main_service_name = main_service_name_id[1];
        
        main_service_id = main_service_id.replace('.0', '');

        $.ajax({
            type : "POST",
            url : "app_modal_fills_serv",
            data : {
                request_type : 'get_locality_list',
                region_code : main_service_id,
            },
            cache : false,
            beforeSend : function() {},
            success : function(response) {
                console.log(response);
                try {
                    var json_p = JSON.parse(response);
                    var options = $("#rt_locality");

                    // var options =
                    // $("#selector");
                    options.empty();
                    options.append(new Option("-- Select --", 0));

                    $(json_p).each(function() {
                        $('#rt_locality').append(
                            '<option value="'
                            + this.location_name
                            + '">'
                            + this.location_name
                            + '</option>');
                    });
                } catch (e) {
                    console.error('Error parsing response:', e);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">An error occurred while processing the response.</span>' }, { type: 'danger' });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX Error:', textStatus, errorThrown);
                $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger' });
            }
        });

    })


    
    $('#btn_generate_rent_demand_note_').on('click', (e) => {
        //e.preventDefault();
      
        var rdn_rent_id = $('#rdn_rent_id').val();
        var rdn_account_number = $('#rdn_account_number').val();
       


        $.ajax({
            type: "POST",
            url: "rent_mgt_serv",
          //  target : '_blank',
            data: {
                request_type: 'select_prepare_rent_demand_notice_single',
                rdn_rent_id: rdn_rent_id,
                rdn_account_number : rdn_account_number
                   
                     },
            cache: false,
          
            beforeSend: function () { },
            success: function(jobdetails) {
                //console.log(data)
            //        $('#elisDocumentPreview').modal({
            //           backdrop: 'static',
            //         });
                 
            //        var blob = new Blob(
            //                [ data ],
            //                {
            //                    type : "application/pdf"
            //                });
            //    var objectUrl = URL
            //                .createObjectURL(blob);

            var table = $('#tbl_rent_assessment_details');
            table.find("tbody tr").remove();
        
            //console.log(jobdetails);
            var json_p = JSON.parse(jobdetails);
            
            $(json_p.rent_assessment).each(function () {
                        
                        table.append("<tr><td>" 
                            + this.rc_period 
                            + "</td><td>" 
                            + this.rc_interest_rate 
                            + "</td><td>" 
                            + this.rc_annual_rent 
                            + "</td><td>" 
                            + this.rc_amount_assessed 
                            + "</td><td>" 
                            + this.rc_description 
                            + "</td><td>" 
                            + this.created_by 
                            + "</td>"
                                
                                   
                        + "</tr>");
                  });


            },
            complete: function(){
                //console.log("Completed ajax");

              }
            });
          

    })

    $('#btn_print_rent_demand_note').on('click', (e) => {
        //e.preventDefault();
      
        var rdn_rent_id = $('#rdn_rent_id').val();
        var rdn_account_number = $('#rdn_account_number').val();
       


        $.ajax({
            type: "POST",
            url: "rent_mgt_pdf_serv",
            target : '_blank',
            data: {
                request_type: 'print_rent_demand_notice',
                rdn_rent_id: rdn_rent_id,
                rdn_account_number : rdn_account_number
                },
            cache: false,
            xhrFields : {
                   responseType : 'blob'
               },
            beforeSend: function () { },
            success: function(data) {
                //console.log(data)
                   $('#elisDocumentPreview').modal({
                      backdrop: 'static',
                    });
                   // console.log("pdf blob sdata");
                    //console.log(data);
                   var blob = new Blob(
                           [ data ],
                           {
                               type : "application/pdf"
                           });
               var objectUrl = URL
                           .createObjectURL(blob);
                   // window.open(objectUrl);
               ///	console.log("success ajax");

                $('#elisdovumentpreviewblobfile').attr('src',objectUrl);
                   
                   
                   
                 
            },
            complete: function(){
                //console.log("Completed ajax");

              }
            });
          

    })

    $('#btn_save_rent_client_details_2').on('click', (e) => {
        e.preventDefault();

        var rt_rent_id = $('#rt_rent_id').val();
        var rt_leasee_name = $('#rt_leasee_name').val();
        var rt_leasee_address = $('#rt_leasee_address').val();
        var rt_mobile_phone_1 = $('#rt_mobile_phone_1').val();
        var rt_mobile_phone_2 = $('#rt_mobile_phone_2').val();
        var rt_email = $('#rt_email').val();
        //var rt_region_code = $('#rt_region_code').val();
        //var rt_locality = $('#rt_locality').val();
        var rt_estate = $('#rt_estate').val();
        var rt_plot_number = $('#rt_plot_number').val();
        var rt_plot_size = $('#rt_plot_size').val();
       // var rt_block_number = $('#rt_block_number').val();
        var rt_convenant_user = $('#rt_convenant_user').val();
        //var rt_original_use = $('#rt_original_use').val();
        var rt_current_use = $('#rt_current_use').val();
        var rt_nature_of_dev = $('#rt_nature_of_dev').val();
        var rt_parcel_address = $('#rt_parcel_address').val();
        var rt_file_number = $('#rt_file_number').val();
        var rt_ledger = $('#rt_ledger').val();
        var rt_folio = $('#rt_folio').val();
        var rt_ls_number = $('#rt_ls_number').val();
        var rt_commencement_date = $('#rt_commencement_date').val();
        var rt_term = $('#rt_term').val();
        //var rt_expiry_date = $('#rt_expiry_date').val();
        var rt_consent_date = $('#rt_consent_date').val();
        var rt_location_rate = $('#rt_location_rate').val();
        var rt_rent_category = $('#rt_rent_category').val();
        var rt_rent_review_clause = $('#rt_rent_review_clause').val();
        var rt_rent_passing = $('#rt_rent_passing').val();
        //var rt_adjoining_plots = $('#rt_adjoining_plots').val();
        //var rt_amount_due = $('#rt_amount_due').val();
        var rt_rent_outstanding = $('#rt_rent_outstanding').val();
        //var rt_classification_of_arrears = $('#rt_classification_of_arrears').val();
       // var rt_serial_number = $('#rt_serial_number').val();
        var rt_remarks = $('#rt_remarks').val();
        var rt_last_payment_date = $('#rt_last_payment_date').val();
        var rt_nature_of_instrument = $('#rt_nature_of_instrument').val();
        //var rt_last_review_date = $('#rt_last_review_date').val();
        var rt_last_payment_period = $('#rt_last_payment_period').val();
        var rt_period_in_arrears = $('#rt_period_in_arrears').val();
        var rt_glpin = $('#rt_glpin').val();

        // if(!rt_leasee_name || !rt_leasee_address || !rt_mobile_phone_1 || !rt_region_code || !rt_locality || !rt_estate || 
        //     !rt_plot_number || !rt_plot_size || !rt_block_number || !rt_file_number || !rt_ledger || !rt_commencement_date || !rt_term || 
        //     !rt_expiry_date || !rt_consent_date || !rt_location_rate) {

        //         alert('Please fill in all the required fields');
        //         return;
        //  }

         // List of required fields
        const fields = [
            { field: rt_leasee_name, selector: '#rt_leasee_name' },
            { field: rt_leasee_address, selector: '#rt_leasee_address' },
            { field: rt_mobile_phone_1, selector: '#rt_mobile_phone_1' },
            // { field: rt_region_code, selector: '#rt_region_code' },
            // { field: rt_locality, selector: '#rt_locality' },
            { field: rt_estate, selector: '#rt_estate' },
            { field: rt_plot_number, selector: '#rt_plot_number' },
            { field: rt_plot_size, selector: '#rt_plot_size' },
            //{ field: rt_block_number, selector: '#rt_block_number' },
            { field: rt_file_number, selector: '#rt_file_number' },
            { field: rt_ledger, selector: '#rt_ledger' },
            { field: rt_commencement_date, selector: '#rt_commencement_date' },
            { field: rt_term, selector: '#rt_term' },
            //{ field: rt_expiry_date, selector: '#rt_expiry_date' },
            //{ field: rt_consent_date, selector: '#rt_consent_date' },
            { field: rt_location_rate, selector: '#rt_location_rate' },
            { field: rt_last_payment_date, selector: '#rt_last_payment_date' },
            { field: rt_rent_review_clause, selector: '#rt_rent_review_clause' },
            //{ field: rt_last_review_date, selector: '#rt_last_review_date' },
            { field: rt_last_payment_period, selector: '#rt_last_payment_period' },
            { field: rt_period_in_arrears, selector: '#rt_period_in_arrears'},
        ];

        let allFieldsFilled = true;

        fields.forEach(({ field, selector }) => {
            const inputElement = document.querySelector(selector);

            if (!field) {
                inputElement.style.border = '2px solid red'; // Add red border for empty fields
                allFieldsFilled = false;
            } else {
                inputElement.style.border = ''; // Reset border if the field is filled
            }
        });

        if (!allFieldsFilled) {
            alert('Please fill in all the required fields');
            return;
        }

        $.ajax({
            type : "POST",
            url : "Case_Management_Serv",
            data : {
                request_type : 'add_update_rent_leasee_details',
                rent_id : rt_rent_id || '',
                owners_name : rt_leasee_name || '',
                address : rt_leasee_address || '',
                mobile : rt_mobile_phone_1 || '',
                mobile_1 : rt_mobile_phone_2 || '',
                email : rt_email || '',
                file_number : rt_file_number || '',
                ledger : rt_ledger || '',
                folio : rt_folio || '',
                //location : rt_locality || '',
                //block : rt_block_number || '',
                plot_number : rt_plot_number || '',
                plot_size : rt_plot_size || '',
                covenanted_user : rt_convenant_user || '',
                current_use : rt_current_use || '',
                nature_of_devt : rt_nature_of_dev || '',
                parcel_address : rt_parcel_address || '',
                ls_number : rt_ls_number || '',
                comm_date : rt_commencement_date || '',
                term : rt_term || '',
                //expiry_date : rt_expiry_date || '',
                consent_date : rt_consent_date || '',
                location_rate : rt_location_rate || '',
                rent_category : rt_rent_category || '',
                rent_review_clause : rt_rent_review_clause || 0,
                rent_passing : rt_rent_passing || 0,
                //adjoining_plots : rt_adjoining_plots || '',
                //amount_due : rt_amount_due || '',
                //arrears_amounts : rt_arrears_amounts,
                //original_use : rt_original_use || '',
                rent_outstanding : rt_rent_outstanding || '',
                //classification_of_arrears : rt_classification_of_arrears || '',
                glpin : rt_glpin || '',
                remarks : rt_remarks || '',
                estate : rt_estate || '',
                last_payment_date : rt_last_payment_date || '',
                nature_of_instrument : rt_nature_of_instrument || '',
                //last_review_date : rt_last_review_date || '',
                //region_id : rt_region_code || 0,
                last_payment_period : rt_last_payment_period || '',
                period_in_arrears : rt_period_in_arrears || ''


            },
            cache : false,
            //beforeSend : function() {},
            success: function(response) {
                try {
                    const json_p = JSON.parse(response);
                    if (json_p.success) {
                        $('#addlegder').modal('hide');
                        $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">Data saved successfully.</span>' }, { type: 'success' });
                    } else {
                        $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Error occurred, try again.</span>' }, { type: 'danger' });
                    }
                } catch (e) {
                    console.error('Error parsing response:', e);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">An error occurred while processing the response.</span>' }, { type: 'danger' });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX Error:', textStatus, errorThrown);
                $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger' });
            }
        });
    })

    $('#btn_rt_search_').on('click', (e) => {
        e.preventDefault();

        var rts_select_type = $('#rts_select_type').val();
        var rts_estate = $('#rts_estate').val();
        var rts_keyword = $('#rts_keyword').val();

        if(!rts_select_type){
            $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
            return;
        }

        switch(rts_select_type) {
            case 'Plot Number':
                if(!rts_estate || !rts_keyword) {
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
                    return;
                }
                break;
            case 'Estate':
                if(!rts_estate) {
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
                    return;
                }
                break;
            case 'Name of Leasee/Assignee':
                if(!rts_estate || !rts_keyword || rts_keyword.length < 3) {
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Keyword should be atleast 3</span>' }, { type: 'danger' });
                    return;
                }
                break;
        }

        $.ajax({
            type : "POST",
            url : "Case_Management_Serv",
            data : {
                request_type : 'select_rent_leasee_details',
                select_type : rts_select_type,
                estate : rts_estate,
                keyword : rts_keyword
            },
            cache : false,
            beforeSend : function() {},
            success : function(response) {
                console.log(response);
                try{
                    var json_p = JSON.parse(response);

                    if(json_p.data == null) {
                        $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">No data found.</span>' }, { type: 'danger' });

                        datatable.search("").draw();
                        datatable.state.clear();
                        datatable.clear();
                    }

                    datatable.search("").draw();
                    datatable.state.clear();
                    datatable.clear();

                    $(json_p.data).each(function() {

                        const stringAmount = this.rent_outstanding;
                        const numberAmount = parseFloat(stringAmount);
                        const formattedAmount = numberAmount.toLocaleString('en-US', {
                            style: 'currency',
                            currency: 'GHS',
                        });

                        // Set the start date
                        var startDate = this.comm_date;
                        startDate = new Date(startDate.replace(/-/g, "/"));

                        // var endDate = ;
                        // var noOfYearsToAdd = 10; // Number of years to add
                        // var count = 0;

                        // // Loop to add years, skipping if the end date falls on a weekend
                        // while (count < noOfYearsToAdd) {
                        //     endDate = new Date(startDate.setFullYear(startDate.getFullYear() + 1));
                        //     if (endDate.getDay() !== 0 && endDate.getDay() !== 6) { // Check if it's not a weekend
                        //         count++;
                        //     }
                        // }

                        // Set the start date
                        var endDate = this.expiry_date;
                        endDate = new Date(endDate.replace(/-/g, "/"));

                        var nxt_date = '';

                        var datex = new Date(endDate);
                        let day = datex.getDate();
                        let month = datex.getMonth() + 1;
                        let year = datex.getFullYear();

                        nxt_date = `${month}/${day}/${year}`;

                        // Calculate the difference in years instead of days
                        var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/');
                        var date1 = new Date(today);
                        var date2 = new Date(nxt_date);
                        var diffYears = date2.getFullYear() - date1.getFullYear();
                        reminder = diffYears;

                        if (reminder <= 0) {
                            var Str = reminder.toString();
                            var newStr = Str.replace('-', '');
                            display_reminder = `<label class="badge badge-danger">${newStr} Year(s) Passed</label>`;
                        } else {
                            display_reminder = `<label class="badge badge-success">${reminder} Year(s) Left</label>`;
                        }

                        datatable.row.add([
                            this.plot_number,
                            this.owners_name,
                            this.file_number,
                            this.comm_date,
                            //this.location,
                            this.consent_date,
                            this.term,
                            this.plot_size,
                            this.rent_review_clause,
                            this.last_payment_period,
                            ' <div class="text-right">'+formattedAmount+'</div>',
                            display_reminder,
                            // ' <form action="rent_application_progress_details" method="post">'
                            // + '<input type="hidden" name="rent_id" id="rent_id" value="'
                            // + this.rl_id
                            // + '">'
                            // + '<div class="text-center">'
                            // + '<button type="submit" name="save" class="btn btn-danger" >'
                            // + '<i class="fas fa-eye"></i>'
                            // + '</button>'
                            // + '<div></form>'
                            '<div class="dropdown">'
                            +'<button class="btn btn-danger dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                +'<i class="fas fa-info-circle"></i>'
                            +'</button>'
                            +'<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">'
                                +'<a class="dropdown-item" href="#"' 
                                +'data-toggle="modal" data-target="#addlegder"'
                                +'data-rent_id="'+this.rl_id+'"'
                                +'data-owners_name="'+this.owners_name+'"'
                                +'data-address="'+this.address+'"'
                                +'data-mobile="'+this.mobile+'"'
                                +'data-mobile_1="'+this.mobile_1+'"'
                                +'data-email="'+this.email+'"'
                                +'data-file_number="'+this.file_number+'"'
                                +'data-ledger="'+this.ledger+'"'
                                +'data-folio="'+this.folio+'"'
                                // +'data-location="'+this.location+'"'
                                // +'data-block="'+this.block+'"'
                                +'data-plot_number="'+this.plot_number+'"'
                                +'data-plot_size="'+this.plot_size+'"'
                                +'data-covenanted_user="'+this.covenanted_user+'"'
                                +'data-current_use="'+this.current_use+'"'
                                +'data-nature_of_devt="'+this.nature_of_devt+'"'
                                +'data-parcel_address="'+this.parcel_address+'"'
                                +'data-ls_number="'+this.ls_number+'"'
                                +'data-comm_date="'+this.comm_date+'"'
                                +'data-term="'+this.term+'"'
                               // +'data-expiry_date="'+this.expiry_date+'"'
                                +'data-consent_date="'+this.consent_date+'"'
                                +'data-location_rate="'+this.location_rate+'"'
                                +'data-rent_category="'+this.rent_category+'"'
                                +'data-rent_review_clause="'+this.rent_review_clause+'"'
                                +'data-rent_passing="'+this.rent_passing+'"'
                               // +'data-adjoining_plots="'+this.adjoining_plots+'"'
                                //+'data-original_use="'+this.original_use+'"'
                                +'data-rent_outstanding="'+this.rent_outstanding+'"'
                                //+'data-classification_of_arrears="'+this.classification_of_arrears+'"'
                                +'data-glpin="'+this.glpin+'"'
                                +'data-remarks="'+this.remarks+'"'
                                +'data-estate="'+this.estate+'"'
                                +'data-last_payment_date="'+this.last_payment_date+'"'
                                +'data-nature_of_instrument="'+this.nature_of_instrument+'"'
                                //+'data-last_review_date="'+this.last_review_date+'"'
                                //+'data-region_id="'+this.region_id+'"'
                                +'data-last_payment_period="'+this.last_payment_period+'"'
                                +'data-period_in_arrears="'+this.period_in_arrears+'"'
                                +'><i class="fas fa-eye"></i> View/Edit</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#singlerentdemandnotice"'
                                +'data-rent_id="'+this.rl_id+'"'
                                +'data-account_number="'+this.account_number+'"'
                                +'data-owners_name="'+this.owners_name+'"'
                                +'data-address="'+this.address+'"'
                                +'data-mobile="'+this.mobile+'"'
                                +'data-mobile_1="'+this.mobile_1+'"'
                                +'data-email="'+this.email+'"'
                                +'><i class="fas fa-money-bill"></i>Rent Demand Notice</a>'
                                 +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#paymenthistory"><i class="fas fa-money-bill"></i> Payment History</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#transactionhistory"><i class="fas fa-list"></i> Transaction History</a>'
                                 +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#rentdocuments"><i class="fas fa-file-alt"></i> Documents</a>'
                            +'</div>'
                            +'</div>'
                        ])
                        .draw(false);
                    })
                    
                } catch (e) {
                    console.error('Error parsing response:', e);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">An error occurred while processing the response.</span>' }, { type: 'danger' });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX Error:', textStatus, errorThrown);
                $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger' });
            }
        });
    })

    $('#addlegder_1').on('shown.bs.modal', (e) => {
        e.preventDefault();
    
        // Set values for form fields using data attributes from the triggering element
        $("#rt_rent_id").val($(e.relatedTarget).data("rent_id"));
        $("#rt_leasee_name").val($(e.relatedTarget).data("owners_name"));
        $("#rt_leasee_address").val($(e.relatedTarget).data("address"));
        $("#rt_mobile_phone_1").val($(e.relatedTarget).data("mobile"));
        $("#rt_mobile_phone_2").val($(e.relatedTarget).data("mobile_1"));
        $("#rt_email").val($(e.relatedTarget).data("email"));
        $("#rt_file_number").val($(e.relatedTarget).data("file_number"));
        $("#rt_ledger").val($(e.relatedTarget).data("ledger"));
        $("#rt_folio").val($(e.relatedTarget).data("folio"));
        // $("#rt_location_rate").val($(e.relatedTarget).data("location"));
        // $("#rt_block_number").val($(e.relatedTarget).data("block"));
        $("#rt_plot_number").val($(e.relatedTarget).data("plot_number"));
        $("#rt_plot_size").val($(e.relatedTarget).data("plot_size"));
        $("#rt_convenant_user").val($(e.relatedTarget).data("covenanted_user"));
        $("#rt_current_use").val($(e.relatedTarget).data("current_use"));
        $("#rt_nature_of_dev").val($(e.relatedTarget).data("nature_of_devt"));
        $("#rt_parcel_address").val($(e.relatedTarget).data("parcel_address"));
        $("#rt_ls_number").val($(e.relatedTarget).data("ls_number"));
        $("#rt_commencement_date").val($(e.relatedTarget).data("comm_date"));
        $("#rt_term").val($(e.relatedTarget).data("term"));
       // $("#rt_expiry_date").val($(e.relatedTarget).data("expiry_date"));
        $("#rt_consent_date").val($(e.relatedTarget).data("consent_date"));
        $("#rt_rent_category").val($(e.relatedTarget).data("rent_category"));
        $("#rt_rent_review_clause").val($(e.relatedTarget).data("rent_review_clause"));
        $("#rt_rent_passing").val($(e.relatedTarget).data("rent_passing"));
        // $("#rt_adjoining_plots").val($(e.relatedTarget).data("adjoining_plots"));
        // $("#rt_original_use").val($(e.relatedTarget).data("original_use"));
        $("#rt_rent_outstanding").val($(e.relatedTarget).data("rent_outstanding"));
        //$("#rt_classification_of_arrears").val($(e.relatedTarget).data("classification_of_arrears"));
        $("#rt_glpin").val($(e.relatedTarget).data("glpin"));
        $("#rt_remarks").val($(e.relatedTarget).data("remarks"));
        $("#rt_estate").val($(e.relatedTarget).data("estate"));
        $("#rt_last_payment_date").val($(e.relatedTarget).data("last_payment_date"));
        $("#rt_nature_of_instrument").val($(e.relatedTarget).data("nature_of_instrument"));
        //$("#rt_last_review_date").val($(e.relatedTarget).data("last_review_date"));
        //$("#rt_region_code").val($(e.relatedTarget).data("region_id"));
        $("#rt_last_payment_period").val($(e.relatedTarget).data("last_payment_period"));
        $("#rt_period_in_arrears").val($(e.relatedTarget).data("period_in_arrears"));
    });

    $('#singlerentdemandnotice_1').on('shown.bs.modal', (e) => {
       // e.preventDefault();
    
        // Set values for form fields using data attributes from the triggering element
        $("#rdn_rent_id").val($(e.relatedTarget).data("rent_id"));
        $("#rdn_account_number").val($(e.relatedTarget).data("account_number"));
        $("#rdn_leasee_name").val($(e.relatedTarget).data("owners_name"));
        $("#rdn_leasee_address").val($(e.relatedTarget).data("address"));
        $("#rdn_mobile_phone_1").val($(e.relatedTarget).data("mobile"));
        $("#rdn_mobile_phone_2").val($(e.relatedTarget).data("mobile_1"));
        $("#rdn_email").val($(e.relatedTarget).data("email"));
    });




$("#btn_upload_rent_data_file")
.click(
        function(event) {
            event.preventDefault();

            var sampleFile = document
                    .getElementById("fileUploadFormrentdata").files[0];

            var filename = document
                    .getElementById("fileUploadFormrentdata").files[0].name;

            console.log(filename);

            var formdata = new FormData();

            /*
             * formdata.append("case_number",
             * case_number);
             */
            formdata.append("file_name", filename);
            formdata.append("sampleFile",sampleFile);

            $
                    .ajax({
                        type : "POST",
                        enctype : 'multipart/form-data',
                        url : "UploadRentDataCSV",
                        // url :
                        // "UploadRegionalNumberCSV",
                        data : formdata,
                        processData : false,
                        contentType : false,
                        cache : false,
                        timeout : 600000,
                        success : function(data) {

                          // console.log(data);

                            var table_bp = $('#bulk_rent_data_list_dataTable_smd');
                            table_bp.find(
                                    "tbody tr")
                                    .remove();

                            // $("#result").text(data);
                            // alert(data);

                            var json_p = JSON
                                    .parse(data);

                            var table = $('#bulk_rent_data_list_dataTable_smd');
                            // table.find("tbody
                            // tr").remove();
                                

                            
                            $(json_p)
                                    .each(
                                            function() {
                                                table_bp
                                                        .append("<tr><td>"
                                                                + this.owners_name
                                                                + "</td><td>"
                                                                + this.address
                                                                + "</td><td>"
                                                                + this.file_number
                                                                + "</td><td>"
                                                                + this.ledger
                                                                + "</td><td>"
                                                                + this.folio
                                                                + "</td><td>"
                                                                + this.plot_number
                                                                + "</td><td>"
                                                                + this.plot_size
                                                                + "</td><td>"
                                                                + this.covenanted_user
                                                                + "</td><td>"
                                                                + this.current_use
                                                                + "</td><td>"
                                                                + this.nature_of_devt
                                                                + "</td><td>"
                                                                + this.ls_number
                                                                + "</td><td>"
                                                                + this.nature_of_instrument
                                                                + "</td><td>"
                                                                + this.comm_date
                                                                + "</td><td>"
                                                                + this.term
                                                                + "</td><td>"
                                                                + this.consent_date
                                                                + "</td><td>"
                                                                + this.rent_review_clause
                                                                + "</td><td>"
                                                                + this.rent_passing
                                                                + "</td><td>"
                                                                + this.period_in_arrears
                                                                + "</td><td>"
                                                                + this.previous_rent_review_clause
                                                                + "</td>"
                                                                + "</tr>");
                                            });

                            $(
                                    '#fileRentUploadModal')
                                    .modal('hide');
                            console.log(
                                    "SUCCESS : ",
                                    data);
                            $("#btn_upload_rn_file")
                                    .prop(
                                            "disabled",
                                            false);

                        },
                        error : function(e) {

                            // $("#result").text(e.responseText);
                            console.log("ERROR : ",
                                    e);
                            $("#btn_upload_rent_data_file")
                                    .prop(
                                            "disabled",
                                            false);

                        }
                    });

                });


 $("#btn_process_rent_data_by_csv_1").click(function(event) {

           

            var rnt_upload_office_region = $("#rnt_upload_office_region").val();
            var rnt_upload_eatate = $("#rnt_upload_eatate").val();

            rnt_upload_office_region = rnt_upload_office_region.replace('.0', '');
            rnt_upload_eatate = rnt_upload_eatate.replace('.0', '');


            var table = storeTblValues()
            var list_of_application_new = JSON
                    .stringify(table)
            console.log(list_of_application_new);

            function storeTblValues() {
                var TableData = new Array();

                $(
                        '#bulk_rent_data_list_dataTable_smd tr')
                        .each(
                                function(row, tr) {
                                    TableData[row] = {
                                        "rnt_upload_office_region" : rnt_upload_office_region,
                                        "rnt_upload_eatate" : rnt_upload_eatate,


                                        "owners_name" : $(tr).find('td:eq(0)').text().trim(),
                                        "address" : $(tr).find('td:eq(1)').text().trim(),
                                        "file_number" : $(tr).find('td:eq(2)').text().trim(),
                                        "ledger" : $(tr).find('td:eq(3)').text().trim(),
                                        "folio" : $(tr).find('td:eq(4)').text().trim(),
                                        "plot_number" : $(tr).find('td:eq(5)').text().trim(),
                                        "plot_size" : $(tr).find('td:eq(6)').text().trim(),
                                        "covenanted_user" : $(tr).find('td:eq(7)').text().trim(),
                                        "current_use" : $(tr).find('td:eq(8)').text().trim(),
                                        "nature_of_devt" : $(tr).find('td:eq(9)').text().trim(),
                                        "ls_number" : $(tr).find('td:eq(10)').text().trim(),
                                        "nature_of_instrument" : $(tr).find('td:eq(11)').text().trim(),
                                        "comm_date" : $(tr).find('td:eq(12)').text().trim(),
                                        "term" : $(tr).find('td:eq(13)').text().trim(),
                                        "consent_date" : $(tr).find('td:eq(14)').text().trim(),
                                        "rent_review_clause" : $(tr).find('td:eq(15)').text().trim(),
                                        "rent_passing" : $(tr).find('td:eq(16)').text().trim(),
                                        "period_in_arrears" : $(tr).find('td:eq(17)').text().trim(),


								
									
                              
                                    }
                                });
                TableData.shift(); // first row
                // will be empty
                // - so remove
                return TableData;
            }

            $
                    .ajax({
                        type : "POST",
                        url : "Case_Management_Serv",
                        data : {
                            request_type : 'select_upload_rent_data',
                            rent_data_upload_list : list_of_application_new,

                        },
                        cache : false,

                        // xhrFields : {
                        //     responseType : 'blob'
                        // },
                        success : function(
                                jobdetails) {
                            console.log(jobdetails);

                         
                           alert(jobdetails);


                           
                          

                        }
                    });
        });

});

