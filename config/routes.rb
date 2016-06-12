Rails.application.routes.draw do

  root 'site#welcome'
  get  'site/active_week'

  get  'admin/current_week'
  post 'admin/add_new_game'

  devise_for :users

end
