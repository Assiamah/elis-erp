/*$(document)
		.ready(
				function() {
 */
					var lrdfp_parcel_lrd_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_lrd_parcels_dataLayer = new ol.layer.Tile({
						title : 'LRD Parcels Layer',
						source : lrdfp_parcel_lrd_dataSource
					
					})
					
					var lrdfp_parcels_smd_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_parcels_smd_dataLayer = new ol.layer.Tile({
						title : 'SMD Parcels Layer',
						source : lrdfp_parcels_smd_dataSource
					
					})
					
					var lrdfp_cadastral_smd_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_cadastral_smd_dataLayer = new ol.layer.Tile({
						title : 'SMD Cadastral Layer',
						source : lrdfp_cadastral_smd_dataSource
					
					})
					
					var lrdfp_garro_parcels_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_garro_parcels_dataLayer = new ol.layer.Tile({
						title : 'Existing GARRO Layer',
						// visible: false,
						source : lrdfp_garro_parcels_dataSource
					
					})
					
					var lrdfp_cro_sp_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_cro_parcels_dataLayer = new ol.layer.Tile({
						title : 'Existing CRO Layer',
						// visible: false,
						source : lrdfp_cro_sp_dataSource
					
					})
					
					var lrdfp_pvlmd_current_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_pvlmd_current_dataLayer = new ol.layer.Tile({
						title : 'PVLMD Current Layer',
						// visible: false,
						source : lrdfp_pvlmd_current_dataSource
					
					})
					
					var lrdfp_grid_lrd_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_grid_lrd_dataLayer = new ol.layer.Tile({
						title : 'Grid',
						visible : false,
						source : lrdfp_grid_lrd_dataSource
					
					})
					
					var lrdfp_registration_district_dataSource = new ol.source.TileWMS({
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
					
					var lrdfp_registration_district_dataLayer = new ol.layer.Tile({
						title : 'Registration District',
						visible : false,
						source : lrdfp_registration_district_dataSource
					
					})
					
					// 104_modified_CR
					// DIST_03_01_A_modified
					
					var lrdfp_StaticImage = new ol.layer.Image({
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
					
					var lrdfp_markers = new ol.layer.Vector({
						// title: 'Markers',
						source : new ol.source.Vector(),
					// style: iconStyle
					
					/*
					 * new ol.style.Style({
					 * 
					 * image: new ol.style.Icon({ anchor: [0.5, 1], src: 'marker.png' }) })
					 */
					});
					
					lrdfp_pvlmd_searchLayer = new ol.layer.Vector({
						title : 'Search Layer',
						source : undefined,
						style : new ol.style.Style({
							stroke : new ol.style.Stroke({
								color : 'yellow',
								width : 3
							})
						})
					});
					
					// var all_layers = [vectorwkt];
					
					var london = ol.proj.fromLonLat([ -0.12755, 51.507222 ]), istanbul = ol.proj
							.fromLonLat([ 28.9744, 41.0128 ]), view = new ol.View({
						center : istanbul,
						zoom : 5
					});
					var vectorLayer;
					
					var lrdfp_googleLayerHybrid = new ol.layer.Tile({
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
					
					var lrdfp_new_de = new ol.layer.Tile({
						title : "Open Street Map",
						// 'type': 'base',
						visible : false,
						source : new ol.source.OSM({
							wrapX : false
						}),
					// projection: 'EPSG:4326'
					})
					
					var lrdfp_projObj = new ol.proj.Projection({
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
					
					var lrdfp_firstProjection = '+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs';
					var lrdfp_secondProjection = '+proj=longlat +datum=WGS84 +no_defs';
					
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
					
					var lrdfp_view_e = new ol.View({
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
					
					var lrdfpmap = new ol.Map({
						target : 'lrdfp-map',
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
						view : lrdfp_view_e
					});
					
					// map.addLayer(new_de);
					lrdfpmap.addLayer(lrdfp_googleLayerHybrid);
					lrdfpmap.addLayer(lrdfp_StaticImage);
					lrdfpmap.addLayer(lrdfp_registration_district_dataLayer);
					
					lrdfpmap.addLayer(lrdfp_grid_lrd_dataLayer);
					
					// map.addLayer(beacon_lrd_dataLayer);
					
					lrdfpmap.addLayer(lrdfp_lrd_parcels_dataLayer);
					lrdfpmap.addLayer(lrdfp_parcels_smd_dataLayer);
					lrdfpmap.addLayer(lrdfp_cadastral_smd_dataLayer);
					lrdfpmap.addLayer(lrdfp_pvlmd_current_dataLayer);
					lrdfpmap.addLayer(lrdfp_cro_parcels_dataLayer);
					lrdfpmap.addLayer(lrdfp_garro_parcels_dataLayer);
					lrdfpmap.addLayer(lrdfp_pvlmd_searchLayer);
					
					document.getElementById('lc_btn_fr_visualise_coordinate').addEventListener(
							'click',
							function() {
					
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
					
								$('#lc_fr_bl_wkt_polygon').val(polygon_tttt);
								$('#lc_bl_wkt_polygon').val(polygon_tttt);
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
					
								lrdfp_pvlmd_searchLayer.setSource(new ol.source.Vector({
									features : (new ol.format.WKT()).readFeatures(polygon_tttt)
								}));
								view.fit(lrdfp_pvlmd_searchLayer.getSource().getExtent());
					
								lrdfpmap.getView().fit(
										lrdfp_pvlmd_searchLayer.getSource().getExtent(), {
											size : map.getSize(),
											maxZoom : 16
										})
					
							});
					
					// });
					