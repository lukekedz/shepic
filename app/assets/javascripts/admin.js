var ready = function() {

  $("#add_game").css("display", "none");
  var add_game_displayed = false;

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
