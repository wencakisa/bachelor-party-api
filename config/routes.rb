Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :activities

  resources :quotations, except: [:destroy] do
    member do
      patch 'approve', to: 'quotations#approve'
      patch 'reject', to: 'quotations#reject'
    end
  end
end
