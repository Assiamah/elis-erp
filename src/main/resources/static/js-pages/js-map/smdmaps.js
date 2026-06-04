$(document)
		.ready(
				function() {

					var lrd_point_coordinate_list;

					var lrd_click_type = 'MapClick';

					var smd_parcel_lrd_dataSource = new ol.source.TileWMS(
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

					var smd_lrd_parcels_dataLayer = new ol.layer.Tile({
						title : 'LRD Parcels Layer',
						source : smd_parcel_lrd_dataSource
					})

					var smd_cadastral_new_dataSource = new ol.source.TileWMS(
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

					var smd_cadastral_new_dataLayer = new ol.layer.Tile({
						title : 'SMD Cadastral Layer',
						source : smd_cadastral_new_dataSource

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

					var smd_grid_lrd_dataSource = new ol.source.TileWMS(
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

					var smd_grid_lrd_dataLayer = new ol.layer.Tile({
						title : 'Grid',
						visible : false,
						source : smd_grid_lrd_dataSource

					})

					var smd_registration_district_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:registration_district',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var smd_registration_district_dataLayer = new ol.layer.Tile(
							{
								title : 'Registration District',
								visible : false,
								source : smd_registration_district_dataSource

							})

					// 104_modified_CR
					// DIST_03_01_A_modified

					var smd_StaticImage = new ol.layer.Image({
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

					smd_garro_search_result_searchLayer = new ol.layer.Vector({
						title : 'garro_search_result',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'pink',
								width : 3
							})
						})
					});

					smd_cro_search_result_searchLayer = new ol.layer.Vector({
						title : 'cro_search_result',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'orange',
								width : 3
							})
						})
					});

					smd_smd_current_search_result_searchLayer = new ol.layer.Vector(
							{
								title : 'smd_current_search_result',
								source : undefined,
								style : new ol.style.Style({
									stroke : new ol.style.Stroke({
										color : 'blue',
										width : 3
									})
								})
							});

					smd_smd_parcel_search_result_searchLayer = new ol.layer.Vector(
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

					smd_smd_cadastral_search_result_searchLayer = new ol.layer.Vector(
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

					smd_lrd_search_result_searchLayer = new ol.layer.Vector({
						title : 'lrd_search_result',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'green',
								width : 3
							})
						})
					});

					smd_lc_searchLayer = new ol.layer.Vector({
						title : 'Search Layer',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'red',
								width : 3
							})
						})
					});

					var smd_markers = new ol.layer.Vector({
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

					// var all_layers = [smdparcelsLayer,vectorLayer];
					// var all_layers = [smdparcelsLayer];
					// 

					// create a vector layer used for editing
					var smd_vector_layer = new ol.layer.Vector({
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

					var smd_features = new ol.Collection();
					var smd_featureOverlay = new ol.layer.Vector({
						source : new ol.source.Vector({
							features : smd_features
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

					var smd_googleLayerHybrid = new ol.layer.Tile(
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

					var smd_new_de = new ol.layer.Tile({
						title : "Open Street Map",
						// 'type': 'base',
						visible : false,
						source : new ol.source.OSM({
							wrapX : false
						}),
					// projection: 'EPSG:4326'
					})

					var smd_source = new ol.source.Vector({
						wrapX : false
					});

					var vector = new ol.layer.Vector({
						'type' : 'base',
						source : smd_source
					});

					var smd_projObj = new ol.proj.Projection({
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

					var smd_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
					var smd_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

					// console.log(firstProjection);
					// console.log(secondProjection);
					// proj4(firstProjection,secondProjection,[2,5]);
					// console.log(proj4(secondProjection,firstProjection,[2,5]));
					// ol.proj.proj4.register(proj4);
					// ol.proj.registerProj4(proj4);
					// register(proj4);

					var smd_proj27700 = ol.proj.get('EPSG:2136');
					// proj27700.setExtent([0, 0, 2011055.53818079,
					// 2360318.82691170]);
					smd_proj27700.setExtent([ 80935.4497355444,
							1209.0295731349593, 1711780.3060929566,
							2358523.124783509 ]);

					var smd_view_e = new ol.View({
						// center: ol.proj.fromLonLat([4.8, 47.75]),
						// center: ol.proj.transform([1187433.58822084,
						// 327091.107070208],
						// 'EPSG:4326','EPSG:3857'),
						projection : smd_projObj,
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

					var smd_map = new ol.Map({
						target : 'smd-map',
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
						view : smd_view_e
					});

					// map.addLayer(new_de);
					smd_map.addLayer(smd_googleLayerHybrid);
					smd_map.addLayer(smd_StaticImage);
					smd_map.addLayer(smd_registration_district_dataLayer);

					smd_map.addLayer(smd_grid_lrd_dataLayer);

					// smd_map.addLayer(smd_lrd_parcels_dataLayer);
					smd_map.addLayer(smd_smd_current_dataLayer);

					// smd_map.addLayer(smd_cadastral_new_dataLayer);

					smd_map.addLayer(smd_lc_searchLayer);
smd_map.addLayer(smd_markers);
					smd_map
							.on(
									'click',
									function(evt) {

										// $("#smdparcelinformation").modal();

										// click_type= 'DrawClick'
										var viewResolution = map.getView()
												.getResolution();
										var viewProjection = map.getView()
												.getProjection();

										if (lrd_click_type === 'DrawClick') {

										}
										if (lrd_click_type === 'MapClick') {

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

																	var table = $('#smd_more_than_one_parcel_Table');
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

																						smd_lc_searchLayer.setSource(new ol.source.Vector(
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

																						view.fit(smd_lc_searchLayer.getSource().getExtent());
																						smd_map.getView().fit(smd_lc_searchLayer
																												.getSource()
																												.getExtent(),
																										{size : map.getSize(),maxZoom : 16})

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
									});

					$("#addsmdtransaction")
							.on(
									"show.bs.modal",
									function(e) {
										var gid = $(e.relatedTarget).data(
												'target-id');

										console.log('gid');
										console.log(gid);

										$('#addsmdtransaction #smd_tr_t_id')
												.val([]);
										$('#addsmdtransaction #smd_tr_gid')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_reference_number')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_cc_number')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_regional_number')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_job_number')
												.val([]);

										$(
												'#addsmdtransaction #smd_tr_applicant_name')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_grantor_name')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_date_of_instument')
												.val([]);

										$(
												'#addsmdtransaction #smd_tr_type_instrument')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_consideration')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_certificate_number')
												.val([]);
										$('#addsmdtransaction #smd_tr_term')
												.val([]);
										$(
												'#addsmdtransaction #smd_tr_commencement_date')
												.val([]);
										$('#addsmdtransaction #smd_tr_purpose')
												.val([]);

										$(
												'#addsmdtransaction #smd_tr_plan_number')
												.val([]);
										$('#addsmdtransaction #smd_tr_remarks')
												.val([]);
												
												$(
												'#addsmdtransaction #smd_tr_modified_by')
												.val([]);
										$('#addsmdtransaction #smd_tr_modified_date')
												.val([]);

										var today = new Date();
										var dd = String(today.getDate())
												.padStart(2, '0');
										var mm = String(today.getMonth() + 1)
												.padStart(2, '0'); // January
										// is 0!
										var yyyy = today.getFullYear();

										today = mm + '/' + dd + '/' + yyyy;

										if (gid) {
											console
													.log('addsmdtransaction loading '
															+ 'valid ')
											console
													.log('addsmdtransaction loading '
															+ gid)

											$('#addsmdtransaction #smd_tr_gid')
													.val($('#smd_gid_p').val());
											$('#addsmdtransaction #smd_tr_t_id')
													.val(gid);

											/*
											 * $( '#addsmdtransaction
											 * #lrd_td_plotted_by_reg') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addsmdtransaction
											 * #lrd_td_checked_by') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addsmdtransaction
											 * #lrd_td_plott_date_reg')
											 * .val(today);
											 */
											// $('#addsmdtransaction
											// #lrd_td_job_numnber').val(job_number);
											$(
													'#addsmdtransaction #lrd_td_reference_number')
													.val(
											$('#lrd_ps_reference_number').val());

											$
													.ajax({
														type : "POST",
														url : 'Maps',
														data : {
															request_type : 'select_lc_spatial_objects_smd_transaction_by_gid',
															gid : gid
														},
														cache : false,
														beforeSend : function() {
															// $('#district').html('<img
															// src="img/loading.gif"
															// alt="" width="24"
															// height="24">');
														},
														success : function(
																serviceresponse) {

															var json_p = JSON
																	.parse(serviceresponse);
															console.log(json_p)

															$(json_p.data)
																	.each(
																			function() {

																				$(
																						'#addsmdtransaction #smd_tr_reference_number')
																						.val(
																								this.reference_number);
																				$(
																						'#addsmdtransaction #smd_tr_cc_number')
																						.val(
																								this.cc_number);
																				$(
																						'#addsmdtransaction #smd_tr_regional_number')
																						.val(
																								this.regional_number);

																				$(
																						'#addsmdtransaction #smd_tr_job_number')
																						.val(
																								this.job_number);
																				$(
																						'#addsmdtransaction #smd_tr_applicant_name')
																						.val(
																								this.applicant_name);
																				$(
																						'#addsmdtransaction #smd_tr_grantor_name')
																						.val(
																								this.grantor_name);
																				$(
																						'#addsmdtransaction #smd_tr_old_ref_number')
																						.val(
																								this.old_ref_number);
																				$(
																						'#addsmdtransaction #smd_tr_mul_claim')
																						.val(
																								this.mul_claim);
																				$(
																						'#addsmdtransaction #smd_tr_purpose')
																						.val(
																								this.purpose);

																				$(
																						'#addsmdtransaction #smd_tr_plan_number')
																						.val(
																								this.plan_number);
																				$(
																						'#addsmdtransaction #smd_tr_remarks')
																						.val(
																								this.remarks);
																								
																								
																								$(
																						'#addsmdtransaction #smd_tr_modified_by')
																						.val(
																								this.modified_by);
																				$(
																						'#addsmdtransaction #smd_tr_modified_date')
																						.val(
																								this.modified_date);

																			});

														}
													});

										} else {
											// console.log('addsmdtransaction
											// loading ' + 'not valid ')

											$('#addsmdtransaction #smd_tr_t_id')
													.val('0');
											$('#addsmdtransaction #smd_tr_gid')
													.val($('#smd_gid_p').val());
											$(
													'#addsmdtransaction #smd_tr_reference_number')
													.val([]);

											$(
													'#addsmdtransaction #smd_tr_reference_number')
													.val($('#smd_ref_no').val());

										}

										// document.write(today);

									});

					$('#btn_save_smd_transaction')
							.on(
									'click',
									function(e) {

										console.log('Assiamah');

										var gid = document
												.getElementById("smd_tr_gid").value;

										var t_id = document
												.getElementById("smd_tr_t_id").value;

										var reference_number = document
												.getElementById("smd_tr_reference_number").value;
										var cc_number = document
												.getElementById("smd_tr_cc_number").value;
										var regional_number = document
												.getElementById("smd_tr_regional_number").value;
										var job_number = document
												.getElementById("smd_tr_job_number").value;
										var applicant_name = document
												.getElementById("smd_tr_applicant_name").value;
										var grantor_name = document
												.getElementById("smd_tr_grantor_name").value;

										var old_ref_number = document
												.getElementById("smd_tr_old_ref_number").value;
										var mul_claim = document
												.getElementById("smd_tr_mul_claim").value;

										var purpose = document
												.getElementById("smd_tr_purpose").value;

										var plan_number = document
												.getElementById("smd_tr_plan_number").value;

										var remarks = document
												.getElementById("smd_tr_remarks").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'select_lc_spatial_objects_smd_transaction_add_update',
														reference_number : reference_number,
														cc_number : cc_number,
														regional_number : regional_number,
														job_number : job_number,
														applicant_name : applicant_name,
														grantor_name : grantor_name,
														old_ref_number : old_ref_number,
														mul_claim : mul_claim,
														purpose : purpose,
														plan_number : plan_number,
														remarks : remarks,
														fid_id_fk : gid,
														gid : t_id

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
														console.log(jobdetails)
														alert(jobdetails);

													}
												});

									});

					document.getElementById('smd_btn_show_location')
							.addEventListener(
									'click',
									function() {

										/*
										 * var radioValue = $(
										 * "input[name='interaction_type']:checked")
										 * .val();
										 * 
										 * if (radioValue) {
										 * 
										 * alert("Your are a - " + radioValue); }
										 * 
										 * 
										 */

										console.log('you');
										smd_markers.getSource().clear()
										var x_coordinate_mak = $(
												'#smd_x_coordinate_mak').val();
										var y_coordinate_mak = $(
												'#smd_y_coordinate_mak').val();

										var marker = new ol.Feature({
											geometry : new ol.geom.Point([
													x_coordinate_mak,
													y_coordinate_mak ])
										// dont worry about coordinate type 0,0
										// will be in west coast of
										// africa
										});
										// source.addFeature(marker);

										// smd_searchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.format.WKT()).readFeatures(polygon_tttt)}));
										// var marker = new ol.Feature(new
										// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
										// x_coordinate_mak])));
										smd_markers.getSource().addFeature(
												marker);

										// smd_searchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

										// view.fit(markers.getSource().getExtent());
										// var extent =
										// smd_searchLayer.getSource().getExtent();
										smd_map.getView().fit(
												smd_markers.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})
									});

					document
							.getElementById('smd_btn_visualise_coordinate')
							.addEventListener(
									'click',
									function() {

										var table = $('#coordinatelis_Table')
												.tableToJSON();
										// s console.log(table);
										// alert(JSON.stringify(table));
										var list_of_application_new = JSON
												.stringify(table);
										console.log(list_of_application_new);

										var json_p = JSON
												.parse(list_of_application_new);

										console.log(json_p);
										polygon = '';

										point_coordinate_list = '';

										var jsonArr = [];

										var counter = 0;
										var first_x_coordinate = '';
										var first_y_coordinate = '';
										$(json_p)
												.each(
														function() {

															/*
															 * if (counter=0){
															 * first_x_coordinate=this.x_coordinate ;
															 * first_y_coordinate=this.y_coordinate; }
															 */

															item = {}
															item["coordinate_name"] = this.name;
															item["x_coordinate"] = this.x_coordinate;
															item["y_coordinate"] = this.y_coordinate;

															jsonArr.push(item);
															polygon += this.y_coordinate
																	+ " "
																	+ this.x_coordinate
																	+ ", ";

															counter++;

														});

										polygon_real = "POLYGON((" + polygon
												+ "))";
										var first_coordinate = '';
										// first_coordinate = ", "+
										// first_y_coordinate + " "+
										// first_x_coordinate + "))";
										first_coordinate = ", "
												+ json_p[0].y_coordinate + " "
												+ json_p[0].x_coordinate + "))";

										console.log('first_coordinate');
										console.log(first_coordinate);
										// /grid.store.getAt(0).data.name
										var polygon_tttt = polygon_real
												.replace(', ))',
														first_coordinate);

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

										$('#smd_bl_wkt_polygon').val(
												polygon_tttt);
										// var wktplygonsearch =
										// $('#lc_fr_bl_wkt_polygon').val();
										// Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_smd]')[0].setValue(polygon_tttt);

										/*
										 * var format = new ol.format.WKT(); var
										 * feature = format.readFeature(
										 * 'POLYGON((1187149.88749177
										 * 321970.352529228,1187252.44828482
										 * 322000.51758416,1187278.49030434
										 * 321905.465328425,1187172.80418022
										 * 321877.68741487,1187149.88749177
										 * 321970.352529228))');
										 * feature.getGeometry().transform(projObj,'EPSG:4326');
										 * 
										 * var vectorwkt = new ol.layer.Vector({
										 * title: 'WKT Layer', source: new
										 * ol.source.Vector({ features:
										 * [feature] }) });
										 */

										smd_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(polygon_tttt)
														}));
										view.fit(smd_lc_searchLayer.getSource()
												.getExtent());

										smd_map.getView().fit(
												smd_lc_searchLayer.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})

									});

					document
							.getElementById('smd_btn_visualise_search')
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
															// smd_searchLayer.getSource().getFeatures().length;
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
															if (smd_current_search_result_searchLayer
																	.getSource() != null) {
																smd_current_search_result_searchLayer
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
																garro_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.garro)
																				}));
																/*
																 * var features =
																 * smd_searchLayer.getSource().getFeatures();
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
																cro_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.cro)
																				}));
															}
															if (json_p.smdcurrent === undefined
																	|| json_p.smdcurrent.features === null) {
															} else {
																smd_current_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.smdcurrent)
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
															view
																	.fit(smd_current_search_result_searchLayer
																			.getSource()
																			.getExtent());
															map
																	.getView()
																	.fit(
																			smd_current_search_result_searchLayer
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
							.getElementById('smd_btn_save_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("smd_bl_wkt_polygon").value;
										console.log(wktplygonsearch)

										$("#smdparcelinformationfirst").modal();

										$(
												'#smdparcelinformationfirst #smd_ref_no_f')
												.val([]);

										$(
												'#smdparcelinformationfirst #smd_land_size_f')
												.val([]);

										$(
												'#smdparcelinformationfirst #smd_wkt_polygon_f')
												.val(wktplygonsearch);

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'select_calculate_area_in_acres',

														wkt_polygon : wktplygonsearch
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
														console.log(jobdetails)
														// alert(jobdetails);

														$(
																'#smdparcelinformationfirst #smd_land_size_f')
																.val(jobdetails);

													}
												});

									});

					$("#btn_save_smd_parcel_details_f")
							.click(
									function(event) {

										var wktplygonsearch = document
												.getElementById("smd_wkt_polygon_f").value;

										/*
										 * var lrd_glpin = document
										 * .getElementById("lrd_glpin").value;
										 */

										var locality = document
												.getElementById("smd_locality_f").value;

										var remarks = '';

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'select_lc_spatial_objects_smd_save',
														wkt_polgon : wktplygonsearch,
														certificate_number : '',

														locality : locality,
														remarks : remarks
													},
													cache : false,

													success : function(
															jobdetails) {
														console.log(jobdetails)

														var json_p = JSON
																.parse(jobdetails);

														/*
														 * $(
														 * "#pvlmdparcelinformation")
														 * .modal();
														 */

														$(
																'#smdparcelinformationfirst #smd_gid_f')
																.val(json_p.gid);
														$(
																'#smdparcelinformationfirst #smd_ref_no_f')
																.val(
																		json_p.reference_number);

														// $("#btn_save_lrd_parcel_details_fts_with_info")
														document
																.getElementById("btn_save_smd_parcel_details_f").disabled = true;
														alert('Parcel Successfully Saved')
													}
												});

									});

					document
							.getElementById('btn_save_smd_parcel_details')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v

										var gid = document
												.getElementById("smd_gid_p").value;

										var smd_cc_number = document
												.getElementById("smd_cc_number").value;
										var smd_reg_no = document
												.getElementById("smd_reg_no").value;

										var smd_a_name = document
												.getElementById("smd_a_name").value;
										var smd_job_number = document
												.getElementById("smd_job_number").value;

										/*
										 * var plot_number = document
										 * .getElementById("smd_plot_number").value;
										 */
										var smd_locality = document
												.getElementById("smd_locality").value;

										var smd_plan_no = document
												.getElementById("smd_plan_no").value;
										var smd_remarks = document
												.getElementById("smd_remarks").value;

										var smd_mul_claim = document
												.getElementById("smd_mul_claim").value;

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'select_update_smd_parcels',
														gid : gid,
														wkt_polygon : smd_wkt_polygon,
														cc_number : smd_cc_number,
														reg_no : smd_reg_no,
														a_name : smd_a_name,
														job_number : smd_job_number,
														locality : smd_locality,
														plan_no : smd_plan_no,
														mul_claim : smd_mul_claim,
														remarks : smd_remarks
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
														console.log(jobdetails)
														alert(jobdetails);

														var json_p = JSON
																.parse(jobdetails);
														$(
																"#smdparcelinformation")
																.modal();

														$(
																'#smdparcelinformation #smd_gid_p')
																.val(json_p.gid);
														$(
																'#smdparcelinformation #smd_ref_no')
																.val(
																		json_p.reference_number);

													}
												});

									});

					document
							.getElementById('smd_btn_visualise_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										// console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("smd_bl_wkt_polygon").value;
										console.log(wktplygonsearch)
										smd_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(wktplygonsearch)
														}));
										smd_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.GeoJSON())
																	.readFeatures(json_p.parcels)
														}));

										view.fit(smd_lc_searchLayer.getSource()
												.getExtent());
										smd_map.getView().fit(
												smd_lc_searchLayer.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})

									});

					document
							.getElementById(
									'smd_btn_search_by_reference_number')
							.addEventListener(
									'click',
									function() {

										var search_text = $(
												'#smd_search_by_text').val();
										console.log(search_text)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													data : {
														request_type : 'select_search_smd_parcles_by_other_number',
														vr_search_text : search_text
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
															// lrd_smd_searchLayer.getSource().getFeatures().length;
															// console.log(featureCount);

															if (smd_lc_searchLayer
																	.getSource() != null) {
																smd_lc_searchLayer
																		.getSource()
																		.clear();
															}

															if (json_p.parcels === undefined
																	|| json_p.parcels.features === null) {

															} else {
																smd_lc_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.parcels)
																				}));

															}

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

					// smd_btn_search_for_scanned_maps

					$('#smd_scale_value').change(
							function() {
								// alert($(this).val());
								$('#smd_scale_value_e').val($(this).val());
								var view = smd_map.getView();
								view.setResolution(ol.proj.getPointResolution(
										view.getProjection(),
										getResolutionFromScale($(this).val()),
										view.getCenter()));
								click_map_zoom_value = false;

							});
					// 

					var click_map_zoom_value = true;
					document
							.getElementById('smd_btn_scale_zoom')
							.addEventListener(
									'click',
									function() {

										var scale_value = $(
												'#smd_scale_value_e').val();
										var view = smd_map.getView();
										view
												.setResolution(ol.proj
														.getPointResolution(
																view
																		.getProjection(),
																getResolutionFromScale(scale_value),
																view
																		.getCenter()));
										click_map_zoom_value = false;
									});

					document
							.getElementById('smd_lockmapscale')
							.addEventListener(
									'click',
									function() {
										/*
										 * map.getInteractions().forEach(function(interaction) {
										 * if (interaction instanceof
										 * ol.interaction.MouseWheelZoom) {
										 * interaction.setActive(false); } },
										 * this);
										 */
										// console.log('Namekkjksd');
										if (document
												.getElementById("smd_lockmapscale").checked) {

											// ol.interaction.DoubleClickZoom
											// ol.interaction.MouseWheelZoom

											var MouseWheelZoomClickInteraction;
											// find DoubleClickZoom interaction
											smd_map
													.getInteractions()
													.getArray()
													.forEach(
															function(
																	interaction) {
																if (interaction instanceof ol.interaction.MouseWheelZoom) {
																	MouseWheelZoomClickInteraction = interaction;
																}
															});
											// remove from map
											smd_map
													.removeInteraction(MouseWheelZoomClickInteraction);

											var dblClickInteraction;
											// find DoubleClickZoom interaction
											smd_map
													.getInteractions()
													.getArray()
													.forEach(
															function(
																	interaction) {
																if (interaction instanceof ol.interaction.DoubleClickZoom) {
																	dblClickInteraction = interaction;
																}
															});
											// remove from map
											smd_map
													.removeInteraction(dblClickInteraction);

										} else {

											dblClickInteraction = new ol.interaction.DoubleClickZoom(
													{
														delta : 0
													});
											smd_map
													.addInteraction(dblClickInteraction);

											MouseWheelZoomClickInteraction = new ol.interaction.MouseWheelZoom(
													{
														delta : 0
													});
											smd_map
													.addInteraction(MouseWheelZoomClickInteraction);

										}

									});

					document
							.getElementById(
									'smd_btn_load_for_scanned_maps_by_point')
							.addEventListener(
									'click',
									function() {

										console.log('kkkkk');

										var x_coordinate_mak = $(
												'#smd_x_coordinate').val();
										var y_coordinate_mak = $(
												'#smd_y_coordinate').val();

										polygon = x_coordinate_mak + " "
												+ y_coordinate_mak;

										polygon_real = "POINT(" + polygon + ")";

										$
												.ajax({
													type : "POST",
													url : "Maps",
													data : {
														request_type : 'search_for_smd_scan_map_for_a_point',
														wkt_polygon : polygon_real
													},
													cache : false,
													success : function(
															jobdetails) {

														var json_p = JSON
																.parse(jobdetails);
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

					document
							.getElementById('smd_btn_search_for_scanned_maps')
							.addEventListener(
									'click',
									function() {

										console.log('kkkkk');

										// var wkt_polygon =
										// $('#smd_txt_wkt_polygon').val();

										var wkt_polygon_k = $.trim($(
												"#smd_bl_wkt_polygon").val());
										var wkt_polygon = document
												.getElementById("smd_bl_wkt_polygon").value;
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
							.getElementById('smd_btn_load_for_scanned_maps')
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

										smd_StaticImage.setSource(image_source);

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

										lrd_map.getView().fit(new_extent,
												lrd_map.getSize());

										// map.getView().fit(new_extent,
										// map.getSize());

										/*
										 * lrd_map.getView().fit(new_extent, {
										 * size : lrd_map.getSize(), maxZoom :
										 * 16 })
										 */

									});

					$('#smdparcelinformation')
							.on(
									'show.bs.modal',
									function(e) {



 									var table_bp = $('#coordinatelis_Table');
										table_bp.find("tbody tr").remove();



										var parcel_uuid = $(e.relatedTarget)
												.data('parcel_uuid');
										var reference_number = $(
												e.relatedTarget).data(
												'reference_number');

										console.log(parcel_uuid);
										console.log(reference_number);
										/*
										 * remarks, sheet_number, file_number,
										 * property_number, reference_number,
										 * locality, plot_number, cro_reference,
										 * nt_number, parcel_uuid
										 */

										$('#smdparcelinformation #smd_gid_p')
												.val(parcel_uuid);

										$('#smdparcelinformation #smd_ref_no')
												.val(
														$(e.relatedTarget)
																.data(
																		'reference_number'));

										$('#smdparcelinformation #smd_locality')
												.val(
														$(e.relatedTarget)
																.data(
																		'locality'));

										$(
												'#smdparcelinformation #smd_plotted_by')
												.val(
														$(e.relatedTarget)
																.data(
																		'plotted_by'));

										$(
												'#smdparcelinformation #smd_date_plott')
												.val(
														$(e.relatedTarget)
																.data(
																		'date_plott'));

										$(
												'#smdparcelinformation #type_of_plotting')
												.val(
														$(e.relatedTarget)
																.data(
																		'type_of_plotting'));

										$('#smdparcelinformation #acreage').val($(e.relatedTarget).data('acreage'));
										$('#smdparcelinformation #modified_by').val($(e.relatedTarget).data('modified_by'));
										$('#smdparcelinformation #modified_date').val($(e.relatedTarget).data('modified_date'));

										var table = $('#smd_transaction_dataTable');
										table.find("tbody tr").remove();
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

													},
													success : function(
															serviceresponse) {

														var json_p = JSON
																.parse(serviceresponse);
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

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														$('#smd_bl_wkt_polygon')
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

										var table_docs = $('#lrd_scanned_documents_dataTable');
										table_docs.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'LoadLRDJackets',
													data : {
														request_type : 'load_lrd_jacket_certificate',
														certificate_number : reference_number
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

									});

			
										
										
											$('#smd_btn_search_transaction')
							.on(
									'click',
									function(e) {

										var reference_number = $(
												'#smd_search_transaction_by_text')
												.val();

										var table = $('#smd_transaction_all_dataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'smd_transaction_select_by_reference_number',
														reference_number : reference_number,
														gid_fk : 0
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
														console.log(json_p)

														$(json_p.data)
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

																							+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addsmdtransactionlong" data-target-id="'
																							+ this.t_id
																							+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																							+ "</tr>");
																		});

													}
												});
									});

					document
							.getElementById('smd_btnprintmap')
							.addEventListener(
									'click',
									function() {
										console.log("click_type");

										var wktplygonsearch = $(
												'#smd_bl_wkt_polygon').val();

										// wktplygonsearch
										// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_smd]')[0].getValue();

										var canvas = document.getElementById(
												"smd-map")
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
										doc.text(60, 200, 'smd Current Parcel')

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

														if (json_p !== undefined
																|| json_p !== null) {
															// var featureCount
															// =
															// smd_searchLayer.getSource().getFeatures().length;
															// console.log(featureCount);

															// if
															// (lc_searchLayer.getSource()
															// !=
															// null )
															// {lc_searchLayer.getSource().clear();}

															if (json_p.garro === undefined
																	|| json_p.garro === null) {

																doc.addPage(
																		'a4',
																		'l');
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
																// smd_searchLayer.setSource(new
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
																// smd_searchLayer.setSource(new
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

																var columns = [
																		{
																			title : "LS Number",
																			dataKey : "ls_number"
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

															if (json_p.smdcurrent === undefined
																	|| json_p.smdcurrent === null) {

																var data_rows = [ {
																	main_description : 'No Recorded Transaction'
																} ];
																var columns = [ {
																	title : 'smd Current Layer',
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
																// smd_searchLayer.setSource(new
																// ol.source.Vector({features:
																// (new
																// ol.format.GeoJSON()).readFeatures(json_p.cro)}));
																// doc.addPage('a4',
																// 'l');
																// doc.setFontSize(12)
																// doc.text(20,
																// 30,
																// 'smd
																// Current
																// Layer')

																transaction_data = json_p.smdcurrent;

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
																// smd_searchLayer.setSource(new
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
																// smd_searchLayer.setSource(new
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
																// smd_searchLayer.setSource(new
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
															// view.fit(smd_searchLayer.getSource().getExtent());
															// map.getView().fit(smd_searchLayer.getSource().getExtent(),
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

					function getResolutionFromScale(scale) {
						var units = smd_map.getView().getProjection()
								.getUnits();
						var dpi = 25.4 / 0.28;
						var mpu = ol.proj.METERS_PER_UNIT[units];
						var resolution = scale / (mpu * 39.37 * dpi);
						return resolution;
					}

				});