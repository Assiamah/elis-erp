<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">PVLMD Map Plottings</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Manage and plot PVLMD noted proposal parcels</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">PVLMD Plottings</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Maps</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
<input type="hidden" id="regions_polygon" value="${regions_polygon}">
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
                        <!-- Action Buttons -->
                        <div class="btn-group w-100 mb-4">
                            <button type="button" class="btn btn-primary btn-sm" id="pvlmd_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot" data-bs-tooltip="tooltip" title="Add Coordinate">
                                <i class="fas fa-plus-circle me-1"></i> Add
                            </button>
                            <button type="button" class="btn btn-info btn-sm" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv" data-bs-tooltip="tooltip" title="Upload CSV">
                                <i class="fas fa-upload me-1"></i> CSV
                            </button>
                            <button type="button" class="btn btn-warning btn-sm" id="pvlmd_btn_visualise_coordinate" data-bs-tooltip="tooltip" title="Visualise Coordinate">
                                <i class="fas fa-eye me-1"></i> Visualise
                            </button>
                            <!-- <button type="button" class="btn btn-success btn-sm" id="pvlmd_btn_save_wkt" data-bs-tooltip="tooltip" title="Save Parcels">
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
                            <textarea class="form-control form-control-sm mb-2" rows="3" id="pvlmd_bl_wkt_polygon" placeholder="POLYGON((...))"></textarea>
                            <button type="button" class="btn btn-outline-primary btn-sm w-100" id="pvlmd_btn_visualise_wkt" data-bs-tooltip="tooltip" title="Visualise Polygon">
                                <i class="fas fa-map me-1"></i> Visualise Polygon
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
                                        <input class="form-control form-control-sm" id="pvlmd_search_by_text" name="pvlmd_search_by_text" type="text" placeholder="Search by Ref Number" required>
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

                        <input id="pvlmd_btn_search_by_transaction_reference_number" type="hidden">

                        <!-- Scanned Maps Section -->
                        <div class="card border-warning mb-4">
                            <div class="card-header bg-warning bg-opacity-10 border-warning py-2">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-layer-group me-2"></i>Scanned Maps
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="mb-3">
                                    <select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
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
                                <i class="fas fa-copy me-2"></i>More Than One Overlay
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
                                <input type="radio" class="btn-check" id="draw" name="interaction_type" value="draw" checked>
                                <label class="btn btn-outline-primary btn-sm" for="draw">
                                    <i class="fas fa-pencil-alt me-1"></i> Draw
                                </label>
                                <input type="radio" class="btn-check" id="modify" name="interaction_type" value="modify">
                                <label class="btn btn-outline-warning btn-sm" for="modify">
                                    <i class="fas fa-edit me-1"></i> Modify
                                </label>
                            </div>

                            <!-- Scale Controls -->
                            <div class="d-flex align-items-center gap-2">
                                <span class="fw-semibold text-muted">Scale:</span>
                                <input class="form-control form-control-sm" id="pvlmd_scale_value_e" name="pvlmd_scale_value_e" type="text" style="width: 90px;">
                                <select name="pvlmd_scale_value" id="pvlmd_scale_value" class="form-select form-select-sm" style="width: 120px;">
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
                                    <input class="form-check-input" type="checkbox" checked="checked" id="pvlmd_lockmapscale">
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
                                <button type="button" class="btn btn-outline-success btn-sm" id="pvlmd_btn_download_geojson" data-bs-tooltip="tooltip" title="GeoJSON">
                                    <i class="fas fa-download me-1"></i> GeoJSON
                                </button>
                            </div>
                        </div>

                        <!-- Map Container -->
                        <div class="border rounded" style="height: 600px;">
                            <div id="pvlmd-map" class="h-100 w-100"></div>
                        </div>

                        <form action="${pageContext.request.contextPath}/#" method="post" target="_blank"></form>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i> PVLMD noted proposal map plotting
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

<jsp:include page="pvlmd_maps_modals.jsp"></jsp:include>

<!-- Bootstrap 5 JS Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-tooltip="tooltip"]'));
        tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>

<script src="${pageContext.request.contextPath}/js-pages/gated_workflow.js"></script>

<script src="${pageContext.request.contextPath}/js-pages/js-map/pvlmd_spatial.js"></script>
