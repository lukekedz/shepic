class SiteController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def welcome
  end

  def active_week
    @current_week = Week.last
    @games = Game.where(week_id: @current_week.id)

    @picks = {}
    @games.each do |g|
      user_pick = g.picks.where(user_id: current_user.id)
      if user_pick[0] != nil
        @picks[user_pick[0].game_id] = user_pick[0].pick
      end
    end
  end

  def game_pick
    @pick = Pick.new(pick_params)

    respond_to do |format|
      if @pick.save
         # see gmail email / LDS project
         # data = {:message => "Hitting the controller!"}
         # render :json => data, :status => :ok

         # original
         format.json { render json: @pick.to_json }
      end
    end
  end

  def pick_params
    params.require(:pick).permit(:user_id, :game_id, :pick)
  end

end
