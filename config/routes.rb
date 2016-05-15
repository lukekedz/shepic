Rails.application.routes.draw do
  root 'site#welcome'
  get  'admin/current_week'

  devise_for :users

end
