/*$(document)
		.ready(
				function() {*/

let division_layer = $('#division_layer').val();
console.log(division_layer)

var lrd_click_type = 'MapClick';

var parcel_lrd_dataSource = new ol.source.TileWMS({
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

var lrd_parcels_dataLayer = new ol.layer.Tile({
	title : 'LRD Parcels Layer',
	source : parcel_lrd_dataSource

})

var parcels_smd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:lc_spatial_objects_smd',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var parcels_smd_dataLayer = new ol.layer.Tile({
	title : 'SMD Layer',
	source : parcels_smd_dataSource

})

var garro_parcels_dataSource = new ol.source.TileWMS({
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

var garro_parcels_dataLayer = new ol.layer.Tile({
	title : 'Existing GARRO Layer',
	// visible: false,
	source : garro_parcels_dataSource
});

var cro_sp_dataSource = new ol.source.TileWMS({
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

var cro_parcels_dataLayer = new ol.layer.Tile({
	title : 'Existing CRO Layer',
	// visible: false,
	source : cro_sp_dataSource

})

var pvlmd_current_dataSource = new ol.source.TileWMS({
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

var pvlmd_current_dataLayer = new ol.layer.Tile({
	title : 'PVLMD Current Layer',
	// visible: false,
	source : pvlmd_current_dataSource

})

var grid_lrd_dataSource = new ol.source.TileWMS({
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

var grid_lrd_dataLayer = new ol.layer.Tile({
	title : 'Grid',
	// visible : false,
	source : grid_lrd_dataSource

})

var registration_district_dataSource = new ol.source.TileWMS({
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

var registration_district_dataLayer = new ol.layer.Tile({
	title : 'Registration District',
	visible : false,
	source : registration_district_dataSource

})

var smd_smd_current_dataSource = new ol.source.TileWMS(
	{
		url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
		params : {
			'LAYERS' : 'csau_geospatial:lc_spatial_objects_smd',
			'TILED' : true
		},
		// params: {'LAYERS':
		// 'rating:spatial_unit_assembly', 'cql_filter':
		// "assembly_code='AMA'" , 'TILED': true },,
		serverType : 'geoserver',
		transition : 0
	})

var smd_smd_current_dataLayer = new ol.layer.Tile({
title : 'SMD Current Layer',
// visible: false,
source : smd_smd_current_dataSource

})

var lrd_certificate_region_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:lrd_certificate_region',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var lrd_certificate_region_dataLayer = new ol.layer.Tile({
	title : 'LRD Certificate Region',
	visible : false,
	source : lrd_certificate_region_dataSource

})
// 104_modified_CR
// DIST_03_01_A_modified

var StaticImage = new ol.layer.Image({
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

garro_search_result_searchLayer = new ol.layer.Vector({
	title : 'garro_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'pink',
			width : 3
		})
	})
});

cro_search_result_searchLayer = new ol.layer.Vector({
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

smd_parcel_search_result_searchLayer = new ol.layer.Vector({
	title : 'smd_parcel_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'purple',
			width : 3
		})
	})
});

smd_cadastral_search_result_searchLayer = new ol.layer.Vector({
	title : 'smd_cadastral_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'brown',
			width : 3
		})
	})
});

lrd_search_result_searchLayer = new ol.layer.Vector({
	title : 'lrd_search_result',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'green',
			width : 3
		})
	})
});

lc_searchLayer = new ol.layer.Vector({
	title : 'Search Layer',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'red',
			width : 3
		})
	})
});

var markers = new ol.layer.Vector({
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

var googleLayerHybrid = new ol.layer.Tile({
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

var new_de = new ol.layer.Tile({
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

var projObj = new ol.proj.Projection({
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

var firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
var secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

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

var view_e = new ol.View({
	// center: ol.proj.fromLonLat([4.8, 47.75]),
	// center: ol.proj.transform([1187433.58822084,
	// 327091.107070208],
	// 'EPSG:4326','EPSG:3857'),
	projection : projObj,
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

var map = new ol.Map({
	target : 'lc-map',
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
	view : view_e
});

function switchMapTarget(targetId) {
    map.setTarget(targetId);
}

switchMapTarget('lc-map1');

// map.addLayer(new_de);
map.addLayer(googleLayerHybrid);
map.addLayer(StaticImage);

map.addLayer(lrd_certificate_region_dataLayer);
map.addLayer(registration_district_dataLayer);

map.addLayer(grid_lrd_dataLayer);

// map.addLayer(beacon_lrd_dataLayer);

map.addLayer(lrd_parcels_dataLayer);
map.addLayer(parcels_smd_dataLayer);
// map.addLayer(cadastral_smd_dataLayer);
map.addLayer(pvlmd_current_dataLayer);
map.addLayer(cro_parcels_dataLayer);
map.addLayer(garro_parcels_dataLayer);

map.addLayer(garro_search_result_searchLayer);
map.addLayer(cro_search_result_searchLayer);
map.addLayer(pvlmd_current_search_result_searchLayer);
map.addLayer(smd_smd_current_dataLayer);
// map.addLayer(smd_parcel_search_result_searchLayer);
// map.addLayer(smd_cadastral_search_result_searchLayer);
// map.addLayer(lrd_search_result_searchLayer);

map.addLayer(lc_searchLayer);


map
							.on(
									'click',
									function(evt) {
										// click_type= 'DrawClick'
										var viewResolution = map.getView()
												.getResolution();
										var viewProjection = map.getView()
												.getProjection();

										if (lrd_click_type === 'DrawClick') {

										}
										if (lrd_click_type === 'MapClick') {

											
											switch(division_layer) {
												case 'LRD':
												  

												var coordinate = evt.coordinate;
											console.log(coordinate);
											// var viewResolution = *//** @type
											// {number} *//*
											// (view.getResolution());
											// var viewResolution =
											// (view.getResolution());
											var url =  parcel_lrd_dataSource
													.getGetFeatureInfoUrl(
															evt.coordinate,
															viewResolution,
															viewProjection,
															{
																'INFO_FORMAT' : 'application/json',
																'propertyName' : 'reference_number,locality,plotted_by,date_plott,checked_by,type_of_plotting,modified_by,modified_date',
																'FEATURE_COUNT' : 50
															});
											// var url =
											// parcel_lrd_dataSource.getGetFeatureInfoUrl(evt.coordinate,
											// viewResolution,
											// projObj,{'INFO_FORMAT':
											// 'application/json','propertyName':
											// 'gid, id, cc_numb,
											// ref_no, reg_no, cert_no, a_name,
											// grantor, locality,
											// job_number, type_instr, date_ins,
											// considerat,
											// purpose, date_com, term,
											// mul_claim, remarks,
											// plotted_by, checked_by,
											// plott_date, area_acre',
											// 'FEATURE_COUNT': 50 });

											// evt.coordinate, viewResolution,

											// {'INFO_FORMAT':
											// 'application/json' });

											var thislayer = lrd_parcels_dataLayer
													.getSource().getParams().LAYERS;
											console.log(thislayer);
											if (url) {
												console.log(url);

												var parser = new ol.format.GeoJSON();
												var lookup = {};

												$
														.ajax({
															type : "GET",
															url : url,
															cache : false,
															beforeSend : function() {
																// $('#district').html('<img
																// src="img/loading.gif"
																// alt=""
																// width="24"
																// height="24">');
															},
															success : function(
																	serviceresponse) {

																console
																		.log('service response')
																console
																		.log(serviceresponse)
																// var json_p =
																// JSON.parse(serviceresponse);
																// console.log(json_p)

																console
																		.log('FEATURES')

																var feature = serviceresponse.features;
																console
																		.log(serviceresponse.features)
																// var props =
																// feature.properties;
																console
																		.log('feature count');

																 console.log(feature.length);
																// console.log(feature);

																var table = $('#lc_more_than_one_parcel_Table');
																table
																		.find(
																				"tbody tr")
																		.remove();

																if (feature.length > 1) {

																	var features = feature;
																	for (var i = 0, len = features.length; i < len; i++) {
																		var feat = features[i].properties;

																		var props = features[i].properties;

																		var iid = feat['id'] = features[i].id;
																		var words = iid
																				.split('.');
																		// var
																		// word0
																		// =
																		// words[0];
																		var parcel_uuid = words[1];
																		console
																				.log(parcel_uuid);

																		// feat['fid']
																		// =
																		// parcel_uuid;
																		// features_data_array
																		// .push(feat);

																		table
																				.append("<tr><td>"
																						+ props.reference_number
																						+ "</td><td>"
																						+ props.locality
																						+ "</td><td>"
																						+ props.type_of_plotting

																						+ "</td>"

																						+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" data-toggle="modal" data-target="#lrdparcelIndormation" '
																						+ 'data-parcel_uuid="'
																						+ parcel_uuid
																						+ '" '
																						+ 'data-reference_number="'
																						+ props.reference_number
																						+ '" '
																						+ 'data-locality="'
																						+ props.locality
																						+ '" '
																						+ 'data-plotted_by="'
																						+ props.plotted_by
																						+ '" '
																						+ 'data-date_plott="'
																						+ props.date_plott
																						+ '" '
																						+ 'data-checked_by="'
																						+ props.checked_by
																						+ '" '
																						
																						+ 'data-date_plott="'
																						+ props.modified_by
																						+ '" '
																						+ 'data-checked_by="'
																						+ props.mofified_date
																						+ '" '

																						+ 'data-type_of_plotting="'
																						+ props.type_of_plotting
																						+ '" id="deletede"><span class="fas fa-check"></span></button></p> </td>'

																						+ "</tr>");

																	}
																} else {
																
																	var table_bp = $('#coordinatelis_Table');
								                                 		table_bp.find("tbody tr").remove();

 																		$("#lrd_btn_save_wkt").prop("disabled", true);

																	var feature1 = serviceresponse.features[0];
																	if (feature1) {

																		var props = feature1.properties;
																		var spatial_id = feature1.id;
																		// var
																		// result_1
																		// =
																		// Ext.JSON.decode(conn.responseText,
																		// true);
																		// // #1
																		// console.log(props);
																		// console.log(spatial_id);
																		// console.log(props.job_no);

																		var words = spatial_id
																				.split('.');

																		// var
																		// word0
																		// =
																		// words[0];
																		var parcel_uuid = words[1];
																		console
																				.log(parcel_uuid);

																		$(
																				"#lrdparcelIndormation")
																				.modal();

																		$(
																				'#lrdparcelIndormation #lrd_ps_fid')
																				.val(
																						parcel_uuid);

																		$(
																				'#lrdparcelIndormation #lrd_ps_reference_number')
																				.val(
																						props.reference_number);
																		$(
																				'#lrdparcelIndormation #lrd_ps_locality')
																				.val(
																						props.locality);
																		$(
																				'#lrdparcelIndormation #lrd_ps_plotted_by')
																				.val(
																						props.plotted_by);
																		$(
																				'#lrdparcelIndormation #lrd_ps_date_plott')
																				.val(
																						props.date_plott);

																		$(
																				'#lrdparcelIndormation #lrd_ps_checked_by')
																				.val(
																						props.checked_by);
																		$(
																				'#lrdparcelIndormation #lrd_ps_type_of_plotting')
																				.val(
																						props.type_of_plotting);
																						
																		$(
																				'#lrdparcelIndormation #lrd_ps_modified_by')
																				.val(
																						props.modified_by);
																		$(
																				'#lrdparcelIndormation #lrd_ps_modified_date')
																				.val(
																						props.modified_date);

																		var table = $('#lrd_transaction_dataTable');
																		table
																				.find(
																						"tbody tr")
																				.remove();
																		$
																				.ajax({
																					type : "POST",
																					url : 'Maps',
																					data : {
																						request_type : 'load_lrd_transaction_details',
																						fid_fk : parcel_uuid
																					},
																					cache : false,
																					beforeSend : function() {
																						// $('#district').html('<img
																						// src="img/loading.gif"
																						// alt=""
																						// width="24"
																						// height="24">');
																					},
																					success : function(
																							serviceresponse) {

																						var json_p = JSON
																								.parse(serviceresponse);
																						console
																								.log(json_p)

																						/*
																						 * $(
																						 * '#lrd_txt_wkt_polygon')
																						 * .val(
																						 * json_p.wkt);
																						 */

																						$(
																								json_p.data)
																								.each(
																										function() {

																											table
																													.append("<tr><td>"
																															+ this.applicant_name
																															+ "</td><td>"
																															+ this.grantor_name
																															+ "</td><td>"
																															+ this.certicate_number
																															+ "</td><td>"
																															+ this.nature_of_instument
																															+ "</td>"

																															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addlrdtransaction" data-target-id="'
																															+ this.gid
																															+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																															+ "</tr>");
																										});

																					}
																				});

																		$
																				.ajax({
																					type : "POST",
																					url : "Maps",
																					data : {
																						request_type : 'search_lrd_parcel_wkt',
																						parcel_id : parcel_uuid,
																					},
																					cache : false,

																					success : function(
																							jobdetails) {

																						console
																								.log(jobdetails);
																						var json_p = JSON
																								.parse(jobdetails);

																						$(
																								'#lrd_txt_wkt_polygon')
																								.val(
																										json_p.data.polygon_wkt);

																						lrd_pvlmd_searchLayer
																								.setSource(new ol.source.Vector(
																										{
																											features : (new ol.format.WKT())
																													.readFeatures(json_p.data.polygon_wkt)
																										}));
																						lrd_pvlmd_searchLayer
																								.setSource(new ol.source.Vector(
																										{
																											features : (new ol.format.GeoJSON())
																													.readFeatures(json_p.parcels)
																										}));

																						view
																								.fit(lrd_pvlmd_searchLayer
																										.getSource()
																										.getExtent());
																						lrd_map
																								.getView()
																								.fit(
																										lrd_pvlmd_searchLayer
																												.getSource()
																												.getExtent(),
																										{
																											size : map
																													.getSize(),
																											maxZoom : 16
																										})

																					}
																				});

																		var table_encumbrance = $('#lrd_memorial_encumbrance_details_dataTable');
																		table_encumbrance
																				.find(
																						"tbody tr")
																				.remove();
																		$
																				.ajax({
																					type : "POST",
																					url : 'lrd_memorials_section_serv',
																					data : {
																						request_type : 'select_lrd_memorials_section_all_by_case_number',
																						case_number : props.reference_number
																					},
																					cache : false,
																					beforeSend : function() {
																						// $('#district').html('<img
																						// src="img/loading.gif"
																						// alt=""
																						// width="24"
																						// height="24">');
																					},
																					success : function(
																							serviceresponse) {
																						//console.log(props.reference_number);
																						//console.log('Assiamah');
																						console
																								.log(serviceresponse);

																						var json_p = JSON
																								.parse(serviceresponse);

																						$(
																								json_p.data)
																								.each(
																										function() {

																											table_encumbrance
																													.append("<tr><td>"
																															+ this.m_registered_no
																															+ "</td><td>"
																															+ this.m_memorials
																															+ "</td><td>"
																															+ this.m_date_of_instrument
																															+ "</td><td>"
																															+ this.m_date_of_registration
																															+ "</td>"

																															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#lrdpEncumbranceModal" data-target-id="'
																															+ this.case_number
																															+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																															+ "</tr>");
																										});

																					}
																				});

																		var table_docs = $('#lrd_scanned_documents_dataTable');
																		table_docs
																				.find(
																						"tbody tr")
																				.remove();
																		$
																				.ajax({
																					type : "POST",
																					url : 'LoadLRDJackets',
																					data : {
																						request_type : 'load_lrd_jacket_certificate',
																						certificate_number : props.reference_number
																					},
																					cache : false,
																					beforeSend : function() {
																						// $('#district').html('<img
																						// src="img/loading.gif"
																						// alt=""
																						// width="24"
																						// height="24">');
																					},
																					success : function(
																							serviceresponse) {

																						var json_p = JSON
																								.parse(serviceresponse);
																						console
																								.log(json_p)

																						$(
																								json_p)
																								.each(
																										function() {

																											/*
																											 * table_docs
																											 * .append("<tr><td>" +
																											 * this.document_name + "</td><td>" +
																											 * this.document_extention + "</td><td>" +
																											 * this.document_file + "</td>" + '<td><p data-placement="top" data-toggle="tooltip" title="Open"><a
																											 * href="teamServlet?document_path=' +
																											 * this.document_file + '"
																											 * target="_blank">link</a></p></td>' + "</tr>");
																											 */

																											table_docs
																													.append("<tr>"

																															+ '<td> <a class="link-post" href="'
																															+ this.document_file
																															+ '">'
																															+ this.document_name
																															+ '</a></td>'

																															+ "<td>"
																															+ this.document_extention
																															+ "</td>"

																															// +
																															// '<td><p
																															// data-placement="top"
																															// data-toggle="tooltip"
																															// title="Open"><a
																															// href="teamServlet?document_path='+
																															// this.document_file
																															// +'"
																															// target="_blank">link</a></p></td>'

																															+ "</tr>");

																										});

																					}
																				});

																		// console.log('SPATIAL
																		// ID'
																		// +
																		// parcel_uuid);

																	}
																}

															},
															failure : function(
																	errormsg) {
																// Ext.get(login.getEl()).unmask();
																console
																		.log(errormsg);
															}
														});

											}
											// }


												  break;
												case 'PVLMD':
												 

												var coordinate = evt.coordinate;
											console.log(coordinate);
											// var viewResolution = *//** @type
											// {number} *//*
											// (view.getResolution());
											// var viewResolution =
											// (view.getResolution());
											var url = pvlmd_current_dataSource
													.getGetFeatureInfoUrl(
															evt.coordinate,
															viewResolution,
															viewProjection,
															{
																'INFO_FORMAT' : 'application/json',
																'propertyName' : 'remarks,src_info,src_date,pvlmdid,sheet_number,file_number,property_number,reference_number,data_of_clearness,town_name,type_of_plotting,active_status,source_of_data,gid_unique_across,plotting_date,plotted_by,plotted_by_id,checked_by,checked_by_id,checked_by_date,locality,plan_number,plot_number,cro_reference,nt_number,modified_by,modified_date',
																	            //  remarks,src_info,src_date,pvlmdid,sheet_number,file_number,property_number,reference_number,data_of_clearness,town_name,type_of_plotting,active_status,source_of_data,gid_unique_across,plotting_date,plotted_by,plotted_by_id,checked_by,checked_by_id,checked_by_date,locality,plan_number,plot_number,cro_referencent_number	region_code
																'FEATURE_COUNT' : 50
															});

											var thislayer = pvlmd_current_dataLayer
													.getSource().getParams().LAYERS;
											console.log(thislayer);
											if (url) {
												console.log(url);

												var parser = new ol.format.GeoJSON();
												var lookup = {};

												$
														.ajax({
															type : "GET",
															url : url,
															cache : false,
															beforeSend : function() {
																// $('#district').html('<img
																// src="img/loading.gif"
																// alt=""
																// width="24"
																// height="24">');
															},
															success : function(
																	serviceresponse) {

																console
																		.log('service response')
																console
																		.log(serviceresponse)
																// var
																// json_p
																// =
																// JSON.parse(serviceresponse);

																// console.log(json_p)

																console
																		.log('FEATURES')

																var feature = serviceresponse.features;
																console
																		.log(serviceresponse.features)
																// var props =
																// feature.properties;

																$('#pvlmdparcelinformation #pvlmd_modified_by').val((serviceresponse.features[0].properties.plotted_by) == null ? (serviceresponse.features[0].properties.modified_by) : (serviceresponse.features[0].properties.plotted_by));

																$('#pvlmdparcelinformation #pvlmd_modified_date').val((serviceresponse.features[0].properties.plotting_date) == null ? (serviceresponse.features[0].properties.modified_date) : (serviceresponse.features[0].properties.plotting_date));

																$('#addpvlmdtransactionlong #pvlmd_tr_modified_by').val((serviceresponse.features[0].properties.plotted_by) == null ? (serviceresponse.features[0].properties.modified_by) : (serviceresponse.features[0].properties.plotted_by));

																$('#addpvlmdtransactionlong #pvlmd_tr_modified_date').val((serviceresponse.features[0].properties.plotting_date) == null ? (serviceresponse.features[0].properties.modified_date) : (serviceresponse.features[0].properties.plotting_date));

																console.log(serviceresponse.features[0].properties.plotted_by)

																console
																		.log('feature count');

																console
																		.log(feature.length);
																// console.log(feature);

																var table = $('#lc_more_than_one_parcel_Table');
																table
																		.find(
																				"tbody tr")
																		.remove();

																if (feature.length > 1) {

																	// var f1 =
																	// Ext.JSON.decode(feature,
																	// true);
																	// var obj =
																	// JSON
																	// .parse(feature);
																	// console
																	// .log(obj);

																	// var
																	// geoObject
																	// =
																	// JSON.parse(conn.responseText);
																	// var
																	// features
																	// = [];

																	// features_data_array
																	// = [];

																	var features = feature;
																	for (var i = 0, len = features.length; i < len; i++) {
																		var feat = features[i].properties;

																		var props = features[i].properties;

																		var iid = feat['id'] = features[i].id;
																		var words = iid
																				.split('.');
																		// var
																		// word0
																		// =
																		// words[0];
																		var parcel_uuid = words[1];
																		console
																				.log(parcel_uuid);

																		// feat['fid']
																		// =
																		// parcel_uuid;
																		// features_data_array
																		// .push(feat);

																		table
																				.append("<tr><td>"
																						+ props.reference_number
																						+ "</td><td>"
																						+ props.nt_number
																						+ "</td><td>"
																						+ props.locality

																						+ "</td>"

																						+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" data-toggle="modal" data-target="#pvlmdparcelinformation" '
																						+ 'data-parcel_uuid="'
																						+ parcel_uuid
																						+ '" '
																						+ 'data-nt_number="'
																						+ props.nt_number
																						+ '" '
																						+ 'data-cro_reference="'
																						+ props.cro_reference
																						+ '" '
																						+ 'data-property_number="'
																						+ props.property_number
																						+ '" '
																						+ 'data-reference_number="'
																						+ props.reference_number
																						+ '" '
																						+ 'data-file_number="'
																						+ props.file_number
																						+ '" '
																						+ 'data-locality="'
																						+ props.locality
																						+ '" '
																						+ 'data-plot_number="'
																						+ props.plot_number
																						+ '" '
																						+ 'data-modified_by="'
																						+ props.modified_by
																						+ '" '
																						+ 'data-modified_date="'
																						+ props.modified_date
																						+ '" '
																						+ 'data-remarks="'
																						+ props.remarks
																						+ '" id="deletede"><span class="fas fa-check"></span></button></p> </td>'

																						+ "</tr>");

																	}
																	// console
																	// .log(features_data_array);

																} else {
																	var feature1 = serviceresponse.features[0];
																	if (feature1) {

																		var props = feature1.properties;
																		var spatial_id = feature1.id;
																		// var
																		// result_1
																		// =
																		// Ext.JSON.decode(conn.responseText,
																		// true);
																		// // #1
																		// console.log(props);
																		// console.log(spatial_id);
																		// console.log(props.job_no);

																		var words = spatial_id
																				.split('.');

																		// var
																		// word0
																		// =
																		// words[0];
																		var parcel_uuid = words[1];
																		console
																				.log(parcel_uuid);

																		$(
																				"#pvlmdparcelinformation")
																				.modal();

																		$(
																				'#pvlmdparcelinformation #pvlmd_gid')
																				.val(
																						parcel_uuid);

																		$(
																				'#pvlmdparcelinformation #pvlmd_reference_number')
																				.val(
																						props.reference_number);

																		$(
																				'#pvlmdparcelinformation #pvlmd_nt_number')
																				.val(
																						props.nt_number);
																		$(
																				'#pvlmdparcelinformation #pvlmd_file_number')
																				.val(
																						props.file_number);

																		/*
																		 * $(
																		 * '#pvlmdparcelinformation
																		 * #pvlmd_cro_reference')
																		 * .val(
																		 * props.cro_reference); $(
																		 * '#pvlmdparcelinformation
																		 * #pvlmd_property_number')
																		 * .val(
																		 * props.property_number);
																		 */
																		$(
																				'#pvlmdparcelinformation #pvlmd_locality')
																				.val(
																						props.locality);

																		$(
																				'#pvlmdparcelinformation #pvlmd_sheet_number')
																				.val(
																						props.sheet_number);

																		$(
																				'#pvlmdparcelinformation #pvlmd_plot_number')
																				.val(
																						props.plot_number);
																		$(
																				'#pvlmdparcelinformation #pvlmd_remarks')
																				.val(
																						props.remarks);
																						
																							$(
																				'#pvlmdparcelinformation #modified_by')
																				.val(
																						props.modified_by);
																		$(
																				'#pvlmdparcelinformation #modified_date')
																				.val(
																						props.modified_date);

																		var table = $('#pvlmd_transaction_dataTable');
																		table
																				.find(
																						"tbody tr")
																				.remove();
																		$
																				.ajax({
																					type : "POST",
																					url : 'Maps',
																					data : {
																						request_type : 'pvlmd_transaction_select_by_reference_number_main',
																						reference_number : props.reference_number,
																						gid_fk : parcel_uuid
																					},
																					cache : false,
																					beforeSend : function() {
																						// $('#district').html('<img
																						// src="img/loading.gif"
																						// alt=""
																						// width="24"
																						// height="24">');
																					},
																					success : function(
																							serviceresponse) {

																						var json_p = JSON
																								.parse(serviceresponse);
																						console
																								.log(json_p)

																						$(
																								json_p.data)
																								.each(
																										function() {

																											table
																													.append("<tr><td>"
																															+ this.party2_defendant
																															+ "</td><td>"
																															+ this.party1_plaintiff
																															+ "</td><td>"
																															+ this.reference_number
																															+ "</td><td>"
																															+ this.instrument_type
																															+ "</td>"

																															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addpvlmdtransactionlong" data-target-id="'
																															+ this.t_id
																															+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																															+ "</tr>");
																										});

																					}
																				});

																		var table_docs = $('#lrd_scanned_documents_dataTable');
																		table_docs
																				.find(
																						"tbody tr")
																				.remove();
																		$
																				.ajax({
																					type : "POST",
																					url : 'LoadLRDJackets',
																					data : {
																						request_type : 'load_lrd_jacket_certificate',
																						certificate_number : props.reference_number
																					},
																					cache : false,
																					beforeSend : function() {
																						// $('#district').html('<img
																						// src="img/loading.gif"
																						// alt=""
																						// width="24"
																						// height="24">');
																					},
																					success : function(
																							serviceresponse) {

																						var json_p = JSON
																								.parse(serviceresponse);
																						console
																								.log(json_p)

																						$(
																								json_p)
																								.each(
																										function() {

																											/*
																											 * table_docs
																											 * .append("<tr><td>" +
																											 * this.document_name + "</td><td>" +
																											 * this.document_extention + "</td><td>" +
																											 * this.document_file + "</td>" + '<td><p data-placement="top" data-toggle="tooltip" title="Open"><a
																											 * href="teamServlet?document_path=' +
																											 * this.document_file + '"
																											 * target="_blank">link</a></p></td>' + "</tr>");
																											 */

																											table_docs
																													.append("<tr>"

																															+ '<td> <a class="link-post" href="'
																															+ this.document_file
																															+ '">'
																															+ this.document_name
																															+ '</a></td>'

																															+ "<td>"
																															+ this.document_extention
																															+ "</td>"

																															// +
																															// '<td><p
																															// data-placement="top"
																															// data-toggle="tooltip"
																															// title="Open"><a
																															// href="teamServlet?document_path='+
																															// this.document_file
																															// +'"
																															// target="_blank">link</a></p></td>'

																															+ "</tr>");

																										});

																					}
																				});

																		// console.log('SPATIAL
																		// ID'
																		// +
																		// parcel_uuid);

																	}

																							console.log('SPATIAL ID'+parcel_uuid);
																	$
																			.ajax({
																				type : "POST",
																				url : "Maps",
																				data : {
																					request_type : 'search_pvlmd_parcel_wkt',
																					parcel_id : parcel_uuid,
																				},
																				cache : false,

																				success : function(
																						jobdetails) {

																					console
																							.log(jobdetails);
																					var json_p = JSON
																							.parse(jobdetails);

																					$(
																							'#pvlmd_bl_wkt_polygon')
																							.val(
																									json_p.data.polygon_wkt);

																				}
																			});
																}

															},
															failure : function(
																	errormsg) {
																// Ext.get(login.getEl()).unmask();
																console
																		.log(errormsg);
															}
														});

											}
											// }
												  break;
												default:
													var coordinate = evt.coordinate;
													console.log(coordinate);
													// var viewResolution = *//** @type
													// {number} *//*
													// (view.getResolution());
													// var viewResolution =
													// (view.getResolution());
													var url = smd_smd_current_dataSource
															.getGetFeatureInfoUrl(
																	evt.coordinate,
																	viewResolution,
																	viewProjection,
																	{
																		'INFO_FORMAT' : 'application/json',
																		'propertyName' : 'reference_number,locality,plotted_by,date_plott,checked_by,type_of_plotting,acreage,status,parcel_identifier,modified_by,modified_date',
																		'FEATURE_COUNT' : 50
																	});
		
													var thislayer = smd_smd_current_dataLayer
															.getSource().getParams().LAYERS;
													console.log(thislayer);
													if (url) {
														console.log(url);
		
														var parser = new ol.format.GeoJSON();
														var lookup = {};
		
														$
																.ajax({
																	type : "GET",
																	url : url,
																	cache : false,
																	beforeSend : function() {
																		// $('#district').html('<img
																		// src="img/loading.gif"
																		// alt=""
																		// width="24"
																		// height="24">');
																	},
																	success : function(
																			serviceresponse) {
		
																		console
																				.log('service response')
																		console
																				.log(serviceresponse)
																		// var
																		// json_p
																		// =
																		// JSON.parse(serviceresponse);
		
																		// console.log(json_p)
		
																		console
																				.log('FEATURES')
		
																		var feature = serviceresponse.features;
																		console
																				.log(serviceresponse.features)
																		// var props =
																		// feature.properties;
																		console
																				.log('feature count');
		
																		console
																				.log(feature.length);
																		// console.log(feature);
		
																		if (feature.length > 1) {
		
																			// var f1 =
																			// Ext.JSON.decode(feature,
																			// true);
																			// var obj =
																			// JSON
																			// .parse(feature);
																			// console
																			// .log(obj);
		
																			// var
																			// geoObject
																			// =
																			// JSON.parse(conn.responseText);
																			// var
																			// features
																			// = [];
		
																			// features_data_array
																			// = [];
		
																			var table = $('#lc_more_than_one_parcel_Table');
																			table
																					.find(
																							"tbody tr")
																					.remove();
		
																			var features = feature;
																			for (var i = 0, len = features.length; i < len; i++) {
																				var feat = features[i].properties;
		
																				var props = features[i].properties;
		
																				var iid = feat['id'] = features[i].id;
																				var words = iid
																						.split('.');
																				// var
																				// word0
																				// =
																				// words[0];
																				var parcel_uuid = words[1];
																				console
																						.log(parcel_uuid);
		
																				// feat['fid']
																				// =
																				// parcel_uuid;
																				// features_data_array
																				// .push(feat);
		
																				table
																						.append("<tr><td>"
																								+ props.reference_number
																								+ "</td><td>"
																								+ props.locality
																								+ "</td><td>"
																								+ props.plotted_by
		
																								+ "</td>"
		
																								+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" data-toggle="modal" data-target="#smdparcelinformation" '
																								+ 'data-parcel_uuid="'
																								+ parcel_uuid
																								+ '" '
																								+ 'data-reference_number="'
																								+ props.reference_number
																								+ '" '
																								+ 'data-locality="'
																								+ props.locality
																								+ '" '
																								+ 'data-plotted_by="'
																								+ props.plotted_by
																								+ '" '
																								+ 'data-date_plott="'
																								+ props.date_plott
																								+ '" '
																								+ 'data-checked_by="'
																								+ props.checked_by
																								+ '" '
																								+ 'data-type_of_plotting="'
																								+ props.type_of_plotting
																								+ '" '
																									+ 'data-modified_by="'
																								+ props.modified_by
																								+ '" '
																								+ 'data-modified_date="'
																								+ props.modified_date
																								+ '" '
																								+ 'data-acreage="'
																								+ props.acreage
																								+ '" id="deletede"><span class="fas fa-check"></span></button></p> </td>'
		
																								+ "</tr>");
		
																			}
																			// console
																			// .log(features_data_array);
		
																		} else {
																			var feature1 = serviceresponse.features[0];
																			if (feature1) {
		
																				var props = feature1.properties;
																				var spatial_id = feature1.id;
																				// var
																				// result_1
																				// =
																				// Ext.JSON.decode(conn.responseText,
																				// true);
																				// // #1
																				// console.log(props);
																				// console.log(spatial_id);
																				// console.log(props.job_no);
		
																				var words = spatial_id
																						.split('.');
		
																				// var
																				// word0
																				// =
																				// words[0];
		
																				var parcel_uuid = words[1];
																				console
																						.log(parcel_uuid);
		
																				$(
																						"#smdparcelinformation")
																						.modal();
		
																				$(
																						'#smdparcelinformation #smd_gid_p')
																						.val(
																								parcel_uuid);
		
																				$(
																						'#smdparcelinformation #smd_ref_no')
																						.val(
																								props.reference_number);
		
																				$(
																						'#smdparcelinformation #smd_locality')
																						.val(
																								props.locality);
		
																				$(
																						'#smdparcelinformation #smd_plotted_by')
																						.val(
																								props.plotted_by);
		
																				$(
																						'#smdparcelinformation #smd_date_plott')
																						.val(
																								props.date_plott);
		
																				$(
																						'#smdparcelinformation #type_of_plotting')
																						.val(
																								props.type_of_plotting);
		
																				$('#smdparcelinformation #acreage')
																						.val(props.acreage);
		
		
		
																				$('#smdparcelinformation #modified_by').val(props.modified_by);
		
																				$('#smdparcelinformation #modified_date').val(props.modified_date);
																				var table = $('#smd_transaction_dataTable');
																				table
																						.find(
																								"tbody tr")
																						.remove();
																				$
																						.ajax({
																							type : "POST",
																							url : 'Maps',
																							data : {
																								request_type : 'select_lc_spatial_objects_smd_transaction_by_fk',
																								fid_fk : parcel_uuid
																							},
																							cache : false,
																							beforeSend : function() {
																								// $('#district').html('<img
																								// src="img/loading.gif"
																								// alt=""
																								// width="24"
																								// height="24">');
																							},
																							success : function(
																									serviceresponse) {
		
																								var json_p = JSON
																										.parse(serviceresponse);
																								console
																										.log(json_p)
		
																								/*
																								 * $(
																								 * '#lrd_txt_wkt_polygon')
																								 * .val(
																								 * json_p.wkt);
																								 */
		
																								$(
																										json_p.data)
																										.each(
																												function() {
		
																													table
																															.append("<tr><td>"
																																	+ this.applicant_name
																																	+ "</td><td>"
																																	+ this.grantor_name
																																	+ "</td><td>"
																																	+ this.mul_claim
																																	+ "</td><td>"
																																	+ this.remarks
																																	+ "</td>"
		
																																	+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addsmdtransaction" data-target-id="'
																																	+ this.gid
																																	+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'
		
																																	+ "</tr>");
																												});
		
																							}
																						});
		
																				$
																						.ajax({
																							type : "POST",
																							url : "Maps",
																							data : {
																								request_type : 'search_smd_parcel_wkt',
																								parcel_id : parcel_uuid,
																							},
																							cache : false,
		
																							success : function(
																									jobdetails) {
		
																								console
																										.log(jobdetails);
																								var json_p = JSON
																										.parse(jobdetails);
		
																								$(
																										'#smd_bl_wkt_polygon')
																										.val(
																												json_p.data.polygon_wkt);
		
																								smd_lc_searchLayer
																										.setSource(new ol.source.Vector(
																												{
																													features : (new ol.format.WKT())
																															.readFeatures(json_p.data.polygon_wkt)
																												}));
																								smd_lc_searchLayer
																										.setSource(new ol.source.Vector(
																												{
																													features : (new ol.format.GeoJSON())
																															.readFeatures(json_p.parcels)
																												}));
		
																								view
																										.fit(smd_lc_searchLayer
																												.getSource()
																												.getExtent());
																								smd_map
																										.getView()
																										.fit(
																												smd_lc_searchLayer
																														.getSource()
																														.getExtent(),
																												{
																													size : map
																															.getSize(),
																													maxZoom : 16
																												})
		
																							}
																						});
		
																				var table_docs = $('#smd_scanned_documents_dataTable');
																				table_docs
																						.find(
																								"tbody tr")
																						.remove();
																				$
																						.ajax({
																							type : "POST",
																							url : 'LoadLRDJackets',
																							data : {
																								request_type : 'load_smd_jacket_certificate',
																								certificate_number : props.reference_number
																							},
																							cache : false,
																							beforeSend : function() {
																								// $('#district').html('<img
																								// src="img/loading.gif"
																								// alt=""
																								// width="24"
																								// height="24">');
																							},
																							success : function(
																									serviceresponse) {
		
																								var json_p = JSON
																										.parse(serviceresponse);
																								console
																										.log(json_p)
		
																								$(
																										json_p)
																										.each(
																												function() {
		
																													/*
																													 * table_docs
																													 * .append("<tr><td>" +
																													 * this.document_name + "</td><td>" +
																													 * this.document_extention + "</td><td>" +
																													 * this.document_file + "</td>" + '<td><p data-placement="top" data-toggle="tooltip" title="Open"><a
																													 * href="teamServlet?document_path=' +
																													 * this.document_file + '"
																													 * target="_blank">link</a></p></td>' + "</tr>");
																													 */
		
																													table_docs
																															.append("<tr>"
		
																																	+ '<td> <a class="link-post" href="'
																																	+ this.document_file
																																	+ '">'
																																	+ this.document_name
																																	+ '</a></td>'
		
																																	+ "<td>"
																																	+ this.document_extention
																																	+ "</td>"
		
																																	// +
																																	// '<td><p
																																	// data-placement="top"
																																	// data-toggle="tooltip"
																																	// title="Open"><a
																																	// href="teamServlet?document_path='+
																																	// this.document_file
																																	// +'"
																																	// target="_blank">link</a></p></td>'
		
																																	+ "</tr>");
		
																												});
		
																							}
																						});
		
																				// console.log('SPATIAL
																				// ID'
																				// +
																				// parcel_uuid);
		
																			}
																		}
		
																	},
																	failure : function(
																			errormsg) {
																		// Ext.get(login.getEl()).unmask();
																		console
																				.log(errormsg);
																	}
																});
		
													}
													// }
											  }

											

										}
									});

$("#lc_btn_show_location").click(function(event) {


			console.log('you');
			markers.getSource().clear()
			var x_coordinate_mak = $('#lc_x_coordinate').val();
			var y_coordinate_mak = $('#lc_y_coordinate').val();

			var marker = new ol.Feature({
				geometry : new ol.geom.Point([ x_coordinate_mak,
						y_coordinate_mak ])
			// dont worry about coordinate type 0,0
			// will be in west coast of
			// africa
			});
			// source.addFeature(marker);

			// pvlmd_searchLayer.setSource(new
			// ol.source.Vector({features: (new
			// ol.format.WKT()).readFeatures(polygon_tttt)}));
			// var marker = new ol.Feature(new
			// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
			// x_coordinate_mak])));
			markers.getSource().addFeature(marker);

			// pvlmd_searchLayer.setSource(new
			// ol.source.Vector({features: (new
			// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

			// view.fit(markers.getSource().getExtent());
			// var extent =
			// pvlmd_searchLayer.getSource().getExtent();
			map.getView().fit(markers.getSource().getExtent(), {
				size : map.getSize(),
				maxZoom : 16
			})
		});
$("#lc_btn_visualise_search").click(function(event) {

					//console.log($('#lc_bl_wkt_polygon').val())
					var wktplygonsearch = $('#lc_bl_wkt_polygon').val() == undefined ? $('#lc_fr_bl_wkt_polygon').val() : $('#lc_bl_wkt_polygon').val();
					var request = new XMLHttpRequest();
					/*
					 * var params = '{"vr_polygon":"'+ wktplygonsearch
					 * +'","request_type":"select_consolidated_internal_search_report_geom"}';
					 * 
					 * request.onreadystatechange = function() { if
					 * (this.readyState == 4 && this.status == 200) {
					 * console.log(this.responseText); // var json
					 * =this.responseText; //
					 * insert_parceldata(this.responseText); } };
					 * 
					 * request.open('POST', 'Case_Management_Serv', true);
					 * //request.setRequestHeader('api-key', 'your-api-key');
					 * request.setRequestHeader("Content-type",
					 * "application/json"); request.send(params);
					 */

					console.log(wktplygonsearch)

					$
							.ajax({
								type : "POST",
								url : "Case_Management_Serv",
								data : {
									request_type : 'select_consolidated_internal_search_report_geom',
									vr_polygon : wktplygonsearch
								},
								cache : false,
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success : function(jobdetails) {

									var json_p = JSON.parse(jobdetails);
									console.log(json_p)
									/*
									 * $(json_p.milestones).each(function () {
									 * 
									 * 
									 * });
									 */

									if (json_p !== undefined || json_p !== null) {
										// var featureCount
										// =
										// pvlmd_searchLayer.getSource().getFeatures().length;
										// console.log(featureCount);

										if (garro_search_result_searchLayer
												.getSource() != null) {
											garro_search_result_searchLayer
													.getSource().clear();
										}
										if (cro_search_result_searchLayer
												.getSource() != null) {
											cro_search_result_searchLayer
													.getSource().clear();
										}
										if (pvlmd_current_search_result_searchLayer
												.getSource() != null) {
											pvlmd_current_search_result_searchLayer
													.getSource().clear();
										}
										if (smd_parcel_search_result_searchLayer
												.getSource() != null) {
											smd_parcel_search_result_searchLayer
													.getSource().clear();
										}
										if (smd_cadastral_search_result_searchLayer
												.getSource() != null) {
											smd_cadastral_search_result_searchLayer
													.getSource().clear();
										}
										if (lrd_search_result_searchLayer
												.getSource() != null) {
											lrd_search_result_searchLayer
													.getSource().clear();
										}

										if (json_p.garro === undefined
												|| json_p.garro.features === null) {

										} else {
											garro_search_result_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.garro)
															}));
											/*
											 * var features =
											 * pvlmd_searchLayer.getSource().getFeatures();
											 * for (var i in features) { var
											 * feature = features[i]; //var
											 * featureName =
											 * feature.get('valuation_number');
											 * feature.setStyle(styleFunction(feature));
											 * var fls_number =
											 * feature.get('cc_numb');
											 * feature.setStyle(styleFunction(fls_number)); }
											 */

										}
										if (json_p.cro === undefined
												|| json_p.cro.features === null) {
										} else {
											cro_search_result_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.cro)
															}));
										}
										if (json_p.pvlmdcurrent === undefined
												|| json_p.pvlmdcurrent.features === null) {
										} else {
											pvlmd_current_search_result_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.pvlmdcurrent)
															}));
										}

										if (json_p.smd_parcels === undefined
												|| json_p.smd_parcels.features === null) {
										} else {
											smd_parcel_search_result_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.smd_parcels)
															}));
										}
										if (json_p.smd_cadastral === undefined
												|| json_p.smd_cadastral.features === null) {
										} else {
											smd_cadastral_search_result_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.smd_cadastral)
															}));
										}
										if (json_p.lrd === undefined
												|| json_p.lrd.features === null) {
										} else {
											lrd_search_result_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.lrd)
															}));
										}
										view.fit(lc_searchLayer.getSource()
												.getExtent());
										map.getView().fit(
												lc_searchLayer.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})

									} else {
										/*
										 * Ext.Msg.show({ title:'Error!', msg:
										 * "Error in loading data", icon:
										 * Ext.Msg.ERROR, buttons: Ext.Msg.OK })
										 */
									}

								}
							});
				});

	
	$("#lc_btn_visualise_coordinate").click(function(event) {

			var table = $('#coordinatelis_Table').tableToJSON();
			// s console.log(table);
			// alert(JSON.stringify(table));
			var list_of_application_new = JSON.stringify(table);
			console.log(list_of_application_new);

			var json_p = JSON.parse(list_of_application_new);

			console.log(json_p);
			polygon = '';

			point_coordinate_list = '';

			var jsonArr = [];

			var counter = 0;
			var first_x_coordinate = '';
			var first_y_coordinate = '';
			$(json_p).each(function() {

				/*
				 * if (counter=0){ first_x_coordinate=this.x_coordinate ;
				 * first_y_coordinate=this.y_coordinate; }
				 */

				item = {}
				item["coordinate_name"] = this.name;
				item["x_coordinate"] = this.x_coordinate;
				item["y_coordinate"] = this.y_coordinate;

				jsonArr.push(item);
				polygon += this.y_coordinate + " " + this.x_coordinate + ", ";

				counter++;

			});

			polygon_real = "POLYGON((" + polygon + "))";
			var first_coordinate = '';
			// first_coordinate = ", "+
			// first_y_coordinate + " "+
			// first_x_coordinate + "))";
			first_coordinate = ", " + json_p[0].y_coordinate + " "
					+ json_p[0].x_coordinate + "))";

			console.log('first_coordinate');
			console.log(first_coordinate);
			// /grid.store.getAt(0).data.name
			var polygon_tttt = polygon_real.replace(', ))', first_coordinate);

			var json_to_be_formatted = list_of_application_new
			// json_to_be_formatted =
			// json_to_be_formatted.replace('[[',
			// '[{');
			// json_to_be_formatted =
			// json_to_be_formatted.replace(']]',
			// '}]');
			// json_to_be_formatted =
			// json_to_be_formatted.replace('],[',
			// '},{');
			console.log(json_to_be_formatted);

			point_coordinate_list = json_to_be_formatted;

			console.log(polygon_tttt);

			// wktplygonsearch

			$('#lc_bl_wkt_polygon').val(polygon_tttt);
			$('#lc_fr_bl_wkt_polygon').val(polygon_tttt);
			// var wktplygonsearch =
			// $('#lc_fr_bl_wkt_polygon').val();
			// Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].setValue(polygon_tttt);

			/*
			 * var format = new ol.format.WKT(); var feature =
			 * format.readFeature( 'POLYGON((1187149.88749177
			 * 321970.352529228,1187252.44828482
			 * 322000.51758416,1187278.49030434
			 * 321905.465328425,1187172.80418022
			 * 321877.68741487,1187149.88749177 321970.352529228))');
			 * feature.getGeometry().transform(projObj,'EPSG:4326');
			 * 
			 * var vectorwkt = new ol.layer.Vector({ title: 'WKT Layer', source:
			 * new ol.source.Vector({ features: [feature] }) });
			 */

			lc_searchLayer.setSource(new ol.source.Vector({
				features : (new ol.format.WKT()).readFeatures(polygon_tttt)
			}));
			view.fit(lc_searchLayer.getSource().getExtent());

			map.getView().fit(lc_searchLayer.getSource().getExtent(), {
				size : map.getSize(),
				maxZoom : 16
			})
		});

		$("#lc_btn_visualise_coordinate").click(function(event) {

			var table = $('#coordinatelis_Table').tableToJSON();
			// s console.log(table);
			// alert(JSON.stringify(table));
			var list_of_application_new = JSON.stringify(table);
			console.log(list_of_application_new);

			var json_p = JSON.parse(list_of_application_new);

			console.log(json_p);
			polygon = '';

			point_coordinate_list = '';

			var jsonArr = [];

			var counter = 0;
			var first_x_coordinate = '';
			var first_y_coordinate = '';
			$(json_p).each(function() {

				/*
				 * if (counter=0){ first_x_coordinate=this.x_coordinate ;
				 * first_y_coordinate=this.y_coordinate; }
				 */

				item = {}
				item["coordinate_name"] = this.name;
				item["x_coordinate"] = this.x_coordinate;
				item["y_coordinate"] = this.y_coordinate;

				jsonArr.push(item);
				polygon += this.y_coordinate + " " + this.x_coordinate + ", ";

				counter++;

			});

			polygon_real = "POLYGON((" + polygon + "))";
			var first_coordinate = '';
			// first_coordinate = ", "+
			// first_y_coordinate + " "+
			// first_x_coordinate + "))";
			first_coordinate = ", " + json_p[0].y_coordinate + " "
					+ json_p[0].x_coordinate + "))";

			console.log('first_coordinate');
			console.log(first_coordinate);
			// /grid.store.getAt(0).data.name
			var polygon_tttt = polygon_real.replace(', ))', first_coordinate);

			var json_to_be_formatted = list_of_application_new
			// json_to_be_formatted =
			// json_to_be_formatted.replace('[[',
			// '[{');
			// json_to_be_formatted =
			// json_to_be_formatted.replace(']]',
			// '}]');
			// json_to_be_formatted =
			// json_to_be_formatted.replace('],[',
			// '},{');
			console.log(json_to_be_formatted);

			point_coordinate_list = json_to_be_formatted;

			console.log(polygon_tttt);

			// wktplygonsearch

			$('#lc_bl_wkt_polygon').val(polygon_tttt);
			$('#lc_fr_bl_wkt_polygon').val(polygon_tttt);
			

			lc_searchLayer.setSource(new ol.source.Vector({
				features : (new ol.format.WKT()).readFeatures(polygon_tttt)
			}));
			view.fit(lc_searchLayer.getSource().getExtent());

			map.getView().fit(lc_searchLayer.getSource().getExtent(), {
				size : map.getSize(),
				maxZoom : 16
			})
		});



		$("#lc_btn_visualise_wkt, #lc_btn_visualise_wkt_").click(function(event) {
					// wktplygonsearch
					// v
					// console.log(wktplygonsearch)

					// var wktplygonsearch =
					// $('#lc_bl_wkt_polygon').val();
					var wktplygonsearch = document
							.getElementById("lc_bl_wkt_polygon").value;
					console.log(wktplygonsearch)

					lc_searchLayer.setSource(new ol.source.Vector({
						features : (new ol.format.WKT())
								.readFeatures(wktplygonsearch)
					}));
					// view.fit(pvlmd_searchLayer.getSource().getExtent());
					console.log(wktplygonsearch)

					var extent = lc_searchLayer.getSource().getExtent();
					map.getView().fit(extent, {
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


				$("#lc_btnprintmap").click(function(event) {

					console.log("click_type");

					var wktplygonsearch = $('#lc_bl_wkt_polygon').val();

					// wktplygonsearch
					// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();

					var canvas = document.getElementById("lc-map")
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
					 * Ext.ComponentQuery.query('combo[name=region]')[0].getValue();
					 * var vr_assemby_code=
					 * Ext.ComponentQuery.query('combo[name=assembly_code]')[0].getValue();
					 * var vr_division=
					 * Ext.ComponentQuery.query('combo[name=division]')[0].getValue();
					 * var vr_block=
					 * Ext.ComponentQuery.query('combo[name=block]')[0].getValue();
					 * 
					 */
					doc.setFontSize(16)
					doc.text(80, 35, 'INTERNAL SEARCH REPORT')

					// doc.setFontSize(20)
					// doc.text(35, 50, 'Assembly: ' +
					// vr_assemby_code + '
					// Division: ' + vr_division + ' Block:
					// ' + vr_block)

					/*
					 * doc.setFont("courier"); doc.setFontType("normal");
					 * doc.text(20, 30, 'This is courier normal.');
					 * 
					 * doc.setFont("times"); doc.setFontType("italic");
					 * doc.text(20, 40, 'This is times italic.');
					 * 
					 * doc.setFont("helvetica"); doc.setFontType("bold");
					 * doc.text(20, 50, 'This is helvetica bold.'); ;
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
					// 144, 42); //shows
					// correct image

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

					doc.setDrawColor(144, 238, 144); // draw
					// red
					// lines
					doc.setLineWidth(1.5);
					doc.line(15, 240, 50, 240);
					doc.text(60, 240, 'Parcel Undergoing Registration')

					doc.setFontSize(10)
					doc.setFont("courier");
					doc.setFontType("bolditalic");

					/*
					 * var splitTitle =
					 * doc.splitTextToSize(wkt_polgon_for_search, 180);
					 * doc.text(20, 210, splitTitle);
					 * 
					 * var splitTitle =
					 * doc.splitTextToSize(wkt_polgon_for_search, 180);
					 * doc.text(20, 220, splitTitle);
					 * 
					 * var splitTitle =
					 * doc.splitTextToSize(wkt_polgon_for_search, 180);
					 * doc.text(20, 230, splitTitle);
					 * 
					 * 
					 * var splitTitle =
					 * doc.splitTextToSize(wkt_polgon_for_search, 180);
					 * doc.text(20, 240, splitTitle);
					 * 
					 * 
					 * 
					 * 
					 * 
					 */

					var splitTitle = doc.splitTextToSize(wktplygonsearch, 180);
					doc.text(20, 250, splitTitle);

					// doc.save('map.pdf');

					$
							.ajax({
								type : "POST",
								url : "Case_Management_Serv",
								data : {
									request_type : 'select_consolidated_internal_search_report_attribute',
									vr_polygon : wktplygonsearch
								},
								cache : false,
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success : function(jobdetails) {

									var json_p = JSON.parse(jobdetails);
									console.log(json_p)
									// $(json_p.milestones).each(function
									// () {

									// });

									doc.addPage('a4', 'l');

									if (json_p !== undefined || json_p !== null) {
										// var featureCount
										// =
										// pvlmd_searchLayer.getSource().getFeatures().length;
										// console.log(featureCount);

										// if
										// (lc_searchLayer.getSource()
										// !=
										// null )
										// {lc_searchLayer.getSource().clear();}

										if (json_p.garro === undefined
												|| json_p.garro === null) {

											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'Existing GARRO Data',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc.autoTable(columns, data_rows, {
												margin : {
													top : 10
												},
												theme : 'grid'
											});

											// doc.setFontSize(12)
											// doc.text(20,
											// 30,
											// 'Existing
											// GARRO Data')
											// doc.text(20,
											// 40,
											// 'No Recorded
											// Transaction')
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.garro)}));
											// doc.addPage('a4',
											// 'l');

											// doc.addPage('a4',
											// 'l');

											transaction_data = json_p.garro;

											var columns = [ {
												title : "Property No",
												dataKey : "prop_no"
											}, {
												title : "Instrument Date",
												dataKey : "instrument_date"
											}, {
												title : "Instrument Type",
												dataKey : "instrument_type"
											}, {
												title : "Grantor",
												dataKey : "party1_plaintiff"
											}, {
												title : "Grantee",
												dataKey : "party2_defendant"
											}, {
												title : "Term",
												dataKey : "term"
											}, {
												title : "Commencement Date",
												dataKey : "commencement_date"
											}

											];

											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');
											/*
											 * doc .autoTable( columns, rows, {
											 * 
											 * margin : { top : 35 },
											 * addPageContent : function( data) {
											 * doc.text( "", 40, 40); } });
											 */

											doc.text(20, 30,
													'Existing GARRO Data');

											doc
													.autoTable(
															columns,
															rows,
															{
																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	prop_no : {
																		columnWidth : 40
																	},
																	party1_plaintiff : {
																		columnWidth : 50
																	},
																	party2_defendant : {
																		columnWidth : 50
																	}
																}
															});

										}
										if (json_p.cro === undefined
												|| json_p.cro === null) {

											/*
											 * doc.addPage('a4', 'l');
											 * doc.setFontSize(12) doc.text(20,
											 * 30, 'Existing CRO Data')
											 * doc.text(20, 40, 'No Recorded
											 * Transaction')
											 */
											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'Existing CRO Data',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc
													.autoTable(
															columns,
															data_rows,
															{
																margin : {
																	top : 10
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10
															});

											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.cro)}));
											// doc.addPage('a4',
											// 'l');

											transaction_data = json_p.cro;

											var columns = [ {
												title : "General Number",
												dataKey : "general_no"
											}, {
												title : "Instrument Date",
												dataKey : "instrument_date"
											}, {
												title : "Instrument Type",
												dataKey : "instrument_type"
											}, {
												title : "Grantor",
												dataKey : "party1_plaintiff"
											}, {
												title : "Grantee",
												dataKey : "party2_defendant"
											}, {
												title : "Term",
												dataKey : "term"
											}, {
												title : "Commencement Date",
												dataKey : "commencement_date"
											}

											];
											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');
											doc.text("Existing CRO Data", 15,
													doc.autoTableEndPosY() + 8);

											doc
													.autoTable(
															columns,
															rows,
															{

																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	party1_plaintiff : {
																		columnWidth : 50
																	},
																	party2_defendant : {
																		columnWidth : 50
																	}
																}

															});
										}

										if (json_p.pvlmdcurrent === undefined
												|| json_p.pvlmdcurrent === null) {

											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'PVLMD Current Layer',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc
													.autoTable(
															columns,
															data_rows,
															{
																margin : {
																	top : 10
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10
															});
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.cro)}));
											// doc.addPage('a4',
											// 'l');
											// doc.setFontSize(12)
											// doc.text(20,
											// 30,
											// 'PVLMD
											// Current
											// Layer')

											transaction_data = json_p.pvlmdcurrent;

											var columns = [ {
												title : "Reference No",
												dataKey : "reference_number_p"
											}, {
												title : "Instrument Date",
												dataKey : "instrument_date"
											}, {
												title : "Instrument Type",
												dataKey : "instrument_type"
											}, {
												title : "Grantor",
												dataKey : "party1_plaintiff"
											}, {
												title : "Grantee",
												dataKey : "party2_defendant"
											}, {
												title : "Term",
												dataKey : "term"
											}, {
												title : "Commencement Date",
												dataKey : "commencement_date"
											}

											];
											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');

											doc.text("PVLMD Current Layer", 15,
													doc.autoTableEndPosY() + 8);
											doc
													.autoTable(
															columns,
															rows,
															{

																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	party1_plaintiff : {
																		columnWidth : 50
																	},
																	party2_defendant : {
																		columnWidth : 50
																	}
																}

															});
										}

										if (json_p.smd_parcels === undefined
												|| json_p.smd_parcels === null) {

											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'SMD Parcel Layer',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc
													.autoTable(
															columns,
															data_rows,
															{
																margin : {
																	top : 10
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10
															});
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.smd)}));
											// doc.addPage('a4',
											// 'l');
											// doc.setFontSize(12)
											doc
													.text(20, 30,
															'SMD Parcel Layer')
											transaction_data = json_p.smd_parcels;

											var columns = [
											// {title:
											// "Instrument
											// Date",
											// dataKey:
											// "date_instr"},
											{
												title : "CC No",
												dataKey : "ccno"
											}, {
												title : "Applicant Name",
												dataKey : "a_name"
											},
											// {title:
											// "Grantor",
											// dataKey:
											// "grantor"},
											// {title:
											// "Term",
											// dataKey:
											// "term"},
											// {title:
											// "Commencement
											// Date",
											// dataKey:
											// "date_com"}

											];

											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');

											doc.text("SMD Parcel Layer", 15,
													doc.autoTableEndPosY() + 8);

											doc
													.autoTable(
															columns,
															rows,
															{

																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	ccno : {
																		columnWidth : 50
																	},
																	a_name : {
																		columnWidth : 50
																	}
																}

															});
										}

										if (json_p.smd_cadastral === undefined
												|| json_p.smd_cadastral === null) {

											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'SMD Cadastral Layer',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc
													.autoTable(
															columns,
															data_rows,
															{
																margin : {
																	top : 10
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10
															});
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.smd)}));
											// doc.addPage('a4',
											// 'l');
											// doc.setFontSize(12)
											// doc.text(20,
											// 30,
											// 'SMD
											// Cadastral
											// Layer')
											transaction_data = json_p.smd_cadastral;

											var columns = [
											// {title:
											// "Instrument
											// Date",
											// dataKey:
											// "date_instr"},
											{
												title : "CC No",
												dataKey : "ccno"
											}, {
												title : "Applicant Name",
												dataKey : "a_name"
											},
											// {title:
											// "Grantor",
											// dataKey:
											// "grantor"},
											// {title:
											// "Term",
											// dataKey:
											// "term"},
											// {title:
											// "Commencement
											// Date",
											// dataKey:
											// "date_com"}

											];

											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');

											doc.text("SMD Cadastral Layer", 15,
													doc.autoTableEndPosY() + 8);
											doc
													.autoTable(
															columns,
															rows,
															{

																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	ccno : {
																		columnWidth : 50
																	},
																	a_name : {
																		columnWidth : 50
																	}
																}

															});
										}

										if (json_p.lrd === undefined
												|| json_p.lrd === null) {

											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'LRD Layer',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc
													.autoTable(
															columns,
															data_rows,
															{
																margin : {
																	top : 10
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10
															});
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.lrd)}));
											// doc.addPage('a4',
											// 'l');
											// doc.setFontSize(12)
											// doc.text(20,
											// 30, 'LRD
											// Layer')
											transaction_data = json_p.lrd;

											var columns = [ {
												title : "Reference No.",
												dataKey : "reference_number"
											}, {
												title : "Instrument Date",
												dataKey : "date_of_instument"
											}, {
												title : "Instrument Type",
												dataKey : "type_instrument"
											}, {
												title : "Garntor",
												dataKey : "grantor_name"
											}, {
												title : "Applncant Name",
												dataKey : "applicant_name"
											}, {
												title : "Term",
												dataKey : "term"
											}, {
												title : "Commencement",
												dataKey : "date_commencement"
											}

											];

											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');
											doc.text('LRD Layer', 15, doc
													.autoTableEndPosY() + 8);
											doc
													.autoTable(
															columns,
															rows,
															{

																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	grantor_name : {
																		columnWidth : 50
																	},
																	applicant_name : {
																		columnWidth : 50
																	}
																}

															});
										}

										if (json_p.undergoing_registration === undefined
												|| json_p.undergoing_registration === null) {

											var data_rows = [ {
												main_description : 'No Recorded Transaction'
											} ];
											var columns = [ {
												title : 'Undergoing Registration Layer',
												dataKey : 'main_description'
											} ]

											// doc.autoTable(columns,
											// data_rows,
											// {margin:
											// {top: 50}});

											doc
													.autoTable(
															columns,
															data_rows,
															{
																margin : {
																	top : 10
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10
															});
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.lrd)}));
											// doc.addPage('a4',
											// 'l');
											// doc.setFontSize(12)
											// doc.text(20,
											// 30, 'LRD
											// Layer')
											transaction_data = json_p.undergoing_registration;

											var columns = [ {
												title : "Job No.",
												dataKey : "job_number"
											}, {
												title : "case_number",
												dataKey : "Case Number"
											}, {
												title : "GLPIN",
												dataKey : "glpin"
											}, {
												title : "Regional Number",
												dataKey : "regional_number"
											}, {
												title : "locality",
												dataKey : "locality"
											}, {
												title : "date_approved",
												dataKey : "date_approved"
											}, {
												title : "land_size",
												dataKey : "land_size"
											}

											];

											console.log(transaction_data);

											var rows = transaction_data;
											// Only pt
											// supported
											// (not mm or
											// in)
											// var doc = new
											// jsPDF('p',
											// 'pt');
											doc
													.text(
															'Undergoing Registration Layer',
															15,
															doc
																	.autoTableEndPosY() + 8);
											doc
													.autoTable(
															columns,
															rows,
															{

																margin : {
																	top : 10
																},
																bodyStyles : {
																	valign : 'middle'
																},
																styles : {
																	overflow : 'linebreak',
																	columnWidth : 'wrap'
																},
																theme : 'grid',
																startY : doc
																		.autoTableEndPosY() + 10,
																columnStyles : {
																	grantor_name : {
																		columnWidth : 50
																	},
																	applicant_name : {
																		columnWidth : 50
																	}
																}

															});
										}
										// view.fit(pvlmd_searchLayer.getSource().getExtent());
										// map.getView().fit(pvlmd_searchLayer.getSource().getExtent(),
										// {size:map.getSize(),
										// maxZoom:16})
										doc.save('map.pdf');
									} else {
										/*
										 * Ext.Msg.show({ title:'Error!', msg:
										 * "Error in loading data", icon:
										 * Ext.Msg.ERROR, buttons: Ext.Msg.OK })
										 */
									}
								}
							});

				});

$('#lc_scale_value').change(
		function() {
			// alert($(this).val());
			$('#lc_scale_value_e').val($(this).val());
			var view = lc_map.getView();
			view.setResolution(ol.proj.getPointResolution(view.getProjection(),
					getResolutionFromScale($(this).val()), view.getCenter()));
			click_map_zoom_value = false;

		});
// 

var click_map_zoom_value = true;
// document.getElementById('lc_btn_scale_zoom').addEventListener(
// 		'click',
// 		function() {
			$("#lc_btn_scale_zoom").click(function(event) {
			var scale_value = $('#lc_scale_value_e').val();
			var view = lc_map.getView();
			view.setResolution(ol.proj.getPointResolution(view.getProjection(),
					getResolutionFromScale(scale_value), view.getCenter()));
			click_map_zoom_value = false;
		});

// document
// 		.getElementById('lc_lockmapscale')
// 		.addEventListener(
// 				'click',
// 				function() {

		$("#lc_lockmapscale").click(function(event) {
					/*
					 * map.getInteractions().forEach(function(interaction) { if
					 * (interaction instanceof ol.interaction.MouseWheelZoom) {
					 * interaction.setActive(false); } }, this);
					 */
					// console.log('Namekkjksd');
					if (document.getElementById("lc_lockmapscale").checked) {

						// ol.interaction.DoubleClickZoom
						// ol.interaction.MouseWheelZoom

						var MouseWheelZoomClickInteraction;
						// find DoubleClickZoom interaction
						lc_map
								.getInteractions()
								.getArray()
								.forEach(
										function(interaction) {
											if (interaction instanceof ol.interaction.MouseWheelZoom) {
												MouseWheelZoomClickInteraction = interaction;
											}
										});
						// remove from map
						lc_map
								.removeInteraction(MouseWheelZoomClickInteraction);

						var dblClickInteraction;
						// find DoubleClickZoom interaction
						lc_map
								.getInteractions()
								.getArray()
								.forEach(
										function(interaction) {
											if (interaction instanceof ol.interaction.DoubleClickZoom) {
												dblClickInteraction = interaction;
											}
										});
						// remove from map
						lc_map.removeInteraction(dblClickInteraction);

					} else {

						dblClickInteraction = new ol.interaction.DoubleClickZoom(
								{
									delta : 0
								});
						lc_map.addInteraction(dblClickInteraction);

						MouseWheelZoomClickInteraction = new ol.interaction.MouseWheelZoom(
								{
									delta : 0
								});
						lc_map.addInteraction(MouseWheelZoomClickInteraction);

					}

				});

// document
// 		.getElementById('lc_btn_load_for_scanned_maps_by_point')
// 		.addEventListener(
// 				'click',
// 				function() {
	$("#lc_btn_load_for_scanned_maps_by_point").click(function(event) {
					console.log('kkkkk');

					var x_coordinate_mak = $('#lc_x_coordinate').val();
					var y_coordinate_mak = $('#lc_y_coordinate').val();

					polygon = x_coordinate_mak + " " + y_coordinate_mak;

					polygon_real = "POINT(" + polygon + ")";

					$
							.ajax({
								type : "POST",
								url : "Maps",
								data : {
									request_type : 'search_for_lrd_scan_map_for_a_point',
									wkt_polgon : polygon_real
								},
								cache : false,
								success : function(jobdetails) {

									var json_p = JSON.parse(jobdetails);
									console.log('how come')
									console.log(result)

									var options = $("#geoserverscannedimages_list");
									options.empty();

									$(json_p.data)
											.each(
													function() {

														$(
																'#geoserverscannedimages_list')
																.append(
																		'<option value="'

																				+ this.file_name
																				+ ':'
																				+ this.extent

																				+ '">'
																				+ this.file_name
																				+ '</option>');
													});

								}
							});
				});

				
// document
// 		.getElementById('lc_btn_search_for_scanned_maps')
// 		.addEventListener(
// 				'click',
// 				function(e) {
					$("#lc_btn_search_for_scanned_maps").click(function(event) {
					console.log('kkkkk');

					// var wkt_polygon =
					// $('#lrd_txt_wkt_polygon').val();

					// var wkt_polygon_k =
					// $.trim($("#lc_bl_wkt_polygon").val());
					var wkt_polygon = document
							.getElementById("lc_bl_wkt_polygon").value;
					console.log(wkt_polygon);

					// var job_number =
					// $("#job_number").val();
					$
							.ajax({
								type : "POST",
								url : "Maps",
								data : {
									request_type : 'search_for_lrd_scan_map_for_a_polygon',
									wkt_polygon : wkt_polygon
								},
								cache : false,
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success : function(jobdetails) {

									var json_p = JSON.parse(jobdetails);
									// console.log('how come')
									// console.log(result)
									/*
									 * $('#geoserverscannedimages_list')
									 * .append( '<option value="' +
									 * 'csau_geospatial:108_PART_1_modified:[80935.449735544404,1209.0295731349593,1711780.3060929566,2358523.1247835089]' +
									 * '">' +
									 * 'csau_geospatial:108_PART_1_modified' + '</option>');
									 */

									var options = $("#geoserverscannedimages_list");
									options.empty();

									$(json_p.data)
											.each(
													function() {

														$(
																'#geoserverscannedimages_list')
																.append(
																		'<option value="'

																				+ this.file_name
																				+ ':'
																				+ this.extent

																				+ '">'
																				+ this.file_name
																				+ '</option>');
													});

								}
							});
				});

// document.getElementById('lc_btn_load_for_scanned_maps').addEventListener(
// 		'click',
// 		function(e) {

			$("#lc_btn_load_for_scanned_maps").click(function(event) {

			// console.log('kkkkk');

			// var wkt_polygon =
			// $('#lrd_txt_wkt_polygon').val();

			var geoserverscannedimage = $
					.trim($("#geoserverscannedimages_list").val());
			/*
			 * var wkt_polygon = document
			 * .getElementById("lrd_txt_wkt_polygon").value;
			 */
			// console.log('Scan Map');
			console.log(geoserverscannedimage);

			value_image_scan = geoserverscannedimage;
			only_layer = value_image_scan.split(":", 3);
			console.log(only_layer);
			value_image_scan1 = only_layer[1];
			// console.log(value_image_scan1);
			// all_parameters = {'LAYERS':
			// new_value_image_scan};
			// yyy= "104_modified_CR";
			layer_name = 'csau_geospatial' + ':' + value_image_scan1,
					all_parameters = {
						'LAYERS' : layer_name
					};
			var image_source = new ol.source.ImageWMS({
				url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
				// params:
				// {'LAYERS':'csau_geospatial:104_modified_CR'},
				// 'csau_geospatial:104_modified_CR'
				// params: {'LAYERS':
				// `${new_value_image_scan}`},
				// params: {'LAYERS':
				// new_value_image_scan},
				params : all_parameters,
				serverType : 'geoserver',

			})

			StaticImage.setSource(image_source);

			var new_extent = null;
			extent_nnn = only_layer[2];
			new_extent = extent_nnn;
			console.log('new_extent');
			console.log(new_extent);
			// var extent = ol.extent.createEmpty();
			// StaticImage.setExtent(extent:new_extent);
			// var myExtent = [xmin,ymin,xmax,ymax];
			/*
			 * extent = [ 1173152.85826898, 342671.514293023, 1179683.69808146,
			 * 347057.607642237 ];
			 */

			map.getView().fit(new_extent, map.getSize());

			// map.getView().fit(new_extent,
			// map.getSize());

			/*
			 * lrd_map.getView().fit(new_extent, { size : lrd_map.getSize(),
			 * maxZoom : 16 })
			 */

		});

function getResolutionFromScale(scale) {
	var units = map.getView().getProjection().getUnits();
	var dpi = 25.4 / 0.28;
	var mpu = ol.proj.METERS_PER_UNIT[units];
	var resolution = scale / (mpu * 39.37 * dpi);
	return resolution;
}

// let map_; // Declare map in global scope to ensure it can be accessed in both event handlers
// let map__;
// let map___;

// $("#visualise_and_confirm").on('shown.bs.modal', function () {
//     document.getElementById("lc-map_").style.display = "block"; // Show map container
    
//     setTimeout(() => {
//         initializeMap(); // Initialize the map after the modal is visible
//         if (map_) {
//             map_.updateSize(); // Ensure map resizes correctly
//         }
//     }, 100); // Delay to account for modal transition
// });

// $("#view_parcel_and_transaction").on('shown.bs.modal', function () {
//     document.getElementById("lc-map__").style.display = "block"; // Show map container
    
//     setTimeout(() => {
//         initializeMap_(); // Initialize the map after the modal is visible
//         if (map__) {
//             map__.updateSize(); // Ensure map resizes correctly
//         }
//     }, 100); // Delay to account for modal transition
// });

// $("#check_for_polygon").on('shown.bs.modal', function () {
//     document.getElementById("lc-map___").style.display = "block"; // Show map container
    
//     setTimeout(() => {
//         initializeMap__(); // Initialize the map after the modal is visible
//         if (map___) {
//             map___.updateSize(); // Ensure map resizes correctly
//         }
//     }, 100); // Delay to account for modal transition
// });

// function initializeMap() {
//     if (!map_) { // Initialize map only if it hasn't been created yet
//         map_ = new ol.Map({
//             target: 'lc-map_',
//             controls: ol.control.defaults().extend([
//                 new ol.control.LayerSwitcher(),
//                 new ol.control.OverviewMap(),
//                 new ol.control.ZoomSlider(),
//                 new ol.control.Attribution(),
//                 new ol.control.MousePosition(),
//                 new ol.control.ZoomToExtent(),
//                 new ol.control.FullScreen()
//             ]),
//             renderer: 'canvas',
//             layers: [
//                 new ol.layer.Tile({
//                     title: 'Open Street',
//                     source: new ol.source.OSM()
//                 })
//             ],
//             view: view_e // Assuming `view_e` is defined elsewhere
//         });

//         // Add layers to the map
//         map_.addLayer(googleLayerHybrid);
//         map_.addLayer(StaticImage);
//         map_.addLayer(lrd_certificate_region_dataLayer);
//         map_.addLayer(registration_district_dataLayer);
//         map_.addLayer(grid_lrd_dataLayer);
//         map_.addLayer(lrd_parcels_dataLayer);
//         map_.addLayer(parcels_smd_dataLayer);
//         map_.addLayer(pvlmd_current_dataLayer);
//         map_.addLayer(cro_parcels_dataLayer);
//         map_.addLayer(garro_parcels_dataLayer);
//         map_.addLayer(garro_search_result_searchLayer);
//         map_.addLayer(cro_search_result_searchLayer);
//         map_.addLayer(pvlmd_current_search_result_searchLayer);
//         map_.addLayer(smd_smd_current_dataLayer);
//         map_.addLayer(lc_searchLayer);
//     }
// }

// function initializeMap_() {
//     if (!map__) { // Initialize map only if it hasn't been created yet
//         map__ = new ol.Map({
//             target: 'lc-map__',
//             controls: ol.control.defaults().extend([
//                 new ol.control.LayerSwitcher(),
//                 new ol.control.OverviewMap(),
//                 new ol.control.ZoomSlider(),
//                 new ol.control.Attribution(),
//                 new ol.control.MousePosition(),
//                 new ol.control.ZoomToExtent(),
//                 new ol.control.FullScreen()
//             ]),
//             renderer: 'canvas',
//             layers: [
//                 new ol.layer.Tile({
//                     title: 'Open Street',
//                     source: new ol.source.OSM()
//                 })
//             ],
//             view: view_e // Assuming `view_e` is defined elsewhere
//         });

//         // Add layers to the map
//         map__.addLayer(googleLayerHybrid);
//         map__.addLayer(StaticImage);
//         map__.addLayer(lrd_certificate_region_dataLayer);
//         map__.addLayer(registration_district_dataLayer);
//         map__.addLayer(grid_lrd_dataLayer);
//         map__.addLayer(lrd_parcels_dataLayer);
//         map__.addLayer(parcels_smd_dataLayer);
//         map__.addLayer(pvlmd_current_dataLayer);
//         map__.addLayer(cro_parcels_dataLayer);
//         map__.addLayer(garro_parcels_dataLayer);
//         map__.addLayer(garro_search_result_searchLayer);
//         map__.addLayer(cro_search_result_searchLayer);
//         map__.addLayer(pvlmd_current_search_result_searchLayer);
//         map__.addLayer(smd_smd_current_dataLayer);
//         map__.addLayer(lc_searchLayer);
//     }
// }

// function initializeMap__() {
//     if (!map___) { // Initialize map only if it hasn't been created yet
//         map___ = new ol.Map({
//             target: 'lc-map___',
//             controls: ol.control.defaults().extend([
//                 new ol.control.LayerSwitcher(),
//                 new ol.control.OverviewMap(),
//                 new ol.control.ZoomSlider(),
//                 new ol.control.Attribution(),
//                 new ol.control.MousePosition(),
//                 new ol.control.ZoomToExtent(),
//                 new ol.control.FullScreen()
//             ]),
//             renderer: 'canvas',
//             layers: [
//                 new ol.layer.Tile({
//                     title: 'Open Street',
//                     source: new ol.source.OSM()
//                 })
//             ],
//             view: view_e // Assuming `view_e` is defined elsewhere
//         });

//         // Add layers to the map
//         map___.addLayer(googleLayerHybrid);
//         map___.addLayer(StaticImage);
//         map___.addLayer(lrd_certificate_region_dataLayer);
//         map___.addLayer(registration_district_dataLayer);
//         map___.addLayer(grid_lrd_dataLayer);
//         map___.addLayer(lrd_parcels_dataLayer);
//         map___.addLayer(parcels_smd_dataLayer);
//         map___.addLayer(pvlmd_current_dataLayer);
//         map___.addLayer(cro_parcels_dataLayer);
//         map___.addLayer(garro_parcels_dataLayer);
//         map___.addLayer(garro_search_result_searchLayer);
//         map___.addLayer(cro_search_result_searchLayer);
//         map___.addLayer(pvlmd_current_search_result_searchLayer);
//         map___.addLayer(smd_smd_current_dataLayer);
//         map___.addLayer(lc_searchLayer);
//     }
// }

// $("#visualise_and_confirm").on("hidden.bs.modal", function () {
//     if (map_) {
//         map_.setTarget(null); // Detach the map from its DOM element
//         //map_.dispose(); // Dispose of map resources
//         map_ = null; // Clear the map instance
//     }
//     document.getElementById("lc-map_").style.display = "none"; // Hide map container
// });

// $("#view_parcel_and_transaction").on("hidden.bs.modal", function () {
//     if (map__) {
//         map__.setTarget(null); // Detach the map from its DOM element
//         //map_.dispose(); // Dispose of map resources
//         map__ = null; // Clear the map instance
//     }
//     document.getElementById("lc-map__").style.display = "none"; // Hide map container
// });

// $("#check_for_polygon").on("hidden.bs.modal", function () {
//     if (map___) {
//         map___.setTarget(null); // Detach the map from its DOM element
//         //map_.dispose(); // Dispose of map resources
//         map___ = null; // Clear the map instance
//     }
//     document.getElementById("lc-map___").style.display = "none"; // Hide map container
// });


// });

let maps = {}; // Object to store multiple maps dynamically

function initializeMap(targetId) {
    if (!maps[targetId]) { // Check if map already exists
        maps[targetId] = new ol.Map({
            target: targetId,
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
            layers: [
                new ol.layer.Tile({
                    title: 'Open Street',
                    source: new ol.source.OSM()
                })
            ],
            view: view_e // Assuming `view_e` is defined elsewhere
        });

        // Add layers dynamically
        [
            googleLayerHybrid, StaticImage, lrd_certificate_region_dataLayer,
            registration_district_dataLayer, grid_lrd_dataLayer, lrd_parcels_dataLayer,
            parcels_smd_dataLayer, pvlmd_current_dataLayer, cro_parcels_dataLayer,
            garro_parcels_dataLayer, garro_search_result_searchLayer, cro_search_result_searchLayer,
            pvlmd_current_search_result_searchLayer, smd_smd_current_dataLayer, lc_searchLayer
        ].forEach(layer => maps[targetId].addLayer(layer));
    }
}

function destroyMap(targetId) {
    if (maps[targetId]) {
        maps[targetId].setTarget(null); // Detach the map
        maps[targetId] = null; // Clear the map instance
    }
}

$(".map-modal").on("shown.bs.modal", function () {
    let targetId = $(this).find(".map-container").attr("id");
    document.getElementById(targetId).style.display = "block";

    setTimeout(() => {
        initializeMap(targetId);
        if (maps[targetId]) {
            maps[targetId].updateSize();
        }
    }, 100);
});

$(".map-modal").on("hidden.bs.modal", function () {
    let targetId = $(this).find(".map-container").attr("id");
    destroyMap(targetId);
    document.getElementById(targetId).style.display = "none";
});
