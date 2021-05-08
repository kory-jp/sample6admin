Rails.application.routes.draw do
  namespace :customer do
    root "top#index"
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "session#destory"
  end

  namespace :admin do
    root "top#index"
  end
end
