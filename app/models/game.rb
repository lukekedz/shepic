class Game < ActiveRecord::Base
  belongs_to :weeks
  has_many :picks
  has_many :users, through: :picks
end
