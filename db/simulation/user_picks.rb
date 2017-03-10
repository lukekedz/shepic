current_week_id = Week.last.id
games = Game.where(week_id: current_week_id)

User.where(admin: false).each do |user|
	games.each do |game|
		away_home = ["away", "home"]
		versus    = [game.away, game.home]
	    selector  = rand(0..1)
	    tbreak    = game.tiebreaker == true ? rand(0..160) : "" 

		Pick.where(user_id: user.id, game_id: game.id)
			.first_or_create(user_id:    user.id,
							 game_id:    game.id,
							 away_home:  away_home[selector],
							 pick:       versus[selector],
							 tbreak_pts: tbreak
							)
	end
end