class Week < ActiveRecord::Base
  has_many :games
  has_many :picks, through: :games

  auto_increment :week
end
