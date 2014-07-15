require 'rails_helper'

RSpec.describe NeighborhoodsController, :type => :controller do
  render_views

  describe "GET /neighborhoods" do 
    it 'returns all the neighborhoods' do 
      get :index, format: :json
      body = JSON.parse(response.body)
      nabe_names = body.collect { |l| l["name"] }
      expect(response.status).to eq 200
      expect(nabe_names).to include(Neighborhood.first.name)
    end
  end

  describe 'GET /neighborhoods/:id' do 
    it 'returns one neighborhood with all attributes' do 
      get :show, format: :json, id: 1
      body = JSON.parse(response.body)
      neighborhood_id = body["id"]
      neighborhood_name = body["name"]
      expect(response.status).to eq 200
      expect(neighborhood_id).to eq(Neighborhood.first.id)
      expect(neighborhood_name).to eq(Neighborhood.first.name)
    end

    it 'returns one neighborhood with its available listings as a json attribute, given start and end dates as params' do 
      get :show, format: :json, id: 1, start_date: '05-01-2014', end_date: '07-01-2014'
      body = JSON.parse(response.body)
      first_neighborhood_openings = body["neighborhood_openings"][0]["id"]
      expect(response.status).to eq 200
      expect(first_neighborhood_openings).to eq(@listing1.id)
    end
  end
end

