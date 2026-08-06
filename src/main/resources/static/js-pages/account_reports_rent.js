$(document).ready(function() {
    $(document).on('click', '.set_as_recorded', function(e) {
        e.preventDefault();

        const $button = $(this);
        const refNumber = $button.data('ref_number');

        Swal.fire({
            title: 'Set payment as updated?',
            text: 'Are you sure you want to set this payment as updated? This action cannot be reversed.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '<i class="fa fa-check"></i> Confirm',
            cancelButtonText: '<i class="fa fa-times"></i> Cancel',
            confirmButtonColor: '#198754',
            cancelButtonColor: '#6c757d',
            reverseButtons: true
        }).then(function(result) {
            if (!result.isConfirmed) {
                return;
            }

            $.ajax({
                type: 'POST',
                url: 'Case_Management_Serv',
                data: {
                    request_type: 'account_report_on_ground_rent_bill_update',
                    ref_number: refNumber
                },
                cache: false,
                success: function(jobdetails) {
                    if (String(jobdetails).includes('Success')) {
                        const $row = $button.closest('tr');

                        $row.find('.status-badge')
                            .removeClass('bg-danger')
                            .addClass('bg-success')
                            .text('Recorded');
                        $button.closest('td').empty();

                        if ($.fn.DataTable.isDataTable('#tbl_transactions_result')) {
                            $('#tbl_transactions_result')
                                .DataTable()
                                .row($row)
                                .invalidate('dom')
                                .draw(false);
                        }

                        Swal.fire({
                            title: 'Success',
                            text: 'Payment set as updated successfully.',
                            icon: 'success',
                            confirmButtonColor: '#198754'
                        });
                    } else {
                        Swal.fire({
                            title: 'Update failed',
                            text: 'Sorry, something went wrong while updating the payment.',
                            icon: 'error',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        title: 'Request failed',
                        text: 'The payment could not be updated. Please try again.',
                        icon: 'error',
                        confirmButtonColor: '#dc3545'
                    });
                }
            });
        });
    });

    if (!$.fn.DataTable.isDataTable('#tbl_transactions_result')) {
        $('#tbl_transactions_result').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            ]
        });
    }
});
