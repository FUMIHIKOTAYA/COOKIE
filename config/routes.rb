Rails.application.routes.draw do
  root 'tops#index'

  resources :tops, only: [:index]
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :show, :create, :edit, :update] do
    get :follow, on: :member
  end
  resources :relationships, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
end
