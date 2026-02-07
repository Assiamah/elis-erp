<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Page Header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-20 mb-0 text-primary">
                    <i class="fas fa-map-marked-alt me-2"></i>SMD Plottings
                </h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-decoration-none">Dashboard</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Maps</li>
                </ol>
            </div>
        </div>

        <div class="row">
            <!-- Left Sidebar - Control Panel -->
            <div class="col-lg-4 col-xl-3">
                <div class="card shadow-lg border-0 mb-4">
                    <div class="card-header bg-gradient-primary text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-sliders-h me-2"></i>Control Panel
                        </h5>
                    </div>
                    <div class="card-body">

                        <!-- Action Buttons -->
                        <div class="d-flex flex-wrap gap-2 mb-4">
                            <button type="button" class="btn btn-primary btn-sm" id="smd_btn_add_coordinate"
                                    data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot"
                                    data-bs-tooltip="tooltip" title="Draw a Line / Add Coordinate">
                                <i class="fas fa-plus-circle me-1"></i> Add
                            </button>

                            <button type="button" class="btn btn-info btn-sm" id="lrd_btn_add_coordinate_by_csv"
                                    data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv"
                                    data-bs-tooltip="tooltip" title="Upload CSV">
                                <i class="fas fa-upload me-1"></i> CSV
                            </button>

                            <button type="button" class="btn btn-warning btn-sm" id="smd_btn_visualise_coordinate"
                                    data-bs-tooltip="tooltip" title="Visualise Coordinate">
                                <i class="fas fa-eye me-1"></i> Visualise
                            </button>

                            <button type="button" class="btn btn-success btn-sm" id="smd_btn_save_wkt"
                                    data-bs-tooltip="tooltip" title="Save Parcels">
                                <i class="fas fa-save me-1"></i> Save
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
                                            <th class="text-center">Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- WKT Polygon -->
                        <div class="mb-4">
                            <h6 class="fw-semibold mb-2 text-primary">
                                <i class="fas fa-draw-polygon me-2"></i>WKT Polygon
                            </h6>
                            <textarea class="form-control form-control-sm" rows="3" id="smd_bl_wkt_polygon"
                                      placeholder="POLYGON((x1 y1, x2 y2, ...))"></textarea>
                        </div>

                        <!-- Quick Coordinate / Location Search -->
                        <div class="card border-primary mb-4">
                            <div class="card-header bg-primary bg-opacity-10 border-primary py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-search-location me-2"></i>Quick Location
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="row g-2 mb-3">
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm"
                                               id="smd_x_coordinate_mak" placeholder="Eastings (X)">
                                    </div>
                                    <div class="col-5">
                                        <input type="text" class="form-control form-control-sm"
                                               id="smd_y_coordinate_mak" placeholder="Northings (Y)">
                                    </div>
                                    <div class="col-2">
                                        <button class="btn btn-primary btn-sm w-100" id="smd_btn_show_location"
                                                title="Show Location">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button class="btn btn-info btn-sm flex-fill" id="smd_btn_load_for_scanned_maps_by_point">
                                        <i class="fas fa-check-circle me-1"></i> Search Scanned Map
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Search by Reference Number -->
                        <div class="card border-info mb-4">
                            <div class="card-header bg-info bg-opacity-10 border-info py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-search me-2"></i>Search by Ref. Number
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="input-group input-group-sm">
                                    <input type="text" class="form-control" id="smd_search_by_text"
                                           placeholder="Enter Reference Number" required>
                                    <button class="btn btn-info" type="button" id="smd_btn_search_by_reference_number">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Scanned Maps -->
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
                                    <button class="btn btn-warning btn-sm flex-fill" id="smd_btn_search_for_scanned_maps">
                                        <i class="fas fa-search me-1"></i> Search
                                    </button>
                                    <button class="btn btn-success btn-sm flex-fill" id="smd_btn_load_for_scanned_maps">
                                        <i class="fas fa-check-circle me-1"></i> Load
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Multiple Parcels -->
                        <div class="mt-3">
                            <h6 class="fw-semibold mb-3 text-primary">
                                <i class="fas fa-copy me-2"></i>Multiple Parcel Overlays
                            </h6>
                            <div class="table-responsive">
                                <table class="table table-hover table-sm" id="smd_more_than_one_parcel_Table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Ref Number</th>
                                            <th>Locality</th>
                                            <th>Plotted By</th>
                                            <th class="text-center">Details</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Main Map Area -->
            <div class="col-lg-8 col-xl-9">
                <div class="card shadow-lg border-0 mb-4">
                    <div class="card-header bg-gradient-success text-white border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-map me-2"></i>Map Viewer
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

                            <div class="d-flex align-items-center gap-2">
                                <span class="fw-semibold text-muted">Scale:</span>
                                <select class="form-select form-select-sm" style="width: 120px;" id="smd_scale_value">
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
                                    <input class="form-check-input" type="checkbox" id="smd_lockmapscale" checked>
                                    <label class="form-check-label small" for="smd_lockmapscale">Lock</label>
                                </div>
                                <button class="btn btn-primary btn-sm" id="smd_btn_scale_zoom" title="Zoom to Scale">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>

                            <div class="d-flex gap-2 ms-auto">
                                <button class="btn btn-outline-primary btn-sm" id="smd_btn_visualise_wkt" title="Visualise WKT">
                                    <i class="fas fa-map me-1"></i> View WKT
                                </button>
                                <button class="btn btn-outline-primary btn-sm" id="smd_btn_visualise_search" title="Visualise Search">
                                    <i class="fas fa-search me-1"></i> Search
                                </button>
                                <button class="btn btn-outline-danger btn-sm" id="smd_btnprintmap" title="Print Map">
                                    <i class="fas fa-print me-1"></i> Print
                                </button>
                                <button class="btn btn-outline-secondary btn-sm" id="smd_btngeneratesearchreport" title="Print Report">
                                    <i class="fas fa-file-alt me-1"></i> Report
                                </button>
                            </div>
                        </div>

                        <!-- Map Container -->
                        <div class="border rounded" style="height: 620px;">
                            <div id="smd-map" class="h-100 w-100"></div>
                        </div>
                    </div>

                    <div class="card-footer bg-transparent border-0 pt-3">
                        <div class="d-flex justify-content-between align-items-center text-muted small">
                            <div>
                                <i class="fas fa-info-circle me-1"></i> SMD Plotting Interface
                            </div>
                            <div>
                                <i class="fas fa-sync-alt me-1"></i> Last updated: Just now
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Initialize all tooltips
        const tooltipTriggerList = document.querySelectorAll('[data-bs-tooltip="tooltip"]');
        [...tooltipTriggerList].forEach(el => new bootstrap.Tooltip(el));
    });
</script>