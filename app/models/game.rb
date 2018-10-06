class Game < ActiveRecord::Base
  validates :week_id,     presence: true
  validates :away,        presence: true
  validates :home,        presence: true
  validates_inclusion_of :tiebreaker,   in: [true, false]
  validates_inclusion_of :game_started, in: [true, false]
  validates_inclusion_of :game_finished, in: [true, false]

  belongs_to :weeks
  has_many :picks

  def game_times
    times = []
    (12..23).each do |i|
      times.push(i.to_s + "00")
      times.push(i.to_s + "15")
      times.push(i.to_s + "30")
    end

    times
  end

end
