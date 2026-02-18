
    // Global variables
    let startDate = null;
     let regionId = null;
    let endDate = null;
    let trendsChart;
     let StrD = null;
      let EndD = null;

    // Initialize flatpickr for Date From
    const dateFromPicker = flatpickr("#datefrom", {
        dateFormat: "Y-m-d",
        altInput: true,
        altFormat: "j F Y",
        allowInput: true,
        onChange: function(selectedDates, dateStr, instance) {
            if (selectedDates[0]) {
                let formattedDate = instance.formatDate(selectedDates[0], "j F Y");
                $('#start_date').val(dateStr);
                $('#startdate').val(formattedDate);
                dateToPicker.set('minDate', dateStr);
                startDate = dateStr;

                // If end date is already set, refresh dashboard
                // if (endDate) {
                //     refreshDashboard();
                // }
            }
        }
    });

    // Initialize flatpickr for Date To
    const dateToPicker = flatpickr("#dateto", {
        dateFormat: "Y-m-d",
        altInput: true,
        altFormat: "j F Y",
        allowInput: true,
        onChange: function(selectedDates, dateStr, instance) {
            if (!$('#datefrom').val()) {
                alert("Please select 'Date From' before selecting 'Date To'.");
                $('#dateto').val('');
                return;
            }
            let dateFromVal = $('#datefrom').val();
            if (new Date(dateStr) < new Date(dateFromVal)) {
                alert("End date cannot be earlier than start date.");
                $('#dateto').val('');
                return;
            }

            let formattedDate = instance.formatDate(selectedDates[0], "j F Y");
            $('#end_date').val(dateStr);
            $('#enddate').val(formattedDate);
            endDate = dateStr;
           regionId = $('#sel_change_region_compliance').val();

             StrD = $('#startdate').val();
             EndD = $('#enddate').val();


            // Refresh dashboard when both dates are set
            refreshDashboard();
        }
    });

    // Function to refresh all dashboard data
    function refreshDashboard() {
        if (!startDate || !endDate) return;

        console.log("Fetching dashboard stats for region", regionId, "from", startDate, "to", endDate);

        $.ajax({
            type: "POST",
            url: "csau_manager_dashboard",
            data: {
                request_type: 'load_csau_monitoring_dashboard',
                regional_code: regionId,
                start_date: startDate,
                end_date: endDate
            },
            cache: false,
            success: function(response) {
                var data = JSON.parse(response);

            console.log("Dashboard response:", data);

                updateDashboardUI(data);
            },
            error: function(xhr, status, error) {
                console.error("Error loading dashboard data:", error);
                alert("An error occurred while loading data. Please try again later.");
            }
        });




        

        //   $('#csau_applications_received_today').on('click', function(e) {

        //        $("#officerModal").modal("show");  


        //   })




    }



    // Update UI with response JSON
    function updateDashboardUI(data) {
        // Update range labels
        const rangeText = startDate + ' to ' + endDate;
        $('#receivedRangeLabel').text(rangeText);
        $('#billsCreatedRangeLabel').text(rangeText);
        $('#billsPaidRangeLabel').text(rangeText);
        $('#signedOutRangeLabel').text(rangeText);

        // Update metric cards
        $('#receivedCount').text(data.received || 0);
        $('#billsCreatedCount').text(data.bills_created || 0);
        $('#billsPaidCount').text(data.createdandpaid || 0);
        $('#signedOutCount').text(data.signedout || 0);

        // Pending acknowledgment = bills_created - bills_acknowledged
        // const pendingAck = (data.bills_created || 0) - (data.bills_acknowledged || 0);
       $('#pendingAckCount').text(data.pending_acknowledge || 0);

        // Completion rate = signedout / received * 100
        const received = data.received || 0;
        const signedout = data.signedout || 0;
        const completionRate = received > 0 ? ((signedout / received) * 100).toFixed(1) : 0;
        $('#completionRate').text(completionRate + '%');

        // Update Top Officers tables
        updateOfficerTable('topOfficersReceivedTable', data.top_officers_received);
        updateOfficerTable('topOfficersBillsTable', data.top_officers_bills);

        // Update chart with daily trends
        updateChart(data.daily_trends);
    }

    function updateOfficerTable(tableId, officers) {
        const tbody = $('#' + tableId + ' tbody');
        tbody.empty();
        if (!officers || officers.length === 0) {
            tbody.html('<tr><td colspan="2" class="text-muted text-center">No data</td></tr>');
            return;
        }
        officers.forEach(o => {
            const row = `<tr class="officer-row"><td>${o.name}</td><td class="text-end">${o.count}</td></tr>`;
            tbody.append(row);
        });
    }

    function updateChart(dailyTrends) {
        if (!trendsChart) return;
        const labels = dailyTrends.map(d => d.date);
        const receivedData = dailyTrends.map(d => d.received);
        const signedoutData = dailyTrends.map(d => d.signedout);

        trendsChart.data.labels = labels;
        trendsChart.data.datasets[0].data = receivedData;
        trendsChart.data.datasets[1].data = signedoutData;
        trendsChart.update();
    }

    // Set default dates on page load (current month)
    $(document).ready(function() {
        const today = new Date();
        const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
        const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);

        // Format as YYYY-MM-DD for internal values
        const formatYMD = (date) => {
            const y = date.getFullYear();
            const m = String(date.getMonth() + 1).padStart(2, '0');
            const d = String(date.getDate()).padStart(2, '0');
            return `${y}-${m}-${d}`;
        };

        const startYMD = formatYMD(firstDay);
        const endYMD = formatYMD(lastDay);

        // Set flatpickr inputs (the altInput shows formatted date automatically)
        dateFromPicker.setDate(startYMD, true); // true = trigger onChange
        dateToPicker.setDate(endYMD, true);

        // Initialize Chart.js
        const ctx = document.getElementById('dailyTrendsChart').getContext('2d');
        trendsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [],
                datasets: [
                    { label: 'Received', data: [], borderColor: '#667eea', tension: 0.3 },
                    { label: 'Signed Out', data: [], borderColor: '#ffc107', tension: 0.3 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true } }
            }
        });

        // The onChange events will trigger refreshDashboard automatically

  

    
   $('#card_apps_received').on('click', function(e) {
    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_count_received_today_by_csau_front_officers',
            regional_code: regionId,
            start_date: startDate,
            end_date: endDate
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);

            if (result.success && Array.isArray(result.data)) {
                console.log("Officer data:", result.data);

                // Show the modal
                var modalEl = document.getElementById('officerModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#officerModalLabel').text(`Applications Received Between ${StrD} and ${EndD}`);
                // $('#officerModalLabel').text('Applications Received Between' + $(StrD));

                // Map the data to DataTable format
                var tableData = result.data.map(officer => [
                    officer.fullname,
                    officer.count,
                    `<button class="btn btn-sm btn-outline-primary view-officer-details" id="ViewOfficersBtn" data-userid="${officer.userid}" data-fullname="${officer.fullname}">View</button>`
                ]);

                console.log(tableData);

                // Define table columns
                var columns = [
                    { title: "Officer" },
                    { title: "Count" },
                    { title: "Action", orderable: false, className: "text-end" }
                ];

                // Initialize the DataTable
                initializeApplicationsDataTable('#officerModal table', columns, tableData, `Applications Received Between ${StrD} and ${EndD}`);

            } else {
                Swal.fire({
                    icon: "warning",
                    title: "Sorry!",
                    text: "No records found!",
                    confirmButtonColor: "#0d6efd",
                    confirmButtonText: "OK",
                });

                // Clear table if modal was open before
                $('#officerModal table').DataTable().clear().draw();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer data:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "An error occurred while loading data. Please try again later.",
                confirmButtonColor: "#0d6efd",
            });
        }
    });
});








// Event delegation for dynamically created "View" buttons
$('#officerModal table').on('click', '.view-officer-details', function() {
    var user_created_id = $(this).data('userid');
    var fullname = $(this).data('fullname');
    console.log("Clicked Officer:", user_created_id, fullname);

    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_applications_received_today_by_csau_front_officers',
            created_by_id: user_created_id,
            start_date: startDate,
            end_date: EndD
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);
            console.log("Applications response:", result);

            if (result.success && Array.isArray(result.data) && result.data.length > 0) {
                // Show the applications modal
                var modalEl = document.getElementById('csau_applicationsModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#csau_applicationsModalLabel').text(`Applications Received by ${fullname} Between ${StrD} and ${EndD}`);

                      function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    

                // Map response data to table rows
                var tableData = result.data.map(app => [
                    app.job_number,
                    app.ar_name,
                    app.business_process_name,
                    app.created_date,
                    `<td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(app.job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Cabinet
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
						
					

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="viewApplicationDetails('${app.job_number}','${app.transaction_number}','${app.case_number}','${app.business_process_sub_name}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
							

						</ul>
					</div>
				</td>
                    `
                ]);

                // Define columns
                var columns = [
                    { title: 'Job Number' },
                    { title: 'Applicant Name' },
                    { title: 'Application Type' },
                    { title: 'Submission Date' },
                    { title: 'Action', orderable: false, className: 'text-end' }
                ];

                // Initialize DataTable in modal
                initializeApplicationsDataTable('#csau_applicationsTable', columns, tableData, `Applications Received by ${fullname}`);
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "No Records!",
                    text: "This officer has not received any applications in the selected range.",
                    confirmButtonColor: "#0d6efd"
                });

                // Clear table if it exists
                if ($.fn.DataTable.isDataTable('#csau_applicationsTable')) {
                    $('#csau_applicationsTable').DataTable().clear().draw();
                }
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer applications:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Failed to load applications. Try again later.",
                confirmButtonColor: "#0d6efd"
            });
        }
    });
});







   $('#card_bills_created').on('click', function(e) {
    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_6months_bills_created_by_csau_front_officers',
            regional_code: regionId,
            start_date: startDate,
            end_date: endDate
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);

            if (result.success && Array.isArray(result.data)) {
                console.log("Officer data:", result.data);

                // Show the modal
                var modalEl = document.getElementById('officerModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#officerModalLabel').text(`Bills Created Between ${StrD} and ${EndD}`);
                // $('#officerModalLabel').text('Applications Received Between' + $(StrD));

                // Map the data to DataTable format
                var tableData = result.data.map(officer => [
                    officer.fullname,
                    officer.count,
                    `<button class="btn btn-sm btn-outline-primary view-bill-details" id="ViewOfficersBtn" data-userid="${officer.userid}" data-fullname="${officer.fullname}">View</button>`
                ]);

                // Define table columns
                var columns = [
                    { title: "Officer" },
                    { title: "Count" },
                    { title: "Action", orderable: false, className: "text-end" }
                ];

                // Initialize the DataTable
                initializeApplicationsDataTable('#officerModal table', columns, tableData, `Bills Created Between ${StrD} and ${EndD}`);

            } else {
                Swal.fire({
                    icon: "warning",
                    title: "Sorry!",
                    text: "No records found!",
                    confirmButtonColor: "#0d6efd",
                    confirmButtonText: "OK",
                });

                // Clear table if modal was open before
                $('#officerModal table').DataTable().clear().draw();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer data:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "An error occurred while loading data. Please try again later.",
                confirmButtonColor: "#0d6efd",
            });
        }
    });
});






$('#officerModal table').on('click', '.view-bill-details', function() {
    var user_created_id = $(this).data('userid');
    var fullname = $(this).data('fullname');
    console.log("Clicked Officer:", user_created_id, fullname);

    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'get_bills_created_by_csau_front_officers_last6months',
            created_by_id: user_created_id,
            start_date: startDate,
            end_date: EndD
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);
            console.log("Bills response:", result);

            if (result.success && Array.isArray(result.data) && result.data.length > 0) {
                // Show the applications modal
                var modalEl = document.getElementById('csau_billsModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#csau_billsModalLabel').text(`Bills Created by ${fullname} Between ${StrD} and ${EndD}`);

                      function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    

                // Map response data to table rows
               var tableData = result.data.map(app => [
                    app.lessees_name,
                    app.business_process_name,
                    app.created_date,
                    app.ref_number,
                    app.bill_amount,
                    app.payment_confiration_status == 1
                        ? '<span class="badge bg-success">Paid</span>'
                        : '<span class="badge bg-danger">Unpaid</span>'
                ]);

                // Define columns
                var columns = [
                    { title: 'Applicant Name'},
                    { title: 'Application Type'},
                    { title: 'Created Date' },
                    { title: 'Bill Number' },
                    { title: 'Bill Amount' },
                    { title: 'Payment Status' }
                ];

                // Initialize DataTable in modal
                initializeApplicationsDataTable('#csau_billsModalTable', columns, tableData, `Bills Created  by ${fullname} Between ${StrD} and ${EndD}`);
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "No Records!",
                    text: "This officer has not Generated any Bill in the selected range.",
                    confirmButtonColor: "#0d6efd"
                });

                // Clear table if it exists
                if ($.fn.DataTable.isDataTable('#csau_billsModalTable')) {
                    $('#csau_billsModalTable').DataTable().clear().draw();
                }
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer bills:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Failed to load bills. Try again later.",
                confirmButtonColor: "#0d6efd"
            });
        }
    });
});





   $('#card_bills_paid').on('click', function(e) {
    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_bills_created_by_csau_front_officers_and_paid',
            regional_code: regionId,
            start_date: startDate,
            end_date: endDate
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);

            if (result.success && Array.isArray(result.data)) {
                console.log("Officer data:", result.data);

                // Show the modal
                var modalEl = document.getElementById('officerModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#officerModalLabel').text(`Bills Created Between ${StrD} and ${EndD}`);
                // $('#officerModalLabel').text('Applications Received Between' + $(StrD));

                // Map the data to DataTable format
                var tableData = result.data.map(officer => [
                    officer.fullname,
                    officer.count,
                    `<button class="btn btn-sm btn-outline-primary view-bills-paid" id="ViewOfficersBtn" data-userid="${officer.userid}" data-fullname="${officer.fullname}">View</button>`
                ]);

                // Define table columns
                var columns = [
                    { title: "Officer" },
                    { title: "Count" },
                    { title: "Action", orderable: false, className: "text-end" }
                ];

                // Initialize the DataTable
                initializeApplicationsDataTable('#officerModal table', columns, tableData, `Bills Created Between ${StrD} and ${EndD}`);

            } else {
                Swal.fire({
                    icon: "warning",
                    title: "Sorry!",
                    text: "No records found!",
                    confirmButtonColor: "#0d6efd",
                    confirmButtonText: "OK",
                });

                // Clear table if modal was open before
                $('#officerModal table').DataTable().clear().draw();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer data:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "An error occurred while loading data. Please try again later.",
                confirmButtonColor: "#0d6efd",
            });
        }
    });
});







$('#officerModal table').on('click', '.view-bills-paid', function() {
    var user_created_id = $(this).data('userid');
    var fullname = $(this).data('fullname');
    console.log("Clicked Officer:", user_created_id, fullname);

    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'get_bills_created_by_csau_front_officers_last6months_and_paid',
            created_by_id: user_created_id,
            start_date: startDate,
            end_date: EndD
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);
            console.log("Bills response:", result);

            if (result.success && Array.isArray(result.data) && result.data.length > 0) {
                // Show the applications modal
                var modalEl = document.getElementById('csau_billsModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#csau_billsModalLabel').text(`Bills Created by ${fullname} Between ${StrD} and ${EndD}`);

                      function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    

                // Map response data to table rows
               var tableData = result.data.map(app => [
                    app.lessees_name,
                    app.business_process_name,
                    app.created_date,
                    app.ref_number,
                    app.bill_amount,
                    app.payment_confiration_status == 1
                        ? '<span class="badge bg-success">Paid</span>'
                        : '<span class="badge bg-danger">Unpaid</span>'
                ]);

                // Define columns
                var columns = [
                    { title: 'Applicant Name'},
                    { title: 'Application Type'},
                    { title: 'Created Date' },
                    { title: 'Bill Number' },
                    { title: 'Bill Amount' },
                    { title: 'Payment Status' }
                ];

                // Initialize DataTable in modal
                initializeApplicationsDataTable('#csau_billsModalTable', columns, tableData, `Bills Created  by ${fullname} Between ${StrD} and ${EndD}`);
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "No Records!",
                    text: "This officer has not Generated any Bill in the selected range.",
                    confirmButtonColor: "#0d6efd"
                });

                // Clear table if it exists
                if ($.fn.DataTable.isDataTable('#csau_billsModalTable')) {
                    $('#csau_billsModalTable').DataTable().clear().draw();
                }
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer bills:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Failed to load bills. Try again later.",
                confirmButtonColor: "#0d6efd"
            });
        }
    });
});





   $('#card_apps_signedout').on('click', function(e) {
    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_count_signedout_today_by_csau_front_officers',
            regional_code: regionId,
            start_date: startDate,
            end_date: endDate
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);

            if (result.success && Array.isArray(result.data)) {
                console.log("Officer data:", result.data);

                // Show the modal
                var modalEl = document.getElementById('officerModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#officerModalLabel').text(`Bills Created Between ${StrD} and ${EndD}`);
                // $('#officerModalLabel').text('Applications Received Between' + $(StrD));

                // Map the data to DataTable format
                var tableData = result.data.map(officer => [
                    officer.fullname,
                    officer.count,
                    `<button class="btn btn-sm btn-outline-primary view-appscollected" id="ViewOfficersBtn" data-userid="${officer.userid}" data-fullname="${officer.fullname}">View</button>`
                ]);

                // Define table columns
                var columns = [
                    { title: "Officer" },
                    { title: "Count" },
                    { title: "Action", orderable: false, className: "text-end" }
                ];

                // Initialize the DataTable
                initializeApplicationsDataTable('#officerModal table', columns, tableData, `Bills Created Between ${StrD} and ${EndD}`);

            } else {
                Swal.fire({
                    icon: "warning",
                    title: "Sorry!",
                    text: "No records found!",
                    confirmButtonColor: "#0d6efd",
                    confirmButtonText: "OK",
                });

                // Clear table if modal was open before
                $('#officerModal table').DataTable().clear().draw();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer data:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "An error occurred while loading data. Please try again later.",
                confirmButtonColor: "#0d6efd",
            });
        }
    });
});






$('#officerModal table').on('click', '.view-appscollected', function() {
    var user_created_id = $(this).data('userid');
    var fullname = $(this).data('fullname');
    console.log("Clicked Officer:", user_created_id, fullname);

    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_applications_signedout_today_by_csau_front_officers',
            created_by: user_created_id,
            start_date: startDate,
            end_date: EndD
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);
            console.log("Applications response:", result);

            if (result.success && Array.isArray(result.data) && result.data.length > 0) {
                // Show the applications modal
                var modalEl = document.getElementById('csau_applicationsModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#csau_applicationsModalLabel').text(`Applications Signed Out by ${fullname} Between ${StrD} and ${EndD}`);

                      function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    

                // Map response data to table rows
                var tableData = result.data.map(app => [
                    app.job_number,
                    app.ar_name,
                    app.business_process_name,
                    app.collected_date,
                    `<td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(app.job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Cabinet
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
						
					

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="viewApplicationDetails('${app.job_number}','${app.transaction_number}','${app.case_number}','${app.business_process_sub_name}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
							

						</ul>
					</div>
				</td>
                    `
                ]);

                // Define columns
                var columns = [
                    { title: 'Job Number' },
                    { title: 'Applicant Name' },
                    { title: 'Application Type' },
                    { title: 'Signed Out Date' },
                    { title: 'Action', orderable: false, className: 'text-end' }
                ];

                // Initialize DataTable in modal
                initializeApplicationsDataTable('#csau_applicationsTable', columns, tableData, `Applications Signed Out by ${fullname}`);
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "No Records!",
                    text: "This officer has not received any applications in the selected range.",
                    confirmButtonColor: "#0d6efd"
                });

                // Clear table if it exists
                if ($.fn.DataTable.isDataTable('#csau_applicationsTable')) {
                    $('#csau_applicationsTable').DataTable().clear().draw();
                }
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer applications:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Failed to load applications. Try again later.",
                confirmButtonColor: "#0d6efd"
            });
        }
    });
});





$('#card_pending_ack').on('click', function(e) {
    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'select_bills_today_by_csau_front_officers_and_acknowledged',
            regional_code: regionId,
            start_date: startDate,
            end_date: endDate
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);

            if (result.success && Array.isArray(result.data)) {
                console.log("Officer data:", result.data);

                // Show the modal
                var modalEl = document.getElementById('officerModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#officerModalLabel').text(`Bills Created Yet to Be Acknwoledged Between ${StrD} and ${EndD}`);
                // $('#officerModalLabel').text('Applications Received Between' + $(StrD));

                // Map the data to DataTable format
                var tableData = result.data.map(officer => [
                    officer.fullname,
                    officer.count,
                    `<button class="btn btn-sm btn-outline-primary view-bills-paid-not-ack" id="ViewOfficersBtn" data-userid="${officer.userid}" data-fullname="${officer.fullname}">View</button>`
                ]);

                // Define table columns
                var columns = [
                    { title: "Officer" },
                    { title: "Count" },
                    { title: "Action", orderable: false, className: "text-end" }
                ];

                // Initialize the DataTable
                initializeApplicationsDataTable('#officerModal table', columns, tableData, `Bills Created Yet to Be Acknwoledged Between ${StrD} and ${EndD}`);

            } else {
                Swal.fire({
                    icon: "warning",
                    title: "Sorry!",
                    text: "No records found!",
                    confirmButtonColor: "#0d6efd",
                    confirmButtonText: "OK",
                });

                // Clear table if modal was open before
                $('#officerModal table').DataTable().clear().draw();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer data:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "An error occurred while loading data. Please try again later.",
                confirmButtonColor: "#0d6efd",
            });
        }
    });
});






$('#officerModal table').on('click', '.view-bills-paid-not-ack', function() {
    var user_created_id = $(this).data('userid');
    var fullname = $(this).data('fullname');
    console.log("Clicked Officer:", user_created_id, fullname);

    $.ajax({
        type: "POST",
        url: "csau_manager_dashboard",
        data: {
            request_type: 'get_bills_created_by_csau_front_officers_today_and_acknowledged',
            created_by_id: user_created_id,
            start_date: startDate,
            end_date: EndD
        },
        cache: false,
        success: function(response) {
            var result = JSON.parse(response);
            console.log("Bills response:", result);

            if (result.success && Array.isArray(result.data) && result.data.length > 0) {
                // Show the applications modal
                var modalEl = document.getElementById('csau_billsModal');
                var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.show();

                // Set modal title
                $('#csau_billsModalLabel').text(`Bills Created Yet to Be Acknwoledged by ${fullname} Between ${StrD} and ${EndD}`);

                      function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    

                // Map response data to table rows
               var tableData = result.data.map(app => [
                    app.lessees_name,
                    app.business_process_name,
                    app.created_date,
                    app.ref_number,
                    app.bill_amount,
                    app.payment_confiration_status == 1
                        ? '<span class="badge bg-success">Paid</span>'
                        : '<span class="badge bg-danger">Unpaid</span>'
                ]);

                // Define columns
                var columns = [
                    { title: 'Applicant Name'},
                    { title: 'Application Type'},
                    { title: 'Created Date' },
                    { title: 'Bill Number' },
                    { title: 'Bill Amount' },
                    { title: 'Payment Status' }
                ];

                // Initialize DataTable in modal
                initializeApplicationsDataTable('#csau_billsModalTable', columns, tableData, `Bills Created Yet to Be Acknwoledged  by ${fullname} Between ${StrD} and ${EndD}`);
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "No Records!",
                    text: "This officer has not Generated any Bill in the selected range.",
                    confirmButtonColor: "#0d6efd"
                });

                // Clear table if it exists
                if ($.fn.DataTable.isDataTable('#csau_billsModalTable')) {
                    $('#csau_billsModalTable').DataTable().clear().draw();
                }
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading officer bills:", error);
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Failed to load bills. Try again later.",
                confirmButtonColor: "#0d6efd"
            });
        }
    });
});



function generateChart(modalBody, title, type, tableData) {
    console.log("=== START generateChart ===");
    console.log("Chart type:", type);
    console.log("Table data length:", tableData.length);
    console.log("Full tableData:", tableData);

    if (!type) {
        Swal.fire({
            title: 'Ops!',
            text: 'Please select one option.',
            icon: 'warning',
            confirmButtonText: 'OK'
        });
        return;
    }

    // Clear existing chart
    let chartContainer = modalBody.find(".chart");
    if (window.currentChart && window.currentChart.dispose) {
        window.currentChart.dispose();
    }

    // Validate data
    if (!tableData || tableData.length === 0) {
        Swal.fire({
            title: 'No Data!',
            text: 'There is no data to display in the chart.',
            icon: 'info',
            confirmButtonText: 'OK'
        });
        return;
    }

    let labels = [];
    let seriesData = [];

    tableData.forEach((item, index) => {
        let name, total;

        // Check if item is an array or object
        if (Array.isArray(item)) {
            // array format: [name, total, action?]
            name = item[0];
            total = item[1];
        } else {
            // object format: {name, total}
            name = item.name;
            total = item.total;
        }

        // Clean up name if it contains HTML
        name = $("<div>").html(name).text().trim();

        // Ensure total is numeric
        if (total === undefined || total === null) total = 0;
        else if (typeof total === "string") total = parseFloat(total.replace(/[^\d.-]/g, '')) || 0;

        if (type === "bar") {
            labels.push(name || `Item ${index + 1}`);
            seriesData.push(total);
        } else {
            seriesData.push({ name: name || `Item ${index + 1}`, value: total });
        }
    });

    // Set chart dimensions
    let height = (type === "pie" || type === "doughnut") ? 400 : 500;
    chartContainer.css({ width: "100%", height: height + "px", border: "1px solid #ddd" });

    // Initialize ECharts
    let chart = echarts.init(chartContainer[0]);
    window.currentChart = chart;

    let options = {
        title: {
            text: title || 'Chart',
            left: 'center',
            textStyle: { fontSize: 16, fontWeight: 'bold' }
        },
        tooltip: { trigger: type === 'bar' ? 'axis' : 'item', formatter: type === 'bar' ? '{b}: {c}' : '{a}<br/>{b}: {c} ({d}%)' },
        toolbox: { show: true, feature: { saveAsImage: { title: "Save as Image", show: true } }, right: 20, top: 20 },
        backgroundColor: '#f8f9fa'
    };

    if (type === "pie" || type === "doughnut") {
        options.series = [{
            name: title || 'Data',
            type: 'pie',
            radius: type === 'pie' ? '65%' : ['40%', '70%'],
            center: ['50%', '50%'],
            data: seriesData,
            itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)' } },
            label: { formatter: '{b}: {c} ({d}%)' }
        }];
    } else {
        options.xAxis = { type: 'category', data: labels, axisLabel: { rotate: 45 } };
        options.yAxis = { type: 'value', name: 'Count' };
        options.series = [{ name: title || 'Data', type: 'bar', data: seriesData, itemStyle: { color: '#1890ff' }, label: { show: true, position: 'top' } }];
    }

    try {
        chart.setOption(options);
        console.log("Chart rendered successfully");
    } catch (error) {
        console.error("Error rendering chart:", error);
        Swal.fire({
            title: 'Chart Error!',
            text: 'Failed to render chart: ' + error.message,
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
}





  $(".generate-chart").on("submit", function (event) {
    event.preventDefault();

    let chartType = $(this).serializeArray()[0].value;

    let modalBody = $(this).parents(".modal-content").find(".modal-body");

    let tableData = modalBody.find("table").DataTable().rows().data().toArray();

    console.log(tableData);

    let title = $(this).parents(".modal-content").find(".modal-title").text();

    generateChart(modalBody, title, chartType, tableData);
  });



  function initializeApplicationsDataTable(tableId, columns, data, title_) {

    // Destroy existing DataTable if it exists
    if ($.fn.DataTable.isDataTable(tableId)) {
        $(tableId).DataTable().destroy();
    }

    return $(tableId).DataTable({
        responsive: true,
        data: data,
        columns: columns,
        order: [[1, "desc"]],

        // ✅ CENTRALIZED BUTTONS
        buttons: getServiceTypeButtons(title_),

        dom: '<"row"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
             '<"row"<"col-sm-12"tr>>' +
             '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',

        pageLength: 10,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            paginate: {
                first: "First",
                last: "Last",
                next: "Next",
                previous: "Previous"
            }
        }
    });
}



  function getServiceTypeButtons(title_) {
  return [
    {
      extend: 'copy',
      title: title_,
      documentTitle: title_,
      exportOptions: {
               columns: ':visible',
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'csv',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
            columns: ':visible',
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'excel',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
         columns: ':visible',
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'pdf',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: ':visible',
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'print',
      text: 'Print',
      title: '',
      documentTitle: '',
      exportOptions: {
            columns: ':visible',
        format: {
          body: data => $('<div>').html(data).text()
        }
      },
      customize: function (win) {
        $(win.document.body).prepend(`
          <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">
            ${title_}
          </h3>
          <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
            This report is generated using the Enterprise Land Information System
          </p>
        `);
      }
    },
    'pageLength'
  ];
}





window.viewApplicationDetails = function(job_number, transaction_number, case_number, business_process_sub_name) {
     
      // Create a form dynamically
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'front_office_view_application';
      form.target = '_blank'
      form.style.display = 'none'; // Hide the form
      
      // Add the case number as an input field
      const caseNumberInput = document.createElement('input');
      caseNumberInput.type = 'hidden';
      caseNumberInput.name = 'search_text';
      caseNumberInput.value = case_number;
      form.appendChild(caseNumberInput);

      // Add the case number as an input field
      const jobNumberInput = document.createElement('input');
      jobNumberInput.type = 'hidden';
      jobNumberInput.name = 'search_text';
      jobNumberInput.value = job_number;
      form.appendChild(jobNumberInput);

      // Add the case number as an input field
      const transactionNumberInput = document.createElement('input');
      transactionNumberInput.type = 'hidden';
      transactionNumberInput.name = 'search_text';
      transactionNumberInput.value = transaction_number;
      form.appendChild(transactionNumberInput);

      // Add the case number as an input field
      const businessProcessSubNameInput = document.createElement('input');
      businessProcessSubNameInput.type = 'hidden';
      businessProcessSubNameInput.name = 'search_text';
      businessProcessSubNameInput.value = business_process_sub_name;
      form.appendChild(businessProcessSubNameInput);
      
      // Add the form to the body and submit it
      document.body.appendChild(form);
      form.submit();
};







$('#cabinetModal')
  .off('show.bs.modal')
  .on('show.bs.modal', handleCabinetModalShow);



        function clearTableRows($table) {
        $table.find("tbody tr").remove();
    }

       function handleAjaxError(xhr, status, error) {
        console.error('AJAX Error:', error);
        showNotification(
            `Error loading data. Please try again.`,
            'error'
        );
    }

          function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function updateRefreshTime() {
		const now = new Date();
		const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
		$('#lastRefreshTime').text(timeString);
	}

    function handleCabinetModalShow(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        
        if (!jobNumber) {
            console.error('No job number provided for cabinet modal');
            return;
        }

        resetCabinetModal();
        loadCabinetDetails(jobNumber);
    }

    function resetCabinetModal() {
        const fields = [
            '#enq_applicant_name',
            '#enq_applicant_type',
            '#enq_cabinet_name',
            '#enq_job_purpose',
            '#enq_job_status',
            '#enq_current_application_status'
        ];
        
        fields.forEach(selector => $(selector).val(''));
        clearTableRows($('#cabinet-tracking'));
    }

    function loadCabinetDetails(jobNumber) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_cabinet_details_by_job_number',
                job_number: jobNumber
            },
            cache: false,
            success: function(response) {
                populateCabinetData(response);
				updateRefreshTime();
            },
            error: handleAjaxError
        });
    }

    function populateCabinetData(response) {
        try {
            const data = JSON.parse(response);
            // console.log(data);
            // Populate cabinet tracking table
            if (data.cabinet_tracking && Array.isArray(data.cabinet_tracking)) {
                const table = $('#cabinet-tracking');
				table.empty();
                data.cabinet_tracking.forEach(tracking => {
                    table.append(createCabinetTrackingRow(tracking));
                });

				// Update last update date
				if (data.cabinet_tracking && data.cabinet_tracking.length > 0) {
					const lastUpdate = data.cabinet_tracking[data.cabinet_tracking.length - 1].created_date;
					$('#lastUpdateDate').text(lastUpdate);
				}

				const trackingCount = Array.isArray(data.cabinet_tracking) ? data.cabinet_tracking.length : 0;
				$('#trackingEntriesCount').text(trackingCount);
				$('#historyCount').text(trackingCount + ' entries');
            }

            // Populate cabinet data fields
            if (data.cabinet_data) {
                const cabinet = data.cabinet_data;
                $('#enq_applicant_name').val(cabinet.ar_name || '');
                $('#enq_applicant_type').val(cabinet.business_process_sub_name || '');
                $('#enq_cabinet_name').val(cabinet.file_number || '');
                $('#enq_job_purpose').val(cabinet.job_purpose || '');
                $('#enq_job_status').val(cabinet.job_status || '');
                $('#enq_current_application_status').val(cabinet.current_application_status || '');
            }
        } catch (error) {
            // console.error('Error parsing cabinet data:', error);
        }
    }

    function createCabinetTrackingRow(tracking) {
        return `
            <tr>
                <td class="small">${escapeHtml(tracking.officers_general_comments || '')}</td>
                <td class="small">${escapeHtml(tracking.division || '')}</td>
                <td class="small">${escapeHtml(tracking.created_by || '')}</td>
                <td class="small">${formatDate(tracking.created_date)}</td>
            </tr>
        `;
    }






    });


// $.notify({
// 																message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No records found!</span>',
// 															}, { type : 'danger' , z_index: 9999  });
// 															return;



