Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  root to: "tweets#index"
  resources :tweets do
    member do
      get 'atlas'
    end
    resources :comments, only: :create
  end
  resources :users, only: :show

end
