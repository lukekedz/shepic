class Week < ActiveRecord::Base
  validates :week, presence: true
  
  has_many :games
  has_many :picks, through: :games

  def self.current
    Week.last
  end

end
