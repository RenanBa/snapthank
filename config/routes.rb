Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  put '/members/update/:email', to: 'members#update'
  resources :members
end
