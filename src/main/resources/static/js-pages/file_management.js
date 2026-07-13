$(document)
		.ready(
				function() {

					var datatable = $("#job_casemgtdetailsdataTable")
							.DataTable({
								// responsive: true,

								stateSave : true,
								"createdRow" : function(row, data, dataIndex) {
									// if (data[0] == "1") {
									// 	$(row).addClass('tr-completed-work');
									// }
									if(data[7] == 'Approved'){
										$(row).addClass('bg-success text-white');
									  }
									
								},

							/*
							 * columns: [ { // Responsive control column data:
							 * null, defaultContent: '', className: 'control',
							 * orderable: false },
							 *  ],
							 */
							});

					$('#frmFileJobSearch').on('submit', function(e) {
    e.preventDefault();
    
    // Get and validate search value
    const enq_search_value = $("#file_search_value").val().trim();
    console.log('Search Value:', enq_search_value);
    
    // Validate minimum characters
    if (!enq_search_value || enq_search_value.length < 4) {
        Swal.fire({
            title: 'Invalid Search',
            html: `<div class="text-center">
                    <div class="mb-3">
                        <i class="fas fa-exclamation-triangle text-warning fa-3x"></i>
                    </div>
                    <h5 class="mb-3">Search Term Too Short</h5>
                    <p class="mb-2">Please enter at least <strong>4 characters</strong> to search</p>
                    <div class="alert alert-info bg-info bg-opacity-10 border-info mt-3">
                        <i class="fas fa-lightbulb me-2"></i>
                        <span class="fw-semibold">Tip:</span> Enter job number, case number, or applicant name
                    </div>
                    <p class="text-muted small mt-2">
                        Current length: <span class="fw-bold">${enq_search_value.length || 0}</span> characters
                    </p>
                </div>`,
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#f39c12',
            background: 'white',
            backdrop: 'rgba(0,0,0,0.4)',
            width: 500
        });
        return;
    }

    // Show loading state with SweetAlert
    Swal.fire({
        title: 'Searching Files',
        html: `
            <div class="text-center">
                <div class="spinner-border text-primary mb-3" role="status" style="width: 3rem; height: 3rem;">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mb-0">Searching for: <strong>"${enq_search_value}"</strong></p>
                <p class="text-muted small mt-2">Please wait while we fetch the records</p>
            </div>
        `,
        showConfirmButton: false,
        allowOutsideClick: false,
        allowEscapeKey: false,
        background: 'white',
        backdrop: 'rgba(0,0,0,0.4)'
    });

    // Make AJAX call
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'load_application_details_by_job_number',
            job_number: enq_search_value
        },
        cache: false,
        dataType: 'json',
        success: function(jobdetails) {
            Swal.close(); // Close loading Swal
            
            try {
                // Parse response if string
                const json_p = (typeof jobdetails === 'string') ? JSON.parse(jobdetails) : jobdetails;
                
                // Clear existing table data
                const table = $('#file-search-results-table');
                table.find("tbody tr").remove();
                
                // Check if data exists
                if (!json_p.job_detail || !json_p.transaction_details) {
                    // Hide table, show no results message
                    $('#file-search-results-section .table-responsive').hide();
                    $('#no-results-message').show();
                    $('#result-count').text('0');
                    
                    Swal.fire({
                        title: 'No Records Found',
                        html: `<div class="text-center">
                                <div class="mb-3">
                                    <div class="bg-warning bg-opacity-10 rounded-circle p-3 d-inline-block">
                                        <i class="fas fa-folder-open text-warning fa-3x"></i>
                                    </div>
                                </div>
                                <h5 class="mb-2">No matching files found</h5>
                                <p class="text-muted mb-2">Search term: <strong>"${enq_search_value}"</strong></p>
                                <div class="alert alert-info bg-info bg-opacity-10 border-info mt-3">
                                    <i class="fas fa-search me-2"></i>
                                    Suggestions:
                                    <ul class="text-start mb-0 mt-2">
                                        <li>Check the job number for typos</li>
                                        <li>Try a different search term</li>
                                        <li>Use the batch number search</li>
                                    </ul>
                                </div>
                            </div>`,
                        icon: 'info',
                        confirmButtonText: 'Try Again',
                        confirmButtonColor: '#0d6efd',
                        background: 'white',
                        backdrop: 'rgba(0,0,0,0.4)'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $('#file_search_value').focus().select();
                        }
                    });
                    return;
                }
                
                // Show table, hide no results message
                $('#file-search-results-section .table-responsive').show();
                $('#no-results-message').hide();
                $('#result-count').text('1');
                
                // Safely access nested properties
                const transaction_details = json_p.transaction_details || {};
                const job_detail = json_p.job_detail || {};
                const parcel_details = json_p.parcel_details || {};
                
                // Get values with fallbacks
                const ar_name = transaction_details.ar_name || 'N/A';
                const case_number = transaction_details.case_number || 'N/A';
                const job_number = job_detail.job_number || 'N/A';
                const business_process_sub_name = job_detail.business_process_sub_name || 'N/A';
                const locality = parcel_details.locality || transaction_details.locality || 'N/A';
                
                // Create table row with Bootstrap 5 styling
                const row = `
                    <tr class="align-middle">
                        <td>
                            <div class="d-flex align-items-center">
                                <!--<div class="bg-primary bg-opacity-10 rounded-circle p-2 me-2">
                                    <i class="fas fa-user text-primary"></i>
                                </div>-->
                                <span class="fw-semibold">${escapeHtml(ar_name)}</span>
                            </div>
                        </td>
                        <td>
                            <span class="badge bg-secondary bg-opacity-10 text-secondary px-3 py-2">
                                <!--<i class="fas fa-file-invoice me-1"></i> -->
                                ${escapeHtml(case_number)}
                            </span>
                        </td>
                        <td>
                            <span class="fw-bold text-primary">${escapeHtml(job_number)}</span>
                        </td>
                        <td>
                            <span class="badge bg-info bg-opacity-10 text-info px-3 py-2">
                               <!-- <i class="fas fa-tag me-1"></i> -->
                                ${escapeHtml(business_process_sub_name)}
                            </span>
                        </td>
                        <td>
                            <!--<i class="fas fa-map-marker-alt text-muted me-1"></i> -->
                            ${escapeHtml(locality)}
                        </td>
                        <td class="text-center">
                            <button class="btn btn-success btn-sm add-file-btn" 
                                    data-job_number="${escapeHtml(job_number)}"
                                    data-ar_name="${escapeHtml(ar_name)}"
                                    data-app_type="${escapeHtml(business_process_sub_name)}"
                                    data-locality="${escapeHtml(locality)}"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Add file to prepared list">
                                <i class="fas fa-plus-circle me-1"></i>
                                Add File
                            </button>
                        </td>
                    </tr>
                `;
                
                table.append(row);
                
                // Update last search time
                updateLastSearchTime();
                
                // Add to recent searches
                addRecentSearch(enq_search_value, 'job');
                
                // Initialize tooltips
                initializeTooltips();
                
                // Show success message
                Swal.fire({
                    title: 'File Found!',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <div class="bg-success bg-opacity-10 rounded-circle p-3 d-inline-block">
                                    <i class="fas fa-check-circle text-success fa-3x"></i>
                                </div>
                            </div>
                            <h5 class="mb-2">Application Retrieved Successfully</h5>
                            <div class="bg-light rounded-3 p-3 mt-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Job Number:</span>
                                    <span class="fw-semibold text-primary">${escapeHtml(job_number)}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Applicant:</span>
                                    <span class="fw-semibold">${escapeHtml(ar_name.substring(0, 30))}${ar_name.length > 30 ? '...' : ''}</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Application Type:</span>
                                    <span class="fw-semibold">${escapeHtml(business_process_sub_name)}</span>
                                </div>
                            </div>
                        </div>`,
                    icon: 'success',
                    timer: 2500,
                    timerProgressBar: true,
                    showConfirmButton: false,
                    background: 'white'
                });
                
            } catch (error) {
                console.error('Error parsing response:', error);
                Swal.close();
                
                Swal.fire({
                    title: 'Processing Error',
                    html: `<div class="text-center">
                            <div class="mb-3">
                                <i class="fas fa-exclamation-circle text-danger fa-3x"></i>
                            </div>
                            <h5 class="mb-2">Failed to process server response</h5>
                            <p class="text-muted small">${error.message || 'Invalid data format'}</p>
                            <div class="alert alert-secondary bg-secondary bg-opacity-10 border-secondary mt-3">
                                <i class="fas fa-tools me-2"></i>
                                Please try again or contact support
                            </div>
                        </div>`,
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545',
                    background: 'white'
                });
            }
        },
        error: function(xhr, status, error) {
            Swal.close(); // Close loading Swal
            
            let errorMessage = 'Unable to complete the search';
            let errorDetails = '';
            
            if (xhr.status === 404) {
                errorMessage = 'Search service not found';
                errorDetails = 'Please contact system administrator';
            } else if (xhr.status === 500) {
                errorMessage = 'Server error occurred';
                errorDetails = 'Please try again in a few moments';
            } else if (xhr.status === 0) {
                errorMessage = 'Network connection error';
                errorDetails = 'Please check your internet connection';
            } else if (xhr.status === 400) {
                errorMessage = 'Invalid search request';
                errorDetails = 'Please check your search term and try again';
            }

            Swal.fire({
                title: 'Search Failed',
                html: `<div class="text-center">
                        <div class="mb-3">
                            <i class="fas fa-exclamation-triangle text-danger fa-3x"></i>
                        </div>
                        <h5 class="mb-2">${errorMessage}</h5>
                        <p class="text-danger small">${xhr.status}: ${error}</p>
                        <p class="text-muted mt-2">${errorDetails}</p>
                        <div class="bg-light rounded-3 p-2 mt-2">
                            <span class="text-muted">Search term:</span>
                            <span class="fw-semibold ms-2">"${escapeHtml(enq_search_value)}"</span>
                        </div>
                        <div class="alert alert-warning bg-warning bg-opacity-10 border-warning mt-3">
                            <i class="fas fa-redo-alt me-2"></i>
                            Would you like to try again?
                        </div>
                    </div>`,
                icon: 'error',
                confirmButtonText: '<i class="fas fa-redo-alt me-2"></i>Try Again',
                confirmButtonColor: '#0d6efd',
                showCancelButton: true,
                cancelButtonText: '<i class="fas fa-times me-2"></i>Cancel',
                cancelButtonColor: '#6c757d',
                background: 'white',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    $('#frmFileJobSearch').submit();
                }
            });
        }
    });
});

// Use delegated events so values come from DOM attributes instead of inline JS strings.
$(document).on('click', '.add-file-btn', function() {
    window.confirmAddFile(
        $(this).attr('data-job_number') || '',
        $(this).attr('data-ar_name') || '',
        $(this).attr('data-app_type') || '',
        $(this).attr('data-locality') || '',
        this
    );
});

// Global function to confirm adding file to list
window.confirmAddFile = function(job_number, ar_name, app_type, locality, triggerButton) {
    Swal.fire({
        title: 'Add File to List?',
        html: `<div class="text-start">
                <div class="mb-3 text-center">
                    <div class="bg-success bg-opacity-10 rounded-circle p-3 d-inline-block">
                        <i class="fas fa-file-alt text-success fa-3x"></i>
                    </div>
                </div>
                <h5 class="mb-3 text-center fw-bold">Confirm Add File</h5>
                
                <div class="card border-0 bg-light mb-3">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-briefcase me-2 text-muted" style="width: 24px;"></i>
                            <span class="text-muted">Job Number:</span>
                            <span class="ms-2 fw-semibold text-primary">${escapeHtml(job_number)}</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-user me-2 text-muted" style="width: 24px;"></i>
                            <span class="text-muted">Applicant:</span>
                            <span class="ms-2 fw-semibold">${escapeHtml(ar_name)}</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-tag me-2 text-muted" style="width: 24px;"></i>
                            <span class="text-muted">Application:</span>
                            <span class="ms-2">${escapeHtml(app_type)}</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-map-marker-alt me-2 text-muted" style="width: 24px;"></i>
                            <span class="text-muted">Locality:</span>
                            <span class="ms-2">${escapeHtml(locality)}</span>
                        </div>
                    </div>
                </div>
                
                <div class="alert alert-info bg-info bg-opacity-10 border-info mb-0">
                    <i class="fas fa-info-circle me-2"></i>
                    This file will be added to your prepared file list for processing.
                </div>
            </div>`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '<i class="fas fa-check me-2"></i>Yes, Add File',
        cancelButtonText: '<i class="fas fa-times me-2"></i>Cancel',
        confirmButtonColor: '#198754',
        // cancelButtonColor: '#6c757d',
        background: 'white',
        width: 550,
        reverseButtons: true,
        customClass: {
            confirmButton: 'btn btn-success',
            // cancelButton: 'btn btn-secondary'
        }
    }).then((result) => {
        if (result.isConfirmed) {
            // Call the original addFileToList function
            if (typeof window.addFileToList === 'function') {
                window.addFileToList(job_number, ar_name, app_type, locality, 'File movement');
                
                // Show success message
                Swal.fire({
                    title: 'File Added!',
                    html: `<div class="text-center">
                            <div class="mb-2">
                                <i class="fas fa-check-circle text-success fa-2x"></i>
                            </div>
                            <p class="mb-0 fw-semibold">File <span class="text-primary">${escapeHtml(job_number)}</span> has been added</p>
                            <p class="text-muted small mt-2">You can view it in your prepared file list</p>
                        </div>`,
                    icon: 'success',
                    timer: 2000,
                    timerProgressBar: true,
                    showConfirmButton: false,
                    background: 'white'
                });
                
                // Update button state
                const btn = triggerButton ? $(triggerButton) : $(`button[data-job_number="${job_number}"]`).first();
                btn.html('<i class="fas fa-check me-1"></i>Added');
                btn.removeClass('btn-success').addClass('btn-secondary');
                btn.prop('disabled', true);
                btn.attr('title', 'Already added to list');
                
                // Update tooltip
                const tooltip = bootstrap.Tooltip.getInstance(btn[0]);
                if (tooltip) {
                    tooltip.dispose();
                }
                new bootstrap.Tooltip(btn[0], {
                    title: 'Already added to list',
                    placement: 'top'
                });
            } else {
                console.error('addFileToList function not found');
                Swal.fire({
                    title: 'Error',
                    text: 'Could not add file. Function not available.',
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
            }
        }
    });
};

// Helper function to escape HTML and prevent XSS
function escapeHtml(text) {
    if (!text) return '';
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.toString().replace(/[&<>"']/g, function(m) { return map[m]; });
}

// Update last search time
function updateLastSearchTime() {
    const now = new Date();
    const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    $('#last-search-time').text(timeStr);
}

// Add to recent searches
function addRecentSearch(term, type) {
    let searches = JSON.parse(localStorage.getItem('recentFileSearches') || '[]');
    searches = [{ term, type, timestamp: new Date().toISOString() }, ...searches];
    searches = searches.filter((v, i, a) => a.findIndex(t => t.term === v.term) === i).slice(0, 5);
    localStorage.setItem('recentFileSearches', JSON.stringify(searches));
    
    // Trigger recent searches display if function exists
    if (typeof displayRecentSearches === 'function') {
        displayRecentSearches();
    }
}

// Initialize tooltips
function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.forEach(function(tooltipTriggerEl) {
        try {
            const tooltip = bootstrap.Tooltip.getInstance(tooltipTriggerEl);
            if (tooltip) {
                tooltip.dispose();
            }
            new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover',
                delay: { show: 300, hide: 100 }
            });
        } catch (e) {
            console.warn('Could not initialize tooltip:', e);
        }
    });
}

// Enter key support
$('#file_search_value').on('keypress', function(e) {
    if (e.which === 13) {
        e.preventDefault();
        $('#frmFileJobSearch').submit();
    }
});

// Clear search with confirmation
$('#btnClearFileSearch').on('click', function(e) {
    e.preventDefault();
    
    const searchValue = $('#file_search_value').val().trim();
    if (searchValue !== '') {
        Swal.fire({
            title: 'Clear Search?',
            html: '<p>This will clear your current search term.</p>',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '<i class="fas fa-undo me-2"></i>Yes, Clear',
            cancelButtonText: '<i class="fas fa-times me-2"></i>Cancel',
            confirmButtonColor: '#6c757d',
            cancelButtonColor: '#0d6efd',
            background: 'white',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                $('#file_search_value').val('').focus();
                
                Swal.fire({
                    title: 'Cleared',
                    text: 'Search field has been cleared',
                    icon: 'success',
                    timer: 1500,
                    showConfirmButton: false,
                    background: 'white'
                });
            }
        });
    }
});

// Add clear button if it doesn't exist
$(document).ready(function() {
    if ($('#btnClearFileSearch').length === 0) {
        const clearBtn = $('<button type="button" class="btn btn-outline-secondary ms-2" id="btnClearFileSearch">' +
                          '<i class="fas fa-times"></i>' +
                          '</button>');
        $('#file_search_value').after(clearBtn);
    }
    
    // Add no results message container if it doesn't exist
    if ($('#no-results-message').length === 0) {
        const noResultsHtml = `
            <div id="no-results-message" class="text-center py-5" style="display: none;">
                <div class="bg-light bg-opacity-50 rounded-circle p-4 d-inline-block mb-3">
                    <i class="fas fa-folder-open text-muted fa-3x"></i>
                </div>
                <h6 class="fw-bold mb-2">No Files Found</h6>
                <p class="text-muted mb-2">No records match your search criteria</p>
                <small class="text-muted d-block mb-3">Try adjusting your search term</small>
            </div>
        `;
        $('#file-search-results-section .card-body').append(noResultsHtml);
    }
});

				
					
					$('#frmEnquiryBatchlist').on('submit',function(e) {

								// validation code here
								e.preventDefault();
								// console.log('how are your search');

								var enq_batchlist_val = $("#enq_batchlist").val();
								//console.log('Search Value: ' + enq_batchlist_val);

								if (!(enq_batchlist_val.length >= 4)) {
									$.notify({
												message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 6 or more characters to search </span>',
									}, {type : 'danger' , z_index: 9999 });
								} else {

									
									

									$.ajax({
										type : "POST",
										url : "Case_Management_Serv",
										data : {
											request_type : 'load_applications_by_batchlist',
											job_number : enq_batchlist_val
										},
										cache : false,
										beforeSend : function() {
											
										},
										success : function(jobdetails) {
											try {
												var table = $('#tbl_batchlist_history');
												table.find("tbody tr").remove();

												//console.log(jobdetails);
												
												var json_p = JSON.parse(jobdetails);

												$(json_p).each(function() {

													table.append("<tr><td>" + this.ar_name
																+ "</td><td>" + this.job_number
																+ "</td><td>" + this.job_purpose
																+ "</td><td>" + this.sender_name
																+ "</td><td>" + this.receiver_name
																+ "</td><td>" + this.date_created
																+ "</td>"
																+ '</tr>');

													});
												
												$("#enq-search-results-section").hide();
												$("#batchlist_value").empty();
												$("#batchlist_value").append(enq_batchlist_val);
												$("#BachlistModal").modal("show");
												}
												catch(err) {
												 console.log(err.message);
												}
										}

									});

												
											
								}
							});
					
					
					$("#btn_process_file_list").click(function(event){
					   	 
				   	  	//alert(JSON.stringify(table)); 
						let request_type ="";
						var list_of_application_new = JSON.stringify(table)
						if($('#batch_type').val()==='Unit'){
							request_type = 'process_file_list';
							var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
					   	 	var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
					   		var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');
							
					    }else{
					    	request_type = 'process_file_list';
					    	var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
					   	 	var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
					   		var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');
							
					    }
							
						var table = storeTblValues();
						list_of_application_new = JSON.stringify(table);
						//console.log(list_of_application_new);
							
							
							
						console.log("request_type: " + request_type);
				        console.log("userid_1 " + userid_1);
				        console.log("sender " + send_to_name);
				        console.log("sender " + send_to_id);


						function storeTblValues()
						{
						    var TableData = new Array();

						    $('#FileListdataTable tr').each(function(row, tr){
						        TableData[row]={
						            "job_number" : $(tr).find('td:eq(0)').text().trim() ,
						            "ar_name" : $(tr).find('td:eq(1)').text().trim(),
						            "locality" : $(tr).find('td:eq(3)').text().trim(),
						            "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim()
						            
						        }    
						    }); 
						    TableData.shift();  // first row will be empty - so remove
						    return TableData;
						}
				    	 
				    	 $.ajax({
							 type: "POST",
							 url: "Case_Management_Serv",
							 data: {
				                	request_type: request_type,
				                	division: localStorage.getItem('division'),
				                  	list_of_application:list_of_application_new,
				                  	send_to_name : send_to_name,
						            send_to_id : send_to_id
				                  	},
							 cache: false,
							
							 success: function(response) {
								    console.log(response)
								    
								  var json_p = JSON.parse(response);
								 
								   /* $('#request_type').val('request_to_generate_batch_list');
								    $('#list_of_application').val(list_of_application_new);
								    $('#batch_number').val(json_p.batch_number);
								   
								    $('#modified_by').val(  $( "#user_to_send_to" ).val());
								    //var userid_1 = $( "#user_to_send_to" ).val(); 
								    
								  //  $('#modified_by').val(localStorage.getItem('fullname'));
								    $('#modified_by_id').val( localStorage.getItem('userid'));
								    // $('#downloadForm').submit();
*/								    
										 $.ajax({
												 type: "POST",
												 url: "GenerateCaseReports",
												 target : '_blank',
												 data: {
													 request_type: 'request_to_generate_file_list',
						           					  list_of_application: list_of_application_new,
						           					  batch_number: json_p.batch_number,
						           					  modified_by : localStorage.getItem('fullname'),
						           					  modified_by_id : localStorage.getItem('userid'),
						           					send_to_name: send_to_name,
				                                    send_to_id: send_to_id
									                  	},
												 cache: false,
												 xhrFields : {
														responseType : 'blob'
													},
												 beforeSend: function () {
													// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													//console.log("before ajax");
													
													
													
													
												 },
												 success: function(data) {
													 console.log(data)
													
													
														$('#elisDocumentPreview').modal({
							     	    	 			 backdrop: 'static',
							     	    				});
													 
													 
													 var blob = new Blob(
																[ data ],
																{
																	type : "application/pdf"
																});
													var objectUrl = URL
																.createObjectURL(blob);
														// window.open(objectUrl);
														console.log("success ajax");

				 	    							$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
														
														
														
												      
												 },
												 complete: function(){
													 console.log("Completed ajax");
													 $('#viewBatchlistModal').modal('hide');
													 console.log("Completed 3 ajax");
				 	    							 //Clear Local storage Bactlist
				 	    				       		localStorage.setItem('batchlistdata', '');
				 	    				       		//prepareBatchlistModal();
				 	    				       		
				 	    				       	   
												   }
												 });  
						
							      
							 }
							 }); 
				 		
				 	});
					
					 $('#btnViewFilesList').on('click', function(e) {
				 	        
				 	  		//console.log('View batchlist');
				 	  		
						 prepareFileBatchingModal();
				 	    		
				 	     });


						  $("#btn_process_file_movement_list").click(function(event){
					   	 
							//alert(JSON.stringify(table)); 
					   let request_type ="";
					   var list_of_application_new = JSON.stringify(table)
					   if($('#batch_type').val()==='Unit'){
						   request_type = 'process_file_movement_list';
						   var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a unit to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#btn_process_file_movement_list").removeClass('d-none')
								}
							  })
						   
					   }else{
						   request_type = 'process_file_movement_list';
						   var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a user to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#btn_process_file_movement_list").removeClass('d-none')
								}
							  })
						   
					   }
						   
					   var table = storeTblValues();
					   list_of_application_new = JSON.stringify(table);
					   //console.log(list_of_application_new);
						   
						   
						   
					   console.log("request_type: " + request_type);
					   console.log("userid_1 " + userid_1);
					   console.log("sender " + send_to_name);
					   console.log("sender " + send_to_id);


					   function storeTblValues()
					   {
						   var TableData = new Array();

						   $('#FileListdataTable tr').each(function(row, tr){
							   TableData[row]={
								   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
								   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
								   "locality" : $(tr).find('td:eq(3)').text().trim(),
								   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim()
								   
							   }    
						   }); 
						   TableData.shift();  // first row will be empty - so remove
						   return TableData;
					   }
						
						$.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							data: {
								   request_type: request_type,
								   division: localStorage.getItem('division'),
									 list_of_application:list_of_application_new,
									 send_to_name : send_to_name,
								   send_to_id : send_to_id
									 },
							cache: false,
						   
							success: function(response) {
								   console.log(response)
								   
								 var json_p = JSON.parse(response);
								
								  /* $('#request_type').val('request_to_generate_batch_list');
								   $('#list_of_application').val(list_of_application_new);
								   $('#batch_number').val(json_p.batch_number);
								  
								   $('#modified_by').val(  $( "#user_to_send_to" ).val());
								   //var userid_1 = $( "#user_to_send_to" ).val(); 
								   
								 //  $('#modified_by').val(localStorage.getItem('fullname'));
								   $('#modified_by_id').val( localStorage.getItem('userid'));
								   // $('#downloadForm').submit();
*/								    
										$.ajax({
												type: "POST",
												url: "GenerateCaseReports",
												target : '_blank',
												data: {
													request_type: 'request_to_generate_file_list',
														list_of_application: list_of_application_new,
														batch_number: json_p.batch_number,
														modified_by : localStorage.getItem('fullname'),
														modified_by_id : localStorage.getItem('userid'),
													  send_to_name: send_to_name,
												   send_to_id: send_to_id
														 },
												cache: false,
												xhrFields : {
													   responseType : 'blob'
												   },
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												   //console.log("before ajax");
												   
												   
												   
												   
												},
												success: function(data) {
													console.log(data)
												   
												   
													   $('#elisDocumentPreview').modal({
														  backdrop: 'static',
														});
													
													
													var blob = new Blob(
															   [ data ],
															   {
																   type : "application/pdf"
															   });
												   var objectUrl = URL
															   .createObjectURL(blob);
													   // window.open(objectUrl);
													   console.log("success ajax");

													$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
													   
													   
													   
													 
												},
												complete: function(){
													console.log("Completed ajax");
													$('#viewBatchlistModal').modal('hide');
													console.log("Completed 3 ajax");
													 //Clear Local storage Bactlist
													   localStorage.setItem('batchlistdata', '');
													   //prepareBatchlistModal();
													   
													  
												  }
												});  
					   
								 
							}
							}); 
						
					});

					

					
					$('#frmRequestJobSearch')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('how are your search');

										var enq_search_value = $(
												"#file_search_value").val();
										console.log('Search Value: '
												+ enq_search_value);

										if (!(enq_search_value.length >= 4)) {
											$
													.notify(
															{
																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 4 or more characters to search </span>',
															}, {
																type : 'danger' , z_index: 9999 
															});
										} else {

											

											$.ajax({
														type : "POST",
														url : "Case_Management_Serv",
														data : {
															request_type : 'load_application_details_by_job_number',
															job_number : enq_search_value
														},
														cache : false,
														
														success : function(
																jobdetails) {

														

															var table = $('#file-search-results-table');
															table.find(
																	"tbody tr")
																	.remove();

															//console.log(jobdetails);
															var json_p = JSON
																	.parse(jobdetails);
															
															if(result.job_detail !==null){
																table.append("<tr><td>" 
																		+ json_p.transaction_details.ar_name
																		+ "</td><td>"
																		+  json_p.transaction_details.case_number
																		+ "</td><td>"
																		+ json_p.job_detail.job_number
																		+ "</td><td>"
																		+ json_p.job_detail.business_process_sub_name
																		+ "</td><td>"
																		+ json_p.parcel_details.locality
																		+ "</td>"

																		+ '<td> <button class="btn btn-info" data-toggle="modal" data-target="#askForPurposeOfSendingRequest" id="btnAddRequest"'
																		+ ' data-job_number="'+ json_p.job_detail.job_number+'" data-bs-desc="openall" data-ar_name="'+json_p.transaction_details.ar_name+'" data-business_process_sub_name="'+json_p.job_detail.business_process_sub_name+'" data-locality="'+json_p.parcel_details.locality+'"> Add </button>  '
																		+ '<button class="btn btn-danger" data-toggle="modal" data-target="#checkAppdetailsforRequest"'
																		+ ' data-job_number="'+ json_p.job_detail.job_number+'" data-transaction_number="'+json_p.transaction_details.transaction_number+'"> Details </button>  '
																		+ '</td></tr>'
																
																
																
																)
															}

														

														}
													});
										}
									});

									$('#btnViewRequestsList').on('click', function(e) {
				 	        
										//console.log('View batchlist');
										
										prepareRequestBatchingModal();
										  
								   });


								   $('#btnAddRequest').on('click', function(e) {
				 	        //console.log('jksnfjvnwjsk')
									return;
									  
							   });



							   $("#btn_process_request_list").click(function(event){
					   	 
								//alert(JSON.stringify(table)); 
						   let request_type ="";
						   var list_of_application_new = JSON.stringify(table)
						   if($('#batch_type').val()==='Unit'){
							   request_type = 'process_request_list';
							   var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
								   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
								  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');
	
								  if(!userid_1 || !send_to_id || !send_to_name) {
	
									alert('Please select a unit to send to');
	
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
									}, { type : 'danger' , z_index: 9999  });
	
									return;
	
								  }
	
								  $("#unit_to_send_to").on('input', function(){
									var userid_1 = $(this).val();  // $( "#user_to_send_to option
									if(userid_1){
										$("#btn_process_request_list").removeClass('d-none')
									}
								  })
							   
						   }else{
							   request_type = 'process_request_list';
							   var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
								   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
								  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');
	
								  if(!userid_1 || !send_to_id || !send_to_name) {
	
									alert('Please select a user to send to');
	
									$.notify({
										message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
									}, { type : 'danger' , z_index: 9999  });
	
									return;
	
								  }
	
								  $("#unit_to_send_to").on('input', function(){
									var userid_1 = $(this).val();  // $( "#user_to_send_to option
									if(userid_1){
										$("#btn_process_request_list").removeClass('d-none')
									}
								  })
							   
						   }
							   
						   var table = storeTblValues();
						   list_of_application_new = JSON.stringify(table);
						   //console.log(list_of_application_new);
							   
							   
							   
						   console.log("request_type: " + request_type);
						   console.log("userid_1 " + userid_1);
						   console.log("sender " + send_to_name);
						   console.log("sender " + send_to_id);
	
	
						   function storeTblValues()
						   {
							   var TableData = new Array();
	
							   $('#FileListdataTable tr').each(function(row, tr){
								   TableData[row]={
									   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
									   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
									   "locality" : $(tr).find('td:eq(3)').text().trim(),
									   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
									   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
									   "remarks" : $(tr).find('td:eq(5)').text().trim()
									   
								   }    
							   }); 
							   TableData.shift();  // first row will be empty - so remove
							   return TableData;
						   }
							
							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									   request_type: request_type,
									   division: localStorage.getItem('division'),
										 list_of_application:list_of_application_new,
										 send_to_name : send_to_name,
									   send_to_id : send_to_id,
									   batch_type: $('#batch_type').val()
										 },
								cache: false,
							   
								success: function(response) {
									 //  console.log(response)
									   
									 var json_p = JSON.parse(response);
									
											$.ajax({
													type: "POST",
													url: "GenerateCaseReports",
													target : '_blank',
													data: {
														request_type: 'request_to_generate_request_list',
															list_of_application: list_of_application_new,
															batch_number: json_p.batch_number,
															modified_by : localStorage.getItem('fullname'),
															modified_by_id : localStorage.getItem('userid'),
														  send_to_name: send_to_name,
													   send_to_id: send_to_id,
															 },
													cache: false,
													xhrFields : {
														   responseType : 'blob'
													   },
													beforeSend: function () {
													   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
													   //console.log("before ajax");
													   
													   
													   
													   
													},
													success: function(data) {
														console.log(data)
													   
													   
														   $('#elisDocumentPreview').modal({
															  backdrop: 'static',
															});
														
														
														var blob = new Blob(
																   [ data ],
																   {
																	   type : "application/pdf"
																   });
													   var objectUrl = URL
																   .createObjectURL(blob);
														   // window.open(objectUrl);
														   console.log("success ajax");
	
														$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
														   
														   
														   
														 
													},
													complete: function(){
														console.log("Completed ajax");
														$('#viewFileListModal').modal('hide');
														console.log("Completed 3 ajax");
														 //Clear Local storage Bactlist
														   localStorage.setItem('requestBatchingListData', '');
														   //prepareBatchlistModal();
														   
														  
													  }
													});  
						   
									 
								}
								}); 
							
						});

						

						$("#apbtn_process_request_list").click(function(event){
					   	 
							//alert(JSON.stringify(table)); 
					   let request_type ="";
					   var list_of_application_new = JSON.stringify(table)
					   if($('#batch_type').val()==='Unit'){
						   request_type = 'process_request_list';
						   var userid_1 = $("#rs_unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a unit to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#rs_unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#apbtn_process_request_list").removeClass('d-none')
								}
							  })
						   
					   }else{
						   request_type = 'process_request_list';
						   var userid_1 = $("#rs_user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
							   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
							  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');

							  if(!userid_1 || !send_to_id || !send_to_name) {

								alert('Please select a user to send to');

								$.notify({
									message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
								}, { type : 'danger' , z_index: 9999  });

								return;

							  }

							  $("#rs_unit_to_send_to").on('input', function(){
								var userid_1 = $(this).val();  // $( "#user_to_send_to option
								if(userid_1){
									$("#apbtn_process_request_list").removeClass('d-none')
								}
							  })
						   
					   }
						   
					   var table = storeTblValues();
					   list_of_application_new = JSON.stringify(table);
					   //console.log(list_of_application_new);
						   
						   
						   
					   console.log("request_type: " + request_type);
					   console.log("userid_1 " + userid_1);
					   console.log("sender " + send_to_name);
					   console.log("sender " + send_to_id);


					   function storeTblValues()
					   {
						   var TableData = new Array();

						   $('#FileListdataTable tr').each(function(row, tr){
							   TableData[row]={
								   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
								   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
								   "locality" : $(tr).find('td:eq(3)').text().trim(),
								   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
								   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
								   "remarks" : $(tr).find('td:eq(5)').text().trim()
								   
							   }    
						   }); 
						   TableData.shift();  // first row will be empty - so remove
						   return TableData;
					   }
						
						$.ajax({
							type: "POST",
							url: "Case_Management_Serv",
							data: {
								   request_type: request_type,
								   division: localStorage.getItem('division'),
									 list_of_application:list_of_application_new,
									 send_to_name : send_to_name,
								   send_to_id : send_to_id,
								   batch_type: $('#batch_type').val()
									 },
							cache: false,
						   
							success: function(response) {
								 //  console.log(response)
								   
								 var json_p = JSON.parse(response);
								
										$.ajax({
												type: "POST",
												url: "GenerateCaseReports",
												target : '_blank',
												data: {
													request_type: 'request_to_generate_request_list',
														list_of_application: list_of_application_new,
														batch_number: json_p.batch_number,
														modified_by : localStorage.getItem('fullname'),
														modified_by_id : localStorage.getItem('userid'),
													  send_to_name: send_to_name,
												   send_to_id: send_to_id,
														 },
												cache: false,
												xhrFields : {
													   responseType : 'blob'
												   },
												beforeSend: function () {
												   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
												   //console.log("before ajax");
												   
												   
												   
												   
												},
												success: function(data) {
													console.log(data)
												   
												   
													   $('#elisDocumentPreview').modal({
														  backdrop: 'static',
														});
													
													
													var blob = new Blob(
															   [ data ],
															   {
																   type : "application/pdf"
															   });
												   var objectUrl = URL
															   .createObjectURL(blob);
													   // window.open(objectUrl);
													   console.log("success ajax");

													$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
													   
													   
													   
													 
												},
												complete: function(){
													console.log("Completed ajax");
													$('#viewFileListModal').modal('hide');
													console.log("Completed 3 ajax");
													 //Clear Local storage Bactlist
													   localStorage.setItem('requestBatchingListData', '');
													   //prepareBatchlistModal();
													   
													  
												  }
												});  
					   
								 
							}
							}); 
						
					});


						$(".btnLoadUnitApplications")
						.click(
								function(event) {
									var inbox_type = $(this).data('id');
								if(inbox_type == 2){
									document.getElementById('inbox_text').innerHTML = "Officer/Unit"
								} else if(inbox_type == 4) {
									document.getElementById('inbox_text').innerHTML = "Sent To"
								}
								else if(inbox_type == 5) {
									document.getElementById('inbox_text').innerHTML = "Queried By"
								} else {
									document.getElementById('inbox_text').innerHTML = "Requested By"
								}

								if(inbox_type == 4){
									document.getElementById('send_text').innerHTML = "Archive Request"
								} else {
									document.getElementById('send_text').innerHTML = "Send Request"
								}

								if(inbox_type == 1){
									//document.getElementById('send_text').innerHTML = "Archive Request"
									$("#sendbulkrequest").removeClass('d-none');
								} else {
									//document.getElementById('send_text').innerHTML = "Send Request"
									$("#sendbulkrequest").addClass('d-none');
								}

								if(inbox_type == 4){
									//document.getElementById('send_text').innerHTML = "Archive Request"
									$("#archivebulkrequest").removeClass('d-none');
								} else {
									//document.getElementById('send_text').innerHTML = "Send Request"
									$("#archivebulkrequest").addClass('d-none');
								}
									
									$.ajax({
												type : "POST",
												url : "Case_Management_Serv",
												data : {
													request_type : 'load_app_request_at_unit_by_inbox_type',
													inbox_type : inbox_type + '_false',
												},

												success : function(
														jobdetails) {
													
													// console.log(jobdetails);
													var json_p = JSON
															.parse(jobdetails);


													/*
													 * $('th:nth-child(7)').show();
													 * $('th:nth-child(8)').show();
													 */

													// datatable.column(0)
													// 		.visible(false);
													// datatable.column(1).visible(false);

													
													//datatable.column(0).visible(false);
													//datatable.column(1).visible(false);

													datatable.search("")
															.draw();
													datatable.state.clear();
													datatable.clear();

													$("#body-dg-1")
															.removeClass(
																	'bg-dark');
													$("#number-text-1")
															.removeClass(
																	'text-white');
													$("#number-text-1")
															.addClass(
																	'text-gray-800');
													$("#body-dg-2")
															.removeClass(
																	'bg-dark');
													$("#number-text-2")
															.removeClass(
																	'text-white');
													$("#number-text-2")
															.addClass(
																	'text-gray-800');
													$("#body-dg-3")
															.removeClass(
																	'bg-dark');
													$("#number-text-3")
															.removeClass(
																	'text-white');
													$("#number-text-3")
															.addClass(
																	'text-gray-800');
													$("#body-dg-4")
															.removeClass(
																	'bg-dark');
													$("#number-text-4")
															.removeClass(
																	'text-white');
													$("#number-text-4")
															.addClass(
																	'text-gray-800');

													$("#body-dg-5")
													.removeClass(
															'bg-dark');
														$("#number-text-5")
																.removeClass(
																		'text-white');
														$("#number-text-5")
																.addClass(
																		'text-gray-800');

													$(json_p.data)
															.each(
																	function() {

																		datatable.row
																				.add([

																					'<input type="checkbox"/>',
																					this.created_on,
																					this.job_number,
																					this.ar_name,
																					this.business_process_sub_name,
																					this.job_purpose,
																					inbox_type == 2 ? this.officer_comments : this.remarks,
																					this.job_status,
																					inbox_type == 2 ? this.job_recieved_by : this.job_forwarded_by,

																					inbox_type == 4 ? 
																					
																					'<div class="text-center"><button  class="btn btn-danger"  data-title="Add to List"  id="btnAddToBatchlist-'
																							+ this.job_number
																							+ '" data-job_number="'
																							+ this.job_number
																							+ '" data-ar_name="'
																							+ this.ar_name
																							+ '" data-business_process_sub_name="'
																							+ this.business_process_sub_name
																							+ '" data-job_purpose="'
																							+ this.job_purpose
																							+ '" data-req_id="'
																							+ this.rq_id
																							+ '" data-target="#askArchiveRequest" data-toggle="modal" >'
																							+ ' <i class="fas fa-trash"></i>'
																							+ ' </button><div>' 
																					
																					: 

																					inbox_type == 3 && this.job_purpose == 'Certificate Signing' ? 
																					// inbox_type == 3 ? 
																					
																					'<div class="text-center"><button  class="btn btn-info"  data-title="Add to List"  id="btnAddToBatchlist-'
																							+ this.job_number
																							+ '" data-job_number="'
																							+ this.job_number
																							+ '" data-ar_name="'
																							+ this.ar_name
																							+ '" data-business_process_sub_name="'
																							+ this.business_process_sub_name
																							+ '" data-job_purpose="'
																							+ this.job_purpose
																							+ '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
																							+ ' <i class="fas fa-paper-plane"></i>'
																							+ ' </button><div>'
																							
																							:

																							'<div class="text-center"><button  class="btn btn-info"  data-title="Add to List"  id="btnAddToBatchlist-'
																							+ this.job_number
																							+ '" data-job_number="'
																							+ this.job_number
																							+ '" data-ar_name="'
																							+ this.ar_name
																							+ '" data-business_process_sub_name="'
																							+ this.business_process_sub_name
																							+ '" data-job_purpose="'
																							+ this.job_purpose
																							+ '" data-target="#askForPurposeOfSendingRequesttoOfficer" data-toggle="modal" >'
																							+ ' <i class="fas fa-paper-plane"></i>'
																							+ ' </button><div>'
																							,

																					'<form action="front_office_view_application" method="post">'
																							+ '<input type="hidden" name="case_number" id="case_number" value="'
																							+ this.transaction_number
																							+ '">'
																							+ '<input type="hidden" name="search_text" id="search_text" value="'
																							+ this.case_number
																							+ '">'
																							+ '<input type="hidden" name="job_number" id="job_number" value="'
																							+ this.job_number
																							+ '">'
																							+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
																							+ this.business_process_sub_name
																							+ '">'

																							+ '	<div class="text-center"><button type="submit" name="save" class="btn btn-primary" >'

																							+ '	<i class="fas fa-eye"></i>'
																							+ '	</button><div></form>',

																							'<form action="new_request_application_progress_details" method="post">'
																							+ '<input type="hidden" name="case_number" id="case_number" value="'
																							+ this.transaction_number
																							+ '">'
																							+ '<input type="hidden" name="review_instruction" id="review_instruction" value="'
																							+ this.remarks
																							+ '">'
																							+ '<input type="hidden" name="transaction_number" id="transaction_number" value="'
																							+ this.transaction_number
																							+ '">'
																							+ '<input type="hidden" name="job_number" id="job_number" value="'
																							+ this.job_number
																							+ '">'
																							+ '<input type="hidden" name="job_purpose" id="job_purpose" value="'
																							+ this.job_purpose
																							+ '">'
																							+ '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'
																							+ this.business_process_sub_name
																							+ '">'

																							+ '		<div class="text-center"><button type="submit" name="save" class="btn btn-danger btn-to-be-disabled to_hide_on_level_1" >'

																							+ '	<i class="fas fa-folder-open"></i>'
																							+ '	</button><div></form>'
																							

																						])
																				.draw(
																						false);
																		datatable
																				.column(
																						2)
																				.data()
																				.sort();

																	});

													switch (inbox_type) {
													case 1:

														$(".btn-to-be-disabled").prop('disabled',true);
														//datatable.column(11).visible(true);

														$("#body-dg-1")
																.addClass(
																		'bg-dark');
														$("#number-text-1")
																.removeClass(
																		'text-gray-800');
														$("#number-text-1")
																.addClass(
																		'text-white');

														break;
													case 2:

														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		false);

														$("#body-dg-2")
																.addClass(
																		'bg-dark');
														$("#number-text-2")
																.removeClass(
																		'text-gray-800');
														$("#number-text-2")
																.addClass(
																		'text-white');
														//datatable.column(11).visible(true);

														break;
													case 3:
														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		false);

														$("#body-dg-3")
																.addClass(
																		'bg-dark');
														$("#number-text-3")
																.removeClass(
																		'text-gray-800');
														$("#number-text-3")
																.addClass(
																		'text-white');
														//datatable.column(11).visible(true);
														break;
													case 4:
														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		true);
														// datatable
														// 		.column(11)
														// 		.visible(
														// 				false);

														$("#body-dg-4")
																.addClass(
																		'bg-dark');
														$("#number-text-4")
																.removeClass(
																		'text-gray-800');
														$("#number-text-4")
																.addClass(
																		'text-white');
														break;
														case 5:
														$(
																".btn-to-be-disabled")
																.prop(
																		'disabled',
																		true);
														// datatable
														// 		.column(11)
														// 		.visible(
														// 				false);

														$("#body-dg-5")
																.addClass(
																		'bg-dark');
														$("#number-text-5")
																.removeClass(
																		'text-gray-800');
														$("#number-text-5")
																.addClass(
																		'text-white');
														break;
													default:
														// code block
													}


												}

											});

								});


				$("#btn_process_request_list_to_user").click(function(event){
					   	 
									//alert(JSON.stringify(table)); 
							   let request_type ="";
							   var list_of_application_new = JSON.stringify(table)
							   if($('#batch_type').val()==='Unit'){
								   request_type = 'process_request_list_to_user';
								   var userid_1 = $("#unit_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
									   var  send_to_id  = $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('id');
									  var  send_to_name= $('#listofunitsbatching option').filter(function() {return this.value == userid_1; }).data('name');
		
									  if(!userid_1 || !send_to_id || !send_to_name) {
		
										alert('Please select a unit to send to');
		
										$.notify({
											message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a unit</span>',
										}, { type : 'danger' , z_index: 9999  });
		
										return;
		
									  }
		
									  $("#unit_to_send_to").on('input', function(){
										var userid_1 = $(this).val();  // $( "#user_to_send_to option
										if(userid_1){
											$("#btn_process_request_list_to_user").removeClass('d-none')
										}
									  })
								   
							   }else{
								   request_type = 'process_request_list_to_user';
								   var userid_1 = $("#user_to_send_to").val();  // $( "#user_to_send_to option:selected" ).text();
									   var  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('id');
									  var  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == userid_1; }).data('name');
		
									  if(!userid_1 || !send_to_id || !send_to_name) {
		
										alert('Please select a user to send to');
		
										$.notify({
											message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select a user</span>',
										}, { type : 'danger' , z_index: 9999  });
		
										return;
		
									  }
		
									  $("#unit_to_send_to").on('input', function(){
										var userid_1 = $(this).val();  // $( "#user_to_send_to option
										if(userid_1){
											$("#btn_process_request_list_to_user").removeClass('d-none')
										}
									  })
								   
							   }
								   
							   var table = storeTblValues();
							   list_of_application_new = JSON.stringify(table);
							   //console.log(list_of_application_new);
								   
								   
								   
							   console.log("request_type: " + request_type);
							   console.log("userid_1 " + userid_1);
							   console.log("sender " + send_to_name);
							   console.log("sender " + send_to_id);
		
		
							   function storeTblValues()
							   {
								   var TableData = new Array();
		
								   $('#FileListdataTable tr').each(function(row, tr){
									   TableData[row]={
										   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
										   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
										   "locality" : $(tr).find('td:eq(3)').text().trim(),
										   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
										   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
										   "remarks" : $(tr).find('td:eq(5)').text().trim()
										   
									   }    
								   }); 
								   TableData.shift();  // first row will be empty - so remove
								   return TableData;
							   }
								
								$.ajax({
									type: "POST",
									url: "Case_Management_Serv",
									data: {
										   request_type: request_type,
										   division: localStorage.getItem('division'),
											 list_of_application:list_of_application_new,
											 send_to_name : send_to_name,
										   send_to_id : send_to_id,
											 },
									cache: false,
								   
									success: function(response) {
										   console.log(response)
										   
										 var json_p = JSON.parse(response);
										
										  /* $('#request_type').val('request_to_generate_batch_list');
										   $('#list_of_application').val(list_of_application_new);
										   $('#batch_number').val(json_p.batch_number);
										  
										   $('#modified_by').val(  $( "#user_to_send_to" ).val());
										   //var userid_1 = $( "#user_to_send_to" ).val(); 
										   
										 //  $('#modified_by').val(localStorage.getItem('fullname'));
										   $('#modified_by_id').val( localStorage.getItem('userid'));
										   // $('#downloadForm').submit();

										   
		*/								    
											if(json_p.success == true) {
												$.ajax({
														type: "POST",
														url: "GenerateCaseReports",
														target : '_blank',
														data: {
															request_type: 'request_to_generate_request_list',
																list_of_application: list_of_application_new,
																batch_number: json_p.batch_number,
																modified_by : localStorage.getItem('fullname'),
																modified_by_id : localStorage.getItem('userid'),
															  send_to_name: send_to_name,
														   send_to_id: send_to_id
																 },
														cache: false,
														xhrFields : {
															   responseType : 'blob'
														   },
														beforeSend: function () {
														   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
														   //console.log("before ajax");
														   
														   
														   
														   
														},
														success: function(data) {
															console.log(data)
														   
														   
															   $('#elisDocumentPreview').modal({
																  backdrop: 'static',
																});
															
															
															var blob = new Blob(
																	   [ data ],
																	   {
																		   type : "application/pdf"
																	   });
														   var objectUrl = URL
																	   .createObjectURL(blob);
															   // window.open(objectUrl);
															   console.log("success ajax");
		
															$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
															   
															   
															   
															 
														},
														complete: function(){
															console.log("Completed ajax");
															$('#viewBatchlistModal').modal('hide');
															console.log("Completed 3 ajax");
															 //Clear Local storage Bactlist
															   localStorage.setItem('requestBatchingListData', '');
															   //prepareBatchlistModal();
															   
															  
														  }
														});  
							   
													}

													else {

														$.notify({
															message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Oops! Action can not be done. The selected officer has '+json_p.user_count+' case(s).</span>',
														}, {
															type: 'danger'
														});

														alert('Oops! Action can not be done. The selected officer has '+json_p.user_count+' case(s).')
													}
									}
									}); 

							});

							

							$("#btn_process_to_arachive_request_list").click(function(event){
					   	 
								//alert(JSON.stringify(table)); 
						   let request_type ="";
						   var list_of_application_new = JSON.stringify(table)
							   
						   var table = storeTblValues();
						   list_of_application_new = JSON.stringify(table);
						   //console.log(list_of_application_new);
							
	
	
						   function storeTblValues()
						   {
							   var TableData = new Array();
	
							   $('#ArchiveListdataTable tr').each(function(row, tr){
								   TableData[row]={
									   "job_number" : $(tr).find('td:eq(0)').text().trim() ,
									   "ar_name" : $(tr).find('td:eq(1)').text().trim(),
									   "locality" : $(tr).find('td:eq(3)').text().trim(),
									   "business_process_sub_name" : $(tr).find('td:eq(2)').text().trim(),
									   "job_purpose" : $(tr).find('td:eq(4)').text().trim(),
									   "remarks" : $(tr).find('td:eq(5)').text().trim()
									   
								   }    
							   }); 
							   TableData.shift();  // first row will be empty - so remove
							   return TableData;
						   }
							
							$.ajax({
								type: "POST",
								url: "Case_Management_Serv",
								data: {
									   request_type: 'process_request_list_to_archive',
										 list_of_application:list_of_application_new,
										 },
								cache: false,
							   
								success: function(response) {
									   console.log(response)
									   
									 var json_p = JSON.parse(response);
									
									  /* $('#request_type').val('request_to_generate_batch_list');
									   $('#list_of_application').val(list_of_application_new);
									   $('#batch_number').val(json_p.batch_number);
									  
									   $('#modified_by').val(  $( "#user_to_send_to" ).val());
									   //var userid_1 = $( "#user_to_send_to" ).val(); 
									   
									 //  $('#modified_by').val(localStorage.getItem('fullname'));
									   $('#modified_by_id').val( localStorage.getItem('userid'));
									   // $('#downloadForm').submit();

									   
	*/								    
												if(json_p.success == true) {

													$('#viewArchiveListModal').modal('hide');
													
													$.notify({
														message: '<i class="fa fa-check-circle  fa-3x fa-fw"></i><span class="text-bold"> Selected request has been archived successfully.</span>',
													}, {
														type: 'success'
													});
													localStorage.setItem('requestArchiveListData', '');

											// $.ajax({
											// 		type: "POST",
											// 		url: "GenerateCaseReports",
											// 		target : '_blank',
											// 		data: {
											// 			request_type: 'request_to_generate_request_list',
											// 				list_of_application: list_of_application_new,
											// 				batch_number: json_p.batch_number,
											// 				modified_by : localStorage.getItem('fullname'),
											// 				modified_by_id : localStorage.getItem('userid'),
											// 			  send_to_name: send_to_name,
											// 		   send_to_id: send_to_id
											// 				 },
											// 		cache: false,
											// 		xhrFields : {
											// 			   responseType : 'blob'
											// 		   },
											// 		beforeSend: function () {
											// 		   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
											// 		   //console.log("before ajax");
													   
													   
													   
													   
											// 		},
											// 		success: function(data) {
											// 			console.log(data)
													   
													   
											// 			   $('#elisDocumentPreview').modal({
											// 				  backdrop: 'static',
											// 				});
														
														
											// 			var blob = new Blob(
											// 					   [ data ],
											// 					   {
											// 						   type : "application/pdf"
											// 					   });
											// 		   var objectUrl = URL
											// 					   .createObjectURL(blob);
											// 			   // window.open(objectUrl);
											// 			   console.log("success ajax");
	
											// 			$('#elisdovumentpreviewblobfile').attr('src',objectUrl);
														   
														   
														   
														 
											// 		},
											// 		complete: function(){
											// 			console.log("Completed ajax");
											// 			$('#viewBatchlistModal').modal('hide');
											// 			console.log("Completed 3 ajax");
											// 			 //Clear Local storage Bactlist
											// 			   localStorage.setItem('batchlistdata', '');
											// 			   //prepareBatchlistModal();
														   
														  
											// 		  }
											// 		});  
						   
												}

												else {

													$.notify({
														message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold"> Oops! Action can not be done. Something went wrong.</span>',
													}, {
														type: 'danger'
													});

													alert('Oops! Something went wrong.')
												}
								}
								}); 

						});

							$('#req_job_purpose').on('change', function(e) {

								var job_purpose = $('#req_job_purpose').val();
								var job_number = $('#req_job_number').val();

								console.log(job_number);

								if(job_purpose == 'Certificate Generation' || job_purpose == 'Certificate Generation Transition' ||  job_purpose == 'Folio and Volume Generation') {

									$.ajax({
										type: "POST",
										url: "Case_Management_Serv",
										data: {
											   request_type: 'select_check_wkt_polygon_by_job_number',
											   job_number : job_number,
											},
										cache: false,
									   
										success: function(response) {
											//console.log(response)
											   
											var json_p = JSON.parse(response);

											if(json_p.data || json_p.data != null){
												$('#btnaddreqtolistFinal').removeClass('d-none');
											} else {
												$('#btnaddreqtolistFinal').addClass('d-none');

												alert('Application has not been noted');
		
												$.notify({
													message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Application has not been noted</span>',
												}, { type : 'danger' , z_index: 9999  });

											}
											
										}
									}); 

								} else {
									$('#btnaddreqtolistFinal').removeClass('d-none');
								}

							})




		   $('#checkAppdetailsforRequest').on('show.bs.modal', function(e) {
			// $('#req_job_number').val($(e.relatedTarget).data('job_number'));
			// $('#req_ar_name').val($(e.relatedTarget).data('transaction_number'));

			var job_number = $(e.relatedTarget).data('job_number');
			var transaction_number = $(e.relatedTarget).data('transaction_number')

			if(transaction_number || job_purpose) {

				$.ajax({
					type: "POST",
					url: "Case_Management_Serv",
					data: {
						   request_type: 'select_check_application_details_for_request',
						   job_number : job_number,
						   transaction_number: transaction_number
						},
					cache: false,
				   
					success: function(response) {
						
						   
						var json_p = JSON.parse(response);
						console.log(json_p)

						var registration_district_number = json_p.parcel_details.registration_district_number
						var registration_section_number = json_p.parcel_details.registration_section_number
						var registration_block_number = json_p.parcel_details.registration_block_number
						var folio_number = json_p.transaction_details.folio_number
						var volume_number = json_p.transaction_details.volume_number
						var parcel_wkt = json_p.parcel_wkt

						$('#reqsss_job_number').val(job_number)
						$('#req_districk_no').val(registration_district_number)
						$('#req_section_no').val(registration_section_number)
						$('#req_block_no').val(registration_block_number)
						$('#req_folio_no').val(folio_number)
						$('#req_volume_no').val(volume_number)
						$('#req_parcel_wkt').val(parcel_wkt)
					}
				}); 

			} else {
				//
			}
				
           });


		   $('#btnAddAlltoRequestlist').on('click', function(e) {
				var remarks_notes = $("#txt_general_remarks_notes").val();
			
				if (remarks_notes) {
					var confirmText = "Are you sure you want to add these application to the list?";
					if (confirm(confirmText)) {
						$("#job_casemgtdetailsdataTable input[type=checkbox]:checked, #job_detailsdataTable input[type=checkbox]:checked").each(
							function() {
								var row = $(this).closest("tr")[0];
								var job_number = row.cells[2].innerHTML;
								var ar_name = row.cells[3].innerHTML;
								var business_process_sub_name = row.cells[4].innerHTML;
								var job_purpose = row.cells[5].innerHTML;
								addRequestToList(
									job_number,
									ar_name,
									business_process_sub_name,
									"",
									job_purpose,
									remarks_notes
								);
							});

							prepareRequestBatchingModal();

							// $('#viewBatchlistModal #lbl_batch_type').val('cst');
					}
				} else {
					$.notify(
						{
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Purpose of batching required ! </span>',
						}, {
							type : 'danger' , z_index: 9999 
						});
				}

			});

			

			$('#btnAddAlltoArchivelist').on('click', function(e) {
				var remarks_notes = $("#txt_general_archive_notes").val();

				localStorage.removeItem('requestArchiveListData');
			
				if (remarks_notes) {
					var confirmText = "Are you sure you want to add these application to the archive list?";
					if (confirm(confirmText)) {
						$("#job_casemgtdetailsdataTable input[type=checkbox]:checked").each(
							function() {
								var row = $(this).closest("tr")[0];
								var job_number = row.cells[2].innerHTML;
								var ar_name = row.cells[3].innerHTML;
								var business_process_sub_name = row.cells[4].innerHTML;
								var job_purpose = row.cells[5].innerHTML;
								addArchiveToList(
									job_number,
									ar_name,
									business_process_sub_name,
									"",
									job_purpose,
									remarks_notes
								);
							});

							prepareRequestArchiveModal();

							// $('#viewBatchlistModal #lbl_batch_type').val('cst');
					}
				} else {
					$.notify(
						{
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Note for archiving is required ! </span>',
						}, {
							type : 'danger' , z_index: 9999 
						});
				}

			});
});
