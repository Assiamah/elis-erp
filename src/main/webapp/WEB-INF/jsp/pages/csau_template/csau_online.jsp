<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="main-content app-content">
    <div class="container-fluid page-container">

		<!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Client Application Management</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Client Application</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row">
            <!-- Main Content Area -->
            <div class="col-lg-8">
                <!-- Tab Navigation -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-transparent border-0 px-4 pt-4 pb-0">
                        <ul class="nav nav-tabs tab-style-6 nav-tabs-line" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#search-clients" type="button" role="tab">
                                    <i class="fas fa-search me-1 align-middle"></i>Search Clients
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#payment-acknowledge" type="button" role="tab">
                                    <i class="fas fa-check-circle me-2"></i>Payment Acknowledge
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#process-case" type="button" role="tab">
                                    <i class="fas fa-cogs me-2"></i>Process Case
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#manual-bills" type="button" role="tab">
                                    <i class="fas fa-file-invoice me-2"></i>Manual Bills
                                </button>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="card-body px-4 pt-4">
                        <div class="tab-content">
                            <!-- Tab 1: Search Clients -->
                            <div class="tab-pane fade show active" id="search-clients" role="tabpanel">
                                <div class="card border-0 shadow-none">
                                    <div class="card-header bg-light border-0 py-3">
                                        <h5 class="mb-0 fw-semibold">
                                            <i class="fas fa-search text-primary me-2"></i>
                                            Search for Clients to Create Bills
                                        </h5>
                                    </div>
                                    <div class="card-body">
										<div id="searchClientErrorAlert"></div>
                                        <div class="row g-3">
                                            <div class="col-md-10">
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-user text-muted"></i>
                                                    </span>
                                                    <input type="text" 
                                                           class="form-control border-start-0" 
                                                           id="client_by_email_phone_search" 
                                                           placeholder="Enter email or phone number">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <button class="btn btn-primary w-100" id="btnFindClientDetails">
                                                    <i class="fas fa-search me-1"></i> Search
                                                </button>
                                            </div>
                                        </div>

                                        <div class="mt-4">
                                            <div class="table-responsive">
                                                <table class="table table-hover table-striped" id="clientsearchlist_dataTable">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>Email</th>
                                                            <th>Account Type</th>
                                                            <th>Phone</th>
                                                            <th>Address</th>
                                                            <th class="text-center">Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 2: Payment Acknowledge -->
                            <div class="tab-pane fade" id="payment-acknowledge" role="tabpanel">
                                <div class="card border-0 shadow-none">
                                    <div class="card-header bg-light border-0 py-3">
                                        <h5 class="mb-0 fw-semibold">
                                            <i class="fas fa-check-circle text-primary me-2"></i>
                                            Acknowledge After Payment
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-10">
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light border-end-0">
                                                        <i class="fas fa-hashtag text-muted"></i>
                                                    </span>
                                                    <input type="text" 
                                                           class="form-control border-start-0" 
                                                           id="txt_ref_number_for_payment" 
                                                           placeholder="Enter reference number">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <button class="btn btn-primary w-100" id="btn_load_bill_details_after_payment">
                                                    <i class="fas fa-search me-1"></i> Search
                                                </button>
                                            </div>
                                        </div>

                                        <div class="mt-4">
                                            <div class="table-responsive">
                                                <table class="table table-hover" id="bill_for_payment_list_dataTable">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Ref No.</th>
                                                            <th>Name</th>
                                                            <th>Amount</th>
                                                            <th class="text-center">Status</th>
                                                            <th class="text-end">Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 3: Process Case -->
                            <div class="tab-pane fade" id="process-case" role="tabpanel">
                                <div class="card border-0 shadow-none">
                                    <div class="card-header bg-light border-0 py-3">
                                        <h5 class="mb-0 fw-semibold">
                                            <i class="fas fa-cogs text-warning me-2"></i>
                                            Processing Application on Case
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-10">
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light border-end-0">
                                                        <i class="fas fa-briefcase text-muted"></i>
                                                    </span>
                                                    <input type="text" 
                                                           class="form-control border-start-0" 
                                                           id="txt_job_number_for_adding_case_and_status" 
                                                           placeholder="Enter job number"
															oninput="this.value = this.value.toUpperCase()">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <button class="btn btn-warning w-100" id="btn_job_number_for_adding_case_and_status">
                                                    <i class="fas fa-search me-1"></i> Search
                                                </button>
                                            </div>
                                        </div>

                                        <div class="mt-4">
                                            <div class="table-responsive">
                                                <table class="table table-hover" id="tbl_job_detail_dataTable">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Job Number</th>
                                                            <th>Case Number</th>
                                                            <th>Applicant Name</th>
                                                            <!-- <th class="text-center">New Service</th> -->
                                                            <th class="text-end">Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody></tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 4: Manual Bills -->
                            <div class="tab-pane fade" id="manual-bills" role="tabpanel">
                                <div class="card border-0 shadow-none">
                                    <div class="card-header bg-light border-0 py-3">
                                        <h5 class="mb-0 fw-semibold">
                                            <i class="fas fa-file-invoice text-warning me-2"></i>
                                            Create Manual Bills
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-10">
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light border-end-0">
                                                        <i class="fas fa-user text-muted"></i>
                                                    </span>
                                                    <input type="text" 
                                                           class="form-control border-start-0" 
                                                           id="client_by_email_phone_search_mb" 
                                                           placeholder="Enter email or phone number">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <button class="btn btn-warning w-100" id="btnFindClientDetailsManualBill">
                                                    <i class="fas fa-search me-1"></i> Search
                                                </button>
                                            </div>
                                        </div>

                                        <div class="mt-4">
                                            <div class="table-responsive">
                                                <table class="table table-hover" id="clientsearchlistManualBills_dataTable">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>Email</th>
                                                            <th>Account Type</th>
                                                            <th>Phone</th>
                                                            <th>Address</th>
                                                            <th class="text-center">New Bill</th>
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
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Instructions Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-transparent border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-info-circle text-primary me-2"></i>
                            Instructions & Guidelines
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-dark border mb-3">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <i class="fas fa-lightbulb text-warning fs-5"></i>
                                </div>
                                <div class="w-100">
                                    <div class="fw-semibold mb-2">Quick Start Guide</div>
                                    <div class="text-muted fs-13">
                                        <ul class="mb-0 ps-3">
                                            <li>Use the tabs to navigate between different functions</li>
                                            <li>Search clients by email or phone number</li>
                                            <li>Process cases using job numbers</li>
                                            <li>Acknowledge payments using reference numbers</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-info border mb-3">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <i class="fas fa-exclamation-circle text-info fs-5"></i>
                                </div>
                                <div class="w-100">
                                    <div class="fw-semibold mb-2">Important Notes</div>
                                    <div class="text-muted fs-13">
                                        <ul class="mb-0 ps-3">
                                            <li>Always verify client information before creating bills</li>
                                            <li>Ensure payments are properly acknowledged</li>
                                            <li>Update case status promptly after processing</li>
                                            <li>Keep manual bills properly documented</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-success border">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <i class="fas fa-rocket text-success fs-5"></i>
                                </div>
                                <div class="w-100">
                                    <div class="fw-semibold mb-2">Best Practices</div>
                                    <div class="text-muted fs-13">
                                        <ul class="mb-0 ps-3">
                                            <li>Double-check reference numbers before processing</li>
                                            <li>Maintain consistent communication with clients</li>
                                            <li>Follow up on pending cases regularly</li>
                                            <li>Use system reports for performance tracking</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reports Card -->
                <!-- <div class="card shadow-sm border-0">
                    <div class="card-header bg-transparent border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-chart-bar text-success me-2"></i>
                            Reports & Analytics
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-borderless">
                            <a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
                                <div class="bg-primary bg-opacity-10 rounded p-2 me-3">
                                    <i class="fas fa-file-invoice text-primary"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-medium">Daily Application Report</div>
                                    <small class="text-muted">Summary of today's applications</small>
                                </div>
                                <i class="fas fa-chevron-right text-muted"></i>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
                                <div class="bg-success bg-opacity-10 rounded p-2 me-3">
                                    <i class="fas fa-money-bill-wave text-success"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-medium">Payment Status Report</div>
                                    <small class="text-muted">Pending and completed payments</small>
                                </div>
                                <i class="fas fa-chevron-right text-muted"></i>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
                                <div class="bg-warning bg-opacity-10 rounded p-2 me-3">
                                    <i class="fas fa-tasks text-warning"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-medium">Case Processing Report</div>
                                    <small class="text-muted">Case status and processing times</small>
                                </div>
                                <i class="fas fa-chevron-right text-muted"></i>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
                                <div class="bg-info bg-opacity-10 rounded p-2 me-3">
                                    <i class="fas fa-chart-line text-info"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-medium">Performance Analytics</div>
                                    <small class="text-muted">Efficiency and completion metrics</small>
                                </div>
                                <i class="fas fa-chevron-right text-muted"></i>
                            </a>
                        </div>
                    </div>
                </div> -->
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const fileInput = document.getElementById('fileUploadFormatCSAU');
    const btnSelectFile = document.getElementById('btnSelectFile');
    const btnRemoveFile = document.getElementById('btnRemoveFile');
    const btnUploadFile = document.getElementById('btnUploadFile');
    const fileInfo = document.getElementById('fileInfo');
    const fileName = document.getElementById('fileName');
    const fileSize = document.getElementById('fileSize');
    const fileSizeProgress = document.getElementById('fileSizeProgress');
    const sizeError = document.getElementById('sizeError');
    // const uploadButtonContainer = document.getElementById('uploadButtonContainer');
    const fileValidationError = document.getElementById('fileValidationError');
    const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB in bytes
    
    // Open file dialog when button is clicked
    btnSelectFile.addEventListener('click', function() {
        fileInput.click();
    });
    
    // Handle file selection
    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        
        if (file) {
            validateAndDisplayFile(file);
        }
    });
    
    // Handle file removal
    btnRemoveFile.addEventListener('click', function() {
        resetFileInput();
    });
    
    // Handle drag and drop
    const fileUploadArea = document.querySelector('.file-upload-area');
    
    fileUploadArea.addEventListener('dragover', function(e) {
        e.preventDefault();
        e.stopPropagation();
        fileUploadArea.classList.add('dragover');
    });
    
    fileUploadArea.addEventListener('dragleave', function(e) {
        e.preventDefault();
        e.stopPropagation();
        fileUploadArea.classList.remove('dragover');
    });
    
    fileUploadArea.addEventListener('drop', function(e) {
        e.preventDefault();
        e.stopPropagation();
        fileUploadArea.classList.remove('dragover');
        
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            const file = files[0];
            validateAndDisplayFile(file);
            // Set the file input value (this requires a workaround)
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(file);
            fileInput.files = dataTransfer.files;
        }
    });
    
    // File validation and display function
    function validateAndDisplayFile(file) {
        // Check if file is PDF
        if (file.type !== 'application/pdf') {
            showError('Please select a PDF file only.');
            resetFileInput();
            return;
        }
        
        // Check file size (max 10MB)
        if (file.size > MAX_FILE_SIZE) {
            showError(`File size (`+formatFileSize(file.size)+`) exceeds 10MB limit.`);
            resetFileInput();
            return;
        }
        
        // Check for zero-size files
        if (file.size === 0) {
            showError('The selected file is empty.');
            resetFileInput();
            return;
        }
        
        // Display file info
        fileName.textContent = truncateFileName(file.name, 30);
        fileSize.textContent = formatFileSize(file.size);
        
        // Update progress bar based on file size
        updateProgressBar(file.size);
        
        // Show file info and upload button
        fileInfo.style.display = 'block';
        // uploadButtonContainer.style.display = 'block';
        sizeError.style.display = 'none';
        fileValidationError.style.display = 'none';
        
        // Make input valid for Bootstrap validation
        fileInput.setCustomValidity('');
        
        // Log file details for debugging
        // console.log('PDF File selected:', {
        //     name: file.name,
        //     size: file.size,
        //     formattedSize: formatFileSize(file.size),
        //     type: file.type,
        //     lastModified: new Date(file.lastModified).toLocaleString()
        // });
    }
    
    // Format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }
    
    // Update progress bar based on file size
    function updateProgressBar(fileSizeBytes) {
        const percentage = (fileSizeBytes / MAX_FILE_SIZE) * 100;
        const progressBar = fileSizeProgress.querySelector('.progress-bar');
        
        // Show progress bar for files over 1MB
        if (fileSizeBytes > 1024 * 1024) {
            fileSizeProgress.style.display = 'block';
            
            // Set color based on size
            if (percentage >= 90) {
                progressBar.className = 'progress-bar bg-danger';
            } else if (percentage >= 70) {
                progressBar.className = 'progress-bar bg-warning';
            } else {
                progressBar.className = 'progress-bar bg-success';
            }
            
            progressBar.style.width = Math.min(percentage, 100) + '%';
        } else {
            fileSizeProgress.style.display = 'none';
        }
    }
    
    // Show error message
    function showError(message) {
        fileValidationError.textContent = message;
        fileValidationError.style.display = 'block';
        
        // Highlight the upload area
        fileUploadArea.classList.add('border-danger');
        
        // Show error for 5 seconds
        setTimeout(() => {
            fileUploadArea.classList.remove('border-danger');
        }, 5000);
    }
    
    // Reset file input
    function resetFileInput() {
        fileInput.value = '';
        fileInfo.style.display = 'none';
        // uploadButtonContainer.style.display = 'none';
        sizeError.style.display = 'none';
        fileSizeProgress.style.display = 'none';
        fileValidationError.style.display = 'none';
        fileUploadArea.classList.remove('border-danger');
        fileInput.setCustomValidity('Please select a valid PDF file.');
    }
    
    // Truncate long file names
    function truncateFileName(name, maxLength) {
        if (name.length <= maxLength) return name;
        
        const extension = name.split('.').pop();
        const nameWithoutExt = name.substring(0, name.lastIndexOf('.'));
        const truncatedLength = maxLength - extension.length - 4; // Account for "..."
        
        return nameWithoutExt.substring(0, truncatedLength) + '...' + extension;
    }
    
    // Form submission validation
    document.querySelector('form').addEventListener('submit', function(e) {
        if (!fileInput.files.length) {
            e.preventDefault();
            showError('Please select a PDF file to upload.');
            return;
        }
        
        const file = fileInput.files[0];
        if (file.type !== 'application/pdf') {
            e.preventDefault();
            showError('Only PDF files are allowed.');
            return;
        }
        
        if (file.size > MAX_FILE_SIZE) {
            e.preventDefault();
            showError(`File size (`+formatFileSize(file.size)+`) exceeds 10MB limit.`);
            return;
        }
        
        // If all validations pass, show loading state
        btnUploadFile.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Uploading...';
        btnUploadFile.disabled = true;
    });
    
    // Initialize
    resetFileInput();

    // Add event listener for View PDF button
    document.getElementById('btnViewFile').addEventListener('click', viewSelectedPDF);

    // Function to view the selected PDF file
    function viewSelectedPDF() {
        const fileInput = document.getElementById('fileUploadFormatCSAU');
        
        // Check if a file is selected
        if (!fileInput.files || fileInput.files.length === 0) {
            Swal.fire({
                title: 'No File Selected',
                text: 'Please select a PDF file first',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }
        
        const file = fileInput.files[0];
        
        // Validate file type
        if (file.type !== 'application/pdf') {
            Swal.fire({
                title: 'Invalid File Type',
                text: 'Please select a valid PDF file',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return;
        }
        
        try {
            // Show loading state
            showPDFLoading();
            
            // Create object URL for the PDF file
            const fileURL = URL.createObjectURL(file);
            
            // Open PDF in a modal
            openPDFModal(file, fileURL);
            
        } catch (error) {
            console.error('Error viewing PDF:', error);
            Swal.fire({
                title: 'Error',
                text: 'Could not open the PDF file. Please try again.',
                icon: 'error',
                confirmButtonText: 'OK'
            });
        }
    }

    // Function to open PDF in a modal
    function openPDFModal(file, fileURL) {
        // Create modal HTML
        const modalHTML = `
            <div class="modal fade effect-fade modal-blur" id="pdfViewerModal" tabindex="-1" aria-labelledby="pdfViewerModalLabel" aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header d-flex justify-content-between">
                            <h6 class="modal-title" id="pdfViewerModalLabel">
                                <i class="fas fa-file-pdf me-2"></i>
                                `+file.name+`
                            </h6>
                            <div>
                                <span class="badge bg-light text-dark ms-2">`+formatFileSize(file.size)+`</span>
                                <button type="button" class="btn btn-sm btn-outline-light me-2" id="btnDownloadPDF">
                                    <i class="fas fa-download me-1"></i>Download
                                </button>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                        </div>
                        <div class="modal-body p-0" style="min-height: 70vh;">
                            <div id="pdfViewerContainer">
                                <!--<div class="d-flex flex-column align-items-center justify-content-center h-100 p-5" id="pdfLoading">
                                    <div class="spinner-border text-primary mb-3" role="status">
                                        <span class="visually-hidden">Loading PDF...</span>
                                    </div>
                                    <p class="text-muted">Loading PDF document...</p>
                                </div>-->
                                <div id="pdfViewer" style="display: none;">
                                    <div class="pdf-toolbar bg-light p-2 border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <button class="btn btn-sm btn-outline-dark me-2" id="btnPrevPage">
                                                    <i class="fas fa-chevron-left"></i>
                                                </button>
                                                <span class="mx-2">
                                                    Page: <span id="currentPage">1</span> / <span id="totalPages">0</span>
                                                </span>
                                                <button class="btn btn-sm btn-outline-dark ms-2" id="btnNextPage">
                                                    <i class="fas fa-chevron-right"></i>
                                                </button>
                                            </div>
                                            <div>
                                                <div class="input-group input-group-sm" style="width: 150px;">
                                                    <span class="input-group-text">Zoom</span>
                                                    <select class="form-select" id="zoomSelect">
                                                        <option value="0.5">50%</option>
                                                        <option value="0.75">75%</option>
                                                        <option value="1" selected>100%</option>
                                                        <option value="1.25">125%</option>
                                                        <option value="1.5">150%</option>
                                                        <option value="2">200%</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pdf-container p-3">
                                        <canvas id="pdfCanvas" class="mx-auto d-block shadow-sm"></canvas>
                                    </div>
                                </div>
                                <div id="pdfError" class="d-none text-center p-5">
                                    <i class="fas fa-exclamation-triangle fa-3x text-danger mb-3"></i>
                                    <h5>Unable to load PDF</h5>
                                    <p class="text-muted">There was an error loading the PDF document.</p>
                                    <button class="btn btn-primary" onclick="location.reload()">
                                        <i class="fas fa-redo me-2"></i>Try Again
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer d-flex justify-content-between">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i>
                                Use arrow keys to navigate between pages
                            </div>
                            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Add modal to body if not exists
        if (!document.getElementById('pdfViewerModal')) {
            document.body.insertAdjacentHTML('beforeend', modalHTML);
        }
        
        // Get modal instance
        const modal = new bootstrap.Modal(document.getElementById('pdfViewerModal'));
        
        // Show modal
        modal.show();
        
        // Initialize PDF.js when modal is shown
        document.getElementById('pdfViewerModal').addEventListener('shown.bs.modal', function() {
            initializePDFViewer(fileURL);
        });
        
        // Clean up object URL when modal is closed
        document.getElementById('pdfViewerModal').addEventListener('hidden.bs.modal', function() {
            URL.revokeObjectURL(fileURL);
            this.remove();
        });
        
        // Download button handler
        document.getElementById('pdfViewerModal').addEventListener('click', function(e) {
            if (e.target.id === 'btnDownloadPDF' || e.target.closest('#btnDownloadPDF')) {
                downloadPDF(file);
            }
        });
    }

    // Function to initialize PDF.js viewer
    function initializePDFViewer(fileURL) {
        // Check if PDF.js is loaded
        if (typeof pdfjsLib === 'undefined') {
            // Load PDF.js dynamically
            loadPDFJS().then(() => {
                renderPDF(fileURL);
            }).catch(error => {
                console.error('Failed to load PDF.js:', error);
                showPDFError();
            });
        } else {
            renderPDF(fileURL);
        }
    }

    // Function to load PDF.js library dynamically
    function loadPDFJS() {
        return new Promise((resolve, reject) => {
            if (typeof pdfjsLib !== 'undefined') {
                resolve();
                return;
            }
            
            // Create script element
            const script = document.createElement('script');
            script.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js';
            script.integrity = 'sha512-9o9W6Vg9Q9W6XjP0lL8y4E5qX1G8M8q2+5Q6J5q5v5z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z';
            script.crossOrigin = 'anonymous';
            script.onload = resolve;
            script.onerror = reject;
            document.head.appendChild(script);
            
            // Also load the worker
            const workerScript = document.createElement('script');
            workerScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
            workerScript.integrity = 'sha512-9o9W6Vg9Q9W6XjP0lL8y4E5qX1G8M8q2+5Q6J5q5v5z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z';
            workerScript.crossOrigin = 'anonymous';
            document.head.appendChild(workerScript);
        });
    }

    // Function to render PDF using PDF.js
    async function renderPDF(fileURL) {
        try {
            const pdfContainer = document.getElementById('pdfViewerContainer');
            // const pdfLoading = document.getElementById('pdfLoading');
            const pdfViewer = document.getElementById('pdfViewer');
            const pdfCanvas = document.getElementById('pdfCanvas');
            const currentPageSpan = document.getElementById('currentPage');
            const totalPagesSpan = document.getElementById('totalPages');
            const zoomSelect = document.getElementById('zoomSelect');
            
            // Set PDF.js worker path
            pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.4.120/pdf.worker.min.js';
            
            // Load the PDF
            const loadingTask = pdfjsLib.getDocument(fileURL);
            const pdf = await loadingTask.promise;
            
            // Get total pages
            const totalPages = pdf.numPages;
            totalPagesSpan.textContent = totalPages;
            
            // Set initial page
            let currentPage = 1;
            let scale = parseFloat(zoomSelect.value);
            
            // Function to render a specific page
            async function renderPage(pageNum) {
                try {
                    // pdfLoading.style.display = 'flex';
                    pdfViewer.style.display = 'none';
                    
                    const page = await pdf.getPage(pageNum);
                    
                    // Get viewport
                    const viewport = page.getViewport({ scale: scale });
                    
                    // Set canvas dimensions
                    const canvas = pdfCanvas;
                    const context = canvas.getContext('2d');
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;
                    
                    // Render PDF page
                    const renderContext = {
                        canvasContext: context,
                        viewport: viewport
                    };
                    
                    await page.render(renderContext).promise;
                    
                    // Update UI
                    currentPageSpan.textContent = currentPage;
                    // pdfLoading.style.display = 'none';
                    pdfViewer.style.display = 'block';
                    
                } catch (error) {
                    console.error('Error rendering page:', error);
                    showPDFError();
                }
            }
            
            // Render first page
            await renderPage(currentPage);
            
            // Navigation handlers
            document.getElementById('btnPrevPage').addEventListener('click', async () => {
                if (currentPage > 1) {
                    currentPage--;
                    await renderPage(currentPage);
                }
            });
            
            document.getElementById('btnNextPage').addEventListener('click', async () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    await renderPage(currentPage);
                }
            });
            
            // Zoom handler
            zoomSelect.addEventListener('change', async () => {
                scale = parseFloat(zoomSelect.value);
                await renderPage(currentPage);
            });
            
            // Keyboard navigation
            document.addEventListener('keydown', async (e) => {
                if (document.getElementById('pdfViewerModal').classList.contains('show')) {
                    switch(e.key) {
                        case 'ArrowLeft':
                            if (currentPage > 1) {
                                currentPage--;
                                await renderPage(currentPage);
                            }
                            break;
                        case 'ArrowRight':
                            if (currentPage < totalPages) {
                                currentPage++;
                                await renderPage(currentPage);
                            }
                            break;
                        case '+':
                        case '=':
                            e.preventDefault();
                            if (scale < 3) {
                                scale += 0.25;
                                zoomSelect.value = scale.toFixed(2);
                                await renderPage(currentPage);
                            }
                            break;
                        case '-':
                            e.preventDefault();
                            if (scale > 0.25) {
                                scale -= 0.25;
                                zoomSelect.value = scale.toFixed(2);
                                await renderPage(currentPage);
                            }
                            break;
                    }
                }
            });
            
        } catch (error) {
            console.error('Error loading PDF:', error);
            showPDFError();
        }
    }

    // Function to download PDF
    function downloadPDF(file) {
        const downloadURL = URL.createObjectURL(file);
        const a = document.createElement('a');
        a.href = downloadURL;
        a.download = file.name;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(downloadURL);
        
        // Show success message
        Swal.fire({
            title: 'Download Started',
            text: `Downloading `+file.name+``,
            icon: 'success',
            timer: 2000,
            showConfirmButton: false
        });
    }

    // Helper function to show PDF loading state
    function showPDFLoading() {
        // You can add a small loading indicator here if needed
        const btnView = document.getElementById('btnViewFile');
        const originalHTML = btnView.innerHTML;
        btnView.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Opening...';
        btnView.disabled = true;
        
        // Reset button after 2 seconds (in case PDF takes longer)
        setTimeout(() => {
            btnView.innerHTML = originalHTML;
            btnView.disabled = false;
        }, 2000);
    }

    // Helper function to show PDF error
    function showPDFError() {
        // const pdfLoading = document.getElementById('pdfLoading');
        const pdfViewer = document.getElementById('pdfViewer');
        const pdfError = document.getElementById('pdfError');
        
        // if (pdfLoading) pdfLoading.style.display = 'none';
        if (pdfViewer) pdfViewer.style.display = 'none';
        if (pdfError) {
            pdfError.classList.remove('d-none');
            pdfError.classList.add('d-flex', 'flex-column', 'align-items-center', 'justify-content-center');
        }
    }

    // Helper function to format file size
    // function formatFileSize(bytes) {
    //     if (bytes === 0) return '0 Bytes';
    //     const k = 1024;
    //     const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    //     const i = Math.floor(Math.log(bytes) / Math.log(k));
    //     return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    // }

    // Add CSS for PDF viewer
    const pdfViewerCSS = `
        #pdfCanvas {
            max-width: 100%;
            border: 1px solid #dee2e6;
            border-radius: 4px;
        }
        
        .pdf-container {
            overflow: auto;
            max-height: calc(70vh - 100px);
        }
        
        .pdf-toolbar {
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        #btnViewFile:hover {
            transform: translateY(-1px);
            transition: transform 0.2s;
        }
        
        #pdfViewerModal .modal-dialog {
            max-width: 70%;
        }
        
        .modal {
            background: rgba(0, 0, 0, 0.42) !important;
        }
        
        #pdfViewerModal .modal-body {
            min-height: 70vh;
            max-height: 80vh;
            overflow: hidden;
        }
        
        @media (max-width: 768px) {
            #pdfViewerModal .modal-dialog {
                max-width: 95%;
                margin: 0.5rem;
            }
            
            .pdf-toolbar {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .pdf-toolbar > div {
                width: 100%;
                justify-content: center;
            }
        }
    `;

    // Add CSS to document
    if (!document.getElementById('pdf-viewer-css')) {
        const style = document.createElement('style');
        style.id = 'pdf-viewer-css';
        style.textContent = pdfViewerCSS;
        document.head.appendChild(style);
    }
});
</script>
