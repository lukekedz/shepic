require 'rails_helper'

describe AdminController, :type => :controller do
    describe 'GET active_week' do
        it 'has a 200 status code' do
            user = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(user)
            allow(controller).to receive(:current_user).and_return(user)

            get :active_week
            expect(response.status).to eq(200)
        end
    end

    describe 'GET active_week var @teams' do
        it 'returns expected amount of seeded teams' do
            user = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(user)
            allow(controller).to receive(:current_user).and_return(user)

            get :active_week
            expect(assigns(:teams).length).to eq(113)
        end
    end

    describe 'GET active_week var @games' do
        before :each do
            admin = double('user', :admin => true)
            allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
            allow(controller).to receive(:current_user).and_return(admin)
        end

        it 'returns expected amount of seeded simulation games' do
            get :active_week
            expect(assigns(:games).length).to eq(10)
        end
    end
end