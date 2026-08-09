$(document).ready(function() {
    // ================================================================
    // INITIALIZE ALL VARIABLES AT THE TOP
    // ================================================================
    var lrd_point_coordinate_list;
    var lrd_click_type = 'MapClick';
    
    // Drawing and measurement variables - INITIALIZED HERE
    var lrd_draw_interaction = null;
    var lrd_modify_interaction = null;
    var lrd_measure_interaction = null;
    var lrd_measure_type = 'distance';
    var lrd_measure_sketch = null;
    var lrd_measure_label = null;
    var lrd_measure_helpTooltip = null;
    var lrd_measure_continueTooltip = null;
    var lrd_measurement_units = 'imperial'; // 'imperial' or 'metric'
    
    var lrd_pvlmd_searchLayer; // Will be defined later

    // ================================================================
    // LAYER DEFINITIONS
    // ================================================================
    var lrd_parcel_lrd_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:lc_spatial_objects',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });
    
    var lrd_lrd_parcels_dataLayer = new ol.layer.Tile({
        title: 'LRD Parcels',
        source: lrd_parcel_lrd_dataSource
    });

    var lrd_undergoing_registration_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:lc_published_undergoing_registration_applications',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_undergoing_registration_dataLayer = new ol.layer.Tile({
        title: 'Undergoing Registration Layer',
        source: lrd_undergoing_registration_dataSource
    });

    var lrd_spatial_blocked_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:lc_spatial_blocked',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_spatial_blocked_dataLayer = new ol.layer.Tile({
        title: 'LRD Blocked Parcel',
        source: lrd_spatial_blocked_dataSource
    });

    var lrd_spatial_deleted_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:lc_spatial_objects_deleted',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_spatial_deleted_dataLayer = new ol.layer.Tile({
        title: 'LRD Deleted Parcel',
        visible: false,
        source: lrd_spatial_deleted_dataSource
    });

    var lrd_grid_lrd_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:gng_grid',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_grid_lrd_dataLayer = new ol.layer.Tile({
        title: 'GridLines',
        visible: false,
        source: lrd_grid_lrd_dataSource
    });

    var lrd_grid_500_lrd_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:grid_500',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_grid_500_lrd_dataLayer = new ol.layer.Tile({
        title: 'GridLines 500',
        visible: false,
        source: lrd_grid_500_lrd_dataSource
    });

    var lrd_registration_district_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:registration_district',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_registration_district_dataLayer = new ol.layer.Tile({
        title: 'Registration District',
        visible: false,
        source: lrd_registration_district_dataSource
    });

    var smd_smd_current_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:lc_spatial_objects_smd',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var smd_smd_current_dataLayer = new ol.layer.Tile({
        title: 'SMD Current Layer',
        visible: false,
        source: smd_smd_current_dataSource
    });

    var lrd_StaticImage = new ol.layer.Image({
        title: 'Scanned Map',
        visible: true,
        source: undefined
    });

    lrd_pvlmd_searchLayer = new ol.layer.Vector({
        title: 'Search Layer',
        source: undefined,
        style: new ol.style.Style({
            stroke: new ol.style.Stroke({
                color: 'red',
                width: 3
            })
        })
    });

    var lrd_markers = new ol.layer.Vector({
        source: new ol.source.Vector()
    });

    // Create drawing layer
    var lrd_draw_layer = new ol.layer.Vector({
        title: 'Drawing Layer',
        source: new ol.source.Vector(),
        style: new ol.style.Style({
            fill: new ol.style.Fill({
                color: 'rgba(255, 0, 0, 0.2)'
            }),
            stroke: new ol.style.Stroke({
                color: '#ff0000',
                width: 2
            }),
            image: new ol.style.Circle({
                radius: 6,
                fill: new ol.style.Fill({
                    color: '#ff0000'
                })
            })
        })
    });

    // Create measurement layer
    var lrd_measure_layer = new ol.layer.Vector({
        title: 'Measure Layer',
        source: new ol.source.Vector(),
        style: new ol.style.Style({
            fill: new ol.style.Fill({
                color: 'rgba(0, 255, 0, 0.1)'
            }),
            stroke: new ol.style.Stroke({
                color: '#00ff00',
                width: 2,
                lineDash: [4, 4]
            }),
            image: new ol.style.Circle({
                radius: 5,
                fill: new ol.style.Fill({
                    color: '#00ff00'
                })
            })
        })
    });

    // Create measurement label layer
    var lrd_measure_label_layer = new ol.layer.Vector({
        title: 'Measure Labels',
        source: new ol.source.Vector(),
        style: new ol.style.Style({
            text: new ol.style.Text({
                font: '12px Calibri, sans-serif',
                fill: new ol.style.Fill({
                    color: '#000000'
                }),
                stroke: new ol.style.Stroke({
                    color: '#ffffff',
                    width: 3
                }),
                backgroundFill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0.7)'
                }),
                padding: [3, 5, 3, 5],
                textAlign: 'center',
                textBaseline: 'middle',
                offsetY: -15
            })
        })
    });

    var lrd_googleLayerHybrid = new ol.layer.Tile({
        title: "Google Satellite & Roads",
        visible: false,
        'opacity': 1.000000,
        source: new ol.source.XYZ({
            attributions: [new ol.Attribution({
                html: '<a href=""></a>'
            })],
            url: 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
        })
    });

    var lrd_new_de = new ol.layer.Tile({
        title: "Open Street Map",
        visible: false,
        source: new ol.source.OSM({
            wrapX: false
        })
    });

    // ================================================================
    // PROJECTION SETUP
    // ================================================================
    var lrd_projObj = new ol.proj.Projection({
        code: 'EPSG:2136',
        extent: [80935.4497355444, 1209.0295731349593, 1711780.3060929566, 2358523.124783509],
        units: 'ft',
        axisOrientation: 'enu',
        global: false,
        worldExtent: [-3.79, 1.4, 2.1, 11.16],
        getPointResolution: function(r) {
            return r;
        }
    });

    ol.proj.setProj4(proj4);
    proj4.defs("EPSG:2136", '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs');

    var proj27700 = ol.proj.get('EPSG:2136');
    proj27700.setExtent([80935.4497355444, 1209.0295731349593, 1711780.3060929566, 2358523.124783509]);

    var lrd_view_e = new ol.View({
        projection: lrd_projObj,
        center: [1187433.58822084, 327091.107070208],
        extent: ol.proj.get('EPSG:2136').getExtent(),
        scales: [100000, 250000, 500000, 1000000, 2000000, 4000000, 8000000],
        zoom: 12
    });

    // ================================================================
    // MAP INITIALIZATION
    // ================================================================
    var lrd_map = new ol.Map({
        target: 'lrd-map',
        controls: ol.control.defaults().extend([
            new ol.control.LayerSwitcher(),
            new ol.control.OverviewMap(),
            new ol.control.ZoomSlider(),
            new ol.control.Attribution(),
            new ol.control.MousePosition(),
            new ol.control.ZoomToExtent(),
            new ol.control.FullScreen()
        ]),
        renderer: 'canvas',
        layers: [new ol.layer.Tile({
            title: 'Open Street',
            source: new ol.source.OSM()
        })],
        view: lrd_view_e
    });

    // Add layers to map
    lrd_map.addLayer(lrd_googleLayerHybrid);
    lrd_map.addLayer(lrd_StaticImage);
    lrd_map.addLayer(lrd_registration_district_dataLayer);
    lrd_map.addLayer(lrd_undergoing_registration_dataLayer);
    lrd_map.addLayer(lrd_spatial_blocked_dataLayer);
    lrd_map.addLayer(lrd_spatial_deleted_dataLayer);
    lrd_map.addLayer(lrd_grid_lrd_dataLayer);
    lrd_map.addLayer(lrd_grid_500_lrd_dataLayer);
    lrd_map.addLayer(smd_smd_current_dataLayer);
    lrd_map.addLayer(lrd_lrd_parcels_dataLayer);
    lrd_map.addLayer(lrd_pvlmd_searchLayer);
    lrd_map.addLayer(lrd_draw_layer);
    lrd_map.addLayer(lrd_measure_layer);
    lrd_map.addLayer(lrd_measure_label_layer);
    lrd_map.addLayer(lrd_markers);

    // ================================================================
    // FORMAT MEASUREMENT VALUES - IMPERIAL UNITS (FEET, MILES, ACRES)
    // ================================================================
    function formatLength(lengthInMeters) {
        // Convert meters to feet (1 meter = 3.28084 feet)
        var lengthInFeet = lengthInMeters * 3.28084;
        
        if (lengthInFeet >= 5280) { // 1 mile = 5280 feet
            return (lengthInFeet / 5280).toFixed(2) + ' mi';
        } else if (lengthInFeet >= 100) {
            return lengthInFeet.toFixed(2) + ' ft';
        } else {
            return lengthInFeet.toFixed(1) + ' ft';
        }
    }

    function formatArea(areaInMeters) {
        // Convert square meters to square feet (1 sq meter = 10.7639 sq feet)
        var areaInFeet = areaInMeters * 10.7639;
        
        if (areaInFeet >= 43560) { // 1 acre = 43560 sq feet
            return (areaInFeet / 43560).toFixed(2) + ' ac';
        } else if (areaInFeet >= 1000) {
            return areaInFeet.toFixed(2) + ' ft²';
        } else {
            return areaInFeet.toFixed(1) + ' ft²';
        }
    }

    // ================================================================
    // CLEAR DRAWING INTERACTIONS
    // ================================================================
    function clearDrawingInteractions() {
        if (lrd_draw_interaction) {
            lrd_map.removeInteraction(lrd_draw_interaction);
            lrd_draw_interaction = null;
        }
        if (lrd_modify_interaction) {
            lrd_map.removeInteraction(lrd_modify_interaction);
            lrd_modify_interaction = null;
        }
        if (lrd_measure_interaction) {
            lrd_map.removeInteraction(lrd_measure_interaction);
            lrd_measure_interaction = null;
            lrd_map.un('pointermove', updateMeasurementOnMove);
        }
        
        // Reset button states
        $('#lrd_btn_draw_polygon, #lrd_btn_modify_polygon, #lrd_btn_measure_distance, #lrd_btn_measure_area')
            .removeClass('active btn-primary btn-warning btn-success btn-info')
            .addClass('btn-outline-primary btn-outline-warning btn-outline-success btn-outline-info');
    }

    // ================================================================
    // CLEAR MEASUREMENTS
    // ================================================================
    function clearMeasurements() {
        if (lrd_measure_layer) {
            lrd_measure_layer.getSource().clear();
        }
        if (lrd_measure_label_layer) {
            lrd_measure_label_layer.getSource().clear();
        }
        lrd_measure_sketch = null;
        lrd_measure_label = null;
        
        lrd_map.un('pointermove', updateMeasurementOnMove);
        
        $('#lrd_btn_measure_distance, #lrd_btn_measure_area')
            .removeClass('active btn-success btn-info')
            .addClass('btn-outline-success btn-outline-info');
    }

    // ================================================================
    // TOAST NOTIFICATION
    // ================================================================
    function showToast(type, message) {
        $('.position-fixed.bottom-0.end-0').remove();
        
        var toastHtml = `
            <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
                <div class="toast align-items-center text-white bg-${type} border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'warning' ? 'exclamation-triangle' : 'info-circle'} me-2"></i>
                            ${message}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            </div>
        `;
        
        $('body').append(toastHtml);
        
        setTimeout(function() {
            $('.position-fixed.bottom-0.end-0').remove();
        }, 5000);
    }

    // ================================================================
    // CREATE TOOLTIP
    // ================================================================
    function createTooltip(feature, message, type) {
        var tooltipFeature = new ol.Feature({
            geometry: feature.getGeometry()
        });
        
        var color = type === 'success' ? '#28a745' : 
                    type === 'warning' ? '#ffc107' : '#17a2b8';
        var textColor = type === 'warning' ? '#000000' : '#ffffff';
        
        tooltipFeature.setStyle(new ol.style.Style({
            text: new ol.style.Text({
                text: message,
                font: '12px Calibri, sans-serif',
                fill: new ol.style.Fill({
                    color: textColor
                }),
                stroke: new ol.style.Stroke({
                    color: '#000000',
                    width: 2
                }),
                backgroundFill: new ol.style.Fill({
                    color: color
                }),
                padding: [4, 8, 4, 8],
                textAlign: 'center',
                textBaseline: 'middle',
                offsetY: -40
            })
        }));
        
        lrd_measure_label_layer.getSource().addFeature(tooltipFeature);
        return tooltipFeature;
    }

    // ================================================================
    // REMOVE TOOLTIP
    // ================================================================
    function removeTooltip(tooltip) {
        if (tooltip) {
            lrd_measure_label_layer.getSource().removeFeature(tooltip);
        }
    }

    // ================================================================
    // UPDATE MEASUREMENT LABEL
    // ================================================================
    function updateMeasurementLabel(geometry, type) {
        if (!lrd_measure_label) {
            return;
        }
        
        var measurement = '';
        var labelPoint = null;
        
        try {
            if (type === 'distance') {
                // Calculate length in meters
                var lengthInMeters = 0;
                if (ol.sphere && typeof ol.sphere.getLength === 'function') {
                    lengthInMeters = ol.sphere.getLength(geometry, {
                        projection: lrd_map.getView().getProjection()
                    });
                } else {
                    var coords = geometry.getCoordinates();
                    for (var i = 0; i < coords.length - 1; i++) {
                        var p1 = coords[i];
                        var p2 = coords[i + 1];
                        var dx = p2[0] - p1[0];
                        var dy = p2[1] - p1[1];
                        lengthInMeters += Math.sqrt(dx * dx + dy * dy);
                    }
                }
                measurement = formatLength(lengthInMeters);
                
                var coords = geometry.getCoordinates();
                var midIndex = Math.floor(coords.length / 2);
                labelPoint = new ol.geom.Point(coords[midIndex] || coords[0]);
                
            } else if (type === 'area') {
                var areaInMeters = 0;
                if (ol.sphere && typeof ol.sphere.getArea === 'function') {
                    areaInMeters = ol.sphere.getArea(geometry, {
                        projection: lrd_map.getView().getProjection()
                    });
                } else {
                    var coords = geometry.getCoordinates()[0];
                    for (var i = 0; i < coords.length - 1; i++) {
                        var p1 = coords[i];
                        var p2 = coords[i + 1];
                        areaInMeters += (p1[0] * p2[1] - p2[0] * p1[1]);
                    }
                    areaInMeters = Math.abs(areaInMeters) / 2;
                }
                measurement = formatArea(areaInMeters);
                
                var polygon = geometry;
                var center = polygon.getInteriorPoint ? 
                    polygon.getInteriorPoint().getCoordinates() : 
                    polygon.getFirstCoordinate();
                labelPoint = new ol.geom.Point(center);
            }
            
            lrd_measure_label.setGeometry(labelPoint);
            lrd_measure_label.setStyle(new ol.style.Style({
                text: new ol.style.Text({
                    text: measurement,
                    font: '14px Calibri, sans-serif',
                    fill: new ol.style.Fill({
                        color: '#000000'
                    }),
                    stroke: new ol.style.Stroke({
                        color: '#ffffff',
                        width: 3
                    }),
                    backgroundFill: new ol.style.Fill({
                        color: 'rgba(255, 255, 255, 0.85)'
                    }),
                    padding: [4, 8, 4, 8],
                    textAlign: 'center',
                    textBaseline: 'middle',
                    offsetY: -20
                })
            }));
        } catch (error) {
            console.error('Error updating measurement label:', error);
        }
    }

    // ================================================================
    // UPDATE MEASUREMENT ON POINTER MOVE
    // ================================================================
    function updateMeasurementOnMove(event) {
        if (!lrd_measure_interaction || !lrd_measure_sketch) {
            return;
        }
        
        try {
            var sketch = lrd_measure_sketch;
            var geometry = sketch.getGeometry();
            
            if (!geometry) {
                return;
            }
            
            var coords = geometry.getCoordinates();
            
            if (geometry.getType() === 'LineString') {
                var currentPoint = event.coordinate;
                var tempCoords = coords.slice();
                tempCoords.push(currentPoint);
                var tempGeometry = new ol.geom.LineString(tempCoords);
                updateMeasurementLabel(tempGeometry, 'distance');
            } else if (geometry.getType() === 'Polygon') {
                var rings = geometry.getCoordinates();
                if (rings && rings.length > 0) {
                    var ring = rings[0];
                    var tempRing = ring.slice();
                    tempRing.push(event.coordinate);
                    var tempPolygon = new ol.geom.Polygon([tempRing]);
                    updateMeasurementLabel(tempPolygon, 'area');
                }
            }
        } catch (error) {
            console.error('Error in updateMeasurementOnMove:', error);
        }
    }

    // ================================================================
    // UPDATE FINAL MEASUREMENT
    // ================================================================
    function updateMeasurement(feature) {
        var geometry = feature.getGeometry();
        if (!geometry) {
            return;
        }
        
        var measurement = '';
        var labelPoint = null;
        
        try {
            if (lrd_measure_type === 'distance') {
                var lengthInMeters = 0;
                if (ol.sphere && typeof ol.sphere.getLength === 'function') {
                    lengthInMeters = ol.sphere.getLength(geometry, {
                        projection: lrd_map.getView().getProjection()
                    });
                } else {
                    var coords = geometry.getCoordinates();
                    for (var i = 0; i < coords.length - 1; i++) {
                        var p1 = coords[i];
                        var p2 = coords[i + 1];
                        var dx = p2[0] - p1[0];
                        var dy = p2[1] - p1[1];
                        lengthInMeters += Math.sqrt(dx * dx + dy * dy);
                    }
                }
                measurement = formatLength(lengthInMeters);
                
                var coords = geometry.getCoordinates();
                var midIndex = Math.floor(coords.length / 2);
                labelPoint = new ol.geom.Point(coords[midIndex] || coords[0]);
                
            } else {
                var areaInMeters = 0;
                if (ol.sphere && typeof ol.sphere.getArea === 'function') {
                    areaInMeters = ol.sphere.getArea(geometry, {
                        projection: lrd_map.getView().getProjection()
                    });
                } else {
                    var coords = geometry.getCoordinates()[0];
                    for (var i = 0; i < coords.length - 1; i++) {
                        var p1 = coords[i];
                        var p2 = coords[i + 1];
                        areaInMeters += (p1[0] * p2[1] - p2[0] * p1[1]);
                    }
                    areaInMeters = Math.abs(areaInMeters) / 2;
                }
                measurement = formatArea(areaInMeters);
                
                var polygon = geometry;
                var center = polygon.getInteriorPoint ? 
                    polygon.getInteriorPoint().getCoordinates() : 
                    polygon.getFirstCoordinate();
                labelPoint = new ol.geom.Point(center);
            }
            
            if (lrd_measure_label) {
                lrd_measure_label.setGeometry(labelPoint);
                lrd_measure_label.setStyle(new ol.style.Style({
                    text: new ol.style.Text({
                        text: measurement,
                        font: '16px Calibri, sans-serif',
                        fill: new ol.style.Fill({
                            color: '#000000'
                        }),
                        stroke: new ol.style.Stroke({
                            color: '#ffffff',
                            width: 4
                        }),
                        backgroundFill: new ol.style.Fill({
                            color: 'rgba(255, 255, 0, 0.9)'
                        }),
                        padding: [6, 12, 6, 12],
                        textAlign: 'center',
                        textBaseline: 'middle',
                        offsetY: -25
                    })
                }));
            }
            
            var resultMsg = (lrd_measure_type === 'distance') ? 
                'Distance: ' + measurement : 
                'Area: ' + measurement;
            showToast('success', resultMsg);
            
            lrd_map.un('pointermove', updateMeasurementOnMove);
        } catch (error) {
            console.error('Error updating measurement:', error);
            showToast('error', 'Error calculating measurement');
        }
    }

    // ================================================================
    // ACTIVATE LIVE MEASURE TOOL
    // ================================================================
    function activateLiveMeasureTool() {
        clearDrawingInteractions();
        clearMeasurements();
        
        if (lrd_measure_label_layer) {
            lrd_measure_label_layer.getSource().clear();
        }
        
        var type = (lrd_measure_type === 'area') ? 'Polygon' : 'LineString';
        
        lrd_measure_interaction = new ol.interaction.Draw({
            source: lrd_measure_layer.getSource(),
            type: type,
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(0, 255, 0, 0.1)'
                }),
                stroke: new ol.style.Stroke({
                    color: '#00ff00',
                    width: 2,
                    lineDash: [4, 4]
                }),
                image: new ol.style.Circle({
                    radius: 5,
                    fill: new ol.style.Fill({
                        color: '#00ff00'
                    })
                })
            })
        });
        
        lrd_measure_interaction.on('drawstart', function(event) {
            try {
                lrd_measure_sketch = event.feature;
                
                var helpMsg = (lrd_measure_type === 'area') ? 
                    'Click to add points to measure area. Double-click to finish.' : 
                    'Click to add points to measure distance. Double-click to finish.';
                lrd_measure_helpTooltip = createTooltip(lrd_measure_sketch, helpMsg, 'info');
                
                lrd_measure_label = new ol.Feature({
                    geometry: new ol.geom.Point([0, 0])
                });
                lrd_measure_label_layer.getSource().addFeature(lrd_measure_label);
                
                lrd_measure_label.setStyle(new ol.style.Style({
                    text: new ol.style.Text({
                        font: '14px Calibri, sans-serif',
                        fill: new ol.style.Fill({
                            color: '#000000'
                        }),
                        stroke: new ol.style.Stroke({
                            color: '#ffffff',
                            width: 3
                        }),
                        backgroundFill: new ol.style.Fill({
                            color: 'rgba(255, 255, 255, 0.85)'
                        }),
                        padding: [4, 8, 4, 8],
                        textAlign: 'center',
                        textBaseline: 'middle',
                        offsetY: -20
                    })
                }));
                
                lrd_measure_interaction.on('drawend', function(event) {
                    removeTooltip(lrd_measure_helpTooltip);
                    removeTooltip(lrd_measure_continueTooltip);
                    
                    updateMeasurement(event.feature);
                    
                    lrd_measure_continueTooltip = createTooltip(
                        event.feature, 
                        'Measurement complete. Press Escape to clear.', 
                        'success'
                    );
                    
                    setTimeout(function() {
                        removeTooltip(lrd_measure_continueTooltip);
                    }, 3000);
                });
                
                lrd_map.on('pointermove', updateMeasurementOnMove);
            } catch (error) {
                console.error('Error in drawstart:', error);
            }
        });
        
        lrd_map.addInteraction(lrd_measure_interaction);
    }

    // ================================================================
    // DRAW POLYGON TOOL
    // ================================================================
    document.getElementById('lrd_btn_draw_polygon').addEventListener('click', function() {
        clearDrawingInteractions();
        
        lrd_draw_interaction = new ol.interaction.Draw({
            source: lrd_draw_layer.getSource(),
            type: 'Polygon',
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(255, 0, 0, 0.2)'
                }),
                stroke: new ol.style.Stroke({
                    color: '#ff0000',
                    width: 2
                }),
                image: new ol.style.Circle({
                    radius: 6,
                    fill: new ol.style.Fill({
                        color: '#ff0000'
                    })
                })
            })
        });
        
        lrd_draw_interaction.on('drawend', function(event) {
            var feature = event.feature;
            var geometry = feature.getGeometry();
            var wkt = new ol.format.WKT().writeGeometry(geometry);
            
            $('#lrd_txt_wkt_polygon').val(wkt);
            
            lrd_pvlmd_searchLayer.setSource(new ol.source.Vector({
                features: [feature]
            }));
            
            lrd_map.getView().fit(lrd_pvlmd_searchLayer.getSource().getExtent(), {
                size: lrd_map.getSize(),
                maxZoom: 16
            });
            
            showToast('success', 'Polygon drawn successfully!');
        });
        
        lrd_map.addInteraction(lrd_draw_interaction);
        $(this).addClass('active btn-primary').removeClass('btn-outline-primary');
        showToast('info', 'Click on the map to draw a polygon. Double-click to finish.');
    });

    // ================================================================
    // MODIFY POLYGON TOOL
    // ================================================================
    document.getElementById('lrd_btn_modify_polygon').addEventListener('click', function() {
        clearDrawingInteractions();
        
        var features = lrd_draw_layer.getSource().getFeatures();
        if (features.length === 0) {
            showToast('warning', 'No polygon to modify. Draw a polygon first.');
            return;
        }
        
        lrd_modify_interaction = new ol.interaction.Modify({
            source: lrd_draw_layer.getSource(),
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 0, 0.2)'
                }),
                stroke: new ol.style.Stroke({
                    color: '#ffcc00',
                    width: 3
                }),
                image: new ol.style.Circle({
                    radius: 8,
                    fill: new ol.style.Fill({
                        color: '#ffcc00'
                    })
                })
            })
        });
        
        lrd_modify_interaction.on('modifyend', function(event) {
            var features = event.features.getArray();
            if (features.length > 0) {
                var geometry = features[0].getGeometry();
                var wkt = new ol.format.WKT().writeGeometry(geometry);
                $('#lrd_txt_wkt_polygon').val(wkt);
                showToast('success', 'Polygon modified successfully!');
            }
        });
        
        lrd_map.addInteraction(lrd_modify_interaction);
        $(this).addClass('active btn-warning').removeClass('btn-outline-warning');
        showToast('info', 'Click and drag vertices to modify the polygon.');
    });

    // ================================================================
    // DELETE POLYGON TOOL
    // ================================================================
    document.getElementById('lrd_btn_delete_polygon').addEventListener('click', function() {
        var features = lrd_draw_layer.getSource().getFeatures();
        if (features.length === 0) {
            showToast('warning', 'No polygon to delete.');
            return;
        }
        
        if (confirm('Are you sure you want to delete the current polygon?')) {
            lrd_draw_layer.getSource().clear();
            $('#lrd_txt_wkt_polygon').val('');
            showToast('success', 'Polygon deleted successfully!');
        }
    });

    // ================================================================
    // MEASURE DISTANCE TOOL
    // ================================================================
    document.getElementById('lrd_btn_measure_distance').addEventListener('click', function() {
        lrd_measure_type = 'distance';
        activateLiveMeasureTool();
        $(this).addClass('active btn-success').removeClass('btn-outline-success');
        showToast('info', 'Click on the map to measure distance. Double-click to finish.');
    });

    // ================================================================
    // MEASURE AREA TOOL
    // ================================================================
    document.getElementById('lrd_btn_measure_area').addEventListener('click', function() {
        lrd_measure_type = 'area';
        activateLiveMeasureTool();
        $(this).addClass('active btn-info').removeClass('btn-outline-info');
        showToast('info', 'Click on the map to measure area. Double-click to finish.');
    });

    // ================================================================
    // CLEAR MEASUREMENTS BUTTON
    // ================================================================
    document.getElementById('lrd_btn_clear_measurements').addEventListener('click', function() {
        clearMeasurements();
        showToast('success', 'Measurements cleared.');
    });

    // ================================================================
    // REFRESH MAP
    // ================================================================
    document.getElementById('lrd_btn_refresh_btn_wkt').addEventListener('click', function() {
        clearDrawingInteractions();
        clearMeasurements();
        lrd_draw_layer.getSource().clear();
        if (lrd_pvlmd_searchLayer) {
            lrd_pvlmd_searchLayer.getSource().clear();
        }
        $('#lrd_txt_wkt_polygon').val('');
        showToast('info', 'Map refreshed. All drawings and measurements cleared.');
    });

    // ================================================================
    // KEYBOARD SHORTCUTS
    // ================================================================
    document.addEventListener('keydown', function(e) {
        if (e.key === 'd' || e.key === 'D') {
            if (!e.ctrlKey && !e.metaKey) {
                document.getElementById('lrd_btn_draw_polygon').click();
            }
        }
        if (e.key === 'm' || e.key === 'M') {
            if (!e.ctrlKey && !e.metaKey) {
                document.getElementById('lrd_btn_modify_polygon').click();
            }
        }
        if (e.key === 'r' || e.key === 'R') {
            if (!e.ctrlKey && !e.metaKey) {
                document.getElementById('lrd_btn_measure_distance').click();
            }
        }
        if (e.key === 'a' || e.key === 'A') {
            if (!e.ctrlKey && !e.metaKey) {
                document.getElementById('lrd_btn_measure_area').click();
            }
        }
        if (e.key === 'Escape') {
            clearDrawingInteractions();
            showToast('info', 'Drawing/Measurement cancelled.');
        }
    });

    // ================================================================
    // ADD STYLING FOR ACTIVE BUTTONS
    // ================================================================
    $('head').append(`
        <style>
            .btn.active {
                box-shadow: 0 0 0 3px rgba(0,0,0,0.2);
                transform: scale(0.95);
            }
            .btn-outline-primary.active {
                background-color: #0d6efd;
                color: white;
            }
            .btn-outline-warning.active {
                background-color: #ffc107;
                color: white;
            }
            .btn-outline-success.active {
                background-color: #198754;
                color: white;
            }
            .btn-outline-info.active {
                background-color: #0dcaf0;
                color: white;
            }
            .toast {
                min-width: 300px;
            }
            .bg-success .toast-body {
                background-color: #198754;
            }
            .bg-warning .toast-body {
                background-color: #ffc107;
                color: #000;
            }
            .bg-info .toast-body {
                background-color: #0dcaf0;
                color: #000;
            }
            .bg-danger .toast-body {
                background-color: #dc3545;
            }
        </style>
    `);

    // ================================================================
    // VISUALISE COORDINATE
    // ================================================================
    document.getElementById('lrd_btn_visualise_coordinate').addEventListener('click', function() {
        var polygonGroups = {};
        
        $('#coordinatelis_Table tbody tr').each(function() {
            var name = $(this).find('td:eq(0)').text().trim();
            var x = parseFloat($(this).find('td:eq(1)').text().trim());
            var y = parseFloat($(this).find('td:eq(2)').text().trim());
            
            var parts = name.split('-');
            var polygonId = parts[0] || 'polygon1';
            var ringType = parts[1] || 'outer';
            
            if (!polygonGroups[polygonId]) {
                polygonGroups[polygonId] = { outer: [], inner: [] };
            }
            
            if (ringType === 'inner') {
                polygonGroups[polygonId].inner.push({x: x, y: y});
            } else {
                polygonGroups[polygonId].outer.push({x: x, y: y});
            }
        });

        function calculateArea(points) {
            var area = 0;
            for (var i = 0; i < points.length - 1; i++) {
                area += (points[i].x * points[i+1].y - points[i+1].x * points[i].y);
            }
            var last = points.length - 1;
            area += (points[last].x * points[0].y - points[0].x * points[last].y);
            return area / 2;
        }

        function reverseRing(points) {
            return points.slice().reverse();
        }

        var polygons = [];
        Object.keys(polygonGroups).forEach(function(key) {
            var group = polygonGroups[key];
            
            var outerArea = calculateArea(group.outer);
            if (outerArea < 0) {
                group.outer = reverseRing(group.outer);
            }
            
            if (group.inner.length > 0) {
                var innerArea = calculateArea(group.inner);
                if (innerArea > 0) {
                    group.inner = reverseRing(group.inner);
                }
            }
            
            if (group.outer.length > 0) {
                group.outer.push(group.outer[0]);
            }
            if (group.inner.length > 0) {
                group.inner.push(group.inner[0]);
            }
            
            var outerWKT = group.outer.map(function(p) { return p.y + " " + p.x; }).join(', ');
            var polygonWKT = "((" + outerWKT;
            
            if (group.inner.length > 0) {
                var innerWKT = group.inner.map(function(p) { return p.y + " " + p.x; }).join(', ');
                polygonWKT += ", " + innerWKT;
            }
            
            polygonWKT += "))";
            polygons.push(polygonWKT);
        });

        var wkt;
        if (polygons.length === 1) {
            wkt = "POLYGON" + polygons[0];
        } else {
            wkt = "MULTIPOLYGON(" + polygons.join(', ') + ")";
        }

        $('#lrd_txt_wkt_polygon').val(wkt);
        
        try {
            lrd_pvlmd_searchLayer.setSource(new ol.source.Vector({
                features: (new ol.format.WKT()).readFeatures(wkt)
            }));
            
            lrd_view_e.fit(lrd_pvlmd_searchLayer.getSource().getExtent());
            lrd_map.getView().fit(lrd_pvlmd_searchLayer.getSource().getExtent(), {
                size: lrd_map.getSize(),
                maxZoom: 16
            });
        } catch (error) {
            console.log('Map update error:', error);
            alert('Error rendering polygon: ' + error.message);
        }
    });

    // ================================================================
    // SHOW LOCATION
    // ================================================================
    document.getElementById('lrd_btn_show_location').addEventListener('click', function() {
        lrd_markers.getSource().clear();
        var x_coordinate_mak = $('#lrd_x_coordinate').val();
        var y_coordinate_mak = $('#lrd_y_coordinate').val();
        
        var marker = new ol.Feature({
            geometry: new ol.geom.Point([x_coordinate_mak, y_coordinate_mak])
        });
        
        lrd_markers.getSource().addFeature(marker);
        lrd_map.getView().fit(lrd_markers.getSource().getExtent(), {
            size: lrd_map.getSize(),
            maxZoom: 16
        });
    });

    // ================================================================
    // SCALE CHANGE
    // ================================================================
    $('#lrd_scale_value').change(function() {
        $('#lrd_scale_value_e').val($(this).val());
        var view = lrd_map.getView();
        view.setResolution(ol.proj.getPointResolution(
            view.getProjection(),
            getResolutionFromScale($(this).val()),
            view.getCenter()
        ));
        click_map_zoom_value = false;
    });

    // ================================================================
    // HELPER FUNCTION FOR SCALE
    // ================================================================
    function getResolutionFromScale(scale) {
        var units = lrd_map.getView().getProjection().getUnits();
        var dpi = 25.4 / 0.28;
        var mpu = ol.proj.METERS_PER_UNIT[units];
        var resolution = scale / (mpu * 39.37 * dpi);
        return resolution;
    }

    // ================================================================
    // SCALE ZOOM
    // ================================================================
    var click_map_zoom_value = true;
    document.getElementById('lrd_btn_scale_zoom').addEventListener('click', function() {
        var scale_value = $('#lrd_scale_value_e').val();
        var view = lrd_map.getView();
        view.setResolution(ol.proj.getPointResolution(
            view.getProjection(),
            getResolutionFromScale(scale_value),
            view.getCenter()
        ));
        click_map_zoom_value = false;
    });

    // ================================================================
    // LOCK MAP SCALE
    // ================================================================
    document.getElementById('lrd_lockmapscale').addEventListener('click', function() {
        if (document.getElementById("lrd_lockmapscale").checked) {
            var MouseWheelZoomClickInteraction;
            lrd_map.getInteractions().getArray().forEach(function(interaction) {
                if (interaction instanceof ol.interaction.MouseWheelZoom) {
                    MouseWheelZoomClickInteraction = interaction;
                }
            });
            lrd_map.removeInteraction(MouseWheelZoomClickInteraction);

            var dblClickInteraction;
            lrd_map.getInteractions().getArray().forEach(function(interaction) {
                if (interaction instanceof ol.interaction.DoubleClickZoom) {
                    dblClickInteraction = interaction;
                }
            });
            lrd_map.removeInteraction(dblClickInteraction);
        } else {
            var dblClickInteraction = new ol.interaction.DoubleClickZoom({ delta: 0 });
            lrd_map.addInteraction(dblClickInteraction);
            var MouseWheelZoomClickInteraction = new ol.interaction.MouseWheelZoom({ delta: 0 });
            lrd_map.addInteraction(MouseWheelZoomClickInteraction);
        }
    });

    // ================================================================
    // VISUALISE WKT
    // ================================================================
    document.getElementById('lrd_btn_visualise_wkt').addEventListener('click', function() {
        var wktplygonsearch = $('#lrd_txt_wkt_polygon').val();
        console.log(wktplygonsearch);

        lrd_pvlmd_searchLayer.setSource(new ol.source.Vector({
            features: (new ol.format.WKT()).readFeatures(wktplygonsearch)
        }));
        
        var extent = lrd_pvlmd_searchLayer.getSource().getExtent();
        lrd_map.getView().fit(extent, {
            size: lrd_map.getSize(),
            maxZoom: 16
        });
    });

    // ================================================================
    // MAP CLICK EVENT - Your existing code
    // ================================================================
    lrd_map.on('click', function(evt) {
        var viewResolution = lrd_map.getView().getResolution();
        var viewProjection = lrd_map.getView().getProjection();

        if (lrd_click_type === 'MapClick') {
            var coordinate = evt.coordinate;
            console.log(coordinate);
            
            var url = lrd_parcel_lrd_dataSource.getGetFeatureInfoUrl(
                evt.coordinate,
                viewResolution,
                viewProjection,
                {
                    'INFO_FORMAT': 'application/json',
                    'propertyName': 'reference_number,locality,plotted_by,date_plott,checked_by,type_of_plotting,modified_by,modified_date',
                    'FEATURE_COUNT': 50
                }
            );

            if (url) {
                console.log(url);
                $.ajax({
                    type: "GET",
                    url: url,
                    cache: false,
                    success: function(serviceresponse) {
                        console.log('service response');
                        console.log(serviceresponse);
                        console.log('FEATURES');
                        var feature = serviceresponse.features;
                        console.log(serviceresponse.features);
                        console.log('feature count');
                        console.log(feature.length);

                        var table = $('#lrd_more_than_one_parcel_Table');
                        table.find("tbody tr").remove();

                        if (feature.length > 1) {
                            var features = feature;
                            for (var i = 0, len = features.length; i < len; i++) {
                                var props = features[i].properties;
                                var iid = features[i].id;
                                var words = iid.split('.');
                                var parcel_uuid = words[1];
                                console.log(parcel_uuid);

                                table.append(
                                    "<tr><td>" + props.reference_number + 
                                    "</td><td>" + props.locality + 
                                    "</td><td>" + props.type_of_plotting + 
                                    "</td>" +
                                    '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client">' +
                                    '<button class="btn btn-success btn-circle btn-sm" data-title="Delete" data-toggle="modal" data-target="#lrdparcelIndormation" ' +
                                    'data-parcel_uuid="' + parcel_uuid + '" ' +
                                    'data-reference_number="' + props.reference_number + '" ' +
                                    'data-locality="' + props.locality + '" ' +
                                    'data-plotted_by="' + props.plotted_by + '" ' +
                                    'data-date_plott="' + props.date_plott + '" ' +
                                    'data-checked_by="' + props.checked_by + '" ' +
                                    'data-type_of_plotting="' + props.type_of_plotting + '" ' +
                                    'id="deletede"><span class="fas fa-check"></span></button></p> </td>' +
                                    "</tr>"
                                );
                            }
                        } else {
                            var table_bp = $('#coordinatelis_Table');
                            table_bp.find("tbody tr").remove();
                            $("#lrd_btn_save_wkt").prop("disabled", true);

                            var feature1 = serviceresponse.features[0];
                            if (feature1) {
                                var props = feature1.properties;
                                var spatial_id = feature1.id;
                                var words = spatial_id.split('.');
                                var parcel_uuid = words[1];
                                console.log(parcel_uuid);

                                $("#lrdparcelIndormation").modal('show');

                                $('#lrdparcelIndormation #lrd_ps_fid').val(parcel_uuid);
                                $('#lrdparcelIndormation #lrd_ps_reference_number').val(props.reference_number);
                                $('#lrdparcelIndormation #lrd_ps_locality').val(props.locality);
                                $('#lrdparcelIndormation #lrd_ps_plotted_by').val(props.plotted_by);
                                $('#lrdparcelIndormation #lrd_ps_date_plott').val(props.date_plott);
                                $('#lrdparcelIndormation #lrd_ps_checked_by').val(props.checked_by);
                                $('#lrdparcelIndormation #lrd_ps_type_of_plotting').val(props.type_of_plotting);
                                $('#lrdparcelIndormation #lrd_ps_modified_by').val(props.modified_by);
                                $('#lrdparcelIndormation #lrd_ps_modified_date').val(props.modified_date);

                                // Load transactions
                                var table = $('#lrd_transaction_dataTable');
                                table.find("tbody tr").remove();
                                table.append("<tr><td colspan='5' class='text-center'>Loading transactions...</td></tr>");

                                $.ajax({
                                    type: "POST",
                                    url: 'Maps',
                                    data: {
                                        request_type: 'load_lrd_transaction_details',
                                        fid_fk: parcel_uuid
                                    },
                                    cache: false,
                                    success: function(serviceresponse) {
                                        try {
                                            var json_p = typeof serviceresponse === 'object' ? serviceresponse : JSON.parse(serviceresponse);
                                            console.log('Transaction Details:', json_p);
                                            table.find("tbody tr").remove();
                                            
                                            if (json_p && json_p.data && Array.isArray(json_p.data)) {
                                                if (json_p.data.length === 0) {
                                                    table.append("<tr><td colspan='5' class='text-center'>No transactions found</td></tr>");
                                                } else {
                                                    $.each(json_p.data, function(index, item) {
                                                        table.append(
                                                            "<tr>" +
                                                                "<td>" + (item.applicant_name || 'N/A') + "</td>" +
                                                                "<td>" + (item.grantor_name || 'N/A') + "</td>" +
                                                                "<td>" + (item.certicate_number || 'N/A') + "</td>" +
                                                                "<td>" + (item.nature_of_instument || 'N/A') + "</td>" +
                                                                '<td><button class="btn btn-info btn-sm btn-details" ' +
                                                                'data-gid="' + (item.gid || '') + '" ' +
                                                                'data-applicant="' + (item.applicant_name || '') + '" ' +
                                                                'data-grantor="' + (item.grantor_name || '') + '" ' +
                                                                'data-certificate="' + (item.certicate_number || '') + '" ' +
                                                                'data-instrument="' + (item.nature_of_instument || '') + '" ' +
                                                                'data-date-reg="' + (item.date_of_registration || '') + '" ' +
                                                                'data-date-inst="' + (item.date_of_instument || '') + '" ' +
                                                                'data-volume="' + (item.volume || '') + '" ' +
                                                                'data-folio="' + (item.folio || '') + '" ' +
                                                                'data-consideration="' + (item.consideration || '') + '" ' +
                                                                'data-purpose="' + (item.purpose || '') + '" ' +
                                                                'data-term="' + (item.term || '') + '" ' +
                                                                'data-remarks="' + (item.remarks || '') + '" ' +
                                                                'data-type-reg="' + (item.type_of_registration || '') + '" ' +
                                                                'data-cc-number="' + (item.cc_number || '') + '" ' +
                                                                'data-job-number="' + (item.job_number || '') + '" ' +
                                                                'data-land-size="' + (item.land_size || '') + '" ' +
                                                                'data-encumbrance="' + (item.encumbrance || '') + '" ' +
                                                                'data-type-cert="' + (item.type_of_certificate || '') + '" ' +
                                                                'data-reg-number="' + (item.registered_number || '') + '" ' +
                                                                'data-type-instrument="' + (item.type_instrument || '') + '" ' +
                                                                'data-date-issued="' + (item.date_of_issued_cert_no || '') + '" ' +
                                                                'data-plan-number="' + (item.plan_number || '') + '" ' +
                                                                'data-modified-by="' + (item.modified_by || '') + '" ' +
                                                                'data-modified-date="' + (item.modified_date || '') + '" ' +
                                                                'title="View Details">' +
                                                                '<i class="fas fa-info-circle"></i> Details' +
                                                                '</button></td>' +
                                                            "</tr>"
                                                        );
                                                    });
                                                }
                                            }
                                        } catch (error) {
                                            console.error('Error processing transaction details:', error);
                                            table.find("tbody tr").remove();
                                            table.append("<tr><td colspan='5' class='text-center text-danger'>Error loading transactions</td></tr>");
                                        }
                                    },
                                    error: function(xhr, status, error) {
                                        console.error('AJAX Error - load_lrd_transaction_details:', error);
                                        table.find("tbody tr").remove();
                                        table.append("<tr><td colspan='5' class='text-center text-danger'>Failed to load transactions</td></tr>");
                                    }
                                });

                                // Load memorials
                                var table_encumbrance = $('#lrd_memorial_encumbrance_details_dataTable');
                                table_encumbrance.find("tbody tr").remove();
                                table_encumbrance.append("<tr><td colspan='5' class='text-center'>Loading memorials...</td></tr>");

                                $.ajax({
                                    type: "POST",
                                    url: 'lrd_memorials_section_serv',
                                    data: {
                                        request_type: 'select_lrd_memorials_section_all_by_case_number',
                                        case_number: props.reference_number
                                    },
                                    cache: false,
                                    success: function(serviceresponse) {
                                        try {
                                            var json_p = typeof serviceresponse === 'object' ? serviceresponse : JSON.parse(serviceresponse);
                                            table_encumbrance.find("tbody tr").remove();
                                            
                                            if (json_p && json_p.data && Array.isArray(json_p.data)) {
                                                if (json_p.data.length === 0) {
                                                    table_encumbrance.append("<tr><td colspan='5' class='text-center'>No memorials found</td></tr>");
                                                } else {
                                                    $.each(json_p.data, function(index, item) {
                                                        table_encumbrance.append(
                                                            "<tr>" +
                                                                "<td>" + (item.m_registered_no || 'N/A') + "</td>" +
                                                                "<td>" + (item.m_memorials || 'N/A') + "</td>" +
                                                                "<td>" + (item.m_date_of_instrument || 'N/A') + "</td>" +
                                                                "<td>" + (item.m_date_of_registration || 'N/A') + "</td>" +
                                                                '<td><button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#lrdpEncumbranceModal" data-target-id="' + (item.case_number || '') + '"><i class="fas fa-info-circle"></i> Details</button></td>' +
                                                            "</tr>"
                                                        );
                                                    });
                                                }
                                            }
                                        } catch (error) {
                                            console.error('Error processing memorials:', error);
                                            table_encumbrance.find("tbody tr").remove();
                                            table_encumbrance.append("<tr><td colspan='5' class='text-center text-danger'>Error loading memorials</td></tr>");
                                        }
                                    },
                                    error: function(xhr, status, error) {
                                        console.error('AJAX Error - select_lrd_memorials_section_all_by_case_number:', error);
                                        table_encumbrance.find("tbody tr").remove();
                                        table_encumbrance.append("<tr><td colspan='5' class='text-center text-danger'>Failed to load memorials</td></tr>");
                                    }
                                });

                                // Load scanned documents
                                var table_docs = $('#lrd_scanned_documents_dataTable');
                                table_docs.find("tbody tr").remove();
                                table_docs.append("<tr><td colspan='2' class='text-center'>Loading documents...</td></tr>");

                                $.ajax({
                                    type: "POST",
                                    url: 'LoadLRDJackets',
                                    data: {
                                        request_type: 'load_lrd_jacket_certificate',
                                        certificate_number: props.reference_number
                                    },
                                    cache: false,
                                    success: function(serviceresponse) {
                                        try {
                                            var json_p = typeof serviceresponse === 'object' ? serviceresponse : JSON.parse(serviceresponse);
                                            table_docs.find("tbody tr").remove();
                                            
                                            var dataArray = Array.isArray(json_p) ? json_p : (json_p && json_p.data ? json_p.data : []);
                                            
                                            if (dataArray.length === 0) {
                                                table_docs.append("<tr><td colspan='2' class='text-center'>No documents found</td></tr>");
                                            } else {
                                                $.each(dataArray, function(index, item) {
                                                    var docName = item.document_name || 'Unnamed';
                                                    var docExt = item.document_extention || 'N/A';
                                                    var docFile = item.document_file || '#';
                                                    
                                                    table_docs.append(
                                                        "<tr>" +
                                                            '<td><a class="link-post" href="' + docFile + '" target="_blank">' + docName + '</a></td>' +
                                                            "<td>" + docExt + "</td>" +
                                                        "</tr>"
                                                    );
                                                });
                                            }
                                        } catch (error) {
                                            console.error('Error processing scanned documents:', error);
                                            table_docs.find("tbody tr").remove();
                                            table_docs.append("<tr><td colspan='2' class='text-center text-danger'>Error loading documents</td></tr>");
                                        }
                                    },
                                    error: function(xhr, status, error) {
                                        console.error('AJAX Error - load_lrd_jacket_certificate:', error);
                                        table_docs.find("tbody tr").remove();
                                        table_docs.append("<tr><td colspan='2' class='text-center text-danger'>Failed to load documents</td></tr>");
                                    }
                                });
                            }
                        }
                    },
                    failure: function(errormsg) {
                        console.log(errormsg);
                    }
                });
            }
        }
    });

    // ================================================================
    // REFRESH WKT BUTTON
    // ================================================================
    $("#lrd_btn_refresh_btn_wkt").on("click", function() {
        $("#lrd_btn_save_wkt").prop("disabled", false);
        $('#lrd_txt_wkt_polygon').val("");
    });

    // ================================================================
    // DETAILS BUTTON CLICK HANDLER
    // ================================================================
    $(document).on('click', '.btn-details', function() {
        var gid = $(this).data('gid');
        var applicant = $(this).data('applicant') || 'N/A';
        var grantor = $(this).data('grantor') || 'N/A';
        var certificate = $(this).data('certificate') || 'N/A';
        var instrument = $(this).data('instrument') || 'N/A';
        var dateReg = $(this).data('date-reg') || 'N/A';
        var dateInst = $(this).data('date-inst') || 'N/A';
        var volume = $(this).data('volume') || 'N/A';
        var folio = $(this).data('folio') || 'N/A';
        var consideration = $(this).data('consideration') || 'N/A';
        var purpose = $(this).data('purpose') || 'N/A';
        var term = $(this).data('term') || 'N/A';
        var remarks = $(this).data('remarks') || 'N/A';
        var typeReg = $(this).data('type-reg') || 'N/A';
        var ccNumber = $(this).data('cc-number') || 'N/A';
        var jobNumber = $(this).data('job-number') || 'N/A';
        var landSize = $(this).data('land-size') || 'N/A';
        var encumbrance = $(this).data('encumbrance') || 'N/A';
        var typeCert = $(this).data('type-cert') || 'N/A';
        var regNumber = $(this).data('reg-number') || 'N/A';
        var typeInstrument = $(this).data('type-instrument') || 'N/A';
        var dateIssued = $(this).data('date-issued') || 'N/A';
        var planNumber = $(this).data('plan-number') || 'N/A';
        var modifiedBy = $(this).data('modified-by') || 'N/A';
        var modifiedDate = $(this).data('modified-date') || 'N/A';
        
        updateSummaryPanel(
            gid, applicant, grantor, certificate, instrument,
            dateReg, dateInst, volume, folio, consideration,
            purpose, term, remarks, typeReg, ccNumber,
            jobNumber, landSize, encumbrance, typeCert,
            regNumber, typeInstrument, dateIssued, planNumber,
            modifiedBy, modifiedDate
        );
    });

    // ================================================================
    // SUMMARY PANEL FUNCTIONS
    // ================================================================
    function updateSummaryPanel(gid, applicant, grantor, certificate, instrument, 
                                dateReg, dateInst, volume, folio, consideration, 
                                purpose, term, remarks, typeReg, ccNumber, 
                                jobNumber, landSize, encumbrance, typeCert, 
                                regNumber, typeInstrument, dateIssued, planNumber, 
                                modifiedBy, modifiedDate) {
        
        $('#selected_transaction_panel .alert-info').hide();
        $('#summary_fields').show();
        
        $('#summary_gid').text(gid || '-');
        $('#summary_applicant').text(applicant || '-');
        $('#summary_grantor').text(grantor || '-');
        $('#summary_certificate').text(certificate || '-');
        $('#summary_instrument').text(instrument || '-');
        $('#summary_date_reg').text(dateReg || '-');
        $('#summary_date_inst').text(dateInst || '-');
        $('#summary_volume_folio').text((volume || '-') + ' / ' + (folio || '-'));
        $('#summary_consideration').text(consideration || '-');
        $('#summary_purpose').text(purpose || '-');
        $('#summary_term').text(term || '-');
        $('#summary_land_size').text(landSize || '-');
        $('#summary_job_number').text(jobNumber || '-');
        $('#summary_cc_number').text(ccNumber || '-');
        $('#summary_remarks').text(remarks || '-');
        
        $('#selected_transaction_gid').val(gid);
        
        $('.table-row-selected').removeClass('table-row-selected table-primary');
        if (gid) {
            $('#lrd_transaction_dataTable tbody tr').each(function() {
                if ($(this).find('.btn-details').data('gid') == gid) {
                    $(this).addClass('table-row-selected table-primary');
                }
            });
        }
    }

    function clearSummaryPanel() {
        $('#summary_fields').hide();
        $('#selected_transaction_panel .alert-info').show();
        
        $('#summary_gid').text('-');
        $('#summary_applicant').text('-');
        $('#summary_grantor').text('-');
        $('#summary_certificate').text('-');
        $('#summary_instrument').text('-');
        $('#summary_date_reg').text('-');
        $('#summary_date_inst').text('-');
        $('#summary_volume_folio').text('-');
        $('#summary_consideration').text('-');
        $('#summary_purpose').text('-');
        $('#summary_term').text('-');
        $('#summary_land_size').text('-');
        $('#summary_job_number').text('-');
        $('#summary_cc_number').text('-');
        $('#summary_remarks').text('-');
        
        $('#selected_transaction_gid').val('');
        $('.table-row-selected').removeClass('table-row-selected table-primary');
    }

    $(document).on('click', '#btn_clear_summary', function() {
        clearSummaryPanel();
    });

    $(document).on('click', '#btn_refresh_summary', function() {
        var gid = $('#selected_transaction_gid').val();
        if (gid) {
            $('#lrd_transaction_dataTable tbody tr').each(function() {
                if ($(this).find('.btn-details').data('gid') == gid) {
                    $(this).find('.btn-details').click();
                    return false;
                }
            });
        } else {
            alert('No transaction selected. Please click Details on a transaction first.');
        }
    });

    $(document).on('click', '#btn_export_summary', function() {
        var gid = $('#selected_transaction_gid').val();
        if (!gid) {
            alert('No transaction selected. Please click Details on a transaction first.');
            return;
        }
        
        var exportData = {
            gid: $('#summary_gid').text(),
            applicant: $('#summary_applicant').text(),
            grantor: $('#summary_grantor').text(),
            certificate: $('#summary_certificate').text(),
            instrument: $('#summary_instrument').text(),
            date_registered: $('#summary_date_reg').text(),
            date_instrument: $('#summary_date_inst').text(),
            volume_folio: $('#summary_volume_folio').text(),
            consideration: $('#summary_consideration').text(),
            purpose: $('#summary_purpose').text(),
            term: $('#summary_term').text(),
            land_size: $('#summary_land_size').text(),
            job_number: $('#summary_job_number').text(),
            cc_number: $('#summary_cc_number').text(),
            remarks: $('#summary_remarks').text()
        };
        
        var jsonString = JSON.stringify(exportData, null, 2);
        var blob = new Blob([jsonString], { type: 'application/json' });
        var url = URL.createObjectURL(blob);
        var a = document.createElement('a');
        a.href = url;
        a.download = 'transaction_summary_' + gid + '.json';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    });

    $(document).on('click', '#btn_print_summary', function() {
        var gid = $('#selected_transaction_gid').val();
        if (!gid) {
            alert('No transaction selected. Please click Details on a transaction first.');
            return;
        }
        
        var printWindow = window.open('', '_blank', 'width=800,height=600');
        printWindow.document.write('<html><head><title>Transaction Summary</title>');
        printWindow.document.write('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">');
        printWindow.document.write('</head><body>');
        printWindow.document.write('<div class="container mt-4">');
        printWindow.document.write('<h3>Transaction Summary</h3>');
        printWindow.document.write('<hr>');
        printWindow.document.write('<table class="table table-bordered">');
        printWindow.document.write('<tr><th>GID</th><td>' + $('#summary_gid').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Applicant</th><td>' + $('#summary_applicant').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Grantor</th><td>' + $('#summary_grantor').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Certificate Number</th><td>' + $('#summary_certificate').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Instrument Type</th><td>' + $('#summary_instrument').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Date Registered</th><td>' + $('#summary_date_reg').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Date of Instrument</th><td>' + $('#summary_date_inst').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Volume/Folio</th><td>' + $('#summary_volume_folio').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Consideration</th><td>' + $('#summary_consideration').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Purpose</th><td>' + $('#summary_purpose').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Term</th><td>' + $('#summary_term').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Land Size</th><td>' + $('#summary_land_size').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Job Number</th><td>' + $('#summary_job_number').text() + '</td></tr>');
        printWindow.document.write('<tr><th>CC Number</th><td>' + $('#summary_cc_number').text() + '</td></tr>');
        printWindow.document.write('<tr><th>Remarks</th><td>' + $('#summary_remarks').text() + '</td></tr>');
        printWindow.document.write('</table>');
        printWindow.document.write('</div>');
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        
        setTimeout(function() {
            printWindow.print();
        }, 500);
    });



// ================================================================
// CONVERTED TO JQUERY - ALL EVENT LISTENERS
// ================================================================

// ================================================================
// VISUALISE COORDINATE
// ================================================================
$('#lrd_btn_visualise_coordinate').on('click', function() {
    var polygonGroups = {};
    
    $('#coordinatelis_Table tbody tr').each(function() {
        var name = $(this).find('td:eq(0)').text().trim();
        var x = parseFloat($(this).find('td:eq(1)').text().trim());
        var y = parseFloat($(this).find('td:eq(2)').text().trim());
        
        var parts = name.split('-');
        var polygonId = parts[0] || 'polygon1';
        var ringType = parts[1] || 'outer';
        
        if (!polygonGroups[polygonId]) {
            polygonGroups[polygonId] = { outer: [], inner: [] };
        }
        
        if (ringType === 'inner') {
            polygonGroups[polygonId].inner.push({x: x, y: y});
        } else {
            polygonGroups[polygonId].outer.push({x: x, y: y});
        }
    });
    
    function calculateArea(points) {
        var area = 0;
        for (var i = 0; i < points.length - 1; i++) {
            area += (points[i].x * points[i+1].y - points[i+1].x * points[i].y);
        }
        var last = points.length - 1;
        area += (points[last].x * points[0].y - points[0].x * points[last].y);
        return area / 2;
    }
    
    function reverseRing(points) {
        return points.slice().reverse();
    }
    
    var polygons = [];
    Object.keys(polygonGroups).forEach(function(key) {
        var group = polygonGroups[key];
        
        var outerArea = calculateArea(group.outer);
        if (outerArea < 0) {
            group.outer = reverseRing(group.outer);
        }
        
        if (group.inner.length > 0) {
            var innerArea = calculateArea(group.inner);
            if (innerArea > 0) {
                group.inner = reverseRing(group.inner);
            }
        }
        
        if (group.outer.length > 0) {
            group.outer.push(group.outer[0]);
        }
        if (group.inner.length > 0) {
            group.inner.push(group.inner[0]);
        }
        
        var outerWKT = group.outer.map(function(p) { return p.y + " " + p.x; }).join(', ');
        var polygonWKT = "((" + outerWKT;
        
        if (group.inner.length > 0) {
            var innerWKT = group.inner.map(function(p) { return p.y + " " + p.x; }).join(', ');
            polygonWKT += ", " + innerWKT;
        }
        
        polygonWKT += "))";
        polygons.push(polygonWKT);
    });
    
    var wkt;
    if (polygons.length === 1) {
        wkt = "POLYGON" + polygons[0];
    } else {
        wkt = "MULTIPOLYGON(" + polygons.join(', ') + ")";
    }
    
    $('#lrd_txt_wkt_polygon').val(wkt);

    if(wkt) {
		$('#lrd_btn_request_add_existing_parcel').removeClass('d-none')
	}
    
    try {
        lrd_pvlmd_searchLayer.setSource(new ol.source.Vector({
            features: (new ol.format.WKT()).readFeatures(wkt)
        }));
        
        lrd_view_e.fit(lrd_pvlmd_searchLayer.getSource().getExtent());
        lrd_map.getView().fit(lrd_pvlmd_searchLayer.getSource().getExtent(), {
            size: lrd_map.getSize(),
            maxZoom: 16
        });
    } catch (error) {
        console.log('Map update error:', error);
        alert('Error rendering polygon: ' + error.message);
    }
});

// ================================================================
// SHOW LOCATION
// ================================================================
$('#lrd_btn_show_location').on('click', function() {
    console.log('you');
    lrd_markers.getSource().clear();
    var x_coordinate_mak = $('#lrd_x_coordinate').val();
    var y_coordinate_mak = $('#lrd_y_coordinate').val();
    
    var marker = new ol.Feature({
        geometry: new ol.geom.Point([x_coordinate_mak, y_coordinate_mak])
    });
    
    lrd_markers.getSource().addFeature(marker);
    
    lrd_map.getView().fit(lrd_markers.getSource().getExtent(), {
        size: lrd_map.getSize(),
        maxZoom: 16
    });
});

// ================================================================
// SCALE VALUE CHANGE
// ================================================================
$('#lrd_scale_value').on('change', function() {
    $('#lrd_scale_value_e').val($(this).val());
    var view = lrd_map.getView();
    view.setResolution(ol.proj.getPointResolution(
        view.getProjection(),
        getResolutionFromScale($(this).val()),
        view.getCenter()
    ));
    click_map_zoom_value = false;
});

// ================================================================
// SCALE ZOOM
// ================================================================
var click_map_zoom_value = true;
$('#lrd_btn_scale_zoom').on('click', function() {
    var scale_value = $('#lrd_scale_value_e').val();
    var view = lrd_map.getView();
    view.setResolution(ol.proj.getPointResolution(
        view.getProjection(),
        getResolutionFromScale(scale_value),
        view.getCenter()
    ));
    click_map_zoom_value = false;
});

// ================================================================
// LOCK MAP SCALE
// ================================================================
$('#lrd_lockmapscale').on('click', function() {
    if (document.getElementById("lrd_lockmapscale").checked) {
        var MouseWheelZoomClickInteraction;
        lrd_map.getInteractions().getArray().forEach(function(interaction) {
            if (interaction instanceof ol.interaction.MouseWheelZoom) {
                MouseWheelZoomClickInteraction = interaction;
            }
        });
        lrd_map.removeInteraction(MouseWheelZoomClickInteraction);
        
        var dblClickInteraction;
        lrd_map.getInteractions().getArray().forEach(function(interaction) {
            if (interaction instanceof ol.interaction.DoubleClickZoom) {
                dblClickInteraction = interaction;
            }
        });
        lrd_map.removeInteraction(dblClickInteraction);
    } else {
        var dblClickInteraction = new ol.interaction.DoubleClickZoom({ delta: 0 });
        lrd_map.addInteraction(dblClickInteraction);
        var MouseWheelZoomClickInteraction = new ol.interaction.MouseWheelZoom({ delta: 0 });
        lrd_map.addInteraction(MouseWheelZoomClickInteraction);
    }
});

// ================================================================
// LOAD SCANNED MAPS BY POINT
// ================================================================
$('#lrd_btn_load_for_scanned_maps_by_point').on('click', function() {
    console.log('kkkkk');
    var x_coordinate_mak = $('#lrd_x_coordinate').val();
    var y_coordinate_mak = $('#lrd_y_coordinate').val();
    
    var polygon = x_coordinate_mak + " " + y_coordinate_mak;
    var polygon_real = "POINT(" + polygon + ")";
    
    $.ajax({
        type: "POST",
        url: "Maps",
        data: {
            request_type: 'search_for_lrd_scan_map_for_a_point',
            wkt_polgon: polygon_real
        },
        cache: false,
        success: function(jobdetails) {
            var json_p = JSON.parse(jobdetails);
            console.log('how come');
            console.log(result);
            
            var options = $("#geoserverscannedimages_list");
            options.empty();
            
            $(json_p.data).each(function() {
                $('#geoserverscannedimages_list').append(
                    '<option value="' + this.file_name + ':' + this.extent + '">' + this.file_name + '</option>'
                );
            });
        }
    });
});

// ================================================================
// SEARCH FOR SCANNED MAPS
// ================================================================
$('#lrd_btn_search_for_scanned_maps').on('click', function() {
    console.log('kkkkk');
    var wkt_polygon_k = $.trim($("#lrd_txt_wkt_polygon").val());
    var wkt_polygon = document.getElementById("lrd_txt_wkt_polygon").value;
    console.log(wkt_polygon);
    
    $.ajax({
        type: "POST",
        url: "Maps",
        data: {
            request_type: 'search_for_lrd_scan_map_for_a_polygon',
            wkt_polygon: wkt_polygon
        },
        cache: false,
        beforeSend: function() {},
        success: function(jobdetails) {
            var json_p = JSON.parse(jobdetails);
            console.log('how come');
            console.log(result);
            
            var options = $("#geoserverscannedimages_list");
            options.empty();
            
            $(json_p.data).each(function() {
                $('#geoserverscannedimages_list').append(
                    '<option value="' + this.file_name + ':' + this.extent + '">' + this.file_name + '</option>'
                );
            });
        }
    });
});

// ================================================================
// LOAD FOR SCANNED MAPS
// ================================================================
$('#lrd_btn_load_for_scanned_maps').on('click', function() {
    console.log('kkkkk');
    var geoserverscannedimage = $.trim($("#geoserverscannedimages_list").val());
    console.log('Scan Map');
    console.log(geoserverscannedimage);
    
    var value_image_scan = geoserverscannedimage;
    var only_layer = value_image_scan.split(":", 3);
    console.log(only_layer);
    var value_image_scan1 = only_layer[1];
    var layer_name = 'csau_geospatial' + ':' + value_image_scan1;
    var all_parameters = { 'LAYERS': layer_name };
    
    var image_source = new ol.source.ImageWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: all_parameters,
        serverType: 'geoserver',
    });
    
    lrd_StaticImage.setSource(image_source);
    var new_extent = null;
    var extent_nnn = only_layer[2];
    new_extent = extent_nnn;
    console.log('new_extent');
    console.log(new_extent);
    
    lrd_map.getView().fit(new_extent, lrd_map.getSize());
});

// ================================================================
// SEARCH FOR SCANNED MAPS ALL
// ================================================================
$('#lrd_btn_search_for_scanned_maps_all').on('click', function() {
    console.log('kkkkk');
    var wkt_polygon_k = $.trim($("#lrd_txt_wkt_polygon").val());
    var wkt_polygon = document.getElementById("lrd_txt_wkt_polygon").value;
    console.log(wkt_polygon);
    
    $.ajax({
        type: "POST",
        url: "Maps",
        data: {
            request_type: 'search_for_lrd_scan_map_all',
            wkt_polygon: wkt_polygon
        },
        cache: false,
        beforeSend: function() {},
        success: function(jobdetails) {
            var json_p = JSON.parse(jobdetails);
            console.log('how come');
            console.log(result);
            
            var datalist = $("#listofscannnedmaptosearchfor");
            datalist.empty();
            
            $(json_p.data).each(function() {
                datalist.append(
                    '<option data-name="' + this.file_name + '" data-id="' + this.extent + '" value="' + this.file_name + ':' + this.extent + '" ></option>'
                );
            });
        }
    });
});

// ================================================================
// LOAD FOR SCANNED MAPS ALL
// ================================================================
$('#lrd_btn_load_for_scanned_maps_all').on('click', function() {
    console.log('kkkkk');
    var geoserverscannedimage = $.trim($("#scannned_map_to_search_for").val());
    console.log('Scan Map');
    console.log(geoserverscannedimage);
    
    var value_image_scan = geoserverscannedimage;
    var only_layer = value_image_scan.split(":", 3);
    console.log(only_layer);
    var value_image_scan1 = only_layer[1];
    var layer_name = 'csau_geospatial' + ':' + value_image_scan1;
    var all_parameters = { 'LAYERS': layer_name };
    
    var image_source = new ol.source.ImageWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: all_parameters,
        serverType: 'geoserver',
    });
    
    lrd_StaticImage.setSource(image_source);
    var new_extent = null;
    var extent_nnn = only_layer[2];
    new_extent = extent_nnn;
    console.log('new_extent');
    console.log(new_extent);
    
    lrd_map.getView().fit(new_extent, lrd_map.getSize());
});

// ================================================================
// VISUALISE WKT
// ================================================================
$('#lrd_btn_visualise_wkt').on('click', function() {
    var wktplygonsearch = $('#lrd_txt_wkt_polygon').val();
    console.log(wktplygonsearch);
    
    lrd_pvlmd_searchLayer.setSource(new ol.source.Vector({
        features: (new ol.format.WKT()).readFeatures(wktplygonsearch)
    }));
    
    var extent = lrd_pvlmd_searchLayer.getSource().getExtent();
    lrd_map.getView().fit(extent, {
        size: lrd_map.getSize(),
        maxZoom: 16
    });
});

// ================================================================
// SAVE WKT
// ================================================================
$('#lrd_btn_save_wkt').on('click', function() {
    var wktplygonsearch = document.getElementById("lrd_txt_wkt_polygon").value;
    $("#lrdparcelinformationfirsttimesavewithinfo").modal();
    $('#lrdparcelinformationfirsttimesavewithinfo #lrd_parcel_wkt_to_plot_fts').val(wktplygonsearch);
});

// ================================================================
// SEARCH BY CERTIFICATE NUMBER
// ================================================================
$('#lrd_btn_search_by_certificate_number').on('click', function() {
    var search_text = $('#lrd_search_by_text').val();
    console.log(search_text);
    
    $("#lrdparcelIndormation").modal();
    
    // Clear all fields
    $('#addlrdtransaction #lrd_td_fid_id_fk').val([]);
    $('#addlrdtransaction #lrd_td_gid').val([]);
    $('#addlrdtransaction #lrd_td_plotted_by_reg').val([]);
    $('#addlrdtransaction #lrd_td_checked_by').val([]);
    $('#addlrdtransaction #lrd_td_plott_date_reg').val([]);
    $('#addlrdtransaction #lrd_td_certicate_number').val([]);
    $('#addlrdtransaction #nature_of_instument').val([]);
    $('#addlrdtransaction #applicant_name').val([]);
    $('#addlrdtransaction #plan_number').val([]);
    $('#addlrdtransaction #lrd_td_type_instrument').val([]);
    $('#addlrdtransaction #lrd_td_date_of_instument').val([]);
    $('#addlrdtransaction #lrd_td_consideration').val([]);
    $('#addlrdtransaction #lrd_td_purpose').val([]);
    $('#addlrdtransaction #lrd_td_date_commencement').val([]);
    $('#addlrdtransaction #lrd_td_term').val([]);
    $('#addlrdtransaction #lrd_td_remarks').val([]);
    $('#addlrdtransaction #lrd_td_type_of_registration').val([]);
    $('#addlrdtransaction #lrd_td_encumbrance').val([]);
    $('#addlrdtransaction #lrd_td_checked_by').val([]);
    $('#addlrdtransaction #lrd_td_date_of_registration').val([]);
    $('#addlrdtransaction #lrd_td_volume').val([]);
    $('#addlrdtransaction #lrd_td_folio').val([]);
    $('#addlrdtransaction #lrd_td_date_of_issued_cert_no').val([]);
    $('#addlrdtransaction #lrd_td_type_of_certificate').val([]);
    $('#addlrdtransaction #lrd_td_registered_number').val([]);
    $('#addlrdtransaction #lrd_td_cc_number').val([]);
    $('#addlrdtransaction #lrd_td_certicate_number').val([]);
    $('#addlrdtransaction #lrd_td_registered_number').val([]);
    $('#addlrdtransaction #lrd_td_cc_number').val([]);
    $('#addlrdtransaction #lrd_td_grantor_name').val([]);
    $('#addlrdtransaction #lrd_td_job_number').val([]);
    $('#addlrdtransaction #lrd_td_land_size').val([]);
    
    $('#lrdparcelIndormation #lrd_ps_fid').val('0');
    $('#lrdparcelIndormation #lrd_ps_reference_number').val(search_text);
    $('#lrdparcelIndormation #lrd_ps_locality').val('');
    $('#lrdparcelIndormation #lrd_ps_plotted_by').val('');
    $('#lrdparcelIndormation #lrd_ps_date_plott').val('');
    $('#lrdparcelIndormation #lrd_ps_checked_by').val('');
    $('#lrdparcelIndormation #lrd_ps_type_of_plotting').val('');
    $('#lrdparcelIndormation #lrd_td_reference_number').val('');
    
    var table = $('#lrd_transaction_dataTable');
    table.find("tbody tr").remove();
    
    $.ajax({
        type: "POST",
        url: 'Maps',
        data: {
            request_type: 'load_lrd_transaction_details_by_certificate_number',
            certificate_number: search_text
        },
        cache: false,
        beforeSend: function() {},
        success: function(serviceresponse) {
            var json_p = JSON.parse(serviceresponse);
            console.log(json_p);
            
            $(json_p.data).each(function() {
                table.append(
                    "<tr><td>" + this.applicant_name + 
                    "</td><td>" + this.grantor_name + 
                    "</td><td>" + this.certicate_number + 
                    "</td><td>" + this.nature_of_instument + 
                    "</td>" +
                    '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addlrdtransaction" data-target-id="' + this.gid + '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>' +
                    "</tr>"
                );
            });
            
            var table_docs = $('#lrd_scanned_documents_dataTable');
            table_docs.find("tbody tr").remove();
            
            $.ajax({
                type: "POST",
                url: 'LoadLRDJackets',
                data: {
                    request_type: 'load_lrd_jacket_certificate',
                    certificate_number: search_text
                },
                cache: false,
                beforeSend: function() {},
                success: function(scanned_docs_response) {
                    var json_p = JSON.parse(scanned_docs_response);
                    console.log(json_p);
                    
                    $(json_p).each(function() {
                        table_docs.append(
                            "<tr>" +
                            '<td> <a class="link-post" href="' + this.document_file + '">' + this.document_name + '</a></td>' +
                            "<td>" + this.document_extention + "</td>" +
                            "</tr>"
                        );
                    });
                }
            });
        }
    });
});

// ================================================================
// SEARCH BY REFERENCE NUMBER
// ================================================================
$('#lrd_btn_search_by_reference_number').on('click', function() {
    var search_text = $('#lrd_search_by_text').val();
    console.log(search_text);
    
    $.ajax({
        type: "POST",
        url: "Maps",
        data: {
            request_type: 'lc_spatial_objects_search_by_other_details',
            vr_search_text: search_text
        },
        cache: false,
        beforeSend: function() {},
        success: function(jobdetails) {
            var json_p = JSON.parse(jobdetails);
            console.log(json_p);
            
            if (json_p !== undefined || json_p !== null) {
                if (lrd_pvlmd_searchLayer.getSource() != null) {
                    lrd_pvlmd_searchLayer.getSource().clear();
                }
                
                if (!(json_p.parcels === undefined || json_p.parcels.features === null)) {
                    lrd_pvlmd_searchLayer.setSource(new ol.source.Vector({
                        features: (new ol.format.GeoJSON()).readFeatures(json_p.parcels)
                    }));
                }
                
                lrd_view_e.fit(lrd_pvlmd_searchLayer.getSource().getExtent());
                lrd_map.getView().fit(lrd_pvlmd_searchLayer.getSource().getExtent(), {
                    size: lrd_map.getSize(),
                    maxZoom: 16
                });
                
                $('#lrd_txt_wkt_polygon').val(json_p.wkt);
            }
        }
    });
});

// ================================================================
// PRINT MAP
// ================================================================
$('#lrd_btn_print_map').on('click', function() {
    console.log("click_type");
    
    var wktplygonsearch = $('#lrd_txt_wkt_polygon').val();
    
    var canvas = document.getElementById("lrd-map").getElementsByClassName("ol-unselectable")[0];
    var img = canvas.toDataURL("image/png");
    
    var doc = new jsPDF('portrait', undefined, 'a4');
    doc.setProperties({
        title: 'Internal Search',
        subject: 'This is the subject',
        author: 'Assiamah John',
        keywords: 'generated, javascript, web 2.0, ajax',
        creator: 'Creator Name'
    });
    
    doc.setFontSize(20);
    doc.text(70, 25, 'LANDS COMMISSION');
    doc.setFontSize(16);
    doc.text(80, 35, 'INTERNAL SEARCH REPORT');
    
    doc.addImage(img, 'JPEG', 20, 60, 160, 80);
    
    doc.setFontSize(10);
    doc.setDrawColor(255, 0, 0);
    doc.setLineWidth(1.5);
    doc.line(15, 190, 50, 190);
    doc.text(60, 190, 'Search Polygon');
    
    doc.setDrawColor(51, 51, 255);
    doc.setLineWidth(1.5);
    doc.line(15, 200, 50, 200);
    doc.text(60, 200, 'PVLMD Parcel');
    
    doc.setFontSize(10);
    doc.setFont("courier");
    doc.setFontType("bolditalic");
    
    var splitTitle = doc.splitTextToSize(wktplygonsearch, 180);
    doc.text(20, 250, splitTitle);
    
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'select_consolidated_internal_search_report_attribute',
            vr_polygon: wktplygonsearch
        },
        cache: false,
        beforeSend: function() {},
        success: function(jobdetails) {
            var json_p = JSON.parse(jobdetails);
            console.log(json_p);
            
            if (json_p !== undefined || json_p !== null) {
                // GARRO Data
                if (json_p.garro === undefined || json_p.garro === null) {
                    doc.addPage('a4', 'l');
                    var data_rows = [{ main_description: 'No Recorded Transaction' }];
                    var columns = [{ title: 'Existing GARRO Data', dataKey: 'main_description' }];
                    
                    doc.autoTable(columns, data_rows, {
                        margin: { top: 10 },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 20
                    });
                } else {
                    var transaction_data = json_p.garro;
                    var columns = [
                        { title: "Property No", dataKey: "prop_no" },
                        { title: "Instrument Date", dataKey: "instrument_date" },
                        { title: "Instrument Type", dataKey: "instrument_type" },
                        { title: "Grantor", dataKey: "party1_plaintiff" },
                        { title: "Grantee", dataKey: "party2_defendant" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement Date", dataKey: "commencement_date" }
                    ];
                    
                    doc.autoTable(columns, transaction_data, {
                        margin: { top: 10 },
                        bodyStyles: { valign: 'middle' },
                        styles: { overflow: 'linebreak', columnWidth: 'wrap' },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10,
                        columnStyles: {
                            party1_plaintiff: { columnWidth: 100 },
                            party2_defendant: { columnWidth: 50 }
                        },
                        addPageContent: function(data) {
                            doc.text("Assiamah", 40, 40);
                        }
                    });
                }
                
                // CRO Data
                if (json_p.cro === undefined || json_p.cro === null) {
                    var data_rows = [{ main_description: 'No Recorded Transaction' }];
                    var columns = [{ title: 'Existing CRO Data', dataKey: 'main_description' }];
                    
                    doc.autoTable(columns, data_rows, {
                        margin: { top: 10 },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10
                    });
                } else {
                    var transaction_data = json_p.cro;
                    var columns = [
                        { title: "LS Number", dataKey: "ls_number" },
                        { title: "Instrument Date", dataKey: "instrument_date" },
                        { title: "Instrument Type", dataKey: "instrument_type" },
                        { title: "Grantor", dataKey: "party1_plaintiff" },
                        { title: "Grantee", dataKey: "party2_defendant" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement Date", dataKey: "commencement_date" }
                    ];
                    
                    doc.autoTable(columns, transaction_data, {
                        margin: { top: 10 },
                        bodyStyles: { valign: 'middle' },
                        styles: { overflow: 'linebreak', columnWidth: 'wrap' },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10,
                        columnStyles: {
                            party1_plaintiff: { columnWidth: 50 },
                            party2_defendant: { columnWidth: 50 }
                        }
                    });
                }
                
                // PVLMD Current Layer
                if (json_p.pvlmdcurrent === undefined || json_p.pvlmdcurrent === null) {
                    var data_rows = [{ main_description: 'No Recorded Transaction' }];
                    var columns = [{ title: 'PVLMD Current Layer', dataKey: 'main_description' }];
                    
                    doc.autoTable(columns, data_rows, {
                        margin: { top: 10 },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10
                    });
                } else {
                    var transaction_data = json_p.pvlmdcurrent;
                    var columns = [
                        { title: "Reference No", dataKey: "reference_number_p" },
                        { title: "Instrument Date", dataKey: "instrument_date" },
                        { title: "Instrument Type", dataKey: "instrument_type" },
                        { title: "Grantor", dataKey: "party1_plaintiff" },
                        { title: "Grantee", dataKey: "party2_defendant" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement Date", dataKey: "commencement_date" }
                    ];
                    
                    doc.autoTable(columns, transaction_data, {
                        margin: { top: 10 },
                        bodyStyles: { valign: 'middle' },
                        styles: { overflow: 'linebreak', columnWidth: 'wrap' },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10,
                        columnStyles: {
                            party1_plaintiff: { columnWidth: 50 },
                            party2_defendant: { columnWidth: 50 }
                        }
                    });
                }
                
                // SMD Parcel Layer
                if (json_p.smd_parcels === undefined || json_p.smd_parcels === null) {
                    var data_rows = [{ main_description: 'No Recorded Transaction' }];
                    var columns = [{ title: 'SMD Parcel Layer', dataKey: 'main_description' }];
                    
                    doc.autoTable(columns, data_rows, {
                        margin: { top: 10 },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10
                    });
                } else {
                    doc.text(20, 30, 'SMD Parcel Layer');
                    var transaction_data = json_p.smd_parcels;
                    var columns = [
                        { title: "CC No", dataKey: "ccno" },
                        { title: "Applicant Name", dataKey: "a_name" }
                    ];
                    
                    doc.autoTable(columns, transaction_data, {
                        margin: { top: 10 },
                        bodyStyles: { valign: 'middle' },
                        styles: { overflow: 'linebreak', columnWidth: 'wrap' },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10,
                        columnStyles: {
                            ccno: { columnWidth: 50 },
                            a_name: { columnWidth: 50 }
                        }
                    });
                }
                
                // SMD Cadastral Layer
                if (json_p.smd_cadastral === undefined || json_p.smd_cadastral === null) {
                    var data_rows = [{ main_description: 'No Recorded Transaction' }];
                    var columns = [{ title: 'SMD Cadastral Layer', dataKey: 'main_description' }];
                    
                    doc.autoTable(columns, data_rows, {
                        margin: { top: 10 },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10
                    });
                } else {
                    var transaction_data = json_p.smd_cadastral;
                    var columns = [
                        { title: "CC No", dataKey: "ccno" },
                        { title: "Applicant Name", dataKey: "a_name" }
                    ];
                    
                    doc.autoTable(columns, transaction_data, {
                        margin: { top: 10 },
                        bodyStyles: { valign: 'middle' },
                        styles: { overflow: 'linebreak', columnWidth: 'wrap' },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10,
                        columnStyles: {
                            ccno: { columnWidth: 50 },
                            a_name: { columnWidth: 50 }
                        }
                    });
                }
                
                // LRD Layer
                if (json_p.lrd === undefined || json_p.lrd === null) {
                    var data_rows = [{ main_description: 'No Recorded Transaction' }];
                    var columns = [{ title: 'LRD Layer', dataKey: 'main_description' }];
                    
                    doc.autoTable(columns, data_rows, {
                        margin: { top: 10 },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10
                    });
                } else {
                    var transaction_data = json_p.lrd;
                    var columns = [
                        { title: "Reference No.", dataKey: "reference_number" },
                        { title: "Instrument Date", dataKey: "date_of_instument" },
                        { title: "Instrument Type", dataKey: "type_instrument" },
                        { title: "Grantor", dataKey: "grantor_name" },
                        { title: "Applicant Name", dataKey: "applicant_name" },
                        { title: "Term", dataKey: "term" },
                        { title: "Commencement", dataKey: "date_commencement" }
                    ];
                    
                    doc.autoTable(columns, transaction_data, {
                        margin: { top: 10 },
                        bodyStyles: { valign: 'middle' },
                        styles: { overflow: 'linebreak', columnWidth: 'wrap' },
                        theme: 'grid',
                        startY: doc.autoTableEndPosY() + 10,
                        columnStyles: {
                            grantor_name: { columnWidth: 50 },
                            applicant_name: { columnWidth: 50 }
                        }
                    });
                }
                
                doc.save('map.pdf');
            }
        }
    });
});

// ================================================================
// HELPER FUNCTION FOR SCALE
// ================================================================
function getResolutionFromScale(scale) {
    var units = lrd_map.getView().getProjection().getUnits();
    var dpi = 25.4 / 0.28;
    var mpu = ol.proj.METERS_PER_UNIT[units];
    var resolution = scale / (mpu * 39.37 * dpi);
    return resolution;
}

window.initiateDeleteParcel = function() {

    var selectedJobsList = [];
	var lrd_ps_reference_number = $('#lrd_ps_reference_number').val();

	// Close the underlying modal
    $('#lrdparcelIndormation').modal('hide');

    Swal.fire({
        title: 'Add Job to Request List?',
        text: 'This will add selected jobs to request to list.',
        icon: 'question',
		//target: document.body,
		//backdrop: true,
        html: `
            <!-- <p>This will add selected jobs to request to list.</p> -->
            <div class="form-group text-start mt-2">
                <label for="txt_general_remarks_notes">Remarks: <span class="text-danger">*</span></label>
                <textarea class="form-control mt-1" id="txt_general_remarks_notes" rows="3"></textarea>
            </div>
        `,
        showCancelButton: true,
        confirmButtonText: 'Yes, Add',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#d33',
		// customClass: {
        //     container: 'swal-container-custom' // Add custom class
        // }
    }).then((result) => {
		// if (!result.isConfirmed) {
        //     $('#pvlmdparcelinformation').modal('show');
        // }

        if (result.isConfirmed) {
            var remarks_notes = $("#txt_general_remarks_notes").val();
            if (!remarks_notes) {
                Swal.fire({
                    title: 'Remarks is required!',
                    icon: 'warning',
                    confirmButtonText: 'OK',
                });
                return;
            }

            const exists = selectedJobsList.some(job => job.jobNumberPlain === lrd_ps_reference_number);
        
            if (exists) {
                Swal.fire({
                    title: 'Duplicate Job',
                    text: `Job ${lrd_ps_reference_number} is already in the list.`,
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });

                return;
            }

            // Add job to list
            selectedJobsList.push({
                jobNumberPlain: lrd_ps_reference_number,
                jobNumberHtml: lrd_ps_reference_number,
                applicantNameHtml: lrd_ps_reference_number,
                applicationType: 'TEMPORAL APPLICATION',
                batchingPurpose: 'Archive Plotting',
                remarksNotes: remarks_notes,
                // created_on: jobData.created_on,
                // job_status: jobData.job_status
            });

            // Update localStorage
            localStorage.setItem('requestlistdata', JSON.stringify(selectedJobsList));
            
            // Update the table
            addJobToRequestlist();

            prepareRequestlistModal();
        }
    });

};

$('#lrd_btn_request_add_existing_parcel').on('click', function(e) {
	e.preventDefault();

	var lrd_txt_wkt_polygon = $.trim($('#lrd_txt_wkt_polygon').val());

	if (!lrd_txt_wkt_polygon) {
		Swal.fire({
			title: 'No Polygon Found',
			text: 'Please draw or load a polygon before submitting the request.',
			icon: 'warning',
			confirmButtonText: 'OK'
		});
		return;
	}

	Swal.fire({
		title: 'Request Add Existing Parcel?',
		icon: 'info',
		html: `
			<p class="mb-3">This request will submit the selected polygon for review to add existing parcel.</p>
			<div class="form-group text-start mb-2">
				<label for="lrd_add_exist_reference_number" class="form-label">Reference Number <span class="text-danger">*</span></label>
				<input type="text" id="lrd_add_exist_reference_number" class="form-control" placeholder="Enter reference number">
			</div>
            <div class="form-group text-start mb-2">
				<label for="lrd_add_exist_file_number" class="form-label">File Number</label>
				<input type="text" id="lrd_add_exist_file_number" class="form-control" placeholder="Enter file number">
			</div>
            <div class="form-group text-start mb-2">
				<label for="lrd_add_exist_party_1" class="form-label">Party 1 (Grantor)</label>
				<textarea id="lrd_add_exist_party_1" class="form-control" placeholder="Enter party"></textarea>
			</div>
            <div class="form-group text-start mb-2">
				<label for="lrd_add_exist_party_2" class="form-label">Party 2 (Grantee)</label>
				<textarea id="lrd_add_exist_party_2" class="form-control" placeholder="Enter party"></textarea>
			</div>
            <div class="form-group text-start mb-2">
				<label for="lrd_add_exist_acreage" class="form-label">Acreage <span class="text-danger">*</span></label>
				<input type="number" id="lrd_add_exist_acreage" min="0.01" class="form-control" placeholder="Enter acreage">
			</div>
			<div class="form-group text-start mb-2">
				<label for="lrd_add_exist_locality" class="form-label">Locality <span class="text-danger">*</span></label>
				<input type="text" id="lrd_add_exist_locality" class="form-control" placeholder="Enter locality">
			</div>
		            <div class="form-group text-start mb-2">
				<label for="lrd_add_exist_comments" class="form-label">Comments<span class="text-danger">*</span></label>
				<textarea id="lrd_add_exist_comments" class="form-control" placeholder="Enter comments"></textarea>
			</div>
		`,
		showCancelButton: true,
		confirmButtonText: 'Yes, Submit',
		cancelButtonText: 'Cancel',
		confirmButtonColor: '#d33',
		cancelButtonColor: '#6c757d',
		focusConfirm: false,
		preConfirm: function() {
			var referenceNumber = $.trim($('#lrd_add_exist_reference_number').val());

			if (!referenceNumber) {
				Swal.showValidationMessage('Reference Number is required');
				return false;
			}

			var locality = $.trim($('#lrd_add_exist_locality').val());

			if (!locality) {
				Swal.showValidationMessage('Locality is required');
				return false;
			}

			var acreage = $.trim($('#lrd_add_exist_acreage').val());

			if (!acreage) {
				Swal.showValidationMessage('Acreage is required');
				return false;
			}

			var comments = $.trim($('#lrd_add_exist_comments').val());

            if (!comments) {
				Swal.showValidationMessage('Comments is required');
				return false;
			}
			var fileNumber = $.trim($('#lrd_add_exist_file_number').val());
			var party1 = $.trim($('#lrd_add_exist_party_1').val());
			var party2 = $.trim($('#lrd_add_exist_party_2').val());
			

			return {
				referenceNumber: referenceNumber,
                fileNumber: fileNumber,
                party1: party1,
                party2: party2,
				locality: locality,
                acreage: acreage,
                comments: comments
			};
		}
	}).then(function(result) {
		if (!result.isConfirmed) {
			return;
		}

		Swal.fire({
			title: 'Submitting Request',
			text: 'Please wait while we save the parcel request.',
			allowOutsideClick: false,
			didOpen: function() {
				Swal.showLoading();
			}
		});

		$.ajax({
			type: 'POST',
			url: 'Maps',
			data: {
				request_type: 'select_add_lc_temp_parcels',
				wkt_polygon: lrd_txt_wkt_polygon,
				locality: result.value.locality,
				reference_number: result.value.referenceNumber,
				file_number: result.value.fileNumber,
				party_1: result.value.party1,
				party_2: result.value.party2,
				acreage: result.value.acreage,
				comments: result.value.comments,
                division: 'LRD'
			},
			cache: false,
			success: function(response) {
				if (!response) {
					Swal.fire({
						title: 'Request Failed',
						text: 'Unable to submit the parcel deletion request.',
						icon: 'error',
						confirmButtonText: 'OK'
					});
					return;
				}

				var json_p = JSON.parse(response);

				if (json_p && json_p.success === true) {
					initiateReqAddExistingParcel(json_p.reference_number, json_p.glpin, json_p.party_1, json_p.party_2);
				}

				// Swal.fire({
				// 	title: 'Request Submitted',
				// 	text: response || 'The parcel deletion request has been submitted successfully.',
				// 	icon: 'success',
				// 	confirmButtonText: 'OK'
				// });
			},
			error: function(xhr, status, error) {
				Swal.fire({
					title: 'Request Failed',
					text: xhr.responseText || error || 'Unable to submit the parcel deletion request.',
					icon: 'error',
					confirmButtonText: 'OK'
				});
			}
		});
	});
});


window.initiateReqAddExistingParcel = function(parcelId, referenceNumber, party1, party2) {

    var selectedJobsList = [];

	// Close the underlying modal
    $('#lrdparcelIndormation').modal('hide');

    Swal.fire({
        title: 'Add Job to Request List?',
        text: 'This will add selected jobs to request to list.',
        icon: 'question',
		//target: document.body,
		//backdrop: true,
        html: `
            <!-- <p>This will add selected jobs to request to list.</p> -->
            <div class="form-group text-start mt-2">
                <label for="txt_general_remarks_notes">Remarks: <span class="text-danger">*</span></label>
                <textarea class="form-control mt-1" id="txt_general_remarks_notes" rows="3"></textarea>
            </div>
        `,
        showCancelButton: true,
        confirmButtonText: 'Yes, Add',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#d33',
		// customClass: {
        //     container: 'swal-container-custom' // Add custom class
        // }
    }).then((result) => {
		// if (!result.isConfirmed) {
        //     $('#pvlmdparcelinformation').modal('show');
        // }

        if (result.isConfirmed) {
            var remarks_notes = $("#txt_general_remarks_notes").val();
            if (!remarks_notes) {
                Swal.fire({
                    title: 'Remarks is required!',
                    icon: 'warning',
                    confirmButtonText: 'OK',
                });
                return;
            }

            const exists = selectedJobsList.some(job => job.jobNumberPlain === parcelId);
        
            if (exists) {
                Swal.fire({
                    title: 'Duplicate Job',
                    text: `Job ${parcelId} is already in the list.`,
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });

                return;
            }

            let applicantName = referenceNumber + (party2 == '' ? ' - (' + party1 + ')' : ' - (' + party2 + ')');

            // Add job to list
            selectedJobsList.push({
                jobNumberPlain: parcelId,
                jobNumberHtml: parcelId,
                applicantNameHtml: applicantName,
                applicationType: 'TEMPORAL APPLICATION',
                batchingPurpose: 'Add Plotting',
                remarksNotes: remarks_notes,
                // created_on: jobData.created_on,
                // job_status: jobData.job_status
            });

            // Update localStorage
            localStorage.setItem('requestlistdata', JSON.stringify(selectedJobsList));
            
            // Update the table
            addJobToRequestlist();

            prepareRequestlistModal();
        }
    });

};


});
