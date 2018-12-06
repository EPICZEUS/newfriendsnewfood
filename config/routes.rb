Rails.application.routes.draw do
	root 'users#login'

  resources :restaurants, only: [:index, :show]
  resources :users do
    resources :group_searches, only: [:show, :create]
    resources :groups, except: :new do
      resources :reservations, only: [:show, :create]
      resources :messages, only: [:create]
    end
  end

  get :logging, to: 'users#logging'
  get :logout, to: 'users#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
