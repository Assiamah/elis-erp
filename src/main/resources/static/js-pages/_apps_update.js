$(document).ready(function() {
    // ==================== CONSTANTS & CONFIG ====================
    const AJAX_URL = "Case_Management_Serv";
    const MIN_SEARCH_CHARS = 4;
    
    // ==================== UTILITY FUNCTIONS ====================
    const showNotification = (message, type = 'info', icon = 'fa-info-circle') => {
        const swalIcon = type === 'danger' ? 'error' : type;
        
        Swal.fire({
            icon: swalIcon,
            html: `<div class="text-center">
                  <!--  <i class="fa ${icon} fa-2x mb-2" style="color: ${getIconColor(type)}"></i> -->
                    <p class="mb-0 fw-bold">${message}</p>
                </div>`,
            showConfirmButton: false,
            timer: 3000,
            //toast: true,
            //position: 'top-end',
            //timerProgressBar: true,
            background: '#fff',
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer);
                toast.addEventListener('mouseleave', Swal.resumeTimer);
            }
        });
    };

    // Helper function to get icon color
    function getIconColor(type) {
        const colors = {
            'success': '#28a745',
            'danger': '#dc3545',
            'error': '#dc3545',
            'warning': '#ffc107',
            'info': '#17a2b8',
            'primary': '#007bff',
            'dark': '#343a40'
        };
        return colors[type] || '#17a2b8';
    }

    const showSuccess = (msg) => showNotification(msg, 'success', 'fa-check-circle');
    const showError = (msg) => showNotification(msg, 'danger', 'fa-exclamation-triangle');
    const showWarning = (msg) => showNotification(msg, 'warning', 'fa-exclamation-triangle');
    const showInfo = (msg) => showNotification(msg, 'info', 'fa-info-circle');

    const confirmAction = (message) => {
        return confirm(message);
    };

    const clearFormFields = (formSelector) => {
        $(formSelector).find('input[type!="radio"], textarea').val('');
        $(formSelector).find('select').prop('selectedIndex', 0);
    };

    // ==================== DATA TABLE INITIALIZATION ====================
    const datatable = $("#job_casemgtdetailsdataTable_req").DataTable({
        stateSave: true,
        responsive: true,
        language: {
            emptyTable: "No data available",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            infoEmpty: "Showing 0 to 0 of 0 entries",
            search: "<i class='fa fa-search'></i> Search:",
            paginate: {
                first: '<i class="fa fa-angle-double-left"></i>',
                previous: '<i class="fa fa-angle-left"></i>',
                next: '<i class="fa fa-angle-right"></i>',
                last: '<i class="fa fa-angle-double-right"></i>'
            }
        },
        createdRow: function(row, data, dataIndex) {
            if (data[0] == "1") {
                $(row).addClass('tr-completed-work table-success');
            }
        }
    });

    // ==================== SEARCH FUNCTIONALITY ====================
    const SearchManager = {
        validateSearch: function(type, value) {
            if (!type) {
                showError('Please select a search type');
                return false;
            }
            if (value.length < MIN_SEARCH_CHARS) {
                showError(`Please enter ${MIN_SEARCH_CHARS} or more characters to search`);
                return false;
            }
            return true;
        },

        loadJobDetails: function(jobNumber) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'load_application_details_by_job_number_within_unit',
                    job_number: jobNumber.toUpperCase()
                },
                cache: false
            });
        },

        loadMilestones: function(businessProcessId, subServiceId) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'get_tracking_milestones',
                    main_service_id: businessProcessId,
                    sub_service_id: subServiceId
                },
                cache: false
            });
        },

        populateJobDetails: function(data) {
            const jobDetail = data.job_detail;
            const transactionDetail = data.transaction_details;
            const parcelDetail = data.parcel_details;

            // Personal Details
            $("#fe_client_name, #bl_ar_name_msu").val(transactionDetail.ar_name);
            
            // Job Details
            $("#fe_job_number, #bl_job_number_msu").val(jobDetail.job_number);
            $("#febusiness_process_sub_name, #bl_business_process_sub_name_msu").val(jobDetail.business_process_sub_name);
            
            // Transaction Details
            $("#fe_nature_of_instrument").val(transactionDetail.nature_of_instrument);
            $("#fe_type_of_interest").val(transactionDetail.type_of_interest);
            $("#fe_type_of_use").val(transactionDetail.type_of_use);
            $("#fe_consideration_fee").val(transactionDetail.consideration_fee);
            $("#fe_date_of_document").val(transactionDetail.date_of_document);
            $("#fe_commencement_date").val(transactionDetail.commencement_date);
            $("#fe_transaction_number").val(transactionDetail.transaction_number);
            $("#fe_term").val(transactionDetail.term);
            $("#fe_renewal_term").val(transactionDetail.renewal_term);
            $("#fe_family_name").val(transactionDetail.stool_family_name);
            $("#fe_grantor_family").val(transactionDetail.family_of_grantor);
            $("#fe_annual_rent").val(transactionDetail.annual_rent);
            $("#fe_file_number").val(transactionDetail.case_file_number);
            $("#fe_case_number").val(transactionDetail.case_number);
            
            // Parcel Details
            $("#fe_surveyor_number").val(parcelDetail.licensed_no);
            $("#fe_regional_number").val(parcelDetail.regional_number);
            $("#fe_land_size").val(parcelDetail.land_size);
            $("#fe_locality").val(parcelDetail.locality);
            $("#fe_district").val(parcelDetail.district);
            $("#fe_region").val(parcelDetail.region);
            $("#fe_extent").val(parcelDetail.extent);
            $("#fe_registry_mapref").val(parcelDetail.registry_mapref);

            // Service IDs
            $("#main_service_id_fe").val(jobDetail.business_process_id);
            $("#main_service_sub_id_fe").val(jobDetail.business_process_sub_id);

            return {
                businessProcessId: jobDetail.business_process_id,
                subServiceId: jobDetail.business_process_sub_id
            };
        },

        populateMilestonesTable: function(milestones) {
            const table = $('#tbl_list_of_milestone_stone_dataTable');
            table.find("tbody tr").remove();

            if (milestones.data && milestones.data.length) {
                milestones.data.forEach(function(milestone) {
                    table.append(`
                        <tr id='row' class='bg-success text-white' data-toggle='tooltip' 
                            title='Application Stage Completed' data-placement='left'>
                            <td>${milestone.milestone_description}</td>
                            <td>${milestone.priority_value}</td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" 
                                           name="selectmiletonestagerb" 
                                           value="${milestone.priority_value}">
                                </div>
                            </td>
                        </tr>
                    `);
                });
                $('.mile_stone_details').show();
                $('[data-toggle="tooltip"]').tooltip();
            }
        },

        handleJobNumberSearch: function() {
            const jobNumber = $("#search_job_number").val().trim();
            
            if (!jobNumber) {
                showError('Please enter a job number');
                return;
            }

            this.loadJobDetails(jobNumber)
                .done((response) => {
                    if (response === 'Error in loading Data') {
                        $('.mile_stone_details').hide();
                        showError('Job number not found');
                        return;
                    }

                    const data = JSON.parse(response);
                    const ids = this.populateJobDetails(data);
                    
                    // Load milestones
                    this.loadMilestones(ids.businessProcessId, ids.subServiceId)
                        .done((milestones) => {
                            this.populateMilestonesTable(JSON.parse(milestones));
                        })
                        .fail(() => showError('Failed to load milestones'));
                })
                .fail(() => showError('Failed to load job details'));
        }
    };

    // ==================== REQUEST MANAGEMENT ====================
    const RequestManager = {
        loadApplicationDetails: function(jobNumber) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'select_load_app_details_for_request',
                    job_number: jobNumber
                },
                cache: false
            });
        },

        sendRequest: function(data) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'select_send_request_for_app',
                    job_number: data.jobNumber,
                    req_to: data.reqTo,
                    req_note: data.reqNote,
                    req_to_id: data.reqToId
                },
                cache: false
            });
        },

        respondToRequest: function(data) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'select_respond_to_app_request',
                    job_number: data.jobNumber,
                    response_type: data.responseType,
                    resquest_id: data.requestId,
                    response_note: data.responseNote
                },
                cache: false
            });
        },

        loadInbox: function(inboxType) {
            datatable.state.clear();
            
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'load_request_apps_at_unit_by_inbox_type',
                    inbox_type: inboxType
                },
                cache: false
            });
        },

        renderInboxTable: function(data, inboxType) {
            datatable.clear().draw();
            
            // Reset styling
            $("#body-bg-1, #body-bg-2").removeClass('bg-dark');
            $("#incoming_count, #outgoing_count").removeClass('text-white').addClass('text-gray-800');

            if (data.data && data.data.length) {
                data.data.forEach(function(item) {
                    const statusBadge = this.getStatusBadge(item.req_status);
                    const actionButton = this.getActionButton(item, inboxType);
                    
                    datatable.row.add([
                        '<input type="checkbox" class="form-check-input">',
                        item.created_on,
                        item.job_number,
                        item.req_from,
                        item.req_to,
                        statusBadge,
                        actionButton
                    ]).draw(false);
                }, this);
            }

            // Update styling based on inbox type
            this.updateInboxStyling(inboxType);
        },

        getStatusBadge: function(status) {
            const badges = {
                'pending': '<span class="badge bg-warning text-dark">Pending</span>',
                'approved': '<span class="badge bg-success">Approved</span>',
                'declined': '<span class="badge bg-danger">Declined</span>'
            };
            return `<div class="text-center">${badges[status] || badges.pending}</div>`;
        },

        getActionButton: function(item, inboxType) {
            if (inboxType == 1) {
                return `
                    <form action="app_request_details" method="post">
                        <input type="hidden" name="req_id" value="${item.req_id}">
                        <input type="hidden" name="request_type" value="load_app_request_details">
                        <button type="submit" class="btn btn-primary btn-sm w-100">
                            <i class="fa fa-eye me-1"></i>View Details
                        </button>
                    </form>
                `;
            } else {
                return `
                    <button type="button" class="btn btn-primary btn-sm w-100" 
                            data-bs-toggle="modal" data-bs-target="#view_response_details_modal"
                            data-req_id="${item.req_id}" 
                            data-job_number="${item.job_number}"
                            data-accepted_by="${item.accepted_by || ''}" 
                            data-req_status="${item.req_status}"
                            data-response_note="${item.response_note || ''}" 
                            data-accepted_on="${item.accepted_on || ''}">
                        <i class="fa fa-eye me-1"></i>View Details
                    </button>
                `;
            }
        },

        updateInboxStyling: function(inboxType) {
            $(".btn-to-be-disabled").prop('disabled', inboxType === 1);
            
            if (inboxType === 1) {
                $("#body-bg-1").addClass('bg-dark');
                $("#incoming_count").removeClass('text-gray-800').addClass('text-white');
            } else if (inboxType === 2) {
                $("#body-bg-2").addClass('bg-dark');
                $("#outgoing_count").removeClass('text-gray-800').addClass('text-white');
            }
        }
    };

    // ==================== ENQUIRY SEARCH ====================
    const EnquiryManager = {
        search: function(searchType, searchValue) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'load_application_details_for_enquiries',
                    job_number: searchValue,
                    search_type: searchType
                },
                cache: false
            });
        },

        addToResultsTable: function(data) {
            const table = $('#tbl-appData_tranfer');
            let addedCount = 0;

            data.forEach(function(item) {
                if (!this.isJobNumberExists(item.job_number)) {
                    this.addRow(item);
                    addedCount++;
                } else {
                    showInfo(`Job number ${item.job_number} is already in the table`);
                }
            }, this);

            if (addedCount > 0) {
                showSuccess(`${addedCount} record(s) added successfully`);
            }
        },

        isJobNumberExists: function(jobNumber) {
            let exists = false;
            $('#tbl-appData_tranfer tbody tr').each(function() {
                if ($(this).find('td').eq(2).text().trim() === jobNumber) {
                    exists = true;
                    return false;
                }
            });
            return exists;
        },

        addRow: function(item) {
            //if (item && item.length >= 1) {
               $("#no-results-row").addClass('d-none');
           // }
            const row = $(`
                <tr>
                    <td>${item.ar_name || 'N/A'}</td>
                    <td>${item.case_number || 'N/A'}</td>
                    <td>${item.job_number || 'N/A'}</td>
                    <td>${item.business_process_sub_name || 'N/A'}</td>
                    <td>${item.locality || 'N/A'}</td>
                    <td>${item.regional_number || 'N/A'}</td>
                    <td>
                        <button type="button" class="btn btn-outline-danger btn-sm remove-row-btn">
                            <i class="fa fa-trash-alt me-1"></i>Remove
                        </button>
                    </td>
                </tr>
            `);
            
            $('#tbl-appData_tranfer tbody').append(row);
        },

        // removeAllRows: function() {
        //     if (confirmAction("Are you sure you want to remove all rows?")) {
        //         $('#tbl-appData_tranfer tbody').empty();
        //         showSuccess('All rows removed');
        //     }
        // }

        removeAllRows: function() {
            Swal.fire({
                title: 'Remove all rows?',
                text: 'This action cannot be undone',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes, remove',
                cancelButtonText: 'No, keep',
                reverseButtons: true,
                buttonsStyling: true
            }).then((result) => {
                if (result.isConfirmed) {
                    $('#tbl-appData_tranfer tbody').empty();
                    
                    // Show success toast
                    Swal.fire({
                        icon: 'success',
                        title: 'All rows removed',
                        showConfirmButton: false,
                        timer: 1500,
                        //toast: true,
                        //position: 'top-end'
                    });
                }
            });
        }
    };

    // ==================== MILESTONE MANAGEMENT ====================
    const MilestoneManager = {
        updateApplicationStage: function(jobNumber, stage) {
            return $.ajax({
                type: "POST",
                url: AJAX_URL,
                data: {
                    request_type: 'select_update_application_stage_for_a_job',
                    job_number: jobNumber,
                    application_stage: stage
                },
                cache: false
            });
        },

        handleUpdate: function() {
            const stage = $('input:radio[name="selectmiletonestagerb"]:checked').val();
            const jobNumber = $("#bl_job_number_msu").val();

            if (!stage) {
                showError('Please select a milestone stage');
                return;
            }

            if (!jobNumber) {
                showError('Job number not found');
                return;
            }

            if (!confirmAction('Are you sure you want to update the application stage?')) {
                return;
            }

            this.updateApplicationStage(jobNumber, stage)
                .done((response) => {
                    const result = JSON.parse(response);
                    if (result.success) {
                        showSuccess('Milestone has been updated successfully');
                        setTimeout(() => location.reload(), 2000);
                    } else {
                        showError('Failed to update milestone');
                    }
                })
                .fail(() => showError('Failed to update milestone'));
        }
    };

    // ==================== EVENT HANDLERS ====================
    
    // Job Number Search
    $('#btnJobNumberSearch_mm').on('click', function(e) {
        e.preventDefault();
        SearchManager.handleJobNumberSearch();
    });

    // Milestone Update
    $('#btn_update_milestone_status_for_application_mm').on('click', function(e) {
        e.preventDefault();
        MilestoneManager.handleUpdate();
    });

    // Load Application Details for Request
    $('#btn_load_app_details_req').on('click', function(e) {
        e.preventDefault();
        
        const jobNumber = $("#req_job_number").val().trim();
        
        if (!jobNumber) {
            showError('Please enter a job number');
            return;
        }

        RequestManager.loadApplicationDetails(jobNumber)
            .done((response) => {
                const data = JSON.parse(response);
                
                if (data.success) {
                    $("#req_app_name").val(data.data.ar_name);
                    $("#req_to").val(data.data.job_recieved_by);
                    $("#req_to_id").val(data.data.job_recieved_by_id);
                    showSuccess('Application details loaded');
                } else {
                    showError('Job number not found');
                }
            })
            .fail(() => showError('Failed to load application details'));
    });

    // Make Request
    $('#btn_make_request').on('click', function(e) {
        e.preventDefault();
        
        const requestData = {
            jobNumber: $('#req_job_number').val().trim(),
            reqTo: $('#req_to').val().trim(),
            reqToId: $('#req_to_id').val().trim(),
            reqNote: $('#req_note').val().trim()
        };

        // Validation
        for (let [key, value] of Object.entries(requestData)) {
            if (!value) {
                showError('Please fill all the fields');
                return;
            }
        }

        if (!confirmAction('Are you sure you want to make a request?')) {
            return;
        }

        RequestManager.sendRequest(requestData)
            .done((response) => {
                if (!response) return;
                
                const data = JSON.parse(response);
                if (data.success) {
                    $('#make_app_request_modal').modal('hide');
                    clearFormFields('#make_app_request_modal');
                    showSuccess('Request sent successfully');
                } else {
                    showError('Error! Something went wrong');
                }
            })
            .fail(() => showError('Failed to send request'));
    });

    // Load Inbox
    $('.btnLoadRequest').on('click', function(e) {
        e.preventDefault();
        const inboxType = $(this).data('id');

        RequestManager.loadInbox(inboxType)
            .done((response) => {
                const data = JSON.parse(response);
                RequestManager.renderInboxTable.call(RequestManager, data, inboxType);
            })
            .fail(() => showError('Failed to load inbox'));
    });

    // Respond to Request
    $('#btn_respond_app_request').on('click', function(e) {
        e.preventDefault();

        const responseData = {
            responseType: $("#res_type").val(),
            requestId: $("#res_id").val(),
            jobNumber: $("#res_job_number").val(),
            responseNote: $("#req_response_note").val().trim()
        };

        // Validation
        for (let [key, value] of Object.entries(responseData)) {
            if (!value) {
                showError('Please fill all the fields');
                return;
            }
        }

        if (!confirmAction('Are you sure you want to respond to the request?')) {
            return;
        }

        RequestManager.respondToRequest(responseData)
            .done((response) => {
                const data = JSON.parse(response);
                
                if (data.success) {
                    showSuccess(`Request ${data.response} successfully`);
                    setTimeout(() => location.reload(), 2000);
                } else {
                    showError('Error! Something went wrong');
                }
            })
            .fail(() => showError('Failed to respond to request'));
    });

    // View Response Details Modal
    $('#view_response_details_modal').on('shown.bs.modal', function(e) {
        const button = $(e.relatedTarget);
        
        $("#re_job_number").val(button.data('job_number'));
        $("#re_accepted_by").val(button.data('accepted_by'));
        $("#re_status").val(button.data('req_status'));
        $("#res_note").val(button.data('response_note'));
        $("#res_accepted_on").val(button.data('accepted_on'));
    });

    // Enquiry Search Form Submit
    $('#frmEnquiryJobSearch').on('submit', function(e) {
        e.preventDefault();

        const searchType = $("input[name='rbtn_search_type']:checked").val();
        const searchValue = $("#enq_search_value").val().trim();

        if (!SearchManager.validateSearch(searchType, searchValue)) {
            return;
        }

        EnquiryManager.search(searchType, searchValue)
            .done((response) => {
                if (!response) {
                    showError('No records found!');
                    return;
                }

                if (response.includes('no search type')) {
                    showError('Reference Number has not been acknowledged or does not exist');
                    return;
                }

                const data = JSON.parse(response);
                EnquiryManager.addToResultsTable(data);
            })
            .fail(() => showError('Search failed'));
    });

    // Remove All Rows
    $('#btn-remove-all').on('click', function() {
        EnquiryManager.removeAllRows();
    });

    // Dynamic Remove Row (Event Delegation)
    // $(document).on('click', '.remove-row-btn', function() {
    //     if (confirmAction('Remove this row?')) {
    //         $(this).closest('tr').fadeOut(300, function() {
    //             $(this).remove();
    //             showSuccess('Row removed');
    //         });
    //     }
    // });

    // For single row removal with SweetAlert2 confirmation
    $(document).on('click', '.remove-row-btn', function() {
        const row = $(this).closest('tr');
        const jobNumber = row.find('td:eq(2)').text().trim(); // Get job number for reference
        
        Swal.fire({
            title: 'Remove Row?',
            html: `<p>Are you sure you want to remove this row?</p>
                <p class="text-muted small">Job Number: <strong>${jobNumber}</strong></p>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="fa fa-trash-alt me-2"></i>Yes, remove',
            cancelButtonText: '<i class="fa fa-times me-2"></i>Cancel',
            reverseButtons: true,
            focusCancel: true
        }).then((result) => {
            if (result.isConfirmed) {
                row.fadeOut(300, function() {
                    $(this).remove();
                    
                    // Show success toast
                    Swal.fire({
                        icon: 'success',
                        title: 'Removed!',
                        text: 'Row has been removed successfully',
                        timer: 2000,
                        showConfirmButton: false,
                        // toast: true,
                        // position: 'top-end',
                        timerProgressBar: true
                    });
                });
            }
        });
    });

    // ==================== INITIALIZATION ====================
    
    // Initialize tooltips
    $('[data-toggle="tooltip"]').tooltip();
    
    // Initialize Bootstrap 5 tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Clear form on modal hide
    $('.modal').on('hidden.bs.modal', function() {
        clearFormFields(this);
    });

    // Enter key for search
    $('#enq_search_value').on('keypress', function(e) {
        if (e.which === 13) {
            $('#frmEnquiryJobSearch').submit();
        }
    });

    console.log('Page initialized successfully');


    // ==================== SWEETALERT2 HELPER FUNCTIONS ====================

/**
 * Show confirmation dialog
 */
const showConfirm = async (message, confirmText = 'Yes, proceed!', cancelText = 'Cancel') => {
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: message,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: confirmText,
        cancelButtonText: cancelText,
        reverseButtons: true,
        focusCancel: true
    });

    return result.isConfirmed;
};

// ==================== BATCH PROCESSING FUNCTION ====================

$("#btn_process_batchlist_crb").click(async function(event) {
    event.preventDefault();

    // ==================== VALIDATION ====================
    const bl_job_purpose_new = $("#bl_job_purpose_new").val();
    const bl_remarks_notes = $("#bl_remarks_notes").val().trim();
    const region_id = $("#get_change_region_compliance_crb").val();
    const region_name = $("#get_change_region_compliance_crb option:selected").text();
    const unit_division = $("#unit_division_to_send_to_crb").val();
    const unit_name = $("#unit_to_send_to_crb").val();

    // Validate all fields
    if (!bl_job_purpose_new || bl_job_purpose_new === '-- Select --' || bl_job_purpose_new === '0') {
        showError('Please select a job purpose');
        return;
    }

    if (!bl_remarks_notes) {
        showError('Please enter remarks/notes');
        return;
    }

    if (!region_id || region_id === 'Please Select') {
        showError('Please select a region');
        return;
    }

    if (!unit_division || unit_division === 'none') {
        showError('Please select a division');
        return;
    }

    if (!unit_name) {
        showError('Please select/enter a unit');
        return;
    }

    // ==================== GET TABLE DATA ====================
    const applications = getTableData();
    
    if (applications.length === 0) {
        showError('Please add at least one application to the table');
        return;
    }

    // ==================== CONFIRMATION ====================
    const confirmed = await showConfirm(
        `Are you sure you want to move ${applications.length} application(s)?`
    );

    if (!confirmed) return;

    // ==================== GET UNIT DETAILS ====================
    const unitOption = $('#listofunitsbatching option').filter(function() {
        return this.value === unit_name;
    });
    
    const send_to_id = unitOption.data('id');
    const send_to_name = unitOption.data('name');

    if (!send_to_id || !send_to_name) {
        showError('Invalid unit selection');
        return;
    }

    // ==================== SHOW LOADING ====================
    Swal.fire({
        title: 'Processing...',
        html: 'Please wait while we process your request',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    // ==================== PROCESS BATCH ====================
    try {
        // Prepare batch data
        const batchData = applications.map(app => ({
            job_number: app.job_number,
            ar_name: app.ar_name,
            job_purpose: bl_job_purpose_new,
            business_process_sub_name: app.business_process_sub_name,
            remarks_notes: bl_remarks_notes
        }));

        const list_of_application_new = JSON.stringify(batchData);

        // First AJAX - Save batch
        const saveResponse = await $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'process_batch_list_unit_crb',
                division: localStorage.getItem('division'),
                list_of_application: list_of_application_new,
                send_to_name: send_to_name,
                send_to_id: send_to_id,
                region_id: region_id.replace(".0", ""),
                region_name: region_name,
                divison_name: unit_division
            },
            cache: false
        });

        const jsonResponse = JSON.parse(saveResponse);
        
        // Second AJAX - Generate PDF
        const pdfResponse = await $.ajax({
            type: "POST",
            url: "GenerateCaseReports",
            data: {
                request_type: 'request_to_generate_batch_list',
                list_of_application: list_of_application_new,
                batch_number: jsonResponse.batch_number,
                modified_by: localStorage.getItem('fullname'),
                modified_by_id: localStorage.getItem('userid'),
                send_to_name: send_to_name,
                send_to_id: send_to_id
            },
            cache: false,
            xhrFields: {
                responseType: 'blob'
            }
        });

        // ==================== SHOW PDF PREVIEW ====================
        Swal.close(); // Close loading dialog
        
        // Create blob and show PDF
        const blob = new Blob([pdfResponse], { type: "application/pdf" });
        const objectUrl = URL.createObjectURL(blob);
        
        // Show PDF in modal
        $('#elisdocumentpreviewblobfile').attr('src', objectUrl);
        $('#elisDocumentPreview').modal({
            backdrop: 'static',
            keyboard: false
        });

        // ==================== SUCCESS NOTIFICATION ====================
        showSuccess(`${applications.length} application(s) moved successfully!`);

        // ==================== CLEANUP ====================
        // Clear table
        $('#tbl-appData_tranfer tbody').empty();
        
        // Clear form fields
        $("#bl_job_purpose_new").val('');
        $("#bl_remarks_notes").val('');
        $("#get_change_region_compliance_crb").val('');
        $("#unit_division_to_send_to_crb").val('none');
        $("#unit_to_send_to_crb").val('');
        
        // Clear localStorage
        localStorage.setItem('batchlistdata', '');

        // Hide batch list modal if open
        $('#viewBatchlistModal').modal('hide');

    } catch (error) {
        console.error('Batch processing error:', error);
        Swal.close();
        showError('An error occurred while processing the batch');
    }
});

// ==================== HELPER FUNCTIONS ====================

/**
 * Get table data as array of objects
 */
function getTableData() {
    const tableData = [];
    
    $('#tbl-appData_tranfer tbody tr').each(function() {
        const row = $(this);
        tableData.push({
            job_number: row.find('td:eq(2)').text().trim(),
            ar_name: row.find('td:eq(0)').text().trim(),
            business_process_sub_name: row.find('td:eq(3)').text().trim()
        });
    });
    
    return tableData;
}

/**
 * Validate all form fields with visual feedback
 */
function validateBatchForm() {
    const fields = [
        { id: '#bl_job_purpose_new', name: 'Job Purpose' },
        { id: '#bl_remarks_notes', name: 'Remarks/Notes' },
        { id: '#get_change_region_compliance_crb', name: 'Region' },
        { id: '#unit_division_to_send_to_crb', name: 'Division' },
        { id: '#unit_to_send_to_crb', name: 'Unit' }
    ];

    let isValid = true;
    let firstInvalidField = null;

    fields.forEach(field => {
        const element = $(field.id);
        const value = element.val();
        
        // Remove existing validation styling
        element.removeClass('is-valid is-invalid');
        
        // Check if valid
        if (!value || value === '-- Select --' || value === '0' || value === 'none' || value === 'Please Select') {
            element.addClass('is-invalid');
            isValid = false;
            if (!firstInvalidField) firstInvalidField = element;
        } else {
            element.addClass('is-valid');
        }
    });

    if (!isValid && firstInvalidField) {
        firstInvalidField.focus();
    }

    return isValid;
}
});