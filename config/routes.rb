Rails.application.routes.draw do
  get 'posts/index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
