puts "Seeding DB... "

User.create!(admin: true, username: "luke", email: "luke@gmail.com", password: "loplop", password_confirmation: "loplop" )
User.create!(admin: false, username: "kr", email: "kr@gmail.com", password: "emmie1", password_confirmation: "emmie1" )
User.create!(admin: false, username: "lk", email: "lk@gmail.com", password: "emmie2", password_confirmation: "emmie2" )

Week.create(week: 1, locked: false, finalized: false)

9.times do
  Game.create(
    week_id:    1,
    away:       Faker::University.name,
    home:       Faker::University.name,
    spread:     Faker::Number.between(-15, 15),
    location:   Faker::Address.city,
    tiebreaker: false,
    date:       Faker::Date.between(Date.today, Date.today + 2),
    start_time: ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"].sample
  )
end

Game.create(
  week_id:    1,
  away:       "Florida",
  home:       "Florida State",
  spread:     1.5,
  location:   "Jacksonville, FL",
  tiebreaker: true,
  date:       Faker::Date.between(Date.today, Date.today + 2),
  start_time: ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"].sample
)

teams = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army", "Auburn", "Ball State", "Baylor", "BYU", "Boise State", "Boston College", "Buffalo", "Cal", "UCF", "Central Michigan", "Cincinnati", "Clemson", "Colorado", "Colorado State", "UConn", "Duke", "Eastern Michigan", "Florida", "Florida Atlantic", "Florida International", "Florida State", "Fresno State", "Georgia", "Georgia Tech", "Hawaii", "Houston", "Idaho", "Illinois", "Indiana", "Iowa", "Iowa State", "Kansas", "Kansas State", "Kent State", "Kentucky", "LSU", "Louisiana Tech", "Louisiana-Lafayette", "Louisiana-Monroe", "Louisville", "Marshall", "Maryland", "Memphis", "Miami (FL)", "Miami (OH)", "Michigan", "Michigan State", "Middle Tennessee State", "Minnesota", "Mississippi", "Mississippi State", "Missouri", "Navy", "Nebraska", "Nevada", "UNLV", "New Mexico", "New Mexico State", "North Carolina", "North Carolina State", "North Texas", "Northern Illinois", "Northwestern", "Notre Dame", "Ohio", "Ohio State", "Oklahoma", "Oklahoma State", "Oregon", "Oregon State", "Penn State", "Pitt", "Purdue", "Rice", "Rutgers", "San Diego State", "San Jose State", "South Carolina", "South Florida", "SMU", "Southern Mississippi", "Stanford", "Syracuse", "Temple", "Tennessee", "Texas", "Texas A&M", "TCU", "Texas Tech", "Texas-El Paso", "Toledo", "Troy", "Tulane", "Tulsa", "UCLA", "Utah", "Utah State", "Vanderbilt", "Virginia", "Virginia Tech", "Wake Forest", "Washington", "Washington State", "West Virginia", "Western Kentucky", "Western Michigan", "Wisconsin", "Wyoming"]

teams.each do |t|
  Team.create(name: t)
end