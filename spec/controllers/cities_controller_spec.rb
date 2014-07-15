require 'rails_helper'

RSpec.describe CitiesController, :type => :controller do
  render_views

  describe "GET /cities" do 
    it 'returns all the cities' do 
      get :index, format: :json
      body = JSON.parse(response.body)
      city_names = body.collect { |l| l["name"] }
      expect(response.status).to eq 200
      expect(city_names).to include(City.first.name)
    end
  end

  describe 'GET /cities/:id' do 
    it 'returns one city with all attributes' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      city_id = body["id"]
      city_name = body["name"]
      expect(response.status).to eq 200
      expect(city_id).to eq(City.first.id)
      expect(city_name).to eq(City.first.name)
    end

    it 'returns one city with its available listings as a json attribute, given start and end dates as params' do 
      get :show, format: :json, id: 1, start_date: '05-01-2014', end_date: '07-01-2014'
      body = JSON.parse(response.body)
      first_city_openings = body["city_openings"][0]["id"]
      expect(response.status).to eq 200
      expect(first_city_openings).to eq(@listing1.id)
    end

    it 'returns one city with its neighborhoods as a json attribute' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      first_nabe = body["neighborhoods"][0]["id"]
      expect(response.status).to eq 200
      expect(first_nabe).to eq(@nabe1.id)
    end
  end

  describe 'GET /cities/most_res' do 
    xit 'returns city with the most reservations' do 
    end
  end

  describe 'GET /cities/highest_ratio_res_to_listings' do 
    xit 'returns city with highest ratio of reservations to listings' do 
    end
  end
end

