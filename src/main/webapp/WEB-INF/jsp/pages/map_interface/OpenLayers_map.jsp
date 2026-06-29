
    <style>
        .map-container {
            height: 600px;
            border-radius: 8px;
            overflow: hidden;
        }
        #map {
            width: 100%;
            height: 100%;
        }
        .control-panel {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
        }
        .polygon-list-item {
            cursor: pointer;
            transition: all 0.2s;
        }
        .polygon-list-item:hover {
            background-color: #e9ecef;
        }
        .polygon-list-item.active {
            background-color: #0d6efd;
            color: white;
        }
        .badge-polygon-count {
            background-color: #0d6efd;
            color: white;
            border-radius: 50%;
            padding: 2px 10px;
            font-size: 12px;
        }
        .draw-toolbar .btn {
            margin-right: 5px;
            margin-bottom: 5px;
        }
        .json-output {
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-size: 12px;
            max-height: 300px;
            overflow: auto;
        }
        .coordinate-info {
            background: white;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
        .btn-group-vertical .btn {
            margin-bottom: 4px;
        }
        .layer-control {
            max-height: 150px;
            overflow-y: auto;
        }
    </style>


<div class="main-content app-content">
    <div class="container-fluid page-container">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-0">
                <i class="fas fa-draw-polygon text-primary me-2"></i>Polygon Creator
            </h4>
            <p class="text-muted small mb-0">Draw and manage polygons on the map</p>
        </div>
        <div>
            <span class="badge bg-primary me-2">
                <i class="fas fa-layer-group me-1"></i>
                <span id="polygonCount">0</span> Polygons
            </span>
            <button class="btn btn-success btn-sm" id="savePolygonsBtn">
                <i class="fas fa-save me-1"></i> Save Polygon
            </button>
        </div>
    </div>

    <div class="row g-4">
        <!-- Left Panel - Controls -->
        <div class="col-lg-4 col-xl-3">
            <div class="control-panel shadow-sm">
                <!-- Drawing Tools -->
                <div class="mb-4">
                    <h6 class="fw-bold text-primary mb-3">
                        <i class="fas fa-pencil-alt me-2"></i>Drawing Tools
                    </h6>
                    <div class="draw-toolbar">
                        <button class="btn btn-outline-primary btn-sm" id="drawPolygonBtn">
                            <i class="fas fa-draw-polygon me-1"></i> Draw Polygon
                        </button>
                        <button class="btn btn-outline-warning btn-sm" id="modifyPolygonBtn">
                            <i class="fas fa-edit me-1"></i> Modify
                        </button>
                        <button class="btn btn-outline-danger btn-sm" id="deleteSelectedBtn">
                            <i class="fas fa-trash me-1"></i> Delete
                        </button>
                        <button class="btn btn-outline-secondary btn-sm" id="clearAllBtn">
                            <i class="fas fa-eraser me-1"></i> Clear All
                        </button>
                    </div>
                </div>

                <!-- Polygon List -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h6 class="fw-bold text-primary mb-0">
                            <i class="fas fa-list me-2"></i>Polygon List
                        </h6>
                        <span class="badge-polygon-count" id="polygonCountBadge">0</span>
                    </div>
                    <div class="list-group polygon-list" id="polygonList" style="max-height: 250px; overflow-y: auto;">
                        <div class="text-muted text-center py-3 small" id="emptyPolygonMsg">
                            <i class="fas fa-info-circle me-1"></i> No polygons drawn yet
                        </div>
                    </div>
                </div>

                <!-- Coordinate Info -->
                <div class="coordinate-info mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <small class="fw-bold text-muted">
                            <i class="fas fa-crosshairs me-1"></i>Mouse Position
                        </small>
                        <small class="text-muted" id="mouseCoords">-</small>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <small class="fw-bold text-muted">
                            <i class="fas fa-vector-square me-1"></i>Vertex Count
                        </small>
                        <small class="text-muted" id="vertexCount">-</small>
                    </div>
                </div>

                <!-- Export Options -->
                <div>
                    <h6 class="fw-bold text-primary mb-2">
                        <i class="fas fa-file-export me-2"></i>Export
                    </h6>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-success btn-sm" id="exportGeoJSONBtn">
                            <i class="fas fa-download me-1"></i> Download WKT JSON
                        </button>
                        <button class="btn btn-outline-info btn-sm" id="copyJSONBtn">
                            <i class="fas fa-copy me-1"></i> Copy JSON
                        </button>

                         <button class="btn btn-success btn-sm" id="btn_print_hatched_map">
                            <i class="fas fa-copy me-1"></i> Print Plan
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Map Area -->
        <div class="col-lg-8 col-xl-9">
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <div class="map-container">
                        <div id="map"></div>
                    </div>
                </div>
            </div>

            <!-- JSON Output -->
            <div class="mt-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h6 class="fw-bold text-primary mb-0">
                        <i class="fas fa-code me-2"></i>JSON Output
                    </h6>
                    <button class="btn btn-outline-secondary btn-sm" id="toggleJsonBtn">
                        <i class="fas fa-chevron-down me-1"></i> Toggle
                    </button>
                </div>
                <div id="jsonOutputContainer" style="display: block;">
                    <div class="json-output" id="jsonOutput">
                        <span class="text-muted">// No polygons drawn yet</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</div>

<div class="modal fade" id="savePolygonModal" tabindex="-1" aria-labelledby="savePolygonModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="savePolygonModalLabel">
                    <i class="fas fa-save text-success me-2"></i>Save Polygon WKT
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label fw-semibold" for="polygonJobNumber">Job Number</label>
                    <input type="text" class="form-control" id="polygonJobNumber" placeholder="Enter job number">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold" for="polygonSaveJson">Polygon JSON Array</label>
                    <textarea class="form-control font-monospace" id="polygonSaveJson" rows="12" readonly></textarea>
                    <small class="text-muted">Projection: Accra Ghana Grid (EPSG:2136)</small>
                </div>
                <div class="alert d-none mb-0" id="polygonSaveMessage" role="alert"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-success" id="modalSavePolygonBtn">
                    <i class="fas fa-save me-1"></i> Save
                </button>
            </div>
        </div>
    </div>
</div>



<script>
    // ============================================
    // POLYGON CREATOR - OpenLayers Implementation
    // ============================================

    // ===== Configuration =====
    const CONFIG = {
        centerLonLat: [0.41, 4.82],
        zoom: 5,
        mapProjection: 'EPSG:3857',
        dataProjection: 'EPSG:4326',
        gridProjection: 'EPSG:2136',
        gridExtent: [80935.4497355444, 1209.0295731349593, 1711780.3060929566, 2358523.124783509],
        defaultStyle: {
            fill: {
                color: 'rgba(13, 110, 253, 0.2)'
            },
            stroke: {
                color: '#0d6efd',
                width: 2
            },
            image: {
                radius: 7,
                fill: { color: '#0d6efd' }
            }
        },
        selectedStyle: {
            stroke: {
                color: '#dc3545',
                width: 3
            }
        }
    };

    // ===== State Management =====
    const state = {
        polygons: [],
        selectedFeatureId: null,
        isDrawing: false,
        isModifying: false,
        interactionType: 'none' // 'draw' | 'modify' | 'none'
    };

    // ===== DOM References =====
    const dom = {
        mapContainer: document.getElementById('map'),
        polygonList: document.getElementById('polygonList'),
        polygonCount: document.getElementById('polygonCount'),
        polygonCountBadge: document.getElementById('polygonCountBadge'),
        jsonOutput: document.getElementById('jsonOutput'),
        mouseCoords: document.getElementById('mouseCoords'),
        vertexCount: document.getElementById('vertexCount'),
        emptyMsg: document.getElementById('emptyPolygonMsg'),
        jsonContainer: document.getElementById('jsonOutputContainer'),
        drawBtn: document.getElementById('drawPolygonBtn'),
        modifyBtn: document.getElementById('modifyPolygonBtn'),
        deleteBtn: document.getElementById('deleteSelectedBtn'),
        clearBtn: document.getElementById('clearAllBtn'),
        saveBtn: document.getElementById('savePolygonsBtn'),
        exportGeoJSONBtn: document.getElementById('exportGeoJSONBtn'),
        copyBtn: document.getElementById('copyJSONBtn'),
        toggleJsonBtn: document.getElementById('toggleJsonBtn'),
        saveModal: document.getElementById('savePolygonModal'),
        modalSaveBtn: document.getElementById('modalSavePolygonBtn'),
        jobNumber: document.getElementById('polygonJobNumber'),
        saveJson: document.getElementById('polygonSaveJson'),
        saveMessage: document.getElementById('polygonSaveMessage')
    };

    // ===== OpenLayers Setup =====

    proj4.defs(
        CONFIG.gridProjection,
        '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs'
    );
    ol.proj.setProj4(proj4);

    const gridProjection = ol.proj.get(CONFIG.gridProjection);
    if (gridProjection) {
        gridProjection.setExtent(CONFIG.gridExtent);
    }
    
    // Vector Source
    const vectorSource = new ol.source.Vector({
        wrapX: false
    });

    // Vector Layer
    const vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: function(feature) {
            const isSelected = feature.getId() === state.selectedFeatureId;
            return new ol.style.Style({
                fill: new ol.style.Fill({
                    color: isSelected ? 'rgba(220, 53, 69, 0.2)' : CONFIG.defaultStyle.fill.color
                }),
                stroke: new ol.style.Stroke({
                    color: isSelected ? CONFIG.selectedStyle.stroke.color : CONFIG.defaultStyle.stroke.color,
                    width: isSelected ? CONFIG.selectedStyle.stroke.width : CONFIG.defaultStyle.stroke.width
                }),
                image: new ol.style.Circle({
                    radius: CONFIG.defaultStyle.image.radius,
                    fill: new ol.style.Fill({
                        color: CONFIG.defaultStyle.image.fill.color
                    })
                })
            });
        }
    });

    // Base Layers
    const osmLayer = new ol.layer.Tile({
        source: new ol.source.OSM(),
        title: 'OpenStreetMap'
    });

    const googleHybrid = new ol.layer.Tile({
        title: 'Google Satellite',
        visible: false,
        source: new ol.source.XYZ({
            url: 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
        })
    });

    // Map View
    const view = new ol.View({
        projection: CONFIG.mapProjection,
        center: ol.proj.fromLonLat(CONFIG.centerLonLat),
        zoom: CONFIG.zoom
    });

    // Create Map
    const map = new ol.Map({
        target: 'map',
        layers: [osmLayer, googleHybrid, vectorLayer],
        view: view,
        controls: ol.control.defaults().extend([
            new ol.control.ZoomSlider(),
            new ol.control.FullScreen(),
            new ol.control.MousePosition({
                projection: CONFIG.dataProjection,
                coordinateFormat: function(coordinate) {
                    return coordinate ? coordinate[0].toFixed(6) + ', ' + coordinate[1].toFixed(6) : '';
                }
            })
        ])
    });

    function refreshMapSize() {
        map.updateSize();
    }

    window.addEventListener('load', refreshMapSize);
    window.addEventListener('resize', refreshMapSize);
    setTimeout(refreshMapSize, 100);
    setTimeout(refreshMapSize, 500);

    // ===== Interaction Management =====
    let drawInteraction = null;
    let modifyInteraction = null;
    let selectInteraction = null;

    function clearInteractions() {
        if (drawInteraction) {
            map.removeInteraction(drawInteraction);
            drawInteraction = null;
        }
        if (modifyInteraction) {
            map.removeInteraction(modifyInteraction);
            modifyInteraction = null;
        }
        if (selectInteraction) {
            map.removeInteraction(selectInteraction);
            selectInteraction = null;
        }
        state.isDrawing = false;
        state.isModifying = false;
        state.interactionType = 'none';
        
        // Reset button states
        dom.drawBtn.classList.remove('active');
        dom.modifyBtn.classList.remove('active');
    }

    function startDrawInteraction() {
        clearInteractions();
        refreshMapSize();
        
        drawInteraction = new ol.interaction.Draw({
            source: vectorSource,
            type: 'Polygon',
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(13, 110, 253, 0.1)'
                }),
                stroke: new ol.style.Stroke({
                    color: '#0d6efd',
                    width: 2,
                    lineDash: [5, 5]
                })
            })
        });

        drawInteraction.on('drawend', function(event) {
            const feature = event.feature;
            const id = Date.now() + '_' + Math.random().toString(36).substr(2, 5);
            feature.setId(id);
            
            state.polygons.push({
                id: id,
                feature: feature,
                geometry: feature.getGeometry().clone()
            });
            
            updateUI();
            
            // Auto-select the new polygon
            selectPolygon(id);
            
            // Switch back to default state after drawing
            clearInteractions();
        });

        map.addInteraction(drawInteraction);
        state.isDrawing = true;
        state.interactionType = 'draw';
        dom.drawBtn.classList.add('active');
    }

    function startModifyInteraction() {
        clearInteractions();
        refreshMapSize();
        
        // First, create a select interaction
        selectInteraction = new ol.interaction.Select({
            layers: [vectorLayer],
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: CONFIG.selectedStyle.stroke.color,
                    width: CONFIG.selectedStyle.stroke.width
                })
            })
        });

        selectInteraction.on('select', function(event) {
            const selected = event.selected;
            if (selected.length > 0) {
                const feature = selected[0];
                selectPolygon(feature.getId());
            } else {
                deselectPolygon();
            }
        });

        map.addInteraction(selectInteraction);

        // Then create modify interaction
        modifyInteraction = new ol.interaction.Modify({
            features: selectInteraction.getFeatures(),
            deleteCondition: function(event) {
                return ol.events.condition.shiftKeyOnly(event) && 
                       ol.events.condition.singleClick(event);
            }
        });

        modifyInteraction.on('modifyend', function(event) {
            const features = event.features.getArray();
            features.forEach(function(feature) {
                const id = feature.getId();
                const polygon = state.polygons.find(p => p.id === id);
                if (polygon) {
                    polygon.geometry = feature.getGeometry().clone();
                }
            });
            updateUI();
        });

        map.addInteraction(modifyInteraction);
        state.isModifying = true;
        state.interactionType = 'modify';
        dom.modifyBtn.classList.add('active');
    }

    // ===== Polygon Selection =====
    function selectPolygon(id) {
        state.selectedFeatureId = id;
        
        // Update list UI
        document.querySelectorAll('.polygon-list-item').forEach(el => {
            el.classList.remove('active');
            if (el.dataset.id === id) {
                el.classList.add('active');
            }
        });
        
        // Update map
        vectorLayer.changed();
        updateUI();
    }

    function deselectPolygon() {
        state.selectedFeatureId = null;
        document.querySelectorAll('.polygon-list-item').forEach(el => {
            el.classList.remove('active');
        });
        vectorLayer.changed();
        updateUI();
    }

    // ===== Polygon Management =====
    function deleteSelectedPolygon() {
        if (state.selectedFeatureId === null) return;
        
        const index = state.polygons.findIndex(p => p.id === state.selectedFeatureId);
        if (index !== -1) {
            const polygon = state.polygons[index];
            vectorSource.removeFeature(polygon.feature);
            state.polygons.splice(index, 1);
            state.selectedFeatureId = null;
            updateUI();
        }
    }

    function clearAllPolygons() {
        if (state.polygons.length === 0) return;
        if (!confirm('Are you sure you want to clear all polygons?')) return;
        
        vectorSource.clear();
        state.polygons = [];
        state.selectedFeatureId = null;
        updateUI();
    }

    // ===== Data Export =====
    function getPolygonsGeoJSON() {
        return JSON.stringify(getPolygonsJSONArray(), null, 2);
    }

    function getPolygonsJSONArray() {
        const wktFormat = new ol.format.WKT();
        const features = state.polygons.map(p => {
            const geom = p.feature.getGeometry();
            const gridGeometry = geom.clone().transform(CONFIG.mapProjection, CONFIG.gridProjection);
            const wkt = wktFormat.writeGeometry(gridGeometry);
            return {
                id: p.id,
                type: 'Polygon',
                projection: CONFIG.gridProjection,
                wkt: wkt,
                area: geom.getArea ? geom.getArea() : null
            };
        });
        return features;
    }

    function updateJSONOutput() {
        if (state.polygons.length === 0) {
            dom.jsonOutput.innerHTML = '<span class="text-muted">// No polygons drawn yet</span>';
            return;
        }
        
        const jsonData = getPolygonsJSONArray();
        dom.jsonOutput.textContent = JSON.stringify(jsonData, null, 2);
    }

    function downloadGeoJSON() {
        const wktJson = getPolygonsGeoJSON();
        const blob = new Blob([wktJson], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'polygons_' + new Date().toISOString().slice(0, 10) + '_wkt.json';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }

    function copyJSONToClipboard() {
        const jsonData = getPolygonsJSONArray();
        const text = JSON.stringify(jsonData, null, 2);
        navigator.clipboard.writeText(text).then(() => {
            const originalText = dom.copyBtn.innerHTML;
            dom.copyBtn.innerHTML = '<i class="fas fa-check me-1"></i> Copied!';
            setTimeout(() => {
                dom.copyBtn.innerHTML = originalText;
            }, 2000);
        }).catch(() => {
            alert('Failed to copy JSON. Please try again.');
        });
    }

    // ===== UI Update =====
    function updateUI() {
        // Update polygon count
        const count = state.polygons.length;
        dom.polygonCount.textContent = count;
        dom.polygonCountBadge.textContent = count;
        
        // Update polygon list
        const listHtml = state.polygons.map(function(p, index) {
            const isActive = p.id === state.selectedFeatureId ? 'active' : '';
            const vertexCount = p.feature.getGeometry().getCoordinates()[0].length - 1;

            return ''
                + '<div class="list-group-item list-group-item-action polygon-list-item ' + isActive + '"'
                + ' data-id="' + p.id + '"'
                + ' onclick="window.selectPolygonById(\'' + p.id + '\')">'
                + '<div class="d-flex justify-content-between align-items-center">'
                + '<div>'
                + '<i class="fas fa-draw-polygon me-2"></i>'
                + '<span class="fw-semibold">Polygon ' + (index + 1) + '</span>'
                + '</div>'
                + '<div>'
                + '<span class="badge bg-secondary">' + vertexCount + ' vertices</span>'
                + '<button class="btn btn-sm btn-link text-danger p-0 ms-2" onclick="event.stopPropagation(); window.deletePolygonById(\'' + p.id + '\')">'
                + '<i class="fas fa-times"></i>'
                + '</button>'
                + '</div>'
                + '</div>'
                + '</div>';
        }).join('');
        
        dom.polygonList.innerHTML = listHtml || `
            <div class="text-muted text-center py-3 small">
                <i class="fas fa-info-circle me-1"></i> No polygons drawn yet
            </div>
        `;
        
        // Update JSON output
        updateJSONOutput();
    }

    // ===== Global Functions for HTML onclick =====
    window.selectPolygonById = function(id) {
        selectPolygon(id);
    };

    window.deletePolygonById = function(id) {
        const index = state.polygons.findIndex(p => p.id === id);
        if (index !== -1) {
            const polygon = state.polygons[index];
            vectorSource.removeFeature(polygon.feature);
            state.polygons.splice(index, 1);
            if (state.selectedFeatureId === id) {
                state.selectedFeatureId = null;
            }
            updateUI();
        }
    };

    // ===== Event Listeners =====
    dom.drawBtn.addEventListener('click', startDrawInteraction);

    dom.modifyBtn.addEventListener('click', function() {
        if (state.polygons.length === 0) {
            alert('Please draw at least one polygon first.');
            return;
        }
        startModifyInteraction();
    });

    dom.deleteBtn.addEventListener('click', deleteSelectedPolygon);

    dom.clearBtn.addEventListener('click', clearAllPolygons);

    function showSaveMessage(message, type) {
        dom.saveMessage.className = 'alert alert-' + type + ' mb-0';
        dom.saveMessage.textContent = message;
    }

    function hideSaveMessage() {
        dom.saveMessage.className = 'alert d-none mb-0';
        dom.saveMessage.textContent = '';
    }

    function openSavePolygonModal() {
        if (state.polygons.length === 0) {
            alert('No polygons to save.');
            return;
        }

        const jsonData = getPolygonsJSONArray();
        dom.saveJson.value = JSON.stringify(jsonData, null, 2);
        hideSaveMessage();

        const modal = bootstrap.Modal.getOrCreateInstance(dom.saveModal);
        modal.show();
    }

    function savePolygonFromModal() {
        const jobNumber = dom.jobNumber.value.trim();
        const polygonsJson = dom.saveJson.value.trim();

        if (!jobNumber) {
            showSaveMessage('Please enter a job number.', 'warning');
            dom.jobNumber.focus();
            return;
        }

        if (!polygonsJson) {
            showSaveMessage('No polygon data available to save.', 'warning');
            return;
        }

        dom.modalSaveBtn.disabled = true;
        dom.modalSaveBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Saving...';
        hideSaveMessage();

        $.ajax({
            type: 'POST',
            url : "Maps",
            data: {
                request_type : 'save_hatched_plan_data',
                job_number: jobNumber,
                polygons_json: polygonsJson
            },
            cache: false,
            success: function(response) {
                let result = response;
                if (typeof response === 'string') {
                    try {
                        result = JSON.parse(response);
                    } catch (e) {
                        result = { success: true, message: response };
                    }
                }

                if (result.success === false) {
                    showSaveMessage(result.message || 'Failed to save polygon.', 'danger');
                    return;
                }

                showSaveMessage(result.message || 'Polygon saved successfully.', 'success');
            },
            error: function(xhr) {
                const message = xhr.responseText || 'Failed to save polygon. Please try again.';
                showSaveMessage(message, 'danger');
            },
            complete: function() {
                dom.modalSaveBtn.disabled = false;
                dom.modalSaveBtn.innerHTML = '<i class="fas fa-save me-1"></i> Save';
            }
        });
    }


    


    $('#btn_print_hatched_map').on('click', function(e) {
    console.log("click_type");

    ///var wktplygonsearch = $('#lrd_txt_wkt_polygon').val();
    var wktplygonsearch = 'POLYGON((1272713.6886399083 410835.21906271676,1270110.5931791286 404655.73047630314,1274048.5552428253 403000.9178779029,1280644.1970945906 403726.4471667783,1280239.4417435243 408035.00037375564,1279239.3532419004 410892.8888377089,1275726.3042969867 411581.54972704937,1274451.509182689 411488.50885366515,1272713.6886399083 410835.21906271676))';

    var canvas = document.getElementById("map").getElementsByClassName("ol-unselectable")[0];
    var img = canvas.toDataURL("image/png");

    // Initialize jsPDF
    const { jsPDF } = window.jspdf;
    var doc = new jsPDF('portrait', undefined, 'a4');

    doc.setProperties({
        title: 'Internal Search',
        subject: 'This is the subject',
        author: 'Assiamah John',
        keywords: 'generated, javascript, web 2.0, ajax',
        creator: 'Creator Name'
    });

    // Header
    doc.setFontSize(20);
    doc.text(70, 25, 'LANDS COMMISSION');
    doc.setFontSize(16);
    doc.text(80, 35, 'INTERNAL SEARCH REPORT');

    // Add logo if needed
    var imgLogo = new Image();
    imgLogo.src = './resources/NewLogo.jpg';

    // Add map image
    doc.addImage(img, 'JPEG', 20, 60, 160, 80);

    // Legend
    doc.setFontSize(10);
    doc.setDrawColor(255, 0, 0);
    doc.setLineWidth(1.5);
    doc.line(15, 190, 50, 190);
    doc.text(60, 190, 'Search Polygon');

    doc.setDrawColor(51, 51, 255);
    doc.setLineWidth(1.5);
    doc.line(15, 200, 50, 200);
    doc.text(60, 200, 'PVLMD Parcel');

    // WKT Polygon
    doc.setFontSize(10);
    doc.setFont("courier", "bolditalic");
    var splitTitle = doc.splitTextToSize(wktplygonsearch, 180);
    doc.text(20, 250, splitTitle);

    // Track current Y position for content placement
    var currentY = doc.autoTableEndPosY() + 20;
    if (currentY < 270) {
        currentY = 270;
    }

    // AJAX request
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'select_consolidated_internal_search_report_attribute',
            vr_polygon: wktplygonsearch
        },
        cache: false,
        beforeSend: function() {
            // Show loading indicator
        },
        success: function(jobdetails) {
            try {
                var json_p = JSON.parse(jobdetails);
                console.log(json_p);

                if (json_p !== undefined && json_p !== null) {
                    
                    // Helper function to check if we need a new page
                    function checkPageBreak(requiredSpace) {
                        var pageHeight = doc.internal.pageSize.height;
                        var currentY = doc.autoTableEndPosY() || 20;
                        
                        // Check if we need a new page (leaving 30mm margin)
                        if (currentY + requiredSpace > pageHeight - 30) {
                            doc.addPage();
                            doc.setFontSize(14);
                            doc.text(20, 20, 'Internal Search Report - Continued');
                            doc.setFontSize(10);
                            return 30; // Return new Y position after header
                        }
                        return currentY + 10; // Return current Y + margin
                    }

                    // Helper function to add table or no data message with page break
                    function addTableOrMessage(data, columns, title) {
                        // Calculate estimated space needed
                        var estimatedSpace = data && data.length > 0 ? 
                            Math.min(data.length * 10 + 20, 200) : 40;
                        
                        var startY = checkPageBreak(estimatedSpace);
                        
                        if (!data || data.length === 0) {
                            var noDataRows = [{ main_description: 'No Recorded Transaction' }];
                            var noDataColumns = [{ title: title, dataKey: 'main_description' }];
                            
                            // Add section title
                            doc.setFontSize(11);
                            doc.setFont("helvetica", "bold");
                            doc.text(20, startY, title);
                            doc.setFont("helvetica", "normal");
                            
                            doc.autoTable(noDataColumns, noDataRows, {
                                margin: { top: 5 },
                                theme: 'grid',
                                startY: startY + 7,
                                styles: { fontSize: 9 }
                            });
                        } else {
                            // Add section title
                            doc.setFontSize(11);
                            doc.setFont("helvetica", "bold");
                            doc.text(20, startY, title);
                            doc.setFont("helvetica", "normal");
                            
                            doc.autoTable(columns, data, {
                                margin: { top: 5 },
                                bodyStyles: { valign: 'middle', fontSize: 8 },
                                headStyles: { fillColor: [41, 128, 185], fontSize: 9 },
                                styles: { 
                                    overflow: 'linebreak', 
                                    columnWidth: 'wrap',
                                    fontSize: 8
                                },
                                theme: 'grid',
                                startY: startY + 7,
                                columnStyles: {
                                    party1_plaintiff: { columnWidth: 90 },
                                    party2_defendant: { columnWidth: 80 },
                                    grantor_name: { columnWidth: 80 },
                                    applicant_name: { columnWidth: 80 },
                                    ccno: { columnWidth: 50 },
                                    a_name: { columnWidth: 80 },
                                    prop_no: { columnWidth: 60 },
                                    ls_number: { columnWidth: 60 },
                                    reference_number: { columnWidth: 60 },
                                    reference_number_p: { columnWidth: 60 }
                                },
                                pageBreak: 'auto',
                                tableWidth: 'auto'
                            });
                        }
                    }

                    // GARRO Data
                    var garroColumns = [
                        { title: "Property No", dataKey: "prop_no" },
                        { title: "Instrument Date", dataKey: "instrument_date" },
                        { title: "Instrument Type", dataKey: "instrument_type" },
                        { title: "Grantor", dataKey: "party1_plaintiff" },
                        { title: "Grantee", dataKey: "party2_defendant" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement Date", dataKey: "commencement_date" }
                    ];
                    addTableOrMessage(json_p.garro, garroColumns, '1. Existing GARRO Data');

                    // CRO Data
                    var croColumns = [
                        { title: "LS Number", dataKey: "ls_number" },
                        { title: "Instrument Date", dataKey: "instrument_date" },
                        { title: "Instrument Type", dataKey: "instrument_type" },
                        { title: "Grantor", dataKey: "party1_plaintiff" },
                        { title: "Grantee", dataKey: "party2_defendant" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement Date", dataKey: "commencement_date" }
                    ];
                    addTableOrMessage(json_p.cro, croColumns, '2. Existing CRO Data');

                    // PVLMD Current Data
                    var pvlmdColumns = [
                        { title: "Reference No", dataKey: "reference_number_p" },
                        { title: "Instrument Date", dataKey: "instrument_date" },
                        { title: "Instrument Type", dataKey: "instrument_type" },
                        { title: "Grantor", dataKey: "party1_plaintiff" },
                        { title: "Grantee", dataKey: "party2_defendant" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement Date", dataKey: "commencement_date" }
                    ];
                    addTableOrMessage(json_p.pvlmdcurrent, pvlmdColumns, '3. PVLMD Current Layer');

                    // SMD Parcel Data
                    var smdParcelColumns = [
                        { title: "CC No", dataKey: "ccno" },
                        { title: "Applicant Name", dataKey: "a_name" }
                    ];
                    addTableOrMessage(json_p.smd_parcels, smdParcelColumns, '4. SMD Parcel Layer');

                    // SMD Cadastral Data
                    var smdCadastralColumns = [
                        { title: "CC No", dataKey: "ccno" },
                        { title: "Applicant Name", dataKey: "a_name" }
                    ];
                    addTableOrMessage(json_p.smd_cadastral, smdCadastralColumns, '5. SMD Cadastral Layer');

                    // LRD Data
                    var lrdColumns = [
                        { title: "Reference No.", dataKey: "reference_number" },
                        { title: "Instrument Date", dataKey: "date_of_instument" },
                        { title: "Instrument Type", dataKey: "type_instrument" },
                        { title: "Grantor", dataKey: "grantor_name" },
                        { title: "Applicant Name", dataKey: "applicant_name" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement", dataKey: "date_commencement" }
                    ];
                    addTableOrMessage(json_p.lrd, lrdColumns, '6. LRD Layer');

                    // Add footer with page numbers
                    var totalPages = doc.internal.getNumberOfPages();
                    for (var i = 1; i <= totalPages; i++) {
                        doc.setPage(i);
                        doc.setFontSize(8);
                        doc.setFont("helvetica", "normal");
                        doc.text(
                            20, 
                            doc.internal.pageSize.height - 10, 
                            'Generated on: ' + new Date().toLocaleString()
                        );
                        doc.text(
                            doc.internal.pageSize.width - 30, 
                            doc.internal.pageSize.height - 10, 
                            'Page ' + i + ' of ' + totalPages
                        );
                    }

                    // Save the PDF
                    doc.save('internal_search_report.pdf');
                }
            } catch (error) {
                console.error('Error processing data:', error);
                alert('Error processing report data. Please try again.');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            alert('Error fetching data. Please try again.');
        }
    });
});

    dom.saveBtn.addEventListener('click', openSavePolygonModal);

    dom.modalSaveBtn.addEventListener('click', savePolygonFromModal);

    dom.exportGeoJSONBtn.addEventListener('click', downloadGeoJSON);

    dom.copyBtn.addEventListener('click', copyJSONToClipboard);

    dom.toggleJsonBtn.addEventListener('click', function() {
        const container = dom.jsonContainer;
        const icon = this.querySelector('i');
        if (container.style.display === 'none') {
            container.style.display = 'block';
            icon.className = 'fas fa-chevron-down me-1';
        } else {
            container.style.display = 'none';
            icon.className = 'fas fa-chevron-up me-1';
        }
    });

    // ===== Keyboard Shortcuts =====
    document.addEventListener('keydown', function(e) {
        // Ctrl+D - Draw
        if (e.ctrlKey && e.key === 'd') {
            e.preventDefault();
            startDrawInteraction();
        }
        // Ctrl+M - Modify
        if (e.ctrlKey && e.key === 'm') {
            e.preventDefault();
            if (state.polygons.length > 0) {
                startModifyInteraction();
            }
        }
        // Delete - Delete selected
        if (e.key === 'Delete' && state.selectedFeatureId !== null) {
            deleteSelectedPolygon();
        }
        // Escape - Cancel interactions
        if (e.key === 'Escape') {
            clearInteractions();
            deselectPolygon();
        }
    });

    // ===== Mouse Position Tracking =====
    map.on('pointermove', function(evt) {
        const coords = ol.proj.transform(evt.coordinate, CONFIG.mapProjection, CONFIG.dataProjection);
        dom.mouseCoords.textContent = coords[0].toFixed(6) + ', ' + coords[1].toFixed(6);
        
        // Update vertex count if hovering over a polygon
        const features = map.getFeaturesAtPixel(evt.pixel);
        if (features && features.length > 0) {
            const geom = features[0].getGeometry();
            if (geom && geom.getCoordinates) {
                const coordsArr = geom.getCoordinates()[0];
                dom.vertexCount.textContent = coordsArr ? coordsArr.length - 1 : 0;
            }
        } else {
            dom.vertexCount.textContent = '-';
        }
    });


    console.log('Polygon Creator initialized. Draw polygons using the toolbar or shortcuts.');
</script>
