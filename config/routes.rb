Rails.application.routes.draw do

  get 'landing', to: "landing#index"
  

  resources :posts, only: :index
  get 'authors', to: "authors#index"

  root "authors#index"
end
