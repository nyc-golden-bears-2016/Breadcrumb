//= require jquery
//= require app_assets
//= require js-routes
//= require jQueryRotate

$(document).ready(function() {
  $("#password_confirmation").keyup(validate);

<<<<<<< 5d6fdd0a3c5f488505c49ea0f073eea91f9d66fe
  function options(){
    enableHighAccuracy: true;
    maximumAge: 30000;
  };

  if ($('.hidden').length) {
    navigator.geolocation.getCurrentPosition(function(position) {
      this.pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
        };
      // debugger;
      $.ajax({
        url: '/set_coords',
        method: 'get',
        data: {user_position: pos},
      })
    }, options);
  }

=======
  var form = document.getElementById("#tag-search-form");
form.reset();
// $("#tag-search-form").val("");
// debugger
>>>>>>> add search functions for Trails and Tags
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
