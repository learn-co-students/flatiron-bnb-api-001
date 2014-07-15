Rails.application.routes.draw do
  with_options except: [:new, :edit] do |list_only|
    list_only.resources :users
    list_only.resources :listings
    list_only.resources :reservations do 
      list_only.resources :reviews
    end
  end
  resources :neighborhoods, only: [:index, :show]
  resources :cities, only: [:index, :show]

  # get 'cities/most_reservations', as: 'cities#most_res'
  # get '/cities/highest_ratio_to_listings', as: 'cities#highest_ratio_to_listings'
end
