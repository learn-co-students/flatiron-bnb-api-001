Rails.application.routes.draw do

  constraints subdomain: 'api' do 
    with_options except: [:new, :edit] do |list_only|
      list_only.resources :users
      list_only.resources :listings
      list_only.resources :reservations do 
        list_only.resources :reviews
      end
    end
    resources :neighborhoods, only: [:index, :show]
    resources :cities, only: [:index, :show]
  end

end
