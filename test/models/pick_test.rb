require 'test_helper'

class PickTest < ActiveSupport::TestCase
	def setup
		@pick = Pick.new(user_id:    rand(1000), 
						 game_id:    rand(1000),
						 pick:       Faker::Team.state,
						 away_home:  ["away", "home"].sample,
						 tbreak_pts: rand(100)
						)
	end

  	test 'valid Pick' do
  		assert @pick.valid?, @pick.errors.full_messages
  	end

  	test 'should not save without user_id' do
  		@pick.user_id = nil
  		refute @pick.valid?
	end

  	test 'should not save without game_id' do
  		@pick.game_id = nil
  		refute @pick.valid?
	end
end
