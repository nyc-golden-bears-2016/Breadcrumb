function initialize(mapdetails) {

    // Create an antique treasure-map style of Map
     var styledMapType = new google.maps.StyledMapType(
      [{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":"0.30"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"}]},{"featureType":"administrative","elementType":"labels.text.stroke","stylers":[{"color":"#ffd9b3"},{"visibility":"on"},{"weight":"6"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"administrative","elementType":"labels.icon","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":"1"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"color":"#63391d"},{"visibility":"simplified"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"road","elementType":"labels.text","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":8},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":8},{"lightness":"5"},{"gamma":"1"},{"saturation":"-75"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"labels.text","stylers":[{"visibility":"simplified"},{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"water","elementType":"labels.icon","stylers":[{"visibility":"off"}]}], {name: 'Styled Map'}
     );

      function options(){
        enableHighAccuracy: true;
        maximumAge: 30000;
      };
      

    var trailCenter = new google.maps.LatLng(mapdetails.initialLat, mapdetails.initialLng)
    // Set Initial Map Properties

    var mapProps = {
        center: trailCenter,
        zoom: mapdetails.zoom,
        streetViewControl: false,
        mapTypeId:google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        mapTypeControlOptions: {vmapTypeIds: ['styled_map'] },
        maxZoom: 18
      };

    // Create new Map
    var map = new google.maps.Map(document.getElementById("display-map"),mapProps);
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');


    var numberOfCrumbs = mapdetails.crumbs.length


    for (i = 0; i < numberOfCrumbs; i++) { 
      var xPath = asset_path("x.png");

      var markerImage = new google.maps.MarkerImage( String(xPath),
                new google.maps.Size(40, 40),
                new google.maps.Point(0, 0),
                new google.maps.Point(20, 20));

      var crumbLatLng = {lat: mapdetails.crumbs[i].latitude, lng: mapdetails.crumbs[i].longitude};

      var marker = new google.maps.Marker({
                        position: crumbLatLng,
                        draggable:false,
                        icon: markerImage
                        });

    // Set Map styles and marker
      marker.setMap(map);
    }


    // Create a User Marker
     var userMarker = new google.maps.Marker({
          position:mapProps.center,
          draggable:false,
          icon: {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 6,
            fillColor: '#105c5c',
            fillOpacity: 1,
            strokeColor: '#105c5c',
            strokeWeight: 4
            },
          });







    // Set Map styles and marker

    userMarker.setMap(map);
    // marker.setPosition();
    if (mapdetails.crumbs.length > 1 ) { $("#current").html("<p> </p>") }
    else { $("#current").html("<p>Calculating distance...</p>")  } 

    // find crumb position
  
      var crumbPosition = new google.maps.LatLng(mapdetails.crumbs[0].latitude, mapdetails.crumbs[0].longitude);

    // find current user position

      navigator.geolocation.watchPosition(function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
          };
        map.setCenter(pos);
        userMarker.setPosition(pos);
      if (mapdetails.crumbs.length == 1 ) {
        var userPosition = new google.maps.LatLng(pos.lat, pos.lng);
        debugger;
        $("#current").html("<p>You're roughly " + calcDistance(userPosition, crumbPosition) + " away from the next Crumb</p>" ) 
       }
      }, options);

    function calcDistance(userPosition, crumbPosition){
      var distance = Math.floor( google.maps.geometry.spherical.computeDistanceBetween(userPosition, crumbPosition));
      if (distance > 1000) {return String(distance/1000) + " km"}
      else { return String(distance) + " meters"};
    };

    // Draw circle around the Marker
    var circle = new google.maps.Circle({
      center:mapProps.center,
      radius:50,
      strokeColor:"#105c5c",
      strokeOpacity:0.3,
      strokeWeight:3,
      fillColor:"#105c5c",
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
        map.setCenter(userMarker.position);
        });
      map.controls[google.maps.ControlPosition.TOP_RIGHT].push($(centerControlDiv).show()[0]);
    }


    var centerControl = new CenterControl(map);
}
// Close Initialize Function
$("document").ready(function() {
  var activeId = $("#active-id").text();
  $.ajax({
      url: '/actives/' + activeId + '/mapdetails',
      method: 'get',
    })
    .done((mapdetails) => {
      google.maps.event.addDomListener(window, 'load', initialize(mapdetails));
    });
});

