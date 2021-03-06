$(document).ready(function() {

  $(".pick-away").on("click", function(event){
    console.log('away!')
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
                        "away_home" : awayHome }},
      success: function(data){
        var yourPick = "#your-pick-" + gameId;
        $(yourPick).text("Your Pick: " + gamePick);
      }
    });
  });

  $(".pick-home").on("click", function(event){
    console.log('home!')
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
                        "away_home" : awayHome }},
      success: function(data){
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
      success: function(data){}
    });
  }

});
