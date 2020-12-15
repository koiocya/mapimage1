Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  root to: "tweets#index"
  resources :tweets do
    resources :comments, only: :create
  end
  resources :users, only: :show
<<<<<<< HEAD
<<<<<<< HEAD
=======
  resources :maps
  get '/map_request', to: 'maps#map', as: 'map_request'
>>>>>>> parent of afd3755... 緯度経度を使用しgooglemapに反映
=======
>>>>>>> parent of 9002a1e... Merge pull request #17 from koiocya/revert-16-revert-15-googlemap連携
end
