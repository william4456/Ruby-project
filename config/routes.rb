Rails.application.routes.draw do

  devise_for :users
  resources :users, :posts
  root to: "posts#index"
end
