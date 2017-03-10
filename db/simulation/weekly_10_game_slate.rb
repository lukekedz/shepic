start_times = ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"]

last_week = Week.last ? Week.last.week : 1
new_week  = Week.create(week: last_week + 1, locked: false, finalized: false)

9.times do |i|
  Game.create(
    week_id:    new_week.week,
    away:       Team.all.sample.name,
    home:       Team.all.sample.name,
    spread:     Faker::Number.between(-15, 15),
    location:   Faker::Address.city,
    tiebreaker: (i == 9 ? true : false),
    date:       Faker::Date.between(Date.today, Date.today + 2),
    start_time: start_times.sample
  )
end
