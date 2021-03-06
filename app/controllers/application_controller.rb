class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:active_game_slate, :game_started, :update_score, :week_number_for_scripts]
  before_action :share_globals

  WEEKLY_GAME_COUNT = 10.freeze

  # :nocov:
  before_action do |controller|
    @current_week = Week.current()
  end
  # :nocov:

  def after_sign_in_path_for(resource)
    resource.admin == true ? admin_active_week_path : site_current_week_path
  end

  def share_globals
    @WEEKLY_GAME_COUNT = WEEKLY_GAME_COUNT
  end

  protected

  # :nocov:
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  # :nocov:

end
