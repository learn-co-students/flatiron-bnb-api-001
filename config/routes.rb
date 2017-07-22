Rails.application.routes.draw do

  resources :cities
  resources :listings
  resources :neighborhoods
  resources :reservations
  resources :reviews
  resources :users

end
