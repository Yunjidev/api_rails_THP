Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :articles do
    resources :comments, only: [:index, :create, :update, :destroy], defaults: { format: 'json' }
  end

  get '/member-data', to: 'members#show'
end
