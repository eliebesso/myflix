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

  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  mount Sidekiq::Web, at: "/sidekiq"
end





