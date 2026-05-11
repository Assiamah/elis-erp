/**
 * Regional PVLMD Transaction Search - JavaScript
 * Handles advanced search, filtering, and result display for approved transactions
 */

(function ($) {
    'use strict';

    // Global state
    const state = {
        searchTable: null,
        selectedTransactions: [],
        loadedTransaction: null,
        lastDraw: 1
    };

    // Helper function to parse JSON safely
    function parseJsonSafely(raw) {
        if (raw == null) return null;
        if (typeof raw === 'object') return raw;
        try {
            return JSON.parse(raw);
        } catch (error) {
            return null;
        }
    }

    // Helper function to extract record from payload
    function extractRecord(payload) {
        if (!payload) return null;
        if (Array.isArray(payload.data) && payload.data.length > 0) return payload.data[0];
        if (payload.data && !Array.isArray(payload.data) && typeof payload.data === 'object') return payload.data;
        if (Array.isArray(payload) && payload.length > 0) return payload[0];
        if (payload.t_id || payload.reference_number) return payload;
        return null;
    }

    function getFieldValue(selector) {
        const element = $(selector);
        return element.length ? element.val() : '';
    }

    function renderText(data) {
        if (data === undefined || data === null || data === '' || data === 'null') {
            return 'N/A';
        }
        return $('<div>').text(data).html();
    }

    function emptyDataTableResponse() {
        return JSON.stringify({
            draw: state.lastDraw || 1,
            recordsTotal: 0,
            recordsFiltered: 0,
            data: []
        });
    }

    /**
     * Initialize DataTable with search configuration
     */
    function initializeDataTable() {
        // Destroy existing table if it exists
        if (state.searchTable) {
            state.searchTable.destroy();
            $('#search_results_table tbody').empty();
        }

        state.searchTable = $('#search_results_table').DataTable({
            responsive: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: 'Case_Management_Serv',
                type: 'POST',
                dataType: 'json',
                dataFilter: function(response) {
                    return parseJsonSafely(response) ? response : emptyDataTableResponse();
                },
                data: function(d) {
                    state.lastDraw = d.draw || 1;
                    const simpleSearch = getFieldValue('#simple_search');
                    d.request_type = 'search_regional_transactions';
                    d.search_text = simpleSearch;
                    d.search_reference = getFieldValue('#adv_search_reference') || simpleSearch;
                    d.search_file = getFieldValue('#adv_search_file_number');
                    d.search_jacket = getFieldValue('#adv_search_jacket_name');
                    d.search_region = getFieldValue('#adv_search_region');
                    d.search_document_type = getFieldValue('#adv_search_instrument_type');
                    d.date_from = getFieldValue('#adv_search_date_from');
                    d.date_to = getFieldValue('#adv_search_date_to');
                    d.search_status = getFieldValue('#adv_search_status');
                    d.qc_status = getFieldValue('#adv_search_qc_status');
                },
                dataSrc: function(json) {
                    const payload = parseJsonSafely(json);
                    return payload && Array.isArray(payload.data) ? payload.data : [];
                },
                error: function(xhr, error, thrown) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error loading search results'
                    });
                    console.error('Search DataTable Error:', error);
                }
            },
            columns: [
                { data: 't_id', name: 't_id', defaultContent: 'N/A', render: renderText },
                { data: 'reference_number', name: 'reference_number', defaultContent: 'N/A', render: renderText },
                { data: 'jacket_name', name: 'jacket_name', defaultContent: 'N/A', render: renderText },
                { data: 'file_number', name: 'file_number', defaultContent: 'N/A', render: renderText },
                { data: 'instrument_type', name: 'instrument_type', defaultContent: 'N/A', render: renderText },
                { 
                    data: 'instrument_date',
                    name: 'instrument_date',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return formatDate(data);
                    }
                },
                { data: 'party1_plaintiff', name: 'party1_plaintiff', defaultContent: 'N/A', render: renderText },
                { data: 'party2_defendant', name: 'party2_defendant', defaultContent: 'N/A', render: renderText },
                { 
                    data: 'consideration',
                    name: 'consideration',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return formatCurrency(data, row.consideration_currency);
                    }
                },
                { 
                    data: 'status',
                    name: 'status',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return getStatusBadge(data);
                    }
                },
                { 
                    data: 'approved_under_qc',
                    name: 'approved_under_qc',
                    defaultContent: false,
                    render: function(data, type, row) {
                        return data ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>';
                    }
                },
                { 
                    data: 'created_date',
                    name: 'created_date',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return formatDate(data);
                    }
                },
                {
                    data: null,
                    orderable: false,
                    render: function(data, type, row) {
                        return getSearchActionButtons(row);
                    }
                }
            ],
            order: [[0, 'desc']],
            pageLength: 25,
            lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
            language: {
                processing: '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>',
                emptyTable: 'No transactions found matching your criteria',
                zeroRecords: 'No matching transactions found'
            },
            drawCallback: function(settings) {
                updateResultsCount(settings);
                bindSearchActionButtonEvents();
            }
        });
    }

    /**
     * Bind event listeners to buttons and inputs
     */
    function bindEventListeners() {
        // Simple search button
        $('#btn_simple_search').on('click', function() {
            performSearch();
        });

        // Enter key on simple search input
        $('#simple_search').on('keypress', function(e) {
            if (e.which === 13) {
                performSearch();
            }
        });

        // Export buttons
        $('#export_excel').on('click', function(e) {
            e.preventDefault();
            exportResults('excel');
        });

        $('#export_pdf').on('click', function(e) {
            e.preventDefault();
            exportResults('pdf');
        });

        $('#export_csv').on('click', function(e) {
            e.preventDefault();
            exportResults('csv');
        });

        // Print results
        $('#btn_print_results').on('click', function() {
            printResults();
        });

        $('#btn_advanced_search').on('click', function() {
            performSearch();
            loadStatistics();
        });

        $('#btn_reset_advanced_search').on('click', function() {
            resetAdvancedSearch();
        });

        $('#btn_toggle_filters').on('click', function() {
            toggleFilters();
        });

        $('#btn_save_search_criteria').on('click', function() {
            saveSearchCriteria();
        });

        // Export search results button
        $('#btn_export_search_results').on('click', function() {
            exportResults('excel');
        });
    }

    /**
     * Perform search - Initialize or reload DataTable
     */
    function performSearch() {
        const simpleSearchElement = $('#simple_search');
        const advancedSearchElement = $('#advancedSearchForm');
        const searchText = simpleSearchElement.length ? simpleSearchElement.val().trim() : '';
        const hasAdvancedCriteria = advancedSearchElement.length && advancedSearchElement.find('input, select').toArray().some(function(input) {
            return $(input).val();
        });
        
        if (simpleSearchElement.length && !searchText && !hasAdvancedCriteria) {
            Swal.fire({
                icon: 'warning',
                title: 'Search Required',
                text: 'Please enter a search term to find transactions'
            });
            return;
        }
        
        // Show loading indicator
        Swal.fire({
            title: 'Searching...',
            text: 'Please wait',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });

        if (state.searchTable) {
            state.searchTable.ajax.reload();
        } else {
            initializeDataTable();
        }
        
        // Close loading indicator after a short delay
        setTimeout(() => {
            Swal.close();
        }, 500);
    }

    /**
     * Load search statistics
     */
    function loadStatistics() {
        $.ajax({
            type: 'POST',
            url: 'RegionalTransactionSearchServ',
            data: {
                request_type: 'get_search_statistics',
                reference_number: $('#adv_search_reference').val(),
                file_number: $('#adv_search_file_number').val(),
                jacket_name: $('#adv_search_jacket_name').val(),
                plan_number: $('#adv_search_plan_number').val(),
                party1: $('#adv_search_party1').val(),
                party2: $('#adv_search_party2').val(),
                instrument_type: $('#adv_search_instrument_type').val(),
                region: $('#adv_search_region').val(),
                date_from: $('#adv_search_date_from').val(),
                date_to: $('#adv_search_date_to').val(),
                status: $('#adv_search_status').val(),
                qc_status: $('#adv_search_qc_status').val()
            },
            cache: false,
            success: function(response) {
                const payload = parseJsonSafely(response);
                if (payload && payload.data) {
                    updateStatisticsDisplay(payload.data);
                }
            },
            error: function(xhr) {
                console.error('Statistics Error:', xhr);
            }
        });
    }

    /**
     * Update statistics display
     */
    function updateStatisticsDisplay(data) {
        $('#stat_total_records').text(data.total || 0);
        $('#stat_approved_count').text(data.approved || 0);
        $('#stat_pending_count').text(data.pending || 0);
        $('#stat_rejected_count').text(data.rejected || 0);
        $('#stat_qc_approved').text(data.qc_approved || 0);
        $('#stat_this_month').text(data.this_month || 0);
    }

    /**
     * Update results count badge
     */
    function updateResultsCount(settings) {
        const json = settings.json || {};
        const totalRecords = json.recordsFiltered || json.recordsTotal || 0;
        $('#results_count_badge').text(`${totalRecords} records found`);
        
    }

    /**
     * View transaction details
     */
    function viewTransactionDetails(transactionId) {
        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'get_regional_transaction_by_id',
                t_id: transactionId
            },
            cache: false,
            success: function(response) {
                const payload = parseJsonSafely(response);
                const record = extractRecord(payload);
                
                if (record) {
                    state.loadedTransaction = record;
                    displayFullTransactionDetails(record);
                    $('#viewSearchTransactionModal').modal('show');
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to load transaction details'
                    });
                }
            },
            error: function(xhr) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error fetching transaction details'
                });
                console.error('View Error:', xhr);
            }
        });
    }

    /**
     * Display full transaction details in modal
     */
    function displayFullTransactionDetails(data) {
        const content = `
            <div class="card mb-3">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="ri-information-line me-2"></i>Basic Information</h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Reference Number</label>
                            <p class="mb-0">${data.reference_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Jacket Name</label>
                            <p class="mb-0">${data.jacket_name || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Region</label>
                            <p class="mb-0">${data.region || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">File Number</label>
                            <p class="mb-0">${data.file_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Property Number</label>
                            <p class="mb-0">${data.property_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Submission Date</label>
                            <p class="mb-0">${formatDate(data.submission_date)}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="ri-file-text-line me-2"></i>Document Details</h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Mutation Number</label>
                            <p class="mb-0">${data.mutation_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Deed Number</label>
                            <p class="mb-0">${data.deed_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Serial Number</label>
                            <p class="mb-0">${data.serial_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Sheet Number</label>
                            <p class="mb-0">${data.sheet_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Plan Number</label>
                            <p class="mb-0">${data.plan_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Plot Number</label>
                            <p class="mb-0">${data.plot_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">LVB Number</label>
                            <p class="mb-0">${data.lvb_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Instrument Type</label>
                            <p class="mb-0">${data.instrument_type || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Instrument Date</label>
                            <p class="mb-0">${formatDate(data.instrument_date)}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Consent Date</label>
                            <p class="mb-0">${formatDate(data.consent_date)}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="ri-user-line me-2"></i>Parties Information</h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="fw-bold text-muted small">Party 1 (Plaintiff)</label>
                            <p class="mb-0">${data.party1_plaintiff || 'N/A'}</p>
                            <small class="text-muted">${data.party1_plaintiff_tel_no || ''}</small><br>
                            <small class="text-muted">${data.party1_plaintiff_email || ''}</small>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold text-muted small">Party 2 (Defendant)</label>
                            <p class="mb-0">${data.party2_defendant || 'N/A'}</p>
                            <small class="text-muted">${data.party2_defendant_tel_no || ''}</small><br>
                            <small class="text-muted">${data.party2_defendant_email || ''}</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="ri-money-dollar-circle-line me-2"></i>Financial Details</h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Consideration</label>
                            <p class="mb-0">${formatCurrency(data.consideration, data.consideration_currency)}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Premium</label>
                            <p class="mb-0">${formatCurrency(data.premium, data.premium_currency)}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Rent</label>
                            <p class="mb-0">${data.rent || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="fw-bold text-muted small">Compensation Status</label>
                            <p class="mb-0">${data.compensation_status || 'N/A'}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-3">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="ri-sticky-note-line me-2"></i>Additional Information</h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="fw-bold text-muted small">Remarks</label>
                            <p class="mb-0">${data.remarks || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Status</label>
                            <p class="mb-0">${getStatusBadge(data.status)}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">QC Approved</label>
                            <p class="mb-0">${data.approved_under_qc ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold text-muted small">Created Date</label>
                            <p class="mb-0">${formatDate(data.created_date)}</p>
                        </div>
                    </div>
                </div>
            </div>
        `;
        $('#viewSearchTransactionContent').html(content);
    }

    /**
     * Compare selected transactions
     */
    function compareTransactions() {
        if (state.selectedTransactions.length < 2 || state.selectedTransactions.length > 3) {
            Swal.fire({
                icon: 'warning',
                title: 'Selection Error',
                text: 'Please select 2 or 3 transactions to compare'
            });
            return;
        }

        // Fetch details for all selected transactions
        const promises = state.selectedTransactions.map(id => {
            return $.ajax({
                type: 'POST',
                url: 'Case_Management_Serv',
                data: {
                    request_type: 'get_regional_transaction_by_id',
                    t_id: id
                },
                cache: false
            });
        });

        Promise.all(promises).then(responses => {
            const transactions = responses
                .map(r => {
                    const payload = parseJsonSafely(r);
                    return extractRecord(payload);
                })
                .filter(t => t !== null);
            
            displayComparison(transactions);
            $('#compareTransactionsModal').modal('show');
        }).catch(error => {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Error loading transactions for comparison'
            });
            console.error('Compare Error:', error);
        });
    }

    /**
     * Display comparison view
     */
    function displayComparison(transactions) {
        let html = '<div class="row">';
        
        transactions.forEach((txn, index) => {
            html += `
                <div class="col-md-${12 / transactions.length}">
                    <div class="card h-100">
                        <div class="card-header bg-${['primary', 'success', 'info'][index]} text-white">
                            <h6 class="mb-0">Transaction ${index + 1}</h6>
                        </div>
                        <div class="card-body">
                            <p><strong>Ref:</strong> ${txn.reference_number}</p>
                            <p><strong>Jacket:</strong> ${txn.jacket_name}</p>
                            <p><strong>Type:</strong> ${txn.instrument_type}</p>
                            <p><strong>Date:</strong> ${formatDate(txn.instrument_date)}</p>
                            <p><strong>Party 1:</strong> ${txn.party1_plaintiff || 'N/A'}</p>
                            <p><strong>Party 2:</strong> ${txn.party2_defendant || 'N/A'}</p>
                            <p><strong>Consideration:</strong> ${formatCurrency(txn.consideration, txn.consideration_currency)}</p>
                        </div>
                    </div>
                </div>
            `;
        });
        
        html += '</div>';
        $('#comparison_container').html(html);
    }

    /**
     * Print transaction details
     */
    function printTransaction() {
        const content = $('#viewSearchTransactionContent').html();
        const printWindow = window.open('', '', 'width=800,height=600');
        printWindow.document.write(`
            <html>
                <head>
                    <title>Transaction Details</title>
                    <link href="/assets/libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
                    <style>
                        body { padding: 20px; }
                        @media print { .no-print { display: none; } }
                    </style>
                </head>
                <body>
                    <div class="no-print mb-3">
                        <button onclick="window.print()" class="btn btn-primary">Print</button>
                        <button onclick="window.close()" class="btn btn-secondary">Close</button>
                    </div>
                    ${content}
                </body>
            </html>
        `);
        printWindow.document.close();
    }

    /**
     * Reset advanced search form
     */
    function resetAdvancedSearch() {
        $('#advancedSearchForm')[0].reset();
        $('#adv_search_status').val('approved');
        performSearch();
    }

    /**
     * Save search criteria (placeholder for future implementation)
     */
    function saveSearchCriteria() {
        Swal.fire({
            icon: 'info',
            title: 'Coming Soon',
            text: 'Save search criteria feature coming soon!'
        });
    }

    /**
     * Export results in specified format
     */
    function exportResults(format) {
        const params = [
            'request_type=export_search_results',
            'format=' + format,
            'reference_number=' + encodeURIComponent($('#adv_search_reference').val()),
            'file_number=' + encodeURIComponent($('#adv_search_file_number').val()),
            'jacket_name=' + encodeURIComponent($('#adv_search_jacket_name').val()),
            'plan_number=' + encodeURIComponent($('#adv_search_plan_number').val()),
            'party1=' + encodeURIComponent($('#adv_search_party1').val()),
            'party2=' + encodeURIComponent($('#adv_search_party2').val()),
            'instrument_type=' + encodeURIComponent($('#adv_search_instrument_type').val()),
            'region=' + encodeURIComponent($('#adv_search_region').val()),
            'date_from=' + encodeURIComponent($('#adv_search_date_from').val()),
            'date_to=' + encodeURIComponent($('#adv_search_date_to').val()),
            'status=' + encodeURIComponent($('#adv_search_status').val()),
            'qc_status=' + encodeURIComponent($('#adv_search_qc_status').val())
        ];

        window.location.href = 'RegionalTransactionSearchServ?' + params.join('&');
    }

    /**
     * Print results
     */
    function printResults() {
        window.print();
    }

    /**
     * Toggle filter visibility
     */
    function toggleFilters() {
        const cardBody = $('#advancedSearchForm').closest('.card-body');
        cardBody.slideToggle();
    }

    /**
     * Get action buttons HTML
     */
    function getSearchActionButtons(row) {
        return `
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-sm btn-info btn-view-details" data-id="${row.t_id}" title="View Details">
                    <i class="ri-eye-line"></i>
                </button>
                <button type="button" class="btn btn-sm btn-primary btn-print-txn" data-id="${row.t_id}" title="Print">
                    <i class="ri-printer-line"></i>
                </button>
            </div>
        `;
    }

    /**
     * Bind events to search action buttons
     */
    function bindSearchActionButtonEvents() {
        $('.btn-view-details').off('click').on('click', function() {
            const id = $(this).data('id');
            viewTransactionDetails(id);
        });

        $('.btn-print-txn').off('click').on('click', function() {
            const id = $(this).data('id');
            viewTransactionDetails(id);
            setTimeout(() => {
                printTransaction();
            }, 500);
        });
    }

    /**
     * Get status badge HTML
     */
    function getStatusBadge(status) {
        const badges = {
            'pending': '<span class="badge bg-warning">Pending</span>',
            'approved': '<span class="badge bg-success">Approved</span>',
            'rejected': '<span class="badge bg-danger">Rejected</span>',
            'under_review': '<span class="badge bg-info">Under Review</span>'
        };
        return badges[status] || '<span class="badge bg-secondary">' + renderText(status) + '</span>';
    }

    /**
     * Format date for display
     */
    function formatDate(dateString) {
        if (!dateString || dateString === 'null') return 'N/A';
        const date = new Date(dateString);
        if (isNaN(date.getTime())) return 'N/A';
        return date.toLocaleDateString('en-GB', {
            day: '2-digit',
            month: 'short',
            year: 'numeric'
        });
    }

    /**
     * Format currency for display
     */
    function formatCurrency(amount, currency) {
        if (!amount || amount === '0' || amount === 0 || amount === 'null') return 'N/A';
        return `${currency || 'GHS'} ${parseFloat(amount).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
    }

    /**
     * Initialize the page when DOM is ready
     */
    $(function() {
        bindEventListeners();
        // Do NOT initialize DataTable on load - wait for user to search
    });

}(jQuery));
