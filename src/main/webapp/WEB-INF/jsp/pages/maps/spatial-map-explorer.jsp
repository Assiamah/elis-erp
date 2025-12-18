<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<main class="app-wrapper">
    <div class="container-fluid">

        <div class="main-breadcrumb d-flex align-items-center my-3 position-relative">
            <h2 class="breadcrumb-title mb-0 flex-grow-1 fs-14">Spatial Map Explorer</h2>
            <div class="flex-shrink-0">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-end mb-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Spatial Map Explorer</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Map</li>
                    </ol>
                </nav>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="position-relative">
                            <div class="w-100 min-h-320px" id="map"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Submit Section -->
</main>

<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script>

<script>
    let map;
    let highlightedParcel = null;
    let parcelLayer = null;

    // Define source (EPSG:2136) and destination (EPSG:4326)
    proj4.defs("EPSG:2136", "+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.736 +y_0=0 +ellps=clrk80 +units=m +no_defs");

    // Example point in EPSG:2136
    let point2136 = [264970, 1015339]; // [x, y]

    // Convert to EPSG:4326
    let point4326 = proj4("EPSG:2136", "EPSG:4326", point2136);

    // Leaflet expects [lat, lon]
    let leafletCenter = [point4326[1], point4326[0]];
    // console.log(leafletCenter)

    const geoserverBaseUrl = 'http://localhost:2020/geoserver';

    // Base Layers
    const osmLayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    });

    const satelliteLayer = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        attribution: '© Esri'
    });

    const topoLayer = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenTopoMap contributors'
    });

    // Initialize map with default base layer
    map = L.map('map', {
        center: [5.385786, -0.679827],
        zoom: 16,
        layers: [osmLayer]
    });

    // GeoServer WMS Layer with error handling
    try {
        var gcsez_boundary = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_boundary', // Example layer - replace with yours
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);

        var gcsez_parceldata_02 = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_parceldata_02', // Example layer - replace with yours
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);

        var gcsez_stline = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_stline', // Example layer - replace with yours
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);

        var gcsez_accessroad = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_accessroad', // Example layer - replace with yours
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);
        
        // Optional: Add layer control
        const baseLayers = {
            'OpenStreetMap': osmLayer,
            'Satellite': satelliteLayer,
            'Topographic': topoLayer
        };
        
        const overlays = {
            "Boundary": gcsez_boundary,
            "Parcel Data": gcsez_parceldata_02,
            "Street Line": gcsez_stline,
            "Access Road": gcsez_accessroad
        };

        // Call this function after map initialization
        initParcelHighlightLayer();

        // Modify the click handler
        map.on('click', function(e) {
            // Only process clicks if parcel layer is visible
            if (map.hasLayer(gcsez_parceldata_02)) {
                // Clear previous highlight
                clearParcelHighlight();
                
                // Get parcel info and highlight
                getParcelInfo(e.latlng);
                
                // Center map on click position
                map.panTo(e.latlng);
            }
        });
        
        L.control.layers(baseLayers, overlays, { collapsed: false }).addTo(map);
        
    } catch (error) {
        console.error('Error loading GeoServer layer:', error);
        //alert('Could not connect to GeoServer. Make sure it\'s running on localhost:2020');
        showNotification('Could not connect to GeoServer. Make sure it\'s running on localhost:2020', 'error');
    }

    // Initialize a GeoJSON layer for highlighting
    function initParcelHighlightLayer() {
        parcelLayer = L.geoJSON(null, {
            style: function(feature) {
                return {
                    color: '#ff0000', // Red border
                    weight: 3,
                    opacity: 0.8,
                    fillColor: '#ff0000', // Red fill
                    fillOpacity: 0.2
                };
            }
        }).addTo(map);
    }

    // Function to clear parcel highlight
    function clearParcelHighlight() {
        if (parcelLayer) {
            parcelLayer.clearLayers();
        }
        highlightedParcel = null;
    }

    // Function to highlight a specific parcel
    function highlightParcel(geojsonData) {
        if (!parcelLayer || !geojsonData) return;
        
        // Clear previous highlights
        clearParcelHighlight();
        
        // Add the new parcel to highlight layer
        parcelLayer.addData(geojsonData);
        
        // Store reference to highlighted parcel
        highlightedParcel = geojsonData;
        
        // Fit bounds to the highlighted parcel (optional)
        const bounds = parcelLayer.getBounds();
        if (bounds.isValid()) {
            map.fitBounds(bounds, { padding: [50, 50], maxZoom: 18 });
        }
    }

        // Function to get parcel information via WMS GetFeatureInfo
    function getParcelInfo(latlng) {
        // Show loading state in offcanvas
        document.getElementById('parcelOffcanvasBody').innerHTML = `
            <div class="loading-spinner">
                <div class="spinner-border" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-3">Loading parcel information...</p>
            </div>
        `;
        
        // Show the offcanvas
        showParcelOffcanvas();
        
        // Convert latlng to map coordinates
        const point = map.latLngToContainerPoint(latlng);
        const size = map.getSize();
        
        // Prepare parameters for GetFeatureInfo request
        const params = {
            service: 'WMS',
            version: '1.1.1',
            request: 'GetFeatureInfo',
            layers: 'smarterem:gcsez_parceldata_02',
            query_layers: 'smarterem:gcsez_parceldata_02',
            info_format: 'application/json',
            feature_count: 10,
            x: Math.round(point.x),
            y: Math.round(point.y),
            width: size.x,
            height: size.y,
            srs: 'EPSG:4326',
            bbox: map.getBounds().toBBoxString()
        };
        
        // Build the URL
        const url = geoserverBaseUrl + '/wms?' + L.Util.getParamString(params);
        
        // Make the request
        // Make the request
        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // Highlight the parcel first
                highlightParcel(data);
                // Then display the information
                displayParcelInfo(data);
            })
            .catch(error => {
                console.error('Error fetching parcel info:', error);
                document.getElementById('parcelOffcanvasBody').innerHTML = `
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                        <p>Error loading parcel information. Please try again.</p>
                        <p class="small">${error.message}</p>
                    </div>
                `;
            });
    }

    // Show the custom offcanvas
    function showParcelOffcanvas() {
        const offcanvas = document.getElementById('parcelOffcanvas');
        offcanvas.style.display = 'block'; // make it visible
    }

    // Hide the custom offcanvas
    function hideParcelOffcanvas() {
        const offcanvas = document.getElementById('parcelOffcanvas');
        offcanvas.style.display = 'none'; // hide it
    }

    // Close offcanvas when clicking outside
    document.addEventListener('click', function(event) {
        const offcanvas = document.getElementById('parcelOffcanvas');
        const isClickInsideOffcanvas = offcanvas.contains(event.target);
        
        if (!isClickInsideOffcanvas && offcanvas.classList.contains('show')) {
            // Check if the click is on the map or its children
            const mapElement = document.getElementById('map');
            const isClickOnMap = mapElement.contains(event.target) || event.target === mapElement;
            
            if (isClickOnMap) {
                hideParcelOffcanvas();
            }
        }
    });

    // Function to display parcel information in the offcanvas
    function displayParcelInfo(data) {
        console.log(data);
        const offcanvasBody = document.getElementById('parcelOffcanvasBody');
        
        if (data.features && data.features.length > 0) {
            const feature = data.features[0];
            const properties = feature.properties;
            
            // Get parcel ID for header
            const parcelId = properties.parcel_id || properties.plot_no || properties.serial_no || 'Parcel';
            
            let html = `
                <div class="parcel-header">
                    <div class="parcel-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <h6 class="parcel-title">Plot No.` +parcelId+`</h6>
                </div>
                
                <div class="parcel-details-grid">
                <textarea style="display:none;" id="parcelData" readonly>`+JSON.stringify(properties)+`</textarea>
            `;
            
            // Define standardized property groups in priority order
            const propertyGroups = [
                {
                    title: 'Identification',
                    properties: ['parcel_id', 'plot_no', 'serial_no', 'registry_no', 'survey_no']
                },
                {
                    title: 'Location',
                    properties: ['zone', 'location', 'address', 'coordinates']
                },
                {
                    title: 'Dimensions',
                    properties: ['area', 'size', 'acreage', 'dimensions', 'length', 'width']
                },
                {
                    title: 'Status',
                    properties: ['allocation_status', 'land_use', 'owner', 'condition', 'type']
                },
                {
                    title: 'Administrative',
                    properties: ['district', 'region', 'municipality', 'ward']
                }
            ];
            
            // Render property groups
            propertyGroups.forEach(group => {
                const groupProperties = group.properties.filter(prop => 
                    properties[prop] !== null && properties[prop] !== undefined
                );
                
                if (groupProperties.length > 0) {
                    html += `
                        <div class="property-group">
                            <div class="property-group-header">`+group.title+`</div>
                            <div class="property-group-content">
                    `;
                    
                    groupProperties.forEach(prop => {
                        const allocation_status = prop == 'allocation_status' ? (properties[prop] == 0 ? 'Unallocated' : properties[prop] == 1 ? 'Allocated' : 'Processing') : '';
                        const parcel_prop = prop == 'allocation_status' ? allocation_status : formatLandValue(prop, properties[prop]);
                        html += `
                            <div class="property-item">
                                <span class="property-label">`+formatPropertyName(prop)+`:</span>
                                <span class="property-value">`+parcel_prop+`</span>
                            </div>
                        `;
                    });
                    
                    html += `
                            </div>
                        </div>
                    `;
                }
            });
            
            // Add any remaining properties not in groups
            const allGroupedProperties = propertyGroups.flatMap(group => group.properties);
            const remainingProperties = Object.keys(properties)
                .filter(key => !allGroupedProperties.includes(key) && properties[key] !== null)
                .sort();
                
            if (remainingProperties.length > 0) {
                html += `
                    <div class="property-group">
                        <div class="property-group-header">Additional Information</div>
                        <div class="property-group-content">
                `;
                
                remainingProperties.forEach(prop => {
                    html += `
                        <div class="property-item">
                            <span class="property-label">`+formatPropertyName(prop)+`:</span>
                            <span class="property-value">`+properties[prop]+`</span>
                        </div>
                    `;
                });
                
                html += `
                        </div>
                    </div>
                `;
            }
            
            html += `</div>`; // Close parcel-details-grid
            
            offcanvasBody.innerHTML = html;
        } else {
            offcanvasBody.innerHTML = `
                <div class="no-data-message">
                    <div class="no-data-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <h6>No Parcel Data</h6>
                    <p>No information found for this location.</p>
                </div>
            `;
        }
    }

    // Helper function to format land-specific values
    function formatLandValue(propertyName, value) {
        // console.log(value)
        if (propertyName.includes('area') || propertyName.includes('size') || propertyName.includes('Acreage')) {
            // Format area values
            const numValue = parseFloat(value);
            if (!isNaN(numValue)) {
                if (numValue >= 10000) {
                    return (numValue / 10000).toFixed(2) + ' hectares';
                } else if (numValue >= 1000) {
                    return (numValue / 1000).toFixed(2) + ' acres';
                } else {
                    return numValue + ' sq meters';
                }
            }
        }
        
        // if (propertyName.includes('status')) {
        //     // Format status values
        //     return `<span class="status-badge status-`+value.toLowerCase()+`">`+value+`</span>`;
        // }
        
        if (propertyName.includes('date')) {
            // Format date values
            return new Date(value).toLocaleDateString();
        }
        
        return value;
    }

    // Helper function to format property names for display
    function formatPropertyName(name) {
        return name
            .replace(/_/g, ' ')
            .replace(/([A-Z])/g, ' $1')
            .replace(/\b\w/g, l => l.toUpperCase())
            .trim();
    }
</script>