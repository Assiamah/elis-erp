/**
 * Regional PVLMD Transaction Data Capture - JavaScript
 * Handles transaction CRUD operations and UI interactions
 */

(function ($) {
    'use strict';

    // Global state
    const state = {
        transactionsTable: null,
        currentTransactionId: null,
        loadedTransaction: null,
        lastDraw: 1
    };

    // Helper function to parse JSON safely
    function parseJsonSafely(raw) {
        if (raw == null) {
            return null;
        }
        if (typeof raw === 'object') {
            return raw;
        }
        try {
            return JSON.parse(raw);
        } catch (error) {
            return null;
        }
    }

    // Helper function to get first non-empty value
    function firstNonEmpty() {
        for (let i = 0; i < arguments.length; i += 1) {
            const value = arguments[i];
            if (value !== undefined && value !== null && String(value).trim() !== '') {
                return value;
            }
        }
        return '';
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
     * Initialize DataTable with configuration
     */
    function initializeDataTable() {
        state.transactionsTable = $('#regional_transactions_table').DataTable({
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
                    d.request_type = 'get_regional_transactions_list';
                    // d.search_reference = $('#search_reference_number').val();
                    // d.search_file = $('#search_file_number').val();
                    // d.search_jacket = $('#search_jacket_name').val();
                    // d.search_status = $('#search_status').val();
                },
                dataSrc: function(json) {
                    const payload = parseJsonSafely(json);
                    return payload && Array.isArray(payload.data) ? payload.data : [];
                },
                error: function(xhr, error, thrown) {
                    console.error('DataTable AJAX Error:', error);
                    console.error('Status:', xhr.status);
                    console.error('Response Text:', xhr.responseText);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error loading transactions. Please try again.'
                    });
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
                    data: 'status',
                    name: 'status',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return getStatusBadge(data);
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
                        return getActionButtons(row);
                    }
                }
            ],
            order: [[0, 'desc']],
            pageLength: 25,
            lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
            language: {
                processing: '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>',
                emptyTable: 'No transactions found',
                zeroRecords: 'No matching transactions found'
            },
            drawCallback: function(settings) {
                bindActionButtonEvents();
            }
        });
    }

    /**
     * Bind event listeners to buttons and inputs
     */
    function bindEventListeners() {
        // Add new transaction button
        $('#btn_add_new_transaction').on('click', function() {
            openAddModal();
        });

        // Search button
        $('#btn_search_transactions').on('click', function() {
            if (state.transactionsTable) {
                state.transactionsTable.ajax.reload();
            }
        });

        // Reset search button
        $('#btn_reset_search').on('click', function() {
            resetSearchForm();
        });

        // Save transaction button
        $('#btn_save_transaction').on('click', function() {
            saveTransaction();
        });

        // Export buttons
        $('#btn_export_excel').on('click', function() {
            exportToExcel();
        });

        $('#btn_export_pdf').on('click', function() {
            exportToPDF();
        });

        // Enter key on search inputs
        $('#search_reference_number, #search_file_number, #search_jacket_name').on('keypress', function(e) {
            if (e.which === 13) {
                if (state.transactionsTable) {
                    state.transactionsTable.ajax.reload();
                }
            }
        });
    }

    /**
     * Load transactions into DataTable
     */
    function loadTransactions() {
        if (state.transactionsTable) {
            state.transactionsTable.ajax.reload();
        }
    }

    /**
     * Open modal for adding new transaction
     */
    function openAddModal() {
        state.currentTransactionId = null;
        state.loadedTransaction = null;
        $('#transactionModalLabel').html('<i class="ri-add-circle-line me-2"></i>Add New Transaction');
        $('#transactionForm')[0].reset();
        $('#transaction_id').val('');
        $('#transactionModal').modal('show');
    }

    /**
     * Open modal for editing existing transaction
     */
    function openEditModal(transactionId) {
        state.currentTransactionId = transactionId;
        
        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'get_regional_transaction_by_id',
                t_id: transactionId
            },
            cache: false,
            beforeSend: function() {
                $('#btn_save_transaction').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-1"></span> Loading...');
            },
            success: function(response) {
                const payload = parseJsonSafely(response);
                const record = extractRecord(payload);
                
                if (record) {
                    state.loadedTransaction = record;
                    populateForm(record);
                    $('#transactionModalLabel').html('<i class="ri-edit-line me-2"></i>Edit Transaction');
                    $('#transactionModal').modal('show');
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
                console.error('Fetch Error:', xhr);
            },
            complete: function() {
                $('#btn_save_transaction').prop('disabled', false).html('<i class="ri-save-line me-1"></i> Save Transaction');
            }
        });
    }

    /**
     * Extract record from response payload
     */
    function extractRecord(payload) {
        if (!payload) {
            return null;
        }
        if (Array.isArray(payload.data) && payload.data.length > 0) {
            return payload.data[0];
        }
        if (payload.data && !Array.isArray(payload.data) && typeof payload.data === 'object') {
            return payload.data;
        }
        if (Array.isArray(payload) && payload.length > 0) {
            return payload[0];
        }
        if (payload.t_id || payload.reference_number) {
            return payload;
        }
        return null;
    }

    /**
     * Populate form with transaction data
     */
    function populateForm(data) {
        $('#transaction_id').val(data.t_id);
        
        // Basic Information
        $('#reg_txn_jacket_name').val(data.jacket_name);
        $('#reg_txn_region').val(data.region);
        $('#reg_txn_reference_number').val(data.reference_number);
        $('#reg_txn_file_number').val(data.file_number);
        $('#reg_txn_property_number').val(data.property_number);
        $('#reg_txn_submission_date').val(data.submission_date);

        // Document Details
        $('#reg_txn_mutation_number').val(data.mutation_number);
        $('#reg_txn_deed_number').val(data.deed_number);
        $('#reg_txn_serial_number').val(data.serial_number);
        $('#reg_txn_sheet_number').val(data.sheet_number);
        $('#reg_txn_plan_number').val(data.plan_number);
        $('#reg_txn_plot_number').val(data.plot_number);
        $('#reg_txn_lvb_number').val(data.lvb_number);
        $('#reg_txn_instrument_date').val(data.instrument_date);
        $('#reg_txn_instrument_type').val(data.instrument_type);
        $('#reg_txn_doc_number').val(data.doc_number);

        // Party 1 Information
        $('#reg_txn_party1_plaintiff').val(data.party1_plaintiff);
        $('#reg_txn_party1_plaintiff_tel_no').val(data.party1_plaintiff_tel_no);
        $('#reg_txn_party1_plaintiff_email').val(data.party1_plaintiff_email);
        $('#reg_txn_party1_plantiff_add').val(data.party1_plantiff_add);

        // Party 2 Information
        $('#reg_txn_party2_defendant').val(data.party2_defendant);
        $('#reg_txn_party2_defendant_tel_no').val(data.party2_defendant_tel_no);
        $('#reg_txn_party2_defendant_email').val(data.party2_defendant_email);
        $('#reg_txn_party2_defendant_add').val(data.party2_defendant_add);

        // Financial Details
        $('#reg_txn_consideration').val(data.consideration);
        $('#reg_txn_consideration_currency').val(data.consideration_currency);
        $('#reg_txn_premium').val(data.premium);
        $('#reg_txn_premium_currency').val(data.premium_currency);
        $('#reg_txn_rent').val(data.rent);
        $('#reg_txn_compensation_status').val(data.compensation_status);

        // Additional Details
        $('#reg_txn_term').val(data.term);
        $('#reg_txn_commencement_date').val(data.commencement_date);
        $('#reg_txn_purpose').val(data.purpose);
        $('#reg_txn_entered_date').val(data.entered_date);
        $('#reg_txn_consent_date').val(data.consent_date);
        $('#reg_txn_suit_number').val(data.suit_number);
        $('#reg_txn_judgement_in_favour_of').val(data.judgement_in_favour_of);
        $('#reg_txn_floor_level').val(data.floor_level);
        $('#reg_txn_apartment_number').val(data.apartment_number);
        $('#unit_description').val(data.unit_description);
        $('#hqfile_id').val(data.hqfile_id);
        $('#gid_unique_across').val(data.gid_unique_across);
        $('#reg_txn_remarks').val(data.remarks);
    }

    /**
     * Save transaction (create or update)
     */
    function saveTransaction() {
        // Validate form
        if (!validateForm()) {
            return;
        }

        const formData = collectFormData();
        const isUpdate = state.currentTransactionId !== null;
        const requestType = isUpdate ? 'update_regional_transaction' : 'create_regional_transaction';

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: requestType,
                ...formData
            },
            cache: false,
            beforeSend: function() {
                $('#btn_save_transaction').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-1"></span> Saving...');
            },
            success: function(response) {
                const payload = parseJsonSafely(response);
                
                if (payload && (payload.success || payload.status === 'success')) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: isUpdate ? 'Transaction updated successfully' : 'Transaction created successfully',
                        timer: 2000,
                        showConfirmButton: false
                    });
                    
                    $('#transactionModal').modal('hide');
                    loadTransactions();
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: (payload && payload.message) ? payload.message : 'Failed to save transaction'
                    });
                }
            },
            error: function(xhr) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error saving transaction. Please try again.'
                });
                console.error('Save Error:', xhr);
            },
            complete: function() {
                $('#btn_save_transaction').prop('disabled', false).html('<i class="ri-save-line me-1"></i> Save Transaction');
            }
        });
    }

    /**
     * Validate form before submission
     */
    function validateForm() {
        let isValid = true;
        const requiredFields = ['reg_txn_reference_number', 'reg_txn_instrument_type', 'reg_txn_party1_plaintiff'];

        requiredFields.forEach(field => {
            const element = $(`#${field}`);
            if (!element.val() || element.val().trim() === '') {
                element.addClass('is-invalid');
                isValid = false;
            } else {
                element.removeClass('is-invalid');
            }
        });

        if (!isValid) {
            Swal.fire({
                icon: 'warning',
                title: 'Validation Error',
                text: 'Please fill in all required fields'
            });
        }

        return isValid;
    }

    /**
     * Collect form data into object
     */
    function collectFormData() {
        return {
            t_id: $('#transaction_id').val(),
            jacket_name: $('#reg_txn_jacket_name').val(),
            region: $('#reg_txn_region').val(),
            reference_number: $('#reg_txn_reference_number').val(),
            file_number: $('#reg_txn_file_number').val(),
            property_number: $('#reg_txn_property_number').val(),
            submission_date: $('#reg_txn_submission_date').val(),
            mutation_number: $('#reg_txn_mutation_number').val(),
            deed_number: $('#reg_txn_deed_number').val(),
            serial_number: $('#reg_txn_serial_number').val(),
            sheet_number: $('#reg_txn_sheet_number').val(),
            plan_number: $('#reg_txn_plan_number').val(),
            plot_number: $('#reg_txn_plot_number').val(),
            lvb_number: $('#reg_txn_lvb_number').val(),
            instrument_date: $('#reg_txn_instrument_date').val(),
            instrument_type: $('#reg_txn_instrument_type').val(),
            doc_number: $('#reg_txn_doc_number').val(),
            party1_plaintiff: $('#reg_txn_party1_plaintiff').val(),
            party1_plaintiff_tel_no: $('#reg_txn_party1_plaintiff_tel_no').val(),
            party1_plaintiff_email: $('#reg_txn_party1_plaintiff_email').val(),
            party1_plantiff_add: $('#reg_txn_party1_plantiff_add').val(),
            party2_defendant: $('#reg_txn_party2_defendant').val(),
            party2_defendant_tel_no: $('#reg_txn_party2_defendant_tel_no').val(),
            party2_defendant_email: $('#reg_txn_party2_defendant_email').val(),
            party2_defendant_add: $('#reg_txn_party2_defendant_add').val(),
            consideration: $('#reg_txn_consideration').val(),
            consideration_currency: $('#reg_txn_consideration_currency').val(),
            premium: $('#reg_txn_premium').val(),
            premium_currency: $('#reg_txn_premium_currency').val(),
            rent: $('#reg_txn_rent').val(),
            compensation_status: $('#reg_txn_compensation_status').val(),
            term: $('#reg_txn_term').val(),
            commencement_date: $('#reg_txn_commencement_date').val(),
            purpose: $('#reg_txn_purpose').val(),
            entered_date: $('#reg_txn_entered_date').val(),
            consent_date: $('#reg_txn_consent_date').val(),
            suit_number: $('#reg_txn_suit_number').val(),
            judgement_in_favour_of: $('#reg_txn_judgement_in_favour_of').val(),
            floor_level: $('#reg_txn_floor_level').val(),
            apartment_number: $('#reg_txn_apartment_number').val(),
            unit_description: $('#unit_description').val(),
            hqfile_id: $('#hqfile_id').val(),
            gid_unique_across: $('#gid_unique_across').val(),
            remarks: $('#reg_txn_remarks').val()
        };
    }

    /**
     * View transaction details
     */
    function viewTransaction(transactionId) {
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
                    displayTransactionDetails(record);
                    $('#viewTransactionModal').modal('show');
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
     * Display transaction details in modal
     */
    function displayTransactionDetails(data) {
        const content = `
            <!-- Header Summary Card -->
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-body bg-light">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-8">
                            <h5 class="mb-1 text-primary">
                                <i class="ri-file-text-line me-2"></i>${data.reference_number || 'N/A'}
                            </h5>
                            <p class="mb-0 text-muted">
                                <i class="ri-user-line me-1"></i>${data.jacket_name || 'N/A'}
                            </p>
                        </div>
                        <div class="col-md-4 text-end">
                            ${getStatusBadge(data.status)}
                        </div>
                    </div>
                </div>
            </div>

            <!-- Basic Information -->
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-header bg-white border-bottom">
                    <h6 class="mb-0 text-primary">
                        <i class="ri-information-line me-2"></i>Basic Information
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Region</label>
                            <p class="fw-semibold mb-0">${data.region || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">File Number</label>
                            <p class="fw-semibold mb-0">${data.file_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Property Number</label>
                            <p class="fw-semibold mb-0">${data.property_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Submission Date</label>
                            <p class="fw-semibold mb-0">${formatDate(data.submission_date)}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Document Details -->
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-header bg-white border-bottom">
                    <h6 class="mb-0 text-primary">
                        <i class="ri-file-list-3-line me-2"></i>Document Details
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Mutation Number</label>
                            <p class="fw-semibold mb-0">${data.mutation_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Deed Number</label>
                            <p class="fw-semibold mb-0">${data.deed_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Serial Number</label>
                            <p class="fw-semibold mb-0">${data.serial_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Sheet Number</label>
                            <p class="fw-semibold mb-0">${data.sheet_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Plan Number</label>
                            <p class="fw-semibold mb-0">${data.plan_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Plot Number</label>
                            <p class="fw-semibold mb-0">${data.plot_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">LVB Number</label>
                            <p class="fw-semibold mb-0">${data.lvb_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">DOC Number</label>
                            <p class="fw-semibold mb-0">${data.doc_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Instrument Type</label>
                            <p class="fw-semibold mb-0">${data.instrument_type || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Instrument Date</label>
                            <p class="fw-semibold mb-0">${formatDate(data.instrument_date)}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Party Information -->
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-header bg-white border-bottom">
                    <h6 class="mb-0 text-primary">
                        <i class="ri-group-line me-2"></i>Party Information
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded">
                                <h6 class="text-primary mb-3">
                                    <i class="ri-user-star-line me-2"></i>Party 1 (Plaintiff)
                                </h6>
                                <div class="mb-2">
                                    <label class="text-muted small d-block">Name</label>
                                    <p class="fw-semibold mb-0">${data.party1_plaintiff || 'N/A'}</p>
                                </div>
                                <div class="mb-2">
                                    <label class="text-muted small d-block">Phone</label>
                                    <p class="mb-0"><i class="ri-phone-line me-1"></i>${data.party1_plaintiff_tel_no || 'N/A'}</p>
                                </div>
                                <div class="mb-2">
                                    <label class="text-muted small d-block">Email</label>
                                    <p class="mb-0"><i class="ri-mail-line me-1"></i>${data.party1_plaintiff_email || 'N/A'}</p>
                                </div>
                                <div>
                                    <label class="text-muted small d-block">Address</label>
                                    <p class="mb-0"><i class="ri-map-pin-line me-1"></i>${data.party1_plantiff_add || 'N/A'}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded">
                                <h6 class="text-primary mb-3">
                                    <i class="ri-user-follow-line me-2"></i>Party 2 (Defendant)
                                </h6>
                                <div class="mb-2">
                                    <label class="text-muted small d-block">Name</label>
                                    <p class="fw-semibold mb-0">${data.party2_defendant || 'N/A'}</p>
                                </div>
                                <div class="mb-2">
                                    <label class="text-muted small d-block">Phone</label>
                                    <p class="mb-0"><i class="ri-phone-line me-1"></i>${data.party2_defendant_tel_no || 'N/A'}</p>
                                </div>
                                <div class="mb-2">
                                    <label class="text-muted small d-block">Email</label>
                                    <p class="mb-0"><i class="ri-mail-line me-1"></i>${data.party2_defendant_email || 'N/A'}</p>
                                </div>
                                <div>
                                    <label class="text-muted small d-block">Address</label>
                                    <p class="mb-0"><i class="ri-map-pin-line me-1"></i>${data.party2_defendant_add || 'N/A'}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Financial Details -->
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-header bg-white border-bottom">
                    <h6 class="mb-0 text-primary">
                        <i class="ri-money-dollar-circle-line me-2"></i>Financial Details
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Consideration</label>
                            <p class="fw-semibold mb-0 text-success">
                                ${formatCurrency(data.consideration, data.consideration_currency)}
                            </p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Premium</label>
                            <p class="fw-semibold mb-0 text-success">
                                ${formatCurrency(data.premium, data.premium_currency)}
                            </p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Rent</label>
                            <p class="fw-semibold mb-0">${data.rent || 'N/A'}</p>
                        </div>
                        <div class="col-md-6">
                            <label class="text-muted small mb-1">Compensation Status</label>
                            <p class="fw-semibold mb-0">${data.compensation_status || 'N/A'}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Additional Details -->
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-header bg-white border-bottom">
                    <h6 class="mb-0 text-primary">
                        <i class="ri-sticky-note-line me-2"></i>Additional Details
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Term</label>
                            <p class="fw-semibold mb-0">${data.term || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Commencement Date</label>
                            <p class="fw-semibold mb-0">${formatDate(data.commencement_date)}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Purpose</label>
                            <p class="fw-semibold mb-0">${data.purpose || 'N/A'}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Entered Date</label>
                            <p class="fw-semibold mb-0">${formatDate(data.entered_date)}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Consent Date</label>
                            <p class="fw-semibold mb-0">${formatDate(data.consent_date)}</p>
                        </div>
                        <div class="col-md-4">
                            <label class="text-muted small mb-1">Suit Number</label>
                            <p class="fw-semibold mb-0">${data.suit_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-6">
                            <label class="text-muted small mb-1">Judgement In Favour Of</label>
                            <p class="fw-semibold mb-0">${data.judgement_in_favour_of || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Floor Level</label>
                            <p class="fw-semibold mb-0">${data.floor_level || 'N/A'}</p>
                        </div>
                        <div class="col-md-3">
                            <label class="text-muted small mb-1">Apartment Number</label>
                            <p class="fw-semibold mb-0">${data.apartment_number || 'N/A'}</p>
                        </div>
                        <div class="col-md-12">
                            <label class="text-muted small mb-1">Unit Description</label>
                            <p class="fw-semibold mb-0">${data.unit_description || 'N/A'}</p>
                        </div>
                        <div class="col-md-6">
                            <label class="text-muted small mb-1">HQ File ID</label>
                            <p class="fw-semibold mb-0">${data.hqfile_id || 'N/A'}</p>
                        </div>
                        <div class="col-md-6">
                            <label class="text-muted small mb-1">GID Unique Across</label>
                            <p class="fw-semibold mb-0">${data.gid_unique_across || 'N/A'}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Remarks -->
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom">
                    <h6 class="mb-0 text-primary">
                        <i class="ri-chat-quote-line me-2"></i>Remarks
                    </h6>
                </div>
                <div class="card-body">
                    <p class="mb-0">${data.remarks || 'No remarks provided'}</p>
                </div>
            </div>
        `;
        $('#viewTransactionContent').html(content);
    }

    /**
     * Print transaction details
     */
    function printTransactionDetails() {
        const content = $('#viewTransactionContent').html();
        const title = 'Transaction Details';
        
        const printWindow = window.open('', '', 'width=1200,height=800');
        printWindow.document.write(`
            <!DOCTYPE html>
            <html>
                <head>
                    <title>${title}</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
                    <style>
                        body { 
                            padding: 30px; 
                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        }
                        .card {
                            box-shadow: 0 2px 4px rgba(0,0,0,0.1) !important;
                            border: 1px solid #dee2e6 !important;
                            margin-bottom: 20px;
                        }
                        .card-header {
                            background-color: #f8f9fa !important;
                            border-bottom: 2px solid #dee2e6 !important;
                        }
                        .text-primary {
                            color: #0d6efd !important;
                        }
                        .fw-semibold {
                            font-weight: 600 !important;
                        }
                        .bg-light {
                            background-color: #f8f9fa !important;
                        }
                        @media print {
                            .no-print { display: none; }
                            body { padding: 0; }
                            .card { break-inside: avoid; }
                        }
                    </style>
                </head>
                <body>
                    <div class="no-print mb-4 text-center">
                        <button onclick="window.print()" class="btn btn-primary btn-lg">
                            <i class="ri-printer-line me-2"></i>Print Document
                        </button>
                        <button onclick="window.close()" class="btn btn-secondary btn-lg ms-2">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                    </div>
                    <div class="container-fluid">
                        ${content}
                    </div>
                    <div class="text-center mt-4 text-muted small no-print">
                        <p>Generated on ${new Date().toLocaleString()}</p>
                    </div>
                </body>
            </html>
        `);
        printWindow.document.close();
    }

    /**
     * Delete transaction
     */
    function deleteTransaction(transactionId) {
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            customClass: {
                cancelButton: 'btn btn-outline-dark',
                confirmButton: 'btn btn-danger'
            },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST',
                    url: 'Case_Management_Serv',
                    data: {
                        request_type: 'delete_regional_transaction',
                        t_id: transactionId
                    },
                    cache: false,
                    success: function(response) {
                        const payload = parseJsonSafely(response);
                        
                        if (payload && (payload.success || payload.status === 'success')) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Deleted!',
                                text: 'Transaction deleted successfully',
                                timer: 2000,
                                showConfirmButton: false
                            });
                            loadTransactions();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: (payload && payload.message) ? payload.message : 'Failed to delete transaction'
                            });
                        }
                    },
                    error: function(xhr) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error deleting transaction'
                        });
                        console.error('Delete Error:', xhr);
                    }
                });
            }
        });
    }

    /**
     * Reset search form
     */
    function resetSearchForm() {
        $('#search_reference_number').val('');
        $('#search_file_number').val('');
        $('#search_jacket_name').val('');
        $('#search_status').val('');
        if (state.transactionsTable) {
            state.transactionsTable.ajax.reload();
        }
    }

    /**
     * Export to Excel
     */
    function exportToExcel() {
        window.location.href = 'Case_Management_Serv?request_type=export_regional_transactions_excel&' + 
            'search_reference=' + encodeURIComponent($('#search_reference_number').val()) +
            '&search_file=' + encodeURIComponent($('#search_file_number').val()) +
            '&search_jacket=' + encodeURIComponent($('#search_jacket_name').val()) +
            '&search_status=' + encodeURIComponent($('#search_status').val());
    }

    /**
     * Export to PDF
     */
    function exportToPDF() {
        window.location.href = 'Case_Management_Serv?request_type=export_regional_transactions_pdf&' + 
            'search_reference=' + encodeURIComponent($('#search_reference_number').val()) +
            '&search_file=' + encodeURIComponent($('#search_file_number').val()) +
            '&search_jacket=' + encodeURIComponent($('#search_jacket_name').val()) +
            '&search_status=' + encodeURIComponent($('#search_status').val());
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
     * Get action buttons HTML
     */
    function getActionButtons(row) {
        return `
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-sm btn-info btn-view" data-id="${row.t_id}" title="View">
                    <i class="ri-eye-line"></i>
                </button>
                <button type="button" class="btn btn-sm btn-primary btn-edit" data-id="${row.t_id}" title="Edit">
                    <i class="ri-edit-line"></i>
                </button>
                <button type="button" class="btn btn-sm btn-danger btn-delete" data-id="${row.t_id}" title="Delete">
                    <i class="ri-delete-bin-line"></i>
                </button>
            </div>
        `;
    }

    /**
     * Bind events to action buttons (called after table draw)
     */
    function bindActionButtonEvents() {
        $('.btn-view').off('click').on('click', function() {
            const id = $(this).data('id');
            viewTransaction(id);
        });

        $('.btn-edit').off('click').on('click', function() {
            const id = $(this).data('id');
            openEditModal(id);
        });

        $('.btn-delete').off('click').on('click', function() {
            const id = $(this).data('id');
            deleteTransaction(id);
        });
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
        if (!amount || amount === '0' || amount === 0 || amount === 'null' || amount === '') return 'N/A';
        const curr = currency || 'GHS';
        return `${curr} ${parseFloat(amount).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
    }

    /**
     * Initialize the page when DOM is ready
     */
    $(function() {
        initializeDataTable();
        bindEventListeners();
        loadTransactions();
    });

}(jQuery));
