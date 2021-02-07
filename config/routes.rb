Rails.application.routes.draw do
  root 'posts#index'

  resources :posts

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :show, :create, :edit] do
    get :follow, on: :member
  end
  resources :relationships, only: [:create, :destroy]
end
