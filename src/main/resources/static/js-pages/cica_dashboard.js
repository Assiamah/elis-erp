$(function() {
    
    // ==================== CONSTANTS & CONFIGURATION ====================
    const STATUS_MAP = {
        0: 'Open',
        1: 'On Hold',
        2: 'Pending',
        3: 'Resolved'
    };

    const PURPOSE_MAP = {
        1: 'Service Enquiry',
        2: 'Other Enquiry',
        3: 'Service Complaint',
        4: 'Non-service Complaint'
    };

    const DIVISIONS = ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'];
    const REGIONS = [
        'Greater Accra', 'Western', 'Volta', 'Eastern', 'Ashanti', 
        'Central', 'Northern', 'Upper East', 'Upper West', 'Oti',
        'Bono East', 'Ahafo', 'Bono', 'North East', 'Savannah', 'Western North'
    ];

    let dataTables = {
        service: null,
        other: null
    };

    // ==================== UTILITY FUNCTIONS ====================
    
    /**
     * Convert date string to readable format
     */
    function convertDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-GB', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    }

    /**
     * Format status with badge HTML
     */
    function formatStatusBadge(status) {
        const statusText = STATUS_MAP[status] || 'Unknown';
        const badgeClass = {
            'Open': 'badge bg-info',
            'On Hold': 'badge bg-dark',
            'Pending': 'badge bg-warning',
            'Resolved': 'badge bg-success'
        }[statusText] || 'badge bg-secondary';
        
        return `<span class="${badgeClass}">${statusText}</span>`;
    }

    /**
     * Format priority with badge
     */
    function formatPriorityBadge(priority) {
        const priorityClass = {
            'High': 'badge bg-danger',
            'Medium': 'badge bg-warning',
            'Low': 'badge bg-success'
        }[priority] || 'badge bg-secondary';
        
        return `<span class="${priorityClass}">${priority}</span>`;
    }

    /**
     * Safe get nested value
     */
    function safeGet(obj, path, defaultValue = '') {
        return path.split('.').reduce((acc, part) => acc && acc[part], obj) || defaultValue;
    }

    // ==================== UI UPDATE FUNCTIONS ====================

    /**
     * Update KPI cards with values
     */
    function updateKPICards(data) {
        const kpiMap = {
            'total': 'total',
            'open': 'open',
            'pending': 'pending',
            'hold': 'hold',
            'resolved': 'resolved'
        };

        Object.entries(kpiMap).forEach(([key, elementId]) => {
            const element = document.getElementById(elementId);
            if (element && data[key] !== undefined) {
                element.textContent = data[key];
            }
        });
    }

    /**
     * Update division stats cards
     */
    function updateDivisionStats(data) {
        if (!data) return;
        
        const divisionMap = {
            'pvlmd': 'pvlmd',
            'lrd': 'lrd',
            'smd': 'smd',
            'lvd': 'lvd',
            'corporate': 'corporate'
        };

        Object.entries(divisionMap).forEach(([key, elementId]) => {
            const element = document.getElementById(elementId);
            if (element && data[key] !== undefined) {
                element.textContent = data[key];
            }
        });
    }

    /**
     * Update chart based on filters
     */
    function updateChart(json_result, filters) {
		const { purpose, region, status, division } = filters;
		
		// Don't show chart for purpose 2 (Other Enquiry)
		if (purpose === '2') {
			$('#cica_chart').addClass('d-none');
			return;
		}

		$('#cica_chart').removeClass('d-none');
		
		// Check if Plotly is available
		if (typeof Plotly === 'undefined') {
			console.error('Plotly library is not loaded!');
			$('#barChart').html('<div class="alert alert-warning">Chart library not loaded. Please refresh the page.</div>');
			return;
		}
		
		let chartData = [];
		let chartLayout = { 
			barmode: 'group', 
			title: 'Service Related Complaints',
			xaxis: { title: 'Categories' },
			yaxis: { title: 'Count' }
		};

		try {
			if (division === 'ALL' && region === '0') {
				// Division breakdown by status
				if (status === '4') {
					// All statuses
					const statusTypes = ['open', 'pending', 'resolved', 'hold'];
					const statusNames = ['Open', 'Pending', 'Resolved', 'On Hold'];
					
					statusTypes.forEach((statusType, index) => {
						chartData.push({
							x: DIVISIONS,
							y: DIVISIONS.map(d => json_result[`${d.toLowerCase()}_${statusType}`] || 0),
							name: statusNames[index],
							type: 'bar'
						});
					});
				} else {
					// Single status
					chartData.push({
						x: DIVISIONS,
						y: DIVISIONS.map(d => json_result[d.toLowerCase()] || 0),
						name: 'Count',
						type: 'bar'
					});
				}
			} else if (division !== 'ALL' && region === '0') {
				// Single division - show status breakdown
				chartData.push({
					x: ['Open', 'Pending', 'On Hold', 'Resolved'],
					y: [
						json_result.open || 0,
						json_result.pending || 0,
						json_result.hold || 0,
						json_result.resolved || 0
					],
					name: 'Status',
					type: 'bar'
				});
			} else if (division === 'ALL' && region !== '0') {
				// Regional breakdown
				chartData.push({
					x: REGIONS,
					y: REGIONS.map(r => json_result[r.toLowerCase().replace(/ /g, '_')] || 0),
					name: 'Region Count',
					type: 'bar'
				});
			}

			// Clear existing chart before plotting new one
			const chartDiv = document.getElementById('barChart');
			if (chartDiv) {
				Plotly.purge(chartDiv); // Clean up existing chart
			}

			if (chartData.length) {
				Plotly.newPlot('barChart', chartData, chartLayout, {
					responsive: true,
					displaylogo: false,
					modeBarButtonsToRemove: ['sendDataToCloud']
				});
			} else {
				// Show empty chart message
				Plotly.newPlot('barChart', [{
					x: ['No Data'],
					y: [0],
					type: 'bar',
					marker: { color: '#ccc' }
				}], {
					title: 'No Data Available',
					annotations: [{
						text: 'No data matches your filter criteria',
						x: 0.5,
						y: 0.5,
						xref: 'paper',
						yref: 'paper',
						showarrow: false
					}]
				});
			}
		} catch (error) {
			console.error('Error creating chart:', error);
			$('#barChart').html('<div class="alert alert-danger">Error loading chart. Please try again.</div>');
		}
	}

    /**
     * Toggle visibility of UI sections
     */
    function toggleSections(filters, json_result) {
        const { purpose, region, status, division } = filters;
        
        const showStatusCards = (region === '0' && status === '4') || 
                               (region !== '0' && status === '4') ||
                               (region === '0' && status !== '4' && division === 'ALL') ||
                               (region !== '0' && status !== '4' && division !== 'ALL');
        
        const showDivisionCards = (region === '0' && status !== '4' && division === 'ALL') ||
                                 (region !== '0' && status !== '4' && division === 'ALL');

        $('#div_status').toggleClass('d-none', !showStatusCards);
        $('#div_division').toggleClass('d-none', !showDivisionCards);
        
        // Update division stats if visible
        if (showDivisionCards && json_result) {
            updateDivisionStats(json_result);
        }
    }

    // ==================== DATA PROCESSING FUNCTIONS ====================

    /**
     * Process service data for table
     */
    function processServiceData(data) {
        if (!data || !data.length) return [];
        
        return data.map((item, index) => {
            const status = STATUS_MAP[item.status] || 'Unknown';
            const purpose = PURPOSE_MAP[item.purpose] || item.purpose;
            
            return [
                index + 1,
                item.ticket_no || '',
                item.client_name || '',
                item.client_phone || '',
                item.client_email || '',
                purpose,
                item.subject || '',
                formatStatusBadge(item.status),
                formatPriorityBadge(item.priority),
                item.division || '',
                item.region_name || '',
                item.created_by || '',
                convertDate(item.created_at),
                convertDate(item.sent_date)
            ];
        });
    }

    /**
     * Process other enquiry data for table
     */
    function processOtherData(data) {
        if (!data || !data.length) return [];
        
        return data.map((item, index) => [
            index + 1,
            item.ticket_no || '',
            item.client_name || '',
            item.client_phone || '',
            item.client_email || '',
            item.reference_source || '',
            item.milestone_status || '',
            item.nature_of_enquiry || '',
            item.region_name || '',
            item.created_by || '',
            convertDate(item.created_at),
            convertDate(item.sent_date)
        ]);
    }

    /**
     * Initialize or refresh DataTable
     */
    function refreshDataTable(tableId, data, purpose) {
        const isOtherEnquiry = purpose === '2';
        const tableKey = isOtherEnquiry ? 'other' : 'service';
        const tableSelector = isOtherEnquiry ? '#other_table_list' : '#table_list';
        
        // Destroy existing DataTable
        if (dataTables[tableKey]) {
            dataTables[tableKey].destroy();
            dataTables[tableKey] = null;
        }
        
        // Show/hide appropriate tables
        $('#service_tbl, #other_service_tbl').hide();
        $(isOtherEnquiry ? '#other_service_tbl' : '#service_tbl').show();
        
        // Initialize new DataTable
        if (data.length) {
            const processedData = isOtherEnquiry ? processOtherData(data) : processServiceData(data);
            
            dataTables[tableKey] = $(tableSelector).DataTable({
                data: processedData,
                dom: 'Bfrtip',
                pageLength: 10,
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
                buttons: [
                    'copy', 'csv', 'excel', 'print',
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        title: `CICA - ${PURPOSE_MAP[purpose] || 'Reports'}`,
                        pageSize: 'A4'
                    }
                ],
                responsive: true,
                language: {
                    emptyTable: 'No data available'
                }
            });
        }
    }

    // ==================== EVENT HANDLERS ====================

    /**
     * Handle purpose change - toggle additional filters
     */
    $("#purpose").on('change', function(e) {
        e.preventDefault();
        const purpose = $(this).val();
        $('#purpose_div').toggleClass('d-none', purpose === '2');
        
        // Reset filters when switching to Other Enquiry
        if (purpose === '2') {
            $('#status, #division, #region_id').val('0');
            $('#div_division, #div_status, #cica_chart').addClass('d-none');
        }
    });

    /**
     * Handle form submission
     */
    $("#cica_reports_form").on('submit', function(e) {
        e.preventDefault();
        
        // Get form values
        const filters = {
            start_date: $('input[name="start_date"]').val(),
            end_date: $('input[name="end_date"]').val(),
            purpose: $('#purpose').val(),
            division: $('#division').val(),
            region: $('#region_id').val().replace('.0', ''),
            status: $('#status').val()
        };

        // Validate required fields
        if (!filters.start_date || !filters.end_date || !filters.purpose) {
            Swal.fire({
                icon: 'warning',
                title: 'Missing Fields',
                text: 'Please fill in all required fields'
            });
            return;
        }

        // Show loading state
        const $submitBtn = $("#apply_filter");
        $submitBtn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Loading...');
        
        $('#_show_column').removeClass('d-none');

        // Make AJAX call
        $.ajax({
            type: "POST",
            url: "cica_dashboard_serv",
            data: {
                request_type: "reports",
                ...filters
            },
            dataType: 'json',
            success: function(response) {
                console.log('Response:', response);
                
                let json_result;
                try {
                    json_result = typeof response === 'string' ? JSON.parse(response) : response;
                } catch (e) {
                    console.error('Parse error:', e);
                    return;
                }

                // Update UI based on filters
                toggleSections(filters, json_result);
                updateChart(json_result, filters);
                
                // Update KPI cards
                if (json_result.total !== undefined) {
                    updateKPICards(json_result);
                }

                // Refresh data table
                refreshDataTable(
                    filters.purpose === '2' ? '#other_table_list' : '#table_list',
                    json_result.data || [],
                    filters.purpose
                );
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to load data. Please try again.'
                });
            },
            complete: function() {
                $submitBtn.prop('disabled', false).text('Apply Filter');
            }
        });
    });

    // ==================== COLUMN TOGGLE FUNCTIONS ====================

    window.togglePhoneColumn = function(columnIndex) {
        const table = $('#table_list').DataTable();
        const column = table.column(columnIndex);
        column.visible(!column.visible());
        $('#_phone_option_status').text(column.visible() ? 'On' : 'Off');
    };

    window.toggleEmailColumn = function(columnIndex) {
        const table = $('#table_list').DataTable();
        const column = table.column(columnIndex);
        column.visible(!column.visible());
        $('#_email_option_status').text(column.visible() ? 'On' : 'Off');
    };

    // ==================== INITIALIZATION ====================

    // Initialize DataTables with empty data
    dataTables.service = $('#table_list').DataTable({
        data: [],
        dom: 'Bfrtip',
        buttons: ['copy', 'csv', 'excel', 'print']
    });

    dataTables.other = $('#other_table_list').DataTable({
        data: [],
        dom: 'Bfrtip',
        buttons: ['copy', 'csv', 'excel', 'print']
    });

    // Hide other table initially
    $('#other_service_tbl').hide();

    // Set default dates if not set
    if (!$('#start_date').val()) {
        const today = new Date();
        const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
        $('#start_date').val(firstDay.toISOString().split('T')[0]);
        $('#end_date').val(today.toISOString().split('T')[0]);
    }
});