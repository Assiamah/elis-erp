$(document).ready(function() {
    
    // ==================== CONSTANTS & CONFIG ====================
    const AJAX_CONFIG = {
        type: "POST",
        url: "Case_Management_Serv",
        cache: false,
        dataType: 'json',
        timeout: 30000
    };

    const NOTIFICATION_CONFIG = {
        z_index: 9999,
        allow_dismiss: true,
        delay: 5000
    };

    // ==================== UTILITY FUNCTIONS ====================
    
    /**
     * Show notification using SweetAlert2 (preferred)
     */
    function showNotification(message, type = 'error', title = '') {
        const config = {
            icon: type,
            title: title || getTitleForType(type),
            text: message,
            confirmButtonColor: getColorForType(type),
            timer: type === 'success' ? 3000 : undefined,
            timerProgressBar: type === 'success'
        };
        
        Swal.fire(config);
    }
    
    function getTitleForType(type) {
        const titles = {
            'success': 'Success!',
            'error': 'Error!',
            'warning': 'Warning!',
            'info': 'Information'
        };
        return titles[type] || 'Notification';
    }
    
    function getColorForType(type) {
        const colors = {
            'success': '#28a745',
            'error': '#dc3545',
            'warning': '#ffc107',
            'info': '#17a2b8'
        };
        return colors[type] || '#007bff';
    }

    /**
     * Show loading state
     */
    function showLoading(message = 'Loading...') {
        Swal.fire({
            title: message,
            allowOutsideClick: false,
            allowEscapeKey: false,
            showConfirmButton: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
    }

    /**
     * Hide loading
     */
    function hideLoading() {
        Swal.close();
    }

    /**
     * Validate search input
     */
    function validateSearch(value, type, minLength = 8) {
        if (!value || value.length < minLength) {
            showNotification(
                `Please enter ${minLength} or more characters to search`,
                'warning',
                'Invalid Input'
            );
            return false;
        }
        
        if (!type || type.length === 0) {
            showNotification(
                'Please select the type of field for your search',
                'warning',
                'Selection Required'
            );
            return false;
        }
        
        return true;
    }

    // ==================== SEARCH FORM HANDLER ====================
    
    $('#frmCCJobSearch').on('submit', function(e) {
        e.preventDefault();
        
        // Get form values
        const selectedRadio = $("input[name='rbtn_search_type']:checked");
        const searchType = selectedRadio.length > 0 ? selectedRadio.val() : '';
        const searchValue = $("#cc_search_value").val().trim();
        
        console.log('Search Type:', searchType);
        console.log('Search Value:', searchValue);
        
        // Validate input
        if (!validateSearch(searchValue, searchType, 8)) {
            return;
        }
        
        // Hide previous results
        $("#cc-search-results-section").hide();
        
        // Show loading
        //showLoading('Searching applications...');
        
        // Make AJAX request
        $.ajax({
            ...AJAX_CONFIG,
            data: {
                request_type: 'load_application_details_for_enquiries',
                job_number: searchValue,
                search_type: searchType
            },
            success: function(response) {
                hideLoading();
                
                console.log('Search Response:', response);
                
                // Parse response if needed
                let data = typeof response === 'string' ? JSON.parse(response) : response;
                
                // Clear and populate table
                const table = $('#cc-search-results-table tbody');
                table.empty();
                
                if (data && data.length > 0) {
                    $("#cc-search-results-section").show();
                    
                    // Update result count
                    $('#result_count').text(`Found ${data.length} matching application(s)`);
                    
                    // Loop through results
                    $.each(data, function(index, item) {
                        const row = createSearchResultRow(item, index + 1);
                        table.append(row);
                    });
                    
                    // Initialize tooltips for new buttons
                    initializeTooltips();
                    
                } else {
                    table.append(createEmptyResultRow());
                    showNotification('No results found', 'info', 'Search Complete');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('Search Error:', error);
                showNotification('Failed to search applications. Please try again.', 'error');
                
                // Show error in table
                const table = $('#cc-search-results-table tbody');
                table.empty().append(createErrorRow());
                $("#cc-search-results-section").show();
            }
        });
    });

    /**
     * Create search result row
     */
    function createSearchResultRow(item, index) {
        return `
            <tr>
                <td class="px-3 py-2">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-circle text-primary me-2"></i>
                        ${escapeHtml(item.ar_name || 'N/A')}
                    </div>
                </td>
                <td class="px-3 py-2">
                    <span class="badge bg-light text-dark">${escapeHtml(item.job_number || 'N/A')}</span>
                </td>
                <td class="px-3 py-2">${escapeHtml(item.locality || 'N/A')}</td>
                <td class="px-3 py-2">${escapeHtml(item.regional_number || 'N/A')}</td>
                <td class="px-3 py-2">
                    ${formatStatus(item.current_application_status)}
                </td>
                <td class="px-3 py-2 text-center">
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-primary dropdown-toggle" 
                                type="button" data-bs-toggle="dropdown">
                            <i class="bi bi-gear me-1"></i>Actions
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" style="min-width: 200px;">
                            <li>
                                <button class="dropdown-item track-application" 
                                        data-job-number="${escapeHtml(item.job_number)}"
                                        data-bs-toggle="modal" 
                                        data-bs-target="#trackingModal">
                                    <i class="bi bi-hdd-stack me-2 text-primary"></i>
                                    Track Application
                                </button>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="front_office_view_application" method="post">
                                    <input type="hidden" name="case_number" value="${escapeHtml(item.transaction_number || '')}">
                                    <input type="hidden" name="job_number" value="${escapeHtml(item.job_number || '')}">
                                    <input type="hidden" name="search_text" value="${escapeHtml(item.case_number || '')}">
                                    <button type="submit" class="dropdown-item">
                                        <i class="bi bi-info-circle me-2 text-info"></i>
                                        Application Details
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        `;
    }

    /**
     * Format status with badge
     */
    function formatStatus(status) {
        const statusMap = {
            'completed': 'success',
            'pending': 'warning',
            'processing': 'info',
            'rejected': 'danger'
        };
        
        const statusClass = statusMap[status?.toLowerCase()] || 'secondary';
        return `<span class="badge bg-${statusClass}">${escapeHtml(status || 'Unknown')}</span>`;
    }

    /**
     * Create empty result row
     */
    function createEmptyResultRow() {
        return `
            <tr>
                <td colspan="6" class="text-center py-5">
                    <i class="bi bi-inbox fs-1 text-muted d-block mb-3"></i>
                    <h6 class="text-muted">No Results Found</h6>
                    <p class="text-muted small">Try adjusting your search criteria</p>
                </td>
            </tr>
        `;
    }

    /**
     * Create error row
     */
    function createErrorRow() {
        return `
            <tr>
                <td colspan="6" class="text-center py-5 text-danger">
                    <i class="bi bi-exclamation-triangle fs-1 d-block mb-3"></i>
                    <h6>Error Loading Results</h6>
                    <p class="small">Please try again or contact support</p>
                </td>
            </tr>
        `;
    }

    /**
     * Escape HTML to prevent XSS
     */
    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    /**
     * Initialize Bootstrap tooltips
     */
    function initializeTooltips() {
        const tooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        tooltips.forEach(el => new bootstrap.Tooltip(el));
    }

    // ==================== TRACKING MODAL HANDLER ====================
    
    $('#trackingModal').on('show.bs.modal', function(event) {
        const button = $(event.relatedTarget);
        const jobNumber = button.data('job-number');
        
        console.log('Tracking Job:', jobNumber);
        
        if (!jobNumber) {
            showNotification('Job number is missing', 'error');
            return;
        }
        
        // Clear previous data
        $('#cabinet-tracking tbody').empty();
        $('#sms-tracking tbody').empty();
        
        // Reset form fields
        $('#enq_applicant_name, #enq_applicant_type, #enq_cabinet_name, #enq_job_status').val('');
        
        //showLoading('Loading tracking information...');
        
        $.ajax({
            ...AJAX_CONFIG,
            data: {
                request_type: 'load_application_milestone_for_tracking_by_job',
                job_number: jobNumber
            },
            success: function(response) {
                hideLoading();
                
                let data = typeof response === 'string' ? JSON.parse(response) : response;
                console.log('Tracking Data:', data);
                
                // Process milestones
                if (data.milestones && data.milestones.length) {
                    $.each(data.milestones, function(index, milestone) {
                        const row = createMilestoneRow(milestone, index + 1, data.application_stage);
                        $('#cabinet-tracking tbody').append(row);
                    });
                }
                
                // Process SMS notifications
                if (data.notifications && data.notifications.length) {
                    $.each(data.notifications, function(index, notification) {
                        const row = createSmsRow(notification, index + 1);
                        $('#sms-tracking tbody').append(row);
                    });
                }
                
                // Process application details
                if (data.application_details && data.application_details.length) {
                    const details = data.application_details[0];
                    $('#submitted_by_text').text(details.client_name || '-');
                    $('#sub_service_text').text(details.business_process_sub_name || '-');
                    $('#date_created_text').text(formatDate(details.created_date));
                    $('#job_number_text').text(jobNumber);
                    $('#status_text').text(details.job_status || '-');
                    $('#main_service_text').text(details.business_process_name || '-');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('Tracking Error:', error);
                showNotification('Failed to load tracking information', 'error');
            }
        });
    });

    /**
     * Create milestone row
     */
    function createMilestoneRow(milestone, index, currentStage) {
        const priority = parseInt(milestone.priority_value);
        const stage = parseInt(currentStage);
        
        let rowClass = '';
        let statusText = '';
        
        if (priority < stage) {
            rowClass = 'table-success';
            statusText = 'Completed';
        } else if (priority === stage) {
            rowClass = 'table-info';
            statusText = 'Ongoing';
        } else {
            rowClass = 'table-danger';
            statusText = 'Not Completed';
        }
        
        return `
            <tr class="${rowClass}">
                <td class="px-3 py-2">${index}</td>
                <td class="px-3 py-2">${escapeHtml(milestone.milestone_description)}</td>
                <td class="px-3 py-2">
                    <span class="badge bg-${priority < stage ? 'success' : (priority === stage ? 'info' : 'danger')}">
                        ${statusText}
                    </span>
                </td>
            </tr>
        `;
    }

    /**
     * Create SMS notification row
     */
    function createSmsRow(notification, index) {
        return `
            <tr>
                <td class="px-3 py-2">${index}</td>
                <td class="px-3 py-2">${escapeHtml(notification.sms_message)}</td>
                <td class="px-3 py-2">${formatDate(notification.sms_date_sent)}</td>
            </tr>
        `;
    }

    /**
     * Format date
     */
    function formatDate(dateString) {
        if (!dateString) return '-';
        try {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-GB', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return dateString;
        }
    }

    // ==================== APPLICANT DETAILS HANDLER ====================
    
    $('#frmEnquiryApplicantDetails').on('submit', function(e) {
        e.preventDefault();
        
        const jobNumber = $("#hpl_job_number").val().trim();
        
        if (!jobNumber || jobNumber.length < 4) {
            showNotification('Please enter 4 or more characters to search', 'warning', 'Invalid Input');
            return;
        }
        
       // showLoading('Loading applicant details...');
        
        $.ajax({
            ...AJAX_CONFIG,
            data: {
                request_type: 'load_applicant_details_by_job_number',
                job_number: jobNumber
            },
            success: function(response) {
                hideLoading();
                
                let data = typeof response === 'string' ? JSON.parse(response) : response;
                console.log('Applicant Details:', data);
                
                if (data && data.data) {
                    displayApplicantDetails(data.data[0], jobNumber);
                } else {
                    showNotification('No details found for this job', 'info');
                    $('#tbl_applicant_details_section').addClass('d-none');
                    $('#applicant_empty_state').removeClass('d-none');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('Applicant Details Error:', error);
                showNotification('Failed to load applicant details', 'error');
            }
        });
    });

    /**
     * Display applicant details
     */
    function displayApplicantDetails(applicant, jobNumber) {
        const html = `
            <div class="card bg-light border-0">
                <div class="card-body">
                    <h6 class="border-bottom pb-2 mb-3">
                        <i class="bi bi-person-circle me-2 text-primary"></i>
                        Current Applicant Details
                        <small class="text-muted ms-2">Job: ${escapeHtml(jobNumber)}</small>
                    </h6>
                    <table class="table table-sm table-borderless">
                        <tr>
                            <th class="text-muted ps-0" width="100">Name:</th>
                            <td class="fw-semibold">${escapeHtml(applicant.ar_name || '-')}</td>
                        </tr>
                        <tr>
                            <th class="text-muted ps-0">Phone:</th>
                            <td>${escapeHtml(applicant.phone || '-')}</td>
                        </tr>
                        <tr>
                            <th class="text-muted ps-0">Email:</th>
                            <td>${escapeHtml(applicant.email || '-')}</td>
                        </tr>
                    </table>
                </div>
            </div>
        `;
        
        $('#tbl_applicant_details_section').html(html).removeClass('d-none');
        $('#applicant_empty_state').addClass('d-none');
    }

    // ==================== BATCHLIST HANDLER ====================
    
    $('#frmEnquiryBatchlist').on('submit', function(e) {
        e.preventDefault();
        
        const batchValue = $("#enq_batchlist").val().trim();
        
        if (!batchValue || batchValue.length < 4) {
            showNotification('Please enter 4 or more characters to search', 'warning', 'Invalid Input');
            return;
        }
        
       // showLoading('Loading batchlist...');
        
        $.ajax({
            ...AJAX_CONFIG,
            data: {
                request_type: 'load_applications_by_batchlist',
                job_number: batchValue
            },
            success: function(response) {
                hideLoading();
                
                let data = typeof response === 'string' ? JSON.parse(response) : response;
                console.log('Batchlist Data:', data);
                
                const table = $('#tbl_batchlist_history tbody');
                table.empty();
                
                if (data && data.length) {
                    $.each(data, function(index, item) {
                        table.append(`
                            <tr>
                                <td class="px-3 py-2">${escapeHtml(item.ar_name || '-')}</td>
                                <td class="px-3 py-2"><span class="badge bg-light">${escapeHtml(item.job_number || '-')}</span></td>
                                <td class="px-3 py-2">${escapeHtml(item.job_purpose || '-')}</td>
                                <td class="px-3 py-2">${escapeHtml(item.sender_name || '-')}</td>
                                <td class="px-3 py-2">${escapeHtml(item.receiver_name || '-')}</td>
                                <td class="px-3 py-2">${formatDate(item.date_created)}</td>
                            </tr>
                        `);
                    });
                    
                    $("#batchlist_value").text(batchValue);
                    $("#BachlistModal").modal('show');
                } else {
                    showNotification('No batchlist found', 'info');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('Batchlist Error:', error);
                showNotification('Failed to load batchlist', 'error');
            }
        });
    });

    // ==================== FILE HISTORY MODAL HANDLER ====================
    
    $('#filelistModal').on('show.bs.modal', function(event) {
        const button = $(event.relatedTarget);
        const jobNumber = button.data('target-id');
        
        if (!jobNumber || jobNumber.length < 4) {
            showNotification('Invalid job number', 'error');
            event.preventDefault();
            return;
        }
        
        console.log('File History for:', jobNumber);
        
       // showLoading('Loading file history...');
        
        $.ajax({
            ...AJAX_CONFIG,
            data: {
                request_type: 'load_application_file_location',
                job_number: jobNumber
            },
            success: function(response) {
                hideLoading();
                
                let data = typeof response === 'string' ? JSON.parse(response) : response;
                console.log('File History:', data);
                
                const table = $('#tbl_file_history tbody');
                table.empty();
                
                if (data && data.length) {
                    $.each(data, function(index, item) {
                        table.append(`
                            <tr>
                                <td class="px-3 py-2">${formatDate(item.created_date)}</td>
                                <td class="px-3 py-2"><span class="badge bg-info">${escapeHtml(item.division || '-')}</span></td>
                                <td class="px-3 py-2">${escapeHtml(item.user_fullname || '-')}</td>
                                <td class="px-3 py-2">${escapeHtml(item.created_by || '-')}</td>
                            </tr>
                        `);
                    });
                } else {
                    table.append(`
                        <tr>
                            <td colspan="4" class="text-center py-4 text-muted">
                                <i class="bi bi-archive me-2"></i>No file history found
                            </td>
                        </tr>
                    `);
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('File History Error:', error);
                showNotification('Failed to load file history', 'error');
                
                const table = $('#tbl_file_history tbody');
                table.empty().append(`
                    <tr>
                        <td colspan="4" class="text-center py-4 text-danger">
                            <i class="bi bi-exclamation-triangle me-2"></i>Error loading history
                        </td>
                    </tr>
                `);
            }
        });
    });

    // Initialize tooltips on document ready
    initializeTooltips();

}); // End of document.ready