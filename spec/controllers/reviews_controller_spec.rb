require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe 'GET /reviews.json' do

    context 'all reviews' do 
      before do
        get :index, format: :json
      end

      it 'returns all of the reviews' do 
        expect(json.collect { |l| l["description"] }).to include("Great place, close to subway!")
      end
    end
  end

  describe 'POST /reviews.json' do 

    context 'create success' do 
      before do
        post :create, format: :json, :review => {description: "Okay place", rating: 3, guest_id: 4, reservation_id: 3}
      end

      it 'creates a new review' do 
        expect(Review.last.description).to eq("Okay place")
      end

      it 'user has one more review' do 
        expect(User.find(4).reviews.count).to eq(2)
      end
    end

    context 'create failure' do
      before do
        post :create, format: :json, :review => {description: "Okay place", rating: 3, guest_id: 4, reservation_id: nil}
      end
      
      it 'fails to create a review without a reservation' do 
        expect(response.status).to eq 422
      end
    end

  end

end
