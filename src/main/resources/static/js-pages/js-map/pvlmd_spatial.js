$(document)
		.ready(
				function() {
console.log('PVLMD Maps working');


					var lrd_point_coordinate_list;

					var lrd_click_type = 'MapClick';
					
					
					var pvlmd_regional_boundary_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:gh_lvd_region',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var pvlmd_regional_boundary_dataLayer = new ol.layer.Tile({
						title : 'Regional Boundary',
						source : pvlmd_regional_boundary_dataSource

					})
					
					
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
						visible : false,
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
						visible : false,
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
						visible : false,
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

						var pvlmd_grid_lrd_dataSource_new = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:ghana_grid_index',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var pvlmd_grid_lrd_dataLayer_new = new ol.layer.Tile({
						title : 'Grid Country',
						visible : false,
						source : pvlmd_grid_lrd_dataSource_new

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




							var pvlmd_volta_region_old_data_dataSource = new ol.source.TileWMS(
							{
								url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
								params : {
									'LAYERS' : 'csau_geospatial:volta_pvlmd_old_parcel_records',
									'TILED' : true
								},
								// params: {'LAYERS':
								// 'rating:spatial_unit_assembly', 'cql_filter':
								// "assembly_code='AMA'" , 'TILED': true },,
								serverType : 'geoserver',
								transition : 0
							})

					var pvlmd_volta_region_old_data_dataLayer = new ol.layer.Tile(
							{
								title : 'Volta Old Data',
								visible : false,
								source : pvlmd_volta_region_old_data_dataSource

							})

 var lrd_undergoing_registration_dataSource = new ol.source.TileWMS({
        url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
        params: {
            'LAYERS': 'csau_geospatial:lc_spatial_objects_undergoing_registration',
            'TILED': true
        },
        serverType: 'geoserver',
        transition: 0
    });

    var lrd_undergoing_registration_dataLayer = new ol.layer.Tile({
        title: 'Undergoing Registration Layer',
        source: lrd_undergoing_registration_dataSource
    });


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
					
					// Get the WKT polygon from Java model attribute
//var regions_polygon = '${regions_polygon}';
// let username = "${regions_polygon}";
  var regions_polygon = $('#regions_polygon').val();

  

					pvlmd_lc_regional_boundary_layer = new ol.layer.Vector({
						title : 'Regional Layer',
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





// Variables for drawing and measurement
var pvlmd_drawInteraction = null;
var pvlmd_modifyInteraction = null;
var pvlmd_snapInteraction = null;
var pvlmd_selectedFeature = null;
var pvlmd_measureSource = new ol.source.Vector();
var pvlmd_measureLayer = new ol.layer.Vector({
    title: 'Measurement Layer',
    source: pvlmd_measureSource,
    style: new ol.style.Style({
        fill: new ol.style.Fill({
            color: 'rgba(255, 0, 0, 0.2)'
        }),
        stroke: new ol.style.Stroke({
            color: '#ff0000',
            width: 2
        }),
        image: new ol.style.Circle({
            radius: 6,
            fill: new ol.style.Fill({
                color: '#ff0000'
            })
        })
    })
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
					pvlmd_map.addLayer(pvlmd_regional_boundary_dataLayer);
					
					pvlmd_map.addLayer(pvlmd_registration_district_dataLayer);

                   pvlmd_map.addLayer(lrd_undergoing_registration_dataLayer);
					pvlmd_map.addLayer(pvlmd_grid_lrd_dataLayer);
					pvlmd_map.addLayer(pvlmd_grid_lrd_dataLayer_new);

					

					// map.addLayer(beacon_lrd_dataLayer);

					pvlmd_map.addLayer(pvlmd_lrd_parcels_dataLayer);
					pvlmd_map.addLayer(pvlmd_parcels_smd_dataLayer);
					pvlmd_map.addLayer(pvlmd_cadastral_smd_dataLayer);
					pvlmd_map.addLayer(pvlmd_pvlmd_current_dataLayer);
					pvlmd_map.addLayer(pvlmd_cro_parcels_dataLayer);
					pvlmd_map.addLayer(pvlmd_volta_region_old_data_dataLayer);
					
					pvlmd_map.addLayer(pvlmd_garro_parcels_dataLayer);
					pvlmd_map.addLayer(pvlmd_garro_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_cro_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_current_search_result_searchLayer);
					pvlmd_map
							.addLayer(pvlmd_smd_parcel_search_result_searchLayer);
					pvlmd_map
							.addLayer(pvlmd_smd_cadastral_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_lrd_search_result_searchLayer);
					pvlmd_map.addLayer(pvlmd_lc_regional_boundary_layer);
					
					pvlmd_map.addLayer(pvlmd_lc_searchLayer);
					// Add measurement layer to map
pvlmd_map.addLayer(pvlmd_measureLayer);
					pvlmd_map.addLayer(pvlmd_markers);

					loadAndZoomToRegionPolygon(regions_polygon);
				





                    
           

                    // ================================================================
// PVLMD CLICKABLE WMS LAYER CONFIGURATION
// ================================================================
//
// PVLMD Current remains the PRIMARY layer.
// Its existing modal/workflow is preserved.
//
// Other layers use the generic Identify modal.
//
// enabled:
//     true  = allow map click identification
//     false = do not query this layer
//
// primary:
//     true = use existing PVLMD parcel workflow
//     false = use generic information dialog
// ================================================================

var pvlmdClickableLayers = [
    {
        key: 'pvlmd_current',
        title: 'PVLMD Current Layer',
        layer: pvlmd_pvlmd_current_dataLayer,
        source: pvlmd_pvlmd_current_dataSource,
        enabled: true,
        primary: true
    },

    {
        key: 'lrd_parcels',
        title: 'LRD Parcels Layer',
        layer: pvlmd_lrd_parcels_dataLayer,
        source: pvlmd_parcel_lrd_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'smd_parcels',
        title: 'SMD Parcels Layer',
        layer: pvlmd_parcels_smd_dataLayer,
        source: pvlmd_parcels_smd_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'smd_cadastral',
        title: 'SMD Cadastral Layer',
        layer: pvlmd_cadastral_smd_dataLayer,
        source: pvlmd_cadastral_smd_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'garro',
        title: 'Existing GARRO Layer',
        layer: pvlmd_garro_parcels_dataLayer,
        source: pvlmd_garro_parcels_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'cro',
        title: 'Existing CRO Layer',
        layer: pvlmd_cro_parcels_dataLayer,
        source: pvlmd_cro_sp_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'undergoing_registration',
        title: 'Undergoing Registration Layer',
        layer: lrd_undergoing_registration_dataLayer,
        source: lrd_undergoing_registration_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'registration_district',
        title: 'Registration District',
        layer: pvlmd_registration_district_dataLayer,
        source: pvlmd_registration_district_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'volta_old_data',
        title: 'Volta Old Data',
        layer: pvlmd_volta_region_old_data_dataLayer,
        source: pvlmd_volta_region_old_data_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'regional_boundary',
        title: 'Regional Boundary',
        layer: pvlmd_regional_boundary_dataLayer,
        source: pvlmd_regional_boundary_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'grid',
        title: 'Grid',
        layer: pvlmd_grid_lrd_dataLayer,
        source: pvlmd_grid_lrd_dataSource,
        enabled: true,
        primary: false
    },

    {
        key: 'grid_country',
        title: 'Grid Country',
        layer: pvlmd_grid_lrd_dataLayer_new,
        source: pvlmd_grid_lrd_dataSource_new,
        enabled: true,
        primary: false
    }
];


// ================================================================
// GENERIC IDENTIFY MODAL
// ================================================================
// No HTML modal is required in your JSP.
// JavaScript creates it automatically.
// ================================================================
// ================================================================
// GENERIC IDENTIFY MODAL - CREATED ONCE, NEVER RE-CREATED
// ================================================================
function pvlmdCreateIdentifyModal() {

    if (document.getElementById('pvlmdGenericIdentifyModal')) {
        return;
    }

    var modalHtml = `
        <div class="modal fade"
             id="pvlmdGenericIdentifyModal"
             tabindex="-1"
             aria-labelledby="pvlmdGenericIdentifyModalLabel"
             aria-hidden="true">

            <div class="modal-dialog modal-lg modal-dialog-scrollable">

                <div class="modal-content">

                    <div class="modal-header bg-primary text-white">
                        <div>
                            <h5 class="modal-title"
                                id="pvlmdGenericIdentifyModalLabel">
                                <i class="fas fa-map-marker-alt me-2"></i>
                                Map Feature Information
                            </h5>
                            <small id="pvlmdIdentifyLayerName"
                                   class="text-white-50"></small>
                        </div>
                        <button type="button"
                                class="btn-close btn-close-white"
                                data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <div id="pvlmdIdentifyLoading"
                             class="text-center py-4 d-none">
                            <div class="spinner-border text-primary"
                                 role="status"></div>
                            <div class="mt-2 text-muted">
                                Loading feature information...
                            </div>
                        </div>

                        <div id="pvlmdIdentifyNoData"
                             class="alert alert-info d-none">
                            <i class="fas fa-info-circle me-2"></i>
                            No information was found at this location.
                        </div>

                        <div id="pvlmdIdentifyMultipleFeatures"
                             class="mb-3 d-none">
                            <label class="form-label fw-bold">
                                Features found
                            </label>
                            <select id="pvlmdIdentifyFeatureSelector"
                                    class="form-select"></select>
                        </div>

                        <div id="pvlmdIdentifyContent"></div>
                    </div>

                    <div class="modal-footer">
                        <button type="button"
                                class="btn btn-outline-secondary"
                                id="pvlmdIdentifyCopyBtn">
                            <i class="fas fa-copy me-1"></i>
                            Copy Information
                        </button>
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>
        </div>
    `;

    $('body').append(modalHtml);
}

pvlmdCreateIdentifyModal();


// ================================================================
// REMOVE ORPHANED BOOTSTRAP BACKDROPS
// Bootstrap 5 sometimes leaves <div class="modal-backdrop"> behind
// when a modal is opened while another one is still transitioning,
// which freezes the map (invisible overlay blocks all events).
// ================================================================
function pvlmdCleanupBootstrapBackdrops() {
    $('.modal-backdrop').remove();
    $('body').removeClass('modal-open');
    $('body').css({
        'overflow': '',
        'padding-right': ''
    });
}

// ================================================================
// BLUR THE OPENLAYERS CANVAS SO BOOTSTRAP DOES NOT TRAP FOCUS
// ================================================================
function pvlmdBlurMapCanvas() {
    var target = pvlmd_map && pvlmd_map.getTargetElement
        ? pvlmd_map.getTargetElement()
        : null;

    if (!target) { return; }

    // Remove tabindex if present so the canvas cannot retain focus
    target.removeAttribute('tabindex');

    // Blur any element inside the map container
    var active = document.activeElement;
    if (active && target.contains(active)) {
        active.blur();
    }
}


// ================================================================
// HTML ESCAPE
// Very important because GeoServer attribute values must not be
// inserted directly into HTML.
// ================================================================

function pvlmdEscapeHtml(value) {

    if (value === null ||
        value === undefined ||
        value === '') {

        return '-';
    }

    return $('<div>')
        .text(String(value))
        .html();
}


// ================================================================
// FORMAT PROPERTY NAME
// property_number -> Property Number
// plotting_date   -> Plotting Date
// ================================================================

function pvlmdFormatPropertyName(name) {

    if (!name) {
        return '';
    }

    return String(name)
        .replace(/_/g, ' ')
        .replace(/\b\w/g, function(letter) {
            return letter.toUpperCase();
        });
}


// ================================================================
// PROPERTIES THAT SHOULD NOT NORMALLY BE DISPLAYED
// ================================================================

function pvlmdShouldHideProperty(propertyName) {

    var hiddenProperties = [
        'geom',
        'geometry',
        'the_geom',
        'wkb_geometry'
    ];

    return hiddenProperties.indexOf(
        String(propertyName).toLowerCase()
    ) !== -1;
}


// ================================================================
// BUILD FEATURE INFORMATION TABLE
// ================================================================

function pvlmdBuildFeatureTable(feature) {

    if (!feature) {
        return `
            <div class="alert alert-warning">
                Feature information is unavailable.
            </div>
        `;
    }

    var properties = feature.properties || {};

    var html = `
        <div class="card border-0 shadow-sm">

            <div class="card-header bg-light">

                <div class="d-flex
                            justify-content-between
                            align-items-center">

                    <span class="fw-bold">
                        Feature Details
                    </span>

                    <span class="badge bg-secondary">
                        ${pvlmdEscapeHtml(feature.id || 'Feature')}
                    </span>

                </div>

            </div>

            <div class="card-body p-0">

                <div class="table-responsive">

                    <table class="table
                                  table-sm
                                  table-striped
                                  table-hover
                                  mb-0">

                        <tbody>
    `;

    var propertyCount = 0;

    Object.keys(properties).forEach(function(key) {

        if (pvlmdShouldHideProperty(key)) {
            return;
        }

        var value = properties[key];

        // Handle objects / arrays safely
        if (typeof value === 'object' &&
            value !== null) {

            try {
                value = JSON.stringify(value);
            } catch (e) {
                value = String(value);
            }
        }

        html += `
            <tr>

                <th style="
                    width:35%;
                    min-width:180px;
                    vertical-align:top;
                ">
                    ${pvlmdEscapeHtml(
                        pvlmdFormatPropertyName(key)
                    )}
                </th>

                <td style="
                    word-break:break-word;
                    vertical-align:top;
                ">
                    ${pvlmdEscapeHtml(value)}
                </td>

            </tr>
        `;

        propertyCount++;
    });


    if (propertyCount === 0) {

        html += `
            <tr>
                <td class="text-center
                           text-muted
                           py-4">
                    No attributes available.
                </td>
            </tr>
        `;
    }


    html += `
                        </tbody>

                    </table>

                </div>

            </div>

        </div>
    `;

    return html;
}


// ================================================================
// CURRENT GENERIC IDENTIFY DATA
// ================================================================

var pvlmdCurrentIdentifyFeatures = [];
var pvlmdCurrentIdentifyLayer = null;


// ================================================================
// DISPLAY GENERIC IDENTIFY MODAL
// ================================================================
// ================================================================
// DISPLAY GENERIC IDENTIFY MODAL
// ================================================================
function pvlmdShowIdentifyModal(layerConfig, features) {

    pvlmdCurrentIdentifyLayer = layerConfig;
    pvlmdCurrentIdentifyFeatures = features || [];

    $('#pvlmdIdentifyLayerName')
        .text(layerConfig.title || 'Map Layer');

    $('#pvlmdIdentifyLoading')
        .addClass('d-none');

    $('#pvlmdIdentifyNoData')
        .addClass('d-none');

    $('#pvlmdIdentifyContent')
        .empty();

    $('#pvlmdIdentifyMultipleFeatures')
        .addClass('d-none');

    $('#pvlmdIdentifyFeatureSelector')
        .empty();


    if (!features || features.length === 0) {
        $('#pvlmdIdentifyNoData')
            .removeClass('d-none');
        return;
    }


    // ------------------------------------------------------------
    // Multiple features
    // ------------------------------------------------------------
    if (features.length > 1) {

        $('#pvlmdIdentifyMultipleFeatures')
            .removeClass('d-none');

        features.forEach(function (feature, index) {

            var props = feature.properties || {};

            var label =
                props.reference_number ||
                props.property_number ||
                props.plot_number ||
                props.name ||
                props.locality ||
                props.sheet_number ||
                feature.id ||
                ('Feature ' + (index + 1));

            $('#pvlmdIdentifyFeatureSelector')
                .append(
                    $('<option>', {
                        value: index,
                        text: (index + 1) + '. ' + label
                    })
                );
        });
    }


    // Show first feature
    $('#pvlmdIdentifyContent')
        .html(pvlmdBuildFeatureTable(features[0]));


    // ============================================================
    // SHOW MODAL - CLEAN AND SAFE
    // ============================================================

    // 1) Blur the map canvas BEFORE showing the modal so the
    //    focus-trap does not fight with the OpenLayers canvas.
    pvlmdBlurMapCanvas();

    // 2) Remove any leftover backdrops from previous modals.
    //    This is the actual fix for the "map frozen on 2nd open".
    pvlmdCleanupBootstrapBackdrops();

    // 3) Get the modal element.
    var modalElement =
        document.getElementById('pvlmdGenericIdentifyModal');

    if (!modalElement) { return; }

    // 4) Dispose of any existing instance so we get a fresh one.
    var existingInstance =
        bootstrap.Modal.getInstance(modalElement);

    if (existingInstance) {
        try { existingInstance.dispose(); } catch (e) {}
    }

    // 5) Create a fresh instance and show it.
    var modal = new bootstrap.Modal(modalElement, {
        backdrop: true,
        keyboard: true,
        focus: true
    });

    modal.show();
}


// ================================================================
// CHANGE FEATURE IN GENERIC MODAL
// ================================================================

$(document).on(
    'change',
    '#pvlmdIdentifyFeatureSelector',
    function() {

        var index = parseInt(
            $(this).val(),
            10
        );

        if (isNaN(index)) {
            return;
        }

        var feature =
            pvlmdCurrentIdentifyFeatures[index];

        $('#pvlmdIdentifyContent')
            .html(
                pvlmdBuildFeatureTable(feature)
            );
    }
);


// ================================================================
// COPY GENERIC FEATURE INFORMATION
// ================================================================

$(document).on(
    'click',
    '#pvlmdIdentifyCopyBtn',
    function() {

        if (!pvlmdCurrentIdentifyFeatures ||
            pvlmdCurrentIdentifyFeatures.length === 0) {

            return;
        }


        var index = parseInt(
            $('#pvlmdIdentifyFeatureSelector').val(),
            10
        );

        if (isNaN(index)) {
            index = 0;
        }


        var feature =
            pvlmdCurrentIdentifyFeatures[index];

        var text =
            JSON.stringify(
                feature.properties || {},
                null,
                2
            );


        if (navigator.clipboard &&
            navigator.clipboard.writeText) {

            navigator.clipboard
                .writeText(text)
                .then(function() {

                    if (typeof Swal !== 'undefined') {

                        Swal.fire({
                            title: 'Copied',
                            text: 'Feature information copied to clipboard.',
                            icon: 'success',
                            timer: 1500,
                            showConfirmButton: false
                        });
                    }
                });

        } else {

            var textarea =
                document.createElement('textarea');

            textarea.value = text;

            document.body.appendChild(textarea);

            textarea.select();

            document.execCommand('copy');

            document.body.removeChild(textarea);
        }
    }
);


// ================================================================
// CHECK WHETHER LAYER CAN CURRENTLY BE IDENTIFIED
// ================================================================

function pvlmdCanIdentifyLayer(config) {

    if (!config) {
        return false;
    }

    if (!config.enabled) {
        return false;
    }

    if (!config.layer) {
        return false;
    }

    if (!config.source) {
        return false;
    }


    // Important:
    // only query layers currently visible in LayerSwitcher.
    //
    // If you want hidden layers to also be queried,
    // remove this condition.
    // ------------------------------------------------------------

    if (!config.layer.getVisible()) {
        return false;
    }


    if (typeof config.source.getGetFeatureInfoUrl !== 'function') {
        return false;
    }


    return true;
}


// ================================================================
// GENERATE FEATURE INFO URL
// ================================================================

function pvlmdGetFeatureInfoUrl(
    config,
    coordinate,
    resolution,
    projection
) {

    if (!pvlmdCanIdentifyLayer(config)) {
        return null;
    }


    return config.source.getGetFeatureInfoUrl(
        coordinate,
        resolution,
        projection,
        {
            'INFO_FORMAT': 'application/json',
            'FEATURE_COUNT': 50
        }
    );
}


// ================================================================
// QUERY ONE WMS LAYER
// ================================================================

function pvlmdQueryLayer(
    config,
    coordinate,
    resolution,
    projection
) {

    return new Promise(function(resolve) {

        var url =
            pvlmdGetFeatureInfoUrl(
                config,
                coordinate,
                resolution,
                projection
            );


        if (!url) {

            resolve({
                config: config,
                features: []
            });

            return;
        }


        $.ajax({

            type: 'GET',

            url: url,

            cache: false,

            dataType: 'json',

            success: function(response) {

                resolve({
                    config: config,
                    features:
                        response &&
                        Array.isArray(response.features)
                            ? response.features
                            : []
                });
            },

            error: function(xhr, status, error) {

                console.warn(
                    'FeatureInfo failed:',
                    config.title,
                    status,
                    error
                );

                // Do not break all layer querying just
                // because one GeoServer layer fails.

                resolve({
                    config: config,
                    features: []
                });
            }
        });
    });
}


// ================================================================
// PROCESS EXISTING PVLMD CURRENT LAYER
// ================================================================
//
// This preserves your existing PVLMD workflow.
// ================================================================

function pvlmdProcessCurrentLayerFeatures(features) {

    if (!features ||
        features.length === 0) {

        return false;
    }


    var table =
        $('#pvlmd_more_than_one_parcel_Table');

    table.find('tbody tr').remove();


    // ============================================================
    // MORE THAN ONE PVLMD PARCEL
    // ============================================================

    if (features.length > 1) {

        features.forEach(function(feat) {

            var props =
                feat.properties || {};

            var parcel_uuid =
                (feat.id || '')
                    .split('.')[1] || '';


            // Build row using jQuery instead of raw string
            // concatenation to avoid breaking HTML when a value
            // contains quotes.

            var $row = $('<tr>');


            $('<td>')
                .text(
                    props.reference_number || '-'
                )
                .appendTo($row);


            $('<td>')
                .text(
                    props.nt_number || '-'
                )
                .appendTo($row);


            $('<td>')
                .text(
                    props.locality || '-'
                )
                .appendTo($row);


            var $actionCell =
                $('<td>');


            var $button =
                $('<button>', {
                    type: 'button',
                    class:
                        'btn btn-success btn-circle btn-sm',
                    title: 'Details of Parcel'
                });


            $button.attr({
                'data-bs-toggle': 'modal',
                'data-bs-target':
                    '#pvlmdparcelinformation'
            });


            // Store values using jQuery .data()
            // rather than building raw HTML attributes.

            $button.data(
                'parcel_uuid',
                parcel_uuid
            );

            $button.data(
                'nt_number',
                props.nt_number || ''
            );

            $button.data(
                'cro_reference',
                props.cro_reference || ''
            );

            $button.data(
                'property_number',
                props.property_number || ''
            );

            $button.data(
                'reference_number',
                props.reference_number || ''
            );

            $button.data(
                'file_number',
                props.file_number || ''
            );

            $button.data(
                'locality',
                props.locality || ''
            );

            $button.data(
                'plot_number',
                props.plot_number || ''
            );

            $button.data(
                'sheet_number',
                props.sheet_number || ''
            );

            $button.data(
                'modified_by',
                props.modified_by ||
                props.plotted_by ||
                ''
            );

            $button.data(
                'modified_date',
                props.modified_date ||
                props.plotting_date ||
                ''
            );

            $button.data(
                'remarks',
                props.remarks || ''
            );


            $button.append(
                $('<span>', {
                    class: 'fas fa-check'
                })
            );


            $actionCell
                .append($button);

            $row
                .append($actionCell);

            table
                .append($row);
        });


        // --------------------------------------------------------
        // IMPORTANT
        //
        // Your original code populated the table but did not
        // explicitly show a modal containing that table.
        //
        // If the table is already inside another modal/panel,
        // leave this as-is.
        // --------------------------------------------------------

        return true;
    }


    // ============================================================
    // ONE PVLMD PARCEL
    // ============================================================

    var firstFeature =
        features[0];

    var props =
        firstFeature.properties || {};

    var parcel_uuid =
        (firstFeature.id || '')
            .split('.')[1] || '';


    clearPVLMDSummaryPanel();


    function setText(id, value) {

        var element =
            document.getElementById(id);

        if (element) {

            element.textContent =
                value === null ||
                value === undefined ||
                value === ''
                    ? '-'
                    : value;
        }
    }


    setText(
        'pvlmd_gid',
        parcel_uuid
    );

    setText(
        'pvlmd_reference_number',
        props.reference_number
    );

    setText(
        'pvlmd_nt_number',
        props.nt_number
    );

    setText(
        'pvlmd_file_number',
        props.file_number
    );

    setText(
        'pvlmd_sheet_number',
        props.sheet_number
    );

    setText(
        'pvlmd_locality',
        props.locality
    );

    setText(
        'pvlmd_plot_number',
        props.plot_number
    );

    setText(
        'pvlmd_remarks',
        props.remarks
    );

    setText(
        'pvlmd_modified_by',
        props.plotted_by ||
        props.modified_by ||
        ''
    );

    setText(
        'pvlmd_modified_date',
        props.plotting_date ||
        props.modified_date ||
        ''
    );


    // Load transaction information
    loadAllPVLMDData(
        parcel_uuid,
        props.reference_number
    );


    // Open your EXISTING PVLMD modal
    var modalElement =
        document.getElementById(
            'pvlmdparcelinformation'
        );

    if (modalElement) {

        var modal =
            bootstrap.Modal.getOrCreateInstance(
                modalElement
            );

        modal.show();
    }


    return true;
}


// ================================================================
// FIND PRIMARY PVLMD CONFIG
// ================================================================

function pvlmdGetPrimaryLayerConfig() {

    for (
        var i = 0;
        i < pvlmdClickableLayers.length;
        i++
    ) {

        if (pvlmdClickableLayers[i].primary) {
            return pvlmdClickableLayers[i];
        }
    }

    return null;
}


// ================================================================
// FIND OTHER CLICKABLE LAYERS
// ================================================================

function pvlmdGetSecondaryLayerConfigs() {

    return pvlmdClickableLayers.filter(
        function(config) {

            return !config.primary &&
                   pvlmdCanIdentifyLayer(config);
        }
    );
}


// ================================================================
// QUERY SECONDARY LAYERS
// ================================================================

function pvlmdQuerySecondaryLayers(
    coordinate,
    resolution,
    projection
) {

    var configs =
        pvlmdGetSecondaryLayerConfigs();


    if (configs.length === 0) {
        return Promise.resolve([]);
    }


    var requests =
        configs.map(function(config) {

            return pvlmdQueryLayer(
                config,
                coordinate,
                resolution,
                projection
            );
        });


    return Promise.all(requests);
}


// ================================================================
// SHOW SECONDARY RESULT
// ================================================================
//
// If exactly one layer has data -> open that layer.
//
// If several layers have data -> display a layer selection modal.
// ================================================================

function pvlmdProcessSecondaryResults(results) {

    var matchingResults =
        results.filter(function(result) {

            return result.features &&
                   result.features.length > 0;
        });


    if (matchingResults.length === 0) {

        return false;
    }


    // ============================================================
    // ONLY ONE SECONDARY LAYER HAS DATA
    // ============================================================

    if (matchingResults.length === 1) {

        pvlmdShowIdentifyModal(
            matchingResults[0].config,
            matchingResults[0].features
        );

        return true;
    }


    // ============================================================
    // SEVERAL LAYERS HAVE DATA
    // ============================================================

    pvlmdShowMultiLayerIdentifyDialog(
        matchingResults
    );

    return true;
}


// ================================================================
// MULTIPLE LAYER SELECTION DIALOG
// ================================================================

function pvlmdShowMultiLayerIdentifyDialog(results) {

    var html = `
        <div class="text-start">

            <p class="text-muted mb-3">
                Features were found in multiple map layers.
                Select the layer you want to inspect.
            </p>

            <div class="list-group">
    `;


    results.forEach(function(result, index) {

        var featureCount =
            result.features.length;

        html += `
            <button type="button"
                    class="list-group-item
                           list-group-item-action
                           d-flex
                           justify-content-between
                           align-items-center
                           pvlmd-identify-layer-option"
                    data-result-index="${index}">

                <div>

                    <div class="fw-bold">
                        ${pvlmdEscapeHtml(
                            result.config.title
                        )}
                    </div>

                    <small class="text-muted">
                        ${featureCount}
                        feature${featureCount === 1 ? '' : 's'}
                        found
                    </small>

                </div>

                <span class="badge
                             bg-primary
                             rounded-pill">
                    ${featureCount}
                </span>

            </button>
        `;
    });


    html += `
            </div>

        </div>
    `;


    Swal.fire({

        title: 'Multiple Layers Found',

        html: html,

        icon: 'info',

        showConfirmButton: false,

        showCancelButton: true,

        cancelButtonText: 'Close',

        width: 600,

        didOpen: function() {

            $('.pvlmd-identify-layer-option')
                .off('click')
                .on('click', function() {

                    var index =
                        parseInt(
                            $(this)
                                .attr(
                                    'data-result-index'
                                ),
                            10
                        );


                    var result =
                        results[index];


                    Swal.close();


                    setTimeout(function() {

                        pvlmdShowIdentifyModal(
                            result.config,
                            result.features
                        );

                    }, 200);
                });
        }
    });
}


// ================================================================
// MAP CURSOR
// ================================================================

// pvlmd_map
//     .getTargetElement()
//     .style.cursor = 'default';


// ================================================================
// REPLACE YOUR EXISTING pvlmd_map.on('click'...) WITH THIS
// ================================================================

pvlmd_map.on(
    'click',
    function(evt) {

        // --------------------------------------------------------
        // Do NOT identify map layers while drawing.
        // --------------------------------------------------------

        if (lrd_click_type !== 'MapClick') {
            return;
        }


        var coordinate =
            evt.coordinate;

        var view =
            pvlmd_map.getView();

        var resolution =
            view.getResolution();

        var projection =
            view.getProjection();


        // ========================================================
        // STEP 1
        // QUERY PVLMD CURRENT LAYER FIRST
        //
        // This maintains your existing behaviour.
        // ========================================================

        var primaryConfig =
            pvlmdGetPrimaryLayerConfig();


        var primaryPromise;


        if (primaryConfig &&
            pvlmdCanIdentifyLayer(primaryConfig)) {

            primaryPromise =
                pvlmdQueryLayer(
                    primaryConfig,
                    coordinate,
                    resolution,
                    projection
                );

        } else {

            primaryPromise =
                Promise.resolve({
                    config: primaryConfig,
                    features: []
                });
        }


        primaryPromise.then(
            function(primaryResult) {

                // ------------------------------------------------
                // PVLMD parcel exists.
                //
                // Give PVLMD priority and preserve existing modal.
                // ------------------------------------------------

                if (
                    primaryResult.features &&
                    primaryResult.features.length > 0
                ) {

                    pvlmdProcessCurrentLayerFeatures(
                        primaryResult.features
                    );

                    return;
                }


                // =================================================
                // STEP 2
                // PVLMD CURRENT HAD NOTHING.
                // NOW QUERY OTHER VISIBLE LAYERS.
                // =================================================

                pvlmdQuerySecondaryLayers(
                    coordinate,
                    resolution,
                    projection
                )
                .then(
                    function(results) {

                        pvlmdProcessSecondaryResults(
                            results
                        );
                    }
                )
                .catch(
                    function(error) {

                        console.error(
                            'Secondary layer identify error:',
                            error
                        );
                    }
                );
            }
        )
        .catch(
            function(error) {

                console.error(
                    'PVLMD Current identify error:',
                    error
                );
            }
        );
    }
);


// ================================================================
// ESC KEY / MODAL CLEANUP
// ================================================================

$('#pvlmdGenericIdentifyModal')
    .on(
        'hidden.bs.modal',
        function() {

            pvlmdCurrentIdentifyFeatures = [];
            pvlmdCurrentIdentifyLayer = null;

            $('#pvlmdIdentifyContent')
                .empty();

            $('#pvlmdIdentifyFeatureSelector')
                .empty();

            $('#pvlmdIdentifyMultipleFeatures')
                .addClass('d-none');
        }
    );


// ================================================================
// OPTIONAL PUBLIC FUNCTIONS
// ================================================================
//
// These allow you to enable/disable layer identification later.
//
// Example:
// pvlmdSetLayerClickable('garro', false);
// pvlmdSetLayerClickable('cro', true);
// ================================================================

window.pvlmdSetLayerClickable =
    function(layerKey, enabled) {

        pvlmdClickableLayers.forEach(
            function(config) {

                if (config.key === layerKey) {

                    config.enabled =
                        enabled === true;
                }
            }
        );
    };


// ================================================================
// CHECK CLICKABLE STATUS
// ================================================================

window.pvlmdIsLayerClickable =
    function(layerKey) {

        for (
            var i = 0;
            i < pvlmdClickableLayers.length;
            i++
        ) {

            if (
                pvlmdClickableLayers[i].key ===
                layerKey
            ) {

                return pvlmdClickableLayers[i]
                    .enabled;
            }
        }

        return false;
    };


// ================================================================
// STOP DRAWING AND RETURN TO IDENTIFY MODE
// ================================================================

window.pvlmdReturnToIdentifyMode =
    function() {

        if (pvlmd_drawInteraction) {

            pvlmd_map.removeInteraction(
                pvlmd_drawInteraction
            );

            pvlmd_drawInteraction = null;
        }


        if (pvlmd_modifyInteraction) {

            pvlmd_map.removeInteraction(
                pvlmd_modifyInteraction
            );

            pvlmd_modifyInteraction = null;
        }


        lrd_click_type = 'MapClick';


        $(
            '#pvlmd_btn_draw_polygon,' +
            '#pvlmd_btn_draw_circle,' +
            '#pvlmd_btn_draw_line,' +
            '#pvlmd_btn_modify'
        )
        .removeClass('active');
    };

         
	

// ================================================================
// FUNCTION TO UPDATE PVLMD SUMMARY PANEL
// ================================================================
function updatePVLMDSummaryPanel(data) {
    // Hide the info alert and show the summary fields
    $('#pvlmd_selected_transaction_panel .alert-info').hide();
    $('#pvlmd_summary_fields').show();
    
    // Update all summary fields
    $('#pvlmd_summary_gid').text(data.gid || '-');
    $('#pvlmd_summary_reference').text(data.reference_number || '-');
    $('#pvlmd_summary_file').text(data.file_number || '-');
    $('#pvlmd_summary_property').text(data.property_number || '-');
    $('#pvlmd_summary_nt').text(data.nt_number || '-');
    $('#pvlmd_summary_mutation').text(data.mutation_number || '-');
    $('#pvlmd_summary_deed').text(data.deed_number || '-');
    $('#pvlmd_summary_serial').text(data.serial_number || '-');
    $('#pvlmd_summary_sheet').text(data.sheet_number || '-');
    $('#pvlmd_summary_plan').text(data.plan_number || '-');
    $('#pvlmd_summary_plot').text(data.plot_number || '-');
    $('#pvlmd_summary_lvb').text(data.lvb_number || '-');
    $('#pvlmd_summary_doc').text(data.doc_number || '-');
    $('#pvlmd_summary_party1').text(data.party1_plaintiff || '-');
    $('#pvlmd_summary_party2').text(data.party2_defendant || '-');
    $('#pvlmd_summary_instrument_type').text(data.instrument_type || '-');
    $('#pvlmd_summary_instrument_date').text(data.instrument_date || '-');
    $('#pvlmd_summary_term').text(data.term || '-');
    $('#pvlmd_summary_commencement').text(data.commencement_date || '-');
    $('#pvlmd_summary_purpose').text(data.purpose || '-');
    $('#pvlmd_summary_consideration').text(data.consideration || '-');
    $('#pvlmd_summary_currency').text(data.consideration_currency || '-');
    $('#pvlmd_summary_premium').text(data.premium || '-');
    $('#pvlmd_summary_rent').text(data.rent || '-');
    $('#pvlmd_summary_compensation').text(data.compensation_status || '-');
    $('#pvlmd_summary_suit').text(data.suit_number || '-');
    $('#pvlmd_summary_remarks').text(data.remarks || '-');
    $('#pvlmd_summary_modified_by').text(data.modified_by || '-');
    $('#pvlmd_summary_modified_date').text(data.modified_date || '-');
    
    // Update hidden field
    $('#pvlmd_selected_transaction_gid').val(data.t_id || '');
    
    // Highlight the selected row in the table
    $('.pvlmd-table-row-selected').removeClass('pvlmd-table-row-selected table-primary');
    if (data.t_id) {
        $('#pvlmd_transaction_dataTable tbody tr').each(function() {
            if ($(this).find('.pvlmd-btn-details').data('t_id') == data.t_id) {
                $(this).addClass('pvlmd-table-row-selected table-primary');
            }
        });
    }
    
    console.log('PVLMD Summary panel updated for T_ID:', data.t_id);
}

// ================================================================
// FUNCTION TO CLEAR PVLMD SUMMARY PANEL
// ================================================================
function clearPVLMDSummaryPanel() {
    $('#pvlmd_summary_fields').hide();
    $('#pvlmd_selected_transaction_panel .alert-info').show();
    
    // Clear all summary fields
    $('#pvlmd_summary_gid').text('-');
    $('#pvlmd_summary_reference').text('-');
    $('#pvlmd_summary_file').text('-');
    $('#pvlmd_summary_property').text('-');
    $('#pvlmd_summary_nt').text('-');
    $('#pvlmd_summary_mutation').text('-');
    $('#pvlmd_summary_deed').text('-');
    $('#pvlmd_summary_serial').text('-');
    $('#pvlmd_summary_sheet').text('-');
    $('#pvlmd_summary_plan').text('-');
    $('#pvlmd_summary_plot').text('-');
    $('#pvlmd_summary_lvb').text('-');
    $('#pvlmd_summary_doc').text('-');
    $('#pvlmd_summary_party1').text('-');
    $('#pvlmd_summary_party2').text('-');
    $('#pvlmd_summary_instrument_type').text('-');
    $('#pvlmd_summary_instrument_date').text('-');
    $('#pvlmd_summary_term').text('-');
    $('#pvlmd_summary_commencement').text('-');
    $('#pvlmd_summary_purpose').text('-');
    $('#pvlmd_summary_consideration').text('-');
    $('#pvlmd_summary_currency').text('-');
    $('#pvlmd_summary_premium').text('-');
    $('#pvlmd_summary_rent').text('-');
    $('#pvlmd_summary_compensation').text('-');
    $('#pvlmd_summary_suit').text('-');
    $('#pvlmd_summary_remarks').text('-');
    $('#pvlmd_summary_modified_by').text('-');
    $('#pvlmd_summary_modified_date').text('-');
    
    $('#pvlmd_selected_transaction_gid').val('');
    $('.pvlmd-table-row-selected').removeClass('pvlmd-table-row-selected table-primary');
    
    console.log('PVLMD Summary panel cleared');
}

// ================================================================
// DETAILS BUTTON CLICK HANDLER - UPDATES PVLMD SUMMARY PANEL
// ================================================================
$(document).on('click', '.pvlmd-btn-details', function() {
    // Get all data from the button
    var data = {
        t_id: $(this).data('t_id'),
        reference_number: $(this).data('reference'),
        file_number: $(this).data('file'),
        property_number: $(this).data('property'),
        nt_number: $(this).data('nt'),
        mutation_number: $(this).data('mutation'),
        deed_number: $(this).data('deed'),
        serial_number: $(this).data('serial'),
        sheet_number: $(this).data('sheet'),
        plan_number: $(this).data('plan'),
        plot_number: $(this).data('plot'),
        lvb_number: $(this).data('lvb'),
        doc_number: $(this).data('doc'),
        party1_plaintiff: $(this).data('party1'),
        party1_plaintiff_tel_no: $(this).data('party1-tel'),
        party1_plantiff_add: $(this).data('party1-add'),
        party1_plaintiff_email: $(this).data('party1-email'),
        party2_defendant: $(this).data('party2'),
        party2_defendant_tel_no: $(this).data('party2-tel'),
        party2_defendant_email: $(this).data('party2-email'),
        party2_defendant_add: $(this).data('party2-add'),
        instrument_date: $(this).data('instrument-date'),
        instrument_type: $(this).data('instrument-type'),
        term: $(this).data('term'),
        commencement_date: $(this).data('commencement'),
        purpose: $(this).data('purpose'),
        consent_date: $(this).data('consent'),
        consideration: $(this).data('consideration'),
        consideration_currency: $(this).data('currency'),
        premium: $(this).data('premium'),
        premium_currency: $(this).data('premium-currency'),
        compensation_status: $(this).data('compensation'),
        suit_number: $(this).data('suit'),
        floor_level: $(this).data('floor'),
        apartment_number: $(this).data('apartment'),
        rent: $(this).data('rent'),
        submission_date: $(this).data('submission'),
        unit_description: $(this).data('unit'),
        judgement_in_favour_of: $(this).data('judgement'),
        remarks: $(this).data('remarks'),
        modified_by: $(this).data('modified-by'),
        modified_date: $(this).data('modified-date')
    };
    
    // Update the summary panel
    updatePVLMDSummaryPanel(data);
    
    console.log('PVLMD Transaction selected - T_ID:', data.t_id);
});

// ================================================================
// PVLMD CLEAR SUMMARY BUTTON
// ================================================================
$(document).on('click', '#pvlmd_btn_clear_summary', function() {
    clearPVLMDSummaryPanel();
});

// ================================================================
// PVLMD REFRESH SUMMARY BUTTON
// ================================================================
$(document).on('click', '#pvlmd_btn_refresh_summary', function() {
    var t_id = $('#pvlmd_selected_transaction_gid').val();
    if (t_id) {
        $('#pvlmd_transaction_dataTable tbody tr').each(function() {
            if ($(this).find('.pvlmd-btn-details').data('t_id') == t_id) {
                $(this).find('.pvlmd-btn-details').click();
                return false;
            }
        });
    } else {
        alert('No transaction selected. Please click Details on a transaction first.');
    }
});

// ================================================================
// PVLMD EXPORT SUMMARY BUTTON
// ================================================================
$(document).on('click', '#pvlmd_btn_export_summary', function() {
    var t_id = $('#pvlmd_selected_transaction_gid').val();
    if (!t_id) {
        alert('No transaction selected. Please click Details on a transaction first.');
        return;
    }
    
    var exportData = {
        t_id: $('#pvlmd_summary_gid').text(),
        reference_number: $('#pvlmd_summary_reference').text(),
        file_number: $('#pvlmd_summary_file').text(),
        property_number: $('#pvlmd_summary_property').text(),
        nt_number: $('#pvlmd_summary_nt').text(),
        party1_plaintiff: $('#pvlmd_summary_party1').text(),
        party2_defendant: $('#pvlmd_summary_party2').text(),
        instrument_type: $('#pvlmd_summary_instrument_type').text(),
        instrument_date: $('#pvlmd_summary_instrument_date').text(),
        term: $('#pvlmd_summary_term').text(),
        commencement_date: $('#pvlmd_summary_commencement').text(),
        purpose: $('#pvlmd_summary_purpose').text(),
        consideration: $('#pvlmd_summary_consideration').text(),
        rent: $('#pvlmd_summary_rent').text(),
        remarks: $('#pvlmd_summary_remarks').text()
    };
    
    var jsonString = JSON.stringify(exportData, null, 2);
    var blob = new Blob([jsonString], { type: 'application/json' });
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a');
    a.href = url;
    a.download = 'pvlmd_transaction_summary_' + t_id + '.json';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
});

// ================================================================
// PVLMD PRINT SUMMARY BUTTON
// ================================================================
$(document).on('click', '#pvlmd_btn_print_summary', function() {
    var t_id = $('#pvlmd_selected_transaction_gid').val();
    if (!t_id) {
        alert('No transaction selected. Please click Details on a transaction first.');
        return;
    }
    
    var printWindow = window.open('', '_blank', 'width=800,height=600');
    printWindow.document.write('<html><head><title>PVLMD Transaction Summary</title>');
    printWindow.document.write('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">');
    printWindow.document.write('</head><body>');
    printWindow.document.write('<div class="container mt-4">');
    printWindow.document.write('<h3>PVLMD Transaction Summary</h3>');
    printWindow.document.write('<hr>');
    printWindow.document.write('<table class="table table-bordered">');
    printWindow.document.write('<tr><th>Transaction ID</th><td>' + $('#pvlmd_summary_gid').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Reference Number</th><td>' + $('#pvlmd_summary_reference').text() + '</td></tr>');
    printWindow.document.write('<tr><th>File Number</th><td>' + $('#pvlmd_summary_file').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Property Number</th><td>' + $('#pvlmd_summary_property').text() + '</td></tr>');
    printWindow.document.write('<tr><th>NT Number</th><td>' + $('#pvlmd_summary_nt').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Party 1 (Plaintiff)</th><td>' + $('#pvlmd_summary_party1').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Party 2 (Defendant)</th><td>' + $('#pvlmd_summary_party2').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Instrument Type</th><td>' + $('#pvlmd_summary_instrument_type').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Instrument Date</th><td>' + $('#pvlmd_summary_instrument_date').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Term</th><td>' + $('#pvlmd_summary_term').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Commencement Date</th><td>' + $('#pvlmd_summary_commencement').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Purpose</th><td>' + $('#pvlmd_summary_purpose').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Consideration</th><td>' + $('#pvlmd_summary_consideration').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Rent</th><td>' + $('#pvlmd_summary_rent').text() + '</td></tr>');
    printWindow.document.write('<tr><th>Remarks</th><td>' + $('#pvlmd_summary_remarks').text() + '</td></tr>');
    printWindow.document.write('</table>');
    printWindow.document.write('</div>');
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    
    setTimeout(function() {
        printWindow.print();
    }, 500);
});

// ================================================================
// MODAL SHOW EVENT - Load PVLMD Parcel Information
// // ================================================================
// $('#pvlmdparcelinformation').on('show.bs.modal', function(e) {
//     // Get data from the button that opened the modal
//     var button = $(e.relatedTarget);
//     var parcel_uuid = button.data('gid') || '';
//     var reference_number = button.data('reference') || '';
    
//     // Set hidden fields
//     $('#pvlmd_gid').val(parcel_uuid);
    
//     // Load all data
//     if (parcel_uuid && reference_number) {
//         loadAllPVLMDData(parcel_uuid, reference_number);
//     } else {
//         console.warn('Missing parcel UUID or reference number');
//     }
// });
// ================================================================
// PVLMD PARCEL INFORMATION MODAL
// ================================================================

$('#pvlmdparcelinformation').on('show.bs.modal', function (event) {

    console.log('Opening PVLMD Parcel Information Modal');

    // ============================================================
    // IMPORTANT:
    // When the modal is opened from a button,
    // Bootstrap provides event.relatedTarget.
    //
    // When we open the modal programmatically from the map,
    // event.relatedTarget may be undefined/null.
    //
    // In that case, the map-click function has already populated
    // the modal, so do not overwrite the values.
    // ============================================================

    if (!event.relatedTarget) {

        console.log(
            'PVLMD modal opened programmatically - ' +
            'using data already populated by map click.'
        );

        return;
    }


    // ============================================================
    // GET BUTTON THAT OPENED MODAL
    // ============================================================

    var button = $(event.relatedTarget);

    console.log('PVLMD modal trigger button:');
    console.log(button);


    // ============================================================
    // CLEAR OLD TRANSACTION SUMMARY
    // ============================================================

    clearPVLMDSummaryPanel();


    // ============================================================
    // READ DATA FROM BUTTON
    // ============================================================

    var parcel_uuid =
        button.data('parcel_uuid');

    var nt_number =
        button.data('nt_number');

    var cro_reference =
        button.data('cro_reference');

    var property_number =
        button.data('property_number');

    var reference_number =
        button.data('reference_number');

    var file_number =
        button.data('file_number');

    var sheet_number =
        button.data('sheet_number');

    var locality =
        button.data('locality');

    var plot_number =
        button.data('plot_number');

    var modified_by =
        button.data('modified_by');

    var modified_date =
        button.data('modified_date');

    var remarks =
        button.data('remarks');


    console.log(
        'Loading parcel:',
        parcel_uuid,
        reference_number
    );


    // ============================================================
    // HELPER FUNCTION
    // ============================================================

    function setText(id, value) {

        var element =
            document.getElementById(id);

        if (element) {

            if (
                value !== undefined &&
                value !== null &&
                value !== ''
            ) {
                element.textContent =
                    value;
            } else {
                element.textContent =
                    '-';
            }
        }
    }


    // ============================================================
    // POPULATE PARCEL INFORMATION
    // ============================================================

    setText(
        'pvlmd_gid',
        parcel_uuid
    );

    setText(
        'pvlmd_reference_number',
        reference_number
    );

    setText(
        'pvlmd_nt_number',
        nt_number
    );

    setText(
        'pvlmd_file_number',
        file_number
    );

    setText(
        'pvlmd_sheet_number',
        sheet_number
    );

    setText(
        'pvlmd_locality',
        locality
    );

    setText(
        'pvlmd_plot_number',
        plot_number
    );

    setText(
        'pvlmd_remarks',
        remarks
    );

    setText(
        'pvlmd_modified_by',
        modified_by
    );

    setText(
        'pvlmd_modified_date',
        modified_date
    );


    // ============================================================
    // LOAD TRANSACTIONS
    // ============================================================

    if (
        parcel_uuid ||
        reference_number
    ) {

        loadAllPVLMDData(
            parcel_uuid,
            reference_number
        );

    } else {

        console.warn(
            'Cannot load PVLMD transactions: ' +
            'parcel_uuid and reference_number are empty.'
        );
    }

});


// ================================================================
// FIX BOOTSTRAP ARIA-HIDDEN / FOCUS WARNING
// ================================================================

$('#pvlmdparcelinformation').on(
    'hide.bs.modal',
    function () {

        var modalElement =
            this;

        var activeElement =
            document.activeElement;


        // If focus is currently somewhere inside
        // the modal, remove it BEFORE Bootstrap
        // adds aria-hidden="true".
        if (
            activeElement &&
            modalElement.contains(
                activeElement
            )
        ) {

            activeElement.blur();
        }
    }
);

// ================================================================
// GENERIC IDENTIFY MODAL - CLEANUP ON CLOSE
// ================================================================
$(document).on(
    'hidden.bs.modal',
    '#pvlmdGenericIdentifyModal',
    function () {

        // Reset stored feature state
        pvlmdCurrentIdentifyFeatures = [];
        pvlmdCurrentIdentifyLayer = null;

        $('#pvlmdIdentifyContent').empty();
        $('#pvlmdIdentifyFeatureSelector').empty();
        $('#pvlmdIdentifyMultipleFeatures').addClass('d-none');
        $('#pvlmdIdentifyNoData').addClass('d-none');
        $('#pvlmdIdentifyLoading').addClass('d-none');

        // Ensure no orphaned backdrop is left behind
        setTimeout(pvlmdCleanupBootstrapBackdrops, 0);

        // Blur the modal button so the map canvas regains the page
        var active = document.activeElement;
        if (active && active.blur) {
            active.blur();
        }
    }
);


// ================================================================
// SAME FIX FOR THE PVLMD PARCEL INFORMATION MODAL
// ================================================================
$(document).on(
    'hidden.bs.modal',
    '#pvlmdparcelinformation',
    function () {
        setTimeout(pvlmdCleanupBootstrapBackdrops, 0);
    }
);

// ================================================================
// LOAD ALL PVLMD DATA
// ================================================================

function loadAllPVLMDData(
    parcel_uuid,
    reference_number
) {

    console.log(
        'Loading all PVLMD data for:',
        parcel_uuid,
        reference_number
    );


    // ============================================================
    // VALIDATE PARAMETERS
    // ============================================================

    if (
        (!parcel_uuid ||
            parcel_uuid === '') &&
        (!reference_number ||
            reference_number === '')
    ) {

        console.warn(
            'loadAllPVLMDData(): ' +
            'parcel_uuid and reference_number are empty.'
        );

        return;
    }


    // ============================================================
    // TRANSACTION TABLE
    // ============================================================

    var table =
        $('#pvlmd_transaction_dataTable');


    table
        .find('tbody tr')
        .remove();


    table.append(
        "<tr>" +
        "<td colspan='5' " +
        "class='text-center'>" +
        "Loading transactions..." +
        "</td>" +
        "</tr>"
    );


    // ============================================================
    // AJAX
    // ============================================================

    $.ajax({

        type: 'POST',

        url: 'Maps',

        data: {

            request_type:
                'pvlmd_transaction_select_by_reference_number_main',

            reference_number:
                reference_number || '',

            gid_fk:
                parcel_uuid || ''
        },

        cache: false,


        // ========================================================
        // SUCCESS
        // ========================================================

        success: function (
            serviceresponse
        ) {

            try {

                // =================================================
                // SAFE JSON PARSING
                // =================================================

                var json_p;


                if (
                    typeof serviceresponse ===
                    'object'
                ) {

                    json_p =
                        serviceresponse;

                } else {

                    try {

                        json_p =
                            JSON.parse(
                                serviceresponse
                            );

                    } catch (
                        parseError
                    ) {

                        console.error(
                            'JSON Parse Error:',
                            parseError.message
                        );


                        table
                            .find(
                                'tbody tr'
                            )
                            .remove();


                        table.append(
                            "<tr>" +
                            "<td colspan='5' " +
                            "class='text-center text-danger'>" +
                            "Error parsing transaction data" +
                            "</td>" +
                            "</tr>"
                        );


                        return;
                    }
                }


                console.log(
                    'PVLMD Transaction Details:',
                    json_p
                );


                // =================================================
                // DISPLAY / ZOOM TO PARCEL WKT
                // =================================================

                if (
                    json_p &&
                    json_p.wkt &&
                    typeof json_p.wkt ===
                        'string' &&
                    json_p.wkt.trim() !==
                        ''
                ) {

                    try {

                        console.log(
                            'Loading PVLMD WKT:',
                            json_p.wkt
                        );


                        // =========================================
                        // STORE WKT
                        // =========================================

                        $('#pvlmd_bl_wkt_polygon')
                            .val(
                                json_p.wkt
                            );


                        // =========================================
                        // READ WKT
                        // =========================================

                        var wktFormat =
                            new ol.format.WKT();


                        var features =
                            wktFormat.readFeatures(
                                json_p.wkt
                            );


                        // =========================================
                        // CREATE VECTOR SOURCE
                        // =========================================

                        var vectorSource =
                            new ol.source.Vector({
                                features:
                                    features
                            });


                        // =========================================
                        // SET SEARCH LAYER SOURCE
                        // =========================================

                        pvlmd_lc_searchLayer
                            .setSource(
                                vectorSource
                            );


                        // =========================================
                        // GET EXTENT
                        // =========================================

                        var extent =
                            vectorSource
                                .getExtent();


                        // =========================================
                        // VALIDATE EXTENT
                        // =========================================

                        if (
                            extent &&
                            !ol.extent.isEmpty(
                                extent
                            )
                        ) {

                            // =====================================
                            // IMPORTANT FIX:
                            //
                            // OLD CODE:
                            // view.fit(...)
                            // map.getSize()
                            //
                            // NEW CODE:
                            // pvlmd_map.getView()
                            // pvlmd_map.getSize()
                            // =====================================

                            pvlmd_map
                                .getView()
                                .fit(
                                    extent,
                                    {
                                        size:
                                            pvlmd_map
                                                .getSize(),

                                        maxZoom:
                                            16,

                                        padding: [
                                            50,
                                            50,
                                            50,
                                            50
                                        ],

                                        duration:
                                            500
                                    }
                                );

                        } else {

                            console.warn(
                                'PVLMD parcel has an empty extent.'
                            );
                        }


                    } catch (
                        geometryError
                    ) {

                        console.error(
                            'Error loading PVLMD WKT:',
                            geometryError
                        );
                    }

                } else {

                    console.warn(
                        'No WKT geometry returned for PVLMD parcel.'
                    );
                }


                // =================================================
                // CLEAR LOADING MESSAGE
                // =================================================

                table
                    .find(
                        'tbody tr'
                    )
                    .remove();


                // =================================================
                // PROCESS TRANSACTION DATA
                // =================================================

                if (
                    json_p &&
                    json_p.data &&
                    Array.isArray(
                        json_p.data
                    )
                ) {


                    // =============================================
                    // NO TRANSACTIONS
                    // =============================================

                    if (
                        json_p.data.length ===
                        0
                    ) {

                        table.append(
                            "<tr>" +
                            "<td colspan='5' " +
                            "class='text-center'>" +
                            "No transactions found" +
                            "</td>" +
                            "</tr>"
                        );

                        return;
                    }


                    // =============================================
                    // ADD TRANSACTION ROWS
                    // =============================================

                    $.each(
                        json_p.data,
                        function (
                            index,
                            item
                        ) {

                            table.append(

                                "<tr>" +

                                "<td>" +
                                (
                                    item.party2_defendant ||
                                    'N/A'
                                ) +
                                "</td>" +

                                "<td>" +
                                (
                                    item.party1_plaintiff ||
                                    'N/A'
                                ) +
                                "</td>" +

                                "<td>" +
                                (
                                    item.reference_number ||
                                    'N/A'
                                ) +
                                "</td>" +

                                "<td>" +
                                (
                                    item.instrument_type ||
                                    'N/A'
                                ) +
                                "</td>" +

                                '<td class="text-center">' +

                                '<button ' +
                                'type="button" ' +
                                'class="btn btn-info btn-sm pvlmd-btn-details" ' +

                                'data-t_id="' +
                                escapePVLMDAttribute(
                                    item.t_id
                                ) +
                                '" ' +

                                'data-reference="' +
                                escapePVLMDAttribute(
                                    item.reference_number
                                ) +
                                '" ' +

                                'data-file="' +
                                escapePVLMDAttribute(
                                    item.file_number
                                ) +
                                '" ' +

                                'data-property="' +
                                escapePVLMDAttribute(
                                    item.property_number
                                ) +
                                '" ' +

                                'data-nt="' +
                                escapePVLMDAttribute(
                                    item.nt_number
                                ) +
                                '" ' +

                                'data-mutation="' +
                                escapePVLMDAttribute(
                                    item.mutation_number
                                ) +
                                '" ' +

                                'data-deed="' +
                                escapePVLMDAttribute(
                                    item.deed_number
                                ) +
                                '" ' +

                                'data-serial="' +
                                escapePVLMDAttribute(
                                    item.serial_number
                                ) +
                                '" ' +

                                'data-sheet="' +
                                escapePVLMDAttribute(
                                    item.sheet_number
                                ) +
                                '" ' +

                                'data-plan="' +
                                escapePVLMDAttribute(
                                    item.plan_number
                                ) +
                                '" ' +

                                'data-plot="' +
                                escapePVLMDAttribute(
                                    item.plot_number
                                ) +
                                '" ' +

                                'data-lvb="' +
                                escapePVLMDAttribute(
                                    item.lvb_number
                                ) +
                                '" ' +

                                'data-doc="' +
                                escapePVLMDAttribute(
                                    item.doc_number
                                ) +
                                '" ' +

                                'data-party1="' +
                                escapePVLMDAttribute(
                                    item.party1_plaintiff
                                ) +
                                '" ' +

                                'data-party1-tel="' +
                                escapePVLMDAttribute(
                                    item.party1_plaintiff_tel_no
                                ) +
                                '" ' +

                                'data-party1-add="' +
                                escapePVLMDAttribute(
                                    item.party1_plantiff_add
                                ) +
                                '" ' +

                                'data-party1-email="' +
                                escapePVLMDAttribute(
                                    item.party1_plaintiff_email
                                ) +
                                '" ' +

                                'data-party2="' +
                                escapePVLMDAttribute(
                                    item.party2_defendant
                                ) +
                                '" ' +

                                'data-party2-tel="' +
                                escapePVLMDAttribute(
                                    item.party2_defendant_tel_no
                                ) +
                                '" ' +

                                'data-party2-email="' +
                                escapePVLMDAttribute(
                                    item.party2_defendant_email
                                ) +
                                '" ' +

                                'data-party2-add="' +
                                escapePVLMDAttribute(
                                    item.party2_defendant_add
                                ) +
                                '" ' +

                                'data-instrument-date="' +
                                escapePVLMDAttribute(
                                    item.instrument_date
                                ) +
                                '" ' +

                                'data-instrument-type="' +
                                escapePVLMDAttribute(
                                    item.instrument_type
                                ) +
                                '" ' +

                                'data-term="' +
                                escapePVLMDAttribute(
                                    item.term
                                ) +
                                '" ' +

                                'data-commencement="' +
                                escapePVLMDAttribute(
                                    item.commencement_date
                                ) +
                                '" ' +

                                'data-purpose="' +
                                escapePVLMDAttribute(
                                    item.purpose
                                ) +
                                '" ' +

                                'data-consent="' +
                                escapePVLMDAttribute(
                                    item.consent_date
                                ) +
                                '" ' +

                                'data-consideration="' +
                                escapePVLMDAttribute(
                                    item.consideration
                                ) +
                                '" ' +

                                'data-currency="' +
                                escapePVLMDAttribute(
                                    item.consideration_currency
                                ) +
                                '" ' +

                                'data-premium="' +
                                escapePVLMDAttribute(
                                    item.premium
                                ) +
                                '" ' +

                                'data-premium-currency="' +
                                escapePVLMDAttribute(
                                    item.premium_currency
                                ) +
                                '" ' +

                                'data-compensation="' +
                                escapePVLMDAttribute(
                                    item.compensation_status
                                ) +
                                '" ' +

                                'data-suit="' +
                                escapePVLMDAttribute(
                                    item.suit_number
                                ) +
                                '" ' +

                                'data-floor="' +
                                escapePVLMDAttribute(
                                    item.floor_level
                                ) +
                                '" ' +

                                'data-apartment="' +
                                escapePVLMDAttribute(
                                    item.apartment_number
                                ) +
                                '" ' +

                                'data-rent="' +
                                escapePVLMDAttribute(
                                    item.rent
                                ) +
                                '" ' +

                                'data-submission="' +
                                escapePVLMDAttribute(
                                    item.submission_date
                                ) +
                                '" ' +

                                'data-unit="' +
                                escapePVLMDAttribute(
                                    item.unit_description
                                ) +
                                '" ' +

                                'data-judgement="' +
                                escapePVLMDAttribute(
                                    item.judgement_in_favour_of
                                ) +
                                '" ' +

                                'data-remarks="' +
                                escapePVLMDAttribute(
                                    item.remarks
                                ) +
                                '" ' +

                                'data-modified-by="' +
                                escapePVLMDAttribute(
                                    item.modified_by ||
                                    item.entered_by
                                ) +
                                '" ' +

                                'data-modified-date="' +
                                escapePVLMDAttribute(
                                    item.modified_date ||
                                    item.checked_by_date
                                ) +
                                '" ' +

                                'title="View Details">' +

                                '<i class="fas fa-info-circle"></i> ' +
                                'Details' +

                                '</button>' +

                                '</td>' +

                                '</tr>'
                            );
                        }
                    );


                } else {

                    console.warn(
                        'No data array found in response:',
                        json_p
                    );


                    table.append(
                        "<tr>" +
                        "<td colspan='5' " +
                        "class='text-center'>" +
                        "No data available" +
                        "</td>" +
                        "</tr>"
                    );
                }


            } catch (
                error
            ) {

                console.error(
                    'Error processing PVLMD transaction details:',
                    error
                );


                table
                    .find(
                        'tbody tr'
                    )
                    .remove();


                table.append(
                    "<tr>" +
                    "<td colspan='5' " +
                    "class='text-center text-danger'>" +
                    "Error loading transactions" +
                    "</td>" +
                    "</tr>"
                );
            }
        },


        // ========================================================
        // AJAX ERROR
        // ========================================================

        error: function (
            xhr,
            status,
            error
        ) {

            console.error(
                'AJAX Error - ' +
                'pvlmd_transaction_select_by_reference_number_main'
            );

            console.error(
                'Status:',
                status
            );

            console.error(
                'Error:',
                error
            );

            console.error(
                'HTTP Status:',
                xhr.status
            );


            table
                .find(
                    'tbody tr'
                )
                .remove();


            var errorMsg =
                'Failed to load transactions';


            if (
                xhr.status ===
                0
            ) {

                errorMsg =
                    'Network error - ' +
                    'please check your connection';

            } else if (
                xhr.status ===
                404
            ) {

                errorMsg =
                    'Resource not found';

            } else if (
                xhr.status ===
                500
            ) {

                errorMsg =
                    'Server error - ' +
                    'please try again later';
            }


            table.append(
                "<tr>" +
                "<td colspan='5' " +
                "class='text-center text-danger'>" +
                errorMsg +
                "</td>" +
                "</tr>"
            );
        }

    });
}


// ================================================================
// ESCAPE VALUES USED INSIDE HTML DATA ATTRIBUTES
// ================================================================

function escapePVLMDAttribute(
    value
) {

    if (
        value === undefined ||
        value === null
    ) {
        return '';
    }


    return String(value)

        .replace(
            /&/g,
            '&amp;'
        )

        .replace(
            /"/g,
            '&quot;'
        )

        .replace(
            /'/g,
            '&#39;'
        )

        .replace(
            /</g,
            '&lt;'
        )

        .replace(
            />/g,
            '&gt;'
        );
}

// Using modal show event instead of onclick
$('#addpvlmdtransactionlong').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    var t_id = button.data('t_id');
    
   // console.log('Modal showing, t_id:', t_id);

	    // Close the parcel information modal if it's open
       // Open your EXISTING PVLMD modal - safely
    pvlmdBlurMapCanvas();
    pvlmdCleanupBootstrapBackdrops();

    var modalElement =
        document.getElementById('pvlmdparcelinformation');

    if (modalElement) {

        // Dispose any previous instance so Bootstrap does not
        // reuse a stale one (this is what causes the freeze).
        var existing =
            bootstrap.Modal.getInstance(modalElement);

        if (existing) {
            try { existing.dispose(); } catch (e) {}
        }

        var modal =
            new bootstrap.Modal(modalElement, {
                backdrop: true,
                keyboard: true,
                focus: true
            });

        modal.show();
    }
    
    if (t_id) {
       // loadTransactionData(t_id);
	    $.ajax({
        type: "POST",
        url: 'Maps',
        data: {
            request_type: 'select_pvlmd_transactions_details_by_t_id',
            t_id: t_id
        },
        cache: false,
        success: function(serviceresponse) {
            var json_p = safeParseJSON(serviceresponse, { data: [] });
           //'Transaction details:', json_p);
            
            if (json_p && json_p.data && json_p.data.length > 0) {
                var data = json_p.data[0];
                populateTransactionModal(data);
            } else {
                showErrorInModal('No transaction data found');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error loading transaction details:', error);
            showErrorInModal('Error loading transaction details. Please try again.');
        }
    });
    } else {
        console.warn('No t_id found on button');
        // Show empty state
        var modalBody = document.querySelector('#addpvlmdtransactionlong .modal-body');
        if (modalBody) {
            modalBody.innerHTML = `
                <div class="text-center py-4 text-muted">
                    <i class="fas fa-inbox fa-3x mb-3"></i>
                    <p>No transaction data available</p>
                </div>
            `;
        }
    }
});

// Function to load transaction data
function loadTransactionData(t_id) {
   // console.log('Loading transaction data for ID:', t_id);
    
    if (!t_id) {
       // console.warn('No transaction ID provided');
        return;
    }
    
    // Show loading state in modal
    var loadingHtml = `
        <div class="text-center py-4">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-2 text-muted">Loading transaction details...</p>
        </div>
    `;
    
    // Clear all fields and show loading
    var modalBody = document.querySelector('#addpvlmdtransactionlong .modal-body');
    if (modalBody) {
        modalBody.innerHTML = loadingHtml;
    }
    
   
}

// Function to populate the modal with data
function populateTransactionModal(data) {
    // Helper function to set text content
    function setText(id, value) {
        var element = document.getElementById(id);
        if (element) {
            element.textContent = value || '-';
        }
    }
    
    // Check if modal body exists and restore structure if needed
    var modalBody = document.querySelector('#addpvlmdtransactionlong .modal-body');
    if (modalBody) {
        // If the modal body was replaced with loading HTML, restore the structure
        // This assumes your modal has the structure we designed
        var originalStructure = `
            <input id="pvlmd_gid" name="pvlmd_tr_gid" type="hidden">
            <input id="pvlmd_tr_t_id" name="pvlmd_tr_t_id" type="hidden" value="0">
            <div class="row g-3">
                <!-- Left Column -->
                <div class="col-md-6">
                    <!-- Reference & File -->
                    <div class="row g-2 mb-2">
                        <div class="col-6">
                            <label class="text-muted small fw-bold">Reference No.</label>
                            <p class="fw-semibold mb-0" id="pvlmd_tr_reference_number">-</p>
                        </div>
                        <div class="col-6">
                            <label class="text-muted small fw-bold">File No.</label>
                            <p class="fw-semibold mb-0" id="pvlmd_tr_file_number">-</p>
                        </div>
                    </div>
                    <!-- Rest of your fields... -->
                </div>
                <!-- Right Column -->
                <div class="col-md-6">
                    <!-- All right column fields -->
                </div>
            </div>
        `;
        // Only restore if the body was replaced (contains loading text)
        if (modalBody.innerHTML.includes('Loading transaction details')) {
            // Restore original structure (you should have this stored)
            // For now, we'll just populate existing fields
        }
    }
    
    // Map data to fields - set all fields
    var fieldMap = {
        'pvlmd_tr_reference_number': data.reference_number,
        'pvlmd_tr_file_number': data.file_number,
        'pvlmd_tr_property_number': data.property_number,
        'pvlmd_tr_nt_number': data.nt_number,
        'pvlmd_tr_mutation_number': data.mutation_number,
        'pvlmd_tr_deed_number': data.deed_number,
        'pvlmd_tr_serial_number': data.serial_number,
        'pvlmd_tr_sheet_number': data.sheet_number,
        'pvlmd_tr_plan_number': data.plan_number,
        'pvlmd_tr_plot_number': data.plot_number,
        'pvlmd_tr_lvb_number': data.lvb_number,
        'pvlmd_tr_doc_number': data.doc_number,
        'pvlmd_tr_party1_plaintiff': data.party1_plaintiff,
        'pvlmd_tr_party1_plaintiff_tel_no': data.party1_plaintiff_tel_no,
        'pvlmd_tr_party1_plantiff_add': data.party1_plantiff_add,
        'pvlmd_tr_party1_plaintiff_email': data.party1_plaintiff_email,
        'pvlmd_tr_party2_defendant': data.party2_defendant,
        'pvlmd_tr_party2_defendant_tel_no': data.party2_defendant_tel_no,
        'pvlmd_tr_party2_defendant_email': data.party2_defendant_email,
        'pvlmd_tr_party2_defendant_add': data.party2_defendant_add,
        'pvlmd_tr_instrument_date': data.instrument_date,
        'pvlmd_tr_instrument_type': data.instrument_type,
        'pvlmd_tr_term': data.term,
        'pvlmd_tr_commencement_date': data.commencement_date,
        'pvlmd_tr_purpose': data.purpose,
        'pvlmd_tr_consent_date': data.consent_date,
        'pvlmd_tr_consideration': data.consideration,
        'pvlmd_tr_consideration_currency': data.consideration_currency,
        'pvlmd_tr_premium': data.premium,
        'pvlmd_tr_premium_currency': data.premium_currency,
        'pvlmd_tr_compensation_status': data.compensation_status,
        'pvlmd_tr_suit_number': data.suit_number,
        'pvlmd_tr_floor_level': data.floor_level,
        'pvlmd_tr_apartment_number': data.apartment_number,
        'pvlmd_tr_rent': data.rent,
        'pvlmd_tr_submission_date': data.submission_date,
        'pvlmd_tr_unit_description': data.unit_description,
        'pvlmd_tr_judgement_in_favour_of': data.judgement_in_favour_of,
        'pvlmd_tr_remarks': data.remarks,
        'pvlmd_tr_modified_by': data.modified_by || data.entered_by || '-',
        'pvlmd_tr_modified_date': data.modified_date || data.checked_by_date || '-'
    };

    // Set all fields
    for (var id in fieldMap) {
        if (fieldMap.hasOwnProperty(id)) {
            setText(id, fieldMap[id]);
        }
    }

    // Set hidden fields
    if (data.gid_id_fk) {
        var gidElement = document.getElementById('pvlmd_gid');
        if (gidElement) gidElement.value = data.gid_id_fk;
    }
    if (data.t_id) {
        var tIdElement = document.getElementById('pvlmd_tr_t_id');
        if (tIdElement) tIdElement.value = data.t_id;
    }
    
    // Remove any loading state
    var modalBody2 = document.querySelector('#addpvlmdtransactionlong .modal-body');
    if (modalBody2 && modalBody2.innerHTML.includes('Loading transaction details')) {
        // The fields are already populated above
        // We just need to ensure the structure is visible
       //'Data loaded successfully');
    }
}

// Helper function to show error in modal
function showErrorInModal(message) {
    var modalBody = document.querySelector('#addpvlmdtransactionlong .modal-body');
    if (modalBody) {
        modalBody.innerHTML = `
            <div class="text-center py-4">
                <i class="fas fa-exclamation-triangle fa-3x text-danger mb-3"></i>
                <p class="text-danger fw-bold">${message}</p>
                <button class="btn btn-outline-secondary btn-sm mt-2" onclick="location.reload()">
                    <i class="fas fa-sync-alt me-1"></i>Refresh
                </button>
            </div>
        `;
    }
}

// Safe JSON parse helper
function safeParseJSON(response, fallback) {
    if (!response || response === '' || response === 'null' || response === 'undefined') {
        return fallback || null;
    }
    try {
        return JSON.parse(response);
    } catch (e) {
        console.error('JSON Parse Error:', e);
        console.error('Raw response:', response);
        return fallback || null;
    }
}

// Reset modal when closed (optional)
document.addEventListener('DOMContentLoaded', function() {
    var modalElement = document.getElementById('addpvlmdtransactionlong');
    if (modalElement) {
        modalElement.addEventListener('hidden.bs.modal', function() {
            // Reset any state if needed
          //  console.log('Modal closed');
        });
    }
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

					
					
    // 1. pvlmd_btn_visualise_coordinate - Converted from addEventListener
    // $('#pvlmd_btn_visualise_coordinate').on('click', function(e) {
    //     let jsonArr = [];
    //     let polygonPoints = [];

    //     $('#coordinatelis_Table tbody tr').each(function() {
    //         let name = $(this).find('td:eq(0)').text().trim();
    //         let x = $(this).find('td:eq(1)').text().trim();
    //         let y = $(this).find('td:eq(2)').text().trim();

    //         jsonArr.push({
    //             coordinate_name: name,
    //             x_coordinate: x,
    //             y_coordinate: y
    //         });

    //         polygonPoints.push(y + " " + x);
    //     });

    //     // Close polygon by repeating first point
    //     if (polygonPoints.length > 0) {
    //         polygonPoints.push(polygonPoints[0]);
    //     }

    //     let polygonWKT = "POLYGON((" + polygonPoints.join(', ') + "))";
    //    // console.log(jsonArr);
    //    // console.log(polygonWKT);

    //     $('#pvlmd_bl_wkt_polygon').val(polygonWKT);

    //     pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
    //         features: (new ol.format.WKT()).readFeatures(polygonWKT)
    //     }));
        
    //     view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
    //     pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(), {
    //         size: pvlmd_map.getSize(),
    //         maxZoom: 16
    //     });
    // });

// 	$('#pvlmd_btn_visualise_coordinate').on('click', function(e) {
//     let polygonGroups = {};

//     // Group coordinates by polygon
//     $('#coordinatelis_Table tbody tr').each(function() {
//         let name = $(this).find('td:eq(0)').text().trim();
//         let x = parseFloat($(this).find('td:eq(1)').text().trim());
//         let y = parseFloat($(this).find('td:eq(2)').text().trim());

//         // Extract polygon identifier from name (e.g., "P1-1" -> "P1")
//         let polygonId = name.split('-')[0] || 'polygon1';
        
//         if (!polygonGroups[polygonId]) {
//             polygonGroups[polygonId] = [];
//         }
//         polygonGroups[polygonId].push(y + " " + x);
//     });

//     // Build polygons
//     let polygons = [];
//     Object.keys(polygonGroups).forEach(key => {
//         let points = polygonGroups[key];
//         if (points.length > 0) {
//             points.push(points[0]); // Close polygon
//             polygons.push(points);
//         }
//     });

//     // Generate WKT
//     let wkt;
//     if (polygons.length === 1) {
//         wkt = "POLYGON((" + polygons[0].join(', ') + "))";
//     } else {
//         let polygonWKTs = polygons.map(poly => 
//             "((" + poly.join(', ') + "))"
//         );
//         wkt = "MULTIPOLYGON(" + polygonWKTs.join(', ') + ")";
//     }

//     $('#pvlmd_bl_wkt_polygon').val(wkt);
    
//     // Update map...
//     pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
//         features: (new ol.format.WKT()).readFeatures(wkt)
//     }));
    
//     view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
//     pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(), {
//         size: pvlmd_map.getSize(),
//         maxZoom: 16
//     });
// });
$('#pvlmd_btn_visualise_coordinate').on('click', function(e) {
    let polygonGroups = {};

    // Group coordinates by polygon
    $('#coordinatelis_Table tbody tr').each(function() {
        let name = $(this).find('td:eq(0)').text().trim();
        let x = parseFloat($(this).find('td:eq(1)').text().trim());
        let y = parseFloat($(this).find('td:eq(2)').text().trim());

        let parts = name.split('-');
        let polygonId = parts[0] || 'polygon1';
        let ringType = parts[1] || 'outer';
        
        if (!polygonGroups[polygonId]) {
            polygonGroups[polygonId] = { outer: [], inner: [] };
        }
        
        if (ringType === 'inner') {
            polygonGroups[polygonId].inner.push({x: x, y: y});
        } else {
            polygonGroups[polygonId].outer.push({x: x, y: y});
        }
    });

    // Function to calculate polygon area (positive = CCW, negative = CW)
    function calculateArea(points) {
        let area = 0;
        for (let i = 0; i < points.length - 1; i++) {
            area += (points[i].x * points[i+1].y - points[i+1].x * points[i].y);
        }
        // Close the polygon for area calculation
        let last = points.length - 1;
        area += (points[last].x * points[0].y - points[0].x * points[last].y);
        return area / 2;
    }

    // Function to reverse ring order
    function reverseRing(points) {
        return points.slice().reverse();
    }

    // Build polygons with correct orientation
    let polygons = [];
    Object.keys(polygonGroups).forEach(key => {
        let group = polygonGroups[key];
        
        // Ensure outer ring is counter-clockwise
        let outerArea = calculateArea(group.outer);
        if (outerArea < 0) {
            // Reverse to make it CCW
            group.outer = reverseRing(group.outer);
        }
        
        // Ensure inner rings are clockwise
        if (group.inner.length > 0) {
            let innerArea = calculateArea(group.inner);
            if (innerArea > 0) {
                // Reverse to make it CW
                group.inner = reverseRing(group.inner);
            }
        }
        
        // Close rings
        if (group.outer.length > 0) {
            group.outer.push(group.outer[0]);
        }
        if (group.inner.length > 0) {
            group.inner.push(group.inner[0]);
        }
        
        // Build polygon WKT
        let outerWKT = group.outer.map(p => p.y + " " + p.x).join(', ');
        let polygonWKT = "((" + outerWKT;
        
        if (group.inner.length > 0) {
            let innerWKT = group.inner.map(p => p.y + " " + p.x).join(', ');
            polygonWKT += ", " + innerWKT;
        }
        
        polygonWKT += "))";
        polygons.push(polygonWKT);
    });

    // Generate final WKT
    let wkt;
    if (polygons.length === 1) {
        wkt = "POLYGON" + polygons[0];
    } else {
        wkt = "MULTIPOLYGON(" + polygons.join(', ') + ")";
    }

    $('#pvlmd_bl_wkt_polygon').val(wkt);

	if(wkt) {
		$('#pvlmd_btn_request_add_existing_parcel').removeClass('d-none')
	}
    
    // Update map
    try {
        pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
            features: (new ol.format.WKT()).readFeatures(wkt)
        }));
        
        view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
        pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(), {
            size: pvlmd_map.getSize(),
            maxZoom: 16
        });
    } catch (error) {
        console.log('Map update error:', error);
        alert('Error rendering polygon: ' + error.message);
    }
});

    // 2. pvlmd_btn_save_wkt - Converted from addEventListener
    $('#pvlmd_btn_save_wkt').on('click', function() {
        var wktplygonsearch = $("#pvlmd_bl_wkt_polygon").val();
        $("#pvlmdparcelinformationfirsttimesave").modal();
        $('#pvlmdparcelinformationfirsttimesave #pvlmd_parcel_wkt_to_plot_fts').val(wktplygonsearch);
    });

    // 3. pvlmd_btn_visualise_wkt - Converted from addEventListener
    $('#pvlmd_btn_visualise_wkt').on('click', function(e) {
        var wktplygonsearch = $("#pvlmd_bl_wkt_polygon").val();
       // console.log(wktplygonsearch);

        pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
            features: (new ol.format.WKT()).readFeatures(wktplygonsearch)
        }));
        
        view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
        pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(), {
            size: pvlmd_map.getSize(),
            maxZoom: 16
        });
    });

    // 4. btn_save_pvlmd_parcel_details_fts - Converted from addEventListener
    $('#btn_save_pvlmd_parcel_details_fts').on('click', function(e) {
        var wktplygonsearch = $("#pvlmd_parcel_wkt_to_plot_fts").val();
        var file_number = $("#pvlmd_file_number_fts").val();
        var sheet_number = $("#pvlmd_sheet_number_fts").val();
        var locality = $("#pvlmd_locality_fts").val();
        var remarks = $("#pvlmd_remarks_fts").val();

        $.ajax({
            type: "POST",
            url: "Maps",
            data: {
                request_type: 'pvlmd_polygon_for_save_with_info',
                wkt_polgon: wktplygonsearch,
                file_number: file_number,
                sheet_number: sheet_number,
                locality: locality,
                remarks: remarks
            },
            cache: false,
            success: function(jobdetails) {
               // console.log(jobdetails);
                var json_p = JSON.parse(jobdetails);

                $('#pvlmdparcelinformationfirsttimesave #pvlmd_gid_fts').val(json_p.gid);
                $('#pvlmdparcelinformationfirsttimesave #pvlmd_reference_number_fts').val(json_p.reference_number);
                $('#pvlmdparcelinformationfirsttimesave #pvlmd_nt_number_fts').val(json_p.nt_number);
                $("#btn_save_pvlmd_parcel_details_fts").prop("disabled", true);
            }
        });
    });

    // 5. pvlmd_btn_show_location - Converted from addEventListener
    $('#pvlmd_btn_show_location').on('click', function(e) {
      //  console.log('berhbehr');
        pvlmd_markers.getSource().clear();
        
        var x_coordinate_mak = $('#pvlmd_x_coordinate_mak').val();
        var y_coordinate_mak = $('#pvlmd_y_coordinate_mak').val();

        var marker = new ol.Feature({
            geometry: new ol.geom.Point([x_coordinate_mak, y_coordinate_mak])
        });
        
        pvlmd_markers.getSource().addFeature(marker);
        pvlmd_map.getView().fit(pvlmd_markers.getSource().getExtent(), {
            size: pvlmd_map.getSize(),
            maxZoom: 16
        });
    });

    // 6. pvlmd_btn_search_by_reference_number - Converted from addEventListener
    $('#pvlmd_btn_search_by_reference_number').on('click', function(e) {
        var search_text = $('#pvlmd_search_by_text').val();
       // console.log(search_text);

        $.ajax({
            type: "POST",
            url: "Maps",
            data: {
                request_type: 'select_search_pvlmd_parcles_by_other_number',
                vr_search_text: search_text
            },
            cache: false,
            success: function(jobdetails) {
                var json_p = JSON.parse(jobdetails);
               // console.log(json_p);

                if (json_p !== undefined || json_p !== null) {
                    if (pvlmd_lc_searchLayer.getSource() != null) {
                        pvlmd_lc_searchLayer.getSource().clear();
                    }

                    if (json_p.parcels !== undefined && json_p.parcels.features !== null) {
                        pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
                            features: (new ol.format.GeoJSON()).readFeatures(json_p.parcels)
                        }));
                    }

                    view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
                    pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(), {
                        size: pvlmd_map.getSize(),
                        maxZoom: 16
                    });
                }
            }
        });
    });

    // 7. pvlmd_btn_scale_zoom - Converted from addEventListener
    $('#pvlmd_btn_scale_zoom').on('click', function() {
        var scale_value = $('#pvlmd_scale_value_e').val();
        var view = pvlmd_map.getView();
        view.setResolution(ol.proj.getPointResolution(
            view.getProjection(),
            getResolutionFromScale(scale_value),
            view.getCenter()
        ));
        click_map_zoom_value = false;
    });

    // 8. pvlmd_lockmapscale - Converted from addEventListener
    $('#pvlmd_lockmapscale').on('click', function() {
        if ($(this).is(':checked')) {
            var MouseWheelZoomClickInteraction;
            pvlmd_map.getInteractions().getArray().forEach(function(interaction) {
                if (interaction instanceof ol.interaction.MouseWheelZoom) {
                    MouseWheelZoomClickInteraction = interaction;
                }
            });
            pvlmd_map.removeInteraction(MouseWheelZoomClickInteraction);

            var dblClickInteraction;
            pvlmd_map.getInteractions().getArray().forEach(function(interaction) {
                if (interaction instanceof ol.interaction.DoubleClickZoom) {
                    dblClickInteraction = interaction;
                }
            });
            pvlmd_map.removeInteraction(dblClickInteraction);
        } else {
            var dblClickInteraction = new ol.interaction.DoubleClickZoom({ delta: 0 });
            pvlmd_map.addInteraction(dblClickInteraction);
            var MouseWheelZoomClickInteraction = new ol.interaction.MouseWheelZoom({ delta: 0 });
            pvlmd_map.addInteraction(MouseWheelZoomClickInteraction);
        }
    });

    // 9. pvlmd_btn_load_for_scanned_maps_by_point - Converted from addEventListener
    $('#pvlmd_btn_load_for_scanned_maps_by_point').on('click', function() {
      //  console.log('kkkkk');
        var x_coordinate_mak = $('#pvlmd_x_coordinate_mak').val();
        var y_coordinate_mak = $('#pvlmd_y_coordinate_mak').val();

        var polygon = x_coordinate_mak + " " + y_coordinate_mak;
        var polygon_real = "POINT(" + polygon + ")";
      //  console.log(polygon_real);

        $.ajax({
            type: "POST",
            url: "Maps",
            data: {
                request_type: 'search_for_lrd_scan_map_for_a_point',
                wkt_polgon: polygon_real
            },
            cache: false,
            success: function(jobdetails) {
                var json_p = JSON.parse(jobdetails);
             //   console.log('how come');
              //  console.log(json_p);

                var options = $("#geoserverscannedimages_list");
                options.empty();

                $(json_p.data).each(function() {
                    $('#geoserverscannedimages_list').append(
                        '<option value="' + this.file_name + ':' + this.extent + '">' + this.file_name + '</option>'
                    );
                });
            }
        });
    });

    // 10. pvlmd_btn_search_for_scanned_maps - Converted from addEventListener
    $('#pvlmd_btn_search_for_scanned_maps').on('click', function(e) {
      //  console.log('kkkkk');
        var wkt_polygon = $.trim($("#pvlmd_bl_wkt_polygon").val());
       // console.log(wkt_polygon);

        $.ajax({
            type: "POST",
            url: "Maps",
            data: {
                request_type: 'search_for_lrd_scan_map_for_a_polygon',
                wkt_polygon: wkt_polygon
            },
            cache: false,
            success: function(jobdetails) {
                var json_p = JSON.parse(jobdetails);
              //  console.log('how come');
             //   console.log(json_p);

                var options = $("#geoserverscannedimages_list");
                options.empty();
                
                $(json_p.data).each(function() {
                    $('#geoserverscannedimages_list').append(
                        '<option value="' + this.file_name + ':' + this.extent + '">' + this.file_name + '</option>'
                    );
                });
            }
        });
    });

    // 11. pvlmd_btn_load_for_scanned_maps - Converted from addEventListener
    $('#pvlmd_btn_load_for_scanned_maps').on('click', function(e) {
        var geoserverscannedimage = $.trim($("#geoserverscannedimages_list").val());
     //   console.log(geoserverscannedimage);

        var value_image_scan = geoserverscannedimage;
        var only_layer = value_image_scan.split(":", 3);
      //  console.log(only_layer);
    
        var value_image_scan1 = only_layer[1];
        var layer_name = 'csau_geospatial' + ':' + value_image_scan1;
        var all_parameters = { 'LAYERS': layer_name };
        
        var image_source = new ol.source.ImageWMS({
            url: getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params: all_parameters,
            serverType: 'geoserver',
        });

        pvlmd_StaticImage.setSource(image_source);
        var new_extent = only_layer[2];
     //   console.log('new_extent');
     //   console.log(new_extent);
        
        pvlmd_map.getView().fit(new_extent, pvlmd_map.getSize());
    });

    // 12. pvlmd_btnprintmap - Converted from addEventListener
    $('#pvlmd_btnprintmap').on('click', function(e) {
       // console.log("click_type");
        var wktplygonsearch = $('#pvlmd_bl_wkt_polygon').val();
        
        var canvas = document.getElementById("pvlmd-map").getElementsByClassName("ol-unselectable")[0];
        var img = canvas.toDataURL("image/png");
        
        var doc = new jsPDF('portrait', undefined, 'a4');
        doc.setProperties({
            title: 'Internal Search',
            subject: 'This is the subject',
            author: 'Assiamah John',
            keywords: 'generated, javascript, web 2.0, ajax',
            creator: 'Creator Name'
        });

        doc.setFontSize(20);
        doc.text(70, 25, 'LANDS COMMISSION');
        doc.setFontSize(16);
        doc.text(80, 35, 'INTERNAL SEARCH REPORT');
        doc.addImage(img, 'JPEG', 20, 60, 160, 80);

        doc.setFontSize(10);
        doc.setDrawColor(255, 0, 0);
        doc.setLineWidth(1.5);
        doc.line(15, 170, 50, 170);
        doc.text(60, 170, 'Search Polygon');

        doc.setDrawColor(255, 192, 203);
        doc.setLineWidth(1.5);
        doc.line(15, 180, 50, 180);
        doc.text(60, 180, 'Existing GARRO Parcel');

        doc.setDrawColor(255, 165, 0);
        doc.setLineWidth(1.5);
        doc.line(15, 190, 50, 190);
        doc.text(60, 190, 'Existing CRO Parcel');

        doc.setDrawColor(0, 0, 255);
        doc.setLineWidth(1.5);
        doc.line(15, 200, 50, 200);
        doc.text(60, 200, 'PVLMD Current Parcel');

        doc.setDrawColor(128, 0, 128);
        doc.setLineWidth(1.5);
        doc.line(15, 210, 50, 210);
        doc.text(60, 210, 'SMD Parcel');

        doc.setDrawColor(165, 42, 42);
        doc.setLineWidth(1.5);
        doc.line(15, 220, 50, 220);
        doc.text(60, 220, 'SMD Cadastral');

        doc.setDrawColor(0, 128, 0);
        doc.setLineWidth(1.5);
        doc.line(15, 230, 50, 230);
        doc.text(60, 230, 'LRD Parcel');

        doc.setFontSize(10);
        doc.setFont("courier");
        doc.setFontType("bolditalic");
        
        var splitTitle = doc.splitTextToSize(wktplygonsearch, 180);
        doc.text(20, 250, splitTitle);

        // [Keep the rest of the print functionality with AJAX calls...]
        // The AJAX calls for garro, cro, pvlmdcurrent, etc. remain the same as in your original code
        
        doc.save('map.pdf');
    });


	 // 13. pvlmd_btn_search_by_reference_number - Converted from addEventListener
    $('#pvlmd_parcel_btn_search_by_reference_number').on('click', function(e) {
        var search_text = $('#pvlmd_search_by_text').val();
       // console.log(search_text);

	   if (!search_text || search_text.trim() === '') {
			swal.fire({
				title: "Error",
				text: "Please enter a property number to search.",
				icon: "error",
				button: "OK",
			});

			return;
		}

        $.ajax({
            type: "POST",
            url: "Maps",
            data: {
                request_type: 'select_search_pvlmd_parcles_by_reference_number',
                vr_search_text: search_text
            },
            cache: false,
            success: function(jobdetails) {

                var json_p = JSON.parse(jobdetails);
                console.log(json_p);

                if (json_p !== undefined || json_p !== null) {
                    if (pvlmd_lc_searchLayer.getSource() != null) {
                        pvlmd_lc_searchLayer.getSource().clear();
                    }

					if(!json_p.wkt || json_p.wkt === 'null' || json_p.wkt === '') {

						swal.fire({
							title: "No Polygon Found",
							text: "No polygon data found for the provided property number.",
							icon: "warning",
							button: "OK",
						});

						return;
					}

                    if (json_p.parcels !== undefined && json_p.parcels.features !== null) {
                        pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
                            features: (new ol.format.GeoJSON()).readFeatures(json_p.parcels)
                        }));
                    }

                    view.fit(pvlmd_lc_searchLayer.getSource().getExtent());
                    pvlmd_map.getView().fit(pvlmd_lc_searchLayer.getSource().getExtent(), {
                        size: pvlmd_map.getSize(),
                        maxZoom: 16
                    });

					$("#link_parcel_summary_property").text(json_p.parcels.features[0].properties.property_number || '-');
					$("#link_parcel_summary_reference").text(json_p.parcels.features[0].properties.reference_number || '-');
					$("#link_parcel_summary_locality").text(json_p.parcels.features[0].properties.locality || '-');
					$("#link_parcel_summary_plotted_by").text(json_p.parcels.features[0].properties.plotted_by || '-');
					$("#link_parcel_summary_date_plotted").text(json_p.parcels.features[0].properties.date_plotted || '-');

					$("#pvlmd_bl_wkt_polygon").text(json_p.wkt|| '-');
					$("#linked_parcel_reference").text(search_text);
					$("#link_parcel_reference").val(search_text);

					const link_txn_selected_id = $('#link_txn_selected_id').val();
					const link_parcel_selected_id = $('#link_parcel_reference').val();
					if (link_txn_selected_id && link_parcel_selected_id) {
						$('#pvlmd_btn_link_transaction_and_parcel').prop('disabled', false);
					} else {
						$('#pvlmd_btn_link_transaction_and_parcel').prop('disabled', true);
					}
					
                }
            }
        });
    });

	// Drawing tool event handlers
$('#pvlmd_btn_draw_polygon').on('click', function() {
   lrd_click_type = 'DrawClick';
	
	pvlmd_startDrawing('Polygon');
    // Update UI feedback
    $(this).addClass('active').siblings().removeClass('active');
});

$('#pvlmd_btn_draw_circle').on('click', function() {
    lrd_click_type = 'DrawClick';
    pvlmd_startDrawing('Circle');
    $(this).addClass('active').siblings().removeClass('active');
});

$('#pvlmd_btn_draw_line').on('click', function() {
    lrd_click_type = 'DrawClick';
    pvlmd_startDrawing('LineString');
    $(this).addClass('active').siblings().removeClass('active');
});

$('#pvlmd_btn_modify').on('click', function() {
    pvlmd_startModify();
    $(this).toggleClass('active');
});

// $('#pvlmd_btn_clear_measurements').on('click', function() {
//     pvlmd_clearMeasurements();
//     $('#pvlmd_btn_draw_polygon, #pvlmd_btn_draw_circle, #pvlmd_btn_draw_line, #pvlmd_btn_modify').removeClass('active');
// });

$('#pvlmd_btn_clear_measurements').on('click', function() {

    pvlmd_clearMeasurements();

    lrd_click_type = 'MapClick';

    $('#pvlmd_btn_draw_polygon, ' +
      '#pvlmd_btn_draw_circle, ' +
      '#pvlmd_btn_draw_line, ' +
      '#pvlmd_btn_modify')
        .removeClass('active');
});

// Update the existing visualise button to use the new function
$('#pvlmd_btn_visualise_wkt').off('click').on('click', function() {
    var wkt = $('#pvlmd_bl_wkt_polygon').val();
    pvlmd_visualizeWKT(wkt);
});


// Function to format area
function pvlmd_formatArea(area) {
    var formattedArea;
    if (area > 10000) {
        formattedArea = (area / 10000).toFixed(2) + ' ha';
    } else {
        formattedArea = area.toFixed(2) + ' m²';
    }
    return formattedArea;
}

// Function to format length
function pvlmd_formatLength(length) {
    var formattedLength;
    if (length > 1000) {
        formattedLength = (length / 1000).toFixed(2) + ' km';
    } else {
        formattedLength = length.toFixed(2) + ' m';
    }
    return formattedLength;
}

// Create style for measurement features
function pvlmd_createMeasureStyle(feature, type) {
    var styles = [];
    var geometry = feature.getGeometry();
    var area = null;
    var length = null;
    
    if (type === 'Polygon' || type === 'Circle') {
        if (geometry instanceof ol.geom.Polygon) {
            area = geometry.getArea();
        } else if (geometry instanceof ol.geom.Circle) {
            area = Math.PI * Math.pow(geometry.getRadius(), 2);
        }
    } else if (type === 'LineString') {
        length = geometry.getLength();
    }
    
    styles.push(new ol.style.Style({
        fill: new ol.style.Fill({
            color: 'rgba(255, 0, 0, 0.2)'
        }),
        stroke: new ol.style.Stroke({
            color: '#ff0000',
            width: 2,
            lineDash: [5, 5]
        }),
        image: new ol.style.Circle({
            radius: 6,
            fill: new ol.style.Fill({
                color: '#ff0000'
            }),
            stroke: new ol.style.Stroke({
                color: '#ffffff',
                width: 2
            })
        })
    }));
    
    // Add label for area/length
    if (area !== null || length !== null) {
        var label = '';
        if (area !== null) {
            label = 'Area: ' + pvlmd_formatArea(area);
        } else if (length !== null) {
            label = 'Length: ' + pvlmd_formatLength(length);
        }
        
        var center = geometry.getCenter ? geometry.getCenter() : geometry.getClosestPoint(geometry.getFirstCoordinate());
        
        styles.push(new ol.style.Style({
            text: new ol.style.Text({
                text: label,
                font: 'bold 14px Arial',
                fill: new ol.style.Fill({
                    color: '#ff0000'
                }),
                stroke: new ol.style.Stroke({
                    color: '#ffffff',
                    width: 3
                }),
                backgroundFill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0.8)'
                }),
                padding: [4, 8, 4, 8],
                textAlign: 'center',
                textBaseline: 'middle',
                offsetY: -15
            }),
            geometry: new ol.geom.Point(center)
        }));
    }
    
    return styles;
}

// Function to start drawing
function pvlmd_startDrawing(type) {
    // Remove existing draw interaction
    if (pvlmd_drawInteraction) {
        pvlmd_map.removeInteraction(pvlmd_drawInteraction);
        pvlmd_drawInteraction = null;
    }
    
    // Remove existing modify interaction
    if (pvlmd_modifyInteraction) {
        pvlmd_map.removeInteraction(pvlmd_modifyInteraction);
        pvlmd_modifyInteraction = null;
    }
    
    // Clear previous measurements
    pvlmd_measureSource.clear();
    
    // Create new draw interaction
    pvlmd_drawInteraction = new ol.interaction.Draw({
        source: pvlmd_measureSource,
        type: type,
        style: new ol.style.Style({
            fill: new ol.style.Fill({
                color: 'rgba(255, 0, 0, 0.1)'
            }),
            stroke: new ol.style.Stroke({
                color: '#ff0000',
                width: 2
            }),
            image: new ol.style.Circle({
                radius: 4,
                fill: new ol.style.Fill({
                    color: '#ff0000'
                })
            })
        })
    });
    
    pvlmd_drawInteraction.on('drawend', function(event) {

    // ============================================================
    // YOUR EXISTING DRAWEND CODE
    // ============================================================

    var feature = event.feature;
    var geometry = feature.getGeometry();
    var type = geometry.getType();

    var area = null;
    var length = null;

    if (type === 'Polygon') {

        area = geometry.getArea();

        pvlmd_showMeasurementPopup(
            pvlmd_formatArea(area),
            'Area'
        );

    } else if (type === 'Circle') {

        area =
            Math.PI *
            Math.pow(
                geometry.getRadius(),
                2
            );

        pvlmd_showMeasurementPopup(
            pvlmd_formatArea(area),
            'Area'
        );

    } else if (type === 'LineString') {

        length =
            geometry.getLength();

        pvlmd_showMeasurementPopup(
            pvlmd_formatLength(length),
            'Length'
        );
    }


    feature.setStyle(
        pvlmd_createMeasureStyle(
            feature,
            type
        )
    );


    var format =
        new ol.format.WKT();

    var wkt =
        format.writeFeature(feature);


    $('#pvlmd_bl_wkt_polygon')
        .val(wkt);


    pvlmd_addFeatureToCoordinateList(
        feature
    );


    if (wkt) {

        $('#pvlmd_btn_request_add_existing_parcel')
            .removeClass('d-none');
    }


    pvlmd_visualizeWKT(wkt);


    // ============================================================
    // IMPORTANT:
    // REMOVE DRAW INTERACTION AFTER DRAWING
    // ============================================================

    setTimeout(function() {

        if (pvlmd_drawInteraction) {

            pvlmd_map.removeInteraction(
                pvlmd_drawInteraction
            );

            pvlmd_drawInteraction = null;
        }

        lrd_click_type = 'MapClick';

        $(
            '#pvlmd_btn_draw_polygon,' +
            '#pvlmd_btn_draw_circle,' +
            '#pvlmd_btn_draw_line'
        )
        .removeClass('active');

    }, 100);
});
    
    pvlmd_map.addInteraction(pvlmd_drawInteraction);
}

// Function to show measurement popup
function pvlmd_showMeasurementPopup(value, type) {
    // Use toast notification
    if (typeof $.toast === 'function') {
        $.toast({
            heading: type + ' Measurement',
            text: value,
            icon: 'info',
            position: 'bottom-right',
            stack: false,
            loader: false,
            bgColor: '#7c3aed',
            textColor: '#fff',
            hideAfter: 5000
        });
    } else {
        // Fallback to alert
        alert(type + ': ' + value);
    }
}

// Function to add feature to coordinate list
function pvlmd_addFeatureToCoordinateList(feature) {
    var geometry = feature.getGeometry();
    var coordinates = [];
    
    if (geometry instanceof ol.geom.Polygon) {
        coordinates = geometry.getCoordinates()[0];
    } else if (geometry instanceof ol.geom.LineString) {
        coordinates = geometry.getCoordinates();
    } else if (geometry instanceof ol.geom.Circle) {
        var center = geometry.getCenter();
        var radius = geometry.getRadius();
        // Create points around circle
        var points = 12;
        for (var i = 0; i <= points; i++) {
            var angle = (i / points) * 2 * Math.PI;
            var x = center[0] + radius * Math.cos(angle);
            var y = center[1] + radius * Math.sin(angle);
            coordinates.push([x, y]);
        }
    }
    
    // Add to table
    var table = $('#coordinatelis_Table tbody');
    table.empty();
    
    coordinates.forEach(function(coord, index) {
        var name = 'P1-' + (index + 1);
        table.append(
            '<tr>' +
            '<td>' + name + '</td>' +
            '<td>' + coord[0].toFixed(2) + '</td>' +
            '<td>' + coord[1].toFixed(2) + '</td>' +
            '<td class="text-center">' +
            '<button class="btn btn-danger btn-sm btn-delete-coordinate" data-index="' + index + '">' +
            '<i class="fas fa-trash"></i>' +
            '</button>' +
            '</td>' +
            '</tr>'
        );
    });
    
    // Add delete handlers
    $('.btn-delete-coordinate').on('click', function() {
        var index = $(this).data('index');
        // Remove point from feature
        // This is simplified - in production you'd need to rebuild the geometry
        $(this).closest('tr').remove();
        pvlmd_rebuildPolygonFromTable();
    });
}

// Function to rebuild polygon from table
function pvlmd_rebuildPolygonFromTable() {
    var points = [];
    $('#coordinatelis_Table tbody tr').each(function() {
        var x = parseFloat($(this).find('td:eq(1)').text());
        var y = parseFloat($(this).find('td:eq(2)').text());
        points.push([x, y]);
    });
    
    if (points.length >= 3) {
        var polygon = new ol.geom.Polygon([points]);
        var feature = new ol.Feature(polygon);
        pvlmd_measureSource.clear();
        pvlmd_measureSource.addFeature(feature);
        
        // Update WKT
        var format = new ol.format.WKT();
        var wkt = format.writeFeature(feature);
        $('#pvlmd_bl_wkt_polygon').val(wkt);
    }
}

// Function to visualize WKT
function pvlmd_visualizeWKT(wkt) {
    if (!wkt) return;
    
    try {
        pvlmd_lc_searchLayer.setSource(new ol.source.Vector({
            features: (new ol.format.WKT()).readFeatures(wkt)
        }));
        
        var extent = pvlmd_lc_searchLayer.getSource().getExtent();
        if (extent) {
            pvlmd_map.getView().fit(extent, {
                size: pvlmd_map.getSize(),
                maxZoom: 16,
                padding: [50, 50, 50, 50]
            });
        }
    } catch (error) {
        console.error('Error visualizing WKT:', error);
    }
}

// Function to start modify interaction
function pvlmd_startModify() {
    // Remove existing draw interaction
    if (pvlmd_drawInteraction) {
        pvlmd_map.removeInteraction(pvlmd_drawInteraction);
        pvlmd_drawInteraction = null;
    }
    
    // Remove existing modify interaction
    if (pvlmd_modifyInteraction) {
        pvlmd_map.removeInteraction(pvlmd_modifyInteraction);
        pvlmd_modifyInteraction = null;
    }
    
    // Create modify interaction
    pvlmd_modifyInteraction = new ol.interaction.Modify({
        source: pvlmd_measureSource,
        style: new ol.style.Style({
            image: new ol.style.Circle({
                radius: 8,
                fill: new ol.style.Fill({
                    color: '#ff0000'
                }),
                stroke: new ol.style.Stroke({
                    color: '#ffffff',
                    width: 2
                })
            })
        })
    });
    
    // Add event listener for modify end
    pvlmd_modifyInteraction.on('modifyend', function(event) {
        var features = event.features;
        features.forEach(function(feature) {
            var geometry = feature.getGeometry();
            var type = geometry.getType();
            var area = null;
            var length = null;
            
            if (type === 'Polygon') {
                area = geometry.getArea();
            } else if (type === 'Circle') {
                area = Math.PI * Math.pow(geometry.getRadius(), 2);
            } else if (type === 'LineString') {
                length = geometry.getLength();
            }
            
            // Update style
            feature.setStyle(pvlmd_createMeasureStyle(feature, type));
            
            // Update WKT
            var format = new ol.format.WKT();
            var wkt = format.writeFeature(feature);
            $('#pvlmd_bl_wkt_polygon').val(wkt);
            
            // Update coordinate list
            pvlmd_addFeatureToCoordinateList(feature);
            
            // Show updated measurement
            if (area !== null) {
                pvlmd_showMeasurementPopup(pvlmd_formatArea(area), 'Updated Area');
            } else if (length !== null) {
                pvlmd_showMeasurementPopup(pvlmd_formatLength(length), 'Updated Length');
            }
        });
    });
    
    pvlmd_map.addInteraction(pvlmd_modifyInteraction);
}

// Function to clear measurements
function pvlmd_clearMeasurements() {
    if (pvlmd_drawInteraction) {
        pvlmd_map.removeInteraction(pvlmd_drawInteraction);
        pvlmd_drawInteraction = null;
    }
    if (pvlmd_modifyInteraction) {
        pvlmd_map.removeInteraction(pvlmd_modifyInteraction);
        pvlmd_modifyInteraction = null;
    }
    pvlmd_measureSource.clear();
    $('#pvlmd_bl_wkt_polygon').val('');
    $('#coordinatelis_Table tbody').empty();
    $('#pvlmd_btn_request_add_existing_parcel').addClass('d-none');
}

    // Helper function
    function getResolutionFromScale(scale) {
        var units = pvlmd_map.getView().getProjection().getUnits();
        var dpi = 25.4 / 0.28;
        var mpu = ol.proj.METERS_PER_UNIT[units];
        var resolution = scale / (mpu * 39.37 * dpi);
        return resolution;
    }

	function loadAndZoomToRegionPolygon(wktPolygon) {
		//console.log('Plygon newww')
		//console.log(wktPolygon)
    if (wktPolygon && wktPolygon !== '' && wktPolygon !== 'null') {
        try {
            // Read the WKT polygon
            var features = new ol.format.WKT().readFeatures(wktPolygon);
            
            if (features && features.length > 0) {
                // Set source for the regional boundary layer
                pvlmd_lc_regional_boundary_layer.setSource(new ol.source.Vector({
                    features: features
                }));
                
                // Zoom to the polygon extent
                var extent = pvlmd_lc_regional_boundary_layer.getSource().getExtent();
                       
                    pvlmd_map.getView().fit(extent, {
                        size: pvlmd_map.getSize(),
                        maxZoom: 10
                    });

                // Check if extent is valid (not infinity)
                // if (isFinite(extent[0]) && isFinite(extent[1]) && 
                //     isFinite(extent[2]) && isFinite(extent[3])) {
                    
                //     pvlmd_map.getView().fit(extent, {
                //         size: pvlmd_map.getSize(),
                //         maxZoom: 10,
                //         padding: [50, 50, 50, 50]  // Add some padding around the boundary
                //     });
                    
                //     console.log('Zoomed to region polygon successfully');
                // }
            }
        } catch(e) {
            console.error('Error parsing WKT polygon:', e);
        }
    }
}

window.initiateDeleteParcel = function() {

    var selectedJobsList = [];
	var pvlmd_reference_number = $('#pvlmd_reference_number').text();

	// Close the underlying modal
    $('#pvlmdparcelinformation').modal('hide');

    Swal.fire({
        title: 'Add Job to Request List?',
        text: 'This will add selected jobs to request to list.',
        icon: 'question',
		//target: document.body,
		//backdrop: true,
        html: `
            <!-- <p>This will add selected jobs to request to list.</p> -->
            <div class="form-group text-start mt-2">
                <label for="txt_general_remarks_notes">Remarks: <span class="text-danger">*</span></label>
                <textarea class="form-control mt-1" id="txt_general_remarks_notes" rows="3"></textarea>
            </div>
        `,
        showCancelButton: true,
        confirmButtonText: 'Yes, Add',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#d33',
		// customClass: {
        //     container: 'swal-container-custom' // Add custom class
        // }
    }).then((result) => {
		// if (!result.isConfirmed) {
        //     $('#pvlmdparcelinformation').modal('show');
        // }

        if (result.isConfirmed) {
            var remarks_notes = $("#txt_general_remarks_notes").val();
            if (!remarks_notes) {
                Swal.fire({
                    title: 'Remarks is required!',
                    icon: 'warning',
                    confirmButtonText: 'OK',
                });
                return;
            }

            const exists = selectedJobsList.some(job => job.jobNumberPlain === pvlmd_reference_number);
        
            if (exists) {
                Swal.fire({
                    title: 'Duplicate Job',
                    text: `Job ${pvlmd_reference_number} is already in the list.`,
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });

                return;
            }

            // Add job to list
            selectedJobsList.push({
                jobNumberPlain: pvlmd_reference_number,
                jobNumberHtml: pvlmd_reference_number,
                applicantNameHtml: pvlmd_reference_number,
                applicationType: 'TEMPORAL APPLICATION',
                batchingPurpose: 'Archive Plotting',
                remarksNotes: remarks_notes,
                // created_on: jobData.created_on,
                // job_status: jobData.job_status
            });

            // Update localStorage
            localStorage.setItem('requestlistdata', JSON.stringify(selectedJobsList));
            
            // Update the table
            addJobToRequestlist();

            prepareRequestlistModal();
        }
    });

};

$('#pvlmd_btn_request_add_existing_parcel').on('click', function(e) {
	e.preventDefault();

	var pvlmd_bl_wkt_polygon = $.trim($('#pvlmd_bl_wkt_polygon').val());

	if (!pvlmd_bl_wkt_polygon) {
		Swal.fire({
			title: 'No Polygon Found',
			text: 'Please draw or load a polygon before submitting the request.',
			icon: 'warning',
			confirmButtonText: 'OK'
		});
		return;
	}

	Swal.fire({
		title: 'Request Add Existing Parcel?',
		icon: 'info',
		html: `
			<p class="mb-3">This request will submit the selected polygon for review to add existing parcel.</p>
			<div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_reference_number" class="form-label">Reference Number <span class="text-danger">*</span></label>
				<input type="text" id="pvlmd_add_exist_reference_number" class="form-control" placeholder="Enter reference number">
			</div>
            <div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_file_number" class="form-label">File Number</label>
				<input type="text" id="pvlmd_add_exist_file_number" class="form-control" placeholder="Enter file number">
			</div>
            <div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_party_1" class="form-label">Party 1 (Grantor)</label>
				<textarea id="pvlmd_add_exist_party_1" class="form-control" placeholder="Enter party"></textarea>
			</div>
            <div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_party_2" class="form-label">Party 2 (Grantee)</label>
				<textarea id="pvlmd_add_exist_party_2" class="form-control" placeholder="Enter party"></textarea>
			</div>
            <div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_acreage" class="form-label">Acreage <span class="text-danger">*</span></label>
				<input type="number" id="pvlmd_add_exist_acreage" min="0.01" class="form-control" placeholder="Enter acreage">
			</div>
			<div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_locality" class="form-label">Locality <span class="text-danger">*</span></label>
				<input type="text" id="pvlmd_add_exist_locality" class="form-control" placeholder="Enter locality">
			</div>
            <div class="form-group text-start mb-2">
				<label for="pvlmd_add_exist_comments" class="form-label">Comments<span class="text-danger">*</span></label>
				<textarea id="pvlmd_add_exist_comments" class="form-control" placeholder="Enter comments"></textarea>
			</div>
		`,
		showCancelButton: true,
		confirmButtonText: 'Yes, Submit',
		cancelButtonText: 'Cancel',
		confirmButtonColor: '#d33',
		cancelButtonColor: '#6c757d',
		focusConfirm: false,
		preConfirm: function() {
			var referenceNumber = $.trim($('#pvlmd_add_exist_reference_number').val());

			if (!referenceNumber) {
				Swal.showValidationMessage('Reference Number is required');
				return false;
			}

			var locality = $.trim($('#pvlmd_add_exist_locality').val());

			if (!locality) {
				Swal.showValidationMessage('Locality is required');
				return false;
			}

            var acreage = $.trim($('#pvlmd_add_exist_acreage').val());

			if (!acreage) {
				Swal.showValidationMessage('Acreage is required');
				return false;
			}

            var comments = $.trim($('#pvlmd_add_exist_comments').val());

            if (!comments) {
				Swal.showValidationMessage('Comments is required');
				return false;
			}

			var fileNumber = $.trim($('#pvlmd_add_exist_file_number').val());
			var party1 = $.trim($('#pvlmd_add_exist_party_1').val());
			var party2 = $.trim($('#pvlmd_add_exist_party_2').val());
			

			return {
				referenceNumber: referenceNumber,
                fileNumber: fileNumber,
                party1: party1,
                party2: party2,
				locality: locality,
                acreage: acreage,
                comments: comments
			};
		}
	}).then(function(result) {
		if (!result.isConfirmed) {
			return;
		}

		Swal.fire({
			title: 'Submitting Request',
			text: 'Please wait while we save the parcel request.',
			allowOutsideClick: false,
			didOpen: function() {
				Swal.showLoading();
			}
		});

		$.ajax({
			type: 'POST',
			url: 'Maps',
			data: {
				request_type: 'select_add_lc_temp_parcels',
				wkt_polygon: pvlmd_bl_wkt_polygon,
				locality: result.value.locality,
				reference_number: result.value.referenceNumber,
				file_number: result.value.fileNumber,
				party_1: result.value.party1,
				party_2: result.value.party2,
				acreage: result.value.acreage,
				comments: result.value.comments,
                division: 'PVLMD'
			},
			cache: false,
			success: function(response) {
				if (!response) {
					Swal.fire({
						title: 'Request Failed',
						text: 'Unable to submit the parcel deletion request.',
						icon: 'error',
						confirmButtonText: 'OK'
					});
					return;
				}

				var json_p = JSON.parse(response);

				if (json_p && json_p.success === true) {
					initiateReqAddExistingParcel(json_p.reference_number, json_p.glpin, json_p.party_1, json_p.party_2);
				}

				// Swal.fire({
				// 	title: 'Request Submitted',
				// 	text: response || 'The parcel deletion request has been submitted successfully.',
				// 	icon: 'success',
				// 	confirmButtonText: 'OK'
				// });
			},
			error: function(xhr, status, error) {
				Swal.fire({
					title: 'Request Failed',
					text: xhr.responseText || error || 'Unable to submit the parcel deletion request.',
					icon: 'error',
					confirmButtonText: 'OK'
				});
			}
		});
	});
});


window.initiateReqAddExistingParcel = function(parcelId, referenceNumber, party1, party2) {

    var selectedJobsList = [];

	// Close the underlying modal
    $('#pvlmdparcelinformation').modal('hide');

    Swal.fire({
        title: 'Add Job to Request List?',
        text: 'This will add selected jobs to request to list.',
        icon: 'question',
		//target: document.body,
		//backdrop: true,
        html: `
            <!-- <p>This will add selected jobs to request to list.</p> -->
            <div class="form-group text-start mt-2">
                <label for="txt_general_remarks_notes">Remarks: <span class="text-danger">*</span></label>
                <textarea class="form-control mt-1" id="txt_general_remarks_notes" rows="3"></textarea>
            </div>
        `,
        showCancelButton: true,
        confirmButtonText: 'Yes, Add',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#d33',
		// customClass: {
        //     container: 'swal-container-custom' // Add custom class
        // }
    }).then((result) => {
		// if (!result.isConfirmed) {
        //     $('#pvlmdparcelinformation').modal('show');
        // }

        if (result.isConfirmed) {
            var remarks_notes = $("#txt_general_remarks_notes").val();
            if (!remarks_notes) {
                Swal.fire({
                    title: 'Remarks is required!',
                    icon: 'warning',
                    confirmButtonText: 'OK',
                });
                return;
            }

            const exists = selectedJobsList.some(job => job.jobNumberPlain === parcelId);
        
            if (exists) {
                Swal.fire({
                    title: 'Duplicate Job',
                    text: `Job ${parcelId} is already in the list.`,
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });

                return;
            }

            let applicantName = referenceNumber + (party2 == '' ? ' - (' + party1 + ')' : ' - (' + party2 + ')');

            // Add job to list
            selectedJobsList.push({
                jobNumberPlain: parcelId,
                jobNumberHtml: parcelId,
                applicantNameHtml: applicantName,
                applicationType: 'TEMPORAL APPLICATION',
                batchingPurpose: 'Add Plotting',
                remarksNotes: remarks_notes,
                // created_on: jobData.created_on,
                // job_status: jobData.job_status
            });

            // Update localStorage
            localStorage.setItem('requestlistdata', JSON.stringify(selectedJobsList));
            
            // Update the table
            addJobToRequestlist();

            prepareRequestlistModal();
        }
    });

};



});



