
  $(document).ready(function() {
       console.log('maps loaded');
       
       const btnloadtomaps = document.getElementById("btn-loadparcels");



var googleLayerHybrid =new ol.layer.Tile({
            title: "Google Satellite & Roads",
          //  'type': 'base',
                 visible: false,
                'opacity': 1.000000,
                 source: new ol.source.XYZ({
                 attributions: [new ol.Attribution({ html: '<a href=""></a>' })],
                 url: 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'}),
        });


 var view =  new ol.View({
               
                //4326 
                 // projection: projObj,
                projection: 'EPSG:4326',
                   center: [0.41, 4.82],
                  // center: ol.proj.transform([0.41, 4.82], 'EPSG:2136'),
                     zoom: 5
                 })

var map = new ol.Map({
                target: 'map',
                      controls: ol.control.defaults().extend([
                                                            new ol.control.LayerSwitcher(),  
                                                            /*new ol.control.MousePosition({
                                                                coordinateFormat: ol.coordinate.toStringHDMS,
                                                            }),*/
                                                              new ol.control.OverviewMap(),
                                                            //  new ol.control.ScaleLine(),
                                                              //new ol.control.ScaleLineUnits0(),
                                                              //new ol.control.ControlDrawFeatures(vector_draw, optionsControlDraw),
                                                              //new ol.control.ControlDrawButtons(vector_layer, opt_options),
                                                              new ol.control.ZoomSlider(),
                                                              new ol.control.Attribution(),
                                                              new ol.control.MousePosition(),
                                                              new ol.control.ZoomToExtent(),
                                                              new ol.control.FullScreen()
                                                         //   ,mousePositionControl
                                                              
                                                              ]),
                   renderer: 'canvas',
                layers: [
                  new ol.layer.Tile({
                    title: 'Open Street',
                    'type': 'base',
                    source: new ol.source.OSM()
                  }),
                  new ol.layer.Tile({
                    title: "Google Satellite & Roads",
               //  'type': 'base',
                  // visible: false,
                  'opacity': 1.000000,
                 source: new ol.source.XYZ({
                 attributions: [new ol.Attribution({ html: '<a href=""></a>' })],
                 url: 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'}),
                })
                ],
                view: view
              });
       
     });
 


/*btnloadtomaps.onclick = () => {
  console.log('maps Loaded');
  load_table_maps();
}
*/

