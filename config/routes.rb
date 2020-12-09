Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  root to: "tweets#index"
  resources :tweets
  resources :users, only: :show
end
