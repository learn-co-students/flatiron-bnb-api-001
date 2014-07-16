require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do
  render_views
  describe 'GET /reviews' do
    it 'returns all of the reviews' do 
      get :index, format: :json
      body = JSON.parse(response.body)
      reviews = body.collect { |l| l["description"] }
      expect(response.status).to eq 200
      expect(reviews).to include("Great place, close to subway!")
    end
  end

  describe 'POST /reviews' do 
    it 'creates a new review' do 
      post :create, format: :json, :review => {description: "Okay place", rating: 3, guest_id: 4, reservation_id: 3}
      body = JSON.parse(response.body)
      expect(response.status).to eq 201
      expect(Review.last.description).to eq("Okay place")
      expect(User.find(4).reviews.count).to eq(2)
    end

    it 'fails to create a review without a reservation' do 
      post :create, format: :json, :review => {description: "Okay place", rating: 3, guest_id: 4, reservation_id: nil}
      expect(response.status).to eq 422
    end
  end

end
