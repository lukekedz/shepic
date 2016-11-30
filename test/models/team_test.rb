require 'test_helper'

class TeamTest < ActiveSupport::TestCase
	def setup
		@team = Team.new(name: Faker::Team.state)
	end

  	test 'valid Team' do
  		assert @team.valid?, @team.errors.full_messages
  	end

  	test 'should not save without a name' do
  		@team.name = nil
  		refute @team.valid?
	end
end
