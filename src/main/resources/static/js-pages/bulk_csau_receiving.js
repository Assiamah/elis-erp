$(document).ready(function() {
    const MIN_SEARCH_LENGTH = 8;
    
    // Cache DOM elements
    const $searchForm = $('#frmEnquiryJobSearch');
    const $searchValue = $('#enq_search_value');
    const $resultsSection = $('#enq-search-results-section');
    const $resultsTable = $('#tbl-bulk-receiving-table');
    const $processBtn = $('#btnBatchBulkReceiving');
    const $depositorName = $('#bcd_depositor_by');
    const $idType = $('#bcd_depositor_id_type');
    const $idNumber = $('#bcd_depositor_id_number');
    const $phoneNumber = $('#bcd_depositor_phone_number');
    const $email = $('#bcd_depositor_email');
    const $submissionType = $('#bcd_submission_type');

    // Modal event handlers
    $('#publicFileUploadModal').on('show.bs.modal', function(event) {
        const caseNumber = $(event.relatedTarget).data('br_case_number');
        $(this).find('#public_file_upload_case_number').val(caseNumber);
    });

    $('#publicViewFileModal').on('show.bs.modal', function(event) {
        const caseNumber = $(event.relatedTarget).data('br_case_number');
        $(this).find('#cs_main_case_number').val(caseNumber);
		const arName = $(event.relatedTarget).data('br_ar_name');
		$(this).find('#cs_main_applicant_name').val(arName);
    });

    // SweetAlert helper functions
    async function showAlert(title, text, icon = 'error', confirmText = 'OK') {
        return Swal.fire({
            title,
            text,
            icon,
            confirmButtonText: confirmText,
            confirmButtonColor: '#3085d6',
            timer: icon === 'success' ? 3000 : undefined,
            timerProgressBar: icon === 'success',
            showClass: { popup: 'animate__animated animate__fadeInDown' },
            hideClass: { popup: 'animate__animated animate__fadeOutUp' }
        });
    }

    async function showConfirm(title, text, icon = 'question') {
        return Swal.fire({
            title,
            text,
            icon,
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, proceed',
            cancelButtonText: 'Cancel',
            showClass: { popup: 'animate__animated animate__fadeInDown' },
            reverseButtons: true
        });
    }

    function showLoading(title = 'Processing...') {
        Swal.fire({
            title,
            allowOutsideClick: false,
            showConfirmButton: false,
            willOpen: () => Swal.showLoading()
        });
    }

    // Validate required fields
    function validateRequiredFields(fields) {
        const missingFields = [];
        
        fields.forEach(field => {
            const value = field.element.val()?.trim();
            if (!value || value === '' || value === '-1') {
                missingFields.push(field.name);
            }
        });
        
        return missingFields;
    }

    // Extract table data
    function extractTableData() {
        const tableData = [];
        
        $('#tbl-bulk-receiving-table tbody tr').each(function() {
            const $row = $(this);
            tableData.push({
                ar_name: $row.find('td:eq(0)').text().trim(),
                job_number: $row.find('td:eq(2)').text().trim()
            });
        });
        
        return tableData;
    }

    // Handle search form submission
    $searchForm.on('submit', async function(e) {
        e.preventDefault();
        
        const selectedRadio = $("input[name='rbtn_search_type']:checked");
        const searchType = selectedRadio.val() || '';
        const searchValue = $searchValue.val().trim();

        // Validate input
        if (searchValue.length < MIN_SEARCH_LENGTH) {
            await showAlert(
                'Search Error',
                `Please enter ${MIN_SEARCH_LENGTH} or more characters to search`,
                'warning'
            );
            return;
        }
        
        if (!searchType) {
            await showAlert(
                'Search Type Required',
                'Please select the type of field for your search',
                'warning'
            );
            return;
        }

       // showLoading('Searching...');

        try {
            const response = await $.ajax({
                type: 'POST',
                url: 'Case_Management_Serv',
                data: {
                    request_type: 'load_application_details_for_enquiries',
                    job_number: searchValue,
                    search_type: searchType
                },
                cache: false
            });

            Swal.close();
            await handleSearchResponse(response);
        } catch (error) {
            Swal.close();
            console.error('Search error:', error);
            await showAlert(
                'Search Failed',
                'An error occurred while searching. Please try again.',
                'error'
            );
        }
    });

    // Handle search response
    // async function handleSearchResponse(response) {
    //     if (!response || response.trim() === '') {
    //         await showAlert('No Results', 'No records found!', 'info');
    //         return;
    //     }

    //     if (response.includes('no search type')) {
    //         await showAlert(
    //             'Invalid Reference',
    //             'Reference Number has not been acknowledged or does not exist',
    //             'warning'
    //         );
    //         return;
    //     }

    //     try {
    //         $resultsSection.show();
    //         $resultsTable.find('tbody').empty();
            
    //         const jsonData = JSON.parse(response);
    //         const resultsCount = jsonData.length;

    //         jsonData.forEach(item => {
    //             const rowHtml = `
    //                 <tr>
    //                     <td>${item.ar_name || ''}</td>
    //                     <td>${item.case_number || ''}</td>
    //                     <td>${item.job_number || ''}</td>
    //                     <td>${item.business_process_sub_name || ''}</td>
    //                     <td>${item.glpin || ''}</td>
    //                     <td>${item.locality || ''}</td>
    //                     <td>${item.regional_number || ''}</td>
    //                     <td>
    //                         <div class="btn-group" role="group">
    //                             <button class="btn btn-primary btn-sm" 
    //                                     data-bs-toggle="modal" 
    //                                     data-bs-target="#publicFileUploadModal" 
    //                                     data-br_case_number="${item.case_number}">
    //                                 <i class="fas fa-upload"></i> Upload
    //                             </button>
    //                             <button class="btn btn-warning btn-sm" 
    //                                     data-bs-toggle="modal" 
    //                                     data-bs-target="#publicViewFileModal" 
    //                                     data-br_ar_name="${item.ar_name}"
    //                                     data-br_case_number="${item.case_number}">
    //                                 <i class="fas fa-eye"></i> View
    //                             </button>
    //                         </div>
    //                     </td>
    //                 </tr>
    //             `;
                
    //             $resultsTable.find('tbody').append(rowHtml);
    //         });

    //         await showAlert(
    //             'Search Complete',
    //             `Found ${resultsCount} record(s). Use the Upload/View buttons to manage files for each case.`,
    //             'success'
    //         );
    //     } catch (error) {
    //         console.error('Error parsing response:', error);
    //         await showAlert(
    //             'Processing Error',
    //             'Error processing search results. Please try again.',
    //             'error'
    //         );
    //     }
    // }

    async function handleSearchResponse(response) {
        if (!response || response.trim() === '') {
            await showAlert('No Results', 'No records found!', 'info');
            return;
        }

        if (response.includes('no search type')) {
            await showAlert(
                'Invalid Reference',
                'Reference Number has not been acknowledged or does not exist',
                'warning'
            );
            return;
        }

        try {
            const jsonData = JSON.parse(response);

            let addedCount = 0;
            let duplicatesCount = 0;

            jsonData.forEach(item => {
                if (isDuplicateJobNumber(item.job_number)) {
                    duplicatesCount++;
                    return;
                }

                const rowHtml = `
                    <tr>
                        <td>${item.ar_name || ''}</td>
                        <td>${item.case_number || ''}</td>
                        <td>${item.job_number || ''}</td>
                        <td>${item.business_process_sub_name || ''}</td>
                        <td>${item.glpin || ''}</td>
                        <td>${item.locality || ''}</td>
                        <td>${item.regional_number || ''}</td>
                        <td>
                            <div class="btn-group" role="group">
                                <button class="btn btn-primary btn-sm" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#publicFileUploadModal" 
                                        data-br_case_number="${item.case_number}">
                                    <i class="fas fa-upload"></i> Upload
                                </button>
                                <button class="btn btn-warning btn-sm" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#publicViewFileModal" 
                                        data-br_ar_name="${item.ar_name}"
                                        data-br_case_number="${item.case_number}">
                                    <i class="fas fa-eye"></i> View
                                </button>
                            </div>
                        </td>
                    </tr>
                `;

                $resultsTable.find('tbody').append(rowHtml);
                addedCount++;
            });

            if (addedCount > 0) {
                $resultsSection.show();

                let message = `Added ${addedCount} new record(s).`;

                if (duplicatesCount > 0) {
                    message += ` Skipped ${duplicatesCount} duplicate(s).`;
                }

                await showAlert('Search Complete', message, 'success');

            } else if (duplicatesCount > 0) {
                await showAlert(
                    'Duplicate Records',
                    `All ${duplicatesCount} record(s) already exist.`,
                    'info'
                );
            } else {
                await showAlert('No Results', 'No valid records found!', 'info');
            }

        } catch (error) {
            console.error('Error parsing response:', error);
            await showAlert(
                'Processing Error',
                'Error processing search results. Please try again.',
                'error'
            );
        }
    }


    // Helper function to check for duplicate job numbers
    function isDuplicateJobNumber(jobNumber) {
        let isDuplicate = false;
        $resultsTable.find('tr').each(function() {
            const existingJobNumber = $(this).find('td').eq(2).text().trim();
            if (existingJobNumber === jobNumber) {
                isDuplicate = true;
                return false; // Break loop
            }
        });
        return isDuplicate;
    }

    

    // Handle batch processing
    $processBtn.on('click', async function() {
        // Validate required fields
        const requiredFields = [
            { element: $depositorName, name: 'Depositor Name' },
            { element: $idType, name: 'ID Type' },
            { element: $idNumber, name: 'ID Number' },
            { element: $phoneNumber, name: 'Phone Number' },
            { element: $submissionType, name: 'Submission Type' }
        ];

        const missingFields = validateRequiredFields(requiredFields);
        
        if (missingFields.length > 0) {
            await showAlert(
                'Missing Information',
                `Please fill in the following required fields: ${missingFields.join(', ')}`,
                'warning'
            );
            return;
        }

        // Check if there are any results to process
        const rowCount = $resultsTable.find('tbody tr').length;
        if (rowCount === 0) {
            await showAlert(
                'No Results',
                'Please search and add applications to the table before processing.',
                'warning'
            );
            return;
        }

        // Show confirmation dialog with summary
        const confirmResult = await showConfirm(
            'Confirm Batch Processing',
            `You are about to process ${rowCount} application(s) with the following details:\n\n` +
            `Depositor: ${$depositorName.val()}\n` +
            `ID Type: ${$idType.val()}\n` +
            `ID Number: ${$idNumber.val()}\n` +
            `Phone: ${$phoneNumber.val()}\n` +
            `Email: ${$email.val() || 'Not provided'}\n` +
            `Submission Type: ${$submissionType.val()}\n\n` +
            'Are you sure you want to proceed?',
            'question'
        );

        if (!confirmResult.isConfirmed) {
            await showAlert('Cancelled', 'Batch processing was cancelled.', 'info');
            return;
        }

        showLoading('Processing applications...');

        try {
            // Process each row in the table
            const promises = [];
            $resultsTable.find('tbody tr').each(function(index, row) {
                const jobNumber = row.cells[2].textContent;
                const arName = row.cells[0].textContent;
                const businessProcessName = row.cells[3].textContent;
                const jobPurpose = $submissionType.val();
                
                promises.push(
                    addJobToBatchlist(jobNumber, arName, businessProcessName, jobPurpose, "")
                );
            });

            // Wait for all operations to complete
            await Promise.all(promises);
            
            Swal.close();
            
            // Prepare and show batch list modal
            await prepareBatchlistModal();
            
            await showAlert(
                'Batch Processed',
                `Successfully added ${rowCount} application(s) to the batch list.`,
                'success'
            );
        } catch (error) {
            Swal.close();
            console.error('Batch processing error:', error);
            await showAlert(
                'Processing Error',
                'An error occurred while processing the batch. Some applications may not have been added.',
                'error'
            );
        }
    });

    // Extract table data function (kept for backward compatibility)
    function storeTblValues() {
        return extractTableData();
    }

	$('#btn_load_scanned_documents_public_gated_workflow').on('click', function(e) { 
        loadDocuments();
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
});