start_times = ["1200", "1215", "300", "330", "800", "830", "900"]

10.times do
  Game.create(
    week_id:    Week.last.week,
    away:       Team.all.sample.name,
    home:       Team.all.sample.name,
    spread:     Faker::Number.between(-15, 15),
    location:   Faker::Address.city,
    tiebreaker: false,
    date:       Faker::Date.between(Date.today, Date.today + 2),
    start_time: start_times.sample,
    game_started: false
  )
end

Game.last.update(tiebreaker: true)
Week.last.update(locked: true)