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

            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">

                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">
                        PVLMD Map Plottings
                    </h1>

                    <p class="text-muted small mb-0">
                        <i class="ri-information-line me-1"></i>
                        Manage and plot PVLMD noted proposal parcels
                    </p>
                </div>

                <ol class="breadcrumb mb-0">

                    <li class="breadcrumb-item">
                        <a href="javascript:void(0);" class="text-dark">
                            ELIS
                        </a>
                    </li>

                    <li class="breadcrumb-item">
                        <a href="javascript:void(0);" class="text-dark">
                            PVLMD Plottings
                        </a>
                    </li>

                    <li class="breadcrumb-item active text-success"
                        aria-current="page">
                        Maps
                    </li>

                </ol>

            </div>

        </div>
        <!-- END PAGE HEADER -->


        <!-- ========================================================= -->
        <!-- SERVER-SIDE REGION POLYGON DATA                           -->
        <!-- ========================================================= -->

        <!--
            Using a hidden textarea instead of:
            <input value="${regions_polygon}">

            This is safer where regions_polygon contains JSON,
            GeoJSON, WKT, quotes or other special characters.
        -->
        <textarea
            id="regions_polygon"
            class="d-none"
            aria-hidden="true"><c:out value="${regions_polygon}" /></textarea>


        <div class="row">

            <!-- ===================================================== -->
            <!-- LEFT CONTROL PANEL                                    -->
            <!-- ===================================================== -->
            <div class="col-lg-4 col-xl-3">

                <div class="card shadow-sm border-0 mb-4">

                    <div class="card-header bg-gradient-primary text-white border-0 py-3">

                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-sliders-h me-2"></i>
                            Control Panel
                        </h5>

                    </div>


                    <div class="card-body">

                        <!-- ========================================= -->
                        <!-- PRIMARY ACTION BUTTONS                    -->
                        <!-- ========================================= -->
                        <div class="btn-group w-100 mb-4"
                             role="group"
                             aria-label="Coordinate actions">


                            <!--
                                Do NOT add data-bs-toggle="tooltip"
                                here because data-bs-toggle is already
                                being used for the modal.
                            -->
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


                            <button
                                type="button"
                                class="btn btn-warning btn-sm"
                                id="pvlmd_btn_visualise_coordinate"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                title="Visualise Coordinate">

                                <i class="fas fa-eye me-1"></i>
                                Visualise

                            </button>

                        </div>


                        <!-- ========================================= -->
                        <!-- DRAWING / MEASUREMENT TOOLS               -->
                        <!-- ========================================= -->
                        <div class="card border-info mb-3">

                            <div
                                class="card-header bg-info bg-opacity-10 border-info py-2 d-flex align-items-center">

                                <i class="fas fa-ruler-combined me-2 text-info"></i>

                                <span class="fw-semibold small">
                                    Draw &amp; Measure
                                </span>

                            </div>


                            <div class="card-body p-2">

                                <div class="d-flex flex-wrap gap-1 mb-2">

                                    <button
                                        type="button"
                                        class="btn btn-outline-danger btn-sm flex-fill"
                                        id="pvlmd_btn_draw_polygon"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Draw Polygon">

                                        <i class="fas fa-draw-polygon me-1"></i>
                                        Polygon

                                    </button>


                                    <button
                                        type="button"
                                        class="btn btn-outline-warning btn-sm flex-fill"
                                        id="pvlmd_btn_draw_circle"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Draw Circle">

                                        <i class="fas fa-circle me-1"></i>
                                        Circle

                                    </button>


                                    <button
                                        type="button"
                                        class="btn btn-outline-primary btn-sm flex-fill"
                                        id="pvlmd_btn_draw_line"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Draw Line">

                                        <i class="fas fa-ruler me-1"></i>
                                        Line

                                    </button>

                                </div>


                                <div class="d-flex gap-1">

                                    <button
                                        type="button"
                                        class="btn btn-outline-secondary btn-sm flex-fill"
                                        id="pvlmd_btn_modify"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Modify Features">

                                        <i class="fas fa-edit me-1"></i>
                                        Modify

                                    </button>


                                    <button
                                        type="button"
                                        class="btn btn-outline-danger btn-sm flex-fill"
                                        id="pvlmd_btn_clear_measurements"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Clear Drawings">

                                        <i class="fas fa-eraser me-1"></i>
                                        Clear

                                    </button>

                                </div>


                                <div
                                    class="mt-2 text-muted"
                                    style="font-size: 0.70rem;">

                                    <i class="fas fa-info-circle me-1"></i>

                                    Click the map to draw. Area or length
                                    will be displayed automatically.

                                </div>

                            </div>

                        </div>


                        <!-- ========================================= -->
                        <!-- COORDINATE TABLE                          -->
                        <!-- ========================================= -->
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

                                            <th>Name</th>

                                            <th>X</th>

                                            <th>Y</th>

                                            <th class="text-center">
                                                Action
                                            </th>

                                        </tr>

                                    </thead>


                                    <tbody>
                                        <!-- Populated dynamically -->
                                    </tbody>

                                </table>

                            </div>

                        </div>


                        <!-- ========================================= -->
                        <!-- WKT POLYGON                              -->
                        <!-- ========================================= -->
                        <div class="mb-4">

                            <h6 class="fw-semibold mb-2 text-primary">

                                <i class="fas fa-draw-polygon me-2"></i>
                                WKT Polygon

                            </h6>


                            <textarea
                                class="form-control form-control-sm mb-2"
                                rows="4"
                                id="pvlmd_bl_wkt_polygon"
                                placeholder="POLYGON((x1 y1, x2 y2, x3 y3, x1 y1))"></textarea>


                            <button
                                type="button"
                                class="btn btn-outline-primary btn-sm w-100"
                                id="pvlmd_btn_visualise_wkt"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                title="Visualise Polygon">

                                <i class="fas fa-map me-1"></i>
                                Visualise Polygon

                            </button>


                            <button
                                type="button"
                                class="btn btn-warning btn-sm w-100 mt-2 d-none"
                                id="pvlmd_btn_request_add_existing_parcel"
                                data-bs-toggle="tooltip"
                                data-bs-placement="top"
                                title="Request For Add Existing Parcel">

                                <i class="fas fa-paper-plane me-1"></i>
                                Request For Add Existing Parcel

                            </button>

                        </div>


                        <!-- ========================================= -->
                        <!-- QUICK COORDINATE SEARCH                   -->
                        <!-- ========================================= -->
                        <div class="card border-success mb-4">

                            <div
                                class="card-header bg-success bg-opacity-10 border-success py-2">

                                <h6 class="mb-0 fw-semibold">

                                    <i class="fas fa-search-location me-2"></i>
                                    Quick Coordinate Search

                                </h6>

                            </div>


                            <div class="card-body p-3">

                                <!-- X / Y SEARCH -->
                                <div class="row g-2 mb-2">

                                    <div class="col-5">

                                        <input
                                            type="text"
                                            class="form-control form-control-sm"
                                            id="pvlmd_x_coordinate_mak"
                                            autocomplete="off"
                                            placeholder="X Coordinate">

                                    </div>


                                    <div class="col-5">

                                        <input
                                            type="text"
                                            class="form-control form-control-sm"
                                            id="pvlmd_y_coordinate_mak"
                                            autocomplete="off"
                                            placeholder="Y Coordinate">

                                    </div>


                                    <div class="col-2">

                                        <button
                                            type="button"
                                            class="btn btn-primary btn-sm w-100"
                                            id="pvlmd_btn_show_location"
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="top"
                                            title="Show Location">

                                            <i class="fas fa-map-marker-alt"></i>

                                        </button>

                                    </div>

                                </div>


                                <!-- REFERENCE SEARCH -->
                                <div class="row g-2">

                                    <div class="col-8">

                                        <input
                                            class="form-control form-control-sm"
                                            id="pvlmd_search_by_text"
                                            name="pvlmd_search_by_text"
                                            type="text"
                                            autocomplete="off"
                                            placeholder="Search by Ref Number">

                                    </div>


                                    <div class="col-2">

                                        <button
                                            type="button"
                                            class="btn btn-info btn-sm w-100"
                                            id="pvlmd_btn_search_by_reference_number"
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="top"
                                            title="Search Reference Number">

                                            <i class="fas fa-search"></i>

                                        </button>

                                    </div>


                                    <div class="col-2">

                                        <button
                                            type="button"
                                            class="btn btn-success btn-sm w-100"
                                            id="pvlmd_btn_load_for_scanned_maps_by_point"
                                            data-bs-toggle="tooltip"
                                            data-bs-placement="top"
                                            title="Search Scanned Map">

                                            <i class="fas fa-check-circle"></i>

                                        </button>

                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- Existing JS appears to depend on this ID -->
                        <input
                            id="pvlmd_btn_search_by_transaction_reference_number"
                            type="hidden"
                            value="">


                        <!-- ========================================= -->
                        <!-- SCANNED MAPS                              -->
                        <!-- ========================================= -->
                        <div class="card border-warning mb-4">

                            <div
                                class="card-header bg-warning bg-opacity-10 border-warning py-2">

                                <h6 class="mb-0 fw-semibold">

                                    <i class="fas fa-layer-group me-2"></i>
                                    Scanned Maps

                                </h6>

                            </div>


                            <div class="card-body p-3">

                                <div class="mb-3">

                                    <label
                                        class="form-label small fw-semibold"
                                        for="geoserverscannedimages_list">

                                        Map Sheet

                                    </label>


                                    <select
                                        name="geoserverscannedimages_list"
                                        id="geoserverscannedimages_list"
                                        class="form-select form-select-sm"
                                        data-style="btn-info"
                                        data-live-search="true">

                                        <option value="-1">
                                            No Scanned Image
                                        </option>

                                    </select>

                                </div>


                                <div class="d-flex gap-2">

                                    <button
                                        type="button"
                                        class="btn btn-warning btn-sm flex-fill"
                                        id="pvlmd_btn_search_for_scanned_maps"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Search for related sheets">

                                        <i class="fas fa-search me-1"></i>
                                        Search

                                    </button>


                                    <button
                                        type="button"
                                        class="btn btn-success btn-sm flex-fill"
                                        id="pvlmd_btn_load_for_scanned_maps"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="top"
                                        title="Show Selected Sheet">

                                        <i class="fas fa-check-circle me-1"></i>
                                        Load

                                    </button>

                                </div>

                            </div>

                        </div>


                        <!-- ========================================= -->
                        <!-- MULTIPLE PARCEL OVERLAYS                  -->
                        <!-- ========================================= -->
                        <div class="mt-4">

                            <h6 class="fw-semibold mb-3 text-primary">

                                <i class="fas fa-copy me-2"></i>
                                More Than One Overlay

                            </h6>


                            <div class="table-responsive">

                                <table
                                    class="table table-hover table-sm align-middle"
                                    id="pvlmd_more_than_one_parcel_Table">

                                    <thead class="table-light">

                                        <tr>

                                            <th>
                                                Reference Number
                                            </th>

                                            <th>
                                                NT Number
                                            </th>

                                            <th>
                                                Locality
                                            </th>

                                            <th class="text-center">
                                                Details
                                            </th>

                                        </tr>

                                    </thead>


                                    <tbody>
                                        <!-- Populated dynamically -->
                                    </tbody>

                                </table>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
            <!-- END LEFT CONTROL PANEL -->


            <!-- ===================================================== -->
            <!-- MAIN MAP AREA                                        -->
            <!-- ===================================================== -->
            <div class="col-lg-8 col-xl-9">

                <div class="card shadow-sm border-0 mb-4">

                    <div
                        class="card-header bg-gradient-success text-white border-0 py-3">

                        <h5 class="mb-0 fw-semibold">

                            <i class="fas fa-map me-2"></i>
                            Interactive Map Viewer

                        </h5>

                    </div>


                    <div class="card-body">

                        <!-- ========================================= -->
                        <!-- MAP TOOLBAR                               -->
                        <!-- ========================================= -->
                        <div
                            class="d-flex flex-wrap align-items-center gap-3 mb-4">


                            <!-- DRAW / MODIFY SWITCH -->
                            <div
                                class="btn-group"
                                role="group"
                                aria-label="Map interaction mode">

                                <input
                                    type="radio"
                                    class="btn-check"
                                    id="draw"
                                    name="interaction_type"
                                    value="draw"
                                    autocomplete="off"
                                    checked>


                                <label
                                    class="btn btn-outline-primary btn-sm"
                                    for="draw">

                                    <i class="fas fa-pencil-alt me-1"></i>
                                    Draw

                                </label>


                                <input
                                    type="radio"
                                    class="btn-check"
                                    id="modify"
                                    name="interaction_type"
                                    value="modify"
                                    autocomplete="off">


                                <label
                                    class="btn btn-outline-warning btn-sm"
                                    for="modify">

                                    <i class="fas fa-edit me-1"></i>
                                    Modify

                                </label>

                            </div>


                            <!-- ===================================== -->
                            <!-- SCALE CONTROLS                        -->
                            <!-- ===================================== -->
                            <div
                                class="d-flex flex-wrap align-items-center gap-2">

                                <span class="fw-semibold text-muted small">
                                    Scale:
                                </span>


                                <input
                                    class="form-control form-control-sm"
                                    id="pvlmd_scale_value_e"
                                    name="pvlmd_scale_value_e"
                                    type="text"
                                    inputmode="numeric"
                                    autocomplete="off"
                                    placeholder="Scale"
                                    style="width: 90px;">


                                <select
                                    name="pvlmd_scale_value"
                                    id="pvlmd_scale_value"
                                    class="form-select form-select-sm"
                                    style="width: 125px;">

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
                                        id="pvlmd_lockmapscale"
                                        checked>


                                    <label
                                        class="form-check-label small"
                                        for="pvlmd_lockmapscale">

                                        Lock

                                    </label>

                                </div>


                                <button
                                    type="button"
                                    class="btn btn-primary btn-sm"
                                    id="pvlmd_btn_scale_zoom"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Zoom to Scale">

                                    <i class="fas fa-search"></i>

                                </button>

                            </div>


                            <!-- ===================================== -->
                            <!-- MAP ACTION BUTTONS                    -->
                            <!-- ===================================== -->
                            <div
                                class="d-flex flex-wrap gap-2 ms-lg-auto">


                                <button
                                    type="button"
                                    class="btn btn-outline-primary btn-sm"
                                    id="pvlmd_btnprintmap"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Print Map">

                                    <i class="fas fa-print me-1"></i>
                                    Print

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-info btn-sm"
                                    id="pvlmd_btn_visualise_search"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Visualise Search">

                                    <i class="fas fa-search me-1"></i>
                                    Search

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-secondary btn-sm"
                                    id="pvlmd_btngeneratesearchreport"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Print Search Report">

                                    <i class="fas fa-file-alt me-1"></i>
                                    Report

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-outline-success btn-sm"
                                    id="pvlmd_btn_download_geojson"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="top"
                                    title="Download GeoJSON">

                                    <i class="fas fa-download me-1"></i>
                                    GeoJSON

                                </button>

                            </div>

                        </div>


                        <!-- ========================================= -->
                        <!-- MAP CONTAINER                             -->
                        <!-- ========================================= -->
                        <div
                            id="pvlmd-map-wrapper"
                            class="border rounded position-relative overflow-hidden"
                            style="height: 600px; min-height: 450px;">

                            <div
                                id="pvlmd-map"
                                class="h-100 w-100">
                            </div>

                        </div>

                    </div>


                    <!-- ============================================= -->
                    <!-- MAP FOOTER                                   -->
                    <!-- ============================================= -->
                    <div
                        class="card-footer bg-transparent border-0 pt-3">

                        <div
                            class="d-flex justify-content-between align-items-center flex-wrap gap-2">

                            <div class="text-muted small">

                                <i class="fas fa-info-circle me-1"></i>

                                PVLMD noted proposal map plotting

                            </div>


                            <div class="text-muted small">

                                <i class="fas fa-sync-alt me-1"></i>

                                Last updated:
                                <span id="pvlmd_last_updated">
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

<jsp:include page="pvlmd_maps_modals.jsp" />


<!-- ============================================================= -->
<!-- PAGE INITIALIZATION                                           -->
<!-- ============================================================= -->

<script>

(function () {

    "use strict";


    /**
     * Initialise Bootstrap tooltips.
     *
     * We deliberately initialise only elements whose
     * data-bs-toggle is "tooltip".
     *
     * Modal buttons keep data-bs-toggle="modal".
     */
    function initialisePvlmdTooltips() {

        if (typeof bootstrap === "undefined") {

            console.warn(
                "Bootstrap JavaScript is not available. " +
                "PVLMD tooltips will not be initialised."
            );

            return;
        }


        var tooltipElements =
            document.querySelectorAll(
                '[data-bs-toggle="tooltip"]'
            );


        tooltipElements.forEach(function (element) {

            try {

                var existingInstance =
                    bootstrap.Tooltip.getInstance(element);


                if (!existingInstance) {

                    new bootstrap.Tooltip(element);

                }

            } catch (error) {

                console.error(
                    "Unable to initialise tooltip:",
                    element,
                    error
                );

            }

        });

    }


    /**
     * Read server-side region polygon safely.
     *
     * It may contain:
     * - GeoJSON
     * - JSON
     * - WKT
     * - plain text
     */
    function initialiseRegionPolygonData() {

        var regionElement =
            document.getElementById("regions_polygon");


        if (!regionElement) {

            return;

        }


        var regionValue =
            (regionElement.value || "").trim();


        /*
         * Keep a copy available globally for scripts that
         * want to consume it.
         *
         * The original DOM element is also preserved for
         * compatibility with existing code such as:
         *
         * $("#regions_polygon").val()
         */
        window.pvlmdRegionsPolygonRaw = regionValue;


        if (!regionValue) {

            window.pvlmdRegionsPolygon = null;
            return;

        }


        /*
         * Try parsing JSON/GeoJSON.
         *
         * If parsing fails it may simply be WKT,
         * so we retain the string instead.
         */
        try {

            window.pvlmdRegionsPolygon =
                JSON.parse(regionValue);

        } catch (error) {

            window.pvlmdRegionsPolygon =
                regionValue;

        }

    }


    /**
     * Ensure the OpenLayers map recalculates its size.
     *
     * This is useful where the map is rendered inside
     * Bootstrap layouts/cards and gets its dimensions
     * slightly after initial page rendering.
     */
    function refreshPvlmdMapSize() {

        window.setTimeout(function () {

            try {

                /*
                 * Common map variable names used by existing
                 * applications. This does not create another map.
                 */
                if (
                    typeof window.pvlmd_map !== "undefined" &&
                    window.pvlmd_map &&
                    typeof window.pvlmd_map.updateSize === "function"
                ) {

                    window.pvlmd_map.updateSize();

                }

                else if (
                    typeof window.map !== "undefined" &&
                    window.map &&
                    typeof window.map.updateSize === "function"
                ) {

                    window.map.updateSize();

                }

            } catch (error) {

                console.warn(
                    "Unable to refresh PVLMD map size:",
                    error
                );

            }

        }, 250);

    }


    /**
     * Initialise this JSP.
     */
    function initialisePvlmdPage() {

        initialisePvlmdTooltips();

        initialiseRegionPolygonData();

        refreshPvlmdMapSize();

    }


    /*
     * Handle both cases:
     *
     * 1. Normal full page load.
     * 2. JSP inserted dynamically after DOMContentLoaded.
     */
    if (document.readyState === "loading") {

        document.addEventListener(
            "DOMContentLoaded",
            initialisePvlmdPage
        );

    } else {

        initialisePvlmdPage();

    }

})();

</script>


<!-- ============================================================= -->
<!-- EXISTING APPLICATION SCRIPTS                                  -->
<!-- ============================================================= -->

<script
    src="${pageContext.request.contextPath}/js-pages/js-map/pvlmd_spatial.js">
</script>

<script
    src="${pageContext.request.contextPath}/js-pages/gated_workflow.js">
</script>