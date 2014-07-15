require 'rails_helper'

RSpec.describe ReservationsController, :type => :controller do
  render_views

  describe 'GET /reservations' do 
    it 'returns all reservations' do
      get :index, format: :json
      body = JSON.parse(response.body)
      res_id = body.collect { |l| l["id"] }
      expect(response.status).to eq 200
      expect(res_id).to include(@reservation1.id)
    end

    it 'returns all reservations of a certain status, given as a parameter' do 
      get :index, format: :json, status: "accepted"
      body = JSON.parse(response.body)
      res_id = body.collect { |l| l["id"] }
      expect(response.status).to eq 200
      expect(res_id).to include(@reservation1.id)
    end
  end

  describe 'GET /reservations/:id' do 
    it 'returns one reservation' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      res_id = body["id"]
      res_checkin = body["checkin"]
      res_checkout = body["checkout"]
      res_listing_id = body["listing_id"]
      res_guest_id = body["guest_id"]
      expect(response.status).to eq 200
      expect(res_id).to eq(@reservation1.id)
      expect(res_checkin).to eq('2014-04-25')
      expect(res_checkout).to eq('2014-04-30')
      expect(res_listing_id).to eq(@reservation1.listing_id)
      expect(res_guest_id).to eq(@reservation1.guest_id)
    end

    it 'returns one reservation, with its duration as a json attribute' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_res_duration = body["duration"]
      expect(response.status).to eq 200
      expect(first_res_duration).to eq(5)
    end

    it 'returns one reservation, with its total price as a json attribute' do
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_res_price = body["total_price"]
      expect(response.status).to eq 200
      expect(first_res_price).to eq("250.0")
    end 
  end

  describe 'POST /reservations' do 
    it 'creates a new reservation' do 
      post :create, format: :json, :reservation => {checkin: '2015-09-09', checkout: '2015-09-13', guest_id: 4, listing_id: 2}
      body = JSON.parse(response.body)
      expect(response.status).to eq 201
      expect(Reservation.last.checkin).to eq(Date.parse('2015-09-09'))
    end

    it 'fails to create a new reservation without checkout' do 
      post :create, format: :json, :reservation => {checkin: '2015-09-09', checkout: nil, guest_id: 4, listing_id: 2}
      body = JSON.parse(response.body)
      expect(response.status).to eq 422
    end
  end

  describe 'PATCH /reservations/:id' do 
    it 'updates an existing reservation' do 
      patch :update, format: :json, id: 1, :reservation => {checkin: '2014-09-05', checkout: '2014-10-01', guest_id: 5, listing_id: 2}
      body = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(Reservation.first.checkin).to eq(Date.parse('2014-09-05'))
    end

    it 'fails to update a reservation without a checkout' do 
      patch :update, format: :json, id: 1, :reservation => {checkin: '2014-09-05', checkout: nil, guest_id: 5, listing_id: 2}
      body = JSON.parse(response.body)
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE /reservations/:id' do 
    it 'deletes a reservation' do 
      delete :destroy, format: :json, id: 1
      expect(response.status).to eq 204
    end
  end

end
