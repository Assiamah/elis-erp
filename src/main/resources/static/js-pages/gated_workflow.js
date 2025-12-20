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

    // Copy WKT to clipboard
    window.copyWktToClipboard = function () {
    const wktTextarea = document.getElementById('lc_bl_wkt_polygon');
    if (wktTextarea && wktTextarea.value) {
        navigator.clipboard.writeText(wktTextarea.value).then(() => {
        // Show success toast
        const toast = new bootstrap.Toast(document.createElement('div'));
        // Add toast implementation here
        });
    }
    }

    // Update coordinate statistics
    function updateCoordinateStats() {
        const table = document.getElementById('coordinatelis_Table');
        const rows = table.querySelectorAll('tbody tr:not(#noCoordinatesRow)');
        const total = rows.length;
        
        document.getElementById('totalCoordinates').textContent = total;
        document.getElementById('coordinateSummary').textContent = 
            total > 0 ? `${total} coordinate${total !== 1 ? 's' : ''} added` : 'No coordinates added';
        
        // Show/hide empty state
        const emptyRow = document.getElementById('noCoordinatesRow');
        if (emptyRow) {
            emptyRow.style.display = total > 0 ? 'none' : 'table-row';
    }
    }

    // Initialize when modal is shown
    document.getElementById('upload_coordinate').addEventListener('shown.bs.modal', function() {
        updateCoordinateStats();
    
        // Initialize tooltips
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
});
