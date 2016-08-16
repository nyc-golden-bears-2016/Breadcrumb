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

  $('.edit_trail').on('click', function(event){
    event.preventDefault();
    // debugger;
    var that = this;
    $.ajax({
      url: $(this).attr('action'),
      method: 'delete',
      data: $(this).serialize()
    })
    .done(function(response){
      $('.each-trail').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
      $('.each-trail-desc').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
    });
  })

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
