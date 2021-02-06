Rails.application.routes.draw do
  root 'posts#index'

  resources :posts

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
