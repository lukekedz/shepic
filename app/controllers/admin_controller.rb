class AdminController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_is_admin?

  def current_week
    @current_week = Week.last
    @games = Game.where(week_id: @current_week.id)
  end

  def new_week
  end

  private

  def user_is_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

end