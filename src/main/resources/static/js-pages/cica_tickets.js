$(function() {
    // ==================== CONFIGURATION & UTILITIES ====================
    const config = {
        apiUrl: "cica_tickets_serv",
        statusMap: {
            0: 'Open',
            1: 'Hold',
            2: 'Pending',
            3: 'Resolved'
        },
        purposeMap: {
            1: 'Service Enquiry',
            3: 'Service Complaint',
            4: 'Non-service Complaint'
        },
        rowClasses: {
            warning: 'bg-warning',
            info: 'bg-info',
            success: 'bg-success'
        }
    };

    // SweetAlert2 Configuration
    const SwalConfig = {
        position: 'top-end',
        timer: 3000,
        showConfirmButton: false,
        toast: true
    };

    // Utility Functions
    const formatDate = (dateString) => {
        return new Date(dateString).toISOString().split('T')[0];
    };

    const formatDateFull = (dateString) => {
        return new Date(dateString).toString().slice(0, 24);
    };

    const showNotification = (type, title, message) => {
        // Swal.fire({
        //     ...SwalConfig,
        //     icon: type,
        //     title: title,
        //     text: message
        // });

        swal.fire({
            title: title,
            text: message,
            icon: type === 'success' ? 'success' : type === 'error' ? 'error' : type === 'warning' ? 'warning' : 'info',
            showConfirmButton: true,
            confirmButtonText: "OK",
        });
    };



    const showLoading = (text = 'Loading...') => {
        Swal.fire({
            title: text,
            allowOutsideClick: false,
            showConfirmButton: false,
            willOpen: () => {
                Swal.showLoading();
            }
        });
    };

    const closeLoading = () => {
        Swal.close();
    };

    // ==================== COMMON DATA TABLE FUNCTIONS ====================
    const createTicketRow = (ticket) => {
        const purpose = config.purposeMap[ticket.purpose] || 'Non-service Complaint';
        const status = config.statusMap[ticket.status] || 'Unknown';
        
        return [
            `<div class="form-check">
                <input class="form-check-input fwd tickets" type="checkbox" 
                    data_id="${ticket._id}" 
                    data-purpose="${ticket.purpose}" 
                    data-subject="${ticket.subject}" 
                    data-client_name="${ticket.client_name}" 
                    data-ticket_no="${ticket.ticket_no}">
            </div>`,
            ticket.ticket_no,
            ticket.client_name,
            purpose,
            ticket.subject,
            `<div class="text-center">${status}</div>`,
            `<div class="text-center">${ticket.priority}</div>`,
            ticket.division || '',
            `<div style="text-transform: capitalize">${ticket.reference_id || ''}</div>`,
            formatDate(ticket.created_at),
            createActionButtons(ticket),
            ticket.focal_reply || false,
            ticket.message || 0,
            ticket.destination || 0
        ];
    };

    const createActionButtons = (ticket) => {
        return `
            <form action="cica_tickets_post" method="post">
                <input type="hidden" name="ticket_id" value="${ticket._id}">
                <input type="hidden" name="ticket_no" value="${ticket.ticket_no}">
                <input type="hidden" name="request_type" value="load_ticket_details">
                <div class="text-end">
                    <button type="submit" class="btn btn-primary btn-sm">Ticket Details</button>
                </div>
            </form>`;
    };

    const initializeDataTable = (dataSet, title) => {
        $('#table_list').DataTable().clear().destroy();
        
        const table = $('#table_list').DataTable({
            data: dataSet,
            createdRow: function(row, data, dataIndex) {
                const focalReply = data[10];
                const message = data[11];
                const destination = data[12];
                
                if (focalReply && destination == 1) {
                    $(row).addClass(config.rowClasses.warning);
                } else if (focalReply && destination == 2) {
                    $(row).addClass(config.rowClasses.info);
                } else if (message == 1 && destination == 2) {
                    $(row).addClass(config.rowClasses.success);
                }
            },
            language: {
                emptyTable: "No tickets found",
                info: "Showing _START_ to _END_ of _TOTAL_ tickets",
                infoEmpty: "Showing 0 to 0 of 0 tickets",
                infoFiltered: "(filtered from _MAX_ total tickets)",
                lengthMenu: "Show _MENU_ tickets",
                loadingRecords: "Loading...",
                processing: "Processing...",
                search: "Search:",
                zeroRecords: "No matching tickets found"
            },
            pageLength: 25,
            responsive: true,
            order: [[1, 'desc']]
        });

        // Update row count
        $('#rowCount').text(table.rows().count());
        document.getElementById("card_title").innerHTML = title;
        
        return table;
    };

    // ==================== TICKET LOADING FUNCTIONS ====================
    const loadTickets = async (status, title, activeElementId, inactiveElementIds) => {
        try {
            //showLoading('Loading tickets...');
            
            const regional_code = $('input[name="regional_code"]').val();
            document.getElementById("archived_search").style.display = status === 3 ? "block" : "none";
            
            const response = await $.ajax({
                url: config.apiUrl,
                method: "POST",
                data: {
                    "request_type": "load_tickets",
                    "regional_code": regional_code,
                    "status": status
                }
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success && json_result.data) {
                const dataSet = json_result.data.map(ticket => createTicketRow(ticket));
                initializeDataTable(dataSet, title);
                
                // Update UI states
                $(`#${activeElementId}`).addClass('bg-active');
                inactiveElementIds.forEach(id => $(`#${id}`).removeClass('bg-active'));
                
                const forwardButton = $("#btnViewBatchlist");
                status === 3 ? forwardButton.addClass('disabled') : forwardButton.removeClass('disabled');
                
                showNotification('success', 'Success', `${title} loaded successfully`);
            } else {
                showNotification('error', 'Error', 'Failed to load tickets');
            }
        } catch (error) {
            console.error('Error loading tickets:', error);
            showNotification('error', 'Error', 'Failed to load tickets. Please try again.');
        } finally {
            closeLoading();
        }
    };

    // ==================== EVENT HANDLERS ====================
    // Ticket Type Click Handlers
    $('#tickets_open').on('click', () => {
        $('#table_list').DataTable().clear().destroy();
        loadTickets(0, 'List of Open Tickets', 'body-bg-1', ['body-bg-2', 'body-bg-3', 'body-bg-4'])
         $("#btnViewBatchlist").removeClass('d-none');
    });
    
    $('#tickets_pending').on('click', () => {
        $('#table_list').DataTable().clear().destroy();
        loadTickets(2, 'List of Pending Tickets', 'body-bg-3', ['body-bg-2', 'body-bg-4', 'body-bg-1'])
         $("#btnViewBatchlist").removeClass('d-none');
    });
    
    $('#tickets_hold').on('click', () => {
        $('#table_list').DataTable().clear().destroy();
        loadTickets(1, 'List of Hold Tickets', 'body-bg-2', ['body-bg-3', 'body-bg-4', 'body-bg-1'])
         $("#btnViewBatchlist").removeClass('d-none');
    });
    
    $('#tickets_resolved').on('click', () => {
        $('#table_list').DataTable().clear().destroy();
        document.getElementById("archived_search").style.display = "block";
        // document.getElementById("card_title").innerHTML = "List of Resolved Tickets";
        $("#body-bg-4").addClass('bg-active');
        $("#body-bg-3, #body-bg-2, #body-bg-1").removeClass('bg-active');
        $("#btnViewBatchlist").addClass('d-none');
       //  showNotification('info', 'Info', 'Resolved tickets section loaded');
    });

    // Reply Modal
    $('#table_list').on('click', '.reply', async function() {
        const ticketId = $(this).prop('id');
        $('input[name="ticket_id"]').val(ticketId);
        
        try {
            showLoading('Loading replies...');
            
            const response = await $.ajax({
                type: "POST",
                url: config.apiUrl,
                data: {
                    "request_type": "get_replies",
                    "id": ticketId,
                    "type": "tickets"
                }
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success && json_result.data) {
                const replies = json_result.data[0].replies;
                let html = "";
                
                if (replies && replies.length > 0) {
                    replies.forEach(reply => {
                        html += `
                            <div class="card mb-3">
                                <div class="card-body">
                                    ${reply.reply}
                                    <div class="card-title mt-2">
                                        ${reply.fullname} | <span class="text-primary">${reply.unit_name}</span>
                                    </div>
                                    <div class="label">
                                        <span class="text-muted small">${formatDateFull(reply.date)}</span>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <button class="btn btn-primary btn-sm send_client" 
                                        data-ticket-id="${json_result.data[0].id}"
                                        data-reply="${reply.reply}">
                                        Send to client
                                    </button>
                                </div>
                            </div>`;
                    });
                } else {
                    html = '<div class="alert alert-info">No replies found for this ticket.</div>';
                }
                
                document.getElementById("all_replies").innerHTML = html;
                $('#replyModal').modal('show');
            } else {
                showNotification('info', 'Info', 'No replies found for this ticket');
            }
        } catch (error) {
            console.error('Error loading replies:', error);
            showNotification('error', 'Error', 'Failed to load replies');
        } finally {
            closeLoading();
        }
    });

    // Send to Client
    $('#all_replies').on('click', '.send_client', async function() {
        const ticketId = $(this).data('ticket-id');
        const reply = $(this).data('reply');
        
        $('input[name="ticket_id_client"]').val(ticketId);
        $('#reply_input_client').val(reply);
        
        $('#replyModal').modal('hide');
        
        try {
            showLoading('Loading client replies...');
            
            const response = await $.ajax({
                type: "POST",
                url: config.apiUrl,
                data: {
                    "request_type": "get_client_replies",
                    "id": ticketId
                }
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success && json_result.data) {
                const replies = json_result.data[0].replies_to_client;
                let html = "";
                
                if (replies && replies.length > 0) {
                    replies.forEach(reply => {
                        html += `
                            <div class="card mb-3">
                                <div class="card-body">
                                    ${reply.reply}
                                    <div class="card-title mt-2">
                                        ${reply.fullname} | <span class="text-primary">${reply.unit_name}</span>
                                    </div>
                                    <div class="label">
                                        <span class="text-muted small">${formatDateFull(reply.date)}</span>
                                    </div>
                                </div>
                            </div>`;
                    });
                } else {
                    html = '<div class="alert alert-info">No client replies found.</div>';
                }
                
                document.getElementById("all_client_replies").innerHTML = html;
                $('#replyClientModal').modal('show');
            }
        } catch (error) {
            console.error('Error loading client replies:', error);
            showNotification('error', 'Error', 'Failed to load client replies');
        } finally {
            closeLoading();
        }
    });

    // Status Update
    $('#table_list').on('click', '.status', function() {
        const ticketId = $(this).prop('id');
        $('input[name="status_ticket_id"]').val(ticketId);
        $('#updateStatusModal').modal('show');
    });

    // ==================== FORM SUBMISSIONS ====================
    // Reply Form
    $("#replyForm").submit(async function(e) {
        e.preventDefault();
        
        const submitBtn = $("#reply_ticket");
        const originalText = submitBtn.text();
        submitBtn.prop('disabled', true).text("Please wait...");
        
        try {
            const formData = {
                request_type: "reply_ticket",
                replies: JSON.stringify({
                    userid: $('input[name="userid"]').val(),
                    fullname: $('input[name="fullname"]').val(),
                    unit_name: $('input[name="unit_name"]').val(),
                    unit_id: $('input[name="unit_id"]').val(),
                    reply: $('#reply_input').val(),
                    date: Date.now()
                }),
                ticket_id: $('input[name="ticket_id"]').val(),
                type: "tickets"
            };

            const response = await $.ajax({
                type: "POST",
                url: config.apiUrl,
                data: formData
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success) {
                showNotification('success', 'Success', 'Ticket replied successfully');
                $("#replyModal").modal('hide').find('form').trigger('reset');
                
                // Reload current ticket view
                setTimeout(() => {
                    const activeTab = $('.bg-active').closest('[id^="tickets_"]').attr('id');
                    if (activeTab) $(`#${activeTab}`).click();
                }, 1000);
            } else {
                showNotification('error', 'Error', 'Error replying to ticket');
            }
        } catch (error) {
            console.error('Error submitting reply:', error);
            showNotification('error', 'Error', 'Failed to submit reply');
        } finally {
            submitBtn.prop('disabled', false).text(originalText);
        }
    });

    // Client Reply Form
    $("#clientReplyForm").submit(async function(e) {
        e.preventDefault();
        
        const submitBtn = $("#client_reply_ticket");
        const originalText = submitBtn.text();
        submitBtn.prop('disabled', true).text("Please wait...");
        
        try {
            const formData = {
                request_type: "client_reply",
                replies: JSON.stringify({
                    userid: $('input[name="userid_client"]').val(),
                    fullname: $('input[name="fullname_client"]').val(),
                    unit_name: $('input[name="unit_name_client"]').val(),
                    unit_id: $('input[name="unit_id_client"]').val(),
                    reply: $('#reply_input_client').val(),
                    date: Date.now()
                }),
                ticket_id: $('input[name="ticket_id_client"]').val()
            };

            const response = await $.ajax({
                type: "POST",
                url: config.apiUrl,
                data: formData
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success) {
                showNotification('success', 'Success', 'Reply sent to client successfully');
                $("#replyClientModal").modal('hide').find('form').trigger('reset');
                
                setTimeout(() => {
                    const activeTab = $('.bg-active').closest('[id^="tickets_"]').attr('id');
                    if (activeTab) $(`#${activeTab}`).click();
                }, 1000);
            } else {
                showNotification('error', 'Error', 'Error sending reply to client');
            }
        } catch (error) {
            console.error('Error submitting client reply:', error);
            showNotification('error', 'Error', 'Failed to send reply to client');
        } finally {
            submitBtn.prop('disabled', false).text(originalText);
        }
    });

    // Status Update Form
    $("#updateStatusForm").submit(async function(e) {
        e.preventDefault();
        
        const submitBtn = $("#update_status");
        const originalText = submitBtn.text();
        submitBtn.prop('disabled', true).text("Please wait...");
        
        try {
            const formData = {
                request_type: "status_update",
                status_obj: JSON.stringify({
                    userid: $('input[name="userid_client"]').val(),
                    fullname: $('input[name="fullname_client"]').val(),
                    unit_name: $('input[name="unit_name_client"]').val(),
                    unit_id: $('input[name="unit_id_client"]').val(),
                    status: $('#status_select').val(),
                    date: Date.now()
                }),
                ticket_id: $('input[name="status_ticket_id"]').val(),
                status: $('#status_select').val(),
                type: "tickets"
            };

            const response = await $.ajax({
                type: "POST",
                url: config.apiUrl,
                data: formData
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success) {
                showNotification('success', 'Success', 'Ticket status updated successfully');
                $("#updateStatusModal").modal('hide').find('form').trigger('reset');
                
                setTimeout(() => location.reload(), 1500);
            } else {
                showNotification('error', 'Error', 'Error updating ticket status');
            }
        } catch (error) {
            console.error('Error updating status:', error);
            showNotification('error', 'Error', 'Failed to update ticket status');
        } finally {
            submitBtn.prop('disabled', false).text(originalText);
        }
    });

    // ==================== SEARCH FUNCTIONALITY ====================
    const checkInput = () => {
        const searchValue = $('#cc_search_value').val().trim();
        const isChecked = $('input[name="rbtn_search_type"]:checked').length > 0;
        
        if (!isChecked) {
            showNotification('warning', 'Warning', 'Please select a search type');
            return false;
        }
        if (!searchValue) {
            showNotification('warning', 'Warning', 'Please enter a search keyword');
            return false;
        }
        return true;
    };

    const performSearch = async (endpoint, action, title) => {
        if (!checkInput()) return;
        
        try {
            showLoading('Searching...');
            
            const searchData = {
                request_type: 'search_archived',
                search_value: $('#cc_search_value').val().trim(),
                search_type: $('input[name="rbtn_search_type"]:checked').val(),
                type: "tickets"
            };

            const response = await $.ajax({
                type: "POST",
                url: endpoint,
                data: searchData
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success && json_result.data) {
                const dataSet = json_result.data.map(ticket => createTicketRow(ticket));
                initializeDataTable(dataSet, title);
                showNotification('success', 'Success', 'Search completed successfully');
            } else {
                showNotification('info', 'Info', 'No results found');
                $('#table_list').DataTable().clear().draw();
            }
        } catch (error) {
            console.error('Search error:', error);
            showNotification('error', 'Error', 'Search failed. Please try again.');
        } finally {
            closeLoading();
        }
    };

    // Search Handlers
    $("#btnCCJobSearch").on("click", () => 
        performSearch(config.apiUrl, "cica_tickets_post", "Search Results"));
    
    $("#btnFPJobSearch").on("click", () => 
        performSearch("cica_focal_person_serv", "cica_focal_person", "Focal Person Search Results"));
    
    $("#btnRRJobSearch").on("click", () => 
        performSearch("cica_replies_serv", "cica_replies_post", "Replies Search Results"));

    // Clear Search
    $("#clearSearch").on("click", function() {
        $('#cc_search_value').val('');
        showNotification('info', 'Cleared', 'Search field cleared');
    });

    // ==================== BATCH OPERATIONS ====================
    const getSelectedTickets = () => {
        const checkedList = [];
        $('.tickets:checked').each(function() {
            checkedList.push({
                ticket_no: $(this).data('ticket_no'),
                client_name: $(this).data('client_name'),
                purpose: $(this).data('purpose'),
                subject: $(this).data('subject')
            });
        });
        return checkedList;
    };

    const showBatchList = (modalId, listContainerId) => {
        const checkedList = getSelectedTickets();
        
        if (checkedList.length === 0) {
            showNotification('warning', 'Warning', 'No tickets selected');
            return;
        }

        localStorage.setItem('checkedList', JSON.stringify(checkedList));
        
        $(`#${modalId}`).on('shown.bs.modal', function() {
            const storedList = JSON.parse(localStorage.getItem('checkedList')) || [];
            let html = '<table class="table table-hover"><thead><tr><th>Ticket #</th><th>Name</th><th>Purpose</th><th>Subject</th><th>Action</th></tr></thead><tbody>';
            
            if (storedList.length > 0) {
                storedList.forEach(item => {
                    const purpose = config.purposeMap[item.purpose] || 'Non-service Complaint';
                    html += `
                        <tr>
                            <td>${item.ticket_no}</td>
                            <td>${item.client_name}</td>
                            <td>${purpose}</td>
                            <td>${item.subject}</td>
                            <td>
                                <button class="btn btn-danger btn-sm remove-row" data-ticket-no="${item.ticket_no}">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>`;
                });
            } else {
                html = '<tr><td colspan="5" class="text-center">No tickets selected</td></tr>';
            }
            
            html += '</tbody></table>';
            document.getElementById(listContainerId).innerHTML = html;
        }).modal('show');
    };

    // Remove row from batch list
    $(document).on('click', '.remove-row', function() {
        const ticketNo = $(this).data('ticket-no');
        let storedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        storedList = storedList.filter(item => item.ticket_no !== ticketNo);
        localStorage.setItem('checkedList', JSON.stringify(storedList));
        
        // Refresh the displayed list
        $(this).closest('tr').fadeOut(300, function() {
            $(this).remove();
            if (storedList.length === 0) {
                $(`#${$(this).closest('tbody').attr('id')}`).html('<tr><td colspan="5" class="text-center">No tickets selected</td></tr>');
            }
        });
        
        showNotification('success', 'Removed', 'Ticket removed from batch');
    });

    // Batch Forward
    $("#btnViewBatchlist").on('click', (e) => {
        e.preventDefault();
        showBatchList('showBatchlist', 'batch_list');
    });

    $("#btnViewRequestlist").on('click', (e) => {
        e.preventDefault();
        showBatchList('showRequestlist', 'request_list');
    });

    // Process Batch Forward
    const processBatchForward = async (buttonId, endpoint, requestType, successMessage) => {
        const checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        const division = $('#ft_division').val();
        const region = $('#ft_region').val();
        
        if (checkedList.length === 0) {
            showNotification('warning', 'Warning', 'No tickets selected');
            return;
        }
        
        if (!division || !region) {
            showNotification('warning', 'Warning', 'Please select division and region');
            return;
        }

        const confirmation = await Swal.fire({
            title: 'Confirm Forward',
            text: `Are you sure you want to forward ${checkedList.length} ticket(s)?`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Yes, forward them',
            cancelButtonText: 'Cancel'
        });

        if (!confirmation.isConfirmed) return;

        try {
            showLoading('Forwarding tickets...');
            $(buttonId).prop('disabled', true);
            
            const response = await $.ajax({
                url: endpoint,
                type: "POST",
                data: {
                    request_type: requestType,
                    list: JSON.stringify({ list: checkedList }),
                    region: region,
                    division: division
                }
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success) {
                showNotification('success', 'Success', successMessage);
                localStorage.removeItem('checkedList');
                $('#showBatchlist').modal('hide').find('form').trigger('reset');
                
                setTimeout(() => location.reload(), 1500);
            } else {
                showNotification('error', 'Error', 'Error forwarding tickets');
            }
        } catch (error) {
            console.error('Batch forward error:', error);
            showNotification('error', 'Error', 'Failed to forward tickets');
        } finally {
            closeLoading();
            $(buttonId).prop('disabled', false);
        }
    };

    // Batch Forward Handlers
    $('#btn_print').on('click', () => 
        processBatchForward('#btn_print', config.apiUrl, 'forward_tickets', 'Tickets forwarded successfully'));
    
    $('#btn_focal_print').on('click', () => 
        processBatchForward('#btn_focal_print', "cica_focal_person_serv", 'forward_tickets', 'Tickets forwarded successfully'));
    
    $('#btn_archive_replies').on('click', () => 
        processBatchForward('#btn_archive_replies', "cica_replies_serv", 'forward_tickets', 'Tickets forwarded successfully'));

    // ==================== FORWARD SINGLE TICKET ====================
    $('#table_list').on('click', '.forward', function() {
        const ticketId = $(this).prop('id');
        $('input[name="forward_ticket_id"]').val(ticketId);
        $('#forwardModal').modal('show');
    });

    $("#forwardForm").submit(async function(e) {
        e.preventDefault();
        
        const submitBtn = $("#forward_ticket");
        const originalText = submitBtn.text();
        submitBtn.prop('disabled', true).text("Forwarding...");
        
        try {
            const formData = {
                request_type: "forward_ticket",
                ticket_id: $('input[name="forward_ticket_id"]').val(),
                division: $('#division').val(),
                region: $('#region').val(),
                unit: $('input[name="unit"]').val()
            };

            const response = await $.ajax({
                url: config.apiUrl,
                method: "POST",
                data: formData
            });

            const json_result = JSON.parse(response);
            
            if (json_result.success) {
                showNotification('success', 'Success', 'Ticket forwarded successfully');
                $("#forwardModal").modal('hide').find('form').trigger('reset');
                
                setTimeout(() => location.reload(), 1500);
            } else {
                showNotification('error', 'Error', 'Error forwarding ticket');
            }
        } catch (error) {
            console.error('Forward error:', error);
            showNotification('error', 'Error', 'Failed to forward ticket');
        } finally {
            submitBtn.prop('disabled', false).text(originalText);
        }
    });

    // ==================== INITIALIZATION ====================
    // Load initial data
    $('#tickets_open').click();
    
    // Initialize Select All checkbox
    $('#selectAll').on('change', function() {
        $('.tickets').prop('checked', $(this).prop('checked'));
    });
    
    // Initialize tooltips if using Bootstrap tooltips
    if ($.fn.tooltip) {
        $('[data-bs-toggle="tooltip"]').tooltip();
    }

     // Function to activate a specific card
    function activateCard(cardElement) {
        // Remove active class from all cards
        $('.stat-card').removeClass('active-card');
        
        // Add active class to clicked card
        $(cardElement).addClass('active-card');
    }
    
    // Click handlers for each card
    $('#tickets_open').on('click', function() {
        activateCard(this);
        // Add your existing ticket loading logic here
    });
    
    $('#tickets_pending').on('click', function() {
        activateCard(this);
        // Add your existing ticket loading logic here
    });
    
    $('#tickets_hold').on('click', function() {
        activateCard(this);
        // Add your existing ticket loading logic here
    });
    
    $('#tickets_resolved').on('click', function() {
        activateCard(this);
        // Add your existing ticket loading logic here
    });
    
    // Initialize - activate first card on page load
    activateCard($('#tickets_open'));
});