current_week_id = Week.last.id
games = Game.where(week_id: current_week_id)

if Week.last.locked == true
	games.each do |game|
		game.update(away_pts: rand(0..80), home_pts: rand(0..80), game_started: true, game_finished: true)

		if game.tiebreaker == true
			game.update(total_pts: game.away_pts + game.home_pts)
		end

		if game.away_pts > ( game.home_pts + game.spread )
		  game.update(winner: "away")
		elsif game.away_pts < ( game.home_pts + game.spread )
		  game.update(winner: "home")
		else
		  game.update(winner: "push")
		end
	end
end
