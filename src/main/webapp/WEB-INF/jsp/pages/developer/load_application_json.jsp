  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
 <!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">
						<i class="ri-file-code-fill text-warning me-1"></i>Load Application Json
					</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Load and view application json</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Load Application Json</li>
                </ol>
            </div>
        </div>
          
        
        

      <div class="row g-4">
            <!-- Left Column - JSON Viewer (8 columns) -->
            <div class="col-lg-8">
                <!-- Welcome Header -->
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <h4 class="text-primary mb-1">
                            <i class="bi bi-code-square me-2"></i>
                            Application Details Viewer
                        </h4>
                        <!-- <p class="text-muted mb-0">View complete application data in JSON format</p> -->
                    </div>
                </div>

                <!-- JSON Viewer Card -->
                <div class="row g-3">
                    <div class="col-md-12">
                        <!-- Search Section -->
                        <div class="card border-0 shadow-sm mb-3">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center mb-4">
                                    <div class="flex-shrink-0">
                                        <div class="icon-circle bg-primary bg-opacity-10">
                                            <i class="bi bi-search-heart text-primary fs-4"></i>
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h5 class="mb-1 fw-semibold">Search Application</h5>
                                        <p class="text-muted small mb-0">Enter job number to retrieve details</p>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <div class="d-flex align-items-center text-success small mb-2">
                                        <i class="bi bi-check-circle-fill me-2"></i>
                                        <span>Queries both sub_process & processing tables</span>
                                    </div>
                                    <div class="d-flex align-items-center text-success small mb-2">
                                        <i class="bi bi-check-circle-fill me-2"></i>
                                        <span>Returns complete JSON structure</span>
                                    </div>
                                    <div class="d-flex align-items-center text-success small">
                                        <i class="bi bi-check-circle-fill me-2"></i>
                                        <span>Syntax highlighted for readability</span>
                                    </div>
                                </div>

                                <!-- Search Input Group -->
                                <div class="input-group mb-3">
                                    <span class="input-group-text bg-light border-0">
                                        <i class="bi bi-hash"></i>
                                    </span>
                                    <input type="text" 
                                        class="form-control form-control-lg border-0 bg-light" 
                                        id="jobNumberSearch" 
                                        placeholder="Enter Job Number (e.g., LRDGAR8723722026)"
                                        value="">
                                    <button class="btn btn-primary px-4" id="searchButton">
                                        <i class="bi bi-search me-2"></i>
                                        Load JSON
                                    </button>
                                    <!-- <button class="btn btn-outline-secondary" id="clearButton">
                                        <i class="bi bi-arrow-repeat"></i>
                                    </button> -->
                                </div>
                                <div class="small text-muted">
                                    <i class="bi bi-info-circle me-1"></i>
                                    Minimum 6 characters required
                                </div>
                            </div>
                        </div>

                        <!-- Statistics Cards -->
                        <div id="statsContainer" style="display: none;" class="row g-3 mb-3">
                            <div class="col-md-3">
                                <div class="card border-0 shadow-sm bg-primary bg-opacity-10">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-grid-3x3-gap-fill text-primary fs-4 me-3"></i>
                                            <div>
                                                <small class="text-muted d-block">Total Fields</small>
                                                <span class="h5 mb-0 fw-bold" id="totalFields">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card border-0 shadow-sm bg-success bg-opacity-10">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-file-text text-success fs-4 me-3"></i>
                                            <div>
                                                <small class="text-muted d-block">Sub Process</small>
                                                <span class="h5 mb-0 fw-bold" id="subProcessFields">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card border-0 shadow-sm bg-info bg-opacity-10">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-gear text-info fs-4 me-3"></i>
                                            <div>
                                                <small class="text-muted d-block">Processing</small>
                                                <span class="h5 mb-0 fw-bold" id="processingFields">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card border-0 shadow-sm bg-warning bg-opacity-10">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-clock-history text-warning fs-4 me-3"></i>
                                            <div>
                                                <small class="text-muted d-block">Query Time</small>
                                                <span class="h5 mb-0 fw-bold" id="queryTime">0ms</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- JSON Display Card -->
                        <div class="card border-0 shadow-sm" id="jsonCard" style="display: none;">
                            <div class="card-header bg-white border-0 pt-4 px-4">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <h5 class="mb-1 fw-semibold">
                                            <i class="bi bi-braces text-primary me-2"></i>
                                            Complete Application Data
                                        </h5>
                                        <p class="text-muted small mb-0">
                                            <span class="badge bg-primary bg-opacity-10 text-primary me-2" id="recordCount">
                                                <i class="bi bi-database me-1"></i>1 record
                                            </span>
                                            <span class="text-muted">JSON format with syntax highlighting</span>
                                        </p>
                                    </div>
                                    <button class="btn btn-outline-primary btn-sm" id="copyJsonBtn">
                                        <i class="bi bi-clipboard me-1"></i>
                                        Copy JSON
                                    </button>
                                </div>
                            </div>
                            <div class="card-body px-0">
                                <pre class="bg-dark text-success p-4 m-0 rounded-3" 
                                    style="max-height: 700px; overflow: auto;">
                                    <code id="jsonDisplay" class="language-json" style="font-family: 'Courier New', monospace; font-size: 12px; line-height: 1.4;"></code>
                                </pre>
                            </div>
                        </div>

                        <!-- Loading Indicator -->
                        <div id="loadingIndicator" style="display: none;" class="text-center py-5">
                            <div class="spinner-border text-primary mb-3" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <h6 class="text-muted">Fetching application details...</h6>
                            <p class="text-muted small">Querying database tables</p>
                        </div>

                        <!-- No Results Message -->
                        <div id="noResults" style="display: none;" class="text-center py-5">
                            <div class="mb-3">
                                <i class="bi bi-database-slash text-muted" style="font-size: 3rem;"></i>
                            </div>
                            <h6 class="text-muted mb-2">No Application Found</h6>
                            <p class="text-muted small mb-3">No records found for the provided job number</p>
                            <button class="btn btn-outline-primary btn-sm" onclick="$('#jobNumberSearch').focus()">
                                <i class="bi bi-search me-1"></i>Try Again
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column - Instructions & Info Panel (4 columns) -->
            <div class="col-lg-4">
                <!-- Instructions Card -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <h5 class="mb-1 fw-semibold">
                                    <i class="bi bi-info-circle-fill text-primary me-2"></i>
                                    Instructions & Guidelines
                                </h5>
                                <p class="text-muted small mb-0">How to use the JSON viewer</p>
                            </div>
                            <span class="badge bg-primary bg-opacity-10 text-primary">
                                <i class="bi bi-lightbulb me-1"></i>
                                3 steps
                            </span>
                        </div>
                    </div>
                    <div class="card-body px-4 pt-2">
                        <!-- Accordion for instructions -->
                        <div class="accordion accordion-flush" id="instructionsAccordion">
                            <!-- Step 1: Search -->
                            <div class="accordion-item border-0 mb-2">
                                <h6 class="accordion-header" id="headingSearch">
                                    <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                            type="button" data-bs-toggle="collapse" 
                                            data-bs-target="#collapseSearch">
                                        <i class="bi bi-1-circle-fill me-2 text-primary"></i>
                                        Search for Application
                                    </button>
                                </h6>
                                <div id="collapseSearch" class="accordion-collapse collapse" 
                                    data-bs-parent="#instructionsAccordion">
                                    <div class="accordion-body px-3 py-3">
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-2 d-flex">
                                                <i class="bi bi-arrow-right-circle-fill text-primary me-2 flex-shrink-0"></i>
                                                <span class="small">Enter a valid job number in the search field</span>
                                            </li>
                                            <li class="mb-2 d-flex">
                                                <i class="bi bi-arrow-right-circle-fill text-primary me-2 flex-shrink-0"></i>
                                                <span class="small">Minimum 6 characters required</span>
                                            </li>
                                            <li class="d-flex">
                                                <i class="bi bi-arrow-right-circle-fill text-primary me-2 flex-shrink-0"></i>
                                                <span class="small">Click "Load JSON" or press Enter</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- Step 2: View JSON -->
                            <div class="accordion-item border-0 mb-2">
                                <h6 class="accordion-header" id="headingView">
                                    <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                            type="button" data-bs-toggle="collapse" 
                                            data-bs-target="#collapseView">
                                        <i class="bi bi-2-circle-fill me-2 text-success"></i>
                                        View JSON Data
                                    </button>
                                </h6>
                                <div id="collapseView" class="accordion-collapse collapse" 
                                    data-bs-parent="#instructionsAccordion">
                                    <div class="accordion-body px-3 py-3">
                                        <div class="list-group list-group-flush">
                                            <div class="list-group-item border-0 px-0 py-2">
                                                <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                                <span class="small">Complete data from both tables</span>
                                            </div>
                                            <div class="list-group-item border-0 px-0 py-2">
                                                <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                                <span class="small">Syntax highlighted for readability</span>
                                            </div>
                                            <div class="list-group-item border-0 px-0 py-2">
                                                <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                                <span class="small">Nested sub_process and processing objects</span>
                                            </div>
                                            <div class="list-group-item border-0 px-0 py-2">
                                                <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                                <span class="small">Statistics shown in summary cards</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Step 3: Export/Use Data -->
                            <div class="accordion-item border-0">
                                <h6 class="accordion-header" id="headingExport">
                                    <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                            type="button" data-bs-toggle="collapse" 
                                            data-bs-target="#collapseExport">
                                        <i class="bi bi-3-circle-fill me-2 text-info"></i>
                                        Export or Use Data
                                    </button>
                                </h6>
                                <div id="collapseExport" class="accordion-collapse collapse" 
                                    data-bs-parent="#instructionsAccordion">
                                    <div class="accordion-body px-3 py-3">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-info bg-opacity-10 p-2 rounded-circle me-3">
                                                <i class="bi bi-clipboard text-info"></i>
                                            </div>
                                            <div>
                                                <small class="text-muted d-block">Option 1</small>
                                                <h6 class="mb-0 small">Copy to Clipboard</h6>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-info bg-opacity-10 p-2 rounded-circle me-3">
                                                <i class="bi bi-download text-info"></i>
                                            </div>
                                            <div>
                                                <small class="text-muted d-block">Option 2</small>
                                                <h6 class="mb-0 small">Save as JSON file</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Database Schema Card -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <h5 class="mb-0 fw-semibold">
                            <i class="bi bi-diagram-3 text-primary me-2"></i>
                            Database Schema
                        </h5>
                    </div>
                    <div class="card-body px-4">
                        <div class="mb-3">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-table text-primary me-2"></i>
                                <span class="fw-semibold small">csau.lrd_registration_sub_process</span>
                            </div>
                            <p class="text-muted small ms-4 mb-2">Main application record with job details</p>
                            <div class="bg-light p-2 rounded small ms-4">
                                <code class="text-dark">PRIMARY KEY: jn_id</code><br>
                                <code class="text-dark">UNIQUE: job_number</code>
                            </div>
                        </div>
                        <div>
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-table text-success me-2"></i>
                                <span class="fw-semibold small">csau.lrd_registration_processing</span>
                            </div>
                            <p class="text-muted small ms-4 mb-2">Case processing details with case_number</p>
                            <div class="bg-light p-2 rounded small ms-4">
                                <code class="text-dark">PRIMARY KEY: loid</code><br>
                                <code class="text-dark">UNIQUE: case_number</code>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
          
            
    </div>
      
</div>
      
 <!-- Highlight.js for JSON syntax highlighting -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/highlight.min.js"></script>
       
<script>
    $(document).ready(function() {
        let currentJsonData = null;

        // Syntax highlight JSON
        function highlightJSON(jsonString) {
            if (typeof jsonString === 'string') {
                try {
                    // Parse and re-stringify to ensure valid JSON
                    const obj = JSON.parse(jsonString);
                    jsonString = JSON.stringify(obj, null, 2);
                } catch (e) {
                    // If it's not valid JSON, just return as is
                }
            } else {
                jsonString = JSON.stringify(jsonString, null, 2);
            }
            
            // Use highlight.js to highlight
            const highlighted = hljs.highlight(jsonString, { language: 'json' }).value;
            return highlighted;
        }

        // Load details function
        function loadApplicationDetails(jobNumber) {
            if (!jobNumber || jobNumber.length < 6) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Invalid Input',
                    text: 'Please enter a valid job number (minimum 6 characters)',
                    background: '#1e1e1e',
                    color: '#fff',
                    confirmButtonColor: '#667eea'
                });
                return;
            }

            // Show loading
            $('#loadingIndicator').show();
            $('#jsonResults').hide();
            $('#noResults').hide();
            $('#statsContainer').hide();
            $('#jsonCard').hide();
            currentJsonData = null;

            // Simulate AJAX call (replace with actual AJAX in production)
            setTimeout(function() {
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv", // Replace with your servlet URL
                    data: {
                        request_type: 'get_application_json',
                        job_number: jobNumber
                    },
                    dataType: 'json',
                    success: function(response) {
                        $('#loadingIndicator').hide();
                        
                        if (response && response.success) {
                            currentJsonData = response.data;
                            
                            // Format and display JSON
                            const formattedJson = JSON.stringify(response.data, null, 2);
                            const highlightedJson = formattedJson; //highlightJSON(formattedJson); 
                            
                            $('#jsonDisplay').html(highlightedJson);
                            $('#jsonCard').show();
                            
                            // Update statistics
                            const subFields = response.data.sub_process ? 
                                Object.keys(response.data.sub_process).length : 0;
                            const procFields = response.data.processing ? 
                                Object.keys(response.data.processing).length : 0;
                            
                            $('#totalFields').text(subFields + procFields);
                            $('#subProcessFields').text(subFields);
                            $('#processingFields').text(procFields);
                            $('#queryTime').text(response.query_time || '45ms');
                            
                            $('#statsContainer').show();
                            $('#jsonResults').show();
                            
                            Swal.fire({
                                icon: 'success',
                                title: 'Data Loaded',
                                text: `Successfully loaded ${subFields + procFields} fields`,
                                timer: 2000,
                                showConfirmButton: false,
                                background: '#1e1e1e',
                                color: '#fff'
                            });
                        } else {
                            $('#noResults').show();
                        }
                    },
                    error: function(xhr, status, error) {
                        $('#loadingIndicator').hide();
                        $('#noResults').show();
                        
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to load application details',
                            background: '#1e1e1e',
                            color: '#fff',
                            confirmButtonColor: '#667eea'
                        });
                        console.error('Error:', error);
                    }
                });
            }, 800); // Simulated delay
        }

        // Load button click
        $('#searchButton').on('click', function() {
            const jobNumber = $('#jobNumberSearch').val().trim();
            loadApplicationDetails(jobNumber);
        });

        // Enter key press
        // $('#jobNumberSearch').on('keypress', function(e) {
        //     if (e.which === 13) {
        //         $('#loadDetails').click();
        //     }
        // });

        // Clear results
        $('#clearResults').on('click', function() {
            $('#jobNumberSearch').val('');
            $('#jsonResults').hide();
            $('#noResults').hide();
            $('#statsContainer').hide();
            $('#loadingIndicator').hide();
            $('#jsonDisplay').empty();
            currentJsonData = null;
        });

        // Copy JSON to clipboard
        $('#copyJsonBtn').on('click', function() {
            if (currentJsonData) {
                const jsonString = JSON.stringify(currentJsonData, null, 2);
                navigator.clipboard.writeText(jsonString).then(function() {
                    Swal.fire({
                        icon: 'success',
                        title: 'Copied!',
                        text: 'JSON copied to clipboard',
                        timer: 1500,
                        showConfirmButton: false,
                        background: '#1e1e1e',
                        color: '#fff'
                    });
                }).catch(function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to copy JSON',
                        background: '#1e1e1e',
                        color: '#fff'
                    });
                });
            }
        });

        // Load initial example
        setTimeout(function() {
            $('#loadDetails').click();
        }, 500);
    });
</script>
           
        

  
  
  
  
  

