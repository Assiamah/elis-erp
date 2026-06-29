$(document).ready(function() {
    const state = {
        transaction: null,
        parcel: null,
        linked: null
    };

    function formatText(value) {
        return value !== undefined && value !== null && value !== '' ? value : '-';
    }

    function updateTransactionSummary() {
        $('#link_txn_summary_reference').text(formatText(state.transaction?.reference_number || state.transaction?.job_number));
        $('#link_txn_summary_type').text(formatText(state.transaction?.instrument_type));
        $('#link_txn_summary_date').text(formatText(state.transaction?.instrument_date || state.transaction?.consent_date));
        $('#link_txn_summary_party1').text(formatText(state.transaction?.party1_plaintiff));
        $('#link_txn_summary_party2').text(formatText(state.transaction?.party2_defendant));
        $('#link_txn_summary_remarks').text(formatText(state.transaction?.remarks));
    }

    function updateParcelSummary() {
        $('#link_parcel_summary_property').text(formatText(state.parcel?.property_number));
        $('#link_parcel_summary_reference').text(formatText(state.parcel?.reference_number));
        $('#link_parcel_summary_locality').text(formatText(state.parcel?.locality));
        $('#link_parcel_summary_nt').text(formatText(state.parcel?.nt_number));
    }

    function refreshLinkStatus() {
        if (state.linked) {
            $('#link_summary_status').removeClass('alert-danger').addClass('alert-success').text('Transaction and parcel are linked.');
            $('#linked_txn_reference').text(formatText(state.linked.transaction.reference_number || state.linked.transaction.job_number));
            $('#linked_parcel_reference').text(formatText(state.linked.parcel.reference_number || state.linked.parcel.property_number));
        } else {
            $('#link_summary_status').removeClass('alert-success').addClass('alert-secondary').text('No linked records yet.');
            $('#linked_txn_reference').text('-');
            $('#linked_parcel_reference').text('-');
        }
    }

    function setSearchStatus(message, type) {
        const status = $('#link_txn_search_status');
        status.removeClass('alert-success alert-danger alert-warning');
        if (type === 'success') {
            status.addClass('alert-success');
        } else if (type === 'error') {
            status.addClass('alert-danger');
        } else if (type === 'warning') {
            status.addClass('alert-warning');
        }
        status.text(message).removeClass('d-none');
    }

    function clearSearchStatus() {
        $('#link_txn_search_status').addClass('d-none').text('');
    }

    function renderTransactionRows(transactions) {
        const table = $('#pvlmd_transaction_all_dataTable tbody');
        table.empty();

        if (!Array.isArray(transactions) || transactions.length === 0) {
            table.append('<tr><td colspan="6" class="text-center text-muted">No transactions found.</td></tr>');
            return;
        }

        transactions.forEach(function(tx, index) {
            const jobRef = formatText(tx.reference_number || tx.job_number || tx.doc_number);
            const instrument = formatText(tx.instrument_type);
            const date = formatText(tx.instrument_date || tx.consent_date);
            const party = formatText(tx.party1_plaintiff);
            const counterParty = formatText(tx.party2_defendant);
            const escapedJob = $('<div/>').text(jobRef).html();
            const escapedInstrument = $('<div/>').text(instrument).html();
            const jobNumber = tx.job_number || tx.doc_number || '';
            const transactionId = tx.t_id || '';

            table.append(`
                <tr>
                    <td>${escapedJob}</td>
                    <td>${escapedInstrument}</td>
                    <td>${date}</td>
                    <td>${party}</td>
                    <td>${counterParty}</td>
                    <td class="text-center">
                        <button type="button" class="btn btn-sm btn-outline-primary select-transaction" data-index="${index}"
                            data-reference="${escapedJob}"
                            data-instrument="${escapedInstrument}"
                            data-date="${date}"
                            data-party1="${$('<div/>').text(tx.party1_plaintiff || '').html()}"
                            data-party2="${$('<div/>').text(tx.party2_defendant || '').html()}"
                            data-remarks="${$('<div/>').text(tx.remarks || '').html()}"
                            data-doc-number="${jobNumber}"
                            data-transaction-id="${transactionId}">
                            Select
                        </button>
                    </td>
                </tr>
            `);
        });
    }

    $('#pvlmd_btn_search_transaction').on('click', function() {
        const searchValue = $('#pvlmd_search_transaction_by_text').val().trim();
        if (!searchValue) {
           // setSearchStatus('Please enter a job or transaction number to search.', 'error');
           swal.fire({
                title: 'Error',
                text: 'Please enter a job or transaction number to search.',
                icon: 'error',
                confirmButtonText: 'OK'
            });

            $('#pvlmd_search_transaction_by_text').focus();

            return;
        }

        clearSearchStatus();
        const table = $('#pvlmd_transaction_all_dataTable tbody');
        table.empty();

        $.ajax({
            type: 'POST',
            url: 'Maps',
            data: {
                request_type: 'pvlmd_transaction_select_by_reference_number',
                reference_number: searchValue,
                gid_fk: 0
            },
            cache: false,
            success: function(response) {
                let payload;
                try {
                    payload = JSON.parse(response);
                } catch (error) {
                    setSearchStatus('Unexpected response from transaction search.', 'error');
                    return;
                }

                if (payload && Array.isArray(payload.data) && payload.data.length > 0) {
                    renderTransactionRows(payload.data);
                    setSearchStatus(payload.data.length + ' transaction(s) found.', 'success');
                    
                } else {
                    renderTransactionRows([]);
                    setSearchStatus('No transactions found for that number.', 'warning');
                }
            },
            error: function() {
                setSearchStatus('Unable to load transaction details. Please try again.', 'error');
            }
        });
    });

    $('#pvlmd_transaction_all_dataTable').on('click', '.select-transaction', function() {
        const button = $(this);
        console.log('Transaction selected:', button.data());
        state.transaction = {
            reference_number: button.data('reference'),
            instrument_type: button.data('instrument'),
            instrument_date: button.data('date'),
            party1_plaintiff: button.data('party1'),
            party2_defendant: button.data('party2'),
            remarks: button.data('remarks')
        };
        $('#link_txn_selected_id').val(button.data('transaction-id'));
        $('#link_txn_reference_number').val(button.data('doc-number'));
        $('#linked_txn_reference').text(formatText(button.data('doc-number')));
        updateTransactionSummary();
        setSearchStatus('Selected transaction: ' + formatText(state.transaction.reference_number), 'success');

        const link_txn_selected_id = $('#link_txn_selected_id').val();
        const link_parcel_selected_id = $('#link_parcel_reference').val();
        if (link_txn_selected_id && link_parcel_selected_id) {
            $('#pvlmd_btn_link_transaction_and_parcel').prop('disabled', false);
        } else {
            $('#pvlmd_btn_link_transaction_and_parcel').prop('disabled', true);
        }
    });

    $('#pvlmdparcelinformation').on('shown.bs.modal', function() {
        const propertyNumber = $('#pvlmd_property_number').text().trim();
        if (!propertyNumber || propertyNumber === '-') {
            return;
        }

        state.parcel = {
            property_number: propertyNumber,
            reference_number: $('#link_parcel_summary_reference').text().trim(),
            locality: $('#link_parcel_summary_locality').text().trim(),
            nt_number: $('#pvlmd_nt_number').text().trim()
        };
        updateParcelSummary();
    });

    $('#pvlmd_btn_link_transaction_and_parcel').on('click', function() {
        const link_txn_selected_id = $('#link_txn_selected_id').val();
        const link_parcel_selected_id = $('#link_parcel_reference').val();

        if (!link_txn_selected_id) {
            Swal.fire({
                title: 'Error',
                text: 'Select a transaction before linking.',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return;
        }

        if (!link_parcel_selected_id) {
            Swal.fire({
                title: 'Error',
                text: 'Select a parcel from the map results before linking.',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return;
        }

        // Show confirmation dialog before proceeding
        Swal.fire({
            title: 'Confirm Link',
            text: 'Are you sure you want to link this transaction and parcel?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, link them!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                // Proceed with linking logic here
                $.ajax({
                    type: 'POST',
                    url: 'Maps',
                    data: {
                        request_type: 'pvlmd_link_transaction_and_parcel',
                        transaction_reference: link_txn_selected_id,
                        parcel_reference: link_parcel_selected_id
                    },
                    cache: false,
                    success: function(response) {
                        let payload;
                        try {
                            payload = JSON.parse(response);
                        } catch (error) {
                            Swal.fire({
                                title: 'Error',
                                text: 'Unexpected response from server.',
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                            return;
                        }

                        if (payload && payload.success) {
                            state.linked = {
                                transaction: state.transaction,
                                parcel: state.parcel
                            };
                            //refreshLinkStatus();
                            Swal.fire({
                                title: 'Success',
                                text: 'Transaction and parcel are linked successfully.',
                                icon: 'success',
                                confirmButtonText: 'OK'
                            });
                        } else {
                            Swal.fire({
                                title: 'Error',
                                text: payload.message || 'Failed to link transaction and parcel.',
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        }
                    },
                    error: function() {
                        Swal.fire({
                            title: 'Error',
                            text: 'Unable to link transaction and parcel. Please try again.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            }
        });
    });

    refreshLinkStatus();
});
