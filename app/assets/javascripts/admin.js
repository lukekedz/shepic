var ready = function() {
  // activation
  $(".dropdown-button").dropdown();
  $('select').material_select();

  $(".pick").on("click", function(event){
    event.preventDefault();

    var userId   = event.currentTarget[0].value;
    var gameId   = event.currentTarget[1].value;
    var awayHome = event.currentTarget[3].value;
    var selector = "#" + awayHome + "-game-pick-" + gameId;
    var gamePick = $(selector)[0].value;

    $.ajax({
          type: "POST",
          url: "/site/game_pick",
          data: {"pick" : { "game_id"   : gameId,
                            "pick"      : gamePick,
                            "user_id"   : userId,
                            "away_home" : awayHome
                          }},
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

  tiebreaker = function(){
    var userId = document.getElementById('tbreak-user-id').value;
    var gameId = document.getElementById('tbreak-game-id').value;
    var points = document.getElementById('tbreak-pts').value;

    $.ajax({
          type: "POST",
          url: "/site/tbreak_pick",
          data: {"pick" : { "game_id" : gameId, "tbreak_pts" : points, "user_id" : userId }},
          success: function(data){
            var confirmed = "#tbreak-saved";
            $(confirmed).css('visibility', 'visible');

            setTimeout(function(){
               $(confirmed).css('visibility', 'hidden');
            }, 1500);
          }
      });
  }

  $("#add_game").css("display", "none");
  var add_game_displayed = false;

  $('.datepicker').pickadate({
     selectMonths: true,
     closeOnClear: true,
     format: 'yyyy/mm/dd'
   });

};

// optimized for Rails page loads
$(document).ready(ready);
$(document).on('page:load', ready);
