function initialize() {

    // Create an antique treasure-map style of Map
     var styledMapType = new google.maps.StyledMapType(
      [{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":"0.30"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"}]},{"featureType":"administrative","elementType":"labels.text.stroke","stylers":[{"color":"#ffd9b3"},{"visibility":"on"},{"weight":"6"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"administrative","elementType":"labels.icon","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":"1"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"color":"#63391d"},{"visibility":"simplified"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"road","elementType":"labels.text","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":8},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":8},{"lightness":"5"},{"gamma":"1"},{"saturation":"-75"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"labels.text","stylers":[{"visibility":"simplified"},{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"water","elementType":"labels.icon","stylers":[{"visibility":"off"}]}], {name: 'Styled Map'}
     );

      function options(){
        enableHighAccuracy: true;
        maximumAge: 30000;
      };


    var initalLat = 40.70690094223122;
    var initialLong = -74.00895144247752;

    // Set Initial Map Properties
    var mapProps = {
        center:new google.maps.LatLng(initalLat, initialLong),
        zoom:15,
        streetViewControl: false,
        mapTypeId:google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        mapTypeControlOptions: {vmapTypeIds: ['styled_map'] },
        maxZoom: 17
      };

    // Create new Map
    var map = new google.maps.Map(document.getElementById("display-map"),mapProps);

    var xPath = asset_path("x.png");

    var markerImage = new google.maps.MarkerImage( String(xPath),
              new google.maps.Size(40, 40),
              new google.maps.Point(0, 0),
              new google.maps.Point(20, 20));

    var marker = new google.maps.Marker({
                      position:mapProps.center,
                      draggable:true,
                      icon: markerImage
                      });

    

    // // Print current coordinates of the Marker to the 'Current' Div
    // document.getElementById('current').innerHTML = '<p>Latitude: ' + marker.position.lat().toFixed(8) + '</p><br><p>Longitude: ' + marker.position.lng().toFixed(8) + '</p>';

    $("#crumb_latitude").val(marker.position.lat().toFixed(8));
    $("#crumb_longitude").val(marker.position.lng().toFixed(8));
    // Set Map styles and marker
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');
    marker.setMap(map);

    // Create a User Marker
     var userMarker = new google.maps.Marker({
          position:mapProps.center,
          draggable:false,
          icon: {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 6,
            fillColor: '#de3d21',
            fillOpacity: 1,
            strokeColor: '#de3d21',
            strokeWeight: 4
            },
          });

    // Set Map styles and marker
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');
    marker.setMap(map);
    userMarker.setMap(map);
    // marker.setPosition();


      navigator.geolocation.watchPosition(function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
          };
        map.setCenter(pos);
        userMarker.setPosition(pos);

        var userPosition = new google.maps.LatLng(pos.lat, pos.lng);
        $("#current").html("<p>You're roughly " + Math.floor( google.maps.geometry.spherical.computeDistanceBetween (userPosition, mapProps.center)) + " meters away.</p>" ) 

      }, options);



    // Draw circle around the Marker
    var circle = new google.maps.Circle({
      center:mapProps.center,
      radius:50,
      strokeColor:"#de3d21",
      strokeOpacity:0.3,
      strokeWeight:3,
      fillColor:"#de3d21",
      fillOpacity:0.1
      });

    // Bind Circle to Marker's current location
    circle.setMap(map);
    circle.bindTo('center', userMarker, 'position');


    ////// RECENTER BUTTON //////

    function CenterControl(map) {

      $("#recenter-button-parent").append("<div id='recenter-button'>Recenter Map</div>").hide();
      var centerControlDiv = $("#recenter-button")[0];
      centerControlDiv.index = 1;
      $(centerControlDiv).on('click', function() {
        map.setCenter(marker.position);
        });
      map.controls[google.maps.ControlPosition.TOP_RIGHT].push($(centerControlDiv).show()[0]);
    }


    var centerControl = new CenterControl(map);
}
// Close Initialize Function
$(".active.show").ready(function() {
      // Initialize Map
  google.maps.event.addDomListener(window, 'load', initialize);
});

