Rails.application.routes.draw do
  root 'site#index'
  get  'site/current_week'
  post 'site/game_pick'
  post 'site/tbreak_pick'
  get  'site/standings'
  get  'site/history'
  get  'site/archived'

  get  'admin/active_week'
  post 'admin/add_new_game'
  post 'admin/delete_game'
  get  'admin/lock'
  post 'admin/locked'
  get  'admin/scores'
  post 'admin/review'
  get  'admin/finalize'
  get  'admin/export_results'
  get  'admin/active_game_slate'
  post 'admin/game_started'

  devise_for :users
end
