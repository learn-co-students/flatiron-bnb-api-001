Rails.application.routes.draw do

  constraints subdomain: 'api' do 
    resources :users
    resources :listings
    resources :neighborhoods, only: [:index, :show]
    resources :cities, only: [:index, :show]
    resources :reservations do 
      resources :reviews
    end
  end

end
