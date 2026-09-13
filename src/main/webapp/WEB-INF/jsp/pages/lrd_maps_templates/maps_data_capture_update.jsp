<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>

<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>


<div class="main-content app-content">

    <div class="container-fluid page-container">

        <!-- ========================================================= -->
        <!-- PAGE HEADER                                               -->
        <!-- ========================================================= -->
        <div class="page-header-breadcrumb mb-4">

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">

                <!-- LEFT -->
                <div>

                    <h1 class="page-title fw-semibold fs-20 mb-1">
                        LRD Map Plottings
                    </h1>

                    <p class="text-muted mb-0">
                        <i class="ri-information-line me-1"></i>
                        Manage and plot LRD parcels and transactions
                    </p>

                </div>


                <!-- RIGHT -->
                <div class="text-end">

                    <ol class="breadcrumb justify-content-end mb-2">

                        <li class="breadcrumb-item">

                            <a href="javascript:void(0);"
                               class="text-decoration-none">
                                ELIS
                            </a>

                        </li>


                        <li class="breadcrumb-item">

                            <a href="javascript:void(0);"
                               class="text-decoration-none">
                                LRD Map Plotting
                            </a>

                        </li>


                        <li class="breadcrumb-item active"
                            aria-current="page">
                            Maps
                        </li>

                    </ol>


                    <span class="badge bg-primary me-2 px-3 py-2">

                        <i class="ri-map-pin-line me-1"></i>

                        Parcels:

                        <strong>
                            <c:out value="${parcel_count}" default="0" />
                        </strong>

                    </span>


                    <span class="badge bg-success px-3 py-2">

                        <i class="ri-ruler-2-line me-1"></i>

                        Acreage:

                        <strong>
                            <c:out value="${total_acreage}" default="0" />
                        </strong>

                    </span>

                </div>

            </div>

        </div>
        <!-- END PAGE HEADER -->


        <div class="row">

            <!-- ===================================================== -->
            <!-- LEFT SIDEBAR                                         -->
            <!-- ===================================================== -->
            <div class="col-lg-4 col-xl-3">

                <div class="card shadow-sm border-0 mb-4">


                    <!-- ================================================= -->
                    <!-- CONTROL PANEL HEADER                              -->
                    <!-- ================================================= -->
                    <div class="card-header bg-gradient-primary text-white border-0 py-3">

                        <h5 class="mb-0 fw-semibold">

                            <i class="fas fa-sliders-h me-2"></i>
                            Control Panel

                        </h5>

                    </div>


                    <div class="card-body">


                        <!-- ================================================= -->
                        <!-- MAIN ACTION BUTTONS                               -->
                        <!-- ================================================= -->
                        <div class="btn-group w-100 mb-4"
                             role="group"
                             aria-label="Coordinate actions">


                            <!-- ADD COORDINATE -->
                            <button
                                type="button"
                                class="btn btn-primary btn-sm"
                                id="lc_btn_add_coordinate"
                                data-bs-toggle="modal"
                                data-bs-target="#addcoordinatetoplot"
                                title="Add Coordinate">

                                <i class="fas fa-plus-circle me-1"></i>
                                Add

                            </button>


                            <!-- UPLOAD CSV -->
                            <button
                                type="button"
                                class="btn btn-info btn-sm"
                                id="lrd_btn_add_coordinate_by_csv"
                                data-bs-toggle="modal"
                                data-bs-target="#uploadcoordiantecsv"
                                title="Upload CSV">

                                <i class="fas fa-upload me-1"></i>
                                CSV

                            </button>


                            <!-- VISUALISE -->
                            <button
                                type="button"
                                class="btn btn-warning btn-sm"
                                id="lrd_btn_visualise_coordinate"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                title="Visualise Polygon">

                                <i class="fas fa-eye me-1"></i>
                                Visualise

                            </button>

                        </div>


                        <!-- ================================================= -->
                        <!-- COORDINATE LIST                                   -->
                        <!-- ================================================= -->
                        <div class="mb-4">

                            <h6 class="fw-semibold mb-3 text-primary">

                                <i class="fas fa-list-ol me-2"></i>
                                Coordinate List

                            </h6>


                            <div class="table-responsive">

                                <table
                                    class="table table-hover table-sm align-middle"
                                    id="coordinatelis_Table">

                                    <thead class="table-light">

                                        <tr>

                                            <th>
                                                Name
                                            </th>

                                            <th>
                                                X
                                            </th>

                                            <th>
                                                Y
                                            </th>

                                            <th class="text-center">
                                                Action
                                            </th>

                                        </tr>

                                    </thead>


                                    <tbody>

                                        <!--
                                            Coordinate rows are inserted
                                            dynamically by JavaScript.
                                        -->

                                    </tbody>

                                </table>

                            </div>

                        </div>


                        <!-- ================================================= -->
                        <!-- WKT POLYGON                                       -->
                        <!-- ================================================= -->
                        <div class="mb-4">

                            <h6 class="fw-semibold mb-2 text-primary">

                                <i class="fas fa-draw-polygon me-2"></i>
                                WKT Polygon

                            </h6>


                            <textarea
                                class="form-control form-control-sm"
                                rows="4"
                                id="lrd_txt_wkt_polygon"
                                placeholder="POLYGON((x1 y1, x2 y2, x3 y3, x1 y1))"></textarea>


                            <button
                                type="button"
                                class="btn btn-outline-primary btn-sm w-100 mt-2"
                                id="lrd_btn_visualise_wkt"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                title="Visualise Polygon">

                                <i class="fas fa-map me-1"></i>
                                Visualise Polygon

                            </button>


                            <button
                                type="button"
                                class="btn btn-warning btn-sm w-100 mt-2 d-none"
                                id="lrd_btn_request_add_existing_parcel"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                title="Request For Add Existing Parcel">

                                <i class="fas fa-paper-plane me-1"></i>
                                Request For Add Existing Parcel

                            </button>

                        </div>


                        <!-- ================================================= -->
                        <!-- QUICK COORDINATE SEARCH                           -->
                        <!-- ================================================= -->
                        <div class="card border-success mb-4">

                            <div class="card-header bg-success bg-opacity-10 border-success py-2">

                                <h6 class="mb-0 fw-semibold">

                                    <i class="fas fa-search-location me-2"></i>
                                    Quick Coordinate Search

                                </h6>

                            </div>


                            <div class="card-body p-3">


                                <!-- ========================================= -->
                                <!-- X / Y COORDINATE SEARCH                  -->
                                <!-- ========================================= -->
                                <div class="row g-2 mb-2">

                                    <div class="col-5">

                                        <input
                                            type="text"
                                            class="form-control form-control-sm"
                                            id="lrd_x_coordinate"
                                            autocomplete="off"
                                            inputmode="decimal"
                                            placeholder="X Coordinate">

                                    </div>


                                    <div class="col-5">

                                        <input
                                            type="text"
                                            class="form-control form-control-sm"
                                            id="lrd_y_coordinate"
                                            autocomplete="off"
                                            inputmode="decimal"
                                            placeholder="Y Coordinate">

                                    </div>


                                    <div class="col-2">

                                        <div class="d-grid gap-1">

                                            <button
                                                type="button"
                                                class="btn btn-primary btn-sm"
                                                id="lrd_btn_show_location"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="left"
                                                title="Show Location">

                                                <i class="fas fa-map-marker-alt"></i>

                                            </button>


                                            <button
                                                type="button"
                                                class="btn btn-outline-primary btn-sm"
                                                id="lrd_btn_load_for_scanned_maps_by_point"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="left"
                                                title="Load Scanned Maps">

                                                <i class="fas fa-map"></i>

                                            </button>

                                        </div>

                                    </div>

                                </div>


                                <!-- ========================================= -->
                                <!-- CERTIFICATE / REFERENCE SEARCH           -->
                                <!-- ========================================= -->
                                <div class="row g-2">

                                    <div class="col-10">

                                        <input
                                            type="text"
                                            class="form-control form-control-sm"
                                            id="lrd_search_by_text"
                                            autocomplete="off"
                                            placeholder="Search by Certificate/Ref Number">

                                    </div>


                                    <div class="col-2">

                                        <button
                                            type="button"
                                            class="btn btn-info btn-sm w-100"
                                            id="lrd_btn_search_by_certificate_number"
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="left"
                                            title="Search Certificate or Reference Number">

                                            <i class="fas fa-search"></i>

                                        </button>

                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- ================================================= -->
                        <!-- SCANNED MAPS                                      -->
                        <!-- ================================================= -->
                        <div class="card border-warning mb-4">

                            <div class="card-header bg-warning bg-opacity-10 border-warning py-2">

                                <h6 class="mb-0 fw-semibold">

                                    <i class="fas fa-layer-group me-2"></i>
                                    Scanned Maps

                                </h6>

                            </div>


                            <div class="card-body p-3">

                                <div class="mb-3">

                                    <label
                                        for="geoserverscannedimages_list"
                                        class="form-label small fw-semibold">

                                        Scanned Map Sheet

                                    </label>


                                    <select
                                        class="form-select form-select-sm"
                                        id="geoserverscannedimages_list"
                                        name="geoserverscannedimages_list">

                                        <option value="-1">
                                            Select Scanned Image
                                        </option>

                                    </select>

                                </div>


                                <div class="d-flex gap-2">

                                    <button
                                        type="button"
                                        class="btn btn-warning btn-sm flex-fill"
                                        id="lrd_btn_search_for_scanned_maps"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Search for related scanned maps">

                                        <i class="fas fa-search me-1"></i>
                                        Search

                                    </button>


                                    <button
                                        type="button"
                                        class="btn btn-success btn-sm flex-fill"
                                        id="lrd_btn_load_for_scanned_maps"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Load selected scanned map">

                                        <i class="fas fa-check-circle me-1"></i>
                                        Load

                                    </button>

                                </div>

                            </div>

                        </div>


                        <!-- ================================================= -->
                        <!-- ADVANCED SCANNED MAP SEARCH                       -->
                        <!-- ================================================= -->
                        <div class="card border-info mb-4">

                            <div class="card-header bg-info bg-opacity-10 border-info py-2">

                                <h6 class="mb-0 fw-semibold">

                                    <i class="fas fa-search-plus me-2"></i>
                                    Advanced Search

                                </h6>

                            </div>


                            <div class="card-body p-3">

                                <div class="mb-3">

                                    <label
                                        for="scannned_map_to_search_for"
                                        class="form-label small fw-semibold">

                                        Map Name

                                    </label>


                                    <input
                                        class="form-control form-control-sm"
                                        type="text"
                                        id="scannned_map_to_search_for"
                                        autocomplete="off"
                                        placeholder="Enter Map name"
                                        list="listofscannnedmaptosearchfor">


                                    <datalist id="listofscannnedmaptosearchfor">
                                    </datalist>

                                </div>


                                <div class="d-flex gap-2">

                                    <button
                                        type="button"
                                        class="btn btn-info btn-sm flex-fill"
                                        id="lrd_btn_search_for_scanned_maps_all"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Find scanned maps">

                                        <i class="fas fa-search me-1"></i>
                                        Find

                                    </button>


                                    <button
                                        type="button"
                                        class="btn btn-primary btn-sm flex-fill"
                                        id="lrd_btn_load_for_scanned_maps_all"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Load all matching scanned maps">

                                        <i class="fas fa-layer-group me-1"></i>
                                        Load All

                                    </button>

                                </div>

                            </div>

                        </div>


                        <!-- ================================================= -->
                        <!-- MULTIPLE PARCEL OVERLAYS                          -->
                        <!-- ================================================= -->
                        <div class="mt-4">

                            <h6 class="fw-semibold mb-3 text-primary">

                                <i class="fas fa-copy me-2"></i>
                                Multiple Parcel Overlays

                            </h6>


                            <div class="table-responsive">

                                <table
                                    class="table table-hover table-sm align-middle"
                                    id="lrd_more_than_one_parcel_Table">

                                    <thead class="table-light">

                                        <tr>

                                            <th>
                                                Reference Number
                                            </th>

                                            <th>
                                                Locality
                                            </th>

                                            <th>
                                                Remarks
                                            </th>

                                            <th class="text-center">
                                                Details
                                            </th>

                                        </tr>

                                    </thead>


                                    <tbody>

                                        <!--
                                            Multiple parcel overlay rows
                                            are inserted dynamically.
                                        -->

                                    </tbody>

                                </table>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
            <!-- END LEFT SIDEBAR -->


            <!-- ===================================================== -->
            <!-- MAIN MAP AREA                                        -->
            <!-- ===================================================== -->
            <div class="col-lg-8 col-xl-9">

                <div class="card shadow-sm border-0 mb-4">


                    <!-- ================================================= -->
                    <!-- MAP HEADER                                        -->
                    <!-- ================================================= -->
                    <div class="card-header bg-gradient-success text-white border-0 py-3">

                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">

                            <h5 class="mb-0 fw-semibold">

                                <i class="fas fa-map me-2"></i>
                                Interactive Map Viewer

                            </h5>


                            <div class="small">

                                <i class="fas fa-layer-group me-1"></i>

                                Parcels:

                                <strong>
                                    <c:out value="${parcel_count}" default="0" />
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="card-body">


                        <!-- ================================================= -->
                        <!-- MAP TOOLBAR                                       -->
                        <!-- ================================================= -->
                        <div class="d-flex flex-wrap align-items-center gap-3 mb-4">


                            <!-- ================================================= -->
                            <!-- DRAWING TOOLS                                      -->
                            <!-- ================================================= -->
                            <div class="btn-group"
                                 role="group"
                                 aria-label="LRD drawing tools">


                                <button
                                    type="button"
                                    class="btn btn-outline-primary btn-sm"
                                    id="lrd_btn_draw_polygon"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Draw Polygon">

                                    <i class="fas fa-draw-polygon me-1"></i>
                                    Draw

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-warning btn-sm"
                                    id="lrd_btn_modify_polygon"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Modify Shape">

                                    <i class="fas fa-edit me-1"></i>
                                    Modify

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-danger btn-sm"
                                    id="lrd_btn_delete_polygon"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Delete Selected Polygon">

                                    <i class="fas fa-trash me-1"></i>
                                    Delete

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-success btn-sm"
                                    id="lrd_btn_measure_distance"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Measure Distance">

                                    <i class="fas fa-ruler me-1"></i>
                                    Measure

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-info btn-sm"
                                    id="lrd_btn_measure_area"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Measure Area">

                                    <i class="fas fa-ruler-combined me-1"></i>
                                    Area

                                </button>

                            </div>


                            <!-- ================================================= -->
                            <!-- SCALE CONTROLS                                    -->
                            <!-- ================================================= -->
                            <div class="d-flex flex-wrap align-items-center gap-2">

                                <span class="fw-semibold text-muted small">
                                    Scale:
                                </span>


                                <select
                                    class="form-select form-select-sm"
                                    style="width: 125px;"
                                    id="lrd_scale_value"
                                    name="lrd_scale_value">

                                    <option value="500">
                                        1:500
                                    </option>

                                    <option value="1107">
                                        1:1,107
                                    </option>

                                    <option value="1250">
                                        1:1,250
                                    </option>

                                    <option value="2140">
                                        1:2,140
                                    </option>

                                    <option value="2215">
                                        1:2,215
                                    </option>

                                    <option value="2500">
                                        1:2,500
                                    </option>

                                    <option value="2670">
                                        1:2,670
                                    </option>

                                    <option value="2825">
                                        1:2,825
                                    </option>

                                    <option value="5000">
                                        1:5,000
                                    </option>

                                    <option value="10000">
                                        1:10,000
                                    </option>

                                    <option value="15000">
                                        1:15,000
                                    </option>

                                    <option value="20000">
                                        1:20,000
                                    </option>

                                </select>


                                <div class="form-check mb-0">

                                    <input
                                        class="form-check-input"
                                        type="checkbox"
                                        id="lrd_lockmapscale"
                                        checked>


                                    <label
                                        class="form-check-label small"
                                        for="lrd_lockmapscale">

                                        Lock

                                    </label>

                                </div>


                                <button
                                    type="button"
                                    class="btn btn-primary btn-sm"
                                    id="lrd_btn_scale_zoom"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Zoom to Scale">

                                    <i class="fas fa-search"></i>

                                </button>

                            </div>


                            <!-- ================================================= -->
                            <!-- MAP ACTION BUTTONS                                -->
                            <!-- ================================================= -->
                            <div class="d-flex flex-wrap gap-2 ms-lg-auto">


                                <button
                                    type="button"
                                    class="btn btn-outline-danger btn-sm"
                                    id="lrd_btn_refresh_btn_wkt"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Refresh Map">

                                    <i class="fas fa-redo me-1"></i>
                                    Refresh

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-primary btn-sm"
                                    id="lrd_btn_print_map"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Print Map">

                                    <i class="fas fa-print me-1"></i>
                                    Print

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-secondary btn-sm"
                                    id="lrd_btn_clear_measurements"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Clear Measurements">

                                    <i class="fas fa-eraser me-1"></i>
                                    Clear

                                </button>

                            </div>

                        </div>


                        <!-- ================================================= -->
                        <!-- MAP CONTAINER                                     -->
                        <!-- ================================================= -->
                        <div
                            id="lrd-map-wrapper"
                            class="border rounded position-relative overflow-hidden"
                            style="
                                height: 600px;
                                min-height: 450px;
                                background-color: #f8f9fa;
                            ">

                            <div
                                id="lrd-map"
                                class="h-100 w-100">
                            </div>

                        </div>

                    </div>


                    <!-- ================================================= -->
                    <!-- MAP FOOTER                                        -->
                    <!-- ================================================= -->
                    <div class="card-footer bg-transparent border-0 pt-3">

                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">

                            <div class="text-muted small">

                                <i class="fas fa-info-circle me-1"></i>

                                Total Parcels:

                                <span class="fw-semibold">
                                    <c:out value="${parcel_count}" default="0" />
                                </span>

                            </div>


                            <div class="text-muted small">

                                <i class="fas fa-ruler-combined me-1"></i>

                                Total Acreage:

                                <span class="fw-semibold">
                                    <c:out value="${total_acreage}" default="0" />
                                </span>

                            </div>


                            <div class="text-muted small">

                                <i class="fas fa-sync-alt me-1"></i>

                                Last updated:

                                <span id="lrd_last_updated">
                                    Just now
                                </span>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
            <!-- END MAIN MAP AREA -->

        </div>

    </div>

</div>


<!-- ============================================================= -->
<!-- MODALS                                                        -->
<!-- ============================================================= -->

<jsp:include page="lrd_maps_modals.jsp" />


<!-- ============================================================= -->
<!-- PAGE INITIALISATION                                           -->
<!-- ============================================================= -->

<script>

(function () {

    "use strict";


    /**
     * Initialise Bootstrap tooltips.
     */
    function initialiseLrdTooltips() {

        if (typeof bootstrap === "undefined") {

            console.warn(
                "Bootstrap JavaScript is not loaded. " +
                "LRD tooltips cannot be initialised."
            );

            return;

        }


        var tooltipElements =
            document.querySelectorAll(
                '[data-bs-toggle="tooltip"]'
            );


        tooltipElements.forEach(function (element) {

            try {

                var existingTooltip =
                    bootstrap.Tooltip.getInstance(element);


                if (!existingTooltip) {

                    new bootstrap.Tooltip(element);

                }

            } catch (error) {

                console.error(
                    "Could not initialise Bootstrap tooltip:",
                    element,
                    error
                );

            }

        });

    }


    /**
     * Set the current updated time.
     */
    function updateLastUpdatedTime() {

        var element =
            document.getElementById(
                "lrd_last_updated"
            );


        if (!element) {

            return;

        }


        try {

            var now =
                new Date();


            element.textContent =
                now.toLocaleTimeString(
                    [],
                    {
                        hour: "2-digit",
                        minute: "2-digit"
                    }
                );

        } catch (error) {

            element.textContent =
                "Just now";

        }

    }


    /**
     * Try to force OpenLayers to recalculate
     * the map container size.
     *
     * This does not create a new map.
     */
    function refreshLrdMapSize() {

        window.setTimeout(function () {

            try {

                if (
                    typeof window.lrd_map !== "undefined" &&
                    window.lrd_map &&
                    typeof window.lrd_map.updateSize === "function"
                ) {

                    window.lrd_map.updateSize();

                    return;

                }


                if (
                    typeof window.lrdMap !== "undefined" &&
                    window.lrdMap &&
                    typeof window.lrdMap.updateSize === "function"
                ) {

                    window.lrdMap.updateSize();

                    return;

                }


                if (
                    typeof window.map !== "undefined" &&
                    window.map &&
                    typeof window.map.updateSize === "function"
                ) {

                    window.map.updateSize();

                }

            } catch (error) {

                console.warn(
                    "Unable to refresh LRD map size:",
                    error
                );

            }

        }, 300);

    }


    /**
     * Validate critical page elements.
     */
    function validateLrdPageElements() {

        var requiredElements = [

            "coordinatelis_Table",

            "lrd_txt_wkt_polygon",

            "lrd_x_coordinate",

            "lrd_y_coordinate",

            "lrd_search_by_text",

            "geoserverscannedimages_list",

            "lrd-map"

        ];


        requiredElements.forEach(function (id) {

            if (!document.getElementById(id)) {

                console.warn(
                    "LRD page element not found: #" + id
                );

            }

        });

    }


    /**
     * Main page initialisation.
     */
    function initialiseLrdPage() {

        validateLrdPageElements();

        initialiseLrdTooltips();

        updateLastUpdatedTime();

        refreshLrdMapSize();

    }


    /**
     * Handles both normal page loading
     * and JSP content inserted dynamically.
     */
    if (document.readyState === "loading") {

        document.addEventListener(
            "DOMContentLoaded",
            initialiseLrdPage
        );

    } else {

        initialiseLrdPage();

    }

})();

</script>


<!-- ============================================================= -->
<!-- APPLICATION JAVASCRIPT                                        -->
<!-- ============================================================= -->

<script
    src="${pageContext.request.contextPath}/js-pages/gated_workflow.js">
</script>