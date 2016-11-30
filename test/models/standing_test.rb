require 'test_helper'

class StandingTest < ActiveSupport::TestCase
	def setup
		@standing = Standing.new(user_id: rand(1000), wins: 0)
	end

  	test 'valid Standing' do
  		assert @standing.valid?, @standing.errors.full_messages
  	end

  	test 'should not save without user_id' do
  		@standing.user_id = nil
  		refute @standing.valid?
	end
end
