Rails.application.routes.draw do
  root 'site#index'
  get  'site/current_week'
  post 'site/game_pick'
  post 'site/tbreak_pick'

  get  'admin/active_week'
  post 'admin/add_new_game'
  post 'admin/delete_game'
  get  'admin/lock'
  post 'admin/locked'
  get  'admin/scores'
  post 'admin/finalize'
  post 'admin/new_week'

  devise_for :users
end
