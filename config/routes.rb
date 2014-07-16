Rails.application.routes.draw do

  resources :users, only: [:index, :show]
  resources :listings, except: [:new, :edit]

  resources :reservations, except: [:new, :edit]
  resources :reviews, only: [:index, :create]

  resources :neighborhoods, only: [:index, :show]
  resources :cities, only: [:index, :show]

end
