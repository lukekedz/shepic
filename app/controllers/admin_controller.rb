class AdminController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :user_is_admin?

  def current_week
    @current_week = Week.last
    @games = Game.where(week_id: @current_week.id)
    @new_game = Game.new

    @times = @new_game.game_times()


  end

  def new_week

  end

  def add_new_game
    # puts params
    @new_game = Game.new(game_params)

    if @new_game.save
      redirect_to admin_current_week_path
    end
  end

  private

  def user_is_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

  def game_params
    params.require(:game).permit(:week_id, :away, :home, :spread, :location, :tiebreaker)
  end

end