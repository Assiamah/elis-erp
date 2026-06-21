

var lrd_point_coordinate_list;

var lrd_click_type = 'MapClick';

	// Create an overlay for the popup FIRST
var pvlmd_popupOverlay = new ol.Overlay({
    element: document.createElement('div'),
    positioning: 'bottom-center',
    stopEvent: false,
    offset: [0, -10]
});

// ====== POPUP FUNCTIONS - Define these FIRST ======

// Show popup with content at the specified coordinate
function showPopup(content, coordinate) {
    var popupElement = pvlmd_popupOverlay.getElement();
    
    popupElement.innerHTML = content;
    popupElement.style.display = 'block';
    
    // Add close button
    var closeBtn = document.createElement('span');
    closeBtn.className = 'ol-popup-closer';
    closeBtn.innerHTML = '×';
    closeBtn.onclick = function() {
        pvlmd_popupOverlay.setPosition(undefined);
        popupElement.style.display = 'none';
    };
    
    // Remove existing close button if any
    var existingClose = popupElement.querySelector('.ol-popup-closer');
    if (existingClose) {
        existingClose.remove();
    }
    
    popupElement.prepend(closeBtn);
    
    // Position the popup at the click coordinate
    if (coordinate) {
        pvlmd_popupOverlay.setPosition(coordinate);
    }
}

// Display "No data" message
function displayNoDataMessage(layerName, coordinate) {
    var content = '<div class="attribute-popup">';
    content += '<h4>' + layerName + '</h4>';
    content += '<div style="max-height: 250px; overflow-y: auto; padding: 10px;">';
    content += '<p style="color: #666; text-align: center;">No attribute data available at this location</p>';
    content += '</div></div>';
    showPopup(content, coordinate);
}

// Display simple text data at the click position
function displaySimpleText(layerName, text, coordinate) {
    var content = '<div class="attribute-popup">';
    content += '<h4>' + layerName + '</h4>';
    content += '<div style="max-height: 250px; overflow-y: auto; white-space: pre-wrap; font-size: 13px;">';
    content += text;
    content += '</div></div>';
    showPopup(content, coordinate);
}

// Display HTML data in the popup at the click position
function displayHTMLData(layerName, htmlData, coordinate) {
    var content = '<div class="attribute-popup">';
    content += '<h4>' + layerName + '</h4>';
    content += '<div style="max-height: 250px; overflow-y: auto;">';
    content += htmlData;
    content += '</div></div>';
    showPopup(content, coordinate);
}

// Function to display attribute data in a popup at the click position
function displayAttributeData(layerName, features, coordinate) {
    var content = '<div class="attribute-popup">';
    content += '<h4>' + layerName + '</h4>';
    content += '<div style="max-height: 250px; overflow-y: auto;">';
    
    if (!features || features.length === 0) {
        content += '<p style="color: #666; text-align: center; padding: 10px;">No attributes found</p>';
    } else {
        features.forEach(function(feature, index) {
            if (feature.properties) {
                content += '<div class="feature-properties">';
                if (features.length > 1) {
                    content += '<strong>Feature ' + (index + 1) + ':</strong><br>';
                }
                
                var props = feature.properties;
                var propKeys = Object.keys(props);
                
                if (propKeys.length === 0) {
                    content += 'No attributes available';
                } else {
                    propKeys.forEach(function(key) {
                        if (props[key] !== null && props[key] !== undefined && props[key] !== '') {
                            content += '<strong>' + key + ':</strong> ' + props[key] + '<br>';
                        }
                    });
                }
                
                content += '</div>';
                if (index < features.length - 1) {
                    content += '<hr>';
                }
            }
        });
    }
    
    content += '</div></div>';
    showPopup(content, coordinate);
}

// ====== PARSING FUNCTIONS ======

// Improved XML parsing function
function parseXMLFeatureInfo(xmlText, layer) {
    try {
        var parser = new DOMParser();
        var xmlDoc = parser.parseFromString(xmlText, "text/xml");
        
        // Check for parsing errors
        var parserError = xmlDoc.getElementsByTagName('parsererror');
        if (parserError.length > 0) {
            console.log('XML parsing error');
            return null;
        }
        
        var features = [];
        
        // Try different XML structures
        var featureMembers = xmlDoc.getElementsByTagName('featureMember');
        if (featureMembers.length === 0) {
            featureMembers = xmlDoc.getElementsByTagName('gml:featureMember');
        }
        
        if (featureMembers.length > 0) {
            for (var i = 0; i < featureMembers.length; i++) {
                var props = {};
                var allElements = featureMembers[i].getElementsByTagName('*');
                for (var j = 0; j < allElements.length; j++) {
                    var el = allElements[j];
                    if (el.children.length === 0 && el.textContent.trim() !== '') {
                        var tagName = el.tagName.replace(/^.*:/, '');
                        if (tagName !== 'geometry' && tagName !== 'boundedBy' && 
                            tagName !== 'Envelope' && tagName !== 'lowerCorner' && 
                            tagName !== 'upperCorner' && tagName !== 'pos' &&
                            tagName !== 'Point' && tagName !== 'posList' &&
                            tagName !== 'MultiPolygon' && tagName !== 'Polygon' &&
                            tagName !== 'LinearRing' && tagName !== 'coordinates') {
                            props[tagName] = el.textContent.trim();
                        }
                    }
                }
                if (Object.keys(props).length > 0) {
                    features.push({ properties: props });
                }
            }
        }
        
        if (features.length > 0) {
            return { features: features };
        }
        return null;
    } catch (e) {
        console.log('Error parsing XML:', e);
        return null;
    }
}

// Extract data from plain text
function extractDataFromText(text) {
    if (!text || text.length === 0) return null;
    
    // Parse key-value pairs from text like "key = value"
    var lines = text.split('\n');
    var result = '';
    var hasData = false;
    
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i].trim();
        if (line) {
            // Check if line contains a colon, equals, or dash
            if (line.includes(':') || line.includes('=') || line.includes(' - ')) {
                hasData = true;
                result += line + '\n';
            } else if (hasData && line.length > 0) {
                result += line + '\n';
            }
        }
    }
    
    if (hasData) {
        return result;
    }
    return text;
}

// ====== LAYER CLICK HANDLERS ======

// Main click handler using XML format
function handleLayerClick(evt) {
    var viewResolution = evt.map.getView().getResolution();
    var coordinate = evt.coordinate;
    
    // Get all visible tile layers that are WMS layers
    var visibleLayers = [];
    evt.map.getLayers().forEach(function(layer) {
        if (layer.getVisible() && layer.getSource() instanceof ol.source.TileWMS) {
            visibleLayers.push(layer);
        }
    });
    
    if (visibleLayers.length === 0) {
        console.log('No visible WMS layers to query');
        return;
    }
    
    var clickCoordinate = coordinate;
    
    visibleLayers.forEach(function(layer) {
        var source = layer.getSource();
        var layerName = source.getParams()['LAYERS'];
        var layerTitle = layer.get('title') || 'Layer';
        
        console.log('Querying layer:', layerName);
        
        // Try text/plain format first - it works well for simple attributes
        var url = source.getGetFeatureInfoUrl(
            coordinate,
            viewResolution,
            evt.map.getView().getProjection(),
            {
                'INFO_FORMAT': 'text/plain',
                'FEATURE_COUNT': 10,
                'QUERY_LAYERS': layerName
            }
        );
        
        console.log('Request URL:', url);
        
        if (url) {
            fetch(url)
                .then(function(response) {
                    return response.text();
                })
                .then(function(data) {
                    console.log('Text response for ' + layerTitle + ':', data.substring(0, 300));
                    
                    // Check if it's an XML error
                    if (data.trim().startsWith('<?xml')) {
                        // Try to parse as XML
                        var parsedData = parseXMLFeatureInfo(data, layer);
                        if (parsedData && parsedData.features && parsedData.features.length > 0) {
                            displayAttributeData(layerTitle, parsedData.features, clickCoordinate);
                            return;
                        }
                    }
                    
                    // Check if data contains actual attribute info
                    if (data && data.length > 0 && !data.includes('ServiceException')) {
                        var extractedData = extractDataFromText(data);
                        if (extractedData && extractedData.length > 0 && extractedData.includes('=')) {
                            // Format the extracted data nicely
                            var formattedData = extractedData.replace(/=/g, ': ');
                            displaySimpleText(layerTitle, formattedData, clickCoordinate);
                            return;
                        }
                    }
                    
                    // If no data found, try JSON format
                    tryJSONFormat(layer, coordinate, viewResolution, clickCoordinate);
                })
                .catch(function(error) {
                    console.log('Error with text request:', error);
                    tryJSONFormat(layer, coordinate, viewResolution, clickCoordinate);
                });
        }
    });
}

// Try JSON format
function tryJSONFormat(layer, coordinate, viewResolution, clickCoordinate) {
    var source = layer.getSource();
    var layerName = source.getParams()['LAYERS'];
    var layerTitle = layer.get('title') || 'Layer';
    
    var url = source.getGetFeatureInfoUrl(
        coordinate,
        viewResolution,
        pvlmd_map.getView().getProjection(),
        {
            'INFO_FORMAT': 'application/json',
            'FEATURE_COUNT': 10,
            'QUERY_LAYERS': layerName
        }
    );
    
    if (url) {
        fetch(url)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log('JSON response for ' + layerTitle + ':', data);
                if (data.features && data.features.length > 0) {
                    displayAttributeData(layerTitle, data.features, clickCoordinate);
                } else {
                    // Try text/plain with different parameters
                    tryTextPlainWithParams(layer, coordinate, viewResolution, clickCoordinate);
                }
            })
            .catch(function(error) {
                console.log('JSON request failed:', error);
                tryTextPlainWithParams(layer, coordinate, viewResolution, clickCoordinate);
            });
    }
}

// Try text/plain with different parameters
function tryTextPlainWithParams(layer, coordinate, viewResolution, clickCoordinate) {
    var source = layer.getSource();
    var layerName = source.getParams()['LAYERS'];
    var layerTitle = layer.get('title') || 'Layer';
    
    // Try with different parameter combinations
    var url = source.getGetFeatureInfoUrl(
        coordinate,
        viewResolution,
        pvlmd_map.getView().getProjection(),
        {
            'INFO_FORMAT': 'text/plain',
            'FEATURE_COUNT': 10,
            'QUERY_LAYERS': layerName,
            'BUFFER': 5  // Add a small buffer
        }
    );
    
    if (url) {
        fetch(url)
            .then(function(response) {
                return response.text();
            })
            .then(function(data) {
                console.log('Text with params response:', data.substring(0, 300));
                if (data && data.length > 0 && !data.includes('ServiceException')) {
                    var extractedData = extractDataFromText(data);
                    if (extractedData && extractedData.length > 0) {
                        var formattedData = extractedData.replace(/=/g, ': ');
                        displaySimpleText(layerTitle, formattedData, clickCoordinate);
                        return;
                    }
                }
                displayNoDataMessage(layerTitle, clickCoordinate);
            })
            .catch(function(error) {
                console.log('Text with params failed:', error);
                displayNoDataMessage(layerTitle, clickCoordinate);
            });
    }
}


					var pvlmd_regional_boundary_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:gh_lvd_region',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var pvlmd_regional_boundary_dataLayer = new ol.layer.Tile({
						title : 'Regional Boundary',
						source : pvlmd_regional_boundary_dataSource

					})

var pvlmd_parcel_lrd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:lc_spatial_objects',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_lrd_parcels_dataLayer = new ol.layer.Tile({
	title : 'LRD Parcels Layer',
	visible : false,
	source : pvlmd_parcel_lrd_dataSource

})

var pvlmd_parcels_smd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:parcels_smd',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_parcels_smd_dataLayer = new ol.layer.Tile({
	title : 'SMD Parcels Layer',
	visible : false,
	source : pvlmd_parcels_smd_dataSource

})

var pvlmd_cadastral_smd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:cadastral',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_cadastral_smd_dataLayer = new ol.layer.Tile({
	title : 'SMD Cadastral Layer',
	source : pvlmd_cadastral_smd_dataSource

})

var pvlmd_garro_parcels_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:garro_data',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_garro_parcels_dataLayer = new ol.layer.Tile({
	title : 'Existing GARRO Layer',
	// visible: false,
	source : pvlmd_garro_parcels_dataSource

})

var pvlmd_cro_sp_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:archive_cro_data',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_cro_parcels_dataLayer = new ol.layer.Tile({
	title : 'Existing CRO Layer',
	// visible: false,
	source : pvlmd_cro_sp_dataSource

})

var pvlmd_pvlmd_current_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:pvlmd_parcles',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_pvlmd_current_dataLayer = new ol.layer.Tile({
	title : 'PVLMD Current Layer',
	// visible: false,
	source : pvlmd_pvlmd_current_dataSource

})

var pvlmd_grid_lrd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:gng_grid',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_grid_lrd_dataLayer = new ol.layer.Tile({
	title : 'LRD Grid',
	visible : false,
	source : pvlmd_grid_lrd_dataSource

})

var pvlmd_registration_district_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:district',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var pvlmd_registration_district_dataLayer = new ol.layer.Tile({
	title : 'Registration District',
	visible : false,
	source : pvlmd_registration_district_dataSource

})



							var pvlmd_volta_region_old_data_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:volta_pvlmd_old_parcel_records',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var pvlmd_volta_region_old_data_dataLayer = new ol.layer.Tile(
							{
								title : 'Volta Old Data',
								visible : false,
								source : pvlmd_volta_region_old_data_dataSource

							})

// 104_modified_CR
// DIST_03_01_A_modified

var pvlmd_StaticImage = new ol.layer.Image({
	title : 'Scanned Map',
	// extent: [-13884991, 2870341, -7455066, 6338219],
	visible : true,
	source : undefined,
/*
 * source: new ol.source.ImageWMS({ url:
 * getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms', params: {'LAYERS':
 * 'csau_geospatial:104_modified_CR'}, serverType: 'geoserver', })
 */
});

pvlmd_garro_search_result_searchLayer = new ol.layer.Vector({
	title : 'garro_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'pink',
			width : 3
		})
	})
});

pvlmd_cro_search_result_searchLayer = new ol.layer.Vector({
	title : 'cro_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'orange',
			width : 3
		})
	})
});

pvlmd_current_search_result_searchLayer = new ol.layer.Vector({
	title : 'pvlmd_current_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'blue',
			width : 3
		})
	})
});

pvlmd_smd_parcel_search_result_searchLayer = new ol.layer.Vector({
	title : 'smd_parcel_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'purple',
			width : 3
		})
	})
});

pvlmd_smd_cadastral_search_result_searchLayer = new ol.layer.Vector({
	title : 'smd_cadastral_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'brown',
			width : 3
		})
	})
});

pvlmd_lrd_search_result_searchLayer = new ol.layer.Vector({
	title : 'lrd_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'green',
			width : 3
		})
	})
});

pvlmd_lc_searchLayer = new ol.layer.Vector({
	title : 'Search Layer',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'red',
			width : 3
		})
	})
});

var pvlmd_markers = new ol.layer.Vector({
	// title: 'Markers',
	source : new ol.source.Vector(),

});


var london = ol.proj.fromLonLat([ -0.12755, 51.507222 ]), istanbul = ol.proj
		.fromLonLat([ 28.9744, 41.0128 ]), view = new ol.View({
	center : istanbul,
	zoom : 5
});
var vectorLayer;


// create a vector layer used for editing
var pvlmd_vector_layer = new ol.layer.Vector({
	name : 'my_vectorlayer',
	source : new ol.source.Vector(),
	style : new ol.style.Style({
		fill : new ol.style.Fill({
			color : 'rgba(255, 255, 255, 0.2)'
		}),
		stroke : new ol.style.Stroke({
			color : '#ffcc33',
			width : 2
		}),
		image : new ol.style.Circle({
			radius : 7,
			fill : new ol.style.Fill({
				color : '#ffcc33'
			})
		})
	})
});

var pvlmd_features = new ol.Collection();
var pvlmd_featureOverlay = new ol.layer.Vector({
	source : new ol.source.Vector({
		features : pvlmd_features
	}),
	style : new ol.style.Style({
		fill : new ol.style.Fill({
			color : 'rgba(255, 255, 255, 0.2)'
		}),
		stroke : new ol.style.Stroke({
			color : '#ffcc33',
			width : 2
		}),
		image : new ol.style.Circle({
			radius : 7,
			fill : new ol.style.Fill({
				color : '#ffcc33'
			})
		})
	})
});




var pvlmd_googleLayerHybrid = new ol.layer.Tile({
	title : "Google Satellite & Roads",
	// 'type': 'base',
	visible : false,
	'opacity' : 1.000000,
	source : new ol.source.XYZ({
		attributions : [ new ol.Attribution({
			html : '<a href=""></a>'
		}) ],
		url : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
	}),
});

var pvlmd_new_de = new ol.layer.Tile({
	title : "Open Street Map",
	// 'type': 'base',
	visible : false,
	source : new ol.source.OSM({
		wrapX : false
	}),
// projection: 'EPSG:4326'
})

var pvlmd_source = new ol.source.Vector({
	wrapX : false
});

var vector = new ol.layer.Vector({
	'type' : 'base',
	source : pvlmd_source
});

var pvlmd_projObj = new ol.proj.Projection({
	// code: 'EPSG:3857',
	code : 'EPSG:2136',
	extent : [ 80935.4497355444, 1209.0295731349593, 1711780.3060929566,
			2358523.124783509 ],
	units : 'ft',
	axisOrientation : 'enu',
	global : false,
	// worldExtent: [-199,32,322,0],
	worldExtent : [ -3.79, 1.4, 2.1, 11.16 ],
	getPointResolution : function(r) {
		return r;
	},
// worldExtent: [-118905.86588345, -1185221.57235827,
// 2011055.53818079,
// 2360318.82691170]
// extent: [32000000,5900000,33000000,6000000]
// extent: [32502277,5970203,32513486,5971984]
});

ol.proj.setProj4(proj4);
proj4
		.defs(
				"EPSG:2136",
				'+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs');
// var secondProjection = proj4.defs("EPSG:4326",
// '+proj=longlat +datum=WGS84
// +no_defs');

var pvlmd_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
var pvlmd_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

var pvlmd_draw;
var pvlmd_modify;
var pvlmd_snap;
var pvlmd_select;

var pvlmd_proj27700 = ol.proj.get('EPSG:2136');
// proj27700.setExtent([0, 0, 2011055.53818079,
// 2360318.82691170]);
pvlmd_proj27700.setExtent([ 80935.4497355444, 1209.0295731349593,
		1711780.3060929566, 2358523.124783509 ]);

var pvlmd_view_e = new ol.View({
	// center: ol.proj.fromLonLat([4.8, 47.75]),
	// center: ol.proj.transform([1187433.58822084,
	// 327091.107070208],
	// 'EPSG:4326','EPSG:3857'),
	projection : pvlmd_projObj,
	// projection: 'EPSG:2136',
	// center: ol.proj.fromLonLat([1187433.58822084,
	// 327091.107070208],
	// projObj),
	// center: [956164.35527782, 584176.05990338],
	center : [ 1187433.58822084, 327091.107070208 ],
	// extent:projObj.getExtent(),
	extent : ol.proj.get('EPSG:2136').getExtent(),
	scales : [ 100000, 250000, 500000, 1000000, 2000000, 4000000, 8000000 ],
	zoom : 12
})

var pvlmd_map = new ol.Map({
	target : 'alld-map',
	controls : ol.control.defaults().extend(
			[ new ol.control.LayerSwitcher(),
			/*
			 * new ol.control.MousePosition({ coordinateFormat:
			 * ol.coordinate.toStringHDMS, }),
			 */
			new ol.control.OverviewMap(),
			// new ol.control.ScaleLine(),
			// new ol.control.ScaleLineUnits0(),
			// new
			// ol.control.ControlDrawFeatures(vector_draw,
			// optionsControlDraw),
			// new
			// ol.control.ControlDrawButtons(vector_layer,
			// opt_options),
			new ol.control.ZoomSlider(), new ol.control.Attribution(),
					new ol.control.MousePosition(),
					new ol.control.ZoomToExtent(), new ol.control.FullScreen()
			// ,mousePositionControl

			]),
	renderer : 'canvas',
	layers : [ new ol.layer.Tile({
		title : 'Open Street',
		source : new ol.source.OSM()
	}) ],
	view : pvlmd_view_e
});

// Add the popup overlay to the map
pvlmd_map.addOverlay(pvlmd_popupOverlay);
// map.addLayer(new_de);
pvlmd_map.addLayer(pvlmd_googleLayerHybrid);
pvlmd_map.addLayer(pvlmd_StaticImage);
	pvlmd_map.addLayer(pvlmd_regional_boundary_dataLayer);
pvlmd_map.addLayer(pvlmd_registration_district_dataLayer);

pvlmd_map.addLayer(pvlmd_grid_lrd_dataLayer);

// map.addLayer(beacon_lrd_dataLayer);

pvlmd_map.addLayer(pvlmd_lrd_parcels_dataLayer);
pvlmd_map.addLayer(pvlmd_parcels_smd_dataLayer);
pvlmd_map.addLayer(pvlmd_cadastral_smd_dataLayer);
pvlmd_map.addLayer(pvlmd_pvlmd_current_dataLayer);
pvlmd_map.addLayer(pvlmd_cro_parcels_dataLayer);
	pvlmd_map.addLayer(pvlmd_volta_region_old_data_dataLayer);
pvlmd_map.addLayer(pvlmd_garro_parcels_dataLayer);

pvlmd_map.addLayer(pvlmd_garro_search_result_searchLayer);
pvlmd_map.addLayer(pvlmd_cro_search_result_searchLayer);
pvlmd_map.addLayer(pvlmd_current_search_result_searchLayer);
pvlmd_map.addLayer(pvlmd_smd_parcel_search_result_searchLayer);
pvlmd_map.addLayer(pvlmd_smd_cadastral_search_result_searchLayer);
pvlmd_map.addLayer(pvlmd_lrd_search_result_searchLayer);
pvlmd_map.addLayer(pvlmd_vector_layer);
pvlmd_map.addLayer(pvlmd_lc_searchLayer);
// Add click listener to the map

// Add click listener to the map
pvlmd_map.on('singleclick', handleLayerClick);

// Optional: Add hover effect to change cursor
pvlmd_map.on('pointermove', function(evt) {
    var hit = pvlmd_map.forEachLayerAtPixel(evt.pixel, function(layer) {
        return layer.getVisible() && layer.getSource() instanceof ol.source.TileWMS;
    });
    if (hit) {
        pvlmd_map.getTargetElement().style.cursor = 'pointer';
    } else {
        pvlmd_map.getTargetElement().style.cursor = '';
    }
});

// Close popup when map moves
pvlmd_map.on('moveend', function() {
    var popupElement = pvlmd_popupOverlay.getElement();
    if (popupElement) {
        pvlmd_popupOverlay.setPosition(undefined);
        popupElement.style.display = 'none';
    }
});

// ====== REST OF YOUR EXISTING FUNCTIONS ======

function addDigitizeInteraction(drawType) {
    if (pvlmd_draw) {
        pvlmd_map.removeInteraction(pvlmd_draw);
    }
    if (pvlmd_modify) {
        pvlmd_map.removeInteraction(pvlmd_modify);
    }
    pvlmd_draw = new ol.interaction.Draw({
        source: pvlmd_vector_layer.getSource(),
        type: drawType
    });
    pvlmd_map.addInteraction(pvlmd_draw);
    pvlmd_draw.on('drawend', function(evt) {
        var feature = evt.feature;
        var geometry = feature.getGeometry();
        console.log("Digitized Geometry", geometry);
        if (geometry instanceof ol.geom.Point) {
            console.log(geometry.getCoordinates());
        } else if (geometry instanceof ol.geom.LineString) {
            console.log(geometry.getCoordinates());
        } else if (geometry instanceof ol.geom.Polygon) {
            console.log(geometry.getCoordinates());
        }
    });
}

function enableModify() {
    if (pvlmd_draw) {
        pvlmd_map.removeInteraction(pvlmd_draw);
    }
    if (pvlmd_modify) {
        pvlmd_map.removeInteraction(pvlmd_modify);
    }
    pvlmd_modify = new ol.interaction.Modify({
        source: pvlmd_vector_layer.getSource()
    });
    pvlmd_map.addInteraction(pvlmd_modify);
}

pvlmd_snap = new ol.interaction.Snap({
    source: pvlmd_vector_layer.getSource()
});
pvlmd_map.addInteraction(pvlmd_snap);

pvlmd_select = new ol.interaction.Select();
pvlmd_map.addInteraction(pvlmd_select);

function deleteSelectedFeature() {
    var selected = pvlmd_select.getFeatures();
    selected.forEach(function(feature) {
        pvlmd_vector_layer.getSource().removeFeature(feature);
    });
    selected.clear();
}

function clearDigitizedFeatures() {
    pvlmd_vector_layer.getSource().clear();
}

function exportGeoJSON() {
    var geojson = new ol.format.GeoJSON();
    var features = pvlmd_vector_layer.getSource().getFeatures();
    var json = geojson.writeFeatures(features);
    console.log(json);
    return json;
}

function exportFeaturesToJSONArray() {
    var features = pvlmd_vector_layer.getSource().getFeatures();
    var result = [];
    features.forEach(function(feature) {
        var geometry = feature.getGeometry();
        var featureObj = {
            geometryType: geometry.getType(),
            coordinates: geometry.getCoordinates()
        };
        result.push(featureObj);
    });
    console.log(JSON.stringify(result));
    return result;
}
// });
