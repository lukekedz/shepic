User.create!(admin: true, username: "luke", email: "luke@gmail.com", password: "loplop", password_confirmation: "loplop" )
User.create!(admin: false, username: "kr", email: "kr@gmail.com", password: "emmie1", password_confirmation: "emmie1" )
User.create!(admin: false, username: "lk", email: "lk@gmail.com", password: "emmie2", password_confirmation: "emmie2" )

Week.create(week: 1, locked: false, finalized: false)

10.times do |t|
  Game.create(
    week_id:    1,
    away:       Faker::University.name,
    home:       Faker::University.name,
    spread:     Faker::Number.between(-15, 15),
    location:   Faker::Address.city,
    tiebreaker: false,
    date:       ["09/01/16", "09/02/16", "09/03/16"].sample,
    start_time: ["12:00pm", "3:30pm", "8:30pm"].sample
  )
end

Game.create(
  week_id:    1,
  away:       "Florida",
  home:       "Florida State",
  spread:     1.5,
  location:   "Jacksonville, FL",
  tiebreaker: true,
  date:       "12/31/16",
  start_time: "12:30pm"
)

