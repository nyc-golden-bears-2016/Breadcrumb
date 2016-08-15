//= require jquery
//= require app_assets
//= require js-routes
//= require jQueryRotate

$(document).ready(function() {
  $("#password_confirmation").keyup(validate);

  function options(){
    enableHighAccuracy: true;
    maximumAge: 30000;
  };

  if ($('.hidden').length == 0) {

    navigator.geolocation.getCurrentPosition(function(position) {
      this.pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
        };

      $.ajax({
        url: '/set_coords',
        method: 'get',
        data: {user_position: pos},
      })
    }, options);
  }

});


function validate() {
  var password = $("#password").val();
  var password_confirmation = $("#password_confirmation").val();



    if(password == password_confirmation) {
       $("#validate-status").text("valid");
    }
    else {
        $("#validate-status").text("invalid");
    }

}
