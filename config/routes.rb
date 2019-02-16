Rails.application.routes.draw do
  root to: redirect(Rails.application.credentials.client[:host])

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  resources :activities

  resources :quotations, except: [:destroy] do
    put 'approve', on: :member
  end

  resources :parties
end
