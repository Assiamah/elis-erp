
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<style>
.ol-popup {
    position: absolute;
    background-color: white;
    box-shadow: 0 1px 4px rgba(0,0,0,0.2);
    padding: 15px;
    border-radius: 10px;
    border: 1px solid #cccccc;
    bottom: 12px;
    left: -50px;
    min-width: 250px;
    max-width: 400px;
    max-height: 350px;
    display: none;
    z-index: 1000;
}

.ol-popup:after, .ol-popup:before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
}

.ol-popup:after {
    border-top-color: white;
    border-width: 10px;
    left: 48px;
    margin-left: -10px;
}

.ol-popup:before {
    border-top-color: #cccccc;
    border-width: 11px;
    left: 48px;
    margin-left: -11px;
}

.ol-popup-closer {
    text-decoration: none;
    position: absolute;
    top: 2px;
    right: 8px;
    font-size: 20px;
    cursor: pointer;
}

.ol-popup h4 {
    margin: 0 0 10px 0;
    padding: 0;
    color: #333;
}

.ol-popup .feature-properties {
    margin: 5px 0;
    font-size: 13px;
    line-height: 1.5;
}

.ol-popup hr {
    margin: 8px 0;
    border: none;
    border-top: 1px solid #eee;
}

.ol-popup strong {
    color: #555;
}

.ol-popup table {
    font-size: 12px;
    border-collapse: collapse;
    width: 100%;
}

.ol-popup td {
    padding: 4px 8px;
    border: 1px solid #ddd;
}

.ol-popup tr:nth-child(even) {
    background-color: #f9f9f9;
}
</style>
<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Digital Map Search</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Search and visualize parcels across all divisions</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">Digital Map Search</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Maps</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row">
            <!-- Left Sidebar Controls -->
            <div class="col-lg-4 col-xl-3">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-primary text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-sliders-h me-2"></i>Control Panel
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Drawing Tools Section -->
                        <div class="card border-primary mb-4">
                            <div class="card-header bg-primary bg-opacity-10 border-primary py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-draw-polygon me-2"></i>Drawing Tools
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="btn-group w-100 mb-3" role="group">
                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="addDigitizeInteraction('Polygon')" id="drawPolygonBtn">
                                        <i class="fas fa-draw-polygon me-1"></i> Polygon
                                    </button>
                                    <!-- <button type="button" class="btn btn-outline-success btn-sm" id="drawRectangleBtn">
                                        <i class="fas fa-square me-1"></i> Rectangle
                                    </button>
                                    <button type="button" class="btn btn-outline-info btn-sm" id="drawCircleBtn">
                                        <i class="fas fa-circle me-1"></i> Circle
                                    </button> -->
                                </div>
                                <div class="btn-group w-100 mb-3" role="group">
                                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="enableModify()" id="modifyBtn">
                                        <i class="fas fa-edit me-1"></i> Modify
                                    </button>
                                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteSelectedFeature()" id="deleteBtn">
                                        <i class="fas fa-trash me-1"></i> Delete
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="clearDigitizedFeatures()" id="clearDrawingsBtn">
                                        <i class="fas fa-eraser me-1"></i> Clear All
                                    </button>
                                </div>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-success btn-sm flex-fill" id="saveDrawingBtn">
                                        <i class="fas fa-save me-1"></i> Save Drawing
                                    </button>
                                    <button type="button" class="btn btn-info btn-sm flex-fill"  onclick="exportFeaturesToJSONArray()" id="exportGeoJsonBtn">
                                        <i class="fas fa-file-code me-1"></i> Export GeoJSON
                                    </button>
                                </div>

                                <div class="btn-group">

    <!-- <button onclick="addDigitizeInteraction('Point')">
        Point
    </button>

    <button onclick="addDigitizeInteraction('LineString')">
        Line
    </button>

    <button onclick="addDigitizeInteraction('Polygon')">
        Polygon
    </button> -->

    <!-- <button onclick="enableModify()">
        Modify
    </button>

    <button onclick="deleteSelectedFeature()">
        Delete
    </button>

    <button onclick="clearDigitizedFeatures()">
        Clear
    </button>

    <button onclick="exportFeaturesToJSONArray()">
        Export
    </button> -->

</div>
                            </div>
                        </div>

                        <!-- Drawing Info -->
                        <div class="card border-secondary mb-4">
                            <div class="card-header bg-secondary bg-opacity-10 border-secondary py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-info-circle me-2"></i>Drawing Info
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div id="drawingInfo">
                                    <p class="small text-muted mb-1">Vertices: <span id="vertexCount">0</span></p>
                                    <p class="small text-muted mb-1">Area: <span id="areaInfo">0</span> m²</p>
                                    <p class="small text-muted mb-0">WKT: <span id="wktDisplay" class="text-break">None</span></p>
                                </div>
                            </div>
                        </div>

                        <!-- WKT Polygon Section -->
                        <div class="mb-4">
                            <h6 class="fw-semibold mb-2 text-primary">
                                <i class="fas fa-draw-polygon me-2"></i>WKT Polygon
                            </h6>
                            <textarea class="form-control form-control-sm mb-2" rows="3" id="pvlmd_bl_wkt_polygon" placeholder="POLYGON((...))"></textarea>
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-outline-primary btn-sm flex-fill" id="pvlmd_btn_visualise_wkt" data-bs-tooltip="tooltip" title="Visualise Polygon">
                                    <i class="fas fa-map me-1"></i> Visualise Polygon
                                </button>
                                <button type="button" class="btn btn-success btn-sm flex-fill" id="pvlmd_btn_save_wkt" data-bs-tooltip="tooltip" title="Save Parcels" style="display: none;">
                                    <i class="fas fa-save me-1"></i> Save
                                </button>
                            </div>
                        </div>

                        <!-- Quick Coordinate Search -->
                        <div class="card border-success mb-4">
                            <div class="card-header bg-success bg-opacity-10 border-success py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-search-location me-2"></i>Quick Coordinate Search
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="row g-2 mb-2">
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm" id="pvlmd_x_coordinate_mak" placeholder="X Coordinate">
                                    </div>
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm" id="pvlmd_y_coordinate_mak" placeholder="Y Coordinate">
                                    </div>
                                    <div class="col-2">
                                        <button type="button" class="btn btn-primary btn-sm w-100" id="pvlmd_btn_show_location" data-bs-tooltip="tooltip" title="Show Location">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="row g-2">
                                    <div class="col-8">
                                        <input type="text" class="form-control form-control-sm" id="pvlmd_search_by_text" name="pvlmd_search_by_text" placeholder="Search by Ref Number" required>
                                    </div>
                                    <div class="col-2">
                                        <button type="button" class="btn btn-info btn-sm w-100" id="pvlmd_btn_search_by_reference_number" data-bs-tooltip="tooltip" title="Search Reference Number">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="col-2">
                                        <button type="button" class="btn btn-success btn-sm w-100" id="pvlmd_btn_load_for_scanned_maps_by_point" data-bs-tooltip="tooltip" title="Search Scanned Map">
                                            <i class="fas fa-check-circle"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Scanned Maps Section -->
                        <div class="card border-warning mb-4">
                            <div class="card-header bg-warning bg-opacity-10 border-warning py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-layer-group me-2"></i>Scanned Maps
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="mb-3">
                                    <select class="form-select form-select-sm" id="geoserverscannedimages_list">
                                        <option value="-1">No Scanned Image</option>
                                    </select>
                                </div>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-warning btn-sm flex-fill" id="pvlmd_btn_search_for_scanned_maps" data-bs-tooltip="tooltip" title="Search for related sheets">
                                        <i class="fas fa-search me-1"></i> Search
                                    </button>
                                    <button type="button" class="btn btn-success btn-sm flex-fill" id="pvlmd_btn_load_for_scanned_maps" data-bs-tooltip="tooltip" title="Show Selected Sheet">
                                        <i class="fas fa-check-circle me-1"></i> Load
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Multiple Parcels Table -->
                        <div class="mt-4">
                            <h6 class="fw-semibold mb-3 text-primary">
                                <i class="fas fa-copy me-2"></i>Multiple Parcel Overlays
                            </h6>
                            <div class="table-responsive">
                                <table class="table table-hover table-sm" id="pvlmd_more_than_one_parcel_Table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Reference Number</th>
                                            <th>NT Number</th>
                                            <th>Locality</th>
                                            <th class="text-center">Details</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Dynamic content will be inserted here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Map Area -->
            <div class="col-lg-8 col-xl-9">
                <!-- Map Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-success text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-map me-2"></i>Interactive Map Viewer
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Map Toolbar -->
                        <div class="d-flex flex-wrap align-items-center gap-3 mb-4">
                            <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" name="interaction_type" id="draw" value="draw" checked>
                                <label class="btn btn-outline-primary btn-sm" for="draw">
                                    <i class="fas fa-pencil-alt me-1"></i> Draw
                                </label>
                                <input type="radio" class="btn-check" name="interaction_type" id="modify" value="modify">
                                <label class="btn btn-outline-warning btn-sm" for="modify">
                                    <i class="fas fa-edit me-1"></i> Modify
                                </label>
                            </div>

                            <!-- Scale Controls -->
                            <div class="d-flex align-items-center gap-2">
                                <span class="fw-semibold text-muted">Scale:</span>
                                <input type="text" class="form-control form-control-sm" id="pvlmd_scale_value_e" name="pvlmd_scale_value_e" placeholder="Custom" style="width: 90px;">
                                <select class="form-select form-select-sm" style="width: 120px;" id="pvlmd_scale_value">
                                    <option value="500">1:500</option>
                                    <option value="1107">1:1,107</option>
                                    <option value="1250">1:1,250</option>
                                    <option value="2500">1:2,500</option>
                                    <option value="2140">1:2,140</option>
                                    <option value="2670">1:2,670</option>
                                    <option value="2215">1:2,215</option>
                                    <option value="2825">1:2,825</option>
                                    <option value="5000">1:5,000</option>
                                    <option value="10000">1:10,000</option>
                                    <option value="15000">1:15,000</option>
                                    <option value="20000">1:20,000</option>
                                </select>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="pvlmd_lockmapscale" checked>
                                    <label class="form-check-label small" for="pvlmd_lockmapscale">Lock</label>
                                </div>
                                <button type="button" class="btn btn-primary btn-sm" id="pvlmd_btn_scale_zoom" data-bs-tooltip="tooltip" title="Zoom to Scale">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2 ms-auto">
                                <button type="button" class="btn btn-outline-primary btn-sm" id="pvlmd_btnprintmap" data-bs-tooltip="tooltip" title="Print Map">
                                    <i class="fas fa-print me-1"></i> Print
                                </button>
                                <button type="button" class="btn btn-outline-info btn-sm" id="pvlmd_btn_visualise_search" data-bs-tooltip="tooltip" title="Visualise Search">
                                    <i class="fas fa-search me-1"></i> Search
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm" id="pvlmd_btngeneratesearchreport" data-bs-tooltip="tooltip" title="Print Search Report">
                                    <i class="fas fa-file-alt me-1"></i> Report
                                </button>
                            </div>
                        </div>

                        <!-- Map Container -->
                        <div class="border rounded" style="height: 450px;">
                            <div id="alld-map" class="h-100 w-100"></div>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i> Digital Map Search - All Divisions
                            </div>
                            <div class="text-muted small">
                                <i class="fas fa-sync-alt me-1"></i> Last updated: Just now
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Transaction Search Results Table -->
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-gradient-info text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-list-alt me-2"></i>Transaction Search Results
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered display" id="pvlmd_transaction_all_dataTable" width="100%" cellspacing="0">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Job Number</th>
                                        <th>Certificate Number</th>
                                        <th>File Number</th>
                                        <th>Property Number</th>
                                        <th>Grantor</th>
                                        <th>Grantee</th>
                                        <th>Instrument Type</th>
                                        <th>Transaction Date</th>
                                        <th>Status</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Dynamic content will be inserted here -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-2">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                <i class="fas fa-database me-1"></i> Showing transaction records
                            </div>
                            <div class="text-muted small" id="transactionRecordCount">
                                <i class="fas fa-file-alt me-1"></i> Total: 0 records
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End::app-content -->


<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-tooltip="tooltip"]'));
        tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Initialize Transaction Search DataTable
        if ($.fn.DataTable.isDataTable('#pvlmd_transaction_all_dataTable')) {
            $('#pvlmd_transaction_all_dataTable').DataTable().destroy();
        }
        
        var transactionTable = $('#pvlmd_transaction_all_dataTable').DataTable({
            pageLength: 10,
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            responsive: true,
            order: [[0, 'desc']],
            columnDefs: [
                { orderable: false, targets: [10] }
            ],
            language: {
                search: "<i class='fas fa-search me-1'></i>Search:",
                searchPlaceholder: "Search transactions...",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ to _END_ of _TOTAL_ transactions",
                infoEmpty: "No transactions available",
                infoFiltered: "(filtered from _MAX_ total transactions)",
                zeroRecords: "No matching transactions found"
            }
        });

        // Transaction Search Button Click Handler
        $('#pvlmd_btn_search_transaction').on('click', function() {
            var searchText = $('#pvlmd_search_transaction_by_text').val().trim();
            
            if (!searchText) {
                Swal.fire({
                    title: 'Warning',
                    text: 'Please enter a search term',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });
                return;
            }

            var btn = $(this);
            btn.prop('disabled', true);
            btn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');

            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'search_transactions',
                    search_text: searchText
                },
                dataType: 'json',
                success: function(response) {
                    transactionTable.clear().draw();
                    
                    if (response && response.length > 0) {
                        response.forEach(function(item, index) {
                            var statusBadge = '<span class="badge text-bg-success">Active</span>';
                            if (item.status === 'Inactive') {
                                statusBadge = '<span class="badge text-bg-danger">Inactive</span>';
                            } else if (item.status === 'Pending') {
                                statusBadge = '<span class="badge text-bg-warning text-dark">Pending</span>';
                            }
                            
                            transactionTable.row.add([
                                index + 1,
                                `<span class="fw-semibold">${item.job_number || 'N/A'}</span>`,
                                item.certificate_number || 'N/A',
                                item.file_number || 'N/A',
                                item.property_number || 'N/A',
                                item.grantor || 'N/A',
                                item.grantee || 'N/A',
                                item.instrument_type || 'N/A',
                                item.transaction_date || 'N/A',
                                statusBadge,
                                `<div class="d-flex gap-1 justify-content-center">
                                    <button class="btn btn-sm btn-info view-transaction" 
                                            data-job="${item.job_number}"
                                            title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-primary locate-transaction" 
                                            data-job="${item.job_number}"
                                            title="Locate on Map">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </button>
                                </div>`
                            ]).draw();
                        });
                        
                        $('#transactionRecordCount').html(`<i class="fas fa-file-alt me-1"></i> Total: ${response.length} records`);
                    } else {
                        transactionTable.row.add([
                            'No records found',
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            ''
                        ]).draw();
                        $('#transactionRecordCount').html('<i class="fas fa-file-alt me-1"></i> Total: 0 records');
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Error',
                        text: 'An error occurred while searching transactions',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                },
                complete: function() {
                    btn.prop('disabled', false);
                    btn.html('<i class="fas fa-search me-1"></i> Search');
                }
            });
        });

        // Clear Transaction Search
        $('#pvlmd_btn_clear_transaction_search').on('click', function() {
            $('#pvlmd_search_transaction_by_text').val('');
            transactionTable.clear().draw();
            $('#transactionRecordCount').html('<i class="fas fa-file-alt me-1"></i> Total: 0 records');
        });

        // View Transaction Details
        $(document).on('click', '.view-transaction', function() {
            var jobNumber = $(this).data('job');
            Swal.fire({
                title: 'Transaction Details',
                text: 'View details for job: ' + jobNumber,
                icon: 'info',
                confirmButtonText: 'OK'
            });
        });

        // Locate Transaction on Map
        $(document).on('click', '.locate-transaction', function() {
            var jobNumber = $(this).data('job');
            Swal.fire({
                title: 'Locate Transaction',
                text: 'Locating transaction: ' + jobNumber + ' on map...',
                icon: 'info',
                timer: 2000,
                showConfirmButton: false
            });
        });

        // Enter key support for search
        $('#pvlmd_search_transaction_by_text').on('keypress', function(e) {
            if (e.which === 13) {
                $('#pvlmd_btn_search_transaction').click();
            }
        });

        
    });
</script>


<script src="${pageContext.request.contextPath}/js-pages/js-map/digitalmaps_search.js"></script>
