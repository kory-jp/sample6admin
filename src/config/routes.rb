Rails.application.routes.draw do
  config = Rails.application.config.sample6admin 

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root "top#index"
      resources :posts
      get "login" => "sessions#new", as: :login
      resource :session, only: [:create, :destroy]
      resource :account
      resource :password, only: [:show, :edit, :update]
    end
  end
  
  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [:create, :destroy]
      resources :customers do
        resources :customer_events, only: [:index]
      end
      resources :customer_events, only: [:index]
    end
  end
end
