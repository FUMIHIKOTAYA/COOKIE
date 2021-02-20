Rails.application.routes.draw do
  root 'tops#index'

  resources :tops, only: [:index]
  resources :posts

  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :show, :create, :edit] do
    get :follow, on: :member
  end
  resources :relationships, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
end
