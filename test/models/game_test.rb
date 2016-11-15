require 'test_helper'

class GameTest < ActiveSupport::TestCase
	def setup
    	@game = Game.new(week_id:    rand(1000), 
    					 away:       "OSU", 
    					 home:       "Michigan", 
    					 tiebreaker: [true, false].sample
    					)
  	end

  	test 'valid Game' do
  		assert @game.valid?, @game.errors.full_messages
  	end

  	test "should not save without a week_id" do
  		@game.week_id = nil
  		refute @game.valid?, 'saved Game without week_id'
		assert_not_nil @game.errors[:week_id], "no validation error for week_id present"
	end

  	test "should not save without away team" do
  		@game.away = nil
  		refute @game.valid?, 'saved Game without away team'
		assert_not_nil @game.errors[:away], "no validation error for away team present"
	end

  	test "should not save without home team" do
  		@game.home = nil
  		refute @game.valid?, 'saved Game without home team'
		assert_not_nil @game.errors[:home], "no validation error for home team present"
	end

  	test "should not save without tiebreaker boolean" do
  		@game.tiebreaker = nil
  		refute @game.valid?, 'saved Game without tiebreaker boolean'
		assert_not_nil @game.errors[:tiebreaker], "no validation error for tiebreaker boolean present"
	end

	# test "#game_times" do
	# 	game_times = Game.game_times()
	# 	assert game_times.any?
	# end
end
