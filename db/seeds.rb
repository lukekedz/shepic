puts
puts "Seeding DB: Initial..."
puts

User.create!(username: "luke",  email: "luke@gmail.com",  password: "loplop", password_confirmation: "loplop", admin: true)
User.create!(username: "kr",    email: "kr@gmail.com",    password: "emmie1", password_confirmation: "emmie1")
User.create!(username: "lk",    email: "lk@gmail.com",    password: "emmie2", password_confirmation: "emmie2")
User.create!(username: "gary",  email: "gary@gmail.com",  password: "kickba", password_confirmation: "kickba")
User.create!(username: "kat",   email: "kat@gmail.com",   password: "emmie2", password_confirmation: "emmie2")
User.create!(username: "emmie", email: "emmie@gmail.com", password: "hooman", password_confirmation: "hooman")

teams = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army", "Auburn", "Ball State", "Baylor", "BYU", "Boise State", "Boston College", "Buffalo", "California", "UCF", "Central Michigan", "Cincinnati", "Clemson", "Colorado", "Colorado State", "UConn", "Duke", "Eastern Michigan", "Florida", "Florida Atlantic", "Florida International", "Florida State", "Fresno State", "Georgia", "Georgia Tech", "Hawaii", "Houston", "Idaho", "Illinois", "Indiana", "Iowa", "Iowa State", "Kansas", "Kansas State", "Kent State", "Kentucky", "LSU", "Louisiana Tech", "Louisiana-Lafayette", "Louisiana-Monroe", "Louisville", "Marshall", "Maryland", "Memphis", "Miami (FL)", "Miami (OH)", "Michigan", "Michigan State", "Middle Tennessee State", "Minnesota", "Ole Miss", "Mississippi State", "Missouri", "Navy", "Nebraska", "Nevada", "UNLV", "New Mexico", "New Mexico State", "North Carolina", "NC State", "North Texas", "Northern Illinois", "Northwestern", "Notre Dame", "Ohio", "Ohio State", "Oklahoma", "Oklahoma State", "Oregon", "Oregon State", "Penn State", "Pittsburgh", "Purdue", "Rice", "Rutgers", "San Diego State", "San Jose State", "South Carolina", "South Florida", "SMU", "Southern Mississippi", "Stanford", "Syracuse", "Temple", "Tennessee", "Texas", "Texas A&M", "TCU", "Texas Tech", "Toledo", "Troy", "Tulane", "Tulsa", "UCLA", "USC", "Utah", "Utah State", "Vanderbilt", "Virginia", "Virginia Tech", "Wake Forest", "Washington", "Washington State", "West Virginia", "Western Kentucky", "Western Michigan", "Wisconsin", "Wyoming"]

teams.each { |t| Team.create(name: t) }

Week.create(week: 1, locked: false, finalized: false)
