<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Rent Management Maps</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Visualize and manage government land estates</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Rent Management</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Maps</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Start::row-1 -->
        <div class="row">
            <div class="col-xl-4 col-lg-4">
                <!-- Tools Card -->
                <div class="card custom-card mb-3">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <i class="ri-map-pin-line text-primary me-2"></i>
                            <h5 class="card-title mb-0">Rent Management Tools</h5>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Action Buttons -->
                        <div class="d-flex flex-wrap gap-2 mb-4">
                            <button type="button" class="btn btn-primary" id="pvlmd_btn_add_coordinate"
                                data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot"
                                data-bs-toggle="tooltip" title="Draw a Line">
                                <i class="ri-add-circle-line me-1"></i> Add Coordinate
                            </button>

                            <button type="button" class="btn btn-warning" id="lrd_btn_add_coordinate_by_csv"
                                data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv"
                                data-bs-toggle="tooltip" title="Upload CSV">
                                <i class="ri-upload-cloud-line me-1"></i> Upload CSV
                            </button>

                            <button type="button" class="btn btn-danger" id="pvlmd_btn_visualise_coordinate"
                                data-bs-toggle="tooltip" title="Visualise Coordinate">
                                <i class="ri-eye-line me-1"></i> Visualise
                            </button>

                            <button type="button" class="btn btn-info" id="pvlmd_btn_visualise_wkt"
                                data-bs-toggle="tooltip" title="Visualise Polygon">
                                <i class="ri-map-pin-line me-1"></i> Polygon
                            </button>

                            <button type="button" class="btn btn-success" id="pvlmd_btn_save_parcels"
                                data-bs-toggle="tooltip" title="Save Parcels">
                                <i class="ri-save-line me-1"></i> Save
                            </button>
                        </div>

                        <!-- Search Section -->
                        <div class="card custom-card border mb-4">
                            <div class="card-body">
                                <h6 class="card-title mb-3">
                                    <i class="ri-search-line me-1 text-muted"></i>Search Section
                                </h6>
                                
                                <div class="mb-3">
                                    <label class="form-label small">Search Type</label>
                                    <select class="form-select form-select-sm" id="rts_select_type">
                                        <option disabled selected value="-1">-- select type --</option>
                                        <option value="Plot Number">Plot Number</option>
                                        <option value="Estate">Estate</option>
                                        <option value="Certificate Number">Certificate Number</option>
                                    </select>
                                </div>

                                <div class="mb-3 d-none" id="div_rent_estate">
                                    <label class="form-label small">Select Estate</label>
                                    <select name="rts_estate" id="rts_estate" class="form-select form-select-sm">
                                        <option selected disabled value="">-- select estate --</option>
                                        <c:forEach items="${estate_list}" var="estateList">
                                            <option value="${estateList.ge_id}">${estateList.ge_location_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3 d-none" id="div_rent_keyword">
                                    <label class="form-label small">Keyword</label>
                                    <input class="form-control form-control-sm" 
                                           id="rts_keyword" 
                                           placeholder="Enter keyword...">
                                </div>

                                <div class="mb-3 d-none" id="div_certificate_rmap_search">
                                    <label class="form-label small">Certificate Number</label>
                                    <div class="input-group input-group-sm">
                                        <input class="form-control" 
                                               id="pvlmd_search_by_text"
                                               type="text" 
                                               placeholder="Search by Certificate Number" 
                                               required>
                                        <button type="button" 
                                                class="btn btn-outline-danger"
                                                id="pvlmd_btn_search_by_certificate_number"
                                                data-bs-toggle="tooltip"
                                                title="Show Location">
                                            <i class="ri-search-line"></i>
                                        </button>
                                    </div>
                                </div>

                                <button class="btn btn-success btn-sm w-100" id="btn_rmap_search">
                                    <i class="ri-search-line me-1"></i>Search
                                </button>
                            </div>
                        </div>

                        <!-- WKT Display Area -->
                        <div class="mb-3">
                            <label class="form-label small">WKT Data</label>
                            <div class="form-control form-control-sm bg-light" 
                                 style="min-height: 100px; font-family: monospace; font-size: 12px;"
                                 id="wkt-display">
                                <!-- WKT data will be displayed here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-8 col-lg-8">
                <!-- Map Card -->
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <i class="ri-government-line text-primary me-2"></i>
                            <h5 class="card-title mb-0">Government Land Estates</h5>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div id="govrent-map" style="height: 600px; width: 100%;"></div>
                    </div>
                    <div class="card-footer small text-muted">
                        <div class="d-flex justify-content-between">
                            <span>Rent Management System</span>
                            <span id="map-info">Ready</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End::row-1 -->

    </div>
</div>

<!-- Add Coordinate Modal -->
<div class="modal fade" id="addcoordinatetoplot" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="ri-add-circle-line me-2"></i>Add Coordinate
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="coordinateForm">
                    <div class="mb-3">
                        <label class="form-label">Latitude</label>
                        <input type="text" class="form-control" id="latitude" placeholder="Enter latitude">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Longitude</label>
                        <input type="text" class="form-control" id="longitude" placeholder="Enter longitude">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Plot Number</label>
                        <input type="text" class="form-control" id="plotNumber" placeholder="Enter plot number">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="btnSaveCoordinate">
                    <i class="ri-save-line me-1"></i>Save Coordinate
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Upload CSV Modal -->
<div class="modal fade" id="uploadcoordiantecsv" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="ri-upload-cloud-line me-2"></i>Upload Coordinates CSV
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="csvUploadForm" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="csvFile" class="form-label">Select CSV File</label>
                        <input class="form-control" type="file" id="csvFile" name="csvFile" accept=".csv" required>
                        <div class="form-text">
                            Upload CSV file containing coordinates. Supported format: Latitude,Longitude,PlotNumber
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="hasHeader">
                            <label class="form-check-label" for="hasHeader">
                                File contains header row
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="btnUploadCSV">
                    <i class="ri-upload-cloud-line me-1"></i>Upload
                </button>
            </div>
        </div>
    </div>
</div>

<style>
    /* Map Container */
    #govrent-map {
        border-radius: 0.375rem;
        overflow: hidden;
    }
    
    /* Tool buttons styling */
    .btn {
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
        border-radius: 0.375rem;
        transition: all 0.2s ease;
    }
    
    .btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    
    /* Card styling */
    .card.custom-card {
        border: none;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        border-radius: 0.5rem;
    }
    
    .card-header {
        background-color: #fff;
        border-bottom: 1px solid #e9ecef;
        padding: 1rem 1.25rem;
    }
    
    .card-body {
        padding: 1.25rem;
    }
    
    /* Form controls */
    .form-select, .form-control {
        border-radius: 0.375rem;
        border: 1px solid #e9ecef;
        font-size: 0.875rem;
    }
    
    .form-select:focus, .form-control:focus {
        border-color: #3a7bd5;
        box-shadow: 0 0 0 0.2rem rgba(58, 123, 213, 0.25);
    }
    
    /* Search section card */
    .border {
        border: 1px solid #e9ecef !important;
    }
    
    /* WKT display area */
    #wkt-display {
        overflow-y: auto;
        resize: vertical;
        white-space: pre-wrap;
        word-break: break-all;
        border: 1px solid #e9ecef;
        background-color: #f8f9fa;
    }
    
    /* Modal styling */
    .modal-content {
        border-radius: 0.5rem;
        border: none;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }
    
    .modal-header {
        background-color: #f9fafc;
        border-bottom: 1px solid #e9ecef;
        padding: 1rem 1.5rem;
    }
    
    .modal-body {
        padding: 1.5rem;
    }
    
    .modal-footer {
        border-top: 1px solid #e9ecef;
        padding: 1rem 1.5rem;
    }
    
    /* Responsive adjustments */
    @media (max-width: 992px) {
        .row {
            flex-direction: column;
        }
        
        #govrent-map {
            height: 400px;
        }
        
        .d-flex.flex-wrap.gap-2 {
            justify-content: center;
        }
    }
    
    @media (max-width: 768px) {
        #govrent-map {
            height: 350px;
        }
        
        .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.8125rem;
        }
        
        .card-body {
            padding: 1rem;
        }
    }
    
    /* Loading indicator */
    .map-loading {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1000;
    }
</style>

<script>
    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        
        // Search type toggle
        const searchTypeSelect = document.getElementById('rts_select_type');
        const estateDiv = document.getElementById('div_rent_estate');
        const keywordDiv = document.getElementById('div_rent_keyword');
        const certificateDiv = document.getElementById('div_certificate_rmap_search');
        const searchButtonDiv = document.getElementById('div_btn_rmap_search');
        
        if (searchTypeSelect) {
            searchTypeSelect.addEventListener('change', function() {
                estateDiv.classList.add('d-none');
                keywordDiv.classList.add('d-none');
                certificateDiv.classList.add('d-none');
                searchButtonDiv.classList.remove('d-none');
                
                switch(this.value) {
                    case 'Estate':
                        estateDiv.classList.remove('d-none');
                        searchButtonDiv.classList.add('d-none');
                        break;
                    case 'Plot Number':
                        keywordDiv.classList.remove('d-none');
                        break;
                    case 'Certificate Number':
                        certificateDiv.classList.remove('d-none');
                        searchButtonDiv.classList.add('d-none');
                        break;
                }
            });
        }
    });
</script>