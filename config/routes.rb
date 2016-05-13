Rails.application.routes.draw do
  root 'site#welcome'
  get  'site/admin_add_for_week'

  devise_for :users


end
