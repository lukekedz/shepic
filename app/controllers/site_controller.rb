class SiteController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def welcome
  end

  def active_week
    @current_week = Week.last
    @games = Game.where(week_id: @current_week.id)
  end

end
