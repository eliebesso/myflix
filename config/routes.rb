Myflix::Application.routes.draw do
  root to: 'videos#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :videos, only: [:show, :index] do
  	collection do
  		get 'search'
  	end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]

  get '/my_queue', to: 'queue_items#index'

  resources :users, only: [:create]

  resources :sessions, only: [:create]

   get 'ui(/:action)', controller: 'ui'
end