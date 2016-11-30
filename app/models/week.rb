class Week < ActiveRecord::Base
  validates :week, presence: true
  
  has_many :games
  has_many :picks, through: :games

  auto_increment :week

  def self.current
    Week.last
  end

end
