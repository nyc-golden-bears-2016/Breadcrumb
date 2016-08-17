 //= require jquery
//= require app_assets
//= require js-routes
//= require jQueryRotate
//= require bootstrap-sprockets

$(document).ready(function() {
  $("#password_confirmation").keyup(validate);

  function options(){
    enableHighAccuracy: true;
    maximumAge: 30000;
  };

// $(".search-bar").find('input')[1].value = "";



  if ($('.hidden').length) {
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

  $('.each-trail').on('click', 'form', function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      method: 'delete',
      data: $(this).serialize()
    })
    .done(function(response){
      $('.each-trail').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
      $('.each-trail-desc').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
      $('.each-trail-saved').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
      $('.each-trail-active').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
    });
  })

  $('.each-trail-active').on('click', 'form', function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      method: 'delete',
      data: $(this).serialize()
    })
    .done(function(response){
      $('.each-trail-active').find('form[action="/actives/' + response + '"'+ ']').parent().remove();
    });
  })

  $('.each-trail-saved').on('click', 'form', function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      method: 'delete',
      data: $(this).serialize()
    })
    .done(function(response){
      $('.each-trail-saved').find('a[href="/trails/' + response + '"'+ ']').parent().remove();
    });
  })

  $('.selected-tags').on('click', '.your-tag', function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).children().attr('href'),
      method: 'get',
      data: $(this).serialize()
    })
    .done(function(response){
      $('.your-tag').find('a[href="/trails/' + response.trail + '/remove/' + response.tag + '"' + ']').remove();
    });
  })

  $('.other-tag').on('click', 'a', function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      method: 'get',
      data: $(this).serialize()
    })
    .done(function(response){
      $('.selected-tags').append("<span class='your-tag'><a href=" + response.tag_trail + ">" + response.tag + " | </a></span>")
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
