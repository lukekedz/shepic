puts "Seeding DB: Initial..."

# initial setup
if User.count == 0
  User.create!(admin: true,  username: "luke",  email: "luke@gmail.com",  password: "loplop", password_confirmation: "loplop" )
  User.create!(admin: false, username: "kr",    email: "kr@gmail.com",    password: "emmie1", password_confirmation: "emmie1" )
  User.create!(admin: false, username: "lk",    email: "lk@gmail.com",    password: "emmie2", password_confirmation: "emmie2" )
  User.create!(admin: false, username: "gary",  email: "gary@gmail.com",  password: "kickba", password_confirmation: "kickba" )
  User.create!(admin: false, username: "kat",   email: "kat@gmail.com",   password: "emmie2", password_confirmation: "emmie2" )
  User.create!(admin: false, username: "emmie", email: "emmie@gmail.com", password: "hooman", password_confirmation: "hooman" )
end

teams = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army", "Auburn", "Ball State", "Baylor", "BYU", "Boise State", "Boston College", "Buffalo", "Cal", "UCF", "Central Michigan", "Cincinnati", "Clemson", "Colorado", "Colorado State", "UConn", "Duke", "Eastern Michigan", "Florida", "Florida Atlantic", "Florida International", "Florida State", "Fresno State", "Georgia", "Georgia Tech", "Hawaii", "Houston", "Idaho", "Illinois", "Indiana", "Iowa", "Iowa State", "Kansas", "Kansas State", "Kent State", "Kentucky", "LSU", "Louisiana Tech", "Louisiana-Lafayette", "Louisiana-Monroe", "Louisville", "Marshall", "Maryland", "Memphis", "Miami (FL)", "Miami (OH)", "Michigan", "Michigan State", "Middle Tennessee State", "Minnesota", "Mississippi", "Mississippi State", "Missouri", "Navy", "Nebraska", "Nevada", "UNLV", "New Mexico", "New Mexico State", "North Carolina", "North Carolina State", "North Texas", "Northern Illinois", "Northwestern", "Notre Dame", "Ohio", "Ohio State", "Oklahoma", "Oklahoma State", "Oregon", "Oregon State", "Penn State", "Pitt", "Purdue", "Rice", "Rutgers", "San Diego State", "San Jose State", "South Carolina", "South Florida", "SMU", "Southern Mississippi", "Stanford", "Syracuse", "Temple", "Tennessee", "Texas", "Texas A&M", "TCU", "Texas Tech", "Texas-El Paso", "Toledo", "Troy", "Tulane", "Tulsa", "UCLA", "Utah", "Utah State", "Vanderbilt", "Virginia", "Virginia Tech", "Wake Forest", "Washington", "Washington State", "West Virginia", "Western Kentucky", "Western Michigan", "Wisconsin", "Wyoming"]

if Team.count == 0 
  teams.each { |t| Team.create(name: t) }
end

Week.create(week: 1, locked: false, finalized: false)