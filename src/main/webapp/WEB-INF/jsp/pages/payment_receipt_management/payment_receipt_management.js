$(document).ready(function() {

    var datatable = $("#tbl_payment_receipt_verification_table").DataTable({
        // responsive: true,
        stateSave : true,
        "createdRow" : function(row, data, dataIndex) {
        },
    });

    
    $('#btn_generate_rent_demand_note_').on('click', (e) => {
        //e.preventDefault();
      
        var rdn_rent_id = $('#rdn_rent_id').val();
        var rdn_account_number = $('#rdn_account_number').val();
       


        $.ajax({
            type: "POST",
            url: "GenerateCaseReports",
            target : '_blank',
            data: {
                request_type: 'request_to_generate_publication_list',
                publication_list: JSON.stringify(ordered),
                   to_email_address : send_to_address
                   
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

    

    $('#btn_search_for_bill_to_rectify').on('click', (e) => {
        e.preventDefault();

        var cbo_pr_search_by = $('#cbo_pr_search_by').val();
        var txt_pr_search_value = $('#txt_pr_search_value').val();

        if(!cbo_pr_search_by){
            $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
            return;
        }
        if(!txt_pr_search_value){
            $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
            return;
        }

        $.ajax({
            type : "POST",
            url : "payment_serv",
            data : {
                request_type : 'load_bill_by_ref_or_gog',
                search_by : cbo_pr_search_by,
                search_value : txt_pr_search_value
             
            },
            cache : false,
            beforeSend : function() {},
            success : function(response) {
                console.log(response);
                try{
                    var json_p = JSON.parse(response);

                    if(json_p.payment_data == null) {
                        $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">No data found.</span>' }, { type: 'danger' });
                        datatable.search("").draw();
                        datatable.state.clear();
                        datatable.clear();
                    }

                    datatable.search("").draw();
                    datatable.state.clear();
                    datatable.clear();

                    $(json_p.payment_data).each(function() {

                        const stringAmount = this.bill_amount;
                        const numberAmount = parseFloat(stringAmount);
                        const formattedAmount = numberAmount.toLocaleString('en-US', {
                            style: 'currency',
                            currency: 'GHS',
                        });

                        const pm_stringAmount = this.payment_amount;
                        const pm_numberAmount = parseFloat(pm_stringAmount);
                        const pm_formattedAmount = pm_numberAmount.toLocaleString('en-US', {
                            style: 'currency',
                            currency: 'GHS',
                        });

                        // const pm_stringAmount = this.payment_amount;
                        // var pm_formattedAmount ='0';
                        // if (pm_stringAmount != null && pm_stringAmount !== '') {
                        //     const pm_numberAmount = parseFloat(pm_stringAmount);
                        //     if (!isNaN(pm_numberAmount)) {
                        //          pm_formattedAmount = pm_numberAmount.toLocaleString('en-US', {
                        //             style: 'currency',
                        //             currency: 'GHS',
                        //         });
                        //         console.log(pm_formattedAmount); // Example usage
                        //     } else {
                        //         console.error('Invalid number format for payment amount.');
                        //     }
                        // } else {
                        //     console.warn('Payment amount is null or empty.');
                        // }

                       


                        datatable.row.add([
                            this.ref_number,
                            this.applicant_name,
                            this.bill_date,
                            ' <div class="text-right">'+formattedAmount+'</div>',
                            this.payment_date,
                            this.egcr_number,
                            ' <div class="text-right">'+pm_formattedAmount+'</div>',
                            this.gog_invoice_number,
                            '<div class="dropdown">'
                            +'<button class="btn btn-danger dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                +'<i class="fas fa-info-circle"></i>'
                            +'</button>'
                            +'<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">'
                                +'<a class="dropdown-item" href="#"' 
                                +'data-toggle="modal" data-target="#md_prm_payment_details"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                // +'data-location="'+this.location+'"'
                                // +'data-block="'+this.block+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                               // +'data-expiry_date="'+this.expiry_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                               // +'data-adjoining_plots="'+this.adjoining_plots+'"'
                                //+'data-original_use="'+this.original_use+'"'
                                +'data-created_date="'+this.created_date+'"'
                                //+'data-classification_of_arrears="'+this.classification_of_arrears+'"'
                                +'data-region_id="'+this.region_id+'"'
                                +'data-region_name="'+this.region_name+'"'
                                +'data-created_for="'+this.created_for+'"'
                                +'data-created_for_id="'+this.created_for_id+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                //+'data-last_review_date="'+this.last_review_date+'"'
                                //+'data-region_id="'+this.region_id+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                                +'data-modified_by="'+this.modified_by+'"'
                                +'><i class="fas fa-eye"></i> View Details</a>'
                               
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_check_and_pull_payment"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                               
                                +'><i class="fas fa-money-bill"></i> Check and Pull Payment</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_genarate_egcr_number"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                               
                                +'><i class="fas fa-money-bill"></i> Generate EGCR Number</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_egcr_pdf"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                               
                                +'><i class="fas fa-money-bill"></i> Generate EGCR PDF</a>'
                                //  +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#paymenthistory"><i class="fas fa-money-bill"></i> Generate EGCR</a>'
                                // +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_genarate_egcr_number"><i class="fas fa-list"></i> Generate EGCR Number</a>'
                                //  +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_egcr_pdf"><i class="fas fa-file-alt"></i> Generate EGCR PDF</a>'
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




    $('#btn_resolve_with_gog_invoice_number').on('click', (e) => {
        e.preventDefault();

      //  var cbo_pr_search_by = $('#cbo_pr_search_by').val();
      
      var txt_pr_invoice_number = $('#txt_pr_invoice_number').val();
      var txt_pr_ref_number = $('#txt_pr_ref_number').val();

        if(!txt_pr_invoice_number){
            $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
            return;
        }
        if(!txt_pr_ref_number){
            $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
            return;
        }

        $.ajax({
            type : "POST",
            url : "payment_serv",
            data : {
                request_type : 'check_gog_for_payment_by_ref_or_gog',
                search_by : 'check_gog_for_payment_by_ref_or_gog',
                invoice_number : txt_pr_invoice_number,
                ref_number : txt_pr_ref_number
             
            },
            cache : false,
            beforeSend : function() {},
            success : function(response) {
                console.log(response);
                try{
                    var json_p = JSON.parse(response);

                    if(json_p.payment_data == null) {
                        $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">No data found.</span>' }, { type: 'danger' });
                        datatable.search("").draw();
                        datatable.state.clear();
                        datatable.clear();
                    }

                    datatable.search("").draw();
                    datatable.state.clear();
                    datatable.clear();

                    $(json_p.payment_data).each(function() {

                        const stringAmount = this.bill_amount;
                        const numberAmount = parseFloat(stringAmount);
                        const formattedAmount = numberAmount.toLocaleString('en-US', {
                            style: 'currency',
                            currency: 'GHS',
                        });

                        const pm_stringAmount = this.payment_amount;
                        const pm_numberAmount = parseFloat(pm_stringAmount);
                        const pm_formattedAmount = pm_numberAmount.toLocaleString('en-US', {
                            style: 'currency',
                            currency: 'GHS',
                        });

                        // const pm_stringAmount = this.payment_amount;
                        // var pm_formattedAmount ='0';
                        // if (pm_stringAmount != null && pm_stringAmount !== '') {
                        //     const pm_numberAmount = parseFloat(pm_stringAmount);
                        //     if (!isNaN(pm_numberAmount)) {
                        //          pm_formattedAmount = pm_numberAmount.toLocaleString('en-US', {
                        //             style: 'currency',
                        //             currency: 'GHS',
                        //         });
                        //         console.log(pm_formattedAmount); // Example usage
                        //     } else {
                        //         console.error('Invalid number format for payment amount.');
                        //     }
                        // } else {
                        //     console.warn('Payment amount is null or empty.');
                        // }

                       


                        datatable.row.add([
                            this.ref_number,
                            this.applicant_name,
                            this.bill_date,
                            ' <div class="text-right">'+formattedAmount+'</div>',
                            this.payment_date,
                            this.egcr_number,
                            ' <div class="text-right">'+pm_formattedAmount+'</div>',
                            this.gog_invoice_number,
                            '<div class="dropdown">'
                            +'<button class="btn btn-danger dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                +'<i class="fas fa-info-circle"></i>'
                            +'</button>'
                            +'<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">'
                                +'<a class="dropdown-item" href="#"' 
                                +'data-toggle="modal" data-target="#md_prm_payment_details"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                // +'data-location="'+this.location+'"'
                                // +'data-block="'+this.block+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                               // +'data-expiry_date="'+this.expiry_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                               // +'data-adjoining_plots="'+this.adjoining_plots+'"'
                                //+'data-original_use="'+this.original_use+'"'
                                +'data-created_date="'+this.created_date+'"'
                                //+'data-classification_of_arrears="'+this.classification_of_arrears+'"'
                                +'data-region_id="'+this.region_id+'"'
                                +'data-region_name="'+this.region_name+'"'
                                +'data-created_for="'+this.created_for+'"'
                                +'data-created_for_id="'+this.created_for_id+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                //+'data-last_review_date="'+this.last_review_date+'"'
                                //+'data-region_id="'+this.region_id+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                                +'data-modified_by="'+this.modified_by+'"'
                                +'><i class="fas fa-eye"></i> View Details</a>'
                               
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_check_and_pull_payment"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                               
                                +'><i class="fas fa-money-bill"></i> Check and Pull Payment</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_genarate_egcr_number"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                               
                                +'><i class="fas fa-money-bill"></i> Generate EGCR Number</a>'
                                +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_egcr_pdf"'
                                +'data-pt_id="'+this.pt_id+'"'
                                +'data-applicant_name="'+this.applicant_name+'"'
                                +'data-applicant_phone_number="'+this.applicant_phone_number+'"'
                                +'data-applicant_email="'+this.applicant_email+'"'
                                +'data-ref_number="'+this.ref_number+'"'
                                +'data-bill_date="'+this.bill_date+'"'
                                +'data-bill_amount="'+this.bill_amount+'"'
                                +'data-is_payment_made="'+this.is_payment_made+'"'
                                +'data-payment_date="'+this.payment_date+'"'
                                +'data-payment_confiration_status="'+this.payment_confiration_status+'"'
                                +'data-payment_bank_branch="'+this.payment_bank_branch+'"'
                                +'data-payment_bank="'+this.payment_bank+'"'
                                +'data-payment_status="'+this.payment_status+'"'
                                +'data-payment_mode="'+this.payment_mode+'"'
                                +'data-payment_remarks="'+this.payment_remarks+'"'
                                +'data-payment_amount="'+this.payment_amount+'"'
                                +'data-is_egcr_issued="'+this.is_egcr_issued+'"'
                                +'data-egcr_issued_date="'+this.egcr_issued_date+'"'
                                +'data-egcr_number="'+this.egcr_number+'"'
                                +'data-submission_type="'+this.submission_type+'"'
                                +'data-business_process_sub_name="'+this.business_process_sub_name+'"'
                                +'data-business_process_name="'+this.business_process_name+'"'
                                +'data-created_by="'+this.created_by+'"'
                                +'data-gog_checkout_url="'+this.gog_checkout_url+'"'
                                +'data-gog_invoice_number="'+this.gog_invoice_number+'"'
                               
                                +'><i class="fas fa-money-bill"></i> Generate EGCR PDF</a>'
                                //  +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#paymenthistory"><i class="fas fa-money-bill"></i> Generate EGCR</a>'
                                // +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_genarate_egcr_number"><i class="fas fa-list"></i> Generate EGCR Number</a>'
                                //  +'<a class="dropdown-item" href="#" data-toggle="modal" data-target="#md_prm_egcr_pdf"><i class="fas fa-file-alt"></i> Generate EGCR PDF</a>'
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


    


    $('#md_prm_payment_details').on('shown.bs.modal', (e) => {
        $("#prm_pd_pt_id").val($(e.relatedTarget).data("pt_id"));
        $("#prm_pd_applicant_name").val($(e.relatedTarget).data("applicant_name"));
        $("#prm_pd_applicant_email").val($(e.relatedTarget).data("applicant_email"));
        $("#prm_pd_applicant_phone_number").val($(e.relatedTarget).data("applicant_phone_number"));
        $("#prm_pd_ref_number").val($(e.relatedTarget).data("ref_number"));
        $("#prm_pd_bill_date").val($(e.relatedTarget).data("bill_date"));
        $("#prm_pd_bill_amount").val($(e.relatedTarget).data("bill_amount"));
        $("#prm_pd_is_payment_made").val($(e.relatedTarget).data("is_payment_made"));
        $("#prm_pd_payment_date").val($(e.relatedTarget).data("payment_date"));
        $("#prm_pd_payment_confiration_status").val($(e.relatedTarget).data("payment_confiration_status"));
        $("#prm_pd_payment_bank_branch").val($(e.relatedTarget).data("payment_bank_branch"));
        $("#prm_pd_payment_bank").val($(e.relatedTarget).data("payment_bank"));
        $("#prm_pd_payment_status").val($(e.relatedTarget).data("payment_status"));
        $("#prm_pd_payment_mode").val($(e.relatedTarget).data("payment_mode"));
        $("#prm_pd_payment_remarks").val($(e.relatedTarget).data("payment_remarks"));
        $("#prm_pd_payment_amount").val($(e.relatedTarget).data("payment_amount"));
        $("#prm_pd_is_egcr_issued").val($(e.relatedTarget).data("is_egcr_issued"));
        $("#prm_pd_egcr_issued_date").val($(e.relatedTarget).data("egcr_issued_date"));
        $("#prm_pd_egcr_number").val($(e.relatedTarget).data("egcr_number"));
        $("#prm_pd_submission_type").val($(e.relatedTarget).data("submission_type"));
        $("#prm_pd_business_process_sub_name").val($(e.relatedTarget).data("business_process_sub_name"));
        $("#prm_pd_business_process_name").val($(e.relatedTarget).data("business_process_name"));
        $("#prm_pd_created_by").val($(e.relatedTarget).data("created_by"));
        $("#prm_pd_gog_checkout_url").val($(e.relatedTarget).data("gog_checkout_url"));
        $("#prm_pd_gog_invoice_number").val($(e.relatedTarget).data("gog_invoice_number"));

    });


    $('#md_prm_check_and_pull_payment').on('shown.bs.modal', (e) => {
        $("#prm_cpp_pt_id").val($(e.relatedTarget).data("pt_id"));
        $("#prm_cpp_applicant_name").val($(e.relatedTarget).data("applicant_name"));
        $("#prm_cpp_applicant_email").val($(e.relatedTarget).data("applicant_email"));
        $("#prm_cpp_applicant_phone_number").val($(e.relatedTarget).data("applicant_phone_number"));
        $("#prm_cpp_ref_number").val($(e.relatedTarget).data("ref_number"));
        $("#prm_cpp_bill_date").val($(e.relatedTarget).data("bill_date"));
        $("#prm_cpp_bill_amount").val($(e.relatedTarget).data("bill_amount"));
        $("#prm_cpp_is_payment_made").val($(e.relatedTarget).data("is_payment_made"));
        $("#prm_cpp_payment_date").val($(e.relatedTarget).data("payment_date"));
        $("#prm_cpp_payment_confiration_status").val($(e.relatedTarget).data("payment_confiration_status"));
        $("#prm_cpp_payment_bank_branch").val($(e.relatedTarget).data("payment_bank_branch"));
        $("#prm_cpp_payment_bank").val($(e.relatedTarget).data("payment_bank"));
        $("#prm_cpp_payment_status").val($(e.relatedTarget).data("payment_status"));
        $("#prm_cpp_payment_mode").val($(e.relatedTarget).data("payment_mode"));
        $("#prm_cpp_payment_remarks").val($(e.relatedTarget).data("payment_remarks"));
        $("#prm_cpp_payment_amount").val($(e.relatedTarget).data("payment_amount"));
        $("#prm_cpp_is_egcr_issued").val($(e.relatedTarget).data("is_egcr_issued"));
        $("#prm_cpp_egcr_issued_date").val($(e.relatedTarget).data("egcr_issued_date"));
        $("#prm_cpp_egcr_number").val($(e.relatedTarget).data("egcr_number"));
        $("#prm_cpp_submission_type").val($(e.relatedTarget).data("submission_type"));
        $("#prm_cpp_business_process_sub_name").val($(e.relatedTarget).data("business_process_sub_name"));
        $("#prm_cpp_business_process_name").val($(e.relatedTarget).data("business_process_name"));
        $("#prm_cpp_created_by").val($(e.relatedTarget).data("created_by"));
        $("#prm_cpp_gog_checkout_url").val($(e.relatedTarget).data("gog_checkout_url"));
        $("#prm_cpp_gog_invoice_number").val($(e.relatedTarget).data("gog_invoice_number"));

    });


    $('#md_prm_genarate_egcr_number').on('shown.bs.modal', (e) => {
        $("#prm_gen_pt_id").val($(e.relatedTarget).data("pt_id"));
        $("#prm_gen_applicant_name").val($(e.relatedTarget).data("applicant_name"));
        $("#prm_gen_applicant_email").val($(e.relatedTarget).data("applicant_email"));
        $("#prm_gen_applicant_phone_number").val($(e.relatedTarget).data("applicant_phone_number"));
        $("#prm_gen_ref_number").val($(e.relatedTarget).data("ref_number"));
        $("#prm_gen_bill_date").val($(e.relatedTarget).data("bill_date"));
        $("#prm_gen_bill_amount").val($(e.relatedTarget).data("bill_amount"));
        $("#prm_gen_is_payment_made").val($(e.relatedTarget).data("is_payment_made"));
        $("#prm_gen_payment_date").val($(e.relatedTarget).data("payment_date"));
        $("#prm_gen_payment_confiration_status").val($(e.relatedTarget).data("payment_confiration_status"));
        $("#prm_gen_payment_bank_branch").val($(e.relatedTarget).data("payment_bank_branch"));
        $("#prm_gen_payment_bank").val($(e.relatedTarget).data("payment_bank"));
        $("#prm_gen_payment_status").val($(e.relatedTarget).data("payment_status"));
        $("#prm_gen_payment_mode").val($(e.relatedTarget).data("payment_mode"));
        $("#prm_gen_payment_remarks").val($(e.relatedTarget).data("payment_remarks"));
        $("#prm_gen_payment_amount").val($(e.relatedTarget).data("payment_amount"));
        $("#prm_gen_is_egcr_issued").val($(e.relatedTarget).data("is_egcr_issued"));
        $("#prm_gen_egcr_issued_date").val($(e.relatedTarget).data("egcr_issued_date"));
        $("#prm_gen_egcr_number").val($(e.relatedTarget).data("egcr_number"));
        $("#prm_gen_submission_type").val($(e.relatedTarget).data("submission_type"));
        $("#prm_gen_business_process_sub_name").val($(e.relatedTarget).data("business_process_sub_name"));
        $("#prm_gen_business_process_name").val($(e.relatedTarget).data("business_process_name"));
        $("#prm_gen_created_by").val($(e.relatedTarget).data("created_by"));
        $("#prm_gen_gog_checkout_url").val($(e.relatedTarget).data("gog_checkout_url"));
        $("#prm_gen_gog_invoice_number").val($(e.relatedTarget).data("gog_invoice_number"));

    });


    $('#md_prm_egcr_pdf').on('shown.bs.modal', (e) => {
        $("#prm_gpdf_pt_id").val($(e.relatedTarget).data("pt_id"));
        $("#prm_gpdf_applicant_name").val($(e.relatedTarget).data("applicant_name"));
        $("#prm_gpdf_applicant_email").val($(e.relatedTarget).data("applicant_email"));
        $("#prm_gpdf_applicant_phone_number").val($(e.relatedTarget).data("applicant_phone_number"));
        $("#prm_gpdf_ref_number").val($(e.relatedTarget).data("ref_number"));
        $("#prm_gpdf_bill_date").val($(e.relatedTarget).data("bill_date"));
        $("#prm_gpdf_bill_amount").val($(e.relatedTarget).data("bill_amount"));
        $("#prm_gpdf_is_payment_made").val($(e.relatedTarget).data("is_payment_made"));
        $("#prm_gpdf_payment_date").val($(e.relatedTarget).data("payment_date"));
        $("#prm_gpdf_payment_confiration_status").val($(e.relatedTarget).data("payment_confiration_status"));
        $("#prm_gpdf_payment_bank_branch").val($(e.relatedTarget).data("payment_bank_branch"));
        $("#prm_gpdf_payment_bank").val($(e.relatedTarget).data("payment_bank"));
        $("#prm_gpdf_payment_status").val($(e.relatedTarget).data("payment_status"));
        $("#prm_gpdf_payment_mode").val($(e.relatedTarget).data("payment_mode"));
        $("#prm_gpdf_payment_remarks").val($(e.relatedTarget).data("payment_remarks"));
        $("#prm_gpdf_payment_amount").val($(e.relatedTarget).data("payment_amount"));
        $("#prm_gpdf_is_egcr_issued").val($(e.relatedTarget).data("is_egcr_issued"));
        $("#prm_gpdf_egcr_issued_date").val($(e.relatedTarget).data("egcr_issued_date"));
        $("#prm_gpdf_egcr_number").val($(e.relatedTarget).data("egcr_number"));
        $("#prm_gpdf_submission_type").val($(e.relatedTarget).data("submission_type"));
        $("#prm_gpdf_business_process_sub_name").val($(e.relatedTarget).data("business_process_sub_name"));
        $("#prm_gpdf_business_process_name").val($(e.relatedTarget).data("business_process_name"));
        $("#prm_gpdf_created_by").val($(e.relatedTarget).data("created_by"));
        $("#prm_gpdf_gog_checkout_url").val($(e.relatedTarget).data("gog_checkout_url"));
        $("#prm_gpdf_gog_invoice_number").val($(e.relatedTarget).data("gog_invoice_number"));

    });




});

