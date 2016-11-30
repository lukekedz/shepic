require 'test_helper'

class WeekTest < ActiveSupport::TestCase
	def setup
		@week = Week.new(id:        rand(1000), 
		 				 week:      rand(1000),
		 				 locked:    [true, false].sample,
		 				 finalized: [true, false].sample
						)

		lock_final = [true, true, false]
		3.times do |i|
    		Week.create(id:        i + 1, 
					    week:      i + 1,
					    locked:    lock_final[i],
					    finalized: lock_final[i]
					    )
    	end
  	end

  	test 'valid Week' do
  		assert @week.valid?, @week.errors.full_messages
  	end

  	test 'should not save without a week #' do
  		@week.week = nil
  		refute @week.valid?, 'saved Week without week #'
		assert_not_nil @week.errors[:week_id], 'no validation error for week present'
	end

	test 'method current() returns last week' do
		current_week = Week.current()
		assert current_week.week == Week.count, 'current week is not the latest week'
	end

end