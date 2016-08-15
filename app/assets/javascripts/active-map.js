function initialize(mapdetails) {

    // Create an antique treasure-map style of Map
     var styledMapType = new google.maps.StyledMapType(
      [{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":"0.30"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"}]},{"featureType":"administrative","elementType":"labels.text.stroke","stylers":[{"color":"#ffd9b3"},{"visibility":"on"},{"weight":"6"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"administrative","elementType":"labels.icon","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":"1"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"color":"#63391d"},{"visibility":"simplified"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"road","elementType":"labels.text","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":8},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":8},{"lightness":"5"},{"gamma":"1"},{"saturation":"-75"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"labels.text","stylers":[{"visibility":"simplified"},{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"water","elementType":"labels.icon","stylers":[{"visibility":"off"}]}], {name: 'Styled Map'}
     );


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

    var currentCrumbIndex = mapdetails.currentCrumbIndex;
    var currentCrumb = mapdetails.crumbs[currentCrumbIndex]
    var numberOfCrumbs = mapdetails.crumbs.length;


    for (i = 0; i < numberOfCrumbs; i++) {

      if (i < currentCrumbIndex) {
      var greenX = asset_path("xgreen.png");
      var markerImage = new google.maps.MarkerImage( String(greenX),
                new google.maps.Size(40, 40),
                new google.maps.Point(0, 0),
                new google.maps.Point(20, 20));

      var marker = new google.maps.Marker({
                        position: crumbLatLng,
                        draggable:false,
                        icon: markerImage
                        });

      var activeIdLink = mapdetails.activeId;
      var crumbIdLink = mapdetails.crumbs[i].id;
      marker.addListener('click', function(activeId, crumbId) {
          return function() {window.location = "/actives/" + activeIdLink + "/active_crumbs/" + crumbIdLink;
        }
      }(marker));

      }


     if (i == currentCrumbIndex) {
      var redX = asset_path("xred.png");
      var markerImage = new google.maps.MarkerImage( String(redX),
          new google.maps.Size(40, 40),
          new google.maps.Point(0, 0),
          new google.maps.Point(20, 20));

      }

      var crumbLatLng = {lat: mapdetails.crumbs[i].latitude, lng: mapdetails.crumbs[i].longitude};

      var marker = new google.maps.Marker({
                        position: crumbLatLng,
                        draggable:false,
                        icon: markerImage
                        });
      };


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


    // marker.setPosition();
   $("#current").html("<p>Calculating distance...</p>");

    // find crumb position

    var currentCrumbPosition = new google.maps.LatLng(currentCrumb.latitude, currentCrumb.longitude);

  // Find current user position

      function calcDistance(userPosition, currentCrumbPosition){
        var distance = Math.floor( google.maps.geometry.spherical.computeDistanceBetween(userPosition, currentCrumbPosition));
        var feet = distance * 3.28084;
        if (distance > 2000) {return String(Math.round( (distance/5280) * 100) / 100) + " miles"}
        else { return String(distance) + " feet"};
      };

      function calcHeading(userPosition, currentCrumbPosition){
        return google.maps.geometry.spherical.computeHeading(userPosition, currentCrumbPosition);
      };

      function errorHandler(err) {
          if (err.code == 1)
            {  alert("Error: Access is denied!"); }
          else if( err.code == 2)
            { alert("Error: The geolocation request has timed out"); }
      };

      var options = {
        enableHighAccuracy: true,
        maximumAge: 5000,
        timeout: 60000
      };

      navigator.geolocation.watchPosition(function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
          };
        map.setCenter(pos);
        userMarker.setPosition(pos);
        userMarker.setMap(map);
        var userPosition = new google.maps.LatLng(pos.lat, pos.lng);
        var distance = calcDistance(userPosition, currentCrumbPosition); 
        if (distance < 30) 
          { window.location.replace("/") };

        $("#current").html("<p>You're roughly " + distance + " away from the next Crumb heading</p>" );
        $("#compass_hands").rotate({duration:3000, animateTo:calcHeading(userPosition, currentCrumbPosition)});
        $("#blank-map-overlay").fadeOut(3500);

      }, errorHandler, options);


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
