require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		pw = Faker::Internet.password(6, 128)
    	@user = User.new(admin:                 [true, false].sample, 
    					         username:              Faker::Name.first_name, 
    					         email:                 Faker::Internet.email, 
    					         password:              pw,
    					         password_confirmation: pw
    					)

    	@user.save
    	@user_standing = Standing.find_by(user_id: @user.id)
  	end

  	test 'valid User' do
  		assert @user.valid?, @user.errors.full_messages
  	end

  	test 'user should be included in standings' do
  		assert_not_nil @user_standing, 'user not in standings'
  	end

  	test 'user should have 0 wins' do 
  		assert @user_standing.wins == 0, 'user does not have 0 wins'
  	end
end
