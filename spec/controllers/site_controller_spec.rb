require 'rails_helper'

RSpec.describe SiteController, :type => :controller do

	describe 'GET :index' do
		before :each do 
			sign_in User.create(username: 'user', admin: false, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')
		end

		it 'responds successfully with an HTTP 200 status code' do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the index template' do
			get :index
			expect(response).to render_template('index')	
		end
	end

	describe 'GET :current_week' do
		before :each do
			sign_in User.create(username: 'user', admin: false, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			teams       = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army"]
			start_times = ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"]

			last_week = Week.last ? Week.last.week : 0
			@new_week  = Week.create(week: last_week + 1, locked: false, finalized: false)

			10.times do
			  Game.create(
			    week_id:    @new_week.week,
			    away:       teams.sample,
			    home:       teams.sample,
			    spread:     Faker::Number.between(-15, 15),
			    location:   Faker::Address.city,
			    tiebreaker: false,
			    date:       Faker::Date.between(Date.today, Date.today + 2),
			    start_time: start_times.sample
			  )
			end
		end

		it 'responds successfully with an HTTP 200 status code' do
			get :current_week
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the current_week template' do
			get :current_week
			expect(response).to render_template('current_week')	
		end
	end

	describe 'GET :standings' do
		before :each do
			sign_in User.create(username: 'user', admin: false, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			Week.create(week: 1, locked: true, finalized: true)
		end

		it 'responds successfully with an HTTP 200 status code' do
			get :standings
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the standings template' do
			get :standings
			expect(response).to render_template('standings')	
		end
	end

	describe 'GET :history' do
		before :each do
			sign_in User.create(username: 'user', admin: false, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			Week.create(week: 1, locked: true, finalized: true)
		end

		it 'responds successfully with an HTTP 200 status code' do
			get :history
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the history template' do
			get :history
			expect(response).to render_template('history')	
		end
	end

	describe 'GET :archived' do
		before :each do
			sign_in User.create(username: 'user', admin: false, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			teams       = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army"]
			start_times = ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"]

			last_week = Week.last ? Week.last.week : 0
			@new_week  = Week.create(week: last_week + 1, locked: false, finalized: false)

			10.times do
			  Game.create(
			    week_id:    @new_week.week,
			    away:       teams.sample,
			    home:       teams.sample,
			    spread:     Faker::Number.between(-15, 15),
			    location:   Faker::Address.city,
			    tiebreaker: false,
			    date:       Faker::Date.between(Date.today, Date.today + 2),
			    start_time: start_times.sample
			  )
			end

			games = Game.where(week_id: @new_week.id)
			User.where(admin: false).each do |user|
				games.each do |game|
					away_home = ["away", "home"]
					versus    = [game.away, game.home]
				    selector  = rand(0..1)
				    tbreak    = game.tiebreaker == true ? rand(0..160) : "" 

					Pick.where(user_id: user.id, game_id: game.id)
						.first_or_create(user_id:    user.id,
										 game_id:    game.id,
										 away_home:  away_home[selector],
										 pick:       versus[selector],
										 tbreak_pts: tbreak
										)
				end
			end

			@new_week.update(locked: true, finalized: true)
		end

		it 'responds successfully with an HTTP 200 status code' do
			get :archived, :week => @new_week.id
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the archived template' do
			get :archived, :week => @new_week.id
			expect(response).to render_template('archived')	
		end
	end

end