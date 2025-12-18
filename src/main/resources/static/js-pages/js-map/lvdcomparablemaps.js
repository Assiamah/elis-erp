/*$(document)
		.ready(
<<<<<<< Updated upstream
				function() {
 */

var datatable = $("#map_comparablesearchdataTable").DataTable({
// responsive: true,

// stateSave : true,

});

var lvd_point_coordinate_list;

var lvd_click_type = 'MapClick';

var lvd_parcel_lvd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:sp_parcels_lvd',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var lvd_lvd_parcels_dataLayer = new ol.layer.Tile({
	title : 'LVD Comparables',
	source : lvd_parcel_lvd_dataSource

})

var lvd_grid_lvd_dataSource = new ol.source.TileWMS({
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

var lvd_grid_lvd_dataLayer = new ol.layer.Tile({
	title : 'Grid',
	visible : false,
	source : lvd_grid_lvd_dataSource

})

// 104_modified_CR
// DIST_03_01_A_modified

var lvd_StaticImage = new ol.layer.Image({
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

lvd_pvlmd_searchLayer = new ol.layer.Vector({
	title : 'Search Layer',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'red',
			width : 3
		})
	})
});

function flickrStyle(feature) {
	var style = new ol.style.Style({
		image : new ol.style.Circle({
			radius : 6,
			stroke : new ol.style.Stroke({
				color : 'white',
				width : 2
			}),
			fill : new ol.style.Fill({
				color : 'red'
			})
		}),
		text : new ol.style.Text({
			font : 'bold 11px "Open Sans", "Arial Unicode MS", "sans-serif"',
			placement : 'point',
			fill : new ol.style.Fill({
				color : '#fff'
			}),
			stroke : new ol.style.Stroke({
				color : '#000',
				width : 2
			}),
		}),

	});
	return [ style ];
}

var style = new ol.style.Style({
	image : new ol.style.Circle({
		radius : 6,
		stroke : new ol.style.Stroke({
			color : 'white',
			width : 2
		}),
		fill : new ol.style.Fill({
			color : 'red'
		})
	}),
	text : new ol.style.Text({
		font : 'bold 11px "Open Sans", "Arial Unicode MS", "sans-serif"',
		placement : 'point',
		fill : new ol.style.Fill({
			color : 'blue'
		}),
		stroke : new ol.style.Stroke({
			color : 'white',
			width : 2
		}),
	}),

});

var lvd_markers = new ol.layer.Vector({
	// title: 'Markers',
	source : new ol.source.Vector(),
	style : function(feature) {

		console.log('Check you get the property', feature.get('label'));
		style.getText().setText(feature.get('label'));
		return style;
	}
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

var searchwktpolgonlayer = new ol.layer.Vector({
	title : 'Search Polygon',
	source : undefined,
	style : new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : 'black',
			width : 3
		})
	})
});

var lvd_googleLayerHybrid = new ol.layer.Tile({
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

var lvd_new_de = new ol.layer.Tile({
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

var lvd_projObj = new ol.proj.Projection({
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

var lvd_view_e = new ol.View({
	// center: ol.proj.fromLonLat([4.8, 47.75]),
	// center: ol.proj.transform([1187433.58822084,
	// 327091.107070208],
	// 'EPSG:4326','EPSG:3857'),
	projection : lvd_projObj,
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

//var drawingSource = new ol.source.Vector({
//	useSpatialIndex : false,
//	source : new ol.source.Vector({
//		features : features
//	}),
//	style : new ol.style.Style({
//		fill : new ol.style.Fill({
//			color : 'rgba(255, 255, 255, 0.2)'
//		}),
//		stroke : new ol.style.Stroke({
//			color : '#ffcc33',
//			width : 2
//		}),
//		image : new ol.style.Circle({
//			radius : 7,
//			fill : new ol.style.Fill({
//				color : '#ffcc33'
//			})
//		})
//	})
//});

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

// Add drawing layer
//var drawingLayer = new ol.layer.Vector({
//	title : 'my_vectorlayer',
//	name : 'my_vectorlayer',
//	source : drawingSource
//});

var lvd_map = new ol.Map({
	target : 'lvd-map',
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
	view : lvd_view_e
});

lvd_map.addLayer(lvd_markers);
lvd_map.addLayer(lvd_googleLayerHybrid);
lvd_map.addLayer(lvd_StaticImage);

lvd_map.addLayer(lvd_grid_lvd_dataLayer);

// lvd_map.addLayer(beacon_lvd_dataLayer);

lvd_map.addLayer(lvd_lvd_parcels_dataLayer);
lvd_map.addLayer(lvd_pvlmd_searchLayer);
lvd_map.addLayer(vector_layer);

var sketch; // the current drawing
var draw;
var listener;

// make interactions global so they can later be removed
var select_interaction,

modify_interaction;

// get the interaction type
// var interaction_type = 'None';
var geom_type = 'None';
var data_type = 'GeoJSON';
var draw_interaction = 'draw';

// build up modify interaction
// needs a select and a modify interaction working together
function addModifyInteraction() {
	// remove draw interaction
	lvd_map.removeInteraction(draw_interaction);
	// create select interaction
	select_interaction = new ol.interaction.Select({
		// make sure only the desired layer can be
		// selected
		layers : function(vector_layer) {
			return vector_layer.get('name') === 'my_vectorlayer';
		}
	});

	lvd_map.addInteraction(select_interaction);

	// grab the features from the select interaction to use
	// in the modify
	// interaction
	var selected_features = select_interaction.getFeatures();
	// when a feature is selected...
	selected_features.on('add', function(event) {
		// grab the feature
		var feature = event.element;
		// ...listen for changes and save
		// them
		feature.on('change', saveData);
		// listen to pressing of delete key,
		// then delete selected features

		selected_features.on("keyup", function(event) { // delete
			// key
			Ext.Msg.show({
				title : 'Error!',
				msg : 'Key down',
				buttons : Ext.Msg.OK
			});
			if (e.getKey() == e.DELETE) {
				// alert("Test");
				if (event.keyCode == 46) {
					// remove
					// all
					// selected
					// features
					// from
					// select_interaction
					// and
					// my_vectorlayer
					selected_features.forEach(function(selected_feature) {
						var selected_feature_id = selected_feature.getId();
						// remove
						// from
						// select_interaction
						selected_features.remove(selected_feature);
						// features
						// aus
						// vectorlayer
						// entfernen
						var vectorlayer_features = vector_layer.getSource()
								.getFeatures();
						vectorlayer_features.forEach(function(source_feature) {
							var source_feature_id = source_feature.getId();
							if (source_feature_id === selected_feature_id) {
								// remove
								// from
								// my_vectorlayer
								vector_layer.getSource().removeFeature(
										source_feature);
								// save
								// the
								// changed
								// data
								saveData();
							}
						});
					});
					// remove
					// listener
					// $(document).off('keyup');
				}
			}
		});
		/*
		 * $(document).on('keyup', function(event) {
		 * 
		 * });
		 */
	});
	// create the modify interaction
	modify_interaction = new ol.interaction.Modify({
		features : selected_features,
		// delete vertices by pressing the SHIFT key
		deleteCondition : function(event) {
			return ol.events.condition.shiftKeyOnly(event)
					&& ol.events.condition.singleClick(event);
		}
	});
	// add it to the map
	lvd_map.addInteraction(modify_interaction);
}

// creates a draw interaction
function addDrawInteraction() {

	// map.removeInteraction(draw);

	lvd_map.removeInteraction(select_interaction);
	lvd_map.removeInteraction(modify_interaction);

	var value = geom_type;
	if (value !== 'None') {
		// Drawing interaction
		// remove other interactions

		// create the interaction
		draw_interaction = new ol.interaction.Draw({
			source : vector_layer.getSource(),
			type : /** @type {ol.geom.GeometryType} */
			geom_type
		});
		// add it to the map
		lvd_map.addInteraction(draw_interaction);

		// when a new feature has been drawn...
		draw_interaction.on('drawend', function(event) {
			// create a unique id
			// it is later needed to delete features
			var id = uid();
			// var id = generateSerial();
			console.log(id);
			// give the feature this id
			event.feature.setId(id);
			// save the changed data
			saveData();
		});
	} else {
		/*
		 * draw_interaction = new ol.interaction.Draw({ source :
		 * vector_layer.getSource(), type :
		 *//** @type {ol.geom.GeometryType} */
		/*
		 * geom_type }); // add it to the map
		 * lvd_map.addInteraction(draw_interaction);
		 */
	}

}

// add the draw interaction when the page is first shown
addDrawInteraction();

// shows data in textarea
// replace this function by what you need
function saveData() {
	// get the format the user has chosen
	var final_data;
	var data_type = 'GeoJSON',
	// define a format the data shall be converted to
	format = new ol.format[data_type](),
	// this will be the data in the chosen format
	data;
	try {
		// convert the data of the vector_layer into the
		// chosen format
		data = format.writeFeatures(vector_layer.getSource().getFeatures());
	} catch (e) {
		// at time of creation there is an error in the GPX
		// format (18.7.2014)
		// $('#data').val(e.name + ": " + e.message);
		Ext.Msg.show({
			title : 'Error!',
			msg : 'error in converting data',
			buttons : Ext.Msg.OK
		});
		return;
	}
	if (data_type === 'GeoJSON') {
		// format is JSON
		final_data = JSON.stringify(data, null, 4);
		console.log('text data 2' + final_data);

		var stringData = JSON.parse(final_data);
		console.log(stringData);
		// console.log(dataFile.data[0].degree);
		var obj = JSON.parse(stringData);

		console.log(obj.features);
		console.log(stringData.features);

		if (JSON.stringify(obj.features) !== '[]') {
			// console.log('who are you');
			var geometry_data = obj.features[0].geometry;

			if (geometry_data !== undefined || geometry_data !== null) {

				var input_json = obj.features[0].geometry;
				// console.log('input_json');
				// console.log(input_json);
				var wkt_str = 'POLYGON((';
				input_json.coordinates.forEach(function(p, i) {
					// console.log('p')
					// console.log(p)

					var i;
					for (i = 0; i < p.length; i++) {

						wkt_str = wkt_str + p[i][0] + ' ' + p[i][1] + ', ';
					}

				})

				var wkt_wkt_str = wkt_str + '))';
				wkt_wkt_str = wkt_wkt_str.replace(", ))", "))");

				console.log('Json result wkt_wkt_str - ' + wkt_wkt_str);
				// Ext.ComponentQuery.query('textareafield[name=wktplygonsearch]')[0].setValue(wkt_wkt_str)
				var wktplygonsearch = $('#lvd_txt_wkt_polygon')
						.val(wkt_wkt_str);
			}

		} else {

		}
		/*
		 * if (obj.features !== '[]' ) { }
		 */

		// $('#data').val(JSON.stringify(data, null, 4));
	} else {
		// format is XML (GPX or KML)
		var serializer = new XMLSerializer();
		final_data = serializer.serializeToString(data);
		// $('#data').val(serializer.serializeToString(data));
	}
}

/*
 * // clear map when user clicks on 'Delete all features'
 * $("#delete").click(function() { clearMap(); });
 */
// clears the map and the output of the data
function clearMap() {
	vector_layer.getSource().clear();
	if (select_interaction) {
		select_interaction.getFeatures().clear();
	}
	// $('#data').val('');
}

// creates unique id's

function uid() {
	var id = 0;
	return function() {
		if (arguments[0] === 0) {
			id = 0;
		}
		return id++;
	}
}

function generateSerial() {
	var id = 0;
	// return function() {

	'use strict';

	var chars = '1234567890',

	serialLength = 10,

	randomSerial = "",

	i,

	randomNumber;

	for (i = 0; i < serialLength; i = i + 1) {

		randomNumber = Math.floor(Math.random() * chars.length);

		randomSerial += chars.substring(randomNumber, randomNumber + 1);

	}

	// document.getElementById('serial').innerHTML =
	// randomSerial;
	return randomSerial;

	// }

}

$('#interaction_type').on('click', function(e) {

	// var new_value =
	// Ext.getCmp("interaction_type").items.get(0).getGroupValue();
	var new_value = $('#interaction_type').val();

	if (this.value === 'draw') {
		addDrawInteraction();
	} else {
		addModifyInteraction();
	}

});

$('#line').on('click', function(e) {
	// Ext.ComponentQuery.query('combo[name=geom_type]')[0].setValue('Polygon');
	// var wkt_polgon_for_search=
	// Ext.ComponentQuery.query('textareafield[name=wktplygonsearch]')[0].getValue();

	// console.log('Lines');
	lvd_map.removeInteraction(draw_interaction);
	geom_type = 'LineString';
	addDrawInteraction();
});

$('#stopdraw').on('click', function(e) {

	// console.log('stopdraw');
	lvd_map.removeInteraction(draw_interaction);
	geom_type = 'None';
	addDrawInteraction();
});

$('#polygon').on('click', function(e) {

	// console.log('Polygon');
	// console.log('Polygon');
	lvd_map.removeInteraction(draw_interaction);
	geom_type = 'Polygon';

	addDrawInteraction();

});

this.lvd_map
		.on(
				'click',
				function(evt) {
					// click_type= 'DrawClick'
					var viewResolution = map.getView().getResolution();
					var viewProjection = map.getView().getProjection();

					if (lvd_click_type === 'DrawClick') {

					}
					if (lvd_click_type === 'MapClick') {

						var coordinate = evt.coordinate;
						console.log(coordinate);
						// var viewResolution = *//** @type
						// {number} *//*
						// (view.getResolution());
						// var viewResolution =
						// (view.getResolution());
						var url = lvd_parcel_lvd_dataSource
								.getGetFeatureInfoUrl(
										evt.coordinate,
										viewResolution,
										viewProjection,
										{
											'INFO_FORMAT' : 'application/json',
											'propertyName' : 'job_no,transaction_date,accreage_size_of_land,confirmed_acre_size,unexpired_term,source_data,value_of_property,prominent_landmarks,type_of_house,locality,type_of_use,property_owner',
											'FEATURE_COUNT' : 50
										});
						// var url =
						// parcel_lvd_dataSource.getGetFeatureInfoUrl(evt.coordinate,
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

						var thislayer = lvd_lvd_parcels_dataLayer.getSource()
								.getParams().LAYERS;
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
										success : function(serviceresponse) {

											console.log('service response')
											console.log(serviceresponse)
											// var json_p =
											// JSON.parse(serviceresponse);
											// console.log(json_p)

											console.log('FEATURES')

											var feature = serviceresponse.features;
											console
													.log(serviceresponse.features)
											// var props =
											// feature.properties;
											console.log('feature count');

											
											var feature1 = serviceresponse.features[0];
											if (feature1) {

												var props = feature1.properties;
												var spatial_id = feature1.id;
												// var
												// result_1
												// =
												// Ext.JSON.decode(conn.responseText,
												// true); //
												// #1
												// console.log(props);
												// console.log(spatial_id);
												// console.log(props.job_no);

												var words = spatial_id
														.split('.');

												// var word0
												// =
												// words[0];
												var parcel_uuid = words[1];
												console.log(parcel_uuid);

												$("#newcomparabledata").modal();

												$(
														'#newcomparabledata #cbl_parcel_uuid')
														.val(parcel_uuid);

												$(
														'#newcomparabledata #cbl_job_no')
														.val(props.job_no);
												$(
														'#newcomparabledata #cbl_transaction_date')
														.val(
																props.transaction_date);
												$(
														'#newcomparabledata #cbl_accreage_size_of_land')
														.val(
																props.accreage_size_of_land);
												$(
														'#newcomparabledata #cbl_confirmed_acre_size')
														.val(
																props.confirmed_acre_size);

												$(
														'#newcomparabledata #cbl_unexpired_term')
														.val(
																props.unexpired_term);
												$(
														'#newcomparabledata #cbl_source_data')
														.val(props.source_data);

												$(
														'#newcomparabledata #cbl_value_of_property')
														.val(
																props.value_of_property);

												$(
														'#newcomparabledata #cbl_type_of_house')
														.val(
																props.type_of_house);
												$(
														'#newcomparabledata #cbl_prominent_landmarks')
														.val(
																props.prominent_landmarks);

												$(
														'#newcomparabledata #cbl_locality')
														.val(props.locality);

												$(
														'#newcomparabledata #cbl_type_of_use')
														.val(props.type_of_use);
												$(
														'#newcomparabledata #cbl_property_owner')
														.val(
																props.property_owner);

												$(
														'#newcomparabledata #cbl_source_of_verification')
														.val(
																props.source_of_verification);

												$(
														'#newcomparabledata #cbl_currency_of_value')
														.val(
																props.currency_of_value);

												$(
														'#newcomparabledata #cbl_capital_value')
														.val(
																props.capital_value);

												$(
														'#newcomparabledata #cbl_ground_rent')
														.val(props.ground_rent);

												$(
														'#newcomparabledata #cbl_commencement_date')
														.val(
																props.commencement_date);

												$(
														'#newcomparabledata #cbl_general_omment')
														.val(
																props.general_omment);

												$(
														'#newcomparabledata #cbl_image_path')
														.val(props.image_path);

												var table = $('#lvd_construcctional_details_dataTable');
												table.find("tbody tr").remove();
												$
														.ajax({
															type : "POST",
															url : 'Maps',
															data : {
																request_type : 'load_lvd_constructional_details',
																pid_fk : parcel_uuid
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

																$(json_p.data)
																		.each(
																				function() {

																					table
																							.append("<tr><td>"
																									+ this.floor_details
																									+ "</td><td>"
																									+ this.walls_details
																									+ "</td><td>"
																									+ this.doors_details
																									+ "</td><td>"
																									+ this.windows_details
																									+ "</td>"

																									+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addlrdtransaction" data-target-id="'
																									+ this.id
																									+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																									+ "</tr>");
																				});

															}
														});

											}
											// }

										},
										failure : function(errormsg) {
											// Ext.get(login.getEl()).unmask();
											console.log(errormsg);
										}
									});

						}
						// }

					}
				});
				
$('#btn_save_comparable_main_changes_point').on('click', function(e) {

	var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

	console.log(wktplygonsearch);

	var parcel_uuid = $("#cbl_parcel_uuid_point").val();
	var transaction_date = $("#cbl_transaction_date_point").val();
	var request_type = 'save_lvd_parcel';
	var job_no = $("#cbl_job_no_point").val();
	var accreage_size_of_land = $("#cbl_accreage_size_of_land_point").val();
	var confirmed_acre_size = $("#cbl_confirmed_acre_size_point").val();
	var unexpired_term = $("#cbl_unexpired_term_point").val();
	var transaction_date = $("#cbl_transaction_date_point").val();
	var value_of_property = $("#cbl_value_of_property_point").val();
	var type_of_house = $("#cbl_type_of_house_point").val();
	var source_data = $("#cbl_source_data_point").val();
	var prominent_landmarks = $("#cbl_prominent_landmarks_point").val();
	var locality = $("#cbl_locality_point").val();
	var type_of_use = $("#cbl_type_of_use_point").val();
	var property_owner = $("#cbl_property_owner_point").val();

	$.ajax({
		type : "POST",
		url : 'Maps',
		data : {
			request_type : 'select_update_sp_parcels_lvd_point',
			// request_type :
			// request_type,
			parcel_uuid : parcel_uuid,
			job_no : job_no,
			accreage_size_of_land : accreage_size_of_land,
			confirmed_acre_size : confirmed_acre_size,
			unexpired_term : unexpired_term,
			transaction_date : transaction_date,
			value_of_property : value_of_property,
			type_of_house : type_of_house,
			source_data : source_data,
			prominent_landmarks : prominent_landmarks,
			locality : locality,
			type_of_use : type_of_use,
			property_owner : property_owner
		},
		cache : false,
		beforeSend : function() {
			// $('#district').html('<img
			// src="img/loading.gif"
			// alt=""
			// width="24"
			// height="24">');
		},
		success : function(scanned_docs_response) {

			// var json_p =
			// JSON.parse(scanned_docs_response);

			/*
			 * $("#newcomparabledata").modal(); $('#newcomparabledata
			 * #parcel_uuid').val( scanned_docs_response);
			 */

			alert(scanned_docs_response);
			$('#newcomparabledata_point').modal('hide');

		}
	});

});

$('#btn_save_comparable_main_changes_new').on('click', function(e) {

	var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

	console.log(wktplygonsearch);

	var parcel_uuid = $("#cbl_parcel_uuid").val();
	var transaction_date = $("#cbl_transaction_date").val();
	var request_type = 'save_lvd_parcel';
	var job_no = $("#cbl_job_no").val();
	var accreage_size_of_land = $("#cbl_accreage_size_of_land").val();
	var confirmed_acre_size = $("#cbl_confirmed_acre_size").val();
	var unexpired_term = $("#cbl_unexpired_term").val();
	var transaction_date = $("#cbl_transaction_date").val();
	var value_of_property = $("#cbl_value_of_property").val();
	var type_of_house = $("#cbl_type_of_house").val();
	var source_data = $("#cbl_source_data").val();
	var prominent_landmarks = $("#cbl_prominent_landmarks").val();
	var locality = $("#cbl_locality").val();
	var type_of_use = $("#cbl_type_of_use").val();
	var property_owner = $("#cbl_property_owner").val();

	var source_of_verification = $("#cbl_source_of_verification").val();
	var currency_of_value = $("#cbl_currency_of_value").val();
	var capital_value = $("#cbl_capital_value").val();
	var ground_rent = $("#cbl_ground_rent").val();
	var rental_value = $("#cbl_rental_value").val();
	var commencement_date = $("#cbl_commencement_date").val();
	var general_omment = $("#cbl_general_omment").val();
	var image_path = $("#cbl_property_owner").val();

	$.ajax({
		type : "POST",
		url : 'Maps',
		data : {
			request_type : 'save_lvd_parcel',
			// request_type :
			// request_type,
			parcel_uuid : parcel_uuid,
			job_no : job_no,
			accreage_size_of_land : accreage_size_of_land,
			confirmed_acre_size : confirmed_acre_size,
			unexpired_term : unexpired_term,
			transaction_date : transaction_date,
			value_of_property : value_of_property,
			type_of_house : type_of_house,
			source_data : source_data,
			prominent_landmarks : prominent_landmarks,
			locality : locality,
			type_of_use : type_of_use,
			property_owner : property_owner
		},
		cache : false,
		beforeSend : function() {
			// $('#district').html('<img
			// src="img/loading.gif"
			// alt=""
			// width="24"
			// height="24">');
		},
		success : function(scanned_docs_response) {

			// var json_p =
			// JSON.parse(scanned_docs_response);

			/*
			 * $("#newcomparabledata").modal(); $('#newcomparabledata
			 * #parcel_uuid').val( scanned_docs_response);
			 */

			alert(scanned_docs_response);
			$('#newcomparabledata').modal('hide');

		}
	});

});


$('#btn_map_comparable_search_by_report')
		.on(
				'click',
				function(e) {
					var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();
					console.log(wktplygonsearch);
					$
							.ajax({
								type : "POST",
								url : "Maps",
								data : {
									request_type : 'lvd_search_for_comparables_by_wkt_polygon',
									wkt_polgon : wktplygonsearch,
								},

								success : function(jobdetails) {

									datatable.search("").draw();
									// datatable.state.clear();
									datatable.clear();
									// console.log(jobdetails);
									var json_p = JSON.parse(jobdetails);
									$(json_p.parcel)
											.each(
													function() {

														datatable.row
																.add(
																		[

																				this.job_no,
																				this.transaction_date,
																				this.accreage_size_of_land,
																				this.value_of_property,

																				'<button  class="btn btn-info btn-icon-split"  data-title="View"  id="btnView-'
																						+ this.job_no
																						+ '" data-id="'
																						+ this.id
																						+ '" data-job_no="'
																						+ this.job_no
																						+ '" data-property_owner="'
																						+ this.property_owner
																						+ '" data-wkt="'
																						+ this.wkt
																						+ '" data-target="#comparablepopup" data-toggle="modal" >'
																						+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">View</span>'
																						+ ' </button>',

																		])
																.draw(false);

													});

								}

							});
				});

$('#btn_map_comparable_report_rpt').on(
		'click',
		function(e) {

			/*
			 * var json_p = JSON.parse(jobdetails); $(json_p.data).each(
			 * function() {
			 * 
			 * $('#geoserverscannedimages_list').append( '<option value="' +
			 * this.file_name + ':' + this.extent + '">' + this.file_name + '</option>');
			 * 
			 * });
			 * 
			 * var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();
			 */

			// wktplygonsearch
			// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();
			var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();
			var canvas = document.getElementById("lvd-map")
					.getElementsByClassName("ol-unselectable")[0];
			var img = canvas.toDataURL("image/png");

			// var canvas = event.context.canvas;
			// var data =
			// canvas.toDataURL('image/jpeg');
			var doc = new jsPDF('portrait', undefined, 'a4');
			// var doc = new jsPDF('landscape',
			// undefined, 'a4');
			doc.setProperties({
				title : 'Comparable Report',
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
			doc.text(68, 35, 'LAND VALUATION DIVISION')

			doc.setFontSize(14)
			doc.text(75, 45, 'COMPARABLE REPORT')

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
			// 144, 42); //shows
			// correct image

			doc.addImage(img, 'JPEG', 20, 60, 160, 80);

			doc.setFontSize(10)
			doc.setDrawColor(255, 0, 0); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 190, 50, 190);
			doc.text(60, 190, 'Search Polygon')

			doc.setDrawColor(51, 51, 255); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 200, 50, 200);
			doc.text(60, 200, 'Approved Comparable')

			doc.setDrawColor(0, 204, 0); // draw
			// red
			// lines
			doc.setLineWidth(1.5);
			doc.line(15, 210, 50, 210);
			doc.text(60, 210, 'Not Approved Comparable')

			/*
			 * doc.setDrawColor(0, 204, 0); // draw red lines
			 * doc.setLineWidth(1.5); doc.line(15, 210, 50, 210); doc.text(60,
			 * 210, 'LRD Parcel')
			 * 
			 * 
			 * doc.setDrawColor(255, 153, 51); // draw red lines
			 * doc.setLineWidth(1.5); doc.line(15, 220, 50, 220); doc.text(60,
			 * 220, 'SMD Parcel')
			 */

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

			// doc.save('map.pdf');

			$.ajax({
				type : "POST",
				url : "Maps",
				data : {
					request_type : 'lvd_search_for_comparables_by_wkt_polygon',
					wkt_polgon : wktplygonsearch,
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

					if (json_p !== undefined || json_p !== null) {

						if (json_p.parcel === undefined
								|| json_p.parcel === null) {

							doc.addPage('a4', 'l');
							var data_rows = [ {
								main_description : 'No Recorded Transaction'
							} ];
							var columns = [ {
								title : 'Comparable Data',
								dataKey : 'main_description'
							} ]

							doc.autoTable(columns, data_rows, {
								margin : {
									top : 10
								},
								theme : 'grid',
								startY : doc.autoTable.previous.finalY + 20
							});

						} else {
							doc.addPage('a4', 'l');
							transaction_data = json_p.parcel;

							var columns = [ {
								title : "Job No",
								dataKey : "job_no"
							}, {
								title : "Transaction Date",
								dataKey : "transaction_date"
							}, {
								title : "Land Size",
								dataKey : "accreage_size_of_land"
							}, {
								title : "Confirmed Land Size",
								dataKey : "confirmed_acre_size"
							}, {
								title : "Unexpired Term",
								dataKey : "unexpired_term"
							}, {
								title : "Data Source",
								dataKey : "source_data"
							}, {
								title : "Value",
								dataKey : "value_of_property"
							}

							];

							console.log(transaction_data);

							var rows = transaction_data;

							doc.autoTable(columns, rows, {
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
								startY : 20,
								columnWidth : 'wrap',
								columnStyles : {
									source_data : {
										columnWidth : 60
									},
									value_of_property : {
										columnWidth : 50
									}
								},

							});

						}

						doc.save('map.pdf');
					} else {
						/*
						 * Ext.Msg.show({ title:'Error!', msg: "Error in loading
						 * data", icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK })
						 */
					}
				}
			});

			// Landscape export, 2×4
			// inches
			/*
			 * const doc = new jsPDF({ orientation : "landscape", unit : "in",
			 * format : [ 4, 2 ] });
			 * 
			 * doc.text("Hello world!", 1, 1); doc.save("two-by-four.pdf");
			 */

		});

$('#lvd_btn_visualise_coordinate').on(
		'click',
		function(e) {

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

			$('#lvd_txt_wkt_polygon').val(polygon_tttt);
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

			lvd_pvlmd_searchLayer.setSource(new ol.source.Vector({
				features : (new ol.format.WKT()).readFeatures(polygon_tttt)
			}));
			view.fit(lvd_pvlmd_searchLayer.getSource().getExtent());

			lvd_map.getView().fit(
					lvd_pvlmd_searchLayer.getSource().getExtent(), {
						size : lvd_map.getSize(),
						maxZoom : 16
					})

		});

$('#lvd_btn_visualise_point').on('click', function(e) {

	var table = $('#coordinatelis_Table').tableToJSON();

	var list_of_application_new = JSON.stringify(table);
	console.log(list_of_application_new);

	var json_p = JSON.parse(list_of_application_new);

	console.log(json_p);
	polygon = '';

	point_coordinate_list = '';

	var jsonArr = [];

	var counter = 0;
	var x_coordinate_mak = "0";
	var y_coordinate_mak = "0";
	var main_coordinate_name = "0";

	$(json_p).each(function() {

		item = {}
		item["coordinate_name"] = this.name;
		item["x_coordinate"] = this.x_coordinate;
		item["y_coordinate"] = this.y_coordinate;

		main_coordinate_name = this.name;
		x_coordinate_mak = this.x_coordinate;
		y_coordinate_mak = this.y_coordinate;

		jsonArr.push(item);
		polygon += this.y_coordinate + " " + this.x_coordinate;

		counter++;

	});

	lvd_markers.getSource().clear()
	polygon_real = "POINT( " + polygon + " )";

	$('#lvd_txt_wkt_polygon').val(polygon_real);

	var marker = new ol.Feature({
		geometry : new ol.geom.Point([ y_coordinate_mak, x_coordinate_mak ]),
		label : "Airport"

	});

	lvd_markers.getSource().addFeature(marker);

	lvd_map.getView().fit(lvd_markers.getSource().getExtent(), {
		size : lvd_map.getSize(),
		maxZoom : 16
	})

});

$('#lvd_btn_show_location').on('click', function(e) {

	console.log('you');
	markers.getSource().clear()
	var x_coordinate_mak = $('#lvd_x_coordinate').val();
	var y_coordinate_mak = $('#lvd_y_coordinate').val();

	var marker = new ol.Feature({
		geometry : new ol.geom.Point([ x_coordinate_mak, y_coordinate_mak ])
	// dont worry about coordinate type 0,0
	// will be in west coast of
	// africa
	});
	// source.addFeature(marker);

	// lvd_pvlmd_searchLayer.setSource(new
	// ol.source.Vector({features:
	// (new
	// ol.format.WKT()).readFeatures(polygon_tttt)}));
	// var marker = new ol.Feature(new
	// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
	// x_coordinate_mak])));
	lvd_markers.getSource().addFeature(marker);

	// lvd_pvlmd_searchLayer.setSource(new
	// ol.source.Vector({features:
	// (new
	// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

	// view.fit(markers.getSource().getExtent());
	// var extent =
	// lvd_pvlmd_searchLayer.getSource().getExtent();
	lvd_map.getView().fit(lvd_markers.getSource().getExtent(), {
		size : lvd_map.getSize(),
		maxZoom : 16
	})
});

$('#lvd_btn_search_for_scanned_maps').on('click', function(e) {

	console.log('kkkkk');

	// var wkt_polygon =
	// $('#lvd_txt_wkt_polygon').val();

	var wkt_polygon_k = $.trim($("#lvd_txt_wkt_polygon").val());
	var wkt_polygon = document.getElementById("lvd_txt_wkt_polygon").value;
	console.log(wkt_polygon);

	// var job_number =
	// $("#job_number").val();
	$.ajax({
		type : "POST",
		url : "Maps",
		data : {
			request_type : 'search_for_lvd_scan_map_for_a_polygon',
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
			console.log('how come')
			console.log(result)
			/*
			 * $('#geoserverscannedimages_list') .append( '<option value="' +
			 * 'csau_geospatial:108_PART_1_modified:[80935.449735544404,1209.0295731349593,1711780.3060929566,2358523.1247835089]' +
			 * '">' + 'csau_geospatial:108_PART_1_modified' + '</option>');
			 */

			$(json_p.data).each(function() {

				$('#geoserverscannedimages_list').append('<option value="'

				+ this.file_name + ':' + this.extent

				+ '">' + this.file_name + '</option>');
			});

		}
	});
});

$('#lvd_btn_load_for_scanned_maps').on(
		'click',
		function(e) {

			console.log('kkkkk');

			// var wkt_polygon =
			// $('#lvd_txt_wkt_polygon').val();

			var geoserverscannedimage = $
					.trim($("#geoserverscannedimages_list").val());
			/*
			 * var wkt_polygon = document
			 * .getElementById("lvd_txt_wkt_polygon").value;
			 */
			console.log('Scan Map');

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

			lvd_StaticImage.setSource(image_source);

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

			lvd_map.getView().fit(new_extent, lvd_map.getSize());

			// map.getView().fit(new_extent,
			// map.getSize());

			/*
			 * lvd_map.getView().fit(new_extent, { size : lvd_map.getSize(),
			 * maxZoom : 16 })
			 */

		});


$('#lvd_btn_visualise_wkt').on('click', function(e) {

	// wktplygonsearch
	// var wktplygonsearch =
	// document.getElementById("txt_wkt_polygon");
	// console.log(wktplygonsearch)

	var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

	console.log(wktplygonsearch)

	lvd_pvlmd_searchLayer.setSource(new ol.source.Vector({
		features : (new ol.format.WKT()).readFeatures(wktplygonsearch)
	}));
	// view.fit(lvd_pvlmd_searchLayer.getSource().getExtent());
	var extent = lvd_pvlmd_searchLayer.getSource().getExtent();
	lvd_map.getView().fit(extent, {
		size : lvd_map.getSize(),
		maxZoom : 16
	})
});

$('#lvd_btn_save_wkt').on(
		'click',
		function(e) {

			// wktplygonsearch
			// var wktplygonsearch =
			// document.getElementById("txt_wkt_polygon");
			// console.log(wktplygonsearch)

			var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

			console.log(wktplygonsearch);

			$.ajax({
				type : "POST",
				url : 'Maps',
				data : {
					request_type : 'select_save_lvd_parcels',
					vr_wkt_polygon : wktplygonsearch
				},
				cache : false,
				beforeSend : function() {
					// $('#district').html('<img
					// src="img/loading.gif"
					// alt=""
					// width="24"
					// height="24">');
				},
				success : function(scanned_docs_response) {

					// var json_p =
					// JSON.parse(scanned_docs_response);

					$("#newcomparabledata").modal();

					$('#newcomparabledata #cbl_parcel_uuid').val(
							scanned_docs_response);

				}
			});

		});

$('#lvd_btn_save_wkt_point').on(
		'click',
		function(e) {

			// wktplygonsearch
			// var wktplygonsearch =
			// document.getElementById("txt_wkt_polygon");
			// console.log(wktplygonsearch)

			var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

			console.log(wktplygonsearch);

			$.ajax({
				type : "POST",
				url : 'Maps',
				data : {
					request_type : 'select_save_sp_parcels_lvd_point',
					vr_wkt_polygon : wktplygonsearch
				},
				cache : false,
				beforeSend : function() {
					// $('#district').html('<img
					// src="img/loading.gif"
					// alt=""
					// width="24"
					// height="24">');
				},
				success : function(scanned_docs_response) {

					// var json_p =
					// JSON.parse(scanned_docs_response);

					$("#newcomparabledatapoint").modal();
					$('#newcomparabledatapoint #cbl_parcel_uuid_point').val(
							scanned_docs_response);

				}
			});

		});


$('#lvd_btn_search_by_certificate_number')
		.on(
				'click',
				function(e) {

					var search_text = $('#lvd_search_by_text').val();
					console.log(search_text)

					$("#addnewcomparable").modal();

					$('#addlvdtransaction #lvd_td_fid_id_fk').val([]);
					$('#addlvdtransaction #lvd_td_gid').val([]);
					$('#addlvdtransaction #lvd_td_plotted_by_reg').val([]);
					$('#addlvdtransaction #lvd_td_checked_by').val([]);
					$('#addlvdtransaction #lvd_td_plott_date_reg').val([]);
					$('#addlvdtransaction #lvd_td_certicate_number').val([]);

					$('#addlvdtransaction #nature_of_instument').val([]);
					$('#addlvdtransaction #applicant_name').val([]);
					$('#addlvdtransaction #plan_number').val([]);

					$('#addlvdtransaction #lvd_td_type_instrument').val([]);
					$('#addlvdtransaction #lvd_td_date_of_instument').val([]);
					$('#addlvdtransaction #lvd_td_consideration').val([]);
					$('#addlvdtransaction #lvd_td_purpose').val([]);
					$('#addlvdtransaction #lvd_td_date_commencement').val([]);
					$('#addlvdtransaction #lvd_td_term').val([]);

					$('#addlvdtransaction #lvd_td_remarks').val([]);
					$('#addlvdtransaction #lvd_td_type_of_registration')
							.val([]);
					$('#addlvdtransaction #lvd_td_encumbrance').val([]);
					$('#addlvdtransaction #lvd_td_checked_by').val([]);

					$('#addlvdtransaction #lvd_td_date_of_registration')
							.val([]);
					$('#addlvdtransaction #lvd_td_volume').val([]);
					$('#addlvdtransaction #lvd_td_folio').val([]);
					$('#addlvdtransaction #lvd_td_date_of_issued_cert_no').val(
							[]);
					$('#addlvdtransaction #lvd_td_type_of_certificate').val([]);
					$('#addlvdtransaction #lvd_td_registered_number').val([]);

					$('#addlvdtransaction #lvd_td_cc_number').val([]);
					$('#addlvdtransaction #lvd_td_certicate_number').val([]);
					$('#addlvdtransaction #lvd_td_registered_number').val([]);
					$('#addlvdtransaction #lvd_td_cc_number').val([]);
					$('#addlvdtransaction #lvd_td_grantor_name').val([]);
					$('#addlvdtransaction #lvd_td_job_number').val([]);

					$('#addnewcomparable #lvd_ps_fid').val('0');

					$('#addnewcomparable #lvd_ps_reference_number').val(
							search_text);
					$('#addnewcomparable #lvd_ps_locality').val('');
					$('#addnewcomparable #lvd_ps_plotted_by').val('');
					$('#addnewcomparable #lvd_ps_date_plott').val('');

					$('#addnewcomparable #lvd_ps_checked_by').val('');
					$('#addnewcomparable #lvd_ps_type_of_plotting').val('');
					$('#addnewcomparable #lvd_td_reference_number').val('');

					var table = $('#lvd_transaction_dataTable');
					table.find("tbody tr").remove();
					$
							.ajax({
								type : "POST",
								url : 'Maps',
								data : {
									request_type : 'load_lvd_transaction_details_by_certificate_number',
									certificate_number : search_text
								},
								cache : false,
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success : function(serviceresponse) {

									var json_p = JSON.parse(serviceresponse);
									console.log(json_p)

									$(json_p.data)
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

																		+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addlvdtransaction" data-target-id="'
																		+ this.gid
																		+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																		+ "</tr>");
													});

									var table_docs = $('#lvd_scanned_documents_dataTable');
									table_docs.find("tbody tr").remove();
									$
											.ajax({
												type : "POST",
												url : 'LoadLRDJackets',
												data : {
													request_type : 'load_lvd_jacket_certificate',
													certificate_number : search_text
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
														scanned_docs_response) {

													var json_p = JSON
															.parse(scanned_docs_response);
													console.log(json_p)

													$(json_p)
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

								}
							});

				});

$('#lvd_btn_search_by_reference_number')
		.on(
				'click',
				function(e) {

					var search_text = $('#lvd_search_by_text').val();
					console.log(search_text)

					$
							.ajax({
								type : "POST",
								url : "Maps",
								data : {
									request_type : 'lc_spatial_objects_search_by_other_details',
									vr_search_text : search_text
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
										// lvd_pvlmd_searchLayer.getSource().getFeatures().length;
										// console.log(featureCount);

										if (lvd_pvlmd_searchLayer.getSource() != null) {
											lvd_pvlmd_searchLayer.getSource()
													.clear();
										}

										if (json_p.parcels === undefined
												|| json_p.parcels.features === null) {

										} else {
											lvd_pvlmd_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.parcels)
															}));

										}

										view.fit(lvd_pvlmd_searchLayer
												.getSource().getExtent());
										lvd_map.getView().fit(
												lvd_pvlmd_searchLayer
														.getSource()
														.getExtent(), {
													size : lvd_map.getSize(),
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

$('#comparablepopup').on('show.bs.modal', function(e) {
	var id = $(e.relatedTarget).data('id');
	var job_no = $(e.relatedTarget).data('job_no');
	var property_owner = $(e.relatedTarget).data('property_owner');
	var geom = $(e.relatedTarget).data('wkt');

	console.log(geom);

	lvd_pvlmd_searchLayer.setSource(new ol.source.Vector({
		features : (new ol.format.WKT()).readFeatures(geom)
	}));
	view.fit(lvd_pvlmd_searchLayer.getSource().getExtent());

	lvd_map.getView().fit(lvd_pvlmd_searchLayer.getSource().getExtent(), {
		size : lvd_map.getSize(),
		maxZoom : 16
	})

	$('#comparablepopup').modal('hide');

});

$('#comparableapprovalpopup').on('show.bs.modal', function(e) {
	var id = $(e.relatedTarget).data('id');
	var job_no = $(e.relatedTarget).data('job_no');
	var property_owner = $(e.relatedTarget).data('property_owner');
	var geom = $(e.relatedTarget).data('wkt');

	$('#comparableapprovalpopup #cbl_parcel_uuid_ca').val(id);
	$('#comparableapprovalpopup #cbl_job_no_ca').val(job_no);
	$('#comparableapprovalpopup #cbl_owners_name_ca').val(property_owner);

	// $('#comparablepopup').modal('hide');

});

$('#btn_approve_comparable').on('click', function(e) {

	var cbl_parcel_uuid_ca = $("#cbl_parcel_uuid_ca").val();
	var cbl_job_no_ca = $("#cbl_job_no_ca").val();

	cbl_parcel_uuid_ca = cbl_parcel_uuid_ca.replace('.0', '');
	console.log(cbl_parcel_uuid_ca);

	$.ajax({
		type : "POST",
		url : 'Maps',
		data : {
			request_type : 'select_update_sp_parcels_lvd_point',
			id : cbl_parcel_uuid_ca,
			job_no : cbl_job_no_ca
		},
		cache : false,
		success : function(aj_response) {
			alert(aj_response);
			// $('#newcomparabledata_point').modal('hide');

		}
	});

});

$('#btn_map_comparable_search_by_locality')
		.on(
				'click',
				function(e) {

					var lcc_locality_value = $("#lcc_locality_value").val();

					$
							.ajax({
								type : "POST",
								url : 'Maps',
								data : {
									request_type : 'select_sp_parcels_lvd_search_report_geom_locality',
									locality : lcc_locality_value
								},
								cache : false,
								success : function(aj_response) {
									// alert(aj_response);

									var json_p = JSON.parse(aj_response);
									console.log(json_p)

									if (json_p !== undefined || json_p !== null) {
										// var featureCount
										// =
										// lvd_pvlmd_searchLayer.getSource().getFeatures().length;
										// console.log(featureCount);

										if (lvd_pvlmd_searchLayer.getSource() != null) {
											lvd_pvlmd_searchLayer.getSource()
													.clear();
										}

										if (json_p.parcel === undefined
												|| json_p.parcel.features === null) {

										} else {
											lvd_pvlmd_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.parcel)
															}));

										}

										view.fit(lvd_pvlmd_searchLayer
												.getSource().getExtent());
										lvd_map.getView().fit(
												lvd_pvlmd_searchLayer
														.getSource()
														.getExtent(), {
													size : lvd_map.getSize(),
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

$('#lvd_btn_search_comparables_by_polygon')
		.on(
				'click',
				function(e) {

					var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

					$
							.ajax({
								type : "POST",
								url : 'Maps',
								data : {
									request_type : 'select_sp_parcels_lvd_search_report_geom',
									polygon : wktplygonsearch
								},
								cache : false,
								success : function(aj_response) {
									var json_p = JSON.parse(aj_response);
									console.log(json_p)

									if (json_p !== undefined || json_p !== null) {
										// var featureCount
										// =
										// lvd_pvlmd_searchLayer.getSource().getFeatures().length;
										// console.log(featureCount);

										if (lvd_pvlmd_searchLayer.getSource() != null) {
											lvd_pvlmd_searchLayer.getSource()
													.clear();
										}

										if (json_p.parcel === undefined
												|| json_p.parcel.features === null) {

										} else {
											lvd_pvlmd_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.parcel)
															}));

										}

										view.fit(lvd_pvlmd_searchLayer
												.getSource().getExtent());
										lvd_map.getView().fit(
												lvd_pvlmd_searchLayer
														.getSource()
														.getExtent(), {
													size : lvd_map.getSize(),
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

$('#lvd_btn_print_map')
		.on(
				'click',
				function(e) {

					console.log("click_type");

					var wktplygonsearch = $('#lvd_txt_wkt_polygon').val();

					// wktplygonsearch
					// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();

					var canvas = document.getElementById("lvd-map")
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
					doc.line(15, 190, 50, 190);
					doc.text(60, 190, 'Search Polygon')

					doc.setDrawColor(51, 51, 255); // draw
					// red
					// lines
					doc.setLineWidth(1.5);
					doc.line(15, 200, 50, 200);
					doc.text(60, 200, 'PVLMD Parcel')

					/*
					 * doc.setDrawColor(0, 204, 0); // draw red lines
					 * doc.setLineWidth(1.5); doc.line(15, 210, 50, 210);
					 * doc.text(60, 210, 'LRD Parcel')
					 * 
					 * 
					 * doc.setDrawColor(255, 153, 51); // draw red lines
					 * doc.setLineWidth(1.5); doc.line(15, 220, 50, 220);
					 * doc.text(60, 220, 'SMD Parcel')
					 */

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

											doc.addPage('a4', 'l');
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
																		.autoTableEndPosY() + 20
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
											// doc.text(20,
											// 30,
											// 'Existing
											// GARRO Data')
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
																		columnWidth : 100
																	},
																	party2_defendant : {
																		columnWidth : 50
																	}
																},
																addPageContent : function(
																		data) {
																	doc
																			.text(
																					"Asssiamah",
																					40,
																					40);
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
											// doc.text(20,
											// 30,
											// 'Existing CRO
											// Data')
											transaction_data = json_p.cro;

											var columns = [ {
												title : "LS Number",
												dataKey : "ls_number"
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

										if (json_p.lvd === undefined
												|| json_p.lvd === null) {

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
											// ol.format.GeoJSON()).readFeatures(json_p.lvd)}));
											// doc.addPage('a4',
											// 'l');
											// doc.setFontSize(12)
											// doc.text(20,
											// 30, 'LRD
											// Layer')
											transaction_data = json_p.lvd;

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
// });
