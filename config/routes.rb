Rails.application.routes.draw do
	root 'users#login'

  resources :restaurants, only: [:index, :show]
  resources :users do
    resources :group_searches, only: [:index, :show, :create]
    resources :groups, except: :new do
      resources :reservations, only: [:show, :create, :destroy]
      resources :messages, only: [:create]
    end
  end

  get :login, to: 'users#login'
  get :logout, to: 'users#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
