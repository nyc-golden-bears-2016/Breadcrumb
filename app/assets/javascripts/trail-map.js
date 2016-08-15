function initialize() {

    // Create an antique treasure-map style of Map
     var styledMapType = new google.maps.StyledMapType(
      [{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":"0.30"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"}]},{"featureType":"administrative","elementType":"labels.text.stroke","stylers":[{"color":"#ffd9b3"},{"visibility":"on"},{"weight":"6"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"administrative","elementType":"labels.icon","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":"1"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"color":"#63391d"},{"visibility":"simplified"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"road","elementType":"labels.text","stylers":[{"visibility":"on"},{"color":"#ffd9b3"},{"weight":8},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"weight":8},{"lightness":"5"},{"gamma":"1"},{"saturation":"-75"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#63391d"},{"saturation":"-75"},{"lightness":"5"},{"gamma":"1"}]},{"featureType":"water","elementType":"labels.text","stylers":[{"visibility":"simplified"},{"color":"#ffd9b3"},{"saturation":"-28"},{"lightness":"0"}]},{"featureType":"water","elementType":"labels.icon","stylers":[{"visibility":"off"}]}], {name: 'Styled Map'}
     );

      function options(){
        enableHighAccuracy: true;
        maximumAge: 30000;
      };


    var initalLat = $("#trail_latitude").val();
    var initialLong = $("#trail_longitude").val();

    // Set Initial Map Properties
    var mapProps = {
        center:new google.maps.LatLng(initalLat, initialLong),
        zoom:10,
        streetViewControl: false,
        mapTypeId:google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        mapTypeControlOptions: {vmapTypeIds: ['styled_map'] },
        maxZoom: 18
      };

    // Create new Map
    var map = new google.maps.Map(document.getElementById("display-map"),mapProps);


    var marker = new google.maps.Marker({
                      position:mapProps.center,
                      draggable:true,
                      icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        scale: 8,
                        fillColor: '#de3d21',
                        fillOpacity: 1,
                        strokeOpacity: 0
                        }
                      });

        // Draw circle around the Marker
    var circle = new google.maps.Circle({
      center:mapProps.center,
      radius:1000,
      strokeColor:"#de3d21",
      strokeOpacity:0.8,
      strokeWeight:6,
      fillColor:"#de3d21",
      fillOpacity:0.1,
      editable: false
      });

    // Toggle making the circle bigger or smaller
    google.maps.event.addListener(circle, 'click', function () {
      if (circle.editable == true) { circle.set('editable',false) }
      else { circle.set('editable',true) };
    });


    // Bind Circle to Marker's current location
    circle.setMap(map);
    circle.bindTo('center', marker, 'position');



    // // Print current coordinates of the Marker to the 'Current' Div
 google.maps.event.addListener(marker, 'dragend', function(evt){
      var pos = {
          lat: parseFloat(evt.latLng.lat().toFixed(8)),
          lng: parseFloat(evt.latLng.lng().toFixed(8))
          };
      marker.setPosition(pos);
      $("#trail_latitude").val(marker.position.lat().toFixed(8));
      $("#trail_longitude").val(marker.position.lng().toFixed(8));
});

    // Set Map styles and marker
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');
    marker.setMap(map);


  ////// SEARCH BOX //////

    // Create Searchbox
    var input = document.getElementById('search-box');
    var searchBox = new google.maps.places.SearchBox(input);

    // Bias the SearchBox results towards current map's viewport.
        map.addListener('bounds_changed', function() {
          searchBox.setBounds(map.getBounds());
        });

    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
        var places = searchBox.getPlaces();
        if (places.length == 0) {
          return;
        }

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds();

        places.forEach(function(place) {
          if (!place.geometry) {
            console.log("Returned place contains no geometry");
            return;
          }

        // Update Marker based on Search Result
        marker.setPosition( place.geometry.location );

        $("#trail_latitude").val(marker.position.lat().toFixed(8));
        $("#trail_longitude").val(marker.position.lng().toFixed(8));

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });
      map.fitBounds(bounds);
    });

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
$(".trail.new").ready(function() {
      // Initialize Map
  google.maps.event.addDomListener(window, 'load', initialize);
});

