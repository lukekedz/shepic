require 'rails_helper'

RSpec.describe AdminController, :type => :controller do

	describe 'GET :active_week' do
		before :each do
			sign_in User.create(username: 'admin', admin: true, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			teams       = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army"]
			start_times = ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"]

			last_week = Week.last ? Week.last.week : 0
			new_week  = Week.create(week: last_week + 1, locked: false, finalized: false)

			10.times do
			  Game.create(
			    week_id:    new_week.week,
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
			get :active_week
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the active_week template' do
			get :active_week
			expect(response).to render_template('active_week')	
		end
	end

	describe 'GET :lock' do
		before :each do
			sign_in User.create(username: 'admin', admin: true, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			teams       = ["Air Force",  "Akron",  "Alabama",  "Arizona", "Army"]
			start_times = ["12:00pm", "12:15pm", "3:00pm", "3:30pm", "8:00pm", "8:30pm", "9:00pm"]

			last_week = Week.last ? Week.last.week : 0
			new_week  = Week.create(week: last_week + 1, locked: false, finalized: false)

			10.times do
			  Game.create(
			    week_id:    new_week.week,
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
			get :lock
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the lock template' do
			get :lock
			expect(response).to render_template('lock')	
		end
	end

	describe 'GET :review' do
		before :each do
			sign_in User.create(username: 'admin', admin: true, email: 'dev@gmail.com', password: 'anyong', password_confirmation: 'anyong')

			Week.create(week: 1, locked: true, finalized: true)
		end

		it 'responds successfully with an HTTP 200 status code' do
			get :review
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the review template' do
			get :review
			expect(response).to render_template('review')	
		end
	end

end