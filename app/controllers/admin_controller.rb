class AdminController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_is_admin?

  def new_week
    @current_week = Week.where(locked: false).order("id asc").first
  end


  private

  def user_is_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

end