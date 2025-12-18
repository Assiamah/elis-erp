$(document)
		.ready(
				function() {

					var dlrev_parcel_lrd_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/dlrev_spatial/wms',
								params : {
									'LAYERS' : 'dlrev_spatial:kml_from_lupmis',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var dlrev_lrd_parcels_dataLayer = new ol.layer.Tile({
						title : 'LRD Parcels Layer',
						source : dlrev_parcel_lrd_dataSource

					})

					var dlrev_googleLayerHybrid = new ol.layer.Tile(
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

					var dlrev_new_de = new ol.layer.Tile({
						title : "Open Street Map",
						// 'type': 'base',
						visible : false,
						source : new ol.source.OSM({
							wrapX : false
						}),
					// projection: 'EPSG:4326'
					})

					var dlrev_source = new ol.source.Vector({
						wrapX : false
					});

					var pvlmd_view_e = new ol.View({

						// 4326
						// projection: projObj,
						projection : 'EPSG:4326',
						center : [ 0.41, 4.82 ],
						// center: ol.proj.transform([0.41, 4.82], 'EPSG:2136'),
						zoom : 5
					})

					var vector = new ol.layer.Vector({
						'type' : 'base',
						source : dlrev_source
					});

					var dlrev_map = new ol.Map({
						target : 'dlrev-map',
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
						view : pvlmd_view_e
					});

					// map.addLayer(new_de);
					dlrev_map.addLayer(dlrev_googleLayerHybrid);

					dlrev_map.addLayer(dlrev_lrd_parcels_dataLayer);

					dlrev_map
							.on(
									'click',
									function(evt) {

										$("#dlrevparcelinformation").modal();

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
											var url = dlrev_dlrev_current_dataSource
													.getGetFeatureInfoUrl(
															evt.coordinate,
															viewResolution,
															viewProjection,
															{
																'INFO_FORMAT' : 'application/json',
																'propertyName' : 'remarks,src_info,src_date,dlrevid,sheet_number,file_number,property_number,reference_number,data_of_clearness,town_name,type_of_plotting,active_status,source_of_data,gid_unique_across,plotting_date,plotted_by,plotted_by_id,checked_by,checked_by_id,checked_by_date,locality,plan_number,plot_number,regional_code,is_sync,cro_reference,nt_number',
																'FEATURE_COUNT' : 50
															});

											var thislayer = dlrev_dlrev_current_dataLayer
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

																	// store_1.clearData();
																	// store_1.load();

																	// var grid
																	// =
																	// Ext.getCmp("Grid");
																	// // Grid =
																	// id of
																	// GridPanel
																	// grid.show();

																	var store_1 = Ext
																			.create(
																					'Ext.data.Store',
																					{

																						autoLoad : true,
																						fields : [
																								{
																									name : 'fid',
																									type : 'string'
																								},
																								{
																									name : 'locality',
																									type : 'string'
																								},
																								{
																									name : 'plotted_by',
																									type : 'string'
																								},
																								{
																									name : 'checked_by',
																									type : 'string'
																								},
																								{
																									name : 'reference_number',
																									type : 'string'
																								},
																								{
																									name : 'type_of_plotting',
																									type : 'string'
																								},
																								{
																									name : 'date_plott',
																									type : 'string'
																								},

																						],
																						data : features_data_array,
																						paging : false
																					});

																	console
																			.log(store_1);
																	store_1
																			.loadData(features_data_array);
																	// grid.getStore().loadData(store_1);

																	// store_1.loadData(features_data_array);
																	// store_1.load({params:{start:0,
																	// limit:25}});
																	// grid.store
																	// =store_1;

																	var store_new = Ext.data.StoreManager
																			.lookup('parceloverlaydetailslist');
																	// store.clearData();
																	// store.removeAll();
																	store_new
																			.loadData(features_data_array);
																	console
																			.log(store_new);

																	// features
																	// =
																	// geoObject.features;

																	/*
																	 * Ext.Msg.show({
																	 * title:feature.length,
																	 * msg:
																	 * features, ;
																	 * .l
																	 * buttons:
																	 * Ext.Msg.OK
																	 * icon:
																	 * Ext.Msg.OK,
																	 * });
																	 */

																	// trigger
																	// the data
																	// store
																	// load
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
																				"#dlrevparcelinformation")
																				.modal();

																		$(
																				'#dlrevparcelinformation #dlrev_gid')
																				.val(
																						parcel_uuid);

																		$(
																				'#dlrevparcelinformation #dlrev_reference_number')
																				.val(
																						props.reference_number);

																		$(
																				'#dlrevparcelinformation #dlrev_nt_number')
																				.val(
																						props.nt_number);
																		$(
																				'#dlrevparcelinformation #dlrev_file_number')
																				.val(
																						props.file_number);

																		$(
																				'#dlrevparcelinformation #dlrev_cro_reference')
																				.val(
																						props.cro_reference);

																		$(
																				'#dlrevparcelinformation #dlrev_property_number')
																				.val(
																						props.property_number);
																		$(
																				'#dlrevparcelinformation #dlrev_locality')
																				.val(
																						props.locality);

																		$(
																				'#dlrevparcelinformation #dlrev_sheet_number')
																				.val(
																						props.sheet_number);

																		$(
																				'#dlrevparcelinformation #dlrev_plot_number')
																				.val(
																						props.plot_number);
																		$(
																				'#dlrevparcelinformation #dlrev_remarks')
																				.val(
																						props.remarks);

																		var table = $('#dlrev_transaction_dataTable');
																		table
																				.find(
																						"tbody tr")
																				.remove();
																		$
																				.ajax({
																					type : "POST",
																					url : 'Maps',
																					data : {
																						request_type : 'dlrev_transaction_select_by_reference_number',
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

																															+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#adddlrevtransactionlong" data-target-id="'
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

					$("#adddlrevtransactionlong")
							.on(
									"show.bs.modal",
									function(e) {
										var t_id = $(e.relatedTarget).data(
												'target-id');

										$("#dlrev_tr_t_id").val([]);

										$("#dlrev_tr_reference_number").val([]);
										$("#dlrev_tr_file_number").val([]);
										$("#dlrev_tr_property_number").val([]);
										$("#dlrev_tr_submission_date").val([]);
										$("#dlrev_tr_mutation_number").val([]);
										$("#dlrev_tr_deed_number").val([]);
										$("#dlrev_tr_serial_number").val([]);
										$("#dlrev_tr_sheet_number").val([]);
										$("#dlrev_tr_plan_number").val([]);
										$("#dlrev_tr_plot_number").val([]);
										$("#dlrev_tr_lvb_number").val([]);
										$("#dlrev_tr_instrument_date").val([]);
										$("#dlrev_tr_instrument_type").val([]);
										$("#dlrev_tr_doc_number").val([]);
										$("#dlrev_tr_party1_plaintiff").val([]);
										$("#dlrev_tr_party1_plaintiff_tel_no")
												.val([]);
										$("#dlrev_tr_party1_plaintiff_email")
												.val([]);
										$("#dlrev_tr_party2_defendant").val([]);
										$("#dlrev_tr_party2_defendant_tel_no")
												.val([]);
										$("#dlrev_tr_party2_defendant_email")
												.val([]);
										$("#dlrev_tr_term").val([]);
										$("#dlrev_tr_commencement_date")
												.val([]);
										$("#dlrev_tr_purpose").val([]);

										$("#dlrev_tr_consideration").val([]);
										$("#dlrev_tr_consideration_currency")
												.val([]);
										$("#dlrev_tr_premium").val([]);
										$("#dlrev_tr_premium_currency").val([]);
										$("#dlrev_tr_compensation_status").val(
												[]);

										$("#dlrev_tr_remarks").val([]);
										$("#dlrev_tr_suit_number").val([]);
										$("#dlrev_tr_party1_plantiff_add").val(
												[]);
										$("#dlrev_tr_party2_defendant_add")
												.val([]);
										$("#dlrev_tr_judgement_in_favour_of")
												.val([]);
										$("#dlrev_tr_floor_level").val([]);
										$("#dlrev_tr_apartment_number").val([]);
										$("#dlrev_tr_rent").val([]);

										$("#dlrev_tr_unit_description").val([]);
										$("#dlrev_tr_consent_date").val([]);
										$("#dlrev_tr_t_id").val([]);

										if (t_id) {

											$
													.ajax({
														type : "POST",
														url : 'Maps',
														data : {
															request_type : 'select_dlrev_transactions_details_by_t_id',
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
																						'#adddlrevtransactionlong #lrd_td_nature_of_instument')
																						.val(
																								this.nature_of_instument);

																				$(
																						"#adddlrevtransactionlong #dlrev_tr_t_id")
																						.val(
																								this.t_id);

																				$(
																						"#adddlrevtransactionlong #dlrev_tr_reference_number")
																						.val(
																								this.reference_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_file_number")
																						.val(
																								this.file_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_property_number")
																						.val(
																								this.property_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_submission_date")
																						.val(
																								this.submission_date);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_mutation_number")
																						.val(
																								this.mutation_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_deed_number")
																						.val(
																								this.deed_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_serial_number")
																						.val(
																								this.serial_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_sheet_number")
																						.val(
																								this.sheet_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_plan_number")
																						.val(
																								this.plan_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_plot_number")
																						.val(
																								this.plot_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_lvb_number")
																						.val(
																								this.lvb_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_instrument_date")
																						.val(
																								this.instrument_date);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_instrument_type")
																						.val(
																								this.instrument_type);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_doc_number")
																						.val(
																								this.doc_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party1_plaintiff")
																						.val(
																								this.party1_plaintiff);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party1_plaintiff_tel_no")
																						.val(
																								this.party1_plaintiff_tel_no);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party1_plaintiff_email")
																						.val(
																								this.party1_plaintiff_email);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party2_defendant")
																						.val(
																								this.party2_defendant);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party2_defendant_tel_no")
																						.val(
																								this.party2_defendant_tel_no);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party2_defendant_email")
																						.val(
																								this.party2_defendant_email);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_term")
																						.val(
																								this.term);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_commencement_date")
																						.val(
																								this.commencement_date);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_purpose")
																						.val(
																								this.purpose);

																				$(
																						"#adddlrevtransactionlong #dlrev_tr_consideration")
																						.val(
																								this.consideration);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_consideration_currency")
																						.val(
																								this.consideration_currency);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_premium")
																						.val(
																								this.premium);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_premium_currency")
																						.val(
																								this.premium_currency);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_compensation_status")
																						.val(
																								this.compensation_status);

																				$(
																						"#adddlrevtransactionlong #dlrev_tr_remarks")
																						.val(
																								this.remarks);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_suit_number")
																						.val(
																								this.suit_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party1_plantiff_add")
																						.val(
																								this.party1_plantiff_add);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_party2_defendant_add")
																						.val(
																								this.party2_defendant_add);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_judgement_in_favour_of")
																						.val(
																								this.judgement_in_favour_of);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_floor_level")
																						.val(
																								this.floor_level);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_apartment_number")
																						.val(
																								this.apartment_number);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_rent")
																						.val(
																								this.rent);

																				$(
																						"#adddlrevtransactionlong #dlrev_tr_unit_description")
																						.val(
																								this.unit_description);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_consent_date")
																						.val(
																								this.consent_date);
																				$(
																						"#adddlrevtransactionlong #dlrev_tr_t_id")
																						.val(
																								this.t_id);

																			});

														}
													});

										}

									});

					document
							.getElementById('dlrev_btn_show_location')
							.addEventListener(
									'click',
									function() {

										var radioValue = $(
												"input[name='interaction_type']:checked")
												.val();

										if (radioValue) {

											alert("Your are a - " + radioValue);

										}

										console.log('you');
										markers.getSource().clear()
										var x_coordinate_mak = $(
												'#dlrev_x_coordinate_mak')
												.val();
										var y_coordinate_mak = $(
												'#dlrev_y_coordinate_mak')
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

										// dlrev_searchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.format.WKT()).readFeatures(polygon_tttt)}));
										// var marker = new ol.Feature(new
										// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
										// x_coordinate_mak])));
										markers.getSource().addFeature(marker);

										// dlrev_searchLayer.setSource(new
										// ol.source.Vector({features: (new
										// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

										// view.fit(markers.getSource().getExtent());
										// var extent =
										// dlrev_searchLayer.getSource().getExtent();
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

					document
							.getElementById('dlrev_btn_visualise_coordinate')
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

										$('#dlrev_bl_wkt_polygon').val(
												polygon_tttt);
										// var wktplygonsearch =
										// $('#lc_fr_bl_wkt_polygon').val();
										// Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_dlrev]')[0].setValue(polygon_tttt);

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

										dlrev_lc_searchLayer
												.setSource(new ol.source.Vector(
														{
															features : (new ol.format.WKT())
																	.readFeatures(polygon_tttt)
														}));
										view.fit(dlrev_lc_searchLayer
												.getSource().getExtent());

										dlrev_map.getView().fit(
												dlrev_lc_searchLayer
														.getSource()
														.getExtent(), {
													size : map.getSize(),
													maxZoom : 16
												})

									});

					document
							.getElementById('dlrev_btn_visualise_search')
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
															// dlrev_searchLayer.getSource().getFeatures().length;
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
															if (dlrev_current_search_result_searchLayer
																	.getSource() != null) {
																dlrev_current_search_result_searchLayer
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
																 * dlrev_searchLayer.getSource().getFeatures();
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
															if (json_p.dlrevcurrent === undefined
																	|| json_p.dlrevcurrent.features === null) {
															} else {
																dlrev_current_search_result_searchLayer
																		.setSource(new ol.source.Vector(
																				{
																					features : (new ol.format.GeoJSON())
																							.readFeatures(json_p.dlrevcurrent)
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
																	.fit(dlrev_current_search_result_searchLayer
																			.getSource()
																			.getExtent());
															map
																	.getView()
																	.fit(
																			dlrev_current_search_result_searchLayer
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
							.getElementById('dlrev_btn_save_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("dlrev_bl_wkt_polygon").value;
										console.log(wktplygonsearch)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'dlrev_polygon_for_save',
														wkt_polgon : wktplygonsearch,
														dlrev_unit : '',
														dlrev_plot_type : '',
														number_format : ''
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

														var json_p = JSON
																.parse(jobdetails);

														$(
																"#dlrevparcelinformation")
																.modal();

														$(
																'#dlrevparcelinformation #dlrev_gid')
																.val(json_p.gid);
														$(
																'#dlrevparcelinformation #dlrev_reference_number')
																.val(
																		json_p.reference_number);
														$(
																'#dlrevparcelinformation #dlrev_nt_number')
																.val(
																		json_p.nt_number);

													}
												});

									});

					document
							.getElementById('btn_save_dlrev_parcel_details')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v

										var gid = document
												.getElementById("dlrev_gid").value;

										var file_number = document
												.getElementById("dlrev_file_number").value;
										var reference_number = document
												.getElementById("dlrev_reference_number").value;

										var property_number = document
												.getElementById("dlrev_property_number").value;
										var cro_reference = document
												.getElementById("dlrev_cro_reference").value;

										var plot_number = document
												.getElementById("dlrev_plot_number").value;
										var locality = document
												.getElementById("dlrev_locality").value;

										var sheet_number = document
												.getElementById("dlrev_sheet_number").value;
										var remarks = document
												.getElementById("dlrev_remarks").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'select_update_dlrev_parcels',
														gid : gid,
														sheet_number : sheet_number,
														file_number : file_number,
														reference_number : reference_number,
														property_number : property_number,
														cro_reference : cro_reference,
														plot_number : plot_number,
														locality : locality,
														remarks : remarks
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
														 * "#dlrevparcelinformation")
														 * .modal(); $(
														 * '#dlrevparcelinformation
														 * #dlrev_gid')
														 * .val(json_p.gid); $(
														 * '#dlrevparcelinformation
														 * #dlrev_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#dlrevparcelinformation
														 * #dlrev_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});

					$('#adddlrevtransactionlong').on(
							'show.bs.modal',
							function(event) {
								var button = $(event.relatedTarget) // Button
								// that
								// triggered
								// the
								// modal

								$("#dlrev_tr_gid").val($("#dlrev_gid").val());

								$("#dlrev_tr_reference_number").val(
										$("#dlrev_reference_number").val());
								$("#dlrev_tr_nt_number").val(
										$("#dlrev_nt_number").val());
								$("#dlrev_tr_file_number").val(
										$("#dlrev_file_number").val());
								$("#dlrev_tr_cro_reference").val(
										$("#dlrev_cro_reference").val());

								$("#dlrev_tr_property_number").val(
										$("#dlrev_property_number").val());
							});

					document
							.getElementById(
									'dlrev_tr_btn_save_transaction_long')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v

										var dlrev_gid = document
												.getElementById("dlrev_gid").value;

										var dlrev_tr_t_id = document
												.getElementById("dlrev_tr_t_id").value;

										var reference_number = document
												.getElementById("dlrev_tr_reference_number").value;
										var file_number = document
												.getElementById("dlrev_tr_file_number").value;
										var property_number = document
												.getElementById("dlrev_tr_property_number").value;
										var submission_date = document
												.getElementById("dlrev_tr_submission_date").value;
										var mutation_number = document
												.getElementById("dlrev_tr_mutation_number").value;
										var deed_number = document
												.getElementById("dlrev_tr_deed_number").value;
										var serial_number = document
												.getElementById("dlrev_tr_serial_number").value;
										var sheet_number = document
												.getElementById("dlrev_tr_sheet_number").value;
										var plan_number = document
												.getElementById("dlrev_tr_plan_number").value;
										var plot_number = document
												.getElementById("dlrev_tr_plot_number").value;
										var lvb_number = document
												.getElementById("dlrev_tr_lvb_number").value;
										var instrument_date = document
												.getElementById("dlrev_tr_instrument_date").value;
										var instrument_type = document
												.getElementById("dlrev_tr_instrument_type").value;
										var doc_number = document
												.getElementById("dlrev_tr_doc_number").value;
										var party1_plaintiff = document
												.getElementById("dlrev_tr_party1_plaintiff").value;
										var party1_plaintiff_tel_no = document
												.getElementById("dlrev_tr_party1_plaintiff_tel_no").value;
										var party1_plaintiff_email = document
												.getElementById("dlrev_tr_party1_plaintiff_email").value;
										var party2_defendant = document
												.getElementById("dlrev_tr_party2_defendant").value;
										var party2_defendant_tel_no = document
												.getElementById("dlrev_tr_party2_defendant_tel_no").value;
										var party2_defendant_email = document
												.getElementById("dlrev_tr_party2_defendant_email").value;
										var term = document
												.getElementById("dlrev_tr_term").value;
										var commencement_date = document
												.getElementById("dlrev_tr_commencement_date").value;
										var purpose = document
												.getElementById("dlrev_tr_purpose").value;

										var consideration = document
												.getElementById("dlrev_tr_consideration").value;
										var consideration_currency = document
												.getElementById("dlrev_tr_consideration_currency").value;
										var premium = document
												.getElementById("dlrev_tr_premium").value;
										var premium_currency = document
												.getElementById("dlrev_tr_premium_currency").value;
										var compensation_status = document
												.getElementById("dlrev_tr_compensation_status").value;

										var remarks = document
												.getElementById("dlrev_tr_remarks").value;
										var suit_number = document
												.getElementById("dlrev_tr_suit_number").value;
										var party1_plantiff_add = document
												.getElementById("dlrev_tr_party1_plantiff_add").value;
										var party2_defendant_add = document
												.getElementById("dlrev_tr_party2_defendant_add").value;
										var judgement_in_favour_of = document
												.getElementById("dlrev_tr_judgement_in_favour_of").value;
										var floor_level = document
												.getElementById("dlrev_tr_floor_level").value;
										var apartment_number = document
												.getElementById("dlrev_tr_apartment_number").value;
										var rent = document
												.getElementById("dlrev_tr_rent").value;

										var unit_description = document
												.getElementById("dlrev_tr_unit_description").value;
										var consent_date = document
												.getElementById("dlrev_tr_consent_date").value;
										var plot_number = document
												.getElementById("dlrev_tr_t_id").value;

										console.log(reference_number)

										$
												.ajax({
													type : "POST",
													url : "Maps",
													// target : '_blank',
													data : {
														request_type : 'save_dlrev_transaction',
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
														gid_id_fk : dlrev_gid,
														unit_description : unit_description,
														consent_date : consent_date,
														t_id : dlrev_tr_t_id

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
														 * "#dlrevparcelinformation")
														 * .modal(); $(
														 * '#dlrevparcelinformation
														 * #dlrev_gid')
														 * .val(json_p.gid); $(
														 * '#dlrevparcelinformation
														 * #dlrev_reference_number')
														 * .val(
														 * json_p.reference_number); $(
														 * '#dlrevparcelinformation
														 * #dlrev_nt_number')
														 * .val(
														 * json_p.nt_number);
														 */

													}
												});

									});

					document
							.getElementById('lc_btn_visualise_wkt')
							.addEventListener(
									'click',
									function() {
										// wktplygonsearch
										// v
										// console.log(wktplygonsearch)

										// var wktplygonsearch =
										// $('#lc_bl_wkt_polygon').val();
										var wktplygonsearch = document
												.getElementById("dlrev_bl_wkt_polygon").value;
										console.log(wktplygonsearch)

									});

					document
							.getElementById('dlrev_btnprintmap')
							.addEventListener(
									'click',
									function() {
										console.log("click_type");

										var wktplygonsearch = $(
												'#lc_bl_wkt_polygon').val();

										// wktplygonsearch
										// wktplygonsearch=Ext.ComponentQuery.query('textareafield[name=wktplygonsearch_dlrev]')[0].getValue();

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
												'dlrev Current Parcel')

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
															// dlrev_searchLayer.getSource().getFeatures().length;
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
																// dlrev_searchLayer.setSource(new
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
																// dlrev_searchLayer.setSource(new
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

															if (json_p.dlrevcurrent === undefined
																	|| json_p.dlrevcurrent === null) {

																var data_rows = [ {
																	main_description : 'No Recorded Transaction'
																} ];
																var columns = [ {
																	title : 'dlrev Current Layer',
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
																// dlrev_searchLayer.setSource(new
																// ol.source.Vector({features:
																// (new
																// ol.format.GeoJSON()).readFeatures(json_p.cro)}));
																// doc.addPage('a4',
																// 'l');
																// doc.setFontSize(12)
																// doc.text(20,
																// 30,
																// 'dlrev
																// Current
																// Layer')

																transaction_data = json_p.dlrevcurrent;

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
																// dlrev_searchLayer.setSource(new
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
																// dlrev_searchLayer.setSource(new
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
																// dlrev_searchLayer.setSource(new
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
															// view.fit(dlrev_searchLayer.getSource().getExtent());
															// map.getView().fit(dlrev_searchLayer.getSource().getExtent(),
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