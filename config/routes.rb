Rails.application.routes.draw do
  

  resources :useraccounts, only: [:show]   
  resources :users, only: [:show]


  
  get "search/reviews",  to: "search#reviews"
  get "search/services", to: "search#services"

  

  resources :reviews
  get '/vendor_reviews/:vendor_id', to: 'reviews#show_vendor_reviews', as: 'vendor_reviews'
  get '/client_reviews/:client_id', to: 'reviews#show_client_reviews', as: 'client_reviews'
  resources :services
  get '/user_services', to: 'services#user_services', as: 'user_services'
  resources :accounts
  post '/login', to: 'accounts#login', as: 'login'
  get '/logout', to: 'accounts#logout', as: 'logout'
  root 'accounts#index'
end