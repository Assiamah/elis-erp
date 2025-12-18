/*$(document)
		.ready(
				function() {
 */
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
	title : 'LRD Parcels',
	source : parcel_lrd_dataSource

})

var parcels_smd_dataSource = new ol.source.TileWMS({
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

var parcels_smd_dataLayer = new ol.layer.Tile({
	title : 'SMD Parcels',
	source : parcels_smd_dataSource

})

var garro_parcels_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:garro_sp',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var garro_parcels_dataLayer = new ol.layer.Tile({
	title : 'GARRO Parcels',
	// visible: false,
	source : garro_parcels_dataSource

})

var cro_sp_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:cro_sp',
		'TILED' : true
	},
	// params: {'LAYERS':
	// 'rating:spatial_unit_assembly', 'cql_filter':
	// "assembly_code='AMA'" , 'TILED': true },,
	serverType : 'geoserver',
	transition : 0
})

var cro_parcels_dataLayer = new ol.layer.Tile({
	title : 'CRO Parcels',
	// visible: false,
	source : cro_sp_dataSource

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
	visible : false,
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

pvlmd_searchLayer = new ol.layer.Vector({
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
	target : 'map',
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

// map.addLayer(new_de);
map.addLayer(googleLayerHybrid);
map.addLayer(StaticImage);
map.addLayer(registration_district_dataLayer);

map.addLayer(grid_lrd_dataLayer);

// map.addLayer(beacon_lrd_dataLayer);
map.addLayer(pvlmd_searchLayer);

map.addLayer(lrd_parcels_dataLayer);
map.addLayer(garro_parcels_dataLayer);
map.addLayer(parcels_smd_dataLayer);
map.addLayer(cro_parcels_dataLayer);
// / garro_parcels_dataLayer
// parcels_smd_dataLayer
// cro_parcels_dataLayer
/*
 * document.getElementById('btnprinktmap').addEventListener('click', function() {
 * 
 * });
 */

document
		.getElementById('btn_visualise_search')
		.addEventListener(
				'click',
				function() {

					var wktplygonsearch = $('#bl_wkt_polygon').val();
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

										if (pvlmd_searchLayer.getSource() != null) {
											pvlmd_searchLayer.getSource()
													.clear();
										}

										if (json_p.garro === undefined
												|| json_p.garro.features === null) {

										} else {
											pvlmd_searchLayer
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
											pvlmd_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.cro)
															}));
										}

										if (json_p.smd === undefined
												|| json_p.smd.features === null) {
										} else {
											pvlmd_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.smd)
															}));
										}

										if (json_p.lrd === undefined
												|| json_p.lrd.features === null) {
										} else {
											pvlmd_searchLayer
													.setSource(new ol.source.Vector(
															{
																features : (new ol.format.GeoJSON())
																		.readFeatures(json_p.lrd)
															}));
										}
										view.fit(pvlmd_searchLayer.getSource()
												.getExtent());
										map.getView().fit(
												pvlmd_searchLayer.getSource()
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

document.getElementById('btn_visualise_wkt').addEventListener('click',
		function() {
			// wktplygonsearch
			// var wktplygonsearch =
			// document.getElementById("txt_wkt_polygon");
			// console.log(wktplygonsearch)

			var wktplygonsearch = $('#bl_wkt_polygon').val();

			console.log(wktplygonsearch)

			pvlmd_searchLayer.setSource(new ol.source.Vector({
				features : (new ol.format.WKT()).readFeatures(wktplygonsearch)
			}));
			// view.fit(pvlmd_searchLayer.getSource().getExtent());
			var extent = pvlmd_searchLayer.getSource().getExtent();
			map.getView().fit(extent, {
				size : map.getSize(),
				maxZoom : 16
			})
		});

document
		.getElementById('btnprintmap')
		.addEventListener(
				'click',
				function() {
					console.log("click_type");

					var wktplygonsearch = $('#bl_wkt_polygon').val();

					// wktplygonsearch
					// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();

					var canvas = document.getElementById("map")
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
					doc.text(80, 35, 'OFFICIAL SEARCH')

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

										if (pvlmd_searchLayer.getSource() != null) {
											pvlmd_searchLayer.getSource()
													.clear();
										}

										if (json_p.garro === undefined) {
											doc.setFontSize(16)
											doc.text(20, 30,
													'No Recorded Transaction')
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.garro)}));
											doc.addPage('a4', 'l');
											transaction_data = json_p.garro;

											var columns = [ {
												title : "instrument_date",
												dataKey : "instrument_date"
											}, {
												title : "instrument_type",
												dataKey : "instrument_type"
											}, {
												title : "party1_plaintiff",
												dataKey : "party1_plaintiff"
											}, {
												title : "party2_defendant",
												dataKey : "party2_defendant"
											}, {
												title : "term",
												dataKey : "term"
											}, {
												title : "commencement_date",
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
																	top : 35
																},
																addPageContent : function(
																		data) {
																	doc.text(
																			"",
																			40,
																			40);
																}
															});
										}
										if (json_p.cro === undefined) {
											doc.setFontSize(16)
											doc.text(20, 30,
													'No Recorded Transaction')
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.cro)}));
											doc.addPage('a4', 'l');
											transaction_data = json_p.cro;

											var columns = [ {
												title : "instrument_date",
												dataKey : "instrument_date"
											}, {
												title : "instrument_type",
												dataKey : "instrument_type"
											}, {
												title : "party1_plaintiff",
												dataKey : "party1_plaintiff"
											}, {
												title : "party2_defendant",
												dataKey : "party2_defendant"
											}, {
												title : "term",
												dataKey : "term"
											}, {
												title : "commencement_date",
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
																	top : 35
																},
																addPageContent : function(
																		data) {
																	doc.text(
																			"",
																			40,
																			40);
																}
															});
										}

										if (json_p.smd === undefined) {
											doc.setFontSize(16)
											doc.text(20, 30,
													'No Recorded Transaction')
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.smd)}));
											doc.addPage('a4', 'l');
											transaction_data = json_p.smd;

											var columns = [ {
												title : "date_instr",
												dataKey : "date_instr"
											}, {
												title : "ccno",
												dataKey : "ccno"
											}, {
												title : "a_name",
												dataKey : "a_name"
											}, {
												title : "grantor",
												dataKey : "grantor"
											}, {
												title : "Term",
												dataKey : "term"
											}, {
												title : "date_com",
												dataKey : "date_com"
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
																	top : 35
																},
																addPageContent : function(
																		data) {
																	doc.text(
																			"",
																			40,
																			40);
																}
															});
										}

										if (json_p.lrd === undefined) {
											doc.setFontSize(16)
											doc.text(20, 30,
													'No Recorded Transaction')
											// doc.save('map.pdf');
										} else {
											// pvlmd_searchLayer.setSource(new
											// ol.source.Vector({features:
											// (new
											// ol.format.GeoJSON()).readFeatures(json_p.lrd)}));
											doc.addPage('a4', 'l');
											transaction_data = json_p.lrd;

											var columns = [ {
												title : "date_of_instument",
												dataKey : "date_of_instument"
											}, {
												title : "type_instrument",
												dataKey : "type_instrument"
											}, {
												title : "grantor_name",
												dataKey : "grantor_name"
											}, {
												title : "applicant_name",
												dataKey : "applicant_name"
											}, {
												title : "Term",
												dataKey : "term"
											}, {
												title : "date_commencement",
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
																	top : 35
																},
																addPageContent : function(
																		data) {
																	doc.text(
																			"",
																			40,
																			40);
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

/*
 * $(function() { $('#btnPrint').on('click', function (event) {
 * console.log("click_type"); }) });
 */
/*
 * document.getElementById('btnPrint').addEventListener('click', function() {
 * console.log("click_type");
 * 
 * });
 */
/*
 * var layerSwitcher = new ol.control.LayerSwitcher({ tipLabel: 'Légende', //
 * Optional label for button groupSelectStyle: 'children' // Can be 'children'
 * [default], 'group' or 'none' }); map.addControl(layerSwitcher);
 */