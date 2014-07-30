require 'rails_helper'

RSpec.describe ReservationsController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe 'GET /reservations.json' do 
    context 'all reservations' do 
      before do
        get :index, format: :json
      end

      it 'returns all reservations' do
        expect(json.collect { |l| l["id"] }).to include(@reservation1.id)
      end
    end

    context 'all reservations given status filter' do 
      before do 
        get :index, format: :json, status: "accepted"
      end

      it 'returns all reservations of a certain status, given as a parameter' do 
        expect(json.collect { |l| l["id"] }).to include(@reservation1.id)
      end
    end
  end

  describe 'GET /reservations/:id.json' do
    before do 
      get :show, format: :json, id: 1 
    end 

    context 'one reservation' do 
      it 'returns one reservation' do 
        expect(json["id"]).to eq(@reservation1.id)
      end
    end

    context 'one reservation has a duration' do
      it 'returns one reservation, with its duration as a json attribute' do 
        expect(json["duration"]).to eq(5)
      end
    end

    context 'one reservation has a total price' do 
      it 'returns one reservation, with its total price as a json attribute' do
        expect(json["total_price"]).to eq("250.0")
      end 
    end

  end

  describe 'POST /reservations.json' do 
    it 'creates a new reservation' do 
      post :create, format: :json, :reservation => {checkin: '2015-09-09', checkout: '2015-09-13', guest_id: 4, listing_id: 2}
      expect(response.status).to eq 201
      expect(Reservation.last.checkin).to eq(Date.parse('2015-09-09'))
    end

    it 'fails to create a new reservation without checkout' do 
      post :create, format: :json, :reservation => {checkin: '2015-09-09', checkout: nil, guest_id: 4, listing_id: 2}
      expect(response.status).to eq 422
    end
  end

  describe 'PATCH /reservations/:id.json' do 
    it 'updates an existing reservation' do 
      patch :update, format: :json, id: 1, :reservation => {checkin: '2014-09-05', checkout: '2014-10-01', guest_id: 5, listing_id: 2}
      expect(response.status).to eq 200
      expect(Reservation.first.checkin).to eq(Date.parse('2014-09-05'))
    end

    it 'fails to update a reservation without a checkout' do 
      patch :update, format: :json, id: 1, :reservation => {checkin: '2014-09-05', checkout: nil, guest_id: 5, listing_id: 2}
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE /reservations/:id.json' do 
    it 'deletes a reservation' do 
      delete :destroy, format: :json, id: 1
      expect(response.status).to eq 204
    end
  end

end
