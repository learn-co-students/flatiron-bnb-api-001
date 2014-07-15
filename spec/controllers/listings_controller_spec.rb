require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do
  render_views

  describe "GET /listings" do 
    it 'returns all the listings' do 
      get :index, format: :json
      body = JSON.parse(response.body)
      listing_titles = body.collect { |l| l["title"] }
      expect(response.status).to eq 200
      expect(listing_titles).to include(@listing1.title)
    end

    it 'returns all listings given price filter' do 
      get :index, format: :json, price: 50.0
      body = JSON.parse(response.body)
      listing_titles = body.collect { |l| l["title"] }
      expect(response.status).to eq 200
      expect(listing_titles).to include(@listing1.title)
    end

    it 'returns all listings given listing type filter' do 
      get :index, format: :json, listing_type: "private room"
      body = JSON.parse(response.body)
      listing_titles = body.collect { |l| l["title"] }
      expect(response.status).to eq 200
      expect(listing_titles).to include(@listing1.title)
    end
  end

  describe 'GET /listings/:id' do 
    it 'returns one listing with all attributes' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      listing_id = body["id"]
      listing_address = body["address"]
      listing_type = body["listing_type"]
      listing_title = body["title"]
      listing_description = body["description"]
      listing_price = body["price"]
      listing_neighborhood_id = body["neighborhood_id"]
      listing_host_id = body["host_id"]
      expect(response.status).to eq 200
      expect(listing_id).to eq(@listing1.id)
      expect(listing_address).to eq(@listing1.address)
      expect(listing_type).to eq(@listing1.listing_type)
      expect(listing_title).to eq(@listing1.title)
      expect(listing_description).to eq(@listing1.description)
      expect(listing_neighborhood_id).to eq(@listing1.neighborhood_id)
      expect(listing_host_id).to eq(@listing1.host_id)
    end

    it 'returns one listing with the average rating as a json attribute' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      listing_rating = body["average_rating"]
      expect(response.status).to eq 200
      expect(listing_rating).to eq(@listing1.average_rating)
    end

    it 'returns one listing with its reviews' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_listing_review = body["reviews"][0]["description"]
      expect(response.status).to eq 200
      expect(first_listing_review).to eq("This place was great!")
    end

    it 'returns one listing with its reservations' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_listing_res = body["reservations"][0]["id"]
      expect(response.status).to eq 200
      expect(first_listing_res).to eq(@reservation1.id)
    end
  end

  describe 'POST /listings' do 
    it 'creates a new listing' do 
      post :create, format: :json, :listing => {address: "123 Testing Lane", listing_type: "shared room", title: "Testing Listing", description: "idk", price: 1000.00, neighborhood_id: 1, host_id: 1}
      body = JSON.parse(response.body)
      expect(response.status).to eq 201
      expect(Listing.last.address).to eq("123 Testing Lane")
      expect(Listing.last.host.host).to eq(true)
    end

    it 'fails to create a listing without a neighborhood' do 
      post :create, format: :json, :listing => {address: "123 Testing Lane", listing_type: "shared room", title: "Testing Listing", description: "idk", price: 1000.00, neighborhood_id: nil, host_id: 1}
      expect(response.status).to eq 422
    end
  end

  describe 'PATCH /listings/:id' do 
    it 'updates an existing listing' do 
      patch :update, format: :json, id: 4, :listing => {address: "new address", listing_type: "shared room", title: "new title", description: "New awesome description", price: 500.00, neighborhood_id: 1, host_id: 1}
      body = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(Listing.last.description).to eq("New awesome description")
    end

    it 'fails to update a listing without a neighborhood' do 
      patch :create, format: :json, :listing => {address: "123 Testing Lane", listing_type: "shared room", title: "Testing Listing", description: "idk", price: 1000.00, neighborhood_id: nil, host_id: 1}
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE /listings/:id' do 
    it 'deletes a listing' do 
      delete :destroy, format: :json, id: 1
      expect(response.status).to eq 204
    end
  end
end

