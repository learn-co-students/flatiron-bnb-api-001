require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET /listings.json" do
    before do 
      get :index, format: :json
    end 

    context 'all listings' do 
      it 'returns the listings' do
        expect(json.collect{|l| l["title"]}).to include(@listing1.title)
      end
    end

    context 'all listings given price filter' do 
      before do 
        get :index, format: :json, price: 50.0
      end

      it 'returns the listings' do 
        expect(json.collect{|l| l["title"]}).to include(@listing1.title)
      end
    end

    context 'all listings given a listing type filter' do 
      before do 
        get :index, format: :json, listing_type: "private room"
      end

      it 'returns the listings' do 
        expect(json.collect{|l| l["title"]}).to include(@listing1.title)
      end
    end
  end

  describe 'GET /listings/:id.json' do 
    before do 
      get :show, format: :json, id: 1
    end

    context 'one listing' do 
      it 'returns one listing' do 
        expect(json["id"]).to eq(@listing1.id)
      end
    end

    context 'one listing has an average rating' do 
      it 'has an average rating' do 
        expect(json["average_rating"]).to eq(@listing1.average_rating)
      end
    end

    context 'one listing has reviews' do 
      it  'has reviews' do 
       expect(json["reviews"][0]["description"]).to eq("This place was great!")
      end
    end

    context 'one listing has reservations' do 
      it  'has reservations' do 
        expect(json["reservations"][0]["id"]).to eq(@reservation1.id)
      end
    end
  end

  describe 'POST /listings.json' do
    context 'new listing success' do 
      before do
        post :create, format: :json, :listing => {address: "123 Testing Lane", listing_type: "shared room", title: "Testing Listing", description: "idk", price: 1000.00, neighborhood_id: 1, host_id: 1}
      end

      it 'creates a new listing' do
        expect(Listing.last.address).to eq("123 Testing Lane") 
      end
    end 

    context 'new listing failure' do 
      before do 
        post :create, format: :json, :listing => {address: "123 Testing Lane", listing_type: "shared room", title: "Testing Listing", description: "idk", price: 1000.00, neighborhood_id: nil, host_id: 1}
      end

      it 'responds with 422' do 
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /listings/:id.json' do
    context 'edit listing success' do 
      before do 
        patch :update, format: :json, id: 4, :listing => {address: "new address", listing_type: "shared room", title: "new title", description: "New awesome description", price: 500.00, neighborhood_id: 1, host_id: 1}
      end

      it 'edits a listing' do 
        expect(Listing.last.description).to eq("New awesome description")
      end
    end

    context 'edit listing failure' do 
      before do 
        patch :create, format: :json, :listing => {address: "123 Testing Lane", listing_type: "shared room", title: "Testing Listing", description: "idk", price: 1000.00, neighborhood_id: nil, host_id: 1}
      end

      it 'responds with a 422' do 
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /listings/:id.json' do 
    before do 
      delete :destroy, format: :json, id: 1
    end

    context 'delete a listing' do 
      it 'deletes a listing' do 
        expect(Listing.where(id: 1)).to be_empty
      end

      it 'responds with a 204' do 
        expect(response.status).to eq(204)
      end
    end
  end
end

