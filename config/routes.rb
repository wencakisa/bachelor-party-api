Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'registrations/registrations'
  }

  resources :activities
  resources :quotations, except: [:destroy]
  resources :parties
end
