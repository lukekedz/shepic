User.create!(admin: true, username: "luke", email: "luke@gmail.com", password: "loplop", password_confirmation: "loplop" )
User.create!(admin: false, username: "kr", email: "kr@gmail.com", password: "emmie1", password_confirmation: "emmie1" )

Week.create(week: 1, locked: true)
Week.create(week: 2, locked: false)
Week.create(week: 3, locked: false)

Game.create(week_id: 1, away: "Florida", home: "Florida State", spread: 1, location: "Jacksonville, FL", tiebreaker: false)
Game.create(week_id: 1, away: "Penn State", home: "Ohio State", spread: -15, location: "Columbus, OH", tiebreaker: true)
Game.create(week_id: 1, away: "Kentucky", home: "Alabama", spread: -23, location: "Mooringsport, LA", tiebreaker: false)

Game.create(week_id: 2, away: "Rutgers", home: "Stanford", spread: -4, location: "Chicago, IL", tiebreaker: true)
Game.create(week_id: 2, away: "Oregon", home: "LSU", spread: 5, location: "Hollywood, CA", tiebreaker: false)
Game.create(week_id: 2, away: "Georgia State", home: "Georgia", spread: 2, location: "Atlanta, GA", tiebreaker: true)

Pick.create(game_id: 1, user_id: 1, pick: "Florida State")
Pick.create(game_id: 2, user_id: 1, pick: "Penn State")
Pick.create(game_id: 3, user_id: 1, pick: "Alabama")
Pick.create(game_id: 4, user_id: 1, pick: "Rutgers")
Pick.create(game_id: 5, user_id: 1, pick: "LSU")
Pick.create(game_id: 6, user_id: 1, pick: "Georgia")

Pick.create(game_id: 1, user_id: 2, pick: "Florida State")
Pick.create(game_id: 2, user_id: 2, pick: "Ohio State")
Pick.create(game_id: 3, user_id: 2, pick: "Kentucky")

=begin
I want all user picks
lk = User.find(1)
lk.picks

I want all games in a week
wk = Week.find_by(week:1)
wk.games

I want all the picks from a particular weekwk =
wk = Game.where(week_id:1)
wk.each do |w|
  wkpk = w.picks.where(user_id:1) OR wkpk = w.picks.find_by(user_id:1)
  puts wkpk[0].pick OR puts wkpk.pick
end

Putting it all together
wk = Week.find_by(week:2)
wk.games.each do |g|
  wkpk = Pick.find_by(game_id: g.id, user_id:2)
  puts wkpk.pick
end


=end
