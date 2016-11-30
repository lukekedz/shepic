require 'test_helper'

class GameTest < ActiveSupport::TestCase
	def setup
    	@game = Game.new(week_id:    rand(1000), 
    					 away:       "Michigan", 
    					 home:       "Ohio State", 
    					 tiebreaker: [true, false].sample
    					)

		@game_times = Game.new.game_times
  	end

  	test 'valid Game' do
  		assert @game.valid?, @game.errors.full_messages
  	end

  	test 'should not save without a week_id' do
  		@game.week_id = nil
  		refute @game.valid?, 'saved Game without week_id'
	end

  	test 'should not save without away team' do
  		@game.away = nil
  		refute @game.valid?, 'saved Game without away team'
	end

  	test 'should not save without home team' do
  		@game.home = nil
  		refute @game.valid?, 'saved Game without home team'
	end

  	test 'should not save without tiebreaker boolean' do
  		@game.tiebreaker = nil
  		refute @game.valid?, 'saved Game without tiebreaker boolean'
	end

	test 'game_times() should return array' do
		assert @game_times.kind_of?(Array), 'game_times() not returning an array'
	end

	test 'game_times() should have 36 times' do
		assert @game_times.count == 36, 'count should == 36'
	end

	test 'game_times() should contain strings' do
		assert @game_times.sample.kind_of?(String), 'random element not a string'
	end

	test 'should have AR has_many :picks' do
		assert @game.picks.respond_to?(:new), 'not responding to .new'
	end
end
