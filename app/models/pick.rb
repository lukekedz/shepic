class Pick < ActiveRecord::Base
	validates :user_id, presence: true
	validates :game_id, presence: true

  	belongs_to :users
  	belongs_to :games
end
