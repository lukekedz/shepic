var ready = function() {

  $(".pick").on("click", function(event){
    event.preventDefault();

    var userId = event.currentTarget[0].value;
    var gameId = event.currentTarget[1].value;
    var gamePick = event.target.innerText;

    $.ajax({
          type: "POST",
          url: "/site/game_pick",
          data: {"pick" : { "game_id" : gameId, "pick" : gamePick, "user_id" : userId }},
          success: function(data){
            var confirmed = "#pick-saved-" + gameId;
            $(confirmed).css('visibility', 'visible');
            setTimeout(function(){
               $(confirmed).css('visibility', 'hidden');
            }, 1500);

            var yourPick = "#your-pick-" + gameId;
            $(yourPick).text("Your Pick: " + gamePick);
          }
      });
  });

  $("#add_game").css("display", "none");
  var add_game_displayed = false;

  $('.datepicker').pickadate({
     selectMonths: true,
     closeOnClear: true
   });

  // activating time select dropdown
  $('select').material_select();

  window.shepic = {

    addGamePartial: function() {
      if (add_game_displayed === false) {
        $("#add_game").css("display", "block");
        $("#add_game_btn").text("Cancel");
        add_game_displayed = true;
      } else {
        $("#add_game").css("display", "none");
        $("#add_game_btn").text("Add Game");
        add_game_displayed = false;
      };
    }

  }


};

// optimized for Rails page loads
$(document).ready(ready);
$(document).on('page:load', ready);
