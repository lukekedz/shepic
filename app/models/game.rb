class Game < ActiveRecord::Base
  validates :week_id,     presence: true
  validates :away,        presence: true
  validates :home,        presence: true
  validates_inclusion_of :tiebreaker, in: [true, false]

  belongs_to :weeks
  has_many :picks

  def game_times
    times = []
    (1..12).each do |i|
      times.push(i.to_s + ":00" + "pm")
      times.push(i.to_s + ":15" + "pm")
      times.push(i.to_s + ":30" + "pm")
    end

    3.times { times.insert(0, times.delete_at(-1)) }

    times
  end

end
