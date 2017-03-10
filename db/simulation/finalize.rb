current_week = Week.last
games = Game.where(week_id: current_week.id)

if Week.last.locked == true
    Week.last.update(finalized: true)
	# in seeds, new week creation is part of ten_game_slate

	games.each do |game|
		picks = Pick.where(game_id: game.id)

		picks.each do |pick|
			if game.winner == "push" || game.winner == nil
				Pick.update(pick.id, correct: nil)
			else
				if game.winner == pick.away_home
					Pick.update(pick.id, correct: true)
				else
					Pick.update(pick.id, correct: false)
				end
			end
		end

        User.where(admin: false).each do |user|
            pick = Pick.where(game_id: game.id, user_id: user.id)

            if pick.any? && pick[0].correct == true
              	standing    = Standing.where(user_id: user.id)
          		incremented = standing[0].wins + 1
          
				Standing.update(standing[0].id, wins: incremented)
            end
        end
	end
end
