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

    $('#rts_select_type').on('change', (e) => {
        e.preventDefault();

        datatable.search("").draw();
        datatable.state.clear();
        datatable.clear();

        var rts_select_type = $('#rts_select_type').val();

        if(rts_select_type == 'Plot Number'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');
            $('#div_certificate_rmap_search').addClass('d-none');
            $('#div_btn_rmap_search').removeClass('d-none');

        } else if(rts_select_type == 'Estate'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').addClass('d-none');
            $('#div_certificate_rmap_search').addClass('d-none');
            $('#div_btn_rmap_search').removeClass('d-none');
            
        } else if(rts_select_type == 'Name of Leasee/Assignee'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');
            $('#div_certificate_rmap_search').addClass('d-none');
            $('#div_btn_rmap_search').removeClass('d-none');
            
        } else if(rts_select_type == 'Certificate Number'){

            $('#div_rent_estate').addClass('d-none');
            $('#div_rent_keyword').addClass('d-none');
            $('#div_certificate_rmap_search').removeClass('d-none');
            $('#div_btn_rmap_search').addClass('d-none');
            
        }
    })


    $('#rt_region_code').on('change', (e) => {
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


    
    $('#btn_generate_rent_demand_note').on('click', (e) => {
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
                            + this.rc_amount_of_one_cedi 
                            + "</td><td>" 
                            + this.rc_amount_of_one_cedi_pa 
                            + "</td><td>" 
                            + this.rc_annual_rent 
                            + "</td><td>" 
                            + this.rc_amount_assessed 
                            + "</td><td>" 
                            + this.rc_description 
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

    $('#btn_save_rent_client_details').on('click', (e) => {
        e.preventDefault();

        var rt_rent_id = $('#addlegder .rt_rent_id').val();
        var rt_parcel_id = $('#addlegder #rt_parcel_id').val();
        var rt_leasee_name = $('#addlegder #rt_leasee_name').val();
        var rt_leasee_address = $('#addlegder #rt_leasee_address').val();
        var rt_mobile_phone_1 = $('#addlegder #rt_mobile_phone_1').val();
        var rt_mobile_phone_2 = $('#addlegder #rt_mobile_phone_2').val();
        var rt_email = $('#addlegder #rt_email').val();
        var rt_leasee_digital_address = $('#addlegder #rt_leasee_digital_address').val();
        //var rt_locality = $('#rt_locality').val();
        var rt_estate = $('#addlegder #rt_estate').val();
        var rt_plot_number = $('#addlegder #rt_plot_number').val();
        var rt_plot_size = $('#addlegder #rt_plot_size').val();
       // var rt_block_number = $('#rt_block_number').val();
        var rt_convenant_user = $('#addlegder #rt_convenant_user').val();
        //var rt_original_use = $('#rt_original_use').val();
        var rt_current_use = $('#addlegder #rt_current_use').val();
        var rt_nature_of_dev = $('#addlegder #rt_nature_of_dev').val();
        var rt_parcel_address = $('#addlegder #rt_parcel_address').val();
        var rt_file_number = $('#addlegder #rt_file_number').val();
        var rt_ledger = $('#addlegder #rt_ledger').val();
        var rt_folio = $('#addlegder #rt_folio').val();
        var rt_ls_number = $('#addlegder #rt_ls_number').val();
        var rt_commencement_date = $('#addlegder #rt_commencement_date').val();
        var rt_term = $('#addlegder #rt_term').val();
        //var rt_expiry_date = $('#rt_expiry_date').val();
        var rt_consent_date = $('#addlegder #rt_consent_date').val();
        var rt_location_rate = $('#addlegder #rt_location_rate').val();
        var rt_rent_category = $('#addlegder #rt_rent_category').val();
        var rt_rent_review_clause = $('#addlegder #rt_rent_review_clause').val();
        var rt_rent_passing = $('#addlegder #rt_rent_passing').val();
        //var rt_adjoining_plots = $('#rt_adjoining_plots').val();
        //var rt_amount_due = $('#rt_amount_due').val();
        var rt_rent_outstanding = $('#addlegder #rt_rent_outstanding').val();
        //var rt_classification_of_arrears = $('#rt_classification_of_arrears').val();
       // var rt_serial_number = $('#rt_serial_number').val();
        var rt_remarks = $('#addlegder #rt_remarks').val();
        var rt_last_payment_date = $('#addlegder #rt_last_payment_date').val();
        var rt_nature_of_instrument = $('#addlegder #rt_nature_of_instrument').val();
        //var rt_last_review_date = $('#rt_last_review_date').val();
        var rt_last_payment_period = $('#addlegder #rt_last_payment_period').val();
        var rt_period_in_arrears = $('#addlegder #rt_period_in_arrears').val();
        var rt_glpin = $('#addlegder #rt_glpin').val();

        // if(!rt_leasee_name || !rt_leasee_address || !rt_mobile_phone_1 || !rt_region_code || !rt_locality || !rt_estate || 
        //     !rt_plot_number || !rt_plot_size || !rt_block_number || !rt_file_number || !rt_ledger || !rt_commencement_date || !rt_term || 
        //     !rt_expiry_date || !rt_consent_date || !rt_location_rate) {

        //         alert('Please fill in all the required fields');
        //         return;
        //  }

        console.log(rt_rent_id, rt_rent_category, rt_nature_of_dev);

         // List of required fields
        const fields = [
            { field: rt_leasee_name, selector: '#rt_leasee_name' },
            { field: rt_leasee_address, selector: '#rt_leasee_address' },
            //{ field: rt_mobile_phone_1, selector: '#rt_mobile_phone_1' },
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
            //{ field: rt_location_rate, selector: '#rt_location_rate' },
            { field: rt_last_payment_date, selector: '#rt_last_payment_date' },
            { field: rt_rent_review_clause, selector: '#rt_rent_review_clause' },
            //{ field: rt_last_review_date, selector: '#rt_last_review_date' },
            { field: rt_last_payment_period, selector: '#rt_last_payment_period' },
            //{ field: rt_period_in_arrears, selector: '#rt_period_in_arrears'},
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


 
     rt_estate = rt_estate.replace('.0', '');

        $.ajax({
            type : "POST",
            url : "rent_mgt_serv",
            data : {
                request_type : 'add_update_rent_leasee_details',
                rent_id : rt_rent_id || 0,
                parcel_id : rt_parcel_id || '',
                owners_name : rt_leasee_name || '',
                address : rt_leasee_address || '',
                mobile : rt_mobile_phone_1 || '',
                mobile_1 : rt_mobile_phone_2 || '',
                email : rt_email || '',
                file_number : rt_file_number || '',
                ledger : rt_ledger || '',
                folio : rt_folio || '',
                digital_address : rt_leasee_digital_address || '',
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
                        $("#btn_rt_search").trigger("click");
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

 $('#btn_save_edit_rent_client_details').on('click', (e) => {
       e.preventDefault();
//console.log('fughjhghjh hgvhghgghg hghggh')
        var rt_rent_id = $('#editlegder #rt_e_rent_id').val();
        var rt_parcel_id = $('#editlegder #rt_e_parcel_id').val();
        var rt_leasee_name = $('#editlegder #rt_e_leasee_name').val();
        var rt_leasee_address = $('#editlegder #rt_e_leasee_address').val();
        var rt_mobile_phone_1 = $('#editlegder #rt_e_mobile_phone_1').val();
        var rt_mobile_phone_2 = $('#editlegder #rt_e_mobile_phone_2').val();
        var rt_email = $('#editlegder #rt_e_email').val();
        var rt_leasee_digital_address = $('#editlegder #rt_e_leasee_digital_address').val();
        //var rt_locality = $('#rt_e_locality').val();
        var rt_estate = $('#editlegder #rt_e_estate').val();
        var rt_plot_number = $('#editlegder #rt_e_plot_number').val();
        var rt_plot_size = $('#editlegder #rt_e_plot_size').val();
       // var rt_block_number = $('#rt_e_block_number').val();
        var rt_convenant_user = $('#editlegder #rt_e_convenant_user').val();
        //var rt_original_use = $('#rt_e_original_use').val();
        var rt_current_use = $('#editlegder #rt_e_current_use').val();
        var rt_nature_of_dev = $('#editlegder #rt_e_nature_of_dev').val();
        var rt_parcel_address = $('#editlegder #rt_e_parcel_address').val();
        var rt_file_number = $('#editlegder #rt_e_file_number').val();
        var rt_ledger = $('#editlegder #rt_e_ledger').val();
        var rt_folio = $('#editlegder #rt_e_folio').val();
        var rt_ls_number = $('#editlegder #rt_e_ls_number').val();
        var rt_commencement_date = $('#editlegder #rt_e_commencement_date').val();
        var rt_term = $('#editlegder #rt_e_term').val();
        //var rt_expiry_date = $('#rt_e_expiry_date').val();
        var rt_consent_date = $('#editlegder #rt_e_consent_date').val();
        var rt_location_rate = $('#editlegder #rt_e_location_rate').val();
        var rt_rent_category = $('#editlegder #rt_e_rent_category').val();
        var rt_rent_review_clause = $('#editlegder #rt_e_rent_review_clause').val();
        var rt_rent_passing = $('#editlegder #rt_e_rent_passing').val();
        //var rt_adjoining_plots = $('#rt_e_adjoining_plots').val();
        //var rt_amount_due = $('#rt_e_amount_due').val();
        var rt_rent_outstanding = $('#editlegder #rt_e_rent_outstanding').val();
        //var rt_classification_of_arrears = $('#rt_e_classification_of_arrears').val();
       // var rt_serial_number = $('#rt_e_serial_number').val();
        var rt_remarks = $('#editlegder #rt_e_remarks').val();
        var rt_last_payment_date = $('#editlegder #rt_e_last_payment_date').val();
        var rt_nature_of_instrument = $('#editlegder #rt_e_nature_of_instrument').val();
        //var rt_last_review_date = $('#rt_e_last_review_date').val();
        var rt_last_payment_period = $('#editlegder #rt_e_last_payment_period').val();
        var rt_period_in_arrears = $('#editlegder #rt_e_period_in_arrears').val();
        var rt_glpin = $('#editlegder #rt_e_glpin').val();

    

        console.log(rt_rent_id, rt_rent_category, rt_nature_of_dev);

         // List of required fields
        const fields = [
            { field: rt_leasee_name, selector: '#rt_e_leasee_name' },
            { field: rt_leasee_address, selector: '#rt_e_leasee_address' },
            //{ field: rt_mobile_phone_1, selector: '#rt_e_mobile_phone_1' },
            // { field: rt_region_code, selector: '#rt_e_region_code' },
            // { field: rt_locality, selector: '#rt_e_locality' },
            { field: rt_estate, selector: '#rt_e_estate' },
            { field: rt_plot_number, selector: '#rt_e_plot_number' },
            { field: rt_plot_size, selector: '#rt_e_plot_size' },
            //{ field: rt_block_number, selector: '#rt_e_block_number' },
            { field: rt_file_number, selector: '#rt_e_file_number' },
            { field: rt_ledger, selector: '#rt_e_ledger' },
            { field: rt_commencement_date, selector: '#rt_e_commencement_date' },
            { field: rt_term, selector: '#rt_e_term' },
            //{ field: rt_expiry_date, selector: '#rt_e_expiry_date' },
            //{ field: rt_consent_date, selector: '#rt_e_consent_date' },
            //{ field: rt_location_rate, selector: '#rt_e_location_rate' },
            { field: rt_last_payment_date, selector: '#rt_e_last_payment_date' },
            { field: rt_rent_review_clause, selector: '#rt_e_rent_review_clause' },
            //{ field: rt_last_review_date, selector: '#rt_e_last_review_date' },
            { field: rt_last_payment_period, selector: '#rt_e_last_payment_period' },
            //{ field: rt_period_in_arrears, selector: '#rt_e_period_in_arrears'},
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


 
     rt_estate = rt_estate.replace('.0', '');

        $.ajax({
            type : "POST",
            url : "rent_mgt_serv",
            data : {
                request_type : 'add_update_rent_leasee_details',
                rent_id : rt_rent_id || 0,
                parcel_id : rt_parcel_id || 0,
                owners_name : rt_leasee_name || '',
                address : rt_leasee_address || '',
                mobile : rt_mobile_phone_1 || '',
                mobile_1 : rt_mobile_phone_2 || '',
                email : rt_email || '',
                file_number : rt_file_number || '',
                ledger : rt_ledger || '',
                folio : rt_folio || '',
                digital_address : rt_leasee_digital_address || '',
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
                        $('#editlegder').modal('hide');
                        $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">Data saved successfully.</span>' }, { type: 'success' });
                        $("#btn_rt_search").trigger("click");
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

    
    $('#btn_rt_search').on('click', (e) => {
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


        
        rts_estate = rts_estate.replace(".0", "");
			
        $.ajax({
            type : "POST",
            url : "rent_mgt_serv",
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


       
       
       //             let total_rent_outstanding = 12500; // your value
    /// document.getElementById("rentOutstanding").innerHTML = total_rent_outstanding;

       $("#total_leasee").html(json_p.total_leasee);
       $("#rentOutstanding").html(json_p.total_rent_oustanding);
      

                    if(json_p.data == null) {
                        $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">No data found.</span>' }, { type: 'danger' });

                        datatable.search("").draw();
                        datatable.state.clear();
                        datatable.clear();
                    }

                    datatable.search("").draw();
                    datatable.state.clear();
                    datatable.clear();


             
//                    const value = 8750.75;
// document.querySelector('[data-rent-outstanding]').textContent = 
//   value.toLocaleString('en-GH', { minimumFractionDigits: 2 });

                    $(json_p.data).each(function() {

                        $("#rth_m_idxxx").val(json_p.data[0].rl_id);
                        $("#rth_plot_numberxxx").val(json_p.data[0].plot_number);

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
                            this.account_number,
                            this.plot_number,
                            this.owners_name,
                            this.file_number,
                            this.comm_date,
                            //this.location,
                           // this.consent_date,
                            this.term,
                            this.plot_size,
                          this.last_review_date,
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
                                +'<a class="dropdown-item viewLedgerBtn" href="#"' 
                                +'data-toggle="modal" data-target="#"'
                                +'data-modal_label="Edit Lessee"'
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
                                 +'data-estate_id="'+this.estate_id+'"'
                                +'data-last_payment_date="'+this.last_payment_date+'"'
                                +'data-expiry_date="'+this.expiry_date+'"'
                                +'data-nature_of_instrument="'+this.nature_of_instrument+'"'
                                //+'data-last_review_date="'+this.last_review_date+'"'
                                //+'data-region_id="'+this.region_id+'"'
                                +'data-last_payment_period="'+this.last_payment_period+'"'
                                +'data-period_in_arrears="'+this.period_in_arrears+'"'
                                +'><i class="fas fa-eye"></i> View</a>'
                               

                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#editlegder"'
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
                                 +'data-estate_id="'+this.estate_id+'"'
                                +'data-last_payment_date="'+this.last_payment_date+'"'
                                +'data-nature_of_instrument="'+this.nature_of_instrument+'"'
                                //+'data-last_review_date="'+this.last_review_date+'"'
                                //+'data-region_id="'+this.region_id+'"'
                                +'data-last_payment_period="'+this.last_payment_period+'"'
                                +'data-period_in_arrears="'+this.period_in_arrears+'"'
                                +'><i class="fas fa-money-bill"></i>Edit</a>'



                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#singlerentdemandnotice"'
                                +'data-rent_id="'+this.rl_id+'"'
                                +'data-account_number="'+this.account_number+'"'
                                +'data-owners_name="'+this.owners_name+'"'
                                +'data-address="'+this.address+'"'
                                +'data-mobile="'+this.mobile+'"'
                                +'data-mobile_1="'+this.mobile_1+'"'
                                +'data-email="'+this.email+'"'
                                +'><i class="fas fa-money-bill"></i>Rent Demand Notice</a>'


                                 +'<a class="dropdown-item" href="#" data-toggle="modal" data-m_id="'+this.rl_id+'" data-account_number="" data-target="#paymenthistory"><i class="fas fa-money-bill"></i> Payment History</a>'
                                    +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#rentTransactionhistory"'
                                +'data-rent_id="'+this.rl_id+'"'
                                +'data-account_number="'+this.account_number+'"'
                                +'data-plot_number="'+this.plot_number+'"'

                                +'><i class="fas fa-money-bill"></i>Transaction History</a>'
                                // +'<a class="dropdown-item" href="#"  data-m_id="'+this.rl_id+'" data-account_number="" onclick="loadTransactionHistory('+this.rl_id+')"><i class="fas fa-list"></i> Transaction History</a>'

                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#rentdocuments"'
                                +'data-rent_id="'+this.rl_id+'"'
                                +'data-account_number="'+this.account_number+'"'
                                +'data-file_number="'+this.file_number+'"'
                                +'data-email="'+this.email+'"'
                                +'><i class="fas fa-file-alt"></i>Documents</a>'
                                //  +'<a class="dropdown-item" href="#" data-toggle="modal" data-m_id="'+this.rl_id+'" data-account_number="" data-target="#rentdocuments"><i class="fas fa-file-alt"></i> Documents</a>'
                                  +'<a class="dropdown-item" href="#" data-toggle="modal" data-m_id="'+this.rl_id+'" data-account_number="" data-target="#rentremarks"><i class="fas fa-list"></i> Remarks</a>'
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


      $('#btn_load_scanned_documents_rent').on('click', function(e) { 
	   
		
			
			
			 var table_docs_mains = $('#lc_rent_scanned_documents_dataTable');
			 table_docs_mains.find("tbody tr").remove(); 
	   
        	var case_number = $("#file_upload_file_number_rent").val();
        	//console.log(case_number);
   		 $.ajax({
				 type: "POST",
				 url: "LoadLRDJackets",
				 data: {
	                	request_type: 'load_case_scanned_document_new',
	                	case_number:case_number},
				 cache: false,
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(serviceresponse) {
					// if(!serviceresponse){
					// 	return;
					// }
					try{
						var json_p = JSON.parse(serviceresponse);
						//console.log(json_p)
											
						
						 $(json_p).each(function () {
						        
							

							 table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

					    		    + "</tr>");

						 });

					}catch(e){
													console.log(e)
												}
					
					  
				 }
				 }); 
        //	
        });
$('#lc_rent_scanned_documents_dataTable').on('click', '.link-post', function(e){
	//  console.log(e)

	  e.preventDefault();
var file_to_open = e.target.href;
  console.log(file_to_open);
var file_path = file_to_open.replace("file:///", "");
	 console.log(file_path);
var URL_map = file_to_open;
var newURL = URL_map.replace(/^[a-z]{4,5}\:\/{2}[a-z]{1,}\:[0-9]{1,4}.(.*)/, '$1');
console.log('newURL');
console.log(newURL);
	 
var urlObj = new URL(file_to_open);
var newURL1 = urlObj.href.replace(urlObj.origin, '');
console.log(newURL1);
	 
	  var fileName, fileExtension;
//fileName = file_path;
fileName = file_path;
fileExtension = fileName.replace(/^.*\./, '');
console.log (fileExtension);
	  

		 $.ajax({
				 type: "POST",
				 url: "open_pdffile_new",
				// target:'_blank',
				 data: {
					 //request_type: 'request_to_generate_batch_list',
					 request_type: 'request_to_generate_batch_list',
					 file_to_open:newURL,
						 file_path: newURL1,
						 file_extension: fileExtension,
						 file_to_open: newURL
	           },
				 cache: false,
				xhrFields:{
	                responseType: 'blob'
	            },
				 beforeSend: function () {
					// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
				 },
				 success: function(jobdetails) {
					console.log(jobdetails);
						if(fileExtension==="zip"){
 						
							var blob = new Blob([jobdetails], {type: "application/zip"});
	          			        var objectUrl = URL.createObjectURL(blob);
	          			   		 window.open(objectUrl);
 						}else{
 							
 							$('#elisDocumentPreview').modal({
 		     	    	 			 backdrop: 'static',
 		     	    				});
 		          				
 		          					
 							//const file = new File([blob], 'untitled', { type: blob.type })
 							
 							var blob = new Blob([jobdetails], {type: "application/pdf"});
 		          			        var objectUrl = URL.createObjectURL(blob);
 		          			   // window.open(objectUrl);

 									$(
 											'#elisdovumentpreviewblobfile')
 											.attr('src',
 													objectUrl);
 									
 									$(
 									'#fedocumentPreviewblobfile')
 									.attr('src',
 											objectUrl);
 						}
					
					  
				 }
				 });  
	  
	});
    $("#btn_upload_case_file_rent").click(function (event) {
                      event.preventDefault();
                     var case_number = $("#file_upload_file_number_rent").val();
                     var sampleFile = document.getElementById("fileUploadFormrent").files[0];
                     var filename = document.getElementById("fileUploadFormrent").files[0].name;
                     console.log(filename);
                     
                     var formdata = new FormData();

                     formdata.append("case_number", case_number);
                     formdata.append("file_name", filename);
					   $('.fileUploadrent input[name="sampleFile"]').each(function(index, element) {
							if (element.files && element.files.length > 0) {
								// Append each file with a unique index
								formdata.append('sampleFile', element.files[0]);
								formdata.append('file_name', element.files[0].name);
							}
						});
                     
                    $("#btn_upload_case_file_rent").prop("disabled", true);
                   // console.log(formdata);
                     $.ajax({
                         type: "POST",
                         enctype: 'multipart/form-data',
                         //url: "document_upload_new",
						 url: "document_upload_mutiple_new",
                         data: formdata,
                         processData: false,
                         contentType: false,
                         cache: false,
                         timeout: 600000,
                         success: function (data) {
                          alert(data);
                         // $('#fileUploadModal').modal('hide');
                             console.log("SUCCESS : ", data);
                             $("#btn_upload_case_file").prop("disabled", false);

                         },
                         error: function (e) {

                            // $("#result").text(e.responseText);
                             console.log("ERROR : ", e);
                             $("#btn_upload_case_file_rent").prop("disabled", false);

                         }
                     });
                     
                 });


        $('#rentTransactionhistory').on('shown.bs.modal', (e) => {
            e.preventDefault();
            $("#rth_m_idxxx").val($(e.relatedTarget).data("rent_id"));
            $("#rth_plot_numberxxx").val($(e.relatedTarget).data("plot_number"));
            var table = $('#tbl_rent_transaction_history');
            table.find("tbody tr").remove();

              let v_m_id = $("#rth_m_idxxx").val();

            console.log(v_m_id)

            if(v_m_id == 0) {

                // var table = $('#tbl_rent_transaction_history');
                //     table.find("tbody tr").remove();

                $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">No transaction found.</span>' }, { type: 'danger',z_index: 9999 });
                return;
            }

            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    m_id: v_m_id,
                    request_type: 'load_rent_transaction_history'
                },
                success: function (response) {
                    console.log(response)

                    var table = $('#tbl_rent_transaction_history');
                    table.find(
                                    "tbody tr")
                                    .remove();

                            // $("#result").text(data);
                            // alert(data);

                    var json_p = JSON.parse(response);

                    var table = $('#tbl_rent_transaction_history');
                    
                    $(json_p.data)
                            .each(
                                    function() {
                                        table
                                                .append("<tr><td>"
                                                        + this.plot_number
                                                        + "</td><td>"
                                                        + this.lessee_name
                                                        + "</td><td>"
                                                        + this.nature_of_instrument
                                                        + "</td><td>"
                                                        + this.consent_date
                                                        + "</td><td>"
                                                        + this.term
                                                        + "</td><td>"
                                                        +'<button class="btn btn-primary" type="button" onclick="getTransactionDetails('+this.id+')"><i class="fas fa-eye"></i></button>'
                                                        // +'<button class="btn btn-success" type="button" onclick="addNewTranscationHistory('+this.id+')"><i class="fas fa-plus"></i></button>'
                                                        +"</td>"
                                                        + "</tr>");
                                    });
                    
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX Error:', textStatus, errorThrown);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger',z_index: 9999 });
                }
            });


        });



     let currentLedgerData = {}; // store globally within this scope

    $(document).on("click", ".viewLedgerBtn", function () {
        // Grab data attributes from the button (or from your AJAX response)
        const data = $(this).data(); 
        currentLedgerData = data; // save for edit later
        
        // Populate fields
        $("#view_leasee_name").text(data.owners_name || "");
        $("#view_email").text(data.email || "");
        $("#view_address").text(data.address || "");
        $("#view_digital_address").text(data.digital_address || "");
        $("#view_mobile1").text(data.mobile || "");
        $("#view_mobile2").text(data.mobile_1 || "");

        $("#view_plot_number").text(data.plot_number || "");
        $("#view_plot_size").text(data.plot_size || "");
        $("#view_file_number").text(data.file_number || "");
        $("#view_ledger").text(data.ledger || "");
        $("#view_folio").text(data.folio || "");
        $("#view_ls_number").text(data.ls_number || "");
        $("#view_parcel_address").text(data.parcel_address || "");
        $("#view_convenant_user").text(data.convenant_user || "");
        $("#view_current_use").text(data.current_use || "");
        $("#view_nature_of_dev").text(data.nature_of_devt || "");

        $("#view_estate").text($("#rts_estate option:selected").text() || "");
        //$("#view_estate").text($("#rts_estate option:selected").text() || "");
        $("#view_commencement_date").text(data.comm_date || "");
        $("#view_term").text(data.term || "");
        $("#view_nature_of_instrument").text(data.nature_of_instrument || "");

        $("#view_rent_category").text(data.rent_category || "");
        $("#view_rent_passing").text(data.rent_passing || "");
        $("#view_location_rate").text(data.location_rate || "");
        $("#view_rent_review_clause").text(data.rent_review_clause || "");

        $("#view_last_payment_date").text(data.last_payment_date || "");
        $("#view_rent_outstanding").text(data.rent_outstanding || "");
        $("#view_period_in_arrears").text(data.period_in_arrears || "");
        $("#view_remarks").text(data.remarks || "");
        $("#view_last_payment_period").text(data.last_payment_period || "");
 $("#view_expiry_date").text(data.expiry_date || "");
        

        // Show modal
        $("#viewLedger").modal("show");
    });

    $(document).on("click", "#editLedgerBtn", function () {
        // Hide the view modal
        $("#viewLedger").modal("hide");
        
        // Populate edit modal form fields using currentLedgerData
        const data = currentLedgerData;

        $("#addlegder .rt_rent_id").val(data.rent_id || "");
        $("#addlegder #rt_leasee_name").val(data.owners_name || "");
        $("#addlegder #rt_leasee_address").val(data.address || "");
        $("#addlegder #rt_mobile_phone_1").val(data.mobile || "");
        $("#addlegder #rt_mobile_phone_2").val(data.mobile_1 || "");
        $("#addlegder #rt_email").val(data.email || "");
        $("#addlegder #rt_file_number").val(data.file_number || "");
        $("#addlegder #rt_ledger").val(data.ledger || "");
        $("#addlegder #rt_folio").val(data.folio || "");
        $("#addledger #rt_leasee_digital_address").val(data.digital_address || "");
        $("#addlegder #rt_plot_number").val(data.plot_number || "");
        $("#addlegder #rt_plot_size").val(data.plot_size || "");
        $("#addlegder #rt_convenant_user").val(data.covenanted_user || "");
        $("#addlegder #rt_current_use").val(data.current_use || "");
        $("#addlegder #rt_nature_of_dev").val(data.nature_of_devt || "");
        $("#addlegder #rt_parcel_address").val(data.parcel_address || "");
        $("#addlegder #rt_ls_number").val(data.ls_number || "");
        $("#addlegder #rt_commencement_date").val(data.comm_date || "");
        $("#addlegder #rt_term").val(data.term || "");
        $("#addlegder #rt_consent_date").val(data.consent_date || "");
        $("#addlegder #rt_location_rate").val(data.location_rate || "");
        $("#addlegder #rt_rent_category").val(data.rent_category || "");
        $("#addlegder #rt_rent_review_clause").val(data.rent_review_clause || "");
        $("#addlegder #rt_rent_passing").val(data.rent_passing || "");
        $("#addlegder #rt_rent_outstanding").val(data.rent_outstanding || "");
        $("#addlegder #rt_glpin").val(data.glpin || "");
        $("#addlegder #rt_remarks").val(data.remarks || "");
        $("#addlegder #rt_estate").val(data.estate+".0" || "");
        $("#addlegder #rt_last_payment_date").val(data.last_payment_date || "");
        $("#addlegder #rt_nature_of_instrument").val(data.nature_of_instrument || "");
        $("#addlegder #rt_last_payment_period").val(data.last_payment_period || "");
        $("#addlegder #rt_period_in_arrears").val(data.period_in_arrears || "");

        $("#modal_label").text("Edit Lessee");

        // Show edit modal
        $("#addlegder").modal("show");
    });

    $('#addlegder').on('hidden.bs.modal', (e) => {
        $('#addlegderForm')[0].reset();
    })

    // $('#addlegder').on('shown.bs.modal', (e) => {
    //     e.preventDefault();
    
    //     // Set values for form fields using data attributes from the triggering element
    //     $(".rt_rent_id").val($(e.relatedTarget).data("rent_id"));
    //     $("#rt_leasee_name").val($(e.relatedTarget).data("owners_name"));
    //     $("#rt_leasee_address").val($(e.relatedTarget).data("address"));
    //     $("#rt_mobile_phone_1").val($(e.relatedTarget).data("mobile"));
    //     $("#rt_mobile_phone_2").val($(e.relatedTarget).data("mobile_1"));
    //     $("#rt_email").val($(e.relatedTarget).data("email"));
    //     $("#rt_file_number").val($(e.relatedTarget).data("file_number"));
    //     $("#rt_ledger").val($(e.relatedTarget).data("ledger"));
    //     $("#rt_folio").val($(e.relatedTarget).data("folio"));
    //     $("#rt_leasee_digital_address").val($(e.relatedTarget).data("digital_address"));
    //     // $("#rt_block_number").val($(e.relatedTarget).data("block"));
    //     $("#rt_plot_number").val($(e.relatedTarget).data("plot_number"));
    //     $("#rt_plot_size").val($(e.relatedTarget).data("plot_size"));
    //     $("#rt_convenant_user").val($(e.relatedTarget).data("covenanted_user"));
    //     $("#rt_current_use").val($(e.relatedTarget).data("current_use"));
    //     $("#rt_nature_of_dev").val($(e.relatedTarget).data("nature_of_devt"));
    //     $("#rt_parcel_address").val($(e.relatedTarget).data("parcel_address"));
    //     $("#rt_ls_number").val($(e.relatedTarget).data("ls_number"));
    //     $("#rt_commencement_date").val($(e.relatedTarget).data("comm_date"));
    //     $("#rt_term").val($(e.relatedTarget).data("term"));
    //    // $("#rt_expiry_date").val($(e.relatedTarget).data("expiry_date"));
    //     $("#rt_consent_date").val($(e.relatedTarget).data("consent_date"));
    //     $("#rt_rent_category").val($(e.relatedTarget).data("rent_category"));
    //     $("#rt_rent_review_clause").val($(e.relatedTarget).data("rent_review_clause"));
    //     $("#rt_rent_passing").val($(e.relatedTarget).data("rent_passing"));
    //     // $("#rt_adjoining_plots").val($(e.relatedTarget).data("adjoining_plots"));
    //     // $("#rt_original_use").val($(e.relatedTarget).data("original_use"));
    //     $("#rt_rent_outstanding").val($(e.relatedTarget).data("rent_outstanding"));
    //     //$("#rt_classification_of_arrears").val($(e.relatedTarget).data("classification_of_arrears"));
    //     $("#rt_glpin").val($(e.relatedTarget).data("glpin"));
    //     $("#rt_remarks").val($(e.relatedTarget).data("remarks"));
    //     $("#rt_estate").val($(e.relatedTarget).data("estate")+'.0');
    //     $("#rt_last_payment_date").val($(e.relatedTarget).data("last_payment_date"));
    //     $("#rt_nature_of_instrument").val($(e.relatedTarget).data("nature_of_instrument"));
    //     //$("#rt_last_review_date").val($(e.relatedTarget).data("last_review_date"));
    //     //$("#rt_region_code").val($(e.relatedTarget).data("region_id"));
    //     $("#rt_last_payment_period").val($(e.relatedTarget).data("last_payment_period"));
    //     $("#rt_period_in_arrears").val($(e.relatedTarget).data("period_in_arrears"));
    //     $("#modal_label").text($(e.relatedTarget).data("modal_label"));
    // });

    $('#singlerentdemandnotice').on('shown.bs.modal', (e) => {
       // e.preventDefault();
    
        // Set values for form fields using data attributes from the triggering element
        $("#rdn_rent_id").val($(e.relatedTarget).data("rent_id"));
        $("#rdn_account_number").val($(e.relatedTarget).data("account_number"));
        $("#rdn_leasee_name").val($(e.relatedTarget).data("owners_name"));
        $("#rdn_leasee_address").val($(e.relatedTarget).data("address"));
        $("#rdn_mobile_phone_1").val($(e.relatedTarget).data("mobile"));
        $("#rdn_mobile_phone_2").val($(e.relatedTarget).data("mobile_1"));
        $("#rdn_email").val($(e.relatedTarget).data("email"));
         
        var table = $('#tbl_rent_assessment_details');
            table.find("tbody tr").remove();
        
    });

     $('#editlegder').on('shown.bs.modal', (e) => {
       // e.preventDefault();
    
        $("#rt_e_rent_id").val($(e.relatedTarget).data("rent_id"));
        $("#rt_e_leasee_name").val($(e.relatedTarget).data("owners_name"));
        $("#rt_e_leasee_address").val($(e.relatedTarget).data("address"));
        $("#rt_e_mobile_phone_1").val($(e.relatedTarget).data("mobile"));
        $("#rt_e_mobile_phone_2").val($(e.relatedTarget).data("mobile_1"));
        $("#rt_e_email").val($(e.relatedTarget).data("email"));
        $("#rt_e_file_number").val($(e.relatedTarget).data("file_number"));
        $("#rt_e_ledger").val($(e.relatedTarget).data("ledger"));
        $("#rt_e_folio").val($(e.relatedTarget).data("folio"));
        $("#rt_e_leasee_digital_address").val($(e.relatedTarget).data("digital_address"));
        // $("#rt_e_block_number").val($(e.relatedTarget).data("block"));
        $("#rt_e_plot_number").val($(e.relatedTarget).data("plot_number"));
        $("#rt_e_plot_size").val($(e.relatedTarget).data("plot_size"));
        $("#rt_e_convenant_user").val($(e.relatedTarget).data("covenanted_user"));
        $("#rt_e_current_use").val($(e.relatedTarget).data("current_use"));
       
        $("#rt_e_parcel_address").val($(e.relatedTarget).data("parcel_address"));
        $("#rt_e_ls_number").val($(e.relatedTarget).data("ls_number"));
        $("#rt_e_commencement_date").val($(e.relatedTarget).data("comm_date"));
        $("#rt_e_term").val($(e.relatedTarget).data("term"));
       // $("#rt_expiry_date").val($(e.relatedTarget).data("expiry_date"));
        $("#rt_e_consent_date").val($(e.relatedTarget).data("consent_date"));
        $("#rt_e_rent_category").val($(e.relatedTarget).data("rent_category"));
        $("#rt_e_rent_review_clause").val($(e.relatedTarget).data("rent_review_clause"));
        $("#rt_e_rent_passing").val($(e.relatedTarget).data("rent_passing"));
        // $("#rt_adjoining_plots").val($(e.relatedTarget).data("adjoining_plots"));
        // $("#rt_original_use").val($(e.relatedTarget).data("original_use"));
        $("#rt_e_rent_outstanding").val($(e.relatedTarget).data("rent_outstanding"));
        //$("#rt_classification_of_arrears").val($(e.relatedTarget).data("classification_of_arrears"));
        $("#rt_e_glpin").val($(e.relatedTarget).data("glpin"));
        $("#rt_e_remarks").val($(e.relatedTarget).data("remarks"));
       // $("#rt_e_estate").val($(e.relatedTarget).data("estate")+'.0');
       
        $("#rt_e_last_payment_date").val($(e.relatedTarget).data("last_payment_date"));
     
        //$("#rt_last_review_date").val($(e.relatedTarget).data("last_review_date"));
        //$("#rt_region_code").val($(e.relatedTarget).data("region_id"));
        $("#rt_e_last_payment_period").val($(e.relatedTarget).data("last_payment_period"));
        $("#rt_e_period_in_arrears").val($(e.relatedTarget).data("period_in_arrears"));

 console.log('estate ID')
        console.log($(e.relatedTarget).data("estate_id"))

		$.ajax({
                type: "POST",
                url: "rent_mgt_serv",
                data: {
                    request_type: "get_estate_list",
                },
                cache: false,
                success: function (jobdetails) {
                    const select = $("#rt_e_estate");
                    select.empty(); // Clear existing options
                    const json_p = JSON.parse(jobdetails);
                    $(json_p).each(function () {
                    select.append(
                        `<option value="${this.ge_id}">${this.ge_location_name}</option>`
                    );
                    });
                    $("#rt_e_estate").val($(e.relatedTarget).data("estate_id"));

                },
                error: function (xhr, status, error) {
                    console.error("Error fetching estate list:", error);
                },
                });    

                $.ajax({
                type: "POST",
                url: "rent_mgt_serv",
                data: {
                    request_type: "get_nature_of_development_list",
                },
                cache: false,
                success: function (jobdetails) {
                    const select = $("#rt_e_nature_of_dev");
                    select.empty(); // Clear existing options
                    const json_p = JSON.parse(jobdetails);
                    $(json_p).each(function () {
                    select.append(
                        `<option value="${this.na_name}">${this.na_name}</option>`
                    );
                    });
                    $("#rt_e_nature_of_dev").val($(e.relatedTarget).data("nature_of_devt"));

                },
                error: function (xhr, status, error) {
                    console.error("Error fetching estate list:", error);
                },
                });  

                $.ajax({
                type: "POST",
                url: "rent_mgt_serv",
                data: {
                    request_type: "get_nature_of_instrument_list",
                },
                cache: false,
                success: function (jobdetails) {
                    const select = $("#rt_e_nature_of_instrument");
                    select.empty(); // Clear existing options
                    const json_p = JSON.parse(jobdetails);
                    $(json_p).each(function () {
                    select.append(
                        `<option value="${this.nt_name}">${this.nt_name}</option>`
                    );
                    });
                      $("#rt_e_nature_of_instrument").val($(e.relatedTarget).data("nature_of_instrument"));

                },
                error: function (xhr, status, error) {
                    console.error("Error fetching estate list:", error);
                },
                });  

        //$("#modal_label").text($(e.relatedTarget).data("modal_label"));
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


 $("#btn_process_rent_data_by_csv").click(function(event) {

           

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
                        url : "rent_mgt_serv",
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

        $('#transactionhistory').on('shown.bs.modal', (e) => {
            e.preventDefault();
            $("#rth_m_id").val($(e.relatedTarget).data("m_id"));
        });


        $("#rth_save_btn").click(function (e) {
            e.preventDefault(); // Prevent default form submission
    
            let isValid = true;
    
            // Array of required field IDs
            let requiredFields = [
                "#rth_lessee_name",
                "#rth_lessee_address",
                "#rth_mobile_phone_1",
                "#rth_plot_number",
                "#rth_plot_size",
                "#rth_nature_of_instrument",
                "#rth_term",
                //"#rth_consent_date",
            ];
    
            // Loop through required fields and validate
            requiredFields.forEach(function (field) {
                if ($(field).val().trim() === "") {
                    $(field).addClass("border-danger"); // Add red border
                    isValid = false;
                } else {
                    $(field).removeClass("border-danger"); // Remove red border if filled
                }
            });
    
            if (!isValid) {
                alert("Please fill all required fields.");
                return;
            }

            let m_id = $("#rth_m_idxxx").val();

             if (!m_id) {
               m_id=0
            }
    
            // Collect form data
            let formData = {
                rent_id: $("#rth_rent_id").val(),
                account_number: $("#rth_account_number").val(),
                lessee_name: $("#rth_lessee_name").val(),
                address: $("#rth_lessee_address").val(),
                mobile_1: $("#rth_mobile_phone_2").val(),
                mobile: $("#rth_mobile_phone_1").val(),
                email: $("#rth_email").val(),
                plot_number: $("#rth_plot_number").val(),
                plot_size: $("#rth_plot_size").val(),
                comm_date: $("#rth_comm_date").val(),
                nature_of_instrument: $("#rth_nature_of_instrument").val(),
                consent_date: $("#rth_consent_date").val(),
                term: $("#rth_term").val(),
                remarks: $("#rth_remarks").val(),
                m_id: m_id,
                request_type: 'add_update_rent_transaction_history'
            };
    
            // Send AJAX request
            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: formData,
                dataType: "json",
                success: function (response) {
                    //console.log(response)
                   // try {
                        const json_p = response;
                        if (json_p.success) {
                            $('#addtransactiondiv').collapse('hide');
                            document.getElementById("transactionhistoryForm").reset();
                            //$('#transactionhistory').modal('hide');
                            loadTransactionHistory(m_id)
                            $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">Data saved successfully.</span>' }, { type: 'success',z_index: 9999 });
                        } else {
                            $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Error occurred, try again.</span>' }, { type: 'danger',z_index: 9999 });
                        }
                    // } catch (e) {
                    //     console.error('Error parsing response:', e);
                    //     $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">An error occurred while processing the response.</span>' }, { type: 'danger',z_index: 9999 });
                    // }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX Error:', textStatus, errorThrown);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger',z_index: 9999 });
                }
            });
        });

        $("#btnAddTransaction").click(function (e) {
            e.preventDefault();
            var t_id = $("#rth_m_idxxx").val();
            var plot_number = $("#rth_plot_numberxxx").val();
            document.getElementById("transactionhistoryForm").reset();
            $("#rth_m_id").val(t_id);
              $("#rth_plot_number").val(plot_number);
            $("#rtModalLabelx").text("Add New Transaction");
            $("#addtransactionModal").modal();
        });
    
        // Remove red border when user starts typing
        $("input, select").on("input", function () {
            $(this).removeClass("border-danger");
        });

        window.loadTransactionHistory = function (m_id) {

            $("#rentTransactionhistory").modal();

            let v_m_id = m_id ?? $("#rth_m_id").val();

            console.log(m_id)

            if(v_m_id == 0) {

                var table = $('#tbl_rent_transaction_history');
                    table.find("tbody tr").remove();

                $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">No transaction found.</span>' }, { type: 'danger',z_index: 9999 });
                return;
            }

            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    m_id: v_m_id,
                    request_type: 'load_rent_transaction_history'
                },
                success: function (response) {
                    console.log(response)

                    var table = $('#tbl_rent_transaction_history');
                    table.find(
                                    "tbody tr")
                                    .remove();

                            // $("#result").text(data);
                            // alert(data);

                    var json_p = JSON.parse(response);

                    var table = $('#tbl_rent_transaction_history');
                    
                    $(json_p.data)
                            .each(
                                    function() {
                                        table
                                                .append("<tr><td>"
                                                        + this.plot_number
                                                        + "</td><td>"
                                                        + this.lessee_name
                                                        + "</td><td>"
                                                        + this.nature_of_instrument
                                                        + "</td><td>"
                                                        + this.consent_date
                                                        + "</td><td>"
                                                        + this.term
                                                        + "</td><td>"
                                                        +'<button class="btn btn-primary" type="button" onclick="getTransactionDetails('+this.id+')"><i class="fas fa-eye"></i></button>'
                                                        // +'<button class="btn btn-success" type="button" onclick="addNewTranscationHistory('+this.id+')"><i class="fas fa-plus"></i></button>'
                                                        +"</td>"
                                                        + "</tr>");
                                    });
                    
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX Error:', textStatus, errorThrown);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger',z_index: 9999 });
                }
            });
        }

        window.loadParcelTransaction = function (parcel_id) {


            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    parcel_id: parcel_id,
                    request_type: 'load_parcel_transaction_history'
                },
                success: function (response) {
                    console.log(response)

                    var table = $('#tbl_parcel_transaction_history');
                    table.find("tbody tr").remove();

                            // $("#result").text(data);
                            // alert(data);

                    var json_p = JSON.parse(response);

                    $("#rth_m_idxxx").val(json_p.data[0].rl_id);
                        $("#rth_plot_numberxxx").val(json_p.data[0].plot_number);
                    var table = $('#tbl_parcel_transaction_history');
                    
                    $(json_p.data)
                            .each(
                                    function() {
                                        table
                                                .append("<tr><td>"
                                                        + this.plot_number
                                                        + "</td><td>"
                                                        + this.owners_name
                                                        + "</td><td>"
                                                        + this.nature_of_instrument
                                                        + "</td><td>"
                                                        + this.consent_date
                                                        + "</td><td>"
                                                        + this.term
                                                        + "</td><td>"
                                                        // +'<button class="btn btn-primary" type="button" onclick="loadTransactionHistory('+this.rl_id+')"><i class="fas fa-eye"></i></button>'
                                                        // +'<button class="btn btn-success" type="button" onclick="addNewTranscationHistory('+this.rl_id+')"><i class="fas fa-plus"></i></button>'
                                                         +'<div class="dropdown">'
                            +'<button class="btn btn-danger dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                +'<i class="fas fa-info-circle"></i>'
                            +'</button>'
                            +'<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">'
                                +'<a class="dropdown-item viewLedgerBtn" href="#"' 
                                +'data-toggle="modal" data-target="#"'
                                +'data-modal_label="Edit Lessee"'
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
                                 +'<a class="dropdown-item" href="#" data-toggle="modal" data-m_id="'+this.rl_id+'" data-account_number="" data-target="#paymenthistory"><i class="fas fa-money-bill"></i> Payment History</a>'
                                +'<a class="dropdown-item" href="#"  data-m_id="'+this.rl_id+'" data-account_number="" onclick="loadTransactionHistory('+this.rl_id+')"><i class="fas fa-list"></i> Transaction History</a>'


                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#rentdocuments"'
                                +'data-rent_id="'+this.rl_id+'"'
                                +'data-account_number="'+this.account_number+'"'
                                +'data-file_number="'+this.file_number+'"'
                                +'data-email="'+this.email+'"'
                                +'><i class="fas fa-file-alt"></i>Documents</a>'

                                //  +'<a class="dropdown-item" href="#" data-toggle="modal" data-m_id="'+this.rl_id+'" data-account_number="" data-target="#rentdocuments"><i class="fas fa-file-alt"></i> Documents</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-m_id="'+this.rl_id+'" data-account_number="" data-target="#rentremarks"><i class="fas fa-list"></i> Remarks</a>'
                            +'</div>'
                            +'</div>'
                                                        +"</td>"
                                                        + "</tr>");
                                    });
                    
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX Error:', textStatus, errorThrown);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger',z_index: 9999 });
                }
            });
        }

        window.addNewTranscationHistory = function(t_id) {
            document.getElementById("transactionhistoryForm").reset();
            $("#rth_m_id").val(t_id);
            $("#rtModalLabelx").text("Add New Transaction");
            $("#addtransactionModal").modal();
        }

        window.getTransactionDetails = function (t_id) {

            $("#rth_m_id").val(t_id);

            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    t_id: t_id,
                    request_type: 'load_rent_transaction_history_details'
                },
                success: function (response) {
                   
                        var json_p = JSON.parse(response);
                        
                        if (json_p.success && json_p.data.length > 0) {
                            let data = json_p.data[0];
        
                            // Populate form fields with transaction details
                            $("#rth_rent_id").val(data.id);
                            $("#rth_account_number").val(data.account_number);
                            $("#rth_lessee_name").val(data.lessee_name);
                            $("#rth_lessee_address").val(data.address);
                            $("#rth_mobile_phone_1").val(data.mobile);
                            $("#rth_mobile_phone_2").val(data.mobile_1);
                            $("#rth_email").val(data.email);
                            $("#rth_plot_number").val(data.plot_number);
                            $("#rth_plot_size").val(data.plot_size);
                            $("#rth_comm_date").val(data.comm_date);
                            $("#rth_term").val(data.term);
                            $("#rth_nature_of_instrument").val(data.nature_of_instrument);
                            $("#rth_consent_date").val(data.consent_date);
                            $("#rth_remarks").val(data.remarks);
                            $("#rtModalLabelx").text("Edit Transaction");

                            loadTransactionHistory(data.m_id)

                            $('#addtransactionModal').modal('show');
        
                        }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", xhr.responseText);
                    $.notify({
                        message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Failed to fetch transaction details. Please try again.</span>'
                    }, {
                        type: 'danger',
                        z_index: 1051
                    });
                }
            });
        };

        $('#transactionhistory').on('hidden.bs.modal', (e) => {
            document.getElementById("transactionhistoryForm").reset();
            $('#addtransactiondiv').collapse('hide');

            var table = $('#tbl_rent_transaction_history');
            table.find(
                            "tbody tr")
                            .remove();
        });

        $('#rentdocuments').on('shown.bs.modal', (e) => {
            $("#file_upload_file_number_rent").val($(e.relatedTarget).data("file_number"));
console.log('you jiuue jjdhfj')

console.log($(e.relatedTarget).data("file_number"))
            var table = $('#lc_main_scanned_documents_dataTable');
            table.find(
                            "tbody tr")
                            .remove();
        });
        

        $('#rentremarks').on('hidden.bs.modal', (e) => {
            document.getElementById("transactionremarksForm").reset();
            $('#addremarkdiv').collapse('hide');

            var table = $('#tbl_rent_remarks');
            table.find(
                            "tbody tr")
                            .remove();
        });

        $('#rentremarks').on('shown.bs.modal', (e) => {
            e.preventDefault();
            $("#rnt_m_id").val($(e.relatedTarget).data("m_id"));
        });

        $("#submitRemark").click(function (e) {
            e.preventDefault(); // Prevent default form submission

            var remarks = $("#rnt_remarks").val();
            let m_id = $("#rnt_m_id").val(); 
            let id = $("#rnt_id").val(); 

            if(!remarks) {
                alert("Please fill the required field.");
                return;
            }

            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    m_id: m_id,
                    id: id,
                    remarks: remarks,
                    request_type: 'add_update_rent_transaction_remarks'
                },
                success: function (response) {
                    console.log(response);
                    const json_p = JSON.parse(response);
                    if (json_p.success) {
                        $('#addremarkdiv').collapse('hide');
                        document.getElementById("transactionremarksForm").reset();
                        //$('#transactionhistory').modal('hide');
                        loadTransactionRemarks(m_id)
                        $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">Data saved successfully.</span>' }, { type: 'success',z_index: 9999 });
                    } else {
                        $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Error occurred, try again.</span>' }, { type: 'danger',z_index: 9999 });
                    }
                }
            });
        });


        window.loadTransactionRemarks = function (m_id) {

            let v_m_id = m_id ?? $("#rnt_m_id").val();

            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    m_id: v_m_id,
                    request_type: 'load_rent_transaction_remarks'
                },
                success: function (response) {
                    //console.log(response)

                    var table = $('#tbl_rent_remarks');
                    table.find(
                                    "tbody tr")
                                    .remove();

                            // $("#result").text(data);
                            // alert(data);

                    var json_p = JSON.parse(response);

                    var table = $('#tbl_rent_remarks');
                    
                    $(json_p.data)
                            .each(
                                    function() {
                                        table
                                                .append("<tr><td>"
                                                        + this.remarks
                                                        + "</td><td>"
                                                        + this.created_by
                                                        + "</td><td>"
                                                        + this.created_at
                                                        + "</td><td>"
                                                        +'<button class="btn btn-primary" type="button"><i class="fas fa-edit" onclick="getTransactionRemarks('+this.id+')"></i></button>'
                                                        +"</td>"
                                                        + "</tr>");
                                    });
                    
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX Error:', textStatus, errorThrown);
                    $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger',z_index: 9999 });
                }
            });
        }

        window.getTransactionRemarks = function (r_id) {
            $.ajax({
                url: "rent_mgt_serv", // Change this to your Laravel/PHP route
                type: "POST",
                data: {
                    r_id: r_id,
                    request_type: 'load_rent_transaction_remarks_details'
                },
                success: function (response) {
                   
                        var json_p = JSON.parse(response);
                        
                        if (json_p.success && json_p.data.length > 0) {
                            let data = json_p.data[0];
        
                            // Populate form fields with transaction details
                            $("#rnt_id").val(data.id);
                            $("#rnt_m_id").val(data.m_id);
                            $("#rnt_remarks").val(data.remarks);

                            $('#addremarkdiv').collapse('show');
        
                        }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", xhr.responseText);
                    $.notify({
                        message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Failed to fetch transaction details. Please try again.</span>'
                    }, {
                        type: 'danger',
                        z_index: 1051
                    });
                }
            });
        };

});

