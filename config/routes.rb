Myflix::Application.routes.draw do
  root to: 'videos#index'

  get '/register', to: 'users#new'
  get '/register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :videos, only: [:show, :index] do
  	collection do
  		get 'search'
  	end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:show]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create,  :destroy]

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get '/my_queue', to: 'queue_items#index'

  resources :users, only: [:create]

  resources :sessions, only: [:create]

  get 'ui(/:action)', controller: 'ui'

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords , only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
  resources :invitations, only: [:new, :create]

  require 'sidekiq/web'
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  mount Sidekiq::Web => '/sidekiq'
end





