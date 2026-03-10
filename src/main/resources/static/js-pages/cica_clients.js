// Initialize Choice.js for all select elements
document.addEventListener('DOMContentLoaded', function() {
    const selectElements = document.querySelectorAll('select');
    selectElements.forEach(select => {
        new Choices(select, {
            searchEnabled: true,
            itemSelectText: '',
            removeItemButton: true,
            classNames: {
                containerOuter: 'choices',
                containerInner: 'choices__inner',
                input: 'choices__input',
                inputCloned: 'choices__input--cloned',
                list: 'choices__list',
                listItems: 'choices__list--multiple',
                listSingle: 'choices__list--single',
                listDropdown: 'choices__list--dropdown',
                item: 'choices__item',
                itemSelectable: 'choices__item--selectable',
                itemDisabled: 'choices__item--disabled',
                itemChoice: 'choices__item--choice',
                placeholder: 'choices__placeholder',
                group: 'choices__group',
                groupHeading: 'choices__heading',
                button: 'choices__button',
                activeState: 'is-active',
                focusState: 'is-focused',
                openState: 'is-open',
                disabledState: 'is-disabled',
                highlightedState: 'is-highlighted',
                selectedState: 'is-selected',
                flippedState: 'is-flipped',
                loadingState: 'is-loading',
                noResults: 'has-no-results',
                noChoices: 'has-no-choices'
            }
        });
    });
});

// Initialize
$(document).ready(function() {
    // Hide enquiry section initially
    $('#enquiry-section').hide();
    
    // Purpose change handler
    $('#purpose').on('change', function() {
        handlePurposeChange($(this).val());
    });
    
    // Reset form
    $('#resetBtn').on('click', function() {
        Swal.fire({
            title: 'Reset Form?',
            text: "All entered data will be cleared.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, reset it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $('#cicaClientForm')[0].reset();
                $('#dynamic-fields-container').html(getEmptyStateHTML());
                $('#enquiry-section').hide();
                Swal.fire('Reset!', 'Form has been reset.', 'success');
            }
        });
    });
    
    // Form submission with confirmation
    $('#cicaClientForm').on('submit', function(e) {
        e.preventDefault();
        submitFormWithConfirmation();
    });
    
    // Search button click
    $('#btnCCJobSearch').on('click', function() {
        performSearch();
    });
});

// Handle purpose change
function handlePurposeChange(purposeValue) {
    const container = $('#dynamic-fields-container');
    const enquirySection = $('#enquiry-section');
    const submitBtn = $('#submitBtn');
    
    // Reset dynamic fields
    container.empty();
    
    switch(purposeValue) {
        case '1': // Service Enquiry
            container.html(getServiceEnquiryHTML());
            submitBtn.prop('disabled', true);
            enquirySection.show();
            break;
        case '2': // Other Enquiry
            container.html(getOtherEnquiryHTML());
            submitBtn.prop('disabled', false);
            enquirySection.hide();
            break;
        case '3': // Service Complaint
            container.html(getServiceComplaintHTML());
            submitBtn.prop('disabled', false);
            enquirySection.show();
            break;
        case '4': // Non Service Complaint
            container.html(getNonServiceComplaintHTML());
            submitBtn.prop('disabled', false);
            enquirySection.hide();
            break;
        default:
            container.html(getEmptyStateHTML());
            submitBtn.prop('disabled', true);
            enquirySection.hide();
    }
}

// Dynamic field templates
function getEmptyStateHTML() {
    return `
        <div class="text-center text-muted py-5">
            <i class="fas fa-arrow-left fa-2x mb-3"></i>
            <p class="mb-0">Select a purpose to see additional fields</p>
        </div>
    `;
}

function getServiceEnquiryHTML() {
    return `
        <h6 class="text-primary mb-4"><i class="fas fa-question-circle me-2"></i>Service Enquiry Details</h6>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Within Time Frame? <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="within_time_frame" id="within_time_frame" required>
                <option value="" selected disabled>-- select --</option>
                <option value="1">Yes</option>
                <option value="0">No</option>
            </select>
        </div>
        <div class="additional-fields"></div>
    `;
}

function getOtherEnquiryHTML() {
    return `
        <h6 class="text-primary mb-4"><i class="fas fa-question-circle me-2"></i>Other Enquiry Details</h6>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Nature of Enquiry <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="nature_of_enquiry" id="nature_of_enquiry" required>
                <option value="" selected disabled>-- select --</option>
                <option value="Registration">Registration</option>
                <option value="Plan">Plan</option>
                <option value="Search">Search</option>
                <option value="State Land management">State Land management</option>
                <option value="Stool Land Issues">Stool Land Issues</option>
                <option value="Stamping">Stamping</option>
                <option value="Land Ownership/Acquisition">Land Ownership/Acquisition</option>
                <option value="Others">Others</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Response Provided <span class="text-danger">*</span>
            </label>
            <textarea class="form-control" rows="3" name="reference_source" id="reference_source" required></textarea>
        </div>
    `;
}

function getServiceComplaintHTML() {
    return `
        <h6 class="text-primary mb-4"><i class="fas fa-exclamation-circle me-2"></i>Service Complaint Details</h6>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Subject <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="subject" id="subject" required >
                <option value="" selected disabled>-- select --</option>
                <option value="Payment Issues">Payment Issues</option>
                <option value="Delayed">Delayed</option>
                <option value="Upload issues">Upload issues</option>
                <option value="Queried">Queried</option>
                <option value="Other Issues">Other Issues</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Description <span class="text-danger">*</span>
            </label>
            <textarea class="form-control" rows="3" name="description" id="description" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Contact Client by <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="contact_type" id="contact_type" required >
                <option value="" selected disabled>-- select --</option>
                <option value="SMS">SMS</option>
                <option value="Email">Email</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Priority <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="priority" id="priority" value="High" readonly>
        </div>
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label fw-semibold">
                    Division <span class="text-danger">*</span>
                </label>
                <select class="form-select" name="division" id="division" required >
                    <option value="" selected disabled>-- select --</option>
                    <option value="PVLMD">PVLMD</option>
                    <option value="LRD">LRD</option>
                    <option value="LVD">LVD</option>
                    <option value="SMD">SMD</option>
                    <option value="CORPORATE">CORPORATE</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label fw-semibold">
                    Region <span class="text-danger">*</span>
                </label>
                <select class="form-select" name="region" id="region" required >
                    <option value="" selected disabled>-- select --</option>
                    <option value="11">Greater Accra</option>
                    <option value="14">Western</option>
                    <option value="19">Volta</option>
                    <option value="12">Eastern</option>
                    <option value="13">Ashanti</option>
                    <option value="15">Central</option>
                    <option value="18">Northern</option>
                    <option value="16">Upper East</option>
                    <option value="17">Upper West</option>
                    <option value="10">Tema</option>
                    <option value="22">Oti</option>
                    <option value="23">Bono East</option>
                    <option value="24">Ahafo</option>
                    <option value="20">Bono</option>
                    <option value="25">North East</option>
                    <option value="26">Savannah</option>
                    <option value="21">Western North</option>
                </select>
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Related Service <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="related_service" id="related_service" required >
                <option value="" selected disabled>-- select --</option>
                <option value="Search">Search</option>
                <option value="Stamp Duty">Stamp Duty</option>
                <option value="Concurrence">Concurrence</option>
                <option value="Consent">Consent</option>
                <option value="Plan Approval">Plan Approval</option>
                <option value="Title Registration">Title Registration</option>
                <option value="PVLMD Plotting">PVLMD Plotting</option>
                <option value="Reguralization">Reguralization</option>
                <option value="Certified True Copy">Certified True Copy</option>
                <option value="Dispute">Dispute</option>
                <option value="Composite Plan">Composite Plan</option>
                <option value="General Valuation">General Valuation</option>
                <option value="Compensation">Compensation</option>
                <option value="Deed Registration">Deed Registration</option>
                <option value="Substituted Certificate">Substituted Certificate</option>
                <option value="State Land Rent">State Land Rent</option>
                <option value="Other Services">Other Services</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Reference No. <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="reference_id" id="reference_id" required>
        </div>
    `;
}

function getNonServiceComplaintHTML() {
    return `
        <h6 class="text-primary mb-4"><i class="fas fa-exclamation-triangle me-2"></i>Non-Service Complaint Details</h6>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Subject <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="subject" id="subject" required >
                <option value="" selected disabled>-- select --</option>
                <option value="Staff Misconduct">Staff Misconduct</option>
                <option value="Work Environment">Work Environment</option>
                <option value="Security">Security</option>
                <option value="Others">Others</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Description <span class="text-danger">*</span>
            </label>
            <textarea class="form-control" rows="3" name="description" id="description" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">
                Contact Client by <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="contact_type" id="contact_type" required >
                <option value="" selected disabled>-- select --</option>
                <option value="SMS">SMS</option>
                <option value="Email">Email</option>
            </select>
        </div>
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label fw-semibold">
                    Division <span class="text-danger">*</span>
                </label>
                <select class="form-select" name="division" id="division" required >
                    <option value="CORPORATE" selected>CORPORATE</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label fw-semibold">
                    Region <span class="text-danger">*</span>
                </label>
                <select class="form-select" name="region" id="region" required >
                    <option value="" selected disabled>-- select --</option>
                    <option value="11">Greater Accra</option>
                    <option value="14">Western</option>
                    <option value="19">Volta</option>
                    <option value="12">Eastern</option>
                    <option value="13">Ashanti</option>
                    <option value="15">Central</option>
                    <option value="18">Northern</option>
                    <option value="16">Upper East</option>
                    <option value="17">Upper West</option>
                    <option value="10">Tema</option>
                    <option value="22">Oti</option>
                    <option value="23">Bono East</option>
                    <option value="24">Ahafo</option>
                    <option value="20">Bono</option>
                    <option value="25">North East</option>
                    <option value="26">Savannah</option>
                    <option value="21">Western North</option>
                </select>
            </div>
        </div>
    `;
}

// Form submission with SweetAlert2 confirmation
function submitFormWithConfirmation() {
    // Validate required fields
    if (!validateForm()) {
        Swal.fire({
            icon: 'warning',
            title: 'Missing Information',
            text: 'Please fill all required fields marked with *',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    Swal.fire({
        title: 'Submit Client Details?',
        text: "Please review the information before submitting.",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, submit it!',
        cancelButtonText: 'Review',
        showLoaderOnConfirm: true,
        preConfirm: () => {
            return submitFormData();
        }
    }).then((result) => {
        if (result.isConfirmed && result.value.success) {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'Client details have been submitted successfully.',
                confirmButtonColor: '#28a745'
            }).then(() => {
                // Reset form or redirect if needed
                $('#cicaClientForm')[0].reset();
                $('#dynamic-fields-container').html(getEmptyStateHTML());
            });
        } else if (result.isConfirmed && !result.value.success) {
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: result.value.message || 'Failed to submit client details. Please try again.',
                confirmButtonColor: '#dc3545'
            });
        }
    });
}

// Validate form
function validateForm() {
    let isValid = true;
    
    // Check basic required fields
    $('#cicaClientForm .required-input').each(function() {
        if (!$(this).val().trim()) {
            $(this).addClass('is-invalid');
            isValid = false;
        } else {
            $(this).removeClass('is-invalid');
        }
    });
    
    return isValid;
}

// Submit form data via AJAX
function submitFormData() {
    return new Promise((resolve, reject) => {
        const formData = new FormData();
        
        // Add all form fields to FormData
        $('#cicaClientForm').serializeArray().forEach(field => {
            formData.append(field.name, field.value);
        });
        
        $.ajax({
            type: "POST",
            url: "cica_clients_serv",
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                resolve({ success: true, data: response });
            },
            error: function(xhr, status, error) {
                resolve({ 
                    success: false, 
                    message: error || 'An error occurred while submitting the form.' 
                });
            }
        });
    });
}

// Perform search
function performSearch() {
    const searchType = $('input[name="rbtn_search_type"]:checked').val();
    const searchValue = $('#cc_search_value').val().trim();
    
    // Validate search
    if (!searchType) {
        Swal.fire({
            icon: 'warning',
            title: 'Search Type Required',
            text: 'Please select a search type.',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    if (!searchValue) {
        Swal.fire({
            icon: 'warning',
            title: 'Search Value Required',
            text: 'Please enter a search value.',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    if (searchValue.length < 8) {
        Swal.fire({
            icon: 'warning',
            title: 'More Characters Needed',
            text: 'Please enter at least 8 characters for better search results.',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    // Show loading
    const searchBtn = $('#btnCCJobSearch');
    const originalText = searchBtn.html();
    searchBtn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Searching...');
    
    // Perform AJAX search
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'load_application_details_for_enquiries',
            job_number: searchValue,
            search_type: searchType
        },
        success: function(response) {
            searchBtn.prop('disabled', false).html(originalText);
            displaySearchResults(response);
        },
        error: function() {
            searchBtn.prop('disabled', false).html(originalText);
            Swal.fire({
                icon: 'error',
                title: 'Search Failed',
                text: 'An error occurred while performing the search.',
                confirmButtonColor: '#dc3545'
            });
        }
    });
}

// Display search results
function displaySearchResults(data) {
    const resultsSection = $('#cc-search-results-section');
    const tableBody = $('#cc-search-results-table tbody');
    
    tableBody.empty();
    
    try {
        const results = JSON.parse(data);
        
        console.log('Raw parsed results:', results);
        
        // Check if results is an array or single object
        let resultsArray;
        if (Array.isArray(results)) {
            resultsArray = results;
        } else if (results && typeof results === 'object') {
            resultsArray = [results];
        } else {
            resultsArray = [];
        }
        
        console.log('Results array:', resultsArray);
        
        if (resultsArray.length === 0) {
            Swal.fire({
                icon: 'info',
                title: 'No Results',
                text: 'No applications found matching your search criteria.',
                confirmButtonColor: '#3085d6'
            });
            resultsSection.addClass('d-none');
            return;
        }
        
        // Clear the table first
        tableBody.html('');
        
        // Populate table using DOM manipulation instead of template literals
        resultsArray.forEach((item) => {
            console.log('Current item:', item);
            
            // Create a new row
            const row = $('<tr>');
            
            // Create cells
            const arNameCell = $('<td>').text(item.ar_name || 'N/A');
            const caseNumberCell = $('<td>').text(item.case_number || 'N/A');
            const jobNumberCell = $('<td>').text(item.job_number || 'N/A');
            const localityCell = $('<td>').text(item.locality || 'N/A');
            const regionalNumberCell = $('<td>').text(item.regional_number || 'N/A');
            
            // Create action dropdown cell
            const actionsCell = $('<td>');
            
            // Create dropdown div
            const dropdownDiv = $('<div>').addClass('dropdown');
            
            // Create dropdown button
            const dropdownButton = $('<button>')
                .addClass('btn btn-sm btn-outline-primary dropdown-toggle')
                .attr('type', 'button')
                .attr('data-bs-toggle', 'dropdown')
                .attr('aria-expanded', 'false')
                .html('<i class="fas fa-cog me-1"></i>Actions');
            
            // Create dropdown menu
            const dropdownMenu = $('<ul>').addClass('dropdown-menu');
            
            // Create track button
            const trackButton = $('<button>')
                .addClass('dropdown-item')
                .attr('type', 'button')
                .html('<i class="fas fa-hdd me-2"></i>Track Application')
                .on('click', function(e) {
                    e.preventDefault();
                    loadAndShowTrackingModal(item.job_number);
                });
            
            // Append track button to list item
            const listItem = $('<li>').append(trackButton);
            dropdownMenu.append(listItem);
            
            // Build the dropdown structure
            dropdownDiv.append(dropdownButton, dropdownMenu);
            actionsCell.append(dropdownDiv);
            
            // Append all cells to the row
            row.append(
                arNameCell,
                caseNumberCell,
                jobNumberCell,
                localityCell,
                regionalNumberCell,
                actionsCell
            );
            
            // Append row to table body
            tableBody.append(row);
        });
        
        resultsSection.removeClass('d-none');
        
        Swal.fire({
            icon: 'success',
            title: 'Search Complete',
            text: `Found ${resultsArray.length} result(s).`,
            confirmButtonColor: '#28a745',
            timer: 1500,
            showConfirmButton: false
        });
        
    } catch (error) {
        console.error('Error parsing search results:', error);
        console.error('Raw data that caused error:', data);
        
        // Try to show what's in the data
        if (typeof data === 'string') {
            console.log('Data string length:', data.length);
            console.log('Data string first 500 chars:', data.substring(0, 500));
        }
        
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Failed to parse search results. Please check console for details.',
            confirmButtonColor: '#dc3545'
        });
    }
}

function loadAndShowTrackingModal(jobNumber) {
    if (!jobNumber) {
        Swal.fire({
            icon: 'warning',
            title: 'No Job Number',
            text: 'Job number is missing.',
            confirmButtonColor: '#3085d6'
        });
        return;
    }
    
    // Show loading state
    const modalElement = document.getElementById('trackingModal');
    // const modalBody = modalElement.querySelector('.modal-body');
    // modalBody.innerHTML = `
    //     <div class="text-center py-5">
    //         <div class="spinner-border text-primary" role="status">
    //             <span class="visually-hidden">Loading...</span>
    //         </div>
    //         <p class="mt-3 text-muted">Loading tracking data...</p>
    //     </div>
    // `;
    
    // Show the modal first
    const modal = new bootstrap.Modal(modalElement);
    modal.show();
    
    // Load tracking data
    loadTrackingDataForModal(jobNumber);
}

// Function to load tracking data for modal
async function loadTrackingDataForModal(jobNumber) {
    try {
        // Clear existing data
        clearTrackingTables();
        clearTrackingFields();
        
        // Set job number in the modal
        $('#job_number_text').text(jobNumber);
        
        // Load cabinet details first
        const cabinetData = await loadCabinetDetailsForTrackingModal(jobNumber);
        const cabinetStatus = cabinetData?.cabinet_tracking?.[cabinetData.cabinet_tracking.length - 1]?.officers_general_comments || '';
        
        // Load milestone data
        await loadMilestoneDataForModal(jobNumber, cabinetStatus);
        
        // Update badge counts
        updateBadgeCounts();
        
    } catch (error) {
        console.error('Error loading tracking data:', error);
        
        // Show error in modal
        const modalBody = document.querySelector('#trackingModal .modal-body');
        modalBody.innerHTML = `
            <div class="alert alert-danger">
                <h5 class="alert-heading">Error Loading Data</h5>
                <p>Failed to load tracking data for job: ${jobNumber}</p>
                <p class="mb-0"><small>Error: ${error.message}</small></p>
            </div>
            <div class="text-center mt-3">
                <button class="btn btn-primary" onclick="loadAndShowTrackingModal('${jobNumber}')">
                    <i class="fas fa-redo me-2"></i>Retry
                </button>
            </div>
        `;
    }
}

function loadCabinetDetailsForTrackingModal(jobNumber) {
    return new Promise((resolve, reject) => {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_cabinet_details_by_job_number',
                job_number: jobNumber
            },
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    const table = $('#cabinet-tracking');
                    table.find("tbody tr").remove();
                    
                    if (data.cabinet_tracking && data.cabinet_tracking.length > 0) {
                        data.cabinet_tracking.forEach((item, index) => {
                            const rowClass = index === data.cabinet_tracking.length - 1 ? 'table-info' : '';
                            table.append(`
                                <tr class="${rowClass}">
                                    <td>${item.officers_general_comments || ''}</td>
                                    <td>${item.division || ''}</td>
                                    <td>${item.created_by || ''}</td>
                                    <td>${item.created_date || ''}</td>
                                </tr>
                            `);
                        });

                        $('#commentsCount').text(data.cabinet_tracking.length);

                    } else {
                        table.append(`
                            <tr>
                                <td colspan="4" class="text-center text-muted">
                                    <i class="fas fa-info-circle me-2"></i>No comments found
                                </td>
                            </tr>
                        `);
                    }
                    
                    resolve(data);
                } catch (e) {
                    reject(e);
                }
            },
            error: reject
        });
    });
}

// Modified version of loadMilestoneData for modal
async function loadMilestoneDataForModal(jobNumber, cabinetStatus) {
    try {
        const response = await $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_milestone_for_tracking_by_job',
                job_number: jobNumber
            }
        });
        
        const data = JSON.parse(response);
        processMilestoneDataForModal(data, cabinetStatus, jobNumber);
        
    } catch (error) {
        console.error('Error loading milestone data:', error);
        throw error;
    }
}

// Modified version of processMilestoneData for modal
function processMilestoneDataForModal(data, cabinetStatus, jobNumber) {
    // Set case number
    const caseNumber = data.application_details?.[0]?.case_number || '';
    $("#cs_main_case_number").val(caseNumber);
    $("#case_number_display").text(caseNumber || '-');
    
    // Calculate status
     const purpose = parseInt($('#purpose').val());
    const queryStatus = data.case_query?.[0]?.status || "0";
    const isCompleted = cabinetStatus.includes('cabinet') || cabinetStatus.includes('collected');
    
    // Calculate days passed
    const createdDate = data.application_details?.[0]?.created_date;
    const daysPassed = calculateBusinessDaysPassed(createdDate);
    
    // Calculate total required days
    const totalRequiredDays = data.milestones?.reduce((sum, milestone) => 
        sum + parseFloat(milestone.working_day_required || 0), 0) || 0;
    
    // Calculate reminder percentage
    const reminderPercentage = totalRequiredDays > 0 ? (daysPassed / totalRequiredDays) * 100 : 0;
    
    // Determine application status
    const appStatus = determineAppStatus(isCompleted, queryStatus, reminderPercentage);
    
    // Update UI
    updateAppStatusUI(appStatus, daysPassed);
    updatePriorityFieldForModal(reminderPercentage, queryStatus, isCompleted);
    updateFormFields(purpose, isCompleted, queryStatus, reminderPercentage, jobNumber, daysPassed);
    
    // Populate milestones table
    populateMilestonesTableForModal(data.milestones, data.application_stage);
    
    // Populate notifications
    populateNotificationsForModal(data.notifications);
    
    // Populate case queries
    populateCaseQueriesForModal(data.case_query);
    
    // Populate application details
    populateApplicationDetailsForModal(data.application_details, jobNumber);

}

// Modified populateMilestonesTable for modal
function populateMilestonesTableForModal(milestones, currentStage) {
    const table = $('#app-tracking tbody');
    table.empty();
    
    if (!milestones || milestones.length === 0) {
        table.append(`
            <tr>
                <td colspan="4" class="text-center text-muted">
                    <i class="fas fa-info-circle me-2"></i>No milestones found
                </td>
            </tr>
        `);
        return;
    }
    
    milestones.forEach((milestone, index) => {
        const milestoneNum = index + 1;
        const priorityValue = parseInt(milestone.priority_value || 0);
        const appStage = parseInt(currentStage || 0);
        
        let status, cssClass;
        
        if (priorityValue < appStage) {
            status = "Completed";
            cssClass = "table-success";
        } else if (priorityValue == appStage) {
            status = "Ongoing";
            cssClass = "table-info";
        } else {
            status = "Pending";
            cssClass = "table-warning";
        }
        
        table.append(`
            <tr class="${cssClass}">
                <td>${milestoneNum}</td>
                <td>${milestone.milestone_description || ''}</td>
                <td>
                    <span class="badge ${status === 'Completed' ? 'bg-success' : status === 'Ongoing' ? 'bg-info' : 'bg-warning'}">
                        ${status}
                    </span>
                </td>
                <td class="text-center">${milestone.working_day_required || ''}</td>
            </tr>
        `);
    });
}

// Modified populateNotifications for modal
function populateNotificationsForModal(notifications) {
    const table = $('#sms-tracking tbody');
    table.empty();
    
    if (!notifications || notifications.length === 0) {
        table.append(`
            <tr>
                <td colspan="3" class="text-center text-muted">
                    <i class="fas fa-info-circle me-2"></i>No SMS notifications found
                </td>
            </tr>
        `);
        return;
    }
    
    notifications.forEach((notification, index) => {
        table.append(`
            <tr>
                <td>${index + 1}</td>
                <td><small>${notification.sms_message || ''}</small></td>
                <td>${notification.sms_date_sent || ''}</td>
            </tr>
        `);
    });
}

// Modified populateCaseQueries for modal
function populateCaseQueriesForModal(queries) {
    const table = $('#case-query tbody');
    const caseQueryDiv = $('#case_query');
    table.empty();
    
    if (queries && queries.length > 0) {
        caseQueryDiv.removeClass('d-none');
        queries.forEach((query, index) => {
            table.append(`
                <tr>
                    <td>${index + 1}</td>
                    <td><small>${query.reasons || ''}</small></td>
                    <td><small>${query.query_response || ''}</small></td>
                    <td>${query.created_date || ''}</td>
                </tr>
            `);
        });
    } else {
        caseQueryDiv.addClass('d-none');
    }
}

// Modified populateApplicationDetails for modal
function populateApplicationDetailsForModal(details, jobNumber) {
    if (!details || details.length === 0) {
        $("#submitted_by_text").html('<span class="text-muted">-</span>');
        $("#sub_service_text").html('<span class="text-muted">-</span>');
        $("#date_created_text").html('<span class="text-muted">-</span>');
        $("#job_number_text").text(jobNumber || '-');
        $("#status_text").html('<span class="text-muted">-</span>');
        $("#main_service_text").html('<span class="text-muted">-</span>');
        return;
    }
    
    const detail = details[0];
    
    $("#submitted_by_text").html(detail.client_name || '<span class="text-muted">-</span>');
    $("#sub_service_text").html(detail.business_process_sub_name || '<span class="text-muted">-</span>');
    $("#date_created_text").html(detail.created_date || '<span class="text-muted">-</span>');
    $("#job_number_text").text(jobNumber || '-');
    $("#status_text").html(detail.job_status || '<span class="text-muted">-</span>');
    $("#main_service_text").html(detail.business_process_name || '<span class="text-muted">-</span>');
}

// Modified updatePriorityField for modal
function updatePriorityFieldForModal(reminderPercentage, queryStatus, isCompleted) {
    let priority = 'Low';
    let badgeClass = 'bg-success';
    
    if (isCompleted) {
        priority = 'Low';
        badgeClass = 'bg-success';
    } else if (reminderPercentage > 100 && queryStatus == "0") {
        priority = 'Urgent';
        badgeClass = 'bg-danger';
    } else if (reminderPercentage > 70 && reminderPercentage <= 100 && queryStatus == "0") {
        priority = 'High';
        badgeClass = 'bg-warning';
    } else if (reminderPercentage > 50 && reminderPercentage <= 70 && queryStatus == "0") {
        priority = 'Medium';
        badgeClass = 'bg-info';
    }
    
    $('#priority_status').html(`<span class="badge ${badgeClass}">${priority}</span>`);
}

// Also add this event listener for dynamically created track buttons
// $(document).on('click', '.track-btn', function() {
//     const jobNumber = $(this).data('job');
//     if (jobNumber) {
//         trackApplication(jobNumber);
//     } else {
//         Swal.fire({
//             icon: 'warning',
//             title: 'No Job Number',
//             text: 'Job number is missing.',
//             confirmButtonColor: '#3085d6'
//         });
//     }
// });

// function trackApplication(jobNumber) {
//     console.log('Tracking application:', jobNumber);
//     // Your tracking logic here
//     Swal.fire({
//         icon: 'info',
//         title: 'Tracking Application',
//         text: `Would open tracking for job number: ${jobNumber}`,
//         confirmButtonColor: '#3085d6'
//     });
// }

function updateBadgeCounts() {
    const milestonesCount = $('#app-tracking tbody tr').not('.no-data').length;
    // const commentsCount = $('#cabinet-tracking tbody tr').not('.no-data').length;
    // const queriesCount = $('#case-query tbody tr').not('.no-data').length;
    // const smsCount = $('#sms-tracking tbody tr').not('.no-data').length;
    
    $('#milestonesCount').text(milestonesCount);
    // $('#commentsCount').text(commentsCount);
    // $('#queriesCount').text(queriesCount);
    // $('#smsCount').text(smsCount);
}

// Expand all sections
function expandAllSections() {
    const accordion = new bootstrap.Collapse(document.getElementById('milestonesCollapse'), { toggle: false });
    accordion.show();
    
    const accordion2 = new bootstrap.Collapse(document.getElementById('commentsCollapse'), { toggle: false });
    accordion2.show();
    
    const accordion3 = new bootstrap.Collapse(document.getElementById('queriedCollapse'), { toggle: false });
    accordion3.show();
    
    const accordion4 = new bootstrap.Collapse(document.getElementById('smsCollapse'), { toggle: false });
    accordion4.show();
}

// Collapse all sections
function collapseAllSections() {
    const accordion = new bootstrap.Collapse(document.getElementById('milestonesCollapse'), { toggle: false });
    accordion.hide();
    
    const accordion2 = new bootstrap.Collapse(document.getElementById('commentsCollapse'), { toggle: false });
    accordion2.hide();
    
    const accordion3 = new bootstrap.Collapse(document.getElementById('queriedCollapse'), { toggle: false });
    accordion3.hide();
    
    const accordion4 = new bootstrap.Collapse(document.getElementById('smsCollapse'), { toggle: false });
    accordion4.hide();
}

// Also update the existing trackApplication function to use the new approach:
function trackApplication(jobNumber) {
    loadAndShowTrackingModal(jobNumber);
}

// Main initialization
$(document).ready(function() {
    // Initialize Select2 for all select elements
    initializeSelect2();
    
    // Hide enquiry tab initially
    $("#enquiry_tab").hide();
    
    // Setup modal event handlers
    setupModalHandlers();
    
    // Setup form submissions
    setupFormSubmissions();
    
    // Setup tracking modal
    setupTrackingModal();
    
    // Setup cabinet modal
    setupCabinetModal();
});

// Initialize Select2
function initializeSelect2() {
    $('.select2').select2({
        theme: 'bootstrap-5',
        width: '100%',
        placeholder: '-- select --',
        allowClear: true
    });
    
    // Reinitialize Select2 when dynamic content is loaded
    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field')?.focus();
    });
}

// Setup modal handlers
function setupModalHandlers() {
    // Add Ticket Modal
    $("#addTicketModal").on('shown.bs.modal', function() {
        const name = $('input[name="complainant_name"]').val();
        const email = $('input[name="complainant_email"]').val();
        const phone = $('input[name="complainant_phone"]').val();
        
        $('input[name="ticket_name"]').val(name);
        $('input[name="ticket_email"]').val(email);
        $('input[name="ticket_tel"]').val(phone);
    });
}

// Setup form submissions
function setupFormSubmissions() {
    // Ticket Form
    $("#ticketForm").on('submit', function(e) {
        e.preventDefault();
        submitTicketForm();
    });
    
    // CICA Client Form
    $('#cicaClientForm').on('submit', function(e) {
        e.preventDefault();
        submitCicaClientForm();
    });
}

// Setup tracking modal
function setupTrackingModal() {
    $('#trackingModal').on('show.bs.modal', function(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        if (!jobNumber) return;
        
        // Clear existing data
        clearTrackingTables();
        clearTrackingFields();
        
        // Set reference ID
        $('input[name="reference_id"]').val(jobNumber);
        
        // Load tracking data
        loadTrackingData(jobNumber);
    });
}

// Setup cabinet modal
function setupCabinetModal() {
    $('#cabinetModal').on('show.bs.modal', function(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        if (!jobNumber) return;
        
        loadCabinetDetails(jobNumber);
    });
}

// Clear tracking tables
function clearTrackingTables() {
    const tables = [
        '#app-tracking tbody',
        '#cabinet-tracking tbody', 
        '#case-query tbody',
        '#sms-tracking tbody',
        '#lc_public_documents_dataTable tbody'
    ];
    
    tables.forEach(selector => {
        $(selector).empty();
    });
}

// Clear tracking fields
function clearTrackingFields() {
    const fields = [
        '#submitted_by_text', '#sub_service_text', '#date_created_text',
        '#job_number_text', '#status_text', '#main_service_text',
        '#app_status', '#days_passed', '#priority_status'
    ];
    
    fields.forEach(selector => {
        $(selector).html('<span class="text-muted">-</span>');
    });
    
    $('#job_number_text').text('-');
}

// Load tracking data
async function loadTrackingData(jobNumber) {
    try {
        // Load cabinet details first
        const cabinetData = await loadCabinetDetailsForTracking(jobNumber);
        const cabinetStatus = cabinetData?.cabinet_tracking?.[cabinetData.cabinet_tracking.length - 1]?.officers_general_comments || '';
        
        // Load milestone data
        await loadMilestoneData(jobNumber, cabinetStatus);
        
    } catch (error) {
        console.error('Error loading tracking data:', error);
        showError('Failed to load tracking data');
    }
}

// Load cabinet details for tracking
function loadCabinetDetailsForTracking(jobNumber) {
    return new Promise((resolve, reject) => {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_cabinet_details_by_job_number',
                job_number: jobNumber
            },
            success: function(response) {
                try {
                    const data = JSON.parse(response);
                    const table = $('#cabinet-tracking');
                    table.find("tbody tr").remove();
                    
                    if (data.cabinet_tracking) {
                        data.cabinet_tracking.forEach(item => {
                            table.append(`
                                <tr>
                                    <td>${item.officers_general_comments || ''}</td>
                                    <td>${item.division || ''}</td>
                                    <td>${item.created_by || ''}</td>
                                    <td>${item.created_date || ''}</td>
                                </tr>
                            `);
                        });
                    }

                    
                    
                    resolve(data);
                } catch (e) {
                    reject(e);
                }
            },
            error: reject
        });
    });
}

// Load milestone data
async function loadMilestoneData(jobNumber, cabinetStatus) {
    try {
        const response = await $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_milestone_for_tracking_by_job',
                job_number: jobNumber
            }
        });
        
        const data = JSON.parse(response);
        processMilestoneData(data, cabinetStatus, jobNumber);
        
    } catch (error) {
        console.error('Error loading milestone data:', error);
        throw error;
    }
}

// Process milestone data
function processMilestoneData(data, cabinetStatus, jobNumber) {
    // Set case number
    const caseNumber = data.application_details?.[0]?.case_number || '';
    $("#cs_main_case_number").val(caseNumber);
    
    // Calculate status
    const purpose = parseInt($('#purpose').val());
    const queryStatus = data.case_query?.[0]?.status || "0";
    const isCompleted = cabinetStatus.includes('cabinet') || cabinetStatus.includes('collected');
    
    // Calculate days passed
    const createdDate = data.application_details?.[0]?.created_date;
    const daysPassed = calculateBusinessDaysPassed(createdDate);
    
    // Calculate total required days
    const totalRequiredDays = data.milestones?.reduce((sum, milestone) => 
        sum + parseFloat(milestone.working_day_required || 0), 0) || 0;
    
    // Calculate reminder percentage
    const reminderPercentage = totalRequiredDays > 0 ? (daysPassed / totalRequiredDays) * 100 : 0;
    
    // Determine application status
    const appStatus = determineAppStatus(isCompleted, queryStatus, reminderPercentage);
    
    // Update UI
    updateAppStatusUI(appStatus, daysPassed);
    updateFormFields(purpose, isCompleted, queryStatus, reminderPercentage, jobNumber, daysPassed);
    updatePriorityField(reminderPercentage, queryStatus, isCompleted);
    
    // Populate milestones table
    populateMilestonesTable(data.milestones, data.application_stage);
    
    // Populate notifications
    populateNotifications(data.notifications);
    
    // Populate case queries
    populateCaseQueries(data.case_query);
    
    // Populate application details
    populateApplicationDetails(data.application_details, jobNumber);
}

// Calculate business days passed
function calculateBusinessDaysPassed(createdDate) {
    if (!createdDate) return 0;
    
    const startDate = new Date(createdDate.replace(/-/g, "/"));
    const today = new Date();
    
    let count = 0;
    const current = new Date(startDate);
    
    while (current <= today) {
        const day = current.getDay();
        if (day !== 0 && day !== 6) { // Skip weekends
            count++;
        }
        current.setDate(current.getDate() + 1);
    }
    
    return count;
}

// Determine application status
function determineAppStatus(isCompleted, queryStatus, reminderPercentage) {
    if (isCompleted) return "Completed";
    if (queryStatus == "1") return "Queried";
    if (reminderPercentage <= 0) return "Within Time Frame";
    return "Delayed";
}

// Update application status UI
function updateAppStatusUI(appStatus, daysPassed) {
    $('#app_status').text(appStatus);
    $('#days_passed').text(daysPassed);
}

// Update form fields based on status
function updateFormFields(purpose, isCompleted, queryStatus, reminderPercentage, jobNumber, daysPassed) {
    const purposeElement = $('#purpose');
    const currentPurpose = purpose || parseInt(purposeElement.val());
    
    let html = '';
    
    if (currentPurpose === 1) { // Service Enquiry
        if (isCompleted) {
            $('#within_time_frame').val(1);
            html = getMilestoneStatusHTML();
        } else if (queryStatus == "1") {
            $('#within_time_frame').val(0);
            html = getQueriedFormHTML(jobNumber);
        } else if (reminderPercentage <= 0) {
            $('#within_time_frame').val(1);
            html = getMilestoneStatusHTML();
        } else if (reminderPercentage > 0 && queryStatus == "0") {
            $('#within_time_frame').val(0);
            html = getDelayedFormHTML(jobNumber, daysPassed);
        }
    }

    if ((purpose == 1 || purpose == 3) && queryStatus == "0") {
        $('textarea[name="description"]').val('Application pending for ' + daysPassed + ' days since submission.');
    }

    if(isCompleted == true){
        $('#priority').val('Low')
        $('#case_query').addClass('d-none');
    }
    else if(reminderPercentage > 100 && queryStatus == "0") {
        $('#priority').val('Urgent')
        $('#case_query').addClass('d-none');
    }

    else if(reminderPercentage > 70 && reminderPercentage <= 100 && queryStatus == "0") {
        $('#priority').val('High')
        $('#case_query').addClass('d-none');
    }

    else if(reminderPercentage > 50 && reminderPercentage <= 70 && queryStatus == "0") {
        $('#priority').val('Medium')
        $('#case_query').addClass('d-none');
    }

    else {
        $('#priority').val('Low')
    }
    
    // Update tab_extra2 with generated HTML
    const tabExtra2 = document.getElementById("dynamic-fields-container");
    if (tabExtra2) {
        tabExtra2.innerHTML = html;
        $("#submitBtn").prop('disabled', false);
        
        // Reinitialize Select2 for new select elements
        // setTimeout(() => initializeSelect2(), 100);
    }
}

// Get milestone status HTML
function getMilestoneStatusHTML() {
    return `
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">
                Provide Milestone Status <span class="text-danger">*</span>
            </label>
            <div class="col-sm-8">
                <textarea class="form-control" name="milestone_status" id="milestone_status" required></textarea>
            </div>
        </div>`;
}

// Get queried form HTML
function getQueriedFormHTML(jobNumber) {
    return `
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Subject <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <select class="form-select select2" name="subject" id="subject" required>
                    <option value="" disabled>--select--</option>
                    <option value="Payment Issues">Payment Issues</option>
                    <option value="Delayed">Delayed</option>
                    <option value="Upload issues">Upload issues</option>
                    <option value="Queried" selected>Queried</option>
                    <option value="Other Issues">Other Issues</option>
                </select>
            </div>
        </div>
        ${getComplaintFormHTML(jobNumber)}`;
}

// Get delayed form HTML
function getDelayedFormHTML(jobNumber, daysPassed) {
    return `
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Subject <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <select class="form-select select2" name="subject" id="subject" required>
                    <option value="" disabled>--select--</option>
                    <option value="Payment Issues">Payment Issues</option>
                    <option value="Delayed" selected>Delayed</option>
                    <option value="Upload issues">Upload issues</option>
                    <option value="Queried">Queried</option>
                    <option value="Other Issues">Other Issues</option>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Description <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <textarea class="form-control" name="description" id="description" required>Application pending for ${daysPassed} days since submission.</textarea>
            </div>
        </div>
        ${getComplaintFormHTML(jobNumber)}`;
}

// Get generic complaint form HTML
function getComplaintFormHTML(jobNumber) {
    return `
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Contact Client by <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <select class="form-select select2" name="contact_type" id="contact_type" required>
                    <option value="" disabled>-- select --</option>
                    <option value="SMS">SMS</option>
                    <option value="Email">Email</option>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Priority <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <input class="form-control" type="text" value="Urgent" name="priority" id="priority" required readonly>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Division <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <select class="form-select select2" name="division" id="division" required>
                    <option value="" disabled>-- select --</option>
                    <option value="PVLMD">PVLMD</option>
                    <option value="LRD">LRD</option>
                    <option value="LVD">LVD</option>
                    <option value="SMD">SMD</option>
                    <option value="CORPORATE">CORPORATE</option>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Region <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <select class="form-select select2" name="region" id="region" required>
                    <option value="" disabled>-- select --</option>
                    ${getRegionOptions()}
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Related Service <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <select class="form-select select2" name="related_service" id="related_service" required>
                    <option value="" disabled>-- select --</option>
                    ${getServiceOptions()}
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-semibold">Reference No. <span class="text-danger">*</span></label>
            <div class="col-sm-8">
                <input type="text" class="form-control" name="reference_id" id="reference_id" value="${jobNumber}" required>
            </div>
        </div>`;
}

// Get region options
function getRegionOptions() {
    const regions = [
        {value: "11", label: "Greater Accra"},
        {value: "14", label: "Western"},
        {value: "19", label: "Volta"},
        {value: "12", label: "Eastern"},
        {value: "13", label: "Ashanti"},
        {value: "15", label: "Central"},
        {value: "18", label: "Northern"},
        {value: "16", label: "Upper East"},
        {value: "17", label: "Upper West"},
        {value: "10", label: "Tema"},
        {value: "22", label: "Oti"},
        {value: "23", label: "Bono East"},
        {value: "24", label: "Ahafo"},
        {value: "20", label: "Bono"},
        {value: "25", label: "North East"},
        {value: "26", label: "Savannah"},
        {value: "21", label: "Western North"}
    ];
    
    return regions.map(region => 
        `<option value="${region.value}">${region.label}</option>`
    ).join('');
}

// Get service options
function getServiceOptions() {
    const services = [
        "Search", "Stamp Duty", "Concurrence", "Consent", "Plan Approval",
        "Title Registration", "PVLMD Plotting", "Reguralization",
        "Certified True Copy", "Dispute", "Composite Plan", "General Valuation",
        "Compensation", "Deed Registration", "Substituted Certificate",
        "State Land Rent", "Other Services"
    ];
    
    return services.map(service => 
        `<option value="${service}">${service}</option>`
    ).join('');
}

// Update priority field
function updatePriorityField(reminderPercentage, queryStatus, isCompleted) {
    let priority = 'Low';
    
    if (isCompleted) {
        priority = 'Low';
    } else if (reminderPercentage > 100 && queryStatus == "0") {
        priority = 'Urgent';
    } else if (reminderPercentage > 70 && reminderPercentage <= 100 && queryStatus == "0") {
        priority = 'High';
    } else if (reminderPercentage > 50 && reminderPercentage <= 70 && queryStatus == "0") {
        priority = 'Medium';
    }
    
    $('#priority').val(priority);
}

// Populate milestones table
function populateMilestonesTable(milestones, currentStage) {
    const table = $('#app-tracking');
    table.find("tbody tr").remove();
    
    if (!milestones) return;
    
    milestones.forEach((milestone, index) => {
        const milestoneNum = index + 1;
        const priorityValue = parseInt(milestone.priority_value || 0);
        const appStage = parseInt(currentStage || 0);
        
        let status, cssClass;
        
        if (priorityValue < appStage) {
            status = "Completed";
            cssClass = "bg-success text-dark";
        } else if (priorityValue == appStage) {
            status = "Ongoing";
            cssClass = "bg-info text-dark";
        } else {
            status = "Not Completed";
            cssClass = "bg-danger text-light";
        }
        
        table.append(`
            <tr class="${cssClass}">
                <td>${milestoneNum}</td>
                <td>${milestone.milestone_description || ''}</td>
                <td>${status}</td>
                <td class="text-center">${milestone.working_day_required || ''}</td>
            </tr>
        `);
    });
}

// Populate notifications
function populateNotifications(notifications) {
    const table = $('#sms-tracking');
    if (!notifications) return;
    
    notifications.forEach((notification, index) => {
        table.append(`
            <tr>
                <td>${index + 1}</td>
                <td>${notification.sms_message || ''}</td>
                <td>${notification.sms_date_sent || ''}</td>
            </tr>
        `);

         $('#smsCount').text(notifications.length);
    });
}

// Populate case queries
function populateCaseQueries(queries) {
    const table = $('#case-query');
    const caseQueryDiv = $('#case_query');
    
    if (queries && queries.length > 0) {
        caseQueryDiv.removeClass('d-none');
        queries.forEach((query, index) => {
            table.append(`
                <tr>
                    <td>${index + 1}</td>
                    <td>${query.reasons || ''}</td>
                    <td>${query.query_response || ''}</td>
                    <td>${query.created_date || ''}</td>
                </tr>
            `);
        });

        $('#queriesCount').text(queries.length);
    } else {
        caseQueryDiv.addClass('d-none');
    }
}

// Populate application details
function populateApplicationDetails(details, jobNumber) {
    if (!details || details.length === 0) return;
    
    const detail = details[0];
    
    $("#submitted_by_text").html(detail.client_name || '');
    $("#sub_service_text").html(detail.business_process_sub_name || '');
    $("#date_created_text").html(detail.created_date || '');
    $("#job_number_text").html(jobNumber || '');
    $("#status_text").html(detail.job_status || '');
    $("#main_service_text").html(detail.business_process_name || '');
}

// Load cabinet details
function loadCabinetDetails(jobNumber) {
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'load_application_cabinet_details_by_job_number',
            job_number: jobNumber
        },
        success: function(response) {
            try {
                const data = JSON.parse(response);
                const table = $('#cabinet-tracking');
                table.find("tbody tr").remove();
                
                // Populate cabinet tracking
                if (data.cabinet_tracking) {
                    data.cabinet_tracking.forEach(item => {
                        table.append(`
                            <tr>
                                <td>${item.officers_general_comments || ''}</td>
                                <td>${item.division || ''}</td>
                                <td>${item.created_by || ''}</td>
                                <td>${item.created_date || ''}</td>
                            </tr>
                        `);
                    });
                }
                
                // Populate cabinet data
                if (data.cabinet_data) {
                    data.cabinet_data.forEach(item => {
                        $("#enq_applicant_name").val(item.ar_name || '');
                        $("#enq_applicant_type").val(item.business_process_sub_name || '');
                        $("#enq_cabinet_name").val(item.file_number || '');
                        $("#enq_job_purpose").val(item.job_purpose || '');
                        $("#enq_job_status").val(item.job_status || '');
                        $("#enq_current_application_status").val(item.current_application_status || '');
                    });
                }
            } catch (e) {
                console.error('Error parsing cabinet details:', e);
            }
        },
        error: function() {
            console.error('Error loading cabinet details');
        }
    });
}

// Submit ticket form
function submitTicketForm() {
    const submitBtn = $("#save_btn");
    submitBtn.prop('disabled', true).text("Please wait ...");
    
    // Validate required fields
    // if (!$('input[name="ticket_name"]').val()) {
    //     Swal.fire({
    //         icon: 'warning',
    //         title: 'Input Required',
    //         text: 'Please enter complainant name',
    //         timer: 2000,
    //         showConfirmButton: false
    //     });
    //     submitBtn.prop('disabled', false).text("Save");
    //     return false;
    // }

    // if (!$('#contact_type').find(":selected").val()) {
    //     Swal.fire({
    //         icon: 'warning',
    //         title: 'Input Required',
    //         text: 'Please select contact type',
    //         timer: 2000,
    //         showConfirmButton: false
    //     });
    //     submitBtn.prop('disabled', false).text("Save");
    //     return false;
    // }

    // Show loading indicator
    Swal.fire({
        title: 'Submitting Ticket...',
        text: 'Please wait while your ticket is being processed',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
    
    const formData = {
        request_type: 'open_ticket',
        complainant_name: $('input[name="ticket_name"]').val(),
        complainant_phone: $('input[name="ticket_tel"]').val(),
        complainant_email: $('input[name="ticket_email"]').val(),
        subject: $('input[name="subject"]').val(),
        description: $('#description').val(),
        contact_type: $('#contact_type').find(":selected").text(),
        complaint_type: $('#complaint_type').find(":selected").text(),
        priority: $('#priority').find(":selected").text(),
        related_service: $('#related_service').find(":selected").text(),
        service_number: $('input[name="service_number"]').val(),
        request_by: $('input[name="request_by"]').val(),
        request_by_id: $('input[name="request_by_id"]').val()
    };
    
    $.ajax({
        type: "POST",
        url: "clients_serv",
        data: formData,
        success: function(response) {
            try {
                const jsonResult = JSON.parse(response);
                
                // Close loading
                Swal.close();
                
                if (jsonResult.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Ticket Added Successfully',
                        timer: 1500,
                        showConfirmButton: false
                    });
                    
                    $("#addTicketModal").find('form').trigger('reset');
                    $("#addTicketModal").modal('hide');
                    
                    // Optional: Refresh the ticket list if needed
                    setTimeout(function() {
                        location.reload();
                    }, 1500);
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error Adding Ticket',
                        timer: 2000,
                        showConfirmButton: false
                    });
                }
            } catch (e) {
                Swal.close();
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error processing response',
                    timer: 2000,
                    showConfirmButton: false
                });
                console.error('Parse error:', e);
            }
        },
        error: function(xhr, status, error) {
            Swal.close();
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Error submitting ticket',
                timer: 2000,
                showConfirmButton: false
            });
            console.error('AJAX Error:', error);
        },
        complete: function() {
            submitBtn.prop('disabled', false).text("Save");
        }
    });
}

// Submit CICA client form
function submitCicaClientForm() {
    // Add your CICA client form submission logic here
    console.log('CICA Client Form submitted');
}

// Utility functions
function showError(message) {
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: message,
        timer: 3000,
        showConfirmButton: true,
        confirmButtonText: 'OK',
        confirmButtonColor: '#d33'
    });
}

function showSuccess(message) {
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: message,
        timer: 2000,
        showConfirmButton: false,
        timerProgressBar: true
    });
}

// Purpose change handler (if not already in your code)
$('#purpose').on('change', function() {
    const purpose = $(this).val();
    
    // Show/hide enquiry tab based on purpose
    if (purpose == "1" || purpose == "3") {
        $("#enquiry_tab").show();
    } else {
        $("#enquiry_tab").hide();
    }
    
    // Update dynamic fields
    updateDynamicFields(purpose);
});

// Function to update dynamic fields based on purpose
function updateDynamicFields(purpose) {
    // Add your dynamic field update logic here
    console.log('Purpose changed to:', purpose);
}