<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<jsp:include page="../includes/_header.jsp"></jsp:include>

<div class="container-fluid">
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Rent Management Upload - ${fullname}</h1>
    </div>
    <hr>

    <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <!-- Card Header - Accordion -->
                <a href="#collapseBulkRent" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-file-upload"></i> Bulk Rent Data Upload
                    </h6>
                </a>

                <!-- Card Content - Collapse -->
                <div class="collapse show" id="collapseBulkRent">
                    <div class="card-body">

                        <!-- Region & Estate Selection -->
                        <div class="form-group">
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label for="rnt_upload_office_region"><strong>Office Region</strong></label>
                                    <select class="form-control selectpicker" id="rnt_upload_office_region" data-live-search="true" required>
                                        <option value="" disabled selected>Select Office Region</option>
                                        <c:forEach items="${officeregionlist}" var="region">
                                            <option value="${region.ord_region_code}">${region.ord_region_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="rnt_upload_estate"><strong>Estate</strong></label>
                                    <select class="form-control selectpicker" id="rnt_upload_estate" data-live-search="true" required>
                                        <option value="" disabled selected>Select Estate</option>
                                        <c:forEach items="${estate_list}" var="estate">
                                            <option value="${estate.ge_id}">${estate.ge_location_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="form-row mb-4">
                            <div class="col-md-6">
                                <button type="button" class="btn btn-info btn-lg btn-block" id="btn_upload_rent_by_csv" data-toggle="modal" data-target="#fileRentUploadModal">
                                    <i class="fas fa-file-upload"></i> Upload CSV
                                </button>
                            </div>
                            <div class="col-md-6">
                                <button type="button" class="btn btn-success btn-lg btn-block" id="btn_process_rent_data_by_csv">
                                    <i class="fas fa-cogs"></i> Process Rent Data
                                </button>
                            </div>
                        </div>

                        <!-- Success / Error Alert -->
                        <div id="uploadAlert" class="alert d-none" role="alert"></div>

                        <!-- Data Table -->
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-sm" id="bulk_rent_data_list_dataTable_smd" width="100%" cellspacing="0">
                                <thead class="thead-light">
                                    <tr>
                                        <th>Owner's Name</th>
                                        <th>Address</th>
                                        <th>File No.</th>
                                        <th>Ledger</th>
                                        <th>Folio</th>
                                        <th>Plot No.</th>
                                        <th>Plot Size</th>
                                        <th>Covenanted User</th>
                                        <!-- <th>Current Use</th> -->
                                        <th>LS Number</th>
                                        <th>Nature of Instrument</th>
                                        <th>Comm. Date</th>
                                        <th>Term</th>
                                        <th>Consent Date</th>
                                        <th>Rent Review</th>
                                        <th>Rent Passing</th>
                                        <th>Arrears</th>
                                        <th>Prev. Review</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CSV Upload Modal -->
<div class="modal fade" id="fileRentUploadModal" tabindex="-1" role="dialog" aria-labelledby="fileRentUploadModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="fileRentUploadModalLabel"><i class="fas fa-file-csv"></i> Upload Rent CSV</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="csvUploadForm" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="csvFile"><strong>Select CSV File</strong></label>
                        <input type="file" class="form-control-file" id="csvFile" name="csvFile" accept=".csv" required>
                        <small class="form-text text-muted">
                            Only <code>.csv</code> files are allowed. Max size: 10MB.
                        </small>
                    </div>
                    <!-- <div class="form-group">
                        <label for="uploadRegion"><strong>Region</strong></label>
                        <input type="text" class="form-control" id="uploadRegion" readonly>
                    </div>
                    <div class="form-group">
                        <label for="uploadEstate"><strong>Estate</strong></label>
                        <input type="text" class="form-control" id="uploadEstate" readonly>
                    </div> -->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="btnConfirmUpload">
                    <i class="fas fa-upload"></i> Upload
                </button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../includes/_footer.jsp"></jsp:include>

<!-- JavaScript -->
<script>
$(document).ready(function () {
    const $table = $('#bulk_rent_data_list_dataTable_smd').DataTable({
        responsive: true,
        pageLength: 25,
        order: [[0, 'asc']],
        columnDefs: [{ targets: '_all', className: 'text-center' }]
    });

    // Populate modal with selected region & estate
    $('#btn_upload_rent_by_csv').on('click', function () {
        const regionText = $('#rnt_upload_office_region option:selected').text();
        const estateText = $('#rnt_upload_estate option:selected').text();
        $('#uploadRegion').val(regionText);
        $('#uploadEstate').val(estateText);
    });

    function cleanNumeric(value) {
    if (!value || value === 'null' || value.trim() === '') {
        return '';
    }
    return value.replace(/,/g, ''); // Remove commas
}

    // Handle CSV upload and client-side parsing
    $('#btnConfirmUpload').on('click', function () {
        const fileInput = $('#csvFile')[0];
        const region = $('#rnt_upload_office_region').val();
        const estate = $('#rnt_upload_estate').val();

        if (!fileInput.files[0]) {
            showAlert('Please select a CSV file.', 'warning');
            return;
        }
        // if (!region || !estate) {
        //     showAlert('Please select Office Region and Estate.', 'warning');
        //     return;
        // }

        const file = fileInput.files[0];
        if (file.type !== 'text/csv' && !file.name.endsWith('.csv')) {
            showAlert('Please upload a valid CSV file.', 'danger');
            return;
        }
        

        // Read and parse CSV file
        const reader = new FileReader();
        reader.onload = function (e) {
            const text = e.target.result;
            try {
                // Split text into lines
                const lines = text.split('\n').filter(line => line.trim() !== '');
                if (lines.length < 1) {
                    showAlert('CSV file is empty.', 'danger');
                    return;
                }

                // Get headers from first line
                const headers = lines[0].split(';').map(header => header.trim());
                const expectedHeaders = [
                    "Owner's Name", "Address", "File No.", "Ledger", "Folio", 
                    "Plot No.", "Plot Size", "Covenanted User", "LS Number", 
                    "Nature of Instrument", "Comm. Date", 
                    "Term", "Consent Date", "Rent Review", "Rent Passing", 
                    "Arrears", "Prev. Review"
                ];

                // // Validate headers
                // if (headers.length !== expectedHeaders.length || !headers.every((h, i) => h === expectedHeaders[i])) {
                //     showAlert('CSV headers do not match expected format.', 'danger');
                //     return;
                // }

                // Clear existing table data
                $table.clear();

                // Parse data rows (skip header line)
                for (let i = 1; i < lines.length; i++) {
                    const row = lines[i].split(';').map(cell => cell.trim());
                    if (row.length === headers.length) {
                        $table.row.add([
                            row[0] || '',  // Owner's Name
                            row[1] || '',  // Address
                            row[2] || '',  // File No.
                            row[3] || '',  // Ledger
                            row[4] || '',  // Folio
                            row[5] || '',  // Plot No.
                            row[6] || '0',  // Plot Size
                            row[7] || '',  // Covenanted User
                          //  row[8] || '',  // Current Use
                             row[8] || '', // LS Number
                            row[9] || '',  // Nature of Intrumrnt
                         
                          
                            row[10] || 'null', // Comm. Date
                            row[11] || '0', // Term
                            row[12] || 'null', // Consent Date
                            row[13] || '0', // Rent Review
                            row[14] || '0', // Rent Passing
                            row[15] || '0', // Arrears
                            row[16] || '-'  // Prev. Review
                        ]);
                    }
                }

                // Draw the table
                $table.draw();
                showAlert('CSV data loaded successfully!', 'success');
                $('#fileRentUploadModal').modal('hide');
                $('#csvUploadForm')[0].reset();
            } catch (error) {
                showAlert('Error parsing CSV: ' + error.message, 'danger');
            }
        };
        reader.onerror = function () {
            showAlert('Error reading file.', 'danger');
        };
        reader.readAsText(file);
    });

 // Process Rent Data and Export to JSON
    $('#btn_process_rent_data_by_csv').on('click', function () {
        var region = $('#rnt_upload_office_region').val();
        var estate = $('#rnt_upload_estate').val();

        if (!region || !estate) {
            showAlert('Please select Office Region and Estate.', 'warning');
            return;
        }

         region =  region.replace(".0", "");
          estate =  estate.replace(".0", "");

          // Function to parse and format dates
    function formatDate(value) {
        if (!value || value === 'null' || value.trim() === '') {
            return 'null';
        }
        // Try parsing DD/MM/YYYY or DD-MM-YYYY
        const ddmmyyyyMatch = value.match(/^(\d{1,2})[\/-](\d{1,2})[\/-](\d{4})$/);
        if (ddmmyyyyMatch) {
            const day = parseInt(ddmmyyyyMatch[1], 10);
            const month = parseInt(ddmmyyyyMatch[2], 10) - 1; // JavaScript months are 0-based
            const year = parseInt(ddmmyyyyMatch[3], 10);
            const date = new Date(year, month, day);
            if (!isNaN(date.getTime()) && date.getFullYear() === year && date.getMonth() === month && date.getDate() === day) {
                return date.toISOString().split('T')[0]; // Format as YYYY-MM-DD
            }
        }
        // Try standard JavaScript Date parsing (for YYYY-MM-DD or other formats)
        const date = new Date(value);
        if (!isNaN(date.getTime())) {
            return date.toISOString().split('T')[0];
        }
        // Log warning and return "null" for invalid dates
        console.warn(`Invalid date format: ${value}`);
        return 'null';
    }

        // Export DataTable to JSON
        const jsonData = [];
        const columnKeys = [
            'owners_name', 'address', 'file_number', 'ledger', 'folio', 
            'plot_number', 'plot_size', 'covenanted_user', 'ls_number', 'nature_of_instrument', 'comm_date', 
            'term', 'consent_date', 'rent_review_clause', 'rent_passing', 
            'period_in_arrears', 'previous_rent_review_clause'
        ];

      $table.rows().every(function (rowIdx) {
        const rowData = this.data();
        const rowObject = {
            region: region,
            estate: estate
        };
        columnKeys.forEach((key, index) => {
            let value = rowData[index] || '';
            if (key === 'comm_date' || key === 'consent_date') {
                value = formatDate(value);
            }else if (key === 'rent_passing' || key === 'term' || key === 'period_in_arrears') {
                value = cleanNumeric(value); // Clean numeric fields
            }
            rowObject[key] = value;
        });
        jsonData.push(rowObject);
    });

    if (jsonData.length === 0) {
        showAlert('No data to process.', 'warning');
        return;
    }

        // Log JSON to console (for testing)
        console.log('Exported JSON:', JSON.stringify(jsonData, null, 2));

      var json_array_to_upload = JSON.stringify(jsonData, null, 2);

        // Existing AJAX call for server-side processing
        $.ajax({
            url: 'rent_mgt_serv',
            type: 'POST',
            data: { 
                request_type: 'upload_bulk_rent_ledger', 
                rent_data_upload_list:json_array_to_upload,
                jsonData: JSON.stringify(jsonData) // Optionally send JSON to server
            },
            beforeSend: function () {
                $(this).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Processing...');
            },
            success: function (response) {
            // Parse response if it's a string (in case the server returns JSON as text)
          
          console.log(response)
            let responseObj;
            try {
                responseObj = typeof response === 'string' ? JSON.parse(response) : response;
            } catch (e) {
                showAlert('Invalid server response format.', 'danger');
                return;
            }

            // Handle success or failure based on response
            if (responseObj.success) {
                showAlert(responseObj.msg || 'Rent data processed and exported successfully!', 'success');
               // loadRentData(); // Reload DataTable on success
            } else {
                showAlert(responseObj.msg || 'Failed to process rent data.', 'danger');
            }
        },
            error: function (xhr) {
                showAlert('Processing failed: ' + (xhr.responseText || 'Server error'), 'danger');
            },
            complete: function () {
                $(this).prop('disabled', false).html('<i class="fas fa-cogs"></i> Process Rent Data');
            }
        });
    });


    // Function to parse a CSV line, handling quoted fields with commas
function parseCsvLine(line) {
    const result = [];
    let currentField = '';
    let inQuotes = false;
    let i = 0;

    while (i < line.length) {
        const char = line[i];

        if (char === '"') {
            if (inQuotes && i + 1 < line.length && line[i + 1] === '"') {
                // Handle escaped quotes ("")
                currentField += '"';
                i += 2;
            } else {
                // Toggle quote state
                inQuotes = !inQuotes;
                i++;
            }
        } else if (char === ',' && !inQuotes) {
            // End of field (outside quotes)
            result.push(currentField.trim());
            currentField = '';
            i++;
        } else {
            // Add character to current field
            currentField += char;
            i++;
        }
    }
    // Push the last field
    result.push(currentField.trim());

    // Remove surrounding quotes from quoted fields
    return result.map(field => {
        if (field.startsWith('"') && field.endsWith('"')) {
            return field.slice(1, -1).replace(/""/g, '"'); // Remove quotes and handle escaped quotes
        }
        return field;
    });
}
    // Load data into DataTable (server-side data fetch if needed)
    function loadRentData() {
        const region = $('#rnt_upload_office_region').val();
        const estate = $('#rnt_upload_estate').val();

        if (!region || !estate) return;

        $.get('${pageContext.request.contextPath}/getBulkRentData', { region, estate }, function (data) {
            $table.clear();
            if (data && data.length > 0) {
                data.forEach(row => {
                    $table.row.add([
                        row.owners_name || '',
                        row.address || '',
                        row.file_number || '',
                        row.ledger || '',
                        row.folio || '',
                        row.plot_number || '',
                        row.plot_size || '',
                        row.covenanted_user || '',
                        
                        row.nature_of_devt || '',
                        row.ls_number || '',
                        row.nature_of_instrument || '',
                        row.comm_date || '',
                        row.term || '',
                        row.consent_date || '',
                        row.rent_review_clause || '',
                        row.rent_passing || '',
                        row.period_in_arrears || '',
                        row.previous_rent_review_clause || ''
                    ]);
                });
            }
            $table.draw();
        }).fail(function () {
            showAlert('Failed to load data.', 'danger');
        });
    }

    // Show alert
    function showAlert(message, type) {
        const $alert = $('#uploadAlert');
        $alert.removeClass('d-none alert-success alert-danger alert-warning')
              .addClass('alert-' + type)
              .html('<strong>' + (type === 'danger' ? 'Error!' : type === 'warning' ? 'Warning!' : 'Success!') + '</strong> ' + message)
              .fadeIn()
              .delay(5000).fadeOut();
    }

    // Auto-load on region/estate change
    $('#rnt_upload_office_region, #rnt_upload_estate').on('change', function () {
        loadRentData();
    });
});
</script>

<!-- Required JS (ensure in _footer.jsp or here) -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>