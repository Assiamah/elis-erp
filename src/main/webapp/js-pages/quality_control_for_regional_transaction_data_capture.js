/**
 * Quality Control for Regional PVLMD Transactions - JavaScript
 * Handles transaction review, approval, and rejection workflows
 */

(function ($) {
    'use strict';

    // Global state
    const state = {
        qcTable: null,
        currentReviewTransactionId: null,
        loadedTransaction: null,
        selectedTransactions: [],
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

    function renderText(data) {
        if (data === undefined || data === null || data === '' || data === 'null') {
            return 'N/A';
        }
        const escapedValue = $('<div>').text(data).html();
        return `<span class="qc-cell-clip" title="${escapedValue}">${escapedValue}</span>`;
    }

    function isApproved(row) {
        return row && (row.approved_under_qc === true || row.approved_under_qc === 'true' || row.status === 'approved');
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
     * Initialize DataTable with QC configuration
     */
    function initializeDataTable() {
        state.qcTable = $('#qc_transactions_table').DataTable({
            responsive: true,
            processing: true,
            serverSide: true,
            autoWidth: false,
            ajax: {
                url: 'Case_Management_Serv',
                type: 'POST',
                dataType: 'json',
                dataFilter: function(response) {
                    return parseJsonSafely(response) ? response : emptyDataTableResponse();
                },
                data: function(d) {
                    state.lastDraw = d.draw || 1;
                    d.request_type = 'get_qc_pending_transactions';
                    d.search_reference = $('#qc_search_reference').val();
                    d.search_status = $('#qc_search_status').val();
                    d.date_from = $('#qc_date_from').val();
                    d.date_to = $('#qc_date_to').val();
                },
                dataSrc: function(json) {
                    const payload = parseJsonSafely(json);
                    return payload && Array.isArray(payload.data) ? payload.data : [];
                },
                error: function(xhr, error, thrown) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error loading transactions for QC'
                    });
                    console.error('QC DataTable Error:', error);
                }
            },
            columns: [
                {
                    data: null,
                    orderable: false,
                    searchable: false,
                    className: 'text-center',
                    render: function(data, type, row) {
                        if (isApproved(row) || row.status === 'rejected') {
                            return '';
                        }
                        return `<input type="checkbox" class="form-check-input qc-row-checkbox" data-id="${row.t_id}">`;
                    }
                },
                { data: 't_id', name: 't_id', defaultContent: 'N/A', render: renderText },
                { data: 'reference_number', name: 'reference_number', defaultContent: 'N/A', render: renderText },
                { data: 'jacket_name', name: 'jacket_name', defaultContent: 'N/A', render: renderText },
                { data: 'instrument_type', name: 'instrument_type', defaultContent: 'N/A', render: renderText },
                { data: 'party1_plaintiff', name: 'party1_plaintiff', defaultContent: 'N/A', render: renderText },
                { data: 'party2_defendant', name: 'party2_defendant', defaultContent: 'N/A', render: renderText },
                { data: 'entered_by', name: 'entered_by', defaultContent: 'N/A', render: renderText },
                { 
                    data: 'created_date',
                    name: 'created_date',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return formatDate(data);
                    }
                },
                { 
                    data: 'status',
                    name: 'status',
                    defaultContent: '',
                    render: function(data, type, row) {
                        return getQCStatusBadge(data, row.approved_under_qc);
                    }
                },
                {
                    data: null,
                    orderable: false,
                    render: function(data, type, row) {
                        return getQCActionButtons(row);
                    }
                }
            ],
            order: [[1, 'desc']],
            columnDefs: [
                { targets: 0, width: '42px', responsivePriority: 1 },
                { targets: 1, width: '64px', responsivePriority: 6 },
                { targets: 2, width: '14%', responsivePriority: 2 },
                { targets: 3, width: '18%', responsivePriority: 3 },
                { targets: 4, width: '12%', responsivePriority: 7 },
                { targets: 5, width: '14%', responsivePriority: 5 },
                { targets: 6, width: '14%', responsivePriority: 9 },
                { targets: 7, width: '10%', responsivePriority: 10 },
                { targets: 8, width: '96px', responsivePriority: 8 },
                { targets: 9, width: '112px', responsivePriority: 4, className: 'text-center' },
                { targets: 10, width: '76px', responsivePriority: 1, className: 'text-center' }
            ],
            pageLength: 25,
            lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
            language: {
                processing: '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>',
                emptyTable: 'No transactions pending QC',
                zeroRecords: 'No matching transactions found'
            },
            drawCallback: function(settings) {
                bindQCActionButtonEvents();
                bindSelectionEvents();
                restoreSelectedRows();
                updateBatchApprovalState();
            }
        });
    }

    /**
     * Bind event listeners to buttons and inputs
     */
    function bindEventListeners() {
        // Search button
        $('#btn_qc_search').on('click', function() {
            if (state.qcTable) {
                state.qcTable.ajax.reload();
            }
            loadStatistics();
        });

        // Reset button
        $('#btn_qc_reset').on('click', function() {
            resetQCSearchForm();
        });

        // Mark under review
        $('#btn_mark_under_review')
            .prop('disabled', true)
            .attr('title', 'Under review status is not available from this screen yet');

        // Approve transaction
        $('#btn_approve_transaction').on('click', function() {
            approveTransaction();
        });

        // Decline transaction
        $('#btn_decline_transaction').on('click', function() {
            declineTransaction();
        });

        // Confirm batch approve
        $('#btn_confirm_batch_approve').on('click', function() {
            confirmBatchApproval();
        });

        $('#btn_batch_approve_selected').on('click', function() {
            openBatchApprovalModal();
        });

        $('#select_all_qc_records').on('change', function() {
            const isChecked = $(this).is(':checked');
            $('#qc_transactions_table .qc-row-checkbox').prop('checked', isChecked).trigger('change');
        });

        // Export button
        $('#btn_qc_export').on('click', function() {
            exportQCData();
        });

        // Enter key on search inputs
        $('#qc_search_reference').on('keypress', function(e) {
            if (e.which === 13) {
                if (state.qcTable) {
                    state.qcTable.ajax.reload();
                }
                loadStatistics();
            }
        });
    }

    /**
     * Load transactions into DataTable
     */
    function loadTransactions() {
        if (state.qcTable) {
            state.qcTable.ajax.reload();
        }
    }

    function bindSelectionEvents() {
        $('#qc_transactions_table .qc-row-checkbox').off('change').on('change', function() {
            const transactionId = String($(this).data('id'));
            if ($(this).is(':checked')) {
                if (state.selectedTransactions.indexOf(transactionId) === -1) {
                    state.selectedTransactions.push(transactionId);
                }
            } else {
                state.selectedTransactions = state.selectedTransactions.filter(function(id) {
                    return id !== transactionId;
                });
            }
            updateBatchApprovalState();
        });
    }

    function restoreSelectedRows() {
        $('#qc_transactions_table .qc-row-checkbox').each(function() {
            const transactionId = String($(this).data('id'));
            $(this).prop('checked', state.selectedTransactions.indexOf(transactionId) !== -1);
        });
    }

    function updateBatchApprovalState() {
        const selectedCount = state.selectedTransactions.length;
        $('#selected_qc_count').text(selectedCount);
        $('#btn_batch_approve_selected').prop('disabled', selectedCount === 0);

        const availableRows = $('#qc_transactions_table .qc-row-checkbox');
        const checkedRows = availableRows.filter(':checked');
        $('#select_all_qc_records')
            .prop('checked', availableRows.length > 0 && checkedRows.length === availableRows.length)
            .prop('indeterminate', checkedRows.length > 0 && checkedRows.length < availableRows.length);
    }

    /**
     * Load QC statistics
     */
    function loadStatistics() {
        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'get_qc_statistics',
                search_reference: $('#qc_search_reference').val(),
                search_status: $('#qc_search_status').val(),
                date_from: $('#qc_date_from').val(),
                date_to: $('#qc_date_to').val()
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
        $('#stat_pending').text(data.pending || 0);
        $('#stat_under_review').text(data.under_review || 0);
        $('#stat_approved').text(data.approved_today || 0);
        $('#stat_rejected').text(data.rejected_today || 0);
    }

    /**
     * Open review modal for a transaction
     */
    function openReviewModal(transactionId) {
        state.currentReviewTransactionId = transactionId;
        
        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'get_regional_transaction_by_id',
                t_id: transactionId
            },
            cache: false,
            beforeSend: function() {
                // Show loading indicator if needed
            },
            success: function(response) {
                const payload = parseJsonSafely(response);
                const record = extractRecord(payload);
                
                if (record) {
                    state.loadedTransaction = record;
                    displayReviewDetails(record);
                    resetReviewForm();
                    $('#reviewTransactionModal').modal('show');
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
                console.error('Review Fetch Error:', xhr);
            }
        });
    }

    /**
     * Display transaction details in review modal
     */
    function displayReviewDetails(data) {
        const detailsHtml = `
            <div class="col-md-3">
                <label class="fw-bold text-muted small">Reference Number</label>
                <p class="mb-0">${data.reference_number || 'N/A'}</p>
            </div>
            <div class="col-md-3">
                <label class="fw-bold text-muted small">Jacket Name</label>
                <p class="mb-0">${data.jacket_name || 'N/A'}</p>
            </div>
            <div class="col-md-3">
                <label class="fw-bold text-muted small">Region</label>
                <p class="mb-0">${data.region || 'N/A'}</p>
            </div>
            <div class="col-md-3">
                <label class="fw-bold text-muted small">File Number</label>
                <p class="mb-0">${data.file_number || 'N/A'}</p>
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
                <label class="fw-bold text-muted small">Consideration</label>
                <p class="mb-0">${formatCurrency(data.consideration, data.consideration_currency)}</p>
            </div>
            <div class="col-md-3">
                <label class="fw-bold text-muted small">Premium</label>
                <p class="mb-0">${formatCurrency(data.premium, data.premium_currency)}</p>
            </div>
            <div class="col-md-6">
                <label class="fw-bold text-muted small">Party 1 (Plaintiff)</label>
                <p class="mb-0">${data.party1_plaintiff || 'N/A'}</p>
                <small class="text-muted">${data.party1_plaintiff_tel_no || ''} ${data.party1_plaintiff_email || ''}</small>
            </div>
            <div class="col-md-6">
                <label class="fw-bold text-muted small">Party 2 (Defendant)</label>
                <p class="mb-0">${data.party2_defendant || 'N/A'}</p>
                <small class="text-muted">${data.party2_defendant_tel_no || ''} ${data.party2_defendant_email || ''}</small>
            </div>
            <div class="col-md-12">
                <label class="fw-bold text-muted small">Remarks</label>
                <p class="mb-0">${data.remarks || 'N/A'}</p>
            </div>
            <div class="col-md-4">
                <label class="fw-bold text-muted small">Entered By</label>
                <p class="mb-0">${data.entered_by || 'N/A'}</p>
            </div>
            <div class="col-md-4">
                <label class="fw-bold text-muted small">Created Date</label>
                <p class="mb-0">${formatDate(data.created_date)}</p>
            </div>
            <div class="col-md-4">
                <label class="fw-bold text-muted small">Current Status</label>
                <p class="mb-0">${getQCStatusBadge(data.status, data.approved_under_qc)}</p>
            </div>
        `;
        $('#review_transaction_details').html(detailsHtml);
        $('#review_transaction_id').val(data.t_id);
    }

    /**
     * Reset review form fields
     */
    function resetReviewForm() {
        $('input[type="checkbox"][id^="qc_check_"]').prop('checked', false);
        $('#review_note').val('');
        $('#approve_note').val('');
        $('#decline_note').val('');
    }

    /**
     * Mark transaction as under review
     */
    function markTransactionUnderReview() {
        const transactionId = $('#review_transaction_id').val();
        
        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'mark_transaction_under_review',
                t_id: transactionId,
                review_note: $('#review_note').val()
            },
            cache: false,
            success: function(response) {
                const payload = parseJsonSafely(response);
                
                if (payload && (payload.success || payload.status === 'success')) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Transaction marked as under review',
                        timer: 2000,
                        showConfirmButton: false
                    });
                    $('#reviewTransactionModal').modal('hide');
                    loadTransactions();
                    loadStatistics();
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: (payload && payload.message) ? payload.message : 'Failed to update status'
                    });
                }
            },
            error: function(xhr) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error updating transaction status'
                });
                console.error('Mark Under Review Error:', xhr);
            }
        });
    }

    /**
     * Approve transaction after QC
     */
    function approveTransaction() {
        const transactionId = $('#review_transaction_id').val();
        const approveNote = $('#approve_note').val();
        const reviewNote = $('#review_note').val();

        // Validate checklist
        const checkedItems = $('input[type="checkbox"][id^="qc_check_"]:checked').length;
        if (checkedItems < 5) {
            Swal.fire({
                icon: 'warning',
                title: 'Incomplete Checklist',
                text: 'Please complete at least 5 checklist items before approving.'
            });
            return;
        }

        Swal.fire({
            title: 'Approve Transaction?',
            text: 'Are you sure you want to approve this transaction?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Yes, Approve',
            cancelButtonText: 'Cancel',
            customClass: {
                cancelButton: 'btn btn-outline-dark',
                confirmButton: 'btn btn-success'
            },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST',
                    url: 'Case_Management_Serv',
                    data: {
                        request_type: 'approve_transaction_qc',
                        t_id: transactionId,
                        approval_remarks: approveNote,
                        review_note: reviewNote
                    },
                    cache: false,
                    success: function(response) {
                        const payload = parseJsonSafely(response);
                        
                        if (payload && (payload.success || payload.status === 'success')) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Approved!',
                                text: 'Transaction approved successfully',
                                timer: 2000,
                                showConfirmButton: false
                            });
                            $('#reviewTransactionModal').modal('hide');
                            state.selectedTransactions = state.selectedTransactions.filter(function(id) {
                                return id !== String(transactionId);
                            });
                            loadTransactions();
                            loadStatistics();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: (payload && payload.message) ? payload.message : 'Failed to approve transaction'
                            });
                        }
                    },
                    error: function(xhr) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error approving transaction'
                        });
                        console.error('Approve Error:', xhr);
                    }
                });
            }
        });
    }

    /**
     * Decline/reject transaction
     */
    function declineTransaction() {
        const transactionId = $('#review_transaction_id').val();
        const declineNote = $('#decline_note').val();

        if (!declineNote || declineNote.trim() === '') {
            Swal.fire({
                icon: 'warning',
                title: 'Decline Reason Required',
                text: 'Please provide a reason for declining this transaction.'
            });
            $('#decline_note').focus();
            return;
        }

        Swal.fire({
            title: 'Decline Transaction?',
            text: 'Are you sure you want to decline this transaction?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, Decline',
            cancelButtonText: 'Cancel',
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
                        request_type: 'decline_transaction_qc',
                        t_id: transactionId,
                        decline_reason: declineNote,
                        review_note: $('#review_note').val()
                    },
                    cache: false,
                    success: function(response) {
                        const payload = parseJsonSafely(response);
                        
                        if (payload && (payload.success || payload.status === 'success')) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Declined',
                                text: 'Transaction declined',
                                timer: 2000,
                                showConfirmButton: false
                            });
                            $('#reviewTransactionModal').modal('hide');
                            loadTransactions();
                            loadStatistics();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: (payload && payload.message) ? payload.message : 'Failed to decline transaction'
                            });
                        }
                    },
                    error: function(xhr) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error declining transaction'
                        });
                        console.error('Decline Error:', xhr);
                    }
                });
            }
        });
    }

    function openBatchApprovalModal() {
        const transactionIds = state.selectedTransactions.slice();

        if (transactionIds.length === 0) {
            Swal.fire({
                icon: 'warning',
                title: 'No Transactions Selected',
                text: 'Please select at least one transaction to approve.'
            });
            return;
        }

        const selectedRecords = [];
        state.qcTable.rows().every(function() {
            const row = this.data();
            if (row && transactionIds.indexOf(String(row.t_id)) !== -1) {
                selectedRecords.push(row);
            }
        });

        const listHtml = selectedRecords.length
            ? `<div class="table-responsive"><table class="table table-sm table-bordered mb-0">
                    <thead><tr><th>ID</th><th>Reference Number</th><th>Jacket Name</th></tr></thead>
                    <tbody>${selectedRecords.map(function(row) {
                        return `<tr><td>${renderText(row.t_id)}</td><td>${renderText(row.reference_number)}</td><td>${renderText(row.jacket_name)}</td></tr>`;
                    }).join('')}</tbody>
               </table></div>`
            : `<div class="alert alert-warning mb-0">${transactionIds.length} selected transaction(s). Some selected rows are on another page.</div>`;

        $('#batch_transactions_list').html(listHtml);
        $('#batch_approval_note').val('');
        $('#batchApprovalModal').modal('show');
    }

    /**
     * Confirm batch approval
     */
    function confirmBatchApproval() {
        const transactionIds = state.selectedTransactions.slice();
        const batchNote = $('#batch_approval_note').val();

        if (transactionIds.length === 0) {
            $('#batchApprovalModal').modal('hide');
            updateBatchApprovalState();
            return;
        }

        Swal.fire({
            title: `Approve ${transactionIds.length} Transactions?`,
            text: 'This action cannot be undone.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, Approve All',
            cancelButtonText: 'Cancel',
            customClass: {
                cancelButton: 'btn btn-outline-dark',
                confirmButton: 'btn btn-success'
            },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST',
                    url: 'Case_Management_Serv',
                    data: {
                        request_type: 'batch_approve_qc',
                        transaction_ids: JSON.stringify(transactionIds),
                        approval_remarks: batchNote
                    },
                    cache: false,
                    success: function(response) {
                        const payload = parseJsonSafely(response);
                        
                        if (payload && (payload.success || payload.status === 'success')) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: `${transactionIds.length} transactions approved successfully`,
                                timer: 2000,
                                showConfirmButton: false
                            });
                            $('#batchApprovalModal').modal('hide');
                            state.selectedTransactions = [];
                            $('#select_all_qc_records').prop('checked', false).prop('indeterminate', false);
                            loadTransactions();
                            loadStatistics();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: (payload && payload.message) ? payload.message : 'Failed to approve transactions'
                            });
                        }
                    },
                    error: function(xhr) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error during batch approval'
                        });
                        console.error('Batch Approve Error:', xhr);
                    }
                });
            }
        });
    }

    /**
     * Reset QC search form
     */
    function resetQCSearchForm() {
        $('#qc_search_reference').val('');
        $('#qc_search_status').val('');
        $('#qc_date_from').val('');
        $('#qc_date_to').val('');
        if (state.qcTable) {
            state.qcTable.ajax.reload();
        }
        loadStatistics();
    }

    /**
     * Export QC data
     */
    function exportQCData() {
        window.location.href = 'Case_Management_Serv?request_type=export_qc_data&' +
            'search_reference=' + encodeURIComponent($('#qc_search_reference').val()) +
            '&search_status=' + encodeURIComponent($('#qc_search_status').val()) +
            '&date_from=' + encodeURIComponent($('#qc_date_from').val()) +
            '&date_to=' + encodeURIComponent($('#qc_date_to').val());
    }

    /**
     * Get QC status badge HTML
     */
    function getQCStatusBadge(status, approvedUnderQc) {
        if (approvedUnderQc === true || approvedUnderQc === 'true') {
            return '<span class="badge bg-success">Approved</span>';
        }
        
        const badges = {
            'pending': '<span class="badge bg-warning">Pending</span>',
            'under_review': '<span class="badge bg-info">Under Review</span>',
            'approved': '<span class="badge bg-success">Approved</span>',
            'rejected': '<span class="badge bg-danger">Rejected</span>'
        };
        return badges[status] || '<span class="badge bg-secondary">' + renderText(status) + '</span>';
    }

    /**
     * Get QC action buttons HTML
     */
    function getQCActionButtons(row) {
        let buttons = `
            <div class="qc-actions">
                <button type="button" class="btn btn-sm btn-warning btn-qc-review" data-id="${row.t_id}" title="Review">
                    <i class="ri-eye-line"></i>
                </button>
        `;
        
        if (!row.approved_under_qc && row.status !== 'rejected') {
            buttons += `
                <button type="button" class="btn btn-sm btn-success btn-qc-quick-approve" data-id="${row.t_id}" title="Quick Approve">
                    <i class="ri-checkbox-circle-line"></i>
                </button>
            `;
        }
        
        return buttons + '</div>';
    }

    /**
     * Bind events to QC action buttons
     */
    function bindQCActionButtonEvents() {
        $('.btn-qc-review').off('click').on('click', function() {
            const id = $(this).data('id');
            openReviewModal(id);
        });

        $('.btn-qc-quick-approve').off('click').on('click', function() {
            const id = $(this).data('id');
            quickApproveTransaction(id);
        });
    }

    /**
     * Quick approve transaction without opening modal
     */
    function quickApproveTransaction(transactionId) {
        Swal.fire({
            title: 'Quick Approve?',
            text: 'Approve this transaction without detailed review?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Yes, Approve',
            cancelButtonText: 'Cancel',
            customClass: {
                cancelButton: 'btn btn-outline-dark',
                confirmButton: 'btn btn-success'
            },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST',
                    url: 'Case_Management_Serv',
                    data: {
                        request_type: 'approve_transaction_qc',
                        t_id: transactionId,
                        approval_remarks: 'Quick approved from QC list',
                        review_note: 'Quick approval'
                    },
                    cache: false,
                    success: function(response) {
                        const payload = parseJsonSafely(response);
                        
                        if (payload && (payload.success || payload.status === 'success')) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Approved!',
                                text: 'Transaction approved successfully',
                                timer: 2000,
                                showConfirmButton: false
                            });
                            state.selectedTransactions = state.selectedTransactions.filter(function(id) {
                                return id !== String(transactionId);
                            });
                            loadTransactions();
                            loadStatistics();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: (payload && payload.message) ? payload.message : 'Failed to approve transaction'
                            });
                        }
                    },
                    error: function(xhr) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error approving transaction'
                        });
                        console.error('Quick Approve Error:', xhr);
                    }
                });
            }
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
        if (!amount || amount === '0' || amount === 0 || amount === 'null') return 'N/A';
        return `${currency || 'GHS'} ${parseFloat(amount).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
    }

    /**
     * Initialize the page when DOM is ready
     */
    $(function() {
        initializeDataTable();
        bindEventListeners();
        loadStatistics();
        loadTransactions();
    });

}(jQuery));
