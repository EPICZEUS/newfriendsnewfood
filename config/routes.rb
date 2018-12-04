Rails.application.routes.draw do
	root 'users#login'
  resources :user_groups
  resources :reservations
  resources :restaurants
  resources :groups do
  	resources :messages, only: [:index, :create], controller: 'groups/messages'
  end
  resources :users
  get :logging, to: 'users#logging'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
