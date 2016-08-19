function initialize(mapdetails) {

    // Create an antique treasure-map style of Map
     var styledMapType = new google.maps.StyledMapType(
      [{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":"0.30"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"}]},{"featureType":"administrative","elementType":"labels.text.stroke","stylers":[{"color":"#ffd9b3"},{"visibility":"on"},{"weight":"6"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"administrative","elementType":"labels.icon","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":"1"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"color":"#63391d"},{"visibility":"simplified"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"road","elementType":"labels.text","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":8},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":8},{"lightness":"5"},{"gamma":"1"},{"saturation":"-75"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"labels.text","stylers":[{"visibility":"simplified"},{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"water","elementType":"labels.icon","stylers":[{"visibility":"off"}]}], {name: 'Styled Map'}
     );


    var userLocation = new google.maps.LatLng(mapdetails.initialLat, mapdetails.initialLng)
    // Set Initial Map Properties

    var mapProps = {
        center: userLocation,
        zoom: 16,
        streetViewControl: false,
        mapTypeId:google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        mapTypeControlOptions: {vmapTypeIds: ['styled_map'] },
        maxZoom: 17
      };

    // Create new Map
    var map = new google.maps.Map(document.getElementById("display-map"),mapProps);
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');

    var currentCrumbIndex = mapdetails.currentCrumbIndex;
    var currentCrumb = mapdetails.crumbs[currentCrumbIndex]
    var numberOfCrumbs = mapdetails.crumbs.length;
    var activeIdLink = mapdetails.activeId;

    for (i = 0; i < numberOfCrumbs; i++) {

      if (i < currentCrumbIndex) {

        var greenX = asset_path("xgreen.png");
        var markerImage = new google.maps.MarkerImage( String(greenX),
                  new google.maps.Size(40, 40),
                  new google.maps.Point(0, 0),
                  new google.maps.Point(20, 20));

        var crumbLatLng = {lat: mapdetails.crumbs[i].latitude, lng: mapdetails.crumbs[i].longitude};

        var marker = new google.maps.Marker({
                          position: crumbLatLng,
                          draggable:false,
                          icon: markerImage
                          });

        var crumbIdLink = i + 1;

        marker.addListener('click', function(activeId, crumbId) {
          return function() {window.location = "/actives/" + activeIdLink + "/active_crumbs/" + crumbIdLink; }
          }(marker));
      }


       if (i == currentCrumbIndex) {
        var redX = asset_path("xred.png");
        var markerImage = new google.maps.MarkerImage( String(redX),
            new google.maps.Size(40, 40),
            new google.maps.Point(0, 0),
            new google.maps.Point(20, 20));

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
    var child = asset_path("child-outline.png");
    var userMarkerImage = new google.maps.MarkerImage( String(child),
              new google.maps.Size(50, 50),
              new google.maps.Point(0, 0),
              new google.maps.Point(25, 25));

    // Create a User Marker
     var userMarker = new google.maps.Marker({
          position:mapProps.center,
          draggable:false,
          icon: userMarkerImage
          });


    // marker.setPosition();
   $("#current").html("<p>Calculating distance...</p>");

    // find crumb position

    var currentCrumbPosition = new google.maps.LatLng(currentCrumb.latitude, currentCrumb.longitude);

  // Find current user position


      function calcHeading(userPosition, currentCrumbPosition){
        return google.maps.geometry.spherical.computeHeading(userPosition, currentCrumbPosition);
      };

      function printDistance(distance){
            var feet = Math.floor((distance * 3.28084) - 90);
            if (feet > 2000) {return String(Math.round( (feet/5280) * 100) / 100) + " miles"}
            else { return String(Math.round(feet)) + " feet" };
      };


      function errorHandler(err) {
          if (err.code == 1)
            {  alert("Access is denied!"); }
          else if( err.code == 2)
            { alert("The geolocation request has timed out"); }
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
        userMarker.setPosition(pos);
        userMarker.setMap(map);
        var userPosition = new google.maps.LatLng(pos.lat, pos.lng);

        var distance = google.maps.geometry.spherical.computeDistanceBetween(userPosition, currentCrumbPosition);

        if (distance < 30) {
          var url = '/actives/' + activeIdLink + '/reached';
          var data = { crumb: {id: currentCrumb.order_number } };
          $.ajax({
              url: url,
              method: 'GET',
              data: data
            }).done( function (response) {
              window.location = response.route + String(currentCrumb.id)
            })
        }

         google.maps.event.addListener(map, 'zoom_changed', function() {

          var pixelSizeAtZoom0 = 5;
          var maxPixelSize = 50;


          var zoom = map.getZoom();
          var relativePixelSize = pixelSizeAtZoom0 * zoom ;

          if(relativePixelSize > maxPixelSize)
              relativePixelSize = maxPixelSize;


          //change the size of the icon
          userMarker.setIcon(
              new google.maps.MarkerImage(
                  userMarker.getIcon( String(child) ).url, //marker's same icon graphic
                  null,//size
                  null,//origin
                  new google.maps.Point(relativePixelSize/2, relativePixelSize/2), //anchor
                  new google.maps.Size(relativePixelSize, relativePixelSize) //changes the scale
              )
          );
      });

        $("#current").html("<p>" + printDistance(distance) + " away from the next Crumb</p>" );
        $("#compass_hands").rotate({duration:3000, animateTo:calcHeading(userPosition, currentCrumbPosition)});
        $("#blank-map-overlay").fadeOut(3500);

      }, errorHandler, options);



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
      }).done( function (mapdetails) {

        google.maps.event.addDomListener(window, 'load', initialize(mapdetails));
      });
});
