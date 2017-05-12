Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # put '/members/update', to: 'members#update'
  resources :members
  resources :donors do
    resources :videos
  end
end
