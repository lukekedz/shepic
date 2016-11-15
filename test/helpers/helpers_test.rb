require 'test_helper'
include ApplicationHelper

class HelpersTest < ActiveSupport::TestCase
	def setup
		@game_day = game_day(Time.now)
		@day = @game_day.split(", ")
	end

	test 'returns string' do
		assert @game_day.kind_of?(String), "@game_day not a string"
  	end

  	test 'returns day of week string prior to comma' do
  		assert @day[0].kind_of?(String), "day not a string"
  	end

  	test 'returns day of week, ie ending in y, prior to comma' do 
  		assert @day[0][-1] == 'y', "returning: " + @day[0][-1]
  	end

  	test 'returns day of week, with 1st ltr capital, prior to comma' do 
  		day_1st_ltr = @day[0][0]
  		assert @day[0][0] == day_1st_ltr.upcase, "returning: " + @day[0][0]
  	end

  	test 'returns 3 ltr month' do
  		month = @day[1].split(" ")[0]
  		assert month.length == 3, "returning: " + month.length.to_s
  	end

  	test 'returns day of month' do
  		date = @day[1].split(" ")[1]
  		assert date.match(/^(\d)+$/) , "value not a number in string form"
  	end
end