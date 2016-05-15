Rails.application.routes.draw do
  root 'site#welcome'
  get  'admin/new_week'

  devise_for :users


end
