

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
 <div class="page-header-breadcrumb mb-4">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">

        <!-- Left -->
        <div>
            <h1 class="page-title fw-semibold fs-20 mb-1">
                LRD Map Plottings
            </h1>
            <p class="text-muted mb-0">
                <i class="ri-information-line me-1"></i>
                Manage and plot LRD parcels and transactions
            </p>
        </div>

        <!-- Right -->
        <div class="text-end">

            <ol class="breadcrumb justify-content-end mb-2">
                <li class="breadcrumb-item">
                    <a href="javascript:void(0);" class="text-decoration-none">ELIS</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="javascript:void(0);" class="text-decoration-none">LRD Map Plotting</a>
                </li>
                <li class="breadcrumb-item active">Maps</li>
            </ol>

            <span class="badge bg-primary me-2 px-3 py-2">
                <i class="ri-map-pin-line me-1"></i>
                Parcels: <strong>${parcel_count}</strong>
            </span>

            <span class="badge bg-success px-3 py-2">
                <i class="ri-ruler-2-line me-1"></i>
                Acreage: <strong>${total_acreage}</strong>
            </span>

        </div>

    </div>
</div>

        <!-- End::page-header -->

        <div class="row">
            <!-- Left Sidebar Controls -->
            <div class="col-lg-4 col-xl-3">
                <!-- Control Panel Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-primary text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-sliders-h me-2"></i>Control Panel
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Action Buttons -->
                        <div class="btn-group w-100 mb-4">
                            <button type="button" class="btn btn-primary btn-sm" id="lc_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot" data-bs-tooltip="tooltip" title="Add Coordinate">
                                <i class="fas fa-plus-circle me-1"></i> Add
                            </button>
                            <button type="button" class="btn btn-info btn-sm" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv" data-bs-tooltip="tooltip" title="Upload CSV">
                                <i class="fas fa-upload me-1"></i> CSV
                            </button>
                            <button type="button" class="btn btn-warning btn-sm" id="lrd_btn_visualise_coordinate" data-bs-tooltip="tooltip" title="Visualise Polygon">
                                <i class="fas fa-eye me-1"></i> Visualise
                            </button>
                            <!-- <button type="button" class="btn btn-success btn-sm" id="lrd_btn_save_wkt" data-bs-tooltip="tooltip" title="Plot Parcel">
                                <i class="fas fa-save me-1"></i> Save
                            </button> -->
                        </div>

                        <!-- Coordinate List Table -->
                        <div class="mb-4">
                            <h6 class="fw-semibold mb-3 text-primary">
                                <i class="fas fa-list-ol me-2"></i>Coordinate List
                            </h6>
                            <div class="table-responsive">
                                <table class="table table-hover table-sm" id="coordinatelis_Table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Name</th>
                                            <th>X</th>
                                            <th>Y</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Dynamic content will be inserted here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- WKT Polygon Section -->
                        <div class="mb-4">
                            <h6 class="fw-semibold mb-2 text-primary">
                                <i class="fas fa-draw-polygon me-2"></i>WKT Polygon
                            </h6>
                            <textarea class="form-control form-control-sm" rows="3" id="lrd_txt_wkt_polygon" placeholder="POLYGON((...))"></textarea>
                            <button type="button" class="btn btn-outline-primary btn-sm w-100 mt-2" id="lrd_btn_visualise_wkt" data-bs-tooltip="tooltip" data-bs-original-title="Visualise Polygon">
                                <i class="fas fa-map me-1"></i> Visualise Polygon
                            </button>
                            <button type="button" class="btn btn-warning btn-sm w-100 mt-2 d-none" id="lrd_btn_request_add_existing_parcel" data-bs-toggle="tooltip" title="Request For Add Existing Parcel">
                                <i class="fas fa-paper-plane me-1"></i> Request For Add Existing Parcel
                            </button>
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
                                        <input type="text" class="form-control form-control-sm" id="lrd_x_coordinate" placeholder="Y Coordinate">
                                    </div>
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm" id="lrd_y_coordinate" placeholder="X Coordinate">
                                    </div>
                                    <div class="col-2">
                                        <button class="btn btn-primary btn-sm w-100" id="lrd_btn_show_location" title="Show Location">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </button>
                                          <button class="btn btn-primary btn-sm w-100" id="lrd_btn_load_for_scanned_maps_by_point" title="Load Scanned Maps">
                                            <i class="fas fa-map"></i>
                                        </button>
                                    </div>

                                    
                                </div>
                                <div class="row g-2">
                                    <div class="col-10">
                                        <input type="text" class="form-control form-control-sm" id="lrd_search_by_text" placeholder="Search by Certificate/Ref Number">
                                    </div>
                                    <div class="col-2">
                                        <button class="btn btn-info btn-sm w-100" id="lrd_btn_search_by_certificate_number" title="Search">
                                            <i class="fas fa-search"></i>
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
                                        <option value="-1">Select Scanned Image</option>
                                    </select>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-warning btn-sm flex-fill" id="lrd_btn_search_for_scanned_maps">
                                        <i class="fas fa-search me-1"></i> Search
                                    </button>
                                    <button class="btn btn-success btn-sm flex-fill" id="lrd_btn_load_for_scanned_maps">
                                        <i class="fas fa-check-circle me-1"></i> Load
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Advanced Search -->
                        <div class="card border-info">
                            <div class="card-header bg-info bg-opacity-10 border-info py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-search-plus me-2"></i>Advanced Search
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="mb-3">
                                    <input class="form-control form-control-sm" type="text" 
                                           id="scannned_map_to_search_for" 
                                           placeholder="Enter Map name"
                                           list="listofscannnedmaptosearchfor">
                                    <datalist id="listofscannnedmaptosearchfor"></datalist>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-info btn-sm flex-fill" id="lrd_btn_search_for_scanned_maps_all">
                                        <i class="fas fa-search me-1"></i> Find
                                    </button>
                                    <button class="btn btn-primary btn-sm flex-fill" id="lrd_btn_load_for_scanned_maps_all">
                                        <i class="fas fa-layer-group me-1"></i> Load All
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
                                <table class="table table-hover table-sm" id="lrd_more_than_one_parcel_Table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Reference Number</th>
                                            <th>Locality</th>
                                            <th>Remarks</th>
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
                <!-- Map Controls Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-success text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-map me-2"></i>Interactive Map Viewer
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Map Toolbar -->
                       <!-- Map Toolbar -->
<div class="d-flex flex-wrap align-items-center gap-3 mb-4">
    <!-- Drawing Mode -->
    <div class="btn-group" role="group">
        <button type="button" class="btn btn-outline-primary btn-sm" id="lrd_btn_draw_polygon" title="Draw Polygon">
            <i class="fas fa-draw-polygon me-1"></i> Draw
        </button>
        <button type="button" class="btn btn-outline-warning btn-sm" id="lrd_btn_modify_polygon" title="Modify Shape">
            <i class="fas fa-edit me-1"></i> Modify
        </button>
        <button type="button" class="btn btn-outline-danger btn-sm" id="lrd_btn_delete_polygon" title="Delete Selected">
            <i class="fas fa-trash me-1"></i> Delete
        </button>
        <button type="button" class="btn btn-outline-success btn-sm" id="lrd_btn_measure_distance" title="Measure Distance">
            <i class="fas fa-ruler me-1"></i> Measure
        </button>
        <button type="button" class="btn btn-outline-info btn-sm" id="lrd_btn_measure_area" title="Measure Area">
            <i class="fas fa-ruler-combined me-1"></i> Area
        </button>
    </div>

    <!-- Scale Controls -->
    <div class="d-flex align-items-center gap-2">
        <span class="fw-semibold text-muted">Scale:</span>
        <select class="form-select form-select-sm" style="width: 120px;" id="lrd_scale_value">
            <option value="500">1:500</option>
            <option value="1107">1:1,107</option>
            <option value="1250">1:1,250</option>
            <option value="2500">1:2,500</option>
            <option value="5000">1:5,000</option>
            <option value="10000">1:10,000</option>
            <option value="15000">1:15,000</option>
            <option value="20000">1:20,000</option>
        </select>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="lrd_lockmapscale" checked>
            <label class="form-check-label small" for="lrd_lockmapscale">Lock</label>
        </div>
        <button class="btn btn-primary btn-sm" id="lrd_btn_scale_zoom" title="Zoom to Scale">
            <i class="fas fa-search"></i>
        </button>
    </div>

    <!-- Action Buttons -->
    <div class="d-flex gap-2 ms-auto">
        <button class="btn btn-outline-danger btn-sm" id="lrd_btn_refresh_btn_wkt" title="Refresh Map">
            <i class="fas fa-redo me-1"></i> Refresh
        </button>
        <button class="btn btn-outline-primary btn-sm" id="lrd_btn_print_map" title="Print Map">
            <i class="fas fa-print me-1"></i> Print
        </button>
        <button class="btn btn-outline-secondary btn-sm" id="lrd_btn_clear_measurements" title="Clear Measurements">
            <i class="fas fa-eraser me-1"></i> Clear
        </button>
    </div>
</div>

                        <!-- Map Container -->
                        <div class="border rounded" style="height: 600px;">
                            <div id="lrd-map" class="h-100 w-100"></div>
                        </div>

                       
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i> Total Parcels: <span class="fw-semibold">${parcel_count}</span>
                            </div>
                            <div class="text-muted small">
                                <i class="fas fa-sync-alt me-1"></i> Last updated: Just now
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="lrd_maps_modals.jsp"></jsp:include>

<!-- Bootstrap 5 JS Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize Bootstrap tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-tooltip="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>

<script src="${pageContext.request.contextPath}/js-pages/gated_workflow.js"></script>

