Rails.application.routes.draw do
  namespace :customer do
    root "top#index"
  end

  namespace :admin do
    root "top#index"
  end
end
