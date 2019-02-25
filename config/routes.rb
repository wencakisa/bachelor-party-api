Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  resources :activities

  resources :quotations, except: [:destroy]

  resources :parties, except: [:create]

  resources :users, except: [:update]

  resources :invites, only: %i[create update]
end
