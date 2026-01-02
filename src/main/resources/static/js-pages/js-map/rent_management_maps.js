$(document)
	.ready(
		function () {

			var lrd_click_type = 'MapClick';
			var rent_cadastral_smd_dataSource = new ol.source.TileWMS(
				{
					url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					params: {
						'LAYERS': 'csau_geospatial:gove_estates',
						'TILED': true
					},
					// params: {'LAYERS':
					// 'rating:spatial_unit_assembly', 'cql_filter':
					// "assembly_code='AMA'" , 'TILED': true },,
					serverType: 'geoserver',
					transition: 0
				})

			var rent_cadastral_smd_dataLayer = new ol.layer.Tile({
				title: 'Government Estate Boundary',
				source: rent_cadastral_smd_dataSource

			})

			// Create a WFS URL builder function
			function getWFSFeatureURL(layerName, outputFormat = 'application/json', maxFeatures = 50) {
			const baseURL = getGeoServerEndPoint() + '/geoserver/csau_geospatial/ows';
			const params = {
				service: 'WFS',
				version: '1.0.0',
				request: 'GetFeature',
				typeName: layerName,
				outputFormat: outputFormat,
				maxFeatures: maxFeatures
			};
			
			return baseURL + '?' + new URLSearchParams(params).toString();
			}

			// Usage:
			const wfsUrl = getWFSFeatureURL('csau_geospatial:gove_estates_parcels');
			//console.log(wfsUrl); // Will output URL like your example


			var rent_pvlmd_current_dataSource = new ol.source.TileWMS(
				{
					url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					params: {
						'LAYERS': 'csau_geospatial:gove_estates_parcels',
						'TILED': true
					},
					// params: {'LAYERS':
					// 'rating:spatial_unit_assembly', 'cql_filter':
					// "assembly_code='AMA'" , 'TILED': true },,
					serverType: 'geoserver',
					transition: 0
				})

			var rent_pvlmd_current_dataLayer = new ol.layer.Tile({
				title: 'Government Estate Parcels',
				// visible: false,
				source: rent_pvlmd_current_dataSource

			})

			var rent_grid_lrd_dataSource = new ol.source.TileWMS(
				{
					url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					params: {
						'LAYERS': 'csau_geospatial:gng_grid',
						'TILED': true
					},
					// params: {'LAYERS':
					// 'rating:spatial_unit_assembly', 'cql_filter':
					// "assembly_code='AMA'" , 'TILED': true },,
					serverType: 'geoserver',
					transition: 0
				})

			var rent_grid_lrd_dataLayer = new ol.layer.Tile({
				title: 'LRD Grid',
				visible: false,
				source: rent_grid_lrd_dataSource

			})



			// 104_modified_CR
			// DIST_03_01_A_modified

			var rent_StaticImage = new ol.layer.Image({
				title: 'Scanned Map',
				// extent: [-13884991, 2870341, -7455066, 6338219],
				visible: true,
				source: undefined,
				/*
				 * source: new ol.source.ImageWMS({ url:
				 * getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
				 * params: {'LAYERS': 'csau_geospatial:104_modified_CR'},
				 * serverType: 'geoserver', })
				 */
			});



			rent_lc_searchLayer = new ol.layer.Vector({
				title: 'Search Layer',
				source: undefined,
				style: new ol.style.Style({
					stroke: new ol.style.Stroke({
						color: 'red',
						width: 3
					})
				})
			});

			var rent_markers = new ol.layer.Vector({
				// title: 'Markers',
				source: new ol.source.Vector(),
				// style: iconStyle

				/*
				 * new ol.style.Style({
				 * 
				 * image: new ol.style.Icon({ anchor: [0.5, 1], src:
				 * 'marker.png' }) })
				 */
			});

			// var all_layers = [vectorwkt];

			var london = ol.proj.fromLonLat([-0.12755, 51.507222]), istanbul = ol.proj
				.fromLonLat([28.9744, 41.0128]), view = new ol.View(
					{
						center: istanbul,
						zoom: 5
					});
			var vectorLayer;

			// var all_layers = [pvlmdparcelsLayer,vectorLayer];
			// var all_layers = [pvlmdparcelsLayer];
			// 

			// create a vector layer used for editing
			var rent_vector_layer = new ol.layer.Vector({
				name: 'my_vectorlayer',
				source: new ol.source.Vector(),
				style: new ol.style.Style({
					fill: new ol.style.Fill({
						color: 'rgba(255, 255, 255, 0.2)'
					}),
					stroke: new ol.style.Stroke({
						color: '#ffcc33',
						width: 2
					}),
					image: new ol.style.Circle({
						radius: 7,
						fill: new ol.style.Fill({
							color: '#ffcc33'
						})
					})
				})
			});

			var rent_features = new ol.Collection();
			var rent_featureOverlay = new ol.layer.Vector({
				source: new ol.source.Vector({
					features: rent_features
				}),
				style: new ol.style.Style({
					fill: new ol.style.Fill({
						color: 'rgba(255, 255, 255, 0.2)'
					}),
					stroke: new ol.style.Stroke({
						color: '#ffcc33',
						width: 2
					}),
					image: new ol.style.Circle({
						radius: 7,
						fill: new ol.style.Fill({
							color: '#ffcc33'
						})
					})
				})
			});

			var rent_googleLayerHybrid = new ol.layer.Tile(
				{
					title: "Google Satellite & Roads",
					// 'type': 'base',
					visible: false,
					'opacity': 1.000000,
					source: new ol.source.XYZ(
						{
							attributions: [new ol.Attribution(
								{
									html: '<a href=""></a>'
								})],
							url: 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
						}),
				});

			var rent_new_de = new ol.layer.Tile({
				title: "Open Street Map",
				// 'type': 'base',
				visible: false,
				source: new ol.source.OSM({
					wrapX: false
				}),
				// projection: 'EPSG:4326'
			})

			var rent_source = new ol.source.Vector({
				wrapX: false
			});

			var vector = new ol.layer.Vector({
				'type': 'base',
				source: rent_source
			});

			var rent_projObj = new ol.proj.Projection({
				// code: 'EPSG:3857',
				code: 'EPSG:2136',
				extent: [80935.4497355444, 1209.0295731349593,
					1711780.3060929566, 2358523.124783509],
				units: 'ft',
				axisOrientation: 'enu',
				global: false,
				// worldExtent: [-199,32,322,0],
				worldExtent: [-3.79, 1.4, 2.1, 11.16],
				getPointResolution: function (r) {
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

			var rent_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
			var rent_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';

			// console.log(firstProjection);
			// console.log(secondProjection);
			// proj4(firstProjection,secondProjection,[2,5]);
			// console.log(proj4(secondProjection,firstProjection,[2,5]));
			// ol.proj.proj4.register(proj4);
			// ol.proj.registerProj4(proj4);
			// register(proj4);

			var rent_proj27700 = ol.proj.get('EPSG:2136');
			// proj27700.setExtent([0, 0, 2011055.53818079,
			// 2360318.82691170]);
			rent_proj27700.setExtent([80935.4497355444,
				1209.0295731349593, 1711780.3060929566,
				2358523.124783509]);

			var rent_view_e = new ol.View({
				// center: ol.proj.fromLonLat([4.8, 47.75]),
				// center: ol.proj.transform([1187433.58822084,
				// 327091.107070208],
				// 'EPSG:4326','EPSG:3857'),
				projection: rent_projObj,
				// projection: 'EPSG:2136',
				// center: ol.proj.fromLonLat([1187433.58822084,
				// 327091.107070208],
				// projObj),
				// center: [956164.35527782, 584176.05990338],
				center: [1187433.58822084, 327091.107070208],
				// extent:projObj.getExtent(),
				extent: ol.proj.get('EPSG:2136').getExtent(),
				scales: [100000, 250000, 500000, 1000000, 2000000,
					4000000, 8000000],
				zoom: 12
			})

			var rent_map = new ol.Map({
				target: 'govrent-map',
				controls: ol.control.defaults().extend(
					[new ol.control.LayerSwitcher(),
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
				renderer: 'canvas',
				layers: [new ol.layer.Tile({
					title: 'Open Street',
					source: new ol.source.OSM()
				})],
				view: rent_view_e
			});

			// map.addLayer(new_de);
			rent_map.addLayer(rent_googleLayerHybrid);
			//rent_map.addLayer(rent_StaticImage);
			//rent_map.addLayer(rent_registration_district_dataLayer);

			//rent_map.addLayer(rent_grid_lrd_dataLayer);

			// map.addLayer(beacon_lrd_dataLayer);

			//rent_map.addLayer(rent_lrd_parcels_dataLayer);
			//rent_map.addLayer(rent_parcels_smd_dataLayer);
			rent_map.addLayer(rent_cadastral_smd_dataLayer);
			rent_map.addLayer(rent_pvlmd_current_dataLayer);
			rent_map.addLayer(rent_lc_searchLayer);

			rent_map
				.on(
					'click',
					function (evt) {

						//$("#addlegder").modal();

						// click_type= 'DrawClick'
						var viewResolution = rent_map.getView()
							.getResolution();
						var viewProjection = rent_map.getView()
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
							var url = rent_pvlmd_current_dataSource
								.getGetFeatureInfoUrl(
									evt.coordinate,
									viewResolution,
									viewProjection,
									{
										'INFO_FORMAT': 'application/json',
										'propertyName': 'gep_glpin,gep_locality,gep_land_size,gep_payment_status,gep_developed,gep_demand_note_served',
										'FEATURE_COUNT': 50
									});



							var thislayer = rent_pvlmd_current_dataLayer
								.getSource().getParams().LAYERS;
							console.log(thislayer);
							if (url) {
								console.log(url);

								var parser = new ol.format.GeoJSON();
								var lookup = {};

								$
									.ajax({
										type: "GET",
										url: url,
										cache: false,
										beforeSend: function () {
											// $('#district').html('<img
											// src="img/loading.gif"
											// alt=""
											// width="24"
											// height="24">');
										},
										success: function (
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


												// var obj = JSON
												// 	.parse(conn.responseText);
												// console
												// 	.log(obj);


													
												// var
												// geoObject
												// =
												// JSON.parse(conn.responseText);
												// var
												// features
												// = [];

												features_data_array = [];

												var features = serviceresponse.features;
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
														.log('parcel_uuid:'+parcel_uuid);

													feat['fid'] = parcel_uuid;
													features_data_array
														.push(feat);
												}
												console
													.log('features_data_array:'+features_data_array);


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

														getParcelDetails(
															parcel_uuid, 
															props.gep_glpin, 
															props.gep_locality, 
															props.gep_land_size, 
															props.gep_payment_status, 
															props.gep_developed, 
															props.gep_demand_note_served
														);

													//	gep_glpin,gep_locality,gep_land_size,gep_payment_status,gep_developed,gep_demand_note_served
													// $("#rentParcelDetails").modal();

													// $(
													// 	'#rentParcelDetails #pvlmd_gid')
													// 	.val(
													// 		parcel_uuid);

													// $(
													// 	'#rentParcelDetails #gep_glpin')
													// 	.val(
													// 		props.gep_glpin);

													// $(
													// 	'#rentParcelDetails #gep_land_size')
													// 	.val(
													// 		props.gep_land_size);
													// $(
													// 	'#rentParcelDetails #gep_payment_status')
													// 	.val(
													// 		props.gep_payment_status);

													// $(
													// 	'#rentParcelDetails #gep_developed')
													// 	.val(
													// 		props.gep_developed);

													// $(
													// 	'#rentParcelDetails #gep_demand_note_served')
													// 	.val(
													// 		props.gep_demand_note_served);
													

													// var table = $('#pvlmd_transaction_dataTable');
													// table.find("tbody tr").remove();
													// $
													// 	.ajax({
													// 		type: "POST",
													// 		url: 'Maps',
													// 		data: {
													// 			request_type: 'pvlmd_transaction_select_by_reference_number',
													// 			reference_number: props.reference_number,
													// 			gid_fk: parcel_uuid
													// 		},
													// 		cache: false,
													// 		beforeSend: function () {
													// 			// $('#district').html('<img
													// 			// src="img/loading.gif"
													// 			// alt=""
													// 			// width="24"
													// 			// height="24">');
													// 		},
													// 		success: function (
													// 			serviceresponse) {

													// 			var json_p = JSON
													// 				.parse(serviceresponse);
													// 			console
													// 				.log(json_p)

													// 			$(
													// 				json_p.data)
													// 				.each(
													// 					function () {

													// 						table
													// 							.append("<tr><td>"
													// 								+ this.party2_defendant
													// 								+ "</td><td>"
													// 								+ this.party1_plaintiff
													// 								+ "</td><td>"
													// 								+ this.reference_number
													// 								+ "</td><td>"
													// 								+ this.instrument_type
													// 								+ "</td>"

													// 								+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addpvlmdtransactionlong" data-target-id="'
													// 								+ this.t_id
													// 								+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

													// 								+ "</tr>");
													// 					});

													// 		}
													// 	});

													

												}
											}

										},
										failure: function (
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


					window.getParcelDetails = async function(parcel_uuid, gep_glpin, gep_locality, gep_land_size, gep_payment_status, gep_developed, gep_demand_note_served) {
						// try {
						// 	// Wait for the Promise to resolve
						// 	const rentID = await getTransactionIDSync(parcel_uuid, gep_glpin, gep_locality, gep_land_size, gep_payment_status, gep_developed, gep_demand_note_served);
							
						// 		console.log('rentID: '+rentID);
						// 	// Only load transaction history if rentID is not 0
						// 		if(rentID === 0) {
						// 			$("#transactionhistory").modal();
						// 			// Clear the table if rentID is 0
						// 			var table = $('#tbl_rent_transaction_history');
						// 			table.find("tbody tr").remove();

						// 			return;

						// 		} else {
								
						// 				$('#transactionhistory').on('shown.bs.modal', (e) => {
						// 					e.preventDefault();
						// 					$("#rtModalLabel").text("Rent Parcel Details");
						// 					$("#btnAddNewLessee").removeClass('d-none');
						// 					$("#exDatar").removeClass('d-none');
						// 					$("#rth_m_id").val(rentID); // Use the resolved value here
						// 					$("#xxr_glpin").val(gep_glpin);
						// 					$("#xxr_locality").val(gep_locality);
						// 					$("#xxr_plot_size").val(gep_land_size ?? 0.00);
						// 						console.log('rentID: '+rentID);

						// 						loadTransactionHistory(rentID);
											
						// 				});
						// }
							
						// } catch (error) {
						// 	console.error('Error getting transaction ID:', error);
						// 	// Handle the error appropriately (show message to user, etc.)
						// }

						$("#parcel_idxxxx").val(parcel_uuid)
						

						$.ajax({
							type: "POST",
							url: "Maps",
							data: {
								request_type: 'get_rent_transaction_id_by_parcel_uuid',
								parcel_uuid: parcel_uuid
							},
							cache: false,
							success: function(response) {
								
								var table_1 = $('#tbl_rent_transaction_history');
                    			table_1.find("tbody tr").remove();

								try {
								const result = JSON.parse(response);
								console.log('Transaction data:', result);

									if(result.data === null) {

										// var table = $('#tbl_rent_transaction_history');
                    					// table.find("tbody tr").remove();


										$("#rth_m_id").val(0);
										//reject(new Error('Invalid response format'));
										//$("#rth_m_id").val("0"); // Use the resolved value here
										$("#transactionhistory").modal();

										
										//$('#transactionhistory').on('shown.bs.modal', (e) => {
											//e.preventDefault();

											$("#rtModalLabel").text("Rent Parcel Details");
											$("#btnAddNewLessee").removeClass('d-none');
											$("#exDatar").removeClass('d-none');
											//$("#rth_m_id").val("0"); 
											$("#rt_parcel_id").val(parcel_uuid ?? 0); // Use the resolved value here
											$("#rt_glpin").val(gep_glpin);
											$("#rt_plot_size").val(gep_land_size ?? 0.00);
											$("#xxr_glpin").val(gep_glpin);
											$("#xxr_locality").val(gep_locality);
											$("#xxr_plot_size").val(gep_land_size ?? 0.00);
											
											// $("#rt_payment_status").val(gep_payment_status ?? 0);
											// $("#rt_developed").val(gep_developed ?? 0);
											// $("#rt_demand_note_served").val(gep_demand_note_served ?? 0);
											//loadTransactionHistory();
										//});
										
										//resolve(0);
										//loadParcelTransaction(parcel_uuid)
									} else {
										if (result && result.data[0].rl_id !== undefined) {

										$("#transactionhistory").modal();
										$("#rtModalLabel").text("Rent Parcel Details");
											$("#btnAddNewLessee").removeClass('d-none');
											$("#exDatar").removeClass('d-none');
											$("#rth_m_id").val(result.data[0].rl_id); // Use the resolved value here
											$("#xxr_glpin").val(gep_glpin);
											$("#xxr_locality").val(gep_locality);
											$("#xxr_plot_size").val(gep_land_size ?? 0.00);
												//console.log('rentID: '+rentID);

												//loadTransactionHistory(result.data[0].rl_id);
										//resolve(result.data[0].rl_id);
											loadParcelTransaction(parcel_uuid)
										} else {
											//reject(new Error('Missing rl_id in response'));
										}
									}
									// Make sure your server returns an object with rl_id property
								
									
								} catch (e) {
									console.error('Error parsing response:', e);
									//reject(new Error('Invalid JSON response'));
								}
							},
							error: function(xhr, status, error) {
								console.error('AJAX error:', status, error);
								//reject(new Error(`Request failed: ${error}`));
							}
						});

					}

					$("#addlegder").on('shown.bs.modal', function(e) {
							$(this).css('z-index', '1055');
							$(".modal-backdrop").not(':first').css('z-index', '1054'); // Keep only the first backdrop below

							var parcel_id = $("#parcel_idxxxx").val();
							$("#rt_parcel_id").val(parcel_id)
						});

					function getTransactionIDSync(parcel_uuid, gep_glpin, gep_locality, gep_land_size, gep_payment_status, gep_developed, gep_demand_note_served) {
						console.log('parcel_uuid:'+parcel_uuid)
						return new Promise((resolve, reject) => {
							$.ajax({
							type: "POST",
							url: "Maps",
							data: {
								request_type: 'get_rent_transaction_id_by_parcel_uuid',
								parcel_uuid: parcel_uuid
							},
							cache: false,
							success: function(response) {
								try {
								const result = JSON.parse(response);
								console.log('Transaction data:', result);

									if(result.data === null) {

										var table = $('#tbl_rent_transaction_history');
                    					table.find("tbody tr").remove();
										//reject(new Error('Invalid response format'));
										//$("#rth_m_id").val("0"); // Use the resolved value here
										//$("#transactionhistory").modal();
										
										//$('#transactionhistory').on('shown.bs.modal', (e) => {
											//e.preventDefault();

											$("#rtModalLabel").text("Rent Parcel Details");
											$("#btnAddNewLessee").removeClass('d-none');
											$("#exDatar").removeClass('d-none');
											$("#rth_m_id").val(0); 
											$("#rt_parcel_id").val(parcel_uuid ?? 0); // Use the resolved value here
											$("#rt_glpin").val(gep_glpin);
											$("#rt_plot_size").val(gep_land_size ?? 0.00);
											$("#xxr_glpin").val(gep_glpin);
											$("#xxr_locality").val(gep_locality);
											$("#xxr_plot_size").val(gep_land_size ?? 0.00);
											
											// $("#rt_payment_status").val(gep_payment_status ?? 0);
											// $("#rt_developed").val(gep_developed ?? 0);
											// $("#rt_demand_note_served").val(gep_demand_note_served ?? 0);
											//loadTransactionHistory();
										//});
										
										resolve(0);
									} else {
										if (result && result.data[0].rl_id !== undefined) {

										$("#transactionhistory").modal();
										resolve(result.data[0].rl_id);
										} else {
											reject(new Error('Missing rl_id in response'));
										}
									}
									// Make sure your server returns an object with rl_id property
								
									
								} catch (e) {
								console.error('Error parsing response:', e);
								reject(new Error('Invalid JSON response'));
								}
							},
							error: function(xhr, status, error) {
								console.error('AJAX error:', status, error);
								reject(new Error(`Request failed: ${error}`));
							}
							});
						});
					}

					$('#btn_rmap_search').click(function () {

						var rts_select_type = $('#rts_select_type').val();

						if(rts_select_type == 'Plot Number') {
							var rts_estate = $('#rts_estate').val();
							var rts_plot_number= $('#rts_keyword').val();

							if(!rts_estate || !rts_plot_number) {
								$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
								return;
							}

							searchByPlotNumber(rts_estate, rts_plot_number);

						} else if(rts_select_type == 'Estate') {
							var rts_estate = $('#rts_estate').val();

							if(!rts_estate) {
								$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
								return;
							}

							searchByEstate(rts_estate);
						}
					})

			//$('#cbo_estate_list').change(function () {

				function searchByEstate(rts_estate) {

				//var ge_id = $(this).val();
				var ge_id = rts_estate;
				ge_id = ge_id.replace('.0', '');
				console.log(ge_id);
				$.ajax({
					type: "POST",
					url: "rent_mgt_serv",
					data: {
						request_type: 'select_rt_govt_estates_get_wkt',
						ge_id: ge_id
					},
					cache: false,

					success: function (jobdetails) {

						console.log(jobdetails);
						var json_p = JSON.parse(jobdetails);

						rent_lc_searchLayer.setSource(new ol.source.Vector(
							{
								features: (new ol.format.WKT())
									.readFeatures(json_p.wkt)
							}));

						//rent_map.addLayer(rent_lc_searchLayer);
						rent_map.getView().fit(rent_lc_searchLayer
							.getSource().getExtent(),
							{
								size: rent_map.getSize(),
								maxZoom: 20
							})


					}
				});

			};

			function searchByPlotNumber(rts_estate, rts_plot_number){
				
			}


			$("#btnLinkExistingTrans").click(function () {
				var fileNumber = $("#fileNumberForExistingTransac").val();
				if(!fileNumber) {
					$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Please fill the required field.</span>' }, { type: 'danger' });
					return;
				}

				$.ajax({
					type: "POST",
					url: "Maps",
					data: {
						request_type: 'get_rent_transaction_id_by_file_number',
						file_number: fileNumber
					},
					cache: false,
					success: function(response) {
						try {
							const result = JSON.parse(response);
							console.log('Transaction data:', result);

							if(result.data == null) {
								$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">No transaction found.</span>' }, { type: 'danger' });
								return;
							}

							// Get the data object
							const data = result.data[0];
							
							// Lesee's Details
							$("#addlegder #rt_leasee_name").val(data.owners_name || "");
							$("#addlegder #rt_leasee_address").val(data.address || "");
							$("#addlegder #rt_email").val(data.email || "");
							$("#addlegder #rt_mobile_phone_1").val(data.mobile || "");
							$("#addlegder #rt_mobile_phone_2").val(data.mobile_1 || "");

							// Parcel's Details
							$("#addlegder #rt_convenant_user").val(data.covenanted_user || "");
							$("#addlegder #rt_current_use").val(data.current_use || "");
							$("#addlegder #rt_nature_of_dev").val(data.nature_of_devt || "");
							$("#addlegder #rt_plot_number").val(data.plot_number || "");
							$("#addlegder #rt_plot_size").val(data.plot_size || "");
							$("#addlegder #rt_parcel_address").val(data.parcel_address || "");
							$("#addlegder #rt_file_number").val(data.file_number || "");
							$("#addlegder #rt_ledger").val(data.ledger || "");
							$("#addlegder #rt_folio").val(data.folio || "");
							$("#addlegder #rt_ls_number").val(data.ls_number || "");
							$("#addlegder #rt_glpin").val(data.glpin || "");
							$("#addlegder #rt_nature_of_instrument").val(data.nature_of_instrument || "");

							// Additional Details
							$("#addlegder #rt_estate").val(data.estate+".0" || "");
							$("#addlegder #rt_rent_category").val(data.rent_category || "");
							$("#addlegder #rt_last_payment_period").val(data.last_payment_period || "");
							$("#addlegder #rt_commencement_date").val(data.comm_date || "");
							$("#addlegder #rt_term").val(data.term || "");
							$("#addlegder #rt_last_payment_date").val(data.last_payment_date || "");
							$("#addlegder #rt_rent_review_clause").val(data.rent_review_clause || "");
							$("#addlegder #rt_rent_outstanding").val(data.rent_outstanding || "");
							$("#addlegder #rt_remarks").val(data.remarks || "");
							$("#addlegder #rt_period_in_arrears").val(data.period_in_arrears || "");
							$("#addlegder #rt_rent_passing").val(data.rent_passing || "");
							$("#addlegder #rt_location_rate").val(data.location_rate || "");

							// Set hidden fields if needed
							$("#addlegder #rt_rent_id").val(data.rl_id || "0");
							//$("#rt_parcel_id").val(data.parcel_id || "0");

							$.notify({ message: '<i class="fa fa-check-circle fa-fw"></i><span class="text-bold">Transaction data loaded successfully.</span>' }, { type: 'success' });

						} catch (e) {
							console.error('Error parsing response:', e);
							$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Error loading transaction data.</span>' }, { type: 'danger' });
						}
					},
					error: function(xhr, status, error) {
						console.error('AJAX error:', error);
						$.notify({ message: '<i class="fa fa-times-circle fa-fw"></i><span class="text-bold">Failed to load transaction data.</span>' }, { type: 'danger' });
					}
				});
			});
						

			$("#addpvlmdtransactionlong")
				.on(
					"show.bs.modal",
					function (e) {
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
									type: "POST",
									url: 'Maps',
									data: {
										request_type: 'select_pvlmd_transactions_details_by_t_id',
										t_id: t_id
									},
									cache: false,
									beforeSend: function () {
										// $('#district').html('<img
										// src="img/loading.gif"
										// alt="" width="24"
										// height=gid_id_fk"24">');
									},
									success: function (
										serviceresponse) {

										var json_p = JSON
											.parse(serviceresponse);
										console.log(json_p)

										$(json_p.data)
											.each(
												function () {

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



			$("#rent_btn_show_location")
				.click(
					function (event) {

						var radioValue = $(
							"input[name='interaction_type']:checked")
							.val();

						if (radioValue) {

							alert("Your are a - " + radioValue);

						}

						console.log('you');
						markers.getSource().clear()
						var x_coordinate_mak = $(
							'#rent_x_coordinate_mak')
							.val();
						var y_coordinate_mak = $(
							'#rent_y_coordinate_mak')
							.val();

						var marker = new ol.Feature({
							geometry: new ol.geom.Point([
								x_coordinate_mak,
								y_coordinate_mak])
							// dont worry about coordinate type 0,0
							// will be in west coast of
							// africa
						});
						// source.addFeature(marker);

						// rent_searchLayer.setSource(new
						// ol.source.Vector({features: (new
						// ol.format.WKT()).readFeatures(polygon_tttt)}));
						// var marker = new ol.Feature(new
						// ol.geom.Point(ol.proj.fromLonLat([y_coordinate_mak,
						// x_coordinate_mak])));
						markers.getSource().addFeature(marker);

						// rent_searchLayer.setSource(new
						// ol.source.Vector({features: (new
						// ol.geom.Point([y_coordinate_mak,x_coordinate_mak]))}));

						// view.fit(markers.getSource().getExtent());
						// var extent =
						// rent_searchLayer.getSource().getExtent();
						rent_map.getView()
							.fit(
								markers.getSource()
									.getExtent(),
								{
									size: rent_map
										.getSize(),
									maxZoom: 16
								})
					});



			$("#rent_btn_visualise_coordinate")
				.click(
					function (event) {

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
								function () {

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

						$('#rent_bl_wkt_polygon').val(
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

						rent_lc_searchLayer
							.setSource(new ol.source.Vector(
								{
									features: (new ol.format.WKT())
										.readFeatures(polygon_tttt)
								}));
						view.fit(rent_lc_searchLayer
							.getSource().getExtent());

						rent_map.getView().fit(
							rent_lc_searchLayer
								.getSource()
								.getExtent(), {
							size: map.getSize(),
							maxZoom: 16
						})

					});



			$("#rent_btn_visualise_search").click(function (event) {

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
						type: "POST",
						url: "Case_Management_Serv",
						data: {
							request_type: 'select_consolidated_internal_search_report_geom',
							vr_polygon: wktplygonsearch
						},
						cache: false,
						beforeSend: function () {
							// $('#district').html('<img
							// src="img/loading.gif"
							// alt="" width="24"
							// height="24">');
						},
						success: function (
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
								// rent_searchLayer.getSource().getFeatures().length;
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
								if (rent_current_search_result_searchLayer
									.getSource() != null) {
									rent_current_search_result_searchLayer
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
												features: (new ol.format.GeoJSON())
													.readFeatures(json_p.garro)
											}));
									/*
									 * var features =
									 * rent_searchLayer.getSource().getFeatures();
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
												features: (new ol.format.GeoJSON())
													.readFeatures(json_p.cro)
											}));
								}
								if (json_p.pvlmdcurrent === undefined
									|| json_p.pvlmdcurrent.features === null) {
								} else {
									rent_current_search_result_searchLayer
										.setSource(new ol.source.Vector(
											{
												features: (new ol.format.GeoJSON())
													.readFeatures(json_p.pvlmdcurrent)
											}));
								}

								if (json_p.smd_parcels === undefined
									|| json_p.smd_parcels.features === null) {
								} else {
									smd_parcel_search_result_searchLayer
										.setSource(new ol.source.Vector(
											{
												features: (new ol.format.GeoJSON())
													.readFeatures(json_p.smd_parcels)
											}));
								}
								if (json_p.smd_cadastral === undefined
									|| json_p.smd_cadastral.features === null) {
								} else {
									smd_cadastral_search_result_searchLayer
										.setSource(new ol.source.Vector(
											{
												features: (new ol.format.GeoJSON())
													.readFeatures(json_p.smd_cadastral)
											}));
								}
								if (json_p.lrd === undefined
									|| json_p.lrd.features === null) {
								} else {
									lrd_search_result_searchLayer
										.setSource(new ol.source.Vector(
											{
												features: (new ol.format.GeoJSON())
													.readFeatures(json_p.lrd)
											}));
								}
								view
									.fit(rent_current_search_result_searchLayer
										.getSource()
										.getExtent());
								map
									.getView()
									.fit(
										rent_current_search_result_searchLayer
											.getSource()
											.getExtent(),
										{
											size: map
												.getSize(),
											maxZoom: 16
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
				function (event) {
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





			$("#pvlmd_btnprintmap").click(function (event) {
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
						title: 'Internal Serach',
						subject: 'This is the subject',
						author: 'Assiamah John',
						keywords: 'generated, javascript, web 2.0, ajax',
						creator: 'Creator Name'
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
						type: "POST",
						url: "Case_Management_Serv",
						data: {
							request_type: 'select_consolidated_internal_search_report_attribute',
							vr_polygon: wktplygonsearch
						},
						cache: false,
						beforeSend: function () {
							// $('#district').html('<img
							// src="img/loading.gif"
							// alt="" width="24"
							// height="24">');
						},
						success: function (
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
									var data_rows = [{
										main_description: 'No Recorded Transaction'
									}];
									var columns = [{
										title: 'Existing GARRO Data',
										dataKey: 'main_description'
									}]

									// doc.autoTable(columns,
									// data_rows,
									// {margin:
									// {top: 50}});

									doc
										.autoTable(
											columns,
											data_rows,
											{
												margin: {
													top: 10
												},
												theme: 'grid',
												startY: doc
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
											title: "Property No",
											dataKey: "prop_no"
										},
										{
											title: "Instrument Date",
											dataKey: "instrument_date"
										},
										{
											title: "Instrument Type",
											dataKey: "instrument_type"
										},
										{
											title: "Grantor",
											dataKey: "party1_plaintiff"
										},
										{
											title: "Grantee",
											dataKey: "party2_defendant"
										},
										{
											title: "Term",
											dataKey: "term"
										},
										{
											title: "Commencement Date",
											dataKey: "commencement_date"
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
												margin: {
													top: 10
												},
												bodyStyles: {
													valign: 'middle'
												},
												styles: {
													overflow: 'linebreak',
													columnWidth: 'wrap'
												},
												theme: 'grid',
												startY: doc
													.autoTableEndPosY() + 10,
												columnStyles: {
													party1_plaintiff: {
														columnWidth: 100
													},
													party2_defendant: {
														columnWidth: 50
													}
												},
												addPageContent: function (
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
									var data_rows = [{
										main_description: 'No Recorded Transaction'
									}];
									var columns = [{
										title: 'Existing CRO Data',
										dataKey: 'main_description'
									}]

									// doc.autoTable(columns,
									// data_rows,
									// {margin:
									// {top: 50}});

									doc
										.autoTable(
											columns,
											data_rows,
											{
												margin: {
													top: 10
												},
												theme: 'grid',
												startY: doc
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
											title: "LS Number",
											dataKey: "ls_number"
										},
										{
											title: "Instrument Date",
											dataKey: "instrument_date"
										},
										{
											title: "Instrument Type",
											dataKey: "instrument_type"
										},
										{
											title: "Grantor",
											dataKey: "party1_plaintiff"
										},
										{
											title: "Grantee",
											dataKey: "party2_defendant"
										},
										{
											title: "Term",
											dataKey: "term"
										},
										{
											title: "Commencement Date",
											dataKey: "commencement_date"
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

												margin: {
													top: 10
												},
												bodyStyles: {
													valign: 'middle'
												},
												styles: {
													overflow: 'linebreak',
													columnWidth: 'wrap'
												},
												theme: 'grid',
												startY: doc
													.autoTableEndPosY() + 10,
												columnStyles: {
													party1_plaintiff: {
														columnWidth: 50
													},
													party2_defendant: {
														columnWidth: 50
													}
												}

											});
								}

								if (json_p.pvlmdcurrent === undefined
									|| json_p.pvlmdcurrent === null) {

									var data_rows = [{
										main_description: 'No Recorded Transaction'
									}];
									var columns = [{
										title: 'PVLMD Current Layer',
										dataKey: 'main_description'
									}]

									// doc.autoTable(columns,
									// data_rows,
									// {margin:
									// {top: 50}});

									doc
										.autoTable(
											columns,
											data_rows,
											{
												margin: {
													top: 10
												},
												theme: 'grid',
												startY: doc
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
											title: "Reference No",
											dataKey: "reference_number_p"
										},
										{
											title: "Instrument Date",
											dataKey: "instrument_date"
										},
										{
											title: "Instrument Type",
											dataKey: "instrument_type"
										},
										{
											title: "Grantor",
											dataKey: "party1_plaintiff"
										},
										{
											title: "Grantee",
											dataKey: "party2_defendant"
										},
										{
											title: "Term",
											dataKey: "term"
										},
										{
											title: "Commencement Date",
											dataKey: "commencement_date"
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

												margin: {
													top: 10
												},
												bodyStyles: {
													valign: 'middle'
												},
												styles: {
													overflow: 'linebreak',
													columnWidth: 'wrap'
												},
												theme: 'grid',
												startY: doc
													.autoTableEndPosY() + 10,
												columnStyles: {
													party1_plaintiff: {
														columnWidth: 50
													},
													party2_defendant: {
														columnWidth: 50
													}
												}

											});
								}

								if (json_p.smd_parcels === undefined
									|| json_p.smd_parcels === null) {

									var data_rows = [{
										main_description: 'No Recorded Transaction'
									}];
									var columns = [{
										title: 'SMD Parcel Layer',
										dataKey: 'main_description'
									}]

									// doc.autoTable(columns,
									// data_rows,
									// {margin:
									// {top: 50}});

									doc
										.autoTable(
											columns,
											data_rows,
											{
												margin: {
													top: 10
												},
												theme: 'grid',
												startY: doc
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
											title: "CC No",
											dataKey: "ccno"
										},
										{
											title: "Applicant Name",
											dataKey: "a_name"
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

												margin: {
													top: 10
												},
												bodyStyles: {
													valign: 'middle'
												},
												styles: {
													overflow: 'linebreak',
													columnWidth: 'wrap'
												},
												theme: 'grid',
												startY: doc
													.autoTableEndPosY() + 10,
												columnStyles: {
													ccno: {
														columnWidth: 50
													},
													a_name: {
														columnWidth: 50
													}
												}

											});
								}

								if (json_p.smd_cadastral === undefined
									|| json_p.smd_cadastral === null) {

									var data_rows = [{
										main_description: 'No Recorded Transaction'
									}];
									var columns = [{
										title: 'SMD Cadastral Layer',
										dataKey: 'main_description'
									}]

									// doc.autoTable(columns,
									// data_rows,
									// {margin:
									// {top: 50}});

									doc
										.autoTable(
											columns,
											data_rows,
											{
												margin: {
													top: 10
												},
												theme: 'grid',
												startY: doc
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
											title: "CC No",
											dataKey: "ccno"
										},
										{
											title: "Applicant Name",
											dataKey: "a_name"
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

												margin: {
													top: 10
												},
												bodyStyles: {
													valign: 'middle'
												},
												styles: {
													overflow: 'linebreak',
													columnWidth: 'wrap'
												},
												theme: 'grid',
												startY: doc
													.autoTableEndPosY() + 10,
												columnStyles: {
													ccno: {
														columnWidth: 50
													},
													a_name: {
														columnWidth: 50
													}
												}

											});
								}

								if (json_p.lrd === undefined
									|| json_p.lrd === null) {

									var data_rows = [{
										main_description: 'No Recorded Transaction'
									}];
									var columns = [{
										title: 'LRD Layer',
										dataKey: 'main_description'
									}]

									// doc.autoTable(columns,
									// data_rows,
									// {margin:
									// {top: 50}});

									doc
										.autoTable(
											columns,
											data_rows,
											{
												margin: {
													top: 10
												},
												theme: 'grid',
												startY: doc
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
											title: "Reference No.",
											dataKey: "reference_number"
										},
										{
											title: "Instrument Date",
											dataKey: "date_of_instument"
										},
										{
											title: "Instrument Type",
											dataKey: "type_instrument"
										},
										{
											title: "Garntor",
											dataKey: "grantor_name"
										},
										{
											title: "Applncant Name",
											dataKey: "applicant_name"
										},
										{
											title: "Term",
											dataKey: "term"
										},
										{
											title: "Commencement",
											dataKey: "date_commencement"
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

												margin: {
													top: 10
												},
												bodyStyles: {
													valign: 'middle'
												},
												styles: {
													overflow: 'linebreak',
													columnWidth: 'wrap'
												},
												theme: 'grid',
												startY: doc
													.autoTableEndPosY() + 10,
												columnStyles: {
													grantor_name: {
														columnWidth: 50
													},
													applicant_name: {
														columnWidth: 50
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