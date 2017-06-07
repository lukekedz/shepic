require 'rails_helper'

describe AdminController, :type => :controller do

    describe 'GET active_week when not logged in' do
        it 'returns response status 302' do
            get :active_week
            expect(response.status).to eq(302)
        end

        # TODO: test for the reroute destination
    end

    describe 'GET active_week' do
        before :each do
            admin = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
            allow(controller).to receive(:current_user).and_return(admin)

            get :active_week
        end

        it 'returns response status 200 if logged in' do
            expect(response.status).to eq(200)
        end

        it 'includes instance variable @teams' do
            expect(assigns(:teams)).not_to be_nil
            expect(assigns(:teams)).to be_kind_of(ActiveRecord::Relation)
            expect(assigns(:teams).sample).to be_a(Team)
        end

        it 'includes model Team at @teams sample' do
            expect(assigns(:teams).sample).to be_a(Team)
        end

        it 'includes @teams with correct # of teams' do
            expect(assigns(:teams).length).to eq(113)
        end

        it 'includes instance variable @new_game' do
            expect(assigns(:new_game)).not_to be_nil
            expect(assigns(:new_game)).to be_a(Game)
        end

        it 'includes instance variable @active_week' do
            expect(assigns(:active_week)).not_to be_nil
            expect(assigns(:active_week)).to be_a(Week)
        end

        it 'includes instance variable @games' do
            expect(assigns(:games)).not_to be_nil
            expect(assigns(:games)).to be_kind_of(ActiveRecord::Relation)
        end

        it 'includes model Game at @games sample' do
            expect(assigns(:games).sample).to be_a(Game)
        end

        it 'includes @games w/ expected # of games' do
            # TODO: will not always pass! need to update
            expect(assigns(:games).length).to eq(10)
        end

        it 'includes instance variable @tiebreaker' do
            expect(assigns(:tiebreaker)).not_to be_nil
        end

        it 'includes @tiebreaker as integer' do
            expect(assigns(:tiebreaker)).to be_kind_of(Integer)
        end

        it 'includes instance variable @times' do
            expect(assigns(:times)).not_to be_nil
            expect(assigns(:times)).to be_kind_of(Array)
        end

        it 'includes string at @times sample' do
            expect(assigns(:times).sample).to be_kind_of(String)
        end

        it 'includes @times array with length 36' do
            expect(assigns(:times).length).to eq(36)
        end
    end

    describe 'GET lock' do
        before :each do
            admin = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
            allow(controller).to receive(:current_user).and_return(admin)

            get :lock
        end

        it 'returns response status 200 if logged in' do
            expect(response.status).to eq(200)
        end

        it 'includes instance variable @active_week' do
            expect(assigns(:active_week)).not_to be_nil
            expect(assigns(:active_week)).to be_a(Week)
        end

        it 'includes instance variable @games' do
            expect(assigns(:games)).not_to be_nil
            expect(assigns(:games)).to be_kind_of(ActiveRecord::Relation)
        end

        it 'includes model Game at @games sample' do
            expect(assigns(:games).sample).to be_a(Game)
        end

        it 'includes @games w/ expected # of games' do
            # TODO: will not always pass! need to update
            expect(assigns(:games).length).to eq(10)
        end

        it 'includes instance variable @tiebreaker' do
            expect(assigns(:tiebreaker)).not_to be_nil
        end

        it 'includes @tiebreaker as integer' do
            expect(assigns(:tiebreaker)).to be_kind_of(Integer)
        end
    end

    describe 'GET scores' do
        before :each do
            admin = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
            allow(controller).to receive(:current_user).and_return(admin)

            get :scores
        end

        it 'returns response status 200 if logged in' do
            expect(response.status).to eq(200)
        end

        it 'includes instance variable @points' do
            expect(assigns(:points)).not_to be_nil
            expect(assigns(:points)).to be_kind_of(Array)
        end

        it '@points has length 101' do
            expect(assigns(:points).length).to eq(101)
        end

        it '@points sample is an integer' do
            expect(assigns(:points).sample).to be_kind_of(Integer)
        end

        it 'includes instance variable @active_week' do
            expect(assigns(:active_week)).not_to be_nil
            expect(assigns(:active_week)).to be_a(Week)
        end

        it '@active_week attribute locked is true' do
            expect(assigns(:active_week).locked).to eq(true)
        end

        it 'includes instance variable @games' do
            expect(assigns(:games)).not_to be_nil
            expect(assigns(:games)).to be_a(ActiveRecord::Relation)
        end

        it 'includes model Game at @games sample' do
            expect(assigns(:games).sample).to be_a(Game)
        end
    end

    describe 'GET export_results' do
        before :each do
            admin = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
            allow(controller).to receive(:current_user).and_return(admin)

            get :export_results
        end

        it 'includes instance variable @weeks' do
            expect(assigns(:weeks)).not_to be_nil
            expect(assigns(:weeks)).to be_a(ActiveRecord::Relation)
        end
    end
end
