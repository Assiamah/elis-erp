$(document).ready(function() {
    // Cache DOM elements
    const $enquiryForm = $('#frmEnquiryJobSearch');
    const $searchValue = $('#enq_search_value');
    const $searchTypeRadios = $("input[name='rbtn_search_type']");
    const $resultsSection = $("#enq-search-results-section");
    const $enquiryAlert = $('#enquiry_alert');
    const $resultsTable = $('#enq-search-results-table');
    const $batchlistForm = $('#frmEnquiryBatchlist');
    const $batchlistValue = $("#enq_batchlist");
    const $cabinetModal = $('#cabinetModal');
    const $filelistModal = $('#filelistModal');
    
    // Constants
    const MIN_SEARCH_LENGTH = 8;
    const MIN_BATCHLIST_LENGTH = 4;

    // ==================== MAIN SEARCH FUNCTIONALITY ====================
    $enquiryForm.on('submit', handleEnquirySearch);

    function handleEnquirySearch(e) {
        e.preventDefault();

        const searchType = getSelectedSearchType();
        const searchValue = $searchValue.val().trim();

        if (!validateSearchInput(searchType, searchValue)) {
            return;
        }

        $resultsSection.hide();
        $enquiryAlert.addClass('d-none');

        performEnquirySearch(searchType, searchValue);
    }

    function getSelectedSearchType() {
        const selectedRadio = $searchTypeRadios.filter(':checked');
        return selectedRadio.length > 0 ? selectedRadio.val() : '';
    }

    function validateSearchInput(searchType, searchValue) {
        if (searchValue.length < MIN_SEARCH_LENGTH) {
            showNotification(
                `Please enter ${MIN_SEARCH_LENGTH} or more characters to search`,
                'error'
            );
            return false;
        }

        if (!searchType) {
            showNotification(
                `Please select the type of field for your search`,
                'error'
            );
            return false;
        }

        return true;
    }

    function performEnquirySearch(searchType, searchValue) {
        showLoadingState($('#btnEnquiryJobSearch'), 'Searching...');

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_details_for_enquiries',
                job_number: searchValue,
                search_type: searchType
            },
            cache: false,
            success: function(response) {
                handleSearchResponse(response);
            },
            error: handleAjaxError,
            complete: function() {
                resetLoadingState($('#btnEnquiryJobSearch'), 'Search');
            }
        });
    }

    function handleSearchResponse(response) {
        if (!response) {
            showNoRecordsFound();
            return;
        }

        if (response.includes('no search type')) {
            alert('Reference Number has not been acknowledged or does not exist');
            return;
        }

        try {
            const data = JSON.parse(response);
            displaySearchResults(data);
            $resultsSection.show();
            $enquiryAlert.addClass('d-none');
        } catch (error) {
            console.error('Error parsing JSON:', error);
            showNotification(
                `Error processing search results`,
                'error'
            );
        }
    }

    function displaySearchResults(data) {
        clearTableRows($resultsTable);
        
        if (!Array.isArray(data) || data.length === 0) {
            showNoRecordsFound();
            return;
        }

        const tbody = $resultsTable.find('tbody');
        
        data.forEach(item => {
            const row = createSearchResultRow(item);
            tbody.append(row);
        });

		// Update results count
		const count = data.length;
		$('#resultsCount').text(`${count} application${count !== 1 ? 's' : ''} found`);
		$('#currentCount').text(count);
		$('#totalCount').text(count);
    }

    function createSearchResultRow(item) {
        return `
            <tr>
                <td class="small">${escapeHtml(item.ar_name || '')}</td>
                <td class="small">${escapeHtml(item.case_number || '')}</td>
                <td class="small">${escapeHtml(item.job_number || '')}</td>
                <td class="small">${escapeHtml(item.glpin || '')}</td>
                <td class="small">${escapeHtml(item.locality || '')}</td>
                <td class="small">${escapeHtml(item.regional_number || '')}</td>
                <td>
					<div class="dropdown text-end"> 
						<a aria-label="anchor" href="javascript:void(0);" class="btn btn-icon btn-sm btn-primary border" data-bs-toggle="dropdown" aria-expanded="false"> <i class="ri-more-2-line"></i> </a> 
						<ul class="dropdown-menu" style=""> 
							<li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#cabinetModal" data-target-id="${escapeHtml(item.job_number || '')}" href="javascript:void(0);"><i class="ri-hard-drive-2-line me-2"></i>Cabinet</a></li>
						</ul> 
					</div>
                </td>
            </tr>
        `;
    }

    function showNoRecordsFound() {
        showNotification(
            `No records found!`,
            'error'
        );
        $enquiryAlert.removeClass('d-none');
    }

    // ==================== CABINET MODAL FUNCTIONALITY ====================
    $cabinetModal.on('show.bs.modal', handleCabinetModalShow);

    function handleCabinetModalShow(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        
        if (!jobNumber) {
            console.error('No job number provided for cabinet modal');
            return;
        }

        resetCabinetModal();
        loadCabinetDetails(jobNumber);
    }

    function resetCabinetModal() {
        const fields = [
            '#enq_applicant_name',
            '#enq_applicant_type',
            '#enq_cabinet_name',
            '#enq_job_purpose',
            '#enq_job_status',
            '#enq_current_application_status'
        ];
        
        fields.forEach(selector => $(selector).val(''));
        clearTableRows($('#cabinet-tracking'));
    }

    function loadCabinetDetails(jobNumber) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_cabinet_details_by_job_number',
                job_number: jobNumber
            },
            cache: false,
            success: function(response) {
                populateCabinetData(response);
				updateRefreshTime();
            },
            error: handleAjaxError
        });
    }

    function populateCabinetData(response) {
        try {
            const data = JSON.parse(response);
            // console.log(data);
            // Populate cabinet tracking table
            if (data.cabinet_tracking && Array.isArray(data.cabinet_tracking)) {
                const table = $('#cabinet-tracking');
				table.empty();
                data.cabinet_tracking.forEach(tracking => {
                    table.append(createCabinetTrackingRow(tracking));
                });

				// Update last update date
				if (data.cabinet_tracking && data.cabinet_tracking.length > 0) {
					const lastUpdate = data.cabinet_tracking[data.cabinet_tracking.length - 1].created_date;
					$('#lastUpdateDate').text(lastUpdate);
				}

				const trackingCount = Array.isArray(data.cabinet_tracking) ? data.cabinet_tracking.length : 0;
				$('#trackingEntriesCount').text(trackingCount);
				$('#historyCount').text(trackingCount + ' entries');
            }

            // Populate cabinet data fields
            if (data.cabinet_data) {
                const cabinet = data.cabinet_data;
                $('#enq_applicant_name').val(cabinet.ar_name || '');
                $('#enq_applicant_type').val(cabinet.business_process_sub_name || '');
                $('#enq_cabinet_name').val(cabinet.file_number || '');
                $('#enq_job_purpose').val(cabinet.job_purpose || '');
                $('#enq_job_status').val(cabinet.job_status || '');
                $('#enq_current_application_status').val(cabinet.current_application_status || '');
            }
        } catch (error) {
            console.error('Error parsing cabinet data:', error);
        }
    }

    function createCabinetTrackingRow(tracking) {
        return `
            <tr>
                <td class="small">${escapeHtml(tracking.officers_general_comments || '')}</td>
                <td class="small">${escapeHtml(tracking.division || '')}</td>
                <td class="small">${escapeHtml(tracking.created_by || '')}</td>
                <td class="small">${formatDate(tracking.created_date)}</td>
            </tr>
        `;
    }

    // ==================== BATCHLIST FUNCTIONALITY ====================
    $batchlistForm.on('submit', handleBatchlistSearch);

    function handleBatchlistSearch(e) {
        e.preventDefault();
        
        const batchlistValue = $batchlistValue.val().trim();
        
        if (!validateBatchlistInput(batchlistValue)) {
            return;
        }

        loadBatchlistData(batchlistValue);
    }

    function validateBatchlistInput(value) {
        if (value.length < MIN_BATCHLIST_LENGTH) {
            showNotification(
                `Please enter ${MIN_BATCHLIST_LENGTH} or more characters to search`,
                'error'
            );
            return false;
        }
        return true;
    }

    function loadBatchlistData(batchlistValue) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_applications_by_batchlist',
                job_number: batchlistValue
            },
            cache: false,
            success: function(response) {
                handleBatchlistResponse(response, batchlistValue);
            },
            error: handleAjaxError
        });
    }

    function handleBatchlistResponse(response, batchlistValue) {
        try {
            const data = JSON.parse(response);
            displayBatchlistResults(data, batchlistValue);
        } catch (error) {
            console.error('Error parsing batchlist data:', error);
        }
    }

    function displayBatchlistResults(data, batchlistValue) {
        const table = $('#tbl_batchlist_history');
        clearTableRows(table);

        if (Array.isArray(data)) {
            data.forEach(item => {
                table.append(createBatchlistRow(item));
            });
        }

        $resultsSection.hide();
        $("#batchlist_value").empty().text(batchlistValue);
        $("#BachlistModal").modal("show");
    }

    function createBatchlistRow(item) {
        return `
            <tr>
                <td>${escapeHtml(item.ar_name || '')}</td>
                <td>${escapeHtml(item.job_number || '')}</td>
                <td>${escapeHtml(item.job_purpose || '')}</td>
                <td>${escapeHtml(item.sender_name || '')}</td>
                <td>${escapeHtml(item.receiver_name || '')}</td>
                <td>${formatDate(item.date_created)}</td>
            </tr>
        `;
    }

    // ==================== FILELIST MODAL FUNCTIONALITY ====================
    $filelistModal.on('show.bs.modal', handleFilelistModalShow);

    function handleFilelistModalShow(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        
        if (!validateBatchlistInput(jobNumber)) {
            return;
        }

        loadFileLocationData(jobNumber);
    }

    function loadFileLocationData(jobNumber) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_file_location',
                job_number: jobNumber
            },
            cache: false,
            success: function(response) {
                displayFileLocationData(response);
            },
            error: handleAjaxError
        });
    }

    function displayFileLocationData(response) {
        try {
            const data = JSON.parse(response);
            const table = $('#tbl_file_history');
            clearTableRows(table);

            if (Array.isArray(data)) {
                data.forEach(item => {
                    table.append(createFileLocationRow(item));
                });
            }
        } catch (error) {
            console.error('Error parsing file location data:', error);
        }
    }

    function createFileLocationRow(item) {
        return `
            <tr>
                <td>${escapeHtml(item.created_date || '')}</td>
                <td>${escapeHtml(item.division || '')}</td>
                <td>${escapeHtml(item.user_fullname || '')}</td>
                <td>${escapeHtml(item.created_by || '')}</td>
            </tr>
        `;
    }

    // ==================== UTILITY FUNCTIONS ====================
    function showNotification(message, type = 'danger') {
        // $.notify({
        //     message: message
        // }, {
        //     type: type,
        //     z_index: 9999,
        //     allow_dismiss: true,
        //     delay: 3000
        // });

		swal.fire({
			title: 'Error',
			text: message,
			icon: type,
			confirmButtonText: 'OK'
		})
    }

    function showLoadingState($button, loadingText) {
        const originalHtml = $button.html();
        $button.data('original-html', originalHtml);
        $button.html(`<span class="mdi mdi-loading me-2"></span>${loadingText}`);
        $button.prop('disabled', true);
    }

    function resetLoadingState($button, defaultText) {
        const originalHtml = $button.data('original-html');
        $button.html(originalHtml || defaultText);
        $button.prop('disabled', false);
    }

    function clearTableRows($table) {
        $table.find("tbody tr").remove();
    }

    function handleAjaxError(xhr, status, error) {
        console.error('AJAX Error:', error);
        showNotification(
            `Error loading data. Please try again.`,
            'error'
        );
    }

	function formatDate(dateString) {
		if (!dateString || dateString === 'Date not available') return dateString;
		
		try {
			const date = new Date(dateString);
			if (isNaN(date.getTime())) return dateString;
			
			return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { 
				hour: '2-digit', 
				minute: '2-digit' 
			});
		} catch (error) {
			return dateString;
		}
	}

	function updateRefreshTime() {
		const now = new Date();
		const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
		$('#lastRefreshTime').text(timeString);
	}

    function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
});