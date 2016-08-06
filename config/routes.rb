Rails.application.routes.draw do
  root 'site#index'
  get  'site/current_week'
  post 'site/game_pick'

  get  'admin/active_week'
  post 'admin/add_new_game'

  devise_for :users
end
