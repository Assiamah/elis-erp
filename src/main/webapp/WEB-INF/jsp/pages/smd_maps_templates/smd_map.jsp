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




   <style>
        /* Custom enhancements */
        body {
            background-color: #f4f7fc;
            font-family: 'Segoe UI', Roboto, system-ui, -apple-system, 'Helvetica Neue', sans-serif;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
        }
        .card:hover {
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.08);
        }
        .card-header {
            background: rgba(0, 123, 255, 0.03);
            border-bottom: 1px solid rgba(0,0,0,0.05);
            font-weight: 600;
            letter-spacing: -0.2px;
            border-radius: 1rem 1rem 0 0 !important;
            padding: 1rem 1.25rem;
        }
        .breadcrumb {
            background: transparent;
            padding: 0.75rem 0;
        }
        .btn-primary {
            background: #2c7da0;
            border-color: #2c7da0;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-primary:hover {
            background: #1f5e7e;
            border-color: #1a526f;
            transform: translateY(-1px);
        }
        .btn-outline-primary {
            border-radius: 0.5rem;
        }
        #smd-map {
            height: 500px;
            width: 100%;
            border-radius: 1rem;
            background: #e9ecef;
            z-index: 1;
            box-shadow: inset 0 0 0 1px rgba(0,0,0,0.05), 0 0.25rem 0.5rem rgba(0,0,0,0.1);
        }
        .table-responsive-custom {
            border-radius: 0.75rem;
            overflow-x: auto;
        }
        .table th {
            background-color: #eef2f7;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
        }
        .badge-coord {
            background-color: #e9ecef;
            color: #1e466e;
        }
        .form-control, .form-select {
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
            transition: 0.2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #2c7da0;
            box-shadow: 0 0 0 0.2rem rgba(44,125,160,0.2);
        }
        .btn-group-sm-custom {
            gap: 0.5rem;
        }
        footer.small {
            font-size: 0.75rem;
        }
        .radio-group-inline .form-check {
            margin-right: 1.5rem;
        }
        @media (max-width: 768px) {
            .btn-group.mr-2, .btn-group {
                flex-wrap: wrap;
                margin-bottom: 0.5rem;
            }
            .col-lg-3, .col-lg-9 {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid py-3">
    <!-- Enhanced Breadcrumbs with modern look -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#" class="text-decoration-none"><i class="fas fa-draw-polygon me-1"></i>SMD Plottings</a></li>
            <li class="breadcrumb-item active" aria-current="page">Interactive Maps</li>
        </ol>
    </nav>

    <div class="row g-4">
        <!-- LEFT SIDEBAR: Tools & Data (Col-lg-3) -->
        <div class="col-lg-3">
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <i class="fas fa-map-marked-alt me-2 text-primary"></i> Map Plotting Tools
                </div>
                <div class="card-body">
                    <!-- Action buttons group -->
                    <div class="d-flex flex-wrap gap-2 mb-4">
                        <button type="button" class="btn btn-primary" id="smd_btn_add_coordinate" data-bs-toggle="modal" data-bs-target="#addcoordinatetoplot" title="Draw a Line / Add Point">
                            <i class="fas fa-plus-circle"></i> Add Coord
                        </button>
                        <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate_by_csv" data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv" title="Upload CSV">
                            <i class="fas fa-upload"></i> CSV
                        </button>
                        <button type="button" class="btn btn-primary" id="smd_btn_visualise_coordinate" title="Visualise Coordinate">
                            <i class="fas fa-eye"></i> Visualise
                        </button>
                    </div>

                    <!-- Coordinates List Table (Dynamic) -->
                    <label class="fw-semibold mb-2"><i class="fas fa-list me-1"></i>Coordinate List</label>
                    <div class="table-responsive small mb-3" style="max-height: 220px; overflow-y: auto;">
                        <table class="table table-sm table-bordered table-hover" id="coordinatelis_Table">
                            <thead class="table-light">
                                <tr><th>Name</th><th>Easting (X)</th><th>Northing (Y)</th><th style="width: 50px">Action</th></tr>
                            </thead>
                            <tbody id="coordinateTableBody">
                                <!-- dynamic rows -->
                                <tr><td colspan="4" class="text-muted text-center">No coordinates added</td></tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- WKT Polygon Section -->
                    <div class="mb-3">
                        <label for="smd_bl_wkt_polygon" class="form-label fw-semibold"><i class="fas fa-shield-alt"></i> WKT Polygon</label>
                        <textarea class="form-control" rows="2" id="smd_bl_wkt_polygon" placeholder="POLYGON((...))"></textarea>
                        <div class="d-flex gap-2 mt-2">
                            <button type="button" class="btn btn-sm btn-outline-primary" id="smd_btn_visualise_wkt"><i class="fas fa-map"></i> Visualise Polygon</button>
                            <button type="button" class="btn btn-sm btn-primary" id="smd_btn_save_wkt"><i class="fas fa-save"></i> Save Parcels</button>
                        </div>
                    </div>

                    <!-- Zoom to Coordinate -->
                    <div class="mb-3">
                        <label class="fw-semibold mb-1">Zoom to Location</label>
                        <div class="row g-2">
                            <div class="col-5"><input type="text" class="form-control form-control-sm" id="smd_x_coordinate_mak" placeholder="Eastings"></div>
                            <div class="col-5"><input type="text" class="form-control form-control-sm" id="smd_y_coordinate_mak" placeholder="Northings"></div>
                            <div class="col-2"><button class="btn btn-sm btn-primary w-100" id="smd_btn_show_location"><i class="fas fa-map-marker-alt"></i></button></div>
                        </div>
                        <button class="btn btn-sm btn-secondary w-100 mt-2" id="smd_btn_load_for_scanned_maps_by_point"><i class="fas fa-check-circle"></i> Search Scanned Map</button>
                    </div>

                    <!-- Search by Reference -->
                    <div class="mb-3">
                        <label class="fw-semibold">Ref Number Search</label>
                        <div class="input-group input-group-sm">
                            <input type="text" class="form-control" id="smd_search_by_text" placeholder="Certificate / Ref Number">
                            <button class="btn btn-primary" type="button" id="smd_btn_search_by_reference_number"><i class="fas fa-search"></i> Go</button>
                        </div>
                    </div>

                    <!-- Scanned Maps Dropdown + actions -->
                    <div class="mb-3">
                        <label class="fw-semibold">Scanned Images</label>
                        <select class="form-select form-select-sm mb-2" id="geoserverscannedimages_list">
                            <option value="-1">No Scanned Image</option>
                        </select>
                        <div class="d-flex gap-2">
                            <button class="btn btn-sm btn-outline-secondary" id="smd_btn_search_for_scanned_maps"><i class="fas fa-search"></i> Search</button>
                            <button class="btn btn-sm btn-primary" id="smd_btn_load_for_scanned_maps"><i class="fas fa-check-circle"></i> Load</button>
                        </div>
                    </div>

                    <!-- More than one overlay table -->
                    <div class="mt-3">
                        <h6 class="fw-semibold"><i class="fas fa-layer-group"></i> Overlays</h6>
                        <div class="table-responsive small" style="max-height: 180px;">
                            <table class="table table-sm table-bordered" id="smd_more_than_one_parcel_Table">
                                <thead class="table-light"><tr><th>Ref Number</th><th>Locality</th><th>Plotted By</th><th>Details</th></tr></thead>
                                <tbody><tr><td colspan="4" class="text-muted text-center">No overlays</td></tr></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- RIGHT SIDEBAR: Map & Controls (Col-lg-9) -->
        <div class="col-lg-9">
            <div class="card mb-4">
                <div class="card-header bg-white d-flex flex-wrap justify-content-between align-items-center">
                    <span><i class="fas fa-globe-americas me-2 text-primary"></i>Interactive Map Canvas</span>
                    <span class="badge bg-light text-dark">Spatial Data Platform</span>
                </div>
                <div class="card-body">
                    <!-- Map interaction modes + action row -->
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-3">
                        <div class="d-flex gap-4 radio-group-inline">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="interaction_type" id="draw" value="draw" checked>
                                <label class="form-check-label" for="draw"><i class="fas fa-pencil-ruler"></i> Draw</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="interaction_type" id="modify" value="modify">
                                <label class="form-check-label" for="modify"><i class="fas fa-edit"></i> Modify</label>
                            </div>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <button class="btn btn-sm btn-outline-secondary" id="smd_btnprintmap"><i class="fas fa-print"></i> Print Map</button>
                            <button class="btn btn-sm btn-outline-primary" id="smd_btn_visualise_search"><i class="fas fa-search-location"></i> Visualise Search</button>
                            <button class="btn btn-sm btn-outline-info" id="smd_btngeneratesearchreport"><i class="fas fa-file-alt"></i> Search Report</button>
                        </div>
                    </div>

                    <!-- Scale & Zoom controls -->
                    <div class="row g-2 mb-3 align-items-end">
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label small">Scale Value</label>
                            <div class="input-group input-group-sm">
                                <input type="text" class="form-control" id="smd_scale_value_e" placeholder="Custom scale">
                                <select class="form-select" id="smd_scale_value" style="max-width: 100px;">
                                    <option value="500">500</option><option value="1107">1107</option><option value="1250">1250</option>
                                    <option value="2500">2500</option><option value="2140">2140</option><option value="2670">2670</option>
                                    <option value="5000">5000</option><option value="10000">10000</option><option value="20000">20000</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="form-check mt-2">
                                <input class="form-check-input" type="checkbox" id="smd_lockmapscale" checked>
                                <label class="form-check-label small" for="smd_lockmapscale">Lock map scale</label>
                            </div>
                            <button class="btn btn-sm btn-primary w-100 mt-1" id="smd_btn_scale_zoom"><i class="fas fa-search-plus"></i> Zoom to Scale</button>
                        </div>
                        <div class="col-md-4 d-flex justify-content-md-end mt-2 mt-md-0">
                            <small class="text-muted"><i class="fas fa-info-circle"></i> Use draw/modify tools on map</small>
                        </div>
                    </div>

                    <!-- The Map Container -->
                    <div id="smd-map" style="height: 480px;"></div>
                    <div class="card-footer bg-transparent border-0 text-muted small text-center pt-3">Plottings &copy; SMD - Real-time coordinate mapping</div>
                </div>
            </div>
        </div>
    </div>
</div>



 
