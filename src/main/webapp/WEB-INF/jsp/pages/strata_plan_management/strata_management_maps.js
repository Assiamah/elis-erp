$(document)
		.ready(
				function() {



				console.log('enter')		

					
					var stratacadastral_smd_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:gove_estates',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var stratacadastral_smd_dataLayer = new ol.layer.Tile({
						title : 'Government Estate Boundary',
						source : stratacadastral_smd_dataSource

					})

						
					

					var stratapvlmd_curstratadataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:gove_estates_parcels',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var stratapvlmd_curstratadataLayer = new ol.layer.Tile({
						title : 'Government Estate Parcels',
						// visible: false,
						source : stratapvlmd_curstratadataSource

					})

					var stratagrid_lrd_dataSource = new ol.source.TileWMS(
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

					var stratagrid_lrd_dataLayer = new ol.layer.Tile({
						title : 'LRD Grid',
						visible : false,
						source : stratagrid_lrd_dataSource

					})



					// 104_modified_CR
					// DIST_03_01_A_modified

					var strataStaticImage = new ol.layer.Image({
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

					

					stratalc_searchLayer = new ol.layer.Vector({
						title : 'Search Layer',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'red',
								width : 3
							})
						})
					});

					var stratamarkers = new ol.layer.Vector({
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
					var stratavector_layer = new ol.layer.Vector({
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

					var stratafeatures = new ol.Collection();
					var stratafeatureOverlay = new ol.layer.Vector({
						source : new ol.source.Vector({
							features : stratafeatures
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

					var stratagoogleLayerHybrid = new ol.layer.Tile(
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

					var stratanew_de = new ol.layer.Tile({
						title : "Open Street Map",
						// 'type': 'base',
						visible : false,
						source : new ol.source.OSM({
							wrapX : false
						}),
					// projection: 'EPSG:4326'
					})

					var stratasource = new ol.source.Vector({
						wrapX : false
					});

					var vector = new ol.layer.Vector({
						'type' : 'base',
						source : stratasource
					});

					var strataprojObj = new ol.proj.Projection({
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

					var stratafirstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
					var stratasecondProjection = '+proj=longlat +datum=WGS84 +no_defs';

					// console.log(firstProjection);
					// console.log(secondProjection);
					// proj4(firstProjection,secondProjection,[2,5]);
					// console.log(proj4(secondProjection,firstProjection,[2,5]));
					// ol.proj.proj4.register(proj4);
					// ol.proj.registerProj4(proj4);
					// register(proj4);

					var strataproj27700 = ol.proj.get('EPSG:2136');
					// proj27700.setExtent([0, 0, 2011055.53818079,
					// 2360318.82691170]);
					strataproj27700.setExtent([ 80935.4497355444,
							1209.0295731349593, 1711780.3060929566,
							2358523.124783509 ]);

					var strataview_e = new ol.View({
						// center: ol.proj.fromLonLat([4.8, 47.75]),
						// center: ol.proj.transform([1187433.58822084,
						// 327091.107070208],
						// 'EPSG:4326','EPSG:3857'),
						projection : strataprojObj,
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

					var strataview_pm = new ol.View({
						projection : strataprojObj,
						center : [ 1187433.58822084, 327091.107070208 ],
						extent : ol.proj.get('EPSG:2136').getExtent(),
						scales : [ 100000, 250000, 500000, 1000000, 2000000,
								4000000, 8000000 ],
						zoom : 12
					})

					var strataview_bm = new ol.View({
						projection : strataprojObj,
						center : [ 1187433.58822084, 327091.107070208 ],
						extent : ol.proj.get('EPSG:2136').getExtent(),
						scales : [ 100000, 250000, 500000, 1000000, 2000000,
								4000000, 8000000 ],
						zoom : 12
					})

					var strataview_fm = new ol.View({
						projection : strataprojObj,
						center : [ 1187433.58822084, 327091.107070208 ],
						extent : ol.proj.get('EPSG:2136').getExtent(),
						scales : [ 100000, 250000, 500000, 1000000, 2000000,
								4000000, 8000000 ],
						zoom : 12
					})

					var strataview_um = new ol.View({
						projection : strataprojObj,
						center : [ 1187433.58822084, 327091.107070208 ],
						extent : ol.proj.get('EPSG:2136').getExtent(),
						scales : [ 100000, 250000, 500000, 1000000, 2000000,
								4000000, 8000000 ],
						zoom : 12
					})

					var stratamap = new ol.Map({
						target : 'strata-map',
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
						view : strataview_e
					});

					// map.addLayer(new_de);
					stratamap.addLayer(stratagoogleLayerHybrid);
					//stratamap.addLayer(strataStaticImage);
					//stratamap.addLayer(strataregistration_district_dataLayer);

					//stratamap.addLayer(stratagrid_lrd_dataLayer);

					// map.addLayer(beacon_lrd_dataLayer);

					//stratamap.addLayer(stratalrd_parcels_dataLayer);
					//stratamap.addLayer(strataparcels_smd_dataLayer);
					stratamap.addLayer(stratacadastral_smd_dataLayer);
					stratamap.addLayer(stratapvlmd_curstratadataLayer);
					stratamap.addLayer(stratalc_searchLayer);



					var parcelmap = new ol.Map({
						target : 'map-1',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
										new ol.control.FullScreen()
								]),
						renderer : 'canvas',
						layers : [ new ol.layer.Tile({
							title : 'Open Street',
							source : new ol.source.OSM()
						}) ],
						view : strataview_pm
					});
					parcelmap.addLayer(stratagoogleLayerHybrid);

					var blockmap = new ol.Map({
						target : 'map-2',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
										new ol.control.FullScreen()
								]),
						renderer : 'canvas',
						layers : [ new ol.layer.Tile({
							title : 'Open Street',
							source : new ol.source.OSM()
						}) ],
						view : strataview_bm
					});
					blockmap.addLayer(stratagoogleLayerHybrid);

					var floormap = new ol.Map({
						target : 'map-3',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
										new ol.control.FullScreen()
								]),
						renderer : 'canvas',
						layers : [ new ol.layer.Tile({
							title : 'Open Street',
							source : new ol.source.OSM()
						}) ],
						view : strataview_fm
					});
					floormap.addLayer(stratagoogleLayerHybrid);

					var unit_flat_map = new ol.Map({
						target : 'map-4',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
										new ol.control.FullScreen()
								]),
						renderer : 'canvas',
						layers : [ new ol.layer.Tile({
							title : 'Open Street',
							source : new ol.source.OSM()
						}) ],
						view : strataview_um
					});
					unit_flat_map.addLayer(stratagoogleLayerHybrid);


					



					stratamap
							.on(
									'click',
									function(evt) {

										$("#pvlmdparcelinformation").modal();

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
											var url = stratapvlmd_curstratadataSource
													.getGetFeatureInfoUrl(
															evt.coordinate,
															viewResolution,
															viewProjection,
															{
																'INFO_FORMAT' : 'application/json',
																'propertyName' : 'gep_glpin,gep_locality,gep_land_size,gep_payment_status,gep_developed,gep_demand_note_served',
																'FEATURE_COUNT' : 50
															});

															

											var thislayer = stratapvlmd_curstratadataLayer
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

																// console.log(feature.length);
																// console.log(feature);

																if (feature.length > 1) {

																	// var f1 =
																	// Ext.JSON.decode(feature,
																	// true);
																	var obj = JSON
																			.parse(conn.responseText);
																	console
																			.log(obj);
																	// var
																	// geoObject
																	// =
																	// JSON.parse(conn.responseText);
																	// var
																	// features
																	// = [];

																	features_data_array = [];

																	var features = obj.features;
																	for (var i = 0, len = features.length; i < len; i++) {
																		var feat = features[i].properties;

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

																		feat['fid'] = parcel_uuid;
																		features_data_array
																				.push(feat);
																	}
																	console
																			.log(features_data_array);

																	
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
																				'#rentparcelinformation #pvlmd_gid')
																				.val(
																						parcel_uuid);

																		$(
																				'#rentparcelinformation #pvlmd_reference_number')
																				.val(
																						props.reference_number);

																		$(
																				'#rentparcelinformation #pvlmd_nt_number')
																				.val(
																						props.nt_number);
																		$(
																				'#rentparcelinformation #pvlmd_file_number')
																				.val(
																						props.file_number);

																		$(
																				'#rentparcelinformation #pvlmd_cro_reference')
																				.val(
																						props.cro_reference);

																		$(
																				'#rentparcelinformation #pvlmd_property_number')
																				.val(
																						props.property_number);
																		$(
																				'#rentparcelinformation #pvlmd_locality')
																				.val(
																						props.locality);

																		$(
																				'#rentparcelinformation #pvlmd_sheet_number')
																				.val(
																						props.sheet_number);

																		$(
																				'#rentparcelinformation #pvlmd_plot_number')
																				.val(
																						props.plot_number);
																		$(
																				'#rentparcelinformation #pvlmd_remarks')
																				.val(
																						props.remarks);

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
																						request_type : 'pvlmd_transaction_select_by_reference_number',
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

									$('#cbo_estate_list').change(function() {
								

							
										var ge_id = $(this).val(); 
										ge_id=ge_id.replace('.0', '');
										console.log(ge_id);
										$.ajax({
											type : "POST",
											url : "stratamgt_serv",
											data : {
												request_type : 'select_rt_govt_estates_get_wkt',
												ge_id : ge_id
											},
											cache : false,
											
											success : function(jobdetails) {
		
												console.log(jobdetails);
												var json_p = JSON.parse(jobdetails);

												stratalc_searchLayer.setSource(new ol.source.Vector(
													{
													  features : (new ol.format.WKT())
														  .readFeatures(json_p.wkt)
													}));
							  
													//stratamap.addLayer(stratalc_searchLayer);
													stratamap.getView().fit(stratalc_searchLayer
														.getSource().getExtent(),
													{size : stratamap.getSize(),
													  maxZoom : 20
													})
											

											}
										});
		
									});

					$("#addpvlmdtransactionlong")
							.on(
									"show.bs.modal",
									function(e) {
										var t_id = $(e.relatedTarget).data(
												'target-id');

										$("#pvlmd_tr_t_id").val([]);

										$("#pvlmd_tr_reference_number").val([]);
										$("#pvlmd_tr_file_number").val([]);
										$("#pvlmd_tr_property_number").val([]);
										$("#pvlmd_tr_submission_date").val([]);
										$("#pvlmd_tr_mutation_number").val([]);
										$("#pvlmd_tr_deed_number").val([]);
										$("#pvlmd_tr_serial_number").val([]);
										$("#pvlmd_tr_sheet_number").val([]);
										$("#pvlmd_tr_plan_number").val([]);
										$("#pvlmd_tr_plot_number").val([]);
										$("#pvlmd_tr_lvb_number").val([]);
										$("#pvlmd_tr_instrument_date").val([]);
										$("#pvlmd_tr_instrument_type").val([]);
										$("#pvlmd_tr_doc_number").val([]);
										$("#pvlmd_tr_party1_plaintiff").val([]);
										$("#pvlmd_tr_party1_plaintiff_tel_no")
												.val([]);
										$("#pvlmd_tr_party1_plaintiff_email")
												.val([]);
										$("#pvlmd_tr_party2_defendant").val([]);
										$("#pvlmd_tr_party2_defendant_tel_no")
												.val([]);
										$("#pvlmd_tr_party2_defendant_email")
												.val([]);
										$("#pvlmd_tr_term").val([]);
										$("#pvlmd_tr_commencement_date")
												.val([]);
										$("#pvlmd_tr_purpose").val([]);

										$("#pvlmd_tr_consideration").val([]);
										$("#pvlmd_tr_consideration_currency")
												.val([]);
										$("#pvlmd_tr_premium").val([]);
										$("#pvlmd_tr_premium_currency").val([]);
										$("#pvlmd_tr_compensation_status").val(
												[]);

										$("#pvlmd_tr_remarks").val([]);
										$("#pvlmd_tr_suit_number").val([]);
										$("#pvlmd_tr_party1_plantiff_add").val(
												[]);
										$("#pvlmd_tr_party2_defendant_add")
												.val([]);
										$("#pvlmd_tr_judgement_in_favour_of")
												.val([]);
										$("#pvlmd_tr_floor_level").val([]);
										$("#pvlmd_tr_apartment_number").val([]);
										$("#pvlmd_tr_rent").val([]);

										$("#pvlmd_tr_unit_description").val([]);
										$("#pvlmd_tr_consent_date").val([]);
										$("#pvlmd_tr_t_id").val([]);

										if (t_id) {

											$
													.ajax({
														type : "POST",
														url : 'Maps',
														data : {
															request_type : 'select_pvlmd_transactions_details_by_t_id',
															t_id : t_id
														},
														cache : false,
														beforeSend : function() {
															// $('#district').html('<img
															// src="img/loading.gif"
															// alt="" width="24"
															// height=gid_id_fk"24">');
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
																						'#addpvlmdtransactionlong #lrd_td_nature_of_instument')
																						.val(
																								this.nature_of_instument);

																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_t_id")
																						.val(
																								this.t_id);

																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_reference_number")
																						.val(
																								this.reference_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_file_number")
																						.val(
																								this.file_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_property_number")
																						.val(
																								this.property_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_submission_date")
																						.val(
																								this.submission_date);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_mutation_number")
																						.val(
																								this.mutation_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_deed_number")
																						.val(
																								this.deed_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_serial_number")
																						.val(
																								this.serial_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_sheet_number")
																						.val(
																								this.sheet_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_plan_number")
																						.val(
																								this.plan_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_plot_number")
																						.val(
																								this.plot_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_lvb_number")
																						.val(
																								this.lvb_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_instrument_date")
																						.val(
																								this.instrument_date);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_instrument_type")
																						.val(
																								this.instrument_type);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_doc_number")
																						.val(
																								this.doc_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff")
																						.val(
																								this.party1_plaintiff);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_tel_no")
																						.val(
																								this.party1_plaintiff_tel_no);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_email")
																						.val(
																								this.party1_plaintiff_email);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party2_defendant")
																						.val(
																								this.party2_defendant);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_tel_no")
																						.val(
																								this.party2_defendant_tel_no);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_email")
																						.val(
																								this.party2_defendant_email);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_term")
																						.val(
																								this.term);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_commencement_date")
																						.val(
																								this.commencement_date);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_purpose")
																						.val(
																								this.purpose);

																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_consideration")
																						.val(
																								this.consideration);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_consideration_currency")
																						.val(
																								this.consideration_currency);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_premium")
																						.val(
																								this.premium);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_premium_currency")
																						.val(
																								this.premium_currency);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_compensation_status")
																						.val(
																								this.compensation_status);

																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_remarks")
																						.val(
																								this.remarks);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_suit_number")
																						.val(
																								this.suit_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party1_plantiff_add")
																						.val(
																								this.party1_plantiff_add);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_add")
																						.val(
																								this.party2_defendant_add);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_judgement_in_favour_of")
																						.val(
																								this.judgement_in_favour_of);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_floor_level")
																						.val(
																								this.floor_level);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_apartment_number")
																						.val(
																								this.apartment_number);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_rent")
																						.val(
																								this.rent);

																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_unit_description")
																						.val(
																								this.unit_description);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_consent_date")
																						.val(
																								this.consent_date);
																				$(
																						"#addpvlmdtransactionlong #pvlmd_tr_t_id")
																						.val(
																								this.t_id);

																			});

														}
													});

										}

									});


																
					$("#stratabtn_show_location")
					.click(
							function(event) {

										var radioValue = $(
												"input[name='interaction_type']:checked")
												.val();

										if (radioValue) {

											alert("Your are a - " + radioValue);

										}

										console.log('you');
										markers.getSource().clear()
										var x_coordinate_mak = $(
												'#stratax_coordinate_mak')
												.val();
										var y_coordinate_mak = $(
												'#stratay_coordinate_mak')
												.val();

										var marker = new ol.Feature({
											geometry : new ol.geom.Point([
													x_coordinate_mak,
													y_coordinate_mak ])
										// dont worry about coordinate type 0,0
										// will be in west coast of
										// africa
										});
										// source.addFeature(marker);

										// stratasearchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.format.WKT()).readFeatures(polygon_tttt)}));
										// var marker = new ol.Feature(new
										// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
										// x_coordinate_mak])));
										markers.getSource().addFeature(marker);

										// stratasearchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

										// view.fit(markers.getSource().getExtent());
										// var extent =
										// stratasearchLayer.getSource().getExtent();
										map.getView()
												.fit(
														markers.getSource()
																.getExtent(),
														{
															size : map
																	.getSize(),
															maxZoom : 16
														})
									});


																						
					$("#stratabtn_visualise_coordinate")
					.click(
							function(event) {

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

										$('#stratabl_wkt_polygon').val(
												polygon_tttt);
										// var wktplygonsearch =
										// $('#lc_fr_bl_wkt_polygon').val();
										// Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].setValue(polygon_tttt);

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

										stratalc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(polygon_tttt)
														}));
										view.fit(stratalc_searchLayer
												.getSource().getExtent());

										stratamap.getView().fit(
												stratalc_searchLayer
														.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})

									});

					

				$("#stratabtn_visualise_search").click(function(event) {

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
															// stratasearchLayer.getSource().getFeatures().length;
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
															if (stratacurstratasearch_result_searchLayer
																	.getSource() != null) {
																stratacurstratasearch_result_searchLayer
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
																 * stratasearchLayer.getSource().getFeatures();
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
															if (json_p.pvlmdcurrent === undefined
																	|| json_p.pvlmdcurrent.features === null) {
															} else {
																stratacurstratasearch_result_searchLayer
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
															view
																	.fit(stratacurstratasearch_result_searchLayer
																			.getSource()
																			.getExtent());
															map
																	.getView()
																	.fit(
																			stratacurstratasearch_result_searchLayer
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

					

									
									
				
					$('#addpvlmdtransactionlong').on(
							'show.bs.modal',
							function(event) {
								var button = $(event.relatedTarget) // Button
								// that
								// triggered
								// the
								// modal

								$("#pvlmd_tr_gid").val($("#pvlmd_gid").val());

								$("#pvlmd_tr_reference_number").val(
										$("#pvlmd_reference_number").val());
								$("#pvlmd_tr_nt_number").val(
										$("#pvlmd_nt_number").val());
								$("#pvlmd_tr_file_number").val(
										$("#pvlmd_file_number").val());
								$("#pvlmd_tr_cro_reference").val(
										$("#pvlmd_cro_reference").val());

								$("#pvlmd_tr_property_number").val(
										$("#pvlmd_property_number").val());
							});

					

				

						$("#pvlmd_btnprintmap").click(function(event) {
										console.log("click_type");

										var wktplygonsearch = $(
												'#lc_bl_wkt_polygon').val();

										// wktplygonsearch
										// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();

										var canvas = document.getElementById(
												"lc-map")
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
															// pvlmd_searchLayer.getSource().getFeatures().length;
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

				});