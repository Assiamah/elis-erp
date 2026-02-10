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
        //showLoadingState($('#btnEnquiryJobSearch'), 'Searching...');

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
                //resetLoadingState($('#btnEnquiryJobSearch'), 'Search');
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

				<td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(item.job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Cabinet
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>

							<!-- Collect for Payment -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#collectionForPayment"
								data-ar_name="${escapeHtml(item.ar_name || '')}"
								data-target-id="${escapeHtml(item.job_number || '')}">
									<i class="ri-money-dollar-circle-line me-2"></i>
									Collect for Payment
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>

							<!-- Track Physical File -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#filelistModal"
								data-target-id="${escapeHtml(item.job_number || '')}">
									<i class="ri-archive-line me-2"></i>
									Track Physical File
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="handleApplicationDetailsClick('${escapeHtml(item.job_number)}', '${escapeHtml(item.transaction_number)}', '${escapeHtml(item.case_number)}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>

							<!-- Collection -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#collectionModal"
								data-target-id="${escapeHtml(item.job_number || '')}">
									<i class="ri-hand-heart-line me-2"></i>
									Collection
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>

							<!-- Add Fees -->
							<!--<li>
								<a class="dropdown-item"
								href="javascript:void(0);">
									<i class="ri-money-dollar-box-line me-2"></i>
									Add Fees
								</a>
							</li>-->

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

	 window.handleApplicationDetailsClick = function(jobNumber, transactionNumber, caseNumber) {
		// Create form dynamically
		const form = document.createElement('form');
		form.method = 'POST';
		form.action = 'front_office_view_application';

		// Add hidden input fields
		const jobNumberInput = document.createElement('input');
		jobNumberInput.type = 'hidden';
		jobNumberInput.name = 'job_number';
		jobNumberInput.value = jobNumber;
		form.appendChild(jobNumberInput);

		const transactionNumberInput = document.createElement('input');
		transactionNumberInput.type = 'hidden';
		transactionNumberInput.name = 'case_number';
		transactionNumberInput.value = transactionNumber;
		form.appendChild(transactionNumberInput);

		const caseNumberInput = document.createElement('input');
		caseNumberInput.type = 'hidden';
		caseNumberInput.name = 'search_text';
		caseNumberInput.value = caseNumber;
		form.appendChild(caseNumberInput);

		const businessProcessSubNameInput = document.createElement('input');
		businessProcessSubNameInput.type = 'hidden';
		businessProcessSubNameInput.name = 'business_process_sub_name';
		businessProcessSubNameInput.value = caseNumber;
		form.appendChild(businessProcessSubNameInput);

		// Append form to body and submit
		document.body.appendChild(form);
		form.submit();
	}

	// ==================== COLLECTION FOR PAYMENT MODAL ====================
	$('#collectionForPayment').on('show.bs.modal', function(event) {
		const jobNumber = $(event.relatedTarget).data('target-id');
		$("#cfp_job_number").val(jobNumber || '');

		const arName = $(event.relatedTarget).data('ar_name');
		$("#cfp_ar_name").val(arName || '');

	});

	$('#btn_cpf_save_comment').on('click', function(e) {
		e.preventDefault();

		const form = document.getElementById('frmCollectionForPayment');
		
		const cfpJobNumber = $("#cfp_job_number").val();
		const cfpCollectorsName = $("#cfp_collectors_name").val();
		const cfpIdType = $("#cfp_id_type").val();
		const cpfIdNumber = $("#cpf_id_number").val();
		const cpfCollectionPurpose = $("#cpf_collection_purpose").val();
		const cpfCollectorsPhone = $("#cpf_collectors_phone").val();

		if (!validateCollectionForPaymentFields(cfpCollectorsName, cfpIdType, cpfIdNumber, cpfCollectionPurpose, cpfCollectorsPhone)) {
			form.classList.add('was-validated');
			return;
		}

		const comment = `Application has been Collected for ${cpfCollectionPurpose} by ${cfpCollectorsName} with ID ${cfpIdType}: ${cpfIdNumber} Phone Number ${cpfCollectorsPhone}`;

		saveCollectionForPaymentComment(cfpJobNumber, comment);
	});

	function validateCollectionForPaymentFields(name, idType, idNumber, purpose, phone) {
		if (!name || !name.trim()) {
			showNotification('Please enter collector\'s name', 'error');
			return false;
		}
		if (!idType) {
			showNotification('Please select ID type', 'error');
			return false;
		}
		if (!idNumber || !idNumber.trim()) {
			showNotification('Please enter ID number', 'error');
			return false;
		}
		if (!purpose) {
			showNotification('Please select collection purpose', 'error');
			return false;
		}
		return true;
	}

	function saveCollectionForPaymentComment(jobNumber, comment) {
		//showLoadingState($('#btn_cpf_save_comment'), 'Saving...');
		
		$.ajax({
			type: "POST",
			url: "Case_Management_Serv",
			data: {
				request_type: 'lc_comment_on_job',
				job_number: jobNumber,
				comment: comment
			},
			cache: false,
			success: function(response) {
				//console.log(response);
				const result = JSON.parse(response);
				showNotification(result.msg, 'success');
				$('#collectionForPayment').modal('hide');
				resetCollectionForPaymentForm();
			},
			error: handleAjaxError,
			complete: function() {
				//resetLoadingState($('#btn_cpf_save_comment'), 'Save Comment');
			}
		});
	}

	function resetCollectionForPaymentForm() {
		$("#cfp_collectors_name").val('');
		$("#cfp_id_type").val('');
		$("#cpf_id_number").val('');
		$("#cpf_collection_purpose").val('');
		$("#cpf_collectors_phone").val('');
	}

	// ==================== COLLECTION MODAL ====================
	let currentStep = 1;
    const totalSteps = 3;
    
    // Initialize stepper
    function initializeStepper() {
        updateStepper();
        updateButtons();
    }
    
    // Update stepper UI
    function updateStepper() {
        $('.wizard-steps-collection .step').removeClass('active');
        $('.step-content-collection').removeClass('active');
        
        $(`.wizard-steps-collection .step[data-step="${currentStep}"]`).addClass('active');
        $(`#step-${currentStep}-content-collection`).addClass('active');
        
        // Show/hide complete button
        if (currentStep === totalSteps) {
            $('#btnCompleteProcessCollection').show();
            $('#btnNextStepCollection').hide();
        } else {
            $('#btnCompleteProcessCollection').hide();
            $('#btnNextStepCollection').show();
        }
    }
    
    // Update button states
    function updateButtons() {
        $('#btnPrevStepCollection').prop('disabled', currentStep === 1);
    }
    
    // Next button click
    $('#btnNextStepCollection').on('click', function() {
        if (validateCurrentStep()) {
            if (currentStep < totalSteps) {
                currentStep++;
                updateStepper();
                updateButtons();
            }
        }
    });
    
    // Previous button click
    $('#btnPrevStepCollection').on('click', function() {
        if (currentStep > 1) {
            currentStep--;
            updateStepper();
            updateButtons();
        }
    });
    
    // Complete button click
    $('#btnCompleteProcessCollection').on('click', function() {
        if (validateCurrentStep()) {
            $('#frmSaveCollection').submit();
        }
    });
    
    // Step validation
    function validateCurrentStep() {
        let isValid = true;
        
        switch(currentStep) {
            case 1:
                // Application details step - always valid (readonly)
                break;
                
            case 2:
                // Identity verification - check if parties exist
                if ($('#noPartiesRow').is(':visible')) {
                    showNotification('No parties found for verification', 'warning');
                    isValid = false;
                }
                break;
                
            case 3:
                // Confirmation step - validate checklist and form
                const uncheckedItems = $('.collection-checklist-item:required:not(:checked)');
                if (uncheckedItems.length > 0) {
                    showNotification('Please complete all required checklist items', 'warning');
                    isValid = false;
                }
                
                const form = document.getElementById('frmSaveCollection');
                if (!form.checkValidity()) {
                    form.classList.add('was-validated');
                    isValid = false;
                }
                break;
        }
        
        return isValid;
    }
    
    // Update checklist row creation function
    function createCollectionChecklistRow(checklist, index) {
        return `
            <tr>
                <td class="ps-4">
                    <div class="d-flex align-items-center">
                        <div class="form-check">
                            <input class="form-check-input collection-checklist-item" 
                                   type="checkbox" id="check_${index}" 
                                   ${checklist.required ? 'required' : ''}>
                            <label class="form-check-label ms-2" for="check_${index}">
                                ${escapeHtml(checklist.collection_of_application_checklist_name || '')}
                            </label>
                        </div>
                    </div>
                </td>
                <td class="pe-4 text-center">
                    <div class="form-check d-inline-block">
                        <input class="form-check-input" type="checkbox" id="confirm_${index}">
                    </div>
                </td>
            </tr>
        `;
    }
    
    // Update application party row creation function
    function createApplicationPartyRow(party, index) {
        return `
            <tr class="small">
                <td class="ps-4">
                    <div class="d-flex align-items-center">
                        <div class="avatar-sm flex-shrink-0 me-3">
                            <div class="avatar-title bg-light rounded-circle">
                                <i class="fas fa-user text-primary"></i>
                            </div>
                        </div>
                        <div>
                            <h6 class="fw-medium small">${escapeHtml(party.ar_name || '')}</h6>
                            <small class="text-muted">Party</small>
                        </div>
                    </div>
                </td>
                <td>
                    <span class="badge bg-info bg-opacity-10 text-info">
                        ${escapeHtml(party.ar_gender || 'N/A')}
                    </span>
                </td>
                <td>
                    <small class="d-block">${escapeHtml(party.ar_cell_phone || 'N/A')}</small>
                </td>
                <td>
                    <span class="badge bg-light text-dark">
                        ${escapeHtml(party.ar_id_type || 'N/A')}
                    </span>
                </td>
                <td>
                    <code class="bg-light p-1 rounded">${escapeHtml(party.ar_id_number || 'N/A')}</code>
                </td>
                <td class="pe-4">
                    <span class="badge bg-primary">
                        ${escapeHtml(party.type_of_party || 'N/A')}
                    </span>
                </td>
            </tr>
        `;
    }
    
    // Update populateCollectionData function
    function populateCollectionData(response) {
        try {
            const data = JSON.parse(response);
            
            // Reset stepper
            currentStep = 1;
            initializeStepper();

			//console.log(data);
            
            // Update counts
            const checklistCount = data.collection_checklist && Array.isArray(data.collection_checklist) ? data.collection_checklist.length : 0;
            const partyCount = data.application_parties && Array.isArray(data.application_parties) ? data.application_parties.length : 0;
            
            $('#checklistCount').text(`${checklistCount} Item${checklistCount !== 1 ? 's' : ''}`);
            $('#partyCount').text(`${partyCount} Part${partyCount !== 1 ? 'ies' : 'y'}`);
            
            // Populate collection checklist
            const checklistTable = $('#collection-checklist tbody');
            const noChecklistRow = $('#noChecklistRow');
            checklistTable.find('tr:not(#noChecklistRow)').remove();
            
            if (checklistCount > 0) {
                noChecklistRow.hide();
                data.collection_checklist.forEach((checklist, index) => {
                    checklistTable.append(createCollectionChecklistRow(checklist, index));
                });
            } else {
                noChecklistRow.show();
            }
            
            // Populate application parties
            const partiesTable = $('#collection-parties tbody');
            const noPartiesRow = $('#noPartiesRow');
            partiesTable.find('tr:not(#noPartiesRow)').remove();
            
            if (partyCount > 0) {
                noPartiesRow.hide();
                data.application_parties.forEach((party, index) => {
                    partiesTable.append(createApplicationPartyRow(party, index));
                });
            } else {
                noPartiesRow.show();
            }
            
            // Populate application details
            if (data.application_details) {
                const details = data.application_details;
                $("#col_applicant_name").val(details.ar_name || '');
                $("#col_application_type").val(details.business_process_name || '');
                $("#col_job_number").val(details.job_number || '');
                $("#col_division").val(details.current_division_of_application || '');
                $("#col_job_status").val(details.current_application_status || '');
                $("#col_collection_status").val(details.is_collected || '');
                $("#col_forwarded_by").val(details.job_forwarded_by || '');
                $("#col_date_forwarded").val(details.job_datesend || '');
                $("#col_current_officer").val(details.current_officer || '');
                $("#col_received_by").val(details.job_recieved_by || '');
                $("#col_received_date").val(details.job_received_date || '');
                $("#col_carbinet").val(details.file_number || '');
                $("#col_shelve").val(details.shelve || '--');
                $("#col_filed").val(details.is_filed || '');
                $("#col_filed_date").val(details.filed_date || '');
                $("#col_batchnumber").val(details.batch_number || '');
                $("#col_batched_date").val(details.batch_date || '');
                $("#col_batched_by").val(details.batched_by || '');
                // $("#col_collected_by").val(details.collected_by || '');
                $("#col_id_type").val(details.collected_by_id_type || '');
                $("#col_id_number").val(details.collected_by_id_number || '');
                $("#col_phone_number").val(details.collected_by_phone_number || '');
            }
            
        } catch (error) {
            console.error('Error parsing collection data:', error);
            showNotification('Error loading collection details', 'error');
        }
    }
    
    // Initialize when modal shows
    $('#collectionModal').on('show.bs.modal', function(event) {
		const jobNumber = $(event.relatedTarget).data('target-id');
    
		if (!jobNumber) {
			console.error('No job number provided for collection modal');
			return;
		}

		resetCollectionModal();
		loadCollectionDetails(jobNumber);
		initializeStepper();
    });

	function resetCollectionModal() {
		const fields = [
			'#col_applicant_name', '#col_application_type', '#col_job_number',
			'#col_division', '#col_job_purpose', '#col_job_status',
			'#col_collection_status', '#col_forwarded_by', '#col_date_forwarded',
			'#col_current_officer', '#col_received_by', '#col_received_date',
			'#col_carbinet', '#col_shelve', '#col_filed', '#col_filed_date',
			'#col_batchnumber', '#col_batched_date', '#col_batched_by',
			'#col_collected_by', '#col_id_type', '#col_id_number', '#col_phone_number'
		];
		
		fields.forEach(selector => $(selector).val(''));
		clearTableRows($('#collection-checklist'));
		clearTableRows($('#collection-parties'));
	}

	function loadCollectionDetails(jobNumber) {
		//showLoadingState($('#collectionModal .modal-content'), 'Loading...');
		
		$.ajax({
			type: "POST",
			url: "Case_Management_Serv",
			data: {
				request_type: 'load_application_collection_details_by_job_number',
				job_number: jobNumber
			},
			cache: false,
			success: function(response) {
				populateCollectionData(response);
			},
			error: handleAjaxError,
			complete: function() {
				//resetLoadingState($('#collectionModal .modal-content'), '');
			}
		});
	}
    
    // Reset when modal hides
    $('#collectionModal').on('hidden.bs.modal', function(event) {
        currentStep = 1;
        $('.step-content-collection').removeClass('active');
        $('#btnCompleteProcessCollection').hide();
        $('#btnNextStepCollection').show();
    });

	function formatDate(dateString) {
        if (!dateString) return 'Date not available';
        try {
            const date = new Date(dateString);
            if (isNaN(date.getTime())) return dateString;
            
            const options = { 
                year: 'numeric', 
                month: 'short', 
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            return date.toLocaleDateString('en-GB', options);
        } catch (error) {
            return dateString;
        }
    }

	// ==================== SAVE COLLECTION DETAILS ====================
	$('#frmSaveCollection').on('submit', function(e) {
		e.preventDefault();
		
		if (!validateCollectionForm()) {
			return;
		}
		
		const colJobNumber = $("#col_job_number").val();
		const colCollectedBy = $("#col_collected_by").val();
		const colIdType = $("#col_id_type").val();
		const colIdNumber = $("#col_id_number").val();
		const colPhoneNumber = $("#col_phone_number").val();
		
		saveCollectionDetails(colJobNumber, colCollectedBy, colIdType, colIdNumber, colPhoneNumber);
	});

	function validateCollectionForm() {
		// Validate all required checkboxes are checked
		const allChecked = $('.collection-checklist-item:required').toArray()
			.every(checkbox => checkbox.checked);
		
		if (!allChecked) {
			showNotification('Please complete all required checklist items', 'error');
			return false;
		}
		
		// Validate collector details
		const colCollectedBy = $("#col_collected_by").val();
		const colIdType = $("#col_id_type").val();
		const colIdNumber = $("#col_id_number").val();
		
		if (!colCollectedBy || !colCollectedBy.trim()) {
			showNotification('Please enter collector\'s name', 'error');
			return false;
		}
		if (!colIdType) {
			showNotification('Please select ID type', 'error');
			return false;
		}
		if (!colIdNumber || !colIdNumber.trim()) {
			showNotification('Please enter ID number', 'error');
			return false;
		}
		
		return true;
	}

	function saveCollectionDetails(jobNumber, collectedBy, idType, idNumber, phoneNumber) {
		// Show confirmation dialog
		Swal.fire({
			title: 'Confirm Collection',
			html: `
				<div class="text-start">
					<p class="mb-3">Are you sure you want to save these collection details?</p>
					<div class="card border-0 bg-light mb-3">
						<div class="card-body p-3">
							<table class="table table-sm table-borderless mb-0">
								<tbody>
									<tr>
										<td class="text-muted" style="width: 120px;"><small>Job Number:</small></td>
										<td><strong>${escapeHtml(jobNumber)}</strong></td>
									</tr>
									<tr>
										<td class="text-muted"><small>Collected By:</small></td>
										<td><strong>${escapeHtml(collectedBy)}</strong></td>
									</tr>
									<tr>
										<td class="text-muted"><small>ID Type:</small></td>
										<td><strong>${escapeHtml(idType)}</strong></td>
									</tr>
									<tr>
										<td class="text-muted"><small>ID Number:</small></td>
										<td><strong>${escapeHtml(idNumber)}</strong></td>
									</tr>
									<tr>
										<td class="text-muted"><small>Phone:</small></td>
										<td><strong>${escapeHtml(phoneNumber)}</strong></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="alert alert-warning py-2 mb-0">
						<i class="fas fa-exclamation-triangle me-2"></i>
						<small>This action cannot be undone. Please verify all details before proceeding.</small>
					</div>
				</div>
			`,
			icon: 'question',
			showCancelButton: true,
			confirmButtonText: 'Yes, Save Collection',
			cancelButtonText: 'Cancel',
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			reverseButtons: true,
			showLoaderOnConfirm: true,
			allowOutsideClick: () => !Swal.isLoading(),
			preConfirm: () => {
				// Return a promise for the AJAX call
				return new Promise((resolve, reject) => {
					$.ajax({
						type: "POST",
						url: "Case_Management_Serv",
						data: {
							request_type: 'load_save_collection_details_by_job_number',
							job_number: jobNumber,
							collected_by: collectedBy,
							collected_by_id_type: idType,
							collected_by_id_number: idNumber,
							collected_by_phone_number: phoneNumber
						},
						cache: false,
						success: function(response) {
							try {
								const data = JSON.parse(response);
								if (data.msg === "SUCCESS") {
									resolve({
										success: true,
										message: 'Collection details saved successfully'
									});
								} else {
									resolve({
										success: false,
										message: data.msg || 'Error saving collection details'
									});
								}
							} catch (error) {
								resolve({
									success: false,
									message: 'Error processing response'
								});
							}
						},
						error: function(xhr, status, error) {
							resolve({
								success: false,
								message: handleAjaxError(xhr, status, error, true)
							});
						}
					});
				});
			}
		}).then((result) => {
			if (result.isConfirmed) {
				if (result.value.success) {
					// Success - show success message
					Swal.fire({
						title: 'Success!',
						text: result.value.message,
						icon: 'success',
						confirmButtonText: 'OK',
						confirmButtonColor: '#3085d6',
						timer: 3000,
						timerProgressBar: true,
						willClose: () => {
							// Close modal and reset
							$('#collectionModal').modal('hide');
							resetCollectionModal();
							
							// Optional: Refresh the search results
							if (typeof handleEnquirySearch === 'function') {
								// You might want to trigger a search refresh here
								// handleEnquirySearch();
							}
						}
					});
				} else {
					// Error from server
					Swal.fire({
						title: 'Error!',
						html: `
							<div class="text-start">
								<p class="mb-3">${result.value.message}</p>
								<div class="alert alert-danger py-2 mb-0">
									<i class="fas fa-exclamation-circle me-2"></i>
									<small>Please check the details and try again.</small>
								</div>
							</div>
						`,
						icon: 'error',
						confirmButtonText: 'Try Again',
						confirmButtonColor: '#d33'
					});
				}
			}
		}).catch((error) => {
			// Handle any unexpected errors
			console.error('Error in saveCollectionDetails:', error);
			Swal.fire({
				title: 'Unexpected Error!',
				text: 'An unexpected error occurred. Please try again.',
				icon: 'error',
				confirmButtonText: 'OK'
			});
		});
	}

	// Helper function to handle AJAX errors (updated to return message string)
	function handleAjaxError(xhr, status, error, returnMessage = false) {
		console.error('AJAX Error:', error);
		
		let errorMessage = 'Error loading data. Please try again.';
		
		if (xhr.status === 0) {
			errorMessage = 'Network error. Please check your internet connection.';
		} else if (xhr.status === 404) {
			errorMessage = 'Requested resource not found.';
		} else if (xhr.status === 500) {
			errorMessage = 'Internal server error. Please try again later.';
		} else if (xhr.responseJSON && xhr.responseJSON.message) {
			errorMessage = xhr.responseJSON.message;
		}
		
		if (returnMessage) {
			return errorMessage;
		} else {
			showNotification(errorMessage, 'error');
		}
	}

	// ==================== ADD FEES BUTTON HANDLER ====================
	$(document).on('click', '#btn_add_fees', function() {
		const $row = $(this).closest('tr');
		const jobNumber = $row.find('td:eq(2)').text().trim(); // Job number is in 3rd column
		const applicantName = $row.find('td:eq(0)').text().trim(); // Applicant name is in 1st column
		
		// Store data for use in fees modal
		$('#fees_job_number').val(jobNumber);
		$('#fees_applicant_name').val(applicantName);
		
		// Show the fees modal (you need to create this modal)
		$('#addFeesModal').modal('show');
		
		// Or redirect to fees page
		// window.location.href = `add_fees.jsp?job_number=${jobNumber}&applicant=${encodeURIComponent(applicantName)}`;
	});

	// ==================== INITIALIZE SMART WIZARD ====================
	function initializeSmartWizard() {
		if ($('#smartwizardcollection').length) {
			$('#smartwizardcollection').smartWizard({
				theme: 'arrows',
				transitionEffect: 'fade',
				showStepURLhash: false,
				toolbarSettings: {
					toolbarPosition: 'bottom',
					showNextButton: true,
					showPreviousButton: true
				}
			});
		}
	}

	// Initialize smart wizard on document ready
	$(document).ready(function() {
		// Your existing initialization code...
		initializeSmartWizard();
	});

	// ==================== ADDITIONAL UTILITY FUNCTIONS ====================
	function showLoadingState($element, loadingText) {
		if (!$element || !$element.length) return;
		
		if ($element.is('button')) {
			const originalHtml = $element.html();
			$element.data('original-html', originalHtml);
			$element.html(`<span class="spinner-border spinner-border-sm me-2"></span>${loadingText}`);
			$element.prop('disabled', true);
		} else {
			// For non-button elements, show a loading overlay
			$element.addClass('loading-overlay');
			$element.append(`
				<div class="loading-spinner">
					<div class="spinner-border text-primary" role="status">
						<span class="visually-hidden">${loadingText}</span>
					</div>
				</div>
			`);
		}
	}

	function resetLoadingState($element, defaultText) {
		if (!$element || !$element.length) return;
		
		if ($element.is('button')) {
			const originalHtml = $element.data('original-html');
			$element.html(originalHtml || defaultText);
			$element.prop('disabled', false);
		} else {
			$element.removeClass('loading-overlay');
			$element.find('.loading-spinner').remove();
		}
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
		
		// Reset summary fields
		$('#totalMovements').text('0');
		$('#currentLocation').text('Unknown');
		$('#lastUpdated').text('Just now');
		$('#showingCount').text('0');
		$('#totalCount').text('0');
		
		loadFileLocationData(jobNumber);
	}

    function loadFileLocationData(jobNumber) {
		//showLoadingState($('#filelistModal .modal-content'), 'Loading history...');
		
		$.ajax({
			type: "POST",
			url: "Case_Management_Serv",
			data: {
				request_type: 'load_application_file_location',
				job_number: jobNumber
			},
			cache: false,
			success: function(response) {
				displayFileLocationData(response, jobNumber);
			},
			error: handleAjaxError,
			complete: function() {
				//resetLoadingState($('#filelistModal .modal-content'), '');
			}
		});
	}

    function displayFileLocationData(response, jobNumber) {
		//console.log(response)
		try {
			const data = JSON.parse(response);
			const table = $('#tbl_file_history tbody');
			const noRecordsRow = $('#noRecordsRow');
			
			table.find("tr").remove();
			noRecordsRow.addClass('d-none');

			if (!Array.isArray(data) || data.length === 0) {
				noRecordsRow.removeClass('d-none');
				updateSummaryFields([], jobNumber);
				return;
			}
			
			// Populate table rows
			data.forEach(item => {
				table.append(createFileLocationRow(item));
			});

			// Set the job number in the summary
			$('#fileTrackingJobNumber').text(jobNumber || 'N/A');

			// Update summary fields
			updateSummaryFields(data, jobNumber);
			
		} catch (error) {
			console.error('Error parsing file location data:', error);
			showNotification('Error loading file history', 'error');
			$('#noRecordsRow').removeClass('d-none');
		}
	}

	function updateSummaryFields(data, jobNumber) {
		const count = Array.isArray(data) ? data.length : 0;
		// Update counts
		$('#filelistModal #totalMovements').text(count);
		$('#showingCount').text(count);
		$('#totalCount').text(count);
		
		// Update job number (in case it wasn't set earlier)
		if (jobNumber) {
			$('#fileTrackingJobNumber').text(jobNumber);
		}
		
		// Determine current location (last record's division)
		if (count > 0) {
			const lastRecord = data[data.length - 1];
			$('#currentLocation').text(lastRecord.user_fullname || 'Unknown');
			
			// Update last updated time
			if (lastRecord.created_date) {
				$('#lastUpdated').text(formatDateTime(lastRecord.created_date));
			}
		} else {
			$('#currentLocation').text('Unknown');
			$('#lastUpdated').text('Never');
		}
		
		// Update footer counts
		$('#showingCount').text(count);
		$('#totalCount').text(count);
	}

	function formatDateTime(dateString) {
		if (!dateString || dateString === 'Date not available') {
			return 'Never';
		}
		
		try {
			const date = new Date(dateString);
			if (isNaN(date.getTime())) return dateString;
			
			const now = new Date();
			const diffMs = now - date;
			const diffMins = Math.floor(diffMs / (1000 * 60));
			const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
			const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
			
			// Return relative time for recent updates
			if (diffMins < 1) {
				return 'Just now';
			} else if (diffMins < 60) {
				return `${diffMins} minute${diffMins !== 1 ? 's' : ''} ago`;
			} else if (diffHours < 24) {
				return `${diffHours} hour${diffHours !== 1 ? 's' : ''} ago`;
			} else if (diffDays < 7) {
				return `${diffDays} day${diffDays !== 1 ? 's' : ''} ago`;
			} else {
				// For older dates, show full date
				return date.toLocaleDateString('en-GB', {
					year: 'numeric',
					month: 'short',
					day: 'numeric',
					hour: '2-digit',
					minute: '2-digit'
				});
			}
		} catch (error) {
			return dateString;
		}
	}

    function createFileLocationRow(item) {
		// console.log(item)
		// Determine status based on data
		// let statusClass = 'info';
		// let statusText = 'In Transit';
		
		// if (item.user_fullname && item.created_by) {
		// 	statusClass = 'success';
		// 	statusText = 'Received';
		// } else if (item.created_by && !item.user_fullname) {
		// 	statusClass = 'warning';
		// 	statusText = 'Sent';
		// }
		
		return `
			<tr>
				<td class="ps-4">
					<div class="d-flex align-items-center">
						<!--<div class="bg-light rounded p-2 me-3">
							<i class="fas fa-calendar-day text-primary"></i>
						</div>-->
						<div>
							<div class="fw-medium">${formatDate(item.created_date)}</div>
							<!--<small class="text-muted">${formatTime(item.created_date)}</small>-->
						</div>
					</div>
				</td>
				<td>
					<span class="fw-medium">${escapeHtml(item.division || 'N/A')}</span>
				</td>
				<td>
					<div class="d-flex align-items-center">
						<!--<div class="bg-light rounded-circle p-2 me-2">
							<i class="fas fa-user text-success"></i>
						</div>-->
						<span>${escapeHtml(item.user_fullname || 'N/A')}</span>
					</div>
				</td>
				<td>
					<div class="d-flex align-items-center">
						<!--<div class="bg-light rounded-circle p-2 me-2">
							<i class="fas fa-user-tie text-primary"></i>
						</div>-->
						<span>${escapeHtml(item.created_by || 'N/A')}</span>
					</div>
				</td>
			</tr>
		`;
	}

	// Helper functions for date and time formatting
	// function formatDate(dateString) {
	// 	if (!dateString) return 'N/A';
	// 	try {
	// 		const date = new Date(dateString);
	// 		if (isNaN(date.getTime())) return 'N/A';
	// 		return date.toLocaleDateString('en-GB', {
	// 			year: 'numeric',
	// 			month: 'short',
	// 			day: 'numeric'
	// 		});
	// 	} catch (error) {
	// 		return 'N/A';
	// 	}
	// }

	function formatTime(dateString) {
		if (!dateString) return '';
		try {
			const date = new Date(dateString);
			if (isNaN(date.getTime())) return '';
			return date.toLocaleTimeString('en-GB', {
				hour: '2-digit',
				minute: '2-digit'
			});
		} catch (error) {
			return '';
		}
	}

	$('#btnRefreshHistory').on('click', function() {
		const jobNumber = $('#fileTrackingJobNumber').text();
		
		if (jobNumber && jobNumber !== 'N/A') {
			loadFileLocationData(jobNumber);
		} else {
			// If no job number is set, try to get it from the modal trigger
			const modal = bootstrap.Modal.getInstance(document.getElementById('filelistModal'));
			if (modal) {
				// You might need to store the job number when the modal opens
				const storedJobNumber = $('#filelistModal').data('current-job-number');
				if (storedJobNumber) {
					loadFileLocationData(storedJobNumber);
				}
			}
		}
	});

	$('#filelistModal').on('show.bs.modal', function(event) {
		const jobNumber = $(event.relatedTarget).data('target-id');
		$(this).data('current-job-number', jobNumber);
	});

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
			title: type === 'success' ? 'Success' : 'Error',
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

$(document).on('shown.bs.dropdown', '.action-btn', function () {

    const button = this;
    const dropdown = button.closest('.dropdown');
    const menu = dropdown.querySelector('.table-dropdown');

    if (!menu) return;

    // Move menu to body
    document.body.appendChild(menu);

    const rect = button.getBoundingClientRect();
    const menuHeight = menu.offsetHeight;

    // Position ABOVE the button
    menu.style.position = 'fixed';
    menu.style.top = (rect.top - menuHeight - 8) + 'px';
    menu.style.left = (rect.right - menu.offsetWidth) + 'px';
	menu.style.right = 'auto';
    menu.style.zIndex = 1055;

    // Store reference
    button._dropdownMenu = menu;
});

$(document).on('hide.bs.dropdown', '.action-btn', function () {

    const button = this;
    const dropdown = button.closest('.dropdown');
    const menu = button._dropdownMenu;

    if (!menu || !dropdown) return;

    // Move menu back
    dropdown.appendChild(menu);

    // Reset styles
    menu.style.position = '';
    menu.style.top = '';
    menu.style.left = '';
    menu.style.zIndex = '';

    button._dropdownMenu = null;
});