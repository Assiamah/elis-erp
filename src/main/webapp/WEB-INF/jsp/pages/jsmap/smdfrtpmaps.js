/*$(document)
		.ready(
				function() {*/
var smdfrtpmaps_parcel_lrd_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_lrd_parcels_dataLayer = new ol.layer.Tile({
	title : 'LRD Parcels Layer',
	source : smdfrtpmaps_parcel_lrd_dataSource

})

var smdfrtpmaps_parcels_smd_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_parcels_smd_dataLayer = new ol.layer.Tile({
	title : 'SMD Parcels Layer',
	source : smdfrtpmaps_parcels_smd_dataSource

})

var smdfrtpmaps_cadastral_smd_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_cadastral_smd_dataLayer = new ol.layer.Tile({
	title : 'SMD Cadastral Layer',
	source : smdfrtpmaps_cadastral_smd_dataSource

})

var smdfrtpmaps_garro_parcels_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_garro_parcels_dataLayer = new ol.layer.Tile({
	title : 'Existing GARRO Layer',
	// visible: false,
	source : smdfrtpmaps_garro_parcels_dataSource

})

var smdfrtpmaps_cro_sp_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_cro_parcels_dataLayer = new ol.layer.Tile({
	title : 'Existing CRO Layer',
	// visible: false,
	source : smdfrtpmaps_cro_sp_dataSource

})

var smdfrtpmaps_pvlmd_current_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_pvlmd_current_dataLayer = new ol.layer.Tile({
	title : 'PVLMD Current Layer',
	// visible: false,
	source : smdfrtpmaps_pvlmd_current_dataSource

})

var smdfrtpmaps_grid_lrd_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_grid_lrd_dataLayer = new ol.layer.Tile({
	title : 'Grid',
	visible : false,
	source : smdfrtpmaps_grid_lrd_dataSource

})

var smdfrtpmaps_registration_district_dataSource = new ol.source.TileWMS({
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

var smdfrtpmaps_registration_district_dataLayer = new ol.layer.Tile({
	title : 'Registration District',
	visible : false,
	source : smdfrtpmaps_registration_district_dataSource

})

// 104_modified_CR
// DIST_03_01_A_modified

var smdfrtpmaps_StaticImage = new ol.layer.Image({
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

smdfrtpmaps_garro_search_result_searchLayer = new ol.layer.Vector({
	title : 'garro_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'pink',
			width : 3
		})
	})
});

smdfrtpmaps_cro_search_result_searchLayer = new ol.layer.Vector({
	title : 'cro_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'orange',
			width : 3
		})
	})
});

smdfrtpmaps_pvlmd_current_search_result_searchLayer = new ol.layer.Vector({
	title : 'pvlmd_current_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'blue',
			width : 3
		})
	})
});

smdfrtpmaps_smd_parcel_search_result_searchLayer = new ol.layer.Vector({
	title : 'smd_parcel_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'purple',
			width : 3
		})
	})
});

smdfrtpmaps_smd_cadastral_search_result_searchLayer = new ol.layer.Vector({
	title : 'smd_cadastral_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'brown',
			width : 3
		})
	})
});

smdfrtpmaps_lrd_search_result_searchLayer = new ol.layer.Vector({
	title : 'lrd_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'green',
			width : 3
		})
	})
});

smdfrtpmaps_lc_searchLayer = new ol.layer.Vector({
	title : 'Search Layer',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'red',
			width : 3
		})
	})
});

var smdfrtpmaps_markers = new ol.layer.Vector({
	// title: 'Markers',
	source : new ol.source.Vector(),
// style: iconStyle

/*
 * new ol.style.Style({
 * 
 * image: new ol.style.Icon({ anchor: [0.5, 1], src: 'marker.png' }) })
 */
});

// var all_layers = [vectorwkt];

var london = ol.proj.fromLonLat([ -0.12755, 51.507222 ]), istanbul = ol.proj
		.fromLonLat([ 28.9744, 41.0128 ]), view = new ol.View({
	center : istanbul,
	zoom : 5
});
var vectorLayer;

// var all_layers = [pvlmdparcelsLayer,vectorLayer];
// var all_layers = [pvlmdparcelsLayer];
// 

// create a vector layer used for editing
var vector_layer = new ol.layer.Vector({
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

var features = new ol.Collection();
var featureOverlay = new ol.layer.Vector({
	source : new ol.source.Vector({
		features : features
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

var smdfrtpmaps_googleLayerHybrid = new ol.layer.Tile({
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

var smdfrtpmaps_new_de = new ol.layer.Tile({
	title : "Open Street Map",
	// 'type': 'base',
	visible : false,
	source : new ol.source.OSM({
		wrapX : false
	}),
// projection: 'EPSG:4326'
})

var source = new ol.source.Vector({
	wrapX : false
});

var vector = new ol.layer.Vector({
	'type' : 'base',
	source : source
});

var smdfrtpmaps_projObj = new ol.proj.Projection({
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

var smdfrtpmaps_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
var smdfrtpmaps_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

// console.log(firstProjection);
// console.log(secondProjection);
// proj4(firstProjection,secondProjection,[2,5]);
// console.log(proj4(secondProjection,firstProjection,[2,5]));
// ol.proj.proj4.register(proj4);
// ol.proj.registerProj4(proj4);
// register(proj4);

var proj27700 = ol.proj.get('EPSG:2136');
// proj27700.setExtent([0, 0, 2011055.53818079,
// 2360318.82691170]);
proj27700.setExtent([ 80935.4497355444, 1209.0295731349593, 1711780.3060929566,
		2358523.124783509 ]);

var smdfrtpmaps_view_e = new ol.View({
	// center: ol.proj.fromLonLat([4.8, 47.75]),
	// center: ol.proj.transform([1187433.58822084,
	// 327091.107070208],
	// 'EPSG:4326','EPSG:3857'),
	projection : smdfrtpmaps_projObj,
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

var smdfrtpmaps_map = new ol.Map({
	target : 'smdfrtp-map',
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
	view : smdfrtpmaps_view_e
});

// map.addLayer(new_de);
smdfrtpmaps_map.addLayer(smdfrtpmaps_googleLayerHybrid);
smdfrtpmaps_map.addLayer(smdfrtpmaps_StaticImage);
smdfrtpmaps_map.addLayer(smdfrtpmaps_registration_district_dataLayer);

smdfrtpmaps_map.addLayer(smdfrtpmaps_grid_lrd_dataLayer);

// map.addLayer(beacon_lrd_dataLayer);

/*
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_lrd_parcels_dataLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_parcels_smd_dataLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_cadastral_smd_dataLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_pvlmd_current_dataLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_cro_parcels_dataLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_garro_parcels_dataLayer);
 * 
 * 
 * 
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_garro_search_result_searchLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_cro_search_result_searchLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_pvlmd_current_search_result_searchLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_smd_parcel_search_result_searchLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_smd_cadastral_search_result_searchLayer);
 * smdfrtpmaps_map.addLayer(smdfrtpmaps_lrd_search_result_searchLayer);
 */

smdfrtpmaps_map.addLayer(smdfrtpmaps_lc_searchLayer);

document.getElementById('smdfrtp_lc_btn_fr_visualise_wkt').addEventListener(
		'click', function() {
			// wktplygonsearch
			// v
			// console.log(wktplygonsearch)

			// var wktplygonsearch =
			// $('#lc_bl_wkt_polygon').val();
			var wktplygonsearch = $('#lc_fr_bl_wkt_polygon').val();
			console.log(wktplygonsearch)

			smdfrtpmaps_lc_searchLayer.setSource(new ol.source.Vector({
				features : (new ol.format.WKT()).readFeatures(wktplygonsearch)
			}));
			// view.fit(pvlmd_searchLayer.getSource().getExtent());
			console.log(wktplygonsearch)

			var extent = smdfrtpmaps_lc_searchLayer.getSource().getExtent();
			smdfrtpmaps_map.getView().fit(extent, {
				size : map.getSize(),
				maxZoom : 16
			})
			// map.getView().fit(pvlmd_searchLayer.getSource().getExtent(),
			// {size:map.getSize(), maxZoom:16})

			// pvlmd_searchLayer.events.register('loadend',
			// pvlmd_searchLayer,
			// function(evt){map.zoomToExtent(pvlmd_searchLayer.getDataExtent())});

			// console.log(wktplygonsearch)
			// view.fit(pvlmd_searchLayer.getSource().getExtent());
		});

document.getElementById('smdfrtp_lc_btn_fr_printmap').addEventListener(
		'click',
		function() {
			console.log("click_type");

			var wktplygonsearch = $('#lc_fr_bl_wkt_polygon').val();

			// wktplygonsearch
			// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();
			console.log(wktplygonsearch);

			var canvas = document.getElementById("smdfrtp-map")
					.getElementsByClassName("ol-unselectable")[0];
			var img = canvas.toDataURL("image/png");

			// var canvas = event.context.canvas;
			// var data =
			// canvas.toDataURL('image/jpeg');
			var doc = new jsPDF('portrait', undefined, 'a4');
			// var doc = new jsPDF('landscape',
			// undefined, 'a4');
			doc.setProperties({
				title : 'Internal Serach',
				subject : 'This is the subject',
				author : 'Assiamah John',
				keywords : 'generated, javascript, web 2.0, ajax',
				creator : 'Creator Name'
			});

			// doc.text(20, 20, 'Internal Search');
			doc.setFontSize(20)
			doc.text(70, 25, 'LANDS COMMISSION')

			/*
			 * var vr_region=
			 * Ext.ComponentQuery.query('combo[name=region]')[0].getValue(); var
			 * vr_assemby_code=
			 * Ext.ComponentQuery.query('combo[name=assembly_code]')[0].getValue();
			 * var vr_division=
			 * Ext.ComponentQuery.query('combo[name=division]')[0].getValue();
			 * var vr_block=
			 * Ext.ComponentQuery.query('combo[name=block]')[0].getValue();
			 * 
			 */
			doc.setFontSize(16)
			doc.text(80, 35, 'TITLE PLAN')

			// doc.setFontSize(20)
			// doc.text(35, 50, 'Assembly: ' +
			// vr_assemby_code + ' Division: ' +
			// vr_division + ' Block: ' + vr_block)

			/*
			 * doc.setFont("courier"); doc.setFontType("normal"); doc.text(20,
			 * 30, 'This is courier normal.');
			 * 
			 * doc.setFont("times"); doc.setFontType("italic"); doc.text(20, 40,
			 * 'This is times italic.');
			 * 
			 * doc.setFont("helvetica"); doc.setFontType("bold"); doc.text(20,
			 * 50, 'This is helvetica bold.'); ;
			 */

			// Logo
			var imgLogo = new Image();
			imgLogo.src = './resources/NewLogo.jpg';
			// imgLogo.src =
			// '../epc/WebContent/resources/NewLogo.jpg'
			// var imgData =
			// 'data:image/jpeg;base64,'+
			// Base64.encode('./resources/NewLogo.jpg');

			// doc.addImage(imgData, 'JPEG', 30, 30,
			// 144, 42); //shows correct
			// image

			doc.addImage(img, 'JPEG', 20, 60, 160, 80);

			doc.setFontSize(10)
			doc.setDrawColor(255, 0, 0); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 170, 50, 170);
			doc.text(60, 170, 'Search Polygon')

			doc.setDrawColor(255, 192, 203); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 180, 50, 180);
			doc.text(60, 180, 'Existing GARRO Parcel')

			doc.setDrawColor(255, 165, 0); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 190, 50, 190);
			doc.text(60, 190, 'Existing CRO Parcel')

			doc.setDrawColor(0, 0, 255); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 200, 50, 200);
			doc.text(60, 200, 'PVLMD Current Parcel')

			doc.setDrawColor(128, 0, 128); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 210, 50, 210);
			doc.text(60, 210, 'SMD Parcel')

			doc.setDrawColor(165, 42, 42); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 220, 50, 220);
			doc.text(60, 220, 'SMD Cadastral')

			doc.setDrawColor(0, 128, 0); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 230, 50, 230);
			doc.text(60, 230, 'LRD Parcel')

			doc.setFontSize(10)
			doc.setFont("courier");
			doc.setFontType("bolditalic");

			/*
			 * var splitTitle = doc.splitTextToSize(wkt_polgon_for_search, 180);
			 * doc.text(20, 210, splitTitle);
			 * 
			 * var splitTitle = doc.splitTextToSize(wkt_polgon_for_search, 180);
			 * doc.text(20, 220, splitTitle);
			 * 
			 * var splitTitle = doc.splitTextToSize(wkt_polgon_for_search, 180);
			 * doc.text(20, 230, splitTitle);
			 * 
			 * 
			 * var splitTitle = doc.splitTextToSize(wkt_polgon_for_search, 180);
			 * doc.text(20, 240, splitTitle);
			 * 
			 * 
			 * 
			 * 
			 * 
			 */

			var splitTitle = doc.splitTextToSize(wktplygonsearch, 180);
			doc.text(20, 250, splitTitle);

			doc.save('map.pdf');

		});
// });
