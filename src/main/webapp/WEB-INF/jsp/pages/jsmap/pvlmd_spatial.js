$(document)
		.ready(
				function() {

					var lrd_point_coordinate_list;

					var lrd_click_type = 'MapClick';
					var pvlmd_parcel_lrd_dataSource = new ol.source.TileWMS(
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

					var pvlmd_lrd_parcels_dataLayer = new ol.layer.Tile({
						title : 'LRD Parcels Layer',
						source : pvlmd_parcel_lrd_dataSource

					})

					var pvlmd_parcels_smd_dataSource = new ol.source.TileWMS(
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

					var pvlmd_parcels_smd_dataLayer = new ol.layer.Tile({
						title : 'SMD Parcels Layer',
						source : pvlmd_parcels_smd_dataSource

					})

					var pvlmd_cadastral_smd_dataSource = new ol.source.TileWMS(
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

					var pvlmd_cadastral_smd_dataLayer = new ol.layer.Tile({
						title : 'SMD Cadastral Layer',
						source : pvlmd_cadastral_smd_dataSource

					})

					var pvlmd_garro_parcels_dataSource = new ol.source.TileWMS(
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

					var pvlmd_garro_parcels_dataLayer = new ol.layer.Tile({
						title : 'Existing GARRO Layer',
						// visible: false,
						source : pvlmd_garro_parcels_dataSource

					})

					var pvlmd_cro_sp_dataSource = new ol.source.TileWMS(
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

					var pvlmd_cro_parcels_dataLayer = new ol.layer.Tile({
						title : 'Existing CRO Layer',
						// visible: false,
						source : pvlmd_cro_sp_dataSource

					})

					var pvlmd_pvlmd_current_dataSource = new ol.source.TileWMS(
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

					var pvlmd_pvlmd_current_dataLayer = new ol.layer.Tile({
						title : 'PVLMD Current Layer',
						// visible: false,
						source : pvlmd_pvlmd_current_dataSource

					})

					var pvlmd_grid_lrd_dataSource = new ol.source.TileWMS(
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

					var pvlmd_grid_lrd_dataLayer = new ol.layer.Tile({
						title : 'Grid',
						visible : false,
						source : pvlmd_grid_lrd_dataSource

					})

					var pvlmd_registration_district_dataSource = new ol.source.TileWMS(
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

					var pvlmd_registration_district_dataLayer = new ol.layer.Tile(
							{
								title : 'Registration District',
								visible : false,
								source : pvlmd_registration_district_dataSource

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
					 * getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					 * params: {'LAYERS': 'csau_geospatial:104_modified_CR'},
					 * serverType: 'geoserver', })
					 */
					});

					pvlmd_garro_search_result_searchLayer = new ol.layer.Vector(
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

					pvlmd_current_search_result_searchLayer = new ol.layer.Vector(
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

					pvlmd_smd_parcel_search_result_searchLayer = new ol.layer.Vector(
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

					pvlmd_smd_cadastral_search_result_searchLayer = new ol.layer.Vector(
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

					var pvlmd_googleLayerHybrid = new ol.layer.Tile(
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

					var pvlmd_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
					var pvlmd_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

					// console.log(firstProjection);
					// console.log(secondProjection);
					// proj4(firstProjection,secondProjection,[2,5]);
					// console.log(proj4(secondProjection,firstProjection,[2,5]));
					// ol.proj.proj4.register(proj4);
					// ol.proj.registerProj4(proj4);
					// register(proj4);

					var pvlmd_proj27700 = ol.proj.get('EPSG:2136');
					// proj27700.setExtent([0, 0, 2011055.53818079,
					// 2360318.82691170]);
					pvlmd_proj27700.setExtent([ 80935.4497355444,
							1209.0295731349593, 1711780.3060929566,
							2358523.124783509 ]);

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
						scales : [ 100000, 250000, 500000, 1000000, 2000000,
								4000000, 8000000 ],
						zoom : 12
					})

					var pvlmd_map = new ol.Map({
						target : 'pvlmd-map',
						controls : ol.control.defaults().extend(
								[ new ol.control.LayerSwitcher(),
								/*
								 * new ol.control.MousePosition({
								 * coordinateFormat: ol.coordinate.toStringHDMS,
								 * }),
								 */
								new ol.control.OverviewMap(),
								 new ol.control.ScaleLine(),
								// new ol.control.ScaleLineUnits0(),
								 //new ol.control.ControlDrawFeatures(vector_draw, optionsControlDraw),
								 //new  ol.control.ControlDrawButtons(vector_layer, opt_options),
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
						view : pvlmd_view_e
					});

					// map.addLayer(new_de);
					pvlmd_map.addLayer(pvlmd_googleLayerHybrid);
					pvlmd_map.addLayer(pvlmd_StaticImage);
					pvlmd_map.addLayer(pvlmd_registration_district_dataLayer);

					pvlmd_map.addLayer(pvlmd_grid_lrd_dataLayer);

					// map.addLayer(beacon_lrd_dataLayer);

					pvlmd_map.addLayer(pvlmd_lrd_parcels_dataLayer);
					pvlmd_map.addLayer(pvlmd_parcels_smd_dataLayer);
					pvlmd_map.addLayer(pvlmd_cadastral_smd_dataLayer);
					pvlmd_map.addLayer(pvlmd_pvlmd_current_dataLayer);
					pvlmd_map.addLayer(pvlmd_cro_parcels_dataLayer);
					pvlmd_map.addLayer(pvlmd_garro_parcels_dataLayer);
					pvlmd_map.addLayer(pvlmd_garro_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_cro_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_current_search_result_searchLayer);
					pvlmd_map
							.addLayer(pvlmd_smd_parcel_search_result_searchLayer);
					pvlmd_map
							.addLayer(pvlmd_smd_cadastral_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_lrd_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_lc_searchLayer);
					pvlmd_map.addLayer(pvlmd_markers);
					pvlmd_map
							.on(
									'click',
									function(evt) {

										// $("#pvlmdparcelinformation").modal();

										// click_type= 'DrawClick'
										var viewResolution = pvlmd_map
												.getView().getResolution();
										var viewProjection = pvlmd_map
												.getView().getProjection();

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
											var url = pvlmd_pvlmd_current_dataSource
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

											var thislayer = pvlmd_pvlmd_current_dataLayer
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

																var table = $('#pvlmd_more_than_one_parcel_Table');
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
																						pvlmd_lc_searchLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(json_p.data.polygon_wkt)}));
																						pvlmd_lc_searchLayer.setSource(new ol.source.Vector({features : (new ol.format.GeoJSON()).readFeatures(json_p.parcels)}));

																						view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
																						pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(),{size : map.getSize(),maxZoom : 16})



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

										}
									});

					document
							.getElementById('pvlmd_btn_visualise_coordinate')
							.addEventListener(
									'click',
									function(e) {
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

										$('#pvlmd_bl_wkt_polygon').val(
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

										pvlmd_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(polygon_tttt)
														}));
										view.fit(pvlmd_lc_searchLayer
												.getSource().getExtent());

										pvlmd_map.getView().fit(
												pvlmd_lc_searchLayer
														.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})
									});

					document
							.getElementById('pvlmd_btn_save_wkt')
							.addEventListener(
									'click',
									function() {

										var wktplygonsearch = document
												.getElementById("pvlmd_bl_wkt_polygon").value;

										$(
												"#pvlmdparcelinformationfirsttimesave")
												.modal();

										$(
												'#pvlmdparcelinformationfirsttimesave #pvlmd_parcel_wkt_to_plot_fts')
												.val(wktplygonsearch);

									});

					document
							.getElementById('pvlmd_btn_visualise_wkt')
							.addEventListener(
									'click',
									function(e) {
										// wktplygonsearch
										// v
										// console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("pvlmd_bl_wkt_polygon").value;
										console.log(wktplygonsearch)

										pvlmd_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(wktplygonsearch)
														}));
										view.fit(pvlmd_lc_searchLayer
												.getSource().getExtent());

										pvlmd_map.getView().fit(
												pvlmd_lc_searchLayer
														.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})

									});

					document
							.getElementById('btn_save_pvlmd_parcel_details_fts')
							.addEventListener(
									'click',
									function(e) {
										// wktplygonsearch
										// v
										console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("pvlmd_parcel_wkt_to_plot_fts").value;

										var file_number = document
												.getElementById("pvlmd_file_number_fts").value;

										var sheet_number = document
												.getElementById("pvlmd_sheet_number_fts").value;

										var locality = document
												.getElementById("pvlmd_locality_fts").value;

										var remarks = document
												.getElementById("pvlmd_remarks_fts").value;

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'pvlmd_polygon_for_save_with_info',
														wkt_polgon : wktplygonsearch,
														file_number : file_number,
														sheet_number : sheet_number,
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
																'#pvlmdparcelinformationfirsttimesave #pvlmd_gid_fts')
																.val(json_p.gid);
														$(
																'#pvlmdparcelinformationfirsttimesave #pvlmd_reference_number_fts')
																.val(
																		json_p.reference_number);
														$(
																'#pvlmdparcelinformationfirsttimesave #pvlmd_nt_number_fts')
																.val(
																		json_p.nt_number);

														$(
																"#btn_save_pvlmd_parcel_details_fts")
																.prop(
																		"disabled",
																		true);

													}
												});

									});

					document.getElementById('pvlmd_btn_show_location')
							.addEventListener(
									'click',
									function(e) {

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

										// console.log('you');
										pvlmd_markers.getSource().clear()
										var x_coordinate_mak = $(
												'#pvlmd_x_coordinate_mak')
												.val();
										var y_coordinate_mak = $(
												'#pvlmd_y_coordinate_mak')
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

										// pvlmd_searchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.format.WKT()).readFeatures(polygon_tttt)}));
										// var marker = new ol.Feature(new
										// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
										// x_coordinate_mak])));
										pvlmd_markers.getSource().addFeature(
												marker);

										// pvlmd_searchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

										// view.fit(markers.getSource().getExtent());
										// var extent =
										// pvlmd_searchLayer.getSource().getExtent();
										pvlmd_map.getView().fit(
												pvlmd_markers.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})
									});

					document
							.getElementById(
									'pvlmd_btn_search_by_reference_number')
							.addEventListener(
									'click',
									function(e) {

										var search_text = $(
												'#pvlmd_search_by_text').val();
										console.log(search_text)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													data : {
														request_type : 'select_search_pvlmd_parcles_by_other_number',
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
															// lrd_pvlmd_searchLayer.getSource().getFeatures().length;
															// console.log(featureCount);

															if (pvlmd_lc_searchLayer
																	.getSource() != null) {
																pvlmd_lc_searchLayer
																		.getSource()
																		.clear();
															}

															if (json_p.parcels === undefined
																	|| json_p.parcels.features === null) {

															} else {
																pvlmd_lc_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.parcels)
																				}));

															}

															view
																	.fit(pvlmd_lc_searchLayer
																			.getSource()
																			.getExtent());
															pvlmd_map
																	.getView()
																	.fit(
																			pvlmd_lc_searchLayer
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


					// pvlmd_btn_search_for_scanned_maps

					$('#pvlmd_scale_value').change(
							function() {
								// alert($(this).val());
								$('#pvlmd_scale_value_e').val($(this).val());
								var view = pvlmd_map.getView();
								view.setResolution(ol.proj.getPointResolution(
										view.getProjection(),
										getResolutionFromScale($(this).val()),
										view.getCenter()));
								click_map_zoom_value = false;

							});
					// 

					var click_map_zoom_value = true;
					document
							.getElementById('pvlmd_btn_scale_zoom')
							.addEventListener(
									'click',
									function() {

										var scale_value = $(
												'#pvlmd_scale_value_e').val();
										var view = pvlmd_map.getView();
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
							.getElementById('pvlmd_lockmapscale')
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
												.getElementById("pvlmd_lockmapscale").checked) {

											// ol.interaction.DoubleClickZoom
											// ol.interaction.MouseWheelZoom

											var MouseWheelZoomClickInteraction;
											// find DoubleClickZoom interaction
											pvlmd_map
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
											pvlmd_map
													.removeInteraction(MouseWheelZoomClickInteraction);

											var dblClickInteraction;
											// find DoubleClickZoom interaction
											pvlmd_map
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
											pvlmd_map
													.removeInteraction(dblClickInteraction);

										} else {

											dblClickInteraction = new ol.interaction.DoubleClickZoom(
													{
														delta : 0
													});
											pvlmd_map
													.addInteraction(dblClickInteraction);

											MouseWheelZoomClickInteraction = new ol.interaction.MouseWheelZoom(
													{
														delta : 0
													});
											pvlmd_map
													.addInteraction(MouseWheelZoomClickInteraction);

										}

									});

					document
							.getElementById(
									'pvlmd_btn_load_for_scanned_maps_by_point')
							.addEventListener(
									'click',
									function() {

										console.log('kkkkk');

										var x_coordinate_mak = $(
												'#pvlmd_x_coordinate_mak')
												.val();
										var y_coordinate_mak = $(
												'#pvlmd_y_coordinate_mak')
												.val();

										polygon = x_coordinate_mak + " "
												+ y_coordinate_mak;

										polygon_real = "POINT(" + polygon + ")";

										console.log(polygon_real);

										$
												.ajax({
													type : "POST",
													url : "Maps",
													data : {
														request_type : 'search_for_lrd_scan_map_for_a_point',
														wkt_polgon : polygon_real
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
							.getElementById('pvlmd_btn_search_for_scanned_maps')
							.addEventListener(
									'click',
									function(e) {

										console.log('kkkkk');

										// var wkt_polygon =
										// $('#lrd_txt_wkt_polygon').val();

										var wkt_polygon_k = $.trim($(
												"#pvlmd_bl_wkt_polygon").val());
										var wkt_polygon = document
												.getElementById("pvlmd_bl_wkt_polygon").value;
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
							.getElementById('pvlmd_btn_load_for_scanned_maps')
							.addEventListener(
									'click',
									function(e) {

										// console.log('kkkkk');

										// var wkt_polygon =
										// $('#lrd_txt_wkt_polygon').val();

										var geoserverscannedimage = $.trim($(
												"#geoserverscannedimages_list")
												.val());
										/*
										 * var wkt_polygon = document
										 * .getElementById("lrd_txt_wkt_polygon").value;
										 */
										// console.log('Scan Map');
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

										pvlmd_StaticImage
												.setSource(image_source);

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

										pvlmd_map.getView().fit(new_extent,
												pvlmd_map.getSize());

										// map.getView().fit(new_extent,
										// map.getSize());

										/*
										 * lrd_map.getView().fit(new_extent, {
										 * size : lrd_map.getSize(), maxZoom :
										 * 16 })
										 */

									});

					/*
					 * document .getElementById('pvlmd_btn_search_transaction')
					 * .addEventListener( 'click', function(e) {
					 * 
					 * var reference_number = $(
					 * '#pvlmd_search_transaction_by_text') .val();
					 * 
					 * var table = $('#pvlmd_transaction_all_dataTable');
					 * table.find("tbody tr").remove(); $ .ajax({ type : "POST",
					 * url : 'Maps', data : { request_type :
					 * 'pvlmd_transaction_select_by_reference_number',
					 * reference_number : reference_number, gid_fk : 0 }, cache :
					 * false, beforeSend : function() { // $('#district').html('<img //
					 * src="img/loading.gif" // alt="" // width="24" //
					 * height="24">'); }, success : function( serviceresponse) {
					 * 
					 * var json_p = JSON .parse(serviceresponse);
					 * console.log(json_p)
					 * 
					 * $(json_p.data) .each( function() {
					 * 
					 * table .append("<tr><td>" + this.party1_plaintiff + "</td><td>" +
					 * this.party2_defendant + "</td><td>" +
					 * this.reference_number + "</td><td>" +
					 * this.instrument_type + "</td><td>" +
					 * this.instrument_date + "</td><td>" + this.term + "</td><td>" +
					 * this.purpose + "</td><td>" + this.doc_number + "</td>" + '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button
					 * class="btn btn-info btn-icon-split" data-dismiss="modal"
					 * data-toggle="modal" href="#addpvlmdtransactionlong"
					 * data-target-id="' + this.t_id + '"><span class="icon
					 * text-white-50"> <i class="fas fa-info-circle"></i></span><span
					 * class="text">Details</span></button></p></td>' + "</tr>");
					 * }); } }); });
					 */

					$('#pvlmdparcelinformation')
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

										/*
										 * remarks, sheet_number, file_number,
										 * property_number, reference_number,
										 * locality, plot_number, cro_reference,
										 * nt_number, parcel_uuid
										 */

										$('#pvlmdparcelinformation #pvlmd_gid')
												.val(parcel_uuid);

										$(
												'#pvlmdparcelinformation #pvlmd_reference_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'reference_number'));

										$(
												'#pvlmdparcelinformation #pvlmd_nt_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'nt_number'));
										$(
												'#pvlmdparcelinformation #pvlmd_file_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'file_number'));

										$(
												'#pvlmdparcelinformation #pvlmd_cro_reference')
												.val(
														$(e.relatedTarget)
																.data(
																		'cro_reference'));

										$(
												'#pvlmdparcelinformation #pvlmd_property_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'property_number'));
										$(
												'#pvlmdparcelinformation #pvlmd_locality')
												.val(
														$(e.relatedTarget)
																.data(
																		'locality'));

										$(
												'#pvlmdparcelinformation #pvlmd_sheet_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'sheet_number'));

										$(
												'#pvlmdparcelinformation #pvlmd_plot_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'plot_number'));
										$(
												'#pvlmdparcelinformation #pvlmd_remarks')
												.val(
														$(e.relatedTarget)
																.data('remarks'));
																
												// 				$(
												// '#pvlmdparcelinformation #pvlmd_modified_by')
												// .val(
												// 		$(e.relatedTarget)
												// 				.data(
												// 						'modified_by'));
										// $(
										// 		'#pvlmdparcelinformation #pvlmd_modified_date')
										// 		.val(
										// 				$(e.relatedTarget)
										// 						.data('modified_date'));

										var table = $('#pvlmd_transaction_dataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'pvlmd_transaction_select_by_reference_number_main',
														reference_number : reference_number,
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

																							+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addpvlmdtransactionlong" data-target-id="'
																							+ this.t_id
																							+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																							+ "</tr>");
																		});

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

					$("#addpvlmdtransactionlong")
							.on(
									"show.bs.modal",
									function(e) {
										var t_id = $(e.relatedTarget).data(
												'target-id');

										console.log('t_id');
										console.log(t_id);

										// showSuggestions(job_number);

										/*
										 * $.get( "/controller/" + id, function(
										 * data ) {
										 * $(".modal-body").html(data.html); });
										 */
										// $('#edit
										// #job_numnber').val(job_number);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_gid')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_t_id')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_reference_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_file_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_property_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_nt_number')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_mutation_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_deed_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_serial_number')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_sheet_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_plan_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_plot_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_lvb_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_doc_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_tel_no')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plantiff_add')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_email')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_tel_no')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_email')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_add')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_instrument_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_instrument_type')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_term')
												.val([]);

										$(
												'#addpvlmdtransactionlong #pvlmd_tr_commencement_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_purpose')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_consent_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_consideration')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_consideration_currency')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_premium')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_premium_currency')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_compensation_status')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_suit_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_floor_level')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_apartment_number')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_rent')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_submission_date')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_unit_description')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_judgement_in_favour_of')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_remarks')
												.val([]);
												
												
												
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_modified_id')
												.val([]);
										$(
												'#addpvlmdtransactionlong #pvlmd_tr_modified_date')
												.val([]);

										var today = new Date();
										var dd = String(today.getDate())
												.padStart(2, '0');
										var mm = String(today.getMonth() + 1)
												.padStart(2, '0'); // January
										// is 0!
										var yyyy = today.getFullYear();

										today = mm + '/' + dd + '/' + yyyy;

										if (t_id) {
											console
													.log('addpvlmdtransactionlong loading '
															+ 'valid ')

											/*
											 * $( '#addlrdtransaction
											 * #lrd_td_fid_id_fk')
											 * .val($('#lrd_ps_fid').val());
											 * $('#addlrdtransaction
											 * #lrd_td_gid') .val(gid); $(
											 * '#addlrdtransaction
											 * #lrd_td_plotted_by_reg') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_checked_by') .val(
											 * localStorage
											 * .getItem('fullname')); $(
											 * '#addlrdtransaction
											 * #lrd_td_plott_date_reg')
											 * .val(today); //
											 * $('#addlrdtransaction //
											 * #lrd_td_job_numnber').val(job_number); $(
											 * '#addlrdtransaction
											 * #lrd_td_reference_number') .val( $(
											 * '#lrd_ps_reference_number')
											 * .val());
											 */
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
																						"#pvlmd_tr_gid")
																						.val(
																								$(
																										"#pvlmd_gid")
																										.val());

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_t_id')
																						.val(
																								this.t_id);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_reference_number')
																						.val(
																								this.reference_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_file_number')
																						.val(
																								this.file_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_property_number')
																						.val(
																								this.property_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_nt_number')
																						.val(
																								this.nt_number);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_mutation_number')
																						.val(
																								this.mutation_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_deed_number')
																						.val(
																								this.deed_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_serial_number')
																						.val(
																								this.serial_number);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_sheet_number')
																						.val(
																								this.sheet_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_plan_number')
																						.val(
																								this.plan_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_plot_number')
																						.val(
																								this.plot_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_lvb_number')
																						.val(
																								this.lvb_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_doc_number')
																						.val(
																								this.doc_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff')
																						.val(
																								this.party1_plaintiff);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_tel_no')
																						.val(
																								this.party1_plaintiff_tel_no);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plantiff_add')
																						.val(
																								this.party1_plantiff_add);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party1_plaintiff_email')
																						.val(
																								this.party1_plaintiff_email);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant')
																						.val(
																								this.party2_defendant);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_tel_no')
																						.val(
																								this.party2_defendant_tel_no);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_email')
																						.val(
																								this.party2_defendant_email);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_party2_defendant_add')
																						.val(
																								this.party2_defendant_add);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_instrument_date')
																						.val(
																								this.instrument_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_instrument_type')
																						.val(
																								this.instrument_type);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_term')
																						.val(
																								this.term);

																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_commencement_date')
																						.val(
																								this.commencement_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_purpose')
																						.val(
																								this.purpose);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_consent_date')
																						.val(
																								this.consent_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_consideration')
																						.val(
																								this.consideration);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_consideration_currency')
																						.val(
																								this.consideration_currency);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_premium')
																						.val(
																								this.premium);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_premium_currency')
																						.val(
																								this.premium_currency);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_compensation_status')
																						.val(
																								this.compensation_status);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_suit_number')
																						.val(
																								this.suit_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_floor_level')
																						.val(
																								this.floor_level);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_apartment_number')
																						.val(
																								this.apartment_number);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_rent')
																						.val(
																								this.rent);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_submission_date')
																						.val(
																								this.submission_date);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_unit_description')
																						.val(
																								this.unit_description);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_judgement_in_favour_of')
																						.val(
																								this.judgement_in_favour_of);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_remarks')
																						.val(
																								this.remarks);
																								
																								$(
																						'#addpvlmdtransactionlong #pvlmd_tr_modified_by')
																						.val(
																								this.modified_by);
																				$(
																						'#addpvlmdtransactionlong #pvlmd_tr_modified_date')
																						.val(
																								this.modified_date);

																			});

														}
													});

										} else {

											$("#pvlmd_tr_t_id").val('0');

											$("#pvlmd_tr_gid").val(
													$("#pvlmd_gid").val());

											$("#pvlmd_tr_reference_number")
													.val(
															$(
																	"#pvlmd_reference_number")
																	.val());
											$("#pvlmd_tr_nt_number")
													.val(
															$(
																	"#pvlmd_nt_number")
																	.val());
											$("#pvlmd_tr_file_number").val(
													$("#pvlmd_file_number")
															.val());
											$("#pvlmd_tr_cro_reference").val(
													$("#pvlmd_cro_reference")
															.val());

											$("#pvlmd_tr_property_number").val(
													$("#pvlmd_property_number")
															.val());

										}

									});

					$('#addpvlmdtransactionshort').on(
							'show.bs.modal',
							function(e) {

								var button = $(event.relatedTarget) // Button
								// that
								// triggered
								// the
								// modal

								$("#pvlmd_tr_st_gid")
										.val($("#pvlmd_gid").val());

								$("#pvlmd_tr_st_reference_number").val(
										$("#pvlmd_reference_number").val());
								$("#pvlmd_tr_st_nt_number").val(
										$("#pvlmd_nt_number").val());
								$("#pvlmd_tr_st_file_number").val(
										$("#pvlmd_file_number").val());
								$("#pvlmd_tr_st_cro_reference").val(
										$("#pvlmd_cro_reference").val());

								$("#pvlmd_tr_st_property_number").val(
										$("#pvlmd_property_number").val());
							});

					$('#pvlmdparcelinformation')
							.on(
									'show.bs.modal',
									function(e) {

										var parcel_uuid = $(e.relatedTarget)
												.data('parcel_uuid');
										var reference_number = $(
												e.relatedTarget).data(
												'reference_number');

										/*
										 * remarks, sheet_number, file_number,
										 * property_number, reference_number,
										 * locality, plot_number, cro_reference,
										 * nt_number, parcel_uuid
										 */

										$('#pvlmdparcelinformation #pvlmd_gid')
												.val(parcel_uuid);

										$(
												'#pvlmdparcelinformation #pvlmd_reference_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'reference_number'));

										$(
												'#pvlmdparcelinformation #pvlmd_nt_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'nt_number'));
										$(
												'#pvlmdparcelinformation #pvlmd_file_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'file_number'));

										/*
										 * $( '#pvlmdparcelinformation
										 * #pvlmd_cro_reference') .val(
										 * $(e.relatedTarget) .data(
										 * 'cro_reference'));
										 *//*
											 * $( '#pvlmdparcelinformation
											 * #pvlmd_property_number') .val(
											 * $(e.relatedTarget) .data(
											 * 'property_number'));
											 */
										$(
												'#pvlmdparcelinformation #pvlmd_locality')
												.val(
														$(e.relatedTarget)
																.data(
																		'locality'));

										$(
												'#pvlmdparcelinformation #pvlmd_sheet_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'sheet_number'));

										$(
												'#pvlmdparcelinformation #pvlmd_plot_number')
												.val(
														$(e.relatedTarget)
																.data(
																		'plot_number'));
										$(
												'#pvlmdparcelinformation #pvlmd_remarks')
												.val(
														$(e.relatedTarget)
																.data('remarks'));

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
									
									
					$('#pvlmd_tr_btn_delete_parcel')
							.on(
									'click',
									function(e) {

										var confirmText = "Are you sure you want to delete the selected plotting? Note that this cannot be undone";
										if (confirm(confirmText)) {
											var pvlmd_gid = $('#pvlmd_gid')
													.val();
											$
													.ajax({
														type : "POST",
														url : "Maps",
														// target : '_blank',
														data : {
															request_type : 'select_delete_pvlmd_parcles_to_be_corrected',
															parcel_id : pvlmd_gid
														},
														cache : false,
														success : function(
																jobdetails) {
															console
																	.log(jobdetails)
															alert(jobdetails);

														}
													});

										}

									});


					$('#btn_save_pvlmd_transaction_short')
							.on(
									'click',
									function(e) {

										console.log('Assiamah');

										var pvlmd_gid = document
												.getElementById("pvlmd_gid").value;

										var pvlmd_tr_st_t_id = document
												.getElementById("pvlmd_tr_st_t_id").value;

										var reference_number = document
												.getElementById("pvlmd_tr_st_reference_number").value;
										var file_number = document
												.getElementById("pvlmd_tr_st_file_number").value;
										var property_number = document
												.getElementById("pvlmd_tr_st_property_number").value;
										var submission_date = document
												.getElementById("pvlmd_tr_st_submission_date").value;
										var plot_number = document
												.getElementById("pvlmd_tr_st_plot_number").value;
										var doc_number = document
												.getElementById("pvlmd_tr_st_document_number").value;

										var party1_plaintiff = document
												.getElementById("pvlmd_tr_st_party1_plaintiff").value;
										var party1_plaintiff_tel_no = document
												.getElementById("pvlmd_tr_st_party1_plaintiff_tel_no").value;

										var party2_defendant = document
												.getElementById("pvlmd_tr_st_party2_defendant").value;
										var party2_defendant_tel_no = document
												.getElementById("pvlmd_tr_st_party2_defendant_tel_no").value;
										var term = document
												.getElementById("pvlmd_tr_st_term").value;

										var commencement_date = document
												.getElementById("pvlmd_tr_st_commencement_date").value;

										var purpose = document
												.getElementById("pvlmd_tr_st_purpose").value;

										var consent_date = document
												.getElementById("pvlmd_tr_st_consent_date").value;

										var instrument_date = document
												.getElementById("pvlmd_tr_st_instrument_date").value;
										var instrument_type = document
												.getElementById("pvlmd_tr_st_instrument_type").value;

										var remarks = document
												.getElementById("pvlmd_tr_remarks").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'save_pvlmd_transaction_short',
														reference_number : reference_number,
														file_number : file_number,
														property_number : property_number,
														submission_date : submission_date,
														plot_number : plot_number,
														instrument_date : instrument_date,
														instrument_type : instrument_type,
														doc_number : doc_number,
														party1_plaintiff : party1_plaintiff,
														party1_plaintiff_tel_no : party1_plaintiff_tel_no,

														party2_defendant : party2_defendant,
														party2_defendant_tel_no : party2_defendant_tel_no,

														term : term,
														commencement_date : commencement_date,
														purpose : purpose,
														remarks : remarks,
														gid_id_fk : pvlmd_gid,
														consent_date : consent_date,
														t_id : pvlmd_tr_st_t_id

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

														/*
														 * var json_p = JSON
														 * .parse(jobdetails); $(
														 * "#pvlmdparcelinformation")
														 * .modal(); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_gid')
														 * .val(json_p.gid); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});

					$('#pvlmd_tr_btn_save_transaction_long')
							.on(
									'click',
									function(e) {

										var pvlmd_gid = document
												.getElementById("pvlmd_gid").value;

										var pvlmd_tr_t_id = document
												.getElementById("pvlmd_tr_t_id").value;

										var reference_number = document
												.getElementById("pvlmd_tr_reference_number").value;
										var file_number = document
												.getElementById("pvlmd_tr_file_number").value;
										var property_number = document
												.getElementById("pvlmd_tr_property_number").value;
										var submission_date = document
												.getElementById("pvlmd_tr_submission_date").value;
										var mutation_number = document
												.getElementById("pvlmd_tr_mutation_number").value;
										var deed_number = document
												.getElementById("pvlmd_tr_deed_number").value;
										var serial_number = document
												.getElementById("pvlmd_tr_serial_number").value;
										var sheet_number = document
												.getElementById("pvlmd_tr_sheet_number").value;
										var plan_number = document
												.getElementById("pvlmd_tr_plan_number").value;
										var plot_number = document
												.getElementById("pvlmd_tr_plot_number").value;
										var lvb_number = document
												.getElementById("pvlmd_tr_lvb_number").value;
										var instrument_date = document
												.getElementById("pvlmd_tr_instrument_date").value;
										var instrument_type = document
												.getElementById("pvlmd_tr_instrument_type").value;
										var doc_number = document
												.getElementById("pvlmd_tr_doc_number").value;
										var party1_plaintiff = document
												.getElementById("pvlmd_tr_party1_plaintiff").value;
										var party1_plaintiff_tel_no = document
												.getElementById("pvlmd_tr_party1_plaintiff_tel_no").value;
										var party1_plaintiff_email = document
												.getElementById("pvlmd_tr_party1_plaintiff_email").value;
										var party2_defendant = document
												.getElementById("pvlmd_tr_party2_defendant").value;
										var party2_defendant_tel_no = document
												.getElementById("pvlmd_tr_party2_defendant_tel_no").value;
										var party2_defendant_email = document
												.getElementById("pvlmd_tr_party2_defendant_email").value;
										var term = document
												.getElementById("pvlmd_tr_term").value;
										var commencement_date = document
												.getElementById("pvlmd_tr_commencement_date").value;
										var purpose = document
												.getElementById("pvlmd_tr_purpose").value;

										var consideration = document
												.getElementById("pvlmd_tr_consideration").value;
										var consideration_currency = document
												.getElementById("pvlmd_tr_consideration_currency").value;
										var premium = document
												.getElementById("pvlmd_tr_premium").value;
										var premium_currency = document
												.getElementById("pvlmd_tr_premium_currency").value;
										var compensation_status = document
												.getElementById("pvlmd_tr_compensation_status").value;

										var remarks = document
												.getElementById("pvlmd_tr_remarks").value;
										var suit_number = document
												.getElementById("pvlmd_tr_suit_number").value;
										var party1_plantiff_add = document
												.getElementById("pvlmd_tr_party1_plantiff_add").value;
										var party2_defendant_add = document
												.getElementById("pvlmd_tr_party2_defendant_add").value;
										var judgement_in_favour_of = document
												.getElementById("pvlmd_tr_judgement_in_favour_of").value;
										var floor_level = document
												.getElementById("pvlmd_tr_floor_level").value;
										var apartment_number = document
												.getElementById("pvlmd_tr_apartment_number").value;
										var rent = document
												.getElementById("pvlmd_tr_rent").value;

										var unit_description = document
												.getElementById("pvlmd_tr_unit_description").value;
										var consent_date = document
												.getElementById("pvlmd_tr_consent_date").value;
										var plot_number = document
												.getElementById("pvlmd_tr_plot_number").value;

										console.log(pvlmd_tr_t_id)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'save_pvlmd_transaction',
														reference_number : reference_number,
														file_number : file_number,
														property_number : property_number,
														submission_date : submission_date,
														mutation_number : mutation_number,
														deed_number : deed_number,
														serial_number : serial_number,
														sheet_number : sheet_number,
														plan_number : plan_number,
														plot_number : plot_number,
														lvb_number : lvb_number,
														instrument_date : instrument_date,
														instrument_type : instrument_type,
														doc_number : doc_number,
														party1_plaintiff : party1_plaintiff,
														party1_plaintiff_tel_no : party1_plaintiff_tel_no,
														party1_plaintiff_email : party1_plaintiff_email,
														party2_defendant : party2_defendant,
														party2_defendant_tel_no : party2_defendant_tel_no,
														party2_defendant_email : party2_defendant_email,
														term : term,
														commencement_date : commencement_date,
														purpose : purpose,

														consideration : consideration,
														consideration_currency : consideration_currency,
														premium : premium,
														premium_currency : premium_currency,
														compensation_status : compensation_status,

														remarks : remarks,
														suit_number : suit_number,
														party1_plantiff_add : party1_plantiff_add,
														party2_defendant_add : party2_defendant_add,
														judgement_in_favour_of : judgement_in_favour_of,
														floor_level : floor_level,
														apartment_number : apartment_number,
														rent : rent,
														gid_id_fk : pvlmd_gid,
														unit_description : unit_description,
														consent_date : consent_date,
														t_id : pvlmd_tr_t_id

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

														$(
																'#addpvlmdtransactionlong')
																.modal('hide');
														/*
														 * var json_p = JSON
														 * .parse(jobdetails); $(
														 * "#pvlmdparcelinformation")
														 * .modal(); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_gid')
														 * .val(json_p.gid); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#pvlmdparcelinformation
														 * #pvlmd_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});

					$('#pvlmd_btn_download_geojson')
							.on(
									'click',
									function(e) {

										var confirmText = "Are you sure you want to download geojson of affected parcels?";
										if (confirm(confirmText)) {

											var wktplygonsearch = $(
													'#pvlmd_bl_wkt_polygon')
													.val();
											var request = new XMLHttpRequest();
											/*
											 * var params = '{"vr_polygon":"'+
											 * wktplygonsearch
											 * +'","request_type":"select_consolidated_internal_search_report_geom"}';
											 * 
											 * request.onreadystatechange =
											 * function() { if (this.readyState ==
											 * 4 && this.status == 200) {
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

															if (json_p !== undefined
																	|| json_p !== null) {
																// var
																// featureCount
																// =
																// pvlmd_searchLayer.getSource().getFeatures().length;
																// console.log(featureCount);

																var blob = new Blob(
																		[ json_p.garro.features ],
																		{
																			type : 'application/octet-stream'
																		});

																url = URL
																		.createObjectURL(blob);
																var link = document
																		.createElement('a');
																link
																		.setAttribute(
																				'href',
																				url);
																link
																		.setAttribute(
																				'download',
																				'example.json');

																var event = document
																		.createEvent('MouseEvents');
																event
																		.initMouseEvent(
																				'click',
																				true,
																				true,
																				window,
																				1,
																				0,
																				0,
																				0,
																				0,
																				false,
																				false,
																				false,
																				false,
																				0,
																				null);
																link
																		.dispatchEvent(event);

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
																	garro_search_result_searchLayer
																			.setSource(new ol.source.Vector(
																					{
																						features : (new ol.format.GeoJSON())
																								.readFeatures(json_p.garro)
																					}));
																	/*
																	 * var
																	 * features =
																	 * pvlmd_searchLayer.getSource().getFeatures();
																	 * for (var
																	 * i in
																	 * features) {
																	 * var
																	 * feature =
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
																view
																		.fit(pvlmd_current_search_result_searchLayer
																				.getSource()
																				.getExtent());
																map
																		.getView()
																		.fit(
																				pvlmd_current_search_result_searchLayer
																						.getSource()
																						.getExtent(),
																				{
																					size : pvlmd_map
																							.getSize(),
																					maxZoom : 16
																				})

															} else {

															}

														}
													});

										}

									});

					document
							.getElementById('pvlmd_btnprintmap')
							.addEventListener(
									'click',
									function(e) {
										console.log("click_type");

										var wktplygonsearch = $(
												'#pvlmd_bl_wkt_polygon').val();

										// wktplygonsearch
										// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_pvlmd]')[0].getValue();

										var canvas = document.getElementById(
												"pvlmd-map")
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

					function getResolutionFromScale(scale) {
						var units = pvlmd_map.getView().getProjection()
								.getUnits();
						var dpi = 25.4 / 0.28;
						var mpu = ol.proj.METERS_PER_UNIT[units];
						var resolution = scale / (mpu * 39.37 * dpi);
						return resolution;
					}

				});
