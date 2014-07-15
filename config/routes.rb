Rails.application.routes.draw do

  resources :users, only: [:index, :show]
  resources :listings, except: [:new, :edit]

  resources :reservations, except: [:new, :edit] do 
      resources :reviews, except: [:new, :edit]
    end

  resources :neighborhoods, only: [:index, :show]
  resources :cities, only: [:index, :show]

  # get 'cities/most_reservations', as: 'cities#most_res'
  # get '/cities/highest_ratio_to_listings', as: 'cities#highest_ratio_to_listings'
end
