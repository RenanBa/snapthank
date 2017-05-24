Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Google authentication routes
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  # put '/members/update', to: 'members#update'
  resources :members
  resources :donors do
    resources :videos
  end

  resources :videos, only: [:index, :new, :create]
  root to: 'videos#index'
end
