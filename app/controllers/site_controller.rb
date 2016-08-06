class SiteController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :user

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
    @current_pick = @user.picks.where(game_id: params[:pick][:game_id])

    respond_to do |format|
      if @current_pick == []
        @pick = Pick.new(user_id: params[:pick][:user_id], game_id: params[:pick][:game_id], pick: params[:pick][:pick] )

          if @pick.save
            format.json { render json: @pick.to_json }
          else
            # TODO: error msg
          end
      else
        @pick = Pick.update(@current_pick[0].id, pick: params[:pick][:pick])
        format.json { render json: @pick.to_json }
      end
    end
  end

  private

  def user
    @user = User.find(current_user.id)
  end

end
