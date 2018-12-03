Rails.application.routes.draw do
  resources :user_groups
  resources :reservations
  resources :restaurants
  resources :groups do
  	resources :messages, only: [:index, :create], controller: 'groups/messages'
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
