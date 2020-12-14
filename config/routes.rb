Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  root to: "tweets#index"
  resources :tweets do
    resources :comments, only: :create
  end
  resources :users, only: :show
  resources :maps
  get '/map_request', to: 'maps#map', as: 'map_request'
end
