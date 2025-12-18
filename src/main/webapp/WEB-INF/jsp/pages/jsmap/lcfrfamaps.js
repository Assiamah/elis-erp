$(document)
		.ready(
				function() {

					var lcfrfamaps_parcel_lrd_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_lrd_parcels_dataLayer = new ol.layer.Tile({
						title : 'LRD Parcels Layer',
						source : lcfrfamaps_parcel_lrd_dataSource

					})

					var lcfrfamaps_parcels_smd_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_parcels_smd_dataLayer = new ol.layer.Tile({
						title : 'SMD Parcels Layer',
						source : lcfrfamaps_parcels_smd_dataSource

					})

					var lcfrfamaps_cadastral_smd_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_cadastral_smd_dataLayer = new ol.layer.Tile(
							{
								title : 'SMD Cadastral Layer',
								source : lcfrfamaps_cadastral_smd_dataSource

							})

					var lcfrfamaps_garro_parcels_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_garro_parcels_dataLayer = new ol.layer.Tile(
							{
								title : 'Existing GARRO Layer',
								// visible: false,
								source : lcfrfamaps_garro_parcels_dataSource

							})

					var lcfrfamaps_cro_sp_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_cro_parcels_dataLayer = new ol.layer.Tile({
						title : 'Existing CRO Layer',
						// visible: false,
						source : lcfrfamaps_cro_sp_dataSource

					})

					var lcfrfamaps_pvlmd_current_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_pvlmd_current_dataLayer = new ol.layer.Tile(
							{
								title : 'PVLMD Current Layer',
								// visible: false,
								source : lcfrfamaps_pvlmd_current_dataSource

							})

					var lcfrfamaps_grid_lrd_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_grid_lrd_dataLayer = new ol.layer.Tile({
						title : 'Grid',
						visible : false,
						source : lcfrfamaps_grid_lrd_dataSource

					})

					var lcfrfamaps_registration_district_dataSource = new ol.source.TileWMS(
							{
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

					var lcfrfamaps_registration_district_dataLayer = new ol.layer.Tile(
							{
								title : 'Registration District',
								visible : false,
								source : lcfrfamaps_registration_district_dataSource

							})

					// 104_modified_CR
					// DIST_03_01_A_modified

					var lcfrfamaps_StaticImage = new ol.layer.Image({
						title : 'Scanned Map',
						// extent: [-13884991, 2870341, -7455066, 6338219],
						visible : true,
						source : undefined,
					/*
					 * source: new ol.source.ImageWMS({ url:
					 * getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					 * params: {'LAYERS': 'csau_geospatial:104_modified_CR'},
					 * serverType: 'geoserver', })
					 */
					});

					lcfrfamaps_garro_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'garro_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'pink',
										width : 3
									})
								})
							});

					lcfrfamaps_cro_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'cro_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'orange',
										width : 3
									})
								})
							});

					lcfrfamaps_pvlmd_current_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'pvlmd_current_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'blue',
										width : 3
									})
								})
							});

					lcfrfamaps_smd_parcel_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'smd_parcel_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'purple',
										width : 3
									})
								})
							});

					lcfrfamaps_smd_cadastral_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'smd_cadastral_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'brown',
										width : 3
									})
								})
							});

					lcfrfamaps_lrd_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'lrd_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'green',
										width : 3
									})
								})
							});

					lcfrfamaps_lc_searchLayer = new ol.layer.Vector({
						title : 'Search Layer',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'red',
								width : 3
							})
						})
					});

					var lcfrfamaps_markers = new ol.layer.Vector({
						// title: 'Markers',
						source : new ol.source.Vector(),
					// style: iconStyle

					/*
					 * new ol.style.Style({
					 * 
					 * image: new ol.style.Icon({ anchor: [0.5, 1], src:
					 * 'marker.png' }) })
					 */
					});

					// var all_layers = [vectorwkt];

					var london = ol.proj.fromLonLat([ -0.12755, 51.507222 ]), istanbul = ol.proj
							.fromLonLat([ 28.9744, 41.0128 ]), view = new ol.View(
							{
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

					var lcfrfamaps_googleLayerHybrid = new ol.layer.Tile(
							{
								title : "Google Satellite & Roads",
								// 'type': 'base',
								visible : false,
								'opacity' : 1.000000,
								source : new ol.source.XYZ(
										{
											attributions : [ new ol.Attribution(
													{
														html : '<a href=""></a>'
													}) ],
											url : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
										}),
							});

					var lcfrfamaps_new_de = new ol.layer.Tile({
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

					var lcfrfamaps_projObj = new ol.proj.Projection({
						// code: 'EPSG:3857',
						code : 'EPSG:2136',
						extent : [ 80935.4497355444, 1209.0295731349593,
								1711780.3060929566, 2358523.124783509 ],
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

					var lcfrfamaps_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
					var lcfrfamaps_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

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
					proj27700.setExtent([ 80935.4497355444, 1209.0295731349593,
							1711780.3060929566, 2358523.124783509 ]);

					var lcfrfamaps_view_e = new ol.View({
						// center: ol.proj.fromLonLat([4.8, 47.75]),
						// center: ol.proj.transform([1187433.58822084,
						// 327091.107070208],
						// 'EPSG:4326','EPSG:3857'),
						projection : lcfrfamaps_projObj,
						// projection: 'EPSG:2136',
						// center: ol.proj.fromLonLat([1187433.58822084,
						// 327091.107070208],
						// projObj),
						// center: [956164.35527782, 584176.05990338],
						center : [ 1187433.58822084, 327091.107070208 ],
						// extent:projObj.getExtent(),
						extent : ol.proj.get('EPSG:2136').getExtent(),
						scales : [ 100000, 250000, 500000, 1000000, 2000000,
								4000000, 8000000 ],
						zoom : 12
					})

					var lcfrfamaps_map = new ol.Map({
						target : 'lcfrfa-map',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
								/*
								 * new ol.control.MousePosition({
								 * coordinateFormat: ol.coordinate.toStringHDMS,
								 * }),
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
								new ol.control.ZoomSlider(),
										new ol.control.Attribution(),
										new ol.control.MousePosition(),
										new ol.control.ZoomToExtent(),
										new ol.control.FullScreen()
								// ,mousePositionControl

								]),
						renderer : 'canvas',
						layers : [ new ol.layer.Tile({
							title : 'Open Street',
							source : new ol.source.OSM()
						}) ],
						view : lcfrfamaps_view_e
					});

					// map.addLayer(new_de);
					lcfrfamaps_map.addLayer(lcfrfamaps_googleLayerHybrid);
					lcfrfamaps_map.addLayer(lcfrfamaps_StaticImage);
					lcfrfamaps_map
							.addLayer(lcfrfamaps_registration_district_dataLayer);

					lcfrfamaps_map.addLayer(lcfrfamaps_grid_lrd_dataLayer);

					// map.addLayer(beacon_lrd_dataLayer);

					lcfrfamaps_map.addLayer(lcfrfamaps_lrd_parcels_dataLayer);
					lcfrfamaps_map.addLayer(lcfrfamaps_parcels_smd_dataLayer);
					lcfrfamaps_map.addLayer(lcfrfamaps_cadastral_smd_dataLayer);
					lcfrfamaps_map.addLayer(lcfrfamaps_pvlmd_current_dataLayer);
					lcfrfamaps_map.addLayer(lcfrfamaps_cro_parcels_dataLayer);
					lcfrfamaps_map.addLayer(lcfrfamaps_garro_parcels_dataLayer);

					lcfrfamaps_map
							.addLayer(lcfrfamaps_garro_search_result_searchLayer);
					lcfrfamaps_map
							.addLayer(lcfrfamaps_cro_search_result_searchLayer);
					lcfrfamaps_map
							.addLayer(lcfrfamaps_pvlmd_current_search_result_searchLayer);
					lcfrfamaps_map
							.addLayer(lcfrfamaps_smd_parcel_search_result_searchLayer);
					lcfrfamaps_map
							.addLayer(lcfrfamaps_smd_cadastral_search_result_searchLayer);
					lcfrfamaps_map
							.addLayer(lcfrfamaps_lrd_search_result_searchLayer);

					lcfrfamaps_map.addLayer(lcfrfamaps_lc_searchLayer);

					document
							.getElementById(
									'btn_lcfrfa_lc_btn_visualise_search')
							.addEventListener(
									'click',
									function() {

										var wktplygonsearch = $(
												'#lc_bl_wkt_polygon').val();
										var request = new XMLHttpRequest();
										/*
										 * var params = '{"vr_polygon":"'+
										 * wktplygonsearch
										 * +'","request_type":"select_consolidated_internal_search_report_geom"}';
										 * 
										 * request.onreadystatechange =
										 * function() { if (this.readyState == 4 &&
										 * this.status == 200) {
										 * console.log(this.responseText); //
										 * var json =this.responseText; //
										 * insert_parceldata(this.responseText); } };
										 * 
										 * request.open('POST',
										 * 'Case_Management_Serv', true);
										 * //request.setRequestHeader('api-key',
										 * 'your-api-key');
										 * request.setRequestHeader("Content-type",
										 * "application/json");
										 * request.send(params);
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
													success : function(
															jobdetails) {

														var json_p = JSON
																.parse(jobdetails);
														console.log(json_p)
														/*
														 * $(json_p.milestones).each(function () {
														 * 
														 * 
														 * });
														 */

														if (json_p !== undefined
																|| json_p !== null) {
															// var featureCount
															// =
															// pvlmd_searchLayer.getSource().getFeatures().length;
															// console.log(featureCount);

															if (garro_search_result_searchLayer
																	.getSource() != null) {
																garro_search_result_searchLayer
																		.getSource()
																		.clear();
															}
															if (cro_search_result_searchLayer
																	.getSource() != null) {
																cro_search_result_searchLayer
																		.getSource()
																		.clear();
															}
															if (pvlmd_current_search_result_searchLayer
																	.getSource() != null) {
																pvlmd_current_search_result_searchLayer
																		.getSource()
																		.clear();
															}
															if (smd_parcel_search_result_searchLayer
																	.getSource() != null) {
																smd_parcel_search_result_searchLayer
																		.getSource()
																		.clear();
															}
															if (smd_cadastral_search_result_searchLayer
																	.getSource() != null) {
																smd_cadastral_search_result_searchLayer
																		.getSource()
																		.clear();
															}
															if (lrd_search_result_searchLayer
																	.getSource() != null) {
																lrd_search_result_searchLayer
																		.getSource()
																		.clear();
															}

															if (json_p.garro === undefined
																	|| json_p.garro.features === null) {

															} else {
																lcfrfamaps_garro_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.garro)
																				}));
																/*
																 * var features =
																 * pvlmd_searchLayer.getSource().getFeatures();
																 * for (var i in
																 * features) {
																 * var feature =
																 * features[i];
																 * //var
																 * featureName =
																 * feature.get('valuation_number');
																 * feature.setStyle(styleFunction(feature));
																 * var
																 * fls_number =
																 * feature.get('cc_numb');
																 * feature.setStyle(styleFunction(fls_number)); }
																 */

															}
															if (json_p.cro === undefined
																	|| json_p.cro.features === null) {
															} else {
																lcfrfamaps_cro_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.cro)
																				}));
															}
															if (json_p.pvlmdcurrent === undefined
																	|| json_p.pvlmdcurrent.features === null) {
															} else {
																lcfrfamaps_pvlmd_current_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.pvlmdcurrent)
																				}));
															}

															if (json_p.smd_parcels === undefined
																	|| json_p.smd_parcels.features === null) {
															} else {
																lcfrfamaps_smd_parcel_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.smd_parcels)
																				}));
															}
															if (json_p.smd_cadastral === undefined
																	|| json_p.smd_cadastral.features === null) {
															} else {
																lcfrfamaps_smd_cadastral_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.smd_cadastral)
																				}));
															}
															if (json_p.lrd === undefined
																	|| json_p.lrd.features === null) {
															} else {
																lcfrfamaps_lrd_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.lrd)
																				}));
															}
															view
																	.fit(lcfrfamaps_pvlmd_current_search_result_searchLayer
																			.getSource()
																			.getExtent());
															lcfrfamaps_map
																	.getView()
																	.fit(
																			lcfrfamaps_pvlmd_current_search_result_searchLayer
																					.getSource()
																					.getExtent(),
																			{
																				size : map
																						.getSize(),
																				maxZoom : 16
																			})

														} else {
															/*
															 * Ext.Msg.show({
															 * title:'Error!',
															 * msg: "Error in
															 * loading data",
															 * icon:
															 * Ext.Msg.ERROR,
															 * buttons:
															 * Ext.Msg.OK })
															 */
														}

													}
												});
									});

					document
							.getElementById('btn_lcfrfa_lc_btn_visualise_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										// console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = $(
												'#lc_bl_wkt_polygon').val();
										console.log(wktplygonsearch)

										lcfrfamaps_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(wktplygonsearch)
														}));
										// view.fit(pvlmd_searchLayer.getSource().getExtent());
										console.log(wktplygonsearch)

										var extent = lcfrfamaps_lc_searchLayer
												.getSource().getExtent();
										lcfrfamaps_map.getView().fit(extent, {
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

					document
							.getElementById('btn_lcfrfa_lc_btnprintmap')
							.addEventListener(
									'click',
									function() {
										console.log("click_type");

										var wktplygonsearch = $(
												'#lc_bl_wkt_polygon').val();

										// wktplygonsearch
										// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();

										var canvas = document.getElementById(
												"lcfrfa-map")
												.getElementsByClassName(
														"ol-unselectable")[0];
										var img = canvas.toDataURL("image/png");

										// var canvas = event.context.canvas;
										// var data =
										// canvas.toDataURL('image/jpeg');
										var doc = new jsPDF('portrait',
												undefined, 'a4');
										// var doc = new jsPDF('landscape',
										// undefined, 'a4');
										doc
												.setProperties({
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
										doc.text(80, 35,
												'INTERNAL SEARCH REPORT')

										// doc.setFontSize(20)
										// doc.text(35, 50, 'Assembly: ' +
										// vr_assemby_code + '
										// Division: ' + vr_division + ' Block:
										// ' + vr_block)

										/*
										 * doc.setFont("courier");
										 * doc.setFontType("normal");
										 * doc.text(20, 30, 'This is courier
										 * normal.');
										 * 
										 * doc.setFont("times");
										 * doc.setFontType("italic");
										 * doc.text(20, 40, 'This is times
										 * italic.');
										 * 
										 * doc.setFont("helvetica");
										 * doc.setFontType("bold"); doc.text(20,
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

										doc.addImage(img, 'JPEG', 20, 60, 160,
												80);

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
										doc.text(60, 180,
												'Existing GARRO Parcel')

										doc.setDrawColor(255, 165, 0); // draw
										// red
										// lines
										doc.setLineWidth(1.5);
										doc.line(15, 190, 50, 190);
										doc
												.text(60, 190,
														'Existing CRO Parcel')

										doc.setDrawColor(0, 0, 255); // draw
										// red
										// lines
										doc.setLineWidth(1.5);
										doc.line(15, 200, 50, 200);
										doc.text(60, 200,
												'PVLMD Current Parcel')

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
										doc
												.text(60, 240,
														'Parcel Undergoing Registration')

										doc.setFontSize(10)
										doc.setFont("courier");
										doc.setFontType("bolditalic");

										/*
										 * var splitTitle =
										 * doc.splitTextToSize(wkt_polgon_for_search,
										 * 180); doc.text(20, 210, splitTitle);
										 * 
										 * var splitTitle =
										 * doc.splitTextToSize(wkt_polgon_for_search,
										 * 180); doc.text(20, 220, splitTitle);
										 * 
										 * var splitTitle =
										 * doc.splitTextToSize(wkt_polgon_for_search,
										 * 180); doc.text(20, 230, splitTitle);
										 * 
										 * 
										 * var splitTitle =
										 * doc.splitTextToSize(wkt_polgon_for_search,
										 * 180); doc.text(20, 240, splitTitle);
										 * 
										 * 
										 * 
										 * 
										 * 
										 */

										var splitTitle = doc.splitTextToSize(
												wktplygonsearch, 180);
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
													success : function(
															jobdetails) {

														var json_p = JSON
																.parse(jobdetails);
														console.log(json_p)
														// $(json_p.milestones).each(function
														// () {

														// });

														doc.addPage('a4', 'l');

														if (json_p !== undefined
																|| json_p !== null) {
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

																doc
																		.autoTable(
																				columns,
																				data_rows,
																				{
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

																var columns = [
																		{
																			title : "Property No",
																			dataKey : "prop_no"
																		},
																		{
																			title : "Instrument Date",
																			dataKey : "instrument_date"
																		},
																		{
																			title : "Instrument Type",
																			dataKey : "instrument_type"
																		},
																		{
																			title : "Grantor",
																			dataKey : "party1_plaintiff"
																		},
																		{
																			title : "Grantee",
																			dataKey : "party2_defendant"
																		},
																		{
																			title : "Term",
																			dataKey : "term"
																		},
																		{
																			title : "Commencement Date",
																			dataKey : "commencement_date"
																		}

																];

																console
																		.log(transaction_data);

																var rows = transaction_data;
																// Only pt
																// supported
																// (not mm or
																// in)
																// var doc = new
																// jsPDF('p',
																// 'pt');
																/*
																 * doc
																 * .autoTable(
																 * columns,
																 * rows, {
																 * 
																 * margin : {
																 * top : 35 },
																 * addPageContent :
																 * function(
																 * data) {
																 * doc.text( "",
																 * 40, 40); }
																 * });
																 */

																doc
																		.text(
																				20,
																				30,
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
																 * doc.addPage('a4',
																 * 'l');
																 * doc.setFontSize(12)
																 * doc.text(20,
																 * 30, 'Existing
																 * CRO Data')
																 * doc.text(20,
																 * 40, 'No
																 * Recorded
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

																var columns = [
																		{
																			title : "General Number",
																			dataKey : "general_no"
																		},
																		{
																			title : "Instrument Date",
																			dataKey : "instrument_date"
																		},
																		{
																			title : "Instrument Type",
																			dataKey : "instrument_type"
																		},
																		{
																			title : "Grantor",
																			dataKey : "party1_plaintiff"
																		},
																		{
																			title : "Grantee",
																			dataKey : "party2_defendant"
																		},
																		{
																			title : "Term",
																			dataKey : "term"
																		},
																		{
																			title : "Commencement Date",
																			dataKey : "commencement_date"
																		}

																];
																console
																		.log(transaction_data);

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
																				"Existing CRO Data",
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

																var columns = [
																		{
																			title : "Reference No",
																			dataKey : "reference_number_p"
																		},
																		{
																			title : "Instrument Date",
																			dataKey : "instrument_date"
																		},
																		{
																			title : "Instrument Type",
																			dataKey : "instrument_type"
																		},
																		{
																			title : "Grantor",
																			dataKey : "party1_plaintiff"
																		},
																		{
																			title : "Grantee",
																			dataKey : "party2_defendant"
																		},
																		{
																			title : "Term",
																			dataKey : "term"
																		},
																		{
																			title : "Commencement Date",
																			dataKey : "commencement_date"
																		}

																];
																console
																		.log(transaction_data);

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
																				"PVLMD Current Layer",
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
																		.text(
																				20,
																				30,
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
																		},
																		{
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

																console
																		.log(transaction_data);

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
																				"SMD Parcel Layer",
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
																		},
																		{
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

																console
																		.log(transaction_data);

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
																				"SMD Cadastral Layer",
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

																var columns = [
																		{
																			title : "Reference No.",
																			dataKey : "reference_number"
																		},
																		{
																			title : "Instrument Date",
																			dataKey : "date_of_instument"
																		},
																		{
																			title : "Instrument Type",
																			dataKey : "type_instrument"
																		},
																		{
																			title : "Garntor",
																			dataKey : "grantor_name"
																		},
																		{
																			title : "Applncant Name",
																			dataKey : "applicant_name"
																		},
																		{
																			title : "Term",
																			dataKey : "term"
																		},
																		{
																			title : "Commencement",
																			dataKey : "date_commencement"
																		}

																];

																console
																		.log(transaction_data);

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
																				'LRD Layer',
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

																var columns = [
																		{
																			title : "Job No.",
																			dataKey : "job_number"
																		},
																		{
																			title : "case_number",
																			dataKey : "Case Number"
																		},
																		{
																			title : "GLPIN",
																			dataKey : "glpin"
																		},
																		{
																			title : "Regional Number",
																			dataKey : "regional_number"
																		},
																		{
																			title : "locality",
																			dataKey : "locality"
																		},
																		{
																			title : "date_approved",
																			dataKey : "date_approved"
																		},
																		{
																			title : "land_size",
																			dataKey : "land_size"
																		}

																];

																console
																		.log(transaction_data);

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
															 * Ext.Msg.show({
															 * title:'Error!',
															 * msg: "Error in
															 * loading data",
															 * icon:
															 * Ext.Msg.ERROR,
															 * buttons:
															 * Ext.Msg.OK })
															 */
														}

													}
												});

									});


									document
							.getElementById('lrd_btn_search_for_scanned_maps')
							.addEventListener(
									'click',
									function() {

										console.log('kkkkk');

										// var wkt_polygon =
										// $('#lrd_txt_wkt_polygon').val();

										var wkt_polygon_k = $.trim($(
												"#lc_fr_bl_wkt_polygon").val());
										var wkt_polygon = document
												.getElementById("lc_fr_bl_wkt_polygon").value;
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
													success : function(
															jobdetails) {

														var json_p = JSON
																.parse(jobdetails);
														console.log('how come')
														console.log(result)
														/*
														 * $('#geoserverscannedimages_list')
														 * .append( '<option
														 * value="' +
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

					document
							.getElementById('lrd_btn_load_for_scanned_maps')
							.addEventListener(
									'click',
									function() {

										console.log('kkkkk');

										// var wkt_polygon =
										// $('#lrd_txt_wkt_polygon').val();

										var geoserverscannedimage = $.trim($(
												"#geoserverscannedimages_list")
												.val());
										/*
										 * var wkt_polygon = document
										 * .getElementById("lrd_txt_wkt_polygon").value;
										 */
										console.log('Scan Map');

										console.log(geoserverscannedimage);

										value_image_scan = geoserverscannedimage;
										only_layer = value_image_scan.split(
												":", 3);
										console.log(only_layer);
										value_image_scan1 = only_layer[1];
										// console.log(value_image_scan1);
										// all_parameters = {'LAYERS':
										// new_value_image_scan};
										// yyy= "104_modified_CR";
										layer_name = 'csau_geospatial' + ':'
												+ value_image_scan1,
												all_parameters = {
													'LAYERS' : layer_name
												};
										var image_source = new ol.source.ImageWMS(
												{
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

										lrd_StaticImage.setSource(image_source);

										var new_extent = null;
										extent_nnn = only_layer[2];
										new_extent = extent_nnn;
										console.log('new_extent');
										console.log(new_extent);
										// var extent = ol.extent.createEmpty();
										// StaticImage.setExtent(extent:new_extent);
										// var myExtent = [xmin,ymin,xmax,ymax];
										/*
										 * extent = [ 1173152.85826898,
										 * 342671.514293023, 1179683.69808146,
										 * 347057.607642237 ];
										 */

										lcfrfamaps_map.getView().fit(new_extent,
												lcfrfamaps_map.getSize());

										// map.getView().fit(new_extent,
										// map.getSize());

										/*
										 * lcfrfamaps_map.getView().fit(new_extent, {
										 * size : lcfrfamaps_map.getSize(), maxZoom :
										 * 16 })
										 */

									});
				});
