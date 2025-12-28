// Initialize the map when the DOM is fully loaded
document.addEventListener('DOMContentLoaded', function() {

    // Export payments button
    $('#exportPayments').on('click', function() {
        Swal.fire({
            title: 'Export Payment Records',
            text: 'Select export format',
            icon: 'info',
            showCancelButton: true,
            confirmButtonText: 'Excel',
            cancelButtonText: 'PDF',
            showDenyButton: true,
            denyButtonText: 'CSV'
        }).then((result) => {
            if (result.isConfirmed) {
                exportPayments('excel');
            } else if (result.isDenied) {
                exportPayments('csv');
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                exportPayments('pdf');
            }
        });
    });
    
    // Export payments function
    function exportPayments(format) {
        // Show loading
        Swal.fire({
            title: 'Exporting...',
            text: 'Please wait while we prepare your export',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
        
        // Simulate export process
        setTimeout(() => {
            Swal.fire({
                title: 'Export Complete!',
                text: `Payment records exported as ${format.toUpperCase()}`,
                icon: 'success',
                confirmButtonColor: '#198754'
            });
        }, 1500);
    }
    
    // Add public document button
    $('.prFileUploadModal').on('click', function() {
        $('#fileUploadModal').modal('show');
    });

    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Show loading indicator when modal opens
    $('#check_review_documents').on('show.bs.modal', function() {
        // Clear existing dynamic content
        $('#documentsTableBody_gated_workflow').html('<tr id="noDocumentsRow"><td colspan="4" class="text-center py-4"><div class="text-muted"><i class="bi bi-folder-x fs-1 mb-2 d-block"></i><p class="mb-0">No documents loaded</p></div></td></tr>');
        
        // Reset statistics
        updateDocumentStatistics(0, 0, 0, 0);
    });

    // Load documents button - from your existing code
    $('#btn_load_scanned_documents_public_gated_workflow').on('click', function(e) { 
        loadDocuments();
    });

    // Refresh documents button
    $('#btn_refresh_documents').on('click', function() {
        loadDocuments();
    });

    // Export documents button
    $('#btn_export_documents').on('click', function() {
        exportDocuments();
    });

    // Save review button
    $('#btn_save_review').on('click', function() {
        saveDocumentReview();
    });

    // Show approval button toggle
    $('#showApprovalButton').on('change', function() {
        if ($(this).is(':checked')) {
            $('#btn_update_app_status_ffrv').show();
        } else {
            $('#btn_update_app_status_ffrv').hide();
        }
    });

    // Final approval button
    $('#btn_update_app_status_ffrv').on('click', function() {
        confirmFinalApproval();
    });

    // Toggle all documents for review
    $('#toggleAllDocuments').on('change', function() {
        const isChecked = $(this).is(':checked');
        $('.document-checkbox').prop('checked', isChecked);
    });


    // Function to load documents
    function loadDocuments() {
        const case_number = $("#cs_main_case_number").val();
        const tableBody = $('#documentsTableBody_gated_workflow');
        const loadingIndicator = $('#documentsLoading');
        
        if (!case_number) {
            showToast('Case number is required', 'danger');
            return;
        }
        
        // Show loading state
        loadingIndicator.removeClass('d-none');
        tableBody.html('<tr><td colspan="4" class="text-center py-4"><div class="spinner-border spinner-border-sm text-primary me-2"></div><small>Loading documents...</small></td></tr>');
        
        $.ajax({
            type: "POST",
            url: "LoadLRDJackets",
            data: {
                request_type: 'load_case_scanned_document_public_new',
                case_number: case_number
            },
            cache: false,
            success: function(serviceresponse) {
                loadingIndicator.addClass('d-none');
                
                if(!serviceresponse) {
                    tableBody.html('<tr id="noDocumentsRow"><td colspan="4" class="text-center py-4"><div class="text-muted"><i class="bi bi-folder-x fs-1 mb-2 d-block"></i><p class="mb-0">No documents found</p><small>Click "Add Documents" to upload documents</small></div></td></tr>');
                    updateDocumentStatistics(0, 0, 0, 0);
                    return;
                }
                
                try {
                    const json_p = JSON.parse(serviceresponse);
                    let html = '';
                    let totalDocs = 0;
                    
                    $(json_p).each(function () {
                        totalDocs++;
                        const docName = this.doc_description || 'Unnamed Document';
                        const docUuid = this.doc_uuid || '#';
                        const docType = this.doc_type || 'PDF';
                        
                        html += `
                            <tr>
                                <td class="align-middle">
                                    <div class="d-flex align-items-center">
                                        <!--<div class="form-check me-2">
                                            <input class="form-check-input document-checkbox" type="checkbox" value="${docUuid}">
                                        </div>
                                        <div class="avatar avatar-xs bg-light-primary rounded-circle me-2">
                                            <i class="bi bi-file-earmark"></i>
                                        </div>-->
                                        <div>
                                            <a href="${docUuid}" class="link-post fw-semibold text-decoration-none" data-bs-toggle="tooltip" data-bs-placement="top" title="Click to preview">
                                                ${docName}
                                            </a>
                                            <small class="text-muted d-block">
                                                <i class="bi bi-calendar me-1"></i> ${this.upload_date || 'Date not available'}
                                            </small>
                                        </div>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <span class="badge bg-info">
                                        ${docType}
                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge bg-secondary">.pdf</span>
                                </td>
                                <td class="align-middle text-center">
                                    <div class="d-flex justify-content-center gap-1">
                                        <button type="button" class="btn btn-outline-info btn-sm btn-preview-document"
                                                data-document-path="${docUuid}"
                                                data-document-name="${docName}">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                        <a href="${docUuid}" 
                                        class="btn btn-outline-success btn-sm" 
                                        download="${docName}"
                                        data-bs-toggle="tooltip" data-bs-placement="top" title="Download">
                                            <i class="bi bi-download"></i>
                                        </a>
                                        <!--<button type="button" class="btn btn-outline-primary btn-sm btn-open-document"
                                                data-document-path="${docUuid}">
                                            <i class="bi bi-folder2-open"></i>
                                        </button>-->
                                    </div>
                                </td>
                            </tr>
                        `;
                    });
                    
                    tableBody.html(html);
                    
                    // Update statistics
                    updateDocumentStatistics(totalDocs, 0, totalDocs, 0);
                    
                    // Initialize tooltips for new elements
                    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                    tooltipTriggerList.map(function (tooltipTriggerEl) {
                        return new bootstrap.Tooltip(tooltipTriggerEl);
                    });
                    
                    // Show success message
                    showToast(`Successfully loaded ${totalDocs} document(s)`, 'success');
                    
                } catch(e) {
                    console.error('Error parsing document data:', e);
                    tableBody.html('<tr id="noDocumentsRow"><td colspan="4" class="text-center py-4"><div class="text-muted"><i class="bi bi-exclamation-triangle fs-1 mb-2 d-block"></i><p class="mb-0">Error loading documents</p><small>Please try again</small></div></td></tr>');
                    updateDocumentStatistics(0, 0, 0, 0);
                    showToast('Error loading documents. Please try again.', 'danger');
                }
            },
            error: function(xhr, status, error) {
                loadingIndicator.addClass('d-none');
                tableBody.html('<tr id="noDocumentsRow"><td colspan="4" class="text-center py-4"><div class="text-muted"><i class="bi bi-exclamation-triangle fs-1 mb-2 d-block"></i><p class="mb-0">Error loading documents</p><small>Please try again</small></div></td></tr>');
                updateDocumentStatistics(0, 0, 0, 0);
                showToast('Error loading documents. Please try again.', 'danger');
                console.error('AJAX Error:', error);
            }
        });
    }

    // Function to update document statistics
    function updateDocumentStatistics(total, reviewed, pending, rejected) {
        $('#totalDocumentsCount').text(total);
        $('#reviewedCount').text(reviewed);
        $('#pendingCount').text(pending);
        $('#rejectedCount').text(rejected);
    }

    // Function to export documents
    function exportDocuments() {
        const case_number = $("#cs_main_case_number").val();
        
        if (!case_number) {
            showToast('Case number is required', 'danger');
            return;
        }
        
        Swal.fire({
            title: 'Export Documents',
            text: 'Select export format',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Export as CSV',
            cancelButtonText: 'Export as PDF',
            showDenyButton: true,
            denyButtonText: 'Export All Files',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Export as CSV
                exportAsCSV();
            } else if (result.isDenied) {
                // Export as ZIP (all files)
                exportAsZIP();
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                // Export as PDF report
                exportAsPDF();
            }
        });
    }

    // Function to save document review
    function saveDocumentReview() {
        const selectedDocs = [];
        $('.document-checkbox:checked').each(function() {
            selectedDocs.push($(this).val());
        });
        
        const reviewStatus = $('input[name="reviewStatus"]:checked').val();
        
        if (selectedDocs.length === 0) {
            showToast('Please select at least one document to review', 'warning');
            return;
        }
        
        if (!reviewStatus) {
            showToast('Please select a review status (Approve or Reject)', 'warning');
            return;
        }
        
        // Show confirmation
        Swal.fire({
            title: 'Confirm Review',
            html: `You are about to <strong>${reviewStatus}</strong> ${selectedDocs.length} document(s).<br><br>Are you sure?`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Yes, proceed',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading
                Swal.fire({
                    title: 'Processing...',
                    text: 'Please wait while we save your review',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Simulate API call (replace with actual AJAX call)
                setTimeout(() => {
                    Swal.fire({
                        title: 'Success!',
                        text: `Successfully ${reviewStatus}ed ${selectedDocs.length} document(s)`,
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        // Reload documents to reflect changes
                        loadDocuments();
                    });
                }, 1500);
            }
        });
    }

    // Function to confirm final approval
    function confirmFinalApproval() {
        Swal.fire({
            title: 'Final Approval',
            text: 'Are you sure you want to give final approval for all documents? This action cannot be undone.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, approve all',
            cancelButtonText: 'Cancel',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Implement final approval logic here
                showToast('Final approval submitted successfully', 'success');
            }
        });
    }

    // Helper functions
    function exportAsCSV() {
        // Implement CSV export logic
        showToast('CSV export initiated', 'info');
    }

    function exportAsPDF() {
        // Implement PDF export logic
        showToast('PDF report generation initiated', 'info');
    }

    function exportAsZIP() {
        // Implement ZIP export logic
        showToast('ZIP file download initiated', 'info');
    }

    function showToast(message, type) {
        const toast = $(`
            <div class="toast align-items-center text-white bg-${type} border-0" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        ${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        `);
        
        if (!$('#toastContainer').length) {
            $('body').append('<div id="toastContainer" class="toast-container position-fixed top-0 end-0 p-3"></div>');
        }
        
        $('#toastContainer').append(toast);
        const bsToast = new bootstrap.Toast(toast[0]);
        bsToast.show();
        
        toast.on('hidden.bs.toast', function() {
            $(this).remove();
        });
    }

    // Combined event handler for all document tables
   $(document).on('click', '.btn-preview-document', function (e) {
        e.preventDefault();

        const previewModal = bootstrap.Modal.getOrCreateInstance(
            document.getElementById('previewModal')
        );

        const previewContent = $('#previewContent');
        const previewLoading = $('#previewLoading');
        const previewError = $('#previewError');

        // Reset UI
        previewContent.addClass('d-none').empty();
        previewError.addClass('d-none');
        previewLoading.removeClass('d-none');

        previewModal.show();

        // ✅ ALWAYS USE currentTarget / this
        const file_to_open = $(this).data('document-path');

        //console.log('File path:', file_to_open);

        if (!file_to_open) {
            previewLoading.addClass('d-none');
            previewError.removeClass('d-none').text('Invalid file path');
            return;
        }

        const file_path = file_to_open.replace(/^file:\/\//, '');

        $.ajax({
            type: "POST",
            url: "open_pdffile",
            data: {
                request_type: 'request_to_generate_batch_list',
                file_to_open: file_path
            },
            xhrFields: {
                responseType: 'blob'
            },
            success: function (jobdetails) {
                const blob = new Blob([jobdetails], {
                    type: "application/pdf"
                });

                const objectUrl = URL.createObjectURL(blob);

                previewLoading.addClass('d-none');
                previewContent.removeClass('d-none').html(`
                    <iframe src="${objectUrl}"
                            width="100%"
                            height="800"
                            frameborder="0"></iframe>
                `);
            },
            error: function () {
                previewLoading.addClass('d-none');
                previewError.removeClass('d-none').text('Failed to load document');
            }
        });
    });

    $(document).on('click', '.addeditpartyGeneralBtn', function(e) {
        var party_id ='';
        //get data-id attribute of the clicked element
        var party_id = $(this).data('target-id');
        //console.log("party_id=" + party_id); 
        //populate the textbox
        $('#party_id_gen').val(party_id);
        
        $("#party_ar_name_gen").val($(this).data('ar_name')); 
        $("#party_ar_gender_gen").find('option[value="' + $(this).data('ar_gender') + '"]').prop('selected', true); 
        $("#party_ar_cell_phone_gen").val($(this).data('ar_cell_phone'));
        $("#party_ar_cell_phone2_gen").val($(this).data('ar_cell_phone2'));
        $("#party_ar_nationality_gen").find('option[value="' + $(this).data('ar_nationality') + '"]').prop('selected', true); 
        $("#party_ar_address_gen").val($(this).data('ar_address'));
        $("#party_ar_tin_no_gen").val($(this).data('ar_tin_no')); 
        $("#party_ar_id_type_gen").find('option[value="' + $(this).data('ar_id_type') + '"]').prop('selected', true); 
        $("#party_ar_id_number_gen").val($(this).data('ar_id_number'));
        $("#party_ar_type_of_party_gen").find('option[value="' + $(this).data('type_of_party') + '"]').prop('selected', true);  
        $("#party_ar_location_gen").val($(this).data('ar_location')); 
        $("#party_ar_district_gen").val($(this).data('ar_district'));
        $("#party_ar_region_gen_gen").val($(this).data('ar_region')); 
        $("#party_ar_person_type_gen").find('option[value="' + $(this).data('ar_person_type') + '"]').prop('selected', true); 

        $('#addeditpartyGeneral').modal('show');
        
    });

    $('#btnsavenewpartyGeneral').on('click', function(e) {
        // Gather form data
        const formData = {
            ar_client_id: $("#party_id_gen").val(),
            ar_name: $("#party_ar_name_gen").val().trim(),
            ar_gender: $("#party_ar_gender_gen").val(),
            ar_cell_phone: $("#party_ar_cell_phone_gen").val().trim(),
            ar_cell_phone2: $("#party_ar_cell_phone2_gen").val().trim(),
            ar_nationality: $("#party_ar_nationality_gen").val(),
            ar_address: $("#party_ar_address_gen").val().trim(),
            ar_tin_no: $("#party_ar_tin_no_gen").val().trim(),
            ar_id_type: $("#party_ar_id_type_gen").val(),
            ar_id_number: $("#party_ar_id_number_gen").val().trim(),
            ar_type_of_party: $("#party_ar_type_of_party_gen").val(),
            ar_location: $("#party_ar_location_gen").val().trim(),
            ar_district: $("#party_ar_district_gen").val(),
            ar_region: $("#party_ar_region_gen").val(),
            ar_person_type: $("#party_ar_person_type_gen").val(),
            family_name: $("#family_name_gen").val().trim(),
            grantor_family: $("#grantor_family_gen").val().trim()
        };

        // Validation
        if (!formData.ar_name) {
            Swal.fire({
                title: 'Validation Error',
                text: 'Please enter the party name',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

        if (!formData.ar_gender || formData.ar_gender === "-1") {
            Swal.fire({
                title: 'Validation Error',
                text: 'Please select gender',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

        if (!formData.ar_cell_phone) {
            Swal.fire({
                title: 'Validation Error',
                text: 'Please enter phone number',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

        if (!formData.ar_type_of_party) {
            Swal.fire({
                title: 'Validation Error',
                text: 'Please select party type',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

        // Show confirmation dialog
        const isEditMode = formData.ar_client_id !== "";
        const actionText = isEditMode ? 'update' : 'add';
        const partyName = formData.ar_name.length > 30 ? formData.ar_name.substring(0, 30) + '...' : formData.ar_name;
        
        Swal.fire({
            title: `Confirm ${isEditMode ? 'Update' : 'Addition'}`,
            html: `<div class="text-start">
                    <p>Are you sure you want to ${actionText} this party?</p>
                    <div class="alert alert-light border mt-2">
                        <div class="small">
                            <strong>Name:</strong> ${partyName}<br>
                            <strong>Type:</strong> ${formData.ar_type_of_party}<br>
                            <strong>Phone:</strong> ${formData.ar_cell_phone}<br>
                            ${formData.ar_id_number ? `<strong>ID:</strong> ${formData.ar_id_number}<br>` : ''}
                        </div>
                    </div>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: `Yes, ${isEditMode ? 'Update' : 'Add'} Party`,
            cancelButtonText: 'Cancel',
            reverseButtons: true,
            customClass: {
                confirmButton: 'btn btn-primary ms-2',
                cancelButton: 'btn btn-secondary'
            },
            buttonsStyling: false,
            showLoaderOnConfirm: true,
            preConfirm: () => {
                return new Promise((resolve, reject) => {
                    // Set grantor family and stool names
                    $('#fe_family_name').val(formData.family_name);
                    $('#fe_grantor_family').val(formData.grantor_family);

                    const created_by = localStorage.getItem('fullname');
                    const created_by_id = localStorage.getItem('userid');
                    const case_number = $("#fe_transaction_number").val() || $("#cs_main_transaction_number").val();

                    const request_type = isEditMode 
                        ? 'select_address_register_edit_general'
                        : 'select_address_register_add_new_general';

                    $.ajax({
                        type: "POST",
                        url: "Case_Management_Serv",
                        data: {
                            request_type: request_type,
                            ar_client_id: formData.ar_client_id,
                            case_number: case_number,
                            type_of_party: formData.ar_type_of_party,
                            ar_name: formData.ar_name,
                            ar_gender: formData.ar_gender,
                            ar_cell_phone: formData.ar_cell_phone,
                            ar_cell_phone2: formData.ar_cell_phone2,
                            ar_nationality: formData.ar_nationality,
                            ar_address: formData.ar_address,
                            ar_tin_no: formData.ar_tin_no,
                            ar_id_type: formData.ar_id_type,
                            ar_id_number: formData.ar_id_number,
                            ar_location: formData.ar_location,
                            ar_district: formData.ar_district,
                            ar_region: formData.ar_region,
                            ar_person_type: formData.ar_person_type,
                            created_by: created_by,
                            created_by_id: created_by_id
                        },
                        cache: false,
                        success: function(jobdetails) {
                            try {
                                const json_p = JSON.parse(jobdetails);
                                
                                // Clear table
                                const table = $('#party_details_datatable');
                                table.find("tbody tr").remove();

                                // Check if response indicates success
                                let hasSuccess = false;
                                if (json_p.message && json_p.message.includes("Success")) {
                                    hasSuccess = true;
                                } else if (json_p.length > 0) {
                                    hasSuccess = true;
                                }

                                if (hasSuccess) {
                                    // Rebuild table with new data
                                    $(json_p).each(function() {

                                        const genderBadgeClass =
                                            this.ar_gender === 'MALE'
                                                ? 'bg-info text-white'
                                                : this.ar_gender === 'FEMALE'
                                                ? 'bg-pink text-white'
                                                : 'bg-secondary text-white';

                                        const genderLabel =
                                            this.ar_gender === 'MALE'
                                                ? 'Male'
                                                : this.ar_gender === 'FEMALE'
                                                ? 'Female'
                                                : 'Other';

                                        const partyBadgeClass =
                                            this.type_of_party === 'Grantor'
                                                ? 'bg-success text-white'
                                                : this.type_of_party === 'Applicant'
                                                ? 'bg-warning text-white'
                                                : 'bg-info text-white';

                                        const phone1 = (this.ar_cell_phone || '').trim() || '--';
                                        const phone2 = (this.ar_cell_phone2 || '').trim();

                                        const rowHtml = `
                                            <tr>
                                                <!-- Name -->
                                                <td class="align-middle">
                                                    <div class="fw-semibold">${this.ar_name || '--'}</div>
                                                </td>

                                                <!-- Gender -->
                                                <td class="align-middle">
                                                    <span class="badge ${genderBadgeClass}">
                                                        ${genderLabel}
                                                    </span>
                                                </td>

                                                <!-- Contact -->
                                                <td class="align-middle">
                                                    <div class="contact-info">
                                                        <div class="d-flex align-items-center mb-1">
                                                            <i class="bi bi-phone text-primary me-2"></i>
                                                            <small>${phone1}</small>
                                                        </div>

                                                        ${
                                                            phone2
                                                                ? `
                                                            <div class="d-flex align-items-center">
                                                                <i class="bi bi-telephone-plus text-secondary me-2"></i>
                                                                <small>${phone2}</small>
                                                            </div>
                                                            `
                                                                : ''
                                                        }
                                                    </div>
                                                </td>

                                                <!-- Party Type -->
                                                <td class="align-middle">
                                                    <span class="badge ${partyBadgeClass}">
                                                        ${this.type_of_party || '--'}
                                                    </span>
                                                </td>

                                                <!-- Actions -->
                                                <td class="align-middle text-center">
                                                    <div class="d-flex justify-content-center gap-2">

                                                        <!-- Edit -->
                                                        <button class="btn btn-outline-primary btn-sm addeditpartyGeneralBtn"
                                                                data-bs-placement="top"
                                                                data-bs-title="Edit Party"
                                                                data-target-id="${this.ar_client_id || ''}"
                                                                data-ar_name="${this.ar_name || ''}"
                                                                data-ar_gender="${this.ar_gender || ''}"
                                                                data-ar_address="${this.ar_address || ''}"
                                                                data-ar_cell_phone="${this.ar_cell_phone || ''}"
                                                                data-ar_cell_phone2="${this.ar_cell_phone2 || ''}"
                                                                data-ar_tin_no="${this.ar_tin_no || ''}"
                                                                data-ar_id_type="${this.ar_id_type || ''}"
                                                                data-ar_id_number="${this.ar_id_number || ''}"
                                                                data-ar_location="${this.ar_location || ''}"
                                                                data-ar_district="${this.ar_district || ''}"
                                                                data-ar_region="${this.ar_region || ''}"
                                                                data-type_of_party="${this.type_of_party || ''}"
                                                                data-ar_person_type="${this.ar_person_type || ''}"
                                                                data-p_uid="${this.p_uid || ''}"
                                                                data-ar_id="${this.ar_id || ''}">
                                                            <i class="bi bi-pencil"></i> Edit
                                                        </button>

                                                        <!-- Delete -->
                                                        <button class="btn btn-outline-danger btn-sm"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#deletepartyGeneral"
                                                                data-bs-placement="top"
                                                                data-bs-title="Delete Party"
                                                                data-target-id="${this.ar_client_id || ''}"
                                                                data-ar_name="${this.ar_name || ''}"
                                                                data-ar_gender="${this.ar_gender || ''}"
                                                                data-ar_address="${this.ar_address || ''}"
                                                                data-ar_cell_phone="${this.ar_cell_phone || ''}"
                                                                data-ar_cell_phone2="${this.ar_cell_phone2 || ''}"
                                                                data-ar_tin_no="${this.ar_tin_no || ''}"
                                                                data-ar_id_type="${this.ar_id_type || ''}"
                                                                data-ar_id_number="${this.ar_id_number || ''}"
                                                                data-ar_location="${this.ar_location || ''}"
                                                                data-ar_district="${this.ar_district || ''}"
                                                                data-ar_region="${this.ar_region || ''}"
                                                                data-type_of_party="${this.type_of_party || ''}"
                                                                data-ar_person_type="${this.ar_person_type || ''}"
                                                                data-p_uid="${this.p_uid || ''}"
                                                                data-ar_id="${this.ar_id || ''}">
                                                            <i class="bi bi-trash"></i> Delete
                                                        </button>

                                                    </div>
                                                </td>
                                            </tr>
                                        `;
                                        table.append(rowHtml);
                                    });
                                    
                                    resolve({
                                        success: true,
                                        message: `Party ${isEditMode ? 'updated' : 'added'} successfully!`,
                                        isEditMode: isEditMode
                                    });
                                } else {
                                    reject('Failed to save party. Please try again.');
                                }
                            } catch (error) {
                                console.error('Error parsing response:', error);
                                reject('Invalid response from server. Please try again.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('AJAX Error:', error);
                            reject('Network error occurred. Please check your connection and try again.');
                        }
                    });
                });
            },
            allowOutsideClick: () => !Swal.isLoading()
        }).then((result) => {
            if (result.isConfirmed && result.value && result.value.success) {
                Swal.fire({
                    title: 'Success!',
                    text: result.value.message,
                    icon: 'success',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'OK',
                    timer: 3000,
                    timerProgressBar: true,
                    willClose: () => {
                        // Close the modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('addeditpartyGeneral'));
                        if (modal) {
                            modal.hide();
                        }
                        
                        // Reset form
                        if (!result.value.isEditMode) {
                            $('#party_id_gen').val('');
                            $('#party_ar_name_gen').val('');
                            $('#party_ar_gender_gen').val('');
                            $('#party_ar_cell_phone_gen').val('');
                            $('#party_ar_cell_phone2_gen').val('');
                            $('#party_ar_nationality_gen').val('Ghanaian');
                            $('#party_ar_address_gen').val('');
                            $('#party_ar_tin_no_gen').val('');
                            $('#party_ar_id_type_gen').val('');
                            $('#party_ar_id_number_gen').val('');
                            $('#party_ar_type_of_party_gen').val('');
                            $('#party_ar_location_gen').val('');
                            $('#party_ar_district_gen').val('');
                            $('#party_ar_region_gen').val('');
                            $('#party_ar_person_type_gen').val('Natural Person');
                            $('#family_name_gen').val('');
                            $('#grantor_family_gen').val('');
                        }
                        
                        // Refresh any other UI components if needed
                        if (typeof refreshPartyStatistics === 'function') {
                            refreshPartyStatistics();
                        }
                    }
                });
            }
        }).catch((error) => {
            if (error) {
                Swal.fire({
                    title: 'Error!',
                    text: error,
                    icon: 'error',
                    confirmButtonColor: '#d33',
                    confirmButtonText: 'OK'
                });
            }
        });
    });

    $(document).on('click', '.deletepartyGeneralBtn', function() {
        const targetId = $(this).data('target-id');
        const ar_id = $(this).data('ar_id');
        const p_uid = $(this).data('p_uid');
        const case_number = $("#fe_transaction_number").val() || $("#cs_main_transaction_number").val();
        const job_number = $("#cs_main_job_number").val();
        
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel',
            reverseButtons: true,
            customClass: {
                confirmButton: 'btn btn-primary ms-2',
                cancelButton: 'btn btn-secondary'
            },
            buttonsStyling: false,
            showLoaderOnConfirm: true,
            preConfirm: () => {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: "Case_Management_Serv",
                        data: {
                            request_type: 'select_delete_party',
                            ar_client_id: targetId,
                            case_number: case_number,
                            job_number: job_number,
                            ar_id: parseInt(ar_id),
							p_uid: parseInt(p_uid)
                        },
                        cache: false,
                        success: function(jobdetails) {
                            try {
                                const json_p = JSON.parse(jobdetails);
                                
                                // Clear table
                                const table = $('#party_details_datatable');
                                table.find("tbody tr").remove();

                                // Check if response indicates success
                                let hasSuccess = false;
                                if (json_p.message && json_p.message.includes("Success")) {
                                    hasSuccess = true;
                                } else if (json_p.length > 0) {
                                    hasSuccess = true;
                                }

                                if (hasSuccess) {
                                    // Rebuild table with new data
                                    $(json_p).each(function() {

                                        const genderBadgeClass =
                                            this.ar_gender === 'MALE'
                                                ? 'bg-info text-white'
                                                : this.ar_gender === 'FEMALE'
                                                ? 'bg-pink text-white'
                                                : 'bg-secondary text-white';

                                        const genderLabel =
                                            this.ar_gender === 'MALE'
                                                ? 'Male'
                                                : this.ar_gender === 'FEMALE'
                                                ? 'Female'
                                                : 'Other';

                                        const partyBadgeClass =
                                            this.type_of_party === 'Grantor'
                                                ? 'bg-success text-white'
                                                : this.type_of_party === 'Applicant'
                                                ? 'bg-warning text-white'
                                                : 'bg-info text-white';

                                        const phone1 = (this.ar_cell_phone || '').trim() || '--';
                                        const phone2 = (this.ar_cell_phone2 || '').trim();

                                        const rowHtml = `
                                            <tr>
                                                <!-- Name -->
                                                <td class="align-middle">
                                                    <div class="fw-semibold">${this.ar_name || '--'}</div>
                                                </td>

                                                <!-- Gender -->
                                                <td class="align-middle">
                                                    <span class="badge ${genderBadgeClass}">
                                                        ${genderLabel}
                                                    </span>
                                                </td>

                                                <!-- Contact -->
                                                <td class="align-middle">
                                                    <div class="contact-info">
                                                        <div class="d-flex align-items-center mb-1">
                                                            <i class="bi bi-phone text-primary me-2"></i>
                                                            <small>${phone1}</small>
                                                        </div>

                                                        ${
                                                            phone2
                                                                ? `
                                                            <div class="d-flex align-items-center">
                                                                <i class="bi bi-telephone-plus text-secondary me-2"></i>
                                                                <small>${phone2}</small>
                                                            </div>
                                                            `
                                                                : ''
                                                        }
                                                    </div>
                                                </td>

                                                <!-- Party Type -->
                                                <td class="align-middle">
                                                    <span class="badge ${partyBadgeClass}">
                                                        ${this.type_of_party || '--'}
                                                    </span>
                                                </td>

                                                <!-- Actions -->
                                                <td class="align-middle text-center">
                                                    <div class="d-flex justify-content-center gap-2">

                                                        <!-- Edit -->
                                                        <button class="btn btn-outline-primary btn-sm addeditpartyGeneralBtn"
                                                                data-bs-placement="top"
                                                                data-bs-title="Edit Party"
                                                                data-target-id="${this.ar_client_id || ''}"
                                                                data-ar_name="${this.ar_name || ''}"
                                                                data-ar_gender="${this.ar_gender || ''}"
                                                                data-ar_address="${this.ar_address || ''}"
                                                                data-ar_cell_phone="${this.ar_cell_phone || ''}"
                                                                data-ar_cell_phone2="${this.ar_cell_phone2 || ''}"
                                                                data-ar_tin_no="${this.ar_tin_no || ''}"
                                                                data-ar_id_type="${this.ar_id_type || ''}"
                                                                data-ar_id_number="${this.ar_id_number || ''}"
                                                                data-ar_location="${this.ar_location || ''}"
                                                                data-ar_district="${this.ar_district || ''}"
                                                                data-ar_region="${this.ar_region || ''}"
                                                                data-type_of_party="${this.type_of_party || ''}"
                                                                data-ar_person_type="${this.ar_person_type || ''}"
                                                                data-p_uid="${this.p_uid || ''}"
                                                                data-ar_id="${this.ar_id || ''}">
                                                            <i class="bi bi-pencil"></i> Edit
                                                        </button>

                                                        <!-- Delete -->
                                                        <button class="btn btn-outline-danger btn-sm"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#deletepartyGeneral"
                                                                data-bs-placement="top"
                                                                data-bs-title="Delete Party"
                                                                data-target-id="${this.ar_client_id || ''}"
                                                                data-ar_name="${this.ar_name || ''}"
                                                                data-ar_gender="${this.ar_gender || ''}"
                                                                data-ar_address="${this.ar_address || ''}"
                                                                data-ar_cell_phone="${this.ar_cell_phone || ''}"
                                                                data-ar_cell_phone2="${this.ar_cell_phone2 || ''}"
                                                                data-ar_tin_no="${this.ar_tin_no || ''}"
                                                                data-ar_id_type="${this.ar_id_type || ''}"
                                                                data-ar_id_number="${this.ar_id_number || ''}"
                                                                data-ar_location="${this.ar_location || ''}"
                                                                data-ar_district="${this.ar_district || ''}"
                                                                data-ar_region="${this.ar_region || ''}"
                                                                data-type_of_party="${this.type_of_party || ''}"
                                                                data-ar_person_type="${this.ar_person_type || ''}"
                                                                data-p_uid="${this.p_uid || ''}"
                                                                data-ar_id="${this.ar_id || ''}">
                                                            <i class="bi bi-trash"></i> Delete
                                                        </button>

                                                    </div>
                                                </td>
                                            </tr>
                                        `;
                                        table.append(rowHtml);
                                    });
                                    
                                    resolve({
                                        success: true,
                                        message: `Party deleted successfully!`
                                    });
                                } else {
                                    reject('Failed to delete party. Please try again.');
                                }
                            } catch (error) {
                                console.error("Error parsing response:", error);
                                Swal.fire({
                                    title: 'Error!',
                                    text: 'Failed to delete party.',
                                    icon: 'error',
                                    confirmButtonColor: '#d33',
                                    confirmButtonText: 'OK'
                                });
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("AJAX Error:", error);
                            Swal.fire({
                                title: 'Error!',
                                text: 'Failed to delete party.',
                                icon: 'error',
                                confirmButtonColor: '#d33',
                                confirmButtonText: 'OK'
                            });
                        }
                    });
                });
            },
            allowOutsideClick: () => !Swal.isLoading()
        }).then((result) => {
            if (result.isConfirmed && result.value && result.value.success) {
                Swal.fire({
                    title: 'Success!',
                    text: result.value.message,
                    icon: 'success',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'OK',
                    timer: 3000,
                    timerProgressBar: true,
                    willClose: () => {
                        // Refresh any other UI components if needed
                        if (typeof refreshPartyStatistics === 'function') {
                            refreshPartyStatistics();
                        }
                    }
                });
            }
        }).catch((error) => {
            if (error) {
                Swal.fire({
                    title: 'Error!',
                    text: error,
                    icon: 'error',
                    confirmButtonColor: '#d33',
                    confirmButtonText: 'OK'
                });
            }
        });
    });

    $('#frmFurtherEntries_only_').on('submit', function(e) {
        e.preventDefault();
        
        // Collect all form data
        const formData = {
            case_number: $("#fe_case_number").val(),
            transaction_number: $("#fe_transaction_number").val(),
            commencement_date: $("#fe_commencement_date").val(),
            date_of_registration: $("#fe_date_of_registration").val(),
            stool_family_name: $("#fe_family_name").val(),
            family_of_grantor: $("#fe_grantor_family").val(),
            renewal_term: $("#fe_renewal_term").val(),
            term: $("#fe_term").val(),
            date_of_document: $("#fe_date_of_document").val(),
            consideration_fee: $("#fe_consideration_fee").val(),
            consideration_currency: $("#fe_consideration_currency").val(),
            type_of_use: $("#fe_type_of_use").val(),
            size_of_land: $("#fe_land_size").val(),
            type_of_interest: $("#fe_type_of_interest").val(),
            nature_of_instrument: $("#fe_nature_of_instrument").val(),
            client_name: $("#fe_client_name").val(),
            business_process_sub_name: $("#fe_business_process_sub_name").val(),
            job_number: $("#fe_job_number").val(),
            annual_rent: $("#fe_annual_rent").val(),
            surveyor_number: $("#fe_surveyor_number").val(),
            regional_number: $("#fe_regional_number").val(),
            land_size: $("#fe_land_size").val(),
            district: $("#fe_district").val(),
            locality: $("#fe_locality").val(),
            region: $("#fe_region").val(),
            extent: $("#fe_extent").val(),
            file_number: $("#fe_file_number").val(),
            registry_mapref: $("#fe_registry_mapref").val(),
            date_of_issue: $("#fe_date_of_issue").val(),
            registered_number: $("#fe_registered_number").val(),
            certificate_type: $("#fe_certificate_type").val(),
            modified_by: localStorage.getItem("fullname") || 'System',
            modified_by_id: localStorage.getItem("userid") || '0'
        };

        // Validation
        const requiredFields = [
            'case_number', 'term', 'date_of_document', 'consideration_fee',
            'type_of_interest', 'locality', 'district', 'region',
            'extent', 'annual_rent', 'commencement_date'
        ];

        const missingFields = [];
        requiredFields.forEach(field => {
            if (!formData[field] || formData[field].toString().trim() === '') {
                const fieldLabel = field.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
                missingFields.push(fieldLabel);
            }
        });

        if (missingFields.length > 0) {
            Swal.fire({
                title: 'Validation Error',
                html: `<div class="text-start">
                        <p>Please fill in the following required fields:</p>
                        <ul class="list-unstyled ps-3">
                            ${missingFields.map(field => `<li><i class="bi bi-dot text-danger me-2"></i>${field}</li>`).join('')}
                        </ul>
                    </div>`,
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
            });
            return;
        }

        // Show confirmation dialog with summary
        Swal.fire({
            title: 'Confirm Case Update',
            html: `<div class="text-start">
                    <p class="mb-3">Are you sure you want to update this case with the following details?</p>
                    
                    <div class="card border mb-3">
                        <div class="card-header bg-light py-2">
                            <h6 class="mb-0 fw-semibold">
                                <i class="bi bi-info-circle me-2"></i>Case Summary
                            </h6>
                        </div>
                        <div class="card-body p-3">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <strong><i class="bi bi-journal me-2"></i>Case Number:</strong>
                                        <div class="text-primary mt-1">${formData.case_number}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-currency-exchange me-2"></i>Consideration:</strong>
                                        <div class="text-success mt-1">${formData.consideration_currency} ${parseFloat(formData.consideration_fee).toLocaleString()}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-calendar me-2"></i>Term:</strong>
                                        <div class="text-dark mt-1">${formData.term} years</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-geo-alt me-2"></i>Location:</strong>
                                        <div class="text-dark mt-1">${formData.locality}, ${formData.district}</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <strong><i class="bi bi-cash-stack me-2"></i>Annual Rent:</strong>
                                        <div class="text-dark mt-1">GHS ${parseFloat(formData.annual_rent).toLocaleString()}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-calendar-check me-2"></i>Commencement:</strong>
                                        <div class="text-dark mt-1">${formData.commencement_date}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-calendar-date me-2"></i>Document Date:</strong>
                                        <div class="text-dark mt-1">${formData.date_of_document}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-aspect-ratio me-2"></i>Land Size:</strong>
                                        <div class="text-dark mt-1">${formData.land_size} acres</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert-info small mb-0">
                        <i class="bi bi-info-circle me-2"></i>
                        This will update the case record with new details. The action cannot be undone.
                    </div>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="bi bi-check-circle me-2"></i>Update Case',
            cancelButtonText: '<i class="bi bi-x-circle me-2"></i>Cancel',
            reverseButtons: true,
            customClass: {
                confirmButton: 'btn btn-primary px-4 ms-2',
                cancelButton: 'btn btn-secondary px-4'
            },
            buttonsStyling: false,
            showLoaderOnConfirm: true,
            preConfirm: () => {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: "POST",
                        url: "Case_Management_Serv",
                        data: {
                            request_type: 'further_entries_update_case',
                            case_number: formData.case_number,
                            annual_rent: formData.annual_rent,
                            commencement_date: formData.commencement_date,
                            date_of_registration: formData.date_of_registration,
                            stool_family_name: formData.stool_family_name,
                            family_of_grantor: formData.family_of_grantor,
                            renewal_term: formData.renewal_term,
                            term: formData.term,
                            date_of_document: formData.date_of_document,
                            consideration_fee: formData.consideration_fee,
                            consideration_currency: formData.consideration_currency,
                            extent: formData.extent,
                            size_of_land: formData.size_of_land,
                            type_of_interest: formData.type_of_interest,
                            nature_of_instrument: formData.nature_of_instrument,
                            type_of_use: formData.type_of_use,
                            transaction_number: formData.transaction_number,
                            client_name: formData.client_name,
                            business_process_sub_name: formData.business_process_sub_name,
                            job_number: formData.job_number,
                            surveyor_number: formData.surveyor_number,
                            regional_number: formData.regional_number,
                            land_size: formData.land_size,
                            locality: formData.locality,
                            district: formData.district,
                            region: formData.region,
                            file_number: formData.file_number,
                            date_of_issue: formData.date_of_issue,
                            registered_number: formData.registered_number,
                            registry_mapref: formData.registry_mapref,
                            certificate_type: formData.certificate_type,
                            modified_by: formData.modified_by,
                            modified_by_id: formData.modified_by_id
                        },
                        cache: false,
                        timeout: 30000,
                        success: function(response) {
                            // console.log('Server response:', response);
                            
                            try {
                                const result = typeof response === 'string' ? JSON.parse(response) : response;
                                
                                if (result.data === 'Success' || result.success || result.message?.includes("success")) {
                                    resolve({
                                        success: true,
                                        message: 'Case details updated successfully!',
                                        caseNumber: formData.case_number
                                    });
                                } else {
                                    const errorMsg = result.message || result.error || 'Failed to update case. Please try again.';
                                    reject(errorMsg);
                                }
                            } catch (error) {
                                console.error('Error parsing response:', error);
                                reject('Invalid response from server. Please try again.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('AJAX Error:', error);
                            if (status === 'timeout') {
                                reject('Request timeout. Please try again.');
                            } else {
                                reject('Network error occurred. Please check your connection.');
                            }
                        }
                    });
                });
            },
            allowOutsideClick: () => !Swal.isLoading()
        }).then((result) => {
            if (result.isConfirmed && result.value && result.value.success) {
                Swal.fire({
                    title: '<i class="bi bi-check-circle-fill text-success me-2"></i>Success!',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="bi bi-check2-circle text-success fs-1"></i>
                            </div>
                            <h5 class="mb-2">${result.value.message}</h5>
                            <p class="text-muted small mb-0">
                                Case Number: <strong>${result.value.caseNumber}</strong>
                            </p>
                        </div>`,
                    icon: 'success',
                    confirmButtonColor: '#198754',
                    confirmButtonText: '<i class="bi bi-check-lg me-1"></i>OK',
                    timer: 3000,
                    timerProgressBar: true,
                    showClass: {
                        popup: 'animate__animated animate__fadeInDown'
                    },
                    hideClass: {
                        popup: 'animate__animated animate__fadeOutUp'
                    },
                    willClose: () => {
                        // Close the modal
                        const modalElement = document.getElementById('further_entry');
                        if (modalElement) {
                            const modal = bootstrap.Modal.getInstance(modalElement);
                            if (modal) {
                                modal.hide();
                            }
                        }
                        
                        // Show success alert in the form
                        const alertHtml = `
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>
                                <strong>Success!</strong> Case details saved successfully
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        `;
                        $("#alert-display-space").html(alertHtml);
                        
                        // Optional: Add job to batchlist if needed
                        // if (typeof addJobToBatchlist === 'function') {
                        //     addJobToBatchlist(
                        //         formData.job_number,
                        //         formData.client_name,
                        //         formData.business_process_sub_name,
                        //         "",
                        //         ""
                        //     );
                        // }
                        
                        // // Optional: Prepare batchlist modal
                        // if (typeof prepareBatchlistModal === 'function') {
                        //     prepareBatchlistModal();
                        // }
                        
                        // Trigger any custom events if needed
                        $(document).trigger('caseUpdated', [formData.case_number]);
                    }
                });
            }
        }).catch((error) => {
            if (error) {
                Swal.fire({
                    title: '<i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>Error!',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="bi bi-x-circle text-danger fs-1"></i>
                            </div>
                            <h5 class="mb-2">Update Failed</h5>
                            <p class="text-muted">${error}</p>
                        </div>`,
                    icon: 'error',
                    confirmButtonColor: '#dc3545',
                    confirmButtonText: '<i class="bi bi-x-lg me-1"></i>Close',
                    showClass: {
                        popup: 'animate__animated animate__shakeX'
                    },
                    willClose: () => {
                        // Show error alert in the form
                        const alertHtml = `
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                <strong>Error!</strong> Something went wrong. Please try again.
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        `;
                        $("#alert-display-space").html(alertHtml);
                    }
                });
            }
        });
    });

    $('#lc_btn_add_coordinate').on('click', function () {
        $(document).off('focusin.modal');
        // 🔥 WAIT FOR BOOTSTRAP TO RELEASE FOCUS
        setTimeout(openSwal, 300);
    });

    // Handle Add Coordinate button click
    function openSwal() {
        Swal.fire({
            target: document.getElementById('upload_coordinate'),
            title: '<i class="bi bi-plus-circle text-primary me-2"></i>Add Coordinate',
            html: `<form id="coordinateForm">
                <div class="text-start">
                    <!-- Name Field -->
                    <div class="mb-3">
                        <label for="swal_coordinate_name" class="form-label fw-semibold">
                            <i class="bi bi-tag me-1"></i>Coordinate Name
                        </label>
                        <input type="text" 
                            class="form-control" 
                            id="swal_coordinate_name" 
                            placeholder="Enter coordinate name"
                            required>
                        <div class="form-text">
                            <i class="bi bi-info-circle me-1"></i>
                            Optional descriptive name for the coordinate
                        </div>
                    </div>

                    <!-- X Coordinate -->
                    <div class="mb-3">
                        <label for="swal_x_coordinate" class="form-label fw-semibold">
                            <i class="bi bi-arrow-right me-1"></i>X-Coordinate (Longitude)
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">
                                <i class="bi bi-long-arrow-right"></i>
                            </span>
                            <input type="text" 
                                class="form-control" 
                                id="swal_x_coordinate" 
                                placeholder="e.g., 371985.85"
                                pattern="-?\d+(\.\d+)?"
                                required>
                        </div>
                        <div class="invalid-feedback d-none" id="xError">
                            Please enter a valid numeric coordinate
                        </div>
                    </div>

                    <!-- Y Coordinate -->
                    <div class="mb-3">
                        <label for="swal_y_coordinate" class="form-label fw-semibold">
                            <i class="bi bi-arrow-up me-1"></i>Y-Coordinate (Latitude)
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">
                                <i class="bi bi-long-arrow-up"></i>
                            </span>
                            <input type="text" 
                                class="form-control" 
                                id="swal_y_coordinate" 
                                placeholder="e.g., 1204274.10"
                                pattern="-?\d+(\.\d+)?"
                                required>
                        </div>
                        <div class="invalid-feedback d-none" id="yError">
                            Please enter a valid numeric coordinate
                        </div>
                    </div>

                    <!-- Preview -->
                    <div class="alert alert-light border mt-3" id="coordinatePreview">
                        <h6 class="alert-heading mb-2">
                            <i class="bi bi-eye me-2"></i>Preview
                        </h6>
                        <div class="row small">
                            <div class="col-md-4">
                                <strong>Name:</strong> 
                                <span id="previewName" class="text-muted">-</span>
                            </div>
                            <div class="col-md-4">
                                <strong>X:</strong> 
                                <span id="previewX" class="text-muted">-</span>
                            </div>
                            <div class="col-md-4">
                                <strong>Y:</strong> 
                                <span id="previewY" class="text-muted">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </form>`,
            focusConfirm: false,
            allowOutsideClick: false,
            showCancelButton: true,
            confirmButtonText: '<i class="bi bi-plus-circle me-1"></i>Add Coordinate',
            cancelButtonText: '<i class="bi bi-x-circle me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            reverseButtons: true,
            customClass: {
                confirmButton: 'btn btn-primary px-4 ms-2',
                cancelButton: 'btn btn-secondary px-4',
                popup: 'swal-wide'
            },
            buttonsStyling: false,
            showLoaderOnConfirm: false,
            preConfirm: () => {
                return new Promise((resolve, reject) => {
                    const name = document.getElementById('swal_coordinate_name').value.trim();
                    const xCoord = document.getElementById('swal_x_coordinate').value.trim();
                    const yCoord = document.getElementById('swal_y_coordinate').value.trim();
                    
                    // Validation
                    let isValid = true;
                    const xError = document.getElementById('xError');
                    const yError = document.getElementById('yError');
                    
                    // Reset errors
                    xError.classList.add('d-none');
                    yError.classList.add('d-none');
                    
                    // Validate X coordinate
                    if (!xCoord) {
                        xError.textContent = 'X-Coordinate is required';
                        xError.classList.remove('d-none');
                        isValid = false;
                    } else if (!/^-?\d+(\.\d+)?$/.test(xCoord)) {
                        xError.textContent = 'X-Coordinate must be a valid number';
                        xError.classList.remove('d-none');
                        isValid = false;
                    }
                    
                    // Validate Y coordinate
                    if (!yCoord) {
                        yError.textContent = 'Y-Coordinate is required';
                        yError.classList.remove('d-none');
                        isValid = false;
                    } else if (!/^-?\d+(\.\d+)?$/.test(yCoord)) {
                        yError.textContent = 'Y-Coordinate must be a valid number';
                        yError.classList.remove('d-none');
                        isValid = false;
                    }
                    
                    if (!isValid) {
                        reject('Please fix the validation errors');
                    } else {
                        resolve({
                            name: name || `Point ${$('#coordinatelis_Table tbody tr').length + 1}`,
                            x: parseFloat(xCoord),
                            y: parseFloat(yCoord)
                        });
                    }
                });
            },
            didOpen: () => {

                document.getElementById('swal_coordinate_name').focus();

                // Add real-time validation and preview
                const nameInput = document.getElementById('swal_coordinate_name');
                const xInput = document.getElementById('swal_x_coordinate');
                const yInput = document.getElementById('swal_y_coordinate');
                
                const updatePreview = () => {
                    document.getElementById('previewName').textContent = 
                        nameInput.value || 'Unnamed';
                    document.getElementById('previewX').textContent = 
                        xInput.value || '-';
                    document.getElementById('previewY').textContent = 
                        yInput.value || '-';
                };
                
                nameInput.addEventListener('input', updatePreview);
                xInput.addEventListener('input', updatePreview);
                yInput.addEventListener('input', updatePreview);
                
                // Initial preview
                updatePreview();
                
                // Focus on first input
                setTimeout(() => nameInput.focus(), 100);
            },
            willClose: () => {
                // Restore Bootstrap modal focus trap
                $(document).on('focusin.modal', function (e) {
                    const modal = $(e.target).closest('.modal')[0];
                    if (modal) {
                        modal.focus();
                    }
                });
            },
            allowOutsideClick: () => !Swal.isLoading()
        }).then((result) => {
            if (result.isConfirmed && result.value) {
                const coordinate = result.value;
                
                // Add to table
                addCoordinateToTable(coordinate.name, coordinate.x, coordinate.y);
                
                // Show success message
                Swal.fire({
                    title: '<i class="bi bi-check-circle text-success me-2"></i>Success!',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="bi bi-geo-alt text-primary fs-1"></i>
                            </div>
                            <h5 class="mb-2">Coordinate Added</h5>
                            <p class="text-muted small">
                                <strong>${coordinate.name}</strong><br>
                                X: ${coordinate.x}, Y: ${coordinate.y}
                            </p>
                        </div>`,
                    icon: 'success',
                    confirmButtonText: '<i class="bi bi-check-lg me-1"></i>OK',
                    confirmButtonColor: '#198754',
                    timer: 2000,
                    timerProgressBar: true,
                    showClass: {
                        popup: 'animate__animated animate__fadeInDown'
                    },
                    hideClass: {
                        popup: 'animate__animated animate__fadeOutUp'
                    }
                });
            }
        }).catch((error) => {
            if (error) {
                Swal.showValidationMessage(error);
            }
        });
    };

    // Function to add coordinate to table
    function addCoordinateToTable(name, x, y) {
        const table = $('#coordinatelis_Table');
        const tbody = table.find('tbody');
        
        // Remove empty state row if it exists
        const emptyRow = tbody.find('#noCoordinatesRow');
        if (emptyRow.length) {
            emptyRow.remove();
        }
        
        // Create new row
        const newRow = `
            <tr data-x="${x}" data-y="${y}">
                <td class="align-middle">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-xs bg-light-primary rounded-circle me-2">
                            <i class="bi bi-geo"></i>
                        </div>
                        <div>
                            <div class="fw-semibold">${name}</div>
                            <small class="text-muted">Added: ${new Date().toLocaleTimeString()}</small>
                        </div>
                    </div>
                </td>
                <td class="align-middle">
                    <span class="badge bg-info">${x}</span>
                </td>
                <td class="align-middle">
                    <span class="badge bg-success">${y}</span>
                </td>
                <td class="align-middle text-center">
                    <button type="button" class="btn btn-outline-danger btn-sm btn-remove-coordinate"
                            data-bs-toggle="tooltip" data-bs-placement="top" 
                            title="Remove coordinate">
                        <i class="bi bi-trash"></i> Remove
                    </button>
                </td>
            </tr>
        `;
        
        tbody.append(newRow);
        
        // Add remove functionality
        const removeBtn = tbody.find('tr:last .btn-remove-coordinate');
        removeBtn.on('click', function() {
            const row = $(this).closest('tr');
            const coordName = row.find('td:first .fw-semibold').text();
            
            Swal.fire({
                title: 'Remove Coordinate?',
                html: `<div class="text-center">
                        <div class="mb-3">
                            <i class="bi bi-exclamation-triangle text-warning fs-1"></i>
                        </div>
                        <h5 class="mb-2">Confirm Removal</h5>
                        <p class="text-muted">
                            Are you sure you want to remove<br>
                            <strong>"${coordName}"</strong>?
                        </p>
                    </div>`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '<i class="bi bi-trash me-1"></i>Remove',
                cancelButtonText: '<i class="bi bi-x-circle me-1"></i>Cancel',
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    row.fadeOut(300, function() {
                        $(this).remove();
                        updateCoordinateStats();
                        
                        // If table is empty, show empty state
                        if ($('#coordinatelis_Table tbody tr').length === 0) {
                            tbody.append(`
                                <tr id="noCoordinatesRow">
                                    <td colspan="4" class="text-center py-4">
                                        <div class="text-muted">
                                            <i class="bi bi-geo fs-1 mb-2 d-block"></i>
                                            <p class="mb-0">No coordinates added</p>
                                            <small>Click "Add Coordinate" or "Upload CSV" to get started</small>
                                        </div>
                                    </td>
                                </tr>
                            `);
                        }
                    });
                    
                    // Show removal success
                    Swal.fire({
                        title: 'Removed!',
                        text: 'Coordinate has been removed',
                        icon: 'success',
                        timer: 1500,
                        showConfirmButton: false
                    });
                }
            });
        });
        
        // Initialize tooltip
        new bootstrap.Tooltip(removeBtn[0]);
        
        // Update statistics
        updateCoordinateStats();
        
        // Optionally update WKT polygon if needed
        updateWktFromCoordinates();
    }

    // Function to update coordinate statistics
    function updateCoordinateStats() {
        const table = $('#coordinatelis_Table');
        const rows = table.find('tbody tr:not(#noCoordinatesRow)');
        const total = rows.length;
        
        // Update statistics display if it exists
        const totalEl = document.getElementById('totalCoordinates');
        if (totalEl) {
            totalEl.textContent = total;
        }
        
        // Update summary text if it exists
        const summaryEl = document.getElementById('coordinateSummary');
        if (summaryEl) {
            summaryEl.textContent = 
                total > 0 ? `${total} coordinate${total !== 1 ? 's' : ''} added` : 'No coordinates added';
        }
    }

    // Function to update WKT polygon from coordinates
    function updateWktFromCoordinates() {
        const table = $('#coordinatelis_Table');
        const rows = table.find('tbody tr:not(#noCoordinatesRow)');
        
        if (rows.length >= 3) { // Need at least 3 points for a polygon
            let coordinates = [];
            rows.each(function() {
                const x = $(this).data('x');
                const y = $(this).data('y');
                coordinates.push(`${x} ${y}`);
            });
            
            // Close the polygon by repeating first coordinate
            const firstCoord = coordinates[0];
            coordinates.push(firstCoord);
            
            const wkt = `POLYGON((${coordinates.join(', ')}))`;
            $('#lc_bl_wkt_polygon').val(wkt);
            
            // Update polygon status
            const statusEl = document.getElementById('polygonStatus');
            if (statusEl) {
                statusEl.textContent = 'Yes';
                statusEl.parentElement.parentElement.querySelector('.card')
                    .classList.add('border-success');
            }
        }
    }

    // Update statistics when modal opens
    $('#upload_coordinate').on('shown.bs.modal', function() {
        updateCoordinateStats();
    });

    $('#btn_lc_save_parcel_for_general_noting').on('click', function(e) {
        // Gather data
        var job_number = $("#cs_main_job_number").val();
        var case_number = $("#cs_main_case_number").val();
        var wkt_polygon = $("#lc_bl_wkt_polygon").val() || $("#lc_fr_bl_wkt_polygon").val();
        var send_by_id = localStorage.getItem('userid') || '';
        var send_by_name = localStorage.getItem('fullname') || 'System User';
        
        // Validation
        if (!case_number || !job_number) {
            Swal.fire({
                title: 'Missing Information',
                text: 'Case number and job number are required to save the parcel.',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
            });
            return;
        }
        
        if (!wkt_polygon || wkt_polygon.trim() === '') {
            Swal.fire({
                title: 'No Polygon Data',
                text: 'Please add coordinates or WKT polygon data before saving.',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
            });
            return;
        }
        
        // Show confirmation dialog
        Swal.fire({
            title: '<i class="bi bi-save text-primary me-2"></i>Save Parcel Data',
            html: `<div class="text-start">
                    <p class="mb-3">Are you sure you want to save this parcel data?</p>
                    
                    <div class="card border mb-3">
                        <div class="card-body p-3">
                            <div class="row small">
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <strong><i class="bi bi-journal-text me-2"></i>Case Number:</strong>
                                        <div class="text-primary mt-1">${case_number}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-file-earmark-text me-2"></i>Job Number:</strong>
                                        <div class="text-dark mt-1">${job_number}</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-2">
                                        <strong><i class="bi bi-person me-2"></i>Saving as:</strong>
                                        <div class="text-dark mt-1">${send_by_name}</div>
                                    </div>
                                    <div class="mb-2">
                                        <strong><i class="bi bi-polygon me-2"></i>Points:</strong>
                                        <div class="text-dark mt-1" id="pointCount">Calculating...</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- WKT Preview -->
                            <div class="mt-3">
                                <strong><i class="bi bi-code-slash me-2"></i>WKT Preview:</strong>
                                <div class="bg-light p-2 mt-1 rounded small font-monospace" style="max-height: 100px; overflow: auto;">
                                    ${wkt_polygon.length > 100 ? wkt_polygon.substring(0, 100) + '...' : wkt_polygon}
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert-info small mb-0">
                        <i class="bi bi-info-circle me-2"></i>
                        This will save the spatial data to the database. Make sure the polygon is correctly formed.
                    </div>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="bi bi-save me-2"></i>Save Parcel',
            cancelButtonText: '<i class="bi bi-x-circle me-2"></i>Cancel',
            reverseButtons: true,
            customClass: {
                confirmButton: 'btn btn-primary px-4 ms-2',
                cancelButton: 'btn btn-secondary px-4'
            },
            buttonsStyling: false,
            showLoaderOnConfirm: true,
            preConfirm: () => {
                return new Promise((resolve, reject) => {
                    // Calculate point count for display
                    setTimeout(() => {
                        const pointCount = wkt_polygon.match(/\d+\.?\d*\s+\d+\.?\d*/g)?.length || 0;
                        document.getElementById('pointCount').textContent = `${pointCount} point${pointCount !== 1 ? 's' : ''}`;
                    }, 100);
                    
                    // Send AJAX request
                    $.ajax({
                        type: "POST",
                        url: "Maps",
                        data: {
                            request_type: 'select_save_spatial_objects_undergoing_registration',
                            wkt_polygon: wkt_polygon,
                            case_number: case_number,
                            job_number: job_number
                        },
                        cache: false,
                        timeout: 30000, // 30 second timeout
                        success: function(response) {
                            // console.log('Save response:', response);
                            
                            try {
                                // Check if response is JSON
                                let result;
                                if (typeof response === 'string' && response.trim().startsWith('{')) {
                                    result = JSON.parse(response);
                                } else {
                                    result = { message: response, success: true };
                                }
                                
                                if (result.success !== false && !response.includes("Error") && !response.includes("error")) {
                                    resolve({
                                        success: true,
                                        message: response,
                                        caseNumber: case_number,
                                        jobNumber: job_number
                                    });
                                } else {
                                    const errorMsg = result.message || result.error || 'Failed to save parcel data';
                                    reject(errorMsg);
                                }
                            } catch (error) {
                                console.error('Error parsing response:', error);
                                // If it's not JSON but looks successful
                                if (typeof response === 'string' && response.length < 100) {
                                    resolve({
                                        success: true,
                                        message: response,
                                        caseNumber: case_number,
                                        jobNumber: job_number
                                    });
                                } else {
                                    reject('Invalid response from server');
                                }
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('AJAX Error:', error);
                            if (status === 'timeout') {
                                reject('Request timeout. Please try again.');
                            } else {
                                reject('Network error occurred. Please check your connection.');
                            }
                        }
                    });
                });
            },
            allowOutsideClick: () => !Swal.isLoading()
        }).then((result) => {
            if (result.isConfirmed && result.value && result.value.success) {
                Swal.fire({
                    title: '<i class="bi bi-check-circle-fill text-success me-2"></i>Success!',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="bi bi-check2-circle text-success fs-1"></i>
                            </div>
                            <h5 class="mb-2">Parcel Saved Successfully</h5>
                            <div class="alert alert-light border mt-3">
                                <p class="mb-2 small">
                                    <strong>Case:</strong> ${result.value.caseNumber}<br>
                                    <strong>Job:</strong> ${result.value.jobNumber}
                                </p>
                                <p class="mb-0 small text-muted">
                                    <i class="bi bi-clock me-1"></i>
                                    ${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}
                                </p>
                            </div>
                        </div>`,
                    icon: 'success',
                    confirmButtonColor: '#198754',
                    confirmButtonText: '<i class="bi bi-check-lg me-1"></i>OK',
                    timer: 3000,
                    timerProgressBar: true,
                    showClass: {
                        popup: 'animate__animated animate__fadeInDown'
                    },
                    hideClass: {
                        popup: 'animate__animated animate__fadeOutUp'
                    },
                    willClose: () => {
                        // Show the original message modal if it still exists
                        const messageModal = document.getElementById('general_message_dialog');
                        if (messageModal) {
                            const modal = bootstrap.Modal.getInstance(messageModal);
                            if (modal) {
                                // Update message
                                $('#general_message_dialog_msg_new').val(result.value.message || 'Parcel saved successfully');
                                // Show modal
                                modal.show();
                            }
                        }
                        
                        // Refresh any map visualizations if needed
                        if (typeof refreshMapVisualization === 'function') {
                            refreshMapVisualization();
                        }
                        
                        // Clear coordinates table if needed
                        const table = $('#coordinatelis_Table tbody');
                        if (table.find('tr').length > 0 && !table.find('#noCoordinatesRow').length) {
                            Swal.fire({
                                title: 'Clear Coordinates?',
                                text: 'Do you want to clear the coordinate table?',
                                icon: 'question',
                                showCancelButton: true,
                                confirmButtonText: 'Yes, clear',
                                cancelButtonText: 'No, keep',
                                confirmButtonColor: '#0d6efd',
                                cancelButtonColor: '#6c757d'
                            }).then((clearResult) => {
                                if (clearResult.isConfirmed) {
                                    table.empty();
                                    table.append(`
                                        <tr id="noCoordinatesRow">
                                            <td colspan="4" class="text-center py-4">
                                                <div class="text-muted">
                                                    <i class="bi bi-geo fs-1 mb-2 d-block"></i>
                                                    <p class="mb-0">No coordinates added</p>
                                                    <small>Click "Add Coordinate" or "Upload CSV" to get started</small>
                                                </div>
                                            </td>
                                        </tr>
                                    `);
                                    $('#lc_bl_wkt_polygon').val('');
                                }
                            });
                        }
                    }
                });
            }
        }).catch((error) => {
            if (error) {
                Swal.fire({
                    title: '<i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>Error!',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="bi bi-x-circle text-danger fs-1"></i>
                            </div>
                            <h5 class="mb-2">Save Failed</h5>
                            <p class="text-muted">${error}</p>
                            <div class="mt-3">
                                <button class="btn btn-sm btn-outline-primary me-2" onclick="retrySaveParcel()">
                                    <i class="bi bi-arrow-clockwise me-1"></i>Try Again
                                </button>
                                <button class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">
                                    <i class="bi bi-x me-1"></i>Close
                                </button>
                            </div>
                        </div>`,
                    icon: 'error',
                    confirmButtonColor: '#dc3545',
                    showConfirmButton: false,
                    showCloseButton: true,
                    showClass: {
                        popup: 'animate__animated animate__shakeX'
                    }
                });
            }
        });
    });

    // Retry function
    function retrySaveParcel() {
        Swal.close();
        $('#btn_lc_save_parcel_for_general_noting').click();
    }

    // Remove the entire modal HTML code and replace with this JavaScript

    // Handle CSV upload button click
    $('#lrd_btn_add_coordinate_by_csv').on('click', function() {
        // Create SweetAlert modal for file upload
        Swal.fire({
            title: 'Upload Coordinates CSV',
            html: `
                <div class="mb-3">
                    <label for="csvFileInput" class="form-label">Select CSV File</label>
                    <input type="file" class="form-control" id="csvFileInput" accept=".csv">
                    <div class="form-text">Please select a CSV file with coordinates</div>
                </div>
                <div id="previewSection" style="display: none;" class="mt-3">
                    <h6 class="mb-2">Preview (first 5 rows):</h6>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered" id="csvPreviewTable">
                            <thead class="table-light">
                                <tr>
                                    <th>Point ID</th>
                                    <th>Latitude</th>
                                    <th>Longitude</th>
                                </tr>
                            </thead>
                            <tbody id="previewBody"></tbody>
                        </table>
                    </div>
                </div>
            `,
            showCancelButton: true,
            confirmButtonText: 'Upload',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#198754',
            cancelButtonColor: '#6c757d',
            showLoaderOnConfirm: true,
            preConfirm: () => {
                const fileInput = document.getElementById('csvFileInput');
                const file = fileInput.files[0];
                
                if (!file) {
                    Swal.showValidationMessage('Please select a CSV file');
                    return false;
                }
                
                // Check file extension
                const fileName = file.name;
                const fileExtension = fileName.split('.').pop().toLowerCase();
                
                if (fileExtension !== 'csv') {
                    Swal.showValidationMessage('Please upload a CSV file');
                    return false;
                }
                
                return new Promise((resolve, reject) => {
                    const reader = new FileReader();
                    
                    reader.onload = function(e) {
                        try {
                            const csvContent = e.target.result;
                            const rows = csvContent.split(/\r\n|\n|\r/);
                            const coordinates = [];
                            
                            // Process CSV rows
                            rows.forEach((row, index) => {
                                if (row.trim()) {
                                    const points = row.split(',');
                                    if (points.length >= 2) {
                                        const pointId = points[0] || `Point ${index + 1}`;
                                        coordinates.push({
                                            pointId: pointId.trim(),
                                            latitude: parseFloat(points[1].trim()),
                                            longitude: parseFloat(points[2].trim())
                                        });
                                    }
                                }
                            });
                            
                            if (coordinates.length === 0) {
                                reject('No valid coordinates found in the CSV file');
                            } else {
                                resolve({ coordinates: coordinates, file: file });
                            }
                        } catch (error) {
                            reject('Error parsing CSV file: ' + error.message);
                        }
                    };
                    
                    reader.onerror = function() {
                        reject('Error reading file');
                    };
                    
                    reader.readAsText(file);
                });
            },
            didOpen: () => {
                // Add preview functionality
                const fileInput = document.getElementById('csvFileInput');
                fileInput.addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (!file) return;
                    
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        try {
                            const csvContent = e.target.result;
                            const rows = csvContent.split(/\r\n|\n|\r/);
                            const previewBody = document.getElementById('previewBody');
                            const previewSection = document.getElementById('previewSection');
                            
                            previewBody.innerHTML = '';
                            let rowCount = 0;
                            
                            // Show first 5 rows
                            rows.forEach((row, index) => {
                                if (row.trim() && rowCount < 5) {
                                    const points = row.split(',');
                                    if (points.length >= 2) {
                                        const pointId = points[0] || `Point ${index + 1}`;
                                        previewBody.innerHTML += `
                                            <tr>
                                                <td>${pointId.trim()}</td>
                                                <td>${points[1].trim()}</td>
                                                <td>${points[2].trim()}</td>
                                            </tr>
                                        `;
                                        rowCount++;
                                    }
                                }
                            });
                            
                            if (rowCount > 0) {
                                previewSection.style.display = 'block';
                            } else {
                                previewSection.style.display = 'none';
                            }
                        } catch (error) {
                            console.error('Preview error:', error);
                        }
                    };
                    reader.readAsText(file);
                });
            }
        }).then((result) => {
            if (result.isConfirmed) {
                const { coordinates, file } = result.value;
                
                // Process the uploaded coordinates
                processUploadedCoordinates(coordinates);
                
                // Show success message
                // Swal.fire({
                //     title: 'Success!',
                //     html: `
                //         <div class="text-center">
                //             <i class="bi bi-check-circle-fill text-success display-4 mb-3"></i>
                //             <p>CSV file uploaded successfully!</p>
                //             <p class="small text-muted">
                //                 <strong>${coordinates.length}</strong> coordinates loaded from <strong>${file.name}</strong>
                //             </p>
                //         </div>
                //     `,
                //     icon: 'success',
                //     confirmButtonText: 'Continue',
                //     confirmButtonColor: '#198754'
                // });
            }
        }).catch((error) => {
            if (error) {
                Swal.fire({
                    title: 'Error',
                    text: error,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
            }
        });
    });
    
    // Function to process uploaded coordinates
    function processUploadedCoordinates(coordinates) {
        // Clear existing table rows
        const table = $('#coordinatelis_Table');
        const tbody = table.find('tbody');
        
        // Remove empty state row if it exists
        const emptyRow = tbody.find('#noCoordinatesRow');
        if (emptyRow.length) {
            emptyRow.remove();
        }
        
        // Clear all existing coordinate rows
        tbody.find('tr[data-x][data-y]').remove();
        
        // Check if coordinates array is empty
        if (!coordinates || coordinates.length === 0) {
            // Show empty state
            tbody.append(`
                <tr id="noCoordinatesRow">
                    <td colspan="4" class="text-center py-4">
                        <div class="text-muted">
                            <i class="bi bi-exclamation-circle fs-1 mb-2 d-block"></i>
                            <p class="mb-0">No valid coordinates found</p>
                            <small>The CSV file doesn't contain valid coordinate data</small>
                        </div>
                    </td>
                </tr>
            `);
            updateCoordinateStats();
            return;
        }
        
        // Add coordinates to table
        coordinates.forEach((coord, index) => {
            const pointName = coord.pointId || `Point ${index + 1}`;
            const latitude = coord.latitude || coord.x || 0;
            const longitude = coord.longitude || coord.y || 0;
            
            // Format the coordinates for display
            const formattedLat = parseFloat(latitude).toFixed(6);
            const formattedLng = parseFloat(longitude).toFixed(6);
            
            const newRow = `
                <tr data-x="${formattedLat}" data-y="${formattedLng}">
                    <td class="align-middle">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-xs bg-light-primary rounded-circle me-2">
                                <i class="bi bi-geo"></i>
                            </div>
                            <div>
                                <div class="fw-semibold">${pointName}</div>
                                <small class="text-muted">Added: ${new Date().toLocaleTimeString()}</small>
                            </div>
                        </div>
                    </td>
                    <td class="align-middle">
                        <span class="badge bg-info">${formattedLat}</span>
                    </td>
                    <td class="align-middle">
                        <span class="badge bg-success">${formattedLng}</span>
                    </td>
                    <td class="align-middle text-center">
                        <div class="btn-group" role="group">
                            <!-- <button type="button" class="btn btn-outline-primary btn-sm btn-zoom-coordinate"
                                    data-bs-toggle="tooltip" data-bs-placement="top" 
                                    title="Zoom to coordinate" data-lat="${formattedLat}" data-lng="${formattedLng}">
                                <i class="bi bi-zoom-in"></i>
                            </button> -->
                            <button type="button" class="btn btn-outline-danger btn-sm btn-remove-coordinate"
                                    data-bs-toggle="tooltip" data-bs-placement="top" 
                                    title="Remove coordinate" data-index="${index}">
                                <i class="bi bi-trash"></i> Remove
                            </button>
                        </div>
                    </td>
                </tr>
            `;
            
            tbody.append(newRow);
        });
        
        // Add event listeners to all remove buttons
        $('.btn-remove-coordinate').off('click').on('click', function() {
            const row = $(this).closest('tr');
            const coordName = row.find('td:first .fw-semibold').text();
            const lat = row.data('x');
            const lng = row.data('y');
            
            Swal.fire({
                title: 'Remove Coordinate?',
                html: `<div class="text-center">
                        <div class="mb-3">
                            <i class="bi bi-exclamation-triangle text-warning fs-1"></i>
                        </div>
                        <h5 class="mb-2">Confirm Removal</h5>
                        <p class="text-muted">
                            Are you sure you want to remove coordinate:<br>
                            <strong>"${coordName}"</strong><br>
                            <span class="small">(${lat}, ${lng})</span>
                        </p>
                    </div>`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '<i class="bi bi-trash me-1"></i> Remove',
                cancelButtonText: '<i class="bi bi-x-circle me-1"></i> Cancel',
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                reverseButtons: true,
                width: 450
            }).then((result) => {
                if (result.isConfirmed) {
                    row.fadeOut(300, function() {
                        $(this).remove();
                        updateCoordinateStats();
                        
                        // If table is empty, show empty state
                        if (tbody.find('tr[data-x][data-y]').length === 0) {
                            tbody.append(`
                                <tr id="noCoordinatesRow">
                                    <td colspan="4" class="text-center py-4">
                                        <div class="text-muted">
                                            <i class="bi bi-geo fs-1 mb-2 d-block"></i>
                                            <p class="mb-0">No coordinates added</p>
                                            <small>Click "Add Coordinate" or "Upload CSV" to get started</small>
                                        </div>
                                    </td>
                                </tr>
                            `);
                        }
                    });
                    
                    // Show removal success
                    Swal.fire({
                        title: 'Removed!',
                        text: 'Coordinate has been removed',
                        icon: 'success',
                        timer: 1500,
                        showConfirmButton: false
                    });
                }
            });
        });
        
        // Add event listeners to zoom buttons
        $('.btn-zoom-coordinate').off('click').on('click', function() {
            const lat = $(this).data('lat');
            const lng = $(this).data('lng');
            const coordName = $(this).closest('tr').find('.fw-semibold').text();
            
            // Call zoom function if it exists
            if (typeof zoomToCoordinate === 'function') {
                zoomToCoordinate(lat, lng);
            }
            
            // Show success message
            Swal.fire({
                title: 'Zooming to Coordinate',
                html: `<div class="text-center">
                        <div class="mb-3">
                            <i class="bi bi-zoom-in text-primary fs-1"></i>
                        </div>
                        <p class="mb-0"><strong>${coordName}</strong></p>
                        <p class="text-muted small mb-0">${lat}, ${lng}</p>
                    </div>`,
                icon: 'info',
                timer: 1500,
                showConfirmButton: false
            });
        });
        
        // Initialize tooltips for all buttons
        tbody.find('[data-bs-toggle="tooltip"]').each(function() {
            new bootstrap.Tooltip(this);
        });
        
        // Update statistics
        updateCoordinateStats();
        
        // Optionally update WKT polygon if needed
        updateWktFromCoordinates();
        
        // Optionally update map visualization
        if (typeof updateMapWithCoordinates === 'function') {
            updateMapWithCoordinates(coordinates);
        }
        
        // Show success summary
        setTimeout(() => {
            Swal.fire({
                title: 'Success!',
                html: `<div class="text-center">
                        <div class="mb-3">
                            <i class="bi bi-check-circle-fill text-success fs-1"></i>
                        </div>
                        <h5 class="mb-2">${coordinates.length} Coordinates Loaded</h5>
                        <p class="text-muted">
                            CSV file processed successfully.<br>
                            All coordinates have been added to the table.
                        </p>
                    </div>`,
                icon: 'success',
                confirmButtonText: 'Continue',
                confirmButtonColor: '#198754',
                width: 500,
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {

                    // 🔴 Close any open SweetAlert
                    Swal.close();

                    // 🔵 Open Bootstrap modal
                    const modalEl = document.getElementById('upload_coordinate');
                    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                    modal.show();
                }
            });
        }, 500);
    }
    
    // Alternative simpler version (without preview)
    $('#btn-uploadcoordiantecsv').on('click', function() {
        // This keeps your original upload logic but triggered differently
        const csvInput = $('#txtFileUploaduploadcoordiantecsv');
        const csvFile = csvInput[0].files[0];
        
        if (!csvFile) {
            Swal.fire({
                title: 'No File Selected',
                text: 'Please select a CSV file to upload',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }
        
        // Your original upload logic here
        // ... rest of your upload code
        
        Swal.fire({
            title: 'Upload Complete',
            text: 'Coordinates have been uploaded successfully',
            icon: 'success',
            confirmButtonText: 'OK'
        });
    });

    // Handle Clear All Coordinates button click
    $('#btn_clear_all_coordinates').on('click', function() {
        const table = $('#coordinatelis_Table');
        const tbody = table.find('tbody');
        const coordinateRows = tbody.find('tr[data-x][data-y]');
        const coordinateCount = coordinateRows.length;
        
        // If no coordinates, do nothing
        if (coordinateCount === 0) {
            return;
        }
        
        // Confirmation dialog
        Swal.fire({
            title: 'Clear All Coordinates?',
            html: `<div class="text-center">
                    <div class="mb-3">
                        <i class="bi bi-exclamation-triangle text-danger fs-1"></i>
                    </div>
                    <h5 class="mb-2">Confirm Removal</h5>
                    <p class="text-muted">
                        Are you sure you want to remove <strong>all ${coordinateCount} coordinates</strong>?<br>
                        <small class="text-danger">This action cannot be undone.</small>
                    </p>
                </div>`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '<i class="bi bi-trash me-1"></i> Clear All',
            cancelButtonText: '<i class="bi bi-x-circle me-1"></i> Cancel',
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            reverseButtons: true,
            width: 450
        }).then((result) => {
            if (result.isConfirmed) {
                // Animate removal of all rows
                coordinateRows.fadeOut(500, function() {
                    // Remove all coordinate rows
                    tbody.find('tr[data-x][data-y]').remove();
                    
                    // Show empty state
                    if (tbody.find('tr').length === 0) {
                        tbody.append(`
                            <tr id="noCoordinatesRow">
                                <td colspan="4" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="bi bi-geo fs-1 mb-3 d-block"></i>
                                        <h5 class="mb-2">No Coordinates</h5>
                                        <p class="mb-1">Click "Add Coordinate" or "Upload CSV" to get started</p>
                                        <small class="d-block">Coordinates will appear here once added</small>
                                    </div>
                                </td>
                            </tr>
                        `);
                    }
                    
                    // Update button state
                    $('#btn_clear_all_coordinates').prop('disabled', true);
                    
                    // Update other dependent button states
                    updateCoordinateDependentButtons();
                    
                    // Update statistics
                    updateCoordinateStats();
                    
                    // Clear WKT output
                    if ($('#wktOutput').length) {
                        $('#wktOutput').val('');
                    }
                    
                    // Clear map visualization if function exists
                    if (typeof clearMapCoordinates === 'function') {
                        clearMapCoordinates();
                    }
                    
                    // Show success message
                    Swal.fire({
                        title: 'Cleared!',
                        html: `<div class="text-center">
                                <div class="mb-3">
                                    <i class="bi bi-check-circle text-success fs-1"></i>
                                </div>
                                <p class="mb-0">All coordinates have been removed</p>
                                <p class="text-muted small mb-0">${coordinateCount} coordinates cleared</p>
                            </div>`,
                        icon: 'success',
                        timer: 2000,
                        showConfirmButton: false,
                        toast: true,
                        position: 'top-end'
                    });
                });
            }
        });
    });

    $('#send_to_frrv').on('shown.bs.modal', function (e) {

        var job_number = $("#cs_main_job_number").val();

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'select_frrv_details_on_job_number',
                // case_number:case_number,
                job_number:job_number,
                //   fullname:send_by_name,
                //   userid:send_by_id
            },
            cache: false,
            beforeSend: function () {
            // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(jobdetails) {
            
                // console.log(jobdetails);

                if(!jobdetails) {
                    return;
                }

                var json_p = JSON.parse(jobdetails);

                if(json_p.count > 1){

                    $('#btn_send_to_frrv').prop('disabled', true);
                }

                let _html_lrd_badge;
                let _html_smd_badge;
                let _html_pvlmd_badge;

                if(json_p.lrd == 1) {

                    _html_lrd_badge = '<span class="badge bg-success">Sent</span'
                } else {
                    _html_lrd_badge = '<span class="badge bg-danger">Not Sent</span'
                }

                if(json_p.smd == 1) {

                    _html_smd_badge = '<span class="badge bg-success"> Sent</span'
                
                }else {
                    _html_smd_badge = '<span class="badge bg-danger">Not Sent</span'
                }

                if(json_p.pvlmd == 1) {

                    _html_pvlmd_badge = '<span class="badge bg-success">Sent</span'
                
                }else {
                    _html_pvlmd_badge = '<span class="badge bg-danger">Not Sent</span'
                }

                document.getElementById('send_pvlmd_badge_ffrv_v').innerHTML = _html_pvlmd_badge;
                document.getElementById('send_smd_badge_ffrv_v').innerHTML = _html_smd_badge;
                document.getElementById('send_lrd_badge_ffrv_v').innerHTML = _html_lrd_badge;
    
            }
		}); 

    }); 

    // Toggle attachments table visibility
    $('#view_existing_records_info').on('click', function(e) {
        e.preventDefault();
        const table = $('#exreinfo_table');
        table.toggleClass('d-none');
        
        // Change icon based on visibility
        const icon = $(this).find('i');
        if (table.hasClass('d-none')) {
            // icon.removeClass('ri-arrow-up-s-line me-1').addClass('ri-attachment-line me-1');
            $(this).html('<i class="ri-attachment-line me-1"></i> View Attachments (Existing Records Information)');
        } else {
            // icon.removeClass('ri-attachment-line me-1').addClass('ri-arrow-up-s-line me-1');
            $(this).html('<i class="ri-arrow-up-s-line me-1"></i> Hide Attachments');

            loadFRRVScannedDocuments();
        }
    });

    function loadFRRVScannedDocuments() {
        var table_docs = $('#lc_frrv_scanned_documents_dataTable');
        table_docs.find("tbody tr").remove(); 	

        var case_number = $("#cs_main_case_number").val();

        $.ajax({
            type: "POST",
            url: "LoadLRDJackets",
            data: {
            request_type: 'load_case_scanned_document_new',
            case_number:case_number},
            cache: false,
            beforeSend: function () {},
            success: function(serviceresponse) {
                if(!serviceresponse){
                    return;
                }
                try{
                    var json_p = JSON.parse(serviceresponse);              
                    
                    $(json_p).each(function () {
                            
                        table_docs.append("<tr><td> " + this.doc_description + "</td><td>" +this.document_extention + "</td>"
                            +"<td> <button type='button' class='btn btn-outline-info btn-sm btn-preview-document'" +
                                                "data-document-path='" + this.document_file + "'" +
                                                +"data-document-name='" + this.doc_description + "'>" +
                                                "<i class='bi bi-eye'></i>" +
                                        "</button></td>"
                            + "</tr>");

                    });

                }catch(e){
                    console.log(e)
                }
            }
        });
    }
    
    // Initialize tooltips
    $('#review_records_verification').on('shown.bs.modal', function () {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
    
    $(document).on('click', '.viewNotesModal', function() {
        const noteId = $(this).data('target-id');
        const noteDescription = $(this).data('an_description');
        const createdBy = $(this).data('created_by');
        const createdDate = $(this).data('created_date');
        const modifiedBy = $(this).data('modified_by') || 'Not modified';
        const modifiedDate = $(this).data('modified_date') || 'Not modified';
        const noteStatus = $(this).data('note_status') || 'active';
        const noteDivision = $(this).data('division');
        
        // Populate the viewNotesModal with data
        $('#viewNotesModal #vi_note_id').val(noteId);
        $('#viewNotesModal #vi_note_description').html(formatNoteDescription(noteDescription));
        $('#viewNotesModal #vi_created_by').text(createdBy);
        $('#viewNotesModal #vi_created_date').text(createdDate);
        $('#viewNotesModal #vi_modified_by').text(modifiedBy);
        $('#viewNotesModal #vi_modified_date').text(modifiedDate);
        
        // Update status badge
        updateNoteStatusBadge(noteStatus);
        
        // Update last updated timestamp
        const lastUpdated = modifiedDate !== 'Not modified' ? modifiedDate : createdDate;
        $('#vi_last_updated').text(formatDate(lastUpdated));
        
        // Set modal title
        $('#viewNotesModalLabel').html(`<i class="fas fa-sticky-note me-2"></i>View Note #${noteId} | ${noteDivision}`);
        
        // Show the modal
        const viewModal = new bootstrap.Modal(document.getElementById('viewNotesModal'));
        viewModal.show();
    });
    
    // Format note description with line breaks and formatting
    function formatNoteDescription(description) {
        if (!description) return '<span class="text-muted">No description provided</span>';
        
        // Replace newlines with <br> tags
        let formatted = description.replace(/\n/g, '<br>');
        
        // Highlight important text patterns
        // formatted = formatted.replace(/(URGENT|IMPORTANT|CRITICAL|ACTION REQUIRED)/gi, 
        //     '<span class="badge bg-danger bg-opacity-10 text-danger">$1</span>');
        
        // Highlight dates
        // formatted = formatted.replace(/(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4})/g, 
        //     '<span class="badge bg-info bg-opacity-10 text-info">$1</span>');
        
        return formatted;
    }
    
    // Format date for display
    function formatDate(dateString) {
        if (!dateString || dateString === 'Not modified') return 'Not available';
        
        try {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return dateString;
        }
    }
    
    // Update status badge
    function updateNoteStatusBadge(status) {
        const statusElement = $('#viewNotesModal .card-body .badge');
        
        switch(status.toLowerCase()) {
            case 'active':
                statusElement.removeClass('bg-danger bg-warning')
                             .addClass('bg-success bg-opacity-10 text-success border border-success border-opacity-25')
                             .html('<i class="fas fa-check-circle me-1"></i>Active');
                break;
            case 'inactive':
            case 'disabled':
                statusElement.removeClass('bg-success bg-warning')
                             .addClass('bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25')
                             .html('<i class="fas fa-times-circle me-1"></i>Disabled');
                break;
            case 'pending':
                statusElement.removeClass('bg-success bg-danger')
                             .addClass('bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25')
                             .html('<i class="fas fa-clock me-1"></i>Pending');
                break;
        }
    }
    
    // Print button functionality
    $('#btn_print_note').on('click', function() {
        const printContent = `
            <html>
                <head>
                    <title>Note Details</title>
                    <style>
                        body { font-family: Arial, sans-serif; padding: 20px; }
                        .header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
                        .content { margin: 20px 0; }
                        .metadata { margin-top: 20px; font-size: 0.9em; color: #666; }
                    </style>
                </head>
                <body>
                    <div class="header">
                        <h2>Note Details</h2>
                        <p><strong>Note ID:</strong> ${$('#vi_note_id').val()}</p>
                        <p><strong>Job Number:</strong> ${$('#vi_an_job_number').val()}</p>
                        <p><strong>Case Number:</strong> ${$('#vi_an_case_number').val()}</p>
                    </div>
                    <div class="content">
                        <h3>Description</h3>
                        <p>${$('#vi_note_description').text()}</p>
                    </div>
                    <div class="metadata">
                        <p><strong>Created By:</strong> ${$('#vi_created_by').text()}</p>
                        <p><strong>Created Date:</strong> ${$('#vi_created_date').text()}</p>
                        <p><strong>Modified By:</strong> ${$('#vi_modified_by').text()}</p>
                        <p><strong>Modified Date:</strong> ${$('#vi_modified_date').text()}</p>
                    </div>
                </body>
            </html>
        `;
        
        const printWindow = window.open('', '_blank');
        printWindow.document.write(printContent);
        printWindow.document.close();
        printWindow.print();
    });
    
    // Edit button functionality
    $('#btn_edit_note').on('click', function() {
        const noteId = $('#vi_note_id').val();
        
        // Close view modal
        bootstrap.Modal.getInstance(document.getElementById('viewNotesModal')).hide();
        
        // Open edit modal (you'll need to create this or use addNotesModal for editing)
        // For now, show a message
        Swal.fire({
            title: 'Edit Note',
            text: `Would you like to edit note #${noteId}?`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Yes, edit',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                // Here you would typically open an edit modal
                // For example: $('#addNotesModal').modal('show');
                console.log('Opening edit modal for note:', noteId);
            }
        });
    });

    window.loadReviewApplicationDocuments = function(){
        var table_docs = $('#lc_review_scanned_documents_dataTable');
        table_docs.find("tbody tr").remove(); 	

        var case_number = $("#cs_main_case_number").val();

        $.ajax({
            type: "POST",
            url: "LoadLRDJackets",
            data: {
            request_type: 'load_case_scanned_document_new',
            case_number:case_number},
            cache: false,
            beforeSend: function () {},
            success: function(serviceresponse) {
                if(!serviceresponse){
                    return;
                }
                try{
                    var json_p = JSON.parse(serviceresponse);              
                    
                    $(json_p).each(function () {
                            
                        table_docs.append("<tr><td> " + this.doc_description + "</td><td>" +this.document_extention + "</td>"
                            +"<td> <button type='button' class='btn btn-outline-info btn-sm btn-preview-document'" +
                                                "data-document-path='" + this.document_file + "'" +
                                                +"data-document-name='" + this.doc_description + "'>" +
                                                "<i class='bi bi-eye'></i>" +
                                        "</button></td>"
                            + "</tr>");

                    });

                    $("#appDocsCount").text(json_p.length);

                }catch(e){
                    console.log(e)
                }
            }
        });
    }

    window.loadReviewPublicDocuments = function(){
        var table_docs = $('#lc_review_public_documents_dataTable');
        table_docs.find("tbody tr").remove(); 	

        var case_number = $("#cs_main_case_number").val();

        $.ajax({
            type: "POST",
            url: "LoadLRDJackets",
            data: {
            request_type: 'load_case_scanned_document_public_new',
            case_number:case_number},
            cache: false,
            beforeSend: function () {},
            success: function(serviceresponse) {
                if(!serviceresponse){
                    return;
                }
                try{
                    var json_p = JSON.parse(serviceresponse);              
                    
                    $(json_p).each(function () {
                            
                        table_docs.append("<tr><td> " + this.doc_description + "</td><td>" +this.document_extention + "</td>"
                            +"<td> <button type='button' class='btn btn-outline-info btn-sm btn-preview-document'" +
                                                "data-document-path='" + this.document_file + "'" +
                                                +"data-document-name='" + this.doc_description + "'>" +
                                                "<i class='bi bi-eye'></i>" +
                                        "</button></td>"
                            + "</tr>");

                    });

                    $("#publicDocsCount").text(json_p.length);

                }catch(e){
                    console.log(e)
                }
            }
        });
    }

    // Update publication date button
    $('#lc_btn_update_publication_date').on('click', function(e) {
        const btn = $(this);
        const selectedDate = $('#lc_txt_publicity_date').val();
        const case_number = $("#cs_main_case_number").val();
        const job_number = $("#cs_main_job_number").val();
        
        // Get user info from localStorage
        const send_by_id = localStorage.getItem('userid');
        const send_by_name = localStorage.getItem('fullname');
        
        // Validation
        if (!selectedDate) {
            Swal.fire({
                title: 'Date Required',
                text: 'Please select a publication date',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }
        
        // Optional: Validate date is not in the past
        // const today = new Date().toISOString().split('T')[0];
        // if (new Date(selectedDate) < new Date(today)) {
        //     Swal.fire({
        //         title: 'Invalid Date',
        //         text: 'Publication date cannot be in the past',
        //         icon: 'error',
        //         confirmButtonText: 'OK'
        //     });
        //     return;
        // }
        
        // Confirmation dialog
        Swal.fire({
            title: 'Update Publication Date?',
            html: `<div class="text-center">
                    <!--<div class="mb-3">
                        <i class="fas fa-calendar-check text-primary fa-3x"></i>
                    </div>-->
                    <p>Set publication date to:</p>
                    <h5 class="text-primary">${selectedDate}</h5>
                    <p class="text-muted small mt-2">This date will be used for public notice publishing</p>
                    <div class="alert alert-warning bg-warning bg-opacity-10 border-warning mt-3">
                        <i class="fas fa-info-circle me-2"></i>
                        <small>Job Number: <strong>${job_number}</strong></small>
                        <small>Case Number: <strong>${case_number}</strong></small>
                    </div>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '<i class="fas fa-save me-1"></i>Update Date',
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#fd7e14',
            cancelButtonColor: '#6c757d',
            width: 500
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                const originalText = btn.html();
                btn.prop('disabled', true);
                btn.html('<span class="spinner-border spinner-border-sm me-1" role="status"></span>Updating...');
                
                // Make AJAX call
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                        request_type: 'select_update_publication_date',
                        case_number: case_number,
                        publication_date: selectedDate,
                        fullname: send_by_name,
                        userid: send_by_id
                    },
                    cache: false,
                    beforeSend: function() {
                        // Optional: Show additional loading indicator
                    },
                    success: function(response) {
                        // console.log('Server response:', response);
                        
                        // Update UI on success
                        $('#lc_txt_publicity_date').prop('readonly', true);
                        btn.prop('disabled', true);
                        btn.removeClass('btn-warning').addClass('btn-success');
                        btn.html('<i class="fas fa-check me-1"></i>Date Set');
                        
                        // Enable the "Send for Publication" button if it exists
                        if ($('#lc_btn_add_to_publication_list').length) {
                            $('#lc_btn_add_to_publication_list').prop('disabled', false);
                        }
                        
                        // Update status badge
                        $('.card-body .badge').removeClass('bg-warning').addClass('bg-success').text('Date Set');
                        
                        // Show success message with server response
                        Swal.fire({
                            title: 'Success!',
                            html: `<div class="text-start">
                                    <!-- <div class="mb-3">
                                        <i class="fas fa-check-circle text-success fa-3x"></i>
                                    </div> -->
                                    <h5>Publication Date Updated</h5>
                                    <p class="text-muted mb-2">${response}</p>
                                    <div class="alert alert-info mt-3">
                                        <i class="fas fa-calendar-alt me-2"></i>
                                        <strong>Date Set:</strong> ${selectedDate}
                                    </div>
                                </div>`,
                            icon: 'success',
                            confirmButtonText: 'Continue',
                            confirmButtonColor: '#198754',
                            showCancelButton: false
                        });
                        
                        // Optional: Trigger any other updates needed
                        // updatePublicationStatus();
                        
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', error);
                        
                        // Reset button state
                        btn.prop('disabled', false);
                        btn.html(originalText);
                        
                        // Show error message
                        Swal.fire({
                            title: 'Update Failed',
                            html: `<div class="text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-exclamation-triangle text-danger fa-3x"></i>
                                    </div>
                                    <p>Failed to update publication date</p>
                                    <p class="text-danger small">${error || 'Server error occurred'}</p>
                                </div>`,
                            icon: 'error',
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    },
                    complete: function() {
                        // Optional: Any cleanup after request completes
                    }
                });
            }
        });
    });

    $('#lc_btn_add_to_publication_list').on('click', function(e) {
        const btn = $(this);
        const job_number = $("#cs_main_job_number").val();
        const case_number = $("#cs_main_case_number").val();
        const publicationDate = $('#lc_txt_publicity_date').val();
        
        // Get user info from localStorage
        const send_by_id = localStorage.getItem('userid');
        const send_by_name = localStorage.getItem('fullname');
        
        
        // Confirmation dialog
        Swal.fire({
            title: 'Send for Publication?',
            html: `<div class="text-center">
                    <div class="mb-3">
                        <i class="fas fa-bullhorn text-primary fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Confirm Publication Submission</h5>
                    <div class="alert alert-warning bg-warning bg-opacity-10 border-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong>Important:</strong> This action will submit the notice for public publication
                    </div>
                    <div class="text-start mt-3">
                        <p><strong>Job Number:</strong> ${job_number}</p>
                        <p><strong>Case Number:</strong> ${case_number}</p>
                    </div>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '<i class="fas fa-upload me-1"></i>Send for Publication',
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            width: 550
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                const originalText = btn.html();
                btn.prop('disabled', true);
                btn.html('<span class="spinner-border spinner-border-sm me-1" role="status"></span>Processing...');
                
                // Make AJAX call
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                        request_type: 'select_add_to_publication',
                        case_number: case_number,
                        job_number: job_number,
                        fullname: send_by_name,
                        userid: send_by_id
                    },
                    cache: false,
                    beforeSend: function() {
                        // Optional: Show additional loading indicator
                    },
                    success: function(response) {
                        // console.log('Server response:', response);
                        
                        // Update UI on success
                        btn.removeClass('btn-primary').addClass('btn-success');
                        btn.html('<i class="fas fa-check me-1"></i>Sent for Publication');
                        
                        // Disable the date field and update button if they exist
                        if ($('#lc_txt_publicity_date').length) {
                            $('#lc_txt_publicity_date').prop('readonly', true);
                        }
                        if ($('#lc_btn_update_publication_date').length) {
                            $('#lc_btn_update_publication_date').prop('disabled', true);
                            $('#lc_btn_update_publication_date').removeClass('btn-warning').addClass('btn-secondary');
                            $('#lc_btn_update_publication_date').html('<i class="fas fa-lock me-1"></i>Locked');
                        }
                        
                        // Update status badge
                        $('.card-body .badge').removeClass('bg-warning bg-success').addClass('bg-primary').text('Queued for Publication');
                        
                        // Show success message with server response
                        Swal.fire({
                            title: 'Success!',
                            html: `<div class="text-start">
                                    <div class="mb-3">
                                        <i class="fas fa-check-circle text-success fa-3x"></i>
                                    </div>
                                    <h5>Publication Submitted</h5>
                                    <p class="text-muted mb-2">${response}</p>
                                    <div class="alert alert-info mt-3">
                                        <div class="d-flex">
                                            <i class="fas fa-info-circle me-2 mt-1"></i>
                                            <div>
                                                <strong>Publication Details:</strong>
                                                <ul class="mb-0 ps-3">
                                                    <li><strong>Job:</strong> ${job_number}</li>
                                                    <li><strong>Case:</strong> ${case_number}</li>
                                                    <li><strong>Status:</strong> Queued for publication</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>`,
                            icon: 'success',
                            // confirmButtonText: 'View Publication List',
                            // confirmButtonColor: '#198754',
                            showCancelButton: true,
                            cancelButtonText: 'Close',
                            width: 600
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // Option 1: Close current modal and open publication list
                                const publicationModal = bootstrap.Modal.getInstance(document.getElementById('sent_for_publication'));
                                if (publicationModal) {
                                    publicationModal.hide();
                                }
                                
                                // Option 2: Redirect or open another modal
                                // $('#publicationListModal').modal('show');
                                // OR
                                // window.location.href = 'publication_list.jsp';
                                
                                // console.log('Redirecting to publication list...');
                            }
                        });
                        
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', error);
                        
                        // Reset button state
                        btn.prop('disabled', false);
                        btn.html(originalText);
                        
                        // Show error message
                        Swal.fire({
                            title: 'Submission Failed',
                            html: `<div class="text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-exclamation-triangle text-danger fa-3x"></i>
                                    </div>
                                    <p>Failed to submit for publication</p>
                                    <p class="text-danger small">${error || 'Server error occurred'}</p>
                                    <div class="alert alert-warning mt-3">
                                        <i class="fas fa-lightbulb me-2"></i>
                                        Please try again or contact system administrator
                                    </div>
                                </div>`,
                            icon: 'error',
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    },
                    complete: function() {
                        // Optional: Any cleanup after request completes
                    }
                });
            }
        });
    });

    $('#btn_save_lrd_title_plan_update_details_smd_new_update').on('click', function(e) {

		var job_number = $("#cs_main_job_number").val();
		var case_number = $("#cs_main_case_number").val();
		// var gid = $("#gid_pl_smd").val();
		var registry_mapref = $("#txt_lc_registry_mapref_pl_smd").val();
		// var size_of_land = $("#txt_lc_size_of_land_pl_smd").val();
		var plan_no = $("#txt_lc_plan_no_pl_smd").val();
		var ltr_plan_no = $("#ltr_plan_no_pl_smd").val();
		var cc_no = $("#txt_cc_no_pl_smd").val();
        // var transaction_number = $("#lc_txt_transaction_number_pl_smd").val();

         // Validation
        if (!registry_mapref || !plan_no || !ltr_plan_no || !cc_no) {
            Swal.fire({
                title: 'Required Fields',
                text: 'Plan Number and Registry Map Reference are required',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

         Swal.fire({
            title: 'Save Plan Details?',
            html: `<div class="text-center">
                    <div class="mb-3">
                        <i class="fas fa-map-marked-alt text-primary fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Confirm Plan Details</h5>
                    <div class="text-start">
                        <p><strong>Plan Number:</strong> ${plan_no}</p>
                        <p><strong>Registry Map Ref:</strong> ${registry_mapref}</p>
                        <p><strong>CC Number:</strong> ${cc_no || 'Not provided'}</p>
                        <p><strong>LTR Number:</strong> ${ltr_plan_no || 'Not provided'}</p>
                    </div>
                    <div class="alert alert-warning bg-warning bg-opacity-10 border-warning mt-3">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <small>These details will be used for official title plan generation</small>
                    </div>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '<i class="fas fa-save me-1"></i>Save Details',
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            width: 550
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading
                const btn = $('#btn_save_lrd_title_plan_update_details_smd_new_update');
                const originalText = btn.html();
                btn.prop('disabled', true);
                btn.html('<span class="mdi mdi-loading mdi-spin me-1" role="status"></span>Saving...');
			

                $.ajax({
                    type : "POST",
                    url : "Case_Management_Serv",
                    // target:'_blank',
                    data : {
                        request_type : 'select_update_title_plan_details_smd',
                        //gid : gid,
                        case_number:case_number,
                        job_number:job_number,
                        registry_mapref : registry_mapref,
                        //size_of_land : size_of_land,
                        plan_no : plan_no,
                        ltr_plan_no : ltr_plan_no,
                        cc_no : cc_no,
                        //transaction_number : transaction_number
                    },
                    cache : false,
                    /*
                        * xhrFields:{ responseType:
                        * 'blob' },
                        */
                    beforeSend : function() {
                        // $('#district').html('<img
                        // src="img/loading.gif"
                        // alt="" width="24"
                        // height="24">');
                    },
                    success : function(jobdetails) {


                        // Update UI on success
                        btn.removeClass('btn-primary').addClass('btn-success');
                        btn.html('<i class="fas fa-check me-1"></i>Details Saved');

                        // Make fields readonly
                        $('#txt_lc_plan_no_pl_smd, #txt_lc_registry_mapref_pl_smd, #txt_cc_no_pl_smd, #ltr_plan_no_pl_smd')
                            .prop('readonly', true)
                            .closest('.input-group').find('.input-group-text:last-child').removeClass('text-success').addClass('text-success');
                        
                        // Update status badge
                        $('.alert-info .badge').removeClass('bg-warning').addClass('bg-success').text('Completed');
                    
                        // Update last updated timestamp
                        $('#planLastUpdated').text('Just now');
                    
                        // Show success message
                        Swal.fire({
                            title: 'Success!',
                            html: `<div class="text-center">
                                <div class="mb-3">
                                    <i class="fas fa-check-circle text-success fa-3x"></i>
                                </div>
                                <h5>Plan Details Saved</h5>
                                <p class="text-muted">Title plan information has been successfully updated</p>
                                <div class="alert alert-info mt-3">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Plan is now ready for title plan generation process
                                </div>
                            </div>`,
                            icon: 'success',
                            confirmButtonText: 'Continue',
                            confirmButtonColor: '#198754'
                        });
                 
                    }
                });
            }
        });
    });

    // Copy WKT to clipboard
    $('#btn_copy_wkt').on('click', function() {
        const wktText = $('#lc_bl_wkt_polygon').val();
        if (wktText) {
            navigator.clipboard.writeText(wktText).then(() => {
                $(this).html('<i class="fas fa-check"></i>');
                setTimeout(() => {
                    $(this).html('<i class="fas fa-copy"></i>');
                }, 2000);
            });
        }
    });

    $(document).on('click', '#map-tab', function() {
        // console.log('Map tab clicked');
        window.initializeMap('lc-map__');
        
    });

    $("#view_parcel_and_transaction").on('shown.bs.modal', function(e) {

        var bs_desc = $(e.relatedTarget).data("bs-desc");
        //  console.log(bs_desc + 'vhgvgv')
    
        if(bs_desc == 'View and Confirm Parcel and Transaction'){
            $("#btn_confirm_registration_transaction").removeClass('d-none');
        } else {
            $("#btn_confirm_registration_transaction").addClass('d-none');
        }

    })

    window.loadGatedWorkFlowDocuments = function(modalType = 'proprietorship') {
         // Find the specific container in the active modal
        let container;
        
        if (modalType === 'proprietorship') {
            container = document.querySelector('#newProprietorshipModal ._gated_workflow_documents');
        } else if (modalType === 'memorial') {
            container = document.querySelector('#newMemorialsModal ._gated_workflow_documents');
        } else if (modalType === 'encumbrance') {
            container = document.querySelector('#newEncumberancesModal ._gated_workflow_documents');
        }
        
        if (!container) {
            console.error(`Container not found for modal type: ${modalType}`);
            return;
        }

        // Generate unique IDs based on modal type
        const accordionId = `rotDocumentsAccordion_${modalType}`;
        const appDocsTableId = `rot_lc_review_scanned_documents_dataTable_${modalType}`;
        const publicDocsTableId = `rot_lc_review_public_documents_dataTable_${modalType}`;
        const appDocsCountId = `appDocsCount_${modalType}`;
        const publicDocsCountId = `publicDocsCount_${modalType}`;
        const previewContentId = `rotPreviewContent_${modalType}`;
        const previewErrorId = `rotPreviewError_${modalType}`;

        const _documentSection = `
            <div class="accordion" id="${accordionId}">
                    
                    <!-- Application Documents Card -->
                    <div class="accordion-item border rounded mb-3">
                        <h2 class="accordion-header" id="headingApplication_${modalType}">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapseApplication_${modalType}" 
                                    aria-expanded="false" aria-controls="collapseApplication_${modalType}">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-folder-open fa-lg text-primary"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Application Documents</h6>
                                        <small class="text-muted">Private application documents</small>
                                    </div>
                                    <span class="badge bg-primary rounded-pill ms-2" id="${appDocsCountId}">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapseApplication_${modalType}" class="accordion-collapse collapse" 
                             aria-labelledby="headingApplication_${modalType}" data-bs-parent="#${accordionId}">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2 load-app-docs" 
                                                data-modal-type="${modalType}"
                                                data-doc-type="app"
                                            >
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Load
                                        </button>
                                         <!--<button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#fileUploadModal"
                                                data-bs-placement="top" title="Add Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Document
                                        </button>-->
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_app_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="${appDocsTableId}"">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="appDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-file-alt fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Application Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                    <!-- Public Documents Card -->
                    <div class="accordion-item border rounded">
                        <h2 class="accordion-header" id="headingPublic_${modalType}">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapsePublic_${modalType}" 
                                    aria-expanded="false" aria-controls="collapsePublic_${modalType}">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-users fa-lg text-success"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Public Documents</h6>
                                        <small class="text-muted">Publicly accessible documents</small>
                                    </div>
                                    <span class="badge bg-success rounded-pill ms-2" id="${publicDocsCountId}">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapsePublic_${modalType}" class="accordion-collapse collapse" 
                             aria-labelledby="headingPublic_${modalType}" data-bs-parent="#${accordionId}">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2 load-app-docs"
                                            data-modal-type="${modalType}"
                                            data-doc-type="public"
                                        >
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Load
                                        </button>
                                        <!--<button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#publicFileUploadModal"
                                                data-bs-placement="top" title="Add Public Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Public Document
                                        </button>-->
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_public_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Public Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="${publicDocsTableId}">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="publicDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-users fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Public Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Public Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                </div>

                <div class="card mt-3">
                    <div class="card-header">
                        Document Review
                    </div>
                    <div class="card-body">
                        <!--<div class="text-center py-5" id="previewLoading">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading preview...</span>
                            </div>
                            <p class="mt-3 text-muted">Loading document preview...</p>
                        </div>-->
                        <div id="${previewContentId}" class="d-none"></div>
                        <div class="text-center py-5 d-none" id="${previewErrorId}">
                            <i class="bi bi-file-earmark-x display-4 text-danger mb-3"></i>
                            <h6 class="text-danger mb-2">Preview Not Available</h6>
                            <p class="text-muted">This file type cannot be previewed in the browser.</p>
                        </div>
                    </div>
                </div>
        `
        container.innerHTML = _documentSection;
    }

    $(document).on('click', '.load-app-docs', function() {

        const modalType = $(this).data('modal-type');
        const docType = $(this).data('doc-type');

        docType == "app" ? window.rotLoadReviewApplicationDocuments(modalType) : window.rotLoadReviewPublicDocuments(modalType);
    });

    window.rotLoadReviewApplicationDocuments = function(modalType = 'proprietorship'){
        const tableId = `rot_lc_review_scanned_documents_dataTable_${modalType}`;
        const countId = `appDocsCount_${modalType}`;
        
        var table_docs = $(`#${tableId}`);
        table_docs.find("tbody tr").remove(); 

        var case_number = $("#cs_main_case_number").val();

        $.ajax({
            type: "POST",
            url: "LoadLRDJackets",
            data: {
            request_type: 'load_case_scanned_document_new',
            case_number:case_number},
            cache: false,
            beforeSend: function () {},
            success: function(serviceresponse) {
                if(!serviceresponse){
                    return;
                }
                try{
                    var json_p = JSON.parse(serviceresponse);              
                    
                    $(json_p).each(function () {
                            
                        table_docs.append("<tr><td> " + this.doc_description + "</td><td>" +this.document_extention + "</td>"
                            +"<td> <button type='button' class='btn btn-outline-info btn-sm btn-rot-preview-document'" +
                                                "data-document-path='" + this.document_file + "'" +
                                                +"data-document-name='" + this.doc_description + "'>" +
                                                "<i class='bi bi-eye'></i>" +
                                        "</button></td>"
                            + "</tr>");

                    });

                    $(`#${countId}`).text(json_p.length);

                }catch(e){
                    console.log(e)
                }
            }
        });
    }

    window.rotLoadReviewPublicDocuments = function(modalType = 'proprietorship'){
        const tableId = `rot_lc_review_public_documents_dataTable_${modalType}`;
        const countId = `publicDocsCount_${modalType}`;

        var table_docs = $(`#${tableId}`);
        table_docs.find("tbody tr").remove(); 

        var case_number = $("#cs_main_case_number").val();

        $.ajax({
            type: "POST",
            url: "LoadLRDJackets",
            data: {
            request_type: 'load_case_scanned_document_public_new',
            case_number:case_number},
            cache: false,
            beforeSend: function () {},
            success: function(serviceresponse) {
                if(!serviceresponse){
                    return;
                }
                try{
                    var json_p = JSON.parse(serviceresponse);              
                    
                    $(json_p).each(function () {
                            
                        table_docs.append("<tr><td> " + this.doc_description + "</td><td>" +this.document_extention + "</td>"
                            +"<td> <button type='button' class='btn btn-outline-info btn-sm btn-rot-preview-document'" +
                                                "data-document-path='" + this.document_file + "'" +
                                                +"data-document-name='" + this.doc_description + "'>" +
                                                "<i class='bi bi-eye'></i>" +
                                        "</button></td>"
                            + "</tr>");

                    });

                    $(`#${countId}`).text(json_p.length);

                }catch(e){
                    console.log(e)
                }
            }
        });
    }

    $(document).on('click', '.btn-rot-preview-document', function (e) {
        e.preventDefault();

        // Get the modal type from the closest container with dynamic ID
        const closestAccordion = $(this).closest('[id^="rotDocumentsAccordion_"]');
        let modalType = 'proprietorship'; // default
        
        if (closestAccordion.length) {
            const accordionId = closestAccordion.attr('id');
            if (accordionId.includes('memorial')) {
                modalType = 'memorial';
            }

            if (accordionId.includes('encumbrance')) {
                modalType = 'encumbrance';
            }
        }
        
        const previewContentId = `rotPreviewContent_${modalType}`;
        const previewErrorId = `rotPreviewError_${modalType}`;
        
        const previewContent = $(`#${previewContentId}`);
        const previewError = $(`#${previewErrorId}`);

        // ✅ ALWAYS USE currentTarget / this
        const file_to_open = $(this).data('document-path');

        //console.log('File path:', file_to_open);

        if (!file_to_open) {
            previewError.removeClass('d-none').text('Invalid file path');
            return;
        }

        const file_path = file_to_open.replace(/^file:\/\//, '');

        $.ajax({
            type: "POST",
            url: "open_pdffile",
            data: {
                request_type: 'request_to_generate_batch_list',
                file_to_open: file_path
            },
            xhrFields: {
                responseType: 'blob'
            },
            success: function (jobdetails) {
                const blob = new Blob([jobdetails], {
                    type: "application/pdf"
                });

                const objectUrl = URL.createObjectURL(blob);

                previewContent.removeClass('d-none').html(`
                    <iframe src="${objectUrl}"
                            width="100%"
                            height="800"
                            frameborder="0"></iframe>
                `);
            },
            error: function () {
                previewLoading.addClass('d-none');
                previewError.removeClass('d-none').text('Failed to load document');
            }
        });
    });

    $(document).on('click', '.newProprietorshipModal', function() {
        $("#newProprietorshipModal").modal('show');

        $("#ps_id").val(0);
        $("#ps_registration_number").val('');
        $("#ps_proprietor").val('');
        $("#ps_date_of_instrument").val('');
        $("#ps_nature_of_instrument").val('');
        $("#ps_date_of_registration").val('');
        $("#ps_transferor").val('');
        $("#ps_transferee").val('');
        $("#ps_price_paid").val('');
        $("#ps_remarks").val('');
        $("#ps_signature").val('');
        $("#ps_term").val('');

       window.loadGatedWorkFlowDocuments('proprietorship');
    })

    $('#form_add_proprietory').on('submit', function(e) {
        // validation code here
        e.preventDefault();
        // console.log('Form submitted');
        
        // Collect form data
        const ps_id = parseInt($("#ps_id").val());
        const case_number = $("#ps_case_number").val();
        const ps_registration_number = $("#ps_registration_number").val();
        const ps_proprietor = $("#ps_proprietor").val();
        const ps_date_of_instrument = $("#ps_date_of_instrument").val();
        const ps_nature_of_instrument = $("#ps_nature_of_instrument").val();
        const ps_date_of_registration = $("#ps_date_of_registration").val();
        const ps_transferor = $("#ps_transferor").val();
        const ps_transferee = $("#ps_transferee").val();
        const ps_price_paid = $("#ps_price_paid").val();
        const ps_remarks = $("#ps_remarks").val();
        const ps_signature = $("#ps_signature").val();
        const ps_term = $("#ps_term").val();
        
        // Validate required fields
        const requiredFields = [
            { field: 'ps_registration_number', value: ps_registration_number, label: 'Registered Number' },
            { field: 'ps_proprietor', value: ps_proprietor, label: 'Proprietor' },
            { field: 'ps_date_of_instrument', value: ps_date_of_instrument, label: 'Date of Instrument' },
            { field: 'ps_nature_of_instrument', value: ps_nature_of_instrument, label: 'Nature of Instrument' },
            { field: 'ps_date_of_registration', value: ps_date_of_registration, label: 'Date of Registration' },
            { field: 'ps_term', value: ps_term, label: 'Term' }
        ];
        
        // Check for empty required fields
        const emptyFields = requiredFields.filter(field => !field.value.trim());
        if (emptyFields.length > 0) {
            const fieldNames = emptyFields.map(f => f.label).join(', ');
            Swal.fire({
                title: 'Required Fields Missing',
                html: `<div class="text-start">
                        <div class="mb-3">
                            <i class="fas fa-exclamation-triangle text-warning fa-2x"></i>
                        </div>
                        <p>The following fields are required:</p>
                        <ul class="text-start">
                            ${emptyFields.map(f => `<li><strong>${f.label}</strong></li>`).join('')}
                        </ul>
                        <p class="text-muted small mt-2">Please fill in all required fields before submitting</p>
                    </div>`,
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fd7e14'
            });
            return;
        }
        
        // Validate dates
        if (ps_date_of_instrument && ps_date_of_registration) {
            const instrumentDate = new Date(ps_date_of_instrument);
            const registrationDate = new Date(ps_date_of_registration);
            
            if (registrationDate < instrumentDate) {
                Swal.fire({
                    title: 'Date Validation Error',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="fas fa-calendar-times text-danger fa-2x"></i>
                            </div>
                            <p><strong>Date of Registration</strong> cannot be earlier than <strong>Date of Instrument</strong></p>
                            <p class="text-muted small">Please check the dates and try again</p>
                        </div>`,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
                return;
            }
        }
        
        // Prepare confirmation message based on action (add/edit)
        const isEdit = ps_id > 0;
        const actionText = isEdit ? 'Update' : 'Add';
        
        // Show confirmation dialog
        Swal.fire({
            title: `${actionText} Proprietorship Record?`,
            html: `<div class="text-start">
                    <div class="mb-3">
                        <i class="fas fa-user-tie text-primary fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Confirm ${actionText}</h5>
                    <div class="alert alert-info bg-info bg-opacity-10 border-info">
                        <div class="d-flex">
                            <i class="fas fa-info-circle me-2 mt-1"></i>
                            <div>
                                <strong>Record Details:</strong>
                                <ul class="mb-0 ps-3">
                                    <li><strong>Case:</strong> ${case_number}</li>
                                    <li><strong>Proprietor:</strong> ${ps_proprietor}</li>
                                    <li><strong>Registered No:</strong> ${ps_registration_number}</li>
                                    <li><strong>Nature:</strong> ${ps_nature_of_instrument}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <p class="text-muted small mt-3">
                        This action will ${isEdit ? 'update the existing' : 'create a new'} 
                        proprietorship record in the system.
                    </p>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: `<i class="fas fa-save me-1"></i>${actionText} Record`,
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            width: 550,
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                const submitBtn = $('#btn_proprietorship');
                const originalText = submitBtn.html();
                submitBtn.prop('disabled', true);
                submitBtn.html('<span class="spinner-border spinner-border-sm me-1" role="status"></span>Processing...');
                
                // Determine request type
                const request_type = "select_lrd_proprietorship_section_add_and_update";
                
                // Make AJAX call
                $.ajax({
                    type: "POST",
                    url: "lrd_proprietorship_section_serv",
                    data: {
                        request_type: request_type,
                        ps_id: ps_id,
                        ps_case_number: case_number,
                        ps_registration_number: ps_registration_number,
                        ps_proprietor: ps_proprietor,
                        ps_date_of_instrument: ps_date_of_instrument,
                        ps_nature_of_instrument: ps_nature_of_instrument,
                        ps_date_of_registration: ps_date_of_registration,
                        ps_transferor: ps_transferor,
                        ps_transferee: ps_transferee,
                        ps_price_paid: ps_price_paid,
                        ps_remarks: ps_remarks,
                        ps_signature: ps_signature,
                        ps_term: ps_term
                    },
                    cache: false,
                    beforeSend: function() {
                        // Additional loading indicators can be added here
                    },
                    success: function(jobdetails) {
                        // console.log('Server response:', jobdetails);
                        
                        try {
                            const json_p = JSON.parse(jobdetails);
                            
                            // Close the modal
                            const modal = bootstrap.Modal.getInstance(document.getElementById('newProprietorshipModal'));
                            if (modal) {
                                modal.hide();
                            }
                            
                            // Show success message
                            Swal.fire({
                                title: 'Success!',
                                html: `<div class="text-center">
                                        <div class="mb-3">
                                            <i class="fas fa-check-circle text-success fa-3x"></i>
                                        </div>
                                        <h5 class="mb-2">Record ${isEdit ? 'Updated' : 'Added'}</h5>
                                        <p class="text-muted">
                                            Proprietorship details have been ${isEdit ? 'updated' : 'added'} successfully
                                        </p>
                                        <div class="alert alert-success bg-success bg-opacity-10 border-success mt-3">
                                            <i class="fas fa-check me-2"></i>
                                            <strong>Details:</strong> ${ps_proprietor} (${ps_registration_number})
                                        </div>
                                    </div>`,
                                icon: 'success',
                                confirmButtonText: 'Continue',
                                confirmButtonColor: '#198754',
                                timer: 3000,
                                timerProgressBar: true
                            });
                            
                            // Update the table with new data
                            updateProprietorshipTable(json_p.data);
                            
                        } catch (error) {
                            console.error('JSON parsing error:', error);
                            
                            // Show error message for parsing failure
                            Swal.fire({
                                title: 'Processing Error',
                                text: 'Failed to process server response',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#dc3545'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX error:', error);
                        
                        // Show error message
                        Swal.fire({
                            title: 'Save Failed',
                            html: `<div class="text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-exclamation-circle text-danger fa-3x"></i>
                                    </div>
                                    <h5 class="mb-2">Unable to Save Record</h5>
                                    <p class="text-danger small">${error || 'Server error occurred'}</p>
                                    <div class="alert alert-warning mt-3">
                                        <i class="fas fa-lightbulb me-2"></i>
                                        Please try again or contact system administrator
                                    </div>
                                </div>`,
                            icon: 'error',
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    },
                    complete: function() {
                        // Reset button state
                        submitBtn.prop('disabled', false);
                        submitBtn.html(originalText);
                    }
                });
            }
        });
    });

    // Function to update the proprietorship table
    function updateProprietorshipTable(data) {
        const table_bp = $('#lrd_proprietorship_details_dataTable, #lrd_proprietorship_details_dataTable_final_approval');
        table_bp.find("tbody tr").remove();
        
        if (data && data.length > 0) {
            $(data).each(function() {
                const canEdit = this.edit == 1 ? 'd-none' : '';
                table_bp.append(`<tr>
                    <td>
                        <span class="badge bg-info bg-opacity-10 text-info">
                            ${this.ps_registration_number}
                        </span>
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user text-muted me-2"></i>
                            <span>${this.ps_proprietor}</span>
                        </div>
                    </td>
                    <td>${this.ps_date_of_instrument}</td>
                    <td>
                        <span class="badge bg-secondary">
                            ${this.ps_nature_of_instrument}
                        </span>
                    </td>
                    <td>${this.ps_date_of_registration}</td>
                    <td>
                        <div class="small">
                            <div><strong>From:</strong> ${this.ps_transferor}</div>
                            <div><strong>To:</strong> ${this.ps_transferee}</div>
                        </div>
                    </td>
                    <td><span class="fw-medium text-success">${this.ps_price_paid}</span></td>
                    <!--<td>${this.ps_remarks}</td>-->
                    <td>${this.ps_term}</td>
                    <td class="text-center">
                        <button class="btn btn-outline-primary btn-sm ${canEdit} editProprietorshipModal" 
                                data-target-id="${this.ps_id}" 
                                data-ps_id="${this.ps_id}"
                                data-ps_case_number="${this.ps_case_number}"
                                data-ps_registration_number="${this.ps_registration_number}"
                                data-ps_proprietor="${this.ps_proprietor}"
                                data-ps_date_of_instrument="${this.ps_date_of_instrument}"
                                data-ps_nature_of_instrument="${this.ps_nature_of_instrument}"
                                data-ps_date_of_registration="${this.ps_date_of_registration}"
                                data-ps_transferor="${this.ps_transferor}"
                                data-ps_transferee="${this.ps_transferee}"
                                data-ps_price_paid="${this.ps_price_paid}"
                                data-ps_remarks="${this.ps_remarks}"
                                data-ps_signature="${this.ps_signature}"
                                data-ps_term="${this.ps_term}"
                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>
                    </td>
                </tr>`);
            });
            
            // Initialize tooltips for new buttons
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.forEach(function (tooltipTriggerEl) {
                new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
        } else {
            // Show empty state
            table_bp.append(`<tr>
                <td colspan="10" class="text-center py-4">
                    <div class="text-muted">
                        <i class="fas fa-user-tie fa-2x mb-2 d-block"></i>
                        <p class="mb-0">No proprietorship records found</p>
                        <small>Click "Add Proprietor" to create a new record</small>
                    </div>
                </td>
            </tr>`);
        }
    }

    $(document).on('click', '.editProprietorshipModal', function(e) {
        $("#newProprietorshipModal").modal('show');

        const ps_id = $(this).data('ps_id');
        const ps_registration_number = $(this).data('ps_registration_number');
        const ps_proprietor = $(this).data('ps_proprietor');
        const ps_date_of_instrument = $(this).data('ps_date_of_instrument');
        const ps_nature_of_instrument = $(this).data('ps_nature_of_instrument');
        const ps_date_of_registration = $(this).data('ps_date_of_registration');
        const ps_transferor = $(this).data('ps_transferor');
        const ps_transferee = $(this).data('ps_transferee');
        const ps_price_paid = $(this).data('ps_price_paid');
        const ps_remarks = $(this).data('ps_remarks');
        const ps_signature = $(this).data('ps_signature');
        const ps_term = $(this).data('ps_term');

        $("#ps_id").val(ps_id);
        $("#ps_registration_number").val(ps_registration_number);
        $("#ps_proprietor").val(ps_proprietor);
        $("#ps_date_of_instrument").val(ps_date_of_instrument);
        $("#ps_nature_of_instrument").val(ps_nature_of_instrument);
        $("#ps_date_of_registration").val(ps_date_of_registration);
        $("#ps_transferor").val(ps_transferor);
        $("#ps_transferee").val(ps_transferee);
        $("#ps_price_paid").val(ps_price_paid);
        $("#ps_remarks").val(ps_remarks);
        $("#ps_signature").val(ps_signature);
        $("#ps_term").val(ps_term);

        window.loadGatedWorkFlowDocuments('proprietorship');
    });

    $(document).on('click', '.newMemorialsModal', function() {
        $("#newMemorialsModal").modal('show');

        $("#mid").val(0);
        $("#m_registered_no").val('');
        $("#m_entry_number").val('');
        $("#m_date_of_instrument").val('');
        $("#m_date_of_registration").val('');
        $("#m_remarks").val('');

        window.loadGatedWorkFlowDocuments('memorial');
    });

    $('#form_add_memorials').on('submit', function(e) {
        e.preventDefault();
        // console.log('Form submitted');
        
        // Collect form data
        const mid = parseInt($("#mid").val());
        const m_case_number = $("#m_case_number").val();
        const m_registered_no = $("#m_registered_no").val();
        const m_memorials = $("#m_memorials").val();
        const m_date_of_instrument = $("#m_date_of_instrument").val();
        const m_date_of_registration = $("#m_date_of_registration").val();
        const m_remarks = $("#m_remarks").val();
        const m_entry_number = $("#m_entry_number").val();
        
        // Validate required fields
        const requiredFields = [
            { field: 'm_registered_no', value: m_registered_no, label: 'Registered Number' },
            { field: 'm_memorials', value: m_memorials, label: 'Memorials' },
            { field: 'm_date_of_instrument', value: m_date_of_instrument, label: 'Date of Instrument' },
            { field: 'm_date_of_registration', value: m_date_of_registration, label: 'Date of Registration' },
            { field: 'm_entry_number', value: m_entry_number, label: 'Entry Number' }
        ];
        
        // Check for empty required fields
        const emptyFields = requiredFields.filter(field => !field.value.trim());
        if (emptyFields.length > 0) {
            Swal.fire({
                title: 'Required Fields Missing',
                html: `<div class="text-start">
                        <div class="mb-3">
                            <i class="fas fa-exclamation-triangle text-warning fa-2x"></i>
                        </div>
                        <p>The following fields are required:</p>
                        <ul class="text-start">
                            ${emptyFields.map(f => `<li><strong>${f.label}</strong></li>`).join('')}
                        </ul>
                        <p class="text-muted small mt-2">Please fill in all required fields before submitting</p>
                    </div>`,
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fd7e14',
                width: 500
            });
            return;
        }
        
        // Validate dates
        if (m_date_of_instrument && m_date_of_registration) {
            const instrumentDate = new Date(m_date_of_instrument);
            const registrationDate = new Date(m_date_of_registration);
            
            if (registrationDate < instrumentDate) {
                Swal.fire({
                    title: 'Date Validation Error',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="fas fa-calendar-times text-danger fa-2x"></i>
                            </div>
                            <p><strong>Date of Registration</strong> cannot be earlier than <strong>Date of Instrument</strong></p>
                            <p class="text-muted small">Please check the dates and try again</p>
                        </div>`,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
                return;
            }
        }
        
        // Prepare confirmation message based on action (add/edit)
        const isEdit = mid > 0;
        const actionText = isEdit ? 'Update' : 'Add';
        
        // Show confirmation dialog
        Swal.fire({
            title: `${actionText} Memorial Record?`,
            html: `<div class="text-start">
                    <div class="mb-3">
                        <i class="fas fa-file-alt text-danger fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Confirm ${actionText}</h5>
                    <div class="alert alert-info bg-info bg-opacity-10 border-info">
                        <div class="d-flex">
                            <i class="fas fa-info-circle me-2 mt-1"></i>
                            <div>
                                <strong>Record Details:</strong>
                                <ul class="mb-0 ps-3">
                                    <li><strong>Case:</strong> ${m_case_number}</li>
                                    <li><strong>Registered No:</strong> ${m_registered_no}</li>
                                    <li><strong>Memorials:</strong> ${m_memorials.substring(0, 50)}${m_memorials.length > 50 ? '...' : ''}</li>
                                    <li><strong>Entry No:</strong> ${m_entry_number}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <p class="text-muted small mt-3">
                        This action will ${isEdit ? 'update the existing' : 'create a new'} 
                        memorial record in the system.
                    </p>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: `<i class="fas fa-save me-1"></i>${actionText} Record`,
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            width: 550,
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                const submitBtn = $(this).find('button[type="submit"]');
                const originalText = submitBtn.html();
                submitBtn.prop('disabled', true);
                submitBtn.html('<span class="spinner-border spinner-border-sm me-1" role="status"></span>Processing...');
                
                // Make AJAX call
                $.ajax({
                    type: "POST",
                    url: "lrd_memorials_section_serv",
                    data: {
                        request_type: "select_lrd_memorials_section_add_and_update",
                        mid: mid,
                        m_case_number: m_case_number,
                        m_registered_no: m_registered_no,
                        m_memorials: m_memorials,
                        m_date_of_registration: m_date_of_registration,
                        m_date_of_instrument: m_date_of_instrument,
                        m_back: '-',
                        m_forward: '-',
                        m_remarks: m_remarks,
                        m_entry_number: m_entry_number
                    },
                    cache: false,
                    beforeSend: function() {
                        // Additional loading indicators can be added here
                    },
                    success: function(jobdetails) {
                        // console.log('Server response:', jobdetails);
                        
                        try {
                            const json_p = JSON.parse(jobdetails);
                            
                            // Close the modal
                            const modal = bootstrap.Modal.getInstance(document.getElementById('newMemorialsModal'));
                            if (modal) {
                                modal.hide();
                            }
                            
                            // Show success message
                            Swal.fire({
                                title: 'Success!',
                                html: `<div class="text-center">
                                        <div class="mb-3">
                                            <i class="fas fa-check-circle text-success fa-3x"></i>
                                        </div>
                                        <h5 class="mb-2">Record ${isEdit ? 'Updated' : 'Added'}</h5>
                                        <p class="text-muted">
                                            Memorial details have been ${isEdit ? 'updated' : 'added'} successfully
                                        </p>
                                        <div class="alert alert-success bg-success bg-opacity-10 border-success mt-3">
                                            <i class="fas fa-check me-2"></i>
                                            <strong>Details:</strong> ${m_registered_no} (${m_entry_number})
                                        </div>
                                    </div>`,
                                icon: 'success',
                                confirmButtonText: 'Continue',
                                confirmButtonColor: '#198754',
                                timer: 3000,
                                timerProgressBar: true
                            });
                            
                            // Update the table with new data
                            updateMemorialsTable(json_p.data);
                            
                        } catch (error) {
                            console.error('JSON parsing error:', error);
                            
                            // Show error message for parsing failure
                            Swal.fire({
                                title: 'Processing Error',
                                text: 'Failed to process server response',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#dc3545'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX error:', error);
                        
                        // Show error message
                        Swal.fire({
                            title: 'Save Failed',
                            html: `<div class="text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-exclamation-circle text-danger fa-3x"></i>
                                    </div>
                                    <h5 class="mb-2">Unable to Save Record</h5>
                                    <p class="text-danger small">${error || 'Server error occurred'}</p>
                                    <div class="alert alert-warning mt-3">
                                        <i class="fas fa-lightbulb me-2"></i>
                                        Please try again or contact system administrator
                                    </div>
                                </div>`,
                            icon: 'error',
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    },
                    complete: function() {
                        // Reset button state
                        submitBtn.prop('disabled', false);
                        submitBtn.html(originalText);
                    }
                });
            }
        });
    });

    // Function to update the memorials table with the new format
    function updateMemorialsTable(data) {
        const table_bp = $('#lrd_memorial_details_dataTable, #lrd_memorial_details_dataTable_2');
        table_bp.find("tbody tr").remove();
        
        if (data && data.length > 0) {
            $(data).each(function() {
                table_bp.append(`<tr>
                    <td>
                        <span class="badge bg-danger bg-opacity-10 text-danger">
                            ${this.m_registered_no}
                        </span>
                    </td>
                    <td>
                        <div class="text-truncate" style="max-width: 200px;">
                            ${this.m_memorials}
                        </div>
                    </td>
                    <td>${this.m_date_of_instrument}</td>
                    <td>${this.m_date_of_registration}</td>
                    <td>
                        <span class="badge bg-secondary">${this.m_entry_number}</span>
                    </td>
                    <td class="text-center">
                        <button class="btn btn-outline-danger btn-sm editMemorialsModal"
                                data-target-id="${this.mid}"
                                data-mid="${this.mid}"
                                data-m_case_number="${this.m_case_number}"
                                data-m_registered_no="${this.m_registered_no}"
                                data-m_memorials="${this.m_memorials}"
                                data-m_date_of_registration="${this.m_date_of_registration}"
                                data-m_date_of_instrument="${this.m_date_of_instrument}"
                                data-m_back="${this.m_back}"
                                data-m_remarks="${this.m_remarks}"
                                data-m_entry_number="${this.m_entry_number}"
                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Memorial">
                            <i class="fas fa-edit"></i>
                        </button>
                    </td>
                </tr>`);
            });
            
            // Initialize tooltips for new buttons
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.forEach(function (tooltipTriggerEl) {
                new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
        } else {
            // Show empty state
            table_bp.append(`<tr>
                <td colspan="6" class="text-center py-4">
                    <div class="text-muted">
                        <i class="fas fa-file-alt fa-2x mb-2 d-block"></i>
                        <p class="mb-0">No memorial records found</p>
                        <small>Click "Add Memorial" to create a new record</small>
                    </div>
                </td>
            </tr>`);
        }
    }

    // Also update your editMemorialsModal function to match the new button class
    $(document).on('click', '.editMemorialsModal', function(e) {
        $("#newMemorialsModal").modal('show');

        const mid = $(this).data('mid');
        const m_registered_no = $(this).data('m_registered_no');
        const m_memorials = $(this).data('m_memorials');
        const m_date_of_instrument = $(this).data('m_date_of_instrument');
        const m_date_of_registration = $(this).data('m_date_of_registration');
        const m_remarks = $(this).data('m_remarks');
        const m_entry_number = $(this).data('m_entry_number');

        $("#mid").val(mid);
        $("#m_registered_no").val(m_registered_no);
        $("#m_memorials").val(m_memorials);
        $("#m_date_of_instrument").val(m_date_of_instrument);
        $("#m_date_of_registration").val(m_date_of_registration);
        $("#m_remarks").val(m_remarks);
        $("#m_entry_number").val(m_entry_number);

        // Load documents for memorial modal
        const docsContainer = document.querySelector('#newMemorialsModal ._gated_workflow_documents');
        if (docsContainer) {
            window.loadGatedWorkFlowDocuments('memorial');
        }
    });

    $(document).on('click', '.newReservationModal', function(e) {
        $("#newReservationModal").modal('show');
    })

    $('#form_add_reservation').on('submit', function(e) {
        e.preventDefault();
        
        // Collect form data
        const rs_id = parseInt($("#rs_id").val());
        const rs_case_number = $("#rs_case_number").val();
        const rs_reservation_description = $("#rs_reservation_description").val();
        
        // Validate required fields
        if (!rs_reservation_description.trim()) {
            Swal.fire({
                title: 'Required Field Missing',
                html: `<div class="text-start">
                        <div class="mb-3">
                            <i class="fas fa-exclamation-triangle text-warning fa-2x"></i>
                        </div>
                        <p><strong>Reservation Description</strong> is required</p>
                        <p class="text-muted small mt-2">Please enter a detailed reservation description before submitting</p>
                    </div>`,
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fd7e14'
            });
            return;
        }
        
        // Prepare confirmation message based on action (add/edit)
        const isEdit = rs_id > 0;
        const actionText = isEdit ? 'Update' : 'Add';
        
        // Show confirmation dialog
        Swal.fire({
            title: `${actionText} Reservation Record?`,
            html: `<div class="text-start">
                    <div class="mb-3">
                        <i class="fas fa-calendar-check text-primary fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Confirm ${actionText}</h5>
                    <div class="alert alert-info bg-info bg-opacity-10 border-info">
                        <div class="d-flex">
                            <i class="fas fa-info-circle me-2 mt-1"></i>
                            <div>
                                <strong>Record Details:</strong>
                                <ul class="mb-0 ps-3">
                                    <li><strong>Case:</strong> ${rs_case_number}</li>
                                    <li><strong>Description:</strong> ${rs_reservation_description.substring(0, 100)}${rs_reservation_description.length > 100 ? '...' : ''}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <p class="text-muted small mt-3">
                        This action will ${isEdit ? 'update the existing' : 'create a new'} 
                        reservation record in the system.
                    </p>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: `<i class="fas fa-save me-1"></i>${actionText} Record`,
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            width: 550,
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                const submitBtn = $('#btn_reservation_section');
                const originalText = submitBtn.html();
                submitBtn.prop('disabled', true);
                submitBtn.html('<span class="spinner-border spinner-border-sm me-1" role="status"></span>Processing...');
                
                // Make AJAX call
                $.ajax({
                    type: "POST",
                    url: "lrd_reservation_section_serv",
                    data: {
                        request_type: "select_lrd_reservation_section_add_and_update",
                        rs_id: rs_id,
                        rs_case_number: rs_case_number,
                        rs_reservation_description: rs_reservation_description
                    },
                    cache: false,
                    beforeSend: function() {
                        // Additional loading indicators can be added here
                    },
                    success: function(jobdetails) {
                        // console.log('Server response:', jobdetails);
                        
                        try {
                            const json_p = JSON.parse(jobdetails);
                            
                            // Close the modal
                            const modal = bootstrap.Modal.getInstance(document.getElementById('newReservationModal'));
                            if (modal) {
                                modal.hide();
                            }
                            
                            // Show success message
                            Swal.fire({
                                title: 'Success!',
                                html: `<div class="text-center">
                                        <div class="mb-3">
                                            <i class="fas fa-check-circle text-success fa-3x"></i>
                                        </div>
                                        <h5 class="mb-2">Record ${isEdit ? 'Updated' : 'Added'}</h5>
                                        <p class="text-muted">
                                            Reservation details have been ${isEdit ? 'updated' : 'added'} successfully
                                        </p>
                                        <div class="alert alert-success bg-success bg-opacity-10 border-success mt-3">
                                            <i class="fas fa-check me-2"></i>
                                            <strong>Case:</strong> ${rs_case_number}
                                        </div>
                                    </div>`,
                                icon: 'success',
                                confirmButtonText: 'Continue',
                                confirmButtonColor: '#198754',
                                timer: 3000,
                                timerProgressBar: true
                            });
                            
                            // Update the table with new data
                            updateReservationTable(json_p.data);
                            
                        } catch (error) {
                            console.error('JSON parsing error:', error);
                            
                            // Show error message for parsing failure
                            Swal.fire({
                                title: 'Processing Error',
                                text: 'Failed to process server response',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#dc3545'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX error:', error);
                        
                        // Show error message
                        Swal.fire({
                            title: 'Save Failed',
                            html: `<div class="text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-exclamation-circle text-danger fa-3x"></i>
                                    </div>
                                    <h5 class="mb-2">Unable to Save Record</h5>
                                    <p class="text-danger small">${error || 'Server error occurred'}</p>
                                    <div class="alert alert-warning mt-3">
                                        <i class="fas fa-lightbulb me-2"></i>
                                        Please try again or contact system administrator
                                    </div>
                                </div>`,
                            icon: 'error',
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    },
                    complete: function() {
                        // Reset button state
                        submitBtn.prop('disabled', false);
                        submitBtn.html(originalText);
                    }
                });
            }
        });
    });

    // Function to update the reservation table with the new format
    function updateReservationTable(data) {
        const table_bp = $('#lrd_reservation_details_dataTable');
        table_bp.find("tbody tr").remove();
        
        if (data && data.length > 0) {
            $(data).each(function() {
                table_bp.append(`<tr>
                    <td>
                        <div class="text-truncate" style="max-width: 250px;">
                            ${this.reservation_description}
                        </div>
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user-circle text-muted me-2"></i>
                            <span>${this.modified_by}</span>
                        </div>
                    </td>
                    <td>${this.created_date}</td>
                    <td class="text-center">
                        <button class="btn btn-outline-success btn-sm editReservationModal"
                                data-rs_id="${this.rs_id}"
                                data-rs_reservation_description="${this.reservation_description}"
                                data-rs_case_number="${this.case_number}"
                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Reservation">
                            <i class="fas fa-edit"></i>
                        </button>
                    </td>
                </tr>`);
            });
            
            // Initialize tooltips for new buttons
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.forEach(function (tooltipTriggerEl) {
                new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
        } else {
            // Show empty state
            table_bp.append(`<tr>
                <td colspan="4" class="text-center py-4">
                    <div class="text-muted">
                        <i class="fas fa-calendar-check fa-2x mb-2 d-block"></i>
                        <p class="mb-0">No reservation records found</p>
                        <small>Click "Add Reservation" to create a new record</small>
                    </div>
                </td>
            </tr>`);
        }
    }

    // Update the editReservationModal handler
    $(document).on('click', '.editReservationModal', function(e) {
        $("#newReservationModal").modal('show');
        
        const rs_id = $(this).data('rs_id');
        const rs_reservation_description = $(this).data('rs_reservation_description');
        const rs_case_number = $(this).data('rs_case_number');
        
        $("#rs_id").val(rs_id);
        $("#rs_reservation_description").val(rs_reservation_description);
        // $("#rs_case_number").val(rs_case_number); // This should already be set from page load
        
        // Optional: Scroll to top of modal
        $('#newReservationModal .modal-body').scrollTop(0);
    });

    $(document).on('click', '.newEncumberancesModal', function(e) {
        $("#newEncumberancesModal").modal('show');

        window.loadGatedWorkFlowDocuments('encumbrance');
    })

    $('#form_add_encumbrances').on('submit', function(e) {
        e.preventDefault();
        console.log('Form submitted');
        
        // Collect form data
        const es_id = parseInt($("#es_id").val()) || 0;
        const es_case_number = $("#es_case_number").val();
        const es_registered_number = $("#es_registered_number").val();
        const es_date_of_registration = $("#es_date_of_registration").val();
        const es_date_of_instrument = $("#es_date_of_instrument").val();
        const es_memorials = $("#es_memorials").val();
        const es_remarks = $("#es_remarks").val();
        const es_back = $("#es_back").val();
        const es_forward = $("#es_forward").val();
        const es_signature = $("#es_signature").val();
        const es_entry_number = $("#es_entry_number").val();
        
        // Validate required fields
        const requiredFields = [
            { field: 'es_registered_number', value: es_registered_number, label: 'Registered Number' },
            { field: 'es_date_of_instrument', value: es_date_of_instrument, label: 'Date of Instrument' },
            { field: 'es_date_of_registration', value: es_date_of_registration, label: 'Date of Registration' },
            { field: 'es_memorials', value: es_memorials, label: 'Memorials' },
            { field: 'es_entry_number', value: es_entry_number, label: 'Entry Number' }
        ];
        
        // Check for empty required fields
        const emptyFields = requiredFields.filter(field => !field.value.trim());
        if (emptyFields.length > 0) {
            Swal.fire({
                title: 'Required Fields Missing',
                html: `<div class="text-start">
                        <div class="mb-3">
                            <i class="fas fa-exclamation-triangle text-warning fa-2x"></i>
                        </div>
                        <p>The following fields are required:</p>
                        <ul class="text-start">
                            ${emptyFields.map(f => `<li><strong>${f.label}</strong></li>`).join('')}
                        </ul>
                        <p class="text-muted small mt-2">Please fill in all required fields before submitting</p>
                    </div>`,
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#fd7e14'
            });
            return;
        }
        
        // Validate dates
        if (es_date_of_instrument && es_date_of_registration) {
            const instrumentDate = new Date(es_date_of_instrument);
            const registrationDate = new Date(es_date_of_registration);
            
            if (registrationDate < instrumentDate) {
                Swal.fire({
                    title: 'Date Validation Error',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="fas fa-calendar-times text-danger fa-2x"></i>
                            </div>
                            <p><strong>Date of Registration</strong> cannot be earlier than <strong>Date of Instrument</strong></p>
                            <p class="text-muted small">Please check the dates and try again</p>
                        </div>`,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
                return;
            }
        }
        
        // Prepare confirmation message based on action (add/edit)
        const isEdit = es_id > 0;
        const actionText = isEdit ? 'Update' : 'Add';
        
        // Show confirmation dialog
        Swal.fire({
            title: `${actionText} Encumbrance Record?`,
            html: `<div class="text-start">
                    <div class="mb-3">
                        <i class="fas fa-file-contract text-warning fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Confirm ${actionText}</h5>
                    <div class="alert alert-info bg-info bg-opacity-10 border-info">
                        <div class="d-flex">
                            <i class="fas fa-info-circle me-2 mt-1"></i>
                            <div>
                                <strong>Record Details:</strong>
                                <ul class="mb-0 ps-3">
                                    <li><strong>Case:</strong> ${es_case_number}</li>
                                    <li><strong>Registered No:</strong> ${es_registered_number}</li>
                                    <li><strong>Entry No:</strong> ${es_entry_number}</li>
                                    <li><strong>Memorials:</strong> ${es_memorials.substring(0, 50)}${es_memorials.length > 50 ? '...' : ''}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <p class="text-muted small mt-3">
                        This action will ${isEdit ? 'update the existing' : 'create a new'} 
                        encumbrance record in the system.
                    </p>
                </div>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: `<i class="fas fa-save me-1"></i>${actionText} Record`,
            cancelButtonText: '<i class="fas fa-times me-1"></i>Cancel',
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            width: 550,
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                const submitBtn = $(this).find('button[type="submit"]');
                const originalText = submitBtn.html();
                submitBtn.prop('disabled', true);
                submitBtn.html('<span class="spinner-border spinner-border-sm me-1" role="status"></span>Processing...');
                
                // Make AJAX call
                $.ajax({
                    type: "POST",
                    url: "lrd_encumbrances_section_serv",
                    data: {
                        request_type: "select_lrd_encumbrances_section_add_and_update",
                        es_id: es_id,
                        es_registered_number: es_registered_number,
                        es_case_number: es_case_number,
                        es_date_of_registration: es_date_of_registration,
                        es_date_of_instrument: es_date_of_instrument,
                        es_memorials: es_memorials,
                        es_back: es_back,
                        es_forward: es_forward,
                        es_remarks: es_remarks,
                        es_signature: es_signature,
                        es_entry_number: es_entry_number
                    },
                    cache: false,
                    beforeSend: function() {
                        // Additional loading indicators can be added here
                    },
                    success: function(jobdetails) {
                        console.log('Server response:', jobdetails);
                        
                        try {
                            const json_p = JSON.parse(jobdetails);
                            
                            // Close the modal
                            const modal = bootstrap.Modal.getInstance(document.getElementById('newEncumberancesModal'));
                            if (modal) {
                                modal.hide();
                            }
                            
                            // Show success message
                            Swal.fire({
                                title: 'Success!',
                                html: `<div class="text-center">
                                        <div class="mb-3">
                                            <i class="fas fa-check-circle text-success fa-3x"></i>
                                        </div>
                                        <h5 class="mb-2">Record ${isEdit ? 'Updated' : 'Added'}</h5>
                                        <p class="text-muted">
                                            Encumbrance details have been ${isEdit ? 'updated' : 'added'} successfully
                                        </p>
                                        <div class="alert alert-success bg-success bg-opacity-10 border-success mt-3">
                                            <i class="fas fa-check me-2"></i>
                                            <strong>Details:</strong> ${es_registered_number} (${es_entry_number})
                                        </div>
                                    </div>`,
                                icon: 'success',
                                confirmButtonText: 'Continue',
                                confirmButtonColor: '#198754',
                                timer: 3000,
                                timerProgressBar: true
                            });
                            
                            // Update the table with new data
                            updateEncumbrancesTable(json_p.data);
                            
                        } catch (error) {
                            console.error('JSON parsing error:', error);
                            
                            // Show error message for parsing failure
                            Swal.fire({
                                title: 'Processing Error',
                                text: 'Failed to process server response',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#dc3545'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX error:', error);
                        
                        // Show error message
                        Swal.fire({
                            title: 'Save Failed',
                            html: `<div class="text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-exclamation-circle text-danger fa-3x"></i>
                                    </div>
                                    <h5 class="mb-2">Unable to Save Record</h5>
                                    <p class="text-danger small">${error || 'Server error occurred'}</p>
                                    <div class="alert alert-warning mt-3">
                                        <i class="fas fa-lightbulb me-2"></i>
                                        Please try again or contact system administrator
                                    </div>
                                </div>`,
                            icon: 'error',
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    },
                    complete: function() {
                        // Reset button state
                        submitBtn.prop('disabled', false);
                        submitBtn.html(originalText);
                    }
                });
            }
        });
    });

    // Function to update the encumbrances table with the new format
    function updateEncumbrancesTable(data) {
        const table_bp = $('#lrd_registration_encumbrance_dataTable');
        table_bp.find("tbody tr").remove();
        
        if (data && data.length > 0) {
            $(data).each(function() {
                table_bp.append(`<tr>
                    <td>
                        <span class="badge bg-warning bg-opacity-10 text-warning">
                            ${this.es_registered_number}
                        </span>
                    </td>
                    <td>${this.es_date_of_instrument}</td>
                    <td>${this.es_date_of_registration}</td>
                    <td>
                        <div class="text-truncate" style="max-width: 200px;">
                            ${this.es_memorials}
                        </div>
                    </td>
                    <td>
                        <span class="badge bg-secondary">${this.es_entry_number}</span>
                    </td>
                    <td class="text-center">
                        <button class="btn btn-outline-warning btn-sm editEncumberancesModal"
                                data-es_id="${this.es_id}"
                                data-es_case_number="${this.es_case_number}"
                                data-es_registered_number="${this.es_registered_number}"
                                data-es_date_of_registration="${this.es_date_of_registration}"
                                data-es_date_of_instrument="${this.es_date_of_instrument}"
                                data-es_back="${this.es_back}"
                                data-es_forward="${this.es_forward}"
                                data-es_remarks="${this.es_remarks}"
                                data-es_memorials="${this.es_memorials}"
                                data-es_signature="${this.es_signature}"
                                data-es_entry_number="${this.es_entry_number}"
                                data-es_action_on_form_encumbrances="edit"
                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Encumbrance">
                            <i class="fas fa-edit"></i>
                        </button>
                    </td>
                </tr>`);
            });
            
            // Initialize tooltips for new buttons
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.forEach(function (tooltipTriggerEl) {
                new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
        } else {
            // Show empty state
            table_bp.append(`<tr>
                <td colspan="6" class="text-center py-4">
                    <div class="text-muted">
                        <i class="fas fa-file-contract fa-2x mb-2 d-block"></i>
                        <p class="mb-0">No encumbrance records found</p>
                        <small>Click "Add Encumbrance" to create a new record</small>
                    </div>
                </td>
            </tr>`);
        }
    }

    // Update the editEncumberancesModal handler
    $(document).on('click', '.editEncumberancesModal', function(e) {
        $("#newEncumberancesModal").modal('show');
        
        const es_id = $(this).data('es_id');
        const es_registered_number = $(this).data('es_registered_number');
        const es_date_of_instrument = $(this).data('es_date_of_instrument');
        const es_date_of_registration = $(this).data('es_date_of_registration');
        const es_memorials = $(this).data('es_memorials');
        const es_remarks = $(this).data('es_remarks');
        const es_back = $(this).data('es_back');
        const es_forward = $(this).data('es_forward');
        const es_signature = $(this).data('es_signature');
        const es_entry_number = $(this).data('es_entry_number');
        
        $("#es_id").val(es_id);
        $("#es_registered_number").val(es_registered_number);
        $("#es_date_of_instrument").val(es_date_of_instrument);
        $("#es_date_of_registration").val(es_date_of_registration);
        $("#es_memorials").val(es_memorials);
        $("#es_remarks").val(es_remarks);
        $("#es_back").val(es_back);
        $("#es_forward").val(es_forward);
        $("#es_signature").val(es_signature);
        $("#es_entry_number").val(es_entry_number);
        
        // Optional: Scroll to top of modal
        $('#newEncumberancesModal .modal-body').scrollTop(0);

        window.loadGatedWorkFlowDocuments('encumbrance');
    });
    
        
});
