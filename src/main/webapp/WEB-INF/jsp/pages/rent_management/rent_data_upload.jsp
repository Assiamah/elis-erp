<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.rent-upload-page{--ru-green:#087f5b;--ru-deep:#07543f;--ru-border:#d9eee3;color:#183b31}
.rent-upload-page .ru-hero{background:linear-gradient(110deg,#07543f,#0b8a61 65%,#38a77d);border-radius:16px;padding:24px 28px;color:#fff;box-shadow:0 10px 28px rgba(7,84,63,.19)}
.rent-upload-page .ru-hero h1{font-size:24px;font-weight:800;color:#fff;margin:5px 0}
.rent-upload-page .ru-hero p{color:#d8f7e8;margin:0;font-size:13px}
.rent-upload-page .ru-eyebrow{color:#c5f5da;font-size:11px;letter-spacing:1.4px;font-weight:800}
.rent-upload-page .ru-pill{border-radius:100px;padding:8px 13px;border:1px solid #ffffff55;background:#ffffff22;font-size:12px;font-weight:700}
.rent-upload-page .ru-panel{border:1px solid var(--ru-border);border-radius:16px;overflow:hidden;background:white;box-shadow:0 5px 18px rgba(8,84,57,.07)}
.rent-upload-page .ru-panel-header{background:#f6fcf8;border-bottom:1px solid var(--ru-border);padding:17px 21px;display:flex;align-items:center;justify-content:space-between;gap:12px}
.rent-upload-page .ru-title{font-size:15px;font-weight:800;color:var(--ru-deep);margin:0}
.rent-upload-page .ru-subtitle{font-size:12px;color:#6b8878;margin:4px 0 0}
.rent-upload-page .ru-icon{width:38px;height:38px;border-radius:11px;display:inline-flex;align-items:center;justify-content:center;background:#e6f7ed;color:var(--ru-green);font-size:20px}
.rent-upload-page .ru-panel-body{padding:22px}
.rent-upload-page .ru-section-label{font-size:11px;font-weight:800;letter-spacing:1px;text-transform:uppercase;color:#0b805c;margin-bottom:14px}
.rent-upload-page .ru-select-box{background:#f7fcf9;border:1px solid #e0eee5;border-radius:12px;padding:17px}
.rent-upload-page .form-label{font-size:12px;font-weight:750;color:#315b45;margin-bottom:7px}
.rent-upload-page .form-select,.rent-upload-page .form-control{border:1px solid #cfe5d8;border-radius:10px;min-height:43px;font-size:13px}
.rent-upload-page .form-select:focus,.rent-upload-page .form-control:focus{border-color:#16a34a;box-shadow:0 0 0 .2rem rgba(22,163,74,.13)}
.rent-upload-page .ru-action{border-radius:10px;padding:12px 18px;font-size:13px;font-weight:800;border:1px solid transparent;transition:transform .15s,box-shadow .15s}
.rent-upload-page .ru-action:hover{transform:translateY(-1px);box-shadow:0 5px 15px #087f5b22}
.rent-upload-page .ru-upload-btn{background:#e6f7ed;color:#07543f;border-color:#a9ddc1}
.rent-upload-page .ru-upload-btn:hover{background:#d5f2e2;color:#07543f}
.rent-upload-page .ru-process-btn{background:#087f5b;color:white}
.rent-upload-page .ru-process-btn:hover{background:#07543f;color:white}
.rent-upload-page .ru-summary{display:flex;gap:8px;align-items:center;background:#eaf8ef;color:#087f5b;border-radius:100px;padding:7px 13px;font-size:12px;font-weight:800}
.rent-upload-page .ru-table-scroll{overflow-x:auto}
.rent-upload-page #bulk_rent_data_list_dataTable_smd{width:100%!important;border-collapse:separate;border-spacing:0;font-size:12px}
.rent-upload-page #bulk_rent_data_list_dataTable_smd thead th{background:linear-gradient(110deg,#07543f,#0b8a61)!important;color:#fff!important;padding:13px 11px;white-space:nowrap;font-size:11px;font-weight:800;border:0!important}
.rent-upload-page #bulk_rent_data_list_dataTable_smd tbody td{padding:12px 10px;white-space:nowrap;color:#334b3d;border-bottom:1px solid #e7f1e9}
.rent-upload-page #bulk_rent_data_list_dataTable_smd tbody tr:nth-child(even){background:#f6fbf7}
.rent-upload-page #bulk_rent_data_list_dataTable_smd tbody tr:hover{background:#e6f7ec}
.rent-upload-page .dataTables_wrapper .dataTables_filter input,.rent-upload-page .dataTables_wrapper .dataTables_length select{border:1px solid #cfe5d8;border-radius:8px;padding:6px 9px}
.rent-upload-page .dataTables_wrapper .paginate_button.current{background:#087f5b!important;color:white!important;border-color:#087f5b!important}
#fileRentUploadModal .modal-content{border:0;border-radius:17px;overflow:hidden;box-shadow:0 22px 65px rgba(9,65,42,.25)}
#fileRentUploadModal .modal-header{background:linear-gradient(110deg,#07543f,#0b8a61 65%,#38a77d);padding:20px 24px;color:white}
#fileRentUploadModal .modal-title{color:white;font-weight:800}
#fileRentUploadModal .btn-close{filter:invert(1) grayscale(1);opacity:.95}
#fileRentUploadModal .modal-body{padding:26px}
#fileRentUploadModal .modal-footer{background:#f4fbf6;border-top:1px solid #d9eee3;padding:16px 24px}
#fileRentUploadModal .ru-confirm-btn{background:#087f5b;border:1px solid #087f5b;color:white;border-radius:9px;font-weight:800;padding:9px 18px}
#fileRentUploadModal .ru-confirm-btn:hover{background:#07543f}
#fileRentUploadModal .form-control{border-color:#cfe5d8;border-radius:9px}
@media(max-width:767px){.rent-upload-page .ru-hero{padding:19px}.rent-upload-page .ru-panel-body{padding:14px}.rent-upload-page .ru-panel-header{padding:14px}.rent-upload-page .ru-hero h1{font-size:21px}}
</style>

<div class="main-content app-content rent-upload-page">
 <div class="container-fluid page-container">
  <div class="ru-hero mb-4"><div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
   <div><div class="ru-eyebrow"><i class="ri-government-line me-1"></i> ELIS / GROUND RENT MANAGEMENT</div><h1><i class="ri-upload-cloud-2-line me-2"></i>Bulk Rent Data Upload</h1><p>Import, review and process government estate rent records <c:if test="${not empty fullname}">for <c:out value="${fullname}" /></c:if>.</p></div>
   <div class="ru-pill"><i class="ri-file-list-3-line me-1"></i> CSV Import Workspace</div>
  </div></div>

  <div class="ru-panel mb-3">
   <div class="ru-panel-header"><div class="d-flex align-items-center gap-2"><span class="ru-icon"><i class="ri-settings-3-line"></i></span><div><h2 class="ru-title">Upload Configuration</h2><p class="ru-subtitle">Choose the office region and estate before processing</p></div></div>
    <button class="btn btn-sm btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBulkRent" aria-expanded="true" aria-controls="collapseBulkRent"><i class="ri-arrow-down-s-line"></i></button>
   </div>
   <div class="collapse show" id="collapseBulkRent"><div class="ru-panel-body">
    <div class="ru-section-label"><i class="ri-map-pin-line me-1"></i> Target Location</div>
    <div class="ru-select-box mb-3"><div class="row g-3">
     <div class="col-md-6"><label class="form-label" for="rnt_upload_office_region">Office Region</label><select class="form-select" id="rnt_upload_office_region" required><option value="" disabled selected>Select Office Region</option><c:forEach items="${officeregionlist}" var="region"><option value="<c:out value='${region.ord_region_code}' />"><c:out value="${region.ord_region_name}" /></option></c:forEach></select></div>
     <div class="col-md-6"><label class="form-label" for="rnt_upload_estate">Government Estate</label><select class="form-select" id="rnt_upload_estate" required><option value="" disabled selected>Select Estate</option><c:forEach items="${estate_list}" var="estate"><option value="<c:out value='${estate.ge_id}' />"><c:out value="${estate.ge_location_name}" /></option></c:forEach></select></div>
    </div></div>
    <div class="row g-3"><div class="col-md-6"><button type="button" class="btn ru-action ru-upload-btn w-100" id="btn_upload_rent_by_csv" data-bs-toggle="modal" data-bs-target="#fileRentUploadModal"><i class="ri-upload-cloud-2-line me-2"></i>Upload CSV File</button></div>
     <div class="col-md-6"><button type="button" class="btn ru-action ru-process-btn w-100" id="btn_process_rent_data_by_csv"><i class="ri-cpu-line me-2"></i>Process Rent Data</button></div></div>
    <div id="uploadAlert" class="alert d-none mt-3" role="alert"></div>
   </div></div>
  </div>

  <div class="ru-panel mb-4">
   <div class="ru-panel-header"><div class="d-flex align-items-center gap-2"><span class="ru-icon"><i class="ri-table-2"></i></span><div><h2 class="ru-title">Rent Records Preview</h2><p class="ru-subtitle">Verify the uploaded entries before processing</p></div></div><span class="ru-summary"><i class="ri-file-list-3-line"></i><span id="rentUploadRecordCount">0</span> Records</span></div>
   <div class="ru-panel-body"><div class="ru-table-scroll"><table class="table table-hover align-middle mb-0" id="bulk_rent_data_list_dataTable_smd"><thead><tr>
    <th>Owner's Name</th><th>Address</th><th>File No.</th><th>Ledger</th><th>Folio</th><th>Plot No.</th><th>Plot Size</th><th>Covenanted User</th><th>LS Number</th><th>Nature of Instrument</th><th>Comm. Date</th><th>Term</th><th>Consent Date</th><th>Rent Review</th><th>Rent Passing</th><th>Arrears</th><th>Out. Rent</th>
   </tr></thead><tbody></tbody></table></div></div>
  </div>
 </div>
</div>

<div class="modal fade" id="fileRentUploadModal" tabindex="-1" aria-hidden="true"><div class="modal-dialog modal-dialog-centered"><div class="modal-content">
 <div class="modal-header"><h5 class="modal-title"><i class="ri-file-excel-2-line me-2"></i>Upload Rent CSV</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>
 <div class="modal-body"><form id="csvUploadForm" enctype="multipart/form-data"><label for="csvFile" class="form-label fw-semibold">Select CSV File</label><input class="form-control" type="file" id="csvFile" name="csvFile" accept=".csv,text/csv" required><div class="form-text mt-2"><i class="ri-information-line me-1"></i>CSV files only. Maximum file size: 10 MB. The first row should contain column headings.</div></form></div>
 <div class="modal-footer"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button><button type="button" class="ru-confirm-btn" id="btnConfirmUpload"><i class="ri-upload-cloud-2-line me-1"></i>Upload</button></div>
</div></div></div>

<script>
$(function () {
    'use strict';
    const table = $('#bulk_rent_data_list_dataTable_smd').DataTable({
        responsive: false, scrollX: true, pageLength: 25, order: [[0, 'asc']],
        columnDefs: [{ targets: '_all', className: 'text-start' }]
    });
    function updateCount() { $('#rentUploadRecordCount').text(table.rows().count()); }
    function showAlert(message, type) {
        const alert = $('#uploadAlert');
        alert.stop(true, true).removeClass('d-none alert-success alert-danger alert-warning alert-info')
            .addClass('alert-' + type).text(message).show();
    }
    function cleanNumeric(value) {
        const text = String(value == null ? '' : value).trim();
        return !text || text.toLowerCase() === 'null' ? '' : text.replace(/,/g, '');
    }
    function formatDate(value) {
        const text = String(value == null ? '' : value).trim();
        if (!text || text.toLowerCase() === 'null') return 'null';
        const m = text.match(/^(\d{1,2})[\/-](\d{1,2})[\/-](\d{4})$/);
        if (m) {
            const day = +m[1], month = +m[2], year = +m[3];
            const d = new Date(Date.UTC(year, month - 1, day));
            return d.getUTCFullYear() === year && d.getUTCMonth() === month - 1 && d.getUTCDate() === day
                ? d.toISOString().slice(0, 10) : 'null';
        }
        const iso = text.match(/^(\d{4})-(\d{2})-(\d{2})$/);
        if (iso) {
            const year = +iso[1], month = +iso[2], day = +iso[3];
            const d = new Date(Date.UTC(year, month - 1, day));
            return d.getUTCFullYear() === year && d.getUTCMonth() === month - 1 && d.getUTCDate() === day ? text : 'null';
        }
        return 'null';
    }
    // Handles semicolon-delimited CSV and quoted delimiters/newlines.
    function parseCSV(text, delimiter) {
        const records = []; let row = [], field = '', quoted = false;
        text = text.replace(/^\uFEFF/, '');
        for (let i = 0; i < text.length; i++) {
            const ch = text[i];
            if (ch === '"') {
                if (quoted && text[i + 1] === '"') { field += '"'; i++; }
                else quoted = !quoted;
            } else if (ch === delimiter && !quoted) { row.push(field.trim()); field = ''; }
            else if ((ch === '\n' || ch === '\r') && !quoted) {
                if (ch === '\r' && text[i + 1] === '\n') i++;
                row.push(field.trim()); field = '';
                if (row.some(x => x !== '')) records.push(row);
                row = [];
            } else field += ch;
        }
        if (quoted) throw new Error('Unclosed quoted field in CSV.');
        row.push(field.trim());
        if (row.some(x => x !== '')) records.push(row);
        return records;
    }
    $('#btnConfirmUpload').on('click', function () {
        const input = $('#csvFile')[0], file = input.files && input.files[0];
        if (!file) return showAlert('Please select a CSV file.', 'warning');
        if (!/\.csv$/i.test(file.name)) return showAlert('Please upload a valid .csv file.', 'danger');
        if (file.size > 10 * 1024 * 1024) return showAlert('CSV file must not exceed 10 MB.', 'danger');
        const reader = new FileReader();
        reader.onload = function (event) {
            try {
                const text = event.target.result;
                const firstLine = text.split(/\r?\n/, 1)[0] || '';
                const delimiter = (firstLine.match(/;/g) || []).length >= (firstLine.match(/,/g) || []).length ? ';' : ',';
                const records = parseCSV(text, delimiter);
                if (records.length < 2) throw new Error('The CSV has no data rows.');
                const rows = [];
                for (let i = 1; i < records.length; i++) {
                    if (records[i].length !== 17) throw new Error('Row ' + (i + 1) + ' has ' + records[i].length + ' columns; expected 17.');
                    rows.push(records[i]);
                }
                table.clear();
                // DataTables escapes cell text by default only with a renderer: ensure CSV is never interpreted as HTML.
                rows.forEach(row => table.row.add(row.map(value => $('<div>').text(value).html())));
                table.draw(); updateCount();
                showAlert(rows.length + ' rent records loaded. Review the preview before processing.', 'success');
                bootstrap.Modal.getOrCreateInstance(document.getElementById('fileRentUploadModal')).hide();
                $('#csvUploadForm')[0].reset();
            } catch (error) { showAlert('CSV error: ' + error.message, 'danger'); }
        };
        reader.onerror = function () { showAlert('Unable to read CSV file.', 'danger'); };
        reader.readAsText(file);
    });
    $('#btn_process_rent_data_by_csv').on('click', function () {
        const button = $(this);
        let region = String($('#rnt_upload_office_region').val() || '').replace(/\.0$/, '');
        let estate = String($('#rnt_upload_estate').val() || '').replace(/\.0$/, '');
        if (!region || !estate) return showAlert('Please select Office Region and Estate.', 'warning');
        const keys = ['owners_name','address','file_number','ledger','folio','plot_number','plot_size','covenanted_user','ls_number','nature_of_instrument','comm_date','term','consent_date','rent_review_clause','rent_passing','period_in_arrears','rent_outstanding'];
        const jsonData = [];
        table.rows().every(function () {
            const row = this.data(), obj = {region:region,estate:estate};
            keys.forEach((key, index) => {
                // Decode the escaped preview text before sending original values.
                let value = $('<textarea>').html(row[index] || '').text();
                if (key === 'comm_date' || key === 'consent_date') value = formatDate(value);
                else if (['rent_passing','term','period_in_arrears'].includes(key)) value = cleanNumeric(value);
                obj[key] = value;
            });
            jsonData.push(obj);
        });
        if (!jsonData.length) return showAlert('Upload a CSV file before processing.', 'warning');
        const json = JSON.stringify(jsonData);
        button.prop('disabled', true).html('<i class="ri-loader-4-line me-1"></i>Processing...');
        $.ajax({
            url:'rent_mgt_serv', type:'POST', dataType:'json',
            data:{request_type:'upload_bulk_rent_ledger',rent_data_upload_list:json,jsonData:json},
            success:function (response) {
                if (typeof response === 'string') { try { response = JSON.parse(response); } catch (_) {} }
                if (response && response.success) showAlert(response.msg || 'Rent data processed successfully.', 'success');
                else showAlert((response && response.msg) || 'Failed to process rent data.', 'danger');
            },
            error:function (xhr) { showAlert('Processing failed: ' + (xhr.responseJSON && xhr.responseJSON.msg ? xhr.responseJSON.msg : 'Server error (' + xhr.status + ')'), 'danger'); },
            complete:function () { button.prop('disabled', false).html('<i class="ri-cpu-line me-2"></i>Process Rent Data'); }
        });
    });
    updateCount();
});
</script>
