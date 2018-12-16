Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :activities

  resources :quotations, except: [:destroy] do
    patch 'update_status', on: :member
  end
end
