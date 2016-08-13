//= require jquery
//= require app_assets

$(document).ready(function() {
  $("#password_confirmation").keyup(validate);
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
