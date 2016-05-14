User.create!( admin: 1, username: "luke", email: "luke@gmail.com", password: "loplop", password_confirmation: "loplop" )
User.create!( admin: 1, username: "kr", email: "kr@gmail.com", password: "emmie1", password_confirmation: "emmie1" )


Game.create( week: 1, away: "Florida", home: "Florida State", spread: 1, location: "Jacksonville, FL", tiebreaker: false )
Game.create( week: 1, away: "Penn State", home: "Ohio State", spread: -15, location: "Columbus, OH", tiebreaker: true  )
Game.create( week: 1, away: "Kentucky", home: "Alabama", spread: -23, location: "Missouri, MS", tiebreaker: false )
