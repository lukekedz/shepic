class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

	after_create :default_admin
	after_create :set_standing_wins

	has_many :picks
	has_one  :standing

	def default_admin
		user = User.last
	   	user.admin = false
	   	user.save
	end

	def set_standing_wins
		user = User.last
		if user.admin == false
			Standing.create(user_id: user.id, wins: 0)
		end
	end

end
