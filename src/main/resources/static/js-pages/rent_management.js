$(document).ready(function() {

    setTimeout(function() {
        window.initializeTooltips();
    }, 50);

    var datatable = $("#tbl_rent_records").DataTable({
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

            $('#div_rent_estate').addClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');
            $('#div_certificate_rmap_search').addClass('d-none');
            $('#div_btn_rmap_search').addClass('d-none');

        } else if(rts_select_type == 'Estate'){

            $('#div_rent_estate').removeClass('d-none');
            $('#div_rent_keyword').addClass('d-none');
            $('#div_certificate_rmap_search').addClass('d-none');
            $('#div_btn_rmap_search').addClass('d-none');
            
        } else if(rts_select_type == 'Name of Leasee/Assignee'){

            $('#div_rent_estate').addClass('d-none');
            $('#div_rent_keyword').removeClass('d-none');
            $('#div_certificate_rmap_search').addClass('d-none');
            $('#div_btn_rmap_search').addClass('d-none');
            
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
                    //$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">An error occurred while processing the response.</span>' }, { type: 'danger' });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX Error:', textStatus, errorThrown);
                //$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger' });
            }
        });

    })


    
    $('#btn_generate_rent_demand_note').on('click', (e) => {
    e.preventDefault();
    
    var rdn_rent_id = $('#rdn_rent_id').val();
    var rdn_account_number = $('#rdn_account_number').val();
    var rdn_leasee_name = $('#rdn_leasee_name').val();
    var rdn_plot_number = $('#rdn_plot_number').val() || 'N/A';
    var rdn_estate = $('#rdn_estate').val() || 'N/A';
    
    // Validate required fields
    if (!rdn_rent_id || rdn_rent_id === '0') {
        Swal.fire({
            icon: 'warning',
            title: 'Missing Information',
            text: 'Please select a valid lease record to generate demand notice.',
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'OK'
        });
        return;
    }
    
    if (!rdn_leasee_name) {
        Swal.fire({
            icon: 'warning',
            title: 'Missing Information',
            text: 'Please enter the lessee name.',
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'OK'
        });
        return;
    }
    
    // Show confirmation dialog
    Swal.fire({
        title: 'Generate Rent Demand Notice',
        html: `
            <div class="text-start">
                <p class="mb-3">Are you sure you want to generate a rent demand notice?</p>
                
                <div class="alert alert-info py-2 mb-3">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-user-circle fa-lg me-3"></i>
                        <div>
                            <div class="fw-bold">${rdn_leasee_name}</div>
                            <small class="text-muted">
                                <i class="fas fa-hashtag me-1"></i>Plot: ${rdn_plot_number} | 
                                <i class="fas fa-warehouse me-1 ms-2"></i>Estate: ${rdn_estate}
                            </small>
                        </div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <table class="table table-sm table-bordered bg-light">
                        <tbody>
                            <!--<tr>
                                <td class="fw-semibold" style="width: 40%">Lease ID:</td>
                                <td>${rdn_rent_id}</td>
                            </tr>-->
                            <tr>
                                <td class="fw-semibold">Account Number:</td>
                                <td>${rdn_account_number || 'N/A'}</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">Generation Type:</td>
                                <td>
                                    <span class="badge bg-primary">Single Assessment</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="confirmGeneration">
                    <label class="form-check-label" for="confirmGeneration">
                        I confirm all details are correct
                    </label>
                </div>
                
                <div class="text-muted small">
                    <i class="fas fa-info-circle me-1"></i>
                    This will calculate rent assessments based on current rates and outstanding amounts.
                </div>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#198754',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-cogs me-1"></i> Generate Now',
        cancelButtonText: '<i class="fas fa-times me-1"></i> Cancel',
        showLoaderOnConfirm: true,
        preConfirm: () => {
            const checkbox = document.getElementById('confirmGeneration');
            if (!checkbox.checked) {
                Swal.showValidationMessage('Please confirm that all details are correct');
                return false;
            }
            return true;
        },
        allowOutsideClick: () => !Swal.isLoading(),
        width: '500px'
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading animation
            let timerInterval;
            Swal.fire({
                title: 'Generating Demand Notice',
                html: `
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="fas fa-file-invoice-dollar fa-spin fa-2x text-primary"></i>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar progress-bar-striped progress-bar-animated" 
                                 role="progressbar" style="width: 0%"></div>
                        </div>
                        <p class="mt-2 mb-0 text-muted" id="swal-progress-text">Calculating assessments...</p>
                    </div>
                `,
                allowOutsideClick: false,
                didOpen: () => {
                    const progressBar = Swal.getHtmlContainer().querySelector('.progress-bar');
                    const progressText = Swal.getHtmlContainer().querySelector('#swal-progress-text');
                    let progress = 0;
                    
                    timerInterval = setInterval(() => {
                        progress += 10;
                        if (progress <= 80) {
                            progressBar.style.width = `${progress}%`;
                            if (progress < 30) {
                                progressText.textContent = 'Calculating assessments...';
                            } else if (progress < 60) {
                                progressText.textContent = 'Applying rates and charges...';
                            } else {
                                progressText.textContent = 'Finalizing calculations...';
                            }
                        }
                    }, 300);
                },
                willClose: () => {
                    clearInterval(timerInterval);
                }
            });
            
            // Disable generate button during processing
            $('#btn_generate_rent_demand_note').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i> Generating...');
            
            // Make AJAX request
            $.ajax({
                type: "POST",
                url: "rent_mgt_serv",
                data: {
                    request_type: 'select_prepare_rent_demand_notice_single',
                    rdn_rent_id: rdn_rent_id,
                    rdn_account_number: rdn_account_number
                },
                cache: false,
                success: function(jobdetails) {
                    Swal.close();
                    
                    try {
                        var json_p = JSON.parse(jobdetails);
                        var table = $('#tbl_rent_assessment_details');
                        
                        // Clear existing rows
                        table.find("tbody tr").remove();
                        
                        // Check if we have data
                        if (!json_p.rent_assessment || json_p.rent_assessment.length === 0) {
                            // Show empty state
                            table.find('tbody').append(`
                                <tr id="noAssessmentData">
                                    <td colspan="6" class="text-center py-5">
                                        <div class="text-muted">
                                            <i class="fas fa-exclamation-circle fa-2x mb-3"></i>
                                            <p class="mb-2 fw-semibold">No Assessment Data Available</p>
                                            <small>No rent assessments found for this period</small>
                                        </div>
                                    </td>
                                </tr>
                            `);
                            
                            Swal.fire({
                                icon: 'info',
                                title: 'No Assessments Found',
                                text: 'No rent assessments were generated for this period.',
                                confirmButtonColor: '#3085d6'
                            });
                        } else {
                            // Calculate total amount
                            let totalAmount = 0;
                            
                            // Populate table with data
                            $(json_p.rent_assessment).each(function (index) {
                                const amountAssessed = parseFloat(this.rc_amount_assessed || 0);
                                totalAmount += amountAssessed;
                                
                                const row = `
                                    <tr>
                                        <td class="text-center">
                                            <span class="fw-semibold">${this.rc_period || 'N/A'}</span>
                                        </td>
                                        <td class="text-end">
                                            ${this.rc_amount_of_one_cedi || '0.00'}
                                        </td>
                                        <td class="text-end">
                                            ${this.rc_amount_of_one_cedi_pa || '0.00'}
                                        </td>
                                        <td class="text-end fw-semibold">
                                            ${parseFloat(this.rc_annual_rent || 0).toFixed(2)}
                                        </td>
                                        <td class="text-end fw-bold text-primary">
                                            ${amountAssessed.toFixed(2)}
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="fas fa-file-alt text-secondary me-2"></i>
                                                <span>${this.rc_description || 'Rent Assessment'}</span>
                                            </div>
                                        </td>
                                    </tr>
                                `;

                                $('#assessmentCount').text(json_p.rent_assessment.length + ' Items');
                                
                                table.find('tbody').append(row);
                            });
                            
                            // Add total row if we have data
                            if (json_p.rent_assessment.length > 0) {
                                table.find('tbody').append(`
                                    <tr class="table-light">
                                        <td colspan="4" class="text-end fw-bold">Total Amount Due:</td>
                                        <td colspan="2" class="text-start fw-bold text-success">
                                            GHS ${totalAmount.toFixed(2)}
                                        </td>
                                    </tr>
                                `);
                            }
                            
                            // Show success message with options
                            Swal.fire({
                                title: 'Demand Notice Generated!',
                                html: `
                                    <div class="text-center">
                                        <div class="mb-3">
                                            <i class="fas fa-check-circle fa-3x text-success"></i>
                                        </div>
                                        <p class="mb-2"><strong>Rent demand notice generated successfully!</strong></p>
                                        <div class="alert alert-success py-2">
                                            <small>
                                                <i class="fas fa-calculator me-1"></i>
                                                Generated ${json_p.rent_assessment.length} assessment(s) for ${rdn_leasee_name}
                                            </small>
                                        </div>
                                        <div class="alert alert-info py-2">
                                            <small>
                                                <i class="fas fa-money-bill-wave me-1"></i>
                                                Total Amount Due: <strong>GHS ${totalAmount.toFixed(2)}</strong>
                                            </small>
                                        </div>
                                    </div>
                                `,
                                showCancelButton: true,
                                confirmButtonColor: '#198754',
                                cancelButtonColor: '#6c757d',
                                confirmButtonText: '<i class="fas fa-print me-1"></i> View & Print',
                                cancelButtonText: '<i class="fas fa-eye me-1"></i> View Details',
                                //showDenyButton: true,
                                //denyButtonText: '<i class="fas fa-envelope me-1"></i> Send Email',
                                //denyButtonColor: '#0d6efd',
                                width: '500px'
                            }).then((result) => {
                                // Enable print button if exists
                                $('#btn_print_rent_demand_note').prop('disabled', false);
                                
                                if (result.isConfirmed) {
                                    // Generate print/PDF view
                                    generatePrintView(rdn_rent_id, rdn_account_number);
                                } else if (result.isDenied) {
                                    // Send email
                                    const email = $('#rdn_email').val();
                                    if (email) {
                                        sendDemandNoticeEmail(email, rdn_leasee_name, rdn_rent_id);
                                    } else {
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'Email Required',
                                            text: 'Please enter an email address to send the demand notice.',
                                            confirmButtonColor: '#3085d6'
                                        });
                                    }
                                }
                                // If cancelled (view details), just keep modal open
                            });
                        }
                        
                        // Update generation info
                        if (json_p.generation_date) {
                            $('#generationDate').text(json_p.generation_date);
                        }
                        
                        if (json_p.assessment_period) {
                            $('#assessmentPeriod').text(json_p.assessment_period);
                        }
                        
                        // Show summary if it exists
                        if (json_p.summary) {
                            $('#assessmentSummary').show();
                        }
                        
                    } catch (e) {
                        console.error('Error parsing response:', e);
                        Swal.fire({
                            icon: 'error',
                            title: 'Data Error',
                            text: 'Failed to parse server response. Please try again.',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    Swal.close();
                    console.error('AJAX Error:', error);
                    
                    let errorMessage = 'Failed to generate demand notice. ';
                    if (xhr.status === 0) {
                        errorMessage += 'No network connection.';
                    } else if (xhr.status === 404) {
                        errorMessage += 'Server endpoint not found.';
                    } else if (xhr.status === 500) {
                        errorMessage += 'Server error. Please try again later.';
                    } else {
                        errorMessage += 'Please check your connection.';
                    }
                    
                    Swal.fire({
                        icon: 'error',
                        title: 'Generation Failed',
                        html: `
                            <div class="text-start">
                                <p class="mb-2">${errorMessage}</p>
                                <div class="alert alert-danger py-2 mt-2">
                                    <small>
                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                        <strong>Error Details:</strong> ${error}
                                    </small>
                                </div>
                                <div class="mt-3">
                                    <button class="btn btn-sm btn-outline-primary" onclick="retryDemandNoticeGeneration()">
                                        <i class="fas fa-redo me-1"></i> Retry
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary ms-2" onclick="Swal.close()">
                                        <i class="fas fa-times me-1"></i> Cancel
                                    </button>
                                </div>
                            </div>
                        `,
                        confirmButtonText: 'OK',
                        showConfirmButton: false,
                        width: '500px'
                    });
                },
                complete: function() {
                    // Re-enable generate button
                    $('#btn_generate_rent_demand_note').prop('disabled', false).html('<i class="fas fa-cogs me-2"></i> Generate Rent Demand Notice');
                }
            });
        }
    });
});

// Function to retry demand notice generation
function retryDemandNoticeGeneration() {
    Swal.close();
    setTimeout(() => {
        $('#btn_generate_rent_demand_note').click();
    }, 500);
}

// Function to generate print view
function generatePrintView(rentId, accountNumber) {
    // Show loading for print generation
    Swal.fire({
        title: 'Preparing Print Preview',
        html: `
            <div class="text-center">
                <div class="mb-3">
                    <i class="fas fa-print fa-spin fa-2x text-primary"></i>
                </div>
                <p class="mb-0 text-muted">Generating printable demand notice...</p>
            </div>
        `,
        allowOutsideClick: false,
        showConfirmButton: false
    });
    
    // Make AJAX request for print
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: {
            request_type: 'print_rent_demand_notice',
            rdn_rent_id: rentId,
            rdn_account_number: accountNumber
        },
        cache: false,
        xhrFields : {
            responseType : 'blob'
        },
        beforeSend: function () { 
            showLoadingIndicator();
        },
        success: function(pdfBlob) {
            Swal.close();
            
            const file = new File([pdfBlob], `Demand Notice_${accountNumber}.pdf`, {
                type: "application/pdf",
                lastModified: Date.now()
            });
                
            // Create object URL
            const fileURL = URL.createObjectURL(file);
                
            // Open PDF in modal
            openPDFModal(file, fileURL);
                
            // Hide loading indicator
            hideLoadingIndicator();
        },
        error: function(xhr, status, error) {
            Swal.close();
            Swal.fire({
                icon: 'error',
                title: 'Connection Error',
                text: 'Failed to generate print preview. Please try again.',
                confirmButtonColor: '#dc3545'
            });
        }
    });
}

// Function to send demand notice email
function sendDemandNoticeEmail(email, lesseeName, rentId) {
    Swal.fire({
        title: 'Send Demand Notice',
        html: `
            <div class="text-start">
                <p>Send rent demand notice to <strong>${lesseeName}</strong>?</p>
                <div class="alert alert-info py-2">
                    <small>
                        <i class="fas fa-envelope me-1"></i>
                        Email: <strong>${email}</strong>
                    </small>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="includeAttachment">
                    <label class="form-check-label" for="includeAttachment">
                        Include PDF attachment
                    </label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="sendCopyToAdmin">
                    <label class="form-check-label" for="sendCopyToAdmin">
                        Send copy to admin
                    </label>
                </div>
                <div class="text-muted small">
                    <i class="fas fa-info-circle me-1"></i>
                    An email with the demand notice details will be sent immediately.
                </div>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#198754',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-paper-plane me-1"></i> Send Now',
        cancelButtonText: 'Cancel',
        showLoaderOnConfirm: true,
        preConfirm: () => {
            const includeAttachment = $('#includeAttachment').is(':checked');
            const sendCopyToAdmin = $('#sendCopyToAdmin').is(':checked');
            
            return $.ajax({
                type: "POST",
                url: "rent_mgt_serv",
                data: {
                    request_type: 'send_demand_notice_email',
                    rent_id: rentId,
                    email: email,
                    include_attachment: includeAttachment ? '1' : '0',
                    send_copy_to_admin: sendCopyToAdmin ? '1' : '0'
                }
            }).then(response => {
                try {
                    const result = JSON.parse(response);
                    return result;
                } catch (e) {
                    throw new Error('Invalid server response');
                }
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed && result.value) {
            if (result.value.success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Email Sent!',
                    html: `
                        <div class="text-center">
                            <div class="mb-3">
                                <i class="fas fa-paper-plane fa-3x text-success"></i>
                            </div>
                            <p class="mb-2">Demand notice has been sent successfully!</p>
                            <div class="alert alert-success py-2">
                                <small>
                                    <i class="fas fa-envelope me-1"></i>
                                    Sent to: <strong>${email}</strong>
                                </small>
                            </div>
                        </div>
                    `,
                    confirmButtonColor: '#198754'
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Send Failed',
                    text: result.value.message || 'Failed to send email.',
                    confirmButtonColor: '#dc3545'
                });
            }
        }
    });
}

// Add CSS for progress animation
if (!$('#demand-notice-styles').length) {
    const style = document.createElement('style');
    style.id = 'demand-notice-styles';
    style.textContent = `
        .swal2-popup .progress {
            background-color: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .swal2-popup .progress-bar {
            background-color: #0d6efd;
            transition: width 0.3s ease;
        }
        
        #tbl_rent_assessment_details tbody tr {
            transition: all 0.2s ease;
        }
        
        #tbl_rent_assessment_details tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.05);
            transform: translateX(2px);
        }
        
        #btn_generate_rent_demand_note:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }
    `;
    document.head.appendChild(style);
}

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
            beforeSend: function () { 
                 showLoadingIndicator();
            },
            success: function(pdfBlob) {
            //     //console.log(data)
                 
                
            //     //$('#elisDocumentPreview').modal({backdrop: 'static',});
            //         $('#elisDocumentPreview').modal('show');
            //        // console.log("pdf blob sdata");
            //         //console.log(data);
            //        var blob = new Blob(
            //                [ data ],
            //                {
            //                    type : "application/pdf"
            //                });
            //    var objectUrl = URL
            //                .createObjectURL(blob);
            //        // window.open(objectUrl);
            //    ///	console.log("success ajax");

            //     $('#elisdovumentpreviewblobfile').attr('src',objectUrl);
                   
                const file = new File([pdfBlob], `Demand Notice_${rdn_account_number}.pdf`, {
                    type: "application/pdf",
                    lastModified: Date.now()
                });
                
                // Create object URL
                const fileURL = URL.createObjectURL(file);
                
                // Open PDF in modal
                openPDFModal(file, fileURL);
                
                // Hide loading indicator
                hideLoadingIndicator();
                   
                 
            },
            complete: function(){
                //console.log("Completed ajax");

              }
            });
          

    })

    // Function to open PDF modal
    function openPDFModal(file, fileURL) {
        // Create modal HTML
        const modalHTML = `
            <div class="modal fade effect-fade modal-blur" id="pdfViewerModal" tabindex="-1" aria-labelledby="pdfViewerModalLabel" aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered modal-xl">
                    <div class="modal-content">
                        <div class="modal-header d-flex justify-content-between">
                            <h6 class="modal-title" id="pdfViewerModalLabel">
                                <i class="fas fa-file-pdf me-2"></i>
                                ${file.name}
                            </h6>
                            <div>
                                <span class="badge bg-light text-dark ms-2">${formatFileSize(file.size)}</span>
                                <button type="button" class="btn btn-sm btn-outline-light me-2" id="btnDownloadPDF">
                                    <i class="fas fa-download me-1"></i>Download
                                </button>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                        </div>
                        <div class="modal-body p-0" style="min-height: 70vh;">
                            <div id="pdfViewerContainer">
                                <!--<div id="pdfLoading" class="d-flex flex-column align-items-center justify-content-center h-100 p-5">
                                    <div class="spinner-border text-primary mb-3" role="status">
                                        <span class="visually-hidden">Loading PDF...</span>
                                    </div>
                                    <p class="text-muted">Loading PDF document...</p>
                                </div>-->
                                <div id="pdfViewer" style="display: none;">
                                    <div class="pdf-toolbar bg-light p-2 border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <button class="btn btn-sm btn-outline-dark me-2" id="btnPrevPage">
                                                    <i class="fas fa-chevron-left"></i>
                                                </button>
                                                <span class="mx-2">
                                                    Page: <span id="currentPage">1</span> / <span id="totalPages">0</span>
                                                </span>
                                                <button class="btn btn-sm btn-outline-dark ms-2" id="btnNextPage">
                                                    <i class="fas fa-chevron-right"></i>
                                                </button>
                                            </div>
                                            <div>
                                                <div class="input-group input-group-sm" style="width: 150px;">
                                                    <span class="input-group-text">Zoom</span>
                                                    <select class="form-select" id="zoomSelect">
                                                        <option value="0.5">50%</option>
                                                        <option value="0.75">75%</option>
                                                        <option value="1" selected>100%</option>
                                                        <option value="1.25">125%</option>
                                                        <option value="1.5">150%</option>
                                                        <option value="2">200%</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pdf-container p-3">
                                        <canvas id="pdfCanvas" class="mx-auto d-block shadow-sm"></canvas>
                                    </div>
                                </div>
                                <div id="pdfError" class="d-none text-center p-5">
                                    <i class="fas fa-exclamation-triangle fa-3x text-danger mb-3"></i>
                                    <h5>Unable to load PDF</h5>
                                    <p class="text-muted">There was an error loading the PDF document.</p>
                                    <button class="btn btn-primary" onclick="location.reload()">
                                        <i class="fas fa-redo me-2"></i>Try Again
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer d-flex justify-content-between">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i>
                                Use arrow keys to navigate between pages
                            </div>
                            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Add modal to body if not exists
        if (!document.getElementById('pdfViewerModal')) {
            document.body.insertAdjacentHTML('beforeend', modalHTML);
        } else {
            // Remove existing modal
            const existingModal = document.getElementById('pdfViewerModal');
            if (existingModal) {
                existingModal.remove();
            }
            document.body.insertAdjacentHTML('beforeend', modalHTML);
        }
        
        // Get modal instance
        const modal = new bootstrap.Modal(document.getElementById('pdfViewerModal'));
        
        // Show modal
        modal.show();
        
        // Initialize PDF.js when modal is shown
        document.getElementById('pdfViewerModal').addEventListener('shown.bs.modal', function() {
            initializePDFViewer(fileURL);
        });
        
        // Clean up object URL when modal is closed
        document.getElementById('pdfViewerModal').addEventListener('hidden.bs.modal', function() {
            URL.revokeObjectURL(fileURL);
            this.remove();
        });
        
        // Download button handler
        document.getElementById('pdfViewerModal').addEventListener('click', function(e) {
            if (e.target.id === 'btnDownloadPDF' || e.target.closest('#btnDownloadPDF')) {
                downloadPDF(file);
            }
        });
    }

    // Function to initialize PDF.js viewer
    function initializePDFViewer(fileURL) {
        // Check if PDF.js is loaded
        if (typeof pdfjsLib === 'undefined') {
            // Load PDF.js dynamically
            loadPDFJS().then(() => {
                renderPDF(fileURL);
            }).catch(error => {
                console.error('Failed to load PDF.js:', error);
                showPDFError();
            });
        } else {
            renderPDF(fileURL);
        }
    }

    // Function to load PDF.js library dynamically
    function loadPDFJS() {
        return new Promise((resolve, reject) => {
            if (typeof pdfjsLib !== 'undefined') {
                resolve();
                return;
            }
            
            // Create script element
            const script = document.createElement('script');
            script.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js';
            script.integrity = 'sha512-9o9W6Vg9Q9W6XjP0lL8y4E5qX1G8M8q2+5Q6J5q5v5z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z';
            script.crossOrigin = 'anonymous';
            script.onload = resolve;
            script.onerror = reject;
            document.head.appendChild(script);
            
            // Also load the worker
            const workerScript = document.createElement('script');
            workerScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
            workerScript.integrity = 'sha512-9o9W6Vg9Q9W6XjP0lL8y4E5qX1G8M8q2+5Q6J5q5v5z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z';
            workerScript.crossOrigin = 'anonymous';
            document.head.appendChild(workerScript);
        });
    }

    // Function to render PDF using PDF.js
    async function renderPDF(fileURL) {
        try {
            const pdfContainer = document.getElementById('pdfViewerContainer');
            //const pdfLoading = document.getElementById('pdfLoading');
            const pdfViewer = document.getElementById('pdfViewer');
            const pdfCanvas = document.getElementById('pdfCanvas');
            const currentPageSpan = document.getElementById('currentPage');
            const totalPagesSpan = document.getElementById('totalPages');
            const zoomSelect = document.getElementById('zoomSelect');
            
            // Set PDF.js worker path
            pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.4.120/pdf.worker.min.js';
            
            // Load the PDF
            const loadingTask = pdfjsLib.getDocument(fileURL);
            const pdf = await loadingTask.promise;
            
            // Get total pages
            const totalPages = pdf.numPages;
            totalPagesSpan.textContent = totalPages;
            
            // Set initial page
            let currentPage = 1;
            let scale = parseFloat(zoomSelect.value);
            
            // Function to render a specific page
            async function renderPage(pageNum) {
                try {
                    //pdfLoading.style.display = 'flex';
                    pdfViewer.style.display = 'none';
                    
                    const page = await pdf.getPage(pageNum);
                    
                    // Get viewport
                    const viewport = page.getViewport({ scale: scale });
                    
                    // Set canvas dimensions
                    const canvas = pdfCanvas;
                    const context = canvas.getContext('2d');
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;
                    
                    // Render PDF page
                    const renderContext = {
                        canvasContext: context,
                        viewport: viewport
                    };
                    
                    await page.render(renderContext).promise;
                    
                    // Update UI
                    currentPageSpan.textContent = currentPage;
                    //pdfLoading.style.display = 'none';
                    pdfViewer.style.display = 'block';
                    
                } catch (error) {
                    console.error('Error rendering page:', error);
                    showPDFError();
                }
            }
            
            // Render first page
            await renderPage(currentPage);
            
            // Navigation handlers
            document.getElementById('btnPrevPage').addEventListener('click', async () => {
                if (currentPage > 1) {
                    currentPage--;
                    await renderPage(currentPage);
                }
            });
            
            document.getElementById('btnNextPage').addEventListener('click', async () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    await renderPage(currentPage);
                }
            });
            
            // Zoom handler
            zoomSelect.addEventListener('change', async () => {
                scale = parseFloat(zoomSelect.value);
                await renderPage(currentPage);
            });
            
            // Keyboard navigation
            document.addEventListener('keydown', async (e) => {
                if (document.getElementById('pdfViewerModal').classList.contains('show')) {
                    switch(e.key) {
                        case 'ArrowLeft':
                            if (currentPage > 1) {
                                currentPage--;
                                await renderPage(currentPage);
                            }
                            break;
                        case 'ArrowRight':
                            if (currentPage < totalPages) {
                                currentPage++;
                                await renderPage(currentPage);
                            }
                            break;
                        case '+':
                        case '=':
                            e.preventDefault();
                            if (scale < 3) {
                                scale += 0.25;
                                zoomSelect.value = scale.toFixed(2);
                                await renderPage(currentPage);
                            }
                            break;
                        case '-':
                            e.preventDefault();
                            if (scale > 0.25) {
                                scale -= 0.25;
                                zoomSelect.value = scale.toFixed(2);
                                await renderPage(currentPage);
                            }
                            break;
                    }
                }
            });
            
        } catch (error) {
            console.error('Error loading PDF:', error);
            showPDFError();
        }
    }

    // Function to download PDF
    function downloadPDF(file) {
        const downloadURL = URL.createObjectURL(file);
        const a = document.createElement('a');
        a.href = downloadURL;
        a.download = file.name;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(downloadURL);
        
        // Show success message
        Swal.fire({
            title: 'Download Started',
            text: `Downloading ${file.name}`,
            icon: 'success',
            timer: 2000,
            showConfirmButton: false
        });
    }

    // Helper function to format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

     // Helper function to show loading indicator
    function showLoadingIndicator() {
        // You can customize this based on your UI
        Swal.fire({
            title: 'Generating PDF',
            text: 'Please wait while we generate the register document...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
    }

    // Helper function to hide loading indicator
    function hideLoadingIndicator() {
        Swal.close();
    }

    // Helper function to show PDF error
    function showPDFError() {
        //const pdfLoading = document.getElementById('pdfLoading');
        const pdfViewer = document.getElementById('pdfViewer');
        const pdfError = document.getElementById('pdfError');
        
        //if (pdfLoading) pdfLoading.style.display = 'none';
        if (pdfViewer) pdfViewer.style.display = 'none';
        if (pdfError) {
            pdfError.classList.remove('d-none');
            pdfError.classList.add('d-flex', 'flex-column', 'align-items-center', 'justify-content-center');
        }
    }

    // Add CSS for PDF viewer
    const pdfViewerCSS = `
        #pdfCanvas {
            max-width: 100%;
            border: 1px solid #dee2e6;
            border-radius: 4px;
        }
        
        .pdf-container {
            overflow: auto;
            max-height: calc(70vh - 100px);
            background: beige;
        }
        
        .pdf-toolbar {
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        #btnViewFile:hover {
            transform: translateY(-1px);
            transition: transform 0.2s;
        }
        
        #pdfViewerModal .modal-dialog {
            max-width: 90%;
            max-height: 90vh;
        }
        
        .modal {
            background: rgba(0, 0, 0, 0.42) !important;
        }
        
        #pdfViewerModal .modal-body {
            min-height: 70vh;
            max-height: 80vh;
            overflow: hidden;
        }
        
        @media (max-width: 768px) {
            #pdfViewerModal .modal-dialog {
                max-width: 95%;
                margin: 0.5rem;
            }
            
            .pdf-toolbar {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .pdf-toolbar > div {
                width: 100%;
                justify-content: center;
            }
        }
    `;

    // Add CSS to document
    if (!document.getElementById('pdf-viewer-css')) {
        const style = document.createElement('style');
        style.id = 'pdf-viewer-css';
        style.textContent = pdfViewerCSS;
        document.head.appendChild(style);
    }

   // Initialize modal on show
$('#addlegder').on('shown.bs.modal', function () {
    // Load dynamic dropdowns
    loadNewEstateList();
    loadNewNatureOfDevelopmentList();
    loadNewNatureOfInstrumentList();
    
    // Set default dates
    const today = new Date().toISOString().split('T')[0];
    $('#rt_commencement_date').val(today);
    $('#rt_last_payment_date').val(today);
    
    // Reset form
    resetAddForm();
});

// Load estate list for add modal
function loadNewEstateList() {
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: { request_type: "get_estate_list" },
        cache: false,
        success: function (response) {
            try {
                const estates = JSON.parse(response);
                const select = $("#rt_estate");
                select.empty();
                select.append('<option value="">-- Select Estate --</option>');
                
                estates.forEach(function (estate) {
                    select.append(`<option value="${estate.ge_id}">${estate.ge_location_name}</option>`);
                });
            } catch (e) {
                console.error("Error parsing estate list:", e);
                Swal.fire({
                    icon: 'error',
                    title: 'Data Error',
                    text: 'Failed to load estate list.'
                });
            }
        },
        error: function (xhr, status, error) {
            console.error("Error fetching estate list:", error);
            $("#rt_estate").html('<option value="">Error loading estates</option>');
        }
    });
}

// Load nature of development list
function loadNewNatureOfDevelopmentList() {
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: { request_type: "get_nature_of_development_list" },
        cache: false,
        success: function (response) {
            try {
                const developments = JSON.parse(response);
                const select = $("#rt_nature_of_dev");
                select.empty();
                select.append('<option value="">-- Select --</option>');
                
                developments.forEach(function (dev) {
                    select.append(`<option value="${dev.na_name}">${dev.na_name}</option>`);
                });
            } catch (e) {
                console.error("Error parsing development list:", e);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error fetching development list:", error);
            $("#rt_nature_of_dev").html('<option value="">Error loading options</option>');
        }
    });
}

// Load nature of instrument list
function loadNewNatureOfInstrumentList() {
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: { request_type: "get_nature_of_instrument_list" },
        cache: false,
        success: function (response) {
            try {
                const instruments = JSON.parse(response);
                const select = $("#rt_nature_of_instrument");
                select.empty();
                select.append('<option value="">-- Select --</option>');
                
                instruments.forEach(function (instrument) {
                    select.append(`<option value="${instrument.nt_name}">${instrument.nt_name}</option>`);
                });
            } catch (e) {
                console.error("Error parsing instrument list:", e);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error fetching instrument list:", error);
            $("#rt_nature_of_instrument").html('<option value="">Error loading options</option>');
        }
    });
}

// Calculate expiry date when commencement date or term changes
$(document).on('change', '#rt_commencement_date, #rt_term', function () {
    calculateExpiryDate();
});

function calculateExpiryDate() {
    const commDate = $("#rt_commencement_date").val();
    const term = $("#rt_term").val();
    
    if (commDate && term) {
        const expiryDate = new Date(commDate);
        expiryDate.setFullYear(expiryDate.getFullYear() + parseInt(term));
        $("#rt_expiry_date").val(expiryDate.toISOString().split('T')[0]);
    }
}

// Auto-generate account number based on plot and estate
$(document).on('change', '#rt_plot_number, #rt_estate', function () {
    generateAccountNumber();
});

function generateAccountNumber() {
    const plotNumber = $("#rt_plot_number").val();
    const estateId = $("#rt_estate").val();
    const estateName = $("#rt_estate option:selected").text();
    
    if (plotNumber && estateId) {
        // Generate a simple account number format: ESTATE-PLOT-YYMMDD
        const now = new Date();
        const datePart = now.getFullYear().toString().slice(-2) + 
                        (now.getMonth() + 1).toString().padStart(2, '0') + 
                        now.getDate().toString().padStart(2, '0');
        
        // Get estate code (first 3 letters or use ID)
        const estateCode = estateName.substring(0, 3).toUpperCase() || estateId;
        const accountNumber = `${estateCode}-${plotNumber}-${datePart}`;
        
        // You can store this or display it if you have an account number field
        // $("#rt_account_number").val(accountNumber);
    }
}

// Handle save button click
$(document).on('click', '#btn_save_rent_client_details', function (e) {
    e.preventDefault();
    
    const form = document.getElementById('addlegderForm');
    
    // Form validation
    if (!form.checkValidity()) {
        form.classList.add('was-validated');
        Swal.fire({
            icon: 'warning',
            title: 'Validation Error',
            html: `
                <div class="text-start">
                    <p class="mb-2">Please fill all required fields correctly:</p>
                    <ul class="text-start">
                        ${getAddFormValidationErrors(form)}
                    </ul>
                </div>
            `,
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'Fix Errors',
            width: '500px'
        });
        return;
    }
    
    // Show confirmation dialog with form data preview
    Swal.fire({
        title: 'Confirm New Lease',
        html: `
            <div class="text-start">
                <p class="mb-3"><strong>Are you sure you want to create this new lease record?</strong></p>
                
                <div class="alert alert-info py-2 mb-3">
                    <small>
                        <i class="fas fa-info-circle me-1"></i>
                        You are about to add: <strong>${$("#rt_leasee_name").val() || 'New Lessee'}</strong>
                    </small>
                </div>
                
                <div class="preview-section mb-2">
                    <table class="table table-sm table-bordered bg-light">
                        <tbody>
                            <tr>
                                <td class="fw-semibold" style="width: 40%">Plot Number:</td>
                                <td>${$("#rt_plot_number").val() || 'N/A'}</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">Estate:</td>
                                <td>${$("#rt_estate option:selected").text() || 'N/A'}</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">Lease Term:</td>
                                <td>${$("#rt_term").val() || '0'} years</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">File Number:</td>
                                <td>${$("#rt_file_number").val() || 'N/A'}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="confirmAddCheckbox">
                    <label class="form-check-label" for="confirmAddCheckbox">
                        I confirm all information is accurate
                    </label>
                </div>
                
                <div class="text-muted small">
                    <i class="fas fa-exclamation-triangle me-1"></i>
                    Please ensure there are no duplicate entries for this plot.
                </div>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#198754',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-plus-circle me-1"></i> Yes, Create Lease',
        cancelButtonText: '<i class="fas fa-times me-1"></i> Cancel',
        showLoaderOnConfirm: true,
        preConfirm: () => {
            const checkbox = document.getElementById('confirmAddCheckbox');
            if (!checkbox.checked) {
                Swal.showValidationMessage('Please confirm the information is accurate');
                return false;
            }
            
            // Optional: Check for duplicate plot number
            return checkDuplicatePlot();
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed) {
            // Proceed with saving
            saveNewLeaseDetails();
        }
    });
});

// Function to check for duplicate plot number
function checkDuplicatePlot() {
    const plotNumber = $("#rt_plot_number").val();
    const estateId = $("#rt_estate").val();
    
    return new Promise((resolve) => {
        $.ajax({
            type: "POST",
            url: "rent_mgt_serv",
            data: {
                request_type: "check_duplicate_plot",
                plot_number: plotNumber,
                estate_id: estateId
            },
            cache: false,
            success: function (response) {
                try {
                    const result = JSON.parse(response);
                    if (result.duplicate) {
                        Swal.showValidationMessage(`
                            <div class="text-start">
                                <p>Plot number <strong>${plotNumber}</strong> already exists in this estate.</p>
                                <p class="mb-0">Existing lessee: <strong>${result.existing_lessee}</strong></p>
                            </div>
                        `);
                        resolve(false);
                    } else {
                        resolve(true);
                    }
                } catch (e) {
                    // If check fails, still allow save (server will handle duplicate check)
                    resolve(true);
                }
            },
            error: function () {
                // If check fails, still allow save
                resolve(true);
            }
        });
    });
}

// Function to get validation errors for add form
function getAddFormValidationErrors(form) {
    const invalidFields = form.querySelectorAll(':invalid');
    let errorsHtml = '';
    
    const fieldLabels = {
        'rt_leasee_name': 'Full Name',
        'rt_leasee_address': 'Postal Address',
        'rt_mobile_phone_1': 'Primary Mobile',
        'rt_plot_number': 'Plot Number',
        'rt_plot_size': 'Plot Size',
        'rt_file_number': 'File Number',
        'rt_ledger': 'Ledger',
        'rt_estate': 'Estate',
        'rt_commencement_date': 'Commencement Date',
        'rt_term': 'Lease Term',
        'rt_rent_review_clause': 'Rent Review Period',
        'rt_location_rate': 'Location Rate',
        'rt_last_payment_date': 'Last Payment Date',
        'rt_last_payment_period': 'Last Payment Period',
        'rt_period_in_arrears': 'Periods in Arrears'
    };
    
    invalidFields.forEach(field => {
        const fieldId = field.id;
        const fieldName = fieldLabels[fieldId] || fieldId.replace('rt_', '').replace(/_/g, ' ');
        errorsHtml += `<li><strong>${fieldName}:</strong> ${field.validationMessage || 'Required field'}</li>`;
    });
    
    return errorsHtml || '<li>Please check all required fields marked with *</li>';
}

// Function to save new lease details
function saveNewLeaseDetails() {
    // Prepare data
    const formData = {
        request_type: 'add_update_rent_leasee_details',
        rent_id: $("#rt_rent_id").val(),
        owners_name: $("#rt_leasee_name").val(),
        address: $("#rt_leasee_address").val(),
        mobile: $("#rt_mobile_phone_1").val(),
        mobile_1: $("#rt_mobile_phone_2").val(),
        email: $("#rt_email").val(),
        digital_address: $("#rt_leasee_digital_address").val(),
        file_number: $("#rt_file_number").val(),
        ledger: $("#rt_ledger").val(),
        folio: $("#rt_folio").val(),
        plot_number: $("#rt_plot_number").val(),
        plot_size: $("#rt_plot_size").val(),
        covenanted_user: $("#rt_convenant_user").val(),
        current_use: $("#rt_current_use").val(),
        nature_of_devt: $("#rt_nature_of_dev").val(),
        parcel_address: $("#rt_parcel_address").val(),
        ls_number: $("#rt_ls_number").val(),
        comm_date: $("#rt_commencement_date").val(),
        term: $("#rt_term").val().replace(".0", ""),
        estate: $("#rt_estate").val(),
        nature_of_instrument: $("#rt_nature_of_instrument").val(),
        rent_category: $("#rt_rent_category").val(),
        rent_review_clause: $("#rt_rent_review_clause").val().replace(".0", ""),
        rent_passing: $("#rt_rent_passing").val().replace(".0", ""),
        location_rate: $("#rt_location_rate").val().replace(".0", ""),
        last_payment_date: $("#rt_last_payment_date").val(),
        last_payment_period: $("#rt_last_payment_period").val(),
        rent_outstanding: $("#rt_rent_outstanding").val(),
        period_in_arrears: $("#rt_period_in_arrears").val(),
        remarks: $("#rt_remarks").val(),
        glpin: $("#rt_glpin").val()
    };
    
    // Show loading with progress indicator
    let timerInterval;
    Swal.fire({
        title: 'Creating New Lease',
        html: `
            <div class="text-center">
                <div class="mb-3">
                    <i class="fas fa-plus-circle fa-spin fa-2x text-primary"></i>
                </div>
                <div class="progress" style="height: 8px;">
                    <div class="progress-bar progress-bar-striped progress-bar-animated" 
                         role="progressbar" style="width: 0%"></div>
                </div>
                <p class="mt-2 mb-0 text-muted" id="swal-progress-text">Processing request...</p>
            </div>
        `,
        allowOutsideClick: false,
        didOpen: () => {
            const progressBar = Swal.getHtmlContainer().querySelector('.progress-bar');
            const progressText = Swal.getHtmlContainer().querySelector('#swal-progress-text');
            let progress = 0;
            
            timerInterval = setInterval(() => {
                progress += 10;
                if (progress <= 90) {
                    progressBar.style.width = `${progress}%`;
                    progressText.textContent = progress < 50 
                        ? 'Validating data...' 
                        : 'Saving to database...';
                }
            }, 300);
        },
        willClose: () => {
            clearInterval(timerInterval);
        }
    });
    
    // Send AJAX request
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: formData,
        cache: false,
        success: function (response) {
            Swal.close();
            
            try {
                const result = JSON.parse(response);
                
                if (result.success) {
                    // Success notification with options
                    Swal.fire({
                        title: 'Success!',
                        html: `
                            <div class="text-center">
                                <div class="mb-3">
                                    <i class="fas fa-check-circle fa-3x text-success"></i>
                                </div>
                                <p class="mb-2"><strong>New lease created successfully!</strong></p>
                                <div class="alert alert-success py-2">
                                    <small>
                                        <i class="fas fa-check me-1"></i>
                                        <strong>${formData.owners_name}</strong> has been added as a new lessee
                                    </small>
                                </div>
                                ${result.account_number ? 
                                    `<div class="alert alert-info py-2">
                                        <small>
                                            <i class="fas fa-id-card me-1"></i>
                                            Account Number: <strong>${result.account_number}</strong>
                                        </small>
                                    </div>` : ''
                                }
                            </div>
                        `,
                        showCancelButton: true,
                        confirmButtonColor: '#198754',
                        cancelButtonColor: '#6c757d',
                        confirmButtonText: '<i class="fas fa-eye me-1"></i> View New Record',
                        cancelButtonText: '<i class="fas fa-plus me-1"></i> Add Another',
                        showDenyButton: true,
                        denyButtonText: '<i class="fas fa-print me-1"></i> Print Details',
                        denyButtonColor: '#0d6efd',
                        width: '500px'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Close modal and refresh table
                            $('#addlegder').modal('hide');
                            $('#btn_rt_search').click();
                        } else if (result.isDenied) {
                            // Print details
                            generateAddPrintView(formData, result.account_number);
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            // Add another - reset form and keep modal open
                            resetAddForm();
                        }
                    });
                } else {
                    // Error handling
                    let errorMessage = result.message || 'Failed to create new lease.';
                    
                    // Check for specific error types
                    if (errorMessage.includes('duplicate') || errorMessage.includes('already exists')) {
                        errorMessage = `
                            <div class="text-start">
                                <p class="mb-2"><strong>Duplicate Entry Detected!</strong></p>
                                <p class="mb-1">A record with similar details already exists:</p>
                                <ul class="text-start">
                                    ${result.duplicate_details ? 
                                        Object.entries(result.duplicate_details)
                                            .map(([key, value]) => `<li><strong>${key}:</strong> ${value}</li>`)
                                            .join('') 
                                        : '<li>Please check for duplicate plot numbers or file numbers</li>'}
                                </ul>
                                <div class="mt-3">
                                    <button class="btn btn-sm btn-outline-primary" onclick="Swal.close();">
                                        <i class="fas fa-edit me-1"></i> Edit Existing
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary ms-2" onclick="resetAddForm(); Swal.close();">
                                        <i class="fas fa-redo me-1"></i> Start Over
                                    </button>
                                </div>
                            </div>
                        `;
                    }
                    
                    Swal.fire({
                        icon: 'error',
                        title: 'Creation Failed',
                        html: errorMessage,
                        confirmButtonText: 'OK',
                        showConfirmButton: false,
                        width: '500px'
                    });
                }
            } catch (e) {
                console.error('Error parsing response:', e);
                Swal.fire({
                    icon: 'error',
                    title: 'Server Error',
                    text: 'Invalid response from server. Please contact support.',
                    confirmButtonColor: '#dc3545'
                });
            }
        },
        error: function (xhr, status, error) {
            Swal.close();
            console.error('AJAX Error:', error);
            
            let errorMessage = 'Failed to create new lease. ';
            if (xhr.status === 0) {
                errorMessage += 'No network connection.';
            } else if (xhr.status === 404) {
                errorMessage += 'Server endpoint not found.';
            } else if (xhr.status === 500) {
                errorMessage += 'Server error. Please try again later.';
            } else {
                errorMessage += 'Please check your connection.';
            }
            
            Swal.fire({
                icon: 'error',
                title: 'Connection Error',
                html: `
                    <div class="text-start">
                        <p class="mb-2">${errorMessage}</p>
                        <div class="alert alert-danger py-2 mt-2">
                            <small>
                                <i class="fas fa-exclamation-triangle me-1"></i>
                                <strong>Error Details:</strong> ${error}
                            </small>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-sm btn-outline-primary" onclick="retryAddSave()">
                                <i class="fas fa-redo me-1"></i> Retry
                            </button>
                            <button class="btn btn-sm btn-outline-secondary ms-2" onclick="Swal.close()">
                                <i class="fas fa-times me-1"></i> Cancel
                            </button>
                        </div>
                    </div>
                `,
                confirmButtonText: 'OK',
                showConfirmButton: false,
                width: '500px'
            });
        }
    });
}

// Function to reset add form
function resetAddForm() {
    const form = document.getElementById('addlegderForm');
    form.reset();
    form.classList.remove('was-validated');
    
    // Reset calculated fields
    $("#rt_expiry_date").val('');
    
    // Set default dates
    const today = new Date().toISOString().split('T')[0];
    $('#rt_commencement_date').val(today);
    $('#rt_last_payment_date').val(today);
    
    // Reset numeric fields to 0
    $('#rt_rent_passing').val('0');
    $('#rt_location_rate').val('0.00');
    $('#rt_rent_outstanding').val('0');
    $('#rt_period_in_arrears').val('0');
    $('#rt_rent_review_clause').val('0');
    $('#rt_last_payment_period').val('0');
    
    // Focus on first field
    $('#rt_leasee_name').focus();
}

// Function to retry add save operation
function retryAddSave() {
    Swal.close();
    setTimeout(() => {
        $('#btn_save_rent_client_details').click();
    }, 500);
}

// Function to generate print view for new lease
function generateAddPrintView(data, accountNumber) {
    // This would open a print preview of the new lease
    // Implementation depends on your print functionality
    console.log('Printing new lease data:', data);
    
    Swal.fire({
        title: 'Lease Created',
        html: `
            <div class="text-center">
                <div class="mb-3">
                    <i class="fas fa-print fa-3x text-primary"></i>
                </div>
                <p class="mb-2">New lease has been created successfully.</p>
                ${accountNumber ? 
                    `<p class="mb-3"><strong>Account Number:</strong> ${accountNumber}</p>` : ''
                }
                <p class="text-muted small">Print functionality would open here.</p>
            </div>
        `,
        confirmButtonText: 'OK'
    }).then(() => {
        $('#addlegder').modal('hide');
        $('#btn_rt_search').click();
    });
}

// Format numeric inputs on blur
$(document).on('blur', '#rt_rent_passing, #rt_location_rate, #rt_rent_outstanding', function () {
    const value = parseFloat($(this).val()) || 0;
    $(this).val(value.toFixed(2));
});

// Format other numeric inputs
$(document).on('blur', '#rt_plot_size, #rt_term, #rt_rent_review_clause', function () {
    const value = parseFloat($(this).val()) || 0;
    $(this).val(value.toFixed(1));
});

// Add unsaved changes protection
$(document).on('input', '#addlegderForm input, #addlegderForm select, #addlegderForm textarea', function() {
    $('#addlegderForm').addClass('form-modified');
});

$('#addlegder').on('hide.bs.modal', function(e) {
    if ($('#addlegderForm').hasClass('form-modified')) {
        e.preventDefault();
        
        Swal.fire({
            title: 'Unsaved Changes',
            html: `
                <div class="text-start">
                    <p class="mb-3">You have unsaved changes. What would you like to do?</p>
                    <div class="alert alert-warning py-2">
                        <small>
                            <i class="fas fa-exclamation-triangle me-1"></i>
                            All entered data will be lost if you close without saving.
                        </small>
                    </div>
                </div>
            `,
            icon: 'warning',
            showCancelButton: true,
            showDenyButton: true,
            confirmButtonText: '<i class="fas fa-save me-1"></i> Save & Close',
            denyButtonText: '<i class="fas fa-times me-1"></i> Discard Changes',
            cancelButtonText: '<i class="fas fa-arrow-left me-1"></i> Continue Editing',
            confirmButtonColor: '#198754',
            denyButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            reverseButtons: true,
            width: '500px'
        }).then((result) => {
            if (result.isConfirmed) {
                // Trigger save
                $('#btn_save_rent_client_details').click();
            } else if (result.isDenied) {
                // Discard changes and close
                $('#addlegderForm').removeClass('form-modified');
                $('#addlegder').modal('hide');
            }
            // If cancelled, do nothing (continue editing)
        });
        
        return false;
    }
});

// Auto-fill mobile field with country code
$(document).on('blur', '#rt_mobile_phone_1, #rt_mobile_phone_2', function() {
    let value = $(this).val();
    if (value && !value.startsWith('0') && value.length === 9) {
        $(this).val('0' + value);
    }
});

// Add keyboard shortcut for save (Ctrl + S)
$(document).on('keydown', '#addlegder', function(e) {
    if ((e.ctrlKey || e.metaKey) && e.key === 's') {
        e.preventDefault();
        $('#btn_save_rent_client_details').click();
    }
});

// Add auto-suggest for common fields based on estate
$(document).on('change', '#rt_estate', function() {
    const estateId = $(this).val();
    if (estateId) {
        // You could fetch default values for this estate here
        // For now, we'll just show a loading state
        $('#rt_location_rate').attr('placeholder', 'Loading default rate...');
        
        // Example: Fetch estate-specific defaults
        $.ajax({
            type: "POST",
            url: "rent_mgt_serv",
            data: { 
                request_type: "get_estate_defaults",
                estate_id: estateId 
            },
            cache: false,
            success: function (response) {
                try {
                    const defaults = JSON.parse(response);
                    if (defaults.default_location_rate) {
                        $('#rt_location_rate').val(defaults.default_location_rate);
                    }
                    $('#rt_location_rate').removeAttr('placeholder');
                } catch (e) {
                    console.error('Error parsing estate defaults:', e);
                }
            },
            error: function() {
                $('#rt_location_rate').removeAttr('placeholder');
            }
        });
    }
});

// Clear form-modified class when modal is hidden
$('#addlegder').on('hidden.bs.modal', function() {
    $('#addlegderForm').removeClass('form-modified');
});

// Add CSS for form-modified indicator
if (!$('#add-form-styles').length) {
    const style = document.createElement('style');
    style.id = 'add-form-styles';
    style.textContent = `
        #addlegder .form-modified .card-header {
            position: relative;
        }
        
        #addlegder .form-modified .card-header::after {
            content: '●';
            color: #ffc107;
            position: absolute;
            right: 10px;
            font-size: 12px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        #addlegder .form-control:valid {
            border-color: #198754;
        }
        
        #addlegder .form-control:invalid {
            border-color: #dc3545;
        }
    `;
    document.head.appendChild(style);
}

 

    $('#btn_rt_search').on('click', (e) => {
        e.preventDefault();

        var rts_select_type = $('#rts_select_type').val();
        var rts_estate = $('#rts_estate').val();
        var rts_keyword = $('#rts_keyword').val();

        // Validation with SweetAlert
        if (!rts_select_type) {
            Swal.fire({
                icon: 'warning',
                title: 'Search Type Required',
                text: 'Please select a search type to continue.',
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'OK'
            });
            return;
        }

        // Validate based on search type
        switch (rts_select_type) {
            case 'Plot Number':
                if (!rts_estate || !rts_keyword) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Missing Information',
                        text: 'Please select an estate and enter a plot number.',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
                break;
            case 'Estate':
                if (!rts_estate) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Estate Required',
                        text: 'Please select an estate to search.',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
                break;
            case 'Name of Leasee/Assignee':
                if (!rts_keyword || rts_keyword.length < 3) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Search Term Too Short',
                        text: 'Please enter at least 3 characters for name search.',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
                break;
        }

        // Clean estate value
        if (rts_estate) {
            rts_estate = rts_estate.replace(".0", "");
        }

        // Show loading indicator
        // Swal.fire({
        //     title: 'Searching...',
        //     text: 'Please wait while we fetch the data.',
        //     allowOutsideClick: false,
        //     didOpen: () => {
        //         Swal.showLoading();
        //     }
        // });

        $.ajax({
            type: "POST",
            url: "rent_mgt_serv",
            data: {
                request_type: 'select_rent_leasee_details',
                select_type: rts_select_type,
                estate: rts_estate,
                keyword: rts_keyword
            },
            cache: false,
            success: function(response) {
                // console.log(response);
                try {
                    var json_p = JSON.parse(response);

                    // Close loading dialog
                    Swal.close();

                    // Update summary cards
                    $("#total_leasee").html(json_p.total_leasee || 0);
                    
                    // Format currency for outstanding amount
                    const totalOutstanding = parseFloat(json_p.total_rent_oustanding || 0);
                    const formattedTotal = totalOutstanding.toLocaleString('en-GH', {
                        style: 'currency',
                        currency: 'GHS',
                        minimumFractionDigits: 2
                    });
                    $("#rentOutstanding").html(formattedTotal);

                    // Clear table if no data
                    if (!json_p.data || json_p.data.length === 0) {
                        Swal.fire({
                            icon: 'info',
                            title: 'No Results Found',
                            text: 'No records match your search criteria.',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'OK'
                        });
                        
                        datatable.clear().draw();
                        return;
                    }

                    // Success notification
                    // Swal.fire({
                    //     icon: 'success',
                    //     title: 'Search Complete',
                    //     text: `Found ${json_p.data.length} record(s)`,
                    //     timer: 1500,
                    //     showConfirmButton: false
                    // });

                    // Clear and repopulate table
                    datatable.clear();

                    $(json_p.data).each(function() {
                        const amount = parseFloat(this.rent_outstanding || 0);
                        const formattedAmount = amount.toLocaleString('en-GH', {
                            style: 'currency',
                            currency: 'GHS',
                            minimumFractionDigits: 2
                        });

                        // Format dates
                        const formatDate = (dateStr) => {
                            if (!dateStr) return '-';
                            return new Date(dateStr.replace(/-/g, '/')).toLocaleDateString('en-GH', {
                                day: '2-digit',
                                month: 'short',
                                year: 'numeric'
                            });
                        };

                        // Calculate unexpired term with improved logic
                        var endDate = new Date(this.expiry_date?.replace(/-/g, "/"));
                        var today = new Date();
                        var display_reminder = '-';
                        
                        if (this.expiry_date) {
                            const diffTime = endDate - today;
                            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                            const diffYears = Math.floor(diffDays / 365);
                            
                            if (diffDays < 0) {
                                const yearsPassed = Math.abs(diffYears);
                                display_reminder = `<span class="badge bg-danger py-1 px-2">
                                    <i class="fas fa-clock me-1"></i>${yearsPassed} Year(s) Expired
                                </span>`;
                            } else if (diffDays <= 365) {
                                display_reminder = `<span class="badge bg-warning text-dark py-1 px-2">
                                    <i class="fas fa-exclamation-triangle me-1"></i>${diffDays} Day(s) Left
                                </span>`;
                            } else {
                                display_reminder = `<span class="badge bg-success py-1 px-2">
                                    <i class="fas fa-check-circle me-1"></i>${diffYears} Year(s) Left
                                </span>`;
                            }
                        }

                        // Create dropdown actions with improved icons
                        const dropdownHtml = `
                        <div class="dropdown">
                            <button class="btn btn-outline-dark btn-icon btn-sm btn-wave waves-effect waves-light" type="button"
                                    data-bs-toggle="dropdown" aria-expanded="false"
                                    title="Actions">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end p-2" style="min-width: 220px;">
                                <li>
                                    <h6 class="dropdown-header text-primary mb-1">
                                        <i class="fas fa-user-circle me-2"></i>${this.owners_name || 'Leasee'}
                                    </h6>
                                </li>
                                <li><hr class="dropdown-divider my-1"></li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2 viewLedgerBtn" href="#"
                                        data-all='${JSON.stringify(this)}'>
                                        <i class="fas fa-eye text-info me-2"></i>
                                        <div>
                                            <div class="fw-medium">View Details</div>
                                            <small class="text-muted">Complete lease information</small>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2" href="#"
                                        data-bs-toggle="modal" data-bs-target="#editlegder"
                                        data-all='${JSON.stringify(this)}'>
                                        <i class="fas fa-edit text-primary me-2"></i>
                                        <div>
                                            <div class="fw-medium">Edit Details</div>
                                            <small class="text-muted">Update lease information</small>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2" href="#"
                                        data-bs-toggle="modal" data-bs-target="#singlerentdemandnotice"
                                        data-rent_id="${this.rl_id}"
                                        data-account_number="${this.account_number}"
                                        data-owners_name="${this.owners_name}"
                                        data-address="${this.address}"
                                        data-mobile="${this.mobile}"
                                        data-mobile_1="${this.mobile_1}"
                                        data-email="${this.email}"
                                        data-plot_number="${this.plot_number}"
                                        data-estate="${this.estate}">
                                        <i class="fas fa-file-invoice-dollar text-success me-2"></i>
                                        <div>
                                            <div class="fw-medium">Demand Notice</div>
                                            <small class="text-muted">Generate rent invoice</small>
                                        </div>
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider my-1"></li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2" href="#"
                                        data-bs-toggle="modal" data-bs-target="#paymenthistory"
                                        data-m_id="${this.rl_id}">
                                        <i class="fas fa-history text-secondary me-2"></i>
                                        <div>
                                            <div class="fw-medium">Payment History</div>
                                            <small class="text-muted">View all payments</small>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2" href="#"
                                        data-bs-toggle="modal" data-bs-target="#rentdocuments"
                                        data-rent_id="${this.rl_id}">
                                        <i class="fas fa-folder text-warning me-2"></i>
                                        <div>
                                            <div class="fw-medium">Documents</div>
                                            <small class="text-muted">Manage lease documents</small>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>`;

                        // Format term with years
                        const termYears = this.term ? `${this.term} Year(s)` : '-';

                        // Add row with improved formatting
                        datatable.row.add([
                            dropdownHtml,
                            `<div class="fw-medium small text-primary">${this.account_number || '-'}</div>`,
                            `<div>
                                <div class="fw-medium small">${this.plot_number || '-'}</div>
                            </div>`,
                            `<div class="text-truncate" style="max-width: 200px;" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${this.owners_name || ''}">
                                <small>${this.owners_name || '-'}</small>
                            </div>`,
                            `<small>${this.file_number}</small>`,
                            `<small>${formatDate(this.comm_date)}</small>`,
                            `<span class="badge bg-light text-dark">${termYears}</span>`,
                            this.plot_size ? `<small>${this.plot_size} Acres</small>` : '-',
                            `<small>${formatDate(this.last_review_date)}</small>`,
                            `<small>${this.last_payment_period}</small>`,
                            `<div class="text-end fw-bold ${amount > 0 ? 'text-danger' : 'text-success'}">
                                ${formattedAmount}
                                ${amount > 0 ? '<br><small class="text-muted">Outstanding</small>' : '<br><small class="text-muted">Paid</small>'}
                            </div>`,
                            display_reminder
                        ]).draw(false);
                    });

                    // Add hover effects and improve table styling
                    $('.dataTable').addClass('table-hover');
                    
                } catch (e) {
                    console.error('Error parsing JSON response:', e);
                    Swal.fire({
                        icon: 'error',
                        title: 'Data Error',
                        text: 'Failed to process server response. Please try again.',
                        confirmButtonColor: '#dc3545',
                        confirmButtonText: 'OK'
                    });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX Error:', textStatus, errorThrown);
                Swal.fire({
                    icon: 'error',
                    title: 'Request Failed',
                    text: 'Unable to connect to server. Please check your connection and try again.',
                    confirmButtonColor: '#dc3545',
                    confirmButtonText: 'OK'
                });
            }
        });
    });

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
 							
 						//	$('#elisDocumentPreview').modal({backdrop: 'static',});
 		          				 $('#elisDocumentPreview').modal('show');
 		          					
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

                // $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">No transaction found.</span>' }, { type: 'danger',z_index: 9999 });
                // return;
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
                   // $.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">AJAX request failed: ' + textStatus + '</span>' }, { type: 'danger',z_index: 9999 });
                }
            });


        });



let currentLedgerData = {};

$(document).on("click", ".viewLedgerBtn", function () {
    // Get data from the button (passed as JSON string in data-all attribute)
    const dataStr = $(this).data('all');
    currentLedgerData = typeof dataStr === 'string' ? JSON.parse(dataStr) : $(this).data();
    
    console.log('Ledger data:', currentLedgerData);
    
    // Format currency
    const formatCurrency = (amount) => {
        if (!amount) return 'GHS 0.00';
        const num = parseFloat(amount);
        return num.toLocaleString('en-GH', {
            style: 'currency',
            currency: 'GHS',
            minimumFractionDigits: 2
        });
    };
    
    // Format date
    const formatDate = (dateStr) => {
        if (!dateStr) return '-';
        try {
            const date = new Date(dateStr.replace(/-/g, '/'));
            return date.toLocaleDateString('en-GH', {
                day: '2-digit',
                month: 'short',
                year: 'numeric'
            });
        } catch (e) {
            return dateStr;
        }
    };
    
    // Populate Lessee Information
    $("#view_leasee_name").text(currentLedgerData.all?.owners_name || "-");
    $("#view_email").text(currentLedgerData.all?.email || "-");
    $("#view_address").text(currentLedgerData.all?.address || "-");
    $("#view_digital_address").text(currentLedgerData.all?.digital_address || "-");
    $("#view_mobile1").text(currentLedgerData.all?.mobile || "-");
    $("#view_mobile2").text(currentLedgerData.all?.mobile_1 || "-");
    $("#view_account_number").text(currentLedgerData.all?.account_number || "-");
    $("#view_file_number").text(currentLedgerData.all?.file_number || "-");
    
    // Populate Property Details
    $("#view_plot_number").text(currentLedgerData.all?.plot_number || "-");
    $("#view_plot_size").text(currentLedgerData.all?.plot_size ? `${currentLedgerData.all?.plot_size} sqm` : "-");
    $("#view_estate").text(currentLedgerData.all?.estate || "-");
    $("#view_ls_number").text(currentLedgerData.all?.ls_number || "-");
    $("#view_parcel_address").text(currentLedgerData.all?.parcel_address || "-");
    $("#view_ledger").text(currentLedgerData.all?.ledger || "-");
    $("#view_folio").text(currentLedgerData.all?.folio || "-");
    $("#view_convenant_user").text(currentLedgerData.all?.covenanted_user || "-");
    $("#view_current_use").text(currentLedgerData.all?.current_use || "-");
    $("#view_nature_of_dev").text(currentLedgerData.all?.nature_of_devt || "-");
    
    // Populate Lease Terms
    $("#view_commencement_date").text(formatDate(currentLedgerData.all?.comm_date));
    $("#view_term").text(currentLedgerData.all?.term ? `${currentLedgerData.all?.term} Year(s)` : "-");
    $("#view_expiry_date").text(formatDate(currentLedgerData.all?.expiry_date));
    $("#view_nature_of_instrument").text(currentLedgerData.all?.nature_of_instrument || "-");
    
    // Populate Rent Information
    $("#view_rent_category").text(currentLedgerData.all?.rent_category || "-");
    $("#view_rent_passing").text(formatCurrency(currentLedgerData.all?.rent_passing));
    $("#view_location_rate").text(formatCurrency(currentLedgerData.all?.location_rate));
    $("#view_rent_review_clause").text(currentLedgerData.all?.rent_review_clause || "-");
    
    // Populate Payment Status
    $("#view_last_payment_date").text(formatDate(currentLedgerData.all?.last_payment_date));
    $("#view_last_payment_period").text(currentLedgerData.all?.last_payment_period || "-");
    $("#view_rent_outstanding").text(formatCurrency(currentLedgerData.all?.rent_outstanding));
    $("#view_period_in_arrears").text(currentLedgerData.all?.period_in_arrears || "0");
    
    // Populate Additional Information
    $("#view_glpin").text(currentLedgerData.all?.glpin || "-");
    $("#view_remarks").text(currentLedgerData.all?.remarks || "-");
    
    // Calculate and display lease status badge
    const updateStatusBadge = () => {
        if (!currentLedgerData.expiry_date) return;
        
        const endDate = new Date(currentLedgerData.expiry_date.replace(/-/g, "/"));
        const today = new Date();
        const diffTime = endDate - today;
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        let statusText = '';
        let statusClass = '';
        
        if (diffDays < 0) {
            statusText = 'Expired';
            statusClass = 'bg-danger';
        } else if (diffDays <= 30) {
            statusText = 'Expiring Soon';
            statusClass = 'bg-warning text-dark';
        } else if (parseFloat(currentLedgerData.all?.rent_outstanding || 0) > 0) {
            statusText = 'Payment Due';
            statusClass = 'bg-danger';
        } else {
            statusText = 'Active';
            statusClass = 'bg-success';
        }
        
        // Add status badge to modal title
        $('#viewLedgerModalLabel').append(`
            <span class="badge ${statusClass} ms-2">${statusText}</span>
        `);
    };
    
    // Clear any existing status badge
    $('#viewLedgerModalLabel .badge').remove();
    updateStatusBadge();
    
    // Show modal using Bootstrap 5
    const modal = new bootstrap.Modal(document.getElementById('viewLedgerModal'));
    modal.show();
});


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
    $("#rdn_plot_number").val($(e.relatedTarget).data("plot_number"));
    $("#rdn_estate").val($(e.relatedTarget).data("estate"));
        
    var table = $('#tbl_rent_assessment_details');
        table.find("tbody tr").remove();
    
});

     // Handle edit button click
$(document).on("click", "a[data-bs-target='#editlegder']", function (e) {
    e.preventDefault();
    
    // Get data from data-all attribute (JSON string)
    const dataStr = $(this).data('all');
    currentLedgerData = typeof dataStr === 'string' ? JSON.parse(dataStr) : $(this).data();
    
    // Store data in a global variable for the modal shown event
    window.editModalData = currentLedgerData;
});

// Handle modal shown event
$('#editlegder').on('shown.bs.modal', function (e) {
    if (!window.editModalData) return;
    
    const data = window.editModalData;
    // console.log(data);
    
    // Populate form fields
    $("#rt_e_rent_id").val(data.all?.rl_id || 0);
    $("#rt_e_leasee_name").val(data.all?.owners_name || "");
    $("#rt_e_leasee_address").val(data.all?.address || "");
    $("#rt_e_mobile_phone_1").val(data.all?.mobile || "");
    $("#rt_e_mobile_phone_2").val(data.all?.mobile_1 || "");
    $("#rt_e_email").val(data.all?.email || "");
    $("#rt_e_leasee_digital_address").val(data.all?.digital_address || "");
    $("#rt_e_file_number").val(data.all?.file_number || "");
    $("#rt_e_ledger").val(data.all?.ledger || "");
    $("#rt_e_folio").val(data.all?.folio || "");
    $("#rt_e_plot_number").val(data.all?.plot_number || "");
    $("#rt_e_plot_size").val(data.all?.plot_size || "");
    $("#rt_e_parcel_address").val(data.all?.parcel_address || "");
    $("#rt_e_ls_number").val(data.all?.ls_number || "");
    $("#rt_e_commencement_date").val(data.all?.comm_date || "");
    $("#rt_e_term").val(data.all?.term || "");
    $("#rt_e_expiry_date").val(data.all?.expiry_date || "");
    $("#rt_e_rent_category").val(data.all?.rent_category || "");
    $("#rt_e_rent_review_clause").val(data.all?.rent_review_clause || "0");
    $("#rt_e_rent_passing").val(data.all?.rent_passing || "0");
    $("#rt_e_rent_outstanding").val(data.all?.rent_outstanding || "0");
    $("#rt_e_glpin").val(data.all?.glpin || "");
    $("#rt_e_remarks").val(data.all?.remarks || "");
    $("#rt_e_last_payment_date").val(data.all?.last_payment_date || "");
    $("#rt_e_last_payment_period").val(data.all?.last_payment_period || "0");
    $("#rt_e_period_in_arrears").val(data.all?.period_in_arrears || "0");
    
    // Calculate expiry date if not provided
    if (data.all?.comm_date && data.all?.term && !data.all?.expiry_date) {
        const commDate = new Date(data.all?.comm_date);
        const expiryDate = new Date(commDate);
        expiryDate.setFullYear(expiryDate.getFullYear() + parseInt(data.all?.term));
        $("#rt_e_expiry_date").val(expiryDate.toISOString().split('T')[0]);
    }
    
    // Load estate list
    loadEstateList(data.all?.estate);
    
    // Load nature of development list
    loadNatureOfDevelopmentList(data.all?.nature_of_devt);
    
    // Load nature of instrument list
    loadNatureOfInstrumentList(data.all?.nature_of_instrument);
    
    // Set covenanted user and current use
    setTimeout(() => {
        $("#rt_e_convenant_user").val(data.all?.covenanted_user || "");
        $("#rt_e_current_use").val(data.all?.current_use || "");
    }, 500);
});

// Load estate list
function loadEstateList(selectedEstateId) {
    // console.log(selectedEstateId);
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: { request_type: "get_estate_list" },
        cache: false,
        success: function (response) {
            try {
                const estates = JSON.parse(response);
                const select = $("#rt_e_estate");
                select.empty();
                select.append('<option value="">-- Select Estate --</option>');
                
                estates.forEach(function (estate) {
                    const option = $(`<option value="${estate.ge_id}">${estate.ge_location_name}</option>`);
                    if (estate.ge_id == selectedEstateId) {
                        option.attr('selected', true);
                    }
                    select.append(option);
                });
                
                // Trigger change for Bootstrap validation
                select.trigger('change');
            } catch (e) {
                console.error("Error parsing estate list:", e);
                Swal.fire({
                    icon: 'error',
                    title: 'Data Error',
                    text: 'Failed to load estate list.'
                });
            }
        },
        error: function (xhr, status, error) {
            console.error("Error fetching estate list:", error);
            Swal.fire({
                icon: 'error',
                title: 'Connection Error',
                text: 'Failed to load estate list. Please try again.'
            });
        }
    });
}

// Load nature of development list
function loadNatureOfDevelopmentList(selectedNature) {
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: { request_type: "get_nature_of_development_list" },
        cache: false,
        success: function (response) {
            try {
                const developments = JSON.parse(response);
                const select = $("#rt_e_nature_of_dev");
                select.empty();
                select.append('<option value="">-- Select --</option>');
                
                developments.forEach(function (dev) {
                    const option = $(`<option value="${dev.na_name}">${dev.na_name}</option>`);
                    if (dev.na_name == selectedNature) {
                        option.attr('selected', true);
                    }
                    select.append(option);
                });
            } catch (e) {
                console.error("Error parsing development list:", e);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error fetching development list:", error);
        }
    });
}

// Load nature of instrument list
function loadNatureOfInstrumentList(selectedInstrument) {
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: { request_type: "get_nature_of_instrument_list" },
        cache: false,
        success: function (response) {
            try {
                const instruments = JSON.parse(response);
                const select = $("#rt_e_nature_of_instrument");
                select.empty();
                select.append('<option value="">-- Select --</option>');
                
                instruments.forEach(function (instrument) {
                    const option = $(`<option value="${instrument.nt_name}">${instrument.nt_name}</option>`);
                    if (instrument.nt_name == selectedInstrument) {
                        option.attr('selected', true);
                    }
                    select.append(option);
                });
            } catch (e) {
                console.error("Error parsing instrument list:", e);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error fetching instrument list:", error);
        }
    });
}

// Calculate expiry date when commencement date or term changes
$(document).on('change', '#rt_e_commencement_date, #rt_e_term', function () {
    const commDate = $("#rt_e_commencement_date").val();
    const term = $("#rt_e_term").val();
    
    if (commDate && term) {
        const expiryDate = new Date(commDate);
        expiryDate.setFullYear(expiryDate.getFullYear() + parseInt(term));
        $("#rt_expiry_date").val(expiryDate.toISOString().split('T')[0]);
    }
});

// Form validation and save handler
$(document).on('click', '#btn_save_edit_rent_client_details', function (e) {
    e.preventDefault();
    
    const form = document.getElementById('editlegderForm');
    
    // Form validation
    if (!form.checkValidity()) {
        form.classList.add('was-validated');
        Swal.fire({
            icon: 'warning',
            title: 'Validation Error',
            html: `
                <div class="text-start">
                    <p class="mb-2">Please fill all required fields correctly:</p>
                    <ul class="text-start">
                        ${getValidationErrors(form)}
                    </ul>
                </div>
            `,
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'Fix Errors',
            width: '500px'
        });
        return;
    }
    
    // Get form data for preview
    const formData = getFormDataPreview();
    
    // Show confirmation dialog with form data preview
    Swal.fire({
        title: 'Confirm Update',
        html: `
            <div class="text-start">
                <p class="mb-3"><strong>Are you sure you want to update this lease record?</strong></p>
                
                <div class="alert alert-info py-2 mb-3">
                    <small>
                        <i class="fas fa-info-circle me-1"></i>
                        You are about to update: <strong>${formData.owners_name || 'Unknown'}</strong>
                    </small>
                </div>
                
                <div class="preview-section mb-2">
                    <table class="table table-sm table-bordered bg-light">
                        <tbody>
                            <tr>
                                <td class="fw-semibold" style="width: 40%">Plot Number:</td>
                                <td>${formData.plot_number || 'N/A'}</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">File Number:</td>
                                <td>${formData.file_number || 'N/A'}</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">Lease Term:</td>
                                <td>${formData.term || '0'} years</td>
                            </tr>
                            <tr>
                                <td class="fw-semibold">Rent Outstanding:</td>
                                <td>GHS ${parseFloat(formData.rent_outstanding || 0).toFixed(2)}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="confirmUpdateCheckbox">
                    <label class="form-check-label" for="confirmUpdateCheckbox">
                        I have verified all information is correct
                    </label>
                </div>
                
                <div class="text-muted small">
                    <i class="fas fa-exclamation-triangle me-1"></i>
                    This action cannot be undone. Please review carefully.
                </div>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#198754',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-save me-1"></i> Yes, Update Now',
        cancelButtonText: '<i class="fas fa-times me-1"></i> Cancel',
        showLoaderOnConfirm: true,
        preConfirm: () => {
            const checkbox = document.getElementById('confirmUpdateCheckbox');
            if (!checkbox.checked) {
                Swal.showValidationMessage('Please confirm that you have verified the information');
                return false;
            }
            return true;
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed) {
            // Proceed with saving
            saveLeaseDetails();
        }
    });
});

// Function to get form validation errors
function getValidationErrors(form) {
    const invalidFields = form.querySelectorAll(':invalid');
    let errorsHtml = '';
    
    invalidFields.forEach(field => {
        const fieldName = field.previousElementSibling?.textContent || field.id;
        errorsHtml += `<li><strong>${fieldName}:</strong> ${field.validationMessage || 'Required field'}</li>`;
    });
    
    return errorsHtml || '<li>Please check all required fields marked with *</li>';
}

// Function to get form data for preview
function getFormDataPreview() {
    return {
        owners_name: $("#rt_e_leasee_name").val(),
        plot_number: $("#rt_e_plot_number").val(),
        file_number: $("#rt_e_file_number").val(),
        term: $("#rt_e_term").val(),
        rent_outstanding: $("#rt_e_rent_outstanding").val(),
        address: $("#rt_e_leasee_address").val(),
        mobile: $("#rt_e_mobile_phone_1").val(),
        estate: $("#rt_e_estate option:selected").text() || $("#rt_e_estate").val()
    };
}

// Function to save lease details
function saveLeaseDetails() {
    // Prepare full data object
    
    const formData = {
        request_type: 'add_update_rent_leasee_details',
        rent_id: $("#rt_e_rent_id").val(),
        parcel_id: $('#rt_e_parcel_id').val(),
        owners_name: $("#rt_e_leasee_name").val(),
        address: $("#rt_e_leasee_address").val(),
        mobile: $("#rt_e_mobile_phone_1").val(),
        mobile_1: $("#rt_e_mobile_phone_2").val(),
        email: $("#rt_e_email").val(),
        digital_address: $("#rt_e_leasee_digital_address").val(),
        file_number: $("#rt_e_file_number").val(),
        ledger: $("#rt_e_ledger").val(),
        folio: $("#rt_e_folio").val(),
        plot_number: $("#rt_e_plot_number").val(),
        plot_size: $("#rt_e_plot_size").val(),
        covenanted_user: $("#rt_e_convenant_user").val(),
        current_use: $("#rt_e_current_use").val(),
        nature_of_devt: $("#rt_e_nature_of_dev").val(),
        parcel_address: $("#rt_e_parcel_address").val(),
        ls_number: $("#rt_e_ls_number").val(),
        comm_date: $("#rt_e_commencement_date").val(),
        term: $("#rt_e_term").val(),
        estate: $('#rt_e_estate').val().replace('.0', ''),
        nature_of_instrument: $("#rt_e_nature_of_instrument").val(),
        rent_category: $("#rt_e_rent_category").val(),
        rent_review_clause: $("#rt_e_rent_review_clause").val(),
        rent_passing: $("#rt_e_rent_passing").val(),
        location_rate: $("#rt_e_location_rate").val(),
        last_payment_date: $("#rt_e_last_payment_date").val(),
        last_payment_period: $("#rt_e_last_payment_period").val(),
        rent_outstanding: $("#rt_e_rent_outstanding").val(),
        period_in_arrears: $("#rt_e_period_in_arrears").val(),
        remarks: $("#rt_e_remarks").val(),
        glpin: $("#rt_e_glpin").val()
    };
    
    // Show loading with progress indicator
    let timerInterval;
    Swal.fire({
        title: 'Updating Lease Details',
        html: `
            <div class="text-center">
                <div class="mb-3">
                    <i class="fas fa-sync-alt fa-spin fa-2x text-primary"></i>
                </div>
                <div class="progress" style="height: 8px;">
                    <div class="progress-bar progress-bar-striped progress-bar-animated" 
                         role="progressbar" style="width: 0%"></div>
                </div>
                <p class="mt-2 mb-0 text-muted" id="swal-progress-text">Processing request...</p>
            </div>
        `,
        allowOutsideClick: false,
        didOpen: () => {
            const progressBar = Swal.getHtmlContainer().querySelector('.progress-bar');
            const progressText = Swal.getHtmlContainer().querySelector('#swal-progress-text');
            let progress = 0;
            
            timerInterval = setInterval(() => {
                progress += 10;
                if (progress <= 90) {
                    progressBar.style.width = `${progress}%`;
                    progressText.textContent = progress < 50 
                        ? 'Processing request...' 
                        : 'Saving to database...';
                }
            }, 300);
        },
        willClose: () => {
            clearInterval(timerInterval);
        }
    });
    
    // Send AJAX request
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: formData,
        cache: false,
        success: function (response) {
            Swal.close();
            
            try {
                const result = JSON.parse(response);
                
                if (result.success) {
                    // Success notification with options
                    Swal.fire({
                        title: 'Success!',
                        html: `
                            <div class="text-center">
                                <div class="mb-3">
                                    <i class="fas fa-check-circle fa-3x text-success"></i>
                                </div>
                                <p class="mb-2"><strong>Lease details updated successfully!</strong></p>
                                <div class="alert alert-success py-2">
                                    <small>
                                        <i class="fas fa-check me-1"></i>
                                        Record for <strong>${formData.owners_name}</strong> has been updated
                                    </small>
                                </div>
                            </div>
                        `,
                        showCancelButton: true,
                        confirmButtonColor: '#198754',
                        cancelButtonColor: '#6c757d',
                        confirmButtonText: '<i class="fas fa-eye me-1"></i> View Updated Record',
                        cancelButtonText: '<i class="fas fa-times me-1"></i> Close',
                        showDenyButton: true,
                        denyButtonColor: '#0d6efd',
                        width: '500px'
                    }).then((result) => {
                        $('#editlegder').modal('hide');
                        
                        if (result.isConfirmed) {
                            // Trigger search to refresh table
                            $('#btn_rt_search').click();
                            // Optionally scroll to the updated record
                            highlightUpdatedRecord(formData.rent_id);
                        
                        } else {
                            // Just refresh the table
                            $('#btn_rt_search').click();
                        }
                    });
                } else {
                    // Error handling
                    let errorMessage = result.message || 'Failed to update lease details.';
                    
                    // Check for specific error types
                    if (errorMessage.includes('duplicate') || errorMessage.includes('already exists')) {
                        errorMessage = `
                            <div class="text-start">
                                <p class="mb-2"><strong>Duplicate Entry Detected!</strong></p>
                                <p class="mb-1">A record with similar details already exists:</p>
                                <ul class="text-start">
                                    ${result.duplicate_details ? 
                                        Object.entries(result.duplicate_details)
                                            .map(([key, value]) => `<li><strong>${key}:</strong> ${value}</li>`)
                                            .join('') 
                                        : '<li>Please check for duplicate plot numbers or file numbers</li>'}
                                </ul>
                            </div>
                        `;
                    }
                    
                    Swal.fire({
                        icon: 'error',
                        title: 'Update Failed',
                        html: errorMessage,
                        confirmButtonColor: '#dc3545',
                        confirmButtonText: 'Try Again',
                        width: '500px'
                    });
                }
            } catch (e) {
                console.error('Error parsing response:', e);
                Swal.fire({
                    icon: 'error',
                    title: 'Server Error',
                    text: 'Invalid response from server. Please contact support.',
                    confirmButtonColor: '#dc3545'
                });
            }
        },
        error: function (xhr, status, error) {
            Swal.close();
            console.error('AJAX Error:', error);
            
            // Check for specific error types
            let errorMessage = 'Failed to save changes. ';
            if (xhr.status === 0) {
                errorMessage += 'No network connection.';
            } else if (xhr.status === 404) {
                errorMessage += 'Server endpoint not found.';
            } else if (xhr.status === 500) {
                errorMessage += 'Server error. Please try again later.';
            } else {
                errorMessage += 'Please check your connection.';
            }
            
            Swal.fire({
                icon: 'error',
                title: 'Connection Error',
                html: `
                    <div class="text-start">
                        <p class="mb-2">${errorMessage}</p>
                        <div class="alert alert-danger py-2 mt-2">
                            <small>
                                <i class="fas fa-exclamation-triangle me-1"></i>
                                <strong>Error Details:</strong> ${error}
                            </small>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-sm btn-outline-primary" onclick="retrySave()">
                                <i class="fas fa-redo me-1"></i> Retry
                            </button>
                            <button class="btn btn-sm btn-outline-secondary ms-2" onclick="Swal.close()">
                                <i class="fas fa-times me-1"></i> Cancel
                            </button>
                        </div>
                    </div>
                `,
                confirmButtonText: 'OK',
                showConfirmButton: false,
                width: '500px'
            });
        }
    });
}

// Function to highlight updated record in table
function highlightUpdatedRecord(rentId) {
    setTimeout(() => {
        const row = datatable.row(`[data-rent-id="${rentId}"]`).node();
        if (row) {
            $(row).addClass('table-success');
            $('html, body').animate({
                scrollTop: $(row).offset().top - 100
            }, 1000);
            
            // Remove highlight after 3 seconds
            setTimeout(() => {
                $(row).removeClass('table-success');
            }, 3000);
        }
    }, 1000);
}

// Function to retry save operation
function retrySave() {
    Swal.close();
    // Trigger save again after a short delay
    setTimeout(() => {
        $('#btn_save_edit_rent_client_details').click();
    }, 500);
}

// Add change detection to prevent accidental data loss
$(document).on('input', '#editlegderForm input, #editlegderForm select, #editlegderForm textarea', function() {
    // Mark form as modified
    $('#editlegderForm').addClass('form-modified');
    
    // Add visual indicator to save button
    $('#btn_save_edit_rent_client_details').addClass('btn-pulse');
    
    // Remove indicator after 2 seconds if no more changes
    clearTimeout(window.formChangeTimer);
    window.formChangeTimer = setTimeout(() => {
        $('#btn_save_edit_rent_client_details').removeClass('btn-pulse');
    }, 2000);
});

// Prevent accidental closure of modal with unsaved changes
$('#editlegder').on('hide.bs.modal', function(e) {
    if ($('#editlegderForm').hasClass('form-modified')) {
        e.preventDefault();
        
        Swal.fire({
            title: 'Unsaved Changes',
            html: `
                <div class="text-start">
                    <p class="mb-3">You have unsaved changes. What would you like to do?</p>
                    <div class="alert alert-warning py-2">
                        <small>
                            <i class="fas fa-exclamation-triangle me-1"></i>
                            Changes will be lost if you close without saving.
                        </small>
                    </div>
                </div>
            `,
            icon: 'warning',
            showCancelButton: true,
            showDenyButton: true,
            confirmButtonText: '<i class="fas fa-save me-1"></i> Save & Close',
            denyButtonText: '<i class="fas fa-times me-1"></i> Discard Changes',
            cancelButtonText: '<i class="fas fa-arrow-left me-1"></i> Continue Editing',
            confirmButtonColor: '#198754',
            denyButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            reverseButtons: true,
            width: '500px'
        }).then((result) => {
            if (result.isConfirmed) {
                // Save and close
                saveLeaseDetails();
                $('#editlegderForm').removeClass('form-modified');
            } else if (result.isDenied) {
                // Discard changes and close
                $('#editlegderForm').removeClass('form-modified');
                $('#editlegder').modal('hide');
            }
            // If cancelled, do nothing (continue editing)
        });
        
        return false;
    }
});

// Clear validation when modal is hidden
$('#editlegder').on('hidden.bs.modal', function () {
    const form = document.getElementById('editlegderForm');
    form.classList.remove('was-validated');
    window.editModalData = null;
});

// Format currency inputs on blur
$(document).on('blur', '#rt_e_rent_passing, #rt_e_location_rate, #rt_e_rent_outstanding', function () {
    const value = parseFloat($(this).val()) || 0;
    $(this).val(value.toFixed(2));
});

// Format numeric inputs
$(document).on('blur', '#rt_e_plot_size, #rt_e_term, #rt_e_rent_review_clause', function () {
    const value = parseFloat($(this).val()) || 0;
    $(this).val(value.toFixed(1));
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
                           // $.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">Data saved successfully.</span>' }, { type: 'success',z_index: 9999 });
                        } else {
                            //$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Error occurred, try again.</span>' }, { type: 'danger',z_index: 9999 });
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
                                
                                //+'data-modal_label="Edit Lessee"'
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
                                +'<a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#singlerentdemandnotice"'
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


                                +'<a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#rentdocuments"'
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

let currentLesseeData = {};
    
    // Handle modal shown event
    $('#paymenthistory').on('shown.bs.modal', function(e) {
        // Get data from the triggering element
        const button = $(e.relatedTarget);
        const rentId = button.data('m_id') || button.data('rent_id');
        
        // Store rent ID
        $('#rt_rent_id').val(rentId || '0');
        
        // Store additional data if available
        currentLesseeData = {
            rent_id: rentId,
            owners_name: button.data('owners_name'),
            plot_number: button.data('plot_number'),
            account_number: button.data('account_number')
        };
        
        // Update record info
        updateRecordInfo();
        
        // Set default date to today
        const today = new Date().toISOString().split('T')[0];
        $('#payment_date').val(today);
        
        // Clear previous data
        clearPaymentTable();
        
        // Reset form
        $('#addPaymentForm')[0].reset();
        $('#addPaymentForm').removeClass('was-validated');
    });
    
    // Load Payments button
    $('#btn_load_payments').on('click', function() {
        const rentId = $('#rt_rent_id').val();
        
        if (!rentId || rentId === '0') {
            Swal.fire({
                icon: 'warning',
                title: 'Missing Information',
                text: 'Please select a lease record first.',
                confirmButtonColor: '#3085d6'
            });
            return;
        }
        
        loadPaymentHistory(rentId);
    });
    
    // Save Payment form submission
    $('#addPaymentForm').on('submit', function(e) {
        e.preventDefault();
        saveNewPayment();
    });
    
    // Search functionality
    $('#paymentSearch').on('keyup', function() {
        const searchTerm = $(this).val().toLowerCase();
        filterPayments(searchTerm);
    });
    
    // Clear search
    $('#clearSearch').on('click', function() {
        $('#paymentSearch').val('');
        filterPayments('');
    });
    
    // Export handlers
    $('#exportPDF').on('click', function(e) {
        e.preventDefault();
        exportPayments('pdf');
    });
    
    $('#exportExcel').on('click', function(e) {
        e.preventDefault();
        exportPayments('excel');
    });
    
    $('#exportCSV').on('click', function(e) {
        e.preventDefault();
        exportPayments('csv');
    });

        // Function to update record information
function updateRecordInfo() {
    const info = currentLesseeData;
    let infoText = '';
    
    if (info.owners_name) {
        infoText = `${info.owners_name}`;
        if (info.plot_number) {
            infoText += ` | Plot: ${info.plot_number}`;
        }
        if (info.account_number) {
            infoText += ` | Account: ${info.account_number}`;
        }
    } else {
        infoText = 'Select a lease to view payment history';
    }
    
    $('#recordInfo').text(infoText);
}

// Function to load payment history
function loadPaymentHistory(rentId) {
    // Show loading state
    $('#btn_load_payments').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i> Loading...');
    
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: {
            request_type: 'get_payment_history',
            rent_id: rentId
        },
        cache: false,
        success: function(response) {
            $('#btn_load_payments').prop('disabled', false).html('<i class="fas fa-sync-alt me-2"></i> Load Payments');
            
            try {
                const result = JSON.parse(response);
                
                if (result.success && result.data) {
                    populatePaymentTable(result.data.payments);
                    updatePaymentStatistics(result.data);
                    
                    Swal.fire({
                        icon: 'success',
                        title: 'Payments Loaded',
                        text: `Loaded ${result.data.payments.length} payment record(s)`,
                        timer: 1500,
                        showConfirmButton: false
                    });
                } else {
                    clearPaymentTable();
                    Swal.fire({
                        icon: 'info',
                        title: 'No Payments Found',
                        text: 'No payment records found for this lease.',
                        confirmButtonColor: '#3085d6'
                    });
                }
            } catch (e) {
                console.error('Error parsing response:', e);
                Swal.fire({
                    icon: 'error',
                    title: 'Data Error',
                    text: 'Failed to parse payment data.',
                    confirmButtonColor: '#dc3545'
                });
            }
        },
        error: function(xhr, status, error) {
            $('#btn_load_payments').prop('disabled', false).html('<i class="fas fa-sync-alt me-2"></i> Load Payments');
            
            Swal.fire({
                icon: 'error',
                title: 'Connection Error',
                text: 'Failed to load payment history.',
                confirmButtonColor: '#dc3545'
            });
        }
    });
}

// Function to populate payment table
function populatePaymentTable(payments) {
    const tbody = $('#paymentHistoryBody');
    tbody.empty();
    
    if (payments && payments.length > 0) {
        $('#noPaymentData').remove();
        
        let totalAmount = 0;
        
        payments.forEach((payment, index) => {
            const amount = parseFloat(payment.amount || 0);
            totalAmount += amount;
            
            // Format date
            const paymentDate = payment.payment_date ? 
                new Date(payment.payment_date).toLocaleDateString('en-GH', {
                    day: '2-digit',
                    month: 'short',
                    year: 'numeric'
                }) : '-';
            
            // Get payment method icon
            const methodClass = getPaymentMethodClass(payment.payment_mode);
            
            // Get status badge
            const statusBadge = getPaymentStatusBadge(payment.status);
            
            const row = `
                <tr>
                    <td class="text-center">
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item view-payment" href="#" data-id="${payment.id}">
                                        <i class="fas fa-eye me-2"></i> View Details
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item print-receipt" href="#" data-id="${payment.id}">
                                        <i class="fas fa-print me-2"></i> Print Receipt
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger reverse-payment" href="#" data-id="${payment.id}">
                                        <i class="fas fa-undo me-2"></i> Reverse Payment
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </td>
                    <td class="text-center">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-${getPaymentMethodIcon(payment.payment_mode)} ${methodClass} me-2"></i>
                            <span>${payment.payment_mode || '-'}</span>
                        </div>
                    </td>
                    <td class="text-end fw-semibold text-danger">
                        GHS ${parseFloat(payment.arrears_amount || 0).toFixed(2)}
                    </td>
                    <td class="text-center">
                        <span class="badge bg-light text-dark">${payment.receipt_no || '-'}</span>
                    </td>
                    <td class="text-center">
                        ${paymentDate}
                    </td>
                    <td class="text-end fw-bold text-success">
                        GHS ${amount.toFixed(2)}
                    </td>
                    <td class="text-center">
                        ${statusBadge}
                    </td>
                    <td class="text-center">
                        <small class="text-muted">${payment.recorded_by || 'System'}</small>
                    </td>
                </tr>
            `;
            
            tbody.append(row);
        });
        
        // Update summary
        $('#paymentCount').text(`${payments.length} payment${payments.length !== 1 ? 's' : ''}`);
        $('#totalPaid').text(`GHS ${totalAmount.toFixed(2)}`);
        $('#summaryTotalPaid').text(`GHS ${totalAmount.toFixed(2)}`);
        $('#summaryPaymentCount').text(`${payments.length} payment${payments.length !== 1 ? 's' : ''}`);
        
        $('#paymentSummary').show();
    } else {
        tbody.html(`
            <tr id="noPaymentData">
                <td colspan="8" class="text-center py-5">
                    <div class="text-muted">
                        <i class="fas fa-history fa-2x mb-3"></i>
                        <p class="mb-2 fw-semibold">No Payment History Available</p>
                        <small>No payment records found for this lease</small>
                    </div>
                </td>
            </tr>
        `);
        $('#paymentSummary').hide();
        $('#paymentCount').text('0 payments');
        $('#totalPaid').text('GHS 0.00');
    }
    
    // Add event listeners to action buttons
    addPaymentActionListeners();
}

// Helper function to get payment method icon
function getPaymentMethodIcon(method) {
    const icons = {
        'Cash': 'money-bill',
        'Cheque': 'file-invoice',
        'Bank Transfer': 'university',
        'Mobile Money': 'mobile-alt',
        'Online Payment': 'globe'
    };
    return icons[method] || 'credit-card';
}

// Helper function to get payment method class
function getPaymentMethodClass(method) {
    const classes = {
        'Cash': 'payment-method-cash',
        'Cheque': 'payment-method-cheque',
        'Bank Transfer': 'payment-method-transfer',
        'Mobile Money': 'payment-method-mobile'
    };
    return classes[method] || '';
}

// Helper function to get payment status badge
function getPaymentStatusBadge(status) {
    const statusMap = {
        'paid': { class: 'badge-paid', text: 'Paid' },
        'pending': { class: 'badge-pending', text: 'Pending' },
        'reversed': { class: 'badge-reversed', text: 'Reversed' }
    };
    
    const statusInfo = statusMap[status] || { class: 'badge-secondary', text: 'Unknown' };
    return `<span class="badge ${statusInfo.class}">${statusInfo.text}</span>`;
}

// Function to save new payment
function saveNewPayment() {
    const form = document.getElementById('addPaymentForm');
    
    if (!form.checkValidity()) {
        form.classList.add('was-validated');
        Swal.fire({
            icon: 'warning',
            title: 'Validation Error',
            text: 'Please fill all required fields correctly.',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    const formData = {
        request_type: 'save_payment',
        rent_id: $('#rt_rent_id').val(),
        payment_mode: $('#py_payment_mode').val(),
        receipt_no: $('#receipt_no').val(),
        arrears_amount: $('#arrears_amount').val(),
        period_in_arrears: $('#period_in_arrears').val(),
        payment_amount: $('#payment_amount').val(),
        last_payment_period: $('#last_payment_period').val(),
        payment_date: $('#payment_date').val(),
        payment_remarks: $('#payment_remarks').val()
    };
    
    // Show confirmation
    Swal.fire({
        title: 'Confirm Payment',
        html: `
            <div class="text-start">
                <p class="mb-3">Are you sure you want to record this payment?</p>
                <div class="alert alert-info py-2 mb-3">
                    <div class="d-flex justify-content-between">
                        <span>Amount:</span>
                        <span class="fw-bold">GHS ${parseFloat(formData.payment_amount).toFixed(2)}</span>
                    </div>
                    <div class="d-flex justify-content-between mt-1">
                        <span>Receipt No:</span>
                        <span class="fw-bold">${formData.receipt_no}</span>
                    </div>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="confirmPayment">
                    <label class="form-check-label" for="confirmPayment">
                        I confirm this payment has been received
                    </label>
                </div>
            </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#198754',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-check-circle me-1"></i> Confirm & Save',
        cancelButtonText: 'Cancel',
        preConfirm: () => {
            const checkbox = document.getElementById('confirmPayment');
            if (!checkbox.checked) {
                Swal.showValidationMessage('Please confirm the payment has been received');
                return false;
            }
            return true;
        }
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading
            $('#btn_save_payment').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i> Saving...');
            
            $.ajax({
                type: "POST",
                url: "rent_mgt_serv",
                data: formData,
                cache: false,
                success: function(response) {
                    $('#btn_save_payment').prop('disabled', false).html('<i class="fas fa-save me-1"></i> Save Payment');
                    
                    try {
                        const result = JSON.parse(response);
                        
                        if (result.success) {
                            // Close add payment form
                            $('#addpaymentdiv').collapse('hide');
                            
                            // Reset form
                            form.reset();
                            form.classList.remove('was-validated');
                            
                            // Reload payments
                            loadPaymentHistory(formData.rent_id);
                            
                            // Show success
                            Swal.fire({
                                icon: 'success',
                                title: 'Payment Recorded!',
                                html: `
                                    <div class="text-center">
                                        <div class="mb-3">
                                            <i class="fas fa-check-circle fa-3x text-success"></i>
                                        </div>
                                        <p class="mb-2">Payment recorded successfully!</p>
                                        <div class="alert alert-success py-2">
                                            <small>
                                                <i class="fas fa-receipt me-1"></i>
                                                Receipt: <strong>${formData.receipt_no}</strong>
                                            </small>
                                        </div>
                                    </div>
                                `,
                                confirmButtonColor: '#198754'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Save Failed',
                                text: result.message || 'Failed to save payment.',
                                confirmButtonColor: '#dc3545'
                            });
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e);
                        Swal.fire({
                            icon: 'error',
                            title: 'Server Error',
                            text: 'Failed to save payment.',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    $('#btn_save_payment').prop('disabled', false).html('<i class="fas fa-save me-1"></i> Save Payment');
                    
                    Swal.fire({
                        icon: 'error',
                        title: 'Connection Error',
                        text: 'Failed to save payment.',
                        confirmButtonColor: '#dc3545'
                    });
                }
            });
        }
    });
}

// Function to update payment statistics
function updatePaymentStatistics(data) {
    if (data.statistics) {
        const stats = data.statistics;
        
        $('#totalPaymentsCount').text(stats.total_payments || '0');
        $('#avgPaymentAmount').text(`GHS ${parseFloat(stats.average_payment || 0).toFixed(2)}`);
        $('#lastPaymentDays').text(stats.days_since_last || '-');
        $('#paymentFrequency').text(stats.frequency || '-');
        
        $('#paymentStatistics').show();
    } else {
        $('#paymentStatistics').hide();
    }
}

// Function to clear payment table
function clearPaymentTable() {
    $('#paymentHistoryBody').html(`
        <tr id="noPaymentData">
            <td colspan="8" class="text-center py-5">
                <div class="text-muted">
                    <i class="fas fa-history fa-2x mb-3"></i>
                    <p class="mb-2 fw-semibold">No Payment History Available</p>
                    <small>Click "Load Payments" to fetch payment records</small>
                </div>
            </td>
        </tr>
    `);
    $('#paymentSummary').hide();
    $('#paymentStatistics').hide();
}

// Function to filter payments
function filterPayments(searchTerm) {
    const rows = $('#tbl_rent_payment_history tbody tr');
    let visibleCount = 0;
    
    rows.each(function() {
        const rowText = $(this).text().toLowerCase();
        if (rowText.includes(searchTerm)) {
            $(this).show();
            visibleCount++;
        } else {
            $(this).hide();
        }
    });
}

// Function to export payments
function exportPayments(format) {
    const rentId = $('#rt_rent_id').val();
    
    if (!rentId || rentId === '0') {
        Swal.fire({
            icon: 'warning',
            title: 'Missing Information',
            text: 'Please load payment history first.',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    Swal.fire({
        title: 'Exporting Payments',
        html: `
            <div class="text-center">
                <div class="mb-3">
                    <i class="fas fa-file-export fa-spin fa-2x text-primary"></i>
                </div>
                <p class="mb-0 text-muted">Preparing ${format.toUpperCase()} export...</p>
            </div>
        `,
        allowOutsideClick: false,
        showConfirmButton: false
    });
    
    // In a real implementation, this would generate and download the export file
    setTimeout(() => {
        Swal.close();
        Swal.fire({
            icon: 'success',
            title: 'Export Ready',
            text: `Payment history exported as ${format.toUpperCase()}`,
            confirmButtonColor: '#198754'
        });
    }, 1500);
}

// Function to add event listeners to action buttons
function addPaymentActionListeners() {
    // View payment details
    $('.view-payment').on('click', function(e) {
        e.preventDefault();
        const paymentId = $(this).data('id');
        viewPaymentDetails(paymentId);
    });
    
    // Print receipt
    $('.print-receipt').on('click', function(e) {
        e.preventDefault();
        const paymentId = $(this).data('id');
        printReceipt(paymentId);
    });
    
    // Reverse payment
    $('.reverse-payment').on('click', function(e) {
        e.preventDefault();
        const paymentId = $(this).data('id');
        reversePayment(paymentId);
    });
}

// Function to view payment details
function viewPaymentDetails(paymentId) {
    // Implementation for viewing payment details
    console.log('View payment:', paymentId);
    
    Swal.fire({
        icon: 'info',
        title: 'Payment Details',
        text: 'Payment details view would open here.',
        confirmButtonText: 'OK'
    });
}

// Function to print receipt
function printReceipt(paymentId) {
    // Implementation for printing receipt
    console.log('Print receipt:', paymentId);
    
    Swal.fire({
        icon: 'info',
        title: 'Print Receipt',
        text: 'Receipt print preview would open here.',
        confirmButtonText: 'OK'
    });
}

// Function to reverse payment
function reversePayment(paymentId) {
    Swal.fire({
        title: 'Reverse Payment',
        html: `
            <div class="text-start">
                <p class="mb-3">Are you sure you want to reverse this payment?</p>
                <div class="alert alert-danger py-2">
                    <small>
                        <i class="fas fa-exclamation-triangle me-1"></i>
                        This action cannot be undone. A reversal entry will be created.
                    </small>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="confirmReverse">
                    <label class="form-check-label" for="confirmReverse">
                        I understand this will create a reversal transaction
                    </label>
                </div>
            </div>
        `,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: '<i class="fas fa-undo me-1"></i> Reverse Payment',
        cancelButtonText: 'Cancel',
        preConfirm: () => {
            const checkbox = document.getElementById('confirmReverse');
            if (!checkbox.checked) {
                Swal.showValidationMessage('Please confirm you understand this action');
                return false;
            }
            return true;
        }
    }).then((result) => {
        if (result.isConfirmed) {
            // Implement reversal logic here
            console.log('Reverse payment:', paymentId);
            
            Swal.fire({
                icon: 'success',
                title: 'Payment Reversed',
                text: 'Payment has been reversed successfully.',
                confirmButtonColor: '#198754'
            }).then(() => {
                // Reload payments
                const rentId = $('#rt_rent_id').val();
                loadPaymentHistory(rentId);
            });
        }
    });
}

$(document).on('click', '.fileUploadModal', function() {
    $('#fileUploadModal').modal('show');
});

});

