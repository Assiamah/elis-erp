$(document)
		.ready(
				function() {

					console.log('Compensation working');


					var lvdc_point_coordinate_list;

					var lvdc_click_type = 'MapClick';

					var lvdc_parcel_lrd_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:sp_compensation_aquision',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var lvdc_lrd_parcels_dataLayer = new ol.layer.Tile({
						title : 'Acquisition Layer',
						source : lvdc_parcel_lrd_dataSource

					})

					var lvdc_comp_current_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:sp_compensation_claims',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var lvdc_comp_current_dataLayer = new ol.layer.Tile({
						title : 'LVD Compensation',
						// visible: false,
						source : lvdc_comp_current_dataSource

					})
					
					var lvdc_grid_lrd_dataSource = new ol.source.TileWMS(
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

					var lvdc_grid_lrd_dataLayer = new ol.layer.Tile({
						title : 'Grid',
						visible : false,
						source : lvdc_grid_lrd_dataSource

					})

				

					
					lvdc_lc_searchLayer = new ol.layer.Vector({
						title : 'Search Layer',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'red',
								width : 3
							})
						})
					});

					var lvdc_markers = new ol.layer.Vector({
						// title: 'Markers',
						source : new ol.source.Vector(),
					// style: iconStyle

				
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
					var lvdc_vector_layer = new ol.layer.Vector({
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

					var lvdc_features = new ol.Collection();
					var lvdc_featureOverlay = new ol.layer.Vector({
						source : new ol.source.Vector({
							features : lvdc_features
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

					var lvdc_googleLayerHybrid = new ol.layer.Tile(
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

					var lvdc_new_de = new ol.layer.Tile({
						title : "Open Street Map",
						// 'type': 'base',
						visible : false,
						source : new ol.source.OSM({
							wrapX : false
						}),
					// projection: 'EPSG:4326'
					})

					var lvdc_source = new ol.source.Vector({
						wrapX : false
					});

					var vector = new ol.layer.Vector({
						'type' : 'base',
						source : lvdc_source
					});

					var lvdc_projObj = new ol.proj.Projection({
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

					var lvdc_proj27700 = ol.proj.get('EPSG:2136');
					// proj27700.setExtent([0, 0, 2011055.53818079,
					// 2360318.82691170]);
					lvdc_proj27700.setExtent([ 80935.4497355444,
							1209.0295731349593, 1711780.3060929566,
							2358523.124783509 ]);

					var lvdc_view_e = new ol.View({
						// center: ol.proj.fromLonLat([4.8, 47.75]),
						// center: ol.proj.transform([1187433.58822084,
						// 327091.107070208],
						// 'EPSG:4326','EPSG:3857'),
						projection : lvdc_projObj,
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

					var lvdc_map = new ol.Map({
						target : 'lvdc-map',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
								
								new ol.control.OverviewMap(),
								
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
						view : lvdc_view_e
					});

					// map.addLayer(new_de);
					lvdc_map.addLayer(lvdc_googleLayerHybrid);
					lvdc_map.addLayer(lvdc_grid_lrd_dataLayer);
					lvdc_map.addLayer(lvdc_lrd_parcels_dataLayer);
					lvdc_map.addLayer(lvdc_comp_current_dataLayer);
					lvdc_map.addLayer(lvdc_lc_searchLayer);
					
					
					
					lvdc_map
							.on(
									'click',
									function(evt) {

										// $("#smdparcelinformation").modal();

										// click_type= 'DrawClick'
										var viewResolution = lvdc_map.getView()
												.getResolution();
										var viewProjection = lvdc_map.getView()
												.getProjection();

										if (lvdc_click_type === 'DrawClick') {

										}
										if (lvdc_click_type === 'MapClick') {

											var coordinate = evt.coordinate;
											console.log(coordinate);
											// var viewResolution = *//** @type
											// {number} *//*
											// (view.getResolution());
											// var viewResolution =
											// (view.getResolution());
											var url = lvdc_comp_current_dataSource
													.getGetFeatureInfoUrl(
															evt.coordinate,
															viewResolution,
															viewProjection,
															{
																'INFO_FORMAT' : 'application/json',
																'propertyName' : 'cc_claim_no,cc_claimant,cc_file_no,cc_plan_no,cc_locality,cc_land_size,cc_remarks,ca_id',
																'FEATURE_COUNT' : 50
															});

											var thislayer = lvdc_comp_current_dataLayer
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


																	var table = $('#comp_more_than_one_parcel_Table');
																	table.find("tbody tr").remove();

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
																						+ props.cc_claim_no
																						+ "</td><td>"
																						+ props.cc_claimant
																						+ "</td><td>"
																						+ props.cc_file_no

																						+ "</td>"

																						+ '<td><p data-placement="top" data-toggle="tooltip" title="Details of Client"><button class="btn btn-success btn-circle btn-sm" data-title="Delete" data-toggle="modal" data-target="#compparcelinformation" '
																						+ 'data-parcel_uuid="'
																						+ parcel_uuid
																						+ '" '
																						+ 'data-cc_claim_no="'
																						+ props.cc_claim_no
																						+ '" '
																						+ 'data-cc_claimant="'
																						+ props.cc_claimant
																						+ '" '
																						+ 'data-cc_file_no="'
																						+ props.cc_file_no
																						+ '" '
																						+ 'data-cc_plan_no="'
																						+ props.cc_plan_no
																						+ '" '
																						+ 'data-cc_locality="'
																						+ props.cc_locality
																						+ '" '
																						+ 'data-cc_land_size="'
																						+ props.cc_land_size
																						+ '" '
																						+ 'data-cc_remarks="'
																						+ props.cc_remarks
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
																				"#compparcelinformation")
																				.modal();

																		$(
																				'#compparcelinformation #comp_gid_p')
																				.val(
																						parcel_uuid);

																		$(
																				'#compparcelinformation #cc_claim_no')
																				.val(
																						props.cc_claim_no);

																		$(
																				'#compparcelinformation #cc_claimant')
																				.val(
																						props.cc_claimant);

																		$(
																				'#compparcelinformation #cc_file_no')
																				.val(
																						props.cc_file_no);

																		$(
																				'#compparcelinformation #cc_plan_no')
																				.val(
																						props.cc_plan_no);

																		$(
																				'#compparcelinformation #cc_locality')
																				.val(
																						props.cc_locality);

																		$(
																				'#compparcelinformation #cc_land_size')
																				.val(
																						props.cc_land_size);


																			$('#compparcelinformation #cc_land_size').val(props.cc_remarks);
		

																			

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
																								'#comp_bl_wkt_polygon')
																								.val(
																										json_p.data.polygon_wkt);

																						lvdc_lc_searchLayer
																								.setSource(new ol.source.Vector(
																										{
																											features : (new ol.format.WKT())
																													.readFeatures(json_p.data.polygon_wkt)
																										}));
																						lvdc_lc_searchLayer
																								.setSource(new ol.source.Vector(
																										{
																											features : (new ol.format.GeoJSON())
																													.readFeatures(json_p.parcels)
																										}));

																						view
																								.fit(lvdc_lc_searchLayer
																										.getSource()
																										.getExtent());
																						lvdc_map
																								.getView()
																								.fit(
																										lvdc_lc_searchLayer
																												.getSource()
																												.getExtent(),
																										{
																											size : map
																													.getSize(),
																											maxZoom : 16
																										})

																					}
																				});

																		var table_docs = $('#comp_scanned_documents_dataTable');
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

					$("#addcomptransaction")
							.on(
									"show.bs.modal",
									function(e) {
										var gid = $(e.relatedTarget).data(
												'target-id');

										console.log('gid');
										console.log(gid);

										$('#addcomptransaction #comp_tr_t_id')
												.val([]);
										$('#addcomptransaction #comp_tr_gid')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_reference_number')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_cc_number')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_regional_number')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_job_number')
												.val([]);

										$(
												'#addcomptransaction #comp_tr_applicant_name')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_grantor_name')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_date_of_instument')
												.val([]);

										$(
												'#addcomptransaction #comp_tr_type_instrument')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_consideration')
												.val([]);
										$(
												'#addsmdtransaction #comp_tr_certificate_number')
												.val([]);
										$('#addcomptransaction #comp_tr_term')
												.val([]);
										$(
												'#addcomptransaction #comp_tr_commencement_date')
												.val([]);
										$('#addcomptransaction #comp_tr_purpose')
												.val([]);

										$(
												'#addcomptransaction #comp_tr_plan_number')
												.val([]);
										$('#addcomptransaction #comp_tr_remarks')
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
													.log('addcomptransaction loading '
															+ 'valid ')
											console
													.log('addcomptransaction loading '
															+ gid)

											$('#addcomptransaction #comp_tr_gid')
													.val($('#comp_gid_p').val());
											$('#addcomptransaction #comp_tr_t_id')
													.val(gid);

										
											$(
													'#addcomptransaction #lrd_td_reference_number')
													.val(
															$(
																	'#lrd_ps_reference_number')
																	.val());

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
																						'#addcomptransaction #comp_tr_reference_number')
																						.val(
																								this.reference_number);
																				$(
																						'#addcomptransaction #comp_tr_cc_number')
																						.val(
																								this.cc_number);
																				$(
																						'#addcomptransaction #comp_tr_regional_number')
																						.val(
																								this.regional_number);

																				$(
																						'#addcomptransaction #comp_tr_job_number')
																						.val(
																								this.job_number);
																				$(
																						'#addcomptransaction #comp_tr_applicant_name')
																						.val(
																								this.applicant_name);
																				$(
																						'#addcomptransaction #comp_tr_grantor_name')
																						.val(
																								this.grantor_name);
																				$(
																						'#addcomptransaction #comp_tr_old_ref_number')
																						.val(
																								this.old_ref_number);
																				$(
																						'#addcomptransaction #comp_tr_mul_claim')
																						.val(
																								this.mul_claim);
																				$(
																						'#addcomptransaction #comp_tr_purpose')
																						.val(
																								this.purpose);

																				$(
																						'#addcomptransaction #comp_tr_plan_number')
																						.val(
																								this.plan_number);
																				$(
																						'#addcomptransaction #comp_tr_remarks')
																						.val(
																								this.remarks);

																			});

														}
													});

										} else {
											// console.log('addcomptransaction
											// loading ' + 'not valid ')

											$('#addcomptransaction #comp_tr_t_id')
													.val('0');
											$('#addcomptransaction #comp_tr_gid')
													.val($('#comp_gid_p').val());
											$(
													'#addcomptransaction #comp_tr_reference_number')
													.val([]);

											$(
													'#addcomptransaction #comp_tr_reference_number')
													.val($('#comp_ref_no').val());

										}

										// document.write(today);

									});

					$('#btn_save_comp_transaction')
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

					

					document
							.getElementById('comp_btn_visualise_coordinate')
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

										$('#comp_bl_wkt_polygon').val(
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

										lvdc_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(polygon_tttt)
														}));
										view.fit(lvdc_lc_searchLayer.getSource()
												.getExtent());

												lvdc_map.getView().fit(
												lvdc_lc_searchLayer.getSource()
														.getExtent(), {
													size : lvdc_map.getSize(),
													maxZoom : 16
												})

									});

					document
							.getElementById('comp_btn_visualise_search')
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
															if (comp_current_search_result_searchLayer
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
							.getElementById('comp_btn_save_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("comp_bl_wkt_polygon").value;
										console.log(wktplygonsearch)

										$("#compparcelinformation").modal();

										$(
												'#compparcelinformation #comp_ref_no_f')
												.val([]);

										$(
												'#compparcelinformationfirst #comp_land_size_f')
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
																'#compparcelinformationfirst #comp_land_size_f')
																.val(jobdetails);

													}
												});

									});

		
					document
							.getElementById('comp_btn_visualise_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										// console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("comp_bl_wkt_polygon").value;
										console.log(wktplygonsearch)
										comp_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(wktplygonsearch)
														}));
										comp_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.GeoJSON())
																	.readFeatures(json_p.parcels)
														}));

										view.fit(comp_lc_searchLayer.getSource()
												.getExtent());
												lvdc_map.getView().fit(
												comp_lc_searchLayer.getSource()
														.getExtent(), {
													size : lvdc_map.getSize(),
													maxZoom : 16
												})

									});

					document
							.getElementById(
									'comp_btn_search_by_reference_number')
							.addEventListener(
									'click',
									function() {

										var search_text = $(
												'#comp_search_by_text').val();
										console.log(search_text)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													data : {
														request_type : 'select_search_comp_parcles_by_other_number',
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

															if (comp_lc_searchLayer
																	.getSource() != null) {
																comp_lc_searchLayer
																		.getSource()
																		.clear();
															}

															if (json_p.parcels === undefined
																	|| json_p.parcels.features === null) {

															} else {
																comp_lc_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.parcels)
																				}));

															}

															view
																	.fit(comp_lc_searchLayer
																			.getSource()
																			.getExtent());
															comp_map
																	.getView()
																	.fit(
																			comp_lc_searchLayer
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

					// comp_btn_search_for_scanned_maps

					$('#comp_scale_value').change(
							function() {
								// alert($(this).val());
								$('#comp_scale_value_e').val($(this).val());
								var view = lvdc_map.getView();
								view.setResolution(ol.proj.getPointResolution(
										view.getProjection(),
										getResolutionFromScale($(this).val()),
										view.getCenter()));
								click_map_zoom_value = false;

							});
	

					$('#compparcelinformation')
							.on(
									'show.bs.modal',
									function(e) {

										var parcel_uuid = $(e.relatedTarget)
												.data('parcel_uuid');
										var reference_number = $(e.relatedTarget).data('reference_number');
										$('#compparcelinformation #cc_id').val(parcel_uuid);

										$('#compparcelinformation #cc_claim_no').val($(e.relatedTarget).data('cc_claim_no'));
										$('#compparcelinformation #cc_claimant').val($(e.relatedTarget).data('cc_claimant'));

										$(
												'#compparcelinformation #cc_file_no')
												.val(
														$(e.relatedTarget)
																.data(
																		'cc_file_no'));

										$(
												'#compparcelinformation #cc_plan_no')
												.val(
														$(e.relatedTarget)
																.data(
																		'cc_plan_no'));

										$(
												'#compparcelinformation #cc_locality')
												.val(
														$(e.relatedTarget)
																.data(
																		'cc_locality'));

										$('#compparcelinformation #cc_land_size')
												.val(
														$(e.relatedTarget)
																.data('cc_land_size'));


										$('#compparcelinformation #cc_remarks').val(
												$(e.relatedTarget)
														.data('cc_remarks'));

										
										// $
										// 		.ajax({
										// 			type : "POST",
										// 			url : "Maps",
										// 			data : {
										// 				request_type : 'search_comp_parcel_wkt',
										// 				parcel_id : parcel_uuid,
										// 			},
										// 			cache : false,

										// 			success : function(
										// 					jobdetails) {

										// 				console.log(jobdetails);
										// 				var json_p = JSON
										// 						.parse(jobdetails);

										// 				$('#comp_bl_wkt_polygon')
										// 						.val(
										// 								json_p.data.polygon_wkt);

										// 				comp_lc_searchLayer
										// 						.setSource(new ol.source.Vector(
										// 								{
										// 									features : (new ol.format.WKT())
										// 											.readFeatures(json_p.data.polygon_wkt)
										// 								}));
										// 				comp_lc_searchLayer
										// 						.setSource(new ol.source.Vector(
										// 								{
										// 									features : (new ol.format.GeoJSON())
										// 											.readFeatures(json_p.parcels)
										// 								}));

										// 				view
										// 						.fit(comp_lc_searchLayer
										// 								.getSource()
										// 								.getExtent());
										// 				comp_map
										// 						.getView()
										// 						.fit(
										// 								comp_lc_searchLayer
										// 										.getSource()
										// 										.getExtent(),
										// 								{
										// 									size : map
										// 											.getSize(),
										// 									maxZoom : 16
										// 								})

										// 			}
										// 		});

									

									});

				
					document
							.getElementById('comp_btnprintmap')
							.addEventListener(
									'click',
									function() {
										console.log("click_type");

										var wktplygonsearch = $(
												'#comp_bl_wkt_polygon').val();

										// wktplygonsearch
										// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_comp]')[0].getValue();

										var canvas = document.getElementById(
												"lvdc-map")
												.getElementsByClassName(
														"ol-unselectable")[0];
										var img = canvas.toDataURL("image/png");

										
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

									
										doc.setFontSize(16)
										doc.text(80, 35,
												'COMPENSATION MAP')

										
										// Logo
										var imgLogo = new Image();
										imgLogo.src = './resources/NewLogo.jpg';
										doc.addImage(img, 'JPEG', 20, 60, 160,
												80);

									
												doc.save('map.pdf');

									});

					function getResolutionFromScale(scale) {
						var units = lvdc_map.getView().getProjection()
								.getUnits();
						var dpi = 25.4 / 0.28;
						var mpu = ol.proj.METERS_PER_UNIT[units];
						var resolution = scale / (mpu * 39.37 * dpi);
						return resolution;
					}

				});