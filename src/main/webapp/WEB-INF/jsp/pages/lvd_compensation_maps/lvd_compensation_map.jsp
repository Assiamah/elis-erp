
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">LVD Compensation Map</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Manage and plot LVD compensation parcels</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">LVD Compensation Map</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Maps</li>
                </ol>
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
                            <i class="fas fa-sliders-h me-2"></i>Map Plotting
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Action Buttons -->
                        <div class="btn-group w-100 mb-4">
                            <button type="button" class="btn btn-primary btn-sm" id="comp_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot" data-bs-tooltip="tooltip" title="Draw a Line">
                                <i class="fas fa-plus-circle me-1"></i> Add
                            </button>
                            <button type="button" class="btn btn-info btn-sm" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv" data-bs-tooltip="tooltip" title="Upload CSV">
                                <i class="fas fa-upload me-1"></i> CSV
                            </button>
                            <button type="button" class="btn btn-warning btn-sm" id="comp_btn_visualise_coordinate" data-bs-tooltip="tooltip" title="Visualise Coordinate">
                                <i class="fas fa-eye me-1"></i> Visualise
                            </button>
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
                            <textarea class="form-control form-control-sm" rows="3" id="comp_bl_wkt_polygon" placeholder="POLYGON((...))"></textarea>
                            <div class="mt-2 d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm flex-fill" id="comp_btn_visualise_wkt" data-bs-tooltip="tooltip" title="Visualise Polygon(WKT)">
                                    <i class="fas fa-map me-1"></i> Visualise
                                </button>
                                <button type="button" class="btn btn-success btn-sm flex-fill" id="comp_btn_save_wkt" data-bs-tooltip="tooltip" title="Save Parcels">
                                    <i class="fas fa-save me-1"></i> Save
                                </button>
                            </div>
                        </div>

                        <!-- Quick Coordinate Search -->
                        <div class="card border-success mb-4">
                            <div class="card-header bg-success bg-opacity-10 border-success py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-search-location me-2"></i>Quick Search
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="row g-2 mb-2">
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm" id="comp_x_coordinate_mak" placeholder="Eastings">
                                    </div>
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm" id="comp_y_coordinate_mak" placeholder="Northings">
                                    </div>
                                    <div class="col-2">
                                        <button class="btn btn-primary btn-sm w-100" id="comp_btn_show_location" title="Show Location">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="row g-2">
                                    <div class="col-10">
                                        <input type="text" class="form-control form-control-sm" id="comp_search_by_text" placeholder="Search by Ref Number">
                                    </div>
                                    <div class="col-2">
                                        <button class="btn btn-info btn-sm w-100" id="comp_btn_search_by_reference_number" title="Search">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Multiple Parcels Table -->
                        <div class="mt-4">
                            <h6 class="fw-semibold mb-3 text-primary">
                                <i class="fas fa-copy me-2"></i>More Than One Overlay
                            </h6>
                            <div class="table-responsive">
                                <table class="table table-hover table-sm" id="comp_more_than_one_parcel_Table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Ref Number</th>
                                            <th>Locality</th>
                                            <th>Plotted By</th>
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
                            <i class="fas fa-map me-2"></i>Map Sample
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Map Toolbar -->
                        <div class="d-flex flex-wrap align-items-center gap-3 mb-4">
                            <!-- Drawing Mode -->
                            <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" name="drawingMode" id="draw" value="draw" checked>
                                <label class="btn btn-outline-primary btn-sm" for="draw">
                                    <i class="fas fa-pencil-alt me-1"></i> Draw
                                </label>
                                <input type="radio" class="btn-check" name="drawingMode" id="modify" value="modify">
                                <label class="btn btn-outline-warning btn-sm" for="modify">
                                    <i class="fas fa-edit me-1"></i> Modify
                                </label>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2 ms-auto">
                                <button class="btn btn-outline-primary btn-sm" id="comp_btnprintmap" title="Print Map">
                                    <i class="fas fa-print me-1"></i> Print
                                </button>
                                <button class="btn btn-outline-info btn-sm" id="comp_btn_visualise_search" title="Visualise Search">
                                    <i class="fas fa-search me-1"></i> Search
                                </button>
                                <button class="btn btn-outline-success btn-sm" id="comp_btngeneratesearchreport" title="Print Search Report">
                                    <i class="fas fa-file-alt me-1"></i> Report
                                </button>
                            </div>
                        </div>

                        <!-- Map Container -->
                        <div class="border rounded" style="height: 600px;">
                            <div id="lvdc-map" class="h-100 w-100"></div>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i> Plottings
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



<!-- Modal 1: LVD Compensation Claim -->
<div class="modal fade effect-scale modal-blur" tabindex="-1" 
id="compparcelinformation" tabindex="-1" aria-labelledby="compparcelinformationLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-semibold" id="compparcelinformationLabel">
                    <i class="fas fa-file-invoice me-2"></i>LVD Compensation Claim
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form method="POST" action="Maps" target="_blank" id="downloadForm">
                    <input type="hidden" name="cc_id" id="cc_id">
                    
                    <div class="row g-3">
                        <!-- Row 1: Claim No & Claimant -->
                        <div class="col-md-6">
                            <label for="cc_claim_no" class="form-label fw-semibold">Claim No</label>
                            <input class="form-control" type="text" placeholder="Enter Claim No" id="cc_claim_no">
                        </div>
                        <div class="col-md-6">
                            <label for="cc_claimant" class="form-label fw-semibold">Claimant</label>
                            <input class="form-control" type="text" placeholder="Enter Claimant Name" id="cc_claimant">
                        </div>
                        
                        <!-- Row 2: File No & Plan No -->
                        <div class="col-md-6">
                            <label for="cc_file_no" class="form-label fw-semibold">File No</label>
                            <input class="form-control" type="text" placeholder="Enter File No" id="cc_file_no">
                        </div>
                        <div class="col-md-6">
                            <label for="cc_plan_no" class="form-label fw-semibold">Plan No</label>
                            <input class="form-control" type="text" placeholder="Enter Plan No" id="cc_plan_no">
                        </div>
                        
                        <!-- Row 3: Locality & Land Size -->
                        <div class="col-md-6">
                            <label for="cc_locality" class="form-label fw-semibold">Locality</label>
                            <input class="form-control" type="text" placeholder="Enter Locality" id="cc_locality">
                        </div>
                        <div class="col-md-6">
                            <label for="cc_land_size" class="form-label fw-semibold">Land Size</label>
                            <input class="form-control" type="text" placeholder="Enter Land Size" id="cc_land_size">
                        </div>
                        
                        <!-- Row 4: Remarks -->
                        <div class="col-12">
                            <label for="cc_remarks" class="form-label fw-semibold">Remarks</label>
                            <textarea class="form-control" rows="3" placeholder="Enter Remarks" id="cc_remarks"></textarea>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>
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
