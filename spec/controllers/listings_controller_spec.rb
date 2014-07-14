require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do
  describe "GET /listings" do 
    it 'returns all the listings' do 
      get :index, format: :json
      binding.pry
      body = JSON.parse(response.body)
      listing_titles = body.collect { |l| l["title"] }
      expect(response.status).to eq 200
      expect(listing_titles).to include(@listing1.title)
    end

    xit 'returns all listings given price filter' do 
    end

    xit 'returns all listings given listing type filter' do 
    end

  end
end
