class SiteController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :user

  def index
    @weeks = Week.where(locked: true, finalized: true)
  end

  def current_week
    @current_week = Week.last
    @games = Game.where(week_id: @current_week.id).order(:date)

    @picks = {}
    @games.each do |g|
      user_pick = g.picks.where(user_id: current_user.id)
      if user_pick[0] != nil
        @picks[user_pick[0].game_id] = user_pick[0].pick

        if user_pick[0].tbreak_pts != nil
          @tbreak_pts = user_pick[0].tbreak_pts
        end
      end
    end
  end

  def game_pick
    @current_pick = @user.picks.where(game_id: params[:pick][:game_id])

    respond_to do |format|
      if @current_pick == []
        @pick = Pick.new(user_id: params[:pick][:user_id], game_id: params[:pick][:game_id], pick: params[:pick][:pick], away_home: params[:pick][:away_home])

          if @pick.save
            format.json { render json: @pick.to_json }
          else
            # TODO: error msg
          end
      else
        @pick = Pick.update(@current_pick[0].id, pick: params[:pick][:pick], away_home: params[:pick][:away_home])
        format.json { render json: @pick.to_json }
      end
    end
  end

  def tbreak_pick
    @tbreak_pick = @user.picks.where(game_id: params[:pick][:game_id])

    respond_to do |format|
      if @tbreak_pick == []
        @tbreak = Pick.new(user_id: params[:pick][:user_id], game_id: params[:pick][:game_id], tbreak_pts: params[:pick][:tbreak_pts])

          if @tbreak.save
            format.json { render json: @tbreak.to_json }
          else
            # TODO: error msg
          end
      else
        @tbreak = Pick.update(@tbreak_pick[0].id, tbreak_pts: params[:pick][:tbreak_pts])
        format.json { render json: @tbreak.to_json }
      end
    end
  end

  def standings
    @current_week = Week.where(locked: true, finalized: true).last
    @standings = Standing.order(wins: :desc)
  end

  def history
    @weeks = Week.where(locked: true, finalized: true)
  end

  def archived
    @games = Game.where(week_id: params[:week])
  end

  private

  def user
    @user = User.find(current_user.id)
  end

end
