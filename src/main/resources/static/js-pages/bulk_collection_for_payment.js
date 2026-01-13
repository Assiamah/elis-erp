$(document).ready(function() {
    const SEARCH_MIN_LENGTH = 8;
    
    // Cache DOM elements for better performance
    const $searchForm = $('#frmEnquiryJobSearch');
    const $searchValue = $('#enq_search_value');
    const $resultsSection = $('#enq-search-results-section');
    const $resultsTable = $('#tbl-bulk-collection-table tbody');
    const $processBtn = $('#btn_process_bulk_collection');
    const $collectorName = $('#bcd_collected_by');
    const $idType = $('#bcd_id_type');
    const $idNumber = $('#bcd_id_number');
    const $phoneNumber = $('#bcd_phone_number');

    // SweetAlert notification helper
    async function showAlert(title, text, icon = 'error', confirmButtonText = 'OK') {
        return Swal.fire({
            title,
            text,
            icon,
            confirmButtonText,
            confirmButtonColor: '#3085d6',
            timer: icon === 'success' ? 3000 : undefined,
            timerProgressBar: icon === 'success',
            showClass: {
                popup: 'animate__animated animate__fadeInDown'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutUp'
            }
        });
    }

    // Confirmation dialog
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
            showClass: {
                popup: 'animate__animated animate__fadeInDown'
            },
            reverseButtons: true
        });
    }

    // Loading indicator
    function showLoading(title = 'Processing...') {
        Swal.fire({
            title,
            allowOutsideClick: false,
            showConfirmButton: false,
            willOpen: () => {
                Swal.showLoading();
            }
        });
    }

    // Helper function to validate required fields
    function validateFields(fields) {
        for (const [field, value] of Object.entries(fields)) {
            if (!value || value.trim() === '' || value === '-1') {
                return false;
            }
        }
        return true;
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

    // Extract table data
    function extractTableData() {
        const tableData = [];
        
        $('#tbl-bulk-collection-table tbody tr').each(function() {
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
        if (searchValue.length < SEARCH_MIN_LENGTH) {
            await showAlert(
                'Search Error',
                `Please enter ${SEARCH_MIN_LENGTH} or more characters to search`,
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

        //showLoading('Searching...');

        // Perform AJAX search
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
            const data = JSON.parse(response);
            let hasNewResults = false;
            let duplicatesCount = 0;

            data.forEach(item => {
                if (isDuplicateJobNumber(item.job_number)) {
                    duplicatesCount++;
                    return;
                }

                // Add row to table
                const rowHtml = `
                    <tr>
                        <td>${item.ar_name || ''}</td>
                        <td>${item.case_number || ''}</td>
                        <td>${item.job_number || ''}</td>
                        <td>${item.glpin || ''}</td>
                        <td>${item.locality || ''}</td>
                        <td>${item.regional_number || ''}</td>
                    </tr>
                `;
                
                $resultsTable.append(rowHtml);
                hasNewResults = true;
            });

            if (hasNewResults) {
                $resultsSection.show();
                let successMessage = `Successfully added ${data.length - duplicatesCount} record(s) to the batch.`;
                
                if (duplicatesCount > 0) {
                    successMessage += ` ${duplicatesCount} duplicate(s) were skipped.`;
                }
                
                await showAlert(
                    'Search Successful',
                    successMessage,
                    'success'
                );
            } else if (duplicatesCount > 0) {
                await showAlert(
                    'Duplicate Records',
                    `All ${duplicatesCount} record(s) found are already in the batch.`,
                    'info'
                );
            } else {
                await showAlert('No Results', 'No valid records found!', 'info');
            }
        } catch (error) {
            console.error('Error parsing response:', error);
            await showAlert('Processing Error', 'Error processing search results', 'error');
        }
    }

    // Handle batch processing with confirmation
    $processBtn.on('click', async function() {
        // Validate collector details
        const collectorDetails = {
            bcd_collected_by: $collectorName.val(),
            bcd_id_type: $idType.val(),
            bcd_id_number: $idNumber.val(),
            bcd_phone_number: $phoneNumber.val()
        };

        if (!validateFields(collectorDetails)) {
            await showAlert(
                'Missing Information',
                'Please fill up all the fields in Collector\'s Details',
                'warning'
            );
            return;
        }

        // Extract and validate table data
        const tableData = extractTableData();
        
        if (tableData.length === 0) {
            await showAlert('Empty Batch', 'No applications to process. Please search and add applications first.', 'warning');
            return;
        }

        // Show confirmation dialog with details
        const confirmationResult = await showConfirm(
            'Confirm Batch Processing',
            `You are about to process ${tableData.length} application(s) for collection.\n\n` +
            `Collector: ${collectorDetails.bcd_collected_by}\n` +
            `ID Type: ${collectorDetails.bcd_id_type}\n` +
            `ID Number: ${collectorDetails.bcd_id_number}\n\n` +
            'Are you sure you want to proceed?',
            'question'
        );

        if (!confirmationResult.isConfirmed) {
            await showAlert('Cancelled', 'Batch processing was cancelled.', 'info');
            return;
        }

        showLoading('Processing batch...');

        const listOfApplications = JSON.stringify(tableData);
        console.log('Processing batch:', listOfApplications);

        try {
            const response = await $.ajax({
                type: 'POST',
                url: 'Case_Management_Serv',
                data: {
                    request_type: 'process_batch_list_issue_for_payment_collection',
                    list_of_application: listOfApplications,
                    ...collectorDetails
                },
                cache: false
            });

            Swal.close();
            await handleBatchResponse(response, listOfApplications);
        } catch (error) {
            Swal.close();
            console.error('Batch processing error:', error);
            await showAlert(
                'Processing Failed',
                'An error occurred while processing the batch. Please try again.',
                'error'
            );
        }
    });

    // Handle batch processing response
    async function handleBatchResponse(response, listOfApplications) {
        try {
            const result = JSON.parse(response);
            const batchNumber = result.batch_number;
            
            if (!batchNumber) {
                throw new Error('Invalid batch response');
            }

            // Ask user if they want to generate PDF
            const pdfConfirmation = await showConfirm(
                'Batch Processed Successfully',
                `Batch #${batchNumber} has been processed successfully!\n\nWould you like to generate and download the batch list PDF?`,
                'success'
            );

            if (pdfConfirmation.isConfirmed) {
                await generatePdfReport(listOfApplications, batchNumber);
            } else {
                await showAlert(
                    'Batch Complete',
                    `Batch #${batchNumber} has been processed successfully.\nYou can generate the PDF later if needed.`,
                    'info'
                );
            }
            
        } catch (error) {
            console.error('Error processing batch response:', error);
            await showAlert('Processing Error', 'Error processing batch response', 'error');
        }
    }

    // Generate PDF report
    async function generatePdfReport(listOfApplications, batchNumber) {
        showLoading('Generating PDF...');

        try {
            const pdfData = await $.ajax({
                type: 'POST',
                url: 'GenerateCaseReports',
                data: {
                    request_type: 'request_to_generate_batch_list_bulk_correction',
                    list_of_application: listOfApplications,
                    batch_number: batchNumber,
                    modified_by: localStorage.getItem('fullname'),
                    modified_by_id: localStorage.getItem('userid')
                },
                cache: false,
                xhrFields: {
                    responseType: 'blob'
                }
            });

            Swal.close();
            await displayPdfPreview(pdfData, batchNumber);
        } catch (error) {
            Swal.close();
            console.error('PDF generation error:', error);
            await showAlert('PDF Generation Failed', 'Error generating PDF report', 'error');
        }
    }

    // Display PDF preview in new tab
    async function displayPdfPreview(pdfData, batchNumber) {
        const blob = new Blob([pdfData], { type: 'application/pdf' });
        const objectUrl = URL.createObjectURL(blob);
        
        // Open PDF in new tab
        const newWindow = window.open(objectUrl, '_blank');
        
        if (newWindow) {
            await showAlert(
                'PDF Generated',
                `Batch list PDF for Batch #${batchNumber} has been opened in a new tab.`,
                'success'
            );
        } else {
            // If popup blocked, show download option
            const downloadResult = await showConfirm(
                'PDF Ready',
                `Batch list PDF for Batch #${batchNumber} is ready.\n\nPop-up was blocked. Would you like to download it instead?`,
                'warning'
            );

            if (downloadResult.isConfirmed) {
                const downloadLink = document.createElement('a');
                downloadLink.href = objectUrl;
                downloadLink.download = `batch-${batchNumber}-list.pdf`;
                document.body.appendChild(downloadLink);
                downloadLink.click();
                document.body.removeChild(downloadLink);
                
                await showAlert(
                    'Download Started',
                    `PDF for Batch #${batchNumber} is downloading.`,
                    'success'
                );
            }
        }

        // Clean up object URL after some time
        setTimeout(() => {
            URL.revokeObjectURL(objectUrl);
        }, 10000);
    }
});