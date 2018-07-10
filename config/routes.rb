Rails.application.routes.draw do

  get 'landing', to: "landing#index"
  root "landing#index"

  resources :posts
  resources :authors
  resources :users

  
end
