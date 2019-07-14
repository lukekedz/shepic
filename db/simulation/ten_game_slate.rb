start_times = ['1200', '1215', '1500', '1530', '2000', '2030', '2100']

10.times do
  Game.create(
    week_id:      Week.last.week,
    away:         Team.all.sample.name,
    home:         Team.all.sample.name,
    spread:       Faker::Number.between(-15, 15),
    location:     Faker::Address.city,
    tiebreaker:   false,
    date:         Faker::Date.between(Date.today, Date.today + 2),
    start_time:   start_times.sample,
    game_started: false,
    game_finished: false,
    time_remaining: nil

  )
end

Game.last.update(tiebreaker: true)
Week.last.update(locked: true)
